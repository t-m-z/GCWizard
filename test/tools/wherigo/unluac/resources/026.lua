require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _t6zE(str)
  local res = ""
  local dtable = "g4\003NF\028<B\015\016ha\005Mj=\024$3z.}\006t>\000*1d\027WJP\n#~RL\020O\001\030\004E\019Ho-y[\fbvl',G@0Y\b+r{\031\025U?K\002%cV\026\"mfA\v|Q\022/6\\5q7 &_:k\a\021;D2p)\029\023\017\014\tZ\rI`sux!e]XnTi8Sw9(^C\018"
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
_xy4 = Wherigo.ZCartridge()
_j9bRL = Wherigo.ZMedia(_xy4)
_j9bRL.Id = "9eab516e-1c6b-4049-b679-6898fc81e490"
_j9bRL.Name = _t6zE("EoH]oH]")
_j9bRL.Description = ""
_j9bRL.AltText = ""
_j9bRL.Resources = {
  {
    Type = "mp3",
    Filename = "Kuckucklauter.mp3",
    Directives = {}
  }
}
_oWJ = Wherigo.ZMedia(_xy4)
_oWJ.Id = "36ab5799-e785-4110-9805-a80f87ab8892"
_oWJ.Name = _t6zE(",?r4w\fY6w\001r\f")
_oWJ.Description = ""
_oWJ.AltText = ""
_oWJ.Resources = {
  {
    Type = "jpg",
    Filename = "Erebialigea.jpg",
    Directives = {}
  }
}
_54P7f = Wherigo.ZMedia(_xy4)
_54P7f.Id = "a2f7dd77-cfd0-4703-afe6-d1d5145fabbc"
_54P7f.Name = _t6zE("%/\024]r\v6H\vru")
_54P7f.Description = ""
_54P7f.AltText = ""
_54P7f.Resources = {
  {
    Type = "jpg",
    Filename = "Rotkehlchen.jpg",
    Directives = {}
  }
}
_pBCr = Wherigo.ZMedia(_xy4)
_pBCr.Id = "cc770c22-aa28-469d-8808-76f827fe235d"
_pBCr.Name = _t6zE("t0\031wu\001")
_pBCr.Description = ""
_pBCr.AltText = ""
_pBCr.Resources = {
  {
    Type = "jpg",
    Filename = "X-wing.jpg",
    Directives = {}
  }
}
_71BrV = Wherigo.ZMedia(_xy4)
_71BrV.Id = "a10aad45-1b9b-47d3-a252-867cc59830e5"
_71BrV.Name = _t6zE(",u\024r?c?wnr")
_71BrV.Description = ""
_71BrV.AltText = ""
_71BrV.Resources = {
  {
    Type = "jpg",
    Filename = "Enterprise.jpg",
    Directives = {}
  }
}
_4Xsj = Wherigo.ZMedia(_xy4)
_4Xsj.Id = "9f4d04bc-fc8c-4d43-b87a-fb6f3279645b"
_4Xsj.Name = _t6zE("jw\024?/uruM\f6\024r?")
_4Xsj.Description = ""
_4Xsj.AltText = ""
_4Xsj.Resources = {
  {
    Type = "jpg",
    Filename = "Zitronenfalter.jpg",
    Directives = {}
  }
}
_i8kJG = Wherigo.ZMedia(_xy4)
_i8kJG.Id = "c3c6b637-772c-453b-95e6-f924bda74a2c"
_i8kJG.Name = _t6zE("yw\001u\f6")
_i8kJG.Description = ""
_i8kJG.AltText = ""
_i8kJG.Resources = {
  {
    Type = "jpg",
    Filename = "Signal.jpg",
    Directives = {}
  }
}
_jEw = Wherigo.ZMedia(_xy4)
_jEw.Id = "6b204360-6c1f-4e4a-a299-5efe16f15132"
_jEw.Name = _t6zE("\005\f6nH\vrYNu\024z/?\024")
_jEw.Description = ""
_jEw.AltText = ""
_jEw.Resources = {
  {
    Type = "mp3",
    Filename = "kaputteScheibe.mp3",
    Directives = {}
  }
}
_j7_ = Wherigo.ZMedia(_xy4)
_j7_.Id = "c506f2fb-a786-4dfb-8be6-25cad612f348"
_j7_.Name = _t6zE("\028")
_j7_.Description = ""
_j7_.AltText = ""
_j7_.Resources = {
  {
    Type = "jpg",
    Filename = "1.jpg",
    Directives = {}
  }
}
_O0thc = Wherigo.ZMedia(_xy4)
_O0thc.Id = "cc5d6b77-2faa-4d7b-9c4e-68a8bfdb56b4"
_O0thc.Name = _t6zE("b")
_O0thc.Description = ""
_O0thc.AltText = ""
_O0thc.Resources = {
  {
    Type = "jpg",
    Filename = "2.jpg",
    Directives = {}
  }
}
_7Lpnh = Wherigo.ZMedia(_xy4)
_7Lpnh.Id = "858486f7-fae1-423c-bf8c-8adc6a32c7f9"
_7Lpnh.Name = _t6zE("\002")
_7Lpnh.Description = ""
_7Lpnh.AltText = ""
_7Lpnh.Resources = {
  {
    Type = "jpg",
    Filename = "4.jpg",
    Directives = {}
  }
}
_z13w = Wherigo.ZMedia(_xy4)
_z13w.Id = "a8d92cc1-d6b0-4234-aed9-0b436e2e5045"
_z13w.Name = _t6zE("V")
_z13w.Description = ""
_z13w.AltText = ""
_z13w.Resources = {
  {
    Type = "jpg",
    Filename = "5.jpg",
    Directives = {}
  }
}
_rYnVT = Wherigo.ZMedia(_xy4)
_rYnVT.Id = "26c5f765-64b9-40dd-964a-1679d81b0b3a"
_rYnVT.Name = _t6zE("T")
_rYnVT.Description = ""
_rYnVT.AltText = ""
_rYnVT.Resources = {
  {
    Type = "jpg",
    Filename = "6.jpg",
    Directives = {}
  }
}
_G1ns9 = Wherigo.ZMedia(_xy4)
_G1ns9.Id = "0096890d-2aa4-41e5-a07d-bed106e430ae"
_G1ns9.Name = _t6zE("X")
_G1ns9.Description = ""
_G1ns9.AltText = ""
_G1ns9.Resources = {
  {
    Type = "jpg",
    Filename = "7.jpg",
    Directives = {}
  }
}
_MX6BF = Wherigo.ZMedia(_xy4)
_MX6BF.Id = "7f5a6027-5ce2-4d5c-8714-dd48ee4d28ef"
_MX6BF.Name = _t6zE("x")
_MX6BF.Description = ""
_MX6BF.AltText = ""
_MX6BF.Resources = {
  {
    Type = "jpg",
    Filename = "8.jpg",
    Directives = {}
  }
}
_yJP = Wherigo.ZMedia(_xy4)
_yJP.Id = "3bf48708-1975-4288-9e39-5d6736026258"
_yJP.Name = _t6zE("{")
_yJP.Description = ""
_yJP.AltText = ""
_yJP.Resources = {
  {
    Type = "png",
    Filename = "9.png",
    Directives = {}
  }
}
_nUH = Wherigo.ZMedia(_xy4)
_nUH.Id = "295dd2f9-9579-4478-adbe-d99e522c86c0"
_nUH.Name = _t6zE("\028;")
_nUH.Description = ""
_nUH.AltText = ""
_nUH.Resources = {
  {
    Type = "jpg",
    Filename = "10.jpg",
    Directives = {}
  }
}
_9C7Nt = Wherigo.ZMedia(_xy4)
_9C7Nt.Id = "55bc7ed6-768a-4aa1-b0f9-df721435cb67"
_9C7Nt.Name = _t6zE("\028\028")
_9C7Nt.Description = ""
_9C7Nt.AltText = ""
_9C7Nt.Resources = {
  {
    Type = "jpg",
    Filename = "11.jpg",
    Directives = {}
  }
}
_ae3i = Wherigo.ZMedia(_xy4)
_ae3i.Id = "f220f424-dbf6-4634-9423-47afc5414d5f"
_ae3i.Name = _t6zE("\028T")
_ae3i.Description = ""
_ae3i.AltText = ""
_ae3i.Resources = {
  {
    Type = "jpg",
    Filename = "Abkurzung.jpg",
    Directives = {}
  }
}
_c7oXs = Wherigo.ZMedia(_xy4)
_c7oXs.Id = "4454b12c-cfcd-4fe3-8770-40b133aae624"
_c7oXs.Name = _t6zE("\028X")
_c7oXs.Description = ""
_c7oXs.AltText = ""
_c7oXs.Resources = {
  {
    Type = "jpg",
    Filename = "17.jpg",
    Directives = {}
  }
}
_O9QNA = Wherigo.ZMedia(_xy4)
_O9QNA.Id = "ea481526-4e51-4529-ae2e-b375a6f19059"
_O9QNA.Name = _t6zE("\028x")
_O9QNA.Description = ""
_O9QNA.AltText = ""
_O9QNA.Resources = {
  {
    Type = "jpg",
    Filename = "18.jpg",
    Directives = {}
  }
}
_j5U = Wherigo.ZMedia(_xy4)
_j5U.Id = "daf12bf2-148a-4bb3-8032-35df0e185c99"
_j5U.Name = _t6zE("b;")
_j5U.Description = ""
_j5U.AltText = ""
_j5U.Resources = {
  {
    Type = "jpg",
    Filename = "20.jpg",
    Directives = {}
  }
}
_XvbK = Wherigo.ZMedia(_xy4)
_XvbK.Id = "10dcb8a1-5116-41b7-aaac-7ac74fe6b2ee"
_XvbK.Name = _t6zE("\028{")
_XvbK.Description = ""
_XvbK.AltText = ""
_XvbK.Resources = {
  {
    Type = "jpg",
    Filename = "19.jpg",
    Directives = {}
  }
}
_nbXe = Wherigo.ZMedia(_xy4)
_nbXe.Id = "6c1a0e49-121d-4549-9ce2-5df15e174f30"
_nbXe.Name = _t6zE("b\028")
_nbXe.Description = ""
_nbXe.AltText = ""
_nbXe.Resources = {
  {
    Type = "png",
    Filename = "21.png",
    Directives = {}
  }
}
_L_v6H = Wherigo.ZMedia(_xy4)
_L_v6H.Id = "dc7667b1-5adf-4e2f-b42c-7748590f456a"
_L_v6H.Name = _t6zE("bb")
_L_v6H.Description = ""
_L_v6H.AltText = ""
_L_v6H.Resources = {
  {
    Type = "jpg",
    Filename = "22.jpg",
    Directives = {}
  }
}
_XPDlj = Wherigo.ZMedia(_xy4)
_XPDlj.Id = "9219719d-22b0-492a-a6b1-199be83adbb3"
_XPDlj.Name = _t6zE("b\019")
_XPDlj.Description = ""
_XPDlj.AltText = ""
_XPDlj.Resources = {
  {
    Type = "jpg",
    Filename = "23.jpg",
    Directives = {}
  }
}
_wBKW3 = Wherigo.ZMedia(_xy4)
_wBKW3.Id = "62a6a077-08dd-40a0-835f-4890d891be4c"
_wBKW3.Name = _t6zE("b\002")
_wBKW3.Description = ""
_wBKW3.AltText = ""
_wBKW3.Resources = {
  {
    Type = "jpg",
    Filename = "24.jpg",
    Directives = {}
  }
}
_IoX = Wherigo.ZMedia(_xy4)
_IoX.Id = "dbafc9fe-c1ee-460f-8a8a-4c5d8f538c03"
_IoX.Name = _t6zE("bV")
_IoX.Description = ""
_IoX.AltText = ""
_IoX.Resources = {
  {
    Type = "jpg",
    Filename = "25.jpg",
    Directives = {}
  }
}
_JioU2 = Wherigo.ZMedia(_xy4)
_JioU2.Id = "5050f56c-7f8b-4bc9-aa10-26d3375833c7"
_JioU2.Name = _t6zE("y\028")
_JioU2.Description = ""
_JioU2.AltText = ""
_JioU2.Resources = {
  {
    Type = "jpg",
    Filename = "S1.jpg",
    Directives = {}
  }
}
_tZ5C = Wherigo.ZMedia(_xy4)
_tZ5C.Id = "99385412-3446-4a09-a6c7-81e749334ac8"
_tZ5C.Name = _t6zE("yb")
_tZ5C.Description = ""
_tZ5C.AltText = ""
_tZ5C.Resources = {
  {
    Type = "jpg",
    Filename = "S2_1.jpg",
    Directives = {}
  }
}
_ynOMW = Wherigo.ZMedia(_xy4)
_ynOMW.Id = "8d20bbf5-51a3-4851-ac9b-1f4a9a9c1d66"
_ynOMW.Name = _t6zE("y\019")
_ynOMW.Description = ""
_ynOMW.AltText = ""
_ynOMW.Resources = {
  {
    Type = "jpg",
    Filename = "S3.jpg",
    Directives = {}
  }
}
_FBE = Wherigo.ZMedia(_xy4)
_FBE.Id = "853228c9-5e7f-49a2-b3ed-0293f2aefdd2"
_FBE.Name = _t6zE("yV")
_FBE.Description = ""
_FBE.AltText = ""
_FBE.Resources = {
  {
    Type = "jpg",
    Filename = "S5.jpg",
    Directives = {}
  }
}
_Jua0 = Wherigo.ZMedia(_xy4)
_Jua0.Id = "4854cb94-101a-4f80-8fe9-d52f10082096"
_Jua0.Name = _t6zE("yT")
_Jua0.Description = ""
_Jua0.AltText = ""
_Jua0.Resources = {
  {
    Type = "jpg",
    Filename = "S6.jpg",
    Directives = {}
  }
}
_aSw9 = Wherigo.ZMedia(_xy4)
_aSw9.Id = "5829c586-0245-430d-8e12-d455937da685"
_aSw9.Name = _t6zE("yX")
_aSw9.Description = ""
_aSw9.AltText = ""
_aSw9.Resources = {
  {
    Type = "jpg",
    Filename = "S7.jpg",
    Directives = {}
  }
}
_2g4 = Wherigo.ZMedia(_xy4)
_2g4.Id = "f3f4e1dc-1f50-4115-bee1-8e741dabc66e"
_2g4.Name = _t6zE("yx")
_2g4.Description = ""
_2g4.AltText = ""
_2g4.Resources = {
  {
    Type = "jpg",
    Filename = "S8.jpg",
    Directives = {}
  }
}
_nQYe = Wherigo.ZMedia(_xy4)
_nQYe.Id = "237b8ec3-ab98-46fb-9e28-beffbd7496ba"
_nQYe.Name = _t6zE("y{")
_nQYe.Description = ""
_nQYe.AltText = ""
_nQYe.Resources = {
  {
    Type = "png",
    Filename = "S9.png",
    Directives = {}
  }
}
_wOr = Wherigo.ZMedia(_xy4)
_wOr.Id = "67b0ef54-2e2a-47de-848f-3658175a7dd3"
_wOr.Name = _t6zE("\031o?Mr6")
_wOr.Description = ""
_wOr.AltText = ""
_wOr.Resources = {
  {
    Type = "jpg",
    Filename = "Wurfel1.jpg",
    Directives = {}
  }
}
_d9o7j = Wherigo.ZMedia(_xy4)
_d9o7j.Id = "f0561d71-fdf2-4635-be04-e15793065799"
_d9o7j.Name = _t6zE("\014onw]Ya/nruMwnH\vr?")
_d9o7j.Description = ""
_d9o7j.AltText = ""
_d9o7j.Resources = {
  {
    Type = "mp3",
    Filename = "15-Wir-nennen-es-Dosenfischen1.mp3",
    Directives = {}
  }
}
_9cY = Wherigo.ZMedia(_xy4)
_9cY.Id = "5e05e616-6121-43dd-a0b4-8830990d9f8d"
_9cY.Name = _t6zE("N5rY\014\f?w\fY\b/H]M6/\024r")
_9cY.Description = ""
_9cY.AltText = ""
_9cY.Resources = {
  {
    Type = "mp3",
    Filename = "Ave-Maria-Blockflte.mp3",
    Directives = {}
  }
}
_raY = Wherigo.ZMedia(_xy4)
_raY.Id = "c0aa8e99-aaa2-4157-8837-6b3e3fdecfe9"
_raY.Name = _t6zE("N5rY\014\f?w\fY\boH]r6z\f6")
_raY.Description = ""
_raY.AltText = ""
_raY.Resources = {
  {
    Type = "mp3",
    Filename = "humpseq.mp3",
    Directives = {}
  }
}
_WrI = Wherigo.ZMedia(_xy4)
_WrI.Id = "60186e48-8220-497b-95ee-3d07ceab12d0"
_WrI.Name = _t6zE("N5rY\014\f?w\fY!\f5\f?/\024\024w")
_WrI.Description = ""
_WrI.AltText = ""
_WrI.Resources = {
  {
    Type = "mp3",
    Filename = "AveMariaPavarotti.mp3",
    Directives = {}
  }
}
_D7n3 = Wherigo.ZMedia(_xy4)
_D7n3.Id = "ae656185-c71d-41d9-8d3b-105af5f8f3d6"
_D7n3.Name = _t6zE("v0%rpY\028")
_D7n3.Description = ""
_D7n3.AltText = ""
_D7n3.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex1.jpg",
    Directives = {}
  }
}
_vnz = Wherigo.ZMedia(_xy4)
_vnz.Id = "cd427aff-0ac4-451e-ac77-b5ba32803b71"
_vnz.Name = _t6zE("yH\vrwnn\028")
_vnz.Description = ""
_vnz.AltText = ""
_vnz.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss1.jpg",
    Directives = {}
  }
}
_sBn = Wherigo.ZMedia(_xy4)
_sBn.Id = "a9c5ae90-5f54-4204-a716-7f55700324a7"
_sBn.Name = _t6zE("y/un\024w\001r\028")
_sBn.Description = ""
_sBn.AltText = ""
_sBn.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige1.jpg",
    Directives = {}
  }
}
_XrN = Wherigo.ZMedia(_xy4)
_XrN.Id = "4ec1602d-8200-4dfc-ae5f-c03cc87d52bf"
_XrN.Name = _t6zE("y/un\024w\001rb")
_XrN.Description = ""
_XrN.AltText = ""
_XrN.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige2neu.jpg",
    Directives = {}
  }
}
_aweIq = Wherigo.ZMedia(_xy4)
_aweIq.Id = "b73340d2-e3e1-49d6-982b-c9fb8100f596"
_aweIq.Name = _t6zE("v0%rpb")
_aweIq.Description = ""
_aweIq.AltText = ""
_aweIq.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex2.jpg",
    Directives = {}
  }
}
_mcZLz = Wherigo.ZMedia(_xy4)
_mcZLz.Id = "8892b0e0-f645-498d-9e2b-d8e8de55b9b3"
_mcZLz.Name = _t6zE(".\fwY\028")
_mcZLz.Description = ""
_mcZLz.AltText = ""
_mcZLz.Resources = {
  {
    Type = "jpg",
    Filename = "Hai1.jpg",
    Directives = {}
  }
}
_DbYQ = Wherigo.ZMedia(_xy4)
_DbYQ.Id = "61166a68-3bbf-41dc-87f4-27655e2cb9a4"
_DbYQ.Name = _t6zE("\b\f?ruY\028")
_DbYQ.Description = ""
_DbYQ.AltText = ""
_DbYQ.Resources = {
  {
    Type = "jpg",
    Filename = "Baren1neu.jpg",
    Directives = {}
  }
}
_lwElQ = Wherigo.ZMedia(_xy4)
_lwElQ.Id = "ac0cc8f7-1b21-4c19-af8f-3dae7cf44b68"
_lwElQ.Name = _t6zE("\b\f?ruYb")
_lwElQ.Description = ""
_lwElQ.AltText = ""
_lwElQ.Resources = {
  {
    Type = "jpg",
    Filename = "Baren4.jpg",
    Directives = {}
  }
}
_TVaPL = Wherigo.ZMedia(_xy4)
_TVaPL.Id = "dd241c84-4c65-45ab-8574-b6170b42c958"
_TVaPL.Name = _t6zE("\b\f?Y\019")
_TVaPL.Description = ""
_TVaPL.AltText = ""
_TVaPL.Resources = {
  {
    Type = "jpg",
    Filename = "Bar3neu.jpg",
    Directives = {}
  }
}
_jFUk = Wherigo.ZMedia(_xy4)
_jFUk.Id = "e9bcdc0c-473f-4c6b-afe9-d93c42df4f40"
_jFUk.Name = _t6zE("yH\vrwnnYb")
_jFUk.Description = ""
_jFUk.AltText = ""
_jFUk.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss12.jpg",
    Directives = {}
  }
}
_W6E = Wherigo.ZMedia(_xy4)
_W6E.Id = "9cd087f2-f7cf-4cd9-96f4-fc4dfad8c204"
_W6E.Name = _t6zE("\b\f?ruY\002")
_W6E.Description = ""
_W6E.AltText = ""
_W6E.Resources = {
  {
    Type = "jpg",
    Filename = "Baren2.jpg",
    Directives = {}
  }
}
_m7b = Wherigo.ZMedia(_xy4)
_m7b.Id = "00c41160-b3ce-4dc4-aad3-b4813ada54e0"
_m7b.Name = _t6zE("y/un\024w\001r\019")
_m7b.Description = ""
_m7b.AltText = ""
_m7b.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige3.jpg",
    Directives = {}
  }
}
_DUZ_N = Wherigo.ZMedia(_xy4)
_DUZ_N.Id = "47b6f3a2-b9e0-452f-9e48-17a1612a9810"
_DUZ_N.Name = _t6zE("y/un\024w\001r\002")
_DUZ_N.Description = ""
_DUZ_N.AltText = ""
_DUZ_N.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige4.jpg",
    Directives = {}
  }
}
_OHy = Wherigo.ZMedia(_xy4)
_OHy.Id = "27502d98-c4cd-41b0-b458-e3b5177bf7d4"
_OHy.Name = _t6zE("yH\vrwnn\019")
_OHy.Description = ""
_OHy.AltText = ""
_OHy.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss14.jpg",
    Directives = {}
  }
}
_7iWu = Wherigo.ZMedia(_xy4)
_7iWu.Id = "29a76321-d42c-44e1-bd8e-99cd60a9541e"
_7iWu.Name = _t6zE("y/un\024w\001rV")
_7iWu.Description = ""
_7iWu.AltText = ""
_7iWu.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige5_1.jpg",
    Directives = {}
  }
}
_wXqu = Wherigo.ZMedia(_xy4)
_wXqu.Id = "0b32d8b9-f322-4d31-8eda-f4e23adfa82d"
_wXqu.Name = _t6zE("y/un\024w\001rT")
_wXqu.Description = ""
_wXqu.AltText = ""
_wXqu.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstiges6.jpg",
    Directives = {}
  }
}
_CPgQ = Wherigo.ZMedia(_xy4)
_CPgQ.Id = "45f9193f-5201-4200-8a9e-b4d5097cbbac"
_CPgQ.Name = _t6zE("\031\fu\029\028")
_CPgQ.Description = ""
_CPgQ.AltText = ""
_CPgQ.Resources = {
  {
    Type = "jpg",
    Filename = "Wand1.jpg",
    Directives = {}
  }
}
_mq4 = Wherigo.ZMedia(_xy4)
_mq4.Id = "568a1524-3fc4-4e38-8c09-db792242a829"
_mq4.Name = _t6zE("\031\fu\029b")
_mq4.Description = ""
_mq4.AltText = ""
_mq4.Resources = {
  {
    Type = "png",
    Filename = "Wand1b.png",
    Directives = {}
  }
}
_R_A = Wherigo.ZMedia(_xy4)
_R_A.Id = "28958e77-d550-4b59-9c06-d5e126268620"
_R_A.Name = _t6zE("\031\fu\029\019")
_R_A.Description = ""
_R_A.AltText = ""
_R_A.Resources = {
  {
    Type = "jpg",
    Filename = "Wand2k.jpg",
    Directives = {}
  }
}
_wnj5 = Wherigo.ZMedia(_xy4)
_wnj5.Id = "9690adef-d501-44c3-a77a-d50ee60df8db"
_wnj5.Name = _t6zE("\031\fu\029\002")
_wnj5.Description = ""
_wnj5.AltText = ""
_wnj5.Resources = {
  {
    Type = "png",
    Filename = "Wand3.png",
    Directives = {}
  }
}
_yy9dV = Wherigo.ZMedia(_xy4)
_yy9dV.Id = "ef0e0cf2-6d4d-494a-b023-6f30d8483aaa"
_yy9dV.Name = _t6zE("\031\fu\029V")
_yy9dV.Description = ""
_yy9dV.AltText = ""
_yy9dV.Resources = {
  {
    Type = "png",
    Filename = "Wand4.png",
    Directives = {}
  }
}
_ZcFCB = Wherigo.ZMedia(_xy4)
_ZcFCB.Id = "6ccef0b7-87ac-4fc2-8799-5f87cc93e647"
_ZcFCB.Name = _t6zE("\031\fu\029T")
_ZcFCB.Description = ""
_ZcFCB.AltText = ""
_ZcFCB.Resources = {
  {
    Type = "jpg",
    Filename = "Wand5.jpg",
    Directives = {}
  }
}
_r8L = Wherigo.ZMedia(_xy4)
_r8L.Id = "b5433031-094a-4945-931a-91ef5d427f40"
_r8L.Name = _t6zE("\031\fu\029X")
_r8L.Description = ""
_r8L.AltText = ""
_r8L.Resources = {
  {
    Type = "jpg",
    Filename = "WAnd6.jpg",
    Directives = {}
  }
}
_xZOj = Wherigo.ZMedia(_xy4)
_xZOj.Id = "f7894ff5-5b16-4f26-a82d-470d8a7c8442"
_xZOj.Name = _t6zE("\031\fu\029x")
_xZOj.Description = ""
_xZOj.AltText = ""
_xZOj.Resources = {
  {
    Type = "png",
    Filename = "Wand8.png",
    Directives = {}
  }
}
_AaWwS = Wherigo.ZMedia(_xy4)
_AaWwS.Id = "17c30ae4-4333-4385-a72f-b53be832a3ed"
_AaWwS.Name = _t6zE("y/un\024w\001rX")
_AaWwS.Description = ""
_AaWwS.AltText = ""
_AaWwS.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige7.jpg",
    Directives = {}
  }
}
_FQzh = Wherigo.ZMedia(_xy4)
_FQzh.Id = "52f4179b-b001-4fb5-a76c-3d97b2d5f2d6"
_FQzh.Name = _t6zE("y/un\024w\001rx")
_FQzh.Description = ""
_FQzh.AltText = ""
_FQzh.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige19.jpg",
    Directives = {}
  }
}
_Cb3 = Wherigo.ZMedia(_xy4)
_Cb3.Id = "fd65cd85-f32d-489c-88b3-f92e68c6b039"
_Cb3.Name = _t6zE("yH\vrwnn\002")
_Cb3.Description = ""
_Cb3.AltText = ""
_Cb3.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss16.jpg",
    Directives = {}
  }
}
_Oz5l2 = Wherigo.ZMedia(_xy4)
_Oz5l2.Id = "68055ae8-166c-4b6c-8e45-ea8de70ece2b"
_Oz5l2.Name = _t6zE("yH\vrwnnV")
_Oz5l2.Description = ""
_Oz5l2.AltText = ""
_Oz5l2.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss11.jpg",
    Directives = {}
  }
}
_RZB = Wherigo.ZMedia(_xy4)
_RZB.Id = "06b90830-e381-4a12-800e-9bb7c5ce9b68"
_RZB.Name = _t6zE("yH\vrwnnT")
_RZB.Description = ""
_RZB.AltText = ""
_RZB.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss9.jpg",
    Directives = {}
  }
}
_zdZ = Wherigo.ZMedia(_xy4)
_zdZ.Id = "386ca99c-7060-4d86-8f09-068ac986a4a7"
_zdZ.Name = _t6zE("yH\vrwnnX")
_zdZ.Description = ""
_zdZ.AltText = ""
_zdZ.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss17.jpg",
    Directives = {}
  }
}
__yG = Wherigo.ZMedia(_xy4)
__yG.Id = "8441aa9f-4139-46ae-9204-890dd64c29ae"
__yG.Name = _t6zE("yH\vrwnnx")
__yG.Description = ""
__yG.AltText = ""
__yG.Resources = {
  {
    Type = "jpg",
    Filename = "Scheiss13.jpg",
    Directives = {}
  }
}
_b9ymR = Wherigo.ZMedia(_xy4)
_b9ymR.Id = "8c69df6f-fe2c-4be5-9df8-5d85e1da6b61"
_b9ymR.Name = _t6zE(".\fwb")
_b9ymR.Description = ""
_b9ymR.AltText = ""
_b9ymR.Resources = {
  {
    Type = "jpg",
    Filename = "Hai2neu.jpg",
    Directives = {}
  }
}
_ttw = Wherigo.ZMedia(_xy4)
_ttw.Id = "3f67a4b2-8a40-44c5-b6d1-6dd997729607"
_ttw.Name = _t6zE(".\fw\019")
_ttw.Description = ""
_ttw.AltText = ""
_ttw.Resources = {
  {
    Type = "jpg",
    Filename = "Hai3neu1.jpg",
    Directives = {}
  }
}
_vhR = Wherigo.ZMedia(_xy4)
_vhR.Id = "9d2a9a2d-0194-4906-bd93-a4ea958907d3"
_vhR.Name = _t6zE(".\fwV")
_vhR.Description = ""
_vhR.AltText = ""
_vhR.Resources = {
  {
    Type = "jpg",
    Filename = "Hai5.jpg",
    Directives = {}
  }
}
_ePX = Wherigo.ZMedia(_xy4)
_ePX.Id = "147850c9-850f-495a-8717-fb0ec3a43d1c"
_ePX.Name = _t6zE(".\fwT")
_ePX.Description = ""
_ePX.AltText = ""
_ePX.Resources = {
  {
    Type = "jpg",
    Filename = "Hai6.jpg",
    Directives = {}
  }
}
_7CsHU = Wherigo.ZMedia(_xy4)
_7CsHU.Id = "8318df9a-4cbb-4240-a538-d5b846135106"
_7CsHU.Name = _t6zE(".\fw\002")
_7CsHU.Description = ""
_7CsHU.AltText = ""
_7CsHU.Resources = {
  {
    Type = "jpg",
    Filename = "Hai4.jpg",
    Directives = {}
  }
}
_uus = Wherigo.ZMedia(_xy4)
_uus.Id = "73586e4a-645f-42b2-9f84-a2d5375955a5"
_uus.Name = _t6zE("v0%rp\019")
_uus.Description = ""
_uus.AltText = ""
_uus.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex4.jpg",
    Directives = {}
  }
}
_RMAT = Wherigo.ZMedia(_xy4)
_RMAT.Id = "fa8e7d53-82c4-43ac-833e-797b148b8600"
_RMAT.Name = _t6zE("v0%rp\002")
_RMAT.Description = ""
_RMAT.AltText = ""
_RMAT.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex5.jpg",
    Directives = {}
  }
}
_R_6IB = Wherigo.ZMedia(_xy4)
_R_6IB.Id = "2461dc7c-b010-4ec8-a1e6-8f31da3fe9fd"
_R_6IB.Name = _t6zE("v0%rpV")
_R_6IB.Description = ""
_R_6IB.AltText = ""
_R_6IB.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex6.jpg",
    Directives = {}
  }
}
_24I2K = Wherigo.ZMedia(_xy4)
_24I2K.Id = "81ef15c4-7afe-4819-9715-5cb9e09cf5ca"
_24I2K.Name = _t6zE("v0%rpT")
_24I2K.Description = ""
_24I2K.AltText = ""
_24I2K.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex7.jpg",
    Directives = {}
  }
}
_twj_ = Wherigo.ZMedia(_xy4)
_twj_.Id = "f260982a-5a0f-47aa-aaca-2122c7a907da"
_twj_.Name = _t6zE("v0%rpX")
_twj_.Description = ""
_twj_.AltText = ""
_twj_.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex8.jpg",
    Directives = {}
  }
}
_qbD = Wherigo.ZMedia(_xy4)
_qbD.Id = "1292bf16-9b35-4f09-a7bf-41e33329da05"
_qbD.Name = _t6zE("v0%rp{")
_qbD.Description = ""
_qbD.AltText = ""
_qbD.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex10.jpg",
    Directives = {}
  }
}
_DFn = Wherigo.ZMedia(_xy4)
_DFn.Id = "f465d86b-e86c-4310-a2b5-3f30d430e507"
_DFn.Name = _t6zE("v0%rp\028;")
_DFn.Description = ""
_DFn.AltText = ""
_DFn.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex11.jpg",
    Directives = {}
  }
}
_3xV = Wherigo.ZMedia(_xy4)
_3xV.Id = "8c8c90c0-be7b-4de5-bd96-b59cdebf4715"
_3xV.Name = _t6zE("v0%rp\028\028")
_3xV.Description = ""
_3xV.AltText = ""
_3xV.Resources = {
  {
    Type = "jpg",
    Filename = "T-Rex9.jpg",
    Directives = {}
  }
}
_MVRMt = Wherigo.ZMedia(_xy4)
_MVRMt.Id = "e5f4b992-21f2-49df-b38d-f15e393eb5d7"
_MVRMt.Name = _t6zE(".\fwX")
_MVRMt.Description = ""
_MVRMt.AltText = ""
_MVRMt.Resources = {
  {
    Type = "jpg",
    Filename = "Hai7.jpg",
    Directives = {}
  }
}
_qkgvp = Wherigo.ZMedia(_xy4)
_qkgvp.Id = "dd24b936-070a-4a98-ac15-f6d92412d243"
_qkgvp.Name = _t6zE(".\fwx")
_qkgvp.Description = ""
_qkgvp.AltText = ""
_qkgvp.Resources = {
  {
    Type = "jpg",
    Filename = "Hai8.jpg",
    Directives = {}
  }
}
_KUQ = Wherigo.ZMedia(_xy4)
_KUQ.Id = "b4c89e79-68ab-41e5-9bfd-942bb9957833"
_KUQ.Name = _t6zE("\b\f?ruYV")
_KUQ.Description = ""
_KUQ.AltText = ""
_KUQ.Resources = {
  {
    Type = "jpg",
    Filename = "Baren3.jpg",
    Directives = {}
  }
}
_Sa0 = Wherigo.ZMedia(_xy4)
_Sa0.Id = "5f25f9ce-582b-4e1d-afe2-4ea13560e2e5"
_Sa0.Name = _t6zE("\b\f?ruT")
_Sa0.Description = ""
_Sa0.AltText = ""
_Sa0.Resources = {
  {
    Type = "jpg",
    Filename = "Baren5.jpg",
    Directives = {}
  }
}
_IHw = Wherigo.ZMedia(_xy4)
_IHw.Id = "a601d417-6f98-43d4-bb7a-d6eea27f5b54"
_IHw.Name = _t6zE("y/un\024w\001rY{")
_IHw.Description = ""
_IHw.AltText = ""
_IHw.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige10.jpg",
    Directives = {}
  }
}
_pVoE = Wherigo.ZMedia(_xy4)
_pVoE.Id = "489adc36-2b1d-4a6b-a920-58998701de89"
_pVoE.Name = _t6zE("y/un\024w\001rY\028;")
_pVoE.Description = ""
_pVoE.AltText = ""
_pVoE.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige11neu.jpg",
    Directives = {}
  }
}
_xJvgg = Wherigo.ZMedia(_xy4)
_xJvgg.Id = "a2685bdc-df7c-4b6b-9074-d291fc29e371"
_xJvgg.Name = _t6zE("y/un\024w\001rY\028\028")
_xJvgg.Description = ""
_xJvgg.AltText = ""
_xJvgg.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige12.jpg",
    Directives = {}
  }
}
_g53_w = Wherigo.ZMedia(_xy4)
_g53_w.Id = "cec5e4ea-8036-42b6-8d10-0618306c0ff6"
_g53_w.Name = _t6zE("y/un\024w\001rY\028b")
_g53_w.Description = ""
_g53_w.AltText = ""
_g53_w.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige13.jpg",
    Directives = {}
  }
}
_Zd6Wy = Wherigo.ZMedia(_xy4)
_Zd6Wy.Id = "421f22c9-4bac-4bd9-a3ab-961513f55dd2"
_Zd6Wy.Name = _t6zE("y/un\024w\001r\028\019")
_Zd6Wy.Description = ""
_Zd6Wy.AltText = ""
_Zd6Wy.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige15.jpg",
    Directives = {}
  }
}
_TZeE = Wherigo.ZMedia(_xy4)
_TZeE.Id = "0b47e3c2-d947-4aef-a531-4951475913d1"
_TZeE.Name = _t6zE("y/un\024w\001rY\028\002")
_TZeE.Description = ""
_TZeE.AltText = ""
_TZeE.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige16.jpg",
    Directives = {}
  }
}
_zLnfy = Wherigo.ZMedia(_xy4)
_zLnfy.Id = "b76d275c-15cc-41f1-b45a-8614ee733c83"
_zLnfy.Name = _t6zE("y/un\024w\001rY\028V")
_zLnfy.Description = ""
_zLnfy.AltText = ""
_zLnfy.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige17.jpg",
    Directives = {}
  }
}
_xJW = Wherigo.ZMedia(_xy4)
_xJW.Id = "da5c407a-6bb2-4748-bab3-635124dc277c"
_xJW.Name = _t6zE("y/un\024w\001Y\028T")
_xJW.Description = ""
_xJW.AltText = ""
_xJW.Resources = {
  {
    Type = "jpg",
    Filename = "Sonstige18.jpg",
    Directives = {}
  }
}
_EUW60 = Wherigo.ZMedia(_xy4)
_EUW60.Id = "7b72dbd5-c003-4be7-9991-59ca8e6c3702"
_EUW60.Name = _t6zE("yc/w6r?Yb")
_EUW60.Description = ""
_EUW60.AltText = ""
_EUW60.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler2.jpg",
    Directives = {}
  }
}
_ZKq2 = Wherigo.ZMedia(_xy4)
_ZKq2.Id = "15b0bbf1-0f0c-49a8-ba83-6e08bb07b981"
_ZKq2.Name = _t6zE("yc/w6r?\019")
_ZKq2.Description = ""
_ZKq2.AltText = ""
_ZKq2.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler3.jpg",
    Directives = {}
  }
}
_NqU = Wherigo.ZMedia(_xy4)
_NqU.Id = "47824213-ed94-4cf8-a4e4-1ac5f345cd3a"
_NqU.Name = _t6zE("yc/w6r?\002")
_NqU.Description = ""
_NqU.AltText = ""
_NqU.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler4.jpg",
    Directives = {}
  }
}
_BM2q = Wherigo.ZMedia(_xy4)
_BM2q.Id = "bb9267d1-89d9-4713-b19b-d307f3f909bf"
_BM2q.Name = _t6zE("yc/w6r?V")
_BM2q.Description = ""
_BM2q.AltText = ""
_BM2q.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler5.jpg",
    Directives = {}
  }
}
_PN5T = Wherigo.ZMedia(_xy4)
_PN5T.Id = "1421e0be-e27d-4097-8abc-1890ffc5ef8f"
_PN5T.Name = _t6zE("yc/w6r?T")
_PN5T.Description = ""
_PN5T.AltText = ""
_PN5T.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler6.jpg",
    Directives = {}
  }
}
_F51SL = Wherigo.ZMedia(_xy4)
_F51SL.Id = "1f8ff7b5-9c01-45b9-b320-5f28464f8a5e"
_F51SL.Name = _t6zE("yc/w6r?X")
_F51SL.Description = ""
_F51SL.AltText = ""
_F51SL.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler7.jpg",
    Directives = {}
  }
}
_AKgv = Wherigo.ZMedia(_xy4)
_AKgv.Id = "6a41daed-beff-466f-84b1-36bcc05c8d91"
_AKgv.Name = _t6zE("yc/w6r?x")
_AKgv.Description = ""
_AKgv.AltText = ""
_AKgv.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler8.jpg",
    Directives = {}
  }
}
_i3A = Wherigo.ZMedia(_xy4)
_i3A.Id = "96f9f1b2-4ec7-4655-9684-479722d45df8"
_i3A.Name = _t6zE("yc/w6r?x4")
_i3A.Description = ""
_i3A.AltText = ""
_i3A.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler8b.jpg",
    Directives = {}
  }
}
_6pY = Wherigo.ZMedia(_xy4)
_6pY.Id = "e220a2e1-0aae-4a10-8b4a-3eff9e00c7fe"
_6pY.Name = _t6zE("yc/w6r?{")
_6pY.Description = ""
_6pY.AltText = ""
_6pY.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler9neu.jpg",
    Directives = {}
  }
}
_1XvE = Wherigo.ZMedia(_xy4)
_1XvE.Id = "a9b24a3e-073d-4f07-a2e7-b9e10d1bf7a0"
_1XvE.Name = _t6zE("yc/w6r?\028;")
_1XvE.Description = ""
_1XvE.AltText = ""
_1XvE.Resources = {
  {
    Type = "jpg",
    Filename = "Stage10neu1.jpg",
    Directives = {}
  }
}
_9RGs = Wherigo.ZMedia(_xy4)
_9RGs.Id = "56629c98-6dd0-437f-9c82-feb314743069"
_9RGs.Name = _t6zE("yc/w6r?\028\028")
_9RGs.Description = ""
_9RGs.AltText = ""
_9RGs.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler11.jpg",
    Directives = {}
  }
}
_h32 = Wherigo.ZMedia(_xy4)
_h32.Id = "b1d9123f-f400-455d-a563-5b02f636e18b"
_h32.Name = _t6zE("yc/w6r?\028b")
_h32.Description = ""
_h32.AltText = ""
_h32.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler12_1.jpg",
    Directives = {}
  }
}
_9EK = Wherigo.ZMedia(_xy4)
_9EK.Id = "ac9031d7-13c6-4fde-a2e9-ad24d7ab021c"
_9EK.Name = _t6zE("\bw6\029YM/6\001\024")
_9EK.Description = ""
_9EK.AltText = ""
_9EK.Resources = {
  {
    Type = "jpg",
    Filename = "Platzhalter.jpg",
    Directives = {}
  }
}
_4PvLc = Wherigo.ZMedia(_xy4)
_4PvLc.Id = "06f6b958-bf2c-45c7-842b-1af6096f37d6"
_4PvLc.Name = _t6zE("\004/\024M\f660Q%0~/\029r")
_4PvLc.Description = ""
_4PvLc.AltText = ""
_4PvLc.Resources = {
  {
    Type = "png",
    Filename = "Notfallhilfe.png",
    Directives = {}
  }
}
_yls = Wherigo.ZMedia(_xy4)
_yls.Id = "bfb1491c-f719-4b4a-9feb-06afb8efbf84"
_yls.Name = _t6zE("!6\fnL\f]o\001r6")
_yls.Description = ""
_yls.AltText = ""
_yls.Resources = {
  {
    Type = "jpg",
    Filename = "Plasmakugel2.jpg",
    Directives = {}
  }
}
_BpLAZ = Wherigo.ZMedia(_xy4)
_BpLAZ.Id = "e05556f5-7bf2-4217-aaed-f198d7d3db20"
_BpLAZ.Name = _t6zE(",\029r6\001\fnr")
_BpLAZ.Description = ""
_BpLAZ.AltText = ""
_BpLAZ.Resources = {
  {
    Type = "jpg",
    Filename = "Edelgase3.jpg",
    Directives = {}
  }
}
_4jj = Wherigo.ZMedia(_xy4)
_4jj.Id = "617c1f45-bcd4-476e-a13c-4cae0a07ccf0"
_4jj.Name = _t6zE("\b\f\024\024r?wruY!6\fnL\f")
_4jj.Description = ""
_4jj.AltText = ""
_4jj.Resources = {
  {
    Type = "jpg",
    Filename = "BatterienPlasmakugel.jpg",
    Directives = {}
  }
}
_pU60 = Wherigo.ZMedia(_xy4)
_pU60.Id = "964ad1cd-2cc7-45b9-9d92-fdf9dcf4d107"
_pU60.Name = _t6zE("\031\f?Lr4w6\029]\fLr?\fY!/zr?")
_pU60.Description = ""
_pU60.AltText = ""
_pU60.Resources = {
  {
    Type = "jpg",
    Filename = "WarmebildkameraPower.jpg",
    Directives = {}
  }
}
_t_E = Wherigo.ZMedia(_xy4)
_t_E.Id = "6b85dd82-b64b-47a4-be03-aaf460da61c0"
_t_E.Name = _t6zE("\031\f?Lr4w6\029]\fLr?\fY!Mrw6")
_t_E.Description = ""
_t_E.AltText = ""
_t_E.Resources = {
  {
    Type = "jpg",
    Filename = "WarmebildkameraPfeil.jpg",
    Directives = {}
  }
}
_e57B = Wherigo.ZMedia(_xy4)
_e57B.Id = "ffa9b647-1a0d-44f8-8ce7-db1e1c60bf93"
_e57B.Name = _t6zE("\031\f?Lr4w6\029]\fLr?\fYawnc6\f1")
_e57B.Description = ""
_e57B.AltText = ""
_e57B.Resources = {
  {
    Type = "jpg",
    Filename = "DisplayWarmebildkamera.jpg",
    Directives = {}
  }
}
_xirpU = Wherigo.ZMedia(_xy4)
_xirpU.Id = "8b3993cd-317a-470c-bb69-2f73ae460095"
_xirpU.Name = _t6zE("yc/w6r?YyH\v6onnr6Yu\f\v")
_xirpU.Description = ""
_xirpU.AltText = ""
_xirpU.Resources = {
  {
    Type = "jpg",
    Filename = "SpoilerSchlusselnah.jpg",
    Directives = {}
  }
}
_gAP = Wherigo.ZMedia(_xy4)
_gAP.Id = "45db6f54-d1d3-4363-8591-ee8963c93f34"
_gAP.Name = _t6zE("yc/w6r?YyH\v6onnr6YMr?u")
_gAP.Description = ""
_gAP.AltText = ""
_gAP.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler9fern.jpg",
    Directives = {}
  }
}
_fcQRc = Wherigo.ZMedia(_xy4)
_fcQRc.Id = "cab4445a-fbe3-4a5a-a28e-971125ab46b0"
_fcQRc.Name = _t6zE("yc/w6r?\028\028Yu\f\v")
_fcQRc.Description = ""
_fcQRc.AltText = ""
_fcQRc.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler11nah.jpg",
    Directives = {}
  }
}
_lZvk = Wherigo.ZMedia(_xy4)
_lZvk.Id = "d5e4cf2f-621e-4477-9671-a63349d61522"
_lZvk.Name = _t6zE("Cy\b0awu\001r")
_lZvk.Description = ""
_lZvk.AltText = ""
_lZvk.Resources = {
  {
    Type = "jpg",
    Filename = "USB-Dinge.jpg",
    Directives = {}
  }
}
_iVxDU = Wherigo.ZMedia(_xy4)
_iVxDU.Id = "04dc7571-86ef-4855-a31a-2dcde2d24665"
_iVxDU.Name = _t6zE("!/zr?4\fu]n")
_iVxDU.Description = ""
_iVxDU.AltText = ""
_iVxDU.Resources = {
  {
    Type = "jpg",
    Filename = "Powerbank2neu.jpg",
    Directives = {}
  }
}
_6Tn = Wherigo.ZMedia(_xy4)
_6Tn.Id = "f76ffedf-a97f-4a6e-be30-77f05cb71571"
_6Tn.Name = _t6zE("yH\v6onnr6n\fMr")
_6Tn.Description = ""
_6Tn.AltText = ""
_6Tn.Resources = {
  {
    Type = "jpg",
    Filename = "Schlusselsafe_breit.jpg",
    Directives = {}
  }
}
_FZQdQ = Wherigo.ZMedia(_xy4)
_FZQdQ.Id = "df55f9ff-fe8b-418a-b7d4-afe889f94bc9"
_FZQdQ.Name = _t6zE("VY!ou]\024rYrwuM\fH\vYn/")
_FZQdQ.Description = ""
_FZQdQ.AltText = ""
_FZQdQ.Resources = {
  {
    Type = "jpg",
    Filename = "Lab5Punkte.jpg",
    Directives = {}
  }
}
_OA8tZ = Wherigo.ZMedia(_xy4)
_OA8tZ.Id = "8f8aeae0-4150-4fdb-b853-436b7074d84a"
_OA8tZ.Name = _t6zE("v\bn")
_OA8tZ.Description = ""
_OA8tZ.AltText = ""
_OA8tZ.Resources = {
  {
    Type = "jpg",
    Filename = "TBs.jpg",
    Directives = {}
  }
}
_05f = Wherigo.ZMedia(_xy4)
_05f.Id = "5bd8791a-f5cc-4440-b931-3c219fab22fc"
_05f.Name = _t6zE("%r\001runH\vw?Lr")
_05f.Description = ""
_05f.AltText = ""
_05f.Resources = {
  {
    Type = "jpg",
    Filename = "Regenschirme.jpg",
    Directives = {}
  }
}
_tB35 = Wherigo.ZMedia(_xy4)
_tB35.Id = "27760a86-a359-4cf4-9686-4fe8c3a43321"
_tB35.Name = _t6zE(".rw?\001r\024?\fu]r")
_tB35.Description = ""
_tB35.AltText = ""
_tB35.Resources = {
  {
    Type = "jpg",
    Filename = "Heigetranke.jpg",
    Directives = {}
  }
}
_Lrm = Wherigo.ZMedia(_xy4)
_Lrm.Id = "ed53c1c6-e52c-4857-bf36-7203941dfc97"
_Lrm.Name = _t6zE("9r\024?\fu]r")
_Lrm.Description = ""
_Lrm.AltText = ""
_Lrm.Resources = {
  {
    Type = "jpg",
    Filename = "Getranke.jpg",
    Directives = {}
  }
}
_y6W = Wherigo.ZMedia(_xy4)
_y6W.Id = "dd178fea-94ca-4a76-b95c-b21e91e607ce"
_y6W.Name = _t6zE("~\fu\0291Y9?\f44r?")
_y6W.Description = ""
_y6W.AltText = ""
_y6W.Resources = {
  {
    Type = "jpg",
    Filename = "Candygrabber.jpg",
    Directives = {}
  }
}
_dlSCf = Wherigo.ZMedia(_xy4)
_dlSCf.Id = "63963bff-055f-4c57-95c3-45051e7d1664"
_dlSCf.Name = _t6zE(".rw?\001r\024?\fu]rYy/LLr?")
_dlSCf.Description = ""
_dlSCf.AltText = ""
_dlSCf.Resources = {
  {
    Type = "jpg",
    Filename = "HeigetrankeSommer.jpg",
    Directives = {}
  }
}
_oaOx = Wherigo.ZMedia(_xy4)
_oaOx.Id = "6ba2736f-b23f-4748-9935-07633fe9eacf"
_oaOx.Name = _t6zE("&\fu\001rYN?Lr")
_oaOx.Description = ""
_oaOx.AltText = ""
_oaOx.Resources = {
  {
    Type = "jpg",
    Filename = "LangeArme.jpg",
    Directives = {}
  }
}
_Hyy3 = Wherigo.ZMedia(_xy4)
_Hyy3.Id = "87c00a4c-f0ac-47db-adc0-4090d66b561b"
_Hyy3.Name = _t6zE("E6\fccr")
_Hyy3.Description = ""
_Hyy3.AltText = ""
_Hyy3.Resources = {
  {
    Type = "jpg",
    Filename = "Klappe.jpg",
    Directives = {}
  }
}
_cXDxh = Wherigo.ZMedia(_xy4)
_cXDxh.Id = "f6d4ad7b-88eb-4cf0-bde4-b12490d94c24"
_cXDxh.Name = _t6zE("E6\fccrYb")
_cXDxh.Description = ""
_cXDxh.AltText = ""
_cXDxh.Resources = {
  {
    Type = "jpg",
    Filename = "Klappe3.jpg",
    Directives = {}
  }
}
_D2uV6 = Wherigo.ZMedia(_xy4)
_D2uV6.Id = "e3ce2108-9cc9-464a-8a00-080b8cb481f2"
_D2uV6.Name = _t6zE("!\fuw]")
_D2uV6.Description = ""
_D2uV6.AltText = ""
_D2uV6.Resources = {
  {
    Type = "jpg",
    Filename = "Panik.jpg",
    Directives = {}
  }
}
_DYrd = Wherigo.ZMedia(_xy4)
_DYrd.Id = "32568cae-bca5-4f25-b530-efe95f4724ac"
_DYrd.Name = _t6zE("E\fLr?\f")
_DYrd.Description = ""
_DYrd.AltText = ""
_DYrd.Resources = {
  {
    Type = "jpg",
    Filename = "Kamera.jpg",
    Directives = {}
  }
}
_A5hgN = Wherigo.ZMedia(_xy4)
_A5hgN.Id = "e4b0dcca-871e-484d-9e42-1690117b88f8"
_A5hgN.Name = _t6zE("!/zr?4\fu]Yuo?Yrwur")
_A5hgN.Description = ""
_A5hgN.AltText = ""
_A5hgN.Resources = {
  {
    Type = "jpg",
    Filename = "Powerbank1neu.jpg",
    Directives = {}
  }
}
_u2MPd = Wherigo.ZMedia(_xy4)
_u2MPd.Id = "f21ec07f-0d30-42f2-90ce-26941b2c06be"
_u2MPd.Name = _t6zE("Q%YwLY!6\f1r?")
_u2MPd.Description = ""
_u2MPd.AltText = ""
_u2MPd.Resources = {
  {
    Type = "jpg",
    Filename = "QRinApp.jpg",
    Directives = {}
  }
}
_wSm = Wherigo.ZMedia(_xy4)
_wSm.Id = "09b9d531-cf24-40ed-a80b-61bf2289735e"
_wSm.Name = _t6zE("y\024\f\001rYb")
_wSm.Description = ""
_wSm.AltText = ""
_wSm.Resources = {
  {
    Type = "jpg",
    Filename = "Stage2.jpg",
    Directives = {}
  }
}
_qmMC = Wherigo.ZMedia(_xy4)
_qmMC.Id = "e518a6b3-72f5-4980-9a1f-9637d9d39dda"
_qmMC.Name = _t6zE("y\024\f\001rY\019")
_qmMC.Description = ""
_qmMC.AltText = ""
_qmMC.Resources = {
  {
    Type = "jpg",
    Filename = "Stage3.jpg",
    Directives = {}
  }
}
_4nT3 = Wherigo.ZMedia(_xy4)
_4nT3.Id = "84dbc48e-19a6-46cd-986a-633b6d3aecdf"
_4nT3.Name = _t6zE("y\024\f\001rY\002")
_4nT3.Description = ""
_4nT3.AltText = ""
_4nT3.Resources = {
  {
    Type = "jpg",
    Filename = "Stage4.jpg",
    Directives = {}
  }
}
_uQR = Wherigo.ZMedia(_xy4)
_uQR.Id = "0d2319a7-6570-4e37-959e-eead9c0feed1"
_uQR.Name = _t6zE("y\024\f\001rYV")
_uQR.Description = ""
_uQR.AltText = ""
_uQR.Resources = {
  {
    Type = "jpg",
    Filename = "Stage5.jpg",
    Directives = {}
  }
}
_1fJQ = Wherigo.ZMedia(_xy4)
_1fJQ.Id = "52588078-61c0-435b-9e80-dbad3326b1f6"
_1fJQ.Name = _t6zE("y\024\f\001rYT")
_1fJQ.Description = ""
_1fJQ.AltText = ""
_1fJQ.Resources = {
  {
    Type = "jpg",
    Filename = "Stage6.jpg",
    Directives = {}
  }
}
_EUZA5 = Wherigo.ZMedia(_xy4)
_EUZA5.Id = "932ec193-3dfb-4612-bc65-4e3fc106ce05"
_EUZA5.Name = _t6zE("y\024\f\001rYX")
_EUZA5.Description = ""
_EUZA5.AltText = ""
_EUZA5.Resources = {
  {
    Type = "jpg",
    Filename = "Stage7.jpg",
    Directives = {}
  }
}
_HFl = Wherigo.ZMedia(_xy4)
_HFl.Id = "8671d54e-06b5-4430-8898-ecc8cbed4fa8"
_HFl.Name = _t6zE("y\024\f\001rYx")
_HFl.Description = ""
_HFl.AltText = ""
_HFl.Resources = {
  {
    Type = "jpg",
    Filename = "Stage8.jpg",
    Directives = {}
  }
}
_L9dS = Wherigo.ZMedia(_xy4)
_L9dS.Id = "32604d6e-54f2-49b9-aaa9-216b3a8566d2"
_L9dS.Name = _t6zE("y\024\f\001rY{")
_L9dS.Description = ""
_L9dS.AltText = ""
_L9dS.Resources = {
  {
    Type = "jpg",
    Filename = "Stage9neu.jpg",
    Directives = {}
  }
}
_nMQ = Wherigo.ZMedia(_xy4)
_nMQ.Id = "5da1522d-05a4-43c4-becc-3e3926a195a5"
_nMQ.Name = _t6zE("y\024\f\001rY\028;")
_nMQ.Description = ""
_nMQ.AltText = ""
_nMQ.Resources = {
  {
    Type = "jpg",
    Filename = "Stage10neuInhalt1.jpg",
    Directives = {}
  }
}
_DIRz = Wherigo.ZMedia(_xy4)
_DIRz.Id = "1f991655-b098-4ecb-b0b8-54aeaaac307e"
_DIRz.Name = _t6zE("y\024\f\001rY\028b")
_DIRz.Description = ""
_DIRz.AltText = ""
_DIRz.Resources = {
  {
    Type = "jpg",
    Filename = "Stage12.jpg",
    Directives = {}
  }
}
_FJO = Wherigo.ZMedia(_xy4)
_FJO.Id = "d6d22fdf-a9d8-4e5c-978c-c36abd66d36a"
_FJO.Name = _t6zE("y\024\f\001rY\0284")
_FJO.Description = ""
_FJO.AltText = ""
_FJO.Resources = {
  {
    Type = "jpg",
    Filename = "Stage1bneu.jpg",
    Directives = {}
  }
}
_xy4.Id = "ddcfb715-7949-4d41-873f-3eb0e7f759dc"
_xy4.Name = "Bonus zum Bikeport"
_xy4.Description = [[
<BR>
Dies ist der Bonus zum Cache "Der Bikeport" GC7Q6YC.<BR>
<BR>
]]
_xy4.Visible = true
_xy4.Activity = "Geocache"
_xy4.StartingLocationDescription = "<BR>\nLangg\195\182ns<BR>\n"
_xy4.StartingLocation = ZonePoint(50.504167, 8.669033, 0)
_xy4.Version = "3.5"
_xy4.Company = ""
_xy4.Author = "Barfussmann"
_xy4.BuilderVersion = "URWIGO 1.22.5798.37755"
_xy4.CreateDate = "11/22/2020 17:39:26"
_xy4.PublishDate = "1/1/0001 12:00:00 AM"
_xy4.UpdateDate = "08/26/2022 15:21:46"
_xy4.LastPlayedDate = "1/1/0001 12:00:00 AM"
_xy4.TargetDevice = "PocketPC"
_xy4.TargetDeviceVersion = "0"
_xy4.StateId = "1"
_xy4.CountryId = "2"
_xy4.Complete = false
_xy4.UseLogging = true
_f19 = Wherigo.Zone(_xy4)
_f19.Id = "7d055a96-b33a-4013-85fa-3198d89896aa"
_f19.Name = _t6zE("y\024\f\001rY\028Y|y\024\f?\024d")
_f19.Description = ""
_f19.Visible = false
_f19.Commands = {}
_f19.DistanceRange = Distance(-1, "feet")
_f19.ShowObjects = "OnEnter"
_f19.ProximityRange = Distance(60, "meters")
_f19.AllowSetPositionTo = false
_f19.Active = false
_f19.Points = {
  ZonePoint(50.5048360063549, 8.66808759308997, 0),
  ZonePoint(50.503436422964, 8.66786643034489, 0),
  ZonePoint(50.503492286371, 8.67026216192309, 0),
  ZonePoint(50.5048943597922, 8.67036856330816, 0)
}
_f19.OriginalPoint = ZonePoint(50.5041647688705, 8.66914618716653, 0)
_f19.DistanceRangeUOM = "Feet"
_f19.ProximityRangeUOM = "Meters"
_f19.OutOfRangeName = ""
_f19.InRangeName = ""
_RUSQC = Wherigo.Zone(_xy4)
_RUSQC.Id = "4fc0b37a-af8f-4ef3-b0b9-f0ba285e0acf"
_RUSQC.Name = _t6zE("y\024\f\001rYbY|]6rwud")
_RUSQC.Description = ""
_RUSQC.Visible = true
_RUSQC.Commands = {}
_RUSQC.DistanceRange = Distance(-1, "feet")
_RUSQC.ShowObjects = "OnEnter"
_RUSQC.ProximityRange = Distance(60, "meters")
_RUSQC.AllowSetPositionTo = false
_RUSQC.Active = false
_RUSQC.Points = {
  ZonePoint(50.50531667, 8.6698, 0),
  ZonePoint(50.5053716152279, 8.66972914081348, 0),
  ZonePoint(50.5053637752218, 8.66987751411361, 0)
}
_RUSQC.OriginalPoint = ZonePoint(50.5053506868166, 8.66980221830903, 0)
_RUSQC.DistanceRangeUOM = "Feet"
_RUSQC.ProximityRangeUOM = "Meters"
_RUSQC.OutOfRangeName = ""
_RUSQC.InRangeName = ""
_Ss3xb = Wherigo.Zone(_xy4)
_Ss3xb.Id = "91793ff0-14bc-4ee7-bb63-7164f573c4f8"
_Ss3xb.Name = _t6zE("y\024\f\001rY\019Y|]6rwud")
_Ss3xb.Description = ""
_Ss3xb.Visible = true
_Ss3xb.Commands = {}
_Ss3xb.DistanceRange = Distance(-1, "feet")
_Ss3xb.ShowObjects = "OnEnter"
_Ss3xb.ProximityRange = Distance(60, "meters")
_Ss3xb.AllowSetPositionTo = false
_Ss3xb.Active = false
_Ss3xb.Points = {
  ZonePoint(50.50563333, 8.67175, 0),
  ZonePoint(50.5056783008107, 8.67181244041036, 0),
  ZonePoint(50.5056757936201, 8.67168715159819, 0)
}
_Ss3xb.OriginalPoint = ZonePoint(50.5056624748103, 8.67174986400285, 0)
_Ss3xb.DistanceRangeUOM = "Feet"
_Ss3xb.ProximityRangeUOM = "Meters"
_Ss3xb.OutOfRangeName = ""
_Ss3xb.InRangeName = ""
_qkq = Wherigo.Zone(_xy4)
_qkq.Id = "6d71bdce-5563-4809-a988-fef2c0106608"
_qkq.Name = _t6zE("y\024\f\001rY\002Y|]6rwud")
_qkq.Description = ""
_qkq.Visible = true
_qkq.Commands = {}
_qkq.DistanceRange = Distance(-1, "feet")
_qkq.ShowObjects = "OnEnter"
_qkq.ProximityRange = Distance(60, "meters")
_qkq.AllowSetPositionTo = false
_qkq.Active = false
_qkq.Points = {
  ZonePoint(50.5066833, 8.67325, 0),
  ZonePoint(50.5067233434283, 8.67330444896598, 0),
  ZonePoint(50.5067223643945, 8.67319702076405, 0)
}
_qkq.OriginalPoint = ZonePoint(50.5067096692743, 8.67325048991001, 0)
_qkq.DistanceRangeUOM = "Feet"
_qkq.ProximityRangeUOM = "Meters"
_qkq.OutOfRangeName = ""
_qkq.InRangeName = ""
_JunA9 = Wherigo.Zone(_xy4)
_JunA9.Id = "5e3e6d2c-61c1-4385-914b-a97bb7afd461"
_JunA9.Name = _t6zE("y\024\f\001rYVY|]6rwud")
_JunA9.Description = ""
_JunA9.Visible = true
_JunA9.Commands = {}
_JunA9.DistanceRange = Distance(-1, "feet")
_JunA9.ShowObjects = "OnEnter"
_JunA9.ProximityRange = Distance(60, "meters")
_JunA9.AllowSetPositionTo = false
_JunA9.Active = false
_JunA9.Points = {
  ZonePoint(50.5062, 8.67708333, 0),
  ZonePoint(50.5062523535261, 8.67715342108908, 0),
  ZonePoint(50.5062495376066, 8.6770031219356, 0)
}
_JunA9.OriginalPoint = ZonePoint(50.5062339637109, 8.67707995767489, 0)
_JunA9.DistanceRangeUOM = "Feet"
_JunA9.ProximityRangeUOM = "Meters"
_JunA9.OutOfRangeName = ""
_JunA9.InRangeName = ""
_AYv = Wherigo.Zone(_xy4)
_AYv.Id = "e0ac6339-e05e-4c61-ab0e-cdb55c3724c2"
_AYv.Name = _t6zE("y\024\f\001rYTY|]6rwud")
_AYv.Description = ""
_AYv.Visible = true
_AYv.Commands = {}
_AYv.DistanceRange = Distance(-1, "feet")
_AYv.ShowObjects = "OnEnter"
_AYv.ProximityRange = Distance(60, "meters")
_AYv.AllowSetPositionTo = false
_AYv.Active = false
_AYv.Points = {
  ZonePoint(50.50661667, 8.6776, 0),
  ZonePoint(50.5066587359632, 8.67767586776241, 0),
  ZonePoint(50.5066616139749, 8.67752846474262, 0)
}
_AYv.OriginalPoint = ZonePoint(50.5066456733127, 8.67760144416834, 0)
_AYv.DistanceRangeUOM = "Feet"
_AYv.ProximityRangeUOM = "Meters"
_AYv.OutOfRangeName = ""
_AYv.InRangeName = ""
_6vFx = Wherigo.Zone(_xy4)
_6vFx.Id = "2de28ea5-0853-47b3-97aa-75c67317c32c"
_6vFx.Name = _t6zE("y\024\f\001rYXY|]6rwud")
_6vFx.Description = ""
_6vFx.Visible = true
_6vFx.Commands = {}
_6vFx.DistanceRange = Distance(-1, "feet")
_6vFx.ShowObjects = "OnEnter"
_6vFx.ProximityRange = Distance(60, "meters")
_6vFx.AllowSetPositionTo = false
_6vFx.Active = false
_6vFx.Points = {
  ZonePoint(50.50671667, 8.67716667, 0),
  ZonePoint(50.5067796787325, 8.6772353169208, 0),
  ZonePoint(50.506777596612, 8.67709802307922, 0)
}
_6vFx.OriginalPoint = ZonePoint(50.5067579817815, 8.67716667000001, 0)
_6vFx.DistanceRangeUOM = "Feet"
_6vFx.ProximityRangeUOM = "Meters"
_6vFx.OutOfRangeName = ""
_6vFx.InRangeName = ""
_vB6r = Wherigo.Zone(_xy4)
_vB6r.Id = "9be3011d-ce75-4773-9f09-0985ac75bc08"
_vB6r.Name = _t6zE("y\024\f\001rYxY|]6rwud")
_vB6r.Description = ""
_vB6r.Visible = true
_vB6r.Commands = {}
_vB6r.DistanceRange = Distance(-1, "feet")
_vB6r.ShowObjects = "OnEnter"
_vB6r.ProximityRange = Distance(60, "meters")
_vB6r.AllowSetPositionTo = false
_vB6r.Active = false
_vB6r.Points = {
  ZonePoint(50.50738333, 8.67775, 0),
  ZonePoint(50.5074386039467, 8.67782276938032, 0),
  ZonePoint(50.5074424616634, 8.67768532060504, 0)
}
_vB6r.OriginalPoint = ZonePoint(50.5074214652034, 8.67775269666179, 0)
_vB6r.DistanceRangeUOM = "Feet"
_vB6r.ProximityRangeUOM = "Meters"
_vB6r.OutOfRangeName = ""
_vB6r.InRangeName = ""
__CV = Wherigo.Zone(_xy4)
__CV.Id = "2d6516ee-6bd2-4d9a-955b-df45959ab22b"
__CV.Name = _t6zE("y\024\f\001rY{Y|]6rwud")
__CV.Description = ""
__CV.Visible = true
__CV.Commands = {}
__CV.DistanceRange = Distance(-1, "feet")
__CV.ShowObjects = "OnEnter"
__CV.ProximityRange = Distance(60, "meters")
__CV.AllowSetPositionTo = false
__CV.Active = false
__CV.Points = {
  ZonePoint(50.50728333, 8.67855, 0),
  ZonePoint(50.5073424660801, 8.67863388214483, 0),
  ZonePoint(50.5073418224107, 8.67848178165819, 0)
}
__CV.OriginalPoint = ZonePoint(50.5073225394969, 8.67855522126767, 0)
__CV.DistanceRangeUOM = "Feet"
__CV.ProximityRangeUOM = "Meters"
__CV.OutOfRangeName = ""
__CV.InRangeName = ""
_9tLkP = Wherigo.Zone(_xy4)
_9tLkP.Id = "9d8fb000-6881-4483-b921-022ef8317ae1"
_9tLkP.Name = _t6zE("y\024\f\001rY\028;Y|]6rwud")
_9tLkP.Description = ""
_9tLkP.Visible = true
_9tLkP.Commands = {}
_9tLkP.DistanceRange = Distance(-1, "feet")
_9tLkP.ShowObjects = "OnEnter"
_9tLkP.ProximityRange = Distance(60, "meters")
_9tLkP.AllowSetPositionTo = false
_9tLkP.Active = false
_9tLkP.Points = {
  ZonePoint(50.50495, 8.6747, 0),
  ZonePoint(50.5050203544171, 8.67478435782552, 0),
  ZonePoint(50.5050206741218, 8.67462828994598, 0)
}
_9tLkP.OriginalPoint = ZonePoint(50.504997009513, 8.67470421592383, 0)
_9tLkP.DistanceRangeUOM = "Feet"
_9tLkP.ProximityRangeUOM = "Meters"
_9tLkP.OutOfRangeName = ""
_9tLkP.InRangeName = ""
__vs = Wherigo.Zone(_xy4)
__vs.Id = "87d4eb4e-eabf-4ec7-911b-da9789325c87"
__vs.Name = _t6zE("y\024\f\001rY\028\028Y|]6rwud")
__vs.Description = ""
__vs.Visible = true
__vs.Commands = {}
__vs.DistanceRange = Distance(-1, "feet")
__vs.ShowObjects = "OnEnter"
__vs.ProximityRange = Distance(60, "meters")
__vs.AllowSetPositionTo = false
__vs.Active = false
__vs.Points = {
  ZonePoint(50.5046, 8.67138333, 0),
  ZonePoint(50.5046642590459, 8.67147174293988, 0),
  ZonePoint(50.5046587939833, 8.6713085701755, 0)
}
__vs.OriginalPoint = ZonePoint(50.5046410176764, 8.67138788103846, 0)
__vs.DistanceRangeUOM = "Feet"
__vs.ProximityRangeUOM = "Meters"
__vs.OutOfRangeName = ""
__vs.InRangeName = ""
_LVMIT = Wherigo.Zone(_xy4)
_LVMIT.Id = "27448763-495c-4e10-9b02-b8c10ff8cfa2"
_LVMIT.Name = _t6zE("y\024\f\001rY\028bY|]6rwud")
_LVMIT.Description = ""
_LVMIT.Visible = true
_LVMIT.Commands = {}
_LVMIT.DistanceRange = Distance(-1, "feet")
_LVMIT.ShowObjects = "OnEnter"
_LVMIT.ProximityRange = Distance(60, "meters")
_LVMIT.AllowSetPositionTo = false
_LVMIT.Active = false
_LVMIT.Points = {
  ZonePoint(50.50438333, 8.66991667, 0),
  ZonePoint(50.5044543547204, 8.67000661794679, 0),
  ZonePoint(50.5044559618463, 8.66983835098531, 0)
}
_LVMIT.OriginalPoint = ZonePoint(50.5044312155222, 8.6699205463107, 0)
_LVMIT.DistanceRangeUOM = "Feet"
_LVMIT.ProximityRangeUOM = "Meters"
_LVMIT.OutOfRangeName = ""
_LVMIT.InRangeName = ""
_t6v3 = Wherigo.Zone(_xy4)
_t6v3.Id = "7ff1fb8f-8b0c-46ab-be6a-3269408c2b4b"
_t6v3.Name = _t6zE("y\024\f\001rYbY|Nz\f?rurnn0vrn\024d")
_t6v3.Description = ""
_t6v3.Visible = false
_t6v3.Commands = {}
_t6v3.DistanceRange = Distance(-1, "feet")
_t6v3.ShowObjects = "OnEnter"
_t6v3.ProximityRange = Distance(60, "meters")
_t6v3.AllowSetPositionTo = false
_t6v3.Active = false
_t6v3.Points = {
  ZonePoint(50.5056479103762, 8.66933371676966, 0),
  ZonePoint(50.5050128381651, 8.66924441723905, 0),
  ZonePoint(50.5050128381651, 8.67028353905012, 0),
  ZonePoint(50.5056375840672, 8.67034848416333, 0)
}
_t6v3.OriginalPoint = ZonePoint(50.5053277926934, 8.66980253930554, 0)
_t6v3.DistanceRangeUOM = "Feet"
_t6v3.ProximityRangeUOM = "Meters"
_t6v3.OutOfRangeName = ""
_t6v3.InRangeName = ""
_xYF9R = Wherigo.Zone(_xy4)
_xYF9R.Id = "170e279d-c7e7-4f32-b55c-39e8956dc6f0"
_xYF9R.Name = _t6zE("y\024\f\001rY\019Y|&r\024\024r?4/pd")
_xYF9R.Description = ""
_xYF9R.Visible = false
_xYF9R.Commands = {}
_xYF9R.DistanceRange = Distance(-1, "feet")
_xYF9R.ShowObjects = "OnEnter"
_xYF9R.ProximityRange = Distance(60, "meters")
_xYF9R.AllowSetPositionTo = false
_xYF9R.Active = false
_xYF9R.Points = {
  ZonePoint(50.5059680248386, 8.6712901883046, 0),
  ZonePoint(50.5053381201207, 8.67123336133055, 0),
  ZonePoint(50.5053432833083, 8.67224001058502, 0),
  ZonePoint(50.5059886773101, 8.67224812872418, 0)
}
_xYF9R.OriginalPoint = ZonePoint(50.5056595263944, 8.67175292223609, 0)
_xYF9R.DistanceRangeUOM = "Feet"
_xYF9R.ProximityRangeUOM = "Meters"
_xYF9R.OutOfRangeName = ""
_xYF9R.InRangeName = ""
_v570h = Wherigo.Zone(_xy4)
_v570h.Id = "96b0721d-f09f-410d-82a7-0b2a5349273a"
_v570h.Name = _t6zE("y\024\f\001rY\002Y|Cu5r?n\024\fu\0296wH\vrYE//?\029wu\f\024rud")
_v570h.Description = ""
_v570h.Visible = false
_v570h.Commands = {}
_v570h.DistanceRange = Distance(-1, "feet")
_v570h.ShowObjects = "OnEnter"
_v570h.ProximityRange = Distance(60, "meters")
_v570h.AllowSetPositionTo = false
_v570h.Active = false
_v570h.Points = {
  ZonePoint(50.5069748223083, 8.67265403568163, 0),
  ZonePoint(50.5063965617702, 8.67273521707316, 0),
  ZonePoint(50.506401724842, 8.6737824570234, 0),
  ZonePoint(50.5069593332791, 8.67381492957996, 0)
}
_v570h.OriginalPoint = ZonePoint(50.5066831105499, 8.67324665983954, 0)
_v570h.DistanceRangeUOM = "Feet"
_v570h.ProximityRangeUOM = "Meters"
_v570h.OutOfRangeName = ""
_v570h.InRangeName = ""
_yDPL = Wherigo.Zone(_xy4)
_yDPL.Id = "e8da53f2-dba1-4f83-a8e7-5d4ddd6464fd"
_yDPL.Name = _t6zE("y\024\f\001rYVY|\0190a0Iw\029r/d")
_yDPL.Description = ""
_yDPL.Visible = false
_yDPL.Commands = {}
_yDPL.DistanceRange = Distance(-1, "feet")
_yDPL.ShowObjects = "OnEnter"
_yDPL.ProximityRange = Distance(60, "meters")
_yDPL.AllowSetPositionTo = false
_yDPL.Active = false
_yDPL.Points = {
  ZonePoint(50.5064430293965, 8.67678616850846, 0),
  ZonePoint(50.5060041666577, 8.67681864106506, 0),
  ZonePoint(50.5060144928867, 8.67745997405785, 0),
  ZonePoint(50.5064430293965, 8.67741126522293, 0)
}
_yDPL.OriginalPoint = ZonePoint(50.5062261795844, 8.67711901221357, 0)
_yDPL.DistanceRangeUOM = "Feet"
_yDPL.ProximityRangeUOM = "Meters"
_yDPL.OutOfRangeName = ""
_yDPL.InRangeName = ""
_ipL = Wherigo.Zone(_xy4)
_ipL.Id = "2711679e-c069-4168-b6ef-33214f302bbc"
_ipL.Name = _t6zE("y\024\f\001rYTY|~?1c\024rpd")
_ipL.Description = ""
_ipL.Visible = false
_ipL.Commands = {}
_ipL.DistanceRange = Distance(-1, "feet")
_ipL.ShowObjects = "OnEnter"
_ipL.ProximityRange = Distance(60, "meters")
_ipL.AllowSetPositionTo = false
_ipL.Active = false
_ipL.Points = {
  ZonePoint(50.5067786275623, 8.67739502894464, 0),
  ZonePoint(50.5064636816602, 8.67739502894464, 0),
  ZonePoint(50.5064740077887, 8.67782529031953, 0),
  ZonePoint(50.5067786275623, 8.67780905404125, 0)
}
_ipL.OriginalPoint = ZonePoint(50.5066237361434, 8.67760610056251, 0)
_ipL.DistanceRangeUOM = "Feet"
_ipL.ProximityRangeUOM = "Meters"
_ipL.OutOfRangeName = ""
_ipL.InRangeName = ""
_cZWP = Wherigo.Zone(_xy4)
_cZWP.Id = "eaf5031d-c8b1-4a7c-b91e-25d2a733649c"
_cZWP.Name = _t6zE("y\024\f\001rYXY|9r\024\fu\020\024rYE//?\029wu\f\024rud")
_cZWP.Description = ""
_cZWP.Visible = false
_cZWP.Commands = {}
_cZWP.DistanceRange = Distance(-1, "feet")
_cZWP.ShowObjects = "OnEnter"
_cZWP.ProximityRange = Distance(60, "meters")
_cZWP.AllowSetPositionTo = false
_cZWP.Active = false
_cZWP.Points = {
  ZonePoint(50.506933518219, 8.67738691080548, 0),
  ZonePoint(50.5065514536801, 8.67737879266636, 0),
  ZonePoint(50.5065514536801, 8.67693229501311, 0),
  ZonePoint(50.5069438442447, 8.67688358617827, 0)
}
_cZWP.OriginalPoint = ZonePoint(50.506745067456, 8.67714539616581, 0)
_cZWP.DistanceRangeUOM = "Feet"
_cZWP.ProximityRangeUOM = "Meters"
_cZWP.OutOfRangeName = ""
_cZWP.InRangeName = ""
_5lXaf = Wherigo.Zone(_xy4)
_5lXaf.Id = "9967bb57-9cb4-43af-9f40-8212f20c150a"
_5lXaf.Name = _t6zE("y\024\f\001rYxY|luM?\f?/\024d")
_5lXaf.Description = ""
_5lXaf.Visible = false
_5lXaf.Commands = {}
_5lXaf.DistanceRange = Distance(-1, "feet")
_5lXaf.ShowObjects = "OnEnter"
_5lXaf.ProximityRange = Distance(60, "meters")
_5lXaf.AllowSetPositionTo = false
_5lXaf.Active = false
_5lXaf.Points = {
  ZonePoint(50.5076150310725, 8.67812566146805, 0),
  ZonePoint(50.5072226460854, 8.67810130705061, 0),
  ZonePoint(50.5072071571375, 8.67744373777953, 0),
  ZonePoint(50.5076356828236, 8.67741938336209, 0)
}
_5lXaf.OriginalPoint = ZonePoint(50.5074201292798, 8.67777252241507, 0)
_5lXaf.DistanceRangeUOM = "Feet"
_5lXaf.ProximityRangeUOM = "Meters"
_5lXaf.OutOfRangeName = ""
_5lXaf.InRangeName = ""
_59K = Wherigo.Zone(_xy4)
_59K.Id = "55f80813-2270-4d10-8423-94a558d14191"
_59K.Name = _t6zE("y\024\f\001rY{Y|\031\f?Lr4w6\029]\fLr?\fd")
_59K.Description = ""
_59K.Visible = false
_59K.Commands = {}
_59K.DistanceRange = Distance(-1, "feet")
_59K.ShowObjects = "OnEnter"
_59K.ProximityRange = Distance(60, "meters")
_59K.AllowSetPositionTo = false
_59K.Active = false
_59K.Points = {
  ZonePoint(50.5075324239778, 8.67822307913786, 0),
  ZonePoint(50.5070625933782, 8.67822307913786, 0),
  ZonePoint(50.5070729193757, 8.6789455935221, 0),
  ZonePoint(50.5075169351315, 8.67896994793954, 0)
}
_59K.OriginalPoint = ZonePoint(50.5072962179658, 8.67859042493434, 0)
_59K.DistanceRangeUOM = "Feet"
_59K.ProximityRangeUOM = "Meters"
_59K.OutOfRangeName = ""
_59K.InRangeName = ""
_gn0n = Wherigo.Zone(_xy4)
_gn0n.Id = "db7e4cae-a9e9-473a-a5b0-f02862f46974"
_gn0n.Name = _t6zE("y\024\f\001rY\028;Y|!6\fnL\f]o\001r6d")
_gn0n.Description = ""
_gn0n.Visible = false
_gn0n.Commands = {}
_gn0n.DistanceRange = Distance(-1, "feet")
_gn0n.ShowObjects = "OnEnter"
_gn0n.ProximityRange = Distance(60, "meters")
_gn0n.AllowSetPositionTo = false
_gn0n.Active = false
_gn0n.Points = {
  ZonePoint(50.505301977792, 8.67422083653741, 0),
  ZonePoint(50.5046462478789, 8.67422895467653, 0),
  ZonePoint(50.5046823907096, 8.67532490346165, 0),
  ZonePoint(50.5052761618258, 8.67534113973993, 0)
}
_gn0n.OriginalPoint = ZonePoint(50.5049766945516, 8.67477895860388, 0)
_gn0n.DistanceRangeUOM = "Feet"
_gn0n.ProximityRangeUOM = "Meters"
_gn0n.OutOfRangeName = ""
_gn0n.InRangeName = ""
_CxSE = Wherigo.Zone(_xy4)
_CxSE.Id = "65044b50-7a9b-403e-b761-48fac8830a58"
_CxSE.Name = _t6zE("y\024\f\001rY\028\028Y|!?rMwu6\fd")
_CxSE.Description = ""
_CxSE.Visible = false
_CxSE.Commands = {}
_CxSE.DistanceRange = Distance(-1, "feet")
_CxSE.ShowObjects = "OnEnter"
_CxSE.ProximityRange = Distance(60, "meters")
_CxSE.AllowSetPositionTo = false
_CxSE.Active = false
_CxSE.Points = {
  ZonePoint(50.5048734309269, 8.67093299018204, 0),
  ZonePoint(50.5043157978581, 8.67101417157352, 0),
  ZonePoint(50.5043777574132, 8.67198834827139, 0),
  ZonePoint(50.5049044103488, 8.67186657618418, 0)
}
_CxSE.OriginalPoint = ZonePoint(50.5046178491368, 8.67145052155278, 0)
_CxSE.DistanceRangeUOM = "Feet"
_CxSE.ProximityRangeUOM = "Meters"
_CxSE.OutOfRangeName = ""
_CxSE.InRangeName = ""
_ofe = Wherigo.Zone(_xy4)
_ofe.Id = "449a38ca-3001-4cc5-8dfe-4d5c5e7a3cc9"
_ofe.Name = _t6zE("y\024\f\001rY\028bY|\005wu\f6d")
_ofe.Description = ""
_ofe.Visible = false
_ofe.Commands = {}
_ofe.DistanceRange = Distance(-1, "feet")
_ofe.ShowObjects = "OnEnter"
_ofe.ProximityRange = Distance(60, "meters")
_ofe.AllowSetPositionTo = false
_ofe.Active = false
_ofe.Points = {
  ZonePoint(50.5046462478789, 8.6695772609442, 0),
  ZonePoint(50.5041712252469, 8.66961785163997, 0),
  ZonePoint(50.5042022051294, 8.67035660230245, 0),
  ZonePoint(50.5046307580858, 8.6702673027718, 0)
}
_ofe.OriginalPoint = ZonePoint(50.5044126090853, 8.6699547544146, 0)
_ofe.DistanceRangeUOM = "Feet"
_ofe.ProximityRangeUOM = "Meters"
_ofe.OutOfRangeName = ""
_ofe.InRangeName = ""
_eWfrt = Wherigo.Zone(_xy4)
_eWfrt.Id = "ed80b47e-3691-4425-9034-1f71260ef651"
_eWfrt.Name = _t6zE("\bw]rc/?\024")
_eWfrt.Description = ""
_eWfrt.Visible = true
_eWfrt.Commands = {}
_eWfrt.DistanceRange = Distance(-1, "feet")
_eWfrt.ShowObjects = "OnEnter"
_eWfrt.ProximityRange = Distance(60, "meters")
_eWfrt.AllowSetPositionTo = false
_eWfrt.Active = true
_eWfrt.Points = {
  ZonePoint(50.5046301897801, 8.66862804965004, 0),
  ZonePoint(50.5037395475717, 8.66865873958251, 0),
  ZonePoint(50.5037859921535, 8.6701150176088, 0),
  ZonePoint(50.5046930500721, 8.66996695753256, 0)
}
_eWfrt.OriginalPoint = ZonePoint(50.5042121948944, 8.66934219109348, 0)
_eWfrt.DistanceRangeUOM = "Feet"
_eWfrt.ProximityRangeUOM = "Meters"
_eWfrt.OutOfRangeName = ""
_eWfrt.InRangeName = ""
_0Ts9 = Wherigo.Zone(_xy4)
_0Ts9.Id = "07d0eb0f-b51a-4a36-9a81-ab7fc06c3fb9"
_0Ts9.Name = _t6zE("j/urYMor?Y\005wu\f6\f]\024w5wr?ou\001")
_0Ts9.Description = ""
_0Ts9.Visible = false
_0Ts9.Commands = {}
_0Ts9.DistanceRange = Distance(-1, "feet")
_0Ts9.ShowObjects = "OnEnter"
_0Ts9.ProximityRange = Distance(60, "meters")
_0Ts9.AllowSetPositionTo = false
_0Ts9.Active = true
_0Ts9.Points = {
  ZonePoint(50.5073660586939, 8.67517371392364, 0),
  ZonePoint(50.5049145219901, 8.67734319396214, 0),
  ZonePoint(50.5060297055614, 8.67976798337436, 0),
  ZonePoint(50.5085448593021, 8.67781541200825, 0)
}
_0Ts9.OriginalPoint = ZonePoint(50.5067137863869, 8.6775250758171, 0)
_0Ts9.DistanceRangeUOM = "Feet"
_0Ts9.ProximityRangeUOM = "Meters"
_0Ts9.OutOfRangeName = ""
_0Ts9.InRangeName = ""
_jg65_ = Wherigo.Zone(_xy4)
_jg65_.Id = "c6c6bc57-3074-4c07-90c3-b3bf78ab2c50"
_jg65_.Name = _t6zE("\005wu\f6YMor?Y9r?\fr\024Yn\024\fru\029w\001Y\fu")
_jg65_.Description = ""
_jg65_.Visible = false
_jg65_.Commands = {}
_jg65_.DistanceRange = Distance(-1, "feet")
_jg65_.ShowObjects = "OnEnter"
_jg65_.ProximityRange = Distance(60, "meters")
_jg65_.AllowSetPositionTo = false
_jg65_.Active = false
_jg65_.Points = {
  ZonePoint(50.5045339384507, 8.66976039366215, 0),
  ZonePoint(50.5043380549105, 8.66976039366219, 0),
  ZonePoint(50.5043391806803, 8.67010200814354, 0),
  ZonePoint(50.5045260580941, 8.67008430791134, 0)
}
_jg65_.OriginalPoint = ZonePoint(50.5044343080339, 8.6699267758448, 0)
_jg65_.DistanceRangeUOM = "Feet"
_jg65_.ProximityRangeUOM = "Meters"
_jg65_.OutOfRangeName = ""
_jg65_.InRangeName = ""
_A4jFc = Wherigo.ZItem(_xy4)
_A4jFc.Id = "85371f8a-d109-4a71-a935-b2bae696a73c"
_A4jFc.Name = _t6zE("\031w\024\020r4oH\v")
_A4jFc.Description = ""
_A4jFc.Visible = true
_A4jFc.Commands = {}
_A4jFc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_A4jFc.Locked = false
_A4jFc.Opened = false
_c8h = Wherigo.ZItem(_xy4)
_c8h.Id = "d16685e7-7644-459d-9f8e-dde04b951197"
_c8h.Name = _t6zE("\014onw]4/p")
_c8h.Description = ""
_c8h.Visible = true
_c8h.Commands = {}
_c8h.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_c8h.Locked = false
_c8h.Opened = false
_gsDE = Wherigo.ZItem(_xy4)
_gsDE.Id = "5ffc97a9-3226-41cd-9cb7-b8b32f4a3215"
_gsDE.Name = _t6zE(".w6Mr0~ru\024r?")
_gsDE.Description = ""
_gsDE.Visible = true
_gsDE.Commands = {}
_gsDE.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_gsDE.Locked = false
_gsDE.Opened = false
_h68tb = Wherigo.ZItem(_xy4)
_h68tb.Id = "4264deaa-a96d-4cd5-87de-b2589b5e8a4f"
_h68tb.Name = _t6zE("a\f\024ru4\fu]")
_h68tb.Description = _t6zE(",?n\024YL\f6Yzwr\029r?Y?\fon\001ru/LLru\021\a\b%\025\031ruuY\029/H\vYrwu\001r4\fo\024Yzr?\029ruYn/668Y\029\fuuY4rwY\005ou]\024w/uYKQow\020Y4rn\024\fu\029ruK")
_h68tb.Visible = true
_h68tb.Commands = {}
_h68tb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_h68tb.Locked = false
_h68tb.Opened = false
_OoGx = Wherigo.ZItem(_xy4)
_OoGx.Id = "e9646ede-eb82-45cf-9d15-949e9f3170be"
_OoGx.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rYb")
_OoGx.Description = ""
_OoGx.Visible = true
_OoGx.Commands = {}
_OoGx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_OoGx.Locked = false
_OoGx.Opened = false
_bpEvC = Wherigo.ZItem(_xy4)
_bpEvC.Id = "94f5d142-9616-40e5-90bc-3b63376a824a"
_bpEvC.Name = _t6zE("yc/w6r?Yy\024\f\001rYb")
_bpEvC.Description = ""
_bpEvC.Visible = true
_bpEvC.Media = _EUW60
_bpEvC.Commands = {}
_bpEvC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_bpEvC.Locked = false
_bpEvC.Opened = false
_EGZm7 = Wherigo.ZItem(_xy4)
_EGZm7.Id = "7b9a66eb-af7b-45fa-be5d-fb9e9842f241"
_EGZm7.Name = _t6zE("yc/w6r?Yy\024\f\001rY\019")
_EGZm7.Description = ""
_EGZm7.Visible = true
_EGZm7.Media = _ZKq2
_EGZm7.Commands = {}
_EGZm7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_EGZm7.Locked = false
_EGZm7.Opened = false
_bLdu = Wherigo.ZItem(_xy4)
_bLdu.Id = "da6158dc-c630-4e56-98d2-54060004d043"
_bLdu.Name = _t6zE("yc/w6r?Yy\024\f\001rY\002")
_bLdu.Description = ""
_bLdu.Visible = true
_bLdu.Media = _NqU
_bLdu.Commands = {}
_bLdu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_bLdu.Locked = false
_bLdu.Opened = false
_Q4B = Wherigo.ZItem(_xy4)
_Q4B.Id = "ece687c4-3a0e-4c77-b112-52e2322bfa71"
_Q4B.Name = _t6zE("yc/w6r?Yy\024\f\001rYV")
_Q4B.Description = ""
_Q4B.Visible = true
_Q4B.Media = _BM2q
_Q4B.Commands = {}
_Q4B.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Q4B.Locked = false
_Q4B.Opened = false
_Djcm9 = Wherigo.ZItem(_xy4)
_Djcm9.Id = "f988a7af-5919-469c-8051-b037c01a5087"
_Djcm9.Name = _t6zE("yc/w6r?Yy\024\f\001rYT")
_Djcm9.Description = ""
_Djcm9.Visible = true
_Djcm9.Media = _PN5T
_Djcm9.Commands = {}
_Djcm9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Djcm9.Locked = false
_Djcm9.Opened = false
_0dWO = Wherigo.ZItem(_xy4)
_0dWO.Id = "caecc22f-f9ec-47a6-908f-467e18f6e830"
_0dWO.Name = _t6zE("yc/w6r?Yy\024\f\001rYX")
_0dWO.Description = ""
_0dWO.Visible = true
_0dWO.Media = _F51SL
_0dWO.Commands = {}
_0dWO.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_0dWO.Locked = false
_0dWO.Opened = false
_ihjX = Wherigo.ZItem(_xy4)
_ihjX.Id = "7cbe8cc6-9201-407b-8480-129ebd34e202"
_ihjX.Name = _t6zE("yc/w6r?Yy\024\f\001rYx")
_ihjX.Description = ""
_ihjX.Visible = true
_ihjX.Media = _AKgv
_ihjX.Commands = {}
_ihjX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ihjX.Locked = false
_ihjX.Opened = false
_WnrY = Wherigo.ZItem(_xy4)
_WnrY.Id = "f797fef6-d165-445d-910c-9bf990ed76eb"
_WnrY.Name = _t6zE("yc/w6r?Yy\024\f\001rY{")
_WnrY.Description = ""
_WnrY.Visible = true
_WnrY.Media = _6pY
_WnrY.Commands = {}
_WnrY.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_WnrY.Locked = false
_WnrY.Opened = false
_QMmH7 = Wherigo.ZItem(_xy4)
_QMmH7.Id = "886cf6c6-814e-40cf-9ca5-a6343b5a314e"
_QMmH7.Name = _t6zE("yc/w6r?Yy\024\f\001rY\028;")
_QMmH7.Description = ""
_QMmH7.Visible = true
_QMmH7.Media = _1XvE
_QMmH7.Commands = {}
_QMmH7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QMmH7.Locked = false
_QMmH7.Opened = false
_0rCIO = Wherigo.ZItem(_xy4)
_0rCIO.Id = "d4ed7847-1132-44ce-8d25-e0f9e66be77d"
_0rCIO.Name = _t6zE("yc/w6r?Yy\024\f\001rY\028\028")
_0rCIO.Description = ""
_0rCIO.Visible = true
_0rCIO.Media = _9RGs
_0rCIO.Commands = {}
_0rCIO.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_0rCIO.Locked = false
_0rCIO.Opened = false
_fIfBj = Wherigo.ZItem(_xy4)
_fIfBj.Id = "6272d3b2-e945-4289-b1a1-a10a0f05b4d6"
_fIfBj.Name = _t6zE("yc/w6r?Yy\024\f\001rY\028b")
_fIfBj.Description = ""
_fIfBj.Visible = true
_fIfBj.Media = _h32
_fIfBj.Commands = {}
_fIfBj.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fIfBj.Locked = false
_fIfBj.Opened = false
_pGCc = Wherigo.ZItem(_xy4)
_pGCc.Id = "b0388509-32f5-4329-9fb5-00c1269a756f"
_pGCc.Name = _t6zE("yc/w6r?Y.\fu\02910arc/\024")
_pGCc.Description = ""
_pGCc.Visible = true
_pGCc.Media = _i3A
_pGCc.Commands = {}
_pGCc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_pGCc.Locked = false
_pGCc.Opened = false
_sp5C = Wherigo.ZItem(_xy4)
_sp5C.Id = "0c5eeade-0331-4994-b52f-5c3ab8901712"
_sp5C.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rY\019")
_sp5C.Description = ""
_sp5C.Visible = true
_sp5C.Commands = {}
_sp5C.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_sp5C.Locked = false
_sp5C.Opened = false
_3AD = Wherigo.ZItem(_xy4)
_3AD.Id = "7266ff86-3899-4a6f-b145-97342199bd55"
_3AD.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rY\002")
_3AD.Description = ""
_3AD.Visible = true
_3AD.Commands = {}
_3AD.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3AD.Locked = false
_3AD.Opened = false
_N4XH = Wherigo.ZItem(_xy4)
_N4XH.Id = "07341008-cd4b-44e2-af37-02b6215d444f"
_N4XH.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rYV")
_N4XH.Description = ""
_N4XH.Visible = true
_N4XH.Commands = {}
_N4XH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_N4XH.Locked = false
_N4XH.Opened = false
_Qc3_W = Wherigo.ZItem(_xy4)
_Qc3_W.Id = "7d4b1124-7bcb-4d58-80d1-3ef585de9fe2"
_Qc3_W.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rYT")
_Qc3_W.Description = ""
_Qc3_W.Visible = true
_Qc3_W.Commands = {}
_Qc3_W.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Qc3_W.Locked = false
_Qc3_W.Opened = false
_g0m = Wherigo.ZItem(_xy4)
_g0m.Id = "36867d0d-2c31-41f0-bdcc-daaa2c4a0071"
_g0m.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rYX")
_g0m.Description = ""
_g0m.Visible = true
_g0m.Commands = {}
_g0m.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g0m.Locked = false
_g0m.Opened = false
_LRb = Wherigo.ZItem(_xy4)
_LRb.Id = "0e4a113e-1840-4259-8e0e-e0d7f7ce2cd8"
_LRb.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rYx")
_LRb.Description = ""
_LRb.Visible = true
_LRb.Commands = {}
_LRb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_LRb.Locked = false
_LRb.Opened = false
_TcsF = Wherigo.ZItem(_xy4)
_TcsF.Id = "df9a33ed-3a54-4e74-8d8c-e919d55d4b00"
_TcsF.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rY{")
_TcsF.Description = ""
_TcsF.Visible = true
_TcsF.Commands = {}
_TcsF.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_TcsF.Locked = false
_TcsF.Opened = false
_e5rb = Wherigo.ZItem(_xy4)
_e5rb.Id = "aaba0a00-ed6d-4107-a1a4-bfbbe6407157"
_e5rb.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rY\028;")
_e5rb.Description = ""
_e5rb.Visible = true
_e5rb.Commands = {}
_e5rb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_e5rb.Locked = false
_e5rb.Opened = false
_TAc = Wherigo.ZItem(_xy4)
_TAc.Id = "a344ed18-7e70-4893-9d7a-6cb4da663409"
_TAc.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rY\028\028")
_TAc.Description = ""
_TAc.Visible = true
_TAc.Commands = {}
_TAc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_TAc.Locked = false
_TAc.Opened = false
_dtm = Wherigo.ZItem(_xy4)
_dtm.Id = "d24d1726-69de-4aad-838e-90ed206bef32"
_dtm.Name = _t6zE("E//?\029wu\f\024ruYy\024\f\001rY\028b")
_dtm.Description = ""
_dtm.Visible = true
_dtm.Commands = {}
_dtm.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_dtm.Locked = false
_dtm.Opened = false
_JLDBy = Wherigo.ZItem(_xy4)
_JLDBy.Id = "a7ec7317-2168-4fd0-b97d-26f5106a51b7"
_JLDBy.Name = _t6zE("~/\029rYMor?Yv?rn/?")
_JLDBy.Description = ""
_JLDBy.Visible = true
_JLDBy.Commands = {}
_JLDBy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_JLDBy.Locked = false
_JLDBy.Opened = false
_QTCt = Wherigo.ZItem(_xy4)
_QTCt.Id = "cce72c1e-0bfc-4091-8028-ad4b96bd399d"
_QTCt.Name = _t6zE("yc/w6r?YyH\v6ornnr6YMr?u")
_QTCt.Description = ""
_QTCt.Visible = true
_QTCt.Commands = {}
_QTCt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QTCt.Locked = false
_QTCt.Opened = false
_32J = Wherigo.ZItem(_xy4)
_32J.Id = "3a5a6fd5-05b3-42a1-aa03-6391cc9bf0ce"
_32J.Name = _t6zE("yc/w6r?YyH\v6ornnr6uYu\f\v")
_32J.Description = ""
_32J.Visible = true
_32J.Commands = {}
_32J.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_32J.Locked = false
_32J.Opened = false
_XUJvy = Wherigo.ZItem(_xy4)
_XUJvy.Id = "55bcea2d-4424-4fdb-ab8e-a8e3d79f4882"
_XUJvy.Name = _t6zE("yH\v6/nnH/\029rYy\024\f\001rY\0284")
_XUJvy.Description = ""
_XUJvy.Visible = true
_XUJvy.Commands = {}
_XUJvy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_XUJvy.Locked = false
_XUJvy.Opened = false
_D8y = 0
_Lrw = 0
_a75 = 0
_1iAjs = 0
_VZ6M = 0
_okAj = true
_pwE9 = false
_MfOfA = false
_quCBy = false
_baA = false
_OC6K = false
_p2wk = false
_lhXcP = false
_7aoc = false
_e33FE = false
_knei = false
_TjM5 = false
_xpwp = false
_7IL = false
_IzX = false
_naXyO = false
_Kcff = 0
_QjfUX = false
_NBV3 = false
_W4YE = false
_tqx = false
_dyq2h = false
_vGcu = false
_sjJJ = false
_1ZZ = false
_60bfP = false
_6Kj = false
_qXTj = false
_s4oMj = false
_hyB = false
_qMt = false
_vtF = false
_Mbew = false
_m4T = false
_wOdVK = false
_Zqp = false
_nQSY = false
_LVyO = false
_vYfW = false
_ghQ7 = false
_bUBrV = false
_xKRLE = false
_fSrW6 = true
_EWB = false
_phAII = false
_zE5 = false
_uIK = false
_oAd1 = false
_kSc = 0
_wSy = false
_Kl5l = false
_qoE = false
_3mn = false
_lmS = false
_OIhY = _t6zE("[M\028{")
_FkOI = _t6zE("\029oLL1")
_fma = _t6zE("[N\002\015\005H")
_1jY = _t6zE("\029oLL1")
_t_9ks = _t6zE("[[Xlb")
_j0Gv = _t6zE("\029oLL1")
_xy4.ZVariables = {
  _D8y = 0,
  _Lrw = 0,
  _a75 = 0,
  _1iAjs = 0,
  _VZ6M = 0,
  _okAj = true,
  _pwE9 = false,
  _MfOfA = false,
  _quCBy = false,
  _baA = false,
  _OC6K = false,
  _p2wk = false,
  _lhXcP = false,
  _7aoc = false,
  _e33FE = false,
  _knei = false,
  _TjM5 = false,
  _xpwp = false,
  _7IL = false,
  _IzX = false,
  _naXyO = false,
  _Kcff = 0,
  _QjfUX = false,
  _NBV3 = false,
  _W4YE = false,
  _tqx = false,
  _dyq2h = false,
  _vGcu = false,
  _sjJJ = false,
  _1ZZ = false,
  _60bfP = false,
  _6Kj = false,
  _qXTj = false,
  _s4oMj = false,
  _hyB = false,
  _qMt = false,
  _vtF = false,
  _Mbew = false,
  _m4T = false,
  _wOdVK = false,
  _Zqp = false,
  _nQSY = false,
  _LVyO = false,
  _vYfW = false,
  _ghQ7 = false,
  _bUBrV = false,
  _xKRLE = false,
  _fSrW6 = true,
  _EWB = false,
  _phAII = false,
  _zE5 = false,
  _uIK = false,
  _oAd1 = false,
  _kSc = 0,
  _wSy = false,
  _Kl5l = false,
  _qoE = false,
  _3mn = false,
  _lmS = false,
  _OIhY = _t6zE("[M\028{"),
  _FkOI = _t6zE("\029oLL1"),
  _fma = _t6zE("[N\002\015\005H"),
  _1jY = _t6zE("\029oLL1"),
  _t_9ks = _t6zE("[[Xlb"),
  _j0Gv = _t6zE("\029oLL1")
}
__7I2 = Wherigo.ZInput(_xy4)
__7I2.Id = "c0100e00-822f-4dcc-bbd6-6d1589f5608c"
__7I2.Name = _t6zE("j/urYL\fuor66rY,wu\001\f4r")
__7I2.Description = ""
__7I2.Visible = true
__7I2.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12"
}
__7I2.InputType = "MultipleChoice"
__7I2.Text = _t6zE("\brwYzr6H\vr?Yy\024\f\001rY4rMwu\029rn\024Y\029oY\029wH\vY\029rwur?Y\014rwuou\001Yu\fH\vD")
_TkrRc = Wherigo.ZInput(_xy4)
_TkrRc.Id = "0b1b050c-c4c7-4945-a752-a1b0ee9a580f"
_TkrRc.Name = _t6zE("E//?\029wu\f\024ru0~\vrH]")
_TkrRc.Description = ""
_TkrRc.Visible = true
_TkrRc.InputType = "Text"
_TkrRc.Text = _t6zE("\031wrY6\fo\024ruY\029wrY\015rzrw6nY6r\024\020\024ruY\029?rwYy\024r66ruY5/uY\004/?\029You\029Y(n\024Y\029rwur?Yr?Lw\024\024r6\024ruYE//?\029w\fu\024ruD\a\b%\025\bw\024\024rY\f6nYrwurYnrH\vnn\024r66w\001rYj\f\v6Yrwu\001r4ru\021\a\b%\025|\004YV;Y\019;\021\028b\019Y,Y;;xY\002;\021\002VTY\f6n/Y\020\021Y\b\021Y\f6nY\028b\019\002VTd")
_TIN_i = Wherigo.ZInput(_xy4)
_TIN_i.Id = "9c262d1d-b75e-44d9-840d-3e52c1a0c2a3"
_TIN_i.Name = _t6zE("\004/\024M\f660Q%0~/\029r")
_TIN_i.Description = ""
_TIN_i.Visible = true
_TIN_i.InputType = "Text"
_TIN_i.Text = _t6zE("\031wrY6\fo\024r\024Y\029r?Y~/\029r8Y\029ruY\029oYu\fH\vY\029rLYyH\fuuruY\029rnY\004/M\f660Q%0~/\029rnY4r]/LLruY\v\fn\024D")
_tYx = Wherigo.ZInput(_xy4)
_tYx.Id = "87bb8018-cb84-4a05-8b80-80fed61cc686"
_tYx.Name = _t6zE("~/\029rYMo?Y\031l90.w6Mr")
_tYx.Description = ""
_tYx.Visible = true
_tYx.InputType = "Text"
_tYx.Text = _t6zE("\031wrY6\fo\024r\024Y\029r?Y~/\029r8Y\029ruY\029oYu\fH\vY\029rLYyH\fuuruY4r]/LLruY\v\fn\024D")
_rw5 = Wherigo.ZInput(_xy4)
_rw5.Id = "776a1d03-2e16-4df9-ba31-9603d5b48bc2"
_rw5.Name = _t6zE("\031l90y\024\f?\0240~/\029r0,wu\001\f4r")
_rw5.Description = ""
_rw5.Visible = true
_rw5.InputType = "Text"
_rw5.Text = _t6zE("\031wrY6\fo\024r\024Y\029r?Y5wr?n\024r66w\001rY\031l90y\024\f?\0240~/\029rD\a\b%\025|uwH\v\024YTxXV8Y\029\fnYwn\024Y\029r?Y~/\029rYMor?Y\029ruYyH\v6ornnr6n\fMrqd")
_xEpVY = Wherigo.ZInput(_xy4)
_xEpVY.Id = "8960fbe7-e582-4b85-8f49-e19369c1a31c"
_xEpVY.Name = _t6zE("N4]o?\020ou\001")
_xEpVY.Description = ""
_xEpVY.Visible = true
_xEpVY.InputType = "Text"
_xEpVY.Text = _t6zE("\031wrY6\fo\024r\024Y\029r?YN4]or?\020ou\001n0~/\029r8Y\029ruY\029oY\fLY,u\029rY5/uYy\024\f\001rY\028Yr?\v\f6\024ruY\v\fn\024D")
_9ubz = Wherigo.ZInput(_xy4)
_9ubz.Id = "cdb8d697-8195-4003-9e15-bc3404bd51eb"
_9ubz.Name = _t6zE("\005?\f\001rY\028")
_9ubz.Description = _t6zE("&rwH\v\024rYQow\0200\005?\f\001rY\004?\021Y\028")
_9ubz.Visible = true
_9ubz.Media = _j7_
_9ubz.Choices = {
  "6",
  "7",
  "8",
  "10"
}
_9ubz.InputType = "MultipleChoice"
_9ubz.Text = _t6zE("\031wrY5wr6rY\brwurY\v\f4ruYycwuuruD")
_K3o = Wherigo.ZInput(_xy4)
_K3o.Id = "987b49d3-288c-4416-8d58-a8097115a2b9"
_K3o.Name = _t6zE("\005?\f\001rYb")
_K3o.Description = ""
_K3o.Visible = true
_K3o.Media = _O0thc
_K3o.Choices = {
  "4",
  "4 1/2",
  "6",
  "8"
}
_K3o.InputType = "MultipleChoice"
_K3o.Text = _t6zE("\031wrY5wr6rY\brwurY\v\f4ruYlunr]\024ruD")
_P4hX = Wherigo.ZInput(_xy4)
_P4hX.Id = "31b8a420-57d9-4339-948d-d2ea34127329"
_P4hX.Name = _t6zE("\005?\f\001rY\019")
_P4hX.Description = ""
_P4hX.Visible = true
_P4hX.Media = _54P7f
_P4hX.Choices = {
  "Blaukehlchen",
  "Rotkehlchen",
  "Gelbkehlchen",
  "Laubfrosch"
}
_P4hX.InputType = "MultipleChoice"
_P4hX.Text = _t6zE("\031r6H\vrnYvwr?Ynwr\vn\024Y\029oY\foMY\029rLY\bw6\029D")
_qAHt = Wherigo.ZInput(_xy4)
_qAHt.Id = "a8f3426c-9d1d-4989-ba77-7f7da32b3ad2"
_qAHt.Name = _t6zE("\005?\f\001rY\002")
_qAHt.Description = ""
_qAHt.Visible = true
_qAHt.Media = _7Lpnh
_qAHt.Choices = {
  "Wolpertinger",
  "Kuckuck",
  "Tiger",
  "Hering"
}
_qAHt.InputType = "MultipleChoice"
_qAHt.Text = _t6zE("\031r6H\vrnYvwr?Y]\fuun\024Y\029oY\001r?\f\029rY\v/r?ruD")
_SNV = Wherigo.ZInput(_xy4)
_SNV.Id = "93cefd35-2bbd-4522-bc4b-3355576328ca"
_SNV.Name = _t6zE("\005?\f\001rYyH\vzr?Y\028")
_SNV.Description = ""
_SNV.Visible = true
_SNV.Media = _JioU2
_SNV.InputType = "Text"
_SNV.Text = _t6zE("\031wrY6\fo\024r\024Y\029wrY%rwnrc\fnnuoLLr?Y\029rnY(zur?nY\029wrnrnY\031\vr?w\001/nD")
_K3NM = Wherigo.ZInput(_xy4)
_K3NM.Id = "c097377b-b231-4f8a-b6b1-3661c4bca663"
_K3NM.Name = _t6zE("\005?\f\001rYbYnH\vzr?")
_K3NM.Description = ""
_K3NM.Visible = true
_K3NM.Media = _tZ5C
_K3NM.InputType = "Text"
_K3NM.Text = _t6zE("\031wrY6\fo\024r\024Y\029wrYy/\020w\f65r?nwH\vou\001nuoLLr?Y\029rnY(zur?nY\029wrnrnY\031\vr?w\001/nD")
_zo7G = Wherigo.ZInput(_xy4)
_zo7G.Id = "18457629-3e4d-48f3-9562-488bf9f8cd8d"
_zo7G.Name = _t6zE("\005?\f\001rY\019YnH\vzr?")
_zo7G.Description = ""
_zo7G.Visible = true
_zo7G.Media = _ynOMW
_zo7G.InputType = "Text"
_zo7G.Text = _t6zE("\031wrY\vwrnnY\029\fnYE\fuwuH\vru8Yzr6H\vrnY\029r?Y(zur?Y\029wrnrnY\031\vr?w\001/nY\f6nYEwu\029Y4rnrnnruY\v\f\024D")
_ASzHo = Wherigo.ZInput(_xy4)
_ASzHo.Id = "6664e24f-2249-4fab-ba61-7e9ff5f7db4d"
_ASzHo.Name = _t6zE("\005?\f\001rY\002YnH\vzr?")
_ASzHo.Description = ""
_ASzHo.Visible = true
_ASzHo.Media = _oWJ
_ASzHo.InputType = "Text"
_ASzHo.Text = _t6zE("I/uYzr6H\vr?YyH\vLr\024\024r?6wu\001n\f?\024Yn\024\fLL\024Y\029wrnrnY9ruw\024\f6c?\frc\f?\f\024D")
_IAeCS = Wherigo.ZInput(_xy4)
_IAeCS.Id = "d63df7b3-4816-4eda-a2c0-0fb83e8323a5"
_IAeCS.Name = _t6zE("\005?\f\001rYVYnH\vzr?")
_IAeCS.Description = ""
_IAeCS.Visible = true
_IAeCS.Media = _FBE
_IAeCS.InputType = "Text"
_IAeCS.Text = _t6zE("\031wrY6\fo\024r\024Y\029\fnYr?n\024rY\031/?\024Y\foMYyrw\024rY\019b\002Y\029r?Y,p]o?nw/unM\fou\fY5/uYaro\024nH\v6\fu\0298Y\b\fu\029Y\0288Y\031w?4r66/nrY|x\021YNoM6\f\001rd\021")
_kJp = Wherigo.ZInput(_xy4)
_kJp.Id = "bf2dedd4-f4ef-43a1-887a-1effd771727e"
_kJp.Name = _t6zE("\005?\f\001rYTYnH\vzr?")
_kJp.Description = ""
_kJp.Visible = true
_kJp.Media = _Jua0
_kJp.InputType = "Text"
_kJp.Text = _t6zE("\031wrY6\fo\024r\024Y\029r?Y9~0~/\029rY\029rnY~\fH\vrn8Yor4r?Y\029ruY\029r?Y(zur?Y\029wrnrnY\031\vr?w\001/nY\020oM\fr66w\001Y\001rn\024/6cr?\024Ywn\0248Yu/H\vY4r5/?Yr?YLw\024Y\029rLY~\fH\vruY\fu\001rM\fu\001ruY\v\f\024\021")
_988H = Wherigo.ZInput(_xy4)
_988H.Id = "d4a28c80-bdf2-4380-93c3-039e1db185e1"
_988H.Name = _t6zE("\005?\f\001rYXYnH\vzr?")
_988H.Description = ""
_988H.Visible = true
_988H.Media = _aSw9
_988H.InputType = "Text"
_988H.Text = _t6zE("\031wrY6\fo\024r\024Y\029wrYyr?wruuoLLr?Y\029rnY.\fu\0291nY\029rnY(zur?nY\029wrnrnY\031\vr?w\001/nY|n\024\fu\029Yb;b\028dD")
__m2 = Wherigo.ZInput(_xy4)
__m2.Id = "7634efba-1e2d-4f31-ad45-68b4d01ab3c5"
__m2.Name = _t6zE("\005?\f\001rYxYnH\vzr?")
__m2.Description = ""
__m2.Visible = true
__m2.Media = _2g4
__m2.InputType = "Text"
__m2.Text = _t6zE("\031wrY6\fo\024r\024Y\029wrY\005/?Lr6YMor?Y\029wrYrwu\vrw\0246wH\vrY\005r6\029\024\vr/?wrD")
_HP0o = Wherigo.ZInput(_xy4)
_HP0o.Id = "3078f538-f268-4dcb-ab3d-e63c97f6dc8c"
_HP0o.Name = _t6zE("\005?\f\001rY{YnH\vzr?")
_HP0o.Description = ""
_HP0o.Visible = true
_HP0o.Media = _nQYe
_HP0o.InputType = "Text"
_HP0o.Text = _t6zE("\brzrwnrY\029wrYIr?Lo\024ou\001Y5/uY\bw?H\vYou\029Yyzwuur?\024/u0a1r?YLw\024Yzruw\001ruYy\fr\024\020ruq")
_hUxox = Wherigo.ZInput(_xy4)
_hUxox.Id = "b2812c76-63c3-41a2-b245-eba871dd720c"
_hUxox.Name = _t6zE("\005?\f\001rYV")
_hUxox.Description = ""
_hUxox.Visible = true
_hUxox.Media = _z13w
_hUxox.Choices = {
  "Oslo",
  "Kopenhagen",
  "Karl-Heinz",
  "Stockholm"
}
_hUxox.InputType = "MultipleChoice"
_hUxox.Text = _t6zE("\031wrY\vrwnn\024Y\029wrY.\foc\024n\024\f\029\024Y5/uY\004/?zr\001ru")
_35tMQ = Wherigo.ZInput(_xy4)
_35tMQ.Id = "7e534732-e891-44bd-89f7-c303b0011487"
_35tMQ.Name = _t6zE("\005?\f\001rYT")
_35tMQ.Description = ""
_35tMQ.Visible = true
_35tMQ.Media = _rYnVT
_35tMQ.Choices = {
  "Karl-Heinz Grundsprech",
  "Dave Ulmer",
  "Li Wang",
  "Mika Haemaelaeinen"
}
_35tMQ.InputType = "MultipleChoice"
_35tMQ.Text = _t6zE("\031r?Y\v\f\024Y\029ruYr?n\024ruY9r/H\fH\vrY5r?n\024rH]\024D")
_ItW = Wherigo.ZInput(_xy4)
_ItW.Id = "bfbe6d40-2601-41c3-8972-6c25eb47af70"
_ItW.Name = _t6zE("\005?\f\001rYX")
_ItW.Description = ""
_ItW.Visible = true
_ItW.Media = _G1ns9
_ItW.Choices = {
  "Project APE Cache",
  "Webcam Cache",
  "Locationless (Reverse)",
  "Wherigo",
  "Earthcache",
  "Virtual"
}
_ItW.InputType = "MultipleChoice"
_ItW.Text = _t6zE("CLYzr6H\vruY~\fH\vr\0241cY\v\fu\029r6\024YrnYnwH\vY4rwY\029wrnrLY\b/uonD")
_Sexm = Wherigo.ZInput(_xy4)
_Sexm.Id = "d9f367d3-9e73-4fc7-82e3-0c6e5ffe4cc3"
_Sexm.Name = _t6zE("\005?\f\001rYx")
_Sexm.Description = ""
_Sexm.Visible = true
_Sexm.Media = _MX6BF
_Sexm.Choices = {
  "Karl-Heinz",
  "Barfussmann",
  "Sandalenmann",
  "Gummistiefelmann"
}
_Sexm.InputType = "MultipleChoice"
_Sexm.Text = _t6zE("\031wrY6\fo\024r\024Y\029r?Y~\fH\vr?u\fLrY\029rnY(zur?nY\029wrnrnY\031\vr?w\001/nD")
_r00Y = Wherigo.ZInput(_xy4)
_r00Y.Id = "44919cb0-262c-42a8-a98d-d3aaddaee286"
_r00Y.Name = _t6zE("\005?\f\001rY{")
_r00Y.Description = ""
_r00Y.Visible = true
_r00Y.Media = _yJP
_r00Y.Choices = {
  "TFTC",
  "LMAA",
  "FTF",
  "Karl-Heinz"
}
_r00Y.InputType = "MultipleChoice"
_r00Y.Text = _t6zE("\031wrY6\fo\024r\024Y\029wrYN4]or?\020ou\001YMor?YKMw?n\024Y\024/YMwu\029KD")
_GJfS = Wherigo.ZInput(_xy4)
_GJfS.Id = "5a201185-aeec-4c3b-a85b-8388f57c1b4f"
_GJfS.Name = _t6zE("\005?\f\001rY\028;")
_GJfS.Description = ""
_GJfS.Visible = true
_GJfS.Media = _nUH
_GJfS.Choices = {
  "Karl-Heinz",
  "Der Bikeport",
  "Der Carport",
  "Der Heliport"
}
_GJfS.InputType = "MultipleChoice"
_GJfS.Text = _t6zE("\031wrY\vrwnn\024Y\029r?Y.\foc\024H\fH\vrY\020oY\029wrnrLY\b/uonD")
_Kmp = Wherigo.ZInput(_xy4)
_Kmp.Id = "99621f2f-5f52-44fc-9fd6-7be764161938"
_Kmp.Name = _t6zE("\005?\f\001rY\028\028")
_Kmp.Description = ""
_Kmp.Visible = true
_Kmp.Media = _9C7Nt
_Kmp.Choices = {
  "Braunfels",
  "Nirgends",
  "Auf der ISS",
  "Seattle"
}
_Kmp.InputType = "MultipleChoice"
_Kmp.Text = _t6zE("\031/Y4rMwu\029r\024YnwH\vY\029\fnY9?/ouncr\f]Y.QD")
_0X7m = Wherigo.ZInput(_xy4)
_0X7m.Id = "25162f92-cc02-4164-bd70-43ca4acb8475"
_0X7m.Name = _t6zE("\005?\f\001rY\028b")
_0X7m.Description = ""
_0X7m.Visible = true
_0X7m.Media = _pBCr
_0X7m.Choices = {
  "Star Trek",
  "Star Wars",
  "Mondbasis Alpha 1",
  "Kampfstern Galactica"
}
_0X7m.InputType = "MultipleChoice"
_0X7m.Text = _t6zE("\031/\020oY\001r\v/r?\024Y\029wrnrnY%\foLnH\vwMMD")
_KdO = Wherigo.ZInput(_xy4)
_KdO.Id = "3d1004a1-3783-46e4-8043-e530c549b080"
_KdO.Name = _t6zE("\005?\f\001rY\028\019")
_KdO.Description = ""
_KdO.Visible = true
_KdO.Media = _71BrV
_KdO.Choices = {
  "Star Trek",
  "Star Wars",
  "Mondbasis Alpha 1",
  "Kampfstern Galactica"
}
_KdO.InputType = "MultipleChoice"
_KdO.Text = _t6zE("\031/\020oY\001r\v/r?\024Y\029wrnrnY%\foLnH\vwMMD")
_3YB5 = Wherigo.ZInput(_xy4)
_3YB5.Id = "9db6a2fb-5d87-48aa-9ecd-33ebd4c6b27f"
_3YB5.Name = _t6zE("\005?\f\001rY\028\002")
_3YB5.Description = ""
_3YB5.Visible = true
_3YB5.Media = _4Xsj
_3YB5.Choices = {
  "Bananenfalter",
  "Orangenfalter",
  "Zitronenfalter",
  "Apfelfalter"
}
_3YB5.InputType = "MultipleChoice"
_3YB5.Text = _t6zE("CLYzr6H\vruYyH\vLr\024\024r?6wu\001Y\v\fu\029r6\024YrnYnwH\vY\vwr?D")
_bZL = Wherigo.ZInput(_xy4)
_bZL.Id = "5198f12b-1e98-40ce-bda8-080a0acfae4c"
_bZL.Name = _t6zE("\005?\f\001rY\028V")
_bZL.Description = ""
_bZL.Visible = true
_bZL.Media = _i8kJG
_bZL.Choices = {
  "Barfussmann",
  "Karl-Heinz",
  "Kermit",
  "Signal"
}
_bZL.InputType = "MultipleChoice"
_bZL.Text = _t6zE("\031r?Ywn\024Y\vwr?Y\f4\001r4w6\029r\024")
_cx1V = Wherigo.ZInput(_xy4)
_cx1V.Id = "c5abb73e-bc7d-4ddd-8119-0f79a9127005"
_cx1V.Name = _t6zE("\005?\f\001rY\028T")
_cx1V.Description = ""
_cx1V.Visible = true
_cx1V.Media = _ae3i
_cx1V.Choices = {
  "FTF",
  "ECA",
  "TFTC",
  "KDGLGSXKH"
}
_cx1V.InputType = "MultipleChoice"
_cx1V.Text = _t6zE("\031r6H\vrY\029r?YM/6\001ru\029ruYN4]or?\020ou\001ruY\v\f\024YuwH\v\024nYLw\024Y9r/\fH\vwu\001Y\020oY\024ouD")
_A8As = Wherigo.ZInput(_xy4)
_A8As.Id = "d5977cd6-d709-441b-9bd6-f73325473f77"
_A8As.Name = _t6zE("\005?\f\001rY\028X")
_A8As.Description = ""
_A8As.Visible = true
_A8As.Media = _c7oXs
_A8As.Choices = {
  "Geocacher",
  "Hochseeangler",
  "Wuestenbewohner",
  "Polarforscher"
}
_A8As.InputType = "MultipleChoice"
_A8As.Text = _t6zE("K\bwnY4\f6\029YwLY\031\f6\029KYwn\024Y\029wrY\f64r?urYIr?\f4nH\vwr\029ou\001Yzr6H\vr?Y!r?n/uruDY")
_MKggt = Wherigo.ZInput(_xy4)
_MKggt.Id = "de4bd05d-dd99-4b7e-ab00-d3fd8915f269"
_MKggt.Name = _t6zE("\005?\f\001rY\028x")
_MKggt.Description = ""
_MKggt.Visible = true
_MKggt.Media = _O9QNA
_MKggt.Choices = {
  "Langgoens",
  "Kurzgoens",
  "Mittelgoens",
  "Karl-Heinz"
}
_MKggt.InputType = "MultipleChoice"
_MKggt.Text = _t6zE("\031wrY\vrwnn\024Y\029r?Y(?\0248YwuY\029rLY\029oY\029wH\vY\001r?\f\029rY4rMwu\029rn\024D")
_YNW3c = Wherigo.ZInput(_xy4)
_YNW3c.Id = "a68b014d-e731-4466-8d69-ff009906935b"
_YNW3c.Name = _t6zE("\005?\f\001rY\028{")
_YNW3c.Description = ""
_YNW3c.Visible = true
_YNW3c.Media = _XvbK
_YNW3c.Choices = {"Android"}
_YNW3c.InputType = "MultipleChoice"
_YNW3c.Text = _t6zE("\031\fnYwn\024Y4rnnr?DYNu\029?/w\029Y/\029r?YNcc6rD")
_yNOh = Wherigo.ZInput(_xy4)
_yNOh.Id = "2f0bfe9c-6052-4c68-bff3-3a97eb44e975"
_yNOh.Name = _t6zE("\005?\f\001rYb;")
_yNOh.Description = ""
_yNOh.Visible = true
_yNOh.Media = _j5U
_yNOh.Choices = {
  "1790",
  "1990 bis 1995",
  "2000",
  "2010"
}
_yNOh.InputType = "MultipleChoice"
_yNOh.Text = _t6zE("\031\fuuYzo?\029rY\029r?Yr?n\024rY9r/H\fH\vrY5r?n\024rH]\024D")
__NEd4 = Wherigo.ZInput(_xy4)
__NEd4.Id = "90825c3a-de52-4290-b115-396666b5d6ae"
__NEd4.Name = _t6zE("\005?\f\001rYb\028")
__NEd4.Description = ""
__NEd4.Visible = true
__NEd4.Media = _nbXe
__NEd4.Choices = {
  "Rheinland-Pfalz",
  "Thueringen",
  "Hessen",
  "Mallorca"
}
__NEd4.InputType = "MultipleChoice"
__NEd4.Text = _t6zE("luYzr6H\vrLY\bou\029rn6\fu\029Y4rMwu\029rn\024Y\029oY\029wH\vY\001r?\f\029rD")
_0j3G = Wherigo.ZInput(_xy4)
_0j3G.Id = "8007ec3d-3e54-47a5-aa20-fbf388db231c"
_0j3G.Name = _t6zE("\005?\f\001rYbb")
_0j3G.Description = ""
_0j3G.Visible = true
_0j3G.Media = _L_v6H
_0j3G.Choices = {
  "gar keine",
  "12",
  "24",
  "144"
}
_0j3G.InputType = "MultipleChoice"
_0j3G.Text = _t6zE("\031wrY5wr6rYy\024\f\024w/uruY\v\f\024Y\029wrnr?Y\031\vr?w\001/D")
_yGq = Wherigo.ZInput(_xy4)
_yGq.Id = "ee2828db-3c72-4db9-b561-2c5099d86323"
_yGq.Name = _t6zE("\005?\f\001rYb\019")
_yGq.Description = ""
_yGq.Visible = true
_yGq.Media = _XPDlj
_yGq.Choices = {
  "Wald",
  "Wueste",
  "Meer",
  "Sumpf"
}
_yGq.InputType = "MultipleChoice"
_yGq.Text = _t6zE("\031\fnY4rMwu\029r\024YnwH\vY5/?Y\029rLY.\fonY\029rnY(zur?nY\029wrnrnY\031\vr?w\001/nD")
_rpcWV = Wherigo.ZInput(_xy4)
_rpcWV.Id = "8fb16a0b-39ce-47f3-8831-8fdbe6bb01d1"
_rpcWV.Name = _t6zE("\005?\f\001rYb\002")
_rpcWV.Description = ""
_rpcWV.Visible = true
_rpcWV.Media = _wBKW3
_rpcWV.Choices = {
  "Wo ist Guenther?",
  "Wherigo",
  "Weiss ich genau!",
  "Apfelmusfabrik"
}
_rpcWV.InputType = "MultipleChoice"
_rpcWV.Text = _t6zE("\031\fnY4r\029ro\024r\024Y\029wrYN4]or?\020ou\001Y\031l9D")
_i7qzc = Wherigo.ZInput(_xy4)
_i7qzc.Id = "cdb6bbf7-f862-49f9-abb8-8977896bb18d"
_i7qzc.Name = _t6zE("\005?\f\001rYbV")
_i7qzc.Description = ""
_i7qzc.Visible = true
_i7qzc.Media = _IoX
_i7qzc.Choices = {
  "Pi",
  "6",
  "8",
  "10"
}
_i7qzc.InputType = "MultipleChoice"
_i7qzc.Text = _t6zE("\031r6H\vrYj\f\v6Ywn\024Y\001?/rnr?Y\f6nYXY\f4r?Y]6rwur?Y\f6nY{YD")
_Iz_mh = Wherigo.ZInput(_xy4)
_Iz_mh.Id = "164656c9-ebc4-4532-9450-76bb28b889a5"
_Iz_mh.Name = _t6zE("6r\024\020\024rY\005?\f\001r")
_Iz_mh.Description = ""
_Iz_mh.Visible = true
_Iz_mh.Media = _wOr
_Iz_mh.Choices = {
  "20",
  "17 + 3",
  "Wurzel aus 400",
  "zwanzig"
}
_Iz_mh.InputType = "MultipleChoice"
_Iz_mh.Text = _t6zE("\031wrY5wr6rYyrw\024ruY\v\f\024YrwuYl]/n\fr\029r?D")
_B8X = Wherigo.ZInput(_xy4)
_B8X.Id = "ed326347-fab4-4c2c-b654-c0ee821b815b"
_B8X.Name = _t6zE("Nonz\f\v6Y\014onw]4/p")
_B8X.Description = ""
_B8X.Visible = true
_B8X.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5 (Abbruch)"
}
_B8X.InputType = "MultipleChoice"
_B8X.Text = _t6zE("\031\fnY\029\f?MYrnYnrwuD\a\b%\025\a\b%\025\028dY\031w?YuruuruYrnYa/nruMwnH\vru\a\b%\025YZu4nc`Zu4nc`Zu4nc`|5/uY\029ruYa/nruMwnH\vr?ud\a\b%\025bdYN5rY\014\f?w\f\a\b%\025YZu4nc`Zu4nc`Zu4nc`|5/uY!\f5\f?/\024\024wY\001rnou\001rud\a\b%\025\019dYN5rY\014\f?w\f\a\b%\025YZu4nc`Zu4nc`Zu4nc`|5/uYrwurLY\boH]r6z\f6Y\001rnou\001rud\a\b%\025\002dYN5rY\014\f?w\f\a\b%\025YZu4nc`Zu4nc`Zu4nc`|5/uY\b\f?MonnL\fuuY\foMY\029r?Y\b6/H]M6/r\024rY\001rncwr6\024d\a\b%\025VdYN44?oH\v")
_VTih8 = Wherigo.ZInput(_xy4)
_VTih8.Id = "8bcb549d-ded0-41f2-9dce-d6950713109a"
_VTih8.Name = _t6zE("Nonz\f\v6Y\031w\024\020r4oH\v")
_VTih8.Description = ""
_VTih8.Visible = true
_VTih8.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8"
}
_VTih8.InputType = "MultipleChoice"
_VTih8.Text = _t6zE("\031\fnY\029\f?MYrnYnrwuD\a\b%\025\a\b%\025\028dY\b\fr?ruzw\024\020r\a\b%\025bdYv0%rp0\031w\024\020r\a\b%\025\019dY.\fw0\031w\024\020r\a\b%\025\002dYE6/0\031w\024\020r\a\b%\025VdY\014\fuu0wu0\031\fu\0290\031w\024\020r\a\b%\025TdYy/un\024w\001rY\031w\024\020rY\028\a\b%\025XdYy/un\024w\001rY\031w\024\020rYb\a\b%\025xdYN44?oH\v")
_CLpq = Wherigo.ZInput(_xy4)
_CLpq.Id = "61b7e996-5ad8-45f6-a52b-3f7e2b2a7fb7"
_CLpq.Name = _t6zE("Nonz\f\v6Ya\f\024ru4\fu]")
_CLpq.Description = ""
_CLpq.Visible = true
_CLpq.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5"
}
_CLpq.InputType = "MultipleChoice"
_CLpq.Text = _t6zE("I/uYzr6H\vrLY~\fH\vrY\v\fr\024\024rn\024Y\029ruuY\001r?urY\029wrY\005wu\f6]//?\029wu\f\024ruD\a\b%\025\a\b%\025\028dYv\f\001M\f6\024r?M\fou\fY5/uY&\fu\001\001/runY\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~\019\005E\004v\a\b%\025YZu4nc`Zu4nc`Zu4nc`aVY5/uY\b\f?MonnL\fuu\a\b%\025bdY,wuY./H\vY\foMY\029ruY9r/H\vrH]r?q\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~VtVNb\a\b%\025YZu4nc`Zu4nc`Zu4nc`a\002Y5/uY\b\f?MonnL\fuu\a\b%\025\019dY~\fH\vrnY5/uY\fu\029r?ruY(zur?u\a\b%\025\002dYN44?oH\v")
_ivjL = Wherigo.ZInput(_xy4)
_ivjL.Id = "f18b322b-abc1-45f0-a4ff-716723add7f1"
_ivjL.Name = _t6zE("Nonz\f\v6YM?rL\029rY~\fH\vrn")
_ivjL.Description = ""
_ivjL.Visible = true
_ivjL.InputType = "Text"
_ivjL.Text = _t6zE("I/uYzr6H\vrLY~\fH\vrY\v\f\024\024rn\024Y\029oY\029ruuY\001r?urY\029wrY\005wu\f6]//?\029wu\f\024ruD\a\b%\025\a\b%\025\028dY(6r7nY.\foMru\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~T; Nx\a\b%\025YZu4nc`Zu4nc`Zu4nc`|a\0028VY5/uY(6r7n \fr\001r?d\a\b%\025bdY\004r5r?Y\024?1Y\024\vrYr5w6Yr1r\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~\028%at\002\a\b%\025YZu4nc`Zu4nc`Zu4nc`|aVY5/uY\024?\f4w?w\029r?nd\a\b%\025\019dY9!yYncwuu\024Y|vrw6Ybd\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~b~.\002,\a\b%\025YZu4nc`Zu4nc`Zu4nc`|aVY5/uY\024wu\024ru4?/\024d\a\b%\025\002dY\brLr?]ou\001\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~x!V\019!\a\b%\025YZu4nc`Zu4nc`Zu4nc`|aVY5/uY\029r\v\fo\029wd\a\b%\025VdYCL6\fo\024r\a\b%\025YZu4nc`Zu4nc`Zu4nc`9~xI;.;\a\b%\025YZu4nc`Zu4nc`Zu4nc`|aVY5/uYN%0vr\fLd\a\b%\025TdYN44?oH\v")
function _xy4:OnStart()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029wrnruY\031\vr?w\001/Y4r?rw\024nY4wnY\020oLY,u\029rY\029r?Yy\024\f\001rY\028Y\001rncwr6\024You\029YL/rH\v\024rn\024Y\f4]or?\020ruD"),
    Buttons = {
      _t6zE("\004rwu"),
      _t6zE(" \f8Y\f4]or?\020ru")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button2" == true then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_xEpVY)
          end)
        else
          _f19.Active = true
        end
      end
    end
  })
end
function _xy4:OnRestore()
end
function _f19:OnEnter()
  _OIhY = _t6zE("[M\028{")
  if _naXyO == false then
    _Urwigo.MessageBox({
      Text = (_t6zE(".\f66/Y") .. Player.Name) .. _t6zE("q\a\b%\025\a\b%\025 r\024\020\024Yzr?\029rYwH\vY\029w?Yr?n\024YrwuL\f6YrwuYc\f\f?Y\005?\f\001ruYn\024r66ruYou\029Y\029\fu\fH\vY\f66rnYr?]6\fr?ru8Yz\fnY\029oYzwnnruYLonn\024\021"),
      Callback = function(action)
        if action ~= nil then
          _wr3Rn()
        end
      end
    })
  end
  _naXyO = true
  _D8y = 1
end
function _t6v3:OnEnter()
  _OIhY = _t6zE("[\024T5\019")
  _D8y = 2
end
function _xYF9R:OnEnter()
  _OIhY = _t6zE("[p<\005{%")
  _D8y = 3
end
function _v570h:OnEnter()
  _OIhY = _t6zE("[5VX;\v")
  _D8y = 4
end
function _yDPL:OnEnter()
  _OIhY = _t6zE("[1a!&")
  _D8y = 5
end
function _ipL:OnEnter()
  _OIhY = _t6zE("[wc&")
  _D8y = 6
end
function _cZWP:OnEnter()
  _OIhY = _t6zE("[Hj\031!")
  _D8y = 7
end
function _5lXaf:OnEnter()
  _OIhY = _t6zE("[V6t\fM")
  _D8y = 8
end
function _59K:OnEnter()
  _OIhY = _t6zE("[V{E")
  _D8y = 9
end
function _gn0n:OnEnter()
  _OIhY = _t6zE("[\001u;u")
  _D8y = 10
end
function _CxSE:OnEnter()
  _OIhY = _t6zE("[~py,")
  _D8y = 11
end
function _ofe:OnEnter()
  _OIhY = _t6zE("[/Mr")
  _D8y = 12
end
function _eWfrt:OnEnter()
  _OIhY = _t6zE("[r\031M?\024")
  _TjM5 = true
end
function _0Ts9:OnEnter()
  _OIhY = _t6zE("[;vn{")
  _jg65_.Active = true
end
function _jg65_:OnEnter()
  _OIhY = _t6zE("[\015\001TV[")
  _Urwigo.OldDialog({
    {
      Text = _t6zE(",w\001ru\0246wH\vY\v\f\024\024rYwH\vYuwH\v\024Y\029\fLw\024Y\001r?rH\vur\0248Y\029\fnnY~\fH\vr?Y\029ruY\031l9Y6\foMruY6\fnnru8Y/4z/\v6Y\029\fnYuwH\v\024Yu/\024zru\029w\001Ywn\024\021")
    },
    {
      Text = _t6zE("N4r?Yuro6wH\vYz\f?ruY~\fH\vr?Yru\024\024\fronH\v\0248Y\029\fnnYrnY4rwLY,??rwH\vruY\029rnY\005wu\f6nY]rwurY\014r6\029ou\001YwLY!6\f1r?Y\001r\001r4ruY\v\f\024\021")
    },
    {
      Text = _t6zE("a\f?oLY\001w4\024YrnY\015r\024\020\024Y\028Y\028SbY \f\v?rYu\fH\vY\029rLY!o46wn\vY\029/H\vYr\024z\fnY\020oY6rnru8YzruuYL\fuYnwH\vY\029rLY\005wu\f6Y\001ru\fr\vr?\024Y\v\f\024You\029Y\029\f4rwY\029r?Y!6\f1r?Y6\froM\024\021")
    },
    {
      Text = _t6zE("N6n/\\Y.,%j&l~.,\004Y9&C,~E\031C\004y~.qY\a\b%\025\a\b%\025aoY\v\fn\024YrnY\001rnH\v\fMM\024You\029Y]\fuun\024Y\029wH\vY\015r\024\020\024YwunY&/\0014oH\vYrwu\024?\f\001ru\021YawrYa/nrY\001\fu\020YwuY\029r?Y\004\fr\vrYn/66\024rY]\foLY\020oYor4r?nr\vruYnrwu")
    }
  })
end
function __7I2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _D8y = tonumber(input)
  if _D8y == 1 then
    _1SAU()
  elseif _D8y == 2 then
    _tfget()
  elseif _D8y == 3 then
    _DFu()
  elseif _D8y == 4 then
    _NWQE()
  elseif _D8y == 5 then
    _jXhAe()
  elseif _D8y == 6 then
    _Mp7kf()
  elseif _D8y == 7 then
    _Lf5()
  elseif _D8y == 8 then
    _SmKi()
  elseif _D8y == 9 then
    _jmtb()
  elseif _D8y == 10 then
    _OrpTF()
  elseif _D8y == 11 then
    _nIF()
  elseif _D8y == 12 then
    _LaQ()
  end
end
function _TkrRc:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _t6zE("aoYn/66n\024YrwurYnrH\vn\024r66w\001rYj\f\v6Yrwu\001r4ruq"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_TkrRc)
          end)
        end
      end
    })
    return
  end
  _Lrw = input
  if _Lrw == 250142 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028q")
      },
      {
        Text = _t6zE("ErwurYN\vuou\0018Yz\f?oLY\029oY\029wrY\015r\024\020\024Yrwu\001r\001r4ruY\v\fn\024\021\a\b%\025a\fnYr?\001w4\024Y\029/H\vY\001\f?Y]rwuruYywuuq")
      }
    })
  elseif _Lrw == 319188 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYbq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _bpEvC:MoveTo(_t6v3)
      _t6v3.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 338305 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\019q")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _EGZm7:MoveTo(_xYF9R)
      _xYF9R.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 401395 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\002q")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _bLdu:MoveTo(_v570h)
      _v570h.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 372625 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYVq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _Q4B:MoveTo(_yDPL)
      _yDPL.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 397656 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYTq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _Djcm9:MoveTo(_ipL)
      _ipL.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 403630 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYXq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _0dWO:MoveTo(_cZWP)
      _cZWP.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 443665 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYxq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _ihjX:MoveTo(_5lXaf)
      _5lXaf.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 437714 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY{q")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _WnrY:MoveTo(_59K)
      _59K.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 305482 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028;q")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _QMmH7:MoveTo(_gn0n)
      _gn0n.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 276283 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028\028Y|!?rMwu\f6dq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _0rCIO:MoveTo(_CxSE)
      _CxSE.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Lrw == 263195 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnYnwu\029Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028bY|\005wu\f6dq")
      },
      {
        Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021")
      }
    }, function(action)
      _fIfBj:MoveTo(_ofe)
      _ofe.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYnwu\029Y6rw\029r?YuwH\v\024Y\029wrY?wH\v\024w\001ruYE//?\029wu\f\024ru\021\a\b%\025.\fn\024Y\029oY\029wH\vY5wr66rwH\v\024Yuo?Y5r?\024wcc\024D"),
      Buttons = {
        _t6zE(" \f8Y5r?\024wcc\024"),
        _t6zE("\004rwu")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" == true then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_TkrRc)
            end)
          else
            _Urwigo.MessageBox({
              Text = _t6zE("a\fuuYLonn\024Y\029oY\029wH\vY\015r\024\020\024Yz/\v6Yu/H\vYL\f6YLw\024Y\029r?Y5/?\vr?w\001ruYy\024\f\001rY4rnH\v\frM\024w\001rYou\029YnH\v\foru8Yz\fnY\029oY\029/?\024Y5r?]r\v?\024Y\001rL\fH\v\024Y\v\f4ruY]/ruu\024rn\024\021")
            })
          end
        end
      end
    })
  end
end
function _TIN_i:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _t6zE("\bw\024\024rYrwurYj\f\v6Yrwu\001r4ruq"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_TIN_i)
          end)
        end
      end
    })
    return
  end
  _a75 = input
  if _a75 == 345543 then
    if _D8y == 1 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYbY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019\028{Y,Y;;xY\002;\021\028xx")
      })
    elseif _D8y == 2 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\019Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019\019xY,Y;;xY\002;\021\019;V")
      })
    elseif _D8y == 3 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\002Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002;\028Y,Y;;xY\002;\021\019{V")
      })
    elseif _D8y == 4 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYVY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019XbY,Y;;xY\002;\021TbV")
      })
    elseif _D8y == 5 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYTY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019{XY,Y;;xY\002;\021TVT")
      })
    elseif _D8y == 6 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYXY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002;\019Y,Y;;xY\002;\021T\019;")
      })
    elseif _D8y == 7 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYxY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002\002\019Y,Y;;xY\002;\021TTV")
      })
    elseif _D8y == 8 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY{Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002\019XY,Y;;xY\002;\021X\028\002")
      })
    elseif _D8y == 9 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028;Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021b{xY,Y;;xY\002;\021\002xb")
      })
    elseif _D8y == 10 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028\028Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021bXTY,Y;;xY\002;\021bx\019")
      })
    elseif _D8y == 11 then
      _Urwigo.MessageBox({
        Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rY\028bY|\005wu\f6dY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021bT\019Y,Y;;xY\002;\021\028{V")
      })
    elseif _D8y == 12 then
      _Urwigo.Dialog(false, {
        {
          Text = _t6zE("a\fYrnYnwH\vY4rwY\029wrnr?Yy\024\f\024w/uY4r?rw\024nYoLY\029\fnY\005wu\f6Y\v\fu\029r6\0248Y]\fuuYwH\vY\029w?Yu\f\024or?6wH\vY]rwurYE//?\029wu\f\024ruYrwur?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
        },
        {
          Text = _t6zE("\031ruuY]rwuY&/\0014oH\vY5/?Y(?\024Ywn\0248Y\029\fuuY]\fuun\024Y\029oYrwuM\fH\vY\foMYrwurLYjr\024\024r6Y6/\001\001ruYou\029Y\fLY\005wu\f6Y\vwu\024r?6\fnnru8Yn/Mr?uYu/H\vYrwurYa/nrY5/?Y(?\024Ywn\0248Y/\029r?Y4rwYLw?YwuY\029ruY\b?wrM]\fn\024ruYrwuzr?Mru\021")
        },
        {
          Text = _t6zE("I/uYLw?Y\fonY]\fuun\024Y\029oY\f4r?Y\foH\vYrwuM\fH\vY/\vurYrwuruY&/\0014oH\vrwu\024?\f\001Y6/\001\001ru8Y\foH\vYzruuY\029\fnYrw\001ru\0246wH\vYuwH\v\024Y?r\001r6]/uM/?LYwn\024\021")
        }
      }, function(action)
        _Urwigo.MessageBox({
          Text = _t6zE("(\029r?YMr\v6\024Yuo?Y\029r?Y6\fLwuwr?\024rYjr\024\024r6YLw\024Y\029r?Y&/\001\fu6rw\024ou\001Y\foMY\029rLYarH]r6Y\029r?YEwn\024rYou\029Y\029oY4wn\024Y\029\fLw\024Yor4r?M/?\029r?\0248YzwrYL\fuY\vwr?Yz/\v6Y]/??r]\024Y6/\001\001\024D"),
          Buttons = {
            _t6zE("Mr\v6\024"),
            _t6zE("wn\024Y\029\f")
          },
          Callback = function(action)
            if action ~= nil then
              if action == "Button1" == true then
                _Urwigo.MessageBox({
                  Text = _t6zE("a\fuuY4r]/LLn\024Y\029oY\029wrnruYvrp\024Y\015r\024\020\024Y\vwr?YwLY\031\vr?w\001/\021"),
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.OldDialog({
                        {
                          Text = _t6zE("&/\001\fu6rw\024ou\001\\\a\b%\025\a\b%\025\brwY%r\001ruYou\029YMr\v6ru\029rLY%r\001runH\vw?LY|4rwYnr\v?Yn\024\f?]rLY%r\001ruY5wr66rwH\v\024Y\foH\vY4rwY5/?\v\fu\029rurLYyH\vw?Ld8Y4w\024\024rY\029\fnY%r\001ru0\004/\024M\f660&/\0014oH\vYuo\024\020ru\021Ya\fYz\fr?rYrnYuwH\v\024Yn/YnH\v6wLL8YM\f66nYnr64w\001rnYMroH\v\024Yzr?\029ruYn/66\024r\021Y\a\b%\025luY\029wrnrLY\005\f66Y\029wrYwuur?rYa/nrYrwuM\fH\vY\001rnH\v6/nnruY6\fnnru8Y\foH\vYzruuYrnYroH\vY5wr66rwH\v\024YwuY\029ruY\005wu\001r?uY\015oH]ruYn/66\024r8Y\029\fnY?wH\v\024w\001rY&/\0014oH\vY\029/H\vYL\f6Y\029o?H\v\020o46\fr\024\024r?u\021\a\b%\025l\v?Y4?\foH\v\024YroH\vYuwH\v\024YwuY4rw\029ruY&/\0014orH\vr?uY\020oY5r?rzw\001ru\021\a\b%\025a\fnY%r\001ru0\004/\024M\f660&/\0014oH\vYwn\024Y\001ru\foY\029\fn8Yz\fnY\029r?Y\004\fLrY4rn\f\001\024q")
                        },
                        {
                          Text = _t6zE("Nun/un\024ruY\029wrY]6rwur?rYwuur?rYa/nrYLw\024Y\029ruY.\fM\024u/\024w\020ruY/rMMuruYou\029YLw\024Y\029rLY4rw6wr\001ru\029ruY\005/6wrunH\v?rw4r?Y|\001r\v\024Y\foH\vYLw\024Y\fu\029r?ruYy\024wM\024ru8Y\f4r?Y\029r?Y\005/6wrunH\v?rw4r?YMou]\024w/uwr?\024Y\fLY4rn\024rudYro?ruY&/\001rwu\024?\f\001Y|\004\fLrYou\029Yr5ru\024or66Ya\f\024oLdY\foMYrwur?Y.\fM\024u/\024w\020Y5r?rzw\001ruYz\fr\v?ru\029YnwH\vYnr64w\001rYu/H\vY\foMY\029rLYycru\029r?Y4rMwu\029r\024\021Y,?n\024Y\029\fuuY\f46/rnruYou\029Y\fuY\001rrw\001ur\024r?Yy\024r66rYwunY&/\0014oH\vY]6r4ru\021")
                        },
                        {
                          Text = _t6zE("\bw\024\024rYuwH\v\024Y\029w?r]\024YwunY&/\0014oH\vY]?w\024\020r6uY/\029r?Yrw\001rurYNoM]6r4r?Y5r?zru\029ru\021")
                        },
                        {
                          Text = _t6zE("NoMY6\fu\001rY&/\001\024rp\024rY]/ruu\024Y|4\020z\021YLornn\024dYw\v?Y\vwr?Y5r?\020wH\v\024ru\021YyH\v?rw4\024YrwuM\fH\vYrwuruYnH\v/ruruY(u6wur0&/\0018Y\029\fnY?rwH\v\024Y5/66]/LLru\021")
                        }
                      })
                    end
                  end
                })
              end
            else
            end
          end
        })
      end)
    end
  elseif _a75 == 999 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024Y6rw\029r?YuwH\v\024Y\029r?Y?wH\v\024w\001rY~/\029r\021\a\b%\025\a\b%\025\014w\024Y{{{Y]/LLn\024Y\029oY\fonYrwur?YL/r\0016wH\vruY,u\0296/nnH\v6rwMrY?\fon\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_TIN_i)
          end)
        end
      end
    })
  end
end
function _tYx:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _t6zE("aoYn/66n\024Y\029ruY~/\029rYrwu\001r4ru8Y\029ruY\029oYu\fH\vY\029rLYyH\fuuruY\029rnYQ%0~/\029rnYK~/\029rYMor?Y\031l9KY4r]/LLruY\v\f4ruYn/66\024r\024\021\a\b%\025\a\b%\025{{{Yrwu\001r4ru8YoLY\fonYrwur?Ya\for?nH\v6rwMrY\020oY\001r6\fu\001ru\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tYx)
          end)
        end
      end
    })
    return
  end
  _1iAjs = input
  if _1iAjs == 8542 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("NuY\029wrnr?Yy\024r66rY\v\f\024\024rYwH\vYuwH\v\024Y\029\fLw\024Y\001r?rH\vur\0248Y\029\fnnY\029wrY.w6MrY\001ruo\024\020\024Yzw?\029\021\a\b%\025\a\b%\025awrYNoM\001\f4run\024r66ou\001Yn/66\024rY\v/MMru\0246wH\vY]6\f?YnrwuYou\029Yzw?]6wH\vYnH\vzwr?w\001Ywn\024Y\029wrnrYNoM\001\f4rY\foH\vYuwH\v\024\021\021\021")
      },
      {
        Text = _t6zE("N6n/YrwuM\fH\vY\029\fnYIw\029r/Y4r\024?\fH\v\024ruYou\029Y\029\f4rwY\020\fr\v6ru8YzwrY/M\024YnwH\vY\014w\024\0016wr\029r?Y\029rnYzrwnnruYvr\fLnY\029ruY\b\f66Y\vwuYou\029Y\vr?zr?MruY|ru\024nc?wH\v\024Y\029r?YI\f?w\f46ruY\fd\021")
      },
      {
        Text = _t6zE("awrnrYNu\020\f\v6Y\029\fuuY\020on\fLLruYLw\024Y\029r?YNu\020\f\v6Y\029r?Yvw\001r?8Yzr6H\vruYrwuruYy\024rcc\024\fu\020Y\vwu\001r6r\001\024Y\v\f4ruY|I\f?w\f46rY4dYou\029Y\029r?YNu\020\f\v6Y\029r?Y\b\fr?ru8Yzr6H\vrYrwuruY\014//uz\f6]Y\001rL\fH\v\024Y\v\f4ruY|I\f?w\f46rYHdYwuY\029wrY\005/?Lr6Yrwunr\024\020ru\021")
      },
      {
        Text = _t6zE(".wr?Yu/H\vYL\f6Y\029wrY\005/?Lr6\\\a\b%\025\a\b%\025\004YV;Y\019;\021|\fY>Y4dYpYbT\a\b%\025,Y;;xY\002;\021|\fY>YHdYpYb\028Y>Y\028\028")
      },
      {
        Text = _t6zE("\005\f66nY\029wrnrY.w6MrYuwH\v\024Y\fon\001r?rwH\v\024Y\v\f\0248Y\020o?Y\004/\024Y\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuYzr?\029ruY\029w?Y\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uYrwuM\fH\vYn/Y5r??\f\024ru\021")
      }
    })
  elseif _1iAjs == 1973 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("NuY\029wrnr?Yy\024r66rY\v\f\024\024rYwH\vYuwH\v\024Y\029\fLw\024Y\001r?rH\vur\0248Y\029\fnnY\029wrY.w6MrY\001ruo\024\020\024Yzw?\029\021\a\b%\025\a\b%\025awrYNoM\001\f4run\024r66ou\001Yn/66\024rY\v/MMru\0246wH\vY]6\f?YnrwuYou\029Yzw?]6wH\vYnH\vzwr?w\001Ywn\024Y\029wrnrYNoM\001\f4rY\foH\vYuwH\v\024\021\021\021")
      },
      {
        Text = _t6zE("N6n/YrwuM\fH\vY\029\fnYIw\029r/Y4r\024?\fH\v\024ruYou\029Y\029ruY\031r\001Yu\fH\v5/66\020wr\vru\021\a\b%\025\a\b%\025NLYjwr6Y\fu\001r]/LLruY4rMwu\029ruYnwH\vY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uY\029\fuuYwLY\029/ccr6\024ruY\b/\029ru\021")
      },
      {
        Text = _t6zE("\005\f66nY\029wrnrY.w6MrYuwH\v\024Y\fon\001r?rwH\v\024Y\v\f\0248Y\020o?Y\004/\024Y\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuYzr?\029ruY\029w?Y\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uYrwuM\fH\vYn/Y5r??\f\024ru\021")
      }
    })
  elseif _1iAjs == 6813 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("NuY\029wrnr?Yy\024r66rY\v\f\024\024rYwH\vYuwH\v\024Y\029\fLw\024Y\001r?rH\vur\0248Y\029\fnnY\029wrY.w6MrY\001ruo\024\020\024Yzw?\029\021\a\b%\025\a\b%\025awrYNoM\001\f4run\024r66ou\001Yn/66\024rY\v/MMru\0246wH\vY]6\f?YnrwuYou\029Yzw?]6wH\vYnH\vzwr?w\001Ywn\024Y\029wrnrYNoM\001\f4rY\foH\vYuwH\v\024\021\021\021")
      },
      {
        Text = _t6zE("N6n/YrwuM\fH\vY\029\fnYIw\029r/Y4wnY\020oLY,u\029rY4r\024?\fH\v\024ruYou\029Y\029\fuuYrwuM\fH\vYMor?Yw?\001ru\029rwurY\029r?Y\fu\001r4/\024ruruYE//?\029wu\f\024ruYru\024nH\vrw\029ru\021\a\b%\025\a\b%\025\031ruuY\029oYrwurYnH\v6\forY,u\024nH\vrw\029ou\001Y\024?wMMn\0248Y4?\foH\vn\024Y\029oY\029wrnrYE//?\029wu\f\024ruYu/H\vYuwH\v\024YrwuL\f6YoL\020o?rH\vuru\021")
      },
      {
        Text = _t6zE("\005\f66nY\029wrnrY.w6MrYuwH\v\024Y\fon\001r?rwH\v\024Y\v\f\0248Y\020o?Y\004/\024Y\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuYzr?\029ruY\029w?Y\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uYrwuM\fH\vYn/Y5r??\f\024ru\021")
      }
    })
  elseif _1iAjs == 4394 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("awrnYwn\024Yz/\v6Y\029wrYnH\vzwr?w\001n\024rYy\024\f\024w/u8Y\fuY\029r?Y\foH\vY\fLY\v\froMw\001n\024ruY\029wrY.w6MrY\001ruo\024\020\024Yzw?\029\021")
      },
      {
        Text = _t6zE("Cu\029Y\029\f4rwY\v\f4rYwH\vYnwrYnH\v/uY\029ro\0246wH\vY6rwH\v\024r?Y\001rL\fH\v\024\021\a\b%\025awrYr?n\024ruY\031/H\vruY\001\f4YrnYu/H\vYrwuY\fu\029r?rnY\0190a0Iw\029r/YLw\024Y\029ro\0246wH\vY]/Lc6w\020wr?\024r?ruY\005?\f\001ru\021")
      }
    }, function(action)
      if _IzX == true then
        _Urwigo.MessageBox({
          Text = _t6zE("aruY\020zrw\024ruY6\fLwuwr?\024ruYjr\024\024r68Y\foMY\029rLY\029w5r?nrYE//?\029wu\f\024ruYn\024r\vru8Y\v\fn\024Y\029oY\v/MMru\0246wH\vYuwH\v\024Yor4r?nr\vru\021"),
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _t6zE("&rw\029r?Y]\fuun\024Y\029oYuwH\v\024Y\v/MMru8Y\029\fnnYrwur?Y\029rwur?Yvr\fL]/66r\001ruYzruw\001r?Y!?/46rLrYLw\024Y\029rLYIw\029r/Y\v\f\024Y\f6nY\029o8Y\029\fY\029oY\015\fY6rw\029r?Y\f66rwurYou\024r?zr\001nY4wn\024\021"),
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _t6zE("a\fuuYLonn\024Y\029oYz/\v6Y6rw\029r?Y\029ruY~\vrH]r?YrwuYzruw\001YWo\fr6ru\021\a\b%\025Iwr66rwH\v\024Y]\fuun\024Y\029oY\015\fY\020oLwu\029rn\024YrwuY\001\fu\020Y]6rwuYzruw\001Yz\fnYwLYIw\029r/Yr?]ruuru8Yn/Y\029\fnnY\029oYrwuw\001rYy\fH\vruYLw\024Y\001?/nnr?Y\031\f\v?nH\vrwu6wH\v]rw\024Y\fonnH\v6wrnnruY]\fuun\024\021"),
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _t6zE("N6\024r?u\f\024w5Y\029\f?Mn\024Y\029oY\029w?Y\foH\vYrwuM\fH\vY\029wrYE//?\029wu\f\024ruY\029r?Yy\024\f\001rYTY\001r4ruY6\fnnru8Ywu\029rLY\029oY\029ruYQ%0~/\029rY\foMY\029r?Y%orH]nrw\024rY\029rnY\020zrw\024ruY6\fLwuwr?\024ruYjr\024\024r6nYnH\fuun\024You\029Y\029\fnYy\024\f\001rY!\fnnz/?\024Y\002\002\002\002Yrwu\001w4n\024\021")
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
      else
        _Urwigo.MessageBox({
          Text = _t6zE("aruY\020zrw\024ruY6\fLwuwr?\024ruYjr\024\024r68Y\foMY\029rLY\029w5r?nrYE//?\029wu\f\024ruYn\024r\vru8Y\v\f4\024Yw\v?Y\v/MMru\0246wH\vYuwH\v\024Yor4r?nr\vru\021"),
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _t6zE(".\f4ruY\f66rY\fonY\029rLYvr\fLYnH\v/uYrwuruY\b6wH]Y\foMY\029\fnYIw\029r/Y\001rz/?MruDY\a\b%\025Iwr66rwH\v\024Ywn\024Y\015\fYrwur?Y\029\f4rw8Y\029r?YrnY\vwu4r]/LL\024\021"),
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _t6zE("Cu\029YzruuYuwH\v\0248Y\029\fuuYLornn\024Yw\v?Yz/\v6Y6rw\029r?Y\029ruY~\vrH]r?YrwuYzruw\001YWo\fr6ru\021\a\b%\025Iwr66rwH\v\024Y]/ruu\024Yw\v?Y\015\fY\020oLwu\029rn\024YrwuY\001\fu\020Y]6rwuYzruw\001Yz\fnYwLYIw\029r/Yr?]ruuru8Yn/Y\029\fnnYw\v?Yrwuw\001rYy\fH\vruYLw\024Y\001?/nnr?Y\031\f\v?nH\vrwu6wH\v]rw\024Y\fonnH\v6wrnnruY]/ruu\024\021"),
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _t6zE("N6\024r?u\f\024w5Y\029or?M\024Yw\v?YroH\vY\foH\vYrwuM\fH\vY\029wrYE//?\029wu\f\024ruY\029r?Yy\024\f\001rYTY\001r4ruY6\fnnru8Ywu\029rLYw\v?Y\029ruYQ%0~/\029rY\foMY\029r?Y%orH]nrw\024rY\029rnY\020zrw\024ruY6\fLwuwr?\024ruYjr\024\024r6nYnH\fuu\024You\029Y\029\fnYy\024\f\001rY!\fnnz/?\024Y\002\002\002\002Yrwu\001r4\024\021")
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
    end)
  elseif _1iAjs == 4713 then
    _Urwigo.MessageBox({
      Text = _t6zE("arwurYNoM\001\f4rYn/66\024rY]6\f?Ynrwu\\Y\a\b%\025aruY?wH\v\024w\001ruY~/\029rY4rwLY~?1c\024rpYrwun\024r66ru8Y\029\fYnwH\vYwLYluur?ruY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uY4rMwu\029ru\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE(".\fn\024Y\029oYnH\v/uY\f66rYawu\001rYLw\024YrwurLYCy\b0NunH\v6onnY\fuY\029wrYLw\024\001r4?\fH\v\024rY!/zr?4\fu]Y\fu\001rnH\v6/nnruY|ou\029Y\029wrY!/zr?4\fu]Y\foH\vY\fu\001rnH\v\f6\024r\024dD"),
            Media = _lZvk,
            Buttons = {
              _t6zE(" \f8Y\001rL\fH\v\024"),
              _t6zE("\004rwu8Yu/H\vYuwH\v\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE(".\f\024Y\029wH\vY\f4r?Y5r?Lo\0246wH\vY]rwuYy\024orH]Yzrw\024r?Y\001r4?\fH\v\024\021")
                    },
                    {
                      Text = _t6zE("9ru\fon/YzwrY\029r?Y\001\fu\020rY\fu\029r?rYyH\vuwH]nH\vu\fH]YwuY\029r?Ya/nr\021")
                    },
                    {
                      Text = _t6zE("ln\024Y\f66rnYuo?YN46ru]ou\001\021")
                    },
                    {
                      Text = _t6zE("aruYru\024nH\vrw\029ru\029ruY.wuzrwnY\foMY\029ruY?wH\v\024w\001ruY~/\029rY6wrMr?\024Y\029w?Y\f66rwuY\029r?Y6\fLwuwr?\024rYjr\024\024r6\021")
                    }
                  }, function(action)
                    _Urwigo.MessageBox({
                      Text = _t6zE("%rwH\v\024Y\029w?Y\029\fnYr?n\024YrwuL\f6Y\f6nY.w6MrD"),
                      Buttons = {
                        _t6zE(" \f8Y?rwH\v\024"),
                        _t6zE("\014r\v?Y.w6Mrq")
                      },
                      Callback = function(action)
                        if action ~= nil then
                          if action == "Button1" == true then
                            _Urwigo.MessageBox({
                              Text = _t6zE("(E8Y\029\fuuY]\fuun\024Y\029oY\015\fY\029wrY.w6MrYr?uro\024Y\foM?oMru8YzruuY\029oY\029/H\vYuwH\v\024Yzrw\024r?Y]/LLn\024\021")
                            })
                          else
                            _Urwigo.MessageBox({
                              Text = _t6zE("NoMY\029rLY6\fLwuwr?\024ruYjr\024\024r6Yn\024r\v\024YwLYE6\f?\024rp\0248Yz\fnY\029oY\020oLY(rMMuruY4ru/r\024w\001n\024q\a\b%\025 r\024\020\024Y\f66rnY]6\f?D"),
                              Buttons = {
                                _t6zE("]\fcwr?\024q"),
                                _t6zE("\v\fr\vD")
                              },
                              Callback = function(action)
                                if action ~= nil then
                                  if action == "Button1" == true then
                                  else
                                    _Urwigo.MessageBox({
                                      Text = _t6zE("a\fnY\031/?\0248Yzr6H\vrnY\029oY4rwLY~?1c\024rpYrwun\024r66ruYLonn\0248Yn\024r\v\024Y\foMY\029rLY6\fLwuwr?\024ruYjr\024\024r6\021\a\b%\025Cu\029YzwrYrnY\029r?YjoM\f66Yn/Yzw66Y|wn\024Yzw?]6wH\vYjoM\f66qdY\001w4\024YrnYuo?YrwuYrwu\020w\001rnY\031/?\024YwLY\001\fu\020ruYvrp\0248Yzr6H\vrnYL\fuY4rwLY~?1c\024rpYrwun\024r66ruY]\fuu\021\a\b%\025aoYzw?n\024YnH\v/uY?\fon4r]/LLru8Yzr6H\vrnY\029\fnYwn\024\021Y\a\b%\025\014r\v?Y.w6MrY\001w4\024YrnY\015r\024\020\024YuwH\v\024\021\a\b%\025Cu\029YzruuY\029oYrnYwLLr?Yu/H\vYuwH\v\024Y\vwu4r]/LLn\0248Y\029\fuuYn\024\f?\024rY\029wrY.w6MrYuroYou\029Y\001w4Y\fu8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuY5r??\f\024rYwH\vY\029w?Yzruw\001n\024runY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/u\021")
                                    })
                                  end
                                end
                              end
                            })
                          end
                        end
                      end
                    })
                  end)
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYL\fH\vY\029\fnY\029/H\vYr?n\024YrwuL\f68Y4r5/?Y\029oY\029wrY.w6MrYr?uro\024Y\foM?oMn\024q")
                  })
                end
              end
            end
          })
        end
      end
    })
  elseif _1iAjs == 3871 then
    _Urwigo.MessageBox({
      Text = _t6zE("\031ruuYLw\024Y\029wrnr?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Ywn\0248Yn/66\024rYnwrYrw\001ru\0246wH\vYn/YrwuM\fH\vYnrwu8Y\029\fnnY\029oY]rwurY.w6MrY4ru/r\024w\001ruY\029or?M\024rn\024\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("(\029r?Ynwu\029Y\029rwurYNo\001ruY\020oYnH\v6rH\v\024You\029Y\029oY\v\fn\024Y\029rwurY&rnr4?w66rY5r?\001rnnruD"),
            Buttons = {
              _t6zE("y/Ywn\024Yrnq"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\v\forY\029w?Y\029\fnYIw\029r/Y\029/H\vY\foMY</ovo4rY\fu8Yn/Mr?uY\029oY\001ruo\001YL/4w6rnYlu\024r?ur\024Y\v\fn\024\021\a\b%\025a/?\024Yzw?n\024Y\029oY\029wrYE//?\029wu\f\024ruY\029\fuuY\foMY\015r\029ruY\005\f66Yr?]ruuruY]/ruuru\021")
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\v\f4rYwH\vY6rw\029r?Y]rwurYl\029rr8Yz\f?oLY\029oY.w6MrY4ru/r\024w\001ruY]/ruu\024rn\024\021\a\b%\025y\024\f?\024rY\029wrY.w6MrY\029/H\vYrwuM\fH\vYu/H\vYL\f6YuroYou\029Y\001w4Y\fu8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021Ya\fuuY4r]/LLn\024Y\029oY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uYrwuM\fH\vYn/\021")
                  })
                end
              end
            end
          })
        end
      end
    })
  elseif _1iAjs == 9314 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("aruYjr\024\024r6YLw\024Y\029r?YNu6rw\024ou\001YMor?Y\029wrnrYy\024\f\024w/uY\v\fn\024Y\029oY\v/MMru\0246wH\vY\001rMou\029ruY|n/66\024rY/4ruY\foMY\029r?Ywuur?ruYEwn\024rY6wr\001rud\021")
      },
      {
        Text = _t6zE("Cu\029YM\f66nY\029oYu/H\vYuwH\v\024Ynr64r?Y\029?\foMY\001r]/LLruY4wn\024\\\a\b%\025\a\b%\025aoYLonn\024Y\vwr?Y\029wrYE\fLr?\fY\029rwurnYyL\f?\024c\v/urnY4ruo\024\020ru\021")
      },
      {
        Text = _t6zE("y/uuru6wH\v\024Yn\024/r?\024Y\vwr?\021Ya\f?oLYwn\024Y\029wrYwuur?rYEwn\024rY\foH\vYnH\vz\f?\020Y\fu\001rnc?or\v\024You\029Y\v\f\024Yuo?YrwuY]6rwurnY\005run\024r?8Yzr6H\vrnY\029oYLw\024Y\029rLY.\fu\0291Y5/66n\024\fru\029w\001Y\f4\029rH]ruY]\fuun\0248Yn/Y\029\fnnY]rwuY&wH\v\024YwunYluur?rY]/LL\024\021")
      },
      {
        Text = _t6zE("y/66\024rY\029wrY]6rwurY\001?orurYE/u\024?/666\fLcrY6roH\v\024ru8Y\f4r?Y\029rwurY.\fu\02910E\fLr?\fY\vw6M\024Y\029w?YuwH\v\024Yzrw\024r?8Y\029\fuuY6wr\001\024YrnY5r?Lo\0246wH\vY\fuY\029rwurLY.\fu\0291\021Y\005or?Yn/6H\vrY\005\fr66rY\v\f4rYwH\vYwuY\029r?Y\004\fr\vrY\029\fnY.\fu\02910arc/\024Y\fu\001r6r\001\024\021Y\a\b%\025N6n/YrwuM\fH\vY\029ruY\004o?0w!\v/urn0Q%0~/\029rYnH\fuuru8Y\foH\vYzruuY\029oY]rwuYw!/urYwuY\029ruY.\fru\029ruY\v\fr6n\024\021\a\b%\025a\fuuY4r]/LLn\024Y\029oY\029wrYE//?\029wu\f\024ruYMor?Y\029wrnrnYarc/\024YLw\024\001r\024rw6\024\021"),
        Media = _i3A
      },
      {
        Text = _t6zE("Cu\029YM\f66nY\029oYrnY\024?/\024\020\029rLYuwH\v\024YnH\v\fMMn\0248Y\fuYE//?\029wu\f\024ruY\020oY]/LLru8Y\029\fuuYLonn\024Y\029oY\029wrY.w6MrYuroYn\024\f?\024ruYou\029Y\fu\001r4ru8Y\029\fnnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuY4r]/LLn\024Y\029oY\024?/\024\020\029rLY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/u\021")
      }
    })
  elseif _1iAjs == 1771 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("aruY6\fLwuwr?\024ruYjr\024\024r6Y\foMY\029rLYarH]r6Y\029r?Y&/H]Z\fLc`&/H]0a/nrY\v\fn\024Y\029oY\015\fY/MMru4\f?Y\001rMou\029ru\021")
      },
      {
        Text = _t6zE("CLY\fuY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\001rY\020oY\001r6\fu\001ru8YLonn\024Y\029oY\f4r?YnH\v/uYrwuYzruw\001YwuY\029ruY.ou\029r]/\0244ro\024r6uYzor\v6ruY|\029wrYyH\vrwnnrY/\vurY\bro\024r6Yn/66\024rYMrn\024\001r]6r4\024Ynrwu8Y\029\fLw\024YLonn\024Y\029oYuwH\v\024nYL\fH\vrud\021")
      },
      {
        Text = _t6zE("awrYE//?\029wu\f\024ruYn\024r\vruYrwuM\fH\vY\fLY\b/\029ruY\029r?Ya/nrq"),
        Media = _yls
      },
      {
        Text = _t6zE("Cu\029Yn/66\024rY\029wrY4wn\vr?w\001rY.w6MrYuwH\v\024Y\fon?rwH\vru8Y\029\fuuYn\024\f?\024rY\029wrY.w6MrYu/H\vYL\f6YuroYou\029Y\001w4Y\fu8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuY4r]/LLn\024Y\029oY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/u\021")
      }
    })
  elseif _1iAjs == 8311 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("aruY6\fLwuwr?\024ruYjr\024\024r6YLw\024YNuzrwnou\0018Yz\fnY\vwr?Y\020oYL\fH\vruYwn\0248Y\v\fn\024Y\029oY\015\fY\001\fu\020Y/MMrunwH\v\0246wH\vY\001rMou\029ru\021\a\b%\025a\fuuYn/66\024rYrw\001ru\0246wH\vY\f66rnY]6\f?Ynrwu\021")
      },
      {
        Text = _t6zE("lLYy/uurunH\vrwuY]\fuuYL\fuYn/Y\001o\024YzwrYuwH\v\024nYr?]ruuru\021Y,nYn/66\024rYL/r\0016wH\vn\024Y\029ou]r6Ynrwu\021Ya\f\vr?Y\029wrY!6\fnL\f]o\001r6Y\fLY4rn\024ruYwLY\004wn\024]\fn\024ruYn\024r\vruY6\fnnru\021")
      },
      {
        Text = _t6zE("\005o?Y\029ruY\005\f668Y\029\fnnYrnY!?/46rLrYLw\024Y\029r?Y!/zr?4\fu]Y/\029r?Y\029rLYE\f4r6Y\001w4\0248Y6wr\001ruY\fonnr?\029rLYu/H\vYrwu\001rnH\vzrwnn\024rY\b\f\024\024r?wruYwLY\004wn\024]\fn\024ru\021\a\b%\025\031ruuY\029oYrnYnH\v\fMMn\0248Y\029wrY!\fH]ou\001Y\foM\020o?rwnnru8Y\029\fuuY]\fuun\024Y\029oYrnY\015\fYL\f6YLw\024Y\029ruY\b\f\024\024r?wruYc?/4wr?ru\021Y\a\b%\0259w4YLw?Y\029\fuuY\f4r?Y4w\024\024rYou4r\029wu\001\024Y\brnH\vrw\029\021"),
        Media = _4jj
      },
      {
        Text = _t6zE("\br5/?Y\029oY\029wrY!\fH]ou\001YLw\024Y\b\f\024\024r?wruY\foM?rwnn\0248Yor4r?c?orMrY\f4r?Y4w\024\024r8Y/4Y\029wrY!6\fnL\f]o\001r6Y5wr66rwH\v\024YrwuM\fH\vYuo?Y\f4\001rnH\v\f6\024r\024Ywn\024\021"),
        Media = _yls
      },
      {
        Text = _t6zE("(\029r?YnH\v\fMMn\024Y\029oYrnYuo?YuwH\v\0248Y\004r/uY5/uY\029ruY\fu\029r?ruY9\fnruY\020oYou\024r?nH\vrw\029ruD")
      },
      {
        Text = _t6zE("a\fuuY\vw6M\024Y5wr66rwH\v\024Y\029wrnrnY\bw6\029\021"),
        Media = _BpLAZ
      },
      {
        Text = _t6zE("Cu\029Yn/66\024rY\029wrY4wn\vr?w\001rY.w6MrYuwH\v\024Y\fon?rwH\vru8Y\029\fuuYn\024\f?\024rY\029wrY.w6MrYu/H\vYL\f6YuroYou\029Y\001w4Y\fu8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuY4r]/LLn\024Y\029oY\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/u\021")
      }
    })
  elseif _1iAjs == 999 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif _1iAjs == 4334 then
    _Urwigo.OldDialog({
      {
        Text = _t6zE("\br\fH\v\024rY\foMY\015r\029ruY\005\f66Y\029wrYNu6rw\024ou\001Y\foMY\029rLYarH]r6Y\029r?Y!6\fn\024w]\029/nr\021")
      },
      {
        Text = _t6zE("\005\f66nY\029oY\029wrY\031\fr?Lr4w6\029]\fLr?\fYuwH\v\024Y\fu\001rnH\v\f6\024r\024Y4r]/LLruY\v\f4ruYn/66\024rn\0248Y\029\fuuY\v\fn\024Y\029oY5wr66rwH\v\024Yuo?YuwH\v\024Y6\fu\001rY\001ruo\001Y\foMY\029ruY\014ruor0Eu/cMY\001r\029?orH]\024\021")
      },
      {
        Text = _t6zE("awrYE//?\029wu\f\024ruYzr?\029ruYzwrYwuYrwur?Y&,a0Nu\020rw\001rY\fu\001r\020rw\001\024\021\a\b%\025\004o?YLonnYL\fuYnwrYwuY\029wrnrLY\005\f66Yr?n\024YLw\024Y.w6MrY\029r?Y\031\fr?Lr4w6\029]\fLr?\fYnwH\v\0244\f?YL\fH\vru\021")
      },
      {
        Text = _t6zE(",5ru\024or66Y\v\fn\024Y\029oY\029wrY!6\f\024wurYLw\024\0246r?zrw6rYn/Y6\fu\001rYLw\024Yy\024?/LY5r?n/?\001\0248Y\029\fnnYnwH\vY\029wrY\031\fr?LrYn/Yzrw\024Y5r?\024rw6\024Y\v\f\0248Y\029\fnnYL\fuY\029wrYE//?\029wu\fu\024ruYuwH\v\024YLr\v?Y/?\029ru\0246wH\vYr?]ruuruY]\fuu\021")
      },
      {
        Text = _t6zE("luY\029rLY\005\f66Y\029wrY!/zr?4\fu]Y\f4nH\v\f6\024ruY/\029r?Y5/uY\029r?Y!6\f\024wurY\024?ruuruYou\029Yrwuw\001rYjrw\024Yz\f?\024ruY4wnYnwH\vY\029wrY!6\f\024wurYr\024z\fnY\f4\001r]or\v6\024Y\v\f\024\021\a\b%\025Cu\029Y\029\fuuYu/H\vYL\f6YuroYc?/4wr?ru\021")
      },
      {
        Text = _t6zE("\005\f66nY\029wrnrY.w6MrYuwH\v\024Y\fon\001r?rwH\v\024Y\v\f\0248Y\020o?Y\004/\024Y\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029r\021\a\b%\025a\fuuYzr?\029ruY\029w?Y\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uYrwuM\fH\vYn/Y5r??\f\024ru\021")
      },
      {
        Text = _t6zE("aoY]\fuun\024Yu\f\024or?6wH\vY\foH\vYrwuM\fH\vYL\f6Y]6wu\001r6u\021YIwr66rwH\v\024Y4wuYwH\vY\029\f\vrwLYou\029Y]\fuuYrwuruYcr?n/ru6wH\vruYyocc/?\024Y4rwY\029wrnr?Yy\024\f\024w/uY\fu4wr\024ru\021Y")
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024YuwH\v\024Y\029r?Y?wH\v\024w\001rY~/\029r\021\a\b%\025!?/4wr?rYrnYu/H\vYrwuL\f6\021\a\b%\025\a\b%\025N44?oH\vYLw\024Y{{{"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tYx)
          end)
        end
      end
    })
  end
end
function _rw5:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _t6zE("aoYn/66\024Y\029ruY\031l90y\024\f?\0240~/\029rYrwu\001r4ru8Yzr6H\vr?Y\fonYrwur?Y5wr?n\024r66w\001ruYj\f\v6Y4rn\024r\v\024q\a\b%\025\a\b%\025{{{Yrwu\001r4ru8YoLY\fonYrwur?Ya\for?nH\v6rwMrY\020oY\001r6\fu\001ru\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_rw5)
          end)
        end
      end
    })
    return
  end
  if input == 5555 then
    _pwE9 = true
    _S2k()
  elseif input == 9876 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024Y\029r?Y~/\029r8Y\029ruY\029oYrwu\001r4ruYLonn\0248YzruuY\029oY\029ruYQ%0~/\029rYwLYyH\v6ornnr6n\fMrY\001rnH\fuu\024Y\v\fn\024q\a\b%\025\a\b%\025lH\vY4?\foH\vrY\029ruY~/\029r8Y\029r?Y\029w?Y\029\fu\fH\vY\fu\001r\020rw\001\024Yzo?\029r\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_rw5)
          end)
        end
      end
    })
  elseif input == 999 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024YuwH\v\024Y\029r?Y?wH\v\024w\001rY~/\029r\021\a\b%\025lH\vY4?\foH\vrY\029ruY~/\029r8Y\029ruY\029oY4r]/LLruY\v\fn\024Y\f6nY\029oY\029ruYQ%0~/\029rYwLYyH\v6ornnr6n\fMrY\001rnH\fuu\024Y\v\fn\024\021\a\b%\025!?/4wr?rYrnYu/H\vYrwuL\f6\021\a\b%\025\a\b%\025N44?oH\vYLw\024Y{{{\a\b%\025|luY\029rLY\005\f66YLonn\024Y\029oY\029wrY~\f?\024?w\029\001rY\015r\029/H\vYuroYn\024\f?\024rud"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_rw5)
          end)
        end
      end
    })
  end
end
function _xEpVY:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _t6zE(",nYzw?\029YrwurYj\f\v6Y4ru/r\024w\001\024\021\a\b%\025\a\b%\025N44?oH\vYLw\024Y{{{\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_xEpVY)
          end)
        end
      end
    })
    return
  end
  if input == 12345 then
    _f19.Active = false
    _lmS = true
    _c8h:MoveTo(Player)
    _gsDE:MoveTo(Player)
    _A4jFc:MoveTo(Player)
    _XUJvy:MoveTo(Player)
  elseif input == 999 then
    _f19.Active = true
  else
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024YuwH\v\024Y\029r?Y?wH\v\024w\001rY~/\029r\021\a\b%\025\a\b%\025.\fn\024Y\029oY\029w?Y\029ruYN4]or?\020ou\001n0~/\029r8Y\029r?Y\029w?Y\fLY,u\029rY5/uYy\024\f\001rY\028YLw\024\001r\024rw6\024Yzo?\029r8YuwH\v\024Yu/\024wr?\024Y/\029r?Y\001rLr?]\024D\a\b%\025\a\b%\025luY\029rLY\005\f66Y46rw4\024Y\029w?Yuo?Y\029wrY\014/r\0016wH\v]rw\024YrwuY\f4\001rncrwH\vr?\024rnYycwr6Y\020oYuo\024\020ruY|zruuY\029oY4r?rH\v\024w\001\024Y\020oYrwur?YN]or?\020ou\001Y4wn\0248Yn/66\024rYrw\001ru\0246wH\vYrwurY\fo\024/L\f\024wnH\vrYN4ncrwH\vr?ou\001Yr?M/6\001\024YnrwudY/\029r?Y\029ruY\031\vr?w\001/Y\001\fu\020Y5/uY5/?urY\020oY4r\001wuuruY|\029\fMor?YLonn\024Y\029oY\029\fuuY\f4r?Y4rwLY\bw]rc/?\024Ynrwud\021\a\b%\025\a\b%\025\014w\024Y\029rLY~/\029rY{{{Y4?wH\vn\024Y\029oY\vwr?Y/\vurYN4]or?\020ou\001Y\f4\021"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_xEpVY)
          end)
        end
      end
    })
  end
end
function _9ubz:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 56 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _K3o:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 54 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _P4hX:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61246 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _qAHt:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49292 then
    _VZ6M = _VZ6M + 1
    Wherigo.Command("StopSound")
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
    Wherigo.Command("StopSound")
  end
end
function _SNV:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61081 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _K3NM:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 20429 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _zo7G:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 30286 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _ASzHo:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 55772 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _IAeCS:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 27798 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _kJp:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 9892 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _988H:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 65410 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function __m2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 57381 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _HP0o:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 64173 then
    _VZ6M = _VZ6M + 1
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\001r\v\024YuwH\v\024YLw\024Y?rH\v\024ruYawu\001ruY\020o\021\a\b%\025\031/\vr?Y\v\fn\024Y\029oY\029\fnY\001rzonn\024D"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _VZ6M == 10 then
                  _laKY()
                else
                  _lmva()
                end
              end
            end
          })
        end
      end
    })
  else
    _VZ6M = _VZ6M + -1
    _P55()
  end
end
function _hUxox:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 47282 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _35tMQ:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 56339 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _ItW:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 15510 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _Sexm:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 46068 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _r00Y:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 20113 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _GJfS:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 24911 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _Kmp:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 64779 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _0X7m:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 798 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _KdO:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 45513 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _3YB5:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 9335 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _bZL:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 3653 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _cx1V:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 47857 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _A8As:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 63684 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _MKggt:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 11231 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _YNW3c:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 32534 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _yNOh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 31738 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function __NEd4:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 7551 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _0j3G:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61116 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _yGq:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 53530 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _rpcWV:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 15510 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _i7qzc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 56 then
    _VZ6M = _VZ6M + 1
    _oa4zA()
  else
    _VZ6M = _VZ6M + -1
    _7Kg()
  end
end
function _Iz_mh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 55673 then
    _laKY()
  elseif _Urwigo.Hash(string.lower(input)) == 38131 then
    _laKY()
  elseif _Urwigo.Hash(string.lower(input)) == 53241 then
    _laKY()
  elseif _Urwigo.Hash(string.lower(input)) == 9790 then
    _laKY()
  end
end
function _B8X:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 50 then
    Wherigo.PlayAudio(_WrI)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_B8X)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 51 then
    Wherigo.PlayAudio(_raY)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_B8X)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 52 then
    Wherigo.PlayAudio(_9cY)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_B8X)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 49 then
    Wherigo.PlayAudio(_d9o7j)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_B8X)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 24777 then
    Wherigo.Command("StopSound")
  end
end
function _VTih8:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49 then
    _Urwigo.MessageBox({
      Text = "",
      Media = _DbYQ,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "",
            Media = _lwElQ,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "",
                  Media = _TVaPL,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = "",
                        Media = _W6E,
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "",
                              Media = _KUQ,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = "",
                                    Media = _Sa0,
                                    Callback = function(action)
                                      if action ~= nil then
                                        _Urwigo.RunDialogs(function()
                                          Wherigo.GetInput(_VTih8)
                                        end)
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
  elseif _Urwigo.Hash(string.lower(input)) == 50 then
    _Urwigo.MessageBox({
      Text = "",
      Media = _D7n3,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "",
            Media = _aweIq,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "",
                  Media = _uus,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = "",
                        Media = _RMAT,
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "",
                              Media = _R_6IB,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = "",
                                    Media = _24I2K,
                                    Callback = function(action)
                                      if action ~= nil then
                                        _Urwigo.MessageBox({
                                          Text = "",
                                          Media = _twj_,
                                          Callback = function(action)
                                            if action ~= nil then
                                              _Urwigo.MessageBox({
                                                Text = "",
                                                Media = _qbD,
                                                Callback = function(action)
                                                  if action ~= nil then
                                                    _Urwigo.MessageBox({
                                                      Text = "",
                                                      Media = _DFn,
                                                      Callback = function(action)
                                                        if action ~= nil then
                                                          _Urwigo.RunDialogs(function()
                                                            Wherigo.GetInput(_VTih8)
                                                          end)
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
                    end
                  end
                })
              end
            end
          })
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 51 then
    _Urwigo.MessageBox({
      Text = "",
      Media = _mcZLz,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "",
            Media = _b9ymR,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "",
                  Media = _ttw,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = "",
                        Media = _7CsHU,
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "",
                              Media = _vhR,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = "",
                                    Media = _ePX,
                                    Callback = function(action)
                                      if action ~= nil then
                                        _Urwigo.MessageBox({
                                          Text = "",
                                          Media = _qkgvp,
                                          Callback = function(action)
                                            if action ~= nil then
                                              _Urwigo.MessageBox({
                                                Text = "",
                                                Media = _MVRMt,
                                                Callback = function(action)
                                                  if action ~= nil then
                                                    _Urwigo.RunDialogs(function()
                                                      Wherigo.GetInput(_VTih8)
                                                    end)
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
              end
            end
          })
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 52 then
    _Urwigo.MessageBox({
      Text = "",
      Media = _vnz,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "",
            Media = _jFUk,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "",
                  Media = _OHy,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = "",
                        Media = _Cb3,
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "",
                              Media = _Oz5l2,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = "",
                                    Media = _RZB,
                                    Callback = function(action)
                                      if action ~= nil then
                                        _Urwigo.MessageBox({
                                          Text = "",
                                          Media = _zdZ,
                                          Callback = function(action)
                                            if action ~= nil then
                                              _Urwigo.MessageBox({
                                                Text = "",
                                                Media = __yG,
                                                Callback = function(action)
                                                  if action ~= nil then
                                                    _Urwigo.RunDialogs(function()
                                                      Wherigo.GetInput(_VTih8)
                                                    end)
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
              end
            end
          })
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 53 then
    _Urwigo.MessageBox({
      Text = "",
      Media = _CPgQ,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "",
            Media = _mq4,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "",
                  Media = _R_A,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = "",
                        Media = _wnj5,
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "",
                              Media = _yy9dV,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = "",
                                    Media = _r8L,
                                    Callback = function(action)
                                      if action ~= nil then
                                        _Urwigo.MessageBox({
                                          Text = "",
                                          Media = _ZcFCB,
                                          Callback = function(action)
                                            if action ~= nil then
                                              _Urwigo.MessageBox({
                                                Text = "",
                                                Media = _xZOj,
                                                Callback = function(action)
                                                  if action ~= nil then
                                                    _Urwigo.RunDialogs(function()
                                                      Wherigo.GetInput(_VTih8)
                                                    end)
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
              end
            end
          })
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 54 then
    _Urwigo.MessageBox({
      Text = "",
      Media = _IHw,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "",
            Media = _pVoE,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "",
                  Media = _xJvgg,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = "",
                        Media = _g53_w,
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "",
                              Media = _Zd6Wy,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = "",
                                    Media = _TZeE,
                                    Callback = function(action)
                                      if action ~= nil then
                                        _Urwigo.MessageBox({
                                          Text = "",
                                          Media = _zLnfy,
                                          Callback = function(action)
                                            if action ~= nil then
                                              _Urwigo.MessageBox({
                                                Text = "",
                                                Media = _xJW,
                                                Callback = function(action)
                                                  if action ~= nil then
                                                    _Urwigo.RunDialogs(function()
                                                      Wherigo.GetInput(_VTih8)
                                                    end)
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
              end
            end
          })
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 55 then
      _Urwigo.MessageBox({
        Text = "",
        Media = _sBn,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = _XrN,
              Callback = function(action)
                if action ~= nil then
                  _Urwigo.MessageBox({
                    Text = "",
                    Media = _m7b,
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.MessageBox({
                          Text = "",
                          Media = _DUZ_N,
                          Callback = function(action)
                            if action ~= nil then
                              _Urwigo.MessageBox({
                                Text = "",
                                Media = _7iWu,
                                Callback = function(action)
                                  if action ~= nil then
                                    _Urwigo.MessageBox({
                                      Text = "",
                                      Media = _FQzh,
                                      Callback = function(action)
                                        if action ~= nil then
                                          _Urwigo.MessageBox({
                                            Text = "",
                                            Media = _wXqu,
                                            Callback = function(action)
                                              if action ~= nil then
                                                _Urwigo.MessageBox({
                                                  Text = "",
                                                  Media = _AaWwS,
                                                  Callback = function(action)
                                                    if action ~= nil then
                                                      _Urwigo.RunDialogs(function()
                                                        Wherigo.GetInput(_VTih8)
                                                      end)
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
                end
              end
            })
          end
        end
      })
    else
    end
  end
end
function _CLpq:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49 then
    _Urwigo.MessageBox({
      Text = _t6zE("\brwY\029r?Ya/nrY5/uYKv\f\001M\f6\024r?M\fou\fY5/uY&\fu\001\001/runKY]/LLn\024Y\029oY\020zwnH\vruYy\024\f\001rY\028\028Y|!?rMwu\f6dYou\029Y\029rLY\005wu\f6Y\029wrnrnY\031\vr?w\001/nY5/?4rw\021\a\b%\025\a\b%\025awrYE//?\029wu\f\024ruY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021bV\002Y,Y;;xY\002;\021b\002XY")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 50 then
    _Urwigo.MessageBox({
      Text = _t6zE("\brwY\029r?Ya/nrY5/uYK,wuY./H\vY\foMY\029ruY9r/H\vrH]r?qKY]/LLn\024Y\029oY\0016rwH\vY\fLYNuM\fu\0018Yu/H\vY5/?Y\029r?Yy\024\f\001rYbY\029wrnrnY\031\vr?w\001/nY5/?4rw\021\a\b%\025\a\b%\025awrYE//?\029wu\f\024ruY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019bXY,Y;;xY\002;\021\028T\028Y")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 51 then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("y/n/qYaoYzw66n\024Y\f6n/Y\024\f\024n\frH\v6wH\v8Y\029\fnnYwH\vY\029w?YrwuM\fH\vYn/Y\029wrY\005wu\f6]//?\029wu\f\024ruY5/uY\0141n\024r?1nY\fu\029r?r?Y(zur?Y5r??\f\024r\021")
      },
      {
        Text = _t6zE(",\024\vwnH\v0L/?\f6wnH\vYwn\024Y\029\fnY\f4r?Yzw?]6wH\vYr\024z\fnY4r\029ru]6wH\v\021\021\021")
      },
      {
        Text = _t6zE("NH\vYyH\vrwnnY\029?\foMq")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_ivjL)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 52 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _ivjL:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\005wu\f6Y\029wrnrnY~\fH\vrnY6wr\001\024Y4rw\\\a\b%\025\a\b%\025\004YV;YbT\021;TXY,Y;;xY\002\019\021xXxY")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 50 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\005wu\f6Y\029wrnrnY~\fH\vrnY6wr\001\024Y4rw\\\a\b%\025\a\b%\025\004YV;Y\019V\021V;TY,Y;;xY\002\028\021;T\019Y")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 51 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\005wu\f6Y\029wrnrnY~\fH\vrnY6wr\001\024Y4rw\\\a\b%\025\a\b%\025\004YV;Y\019\002\021\019XxY,Y;;xY\019x\021{\028\028Y")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 52 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\005wu\f6Y\029wrnrnY~\fH\vrnY6wr\001\024Y4rw\\\a\b%\025\a\b%\025\004YV;Y\019V\021\028\002bY,Y;;xY\002b\021bTXY")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 53 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\005wu\f6Y\029wrnrnY~\fH\vrnY6wr\001\024Y4rw\\\a\b%\025\a\b%\025\004YV;Y\019\002\021;TVY,Y;;xY\002\019\021\002\028{Y")
    })
  elseif _Urwigo.Hash(string.lower(input)) == 54 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _A4jFc:OnClick()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_VTih8)
  end)
end
function _c8h:OnClick()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_B8X)
  end)
end
function _gsDE:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("\b?\foH\vn\024Y\029oY.w6MrD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button2" then
          Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
        else
          _Urwigo.MessageBox({
            Text = _t6zE("y/66Y\029wrYy\024\f\001r8Y4rwY\029r?Y\029oY\029wH\vY\029r?\020rw\024Y4rMwu\029rn\0248Y\fo\024/L\f\024wnH\vYr?Lw\024\024r6\024Yzr?\029ruY/\029r?Yzw66n\024Y\029oYnwrY6wr4r?Ynr64r?Yrwu\001r4ruD\a\b%\025\a\b%\025\031ruuY\029oY\029w?Y\f4n/6o\024YnwH\vr?YLw\024Y\029r?Yy\024\f\024w/uY4wn\0248Y\029\fuuYwn\024YL\fuor66Y\029wrY4rnnr?rY\031\f\v68Y\fun/un\024ruY6wr4r?YK\fo\024/L\f\024wnH\vKYz\fr\v6ru\021"),
            Buttons = {
              _t6zE("\fo\024/L\f\024wnH\v"),
              _t6zE("L\fuor66")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _L11()
                  _Urwigo.MessageBox({
                    Text = _t6zE("N66rnY]6\f?qYawrY~\f?\024?w\029\001rY]\fuuY|\v/MMru\0246wH\vdY\fo\024/L\f\024wnH\vYr?]ruuru8YLw\024Yzr6H\vr?Yy\024\f\001rY\029oY\001r?\f\029rY4rnH\v\frM\024w\001\024Y4wn\024You\029Y\029\fuuY\029wrYc\fnnru\029rY.w6MrY\fu4wr\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.MessageBox({
                          Text = (_t6zE("\005\f66nY\029oY\029wH\vYuwH\v\024Y5r?6\foMruY\v\fn\024Y/\029r?Y\029rwuY9!y0,LcM\fu\001Y\001r?\f\029rYnr\v?YnH\vr6H\v\024Ywn\0248Y\029\fuuY4wn\024Y\029oY\001r?\f\029rYLw\024Y\029r?Yy\024\f\001rY") .. _D8y) .. _t6zE("Y4rnH\v\frMM\024w\001\024\021"),
                          Callback = function(action)
                            if action ~= nil then
                              _GHBP0()
                              if _D8y == 0 then
                                _eaa()
                              elseif _D8y == 1 then
                                _1SAU()
                              elseif _D8y == 2 then
                                _tfget()
                              elseif _D8y == 3 then
                                _DFu()
                              elseif _D8y == 4 then
                                _NWQE()
                              elseif _D8y == 5 then
                                _jXhAe()
                              elseif _D8y == 6 then
                                _Mp7kf()
                              elseif _D8y == 7 then
                                _Lf5()
                              elseif _D8y == 8 then
                                _SmKi()
                              elseif _D8y == 9 then
                                _jmtb()
                              elseif _D8y == 10 then
                                _OrpTF()
                              elseif _D8y == 11 then
                                _nIF()
                              elseif _D8y == 12 then
                                _LaQ()
                              end
                            end
                          end
                        })
                      end
                    end
                  })
                else
                  _Urwigo.RunDialogs(function()
                    Wherigo.GetInput(__7I2)
                  end)
                end
              end
            end
          })
        end
      end
    end
  })
end
function _h68tb:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("luY\029wrnr?Ya\f\024ru4\fu]Y4rMwu\029ruYnwH\vY\029wrY\005wu\f6]//?\029wu\f\024ruYrwuw\001r?Y\fon\001rz\fr\v6\024r?Y\0141n\024r?1nYLw\024Y\v/\vr?Ya0\031r?\024ou\001\021\a\b%\025\brwY\029ruY4rw\029ruY5/uYLw?Y]/LL\024YL\fuYz\fr\v?ru\029Y\029rnY\031\vr?w\001/nY5/?4rw\021\a\b%\025awrY\029r?Y\fu\029r?ruY(zur?Ynwu\029YwLYCL]?rwnY5/uY\028;Y]L\021\a\b%\025\a\b%\025\031w66n\024Y\029oYzw?]6wH\vYrwuruY\b6wH]YwuY\029wrnrYa\f\024ru4\fu]Yzr?MruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_CLpq)
          end)
        else
          _Urwigo.MessageBox({
            Text = _t6zE("yr\v?Y6/r46wH\vq")
          })
        end
      end
    end
  })
end
function _OoGx:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rYbY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019\028{Y,Y;;xY\002;\021\028xx")
  })
end
function _bpEvC:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _EUW60})
end
function _EGZm7:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _ZKq2})
end
function _bLdu:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _NqU})
end
function _Q4B:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _BM2q})
end
function _Djcm9:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _PN5T})
end
function _0dWO:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _F51SL})
end
function _ihjX:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _AKgv})
end
function _WnrY:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _6pY})
end
function _QMmH7:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _1XvE})
end
function _0rCIO:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _9RGs})
end
function _fIfBj:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _h32})
end
function _pGCc:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _i3A})
end
function _sp5C:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rY\019Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019\019xY,Y;;xY\002;\021\019;V")
  })
end
function _3AD:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rY\002Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002;\028Y,Y;;xY\002;\021\019{V")
  })
end
function _N4XH:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rYVY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019XbY,Y;;xY\002;\021TbV")
  })
end
function _Qc3_W:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rYTY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\019{XY,Y;;xY\002;\021TVT")
  })
end
function _g0m:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rYXY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002;\019Y,Y;;xY\002;\021T\019;")
  })
end
function _LRb:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rYxY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002\002\019Y,Y;;xY\002;\021TTV")
  })
end
function _TcsF:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rY{Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021\002\019XY,Y;;xY\002;\021X\028\002")
  })
end
function _e5rb:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rY\028;Y6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021b{xY,Y;;xY\002;\021\002xb")
  })
end
function _TAc:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rY\028\028Y|!?rMwu\f6dY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021bXTY,Y;;xY\002;\021bx\019")
  })
end
function _dtm:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("awrYE//?\029wu\f\024ruYMor?Yy\024\f\001rY\028bY|\005wu\f6dY6\fo\024ru\\\a\b%\025\a\b%\025\004YV;Y\019;\021bT\019Y,Y;;xY\002;\021\028{V")
  })
end
function _JLDBy:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("ar?Y~/\029rY\020oLY(rMMuruY\029rnYv?rn/?nY6\fo\024r\024\\\a\b%\025\a\b%\025V;\019;bV;")
  })
end
function _QTCt:OnClick()
  _Urwigo.MessageBox({Text = "", Media = _gAP})
end
function _32J:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE(".wr?Y\001?\f4ruq"),
    Media = _xirpU
  })
end
function _XUJvy:OnClick()
  _Urwigo.MessageBox({
    Text = _t6zE("ar?Y~/\029rYMor?Y\029\fnYj\f\v6runH\v6/nnY\029r?Yy\024\f\001rY\0284Y6\fo\024r\024\\\a\b%\025\a\b%\025\002\019\019\002")
  })
end
function _2cX()
  _Urwigo.MessageBox({
    Text = _t6zE(" r\024\020\024Ywn\024YrnY\fuY\029r?Yjrw\0248Y\029ruY\031\vr?w\001/Y\029o?H\vnYyH\fuuruY\029rnYru\024nc?rH\vru\029ruYQ%0~/\029rnY\001\fu\020Y/MMw\020wr66Y\020oYn\024\f?\024ru\021"),
    Callback = function(action)
      if action ~= nil then
        if _okAj == true then
          _Urwigo.Dialog(false, {
            {
              Text = _t6zE("a\fY\029oY5/?\vwuYnH\v/uY\029ruY\014o6\024wY4rnoH\v\024Y\v\fn\024Yzo?\029rY\029w?Yu\fH\vY\029rLYyH\fuuruY\029rnYQ%0~/\029rnY4rwYy\024\f\001rYbxYNYur4ruY\029r?YE/L4wu\f\024w/uYMor?Y\029\fnY6r\024\020\024rYj\f\v6runH\v6/nnY\foH\vYu/H\vYrwuYzrw\024r?r?Y~/\029rY\fu\001r\020rw\001\024\021")
            },
            {
              Text = _t6zE("y/66\024rn\024Y\029oYuwH\v\024Y\foM\001rc\fnn\024Y\v\f4ru8YMwu\029rn\024Y\029oY\029wrnruY~/\029rY\foH\vYu/H\vY\foMY\029r?Yluurunrw\024rY\029r?YE6\fccrY\029rnY\005wu\f6n\021"),
              Media = _cXDxh
            },
            {
              Text = _t6zE("(rMMurY4w\024\024rY\0016rwH\vY\029ruYou\024r?n\024ruYyH\v6ornnr6n\fMrYLw\024Y\029r?Yj\f\v6ru]/L4wu\f\024w/uYTxXV8YnH\fuurY\029ruYQ%0~/\029rYou\029Y\001w4Y\029ruY5/?\vwuYr?z\fr\vu\024ruY~/\029rYrwu\021"),
              Media = _6Tn
            },
            {
              Text = _t6zE("a\fuuY4r]/LLn\024Y\029oY\029ruY\031l90y\024\f?\0240~/\029r8Yzr6H\vruY\029oY\0016rwH\vYwuY\029wrnr?Y~\f?\024?w\029\001rYrwu\001r4ruYLonn\024\021")
            },
            {
              Text = _t6zE("lH\vYzrwnn\021\021\021\a\b%\0259\fu\020YnH\v/ruY]/Lc6w\020wr?\024YLw\024Y\029wrnruY\001\fu\020ruY~/\029rn\021\a\b%\025N4r?Yuo?Yn/Y]\fuuYwH\vYnwH\vr?n\024r66ru8Y\029\fnnY\029ruY\031l9Yuo?Y4r?rH\v\024w\001\024rY!r?n/uruYncwr6ruYou\029YwH\vY\fonnr?\029rLYwuM/?Lwr?\024Yzr?\029r8Yn/4\f6\029Y\015rL\fu\029Yn\024\f?\024r\024\021")
            },
            {
              Text = _t6zE("aw?Yzr?\029ruY\vro\024rYor4?w\001runYu/H\vY\015r\029rY\014ru\001rY\fu\029r?r?YQ%0~/\029rnYor4r?Y\029ruY\031r\001Y6\foMru\021\a\b%\025awrY\f66r?Lrwn\024ruY\029\f5/uYzw?n\024Y\029oY\v/MMru\0246wH\vYuwH\v\024Y4ru/r\024w\001ru\021\a\b%\025\031ruuY\f66rnYcr?Mr]\024YMor?Y\029wH\vY6\froM\0248Y\029\fuuYzw?n\024Y\029oYn/\001\f?Yuo?Yu/H\vYrwuruYrwu\020w\001ruYQ%0~/\029rYnH\fuuruYLornnru\021")
            },
            {
              Text = _t6zE("awrYQ%0~/\029rnYLonn\024Y\029oYor4?w\001runYwLLr?YLw\024Yrwur?Yrp\024r?uruYNccYnH\fuuruYou\029YuwH\v\024Y\029w?r]\024YwLY\031l90!6\f1r?\021"),
              Media = _u2MPd
            },
            {
              Text = _t6zE("\brwY\029ruYLrwn\024ruY\029r?YQ%0~/\029rnY4r]/LLrYwH\vYor4?w\001runYrwurY\004\fH\v?wH\v\0248YzruuYnwrY\001rnH\fuu\024Yzr?\029ru\021\a\b%\025I/uY\029\f\vr?Y4w\024\024rYuo?YnH\fuuru8YzruuY\029wrnYu/\024zru\029w\001Ywn\024You\029YuwH\v\024YrwuM\fH\vYuo?YL\f6Yn/8YoLY\020oYnH\v\foru8Yz\fnY\029\fuuYc\fnnwr?\024\021")
            }
          }, function(action)
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_rw5)
            end)
          end)
        else
          _Urwigo.Dialog(false, {
            {
              Text = _t6zE("a\fY\029oY\029ruY\014o6\024wY4r?rw\024nY\fuYrwurLY\fu\029r?ruYv\f\001Y4rnoH\v\024Y\v\fn\0248Y\v\fn\024Y\029oY\029w?Y\v/MMru\0246wH\vY5/?Y\029rwurLY\vro\024w\001ruY\brnoH\vYrwuruYvr?LwuYMor?Y\029ruY\b/uonY?rnr?5wr?\024\021")
            },
            {
              Text = _t6zE("a\fuuYzo?\029rY\029w?YLw\024Y\029r?YNuLr6\029ou\001YwLYE\f6ru\029r?Y\foH\vYrwuYzwH\v\024w\001r?Y~/\029rYLw\024\001r\024rw6\024\021")
            },
            {
              Text = _t6zE("jo?Y,?wuur?ou\001Y\v\fn\024Y\029oY\029wrnruY~/\029rY\001rn\024r?uYrwuYzrw\024r?rnY\014\f6YLw\024\001r\024rw6\024Y4r]/LLru\021")
            },
            {
              Text = _t6zE("(rMMurY4w\024\024rY\0016rwH\vY\029ruYou\024r?n\024ruYyH\v6ornnr6n\fMrYLw\024Y\029r?Yj\f\v6ru]/L4wu\f\024w/uYTxXV8YnH\fuurY\029ruYQ%0~/\029rYou\029Y\001w4Y\029ruY5/?\vwuYr?z\fr\vu\024ruY~/\029rYrwu\021"),
              Media = _6Tn
            },
            {
              Text = _t6zE("a\fuuY4r]/LLn\024Y\029oY\029ruY\031l90y\024\f?\0240~/\029r8Yzr6H\vruY\029oY\0016rwH\vYwuY\029wrnr?Y~\f?\024?w\029\001rYrwu\001r4ruYLonn\024\021")
            },
            {
              Text = _t6zE("lH\vYzrwnn\021\021\021\a\b%\0259\fu\020YnH\v/ruY]/Lc6w\020wr?\024YLw\024Y\029wrnruY\001\fu\020ruY~/\029rn\021\a\b%\025N4r?Yuo?Yn/Y]\fuuYwH\vYnwH\vr?n\024r66ru8Y\029\fnnY\029ruY\031l9Yuo?Y4r?rH\v\024w\001\024rY!r?n/uruYncwr6ruYou\029YwH\vY\fonnr?\029rLYwuM/?Lwr?\024Yzr?\029r8Yn/4\f6\029Y\015rL\fu\029Yn\024\f?\024r\024\021")
            },
            {
              Text = _t6zE("aw?Yzr?\029ruY\vro\024rYor4?w\001runYu/H\vY\015r\029rY\014ru\001rY\fu\029r?r?YQ%0~/\029rnYor4r?Y\029ruY\031r\001Y6\foMru\021\a\b%\025awrY\f66r?Lrwn\024ruY\029\f5/uYzw?n\024Y\029oY\v/MMru\0246wH\vYuwH\v\024Y4ru/r\024w\001ru\021\a\b%\025\031ruuY\f66rnYcr?Mr]\024YMor?Y\029wH\vY6\froM\0248Y\029\fuuYzw?n\024Y\029oYn/\001\f?Yuo?Yu/H\vYrwuruYrwu\020w\001ruYQ%0~/\029rYnH\fuuruYLornnru\021")
            },
            {
              Text = _t6zE("awrYQ%0~/\029rnYLonn\024Y\029oYor4?w\001runYwLLr?YLw\024Yrwur?Yrp\024r?uruYNccYnH\fuuruYou\029YuwH\v\024Y\029w?r]\024YwLY\031l90!6\f1r?\021"),
              Media = _u2MPd
            },
            {
              Text = _t6zE("\brwY\029ruYLrwn\024ruY\029r?YQ%0~/\029rnY4r]/LLrYwH\vYor4?w\001runYrwurY\004\fH\v?wH\v\0248YzruuYnwrY\001rnH\fuu\024Yzr?\029ru\021\a\b%\025I/uY\029\f\vr?Y4w\024\024rYuo?YnH\fuuru8YzruuY\029wrnYu/\024zru\029w\001Ywn\024You\029YuwH\v\024YrwuM\fH\vYuo?YL\f6Yn/8YoLY\020oYnH\v\foru8Yz\fnY\029\fuuYc\fnnwr?\024\021")
            }
          }, function(action)
            if _IzX == true then
              _Urwigo.MessageBox({
                Text = _t6zE("awrYCr4r?z\fH\vou\001n]\fLr?\fYuwLL\024Yor4?w\001runY\024\f\024n\frH\v6wH\vY\foMYou\029YncrwH\vr?\024Y\029wrYa\f\024ruYrwurY\001rzwnnrYjrw\024\021\a\b%\025a\fnYwn\024Y6rw\029r?Yu/\024zru\029w\0018Y\029\fYrnY\vwr?YLr\v?M\fH\vY\020oYawr4n\024\fr\v6ruY]\fLY|uwH\v\024Y\029o?H\vY9r/H\fH\vr?d\021\a\b%\025awrYE\fLr?\fYwn\024Y|5r?Lo\0246wH\vdY\foMY\fo\024/L\f\024wnH\vrY\brzr\001ou\001n5r?M/6\001ou\001Yrwu\001rn\024r66\024\021YlH\vYnw\024\020rY\f6n/YuwH\v\024Yw?\001ru\029z/Y?oLYou\029Yn\024ror?rY\029wrYE\fLr?\fYnr64r?\021\a\b%\025awrY\001rncrwH\vr?\024ruYNoMu\f\vLruYnH\v\forYwH\vYLw?Y|\fonnr?Y4rwY4rn/u\029r?ruYI/?]/LLuwnnrudYu\f\024or?6wH\vYuwH\v\024Y\fu\021YaoY]\fuun\024Y\vwr?Y\f6n/Y\024?/\024\020YIw\029r/or4r?z\fH\vou\001Y\vrLLou\001n6/nYcrwu6wH\vrYy\fH\vruYL\fH\vru\021"),
                Media = _DYrd,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_rw5)
                    end)
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = _t6zE("awrYCr4r?z\fH\vou\001n]\fLr?\fYuwLL\024Yor4?w\001runY\024\f\024n\frH\v6wH\vY\foMYou\029YncrwH\vr?\024Y\029wrYa\f\024ruYrwurY\001rzwnnrYjrw\024\021\a\b%\025a\fnYwn\024Y6rw\029r?Yu/\024zru\029w\0018Y\029\fYrnY\vwr?YLr\v?M\fH\vY\020oYawr4n\024\fr\v6ruY]\fLY|uwH\v\024Y\029o?H\vY9r/H\fH\vr?d\021\a\b%\025awrYE\fLr?\fYwn\024Y|5r?Lo\0246wH\vdY\foMY\fo\024/L\f\024wnH\vrY\brzr\001ou\001n5r?M/6\001ou\001Yrwu\001rn\024r66\024\021YlH\vYnw\024\020rY\f6n/YuwH\v\024Yw?\001ru\029z/Y?oLYou\029Yn\024ror?rY\029wrYE\fLr?\fYnr64r?\021\a\b%\025awrY\001rncrwH\vr?\024ruYNoMu\f\vLruYnH\v\forYwH\vYLw?Y|\fonnr?Y4rwY4rn/u\029r?ruYI/?]/LLuwnnrudYu\f\024or?6wH\vYuwH\v\024Y\fu\021Yl\v?Y]/ruu\024Y\vwr?Y\f6n/Y\024?/\024\020YIw\029r/or4r?z\fH\vou\001Y\vrLLou\001n6/nYcrwu6wH\vrYy\fH\vruYL\fH\vru\021"),
                Media = _DYrd,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_rw5)
                    end)
                  end
                end
              })
            end
          end)
        end
      end
    end
  })
end
function _f4xED()
  _Urwigo.Dialog(false, {
    {
      Text = _t6zE("lH\vYcr?n/ru6wH\vYL\f\001YQow\020\020rY\024/\024\f6Y\001r?u\021\a\b%\025ErwurYN\vuou\0018Y/4Y\foH\vY\029oYrwuY\001?/nnr?Y\005\fuY4wn\024Y/\029r?YuwH\v\024\021\a\b%\025Iwr66rwH\v\024YL/rH\v\024rn\024Y\029oY\029wH\vY\foH\vY5wr6Y6wr4r?Yn/M/?\024Y\foMY\029wrYyoH\vrYu\fH\vY\029r?Yy\024\f\001rYbY\029wrnrnY\b/uonYL\fH\vru\021")
    },
    {
      Text = _t6zE("a\fuuY\v\fn\024Y\029oY6rw\029r?Y!rH\vY\001r\v\f4\024\021\a\b%\025NuY\029wrnrLYQow\020Y]/LLn\024Y\029oYu\frL6wH\vYuwH\v\024Y5/?4rw\021")
    },
    {
      Text = _t6zE("\brwY\029wrnrLYQow\020YLonn\024Y\029oY\028;Y!ou]\024rYr??rwH\vruY|Mor?Y\015r\029rY?wH\v\024w\001rYNu\024z/?\024Y\001w4\024YrnYrwuruY!ou]\024dYou\029Yr?n\024Y\029\fuuY4r]/LLn\024Y\029oY\029wrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY4rwYy\024\f\001rY\0284YLw\024\001r\024rw6\024\021")
    },
    {
      Text = _t6zE("&\fnnYounY\029/H\vYrwuM\fH\vYL\f6YLw\024Y\029rLYQow\020Y4r\001wuuru\021")
    }
  }, function(action)
    _NF2x2()
  end)
end
function _tfget()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _EUW60
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y&/H]Z\fLc`&/H]0a/nr\a\b%\0250YIw\029r/\001?onn]\f?\024r\a\b%\0250YCy\b0E\f4r6\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6"),
                      Media = _wSm
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _bpEvC:MoveTo(_t6v3)
                        _t6v3.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _L11()
  _f19.Active = false
  _f19.Active = true
  _t6v3.Active = true
  _xYF9R.Active = true
  _v570h.Active = true
  _yDPL.Active = true
  _ipL.Active = true
  _cZWP.Active = true
  _5lXaf.Active = true
  _59K.Active = true
  _gn0n.Active = true
  _CxSE.Active = true
  _ofe.Active = true
end
function _GHBP0()
  _f19.Active = false
  _t6v3.Active = false
  _xYF9R.Active = false
  _v570h.Active = false
  _yDPL.Active = false
  _ipL.Active = false
  _cZWP.Active = false
  _5lXaf.Active = false
  _59K.Active = false
  _gn0n.Active = false
  _CxSE.Active = false
  _ofe.Active = false
end
function _puh1Z()
end
function _wpeJ()
end
function _DFu()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _ZKq2
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y&/H]Z\fLc`&/H]0a/nr\a\b%\0250YIw\029r/\001?onn]\f?\024r\a\b%\0250YCy\b0E\f4r6\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6"),
                      Media = _qmMC
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuY\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _EGZm7:MoveTo(_xYF9R)
                        _xYF9R.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _eaa()
  _Urwigo.MessageBox({
    Text = _t6zE("y\024\f\001rY;Y4r\029ro\024r\0248Y\029\fnnYw?\001ru\029z\fnYLw\024Y\029r?Y\fo\024/L\f\024wnH\vruY,?Lw\024\024r6ou\001YuwH\v\024Y?wH\v\024w\001Y\001r]6\fcc\024Y\v\f\024\021\a\b%\025Ir?Lo\0246wH\vY4rMwu\029rn\024Y\029oY\029wH\vY\001r?\f\029rY\020oYzrw\024Yzr\001Y5/uY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY/\029r?Y\029rwuY9!y0,LcM\fu\001Yz\f?Y\020oYnH\v6rH\v\024\021\a\b%\025a\fYLonn\024Y\029oYz/\v6Y\029/H\vY\foMY\029wrYL\fuor66rY,wu\001\f4rY\029r?Yy\024\f\001rYoLn\024rw\001ru\021"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(__7I2)
        end)
      end
    end
  })
end
function _HbrUx()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029wrYy\024\f\001rY\0284Y\029rnY\b/uonY4r?rw\024nYru\024\029rH]\024D"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Y\v\fn\024Y\029oY\029\fnYj\f\v6runH\v6/nnY\001r/rMMur\024Y4r]/LLruD"),
            Buttons = {
              _t6zE(" \f"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE("luY\029rLY\005\fH\vY4rMwu\029ruYnwH\vY\020zrwY\b/pru\021YNoMY\029rLYarH]r6Y\029r?Y\vwu\024r?ruY!6\fn\024w]4/pY4rMwu\029r\024YnwH\vY\029wrYNu6rw\024ou\001YMor?Y\029wrnrYy\024\f\024w/uYou\029Y\foH\vY\029r?Yr4ruYr?z\fr\vu\024rYK~/\029rYMor?Y\031l9K\021Y\a\b%\025E\fuun\024Y\029oY\029wrnruYQ%0~/\029rYzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Yr?Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("awrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY6\fo\024r\024\\Y\a\b%\025\a\b%\025\002\019\019\002")
                    },
                    {
                      Text = _t6zE("\005\f66nY\029oY\029\fnYyH\v6/nnY\029\fLw\024YuwH\v\024Y\001r/rMMur\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029wrnrY\024/66rYy\024\f\024w/uYz/\v6Y6rw\029r?Yor4r?nc?wu\001ru\021\a\b%\025yH\fuurYwuY\029rLY\005\f66Y4w\024\024rY\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?Y!/zr?4\fu]\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("a\fuuYnH\v\foYu/H\vYL\f6Y\foMY\029wrnrnY\bw6\029\021\a\b%\025a\fLw\024Yzw?n\024Y\029oY\029\fnYz/\v6Y\v/MMru\0246wH\vY\vwu4r]/LLru\021"),
            Media = _FJO
          })
        end
      end
    end
  })
end
function _NWQE()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _NqU
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y&/H]Z\fLc`&/H]0a/nr\a\b%\0250YIw\029r/\001?onn]\f?\024r\a\b%\0250YCy\b0E\f4r6\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6"),
                      Media = _4nT3
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _bLdu:MoveTo(_v570h)
                        _v570h.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _jXhAe()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _BM2q
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y&/H]Z\fLc`&/H]0a/nr\a\b%\0250YIw\029r/\001?onn]\f?\024r\a\b%\0250YCy\b0E\f4r6\a\b%\0250YbY6\fLwuwr?\024rYjr\024\024r6"),
                      Media = _uQR
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Q4B:MoveTo(_yDPL)
                        _yDPL.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _Mp7kf()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _PN5T
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y&/H]Z\fLc`&/H]0a/nr\a\b%\0250Y~?1c\024rp\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6\a\b%\0250Y\015r\029rY\014ru\001rYjro\001n8Yrwuw\001rnY\029\f5/uYLw\024YCy\b0NunH\v6onn"),
                      Media = _1fJQ
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _bpEvC:MoveTo(_ipL)
                        _ipL.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _Lf5()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _F51SL
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y&/H]Z\fLc`&/H]0a/nr\a\b%\0250YIw\029r/\001?onn]\f?\024r\a\b%\0250YCy\b0E\f4r6\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6"),
                      Media = _EUZA5
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _0dWO:MoveTo(_cZWP)
                        _cZWP.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _SmKi()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _AKgv
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6\a\b%\0250Y\001?/nnr8YnH\vz\f?\020rYa/nrYLw\024YywH\v\024Mrun\024r?8YCy\b0NunH\v6onnYou\029Y!6\f\024wurYwLYluur?ru"),
                      Media = _HFl
                    },
                    {
                      Text = _t6zE("Cu\029YwuYrwuw\001r?Y,u\024Mr?uou\001Yu/H\vYrwuY.\fu\02910arc/\024YMor?Y~\fH\vr?YLw\024Y\029rLYM\f6nH\vruYyL\f?\024c\v/ur8YwuYzr6H\vruYrwuYc\f\f?Y.\fu\0291nY\020oLYNon6rw\vruY4r?rw\0246wr\001ruYn/66\024ru\021"),
                      Media = _9EK
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _ihjX:MoveTo(_5lXaf)
                        _5lXaf.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _jmtb()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY/4ruY\foMY\029rLYarH]r6Y\029r?Ywuur?ruYEwn\024rYrwuY6\fLwuwr?\024r?Yjr\024\024r6Y]6r4ru8Y\foMY\029rLYrwuYru\024nc?rH\vru\029r?YQ%0~/\029rY|~/\029rYMor?Y\031l9dY\020oYMwu\029ruYwn\024\021Y\a\b%\025E\fuun\024Y\029oY\029wrnruYQ%0~/\029rYzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Yr?Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("yH\v/uYzwr\029r?DYy/YrwuY\014wn\024qYN4r?Y\029wrnrnY\014\f6Y\v\f\024\024rY\029wrYy\024\f\001rYzruw\001n\024ruYuwH\v\024YrwuruY\031r?\024Y5/uY\002\019;Y,o?/\021\021\021")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _6pY
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y\001?/nnr8YLw\024Yv?\fuM/6wrY4r]6r4\024rY\b/pYou\029Y\029\f?ou\024r?\\\a\b%\0250Y&/H]Z\fLc`&/H]0a/nrYLw\024Y6\fLwuwr?\024ruYjr\024\024r6Y\foMY\029rLYarH]r6\a\b%\0250Y\029w5r?nrYyH\vrw?\v\foMruYwuY.ou\029r]/\0244ro\024r6u\a\b%\0250Y\029w5r?nrYyH\vrw?\v\foMruY/\vurY\bro\024r6"),
                      Media = _L9dS
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _WnrY:MoveTo(_59K)
                        _59K.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _OrpTF()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYnH\fuurY\015r\024\020\024Y4w\024\024rY\029ruYQ%0~/\029rYK~/\029rYMor?Y\031l9K8Y\029ruY\029oY4rwY\029wrnr?Yy\024\f\001rYMwu\029ruYn/66\024rn\024\021"),
                    Buttons = {
                      _t6zE("(E"),
                      _t6zE("\031r6H\vr?Y~/\029rD")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.RunDialogs(function()
                            Wherigo.GetInput(_tYx)
                          end)
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE(",w\001ru\0246wH\vYn/66\024rY\029wrnrYy\024\f\024w/uYrwuruY6\fLwuwr?\024ruYjr\024\024r6Y4rwu\v\f6\024ru8Y\foMY\029rLYou\024r?Y\fu\029r?rLY\029wrnr?YK~/\029rYMor?Y\031l9KY6rwH\v\024Y\020oYMwu\029ruYnrwuYn/66\024r\021\a\b%\025E\fuun\024Y\029oY\029wrnruY6\fLwuwr?\024ruYjr\024\024r6Yzw?]6wH\vYuwH\v\024YMwu\029ruD"),
                            Buttons = {
                              _t6zE("a/H\vY\001rMou\029ruq"),
                              _t6zE("ar?Ywn\024Yzr\001q")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.RunDialogs(function()
                                    Wherigo.GetInput(_tYx)
                                  end)
                                else
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuYwn\024Y\029wrnr?Yjr\024\024r6Yz/\v6Y6rw\029r?Y5r?nH\vzou\029ru8Yn/Mr?uY\029oY]rwurYv/L\f\024ruY\foMY\029ruYNo\001ruY\v\fn\024\021\a\b%\025\031ruuY\029oY\029wrYy\024\f\001rYuwH\v\024Y/\vurY.w6MrY\001r6/rn\024Y4r]/LLn\0248Y\029\fuuYLonn\024Y\029oY\029\fnY.w6Mr0~ru\024r?Yu/H\vYrwuL\f6Y\foM?oMruYou\029Y\029wrnrnY\014\f6Y\fu\001r4ru8Y\029\fnnYLw\024Y\029r?Yy\024\f\001rY/MMru4\f?Y\029/H\vYuwH\v\024Y\f66rnYwuY(?\029uou\001Ywn\024\021")
                                  })
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _1XvE
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y!6\fnL\f]o\001r6\a\b%\0250Yc\fnnru\029rnYCy\b0E\f4r6\a\b%\0250Ya/nrYLw\024YXYLw\024Y9\fnY\001rMor66\024ruY96\fn\fLco66ru\a\b%\0250Y\004/\024M\f664\f\024\024r?wru\a\b%\0250Y6\fLwuwr?\024r?Yjr\024\024r6"),
                      Media = _nMQ
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _QMmH7:MoveTo(_gn0n)
                        _gn0n.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _nIF()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("N6n/YzruuY\029oY\029\fnYyH\vw6\029Y\001rMou\029ruY\v\fn\0248Y\029\fuuYrwuM\fH\vY\029ruYQ%0~/\029rY\foMYnr64w\001ruYnH\fuuruqq"),
                    Callback = function(action)
                      if action ~= nil then
                        if _lmS == true then
                          _Urwigo.MessageBox({
                            Text = _t6zE("Cu\029YM\f66nY\029oY\029ruY.\foc\024H\fH\vrY\vro\024rY4rnoH\v\024Y\v\fn\0248Y\029\fuuY\001w4n\024Y\029oY\vwr?Y\015r\024\020\024Y\029ruY~/\029rYrwu8Y\029r?Y\029w?Yu\fH\vY\029rLYyH\fuuruY\029rnYy\024\f?\0240~/\029rnY|wLYyH\v6ornnr60y\fMrdY5/LY9r/H\fH\vrY!6\fur?YLw\024\001r\024rw6\024Yzo?\029rYou\029Y\029ruY\029oY\029w?You4r\029wu\001\024YLr?]ruYn/66\024rn\024\021\a\b%\025\a\b%\025Cu\029YM\f66nY\029oY\vwr?Y\vro\024rYLw\024YrwurLYrw\001ruruYvr?LwuY4rwLY\b/uonY\001rn\024\f?\024r\024Y4wn\0248Y\029\fuuY\001w4n\024Y\029oY\029ruYnr64ruY~/\029rYrwu8Y\029ruY\029oYnH\v/uY\fLYy\024\f?\024Yrwu\001r\001r4ruY\v\fn\024You\029Y\029ruY\029oY\020\021Y\b\021Y\foH\vYwuY\029r?Y,?wuur?ou\001nL\fw6Yu/H\vYrwuL\f6YLw\024\001r\024rw6\024Y4r]/LLruY\v\fn\024\021"),
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.OldDialog({
                                  {
                                    Text = _t6zE(",nY]/ruu\024rYu\f\024or?6wH\vY\foH\vYnrwu8Y\029\fnnY\029oY5wr66rwH\v\024Y]rwuYL/4w6rnYlu\024r?ur\024Y\v\fn\024Y|\029r?Y,LcM\fu\001Y\vwr?YwLY\031\f6\029Ywn\024Y\f4r?Yrw\001ru\0246wH\vYwuY\f66ruY\004r\024\020ruY\001o\024dY/\029r?Y\029r?Y9r/H\fH\vrY!6\fur?Y\029/zuYwn\024Y|\v\f\024\024rYwH\vYwuur?\v\f64Y5/uY\020zrwY \f\v?ruY\f4r?Yuo?YrwuYrwu\020w\001rY\014\f6d\021")
                                  },
                                  {
                                    Text = _t6zE("luY\029rLY\005\f66YrwuM\fH\vY\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\029wH\vY4rwY\029r?Y6r\024\020\024ruY\005?\f\001rYMor?YK\001rLo\001\001r6\024KYru\024nH\vrw\029ru8Y\foH\vYzruuY\029\fnYyH\vw6\029Yu/H\vY\029\fYwn\024\021\a\b%\025a\fuuY]/LLn\024Y\029oY\foH\vY/\vurYlu\024r?ur\024Y/\029r?Y\029ruY9r/H\fH\vrY!6\fur?Yzrw\024r?\021")
                                  }
                                })
                              end
                            end
                          })
                        elseif _okAj == false then
                          _Urwigo.MessageBox({
                            Text = _t6zE("Cu\029Y\029\fuuY\029ruY\0016rwH\vruY~/\029rYrwu\001r4ru8Y\029ruY\029oY\foH\vYnH\v/uY4rwLYQ%0~/\029rY\fLYy\024\f?\024Yrwu\001r\001r4ruY\v\fn\024You\029Y\029ruY\029oY\020\021Y\b\021YwuY\029r?Y,?wuur?ou\001nL\fw6Yu/H\vYL\f6YLw\024\001r\024rw6\024Y4r]/LLruY\v\fn\024\021"),
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.OldDialog({
                                  {
                                    Text = _t6zE(",nY]/ruu\024rYu\f\024or?6wH\vY\foH\vYnrwu8Y\029\fnnY\029oY5wr66rwH\v\024Y]rwuYL/4w6rnYlu\024r?ur\024Y\v\fn\024Y|\029r?Y,LcM\fu\001Y\vwr?YwLY\031\f6\029Ywn\024Y\f4r?Yrw\001ru\0246wH\vYwuY\f66ruY\004r\024\020ruY\001o\024dY/\029r?Y\029r?Y9r/H\fH\vrY!6\fur?Y\029/zuYwn\024Y|\v\f\024\024rYwH\vYwuur?\v\f64Y5/uY\020zrwY \f\v?ruY\f4r?Yuo?YrwuYrwu\020w\001rY\014\f6d\021")
                                  },
                                  {
                                    Text = _t6zE("luY\029rLY\005\f66YrwuM\fH\vY\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\029wH\vY4rwY\029r?Y6r\024\020\024ruY\005?\f\001rYMor?YK\001rLo\001\001r6\024KYru\024nH\vrw\029ru8Y\foH\vYzruuY\029\fnYyH\vw6\029Yu/H\vY\029\fYwn\024\021\a\b%\025a\fuuY]/LLn\024Y\029oY\foH\vY/\vurYlu\024r?ur\024Y/\029r?Y\029ruY9r/H\fH\vrY!6\fur?Yzrw\024r?\021")
                                  }
                                })
                              end
                            end
                          })
                        else
                          _Urwigo.MessageBox({
                            Text = _t6zE("Cu\029Y\029\fuuY\029ruY~/\029rYrwu\001r4ru8Y\029r?Y\029w?Yu\fH\vY\029rLYyH\fuuruY\029rnYQ%0~/\029rnY\fLYy\024\f?\024YLw\024\001r\024rw6\024Yzo?\029rYou\029Y\029ruY\029oY\029w?You4r\029wu\001\024YMor?Y\029wrnrYy\024\f\024w/uYu/\024wr?ruYn/66\024rn\024Y|\v\f\024\024rYwH\vYrp\024?\fY\029\f?\foMY\vwu\001rzwrnrud\021"),
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.OldDialog({
                                  {
                                    Text = _t6zE(",nY]/ruu\024rYu\f\024or?6wH\vY\foH\vYnrwu8Y\029\fnnY\029oY5wr66rwH\v\024Y]rwuYL/4w6rnYlu\024r?ur\024Y\v\fn\024Y|\029r?Y,LcM\fu\001Y\vwr?YwLY\031\f6\029Ywn\024Y\f4r?Yrw\001ru\0246wH\vYwuY\f66ruY\004r\024\020ruY\001o\024dY/\029r?Y\029r?Y9r/H\fH\vrY!6\fur?Y\029/zuYwn\024Y|\v\f\024\024rYwH\vYwuur?\v\f64Y5/uY\020zrwY \f\v?ruY\015r\029/H\vYuo?YrwuYrwu\020w\001rnY\014\f6d\021")
                                  },
                                  {
                                    Text = _t6zE("\005\f66nYrnYuo?Y\fLY9r/H\fH\vrY!6\fur?Y6wr\001\0248Y\029\fuuYrwuM\fH\vY\029wrY.w6MrYu/H\vYL\f6Yn\024\f?\024ruYou\029Y\029wH\vY4rwY\029r?Y6r\024\020\024ruY\005?\f\001rYMor?YK\001rLo\001\001r6\024KYru\024nH\vrw\029ru8Y\foH\vYzruuY\029\fnYyH\vw6\029Yu/H\vY\029\fYwn\024\021\a\b%\025a\fuuY]/LLn\024Y\029oY\foH\vY/\vurY\029ruY9r/H\fH\vrY!6\fur?Yzrw\024r?\021")
                                  },
                                  {
                                    Text = _t6zE("Cu\029YM\f66nYrnY\024\f\024n\frH\v6wH\vY\029\f?\fuY6wr\001\0248Y\029\fnnY\029oY]rwuYL/4w6rnYlu\024r?ur\024Y\v\fn\0248Y\029\fuuY|ou\029Y\foH\vYuo?Y\029\fuuqdY]\fuun\024Y\029oYLwH\vY\fu?oMruYou\029Y\v/MMru8Y\029\fnnYwH\vYjrw\024Y\v\f4rYou\029Y\029w?Y\029wrYE//?\029wu\f\024ruYMor?Y\029\fnY\005wu\f6Y5r??\f\024ruY]\fuu\\\a\b%\025\a\b%\025;\028Vb\019\002V\019xbb;")
                                  }
                                })
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _9RGs
                    },
                    {
                      Text = _t6zE("Cu\029Yn/Yn/66\024rY\029wrYy\024\f\024w/uY\fonY\029r?Y\004\fr\vrY\fonnr\vru\021"),
                      Media = _fcQRc
                    },
                    {
                      Text = _t6zE("yoH\vrY4w\024\024rY\foH\vY\029wrYouLw\024\024r64\f?rYCL\001r4ou\001Yu\fH\vY\029rLYyH\vw6\029Y\f4\021YIwr66rwH\v\024Y\v\f\024Y\029wrY\brMrn\024w\001ou\001Yuo?YuwH\v\024Y\001r\v\f6\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLYzrw\024r?ncwr6ruY]\fuun\0248Y\foH\vYzruuY\029oY\029\fnYyH\vw6\029YuwH\v\024YMwu\029rn\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _0rCIO:MoveTo(_CxSE)
                        _CxSE.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _LaQ()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029\fnY|r5ru\024or66Y6rr?rdYIr?n\024rH]Y4r?rw\024nY\001rMou\029ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwr\v\024YrnYn/Y\fon8Y\f6nYnrwYLw\024Y\029r?Yy\024\f\024w/uY\f66rnYwuY(?\029uou\001Y/\029r?Yzo?\029rYnwrY\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024D"),
            Buttons = {
              _t6zE("N66rnYwuY(?\029uou\001"),
              _t6zE("9rLo\001\001r6\024")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.OldDialog({
                    {
                      Text = _t6zE("\031ruuY\029oY\029\fnY\005wu\f6Y4r?rw\024nY\001rMou\029ruY\v\fn\024You\029Y\f66rnY\029\fLw\024YwuY(?\029uou\001Ywn\0248Y\029\fuuYM?\f\001rYwH\vYLwH\vYrH\v\0248Yz\f?oLY\029oY\029wrnrY.w6MrY\foM\001r?oMruY\v\fn\024\021")
                    },
                    {
                      Text = _t6zE("a\fnnY\vwr?Y\fuY\029wrnr?Yy\024r66rY\029wrY.w6MrY\001ruo\024\020\024Yzw?\0298Y\v\f4rYwH\vY4rwLY,?n\024r66ruY\029rnY~\fH\vrnYMor?Yn/Youz\f\v?nH\vrwu6wH\vY\001r\v\f6\024ru8Y\029\fnnYrnY\vwr?Y\foH\vY]rwuruYru\024nc?rH\vru\029ruYQ%0~/\029rY\020oLYyH\fuuruY\001w4\0248")
                    },
                    {
                      Text = _t6zE("\005\f66nY\029oYzw?]6wH\vY.w6MrY4ru/r\024w\001n\0248Y\029\fuuY]\fuuYwH\vYLw?Yrw\001ru\0246wH\vYuo?Y5/?n\024r66ru8Y\029\fnnY\029/H\vYuwH\v\024Y\f66rnYLw\024Y\029wrnr?Yy\024\f\024w/uYwuY(?\029uou\001Ywn\024\021")
                    },
                    {
                      Text = _t6zE("y\024\f?\024rY\029wrY.w6MrYwuY\029rLY\005\f66Yu/H\vYL\f6YuroYou\029Y]6wH]rY\029wrnrnY\014\f6Y\029\fuuYK\001rLo\001\001r6\024S4rnH\v\fr\029w\001\024KY\fu\021")
                    }
                  })
                else
                  _Urwigo.Dialog(false, {
                    {
                      Text = _t6zE("\014wn\024q")
                    },
                    {
                      Text = _t6zE(".wr?YrwuYyc/w6r?4w6\029Y\029wrnr?Yy\024\f\024w/u8Y\029\fLw\024Y\029oYnwH\vr?YnrwuY]\fuun\0248Y\029\fnnY\029oY\fuY\029r?Y?wH\v\024w\001ruYy\024r66rY4wn\024\021"),
                      Media = _h32
                    },
                    {
                      Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250Y%r\001ru0\004/\024M\f660&/\0014oH\v\a\b%\0250Y&/H]Z\fLc`&/H]0a/nrYLw\024YNuzrwnou\001ru\a\b%\0250Y&/\0014oH\v\a\b%\0250Y\b/pYLw\024Y.\fM\024u/\024w\020ruYou\029Yc\fnnru\029rLYy\024wM\024"),
                      Media = _DIRz
                    },
                    {
                      Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020\029rLY6/\001\001ruY]\fuun\0248Y4r]/LLn\024Y\029oY\0016rwH\vYrwuYzruw\001Y.w6Mr\021")
                    },
                    {
                      Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029r8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?YLw\024\001rMor\v?\024ruY!/zr?4\fu]YnH\fuuru\021")
                    },
                    {
                      Text = _t6zE("Cu\029Y\foH\vYzruuY\029oY\029\fnY4r?rw\024nY\fuYrwur?Y\029r?Y5/?\vr?w\001ruYy\024\f\024w/uruY\001rL\fH\v\024Y\v\fn\0248YL\fH\vrYrnY\015r\024\020\024Y\024?/\024\020\029rLYu/H\vYrwuYzrw\024r?rnY\014\f6\021")
                    },
                    {
                      Text = _t6zE("Cu\029YM\f66nY\029oY\029oLLr?zrwnrY\029\f?\foMY5r?\020wH\v\024r\024Y\v\f4ruYn/66\024rn\0248Y\029wrY4r?rw\024\001rn\024r66\024rY!/zr?4\fu]YLw\024\020our\vLru8Y\029\fuuY4r]/LLn\024Y\029oYrnY\v/MMru\0246wH\vY\vwu8Y\029wrnrnY\bw6\029Y\029rnY\004/\024M\f660Q%0~/\029rnY\020oYuo\024\020ru\021"),
                      Media = _4PvLc
                    },
                    {
                      Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
                    }
                  }, function(action)
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TIN_i)
                    end)
                  end)
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\bwn\024Y\029oY\029w?YnwH\vr?8Y\fuY\029ruY?wH\v\024w\001ruYE//?\029wu\f\024ruY\020oYnoH\vruD"),
            Buttons = {
              _t6zE(" \f8YnwH\vr?"),
              _t6zE("\004rwu8YounwH\vr?")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYncru\029wr?rYwH\vY\029w?Y\015r\024\020\024YL\f6YrwuYyc/w6r?4w6\029\021\a\b%\025awrnrnYzw?\029Y\029w?You\024r?YKaoYnwr\vn\024KY\fu\001\020rw\001\0248Yn/Mr?uY\029oYwuY\029r?Y\004\fr\vrY\029rnYIr?n\024rH]rnY4wn\024\021\a\b%\025\031w?\029Y\029w?Y\029/?\024YuwH\v\024nY\fu\001r\020rw\001\0248Y\029\fuuY4wn\024Y\029oYnr\v?Yzrw\024Yzr\001Y5/uY\029rLYIr?n\024rH]You\029Y5wr66rwH\v\024Y\029/H\vYuwH\v\024Y4rwY\029ruY?wH\v\024ruYE//?\029wu\f\024ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _fIfBj:MoveTo(_ofe)
                        _ofe.Active = true
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuY\001r4rYwH\vY\029w?Y\020o?YywH\vr?\vrw\024Y\029wrY\014/r\0016wH\v]rw\0248Y\029rwurYr?Lw\024\024r6\024ruYE//?\029wu\f\024ruY\020oYor4r?c?orMru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_TkrRc)
                        end)
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _8E9()
  _Urwigo.MessageBox({
    Text = _t6zE("a\fLw\024YwH\vY\029wH\vYuwH\v\024Youu/r\024w\001Y\020o\024rp\024r8Yn/u\029r?uYuo?YMor?Y\029wH\vY?r6r5\fu\024rYluM/?L\f\024w/uruY\fu\020rw\001r8YLonn\024Y\029oY\015r\024\020\024Yr?n\024YrwuL\f6YrwuYc\f\f?Y\005?\f\001ruY4r\fu\024z/?\024ru\021"),
    Callback = function(action)
      if action ~= nil then
        if _TjM5 == true then
          _Urwigo.MessageBox({
            Text = _t6zE("\brMwu\029ruYnwH\vY\001r?\f\029rY\fu\029r?rY~\fH\vr?Y4rwLY\bw]rc/?\024D"),
            Buttons = {
              _t6zE(" \f"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _OC6K = true
                  _Urwigo.MessageBox({
                    Text = _t6zE(".\fn\024Y\029oYnr64r?Y\029ruY\014o6\024wYKar?Y\bw]rc/?\024KY\029w?r]\024Y\vro\024rY4rnoH\v\024D"),
                    Buttons = {
                      _t6zE(" \f8Y\vro\024r"),
                      _t6zE("\004rwu")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _okAj = true
                          _Urwigo.MessageBox({
                            Text = _t6zE("ywu\029Y\029wrY\fu\029r?ruY~\fH\vr?YLw\024Y\029rLY\b/uonY/\029r?Y\fonnH\v6wrnn6wH\vYLw\024Y\029rLYN\0295ru\024o?rY&\f4Y5/?Y(?\024Y4rnH\v\frM\024w\001\024D"),
                            Buttons = {
                              _t6zE("\b/uon"),
                              _t6zE("N\0295ru\024o?rY&\f4")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.Dialog(false, {
                                    {
                                      Text = _t6zE("\014wn\024qY\a\b%\025\a\b%\025a\fnYwn\024YnH\v6rH\v\024rnYvwLwu\001You\029Yw\v?Yn\024\f?\024r\024Y/MMru4\f?Y\020oM\fr66w\001Y\020rw\0246wH\vYnr\v?Yru\001Y4rwn\fLLru\021")
                                    },
                                    {
                                      Text = _t6zE("\014\f6Ynr\vru8Y/4YLw?Y\029\fYuwH\v\024Y5wr66rwH\v\024Yw?\001ru\029z\fnYrwuM\fr66\0248YoLY\029wH\vYr\024z\fnY\foM\020o\v\f6\024ru8Y\029\fLw\024Y\029wrY\fu\029r?ruYrwuruY/?\029ru\0246wH\vruYI/?nc?ou\001Y4r]/LLru\021")
                                    }
                                  }, function(action)
                                    _2cX()
                                  end)
                                else
                                  _Urwigo.Dialog(false, {
                                    {
                                      Text = _t6zE("9o\024qY\a\b%\025a\fLw\024Yn/66\024ruYnwrY?r6\f\024w5YnH\vur66Y\029o?H\vYnrwuYou\029Y\029\fuuY5r?nH\vzwu\029ru\021")
                                    },
                                    {
                                      Text = _t6zE("aoY]\fuun\024YnwrY\foH\vY4w\024\024ru8YrwuYzruw\001Y\020oY5r?nH\vzwu\029ru8Y\029\fYnwrYuo?Y4rwY\029r?Yr?n\024ruYNoM\001\f4rY\029w?r]\024Y\fLY\bw]rc/?\024YnrwuYLornnru\021")
                                    }
                                  }, function(action)
                                    _2cX()
                                  end)
                                end
                              end
                            end
                          })
                        else
                          _okAj = false
                          _Urwigo.MessageBox({
                            Text = _t6zE("ywu\029Y\029wrY\fu\029r?ruY~\fH\vr?YLw\024Y\029rLY\031l9Y/\029r?Y\fonnH\v6wrnn6wH\vYLw\024Y\029rLYN\0295ru\024o?rY&\f4Y5/?Y(?\024Y4rnH\v\frM\024w\001\024D"),
                            Buttons = {
                              _t6zE("\014o6\024w"),
                              _t6zE("N\0295ru\024o?rY&\f4")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _Urwigo.Dialog(false, {
                                    {
                                      Text = _t6zE("\014wn\024q")
                                    },
                                    {
                                      Text = _t6zE("a\fuuY]/LL\024Yw\v?YroH\vY\015r\024\020\024Y6rw\029r?YrwuYzruw\001YwunY9r\vr\001r8YrnYnrwY\029ruu8Y\029wrY\fu\029r?ruY~\fH\vr?Ynwu\029Yn/Y\001o\024YzwrYMr?\024w\001Y|\f4r?Y\029\fuuYz/66ruYnwrY5wr66rwH\v\024Y\foH\vYu/H\vY\029ruYN\0295ru\024o?rY&\f4Yncwr6rud\021")
                                    },
                                    {
                                      Text = _t6zE("E\fuuYL\f6Y6rw\029r?YuwH\v\024Y\fru\029r?u\021")
                                    },
                                    {
                                      Text = _t6zE("\br5/?YwH\vY\029w?Y\0016rwH\vYu/H\vYrwuYc\f\f?Yzrw\024r?rY\005?\f\001ruYn\024r66r8YLonn\024Y\029oY]o?\020Y\029w?r]\024Y4rwY\bw]rc/?\024Yr\024z\fnYL\fH\vru\021\a\b%\025a\fu\fH\vY]\fuun\024Y\029oY\029\fuuYr?n\024YrwuL\f6Yzwr\029r?Yr\024z\fnYN4n\024\fu\029Y\v\f6\024ru\021")
                                    }
                                  }, function(action)
                                    _2cX()
                                  end)
                                else
                                  _Urwigo.Dialog(false, {
                                    {
                                      Text = _t6zE("9o\024qY\a\b%\025a\fLw\024Yn/66\024ruYnwrY?r6\f\024w5YnH\vur66Y\029o?H\vYnrwuYou\029Y\029\fuuY5r?nH\vzwu\029ru\021")
                                    },
                                    {
                                      Text = _t6zE("aoY]\fuun\024YnwrY\foH\vY4w\024\024ru8YrwuYzruw\001Y\020oY5r?nH\vzwu\029ru8Y\029\fYnwrYuo?Y4rwY\029r?Yr?n\024ruYNoM\001\f4rY\029w?r]\024Y\fLY\bw]rc/?\024YnrwuYLornnru\021")
                                    }
                                  }, function(action)
                                    _2cX()
                                  end)
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE(".\fn\024Y\029oYnr64r?Y\029ruY\014o6\024wYKar?Y\bw]rc/?\024KY\029w?r]\024Y\vro\024rY4rnoH\v\024D"),
                    Buttons = {
                      _t6zE(" \f8Y\vro\024r"),
                      _t6zE("\004rwu")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _okAj = true
                          _Urwigo.MessageBox({
                            Text = _t6zE("ywu\029Y5wr66rwH\v\024Y\001r?\f\029rY\fu\029r?rY~\fH\vr?8Y\029wrY\029ruY\031\vr?w\001/YL\fH\vru8YwLY\031\f6\029You\024r?zr\001nD\a\b%\025,?]ruuruY]\fuun\024Y\029oY\029\fnY\029\f?\fu8Y\029\fnnYuo?YrwurY!/zr?4\fu]Y5/?Y(?\024YnrwuYn/66\024r\021"),
                            Media = _A5hgN,
                            Buttons = {
                              _t6zE(" \f"),
                              _t6zE("\004rwu")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _7IL = true
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuY\029?orH]rY\029wH\vY\029wrYa\foLru8Y\029\fnnY\029oYuwH\v\024Y\020oYnH\vur66Y4wn\024You\029Y\foMY\029wrY\fu\029r?ruY~\fH\vr?Y\foM6\froMn\024\021\a\b%\025jo?YywH\vr?\vrw\024Y4r]/LL\024Y\029oY\0016rwH\vYu/H\vYrwurYrp\024?\fYnH\vzr?rYNoM\001\f4rY4r5/?Y\029oY?wH\v\024w\001Yn\024\f?\024ruY]\fuun\024\021"),
                                    Callback = function(action)
                                      if action ~= nil then
                                        _2cX()
                                      end
                                    end
                                  })
                                else
                                  _2cX()
                                end
                              end
                            end
                          })
                        else
                          _okAj = false
                          _Urwigo.MessageBox({
                            Text = _t6zE("ywu\029Y5wr66rwH\v\024Y\001r?\f\029rY~\fH\vr?8Y\029wrY\029ruY\014o6\024wYL\fH\vru8YwLY\031\f6\029You\024r?zr\001nD\a\b%\025,?]ruuruY]\fuun\024Y\029oY\029\fnY\029\f?\fu8Y\029\fnnY\029r?Y~\fu\0291Y9?\f44r?Y5/uYy\024\f\001rYbXYrwurYC\v?\020rw\024Y\fu\020rw\001ruYn/66\024r\021"),
                            Media = _y6W,
                            Buttons = {
                              _t6zE(" \f"),
                              _t6zE("\004rwu")
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" == true then
                                  _xpwp = true
                                  _Urwigo.MessageBox({
                                    Text = _t6zE("a\fuuY\v/MMrYwH\vYL\f68Y\029\fnnYw\v?YLw\024Y\029rLY\031l90vrw6Y\vwr?Y\029w?r]\024Y\fLY\bw]rc/?\024YMr?\024w\001Ynrw\0298Y4r5/?Y\029wrY\fu\029r?ruY~\fH\vr?Y\fonY\029rLY\031\f6\029Y\020o?orH]Ynwu\029"),
                                    Callback = function(action)
                                      if action ~= nil then
                                        _2cX()
                                      end
                                    end
                                  })
                                else
                                  _UZbQ()
                                end
                              end
                            end
                          })
                        end
                      end
                    end
                  })
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE("\005\f66nY\029oYu/H\vYn/Yzrw\024Y5/LY\bw]rc/?\024Yru\024Mr?u\024YnrwuYn/66\024rn\0248Y\029\fnnY\029oYuwH\v\024Yr?]ruuruY]\fuun\024Y/4Y\029/?\024Y\001r?\f\029rY\fu\029r?rY~\fH\vr?Ynwu\0298Y\029\fuuY\001r\vrY\015r\024\020\024Y4w\024\024rYu/H\vYrwuYzruw\001Y\029wH\v\024r?Y?\fu\021"),
            Callback = function(action)
              if action ~= nil then
                _wde()
              end
            end
          })
        end
      end
    end
  })
end
function _ReY()
  _Urwigo.MessageBox({
    Text = _t6zE("ycwr6n\024Y\029oYrw\001ru\0246wH\vY\001?ou\029n\fr\024\0206wH\vY\foH\vYN\0295ru\024o?rY&\f4nD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Y\v\fn\024Y\029oY\029\fnYN\0295ru\024o?rY&\f4YKVY!ou]\024r8YrwuM\fH\vYn/Y\001rnH\vru]\024KY\029w?r]\024Y\vwr?Y\fLY\bw]rc/?\024YnH\v/uY\001rncwr6\024D"),
            Media = _FZQdQ,
            Buttons = {
              _t6zE(" \f"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("(E8Y\029\fuuY\v\f\024YnwH\vY\029\fnYr?6r\029w\001\024\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _dV5()
                      end
                    end
                  })
                elseif action == "Button1" == false and _OC6K == false and _okAj == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("\031\f?Y\029w?Yru\024\001\fu\001ru8Y\029\fnnY\foMY\029r?Yluurunrw\024rY\029r?YE6\fccrY\029rnY\005wu\f6nY\029rnY\014o6\024wnYrwuYQ%0~/\029rYz\f?8Y\029r?Y\029w?r]\024Y\020oY\029wrnrLYN\0295ru\024o?rY&\f4Y6rw\024r\024rD\a\b%\025\a\b%\025N6n/YM\f66nY\029oYlu\024r?rnnrY\fuYVYnH\vur66ruY\020on\fr\024\0206wH\vruY!ou]\024ruY\v\fn\0248Y\029\fuuYncwr6Yw\vuY\029/H\vYu/H\vY?\fnH\v\021Y9r\v\024Yzw?]6wH\vYnH\vur66\021"),
                    Media = _Hyy3,
                    Callback = function(action)
                      if action ~= nil then
                        _dV5()
                      end
                    end
                  })
                elseif action == "Button1" == false and _OC6K == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fY6\fo\024Y\029rwur?YNu\001\f4ruY\001r?\f\029rYu/H\vY\fu\029r?rY~\fH\vr?Y5/?Y(?\024Ynwu\0298YrLcMr\v6rYwH\vY\029w?8Y\029wrnrnYN\0295ru\024o?rY&\f4Yr5ru\024or66Yr?n\024Yu\fH\vY\029rLY\031\vr?w\001/YnH\vur66Yu/H\vY\020oYncwr6ru\021YaoY]/LLn\024Y\fLY,u\029rY\029rnY\031\vr?w\001/nY\foMY\015r\029ruY\005\f66Yu/H\vYL\f6Y\vwr?Y5/?4rw\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _dV5()
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fuuYL\fH\vrYwH\vY\029wH\vY\vwr?Lw\024Y\foMY\029wrnrnYN\0295ru\024o?rY&\f4You\029Y\029wrY\029\fLw\024Y5r?4ou\029ru\029rY\014/r\0016wH\v]rw\0248YVY!ou]\024rYWo\fnwY\001rnH\vru]\024Y\020oY4r]/LLru8Y\foMLr?]n\fL\021Y\a\b%\0259r\v\024Y\foH\vYzw?]6wH\vY\001\fu\020YnH\vur66\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _dV5()
                      end
                    end
                  })
                end
              end
            end
          })
        else
          _dV5()
        end
      end
    end
  })
end
function _wde()
  _Urwigo.MessageBox({
    Text = _t6zE("\brMwu\029ruYnwH\vY\001r?\f\029rY\fu\029r?rY~\fH\vr?Y4rwLY\bw]rc/?\024D"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _OC6K = true
          _Urwigo.MessageBox({
            Text = _t6zE(".\fn\024Y\029oYnr64r?Y\029ruY\014o6\024wYKar?Y\bw]rc/?\024KY\029w?r]\024Y\vro\024rY4rnoH\v\024D"),
            Buttons = {
              _t6zE(" \f8Y\vro\024r"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _okAj = true
                  _Urwigo.MessageBox({
                    Text = _t6zE("ywu\029Y\029wrY\fu\029r?ruY~\fH\vr?YLw\024Y\029rLY\b/uonY/\029r?Y\fonnH\v6wrnn6wH\vYLw\024Y\029rLYN\0295ru\024o?rY&\f4Y5/?Y(?\024Y4rnH\v\frM\024w\001\024D"),
                    Buttons = {
                      _t6zE("\b/uon"),
                      _t6zE("N\0295ru\024o?rY&\f4")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.Dialog(false, {
                            {
                              Text = _t6zE("\014wn\024qY\a\b%\025\a\b%\025a\fnYwn\024YnH\v6rH\v\024rnYvwLwu\001You\029Yw\v?Yn\024\f?\024r\024Y/MMru4\f?Y\020oM\fr66w\001Y\020rw\0246wH\vYnr\v?Yru\001Y4rwn\fLLru\021")
                            },
                            {
                              Text = _t6zE("\014\f6Ynr\vru8Y/4YLw?Y\029\fYuwH\v\024Y5wr66rwH\v\024Yw?\001ru\029z\fnYrwuM\fr66\0248YoLY\029wH\vYr\024z\fnY\foM\020o\v\f6\024ru8Y\029\fLw\024Y\029wrY\fu\029r?ruYrwuruY/?\029ru\0246wH\vruYI/?nc?ou\001Y4r]/LLru\021")
                            },
                            {
                              Text = _t6zE("\br5/?YwH\vY\029w?Y\015r\024\020\024Yu/H\vYrwuYc\f\f?Yzrw\024r?rY\005?\f\001ruYn\024r66r8YLonn\024Y\029oY\029ruY\031\vr?w\001/Y\f4r?Yru\0296wH\vY\foH\vY\001\fu\020Y/MMw\020wr66Y4r\001wuuru\021")
                            }
                          }, function(action)
                            _2cX()
                          end)
                        else
                          _Urwigo.Dialog(false, {
                            {
                              Text = _t6zE("9o\024qY\a\b%\025a\fLw\024Yn/66\024ruYnwrY?r6\f\024w5YnH\vur66Y\029o?H\vYnrwuYou\029Y\029\fuuY5r?nH\vzwu\029ru\021")
                            },
                            {
                              Text = _t6zE("\br5/?YwH\vY\029w?Y\015r\024\020\024Yu/H\vYrwuYc\f\f?Yzrw\024r?rY\005?\f\001ruYn\024r66r8YLonn\024Y\029oY\029ruY\031\vr?w\001/Y\f4r?Yru\0296wH\vY\foH\vY\001\fu\020Y/MMw\020wr66Y4r\001wuuru\021")
                            }
                          }, function(action)
                            _2cX()
                          end)
                        end
                      end
                    end
                  })
                else
                  _okAj = false
                  _Urwigo.MessageBox({
                    Text = _t6zE("ywu\029Y\029wrY\fu\029r?ruY~\fH\vr?YLw\024Y\029rLY\014o6\024wY/\029r?Y\fonnH\v6wrnn6wH\vYLw\024Y\029rLYN\0295ru\024o?rY&\f4Y5/?Y(?\024Y4rnH\v\frM\024w\001\024D"),
                    Buttons = {
                      _t6zE("\014o6\024w"),
                      _t6zE("N\0295ru\024o?rY&\f4")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _Urwigo.Dialog(false, {
                            {
                              Text = _t6zE("\014wn\024q")
                            },
                            {
                              Text = _t6zE("a\fuuY]/LL\024Yw\v?YroH\vY\015r\024\020\024Y6rw\029r?YrwuYzruw\001YwunY9r\vr\001r8YrnYnrwY\029ruu8Y\029wrY\fu\029r?ruY~\fH\vr?Ynwu\029Yn/Y\001o\024YzwrYMr?\024w\001Y|\f4r?Y\029\fuuYz/66ruYnwrY5wr66rwH\v\024Y\foH\vYu/H\vY\029ruYN\0295ru\024o?rY&\f4Yncwr6rud\021")
                            },
                            {
                              Text = _t6zE("E\fuuYL\f6Y6rw\029r?YuwH\v\024Y\fru\029r?u\021")
                            },
                            {
                              Text = _t6zE("\br5/?YwH\vY\029w?Y\015r\024\020\024Yu/H\vYrwuYc\f\f?Yzrw\024r?rY\005?\f\001ruYn\024r66r8YLonn\024Y\029oY\029ruY\031\vr?w\001/Y\f4r?Yru\0296wH\vY\foH\vY\001\fu\020Y/MMw\020wr66Y4r\001wuuru\021")
                            },
                            {
                              Text = _t6zE("a\fMor?YLonn\024Y\029oY]o?\020Y\029w?r]\024Y4rwLY\bw]rc/?\024Yr\024z\fnYL\fH\vru\021\a\b%\025a\fu\fH\vY]\fuun\024Y\029oY\029\fuuYzwr\029r?Yr\024z\fnYN4n\024\fu\029Y\v\f6\024ru8")
                            }
                          }, function(action)
                            _2cX()
                          end)
                        else
                          _Urwigo.Dialog(false, {
                            {
                              Text = _t6zE("9o\024qY\a\b%\025a\fLw\024Yn/66\024ruYnwrY?r6\f\024w5YnH\vur66Y\029o?H\vYnrwuYou\029Y\029\fuuY5r?nH\vzwu\029ru\021")
                            },
                            {
                              Text = _t6zE("\br5/?YwH\vY\029w?Y\015r\024\020\024Yu/H\vYrwuYc\f\f?Yzrw\024r?rY\005?\f\001ruYn\024r66r8YLonn\024Y\029oY\029ruY\031\vr?w\001/Y\f4r?Yru\0296wH\vY\foH\vY\001\fu\020Y/MMw\020wr66Y4r\001wuuru\021")
                            },
                            {
                              Text = _t6zE("a\fMor?YLonn\024Y\029oY]o?\020Y\029w?r]\024Y4rwLY\bw]rc/?\024Yr\024z\fnYL\fH\vru\021\a\b%\025a\fu\fH\vY]\fuun\024Y\029oY\029\fuuYzwr\029r?Yr\024z\fnYN4n\024\fu\029Y\v\f6\024ru8")
                            }
                          }, function(action)
                            _2cX()
                          end)
                        end
                      end
                    end
                  })
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _t6zE(".\fn\024Y\029oYnr64r?Y\029ruY\014o6\024wYKar?Y\bw]rc/?\024KY\029w?r]\024Y\vro\024rY4rnoH\v\024D"),
            Buttons = {
              _t6zE(" \f8Y\vro\024r"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _okAj = true
                  _Urwigo.MessageBox({
                    Text = _t6zE("ywu\029Y5wr66rwH\v\024Y\001r?\f\029rY\fu\029r?rY~\fH\vr?8Y\029wrY\029ruY\031\vr?w\001/YL\fH\vru8YwLY\031\f6\029You\024r?zr\001nD\a\b%\025,?]ruuruY]\fuun\024Y\029oY\029\fnY\029\f?\fu8Y\029\fnnYuo?YrwurY!/zr?4\fu]Y5/?Y(?\024YnrwuYn/66\024r\021"),
                    Media = _A5hgN,
                    Buttons = {
                      _t6zE(" \f"),
                      _t6zE("\004rwu")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _7IL = true
                          _Urwigo.MessageBox({
                            Text = _t6zE("a\fuuY\029?orH]rY\029wH\vY\029wrYa\foLru8Y\029\fnnY\029oYuwH\v\024Y\020oYnH\vur66Y4wn\024You\029Y\foMY\029wrY\fu\029r?ruY~\fH\vr?Y\foM6\froMn\024\021\a\b%\025jo?YywH\vr?\vrw\024Y4r]/LL\024Y\029oY\0016rwH\vYu/H\vYrwurYrp\024?\fYnH\vzr?rYNoM\001\f4rY4r5/?Y\029oY?wH\v\024w\001Yn\024\f?\024ruY]\fuun\024\021"),
                            Callback = function(action)
                              if action ~= nil then
                                _2cX()
                              end
                            end
                          })
                        else
                          _2cX()
                        end
                      end
                    end
                  })
                else
                  _okAj = false
                  _Urwigo.MessageBox({
                    Text = _t6zE("ywu\029Y5wr66rwH\v\024Y\001r?\f\029rY~\fH\vr?8Y\029wrY\029ruY\014o6\024wYL\fH\vru8YwLY\031\f6\029You\024r?zr\001nD\a\b%\025,?]ruuruY]\fuun\024Y\029oY\029\fnY\029\f?\fu8Y\029\fnnY\029r?Y~\fu\0291Y9?\f44r?Y5/uYy\024\f\001rYbXYrwurYC\v?\020rw\024Y\fu\020rw\001ruYn/66\024r\021"),
                    Media = _y6W,
                    Buttons = {
                      _t6zE(" \f"),
                      _t6zE("\004rwu")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button1" == true then
                          _xpwp = true
                          _Urwigo.MessageBox({
                            Text = _t6zE("ycwr6\024Y\f4r?Yrw\001ru\0246wH\vYr\vY]rwurY%/66r8Y\029\fYw\v?YroH\vYuwH\v\024Yr?un\024\v\fM\024YwunY9r\vr\001rY]/LLruYn/66\024r\024\021"),
                            Callback = function(action)
                              if action ~= nil then
                                _2cX()
                              end
                            end
                          })
                        else
                          _UZbQ()
                        end
                      end
                    end
                  })
                end
              end
            end
          })
        end
      end
    end
  })
end
function _dV5()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oYEwu\029r?Y\029\f4rwD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("a\fuuYL\fH\vrYwH\vY\029wH\vY\vwr?Lw\024Y6wr4r?YnH\v/uYrwuL\f6Y\029\f?\foMY\foMLr?]n\fL8Y\029\fnnY\029wrYy\024\f\001rYTYuwH\v\024Yn/Y\001\fu\020Y\015o\001ru\029M?rwYwn\024\021\a\b%\025a\fYn/66\024rn\024Y\029oY\029ruYlu\v\f6\024Y\029r?Ya/nrY6wr4r?Yr?n\024Ynr64r?Y4r\001o\024\fH\v\024ruY4r5/?Y\029r?Y\004\fH\vzoH\vnYu\fH\vY\029rwurLY,?LrnnruYr5ru\024or66Y\029/H\vY\foH\vYnr64r?Y?\fuY\029\f?M\021"),
            Callback = function(action)
              if action ~= nil then
                _ApQ()
              end
            end
          })
        else
          _ApQ()
        end
      end
    end
  })
end
function _ApQ()
  if _okAj == true then
    _Urwigo.MessageBox({
      Text = _t6zE("\005\f66nY\029oYv\bnY/\029r?Y~/wunY\029\f4rwY\v\fn\0248Y\029wrY\029oY\001r?urY6/nzr?\029ruYL/rH\v\024rn\0248Y\029\fuuY6r\001rY\029wrnrY\029/H\vY4w\024\024rY4rwLY\bw]rc/?\024Y\f4\021\a\b%\025lLY\005wu\f6Y\029rnY\b/uonYwn\024Y\029\fMor?Yu\frL6wH\vY]rwuY!6\f\024\020Y5/?\001rnr\vru\021"),
      Media = _OA8tZ,
      Callback = function(action)
        if action ~= nil then
          _3G02()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _t6zE(".\fn\024Y\029oYv\bnY/\029r?Y~/wunY\029\f4rw8Y\029wrY\029oY\001r?urY6/nzr?\029ruYL/rH\vn\024rn\024Y/\029r?Yzw66n\024Y\029oYzr6H\vrYLw\024ur\vLruY/\029r?Y\020oLwu\029rn\024Y\029wnH/5r?uD"),
      Buttons = {
        _t6zE(" \f"),
        _t6zE("\004rwu")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" == true then
            _Urwigo.MessageBox({
              Text = _t6zE("a\fuuYL\fH\vrY\029\fnY4w\024\024rY\vwr?Y4rwLY\bw]rc/?\024\021\a\b%\025a\fnYru\024nc?rH\vru\029rY\005\fH\vYwn\024YuwH\v\024Y5r?nH\v6/nnruYou\029YM?rwY\020o\001\fru\0016wH\v\021\a\b%\025lLY\005wu\f6Y\029rnY\b/uonYwn\024Y\vwu\001r\001ruY]rwuY!6\f\024\020YMor?Y%rwnru\029rY5/?\001rnr\vru\021"),
              Media = _OA8tZ,
              Callback = function(action)
                if action ~= nil then
                  _3G02()
                end
              end
            })
          else
            _3G02()
          end
        end
      end
    })
  end
end
function _3G02()
  _Urwigo.MessageBox({
    Text = _t6zE("Nu\029r?nY\f6nY4rwLY\014o6\024w8Ynwu\029Y\vwr?Y4rwLY\b/uonY\029wrYLrwn\024ruYy\024\f\024w/uruYr\024z\fnYrLcMwu\0296wH\v8Yz\fnY%r\001ruY\fu4r6\fu\001\024\021\a\b%\025\a\b%\025E/ruu\024rYrnYr5ru\024or66YwuY\029ruYu\frH\vn\024ruYc\f\f?Yy\024ou\029ruY?r\001uruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          if _OC6K == true and _okAj == true then
            if _IzX == true then
              _Urwigo.MessageBox({
                Text = _t6zE("a\fuuYuwLLY4w\024\024rYou4r\029wu\001\024YrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uY\029oY]rwuruYrw\001ruruY\029\f4rwY\v\fn\024\021"),
                Media = _05f,
                Callback = function(action)
                  if action ~= nil then
                    _mdpv()
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = _t6zE("a\fuuYur\vL\024Y4w\024\024rYou4r\029wu\001\024YLwu\029rn\024runYrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uYw\v?Y]rwuruYrw\001ruruY\029\f4rwY\v\fn\024\021\a\b%\025,wuw\001\024YroH\vY\f4r?Yw?\001ru\029zwrYLw\024Y\029rLY\fu\029r?ruYvr\fL8Yzr6H\vrnY\foH\vY\001r?\f\029rY\029ruY\b/uonYL\fH\v\024You\029Yu\f\024or?6wH\vY\foH\vYrwuruY%r\001runH\vo\024\020Y4ru/r\024w\001\024\021"),
                Media = _05f,
                Callback = function(action)
                  if action ~= nil then
                    _mdpv()
                  end
                end
              })
            end
          elseif _OC6K == true and _okAj == false then
            if _IzX == true then
              _Urwigo.MessageBox({
                Text = _t6zE("a\fuuYuwLLY4w\024\024rYou4r\029wu\001\024YrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uY\029oY]rwuruYrw\001ruruY\029\f4rwY\v\fn\024\021"),
                Media = _05f,
                Callback = function(action)
                  if action ~= nil then
                    _mdpv()
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = _t6zE("a\fuuYur\vL\024Y4w\024\024rYou4r\029wu\001\024YLwu\029rn\024runYrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uYw\v?Y]rwuruYrw\001ruruY\029\f4rwY\v\f4\024\021\a\b%\025\005?\f\001\024Y\f4r?Y\029\fnY\fu\029r?rYvr\fL8Yzr6H\vrnYu/H\vYLw\024Y\029rLY\014o6\024wY4rnH\v\frM\024w\001\024Ywn\0248Y/4YrnY\029\fu\fH\vY\foH\vYu/H\vY\029ruY\b/uonYL\fH\vruYzw66You\029Yrwuw\001\024YroH\v8Yzr?YzwrY5wr6rY%r\001runH\vw?LrYLw\024uwLL\024\021"),
                Media = _05f,
                Callback = function(action)
                  if action ~= nil then
                    _mdpv()
                  end
                end
              })
            end
          elseif _xpwp == true or _7IL == true then
            if _IzX == true then
              _Urwigo.MessageBox({
                Text = _t6zE("a\fuuYuwLLY4w\024\024rYou4r\029wu\001\024YrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uY\029oY]rwuruYrw\001ruruY\029\f4rwY\v\fn\024\021\a\b%\025lH\vY\v/MMr8Y\029\fnnYvr\fL8Yzr6H\vrnY\001r?\f\029rYwLY\031\f6\029You\024r?zr\001nYwn\0248Y\v\f\024Y\029w?YrwuruYor4?w\001Y\001r6\fnnru\021"),
                Callback = function(action)
                  if action ~= nil then
                    _mdpv()
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = _t6zE("a\fuuYur\vL\024Y4w\024\024rYou4r\029wu\001\024YLwu\029rn\024runYrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uYw\v?Y]rwuruYrw\001ruruY\029\f4rwY\v\f4\024\021\a\b%\025lH\vY\v/MMr8Y\029\fnnYvr\fL8Yzr6H\vrnY\001r?\f\029rYwLY\031\f6\029You\024r?zr\001nYwn\0248Y\v\f\024YroH\vYLwu\029rn\024runYrwuruYor4?w\001Y\001r6\fnnru\021"),
                Callback = function(action)
                  if action ~= nil then
                    _mdpv()
                  end
                end
              })
            end
          elseif _IzX == true then
            _Urwigo.MessageBox({
              Text = _t6zE("a\fuuYuwLLY4w\024\024rYou4r\029wu\001\024YrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uY\029oY]rwuruYrw\001ruruY\029\f4rwY\v\fn\024\021"),
              Callback = function(action)
                if action ~= nil then
                  _mdpv()
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = _t6zE("a\fuuYur\vL\024Y4w\024\024rYou4r\029wu\001\024YLwu\029rn\024runYrwuruY\029r?Y4r?rw\024\001rn\024r66\024ruY%r\001runH\vw?LrYLw\0248Yn/Mr?uYw\v?Y]rwuruYrw\001ruruY\029\f4rwY\v\f4\024\021"),
              Callback = function(action)
                if action ~= nil then
                  _mdpv()
                end
              end
            })
          end
        else
          _Urwigo.MessageBox({
            Text = _t6zE("a\fuuY\v/MMrYwH\vYL\f68Y\029\fnnY\029rwurY,wunH\v\fr\024\020ou\001Y]/??r]\024Ywn\024You\029Y\024\f\024n\frH\v6wH\vY]rwuY%r\001runH\vw?LY4ru/r\024w\001ruYzw?\0298YoLY\029wrYrLcMwu\0296wH\vr?ruYy\024\f\024w/uruY\020oYnH\vor\024\020ru\021"),
            Callback = function(action)
              if action ~= nil then
                _mdpv()
              end
            end
          })
        end
      end
    end
  })
end
function _mdpv()
  local _Urwigo_Date = os.date("*t")
  if _okAj == true then
    if _Urwigo_Date.month <= 3 or _Urwigo_Date.month >= 11 then
      _Urwigo.MessageBox({
        Text = _t6zE(".\fn\024Y\029oYr5ru\024or66Ylu\024r?rnnrY\fuYrwurLY.rwnn\001r\024?\fru]D"),
        Buttons = {
          _t6zE(" \f"),
          _t6zE("\004rwu")
        },
        Callback = function(action)
          if action ~= nil then
            if action == "Button1" == true then
              _Urwigo.MessageBox({
                Text = _t6zE("a\fYzw?YounY\029r?\020rw\024YwuY\029r?Y]\f6\024ruY \f\v?rn\020rw\024Y4rMwu\029ru8Yn\024r\v\024Y\029wrYE\fcnr6L\fnH\vwurY5r?Lo\0246wH\vYuwH\v\024Y4r?rw\024\021\a\b%\025y/66\024rYwH\vY\029\f\vrwLYnrwuYou\029YuwH\v\024Y5r?\vwu\029r?\0248Yzrw6YwH\vY\001r?\f\029rYnH\v6\fMrY/\029r?YwuY\029r?Y\b\f\029rz\fuurY6wr\001r8Y]\fuuYwH\vYnwrY\029w?Y\f4r?Y\001r?urY4r?rw\024n\024r66ru\021\a\b%\025a\fMor?YrwuM\fH\vY\029ruYru\024nc?rH\vru\029ruYQ%0~/\029rYnH\fuuru\021"),
                Media = _tB35,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _t6zE("\005\f66nY\029oY\015r\024\020\024Yu/H\vY]rwuY.rwnn\001r\024?\fru]YL/rH\v\024rn\0248Y\f4r?Y5r?Lo\0246wH\vYu\fH\vY\brru\029w\001ou\001Y\029rnY\031\vr?w\001/n8Y\029\fuuYn/66\024rn\024Y\029oY\024?/\024\020\029rLYnH\v/uYL\f6Y\015r\024\020\024Y\029ruYru\024nc?rH\vru\029ruYQ%0~/\029rYnH\fuuru\021\a\b%\025a\fnYr?\v/r\v\024Y\029wrY\031\f\v?nH\vrwu6wH\v]rw\0248Y\029\fnnY\029oY\029\fuuY\foH\vYzw?]6wH\vYrwuY.rwnn\001r\024?\fru]Y4r]/LLruY]\fuun\024\021"),
                      Callback = function(action)
                        if action ~= nil then
                          _44HFG()
                        end
                      end
                    })
                  end
                end
              })
            else
              _44HFG()
            end
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _t6zE(".\fn\024Y\029oYr5ru\024or66Ylu\024r?rnnrY\fuYrwurLY.rwnn\001r\024?\fru]D"),
        Buttons = {
          _t6zE(" \f"),
          _t6zE("\004rwu")
        },
        Callback = function(action)
          if action ~= nil then
            if action == "Button1" == true then
              _Urwigo.MessageBox({
                Text = _t6zE("a\fYzw?YounY\029r?\020rw\024YwuY\029r?Yz\f?LruY \f\v?rn\020rw\024Y4rMwu\029ru8Yn\024r\v\024Y\029wrYE\fcnr6L\fnH\vwurY5r?Lo\0246wH\vY4r?rw\024You\029Y\029oY]\fuun\024Y\029wH\vYrwuM\fH\vY4r\029wruru\021"),
                Media = _dlSCf,
                Callback = function(action)
                  if action ~= nil then
                    _44HFG()
                  end
                end
              })
            else
              _44HFG()
            end
          end
        end
      })
    end
  elseif _okAj == false then
    _Urwigo.MessageBox({
      Text = _t6zE(".\fn\024Y\029oYr5ru\024or66Ylu\024r?rnnrY\fuYz\f?LruY/\029r?Y\vrwnnruY9r\024?\fru]ruD"),
      Media = _Lrm,
      Buttons = {
        _t6zE(" \f"),
        _t6zE("\004rwu")
      },
      Callback = function(action)
        if action ~= nil then
          local _Urwigo_Date = os.date("*t")
          if action == "Button1" == true then
            if _Urwigo_Date.month <= 3 or _Urwigo_Date.month >= 11 then
              _Urwigo.MessageBox({
                Text = _t6zE("a\fYzw?YounY\029r?\020rw\024YwuY\029r?Y]\f6\024ruY \f\v?rn\020rw\024Y4rMwu\029ru8Yn\024r\v\024Y\029wrYE\fcnr6L\fnH\vwurY5r?Lo\0246wH\vYuwH\v\024Y4r?rw\024\021\a\b%\025y/66\024rYwH\vY\029\f\vrwLYnrwuYou\029YuwH\v\024Y5r?\vwu\029r?\0248Yzrw6YwH\vY\001r?\f\029rYnH\v6\fMrY/\029r?YwuY\029r?Y\b\f\029rz\fuurY6wr\001r8Y]\fuuYwH\vYnwrY\029w?Y\f4r?Y\001r?urY4r?rw\024n\024r66ru\021\a\b%\025a\fMor?YrwuM\fH\vY\029ruYru\024nc?rH\vru\029ruYQ%0~/\029rYnH\fuuru\021"),
                Media = _tB35,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _t6zE("\005\f66nY\029oYL/Lru\024\fuYu/H\vY]rwuY.rwnn\001r\024?\fru]YL/rH\v\024rn\0248Y\f4r?Y5r?Lo\0246wH\vYu\fH\vY\brru\029w\001ou\001Y\029rnY\031\vr?w\001/n8Y\029\fuuYn/66\024rn\024Y\029oY\024?/\024\020\029rLYnH\v/uYL\f6Y\015r\024\020\024Y\029ruYru\024nc?rH\vru\029ruYQ%0~/\029rYnH\fuuru\021\a\b%\025a\fnYr?\v/r\v\024Y\029wrY\031\f\v?nH\vrwu6wH\v]rw\0248Y\029\fnnY\029oY\029\fuuY\foH\vYzw?]6wH\vYrwuY.rwnn\001r\024?\fru]Y4r]/LLruY]\fuun\024\021"),
                      Callback = function(action)
                        if action ~= nil then
                          _44HFG()
                        end
                      end
                    })
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = _t6zE("NoH\vYzruuY\029oY\vro\024rYuo?YMor?Y\029ruY\b/uonY5/?4rwY\001r]/LLruY4wn\024You\029Y\029ruY\014o6\024wY4r?rw\024nY\fuYrwurLY\fu\029r?ruYv\f\001Y4rnoH\v\024Y\v\fn\0248Y]\fuun\024Y\029oY\029wH\vYu\f\024or?6wH\vY\024?/\024\020\029rLY\001r?urY4rwY\029ruY]/n\024ru6/nruYy/M\024\029?wu]nY/\029r?Y\029ruY.rwnn\001r\024?\fru]ruY4r\029wruru\021"),
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _t6zE("a\fYzw?YounY\029r?\020rw\024YwuY\029r?Yz\f?LruY \f\v?rn\020rw\024Y4rMwu\029ru8Yn\024r\v\024Y\029wrYE\fcnr6L\fnH\vwurY5r?Lo\0246wH\vY4r?rw\024You\029Y]\fuuYrwuM\fH\vY4ruo\024\020\024Yzr?\029ruY|ou\029YzruuYuwH\v\0248Y\029\fuuY\029ruYc\fnnru\029ruYQ%0~/\029rYnH\fuurud\021\a\b%\025\brwLYEor\v6nH\v?\fu]Y\001w6\024\\Y\031r?Y\020or?n\024Y]/LL\0248YL\f\v6\024Y\020or?n\024\021\a\b%\025aruY]\fuun\024Y\029oY\f6n/Y\foH\vYuo\024\020ru8Yn/Mr?uYu/H\vY!6\f\024\020Y5/?\v\fu\029ruYwn\024\021"),
                      Media = _dlSCf,
                      Callback = function(action)
                        if action ~= nil then
                          _44HFG()
                        end
                      end
                    })
                  end
                end
              })
            end
          else
            _44HFG()
          end
        end
      end
    })
  end
end
function _44HFG()
  _Urwigo.MessageBox({
    Text = _t6zE(",wuYc\f\f?Y\031/?\024rY\020oLYv\vrL\fYycru\029ruY\001rM\fr66w\001D"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.Dialog(false, {
            {
              Text = _t6zE("96rwH\vY5/?zr\001\\Y\004wrL\fu\029YLonnYrwuYnH\v6rH\v\024rnY9rzwnnruY\v\f4ru8YzruuYr?Y4rwYrwurLY~\fH\vrY|5/uYLw?Y/\029r?Y\015rL\fu\029Y\fu\029r?rudYuwH\v\024nYncru\029r\024\021\a\b%\025a\fnYwn\024Y5/66]/LLruYwuY(?\029uou\001\021\a\b%\025\004wrL\fu\029Y\020zwu\001\024YrwuruY(zur?8Y9r6\029YMor?Y\029wrY9rn\024\f6\024ou\001YrwurnY~\fH\vrnY\fon\020o\001r4ru\021")
            },
            {
              Text = _t6zE("v?/\024\020\029rLY4wuYwH\vYnr\v?YM?/\v8Y\029\fnnYwH\vY4rwLY\bw]rc/?\024YrwurYycru\029ru\029/nrY\foM\001rn\024r66\024Y\v\f4rYou\029Y\foH\vY\024\f\024n\frH\v6wH\vYnr\v?Y\001?/nn\020or\001w\001Y\001rncru\029r\024Yzw?\029\021")
            },
            {
              Text = _t6zE("(\vurY\029wrnrYycru\029ruY\v\fr\024\024rYrnY5wr6rYIr?4rnnr?ou\001Y\fuY\029rLY\014o6\024wYz/\v6Yr\vr?YuwH\v\024Y\001r\001r4ru\021\a\b%\025lun4rn/u\029r?rY\foMY\029wrYy/M\024\029?wu]nYou\029Y.rwnn\001r\024?\fru]rY\v\fr\024\024ruY\029wrY\brnoH\vr?Y\029rnY\bw]rc/?\024nYz/\v6Y5r?\020wH\v\024ruYLornnruYou\029YLw\024YnH\vu/r\029rLY\014wur?\f6z\fnnr?Y5/?6wr4Yur\vLruYLornnru8Yz\fnYwH\vYLw?Yz/\v6Y\foH\vY/\vurYycru\029rurwu\f\vLruY\foH\vYzrw\024r?\vwuY\v\fr\024\024rY6rwn\024ruY]/ruuru\021")
            },
            {
              Text = _t6zE("\brwY\029ruY9r\024?\fru]ruY]\fuun\024Y\029oY\029wH\vYor4?w\001runY\foH\vY\001r?urY4r\029wruru8YzruuY\029oYuwH\v\024nYncru\029rn\024\021Y\a\b%\025a\fnYuo?Yn/Yur4ru4rwq"),
              Media = _Lrm
            },
            {
              Text = _t6zE("Cu\029Y\foH\vY\029wrnruY\b/uonY\v\fr\024\024rYrnY/\vurY\029wrYorccw\001YM6wrnnru\029ruYycru\029rurwu\f\vLruYz/\v6Y]\foLY\001r\001r4ru\021\a\b%\025NoMY\029wrYl\029rr8YrwuruY\b/uonY\020oY6r\001ru8Y4wuYwH\vYu\frL6wH\vYr?n\024Y\001r]/LLru8Y\f6nYnwH\vY\f4\020rwH\vur\024r8Y\029\fnnY\029wrYycru\029rurwu\f\vLruY\029wrYE/n\024ruY\029rnY\014o6\024wnY|wun4rn/u\029r?rY\029r?Y6\foMr\029ruYE/n\024rudYor4r?n\024rw\001ruYzr?\029ru\021")
            },
            {
              Text = _t6zE("awrY4wn\vr?w\001ruYE/n\024ruYMor?Y\029ruY\b/uonY|4rwLYyH\v?rw4ruY\029wrnr?Yjrw6ruY\001ru\foY\028XV{8{xY,o?/dY]/uu\024rYwH\vYn/Y]/Lc6r\024\024YLw\024Yycru\029ru\001r6\029r?uYMwu\fu\020wr?ru\021")
            },
            {
              Text = _t6zE(" r\024\020\024Y\v\f4rYwH\vY\029wH\vY\029/H\vY\001\fu\020YnH\v/ruY\020o\001r\024rp\024r\024\021\a\b%\025\031/?\foMYwH\vYrw\001ru\0246wH\vY\vwu\fonYz/66\024r\\")
            },
            {
              Text = _t6zE("awrnr?Y\031\vr?w\001/Y\v\f\024YE,l\004,Yycru\0294/pq")
            },
            {
              Text = _t6zE("ar?Y\031\vr?w\001/Yzw?\029Y5r?Lo\0246wH\vY|4\020z\021Y\v/MMru\0246wH\vdY\029ro\0246wH\vYzruw\001r?Y6\foMru\029rYE/n\024ruY5r?o?n\fH\vruY\f6nY\029r?Y\bw]rc/?\024You\029Y\029wrY\024ro?ruYNunH\v\fMMou\001n]/n\024ruYnwu\029Y4r?rw\024nY\001r\024w6\001\024\021\a\b%\025\031or?\029rY\015r\024\020\024Y\029o?H\vYrwurYzrw\024r?rYycru\029ru\029/nrY4rwLY\005wu\f6Y\029rnY\b/uonYu/H\vYLr\v?Y9r6\029Y\001rncru\029r\0248YLornn\024rYwH\vYLw?Y\015\fYor4r?6r\001ru8Yz\fnYwH\vYLw\024Y\029rLYCr4r?nH\vonnYL\fH\vr8Y\029\fYnr64w\001r?Y\foMY]rwuruY\005\f66YwuY\029wrYrw\001rurYv\fnH\vrYM6wrnnruYn/66\021")
            }
          }, function(action)
            if _okAj == true then
              _kTo()
            else
              _Urwigo.Dialog(false, {
                {
                  Text = _t6zE("a\fY\029oY\029ruY\014o6\024wY\fuYrwurLY\fu\029r?ruYv\f\001Y4rnoH\v\024Y\v\fn\024You\029Y\vro\024rYu/H\vYL\f6YMor?Y\029ruY\b/uonYzwr\029r?Y\001r]/LLruY4wn\0248YL\f\001YrnY\029wH\vY5wr66rwH\v\024Y\024?/\024\020YLrwur?Y\031/?\024rYwuY\029ruY\005wu\001r?uY\015oH]ru8Yr\024z\fnY\020oYncru\029ru8Y\029\fLw\024YwH\vY\001ru/r\024w\001\024Yzr?\029r8Y\029wrnrYycru\029rYwuYw?\001ru\029zr6H\vrY~\fH\vrc?/\015r]\024rY\020oYn\024rH]ru\021")
                },
                {
                  Text = _t6zE("luY\029rLY\005\f66Y4ruo\024\020rYrwuM\fH\vY\029wrYycru\029ru\029/nrY\029rnY\014o6\024wn\021\a\b%\025awrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY\029r?Yy\024\f\001rY\028Y6\fo\024r\024Y\019V\002b\021Y\a\b%\025a\fLw\024Y\029r?Y.ou\029Y\014oru\020ruYM?wnn\0248YLonn\024Y\029oYr5ru\024or66Y]o?\020Y\029ruYy\024?/LY\funH\v\f6\024ru\021")
                }
              }, function(action)
                _kTo()
              end)
            end
          end)
        else
          _kTo()
        end
      end
    end
  })
end
function _kTo()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oYlu\024r?rnnr8YrwuY?wH\v\024w\001rnY\031~Y\020oY4ruo\024\020ruD"),
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.MessageBox({
            Text = _t6zE("a\fuuYnH\vrorY\029wH\vYuwH\v\0248YrwuM\fH\vY\020oY]6wu\001r6u\021Y\a\b%\025aoY]\fuun\024Y\001r?urY\029\fnY\031~Y4rwYounY4ruo\024\020ru\021\a\b%\025a\fYwH\vYu\fH\v\024nY\f?4rw\024rYn\024r\vruY\029wrY~\v\fuHruY\foH\vYuwH\v\024YnH\v6rH\v\0248Y\029\fnnYwH\vY\029\f\vrwLY4wu\021\a\b%\025E/ruu\024rYu\f\024or?6wH\vY\f4r?Y\foH\vY\001o\024Ynrwu8Y\029\fnnYwH\vYnr64r?You\024r?zr\001nY4wuY|\020\021Y\b\021YoLYnr64r?YrwuYc\f\f?Y~\fH\vrnY\020oYMwu\029rud8YwuY\029r?Y\b\f\029rz\fuurY6wr\001rY/\029r?Y\fLYyH\v6\fMruY4wuY|5/LYE6wu\001r6uYzor?\029rYwH\vYwuY\029rLY\005\f66YuwH\v\024Y\001rzrH]\024Yzr?\029rud\021"),
            Callback = function(action)
              if action ~= nil then
                _ld3()
              end
            end
          })
        else
          _ld3()
        end
      end
    end
  })
end
function _wr3Rn()
  _Urwigo.MessageBox({
    Text = _t6zE("\bwn\024Y\029oYrw\001ru\0246wH\vY\001\fu\020Y\f66rwuYou\024r?zr\001nY/\029r?YwuYrwurLYvr\fLD"),
    Buttons = {
      _t6zE("N66rwu"),
      _t6zE("lLYvr\fL")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _IzX = true
          _Urwigo.MessageBox({
            Text = _t6zE("Cu\029Ynwu\029Y\029rwurYN?LrY6\fu\001Y\001ruo\0018Y\029\fnnY\029oY\0016rwH\v\020rw\024w\001Y\foMY\020zrwYEu/rcMrY\029?orH]ruY]\fuun\0248Y\029wrYVYLY5/urwu\fu\029r?Yru\024Mr?u\024Ynwu\029D"),
            Media = _oaOx,
            Buttons = {
              _t6zE(" \f"),
              _t6zE("\004rwu")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _Urwigo.MessageBox({
                    Text = _t6zE("a\fnYL/rH\v\024rYwH\vYnr\vruq"),
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.MessageBox({
                          Text = _t6zE("N4r?Yr\001\f6\021Yy/Y6\fu\001rYN?LrY4?\foH\vn\024Y\029oY\vwr?Y4rwY\029wrnrLY~\fH\vrY\001\f?YuwH\v\024\021\a\b%\025\004\f\024or?6wH\vY]\fuuYL\fuY\029ruY\031\vr?w\001/Y\foH\vYnr\v?Y\001o\024Y\001\fu\020Y\f66rwurYncwr6ru\021"),
                          Callback = function(action)
                            if action ~= nil then
                              _8E9()
                            end
                          end
                        })
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _t6zE("\004\fY\029\fuuY\v\fn\024Y\029oY\015\fY96orH]Y\001r\v\f4\0248Y\029\fnnYL\fuY\vwr?Y4rwY\029wrnrLY~\fH\vrY]rwurYn/Y6\fu\001ruYN?LrY4ru/r\024w\001\024\021\a\b%\025\004\f\024or?6wH\vY]\fuuYL\fuY\029ruY\031\vr?w\001/Y\foH\vYnr\v?Y\001o\024Y\001\fu\020Y\f66rwurYncwr6ru\021"),
                    Callback = function(action)
                      if action ~= nil then
                        _8E9()
                      end
                    end
                  })
                end
              end
            end
          })
        else
          _8E9()
        end
      end
    end
  })
end
function _T_o_E()
end
function _ld3()
  _Urwigo.Dialog(false, {
    {
      Text = _t6zE(" r\024\020\024Y\v\f4rYwH\vY\029wH\vY\f4r?Y\001ruo\001YLw\024Y\005?\f\001ruY4/L4\f\029wr?\024You\029YrnYM/6\001ruYu/H\vYrwuYc\f\f?Y\f66\001rLrwurYluM/?L\f\024w/uru\021")
    },
    {
      Text = _t6zE("N6nYr?n\024rnY\029wrY,?]6\fr?ou\0018Yz\f?oLYwH\vYLwH\vYMor?YrwuruY\031\vr?w\001/Yru\024nH\vwr\029ruY\v\f4r8Y/4z/\v6Y\029\fnYrwuw\001rY~\fH\vr?YnwH\vr?Yr\vr?Y\f4nH\v?rH]\024\021")
    },
    {
      Text = _t6zE("joLYrwuruYz/66\024rYwH\v8YzwrYnH\v/uY4rwLY\014o6\024w8YrwuYy1n\024rLY\v\f4ru8Yzr6H\vrnYvr6rM/u\015/]r?Yor4r?M6ornnw\001YL\fH\v\024You\029Y\024?/\024\020\029rLY\f66ruY\brnoH\vr?uY\001\f?\fu\024wr?\0248Y\029\fnnYnwrYLw\024YrwurLY\005ou\029Yu\fH\vY.\fonrYM\f\v?ruY]/ruuru\021")
    },
    {
      Text = _t6zE("a\fnYnr64rYy1n\024rLYzwrY4rwLY\014o6\024wY]/uu\024rYwH\vY\015r\029/H\vY6rw\029r?YuwH\v\024YLr\v?Y5r?zru\029ru8Y\029\fYwH\vY\f66rYLrwurY\028;;YM?rwruY,L\fw60N\029?rnnruY4r?rw\024nY5r?4?\foH\v\024Y\v\f4r\021")
    },
    {
      Text = _t6zE("yc\fr\024r?Yr?M\fr\v?n\024Y\029oYu/H\vYLr\v?Y\020oLYwLY\031\vr?w\001/Ywu\024r\001?wr?\024ruY.w6Mr0y1n\024rL\021")
    },
    {
      Text = _t6zE("Cu\029Y\020oLY\fu\029r?ruYz/66\024rYwH\vY\029wrY\brnoH\vr?Y\029rnY\b/uonYu/r\024w\001ru8Y\020or?n\024YrwuYQow\020Y\020oY\f4n/65wr?ru8Y4r5/?YrnY?wH\v\024w\001Y6/nY\001r\v\024\021\a\b%\025Cu\029Y\foH\vY\vwr?Yz\f?Y\029wrY!?/\001?\fLLwr?ou\001YrwurnY\031\vr?w\001/nYrwurY\029r?Y\014/r\0016wH\v]rw\024ruYou\029YnH\v6wrnn6wH\vY\029wr\015ruw\001r8YMor?Y\029wrYwH\vYLwH\vYru\024nH\vwr\029ruY\v\f4r\021")
    },
    {
      Text = _t6zE("\005\fu\001ruYzw?Y\fLY4rn\024ruY\foH\vY\0016rwH\vYL\f6YLw\024Y\029rLYQow\020Y\fuYou\029Yr?n\024Y\029\fu\fH\vY]/LLruY\029\fuuYu/H\vYrwuYc\f\f?Yzrw\024r?rY,?]6\fr?ou\001ru\021")
    }
  }, function(action)
    _f4xED()
  end)
end
function _UZbQ()
  _Urwigo.MessageBox({
    Text = _t6zE("(\029r?Ynwu\029Y5wr66rwH\v\024Y\001r?\f\029rY\fu\029r?rY~\fH\vr?8Y\029wrYr4ruM\f66nY\029ruY\031\vr?w\001/Yncwr6ru8YwLY\031\f6\029You\024r?zr\001nD\a\b%\025,?]ruuruY]\fuun\024Y\029oY\029\fnY\029\f?\fu8Y\029\fnnYuo?YrwurY!/zr?4\fu]Y5/?Y(?\024YnrwuYn/66\024r\021"),
    Media = _A5hgN,
    Buttons = {
      _t6zE(" \f"),
      _t6zE("\004rwu")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _7IL = true
          _Urwigo.MessageBox({
            Text = _t6zE("a\fuuY\029?orH]rY\029wH\vY\029wrYa\foLru8Y\029\fnnY\029oYuwH\v\024Y\020oYnH\vur66Y4wn\024You\029Y\foMY\029wrY\fu\029r?ruY~\fH\vr?Y\foM6\froMn\024\021\a\b%\025jo?YywH\vr?\vrw\024Y4r]/LL\024Y\029oY\0016rwH\vYu/H\vYrwurYrp\024?\fYnH\vzr?rYNoM\001\f4rY4r5/?Y\029oY?wH\v\024w\001Yn\024\f?\024ruY]\fuun\024\021\a\b%\025N4r?Y\020or?n\024YLonn\024Y\029oY\015r\024\020\024Y\029ruY\031\vr?w\001/Y\foH\vY/MMw\020wr66Yn\024\f?\024ru\021"),
            Callback = function(action)
              if action ~= nil then
                _2cX()
              end
            end
          })
        else
          _2cX()
        end
      end
    end
  })
end
function _NF2x2()
  if _Kcff == 25 then
    _lmva()
  else
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.04 then
      if _QjfUX == false then
        _QjfUX = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_9ubz)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.08 then
      if _NBV3 == false then
        _NBV3 = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_K3o)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.12 then
      if _W4YE == false then
        _W4YE = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_P4hX)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.16 then
      if _tqx == false then
        _tqx = true
        _Kcff = _Kcff + 1
        _Urwigo.MessageBox({
          Text = _t6zE("\bw\024\024rY\029ruYv/uY\fLY.\fu\0291Y\funH\v\f6\024ru8Yn/un\024Yzw?\029YrnYnH\vzwr?w\0018Y\029wrYu\frH\vn\024rY\005?\f\001rY?wH\v\024w\001Y\020oY4r\fu\024z/?\024ru\021"),
          Callback = function(action)
            if action ~= nil then
              Wherigo.PlayAudio(_j9bRL)
              _Urwigo.RunDialogs(function()
                Wherigo.GetInput(_qAHt)
              end)
            end
          end
        })
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.2 then
      if _dyq2h == false then
        _dyq2h = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_hUxox)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.24 then
      if _vGcu == false then
        _vGcu = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_35tMQ)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.28 then
      if _sjJJ == false then
        _sjJJ = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_ItW)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.32 then
      if _1ZZ == false then
        _1ZZ = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_Sexm)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.36 then
      if _60bfP == false then
        _60bfP = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_r00Y)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.4 then
      if _6Kj == false then
        _6Kj = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_GJfS)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.44 then
      if _qXTj == false then
        _qXTj = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_Kmp)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.48 then
      if _s4oMj == false then
        _s4oMj = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_0X7m)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.52 then
      if _hyB == false then
        _hyB = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_KdO)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.56 then
      if _qMt == false then
        _qMt = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_3YB5)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.6 then
      if _vtF == false then
        _vtF = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_bZL)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.64 then
      if _Mbew == false then
        _Mbew = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_cx1V)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.68 then
      if _m4T == false then
        _m4T = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_A8As)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.72 then
      if _wOdVK == false then
        _wOdVK = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_MKggt)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.76 then
      if _Zqp == false then
        _Zqp = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_YNW3c)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.8 then
      if _nQSY == false then
        _nQSY = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_yNOh)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.84 then
      if _LVyO == false then
        _LVyO = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(__NEd4)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.88 then
      if _vYfW == false then
        _vYfW = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_0j3G)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.92 then
      if _ghQ7 == false then
        _ghQ7 = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_yGq)
        end)
      else
        _NF2x2()
      end
    elseif _rndChoiceValue < 0.96 then
      if _bUBrV == false then
        _bUBrV = true
        _Kcff = _Kcff + 1
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_rpcWV)
        end)
      else
        _NF2x2()
      end
    elseif _xKRLE == false then
      _xKRLE = true
      _Kcff = _Kcff + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_i7qzc)
      end)
    else
      _NF2x2()
    end
  end
end
function _lmva()
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.111111111111111 then
    if _EWB == false then
      _EWB = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_SNV)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.222222222222222 then
    if _phAII == false then
      _phAII = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_K3NM)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.333333333333333 then
    if _zE5 == false then
      _zE5 = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_zo7G)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.444444444444444 then
    if _uIK == false then
      _uIK = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_ASzHo)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.555555555555556 then
    if _oAd1 == false then
      _oAd1 = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_IAeCS)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.666666666666667 then
    if _oAd1 == false then
      _oAd1 = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_kJp)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.777777777777778 then
    if _oAd1 == false then
      _oAd1 = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_988H)
      end)
    else
      _lmva()
    end
  elseif _rndChoiceValue < 0.888888888888889 then
    if _oAd1 == false then
      _oAd1 = true
      _kSc = _kSc + 1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(__m2)
      end)
    else
      _lmva()
    end
  elseif _oAd1 == false then
    _oAd1 = true
    _kSc = _kSc + 1
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_HP0o)
    end)
  else
    _lmva()
  end
end
function _Gps44()
  _Urwigo.Dialog(false, {
    {
      Text = _t6zE("(E8Y\029\fnYzw?\029Yn/YuwH\v\024n\021")
    },
    {
      Text = _t6zE("aoY\001w4n\024Y\015\fYuo?Yu/H\vYM\f6nH\vrYNu\024z/?\024ru\021")
    },
    {
      Text = _t6zE("\031wrYn/66n\024Y\029oY\015rL\f6nY\029wrYu/\024zru\029w\001ruY\028;Y!ou]\024rY\020on\fLLruY4r]/LLru\021")
    },
    {
      Text = _t6zE("aoY4r]/LLn\024Y\015r\024\020\024YrwurY\f66r?6r\024\020\024rY\005?\f\001r\021")
    },
    {
      Text = _t6zE("\031ruuY\029oY\029wrnrY\005?\f\001rY?wH\v\024w\001Y4r\fu\024z/?\024rn\0248Y\029\fuuYzr?\024rYwH\vY\029\fnYQow\020YrwuM\fH\vY\f6nY4rn\024\fu\029ru\021")
    },
    {
      Text = _t6zE("y/66\024rn\024Y\029oY\015r\029/H\vY\foH\vY4rwY\029wrnr?Y6r\024\020\024ruY\005?\f\001rY5r?n\f\001ru8Y\029\fuuYLonn\024Y\029oYLw\024Y\029rLY\031\vr?w\001/Yu/H\vYL\f6Y\001\fu\020Y5/uY5/?urY\fuM\fu\001ru\021")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_Iz_mh)
    end)
  end)
end
function _laKY()
  if _okAj == false then
    if _OC6K == true then
      _Urwigo.Dialog(false, {
        {
          Text = _t6zE("Cu\0016\fo46wH\vq\a\b%\025\a\b%\025awrnrYNu\024z/?\024Ywn\024Y?wH\v\024w\001q")
        },
        {
          Text = _t6zE("a\fnYQow\020Ywn\024Y\029\fLw\024Y4rn\024\fu\029ru\021")
        },
        {
          Text = _t6zE("\005\f66nY\029wrY\fu\029r?ruY~\fH\vr?YwLLr?Yu/H\vY5/?Y(?\024YnrwuYn/66\024ru8Y\029\fuuYwn\024Y\029\fnY\015r\024\020\024YrwuYzruw\001Y\029//M\021\a\b%\025awrYy\024\f\001rY\0284Y4rMwu\029r\024YnwH\vYu\frL6wH\vYou\024r?Y\029rLYa\fH\vY\029rnY\bw]rc/?\024n\021\a\b%\025lH\vY4wuY\f4r?Y\020o5r?nwH\v\0246wH\v8Y\029\fnnYw\v?YroH\vYnH\v/uYw?\001ru\029zwrYrwuw\001ruY]/ruu\024\021\a\b%\025Cu\029Y4w\024\024rY\foMc\fnnru8Y\029\fnnY\029wrY\fu\029r?ruYuwH\v\024Y\001rnc/w6r?\024Yzr?\029ru\021")
        },
        {
          Text = _t6zE("awrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY4rwYy\024\f\001rY\0284Y6\fo\024r\024\\\a\b%\025\a\b%\025\002\019\019\002"),
          Media = _FJO
        },
        {
          Text = _t6zE("\005or?Y\029wrYy\024\f\001rY\028Y4Y4ru/r\024w\001n\024Y\029oYrwurY\029r?Y4rw\029ruY4r?rw\024\001rn\024r66\024ruY!/zr?4\fu]n\021YawrnrYn/66\024n\024Y\029oY\029\fu\fH\vY\foH\vYLw\024YwuY\029ruY\031\f6\029Yur\vLruY|c\fnnru\029rYE\f4r6Y\001w4\024YrnY\015rzrw6nY5/?Y(?\024Y4rwY\029ruYru\024nc?rH\vru\029ruYy\024\f\024w/urud\021\a\b%\025\bw\024\024rY\foH\vYLw\024ur\vLru8YzruuY\029oYnr64r?YnH\v/uYrwurYrw\001rurY!/zr?4\fu]Y\029\f4rwY\v\f4ruYn/66\024rn\024q"),
          Media = _iVxDU
        },
        {
          Text = _t6zE("N4r?Yuo?Y,l\004,Y!/zr?4\fu]YLw\024ur\vLruYou\029Y\foMY]rwuruY\005\f66Y\f66rY4rw\029r\021\a\b%\025,5ru\024or66Y4rnoH\v\024Y\vro\024rY\015\fYu/H\vYrwuY\fu\029r?rnYvr\fLY\029ruY\b/uon\021")
        },
        {
          Text = _t6zE("awrY!/zr?4\fu]Yzw?\029Y4rwYrwuw\001ruYy\024\f\024w/uruY4ru/r\024w\001\024\021\a\b%\025aoY]\fuun\024Y\f4r?Y\foH\vY\001r?urYou\024r?zr\001nY\029rwuY.\fu\0291Y\029\fLw\024Y\foM6\f\029ru8Yn/Mr?uY\029oYrwuYc\fnnru\029rnYE\f4r6Y\029\f4rwY\v\f4ruYn/66\024rn\024Y/\029r?Y\029rwuY.\fu\0291Ywu\029o]\024w5rnY&\f\029ruYou\024r?n\024or\024\020\024\021\a\b%\025awrYE\fc\f\020w\024\fr\024Y\029r?Y!/zr?4\fu]Yn/66\024rY\029\fMor?Y\foMY\015r\029ruY\005\f66Y\001?/nnY\001ruo\001Ynrwu\021")
        },
        {
          Text = _t6zE("\004\fH\vY\029rLY\brnoH\vY\029rnY\005wu\f6nY\029\f?Mn\024Y\029oYu\f\024or?6wH\vYuwH\v\024Y5r?\001rnnru8Y\029wrY!/zr?4\fu]Y\foH\vYzwr\029r?Y\020o?orH]\020o6r\001ru8Y\029\fLw\024YnwrYzwr\029r?Y\fo\024/L\f\024wnH\vYwu\029o]\024w5Y\foM\001r6\f\029ruYzw?\029You\029YMor?Y\029wrYu\frH\vn\024ruY~\fH\vr?Y4r?rw\024Yn\024r\v\024\021")
        },
        {
          Text = _t6zE("awrYIr?n\024rH]rY\029r?Yy\024\f\001rnY|ou\029Y\foH\vY\029\fnY\005wu\f6dYnwu\029Y4wnY\foMY\001\fu\020Yzruw\001rYNonu\f\vLruY\b/\029ru5r?n\024rH]r\021\a\b%\025\brwY\001rnH\v6/nnrur?YM?wnH\vr?YyH\vurr\029rH]rY\029or?M\024rYrnYnr\v?YnH\vzr?Yzr?\029ru8Ynr64w\001rY\020oYMwu\029ru\021\a\b%\025N4r?YLw\024Y.w6MrY\029r?YwuY\029r?Y~\f\024?w\029\001rY4r?rw\024\001rn\024r66\024ruYyc/w6r?4w6\029r?Yn/66\024rY\foH\vY\029\fnYL/r\0016wH\vYnrwu\021")
        },
        {
          Text = _t6zE("9N\004jY\031l~.vl9q\a\b%\025\a\b%\025\bw\024\024rY\029wrYarH]r6Y\029r?Y\b/\029ru5r?n\024rH]rYzwr\029r?Yc\fnn\001ru\foY\foM6r\001ruYou\029Y\029\f4rwY\029\f?\foMY\fH\v\024ru8Y\029\fnnYnwH\vY]rwurYNrn\024r8Y\b6\fr\024\024r?Y/\029r?YvN%\004\005(&l,Y\020zwnH\vruY%\fu\029You\029YarH]r6Y4rMwu\029ru\021\a\b%\025a\fuuYu/H\vY\029ruY,?M/6\001Y]/u\024?/66wr?ru8Ywu\029rLY\029oYc?/4wr?n\024Y\029ruYarH]r6Y\020oY5r?nH\vwr4ruY|zruuY\029\fnYwuY]rwurY%wH\v\024ou\001Y\001r\v\0248Y\029\fuuYc\fnn\024Yrnd\021\a\b%\025NunH\v6wrnnru\029Yzwr\029r?YrwuY9rzwH\v\024Y\foMY\029ruYarH]r6Y6r\001ruY|wuY\029r?Y%r\001r6Yz/\v6Y\029\fnY9rzwH\v\0248Yzr6H\vrnY\029oY\foH\vY\foMY\029rLYarH]r6Y5/?\001rMou\029ruY\v\f4ruYn/66\024rn\024d\021")
        },
        {
          Text = _t6zE("\031ruuY\029w?Y\001?/rnnr?rY\014ru\001ruY\fuY\b6\fr\024\024r?u8YNrn\024ruY/\029r?Yz\fnY\foH\vYwLLr?YwuY\029wrYa/nrYM\f66ruY|z\fnYnr\v?Y6rwH\v\024Yc\fnnwr?ruY]\fuud8Y\029\fuuY\029\f?Mn\024Y\029oY\029wrY\foH\vY\001r?urYzwr\029r?Yru\024Mr?uruY|u\f\024or?6wH\vY\foH\vY\029wrYy\fH\vru8Y\029wrYnH\v/uY\029rwuruYI/?\001\fru\001r?uY\029\fY?rwu\001rM\f66ruYnwu\029d\021")
        },
        {
          Text = _t6zE("\005or?Y\029ruY\005\f668Y\029\fnnY\029oYw?\001ru\029z/Y!?/46rLrY\v\f4ruYn/66\024rn\0248Y\029\fuuY]\fuun\024Y\029oY\029\fnY.w6Mr0~ru\024r?Y\foM?oMru8Yzr6H\vrnYnwH\vYuouYwuY\029rwurLYlu5ru\024\f?Y4rMwu\029r\024Y|\020on\fLLruYLw\024YrwuYc\f\f?Y\fu\029r?ruYy\fH\vrud\021")
        },
        {
          Text = _t6zE("awrY\fu\029r?ruYy\fH\vruYwLYlu5ru\024\f?Y]\fuun\024Y\029oY\029w?Y\foH\vYu/H\vY\029\f\vrwLY\funH\v\foru8YM\f66nY\029oY\015r\024\020\024Y]rwurYjrw\024Y/\029r?Y&on\024Y\v\fn\024\021")
        },
        {
          Text = _t6zE("\031l~.vl9q\a\b%\025\a\b%\025\005\f66nY\029oY\fonYw?\001ru\029rwurLY9?ou\029Y\029wrY~\f?\024?w\029\001rYuroYn\024\f?\024ruYLonn\0248Y\029\fuuY]\fuun\024Y\029oY\f4Y\015r\024\020\024Y\029ruYN4]or?\020ou\001n0~/\029r\a\b%\025\a\b%\025\028b\019\002V\a\b%\025\a\b%\0254ruo\024\020ruYou\029Y\v\fn\024Yn/Y\foMY\015r\029ruY\005\f66Yjo\001?wMMY\foMY\029\fnY.w6Mr0~ru\024r?\021\a\b%\025N6n/Y4w\024\024rY\001o\024YLr?]ruY/\029r?Yu/\024wr?ru\021")
        },
        {
          Text = _t6zE("Nun/un\024ruY]\fuun\024Y\029oY\029wrY~\f?\024?w\029\001rY\015r\024\020\024Yrw\001ru\0246wH\vY4rru\029ru\021\a\b%\025\a\b%\025ar?Y%rn\024Y\029wrnrnY~\fH\vrnYwn\024Yrw\001ru\0246wH\vYr\vr?YrwuY\014o6\024w\021")
        },
        {
          Text = _t6zE("Cu\029YM\f66nYrnYw?\001ru\029z/Y!?/46rLrY\001w4\024You\029Y\029oY/\vurY.w6MrYuwH\v\024YLr\v?Yzrw\024r?Y]/LLn\0248Y\029\fuuYn\024\f?\024rY\029wrY~\f?\024?w\029\001rYzwr\029r?Y|5/uYrwurLY\f4\001rncrwH\vr?\024ruYycwr6Y/\029r?YM\f66nY\029\fnYuwH\v\024YL/r\0016wH\vYnrwuYn/66\024r8Y\029ruYN4]or?\020ou\001n0~/\029rY\028b\019\002VYuo\024\020rudYou\029Y4rnoH\vrY\029\fnY.w6Mr0~ru\024r?\021")
        },
        {
          Text = _t6zE("Cu\029YM\f66nY\029w?Y\029wrY5/uYLw?Yc?/\001?\fLLwr?\024rY.w6MrY\029/H\vYL\f6YuwH\v\024Yzrw\024r?\vr6MruY]\fuu8Yzrw6YrwuY!?/46rLY\foM\001r\024?r\024ruYwn\0248Yzr6H\vrnYwH\vYuwH\v\024Y5/?\vr?\001rnr\vruY\v\f4r8Y\029\fuuY]\fuun\024Y\029oYwLYjzrwMr6nM\f66YwLLr?Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029rY|\foH\vYzruuY\029rLYuwH\v\024Yn/Ywn\024dYou\029Y\029oY4r]/LLn\024Y\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uYLw\024\001r\024rw6\024\021\a\b%\025,wuYa\004\005Ywn\024Y\029\f\vr?Yrw\001ru\0246wH\vY\fon\001rnH\v6/nnru\021")
        }
      }, function(action)
        _f19.Active = false
        _c8h:MoveTo(Player)
        _gsDE:MoveTo(Player)
        _A4jFc:MoveTo(Player)
        _XUJvy:MoveTo(Player)
        _xy4:RequestSync()
      end)
    elseif _xpwp == true then
      _Urwigo.Dialog(false, {
        {
          Text = _t6zE("Cu\0016\fo46wH\vq\a\b%\025\a\b%\025awrnrYNu\024z/?\024Ywn\024Y?wH\v\024w\001q")
        },
        {
          Text = _t6zE("a\fnYQow\020Ywn\024Y\029\fLw\024Y4rn\024\fu\029ru\021")
        },
        {
          Text = _t6zE("\005\f66nY\029wrY\fu\029r?ruY~\fH\vr?YLw\024\0246r?zrw6rY\fonY\029rLY\031\f6\029Y\020o?orH]YnrwuYn/66\024ru8Y\029\fuuYwn\024Y\029\fnY\015r\024\020\024YrwuYzruw\001Y\029//M\021\a\b%\025awrYy\024\f\001rY\0284Y4rMwu\029r\024YnwH\vYu\frL6wH\vYou\024r?Y\029rLYa\fH\vY\029rnY\bw]rc/?\024n\021\a\b%\025lH\vY4wuY\f4r?Y\020o5r?nwH\v\0246wH\v8Y\029\fnnYw\v?YroH\vYnH\v/uYw?\001ru\029zwrYrwuw\001ruY]/ruu\024\021\a\b%\025Cu\029Y4w\024\024rY\foMc\fnnru8Y\029\fnnY\029wrY\fu\029r?ruYuwH\v\024Y\001rnc/w6r?\024Yzr?\029ru\021")
        },
        {
          Text = _t6zE("awrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY4rwYy\024\f\001rY\0284Y6\fo\024r\024\\\a\b%\025\a\b%\025\002\019\019\002"),
          Media = _FJO
        },
        {
          Text = _t6zE("\005or?Y\029wrYy\024\f\001rY\028Y4Y4ru/r\024w\001n\024Y\029oYrwurY\029r?Y4rw\029ruY4r?rw\024\001rn\024r66\024ruY!/zr?4\fu]n\021YawrnrYn/66\024n\024Y\029oY\029\fu\fH\vY\foH\vYLw\024YwuY\029ruY\031\f6\029Yur\vLruY|c\fnnru\029rYE\f4r6Y\001w4\024YrnY\015rzrw6nY5/?Y(?\024Y4rwY\029ruYru\024nc?rH\vru\029ruYy\024\f\024w/urud\021\a\b%\025\bw\024\024rY\foH\vYLw\024ur\vLru8YzruuY\029oYnr64r?YnH\v/uYrwurYrw\001rurY!/zr?4\fu]Y\029\f4rwY\v\f4ruYn/66\024rn\024q"),
          Media = _iVxDU
        },
        {
          Text = _t6zE("N4r?Yuo?Y,l\004,Y!/zr?4\fu]YLw\024ur\vLruYou\029Y\foMY]rwuruY\005\f66Y\f66rY4rw\029r\021\a\b%\025,5ru\024or66Y4rnoH\v\024Y\vro\024rY\015\fYu/H\vYrwuY\fu\029r?rnYvr\fLY\029ruY\b/uon\021")
        },
        {
          Text = _t6zE("awrY!/zr?4\fu]Yzw?\029Y4rwYrwuw\001ruYy\024\f\024w/uruY4ru/r\024w\001\024\021\a\b%\025aoY]\fuun\024Y\f4r?Y\foH\vY\001r?urYou\024r?zr\001nY\029rwuY.\fu\0291Y\029\fLw\024Y\foM6\f\029ru8Yn/Mr?uY\029oYrwuYc\fnnru\029rnYE\f4r6Y\029\f4rwY\v\f4ruYn/66\024rn\024Y/\029r?Y\029rwuY.\fu\0291Ywu\029o]\024w5rnY&\f\029ruYou\024r?n\024or\024\020\024\021\a\b%\025awrYE\fc\f\020w\024\fr\024Y\029r?Y!/zr?4\fu]Yn/66\024rY\029\fMor?Y\foMY\015r\029ruY\005\f66Y\001?/nnY\001ruo\001Ynrwu\021")
        },
        {
          Text = _t6zE("\004\fH\vY\029rLY\brnoH\vY\029rnY\005wu\f6nY\029\f?Mn\024Y\029oYu\f\024or?6wH\vYuwH\v\024Y5r?\001rnnru8Y\029wrY!/zr?4\fu]Y\foH\vYzwr\029r?Y\020o?orH]\020o6r\001ru8Y\029\fLw\024YnwrYzwr\029r?Y\fo\024/L\f\024wnH\vYwu\029o]\024w5Y\foM\001r6\f\029ruYzw?\029You\029YMor?Y\029wrYu\frH\vn\024ruY~\fH\vr?Y4r?rw\024Yn\024r\v\024\021")
        },
        {
          Text = _t6zE("awrYIr?n\024rH]rY\029r?Yy\024\f\001rnY|ou\029Y\foH\vY\029\fnY\005wu\f6dYnwu\029Y4wnY\foMY\001\fu\020Yzruw\001rYNonu\f\vLruY\b/\029ru5r?n\024rH]r\021\a\b%\025\brwY\001rnH\v6/nnrur?YM?wnH\vr?YyH\vurr\029rH]rY\029or?M\024rYrnYnr\v?YnH\vzr?Yzr?\029ru8Ynr64w\001rY\020oYMwu\029ru\021\a\b%\025N4r?YLw\024Y.w6MrY\029r?YwuY\029r?Y~\f\024?w\029\001rY4r?rw\024\001rn\024r66\024ruYyc/w6r?4w6\029r?Yn/66\024rY\foH\vY\029\fnYL/r\0016wH\vYnrwu\021")
        },
        {
          Text = _t6zE("9N\004jY\031l~.vl9q\a\b%\025\a\b%\025\bw\024\024rY\029wrYarH]r6Y\029r?Y\b/\029ru5r?n\024rH]rYzwr\029r?Yc\fnn\001ru\foY\foM6r\001ruYou\029Y\029\f4rwY\029\f?\foMY\fH\v\024ru8Y\029\fnnYnwH\vY]rwurYNrn\024r8Y\b6\fr\024\024r?Y/\029r?YvN%\004\005(&l,Y\020zwnH\vruY%\fu\029You\029YarH]r6Y4rMwu\029ru\021\a\b%\025a\fuuYu/H\vY\029ruY,?M/6\001Y]/u\024?/66wr?ru8Ywu\029rLY\029oYc?/4wr?n\024Y\029ruYarH]r6Y\020oY5r?nH\vwr4ruY|zruuY\029\fnYwuY]rwurY%wH\v\024ou\001Y\001r\v\0248Y\029\fuuYc\fnn\024Yrnd\021\a\b%\025NunH\v6wrnnru\029Yzwr\029r?YrwuY9rzwH\v\024Y\foMY\029ruYarH]r6Y6r\001ruY|wuY\029r?Y%r\001r6Yz/\v6Y\029\fnY9rzwH\v\0248Yzr6H\vrnY\029oY\foH\vY\foMY\029rLYarH]r6Y5/?\001rMou\029ruY\v\f4ruYn/66\024rn\024d\021")
        },
        {
          Text = _t6zE("\031ruuY\029w?Y\001?/rnnr?rY\014ru\001ruY\fuY\b6\fr\024\024r?u8YNrn\024ruY/\029r?Yz\fnY\foH\vYwLLr?YwuY\029wrYa/nrYM\f66ruY|z\fnYnr\v?Y6rwH\v\024Yc\fnnwr?ruY]\fuud8Y\029\fuuY\029\f?Mn\024Y\029oY\029wrY\foH\vY\001r?urYzwr\029r?Yru\024Mr?uruY|u\f\024or?6wH\vY\foH\vY\029wrYy\fH\vru8Y\029wrYnH\v/uY\029rwuruYI/?\001\fru\001r?uY\029\fY?rwu\001rM\f66ruYnwu\029d\021")
        },
        {
          Text = _t6zE("\005or?Y\029ruY\005\f668Y\029\fnnY\029oYw?\001ru\029z/Y!?/46rLrY\v\f4ruYn/66\024rn\0248Y\029\fuuY]\fuun\024Y\029oY\029\fnY.w6Mr0~ru\024r?Y\foM?oMru8Yzr6H\vrnYnwH\vYuouYwuY\029rwurLYlu5ru\024\f?Y4rMwu\029r\024Y|\020on\fLLruYLw\024YrwuYc\f\f?Y\fu\029r?ruYy\fH\vrud\021")
        },
        {
          Text = _t6zE("awrY\fu\029r?ruYy\fH\vruYwLYlu5ru\024\f?Y]\fuun\024Y\029oY\029w?Y\foH\vYu/H\vY\029\f\vrwLY\funH\v\foru8YM\f66nY\029oY\015r\024\020\024Y]rwurYjrw\024Y/\029r?Y&on\024Y\v\fn\024\021")
        },
        {
          Text = _t6zE("\031l~.vl9q\a\b%\025\a\b%\025\005\f66nY\029oY\fonYw?\001ru\029rwurLY9?ou\029Y\029wrY~\f?\024?w\029\001rYuroYn\024\f?\024ruYLonn\0248Y\029\fuuY]\fuun\024Y\029oY\f4Y\015r\024\020\024Y\029ruYN4]or?\020ou\001n0~/\029r\a\b%\025\a\b%\025\028b\019\002V\a\b%\025\a\b%\0254ruo\024\020ruYou\029Y\v\fn\024Yn/Y\foMY\015r\029ruY\005\f66Yjo\001?wMMY\foMY\029\fnY.w6Mr0~ru\024r?\021\a\b%\025N6n/Y4w\024\024rY\001o\024YLr?]ruY/\029r?Yu/\024wr?ru\021")
        },
        {
          Text = _t6zE("Nun/un\024ruY]\fuun\024Y\029oY\029wrY~\f?\024?w\029\001rY\015r\024\020\024Yrw\001ru\0246wH\vY4rru\029ru\021\a\b%\025\a\b%\025ar?Y%rn\024Y\029wrnrnY~\fH\vrnYwn\024Yrw\001ru\0246wH\vYr\vr?YrwuY\014o6\024w\021")
        },
        {
          Text = _t6zE("Cu\029YM\f66nYrnYw?\001ru\029z/Y!?/46rLrY\001w4\024You\029Y\029oY/\vurY.w6MrYuwH\v\024YLr\v?Yzrw\024r?Y]/LLn\0248Y\029\fuuYn\024\f?\024rY\029wrY~\f?\024?w\029\001rYzwr\029r?Y|5/uYrwurLY\f4\001rncrwH\vr?\024ruYycwr6Y/\029r?YM\f66nY\029\fnYuwH\v\024YL/r\0016wH\vYnrwuYn/66\024r8Y\029ruYN4]or?\020ou\001n0~/\029rY\028b\019\002VYuo\024\020rudYou\029Y4rnoH\vrY\029\fnY.w6Mr0~ru\024r?\021")
        },
        {
          Text = _t6zE("Cu\029YM\f66nY\029w?Y\029wrY5/uYLw?Yc?/\001?\fLLwr?\024rY.w6MrY\029/H\vYL\f6YuwH\v\024Yzrw\024r?\vr6MruY]\fuu8Yzrw6YrwuY!?/46rLY\foM\001r\024?r\024ruYwn\0248Yzr6H\vrnYwH\vYuwH\v\024Y5/?\vr?\001rnr\vruY\v\f4r8Y\029\fuuY]\fuun\024Y\029oYwLYjzrwMr6nM\f66YwLLr?Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029rY|\foH\vYzruuY\029rLYuwH\v\024Yn/Ywn\024dYou\029Y\029oY4r]/LLn\024Y\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uYLw\024\001r\024rw6\024\021\a\b%\025,wuYa\004\005Ywn\024Y\029\f\vr?Yrw\001ru\0246wH\vY\fon\001rnH\v6/nnru\021")
        }
      }, function(action)
        _f19.Active = false
        _c8h:MoveTo(Player)
        _gsDE:MoveTo(Player)
        _A4jFc:MoveTo(Player)
        _XUJvy:MoveTo(Player)
        _xy4:RequestSync()
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = _t6zE("Cu\0016\fo46wH\vq\a\b%\025\a\b%\025awrnrYNu\024z/?\024Ywn\024Y?wH\v\024w\001q")
        },
        {
          Text = _t6zE("a\fnYQow\020Ywn\024Y\029\fLw\024Y4rn\024\fu\029ru\021")
        },
        {
          Text = _t6zE("awrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY4rwYy\024\f\001rY\0284Y6\fo\024r\024\\\a\b%\025\a\b%\025\002\019\019\002"),
          Media = _FJO
        },
        {
          Text = _t6zE("\005or?Y\029wrYy\024\f\001rY\028Y4Y4ru/r\024w\001n\024Y\029oYrwurY\029r?Y4rw\029ruY4r?rw\024\001rn\024r66\024ruY!/zr?4\fu]n\021YawrnrYn/66\024n\024Y\029oY\029\fu\fH\vY\foH\vYLw\024YwuY\029ruY\031\f6\029Yur\vLruY|c\fnnru\029rYE\f4r6Y\001w4\024YrnY\015rzrw6nY5/?Y(?\024Y4rwY\029ruYru\024nc?rH\vru\029ruYy\024\f\024w/urud\021\a\b%\025\bw\024\024rY\foH\vYLw\024ur\vLru8YzruuY\029oYnr64r?YnH\v/uYrwurYrw\001rurY!/zr?4\fu]Y\029\f4rwY\v\f4ruYn/66\024rn\024q"),
          Media = _iVxDU
        },
        {
          Text = _t6zE("N4r?Yuo?Y,l\004,Y!/zr?4\fu]YLw\024ur\vLruYou\029Y\foMY]rwuruY\005\f66Y\f66rY4rw\029r\021\a\b%\025,5ru\024or66Y4rnoH\v\024Y\vro\024rY\015\fYu/H\vYrwuY\fu\029r?rnYvr\fLY\029ruY\b/uon\021")
        },
        {
          Text = _t6zE("awrY!/zr?4\fu]Yzw?\029Y4rwYrwuw\001ruYy\024\f\024w/uruY4ru/r\024w\001\024\021\a\b%\025aoY]\fuun\024Y\f4r?Y\foH\vY\001r?urYou\024r?zr\001nY\029rwuY.\fu\0291Y\029\fLw\024Y\foM6\f\029ru8Yn/Mr?uY\029oYrwuYc\fnnru\029rnYE\f4r6Y\029\f4rwY\v\f4ruYn/66\024rn\024Y/\029r?Y\029rwuY.\fu\0291Ywu\029o]\024w5rnY&\f\029ruYou\024r?n\024or\024\020\024\021\a\b%\025awrYE\fc\f\020w\024\fr\024Y\029r?Y!/zr?4\fu]Yn/66\024rY\029\fMor?Y\foMY\015r\029ruY\005\f66Y\001?/nnY\001ruo\001Ynrwu\021")
        },
        {
          Text = _t6zE("\004\fH\vY\029rLY\brnoH\vY\029rnY\005wu\f6nY\029\f?Mn\024Y\029oYu\f\024or?6wH\vYuwH\v\024Y5r?\001rnnru8Y\029wrY!/zr?4\fu]Y\foH\vYzwr\029r?Y\020o?orH]\020o6r\001ru8Y\029\fLw\024YnwrYzwr\029r?Y\fo\024/L\f\024wnH\vYwu\029o]\024w5Y\foM\001r6\f\029ruYzw?\029You\029YMor?Y\029wrYu\frH\vn\024ruY~\fH\vr?Y4r?rw\024Yn\024r\v\024\021")
        },
        {
          Text = _t6zE("awrYIr?n\024rH]rY\029r?Yy\024\f\001rnY|ou\029Y\foH\vY\029\fnY\005wu\f6dYnwu\029Y4wnY\foMY\001\fu\020Yzruw\001rYNonu\f\vLruY\b/\029ru5r?n\024rH]r\021\a\b%\025\brwY\001rnH\v6/nnrur?YM?wnH\vr?YyH\vurr\029rH]rY\029or?M\024rYrnYnr\v?YnH\vzr?Yzr?\029ru8Ynr64w\001rY\020oYMwu\029ru\021\a\b%\025N4r?YLw\024Y.w6MrY\029r?YwuY\029r?Y~\f\024?w\029\001rY4r?rw\024\001rn\024r66\024ruYyc/w6r?4w6\029r?Yn/66\024rY\foH\vY\029\fnYL/r\0016wH\vYnrwu\021")
        },
        {
          Text = _t6zE("9N\004jY\031l~.vl9q\a\b%\025\a\b%\025\bw\024\024rY\029wrYarH]r6Y\029r?Y\b/\029ru5r?n\024rH]rYzwr\029r?Yc\fnn\001ru\foY\foM6r\001ruYou\029Y\029\f4rwY\029\f?\foMY\fH\v\024ru8Y\029\fnnYnwH\vY]rwurYNrn\024r8Y\b6\fr\024\024r?Y/\029r?YvN%\004\005(&l,Y\020zwnH\vruY%\fu\029You\029YarH]r6Y4rMwu\029ru\021\a\b%\025a\fuuYu/H\vY\029ruY,?M/6\001Y]/u\024?/66wr?ru8Ywu\029rLY\029oYc?/4wr?n\024Y\029ruYarH]r6Y\020oY5r?nH\vwr4ruY|zruuY\029\fnYwuY]rwurY%wH\v\024ou\001Y\001r\v\0248Y\029\fuuYc\fnn\024Yrnd\021\a\b%\025NunH\v6wrnnru\029Yzwr\029r?YrwuY9rzwH\v\024Y\foMY\029ruYarH]r6Y6r\001ruY|wuY\029r?Y%r\001r6Yz/\v6Y\029\fnY9rzwH\v\0248Yzr6H\vrnY\029oY\foH\vY\foMY\029rLYarH]r6Y5/?\001rMou\029ruY\v\f4ruYn/66\024rn\024d\021")
        },
        {
          Text = _t6zE("\031ruuY\029w?Y\001?/rnnr?rY\014ru\001ruY\fuY\b6\fr\024\024r?u8YNrn\024ruY/\029r?Yz\fnY\foH\vYwLLr?YwuY\029wrYa/nrYM\f66ruY|z\fnYnr\v?Y6rwH\v\024Yc\fnnwr?ruY]\fuud8Y\029\fuuY\029\f?Mn\024Y\029oY\029wrY\foH\vY\001r?urYzwr\029r?Yru\024Mr?uruY|u\f\024or?6wH\vY\foH\vY\029wrYy\fH\vru8Y\029wrYnH\v/uY\029rwuruYI/?\001\fru\001r?uY\029\fY?rwu\001rM\f66ruYnwu\029d\021")
        },
        {
          Text = _t6zE("\005or?Y\029ruY\005\f668Y\029\fnnY\029oYw?\001ru\029z/Y!?/46rLrY\v\f4ruYn/66\024rn\0248Y\029\fuuY]\fuun\024Y\029oY\029\fnY.w6Mr0~ru\024r?Y\foM?oMru8Yzr6H\vrnYnwH\vYuouYwuY\029rwurLYlu5ru\024\f?Y4rMwu\029r\024Y|\020on\fLLruYLw\024YrwuYc\f\f?Y\fu\029r?ruYy\fH\vrud\021")
        },
        {
          Text = _t6zE("awrY\fu\029r?ruYy\fH\vruYwLYlu5ru\024\f?Y]\fuun\024Y\029oY\029w?Y\foH\vYu/H\vY\029\f\vrwLY\funH\v\foru8YM\f66nY\029oY\015r\024\020\024Y]rwurYjrw\024Y/\029r?Y&on\024Y\v\fn\024\021")
        },
        {
          Text = _t6zE("\031l~.vl9q\a\b%\025\a\b%\025\005\f66nY\029oY\fonYw?\001ru\029rwurLY9?ou\029Y\029wrY~\f?\024?w\029\001rYuroYn\024\f?\024ruYLonn\0248Y\029\fuuY]\fuun\024Y\029oY\f4Y\015r\024\020\024Y\029ruYN4]or?\020ou\001n0~/\029r\a\b%\025\a\b%\025\028b\019\002V\a\b%\025\a\b%\0254ruo\024\020ruYou\029Y\v\fn\024Yn/Y\foMY\015r\029ruY\005\f66Yjo\001?wMMY\foMY\029\fnY.w6Mr0~ru\024r?\021\a\b%\025N6n/Y4w\024\024rY\001o\024YLr?]ruY/\029r?Yu/\024wr?ru\021")
        },
        {
          Text = _t6zE("Nun/un\024ruY]\fuun\024Y\029oY\029wrY~\f?\024?w\029\001rY\015r\024\020\024Yrw\001ru\0246wH\vY4rru\029ru\021\a\b%\025\a\b%\025ar?Y%rn\024Y\029wrnrnY~\fH\vrnYwn\024Yrw\001ru\0246wH\vYr\vr?YrwuY\014o6\024w\021")
        },
        {
          Text = _t6zE("Cu\029YM\f66nYrnYw?\001ru\029z/Y!?/46rLrY\001w4\024You\029Y\029oY/\vurY.w6MrYuwH\v\024YLr\v?Yzrw\024r?Y]/LLn\0248Y\029\fuuYn\024\f?\024rY\029wrY~\f?\024?w\029\001rYzwr\029r?Y|5/uYrwurLY\f4\001rncrwH\vr?\024ruYycwr6Y/\029r?YM\f66nY\029\fnYuwH\v\024YL/r\0016wH\vYnrwuYn/66\024r8Y\029ruYN4]or?\020ou\001n0~/\029rY\028b\019\002VYuo\024\020rudYou\029Y4rnoH\vrY\029\fnY.w6Mr0~ru\024r?\021")
        },
        {
          Text = _t6zE("Cu\029YM\f66nY\029w?Y\029wrY5/uYLw?Yc?/\001?\fLLwr?\024rY.w6MrY\029/H\vYL\f6YuwH\v\024Yzrw\024r?\vr6MruY]\fuu8Yzrw6YrwuY!?/46rLY\foM\001r\024?r\024ruYwn\0248Yzr6H\vrnYwH\vYuwH\v\024Y5/?\vr?\001rnr\vruY\v\f4r8Y\029\fuuY]\fuun\024Y\029oYwLYjzrwMr6nM\f66YwLLr?Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029rY|\foH\vYzruuY\029rLYuwH\v\024Yn/Ywn\024dYou\029Y\029oY4r]/LLn\024Y\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uYLw\024\001r\024rw6\024\021\a\b%\025,wuYa\004\005Ywn\024Y\029\f\vr?Yrw\001ru\0246wH\vY\fon\001rnH\v6/nnru\021")
        }
      }, function(action)
        _f19.Active = false
        _c8h:MoveTo(Player)
        _gsDE:MoveTo(Player)
        _A4jFc:MoveTo(Player)
        _XUJvy:MoveTo(Player)
        _xy4:RequestSync()
      end)
    end
  else
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("Cu\0016\fo46wH\vq\a\b%\025\a\b%\025awrnrYNu\024z/?\024Ywn\024Y?wH\v\024w\001q")
      },
      {
        Text = _t6zE("a\fnYQow\020Ywn\024Y\029\fLw\024Y4rn\024\fu\029ru\021")
      },
      {
        Text = _t6zE("awrYE/L4wu\f\024w/uYMor?Y\029\fnYj\f\v6runH\v6/nnY4rwYy\024\f\001rY\0284Y6\fo\024r\024\\\a\b%\025\a\b%\025\002\019\019\002"),
        Media = _FJO
      },
      {
        Text = _t6zE("\005or?Y\029wrYy\024\f\001rY\028Y4Y4ru/r\024w\001n\024Y\029oYrwurY\029r?Y4rw\029ruY4r?rw\024\001rn\024r66\024ruY!/zr?4\fu]n\021YawrnrYn/66\024n\024Y\029oY\029\fu\fH\vY\foH\vYLw\024YwuY\029ruY\031\f6\029Yur\vLruY|c\fnnru\029rYE\f4r6Y\001w4\024YrnY\015rzrw6nY5/?Y(?\024Y4rwY\029ruYru\024nc?rH\vru\029ruYy\024\f\024w/urud\021\a\b%\025\bw\024\024rY\foH\vYLw\024ur\vLru8YzruuY\029oYnr64r?YnH\v/uYrwurYrw\001rurY!/zr?4\fu]Y\029\f4rwY\v\f4ruYn/66\024rn\024q"),
        Media = _iVxDU
      },
      {
        Text = _t6zE("N4r?Yuo?Y,l\004,Y!/zr?4\fu]YLw\024ur\vLruYou\029Y\foMY]rwuruY\005\f66Y\f66rY4rw\029r\021\a\b%\025,5ru\024or66Y4rnoH\v\024Y\vro\024rY\015\fYu/H\vYrwuY\fu\029r?rnYvr\fLY\029ruY\b/uon\021")
      },
      {
        Text = _t6zE("awrY!/zr?4\fu]Yzw?\029Y4rwYrwuw\001ruYy\024\f\024w/uruY4ru/r\024w\001\024\021\a\b%\025aoY]\fuun\024Y\f4r?Y\foH\vY\001r?urYou\024r?zr\001nY\029rwuY.\fu\0291Y\029\fLw\024Y\foM6\f\029ru8Yn/Mr?uY\029oYrwuYc\fnnru\029rnYE\f4r6Y\029\f4rwY\v\f4ruYn/66\024rn\024Y/\029r?Y\029rwuY.\fu\0291Ywu\029o]\024w5rnY&\f\029ruYou\024r?n\024or\024\020\024\021\a\b%\025awrYE\fc\f\020w\024\fr\024Y\029r?Y!/zr?4\fu]Yn/66\024rY\029\fMor?Y\foMY\015r\029ruY\005\f66Y\001?/nnY\001ruo\001Ynrwu\021")
      },
      {
        Text = _t6zE("\004\fH\vY\029rLY\brnoH\vY\029rnY\005wu\f6nY\029\f?Mn\024Y\029oYu\f\024or?6wH\vYuwH\v\024Y5r?\001rnnru8Y\029wrY!/zr?4\fu]Y\foH\vYzwr\029r?Y\020o?orH]\020o6r\001ru8Y\029\fLw\024YnwrYzwr\029r?Y\fo\024/L\f\024wnH\vYwu\029o]\024w5Y\foM\001r6\f\029ruYzw?\029You\029YMor?Y\029wrYu\frH\vn\024ruY~\fH\vr?Y4r?rw\024Yn\024r\v\024\021")
      },
      {
        Text = _t6zE("awrY\001\fu\020rY,~N8Y\029wrY\029oY5/?\vwuY4rwLY\014o6\024wYLw\024\001rnH\v6rcc\024Y\v\fn\0248Y4?\foH\vn\024Y\029oY\015r\024\020\024Y4rwLY\b/uonYu\f\024or?6wH\vYuwH\v\024YLr\v?You\029Yn/66\024rn\024YnwrY\020o?orH]c\fH]ru8YM\f66nYu/H\vYuwH\v\024Y\001rnH\vr\vru\021")
      },
      {
        Text = _t6zE("awrYIr?n\024rH]rY\029r?Yy\024\f\001rnY|ou\029Y\foH\vY\029\fnY\005wu\f6dYnwu\029Y4wnY\foMY\001\fu\020Yzruw\001rYNonu\f\vLruY\b/\029ru5r?n\024rH]r\021\a\b%\025\brwY\001rnH\v6/nnrur?YM?wnH\vr?YyH\vurr\029rH]rY\029or?M\024rYrnYnr\v?YnH\vzr?Yzr?\029ru8Ynr64w\001rY\020oYMwu\029ru\021\a\b%\025N4r?YLw\024Y.w6MrY\029r?YwuY\029r?Y~\f\024?w\029\001rY4r?rw\024\001rn\024r66\024ruYyc/w6r?4w6\029r?Yn/66\024rY\foH\vY\029\fnYL/r\0016wH\vYnrwu\021")
      },
      {
        Text = _t6zE("9N\004jY\031l~.vl9q\a\b%\025\a\b%\025\bw\024\024rY\029wrYarH]r6Y\029r?Y\b/\029ru5r?n\024rH]rYzwr\029r?Yc\fnn\001ru\foY\foM6r\001ruYou\029Y\029\f4rwY\029\f?\foMY\fH\v\024ru8Y\029\fnnYnwH\vY]rwurYNrn\024r8Y\b6\fr\024\024r?Y/\029r?YvN%\004\005(&l,Y\020zwnH\vruY%\fu\029You\029YarH]r6Y4rMwu\029ru\021\a\b%\025a\fuuYu/H\vY\029ruY,?M/6\001Y]/u\024?/66wr?ru8Ywu\029rLY\029oYc?/4wr?n\024Y\029ruYarH]r6Y\020oY5r?nH\vwr4ruY|zruuY\029\fnYwuY]rwurY%wH\v\024ou\001Y\001r\v\0248Y\029\fuuYc\fnn\024Yrnd\021\a\b%\025NunH\v6wrnnru\029Yzwr\029r?YrwuY9rzwH\v\024Y\foMY\029ruYarH]r6Y6r\001ruY|wuY\029r?Y%r\001r6Yz/\v6Y\029\fnY9rzwH\v\0248Yzr6H\vrnY\029oY\foH\vY\foMY\029rLYarH]r6Y5/?\001rMou\029ruY\v\f4ruYn/66\024rn\024d\021")
      },
      {
        Text = _t6zE("\031ruuY\029w?Y\001?/rnnr?rY\014ru\001ruY\fuY\b6\fr\024\024r?u8YNrn\024ruY/\029r?Yz\fnY\foH\vYwLLr?YwuY\029wrYa/nrYM\f66ruY|z\fnYnr\v?Y6rwH\v\024Yc\fnnwr?ruY]\fuud8Y\029\fuuY\029\f?Mn\024Y\029oY\029wrY\foH\vY\001r?urYzwr\029r?Yru\024Mr?uruY|u\f\024or?6wH\vY\foH\vY\029wrYy\fH\vru8Y\029wrYnH\v/uY\029rwuruYI/?\001\fru\001r?uY\029\fY?rwu\001rM\f66ruYnwu\029d\021")
      },
      {
        Text = _t6zE("\005or?Y\029ruY\005\f668Y\029\fnnY\029oYw?\001ru\029z/Y!?/46rLrY\v\f4ruYn/66\024rn\0248Y\029\fuuY]\fuun\024Y\029oY\029\fnY.w6Mr0~ru\024r?Y\foM?oMru8Yzr6H\vrnYnwH\vYuouYwuY\029rwurLYlu5ru\024\f?Y4rMwu\029r\024Y|\020on\fLLruYLw\024YrwuYc\f\f?Y\fu\029r?ruYy\fH\vrud\021")
      },
      {
        Text = _t6zE("awrY\fu\029r?ruYy\fH\vruYwLYlu5ru\024\f?Y]\fuun\024Y\029oY\029w?Y\foH\vYu/H\vY\029\f\vrwLY\funH\v\foru8YM\f66nY\029oY\015r\024\020\024Y]rwurYjrw\024Y/\029r?Y&on\024Y\v\fn\024\021")
      },
      {
        Text = _t6zE("\031l~.vl9q\a\b%\025\a\b%\025\005\f66nY\029oY\fonYw?\001ru\029rwurLY9?ou\029Y\029wrY~\f?\024?w\029\001rYuroYn\024\f?\024ruYLonn\0248Y\029\fuuY]\fuun\024Y\029oY\f4Y\015r\024\020\024Y\029ruYN4]or?\020ou\001n0~/\029r\a\b%\025\a\b%\025\028b\019\002V\a\b%\025\a\b%\0254ruo\024\020ruYou\029Y\v\fn\024Yn/Y\foMY\015r\029ruY\005\f66Yjo\001?wMMY\foMY\029\fnY.w6Mr0~ru\024r?\021\a\b%\025N6n/Y4w\024\024rY\001o\024YLr?]ruY/\029r?Yu/\024wr?ru\021")
      },
      {
        Text = _t6zE("Nun/un\024ruY]\fuun\024Y\029oY\029wrY~\f?\024?w\029\001rY\015r\024\020\024Yrw\001ru\0246wH\vY4rru\029ru\021\a\b%\025\a\b%\025ar?Y%rn\024Y\029wrnrnY~\fH\vrnYwn\024Yrw\001ru\0246wH\vYr\vr?YrwuY\014o6\024w\021")
      },
      {
        Text = _t6zE("Cu\029YM\f66nYrnYw?\001ru\029z/Y!?/46rLrY\001w4\024You\029Y\029oY/\vurY.w6MrYuwH\v\024YLr\v?Yzrw\024r?Y]/LLn\0248Y\029\fuuYn\024\f?\024rY\029wrY~\f?\024?w\029\001rYzwr\029r?Y|5/uYrwurLY\f4\001rncrwH\vr?\024ruYycwr6Y/\029r?YM\f66nY\029\fnYuwH\v\024YL/r\0016wH\vYnrwuYn/66\024r8Y\029ruYN4]or?\020ou\001n0~/\029rY\028b\019\002VYuo\024\020rudYou\029Y4rnoH\vrY\029\fnY.w6Mr0~ru\024r?\021")
      },
      {
        Text = _t6zE("Cu\029YM\f66nY\029w?Y\029wrY5/uYLw?Yc?/\001?\fLLwr?\024rY.w6MrY\029/H\vYL\f6YuwH\v\024Yzrw\024r?\vr6MruY]\fuu8Yzrw6YrwuY!?/46rLY\foM\001r\024?r\024ruYwn\0248Yzr6H\vrnYwH\vYuwH\v\024Y5/?\vr?\001rnr\vruY\v\f4r8Y\029\fuuY]\fuun\024Y\029oYwLYjzrwMr6nM\f66YwLLr?Y\fu\001r4ru8Y\029\fnnY\029wrYy\024\f\024w/uY\001rLo\001\001r6\024Yzo?\029rY|\foH\vYzruuY\029rLYuwH\v\024Yn/Ywn\024dYou\029Y\029oY4r]/LLn\024Y\029wrYE//?\029wu\f\024ruYMor?Y\029wrYu\frH\vn\024rYy\024\f\024w/uYLw\024\001r\024rw6\024\021\a\b%\025,wuYa\004\005Ywn\024Y\029\f\vr?Yrw\001ru\0246wH\vY\fon\001rnH\v6/nnru\021")
      }
    }, function(action)
      _f19.Active = false
      _c8h:MoveTo(Player)
      _gsDE:MoveTo(Player)
      _A4jFc:MoveTo(Player)
      _XUJvy:MoveTo(Player)
      _xy4:RequestSync()
    end)
  end
end
function _S2k()
  if _okAj == true then
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnY\v\f\024Y\015\fYnH\v/uYL\f6Y\001o\024Y\001r]6\fcc\024\021")
      },
      {
        Text = _t6zE("N6nYu\frH\vn\024rnYLonn\024Y\029oY\015r\024\020\024Yu/H\vY\029wrYyoLLrY\029r?YI\f?w\f46ruYNY4wnY!Yrwu\001r4ru\021YawrnrYI\f?w\f46ruYn/66\024rn\024Y\029oY\029w?Y5/?\vwuYz\fr\v?ru\029Y\029rnY\brnoH\vnY\029rnY\014o6\024wnYu/\024wr?\024Y\v\f4ru\021\a\b%\025ywrYz\f?ruYLw\024YCI0,\029\029wu\001Y4rwY\029ruY\031\f6\029n\024\f\024w/uruY5r?n\024rH]\024\021")
      },
      {
        Text = _t6zE("(\vurY\029wrnrYI\f?w\f46ruY]/LLn\024Y\029oY\foMY\015r\029ruY\005\f66YuwH\v\024Yzrw\024r?\021")
      },
      {
        Text = _t6zE("\021\021\021Ywn\024Y\029\fnY\029\fY!\fuw]YwuY\029rwurLY9rnwH\v\024D"),
        Media = _D2uV6
      },
      {
        Text = _t6zE("a\fuuYzw66YwH\vY\029wH\vY\015r\024\020\024Y6wr4r?YuwH\v\024Yzrw\024r?Y\fr?\001r?u\021\a\b%\025a\fnYLw\024Y\029ruYI\f?w\f46ruYNY4wnY!Yz\f?Ynr64n\0245r?n\024\fru\0296wH\vYQo\f\024nH\v\021\a\b%\025y/Yr\024z\fnY\001\f4YrnY4rwY\029ruY\031\f6\029n\024\f\024w/uruYu\f\024or?6wH\vY\001\f?YuwH\v\024Y\020oYMwu\029ru\021")
      }
    }, function(action)
      _ReY()
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _t6zE("a\fnY\v\f\024Y\015\fYnH\v/uYL\f6Y\001o\024Y\001r]6\fcc\024\021")
      },
      {
        Text = _t6zE("N6nYu\frH\vn\024rnYLonn\024Y\029oY\015r\024\020\024Yu/H\vY\029wrYyoLLrY\029r?YI\f?w\f46ruYNY4wnY!Yrwu\001r4ru\021YawrnrYI\f?w\f46ruYn/66\024rn\024Y\029oY\029w?Y5/?\vwuYz\fr\v?ru\029Y\029rnY\brnoH\vnY\029rnY\014o6\024wnYu/\024wr?\024Y\v\f4ru\021\a\b%\025ywrYz\f?ruYLw\024YCI0,\029\029wu\001Y4rwY\029ruY\031\f6\029n\024\f\024w/uruY5r?n\024rH]\024\021")
      },
      {
        Text = _t6zE("lH\vY\v/MMr8Y\029oY\v\fn\024Y\029rwurYNoM\020rwH\vuou\001ruY5/uY\029\fL\f6nY\foM\001r\v/4ruYou\029Y\vro\024rYLw\024\001r4?\fH\v\024\021")
      },
      {
        Text = _t6zE("(\029r?Y5wr66rwH\v\024Y4wn\024Y\029oY\foH\vYn/YnH\v6\foY\001rzrnruYou\029Y\v\fn\024Y\029w?Y\029wrYI\f?w\f46ruYwuY\029r?Y!r?n/u\f6Y~\fH\vrY\004/\024rYu/\024wr?\024\021")
      },
      {
        Text = _t6zE("(\vurY\029wrnrYI\f?w\f46ruY]/LLn\024Y\029oY\foMY\015r\029ruY\005\f66YuwH\v\024Yzrw\024r?\021")
      },
      {
        Text = _t6zE("\021\021\021Ywn\024Y\029\fnY\029\fY!\fuw]YwuY\029rwurLY9rnwH\v\024D"),
        Media = _D2uV6
      },
      {
        Text = _t6zE("a\fuuYzw66YwH\vY\029wH\vY\015r\024\020\024Y6wr4r?YuwH\v\024Yzrw\024r?Y\fr?\001r?u\021\a\b%\025a\fnYLw\024Y\029ruYI\f?w\f46ruYNY4wnY!Yz\f?Ynr64n\0245r?n\024\fru\0296wH\vYQo\f\024nH\v\021\a\b%\025y/Yr\024z\fnY\001\f4YrnY4rwY\029ruY\031\f6\029n\024\f\024w/uruYu\f\024or?6wH\vY\001\f?YuwH\v\024Y\020oYMwu\029ru\021")
      }
    }, function(action)
      _ReY()
    end)
  end
end
function _7Kg()
  Wherigo.PlayAudio(_jEw)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.1 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024Y6rw\029r?YuwH\v\024Y?wH\v\024w\001\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.2 then
    _Urwigo.MessageBox({
      Text = _t6zE("\005\f6nH\vq"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.3 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYn\024wLL\024Y6rw\029r?YuwH\v\024q"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.4 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024YuwH\v\024Y\029wrY?wH\v\024w\001rYNu\024z/?\024q"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.5 then
    _Urwigo.MessageBox({
      Text = _t6zE("Ir?]r\v?\024q"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.6 then
    _Urwigo.MessageBox({
      Text = _t6zE("\004wH\v\024Y?wH\v\024w\001q"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.7 then
    _Urwigo.MessageBox({
      Text = _t6zE("awrYNu\024z/?\024Y\v\fn\024Y\029oY5r?4/H]\024\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.8 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnY\v\fr\024\024rn\024Y\029oY\029wH\vY4rnnr?YMor?YrwurY\fu\029r?rYNu\024z/?\024Yru\024nH\vwr\029ru\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _rndChoiceValue < 0.9 then
    _Urwigo.MessageBox({
      Text = _t6zE("NoMY\029rLY9r4wr\024YnH\vrwun\024Y\029oY]rwuY,pcr?\024rY\020oYnrwu\021\a\b%\025arwurYNu\024z/?\024Ywn\024Y5r?]r\v?\024\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _t6zE("\004rwu\021Yy\024wLL\024YuwH\v\024\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  end
end
function _oa4zA()
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.0625 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024Y5/66Y]/??r]\024q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.125 then
    _Urwigo.MessageBox({
      Text = _t6zE("%wH\v\024w\001q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.1875 then
    _Urwigo.MessageBox({
      Text = _t6zE("9o\024Y\001rL\fH\v\024q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.25 then
    _Urwigo.MessageBox({
      Text = _t6zE("\b?\f5/q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.3125 then
    _Urwigo.MessageBox({
      Text = _t6zE("lH\vY4wuYn\024/6\020Y\foMY\029wH\vq"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.375 then
    _Urwigo.MessageBox({
      Text = _t6zE("y\024wLL\024q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.4375 then
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024Y\029wrY?wH\v\024w\001rYNu\024z/?\024q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.5 then
    _Urwigo.MessageBox({
      Text = _t6zE("awrnrYNu\024z/?\024Yz/66\024rYwH\vY\v/r?ru\021"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.5625 then
    _Urwigo.MessageBox({
      Text = _t6zE("awrYNu\024z/?\024Yn\024wLL\024\021"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.625 then
    _Urwigo.MessageBox({
      Text = _t6zE("E?\fnnqYaoYzrwnn\024Yn/Y5wr6\021"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.6875 then
    _Urwigo.MessageBox({
      Text = _t6zE("aoY4wn\024YrH\v\024YnH\v6\foq"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.75 then
    _Urwigo.MessageBox({
      Text = _t6zE("!r?Mr]\024q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.8125 then
    _Urwigo.MessageBox({
      Text = _t6zE("jo\024?rMMru\029q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.875 then
    _Urwigo.MessageBox({
      Text = _t6zE(",wuz\fu\029M?rwq"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  elseif _rndChoiceValue < 0.9375 then
    _Urwigo.MessageBox({
      Text = _t6zE("v/66qY"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _t6zE("yocr?q"),
      Callback = function(action)
        if action ~= nil then
          __1Q()
        end
      end
    })
  end
end
function __1Q()
  _Urwigo.MessageBox({
    Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
    Callback = function(action)
      if action ~= nil then
        if _VZ6M == 9 then
          _Urwigo.MessageBox({
            Text = _t6zE(" r\024\020\024YMr\v6\024Yuo?Yu/H\vYrwuYrwu\020w\001r?Y!ou]\024\021\a\b%\02596rwH\vY\v\fn\024Y\029oYrnY\001rnH\v\fMM\024\021"),
            Callback = function(action)
              if action ~= nil then
                _lmva()
              end
            end
          })
        else
          _NF2x2()
        end
      end
    end
  })
end
function _c1N()
  if _fSrW6 == true then
    _Urwigo.MessageBox({
      Text = _t6zE("lH\vY\v\f\024\024rY\001\fu\020Y5r?\001rnnruY\020oYr?z\fr\vuru8Y\029\fnnYL\fuY4rwYrwur?YM\f6nH\vruYNu\024z/?\024Yu\f\024or?6wH\vY\foH\vY!ou]\024rY\f4\001r\020/\001ruY4r]/LL\024\021\a\b%\025\a\b%\025N6n/Y6wr4r?YwuYjo]ouM\024YrwuYzruw\001YLr\v?Y]/u\020ru\024?wr?ruq"),
      Callback = function(action)
        if action ~= nil then
          _fSrW6 = false
          _Urwigo.MessageBox({
            Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
            Callback = function(action)
              if action ~= nil then
                if _kSc >= 1 and _kSc < 3 then
                  _lmva()
                else
                  _NF2x2()
                end
              end
            end
          })
        end
      end
    })
  elseif _VZ6M < -4 or _kSc == 3 then
    _Urwigo.MessageBox({
      Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
      Callback = function(action)
        if action ~= nil then
          _Gps44()
        end
      end
    })
  elseif _kSc >= 1 and _kSc < 3 then
    _Urwigo.MessageBox({
      Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
      Callback = function(action)
        if action ~= nil then
          _lmva()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _t6zE("arwurY\f]\024or66rY!ou]\024\020\f\v6\\Y") .. _VZ6M,
      Callback = function(action)
        if action ~= nil then
          _NF2x2()
        end
      end
    })
  end
end
function _P55()
  if _kSc == 1 then
    _Urwigo.MessageBox({
      Text = _t6zE("y/Y]u\fccY5/?Y\029rLYjwr6You\029Y\029\fuuY5r?]\fH]n\024Y\029oY\029wrnrY\005?\f\001r\021\a\b%\025a\fnYwn\024Y\024?\fo?w\001\021\a\b%\025N4r?Yu/H\vYwn\024Y./cMruYou\029Y\014\f6\020YuwH\v\024Y5r?6/?ru\021\a\b%\025lH\vYzorunH\vrY\029w?Yzwr\029r?YLr\v?Y,?M/6\001Y4rwY\029r?Yu\frH\vn\024ruY\005?\f\001r\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  elseif _kSc == 2 then
    _Urwigo.MessageBox({
      Text = _t6zE("yH\v/uYzwr\029r?Y5r?]r\v?\024\021\a\b%\025a\f4rwY\v\f\024\024rYrnYn/Y\001o\024Y\fu\001rM\fu\001ru\021\a\b%\025%rwnnY\029wH\vY\001rM\fr66w\001n\024YL\f6Y\020on\fLLruq"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _t6zE("a\fnYwn\024Y\015r\024\020\024YnH\v/uY\029wrY\029?w\024\024rY\005?\f\001rY\vwu\024r?rwu\fu\029r?8Y\029wrY\029oY5r?4/H]\024Y\v\fn\024qYa\fnYwn\024Yor4r6\021\021\021"),
      Callback = function(action)
        if action ~= nil then
          _c1N()
        end
      end
    })
  end
end
function _1SAU()
  _Urwigo.MessageBox({
    Text = _t6zE(".\fn\024Y\029oY\029wrY.w6MrYMor?Y\029wrnrYy\024\f\001rY4r?rw\024nY\001ruo\024\020\024You\029Y4wn\024Y\024?/\024\020\029rLYuwH\v\024Yzrw\024r?Y\001r]/LLru8Yn/Y\029\fnnYwH\vY\029w?Y\015r\024\020\024Y\029wrYE//?\029wu\f\024ruYMor?Y\029wrYy\024\f\001rYbY5r??\f\024ruYLonnD"),
    Buttons = {
      _t6zE("\004o?Y.w6Mr"),
      _t6zE("E//?\029wu\f\024r?u")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _HbrUx()
        else
          _Urwigo.Dialog(false, {
            {
              Text = _t6zE("awrYy\024\f\024w/uYwn\024Y\v/MMru\0246wH\vYuwH\v\024Y\001rLo\001\001r6\024Yz/?\029ru\021"),
              Media = _FJO
            },
            {
              Text = _t6zE("awrYy\024\f\024w/uYn/66\024rYrw\001ru\0246wH\vYM/6\001ru\029rnY4rwu\v\f6\024ru\\\a\b%\025\a\b%\0250YyH\vz\f?\020rYv\fnH\vrYLw\024Y\031\fr?Lr4w6\029]\fLr?\a\b%\0250Y&/H]Z\fLc`&/H]0a/nrYLw\024YNu6rw\024ou\0018YCy\b0E\f4r6You\029You\001rz/r\vu6wH\vr?Y!6\f\024wur")
            },
            {
              Text = _t6zE("a\fLw\024Y\029oY\029ruY\031l9Y\024?/\024\020Y\029r?Your?z\f?\024r\024ruY!?/46rLrYzrw\024r?ncwr6ruY]\fuun\0248Yzr?\029rYwH\vY\029w?Y\0016rwH\vY\029wrYE//?\029wu\f\024ruY\029r?Yu\frH\vn\024ruYy\024\f\024w/uY5r??\f\024ru\021")
            },
            {
              Text = _t6zE("a\fLw\024YwH\vY\015r\029/H\vY\foMY\015r\029ruY\005\f66Yn/M/?\024Y4ru\fH\v?wH\v\024w\001\024Yzr?\029r8YzruuYrwurYy\024\f\001rY4rnH\v\fr\029w\001\024Y/\029r?Y\001rLo\001\001r6\024Yzo?\029rY|/\029r?Y\029\fnnY\029wrYc?/\001?\fLLwr?\024rY.w6MrYrwuM\fH\vYuwH\v\024Y\fon?rwH\v\024d8YLonn\024Y\029oY5/?\vr?Y\029ruY\004/\024M\f660Q%0~/\029rY\foMY\029r?Y!/zr?4\fu]YnH\fuuru\021")
            },
            {
              Text = _t6zE("Cu\029Y\029\fLw\024YwH\vYuwH\v\024Y4rou?o\vw\001\024Yzr?\029r8YzruuY\015rL\fu\029Y\fonYIr?nr\vruY\029wrnruYQ%0~/\029rYnc\fr\024r?Yu/H\vYL\f6Y\foM?oM\0248Yzrw6Yr?Yw\vuYw?\001ru\029zwrYwuYnrwur?YNccY\001rncrwH\vr?\024Y\v\f\0248YLonnYL\fuY\020on\fr\024\0206wH\vYu/H\vYrwuYn/\001ru\fuu\024rnYy\024\f\001r0!\fnnz/?\024Yrwu\001r4ru\021\a\b%\025\a\b%\025yr64w\001rnY6\fo\024r\024\\Y{xXT")
            }
          }, function(action)
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_TIN_i)
            end)
          end)
        end
      end
    end
  })
end
return _xy4
