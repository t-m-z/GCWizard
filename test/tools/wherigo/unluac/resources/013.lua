require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _l_a8(str)
  local res = ""
  local dtable = "\nn:Q\000B@.+P\005R$\003^V\019KZz4\aG2\030\028he'p(#,~L=xW\020u>HT\026<F-m\006O]cAM\027\002v/7\ft\023q1\004\0220`\031\001j|\015\t\"\016\024Ur&;\014 lS\bYb!9_56XJ[\v?a\025\017is\021y\0298C)\\{\018\r}dDkw%3fg*oENI"
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
_4Ial = Wherigo.ZCartridge()
_ltdg = Wherigo.ZMedia(_4Ial)
_ltdg.Id = "bffa823b-2150-4731-82bb-00c86e6a0755"
_ltdg.Name = _l_a8("}\n\n}#}\127~")
_ltdg.Description = ""
_ltdg.AltText = ""
_ltdg.Resources = {
  {
    Type = "jpg",
    Filename = "EPPELEIN.jpg",
    Directives = {}
  }
}
_OjvCQ = Wherigo.ZMedia(_4Ial)
_OjvCQ.Id = "8ae83be0-f794-4cd6-bc89-3bccc8d79c8a"
_OjvCQ.Name = _l_a8("5/.Ocz\028")
_OjvCQ.Description = ""
_OjvCQ.AltText = ""
_OjvCQ.Resources = {
  {
    Type = "jpg",
    Filename = "A-FRAGE.jpg",
    Directives = {}
  }
}
_7At = Wherigo.ZMedia(_4Ial)
_7At.Id = "27fb8983-0ad8-4a89-85d4-18532fe3ccf8"
_7At.Name = _l_a8("_/.Ocz\028")
_7At.Description = ""
_7At.AltText = ""
_7At.Resources = {
  {
    Type = "jpg",
    Filename = "J-FRAGE.jpg",
    Directives = {}
  }
}
_XRVrX = Wherigo.ZMedia(_4Ial)
_XRVrX.Id = "a6d8150b-d976-4c2b-85dd-687155f84672"
_XRVrX.Name = _l_a8("\127/.Ocz\028")
_XRVrX.Description = ""
_XRVrX.AltText = ""
_XRVrX.Resources = {
  {
    Type = "jpg",
    Filename = "I-FRAGE.jpg",
    Directives = {}
  }
}
_L0Wl2 = Wherigo.ZMedia(_4Ial)
_L0Wl2.Id = "12adec54-63b5-458c-aec0-ca35cba1ee1c"
_L0Wl2.Name = _l_a8("\006/.Ocz\028")
_L0Wl2.Description = ""
_L0Wl2.AltText = ""
_L0Wl2.Resources = {
  {
    Type = "jpg",
    Filename = "B-FRAGE.jpg",
    Directives = {}
  }
}
_3ta = Wherigo.ZMedia(_4Ial)
_3ta.Id = "5067c87d-5472-4cb6-bb7b-7bed0f2bcfcb"
_3ta.Name = _l_a8("*/.Ocz\028")
_3ta.Description = ""
_3ta.AltText = ""
_3ta.Resources = {
  {
    Type = "jpg",
    Filename = "H-FRAGE.jpg",
    Directives = {}
  }
}
_nJv4 = Wherigo.ZMedia(_4Ial)
_nJv4.Id = "48bbcbcc-b7d1-4595-99c3-45d52e3cb75b"
_nJv4.Name = _l_a8("l/.Ocz\028")
_nJv4.Description = ""
_nJv4.AltText = ""
_nJv4.Resources = {
  {
    Type = "jpg",
    Filename = "C-FRAGE.jpg",
    Directives = {}
  }
}
_fe6y = Wherigo.ZMedia(_4Ial)
_fe6y.Id = "3ff182ee-b408-4358-bd35-0d483b7cbed4"
_fe6y.Name = _l_a8("\023/.Ocz\028")
_fe6y.Description = ""
_fe6y.AltText = ""
_fe6y.Resources = {
  {
    Type = "jpg",
    Filename = "G-FRAGE.jpg",
    Directives = {}
  }
}
_FEp = Wherigo.ZMedia(_4Ial)
_FEp.Id = "94ab8cbe-00fd-4e3b-bf33-43be00407a26"
_FEp.Name = _l_a8("t/.Ocz\028")
_FEp.Description = ""
_FEp.AltText = ""
_FEp.Resources = {
  {
    Type = "jpg",
    Filename = "D-FRAGE.jpg",
    Directives = {}
  }
}
_pKRd = Wherigo.ZMedia(_4Ial)
_pKRd.Id = "f88428bf-35ad-457d-a55a-4e08a2c2d194"
_pKRd.Name = _l_a8("./.Ocz\028")
_pKRd.Description = ""
_pKRd.AltText = ""
_pKRd.Resources = {
  {
    Type = "jpg",
    Filename = "F-FRAGE.jpg",
    Directives = {}
  }
}
_lYTz2 = Wherigo.ZMedia(_4Ial)
_lYTz2.Id = "361b6f5e-0852-4b41-8c4c-caa2cde3bdb6"
_lYTz2.Name = _l_a8("}/.Ocz\028")
_lYTz2.Description = ""
_lYTz2.AltText = ""
_lYTz2.Resources = {
  {
    Type = "jpg",
    Filename = "E-FRAGE.jpg",
    Directives = {}
  }
}
_us6d = Wherigo.ZMedia(_4Ial)
_us6d.Id = "9b424c23-a397-48a1-885e-01e400412dce"
_us6d.Name = _l_a8("\021;@@")
_us6d.Description = ""
_us6d.AltText = ""
_us6d.Resources = {
  {
    Type = "jpg",
    Filename = "hhhh.jpg",
    Directives = {}
  }
}
_sbBa = Wherigo.ZMedia(_4Ial)
_sbBa.Id = "74dac357-27c8-4060-8c53-44e95290c9e6"
_sbBa.Name = _l_a8("\021;@x")
_sbBa.Description = ""
_sbBa.AltText = ""
_sbBa.Resources = {
  {
    Type = "jpg",
    Filename = "eeee.jpg",
    Directives = {}
  }
}
_xfAsS = Wherigo.ZMedia(_4Ial)
_xfAsS.Id = "1dc4dcc9-5730-4817-b1ba-78136555c229"
_xfAsS.Name = _l_a8("@\024@\024@\024\024@")
_xfAsS.Description = ""
_xfAsS.AltText = ""
_xfAsS.Resources = {
  {
    Type = "jpg",
    Filename = "dddd.jpg",
    Directives = {}
  }
}
_24Vo = Wherigo.ZMedia(_4Ial)
_24Vo.Id = "23ce7a82-7209-454b-b404-a7efd788c99a"
_24Vo.Name = _l_a8("kkkkkk")
_24Vo.Description = ""
_24Vo.AltText = ""
_24Vo.Resources = {
  {
    Type = "jpg",
    Filename = "jjjj.jpg",
    Directives = {}
  }
}
_Uu7 = Wherigo.ZMedia(_4Ial)
_Uu7.Id = "be1a0417-b9b4-4f49-9a5b-b2a5ce6e8f4e"
_Uu7.Name = _l_a8("x\024\024x\024\024x\024")
_Uu7.Description = ""
_Uu7.AltText = ""
_Uu7.Resources = {
  {
    Type = "jpg",
    Filename = "ffff.jpg",
    Directives = {}
  }
}
_wYI = Wherigo.ZMedia(_4Ial)
_wYI.Id = "8e83ea08-4ee2-4788-afc0-f3b191330ec7"
_wYI.Name = _l_a8("\024x\024x\024xx\024x\024x\024x\024")
_wYI.Description = ""
_wYI.AltText = ""
_wYI.Resources = {
  {
    Type = "jpg",
    Filename = "iiii.jpg",
    Directives = {}
  }
}
_3EkEs = Wherigo.ZMedia(_4Ial)
_3EkEs.Id = "ee8b1efb-3c44-4578-a73c-671da718f610"
_3EkEs.Name = _l_a8("Z\024Z@Zxk\021;\024Z\024")
_3EkEs.Description = ""
_3EkEs.AltText = ""
_3EkEs.Resources = {
  {
    Type = "jpg",
    Filename = "bbbb.jpg",
    Directives = {}
  }
}
_Yj2 = Wherigo.ZMedia(_4Ial)
_Yj2.Id = "9d2a88d9-e2d8-490a-a7cb-bd1dddcbc7d8"
_Yj2.Name = _l_a8("\019NS\016\127}#}S\0192~}~")
_Yj2.Description = ""
_Yj2.AltText = ""
_Yj2.Resources = {
  {
    Type = "jpg",
    Filename = "gespannterSmiley.jpg",
    Directives = {}
  }
}
_TDdoC = Wherigo.ZMedia(_4Ial)
_TDdoC.Id = "95d921f2-5011-46a6-8e5f-910270bd6e7d"
_TDdoC.Name = _l_a8("~}\127~")
_TDdoC.Description = ""
_TDdoC.AltText = ""
_TDdoC.Resources = {
  {
    Type = "jpg",
    Filename = "AUSRUFEZEICHEN.jpg",
    Directives = {}
  }
}
_FrVdJ = Wherigo.ZMedia(_4Ial)
_FrVdJ.Id = "2e4b0e7d-4fc4-466e-9576-e58f20046a6b"
_FrVdJ.Name = _l_a8("\028OT\028sfz=")
_FrVdJ.Description = ""
_FrVdJ.AltText = ""
_FrVdJ.Resources = {
  {
    Type = "jpg",
    Filename = "RIGHTSMILEY.jpg",
    Directives = {}
  }
}
_2OMEK = Wherigo.ZMedia(_4Ial)
_2OMEK.Id = "50ddac5a-13e3-47bd-a1fd-e72b37477dd6"
_2OMEK.Name = _l_a8("k\\;\021ZxZxZx")
_2OMEK.Description = ""
_2OMEK.AltText = ""
_2OMEK.Resources = {
  {
    Type = "jpg",
    Filename = "cccc.jpg",
    Directives = {}
  }
}
_0YoFE = Wherigo.ZMedia(_4Ial)
_0YoFE.Id = "f1af97b1-79de-44ae-b709-5321f8f99b4b"
_0YoFE.Name = _l_a8("]]]]]]]]]]]]]")
_0YoFE.Description = ""
_0YoFE.AltText = ""
_0YoFE.Resources = {
  {
    Type = "jpg",
    Filename = "AAAA.jpg",
    Directives = {}
  }
}
_jFnL = Wherigo.ZMedia(_4Ial)
_jFnL.Id = "5d9bc34c-f2a6-4055-b781-850618d2646b"
_jFnL.Name = _l_a8("\021;@\024yOcz\028")
_jFnL.Description = ""
_jFnL.AltText = ""
_jFnL.Resources = {
  {
    Type = "jpg",
    Filename = "eeeebild.jpg",
    Directives = {}
  }
}
_a5E = Wherigo.ZMedia(_4Ial)
_a5E.Id = "3395f776-4798-4af4-9c94-1d80609f15ce"
_a5E.Name = _l_a8("\021;@@S|uci")
_a5E.Description = ""
_a5E.AltText = ""
_a5E.Resources = {
  {
    Type = "mp3",
    Filename = "09.mp3",
    Directives = {}
  }
}
_fcWdF = Wherigo.ZMedia(_4Ial)
_fcWdF.Id = "8636f596-17c5-4141-aae5-14561ce4b47e"
_fcWdF.Name = _l_a8("\024\024@\024@\024@\024@")
_fcWdF.Description = ""
_fcWdF.AltText = ""
_fcWdF.Resources = {
  {
    Type = "mp3",
    Filename = "01.mp3",
    Directives = {}
  }
}
_dWfcE = Wherigo.ZMedia(_4Ial)
_dWfcE.Id = "6e753930-298f-43eb-9aab-b63d70bc79bf"
_dWfcE.Name = _l_a8("\024xZx\024kZx\024kZx\024")
_dWfcE.Description = ""
_dWfcE.AltText = ""
_dWfcE.Resources = {
  {
    Type = "mp3",
    Filename = "07.mp3",
    Directives = {}
  }
}
_6OH = Wherigo.ZMedia(_4Ial)
_6OH.Id = "d244519b-0cc5-42fa-a6ed-1c43903e983a"
_6OH.Name = _l_a8("]]]]]")
_6OH.Description = ""
_6OH.AltText = ""
_6OH.Resources = {
  {
    Type = "mp3",
    Filename = "10.mp3",
    Directives = {}
  }
}
_YR1kd = Wherigo.ZMedia(_4Ial)
_YR1kd.Id = "6d49855d-6eef-4b5e-8902-7f7e5c5f249f"
_YR1kd.Name = _l_a8(";;;;;")
_YR1kd.Description = ""
_YR1kd.AltText = ""
_YR1kd.Resources = {
  {
    Type = "mp3",
    Filename = "08.mp3",
    Directives = {}
  }
}
_o_Bf = Wherigo.ZMedia(_4Ial)
_o_Bf.Id = "71a0b620-a0e1-46e8-8eae-d570b9a871e3"
_o_Bf.Name = _l_a8("CCCZZZZxx")
_o_Bf.Description = ""
_o_Bf.AltText = ""
_o_Bf.Resources = {
  {
    Type = "mp3",
    Filename = "06.mp3",
    Directives = {}
  }
}
_P5jVk = Wherigo.ZMedia(_4Ial)
_P5jVk.Id = "54b4eabd-c1b9-4e47-94da-e48c9ca55808"
_P5jVk.Name = _l_a8("\021;@\0240\030x")
_P5jVk.Description = ""
_P5jVk.AltText = ""
_P5jVk.Resources = {
  {
    Type = "mp3",
    Filename = "05.mp3",
    Directives = {}
  }
}
_9VL = Wherigo.ZMedia(_4Ial)
_9VL.Id = "d679d1c2-fdfe-4bd2-b587-1826422e23d7"
_9VL.Name = _l_a8("\024kZ\024@Z\024@kZ\024@")
_9VL.Description = ""
_9VL.AltText = ""
_9VL.Resources = {
  {
    Type = "mp3",
    Filename = "03.mp3",
    Directives = {}
  }
}
_Aee7b = Wherigo.ZMedia(_4Ial)
_Aee7b.Id = "0c586280-24f1-42e5-8816-5e35fc17d5a5"
_Aee7b.Name = _l_a8("Z;\\x]\024;\024")
_Aee7b.Description = ""
_Aee7b.AltText = ""
_Aee7b.Resources = {
  {
    Type = "mp3",
    Filename = "02.mp3",
    Directives = {}
  }
}
_C_w = Wherigo.ZMedia(_4Ial)
_C_w.Id = "76467237-9396-44d4-9fc7-96555088ea71"
_C_w.Name = _l_a8("ZZZZZZZ")
_C_w.Description = ""
_C_w.AltText = ""
_C_w.Resources = {
  {
    Type = "mp3",
    Filename = "04.mp3",
    Directives = {}
  }
}
_2RT = Wherigo.ZMedia(_4Ial)
_2RT.Id = "1f70708e-b028-4f64-a829-084379790f8d"
_2RT.Name = _l_a8("\019f\028TyTczz\028")
_2RT.Description = ""
_2RT.AltText = ""
_2RT.Resources = {
  {
    Type = "jpg",
    Filename = "Zielflagge.jpg",
    Directives = {}
  }
}
_udt = Wherigo.ZMedia(_4Ial)
_udt.Id = "92a3ee87-494b-4b3b-8751-723b5ee50801"
_udt.Name = _l_a8("\021\021\021\021\021")
_udt.Description = ""
_udt.AltText = ""
_udt.Resources = {
  {
    Type = "mp3",
    Filename = "final.mp3",
    Directives = {}
  }
}
_FYXNA = Wherigo.ZMedia(_4Ial)
_FYXNA.Id = "1221af4e-6448-4a99-964f-853ad7a892bc"
_FYXNA.Name = _l_a8(".5#Ul*")
_FYXNA.Description = ""
_FYXNA.AltText = ""
_FYXNA.Resources = {
  {
    Type = "mp3",
    Filename = "FALSCH.mp3",
    Directives = {}
  }
}
_z37su = Wherigo.ZMedia(_4Ial)
_z37su.Id = "2b50b4da-19a4-4eec-955e-008280284242"
_z37su.Name = _l_a8("X\028zf\002\002\028\002Sgf\028S")
_z37su.Description = ""
_z37su.AltText = ""
_z37su.Resources = {
  {
    Type = "mp3",
    Filename = "STARTkurz.mp3",
    Directives = {}
  }
}
_947 = Wherigo.ZMedia(_4Ial)
_947.Id = "094bceb8-8ab2-4791-83c9-20ad4e1ee580"
_947.Name = _l_a8("W\127\n\127\127\127\127}}}")
_947.Description = ""
_947.AltText = ""
_947.Resources = {
  {
    Type = "mp3",
    Filename = "YIPIEEEE.mp3",
    Directives = {}
  }
}
_xNW = Wherigo.ZMedia(_4Ial)
_xNW.Id = "2046fe21-2719-4671-b6b9-af4d41971f8f"
_xNW.Name = _l_a8("s\028\002us\028\002u")
_xNW.Description = ""
_xNW.AltText = ""
_xNW.Resources = {
  {
    Type = "jpg",
    Filename = "DENKDENK.jpg",
    Directives = {}
  }
}
_bBX = Wherigo.ZMedia(_4Ial)
_bBX.Id = "6e879aa5-21ef-47cc-88c7-1ae55f6fcd70"
_bBX.Name = _l_a8("s\028OOf4u")
_bBX.Description = ""
_bBX.AltText = ""
_bBX.Resources = {
  {
    Type = "jpg",
    Filename = "DERRICK.jpg",
    Directives = {}
  }
}
_f2g0l = Wherigo.ZMedia(_4Ial)
_f2g0l.Id = "a810ab2b-0921-45d1-87d6-dd6f5340460d"
_f2g0l.Name = _l_a8("XcXi")
_f2g0l.Description = ""
_f2g0l.AltText = ""
_f2g0l.Resources = {
  {
    Type = "jpg",
    Filename = "BABY.jpg",
    Directives = {}
  }
}
_BgWap = Wherigo.ZMedia(_4Ial)
_BgWap.Id = "d139bfe1-af07-4d25-9d18-236c474be2a8"
_BgWap.Name = _l_a8("5l*+N~\023S&\127l*+\127\023")
_BgWap.Description = ""
_BgWap.AltText = ""
_BgWap.Resources = {
  {
    Type = "jpg",
    Filename = "wichtigwichtig.jpg",
    Directives = {}
  }
}
_dYPiH = Wherigo.ZMedia(_4Ial)
_dYPiH.Id = "21df2475-70db-45c8-adc3-7a18e45476b1"
_dYPiH.Name = _l_a8("#|z|")
_dYPiH.Description = ""
_dYPiH.AltText = ""
_dYPiH.Resources = {
  {
    Type = "jpg",
    Filename = "LOGONUE.jpg",
    Directives = {}
  }
}
_njP = Wherigo.ZMedia(_4Ial)
_njP.Id = "ac22a71b-8f57-4c67-a339-829c416f5355"
_njP.Name = _l_a8("uO\0020O=S@")
_njP.Description = ""
_njP.AltText = ""
_njP.Resources = {
  {
    Type = "jpg",
    Filename = "AufgabeBildKrnmr2021.jpg",
    Directives = {}
  }
}
_4Ial.Id = "41c179ce-65c6-4e66-a6b0-c364e6b54465"
_4Ial.Name = "HIRNZERBROESLER (N)"
_4Ial.Description = [[
Ein lustiges Silbenraetsel (nur ohne Silben). Gebe in der Cartridge den Buchstaben des Raetsels ein. Dann gib die Loesung ein (ein Wort, kein Leerzeichen und Sonderzeichen wie folgt: ae, ue, oe, ss statt scharfes "S"). Bist du richtig, gehe zu diesem Ort und suche dort eine beschriebene Info. Hast du alle Infos der 10 Orte gibt es die Finalkoordinaten. Hier die Raetsel:<BR>
<BR>
A: stark alkoholisches Getraenk, dass sich bei Angebot und Nachfrage trifft<BR>
B: unbefleckte kuenstliche Erhebung<BR>
C: Pinker-Kleinstaat-Ort<BR>
D: fuer Vegetarier verbotene Moeglichkeit, ans andere Ufer zu kommen<BR>
E: Bindung, die sehr schnell ins Schleudern kommt<BR>
F: Schmerzschrei einer Schenkung (Mehrzahl), wo Frauen oft dahin schmelzen<BR>
G: Der Beste eines bekannten Naehmaschinenherstellers in einer Stadt in Sachsen-Anhalt<BR>
H: Aufzeichnung in der Mitte<BR>
I: &nbsp;Zweitplatzierter grosser Weiher<BR>
J: Nicht Moritz hat einen Treffer gemacht<BR>
<BR>
Empfohlene, aber nicht verpflichtende Zeit beim Final: MO-FR 10-19 Uhr, SA 10-18 Uhr]]
_4Ial.Visible = true
_4Ial.Activity = "Geocache"
_4Ial.StartingLocationDescription = " N 49\194\176 27.245 E 011\194\176 04.695 (fiktiv)"
_4Ial.StartingLocation = ZonePoint(49.454083, 11.07825, 0)
_4Ial.Version = "2.4"
_4Ial.Company = ""
_4Ial.Author = "BROESEL1972"
_4Ial.BuilderVersion = "URWIGO 1.22.5798.37755"
_4Ial.CreateDate = "03/27/2015 18:47:19"
_4Ial.PublishDate = "1/1/0001 12:00:00 AM"
_4Ial.UpdateDate = "01/26/2021 17:09:46"
_4Ial.LastPlayedDate = "1/1/0001 12:00:00 AM"
_4Ial.TargetDevice = "PocketPC"
_4Ial.TargetDeviceVersion = "0"
_4Ial.StateId = "1"
_4Ial.CountryId = "2"
_4Ial.Complete = false
_4Ial.UseLogging = true
_4Ial.Media = _dYPiH
_4Ial.Icon = _dYPiH
_r9V = Wherigo.Zone(_4Ial)
_r9V.Id = "27239b41-d302-483d-8726-8ca126b85465"
_r9V.Name = _l_a8("\018|O\0020cOu=")
_r9V.Description = ""
_r9V.Visible = true
_r9V.Media = _0YoFE
_r9V.Commands = {}
_r9V.DistanceRange = Distance(-1, "feet")
_r9V.ShowObjects = "OnEnter"
_r9V.ProximityRange = Distance(30, "meters")
_r9V.AllowSetPositionTo = false
_r9V.Active = false
_r9V.Points = {
  ZonePoint(49.4493264676893, 11.0767132043839, 0),
  ZonePoint(49.4487806682208, 11.0767239332199, 0),
  ZonePoint(49.4488469317392, 11.0741704702377, 0),
  ZonePoint(49.4494398118649, 11.0743018984795, 0)
}
_r9V.OriginalPoint = ZonePoint(49.4490984698785, 11.0754773765803, 0)
_r9V.DistanceRangeUOM = "Feet"
_r9V.ProximityRangeUOM = "Meters"
_r9V.OutOfRangeName = ""
_r9V.InRangeName = ""
_8Rse7 = Wherigo.Zone(_4Ial)
_8Rse7.Id = "4f03367e-f4d8-47e6-b306-3e30fa33e24e"
_8Rse7.Name = _l_a8("6c%=|O")
_8Rse7.Description = ""
_8Rse7.Visible = true
_8Rse7.Media = _24Vo
_8Rse7.Commands = {}
_8Rse7.DistanceRange = Distance(-1, "feet")
_8Rse7.ShowObjects = "OnEnter"
_8Rse7.ProximityRange = Distance(30, "meters")
_8Rse7.AllowSetPositionTo = false
_8Rse7.Active = false
_8Rse7.Points = {
  ZonePoint(49.4586546883468, 11.081240773201, 0),
  ZonePoint(49.4581525788756, 11.0814017057419, 0),
  ZonePoint(49.4587348859109, 11.0829305648804, 0),
  ZonePoint(49.4592439630395, 11.0824424028397, 0)
}
_8Rse7.OriginalPoint = ZonePoint(49.4586965290432, 11.0820038616658, 0)
_8Rse7.DistanceRangeUOM = "Feet"
_8Rse7.ProximityRangeUOM = "Meters"
_8Rse7.OutOfRangeName = ""
_8Rse7.InRangeName = ""
_bYH = Wherigo.Zone(_4Ial)
_bYH.Id = "e712bdb4-53b9-4a95-94ea-08b8de753224"
_bYH.Name = _l_a8("UfTX\028Og\028\028")
_bYH.Description = ""
_bYH.Visible = true
_bYH.Media = _wYI
_bYH.Commands = {}
_bYH.DistanceRange = Distance(-1, "feet")
_bYH.ShowObjects = "OnEnter"
_bYH.ProximityRange = Distance(30, "meters")
_bYH.AllowSetPositionTo = false
_bYH.Active = false
_bYH.Points = {
  ZonePoint(49.4230060887304, 11.1055898666382, 0),
  ZonePoint(49.419279279543, 11.108615398407, 0),
  ZonePoint(49.4228665129637, 11.1156964302063, 0),
  ZonePoint(49.4252811177488, 11.1132287979126, 0)
}
_bYH.OriginalPoint = ZonePoint(49.4226082497465, 11.110782623291, 0)
_bYH.DistanceRangeUOM = "Feet"
_bYH.ProximityRangeUOM = "Meters"
_bYH.OutOfRangeName = ""
_bYH.InRangeName = ""
_ZAQg = Wherigo.Zone(_4Ial)
_ZAQg.Id = "6cdef2e4-9206-4576-acdb-6db1b3e2ea1b"
_ZAQg.Name = _l_a8("v\028fgg\028OS+(O0")
_ZAQg.Description = ""
_ZAQg.Visible = true
_ZAQg.Media = _3EkEs
_ZAQg.Commands = {}
_ZAQg.DistanceRange = Distance(-1, "feet")
_ZAQg.ShowObjects = "OnEnter"
_ZAQg.ProximityRange = Distance(30, "meters")
_ZAQg.AllowSetPositionTo = false
_ZAQg.Active = false
_ZAQg.Points = {
  ZonePoint(49.4507214546914, 11.0702329874039, 0),
  ZonePoint(49.4502053141273, 11.0704743862152, 0),
  ZonePoint(49.4503936363141, 11.0713058710098, 0),
  ZonePoint(49.4509062874908, 11.0710644721985, 0)
}
_ZAQg.OriginalPoint = ZonePoint(49.4505566731559, 11.0707694292068, 0)
_ZAQg.DistanceRangeUOM = "Feet"
_ZAQg.ProximityRangeUOM = "Meters"
_ZAQg.OutOfRangeName = ""
_ZAQg.InRangeName = ""
_oz8Ni = Wherigo.Zone(_4Ial)
_oz8Ni.Id = "579db7d4-44e1-49f8-be82-f1835be1e301"
_oz8Ni.Name = _l_a8("}\027\028ucO(gg\028TT")
_oz8Ni.Description = ""
_oz8Ni.Visible = true
_oz8Ni.Media = _sbBa
_oz8Ni.Commands = {}
_oz8Ni.DistanceRange = Distance(-1, "feet")
_oz8Ni.ShowObjects = "OnEnter"
_oz8Ni.ProximityRange = Distance(30, "meters")
_oz8Ni.AllowSetPositionTo = false
_oz8Ni.Active = false
_oz8Ni.Points = {
  ZonePoint(49.4506900679204, 11.0703241825104, 0),
  ZonePoint(49.4502646008197, 11.0705602169037, 0),
  ZonePoint(49.4504250232749, 11.0712361335754, 0),
  ZonePoint(49.4508365393465, 11.0710215568542, 0)
}
_oz8Ni.OriginalPoint = ZonePoint(49.4505540578404, 11.0707855224609, 0)
_oz8Ni.DistanceRangeUOM = "Feet"
_oz8Ni.ProximityRangeUOM = "Meters"
_oz8Ni.OutOfRangeName = ""
_oz8Ni.InRangeName = ""
_K9NS3 = Wherigo.Zone(_4Ial)
_K9NS3.Id = "318de854-16fa-440e-bd83-15039d897bef"
_K9NS3.Name = _l_a8("t|u(/\019\028\002=O(0")
_K9NS3.Description = ""
_K9NS3.Visible = true
_K9NS3.Media = _us6d
_K9NS3.Commands = {}
_K9NS3.DistanceRange = Distance(-1, "feet")
_K9NS3.ShowObjects = "OnEnter"
_K9NS3.ProximityRange = Distance(30, "meters")
_K9NS3.AllowSetPositionTo = false
_K9NS3.Active = false
_K9NS3.Points = {
  ZonePoint(49.4353151096064, 11.112949848175, 0),
  ZonePoint(49.4335289580202, 11.115288734436, 0),
  ZonePoint(49.4323846704787, 11.1117696762085, 0),
  ZonePoint(49.4344359962511, 11.1096453666687, 0)
}
_K9NS3.OriginalPoint = ZonePoint(49.4339161835891, 11.112413406372, 0)
_K9NS3.DistanceRangeUOM = "Feet"
_K9NS3.ProximityRangeUOM = "Meters"
_K9NS3.OutOfRangeName = ""
_K9NS3.InRangeName = ""
_Nu6 = Wherigo.Zone(_4Ial)
_Nu6.Id = "32594be2-39bb-497c-9b93-a47122185745"
_Nu6.Name = _l_a8("6\028fg=\028Ogf\002z\028O\027cTT\028")
_Nu6.Description = ""
_Nu6.Visible = true
_Nu6.Commands = {}
_Nu6.DistanceRange = Distance(-1, "feet")
_Nu6.ShowObjects = "OnEnter"
_Nu6.ProximityRange = Distance(30, "meters")
_Nu6.AllowSetPositionTo = false
_Nu6.Active = false
_Nu6.Points = {
  ZonePoint(49.4382872333052, 11.1068773269653, 0),
  ZonePoint(49.4389848888225, 11.1036586761475, 0),
  ZonePoint(49.4366058427273, 11.1027038097382, 0),
  ZonePoint(49.4362709530728, 11.106276512146, 0)
}
_Nu6.OriginalPoint = ZonePoint(49.437537229482, 11.1048790812493, 0)
_Nu6.DistanceRangeUOM = "Feet"
_Nu6.ProximityRangeUOM = "Meters"
_Nu6.OutOfRangeName = ""
_Nu6.InRangeName = ""
_jnF4 = Wherigo.Zone(_4Ial)
_jnF4.Id = "d94005a7-d9bd-42e4-9971-af3d365e876c"
_jnF4.Name = _l_a8("\f|gc/#(%\0280X\b/\nTc=\020")
_jnF4.Description = ""
_jnF4.Visible = true
_jnF4.Media = _2OMEK
_jnF4.Commands = {}
_jnF4.DistanceRange = Distance(-1, "feet")
_jnF4.ShowObjects = "OnEnter"
_jnF4.ProximityRange = Distance(30, "meters")
_jnF4.AllowSetPositionTo = false
_jnF4.Active = false
_jnF4.Points = {
  ZonePoint(49.4513694956854, 11.0848027467728, 0),
  ZonePoint(49.4505953443664, 11.0836842656136, 0),
  ZonePoint(49.4507629972194, 11.0829305648804, 0),
  ZonePoint(49.4518771872063, 11.083941757679, 0)
}
_jnF4.OriginalPoint = ZonePoint(49.4511512561194, 11.0838398337364, 0)
_jnF4.DistanceRangeUOM = "Feet"
_jnF4.ProximityRangeUOM = "Meters"
_jnF4.OutOfRangeName = ""
_jnF4.InRangeName = ""
_YSflW = Wherigo.Zone(_4Ial)
_YSflW.Id = "e6dd6364-7bbd-4847-b6a6-97a3ef231772"
_YSflW.Name = _l_a8("\f|g\028\002c(")
_YSflW.Description = ""
_YSflW.Visible = true
_YSflW.Media = _Uu7
_YSflW.Commands = {}
_YSflW.DistanceRange = Distance(-1, "feet")
_YSflW.ShowObjects = "OnEnter"
_YSflW.ProximityRange = Distance(30, "meters")
_YSflW.AllowSetPositionTo = false
_YSflW.Active = false
_YSflW.Points = {
  ZonePoint(49.4519106497653, 11.0627818107605, 0),
  ZonePoint(49.4498949296849, 11.0628032684326, 0),
  ZonePoint(49.4500902279902, 11.0661828517914, 0),
  ZonePoint(49.4521268639519, 11.0660755634308, 0)
}
_YSflW.OriginalPoint = ZonePoint(49.4510056678481, 11.0644608736038, 0)
_YSflW.DistanceRangeUOM = "Feet"
_YSflW.ProximityRangeUOM = "Meters"
_YSflW.OutOfRangeName = ""
_YSflW.InRangeName = ""
_qgu = Wherigo.Zone(_4Ial)
_qgu.Id = "fb28a10f-1b14-4453-9151-f1ea74434848"
_qgu.Name = _l_a8(".T\028fg4\027XO(\0284u\028")
_qgu.Description = ""
_qgu.Visible = true
_qgu.Media = _xfAsS
_qgu.Commands = {}
_qgu.DistanceRange = Distance(-1, "feet")
_qgu.ShowObjects = "OnEnter"
_qgu.ProximityRange = Distance(30, "meters")
_qgu.AllowSetPositionTo = false
_qgu.Active = false
_qgu.Points = {
  ZonePoint(49.4532009460972, 11.0769546031952, 0),
  ZonePoint(49.4525523148894, 11.0770726203918, 0),
  ZonePoint(49.4525592894641, 11.076557636261, 0),
  ZonePoint(49.4532532546916, 11.0764878988266, 0)
}
_qgu.OriginalPoint = ZonePoint(49.4528914512856, 11.0767681896687, 0)
_qgu.DistanceRangeUOM = "Feet"
_qgu.ProximityRangeUOM = "Meters"
_qgu.OutOfRangeName = ""
_qgu.InRangeName = ""
_Egs = Wherigo.Zone(_4Ial)
_Egs.Id = "3825dac9-8843-474b-ab3e-7a9956775b30"
_Egs.Name = _l_a8("\f|TT\002\028Og=Ocgg\028")
_Egs.Description = ""
_Egs.Visible = false
_Egs.Media = _2RT
_Egs.Commands = {}
_Egs.DistanceRange = Distance(-1, "feet")
_Egs.ShowObjects = "OnEnter"
_Egs.ProximityRange = Distance(60, "meters")
_Egs.AllowSetPositionTo = false
_Egs.Active = false
_Egs.Points = {
  ZonePoint(49.4631873882159, 11.0831880569458, 0),
  ZonePoint(49.4630758190984, 11.081428527832, 0),
  ZonePoint(49.4617648629394, 11.0819005966187, 0),
  ZonePoint(49.461709076793, 11.0831665992737, 0)
}
_Egs.OriginalPoint = ZonePoint(49.4624342867617, 11.0824209451675, 0)
_Egs.DistanceRangeUOM = "Feet"
_Egs.ProximityRangeUOM = "Meters"
_Egs.OutOfRangeName = ""
_Egs.InRangeName = ""
_WuuN = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _8Rse7})
_WuuN.Id = "b8111877-9f05-4678-87d0-ac459a610513"
_WuuN.Name = _l_a8("6c%=|O")
_WuuN.Description = _l_a8("@k\021kScTgS\002\028(z|=fg4\027\028gS+|O\027c(gSfg=S\028gS\027\028(=\028S\028f\002\028Ss\028OS*c(\030=\020(zc\028\002z\028S\020(OS\002|\028OsTf4\027\028\002S5T=g=cs=\bSt\028OS~c0\028S?6c%=|O?SX\028\020\028f4\027\002\028=S\027\028(=\028Sz\028\002c(z\028\002|00\028\002S\002(OSsf\028S#(\0284u\028Sf\002Ss\028OSU=cs=0c(\028OS")
_WuuN.Visible = true
_WuuN.Media = _24Vo
_WuuN.Commands = {
  _xUPwd = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _zDN0Q = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_WuuN.Commands._xUPwd.Custom = true
_WuuN.Commands._xUPwd.Id = "5bb2a88e-34ab-49a7-b165-fc4c8ed8211b"
_WuuN.Commands._xUPwd.WorksWithAll = true
_WuuN.Commands._zDN0Q.Custom = true
_WuuN.Commands._zDN0Q.Id = "93e6d5d2-ce9d-4d7c-9c66-a0ddb2a15918"
_WuuN.Commands._zDN0Q.WorksWithAll = true
_WuuN.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_WuuN.Gender = "It"
_WuuN.Type = "NPC"
_koi = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _oz8Ni})
_koi.Id = "0090ddac-ce71-43fc-bdd8-2da8c4f8973e"
_koi.Name = _l_a8("}\027\028ucO(gg\028TT")
_koi.Description = _l_a8("}fz\028\002=Tf4\027S*c\002g/Uc4\027g/\006O(\002\002\028\002\bS@Zk\021S\028OXc(=\bS}f\002SN/\006c\027\002S}\002=T(\028y=(\002zgg4\027c4\027=SX\028yf\002s\028=Sgf4\027S9\028Og=\0284u=Sf\002Ss\028OS6f==\028Ss\028gS\006O(\002\002\028\002")
_koi.Visible = true
_koi.Media = _sbBa
_koi.Commands = {
  _S3Cw = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _t3tMy = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_koi.Commands._S3Cw.Custom = true
_koi.Commands._S3Cw.Id = "49781c26-0cfb-46fc-ae5b-df74a2130027"
_koi.Commands._S3Cw.WorksWithAll = true
_koi.Commands._t3tMy.Custom = true
_koi.Commands._t3tMy.Id = "8d65edac-2635-40cf-bf87-f2d5e1439d23"
_koi.Commands._t3tMy.WorksWithAll = true
_koi.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_koi.Gender = "It"
_koi.Type = "NPC"
_u5j = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _ZAQg})
_u5j.Id = "7815e9e4-5d03-4f8b-b672-9c1095f7ab60"
_u5j.Name = _l_a8("v\028fgg\028OS+(O0")
_u5j.Description = _l_a8("t\028OS\006c4ug=\028f\002/:Uc\002sg=\028f\002?(cs\028OXc(SvcOS(Og\030O(\028\002zTf4\027S\006\028g=c\002s=\028fTSs\028gS\127\002\002\028O\028\002SU\030f==T\028O=|O\028gQS}\002=g=\028\027(\002zS4c\bS@\024\\CQSsf\028\002=\028ScTgS6c(=g=\028TT\028S(\002sSfg=Sf\002Sg\028f\002\028OS}\030|4\027\028S\028f\002\028gSs\028OSv\028\002fz\028\002S\028O\027cT=\028\002\028\002S+(\028O0\028Sf\002S~(\028O\002X\028Oz")
_u5j.Visible = true
_u5j.Media = _3EkEs
_u5j.Commands = {
  _1LY = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  __jvb = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_u5j.Commands._1LY.Custom = true
_u5j.Commands._1LY.Id = "a5153fd6-9fab-460f-be58-b8edcbfaed87"
_u5j.Commands._1LY.WorksWithAll = true
_u5j.Commands.__jvb.Custom = true
_u5j.Commands.__jvb.Id = "df2ff927-7eb4-41b1-ab2e-5721b1bd59ea"
_u5j.Commands.__jvb.WorksWithAll = true
_u5j.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_u5j.Gender = "It"
_u5j.Type = "NPC"
_xXO = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _bYH})
_xXO.Id = "da2de349-e8de-4ef9-b905-0683447581b0"
_xXO.Name = _l_a8("UfTX\028Og\028\028")
_xXO.Description = _l_a8("\027\028(=\028Su(\028\002g=Tf4\027\028gS\023\028vc\028gg\028OQS\020(OS~U/\019\028f=Sg|TT=\028S\027f\028OS*f=T\028OgSzO|gg\028gSU=csf|\002S\028\002=g=\028\027\028\002\bS}gSv(Os\028\002ScX\028OS\002(OSsf\028S\023O(\002s0c(\028O\002Sz\028Xc(=QSsc\002c4\027Sv(Os\028SscOc(gS\028f\002\028SU|\002s\028O0(\028TTs\028\030|\002f\028QS\006cs\028\002SXfgS\027\028(=\028Sg=O\028\002zg=\028\002gS9\028OX|=\028\002")
_xXO.Visible = true
_xXO.Media = _wYI
_xXO.Commands = {
  _O5t = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _jadC3 = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_xXO.Commands._O5t.Custom = true
_xXO.Commands._O5t.Id = "03f7733b-7bad-41c4-babd-1ec4c62e971e"
_xXO.Commands._O5t.WorksWithAll = true
_xXO.Commands._jadC3.Custom = true
_xXO.Commands._jadC3.Id = "057d69f7-6889-4081-9d0a-753cc86c2b5c"
_xXO.Commands._jadC3.WorksWithAll = true
_xXO.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xXO.Gender = "It"
_xXO.Type = "NPC"
__d3 = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _K9NS3})
__d3.Id = "bbfa12fa-aee8-423c-981c-8aeba5ceef1c"
__d3.Name = _l_a8("t|u(/\019\028\002=O(0")
__d3.Description = _l_a8("6(g\028(0!SscggSgf4\027Ssc(\028O\027cy=S(0Ssf\028S.cg\020f\002c=f|\002S(\002sS\023\028vcT=Ss\028OS~U/\019\028f=SX\028g4\027c\028y=fz=S(\002sSgf4\027S0f=Ss\028\002SNOgc4\027\028\002!S\019(gc00\028\002\027c\028\002z\028\002S(\002sS.|Tz\028\002Ss\028OS\002c=f|\002cTg|\020fcTfg=fg4\027\028\002S\023\028vcT=\027\028OOg4\027cy=Sc(g\028f\002c\002s\028Og\028=\020=")
__d3.Visible = true
__d3.Media = _us6d
__d3.Commands = {
  _VQTe = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _ET1M = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
__d3.Commands._VQTe.Custom = true
__d3.Commands._VQTe.Id = "15ed9cef-03ca-4327-88c4-5f9e98c79d5f"
__d3.Commands._VQTe.WorksWithAll = true
__d3.Commands._ET1M.Custom = true
__d3.Commands._ET1M.Id = "67331dd6-d4b2-4ba5-ba51-f3490ee744d1"
__d3.Commands._ET1M.WorksWithAll = true
__d3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
__d3.Gender = "It"
__d3.Type = "NPC"
_Tirx = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _Nu6})
_Tirx.Id = "07751bf4-9265-4d0f-90c4-5957e9d74b98"
_Tirx.Name = _l_a8("6\028fg=\028Ogf\002z\028O\027cTT\028")
_Tirx.Description = _l_a8("u|00(\002cT\028gS\018(T=(O/S(\002sS\018|\002zO\028gg\020\028\002=O(0QS\006c(\020\028f=S@Z]CSXfgS@Z]xQSg\028f=S\024CC;S(\002=\028OSt\028\002u0cTg4\027(=\020QS\023O|gg/UccTS0f=S4c\bS\024@CCSUf=\020\030Tc\028=\020\028\002")
_Tirx.Visible = true
_Tirx.Commands = {
  _i_7PU = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _Sepk = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_Tirx.Commands._i_7PU.Custom = true
_Tirx.Commands._i_7PU.Id = "ca434aee-591e-4d8b-9686-109ea88d52bb"
_Tirx.Commands._i_7PU.WorksWithAll = true
_Tirx.Commands._Sepk.Custom = true
_Tirx.Commands._Sepk.Id = "3577d4c8-53a1-4ba1-897c-760b6db8c27c"
_Tirx.Commands._Sepk.WorksWithAll = true
_Tirx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Tirx.Gender = "It"
_Tirx.Type = "NPC"
_fY9tZ = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _jnF4})
_fY9tZ.Id = "d292d54a-4dc8-4f55-b324-c48ee2e89802"
_fY9tZ.Name = _l_a8("\f|gc/#(%\0280X\b/\nTc=\020")
_fY9tZ.Description = _l_a8("scgS\006fTsS\020\028fz=Ss\028\002S\023\028v\028OX\0280(g\028(0g\030Tc=\020!SscSc(gSs\0280S\f#/K\nTc=\020KSf0S\023O(\002s\028S\028f\002\028STc\002zv\028fTfz\028S\028\002z\028SU=Ocgg\028Sv(Os\028\bStc\027\028OSvfs0\028\002SvfOS\027f\028OSc(g\002c\0270gv\028fg\028S0cTS0\028\027OSs\0280S\0236/\nTc=\020Ssf\028S5(y0\028Ougc0u\028f=")
_fY9tZ.Visible = true
_fY9tZ.Media = _2OMEK
_fY9tZ.Commands = {
  _hYLv = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _tnky = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_fY9tZ.Commands._hYLv.Custom = true
_fY9tZ.Commands._hYLv.Id = "0d55f173-49fa-4b4c-9185-be19618fb4b6"
_fY9tZ.Commands._hYLv.WorksWithAll = true
_fY9tZ.Commands._tnky.Custom = true
_fY9tZ.Commands._tnky.Id = "b96281fa-8e9b-4fb8-8d09-d01cd70fc8d4"
_fY9tZ.Commands._tnky.WorksWithAll = true
_fY9tZ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fY9tZ.Gender = "It"
_fY9tZ.Type = "NPC"
_s8jbT = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _qgu})
_s8jbT.Id = "7f90902a-f05c-4ac4-b50b-9e889d7715fc"
_s8jbT.Name = _l_a8(".T\028fg4\027XO(\0284u\028")
_s8jbT.Description = _l_a8("U=\028f\002X|z\028\002XO(\0284u\028S9|\002S}\002s\028S@]S_c\027O\027(\002s\028O=\bSP\002Xg\030QU4\027|\002S(0S@\024CCS\028Ovc\028\027\002=ScTgSsc0cTgSc\028T=\028g=\028S\006O(\0284u\028Sf\002S~(\028O\002X\028OzS\031sc0cTgS\002|4\027Sc(gS*|T\020m")
_s8jbT.Visible = true
_s8jbT.Media = _xfAsS
_s8jbT.Commands = {
  _MUrdz = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _RcL = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_s8jbT.Commands._MUrdz.Custom = true
_s8jbT.Commands._MUrdz.Id = "94d9f9f5-21e0-48c4-a293-3013105b7789"
_s8jbT.Commands._MUrdz.WorksWithAll = true
_s8jbT.Commands._RcL.Custom = true
_s8jbT.Commands._RcL.Id = "36b4f39f-c576-460e-8497-2e63b71c5f59"
_s8jbT.Commands._RcL.WorksWithAll = true
_s8jbT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_s8jbT.Gender = "It"
_s8jbT.Type = "NPC"
_5Ry7 = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _r9V})
_5Ry7.Id = "0e832408-dbeb-4c85-ae4f-b9561591c30e"
_5Ry7.Name = _l_a8("\018|O\0020cOu=")
_5Ry7.Description = _l_a8("5TgS@k@CSs\028OS\023\028=O\028fs\0280cOu=S9|0S_|g\028\030\027g\030Tc=\020S\027f\028O\027\028OS9\028OT\028z=Sv(Os\028!SX\028uc0Ss\028OS\nTc=\020Sg\028f\002\028\002S~c0\028\002\bS*f\028OSTf\028z=Sc(4\027SscgS\023\028O0c\002fg4\027\028S~c=f|\002cT0(g\028(0\b")
_5Ry7.Visible = true
_5Ry7.Media = _0YoFE
_5Ry7.Commands = {
  _sIqaE = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _GHQTF = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_5Ry7.Commands._sIqaE.Custom = true
_5Ry7.Commands._sIqaE.Id = "fcc9f8d3-751a-4eae-91dd-d050d474dfb8"
_5Ry7.Commands._sIqaE.WorksWithAll = true
_5Ry7.Commands._GHQTF.Custom = true
_5Ry7.Commands._GHQTF.Id = "b52c82d3-fa32-4ea5-8491-eb8c521642b5"
_5Ry7.Commands._GHQTF.WorksWithAll = true
_5Ry7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_5Ry7.Gender = "It"
_5Ry7.Type = "NPC"
_2Aig = Wherigo.ZCharacter({Cartridge = _4Ial, Container = _YSflW})
_2Aig.Id = "23fb4be2-b57b-4eba-972f-69c690df84f1"
_2Aig.Name = _l_a8("\f|g\028\002c(")
_2Aig.Description = _l_a8("t\028OS\f|g\028\002c(\030cOuSX\020v\bSsf\028S\f|g\028\002c(Sfg=S\028f\002\028S4c\bSxS*\028u=cOSzO|gg\028S\ncOuc\002Tcz\028Sf\002S~(\028O\002X\028Oz\bSUf\028STf\028z=Sf0SU=cs==\028fTS\018T\028f\002v\028fs\028\0020(\028\027T\028Sv\028g=Tf4\027Ss\028gS.(\028O=\027\028OS+|O\028g")
_2Aig.Visible = true
_2Aig.Media = _Uu7
_2Aig.Commands = {
  _kzm = Wherigo.ZCommand({
    Text = _l_a8("5N.\0235\006}"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  }),
  _bVd = Wherigo.ZCommand({
    Text = _l_a8("#2}U}~"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_2Aig.Commands._kzm.Custom = true
_2Aig.Commands._kzm.Id = "afc8352f-5251-4772-a184-9082933c3d8c"
_2Aig.Commands._kzm.WorksWithAll = true
_2Aig.Commands._bVd.Custom = true
_2Aig.Commands._bVd.Id = "38ff28ed-1245-4b40-a7ce-894c980efcb2"
_2Aig.Commands._bVd.WorksWithAll = true
_2Aig.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2Aig.Gender = "It"
_2Aig.Type = "NPC"
_hIUhz = Wherigo.ZItem(_4Ial)
_hIUhz.Id = "ce3d9c09-1d22-4cc1-9682-b626a8ffb758"
_hIUhz.Name = _l_a8("5")
_hIUhz.Description = _l_a8("g=cOuScTu|\027|Tfg4\027\028gS\023\028=Oc\028\002u!SscggSgf4\027SX\028fS5\002z\028X|=S(\002sS~c4\027yOcz\028S=Ofyy=-\006\f)\031}0\030y\028\027T(\002z\003ScTgSU\127}\006+}SU=c=f|\002S0c4\027\028\002m")
_hIUhz.Visible = true
_hIUhz.Media = _xNW
_hIUhz.Commands = {
  _XD7_ = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_hIUhz.Commands._XD7_.Custom = true
_hIUhz.Commands._XD7_.Id = "b0d21cd1-4726-4a46-af83-fff69510972c"
_hIUhz.Commands._XD7_.WorksWithAll = true
_hIUhz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_hIUhz.Locked = false
_hIUhz.Opened = false
_5ap6 = Wherigo.ZItem(_4Ial)
_5ap6.Id = "378bcf1b-f8d8-4ae5-8b81-32f641626755"
_5ap6.Name = _l_a8("\006")
_5ap6.Description = _l_a8("(\002X\028yT\0284u=\028Su(\028\002g=Tf4\027\028S}O\027\028X(\002z-\006\f)\031}0\030y\028\027T(\002z\003ScTgS.N}~.+}SU=c=f|\002S0c4\027\028\002m")
_5ap6.Visible = true
_5ap6.Media = _xNW
_5ap6.Commands = {
  _mLv = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_5ap6.Commands._mLv.Custom = true
_5ap6.Commands._mLv.Id = "7748a9db-9a9b-4d9f-bed7-76526c2529c7"
_5ap6.Commands._mLv.WorksWithAll = true
_5ap6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_5ap6.Locked = false
_5ap6.Opened = false
_X1NDx = Wherigo.ZItem(_4Ial)
_X1NDx.Id = "74ccf3b4-676c-4881-9e80-dcc1c0168135"
_X1NDx.Name = _l_a8("l")
_X1NDx.Description = _l_a8("\nf\002u\028O/\018T\028f\002g=cc=/2O=-\006\f)\031}0\030y\028\027T(\002z\003ScTgS5l*+}SU=c=f|\002S0c4\027\028\002m")
_X1NDx.Visible = true
_X1NDx.Media = _xNW
_X1NDx.Commands = {
  _H0UOq = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_X1NDx.Commands._H0UOq.Custom = true
_X1NDx.Commands._H0UOq.Id = "10a9c299-e345-4f6c-bd06-118394115b8e"
_X1NDx.Commands._H0UOq.WorksWithAll = true
_X1NDx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_X1NDx.Locked = false
_X1NDx.Opened = false
_nbxoW = Wherigo.ZItem(_4Ial)
_nbxoW.Id = "2b613665-7d3b-4bed-a84d-6a98ddb25b20"
_nbxoW.Name = _l_a8("t")
_nbxoW.Description = _l_a8("y(\028OS\016\028z\028=cOf\028OS9\028OX|=\028\002\028S6|\028zTf4\027u\028f=Sc\002gSc\002s\028O\028SNy\028OS\020(Su|00\028\002-\006\f)\031}0\030y\028\027T(\002z\003ScTgS~}N~+}SU=c=f|\002S0c4\027\028\002m")
_nbxoW.Visible = true
_nbxoW.Media = _xNW
_nbxoW.Commands = {
  _rmT4 = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_nbxoW.Commands._rmT4.Custom = true
_nbxoW.Commands._rmT4.Id = "b98c933d-f82c-4ae0-8d3f-f5a499fc7cae"
_nbxoW.Commands._rmT4.WorksWithAll = true
_nbxoW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nbxoW.Locked = false
_nbxoW.Opened = false
_BVni7 = Wherigo.ZItem(_4Ial)
_BVni7.Id = "a6cc566c-9d3f-4ce0-b1a8-4ce25c3d4491"
_BVni7.Name = _l_a8("}")
_BVni7.Description = _l_a8("\006f\002s(\002z!Ssf\028Sg\028\027OSg4\027\002\028TTSf\002gSU4\027T\028(s\028O\002Su|00=-\006\f)\031}0\030y\028\027T(\002z\003ScTgSU}l*U+}SU=c=f|\002S0c4\027\028\002m")
_BVni7.Visible = true
_BVni7.Media = _xNW
_BVni7.Commands = {
  _gcAA = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_BVni7.Commands._gcAA.Custom = true
_BVni7.Commands._gcAA.Id = "57784b16-5dd0-4411-98e8-5317a5b54d69"
_BVni7.Commands._gcAA.WorksWithAll = true
_BVni7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_BVni7.Locked = false
_BVni7.Opened = false
_ns6 = Wherigo.ZItem(_4Ial)
_ns6.Id = "7d3cfc3b-3919-40ea-9cd6-6b41e592bcd5"
_ns6.Name = _l_a8(".")
_ns6.Description = _l_a8("U4\0270\028O\020g4\027O\028fS\028f\002\028OSU4\027\028\002u(\002zS\0316\028\027O\020c\027Tm!Sv|S.Oc(\028\002S|y=Ssc\027f\002Sg4\0270\028T\020\028\002-\006\f)\031}0\030y\028\027T(\002z\003ScTgS\016\127}\f+}SU=c=f|\002S0c4\027\028\002m")
_ns6.Visible = true
_ns6.Media = _xNW
_ns6.Commands = {
  _UP0 = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_ns6.Commands._UP0.Custom = true
_ns6.Commands._UP0.Id = "e33b79d7-8388-4b4f-a695-88371cfd4acc"
_ns6.Commands._UP0.WorksWithAll = true
_ns6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ns6.Locked = false
_ns6.Opened = false
_UrTLQ = Wherigo.ZItem(_4Ial)
_UrTLQ.Id = "9f9a5b0f-0fb2-4271-901a-72dbe1214c55"
_UrTLQ.Name = _l_a8("\023")
_UrTLQ.Description = _l_a8("t\028OS\006\028g=\028S\028f\002\028gSX\028uc\002\002=\028\002S~c\028\0270cg4\027f\002\028\002\027\028Og=\028TT\028OgSf\002S\028f\002\028OSU=cs=Sf\002SUc4\027g\028\002/5\002\027cT=S-\006\f)\031}0\030y\028\027T(\002z\003ScTgSt\f\127++}SU=c=f|\002S0c4\027\028\002m")
_UrTLQ.Visible = true
_UrTLQ.Media = _xNW
_UrTLQ.Commands = {
  _3QuWu = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_UrTLQ.Commands._3QuWu.Custom = true
_UrTLQ.Commands._3QuWu.Id = "cdb7447a-f251-4b6a-80f5-ef0fc5d5d4b1"
_UrTLQ.Commands._3QuWu.WorksWithAll = true
_UrTLQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_UrTLQ.Locked = false
_UrTLQ.Opened = false
_l56 = Wherigo.ZItem(_4Ial)
_l56.Id = "bd51ed98-5349-41c7-8b61-fdbcddd3dfc6"
_l56.Name = _l_a8("*")
_l56.Description = _l_a8("5(y\020\028f4\027\002(\002zSf\002Ss\028OS6f==\028-\006\f)\031}0\030y\028\027T(\002z\003ScTgS\019&}\127+}SU=c=f|\002S0c4\027\028\002m-\006\f)")
_l56.Visible = true
_l56.Media = _xNW
_l56.Commands = {
  _SkL = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_l56.Commands._SkL.Custom = true
_l56.Commands._SkL.Id = "d0b5dfe0-deac-4244-b95d-1f4c3d4cfc96"
_l56.Commands._SkL.WorksWithAll = true
_l56.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_l56.Locked = false
_l56.Opened = false
_DOM2 = Wherigo.ZItem(_4Ial)
_DOM2.Id = "cbf82ec3-4d51-4076-9e87-3695c125dbab"
_DOM2.Name = _l_a8("\127")
_DOM2.Description = _l_a8("\019v\028f=\030Tc=\020f\028O=\028OSzO|gg\028OS&\028f\027\028O-\006\f)\031}0\030y\028\027T(\002z\003ScTgS}\fU+}SU=c=f|\002S0c4\027\028\002m")
_DOM2.Visible = true
_DOM2.Media = _xNW
_DOM2.Commands = {
  _eYft = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_DOM2.Commands._eYft.Custom = true
_DOM2.Commands._eYft.Id = "39853756-b6d7-40bd-8012-d1d08e182810"
_DOM2.Commands._eYft.WorksWithAll = true
_DOM2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_DOM2.Locked = false
_DOM2.Opened = false
_RMo6 = Wherigo.ZItem(_4Ial)
_RMo6.Id = "054d91cb-7ee8-4dc1-b467-0984a35f93bb"
_RMo6.Name = _l_a8("_")
_RMo6.Description = _l_a8("~f4\027=S6|Of=\020S\027c=S\028f\002\028\002S+O\028yy\028OSz\0280c4\027=-\006\f)\031}0\030y\028\027T(\002z\003ScTgS\019}*~+}SN~tS#}+\019+}SU=c=f|\002S0c4\027\028\002m")
_RMo6.Visible = true
_RMo6.Media = _xNW
_RMo6.Commands = {
  _OSj = Wherigo.ZCommand({
    Text = _l_a8("#|\028g(\002zS\028f\002z\028X\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_RMo6.Commands._OSj.Custom = true
_RMo6.Commands._OSj.Id = "b55245e4-e51a-4f62-9625-e888ac90bf0c"
_RMo6.Commands._OSj.WorksWithAll = true
_RMo6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_RMo6.Locked = false
_RMo6.Opened = false
_jdZW = Wherigo.ZItem({Cartridge = _4Ial, Container = _Egs})
_jdZW.Id = "ff3e48a0-c333-4899-95dd-903651fe665b"
_jdZW.Name = _l_a8("\127~2..\127\019\127}##}US.\127~5#")
_jdZW.Description = _l_a8("\023\028\027=S\002(\002S\020(0S#cs\028\002SK\018(4\027\028\002g4\0270(4uKS\031\f|TT\002\028Og=O\bS\021Cm\b-\006\f)-\006\f)\127*\fS\006}\018266+St}~S.\127~5#S~N\fSt5~~!S&}~~St}\fS#2}UN~\023U+}^+St2\f+S5N.\023}U5\023+S&\127\ft\bSt\127}U}\fS\127U+\003-\006\f)-\006\f)K\1274\027SXf\002S}\030\030\028T\028f\002!Ss\028OS\ff==\028O-\006\f)Xf\002S|\027\002\028S\ncO=\002\028O!SscgSfg=SXf==\028O-\006\f)v|TT\028\002S&\127\fS\028gS\002f4\027=S0cTS9\028Og(4\027\028\002b-\006\f)s|4\027S9|O\027\028OS\028gg\028\002SvfOS\028f\002SU=(\0284uS\018(4\027\028\002K")
_jdZW.Visible = false
_jdZW.Media = _f2g0l
_jdZW.Commands = {}
_jdZW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jdZW.Locked = false
_jdZW.Opened = false
_gr0 = Wherigo.ZItem({Cartridge = _4Ial, Container = _Egs})
_gr0.Id = "ad5c7276-fc5e-400a-89c3-b1fb31d1f9a1"
_gr0.Name = _l_a8("N\002T|4u/l|s\028")
_gr0.Description = ""
_gr0.Visible = false
_gr0.Media = _FrVdJ
_gr0.Commands = {
  _xTJ = Wherigo.ZCommand({
    Text = _l_a8("l|s\028Sc\002\020\028fz\028\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_gr0.Commands._xTJ.Custom = true
_gr0.Commands._xTJ.Id = "29b081b9-1704-421b-810e-f7db7f52ef00"
_gr0.Commands._xTJ.WorksWithAll = true
_gr0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_gr0.Locked = false
_gr0.Opened = true
_dxvg = Wherigo.ZItem({Cartridge = _4Ial, Container = _Egs})
_dxvg.Id = "4b1c7985-0f0b-4199-9170-23feac2354c2"
_dxvg.Name = _l_a8("\023}~5NS#}U}~")
_dxvg.Description = _l_a8("U|!S\002(\002SXf==\028Sz\028\002c(ST\028g\028\002SYY-\006\f)-\006\f)t\028OS\028fz\028\002=Tf4\027S9|Oz\028g\028\027\028\002\028Slc4\027\028Sfg=Sf\002S\028f\002\0280S#cs\028\002\bStf\028g\028OS9\028Og=|\028gg=Sf\002\020vfg4\027\028\002Sz\028z\028\002Ssf\028S\023(fs\028Tf\002\028gS9|\002S\023O|(\002sg\030\028cu\b-\006\f)-\006\f)tc\027\028OSXf\002Sf4\027Sz\028\020v(\002z\028\002!S\028f\002\028\002S|yyf\020f\028TT\028\002S.f\002cTS\020(Sg\028=\020\028\002\bStf\028gSfg=S\028f\002\028S\028f\002yc4\027\028!STc\002zv\028fTfz\028S.fT0s|g\028:\n\028=Tf\002z!Ssf\028SX\028fS~\021ZS\023OcsS\024;\b;x\021S(\002sS}@@S\023OcsSC\021\bZ\\;S\031f\002S:SX\028fSs\028OS6f\002f/\023O(\028\002yTc\0284\027\028mSTf\028z=\bS-\006\f)&\028OS0|\0284\027=\028S\031u\028f\002S\019vc\002zS(\002sSu\028f\002\028S#|zX\028sf\002z(\002zm!Suc\002\002Ss\028\002Sf\002|yyf\020f\028TT\028\002S5(yg(4\027\028\002\bStc\002\002SXf==\028Sc(ySK_5KSuTf4u\028\002\bS&\028OS\002f4\027=SvfTT!SXf==\028SK~}\127~KSsO(\0284u\028\002\bS")
_dxvg.Visible = true
_dxvg.Media = _BgWap
_dxvg.Commands = {
  _4nMl = Wherigo.ZCommand({
    Text = _l_a8("\127~2..\127\019\127}##}~S.\127~5#b"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _l_a8("~f4\027=S9\028Oy(zXcO")
  })
}
_dxvg.Commands._4nMl.Custom = true
_dxvg.Commands._4nMl.Id = "2e4211e2-feb4-41c7-a597-1fadbfeaf8ba"
_dxvg.Commands._4nMl.WorksWithAll = true
_dxvg.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_dxvg.Locked = false
_dxvg.Opened = false
_x1fT6 = _l_a8("s|u(0\028\002=c=f|\002g\020\028\002=O(0")
_UqE = _l_a8("0\028fg=\028Ogf\002z\028O\027cTT\028")
_OCJO = _l_a8("gfTX\028Og\028\028")
_wUffE = _l_a8("O|g\028\002c(")
_L7hI3 = _l_a8("0c%=|O")
_d018 = _l_a8("\028\027\028ucO(gg\028TT")
_9qC8k = _l_a8("v\028fgg\028O=(O0")
_xSKh = _l_a8("yT\028fg4\027XO(\0284u\028")
_a7M = _l_a8("O|gcT(%\0280X(Oz\030Tc=\020")
_Rotii = _l_a8("u|O\0020cOu=")
_SfW5 = 1
_kdRRs = _l_a8("@CC\024@\021C;C")
_NSEs = 0
_6lw = _l_a8("(\027ffz")
_y5Lw7 = _l_a8("xsg4\027csg=|yy\028csf0g")
_7c5 = _l_a8("@\\\021\\\024\\u|00\028O\020f\028\002Oc=gvf=v\028")
_QSYzq = _l_a8("c\002\020\028fz\028\002")
_Rcm = _l_a8("@\021g=cs=(0vcTT(\002zc")
_ua5 = _l_a8("@x]\021]")
_KynhG = _l_a8("\024\024\028=kZ")
_thWA = _l_a8("cO=]C@Z")
_YFz = _l_a8("@x];@Z];x@Z]k@Z;C")
_XoaY3 = 1
_8Zso = 0
_F4_ = 1
_yxa = 1
_WI9ZH = 1
_GI7y = 1
_CRr = 1
_z0u = 1
_cmO = 1
_65A_ = 1
_iMbV = 1
_TNA1A = 0
_ywea = 0
_aWAo = 0
_Lldk0 = 0
_i0c6 = 0
_zeA = 0
_wIP = 0
_OOKI2 = 0
_RhNj6 = 0
__VO = 0
_B0KZ = _l_a8("C\\}N#}]@\021")
_FCX = _l_a8("[OZ\016")
_w_rP = _l_a8("[&((~")
_dDgCK = _l_a8("[\027\127N\027\020")
_aOm = _l_a8("s(00i")
_sCFZ = _l_a8("[W\027\n")
_44y9 = _l_a8("s(00i")
_4Ial.ZVariables = {
  _x1fT6 = _l_a8("s|u(0\028\002=c=f|\002g\020\028\002=O(0"),
  _UqE = _l_a8("0\028fg=\028Ogf\002z\028O\027cTT\028"),
  _OCJO = _l_a8("gfTX\028Og\028\028"),
  _wUffE = _l_a8("O|g\028\002c("),
  _L7hI3 = _l_a8("0c%=|O"),
  _d018 = _l_a8("\028\027\028ucO(gg\028TT"),
  _9qC8k = _l_a8("v\028fgg\028O=(O0"),
  _xSKh = _l_a8("yT\028fg4\027XO(\0284u\028"),
  _a7M = _l_a8("O|gcT(%\0280X(Oz\030Tc=\020"),
  _Rotii = _l_a8("u|O\0020cOu="),
  _SfW5 = 1,
  _kdRRs = _l_a8("@CC\024@\021C;C"),
  _NSEs = 0,
  _6lw = _l_a8("(\027ffz"),
  _y5Lw7 = _l_a8("xsg4\027csg=|yy\028csf0g"),
  _7c5 = _l_a8("@\\\021\\\024\\u|00\028O\020f\028\002Oc=gvf=v\028"),
  _QSYzq = _l_a8("c\002\020\028fz\028\002"),
  _Rcm = _l_a8("@\021g=cs=(0vcTT(\002zc"),
  _ua5 = _l_a8("@x]\021]"),
  _KynhG = _l_a8("\024\024\028=kZ"),
  _thWA = _l_a8("cO=]C@Z"),
  _YFz = _l_a8("@x];@Z];x@Z]k@Z;C"),
  _XoaY3 = 1,
  _8Zso = 0,
  _F4_ = 1,
  _yxa = 1,
  _WI9ZH = 1,
  _GI7y = 1,
  _CRr = 1,
  _z0u = 1,
  _cmO = 1,
  _65A_ = 1,
  _iMbV = 1,
  _TNA1A = 0,
  _ywea = 0,
  _aWAo = 0,
  _Lldk0 = 0,
  _i0c6 = 0,
  _zeA = 0,
  _wIP = 0,
  _OOKI2 = 0,
  _RhNj6 = 0,
  __VO = 0,
  _B0KZ = _l_a8("C\\}N#}]@\021"),
  _FCX = _l_a8("[OZ\016"),
  _w_rP = _l_a8("[&((~"),
  _dDgCK = _l_a8("[\027\127N\027\020"),
  _aOm = _l_a8("s(00i"),
  _sCFZ = _l_a8("[W\027\n"),
  _44y9 = _l_a8("s(00i")
}
_YhP = Wherigo.ZInput(_4Ial)
_YhP.Id = "3fac7781-1514-4cdc-97e3-7f6b4710de13"
_YhP.Name = _l_a8("5")
_YhP.Description = ""
_YhP.Visible = true
_YhP.Media = _OjvCQ
_YhP.InputType = "Text"
_YhP.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_1ilYc = Wherigo.ZInput(_4Ial)
_1ilYc.Id = "d6dd0a49-0620-4490-98a9-22859622386a"
_1ilYc.Name = _l_a8("\006")
_1ilYc.Description = ""
_1ilYc.Visible = true
_1ilYc.Media = _L0Wl2
_1ilYc.InputType = "Text"
_1ilYc.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_1zC7 = Wherigo.ZInput(_4Ial)
_1zC7.Id = "8b36ca20-418c-4ccc-8327-b673c5369579"
_1zC7.Name = _l_a8("l")
_1zC7.Description = ""
_1zC7.Visible = true
_1zC7.Media = _nJv4
_1zC7.InputType = "Text"
_1zC7.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_BaI = Wherigo.ZInput(_4Ial)
_BaI.Id = "1cd1f5b3-ab90-4ea9-93f3-4cf395a30d22"
_BaI.Name = _l_a8("t")
_BaI.Description = ""
_BaI.Visible = true
_BaI.Media = _FEp
_BaI.InputType = "Text"
_BaI.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_EHX = Wherigo.ZInput(_4Ial)
_EHX.Id = "fbc3c729-f87d-455f-8466-ec66cd9310b6"
_EHX.Name = _l_a8("}")
_EHX.Description = ""
_EHX.Visible = true
_EHX.Media = _lYTz2
_EHX.InputType = "Text"
_EHX.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_pHR_O = Wherigo.ZInput(_4Ial)
_pHR_O.Id = "2592c770-0458-4c53-9b70-b8cd4841f82b"
_pHR_O.Name = _l_a8(".")
_pHR_O.Description = ""
_pHR_O.Visible = true
_pHR_O.Media = _pKRd
_pHR_O.InputType = "Text"
_pHR_O.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_Spu2 = Wherigo.ZInput(_4Ial)
_Spu2.Id = "9ab60565-874b-498b-98df-06d0456ac234"
_Spu2.Name = _l_a8("\023")
_Spu2.Description = ""
_Spu2.Visible = true
_Spu2.Media = _fe6y
_Spu2.InputType = "Text"
_Spu2.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_ZPGqN = Wherigo.ZInput(_4Ial)
_ZPGqN.Id = "89b775d8-757a-494a-b744-c2c039595b8c"
_ZPGqN.Name = _l_a8("*")
_ZPGqN.Description = ""
_ZPGqN.Visible = true
_ZPGqN.Media = _3ta
_ZPGqN.InputType = "Text"
_ZPGqN.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_0nMT = Wherigo.ZInput(_4Ial)
_0nMT.Id = "3851126d-0fae-42ef-a8d9-3773ec7b963b"
_0nMT.Name = _l_a8("\127")
_0nMT.Description = ""
_0nMT.Visible = true
_0nMT.Media = _XRVrX
_0nMT.InputType = "Text"
_0nMT.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_4aJT = Wherigo.ZInput(_4Ial)
_4aJT.Id = "50595376-3723-4738-bfc8-14c26fd1eaf0"
_4aJT.Name = _l_a8("_")
_4aJT.Description = ""
_4aJT.Visible = true
_4aJT.Media = _7At
_4aJT.InputType = "Text"
_4aJT.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_YJE9w = Wherigo.ZInput(_4Ial)
_YJE9w.Id = "cf5bfaa3-327b-4c51-a979-f088ff7acb88"
_YJE9w.Name = _l_a8("t2\018N/#2}UN~\023")
_YJE9w.Description = ""
_YJE9w.Visible = true
_YJE9w.Media = _bBX
_YJE9w.InputType = "Text"
_YJE9w.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_NSu = Wherigo.ZInput(_4Ial)
_NSu.Id = "eb886a0f-339c-43f9-bdf3-f2216d10aded"
_NSu.Name = _l_a8("65^/#U\023")
_NSu.Description = ""
_NSu.Visible = true
_NSu.Media = _bBX
_NSu.InputType = "Text"
_NSu.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_jIj = Wherigo.ZInput(_4Ial)
_jIj.Id = "2d3de6ce-4abb-4907-bb40-3436921de76b"
_jIj.Name = _l_a8("U\127#\006}\f/#U\023")
_jIj.Description = ""
_jIj.Visible = true
_jIj.Media = _bBX
_jIj.InputType = "Text"
_jIj.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_pFJ = Wherigo.ZInput(_4Ial)
_pFJ.Id = "0444a2a7-06d9-48c1-b7e8-00cf615dff61"
_pFJ.Name = _l_a8("}*}/#U\023")
_pFJ.Description = ""
_pFJ.Visible = true
_pFJ.Media = _bBX
_pFJ.InputType = "Text"
_pFJ.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_hB6U7 = Wherigo.ZInput(_4Ial)
_hB6U7.Id = "e1403ff0-84d7-4f50-b182-5b0f23dc8b9a"
_hB6U7.Name = _l_a8("&}\127UUS#U\023")
_hB6U7.Description = ""
_hB6U7.Visible = true
_hB6U7.Media = _bBX
_hB6U7.InputType = "Text"
_hB6U7.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_FtldU = Wherigo.ZInput(_4Ial)
_FtldU.Id = "42e80b5d-d067-42c5-b199-23e45c3278d1"
_FtldU.Name = _l_a8("6}\127U+}\fS#U\023")
_FtldU.Description = ""
_FtldU.Visible = true
_FtldU.Media = _bBX
_FtldU.InputType = "Text"
_FtldU.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_RB78 = Wherigo.ZInput(_4Ial)
_RB78.Id = "15a56c6a-0ea2-4a77-8cb0-a00259cf39f6"
_RB78.Name = _l_a8("\f2U5/#U\023")
_RB78.Description = ""
_RB78.Visible = true
_RB78.Media = _bBX
_RB78.InputType = "Text"
_RB78.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_Q24AT = Wherigo.ZInput(_4Ial)
_Q24AT.Id = "e8a653d4-f3d0-4a1a-a266-cddc73abf8da"
_Q24AT.Name = _l_a8(".#}\127Ul*/#U\023")
_Q24AT.Description = ""
_Q24AT.Visible = true
_Q24AT.Media = _bBX
_Q24AT.InputType = "Text"
_Q24AT.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_Z8E = Wherigo.ZInput(_4Ial)
_Z8E.Id = "efe6b92c-ba1e-4f6c-9946-4180adab7c99"
_Z8E.Name = _l_a8("\0182\f~/#U\023")
_Z8E.Description = ""
_Z8E.Visible = true
_Z8E.Media = _njP
_Z8E.InputType = "Text"
_Z8E.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
_Ber = Wherigo.ZInput(_4Ial)
_Ber.Id = "6230a8ef-75c7-490e-a5e6-7c22ac967e2c"
_Ber.Name = _l_a8("\f2U}~5NS#U\023")
_Ber.Description = ""
_Ber.Visible = true
_Ber.Media = _bBX
_Ber.InputType = "Text"
_Ber.Text = _l_a8("&f\028Sfg=Ssf\028S#|\028g(\002zb")
__uuB = Wherigo.ZInput(_4Ial)
__uuB.Id = "6f40aeac-440b-4938-99be-77d540af5d35"
__uuB.Name = _l_a8("\127~2..\127\019\127}##")
__uuB.Description = ""
__uuB.Visible = true
__uuB.Media = _Yj2
__uuB.Choices = {"JA", "NEIN"}
__uuB.InputType = "MultipleChoice"
__uuB.Text = _l_a8("\127\002|yyf\020f\028TT\028\002S.f\002cTSX\028g(4\027\028\002Sb")
_YdO = Wherigo.ZInput(_4Ial)
_YdO.Id = "9340191f-610b-46d3-8bfa-ded486a9f92b"
_YdO.Name = _l_a8("yCC")
_YdO.Description = ""
_YdO.Visible = true
_YdO.Choices = {"JA", "NEIN"}
_YdO.InputType = "MultipleChoice"
_YdO.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_Cc6K9 = Wherigo.ZInput(_4Ial)
_Cc6K9.Id = "9bd16de1-52e0-4e5a-9e5e-cd8d84c837ba"
_Cc6K9.Name = _l_a8("yC@")
_Cc6K9.Description = ""
_Cc6K9.Visible = true
_Cc6K9.Choices = {"JA", "NEIN"}
_Cc6K9.InputType = "MultipleChoice"
_Cc6K9.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_CSMnA = Wherigo.ZInput(_4Ial)
_CSMnA.Id = "15433911-3656-42c5-95b8-e78f08690338"
_CSMnA.Name = _l_a8("yC\024")
_CSMnA.Description = ""
_CSMnA.Visible = true
_CSMnA.Choices = {"JA", "NEIN"}
_CSMnA.InputType = "MultipleChoice"
_CSMnA.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_OQpz = Wherigo.ZInput(_4Ial)
_OQpz.Id = "137f452d-4ac7-4fc5-abed-e1b781a8cb6a"
_OQpz.Name = _l_a8("yCx")
_OQpz.Description = ""
_OQpz.Visible = true
_OQpz.Choices = {"JA", "NEIN"}
_OQpz.InputType = "MultipleChoice"
_OQpz.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_gYCA = Wherigo.ZInput(_4Ial)
_gYCA.Id = "45dcd647-2d06-4d7e-a331-2c2201bdb2c2"
_gYCA.Name = _l_a8("yC\021")
_gYCA.Description = ""
_gYCA.Visible = true
_gYCA.Choices = {"JA", "NEIN"}
_gYCA.InputType = "MultipleChoice"
_gYCA.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_p6J = Wherigo.ZInput(_4Ial)
_p6J.Id = "8cc034a7-46e9-42e0-95f6-aeaa1bdc7204"
_p6J.Name = _l_a8("yC\\")
_p6J.Description = ""
_p6J.Visible = true
_p6J.Choices = {"JA", "NEIN"}
_p6J.InputType = "MultipleChoice"
_p6J.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_tw_Oi = Wherigo.ZInput(_4Ial)
_tw_Oi.Id = "443d4b72-7826-454e-b1b2-029a4de7879f"
_tw_Oi.Name = _l_a8("yC]")
_tw_Oi.Description = ""
_tw_Oi.Visible = true
_tw_Oi.Choices = {"JA", "NEIN"}
_tw_Oi.InputType = "MultipleChoice"
_tw_Oi.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_cgByZ = Wherigo.ZInput(_4Ial)
_cgByZ.Id = "5c1fd05e-0f11-47f2-804d-59e79455fc11"
_cgByZ.Name = _l_a8("yC;")
_cgByZ.Description = ""
_cgByZ.Visible = true
_cgByZ.Choices = {"JA", "NEIN"}
_cgByZ.InputType = "MultipleChoice"
_cgByZ.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_2pbL = Wherigo.ZInput(_4Ial)
_2pbL.Id = "e23c84e6-272d-4de4-b7cd-02bd4d0b3557"
_2pbL.Name = _l_a8("yCk")
_2pbL.Description = ""
_2pbL.Visible = true
_2pbL.Choices = {"JA", "NEIN"}
_2pbL.InputType = "MultipleChoice"
_2pbL.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_226vP = Wherigo.ZInput(_4Ial)
_226vP.Id = "47eb07f5-6bde-4c97-ab40-8e239bd6d8b5"
_226vP.Name = _l_a8("yCZ")
_226vP.Description = ""
_226vP.Visible = true
_226vP.Choices = {"JA", "NEIN"}
_226vP.InputType = "MultipleChoice"
_226vP.Text = _l_a8("\019|\002\028\002yOcz\028S\028OT\028sfz=\bSU|TTSsf\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002bS2s\028OSvfTTg=Ss(ScTT\028Sc\002s\028O\028\002S\028Og=S0cTST|\028g\028\002bSt\028\002\002S0\028\027OScTgS\\Scu=f9\028S\019|\002\028\002SzT\028f4\027\020\028f=fzS\002f00=SscgS\nO|zOc00S\002f4\027=Sc\002\bS\127\002Ssf\028g\0280S.cTTS0(ggS9|OS2O=S\028Og=Ssf\028S5(yzcX\028Sz\028g4\027cyy=Sv\028Os\028\002\b")
_c5R = Wherigo.ZInput(_4Ial)
_c5R.Id = "844cdd13-32c4-44a9-bc05-ee02c9216a75"
_c5R.Name = _l_a8("N\002T|4u4|s\028")
_c5R.Description = ""
_c5R.Visible = true
_c5R.InputType = "Text"
_c5R.Text = _l_a8("\023\028X\028SscgS\ncggv|O=S\031g=\028\027=Sf0S#|zX|4\027mS\028f\002!S(0Ss\028\002SN\002T|4u4|s\028S9|\002Ssf\028g\0280S&\027\028Ofz|S\020(SX\028u|00\028\002")
function _4Ial:OnStart()
  Wherigo.PlayAudio(_z37su)
  _Urwigo.MessageBox({
    Text = _l_a8("*cTT|SK}\030fK\bSt(Svczg=S\028gScTg|!SsfOSs\028\002S\018|\030yS\020(S\020\028OXO\0284\027\028\002\bS\016f\028TSU\030cgg\bS\1270S\127\0029\028\002=|OiSyf\002s\028g=Ss(Ssf\028S\006(4\027g=cX\028\002SK5KSXfgSK_K\bS+f\030\030\028S\028f\002\028\002Sc\002!Sv\028\002\002Ss(SsfOSgf4\027\028OSXfg=!Ssf\028S#|\028g(\002zS\020(Ss\0280SG\028v\028fTfz\028\002S\fc\028=g\028TS\020(Svfgg\028\002\bS#f\028zg=Ss(SOf4\027=fz!Suc\002\002g=Ss(S0\028\027OS\028Oyc\027O\028\002Sf0S\006\028O\028f4\027SKtNSU\127}*U+K\bSt|O=SX\028u|00g=Ss(S\127\002y|g!S(0Ss\028\002SG\028v\028fTfz\028\002S2O=S\028Oy|TzO\028f4\027SX\028g(4\027\028\002S\020(Su|\028\002\002\028\002\bS*cg=Ss(ScTT\028S@CS2O=\028!Suc\002\002g=Ss(S\020(0S.f\002cT\bS"),
    Media = _dYPiH,
    Callback = function(action)
      if action ~= nil then
        _hIUhz:MoveTo(Player)
        _5ap6:MoveTo(Player)
        _X1NDx:MoveTo(Player)
        _nbxoW:MoveTo(Player)
        _BVni7:MoveTo(Player)
        _ns6:MoveTo(Player)
        _UrTLQ:MoveTo(Player)
        _l56:MoveTo(Player)
        _DOM2:MoveTo(Player)
        _RMo6:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _4Ial:OnRestore()
end
function _Egs:OnEnter()
  _FCX = _l_a8("[}zg")
  _gr0.Visible = true
  Wherigo.PlayAudio(_udt)
  _Urwigo.MessageBox({
    Text = "",
    Media = _BgWap,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _YhP:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Rotii = input
  if Wherigo.NoCaseEquals(_Rotii, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 51455 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _TNA1A = _TNA1A + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYY!S\018|O\0020cOu=S\0314c\bS~S\021ZS\024]\bZ\021\\S}SC@@SC\021\b\\@;m"),
        Media = _0YoFE,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_YdO)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _1ilYc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _9qC8k = input
  if Wherigo.NoCaseEquals(_9qC8k, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 46572 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _8Zso = _8Zso + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYY!S&\028fgg\028OS+(O0S\0314c\bS~S\021ZS\024;\bC\024kS}SC@@SC\021\b\024\021\024m"),
        Media = _3EkEs,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_Cc6K9)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _1zC7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _a7M = input
  if Wherigo.NoCaseEquals(_a7M, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 6979 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _ywea = _ywea + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\ff4\027=fzSYYYYS\f|gc/#(%\0280X(Oz/\nTc=\020S\0314c\bSX\028fS~S\021ZS\024;\b@@kS}SC@@SC\\\bC;\\m"),
        Media = _2OMEK,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_CSMnA)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _BaI:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _xSKh = input
  if Wherigo.NoCaseEquals(_xSKh, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 39573 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _aWAo = _aWAo + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYS.T\028fg4\027XO(\0284u\028S\0314c\bS~S\021ZS\024;\b@;\021S}SC@@SC\021\b]Ckm"),
        Media = _xfAsS,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_OQpz)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _EHX:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _d018 = input
  if Wherigo.NoCaseEquals(_d018, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 3375 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Lldk0 = _Lldk0 + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYS}\027\028ucO(gg\028TTS\0314c\bS~S\021ZS\024;\bCx\021S}SC@@SC\021\b\024\\\021m"),
        Media = _sbBa,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_gYCA)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _pHR_O:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _wUffE = input
  if Wherigo.NoCaseEquals(_wUffE, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 20172 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _i0c6 = _i0c6 + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYS\f|g\028\002c(S\0314c\bS~S\021ZS\024;\bC\\@S}SC@@SCx\bk]Cm"),
        Media = _Uu7,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_p6J)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Spu2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _UqE = input
  if Wherigo.NoCaseEquals(_UqE, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 57565 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _zeA = _zeA + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYS6\028fg=\028Ogf\002z\028O\027cTT\028S\0314c\bS~S\021ZS\024]\b\024kkS}SC@@SC]\b\024Zkm"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_tw_Oi)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _ZPGqN:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _x1fT6 = input
  if Wherigo.NoCaseEquals(_x1fT6, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 28697 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _wIP = _wIP + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYSt|u(0\028\002=c=f|\002g\020\028\002=O(0S\0314c\bS~S\021ZS\024]\bC\\CS}SC@@SC]\b;\\]m"),
        Media = _us6d,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_cgByZ)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _0nMT:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _OCJO = input
  if Wherigo.NoCaseEquals(_OCJO, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 21657 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _OOKI2 = _OOKI2 + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYSUfTX\028Og\028\028S\0314c\bS~S\021ZS\024\\\bx\021kS}SC@@SC]\b\\\\\024m"),
        Media = _wYI,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_2pbL)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _4aJT:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _L7hI3 = input
  if Wherigo.NoCaseEquals(_L7hI3, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 37977 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _RhNj6 = _RhNj6 + 1
      Wherigo.PlayAudio(_947)
      _Urwigo.MessageBox({
        Text = _l_a8("\f\127l*+\127\023SYYYYYYS6c%=|OS\0314c\bS~S\021ZS\024;\b\\@xS}SC@@SC\021\bZ\024@m"),
        Media = _24Vo,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_226vP)
            end)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!SscS0(gg=Sv\028f=\028OSu\002|X\028T\002"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _YJE9w:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _kdRRs = input
  if Wherigo.NoCaseEquals(_kdRRs, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 54612 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    __d3.Visible = false
    _K9NS3.Active = false
    Wherigo.PlayAudio(_a5E)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SKt|u(0\028\002=c=f|\002g\020\028\002=O(0KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _NSu:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _6lw = input
  if Wherigo.NoCaseEquals(_6lw, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 32031 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _WuuN.Visible = false
    _8Rse7.Active = false
    Wherigo.PlayAudio(_YR1kd)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK6c%=|OKSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _jIj:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _y5Lw7 = input
  if Wherigo.NoCaseEquals(_y5Lw7, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 2953 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _xXO.Visible = false
    _bYH.Active = false
    Wherigo.PlayAudio(_Aee7b)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SKUfTX\028Og\028\028KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _pFJ:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _QSYzq = input
  if Wherigo.NoCaseEquals(_QSYzq, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 18049 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _koi.Visible = false
    _oz8Ni.Active = false
    Wherigo.PlayAudio(_P5jVk)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK}\027\028ucO(gg\028TTKSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _hB6U7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Rcm = input
  if Wherigo.NoCaseEquals(_Rcm, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 10979 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _u5j.Visible = false
    _ZAQg.Active = false
    Wherigo.PlayAudio(_o_Bf)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK&\028fgg\028OS+(O0KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _FtldU:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _YFz = input
  if Wherigo.NoCaseEquals(_YFz, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 46500 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _Tirx.Visible = false
    _Nu6.Active = false
    Wherigo.PlayAudio(_C_w)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK6\028fg=\028Ogf\002z\028O\027cTT\028KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _RB78:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _KynhG = input
  if Wherigo.NoCaseEquals(_KynhG, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 14455 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _fY9tZ.Visible = false
    _jnF4.Active = false
    Wherigo.PlayAudio(_dWfcE)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK\f|gc/#(%\0280X(Oz/\nTc=\020KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Q24AT:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _thWA = input
  if Wherigo.NoCaseEquals(_thWA, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 6621 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _s8jbT.Visible = false
    _qgu.Active = false
    Wherigo.PlayAudio(_fcWdF)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK.T\028fg4\027XO(\0284u\028KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Z8E:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _ua5 = input
  if Wherigo.NoCaseEquals(_ua5, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 1426 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _5Ry7.Visible = false
    _r9V.Active = false
    Wherigo.PlayAudio(_6OH)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK\018|O\0020cOu=KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Ber:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _7c5 = input
  if Wherigo.NoCaseEquals(_7c5, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 48328 then
    _SfW5 = _SfW5 + -1
    _NSEs = _NSEs + 1
    _2Aig.Visible = false
    _YSflW.Active = false
    Wherigo.PlayAudio(_9VL)
    _Urwigo.MessageBox({
      Text = _l_a8("\f\127l*+\127\023YYYS/St\028OS\006\028O\028f4\027SK\f|g\028\002c(KSfg=S\028Oy|TzO\028f4\027ScXz\028g4\027T|gg\028\002"),
      Media = _FrVdJ,
      Callback = function(action)
        if action ~= nil then
          if _NSEs == 10 then
            _Egs.Visible = true
            _Egs.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("~\028f\002!S\030O|Xf\028OS\028gS\002|4\027S0cT"),
      Media = _TDdoC,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function __uuB:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _Urwigo.MessageBox({
      Text = _l_a8("2uci!S4||T\bStc\002\002Sc(ySf\002Ss\028\002S#cs\028\002SK\018(4\027\028\002g4\0270(4uKS\031\f|TT\002\028Og=O\bS\021Cm\bS6c\002Sv\028fggSs|O=S\006\028g4\027\028fs\bS5X\028OS9|O\027\028OS0(ggS\028f\002\028SK\ncO|T\028KSc(yz\028gcz=Sv\028Os\028\002\bSU|\002g=SvfOsSs\028OSlc4\027\028S\002f4\027=S(\028X\028Oz\028X\028\002\bStf\028S\ncO|T\028Sfg=S\002(\002Sf0S\127\0029\028\002=cO\bS\016f\028T\028\002Stc\002uSy(\028OSscgSu|OO\028u=\028St(O4\027g\030f\028T\028\002Ss\028gS&\027\028Ofz|g\b"),
      Media = _f2g0l,
      Callback = function(action)
        if action ~= nil then
          _gr0.Visible = true
          _dxvg.Visible = false
          _jdZW.Visible = true
          _Urwigo.MessageBox({
            Text = _l_a8("U|TT=\028=Sf\027OSs|4\027S\002f4\027=S\020(0Sf\002|yyf\020f\028TT\028\002S.f\002cTSv|TT\028\002!Sg|Su|\028\002\002=Sf\027OS\028(4\027Sf00\028OS\002|4\027Ss\028\002S|yyf\020f\028TT\028\002S#|z\028f\002=OczSgf4\027\028O\002SX\028fS~\021ZS\023OcsS\024;\b;x\021S(\002sS}@@S\023OcsSC\021\bZ\\;\b"),
            Media = _f2g0l
          })
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _l_a8("tc\002\002SX\028sc\002u\028Sf4\027S0f4\027Szc\002\020S\027\028O\020Tf4\027Sy(\028OSscgSt(O4\027g\030f\028T\028\002S(\002sSv(\028\002g4\027\028S\002|4\027S9f\028TSU\030cggSX\028f0SU(4\027\028\002Ss\028OS.fT0s|g\028S:S\n\028=Tf\002zSc(yS:SX\028fSs\028OSg\028\027OSuT\028f\002\028\002S\023O(\028\002yTc\0284\027\028S\031~\021ZS\023OcsS\024;\b;x\021S(\002sS}@@S\023OcsSC\021\bZ\\;m"),
      Media = _ltdg,
      Callback = function(action)
        if action ~= nil then
          _gr0.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _YdO:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _r9V.Active = true
      _SfW5 = _SfW5 + 1
      _hIUhz.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _Cc6K9:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _ZAQg.Active = true
      _SfW5 = _SfW5 + 1
      _5ap6.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _CSMnA:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _jnF4.Active = true
      _SfW5 = _SfW5 + 1
      _X1NDx.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _OQpz:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _qgu.Active = true
      _SfW5 = _SfW5 + 1
      _nbxoW.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _gYCA:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _oz8Ni.Active = true
      _SfW5 = _SfW5 + 1
      _BVni7.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _p6J:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _YSflW.Active = true
      _SfW5 = _SfW5 + 1
      _ns6.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _tw_Oi:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Nu6.Active = true
      _SfW5 = _SfW5 + 1
      _UrTLQ.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _cgByZ:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _K9NS3.Active = true
      _SfW5 = _SfW5 + 1
      _l56.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _2pbL:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _bYH.Active = true
      _SfW5 = _SfW5 + 1
      _DOM2.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _226vP:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    if _SfW5 > 5 then
      _Urwigo.MessageBox({
        Text = _l_a8("t\028f\002\028S5\002=v|O=Sfg=SOf4\027=fz!ScX\028OSs(S\027cg=SX\028O\028f=gS\\Scu=f9\028S\019|\002\028\002\bS5OX\028f=\028S0f\002s\028g=\028\002gS\028f\002\028ScX!Ssc0f=S\028f\002\028S\002\028(\028S\019|\002\028Scu=f9Sz\028g4\027cT=\028=Sv\028Os\028\002Suc\002\002\b"),
        Media = _Yj2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _8Rse7.Active = true
      _SfW5 = _SfW5 + 1
      _RMo6.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  elseif _Urwigo.Hash(string.lower(input)) == 9796 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function _c5R:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _B0KZ = input
  if Wherigo.NoCaseEquals(_B0KZ, "") then
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 59918 then
    __VO = 1
    _Urwigo.MessageBox({
      Text = _l_a8("t\028OSN\002T|4u4|s\028STc(=\028=\003") .. string.sub(Player.CompletionCode, 1, 15)
    })
  else
    Wherigo.PlayAudio(_FYXNA)
    _Urwigo.MessageBox({
      Text = _l_a8("\ncggv|O=Sc(gSs\0280S#|zX(4\027SycTg4\027S\028f\002z\028z\028X\028\002\bS\006f==\028S\002|4\027S0cTS9\028Og(4\027\028\002"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _WuuN:On_xUPwd(target)
  _Urwigo.MessageBox({
    Text = _l_a8("50S6c%=|OSyf\002s\028g=Ss(Sf0S\002c\027\028\002SN0uO\028fgS\0310f==\028\002Sf\002Ss\028OS&f\028g\028mS\028f\002\028SUu(T=\030(O\bStf\028g\028S\027c=SsfO\028u=Sc0SK\018|\028O\030\028OKSy(\028OSsf4\027S\028f\002S\030ccOS\006(4\027g=cX\028\002S\030cOc=\bStf\028g\028S\006(4\027g=cX\028\002SXf==\028S\028f\002z\028X\028\002\b"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _WuuN:On_zDN0Q(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_NSu)
  end)
end
function _koi:On_S3Cw(target)
  _Urwigo.MessageBox({
    Text = _l_a8("}\n\127\003SU(4\027\028SKscgS*\028O\020KSc0S\006O(\002\002\028\002S(\002sSg(4\027\028Sf0SO\0284\027=\028\002S+\028%=Sf\002Ss\028OS9f\028O=\028\002S\019\028fT\028SscgST\028=\020=\028S&|O=S\031gf\028\027\028S\006fTsm"),
    Media = _jFnL,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _koi:On_t3tMy(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_pFJ)
  end)
end
function _u5j:On_1LY(target)
  _Urwigo.MessageBox({
    Text = _l_a8("*f\028OS0c4\027\028Sf4\027S\028gSsfOS\028f\002SXfgg4\027\028\002S\028f\002yc4\027\028O\003S\019c\028\027T\028S\028f\002yc4\027Sc0SU4\027fTsS\031U\028f=\028S9|0SN/\006c\027\002/5(gzc\002zmSsfO\028u=Sc0S+(O0Ssf\028Sz|Ts\028\002\028\002S\006(4\027g=cX\028\002S\031$5m\bStc\002\002S\002f00g=Ss(SscgS&|O=Sf\002Ss\028OSsOf==\028\002Ss(\002uT\028\002S\019\028fT\028S\031$\006m\bSN\002sS\020(0SU4\027T(ggSg(4\027\028SsfO\028u=Sc0S+(O0S\028f\002\028\002S\006(4\027g=cX\028\002Sc(ySv\028fgg\0280S\023O(\002sS\031$lm\bStf\028S#|\028g(\002zSfg=\003S5\006l"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _u5j:On__jvb(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_hB6U7)
  end)
end
function _xXO:On_O5t(target)
  _Urwigo.MessageBox({
    Text = _l_a8("U|!STf\028X\028OS}\030f\bSU(4\027\028S+cy\028TSZ\bSt|O=Syf\002s\028g=Ss(SsO\028\027XcO\028S*|T\020=cy\028T\002\bStf\028S5\002\020c\027TSs\028OSsO\028\027XcO\028\002S+cy\028T\002Sfg=SK5K\bS~(\002Sg4\027c(SsfOSsf\028SO\0284\027=\028S+cy\028TSz\028\002c(Sc\002\bSt|O=S0|\0284\027=\028Sf4\027Ss\028\002S\006(4\027g=cX\028\002Ss\028OSOf4\027=fz\028\002S5\002=v|O=S\027cX\028\002S\031$\006m\bS\127\002Ss\028OST\028=\020=\028\002S\019\028fT\028Ss\028OS\f(\0284ug\028f=\028S\002f00g=Ss(S\002|4\027SscgSTc\028\002zg=\028S&|O=S\031$lm\bS~(\002S\002f00S\002|4\027Ssf\028SG\028v\028fTfz\028\002S5\002yc\002zgX(4\027g=cX\028\002Ss\028OS\\S\019\028fT\028\002Sc(ySs\028OS\f(\0284ug\028f=\028S\031$tm\bS#|\028g(\002z\003S5\006lt"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _xXO:On_jadC3(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_jIj)
  end)
end
function __d3:On_VQTe(target)
  _Urwigo.MessageBox({
    Text = _l_a8("t(Su|00g=Ssf\028S+O\028\030\030\028SO(\002=\028OS9|0St|u(/\019\028\002=O(0\003SU(4\027\028Ssf\028S\002c\0284\027g=z\028T\028z\028\002\028SU=Ocgg\028\002Tc=\028O\002\028Sz\028z\028\002(\028X\028OSs\028OS+O\028\030\030\028S\002c\027\028Ss\028\002SU4\027f\028\002\028\002\bS\127\027O\028S9f\028Og=\028TTfz\028S.cXOfu\002(00\028OS\031$5m\bStf\028Sv\028fgg\028SsO\028fg=\028TTfz\028S\019c\027TSc0SzT\028f4\027\028\002S#c=\028O\002\028\0020cg=\028\002S\031$\006m\bS~(\002Sz\028\027S\020(Ss\028\002SX\028fs\028\002S\127\002y|=cy\028T\002S(\028X\028OSscgSt|u(\020\028\002=O(0\bSt|O=Sg(4\027g=Ss(S\028f\002\028SU4\027Oc(X\028\002\002(00\028Of\028O(\002zSvf\028Sy|Tz=\003SP\002Xg\030Q.US5\024S/SKbbK\bSP\002Xg\030Qtf\028S.Ocz\028\020\028f4\027\028\002Sgf\002sSKlK\bS#|\028g(\002zSy(\028OSsf\028g\028S\019|\002\028\003S5\006lS"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function __d3:On_ET1M(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_YJE9w)
  end)
end
function _Tirx:On_i_7PU(target)
  _Urwigo.MessageBox({
    Text = _l_a8("50S*c(\030=\028f\002zc\002zSyf\002s\028g=Ss(S\028f\002S\018(\002g=v\028Ou\bS5(ySs\028OS\127\002y|=cy\028TSXf==\028ScTT\028S\019c\027T\028\002Ssf\028Ss(STf\028g=Sf\002Ss\028OS\f\028f\027\028\002y|Tz\028S9|\002STf\002ugS|X\028\002S\002c4\027SO\0284\027=gS(\002=\028\002S\031#\028g\028Of4\027=(\002zmS|\027\002\028S#\028\028O\020\028f4\027\028\002S\028f\002z\028X\028\002\bSP\002Xg\030Q"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Tirx:On_Sepk(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_FtldU)
  end)
end
function _fY9tZ:On_hYLv(target)
  _Urwigo.MessageBox({
    Text = _l_a8("_cSvf\028Sz\028gcz=\003St\028OS\nTc=\020Sfg=ScXg|T(=S\002f%SX\028g|\002s\028O\028g\bS5X\028OSs\028OS\023\028v\028OX\0280(g\028(0g\030Tc=\020SzT\028f4\027Ssc\002\028X\028\002\bS\023\028\027Ss|4\027S0cTS\020(Ss\0280S\023\028XfTs\028Sc(ySs\0280S.|=|\bSt|O=S\028OvcO=\028=Ssf4\027Sy|Tz\028\002s\028S5(yzcX\028\003-\006\f)5ssf\028O\028Ssf\028S5\002\020c\027TSs\028OS#f\002f\028\002!Ssf\028S9|\002S\028f\002\028OS0\028=cTTg4\027\002\028fs\028\002s\028\002SU=f4\027gc\028z\028Su|00\028\002Su|\028\002\002=\028\002S0f=Ss\028OS5\002\020c\027TSs\028OS\018O\028fg\028Sc(ySs\028OSzT\028f4\027\028\002Sg4\027Oc\028z\028\002SzO|gg\028\002S6\028=cTT\030Tc==\028S\031$5m\bSP\002Xg\030Q~(\002S\020(SK\006K\003S50S\006|s\028\002Ss\028gS\023\028XfTs\028gSz\028\027\028\002Sz|Ts\028\002\028S#f\002f\028Sf\002ScTT\028S9f\028OS*f00\028TgOf4\027=(\002z\028\002\bSU(4\027\028Ssf\028S#f\002f\028!Ssf\028S\020(0SzO|gg\028\002S\023\028Xc\028(s\028Sy(\028\027O=SX\020v\bS\020\028fz=\bS5(yS4fO4cS\027cTX\028\002S&\028zSyf\002s\028=Sf\027OS\020v\028fS&|\028O=\028OS\002\028X\028\002\028f\002c\002s\028O\bS\016|0S\028Og=\028\002S&|O=SXf==\028Ss\028\002S\006(4\027g=cX\028\002S\002\028\0270\028\002!Ss\028OSf0S5T\030\027cX\028=Sc0SK9|Os\028Og=\028\002KSfg=\bS\016|0S\020v\028f=\028\002S&|O=Ss\028\002S\006(4\027g=cX\028\002!Ss\028OSf0S5T\030\027cX\028=Sc0SK\027f\002=\028g=\028\002KSTf\028z=\bS\019(0SU4\027T(ggS\002|4\027Ss\028\002S\006(4\027g=cX\028\002v|O=v\028O=S9|0S&|O=!SscgSc0S}\002s\028Ssf\028g\028OSz|Ts\028\002\028\002S#f\002f\028Sfg=S\031$lm\bS#|\028g(\002z\003SK5\006lK"),
    Media = _2OMEK,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _fY9tZ:On_tnky(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_RB78)
  end)
end
function _s8jbT:On_MUrdz(target)
  _Urwigo.MessageBox({
    Text = _l_a8("}\n\127\003SU=\028TTSsf4\027S0f==\028\002Sc(ySsf\028S\006O(\0284u\028S(\002sSg(4\027\028Sf\002Ss\028OS.\028O\002\028S\028f\002\028\002S\028\002zTfg4\027\028\002SUc=\020\bSt(SvfOg=Sf\002Ssf\028g\0280SUc=\020S\028f\002S&|O=Syf\002s\028\002!SscggS\028gSc(4\027Sf0Ss\028(=g4\027\028\002SzfX=S\031$^m\bStf\028gS\002|=f\028O\028\002S(\002sS0\028Ou\028\002\bStc\002\002Sg(4\027\028SXf==\028S\020v\028fS\002\028X\028\002\028f\002c\002s\028OSTf\028z\028\002s\028S+cy\028T\002Sc\002Ss\028OS\006O(\0284u\028\bSt|O=SvfOg=Ss(SxS\019c\027T\028\002Syf\002s\028\002\bS\019(0S5XzT\028f4\027\003Sc\002S\028f\002\028OS+cy\028TSvfOg=Ss(SvcgSyf\002s\028\002!SvcgS0f=SK}\127UKS\020(S=(\002S\027c=\031=\028m\bS5ssf\028O\028ScTT\028SxS\019c\027T\028\002\bStcgS}Oz\028X\002fgSfg=SW\bStf\028S#|\028g(\002zSsf\028g\028OS\019|\002\028Sfg=S\031|\027\002\028S#\028\028O\020\028f4\027\028\002m\003S^W"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _s8jbT:On_RcL(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Q24AT)
  end)
end
function _5Ry7:On_sIqaE(target)
  _Urwigo.MessageBox({
    Text = _l_a8("}\n\127\003S-\006\f)U(4\027\028Sc(ySs\0280S\nTc=\020S\028f\002S\018(\002g=v\028OuS0f=Ss\0280S~c0\028\002SK\n\027|\028\002f%S\127KS\031gf\028\027\028S\006fTsm\bS}Ozc\028\002\020\028S|\027\002\028S#\028\028O\020\028f4\027\028\002Ssf\028S\020v\028fSy\028\027T\028\002s\028\002S&|O=\028S(\002sSsf\028Sy\028\027T\028\002s\028S_c\027O\028g\020c\027TS\031scgSv\028fggS(\028X\028O0cT=\028Sc(ySs\0280S\006fTsm\b-\006\f)-\006\f)"),
    Media = _njP,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _5Ry7:On_GHQTF(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Z8E)
  end)
end
function _2Aig:On_kzm(target)
  _Urwigo.MessageBox({
    Text = _l_a8("\127\002Ssf\028g\0280Sg4\027|\028\002\028\002S(\002sS(\028X\028Og4\027c(XcO\028\002S\ncOuSg(4\027g=Ss(S\028Og=S0cTSscgSc(yyc\028TTfz\028Sg=\028f\002\028O\002\028S2XG\028u=Sc\002S\028f\002\0280S\nTc=\020\bS5(4\027Ss|O=SvfOg=Ss(Sc\002S\028f\002\028OS+cy\028TS\028f\002\028S_c\027O\028g\020c\027TSyf\002s\028\002\bS5(gSsf\028g\028OS\019c\027TSXfTs\028S\020(\028Og=Ssf\028S\004(\028Og(00\028S\031$5m\bStf\028S\020v\028f=\028S(\002sS9f\028O=\028S\019fyy\028OSsf\028g\028OS\019c\027TSXf==\028S0(T=f\030Tf\020f\028O\028\002S\031$\006m\bSP\002Xg\030Qtf\028S9f\028O=\028S\019c\027TS0f=Sgf4\027Sg\028TXg=S0(T=f\030Tf\020f\028O\028\002S\031$lm\bStc\002c4\027S\002f00g=Ss(S9|\002Ss\028OS+cy\028TS\002|4\027SscgS&|O=S0f=Ss\028\002S0\028fg=\028\002S\006(4\027g=cX\028\002S\031$tm\bS#|\028g(\002zSy(\028OS\f|g\028\002c(\003SP\002Xg\030Q5\006lt"),
    Media = _bBX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _2Aig:On_bVd(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Ber)
  end)
end
function _hIUhz:On_XD7_(target)
  if _TNA1A > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_YdO)
    end)
  elseif _TNA1A == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_YhP)
    end)
  end
end
function _5ap6:On_mLv(target)
  if _8Zso > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_Cc6K9)
    end)
  elseif _8Zso == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_1ilYc)
    end)
  end
end
function _X1NDx:On_H0UOq(target)
  if _ywea > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_CSMnA)
    end)
  elseif _ywea == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_1zC7)
    end)
  end
end
function _nbxoW:On_rmT4(target)
  if _aWAo > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_OQpz)
    end)
  elseif _aWAo == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_BaI)
    end)
  end
end
function _BVni7:On_gcAA(target)
  if _Lldk0 > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_gYCA)
    end)
  elseif _Lldk0 == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_EHX)
    end)
  end
end
function _ns6:On_UP0(target)
  if _i0c6 > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_p6J)
    end)
  elseif _i0c6 == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_pHR_O)
    end)
  end
end
function _UrTLQ:On_3QuWu(target)
  if _zeA > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_tw_Oi)
    end)
  elseif _zeA == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_Spu2)
    end)
  end
end
function _l56:On_SkL(target)
  if _wIP > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_cgByZ)
    end)
  elseif _wIP == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_ZPGqN)
    end)
  end
end
function _DOM2:On_eYft(target)
  if _OOKI2 > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_2pbL)
    end)
  elseif _OOKI2 == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_0nMT)
    end)
  end
end
function _RMo6:On_OSj(target)
  if _RhNj6 > 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_226vP)
    end)
  elseif _RhNj6 == 0 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_4aJT)
    end)
  end
end
function _gr0:On_xTJ(target)
  if __VO == 1 then
    _Urwigo.MessageBox({
      Text = _l_a8("t\028OSN\002T|4u/l|s\028STc(=\028=\003S") .. string.sub(Player.CompletionCode, 1, 15)
    })
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_c5R)
    end)
  end
end
function _dxvg:On_4nMl(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(__uuB)
  end)
end
return _4Ial
