require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _CQPB(str)
  local res = ""
  local dtable = "xt\015\000@v=M\"\r2\014]V\018P*r:#'[G4O\031+\fY\002-9s<~\028S7Z\020,\026uQ\b\017\\!>\t \v1e6(`\023N\016\003EycTk\a$H}|gK?J\030XW8aI)FBoC\004p3\019%qmwh&ld\029.Aiz\nf\024\027\005/Rn\025_U\022L;\021Dj5\0010{b^\006"
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
_ZPAkP = Wherigo.ZCartridge()
_OP8W4 = Wherigo.ZMedia(_ZPAkP)
_OP8W4.Id = "99fd034d-133f-4ab2-9204-70caf846f3c6"
_OP8W4.Name = _CQPB("\016fPoU")
_OP8W4.Description = ""
_OP8W4.AltText = ""
_OP8W4.Resources = {
  {
    Type = "jpg",
    Filename = "piano-chopin-pleyel21.jpg",
    Directives = {}
  }
}
_yXJ = Wherigo.ZMedia(_ZPAkP)
_yXJ.Id = "2ed3555d-6e2e-4d41-86dd-31e759cec236"
_yXJ.Name = _CQPB("VP\018\002+xP")
_yXJ.Description = ""
_yXJ.AltText = ""
_yXJ.Resources = {
  {
    Type = "jpg",
    Filename = "cartuja_2_1335256896_3.jpg",
    Directives = {}
  }
}
_BuTP = Wherigo.ZMedia(_ZPAkP)
_BuTP.Id = "8da62d48-fbe3-4b86-9827-c5ff43422386"
_BuTP.Name = _CQPB("V6abP")
_BuTP.Description = ""
_BuTP.AltText = ""
_BuTP.Resources = {
  {
    Type = "jpg",
    Filename = "chopin_piano2.jpg",
    Directives = {}
  }
}
_r8v4 = Wherigo.ZMedia(_ZPAkP)
_r8v4.Id = "0b82113b-d5dc-4f33-b149-2d852739ebc6"
_r8v4.Name = _CQPB("V_UXfo")
_r8v4.Description = ""
_r8v4.AltText = ""
_r8v4.Resources = {
  {
    Type = "jpg",
    Filename = "Chopin51.jpg",
    Directives = {}
  }
}
_0tG = Wherigo.ZMedia(_ZPAkP)
_0tG.Id = "29258e66-a9b6-4395-b3ac-931389493964"
_0tG.Name = _CQPB("V_UXfo3\v")
_0tG.Description = ""
_0tG.AltText = ""
_0tG.Resources = {
  {
    Type = "JPG",
    Filename = "Chopin33.JPG",
    Directives = {}
  }
}
_g4A = Wherigo.ZMedia(_ZPAkP)
_g4A.Id = "7a69dc51-9088-41e8-9006-f1de51662f7a"
_g4A.Name = _CQPB("%Pob")
_g4A.Description = ""
_g4A.AltText = ""
_g4A.Resources = {
  {
    Type = "jpg",
    Filename = "Sand21.jpg",
    Directives = {}
  }
}
_fq1o = Wherigo.ZMedia(_ZPAkP)
_fq1o.Id = "cb02412a-4759-4bf7-94de-8c753342dd4f"
_fq1o.Name = _CQPB("\bP+\018f@6")
_fq1o.Description = ""
_fq1o.AltText = ""
_fq1o.Resources = {
  {
    Type = "jpg",
    Filename = "Maurice2.jpg",
    Directives = {}
  }
}
_MnEpq = Wherigo.ZMedia(_ZPAkP)
_MnEpq.Id = "83dafa7c-441f-45c3-8074-61a4736e4594"
_MnEpq.Name = _CQPB("%UaPHo6")
_MnEpq.Description = ""
_MnEpq.AltText = ""
_MnEpq.Resources = {
  {
    Type = "jpg",
    Filename = "Mercier_Solange_Sand2.jpg",
    Directives = {}
  }
}
_cJ_35 = Wherigo.ZMedia(_ZPAkP)
_cJ_35.Id = "32b97b45-b308-46ea-ae91-bada502eff9a"
_cJ_35.Name = _CQPB("of\0066a3{")
_cJ_35.Description = ""
_cJ_35.AltText = ""
_cJ_35.Resources = {
  {
    Type = "jpg",
    Filename = "nivel0m1.jpg",
    Directives = {}
  }
}
_vTb = Wherigo.ZMedia(_ZPAkP)
_vTb.Id = "cebe64b4-50c9-4f8e-bc2b-5068fd4a8d6a"
_vTb.Name = _CQPB("of\0066a3{3UB")
_vTb.Description = ""
_vTb.AltText = ""
_vTb.Resources = {
  {
    Type = "jpg",
    Filename = "nivel0okm1.jpg",
    Directives = {}
  }
}
_yEZ = Wherigo.ZMedia(_ZPAkP)
_yEZ.Id = "278c28ba-9e66-4ff9-9247-0aebb1761349"
_yEZ.Name = _CQPB("of\0066a35")
_yEZ.Description = ""
_yEZ.AltText = ""
_yEZ.Resources = {
  {
    Type = "jpg",
    Filename = "Nivel1m1.jpg",
    Directives = {}
  }
}
_D3ujN = Wherigo.ZMedia(_ZPAkP)
_D3ujN.Id = "a4845812-de24-4f39-a9dc-efa5850bab90"
_D3ujN.Name = _CQPB("of\0066a353UB")
_D3ujN.Description = ""
_D3ujN.AltText = ""
_D3ujN.Resources = {
  {
    Type = "jpg",
    Filename = "nivel1okm2.jpg",
    Directives = {}
  }
}
_aPbSt = Wherigo.ZMedia(_ZPAkP)
_aPbSt.Id = "a7da01bb-702b-4148-816a-f0273b79cb7c"
_aPbSt.Name = _CQPB("of\0066a3\v")
_aPbSt.Description = ""
_aPbSt.AltText = ""
_aPbSt.Resources = {
  {
    Type = "jpg",
    Filename = "nivel2m1.jpg",
    Directives = {}
  }
}
_nIgBb = Wherigo.ZMedia(_ZPAkP)
_nIgBb.Id = "bc895c8b-4f6c-4741-a018-6cb4dacfe635"
_nIgBb.Name = _CQPB("of\0066a3\v3UBd")
_nIgBb.Description = ""
_nIgBb.AltText = ""
_nIgBb.Resources = {
  {
    Type = "jpg",
    Filename = "nivel2okm2.jpg",
    Directives = {}
  }
}
_Qy2 = Wherigo.ZMedia(_ZPAkP)
_Qy2.Id = "f665d27c-f068-44d5-83ae-0cef6be5759d"
_Qy2.Name = _CQPB("of\0066a3Y")
_Qy2.Description = ""
_Qy2.AltText = ""
_Qy2.Resources = {
  {
    Type = "jpg",
    Filename = "nivel3m1.jpg",
    Directives = {}
  }
}
__CNeV = Wherigo.ZMedia(_ZPAkP)
__CNeV.Id = "3a9f0360-9588-4e62-ae9a-4055604d07e2"
__CNeV.Name = _CQPB("of\0066a3Y3UBd")
__CNeV.Description = ""
__CNeV.AltText = ""
__CNeV.Resources = {
  {
    Type = "jpg",
    Filename = "nivel3okm2.jpg",
    Directives = {}
  }
}
_yeS = Wherigo.ZMedia(_ZPAkP)
_yeS.Id = "b659b8e4-5c5a-44d3-a36a-9909a73835c8"
_yeS.Name = _CQPB("of\0066a3\024")
_yeS.Description = ""
_yeS.AltText = ""
_yeS.Resources = {
  {
    Type = "jpg",
    Filename = "nivel4m1.jpg",
    Directives = {}
  }
}
_aCtV5 = Wherigo.ZMedia(_ZPAkP)
_aCtV5.Id = "941b4f4d-b3c6-4540-a194-b08daebe12b7"
_aCtV5.Name = _CQPB("of\0066a3\0243UBd")
_aCtV5.Description = ""
_aCtV5.AltText = ""
_aCtV5.Resources = {
  {
    Type = "jpg",
    Filename = "nivel4okm2.jpg",
    Directives = {}
  }
}
_ML7x = Wherigo.ZMedia(_ZPAkP)
_ML7x.Id = "a45a6d7d-5beb-4951-8539-2640dcea400c"
_ML7x.Name = _CQPB("of\0066a3y")
_ML7x.Description = ""
_ML7x.AltText = ""
_ML7x.Resources = {
  {
    Type = "jpg",
    Filename = "nivel5m1.jpg",
    Directives = {}
  }
}
_sJkb = Wherigo.ZMedia(_ZPAkP)
_sJkb.Id = "4887c327-5e62-425e-ad73-e97934e927a9"
_sJkb.Name = _CQPB("of\0066a3y3UB")
_sJkb.Description = ""
_sJkb.AltText = ""
_sJkb.Resources = {
  {
    Type = "jpg",
    Filename = "nivel5okm2.jpg",
    Directives = {}
  }
}
_MLsvY = Wherigo.ZMedia(_ZPAkP)
_MLsvY.Id = "4a791c01-f87c-4863-8ff7-1279b847136a"
_MLsvY.Name = _CQPB("i\018fU")
_MLsvY.Description = ""
_MLsvY.AltText = ""
_MLsvY.Resources = {
  {
    Type = "png",
    Filename = "348.png",
    Directives = {}
  }
}
_7X44 = Wherigo.ZMedia(_ZPAkP)
_7X44.Id = "4dbab47d-8b3c-4853-b5b6-9e74f0c761fd"
_7X44.Name = _CQPB("\002U@PobU")
_7X44.Description = ""
_7X44.AltText = ""
_7X44.Resources = {
  {
    Type = "jpg",
    Filename = "t-1091George_Sand____Nohant___coute_Chopin_lrg1.jpg",
    Directives = {}
  }
}
_I62r = Wherigo.ZMedia(_ZPAkP)
_I62r.Id = "2a02074c-eb61-4396-806c-c5b4cabcbb4b"
_I62r.Name = _CQPB("@U@P")
_I62r.Description = ""
_I62r.AltText = ""
_I62r.Resources = {
  {
    Type = "jpg",
    Filename = "coca2_1.jpg",
    Directives = {}
  }
}
_aGTVp = Wherigo.ZMedia(_ZPAkP)
_aGTVp.Id = "b631410b-d563-4b0c-a6fb-01501e70cdec"
_aGTVp.Name = _CQPB("aP}6\018fo\002U!")
_aGTVp.Description = ""
_aGTVp.AltText = ""
_aGTVp.Resources = {
  {
    Type = "jpg",
    Filename = "laberintom1.jpg",
    Directives = {}
  }
}
_IQAf = Wherigo.ZMedia(_ZPAkP)
_IQAf.Id = "4af5c4d2-9b1d-4440-b63b-392faf489ecc"
_IQAf.Name = _CQPB("P+bfU")
_IQAf.Description = ""
_IQAf.AltText = ""
_IQAf.Resources = {
  {
    Type = "mp3",
    Filename = "FredericChopinPreludeinEMinorop28no400_00_00-00_01_00.mp3",
    Directives = {}
  }
}
_DhR4 = Wherigo.ZMedia(_ZPAkP)
_DhR4.Id = "8e0bebf2-facf-484a-becf-085384e2ec28"
_DhR4.Name = _CQPB("@P\018\002P3`o}!XuifoPa")
_DhR4.Description = ""
_DhR4.AltText = ""
_DhR4.Resources = {
  {
    Type = "jpg",
    Filename = "finalletterm2.jpg",
    Directives = {}
  }
}
_d9IY = Wherigo.ZMedia(_ZPAkP)
_d9IY.Id = "a54d797c-e649-4222-8a74-33d527272f7f"
_d9IY.Name = _CQPB("!U}\0186")
_d9IY.Description = ""
_d9IY.AltText = ""
_d9IY.Resources = {
  {
    Type = "jpg",
    Filename = "sobrem1.jpg",
    Directives = {}
  }
}
_w0KGG = Wherigo.ZMedia(_ZPAkP)
_w0KGG.Id = "23c1850d-6d2b-4d01-9b9f-110e8e00e58f"
_w0KGG.Name = _CQPB("!+bU\0183\v")
_w0KGG.Description = ""
_w0KGG.AltText = ""
_w0KGG.Resources = {
  {
    Type = "jpg",
    Filename = "sudorm1.jpg",
    Directives = {}
  }
}
_bZdQf = Wherigo.ZMedia(_ZPAkP)
_bZdQf.Id = "0adb24fa-86f4-4206-93dc-95fe101e7938"
_bZdQf.Name = _CQPB("aP!\0023!UoH")
_bZdQf.Description = ""
_bZdQf.AltText = ""
_bZdQf.Resources = {
  {
    Type = "wma",
    Filename = "28UnHiveraMojorque.wma",
    Directives = {}
  }
}
_Lsc = Wherigo.ZMedia(_ZPAkP)
_Lsc.Id = "c82ec14d-1923-41d6-8179-26982fc9656b"
_Lsc.Name = _CQPB("aP!\0023!Uo3\v")
_Lsc.Description = ""
_Lsc.AltText = ""
_Lsc.Resources = {
  {
    Type = "mp3",
    Filename = "28UnHiveraMojorque.mp3",
    Directives = {}
  }
}
_qIpc = Wherigo.ZMedia(_ZPAkP)
_qIpc.Id = "11b5cbc6-661a-4c97-8997-34134ea59271"
_qIpc.Name = _CQPB("}+!\002U3\v")
_qIpc.Description = ""
_qIpc.AltText = ""
_qIpc.Resources = {
  {
    Type = "png",
    Filename = "Sintitulo.png",
    Directives = {}
  }
}
_6S9D = Wherigo.ZMedia(_ZPAkP)
_6S9D.Id = "a89338eb-4b1e-449b-a0ec-40592cb15d81"
_6S9D.Name = _CQPB("!XUfa6\018")
_6S9D.Description = ""
_6S9D.AltText = ""
_6S9D.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler1.jpg",
    Directives = {}
  }
}
_l_eF = Wherigo.ZMedia(_ZPAkP)
_l_eF.Id = "9a365169-266d-4737-88bc-55f5b762d893"
_l_eF.Name = _CQPB("P@6\018\0023foH")
_l_eF.Description = ""
_l_eF.AltText = ""
_l_eF.Resources = {
  {
    Type = "jpg",
    Filename = "acertijoinglesm2.jpg",
    Directives = {}
  }
}
_tEkOI = Wherigo.ZMedia(_ZPAkP)
_tEkOI.Id = "13c9ea97-c7ea-4786-b4e8-435d7e762f54"
_tEkOI.Name = _CQPB("a6\0066a3{")
_tEkOI.Description = ""
_tEkOI.AltText = ""
_tEkOI.Resources = {
  {
    Type = "jpg",
    Filename = "level0objm.jpg",
    Directives = {}
  }
}
_oTE = Wherigo.ZMedia(_ZPAkP)
_oTE.Id = "1bb27601-b52f-4853-b804-54828067e959"
_oTE.Name = _CQPB("a6\0066a35")
_oTE.Description = ""
_oTE.AltText = ""
_oTE.Resources = {
  {
    Type = "jpg",
    Filename = "level1objm.jpg",
    Directives = {}
  }
}
_2xzx = Wherigo.ZMedia(_ZPAkP)
_2xzx.Id = "784b165a-e10e-4a10-b746-481851e03717"
_2xzx.Name = _CQPB("a6\0066a3\v")
_2xzx.Description = ""
_2xzx.AltText = ""
_2xzx.Resources = {
  {
    Type = "jpg",
    Filename = "level2objm.jpg",
    Directives = {}
  }
}
_Hz2_ = Wherigo.ZMedia(_ZPAkP)
_Hz2_.Id = "12dbb068-b386-460b-bad5-acfa9792bdae"
_Hz2_.Name = _CQPB("a6\0066a3Y")
_Hz2_.Description = ""
_Hz2_.AltText = ""
_Hz2_.Resources = {
  {
    Type = "jpg",
    Filename = "level3objm.jpg",
    Directives = {}
  }
}
_AsVkB = Wherigo.ZMedia(_ZPAkP)
_AsVkB.Id = "bd5931df-9a6d-4973-8dc9-f8d72992be44"
_AsVkB.Name = _CQPB("a6\0066a3\024")
_AsVkB.Description = ""
_AsVkB.AltText = ""
_AsVkB.Resources = {
  {
    Type = "jpg",
    Filename = "level4objm.jpg",
    Directives = {}
  }
}
_Nd2 = Wherigo.ZMedia(_ZPAkP)
_Nd2.Id = "e5884f1b-1989-43c9-8a71-7ee61dce31f8"
_Nd2.Name = _CQPB("a6\0066a3y")
_Nd2.Description = ""
_Nd2.AltText = ""
_Nd2.Resources = {
  {
    Type = "jpg",
    Filename = "level5objm.jpg",
    Directives = {}
  }
}
_bVJUW = Wherigo.ZMedia(_ZPAkP)
_bVJUW.Id = "92e32b96-35d0-4fc8-9ab7-5e6a0bbffd2f"
_bVJUW.Name = _CQPB("SQ;et3t>AA>n")
_bVJUW.Description = ""
_bVJUW.AltText = ""
_bVJUW.Resources = {
  {
    Type = "jpg",
    Filename = "finalletterm1.jpg",
    Directives = {}
  }
}
_BOFu = Wherigo.ZMedia(_ZPAkP)
_BOFu.Id = "f65001ba-ded9-4343-a295-0a19f17f62aa"
_BOFu.Name = _CQPB("f@Uo")
_BOFu.Description = ""
_BOFu.AltText = ""
_BOFu.Resources = {
  {
    Type = "jpg",
    Filename = "icono.jpg",
    Directives = {}
  }
}
_ZWG = Wherigo.ZMedia(_ZPAkP)
_ZWG.Id = "2bb71d7c-9658-4afc-a648-26dce5c2fc6a"
_ZWG.Name = _CQPB("@Po@fUo3ifoPa")
_ZWG.Description = ""
_ZWG.AltText = ""
_ZWG.Resources = {
  {
    Type = "mp3",
    Filename = "28UnHiveraMojorque4.mp3",
    Directives = {}
  }
}
_ZPAkP.Id = "4b32b740-651d-44a9-a19d-02171c3b65d3"
_ZPAkP.Name = "Un Invierno en Mallorca [English ver.]"
_ZPAkP.Description = [[
The quest for Chopin's piano.<BR>
<BR>
Become Frederich Chopin and find your piano.]]
_ZPAkP.Visible = true
_ZPAkP.Activity = "Fiction"
_ZPAkP.StartingLocationDescription = ""
_ZPAkP.StartingLocation = ZonePoint(39.709533, 2.622483, 0)
_ZPAkP.Version = "1"
_ZPAkP.Company = ""
_ZPAkP.Author = "paradoxs"
_ZPAkP.BuilderVersion = "URWIGO 1.21.5528.18461"
_ZPAkP.CreateDate = "04/03/2016 21:52:58"
_ZPAkP.PublishDate = "1/1/0001 12:00:00 AM"
_ZPAkP.UpdateDate = "07/05/2016 18:09:44"
_ZPAkP.LastPlayedDate = "1/1/0001 12:00:00 AM"
_ZPAkP.TargetDevice = "PocketPC"
_ZPAkP.TargetDeviceVersion = "0"
_ZPAkP.StateId = "1"
_ZPAkP.CountryId = "2"
_ZPAkP.Complete = false
_ZPAkP.UseLogging = true
_ZPAkP.Media = _BOFu
_ZPAkP.Icon = _BOFu
_ItKgi = Wherigo.Zone(_ZPAkP)
_ItKgi.Id = "7d8a969b-6136-430b-8fc5-9778f39ebbea"
_ItKgi.Name = _CQPB("ro3fo\006f6\018oU36o3\bPaaU\018@P")
_ItKgi.Description = ""
_ItKgi.Visible = true
_ItKgi.Commands = {}
_ItKgi.DistanceRange = Distance(0, "meters")
_ItKgi.ShowObjects = "OnEnter"
_ItKgi.ProximityRange = Distance(66, "meters")
_ItKgi.AllowSetPositionTo = false
_ItKgi.Active = true
_ItKgi.Points = {
  ZonePoint(39.7097035609557, 2.62228702507922, 0),
  ZonePoint(39.7095020905935, 2.62239794339119, 0),
  ZonePoint(39.7095696424864, 2.62254121287754, 0),
  ZonePoint(39.709739114488, 2.62243029456553, 0)
}
_ItKgi.OriginalPoint = ZonePoint(39.7096286021309, 2.62241411897837, 0)
_ItKgi.DistanceRangeUOM = "Meters"
_ItKgi.ProximityRangeUOM = "Meters"
_ItKgi.OutOfRangeName = ""
_ItKgi.InRangeName = ""
_ieSHa = Wherigo.Zone(_ZPAkP)
_ieSHa.Id = "332187fe-1d4e-41ea-8513-521fa8beef44"
_ieSHa.Name = _CQPB("\bPbP]63w+b6\006Po\0023?3V_UXfo3!6o\002PbU!36o3aU!3}Po@U!d3")
_ieSHa.Description = _CQPB("\bPbP]63w+b6\006Po\002)3}6\002\0026\0183BoU^o3P!3\0236U\018H63%Pob)3f!3\002_63^U]Po3^f\002_3^_U]3V_UXfo3af\0066b3fo3\bPaaU\018@Pd")
_ieSHa.Visible = false
_ieSHa.Commands = {}
_ieSHa.DistanceRange = Distance(18, "meters")
_ieSHa.ShowObjects = "OnEnter"
_ieSHa.ProximityRange = Distance(60, "meters")
_ieSHa.AllowSetPositionTo = false
_ieSHa.Active = false
_ieSHa.Points = {
  ZonePoint(39.709634383427, 2.62199260602792, 0),
  ZonePoint(39.7095182416442, 2.62205268678021, 0),
  ZonePoint(39.7095739423195, 2.62221752371615, 0),
  ZonePoint(39.7096734923507, 2.62215436189957, 0)
}
_ieSHa.OriginalPoint = ZonePoint(39.7096000149354, 2.62210429460596, 0)
_ieSHa.DistanceRangeUOM = "Meters"
_ieSHa.ProximityRangeUOM = "Meters"
_ieSHa.OutOfRangeName = ""
_ieSHa.InRangeName = ""
__mrGl = Wherigo.Zone(_ZPAkP)
__mrGl.Id = "160a9a5b-4a77-4594-a5a5-6aa237b8e685"
__mrGl.Name = _CQPB("\bP+\018f@63P3aP!3X+6\018\002P!3b6a3]UoP!\0026\018fU")
__mrGl.Description = _CQPB("\bP+\018f@63f!3\bPbP]63w+\0066\006Po\002?!36ab6!\0023!Uo)3}+\0023_63f!3oU\0023V_UXfo?!3@_fabd3")
__mrGl.Visible = false
__mrGl.Commands = {}
__mrGl.DistanceRange = Distance(-1, "feet")
__mrGl.ShowObjects = "OnEnter"
__mrGl.ProximityRange = Distance(60, "meters")
__mrGl.AllowSetPositionTo = false
__mrGl.Active = false
__mrGl.Points = {
  ZonePoint(39.7095158714018, 2.62190479569771, 0),
  ZonePoint(39.7092918831178, 2.62195563325735, 0),
  ZonePoint(39.7094388384761, 2.62219595626672, 0),
  ZonePoint(39.7095443143064, 2.62200801134918, 0)
}
__mrGl.OriginalPoint = ZonePoint(39.7094477268255, 2.62201609914274, 0)
__mrGl.DistanceRangeUOM = "Feet"
__mrGl.ProximityRangeUOM = "Meters"
__mrGl.OutOfRangeName = ""
__mrGl.InRangeName = ""
_XFgZQ = Wherigo.Zone(_ZPAkP)
_XFgZQ.Id = "66d1fec4-dc1c-41fc-ab07-5f940173065e"
_XFgZQ.Name = _CQPB("T+!\002U3b63V_UXfo")
_XFgZQ.Description = ""
_XFgZQ.Visible = false
_XFgZQ.Commands = {}
_XFgZQ.DistanceRange = Distance(-1, "feet")
_XFgZQ.ShowObjects = "OnEnter"
_XFgZQ.ProximityRange = Distance(60, "meters")
_XFgZQ.AllowSetPositionTo = false
_XFgZQ.Active = false
_XFgZQ.Points = {
  ZonePoint(39.7093250666132, 2.62105288144009, 0),
  ZonePoint(39.7092575144809, 2.62107598942178, 0),
  ZonePoint(39.709277661615, 2.6211745834769, 0),
  ZonePoint(39.7093440286034, 2.62114223230256, 0)
}
_XFgZQ.OriginalPoint = ZonePoint(39.7093010678281, 2.62111142166033, 0)
_XFgZQ.DistanceRangeUOM = "Feet"
_XFgZQ.ProximityRangeUOM = "Meters"
_XFgZQ.OutOfRangeName = ""
_XFgZQ.InRangeName = ""
_VfWw = Wherigo.Zone(_ZPAkP)
_VfWw.Id = "0655b861-3a99-4361-a7ce-c24524db9fcd"
_VfWw.Name = _CQPB("tU!3}Po@U!3b6a3xP\018bfo")
_VfWw.Description = _CQPB("%UaPoH63f!3\bPbP]63w+\0066bPo\002?!3bP+H_\0026\0183}+\0023!_63f!3oU\0023V_UXfo?!3@_fabd3")
_VfWw.Visible = true
_VfWw.Commands = {}
_VfWw.DistanceRange = Distance(-1, "feet")
_VfWw.ShowObjects = "OnEnter"
_VfWw.ProximityRange = Distance(60, "meters")
_VfWw.AllowSetPositionTo = false
_VfWw.Active = false
_VfWw.Points = {
  ZonePoint(39.7091114229103, 2.62151205118824, 0),
  ZonePoint(39.7090608950749, 2.62146085049783, 0),
  ZonePoint(39.7090365232538, 2.6215476456469, 0),
  ZonePoint(39.7090902439399, 2.62157550192446, 0)
}
_VfWw.OriginalPoint = ZonePoint(39.7090747712947, 2.62152401231436, 0)
_VfWw.DistanceRangeUOM = "Feet"
_VfWw.ProximityRangeUOM = "Meters"
_VfWw.OutOfRangeName = ""
_VfWw.InRangeName = ""
_VLHpz = Wherigo.Zone(_ZPAkP)
_VLHpz.Id = "f082585e-89a9-4b01-ac27-d8fc6d24037c"
_VLHpz.Name = _CQPB(">a3\016fPoU0")
_VLHpz.Description = ""
_VLHpz.Visible = false
_VLHpz.Commands = {}
_VLHpz.DistanceRange = Distance(-1, "feet")
_VLHpz.ShowObjects = "OnEnter"
_VLHpz.ProximityRange = Distance(60, "meters")
_VLHpz.AllowSetPositionTo = false
_VLHpz.Active = false
_VLHpz.Points = {
  ZonePoint(39.7093600738592, 2.62150046657569, 0),
  ZonePoint(39.709333763371, 2.62158295077072, 0),
  ZonePoint(39.7094070199995, 2.62161782213771, 0),
  ZonePoint(39.7094235285247, 2.62154472638766, 0)
}
_VLHpz.OriginalPoint = ZonePoint(39.7093810964386, 2.62156149146794, 0)
_VLHpz.DistanceRangeUOM = "Feet"
_VLHpz.ProximityRangeUOM = "Meters"
_VLHpz.OutOfRangeName = ""
_VLHpz.InRangeName = ""
_9c9T7 = Wherigo.Zone(_ZPAkP)
_9c9T7.Id = "5ee28e5f-9f00-4638-9397-d7ec423db0bb"
_9c9T7.Name = _CQPB("5Yd3>a3VP@_6")
_9c9T7.Description = ""
_9c9T7.Visible = false
_9c9T7.Commands = {}
_9c9T7.DistanceRange = Distance(-1, "feet")
_9c9T7.ShowObjects = "OnEnter"
_9c9T7.ProximityRange = Distance(60, "meters")
_9c9T7.AllowSetPositionTo = false
_9c9T7.Active = false
_9c9T7.Points = {
  ZonePoint(39.7121736490928, 2.62383340734234, 0),
  ZonePoint(39.712018357345, 2.62390244978997, 0),
  ZonePoint(39.7121196092534, 2.62408653516548, 0),
  ZonePoint(39.7122091146189, 2.62401967543888, 0)
}
_9c9T7.OriginalPoint = ZonePoint(39.7121301825775, 2.62396051693417, 0)
_9c9T7.DistanceRangeUOM = "Feet"
_9c9T7.ProximityRangeUOM = "Meters"
_9c9T7.OutOfRangeName = ""
_9c9T7.InRangeName = ""
_Q2mV5 = Wherigo.Zone(_ZPAkP)
_Q2mV5.Id = "02de6903-f472-4ee3-9331-4d95e7685adc"
_Q2mV5.Name = _CQPB("tP}6\018fo\002U3Qof@fU3\0313;f\0066a3{")
_Q2mV5.Description = _CQPB("V_UXfo)3X\0186XP\018P\00263XP\018P36]X6gP\01836a3x+6HU3b6a3aP}6\018fo\002U3b63%UaPHo6d\"Tn1\"Tn1\016Uo3]+@_P3P\0026o@fUo3P3aP36\001Xaf@P@fUod")
_Q2mV5.Visible = false
_Q2mV5.Commands = {}
_Q2mV5.DistanceRange = Distance(0, "meters")
_Q2mV5.ShowObjects = "OnEnter"
_Q2mV5.ProximityRange = Distance(60, "meters")
_Q2mV5.AllowSetPositionTo = false
_Q2mV5.Active = false
_Q2mV5.Points = {
  ZonePoint(39.7089968086927, 2.62127525108171, 0),
  ZonePoint(39.7089279434729, 2.62115403152388, 0),
  ZonePoint(39.7088331971345, 2.62145010142228, 0),
  ZonePoint(39.7089479789945, 2.6214260669272, 0)
}
_Q2mV5.OriginalPoint = ZonePoint(39.7089264820737, 2.62132636273877, 0)
_Q2mV5.DistanceRangeUOM = "Meters"
_Q2mV5.ProximityRangeUOM = "Meters"
_Q2mV5.OutOfRangeName = ""
_Q2mV5.InRangeName = ""
_BoY2 = Wherigo.Zone(_ZPAkP)
_BoY2.Id = "12a0f30f-7e53-4944-a858-410bd3f76e59"
_BoY2.Name = _CQPB(";f\0066a35")
_BoY2.Description = ""
_BoY2.Visible = false
_BoY2.Commands = {}
_BoY2.DistanceRange = Distance(1, "meters")
_BoY2.ShowObjects = "OnEnter"
_BoY2.ProximityRange = Distance(54, "meters")
_BoY2.AllowSetPositionTo = false
_BoY2.Active = false
_BoY2.Points = {
  ZonePoint(39.7092615711969, 2.62115401918963, 0),
  ZonePoint(39.7092507374555, 2.62103532245746, 0),
  ZonePoint(39.7091176370655, 2.62114530135054, 0),
  ZonePoint(39.7091950210445, 2.62119962019408, 0)
}
_BoY2.OriginalPoint = ZonePoint(39.7092062416906, 2.62113356579793, 0)
_BoY2.DistanceRangeUOM = "Meters"
_BoY2.ProximityRangeUOM = "Meters"
_BoY2.OutOfRangeName = ""
_BoY2.InRangeName = ""
_0aPUO = Wherigo.Zone(_ZPAkP)
_0aPUO.Id = "5f67480b-6dee-485c-99d7-190353ce5018"
_0aPUO.Name = _CQPB(";f\0066a3\v")
_0aPUO.Description = ""
_0aPUO.Visible = false
_0aPUO.Commands = {}
_0aPUO.DistanceRange = Distance(-1, "feet")
_0aPUO.ShowObjects = "OnEnter"
_0aPUO.ProximityRange = Distance(60, "meters")
_0aPUO.AllowSetPositionTo = false
_0aPUO.Active = false
_0aPUO.Points = {
  ZonePoint(39.7090895083574, 2.62173054050883, 0),
  ZonePoint(39.7089605348138, 2.62167018623825, 0),
  ZonePoint(39.708943510288, 2.62178754176435, 0),
  ZonePoint(39.7090508163196, 2.62183917819584, 0)
}
_0aPUO.OriginalPoint = ZonePoint(39.7090110924447, 2.62175686167682, 0)
_0aPUO.DistanceRangeUOM = "Feet"
_0aPUO.ProximityRangeUOM = "Meters"
_0aPUO.OutOfRangeName = ""
_0aPUO.InRangeName = ""
_wd_Xy = Wherigo.Zone(_ZPAkP)
_wd_Xy.Id = "d12c73c5-e30c-4c29-a4ad-e776f2ad15de"
_wd_Xy.Name = _CQPB(";f\0066a3Y")
_wd_Xy.Description = ""
_wd_Xy.Visible = false
_wd_Xy.Commands = {}
_wd_Xy.DistanceRange = Distance(-1, "feet")
_wd_Xy.ShowObjects = "OnEnter"
_wd_Xy.ProximityRange = Distance(60, "meters")
_wd_Xy.AllowSetPositionTo = false
_wd_Xy.Active = false
_wd_Xy.Points = {
  ZonePoint(39.7094733321969, 2.62157563121428, 0),
  ZonePoint(39.7093887260502, 2.62153405382791, 0),
  ZonePoint(39.7093665427141, 2.62163330307289, 0),
  ZonePoint(39.7094294814631, 2.62168628071036, 0)
}
_wd_Xy.OriginalPoint = ZonePoint(39.7094145206061, 2.62160731720636, 0)
_wd_Xy.DistanceRangeUOM = "Feet"
_wd_Xy.ProximityRangeUOM = "Meters"
_wd_Xy.OutOfRangeName = ""
_wd_Xy.InRangeName = ""
_7EEKt = Wherigo.Zone(_ZPAkP)
_7EEKt.Id = "a2beda4f-fbe4-4168-8473-7ee90c10e0a9"
_7EEKt.Name = _CQPB(";f\0066a3\024")
_7EEKt.Description = ""
_7EEKt.Visible = false
_7EEKt.Commands = {}
_7EEKt.DistanceRange = Distance(-1, "feet")
_7EEKt.ShowObjects = "OnEnter"
_7EEKt.ProximityRange = Distance(56, "meters")
_7EEKt.AllowSetPositionTo = false
_7EEKt.Active = false
_7EEKt.Points = {
  ZonePoint(39.7089780752298, 2.62128190709749, 0),
  ZonePoint(39.7089192632288, 2.62120612895777, 0),
  ZonePoint(39.7088527127462, 2.62137512091543, 0),
  ZonePoint(39.7089435102879, 2.62139322719659, 0)
}
_7EEKt.OriginalPoint = ZonePoint(39.7089233903732, 2.62131409604182, 0)
_7EEKt.DistanceRangeUOM = "Feet"
_7EEKt.ProximityRangeUOM = "Meters"
_7EEKt.OutOfRangeName = ""
_7EEKt.InRangeName = ""
_Dok = Wherigo.Zone(_ZPAkP)
_Dok.Id = "88525b1a-fa02-45f0-b2d2-efd1b1662b93"
_Dok.Name = _CQPB(";f\0066a3y")
_Dok.Description = ""
_Dok.Visible = false
_Dok.Commands = {}
_Dok.DistanceRange = Distance(0, "meters")
_Dok.ShowObjects = "OnEnter"
_Dok.ProximityRange = Distance(60, "meters")
_Dok.AllowSetPositionTo = false
_Dok.Active = false
_Dok.Points = {
  ZonePoint(39.7090791904828, 2.6217332229208, 0),
  ZonePoint(39.7089651778655, 2.6216768922683, 0),
  ZonePoint(39.7089548599723, 2.62178351814631, 0),
  ZonePoint(39.7090472050616, 2.62182375432674, 0)
}
_Dok.OriginalPoint = ZonePoint(39.7090116083455, 2.62175434691554, 0)
_Dok.DistanceRangeUOM = "Meters"
_Dok.ProximityRangeUOM = "Meters"
_Dok.OutOfRangeName = ""
_Dok.InRangeName = ""
_NB9D2 = Wherigo.Zone(_ZPAkP)
_NB9D2.Id = "d772abc9-f0c9-4b0d-a4b5-c89927340ed4"
_NB9D2.Name = _CQPB(";f\0066a353@Uo\002\018Ua")
_NB9D2.Description = ""
_NB9D2.Visible = false
_NB9D2.Commands = {}
_NB9D2.DistanceRange = Distance(-1, "feet")
_NB9D2.ShowObjects = "OnEnter"
_NB9D2.ProximityRange = Distance(60, "meters")
_NB9D2.AllowSetPositionTo = false
_NB9D2.Active = false
_NB9D2.Points = {
  ZonePoint(39.7093064527088, 2.62143707097052, 0),
  ZonePoint(39.7092225981536, 2.62141325583494, 0),
  ZonePoint(39.7091833615395, 2.62151797958369, 0),
  ZonePoint(39.7092571763859, 2.62156294736727, 0)
}
_NB9D2.OriginalPoint = ZonePoint(39.709242397197, 2.6214828134391, 0)
_NB9D2.DistanceRangeUOM = "Feet"
_NB9D2.ProximityRangeUOM = "Meters"
_NB9D2.OutOfRangeName = ""
_NB9D2.InRangeName = ""
_Oui36 = Wherigo.Zone(_ZPAkP)
_Oui36.Id = "ae64ffd5-b9a5-4ecc-b930-19c9fb5e4139"
_Oui36.Name = _CQPB(";f\0066a3\v3@Uo\002\018Ua")
_Oui36.Description = ""
_Oui36.Visible = false
_Oui36.Commands = {}
_Oui36.DistanceRange = Distance(-1, "feet")
_Oui36.ShowObjects = "OnEnter"
_Oui36.ProximityRange = Distance(60, "meters")
_Oui36.AllowSetPositionTo = false
_Oui36.Active = false
_Oui36.Points = {
  ZonePoint(39.7093019135033, 2.62115977357036, 0),
  ZonePoint(39.7092606299195, 2.6213399576395, 0),
  ZonePoint(39.7090884286835, 2.62128611157274, 0),
  ZonePoint(39.7091793474956, 2.62112075441173, 0)
}
_Oui36.OriginalPoint = ZonePoint(39.7092075799005, 2.62122664929858, 0)
_Oui36.DistanceRangeUOM = "Feet"
_Oui36.ProximityRangeUOM = "Meters"
_Oui36.OutOfRangeName = ""
_Oui36.InRangeName = ""
_IpVk = Wherigo.Zone(_ZPAkP)
_IpVk.Id = "e6a3695b-5e4f-4f88-9c72-21972cc61043"
_IpVk.Name = _CQPB(";f\0066a3Y3@Uo\002\018Ua")
_IpVk.Description = ""
_IpVk.Visible = false
_IpVk.Commands = {}
_IpVk.DistanceRange = Distance(-1, "feet")
_IpVk.ShowObjects = "OnEnter"
_IpVk.ProximityRange = Distance(60, "meters")
_IpVk.AllowSetPositionTo = false
_IpVk.Active = false
_IpVk.Points = {
  ZonePoint(39.7092367050624, 2.62118813371891, 0),
  ZonePoint(39.7091329762363, 2.62114064917033, 0),
  ZonePoint(39.7090836900896, 2.62130024307319, 0),
  ZonePoint(39.7092138962743, 2.62131457892629, 0)
}
_IpVk.OriginalPoint = ZonePoint(39.7091668169156, 2.62123590122218, 0)
_IpVk.DistanceRangeUOM = "Feet"
_IpVk.ProximityRangeUOM = "Meters"
_IpVk.OutOfRangeName = ""
_IpVk.InRangeName = ""
_dLP = Wherigo.Zone(_ZPAkP)
_dLP.Id = "c0a79270-5914-426f-8374-7c13c2ba5a87"
_dLP.Name = _CQPB(";f\0066a3\0243@Uo\002\018Ua")
_dLP.Description = ""
_dLP.Visible = false
_dLP.Commands = {}
_dLP.DistanceRange = Distance(-1, "feet")
_dLP.ShowObjects = "OnEnter"
_dLP.ProximityRange = Distance(60, "meters")
_dLP.AllowSetPositionTo = false
_dLP.Active = false
_dLP.Points = {
  ZonePoint(39.7092186195326, 2.62131490547388, 0),
  ZonePoint(39.709129892642, 2.62131222326487, 0),
  ZonePoint(39.7090824340258, 2.62145706255167, 0),
  ZonePoint(39.7091794146415, 2.62147449691027, 0)
}
_dLP.OriginalPoint = ZonePoint(39.7091525902105, 2.62138967205017, 0)
_dLP.DistanceRangeUOM = "Feet"
_dLP.ProximityRangeUOM = "Meters"
_dLP.OutOfRangeName = ""
_dLP.InRangeName = ""
_fr5qr = Wherigo.Zone(_ZPAkP)
_fr5qr.Id = "202c2213-2d96-4585-8a42-bf514022d62d"
_fr5qr.Name = _CQPB(";f\0066a3y3@Uo\002\018Ua")
_fr5qr.Description = ""
_fr5qr.Visible = false
_fr5qr.Commands = {}
_fr5qr.DistanceRange = Distance(-1, "feet")
_fr5qr.ShowObjects = "OnEnter"
_fr5qr.ProximityRange = Distance(60, "meters")
_fr5qr.AllowSetPositionTo = false
_fr5qr.Active = false
_fr5qr.Points = {
  ZonePoint(39.7091347290393, 2.62134234081472, 0),
  ZonePoint(39.7090553258199, 2.62132693556936, 0),
  ZonePoint(39.7090138464898, 2.62145788015534, 0),
  ZonePoint(39.7090873241432, 2.62146250172898, 0)
}
_fr5qr.OriginalPoint = ZonePoint(39.709072806373, 2.6213974145671, 0)
_fr5qr.DistanceRangeUOM = "Feet"
_fr5qr.ProximityRangeUOM = "Meters"
_fr5qr.OutOfRangeName = ""
_fr5qr.InRangeName = ""
_3h6u = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _Q2mV5})
_3h6u.Id = "5e6be5dc-15f0-472d-b492-63e30b55e747"
_3h6u.Name = _CQPB("t6\0066a3{")
_3h6u.Description = ""
_3h6u.Visible = true
_3h6u.Media = _tEkOI
_3h6u.Commands = {}
_3h6u.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3h6u.Locked = false
_3h6u.Opened = false
_Xhyn = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _BoY2})
_Xhyn.Id = "1dc8b57d-3a8e-4885-9da7-4d5c0905f948"
_Xhyn.Name = _CQPB("t6\0066a35")
_Xhyn.Description = ""
_Xhyn.Visible = true
_Xhyn.Media = _oTE
_Xhyn.Commands = {}
_Xhyn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Xhyn.Locked = false
_Xhyn.Opened = false
_kiFzQ = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _wd_Xy})
_kiFzQ.Id = "e6c49aaa-37dc-4e35-9503-5a2e988fb046"
_kiFzQ.Name = _CQPB("t6\0066a3Y")
_kiFzQ.Description = ""
_kiFzQ.Visible = true
_kiFzQ.Media = _Hz2_
_kiFzQ.Commands = {}
_kiFzQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_kiFzQ.Locked = false
_kiFzQ.Opened = false
_Gcr8 = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _0aPUO})
_Gcr8.Id = "c800289f-cbdb-45b1-a401-f7d107d9d3e2"
_Gcr8.Name = _CQPB("t6\0066a3\v")
_Gcr8.Description = ""
_Gcr8.Visible = true
_Gcr8.Media = _2xzx
_Gcr8.Commands = {}
_Gcr8.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Gcr8.Locked = false
_Gcr8.Opened = false
_Zj_ = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _7EEKt})
_Zj_.Id = "7220c4d8-73ed-4b1f-97fe-2bc9e61a1b7d"
_Zj_.Name = _CQPB("t6\0066a3\024")
_Zj_.Description = ""
_Zj_.Visible = true
_Zj_.Media = _AsVkB
_Zj_.Commands = {}
_Zj_.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Zj_.Locked = false
_Zj_.Opened = false
_NF7H = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _Dok})
_NF7H.Id = "326be5d5-746b-4700-aed6-7657064e17a7"
_NF7H.Name = _CQPB("t6\0066a3y")
_NF7H.Description = ""
_NF7H.Visible = true
_NF7H.Media = _Nd2
_NF7H.Commands = {}
_NF7H.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NF7H.Locked = false
_NF7H.Opened = false
_enK = Wherigo.ZItem({Cartridge = _ZPAkP, Container = __mrGl})
_enK.Id = "23ea452c-3b9b-4cc6-84bb-713a11321410"
_enK.Name = _CQPB("e@6\018\002fxU3b63\bP+\018f@6")
_enK.Description = ""
_enK.Visible = true
_enK.Media = _l_eF
_enK.Commands = {}
_enK.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_enK.Locked = false
_enK.Opened = true
_WmnH = Wherigo.ZItem({Cartridge = _ZPAkP, Container = _VLHpz})
_WmnH.Id = "9848f2f1-d652-41ed-a943-f050e561920b"
_WmnH.Name = _CQPB("tP3@P\018\002P3b6a3XfPoU")
_WmnH.Description = ""
_WmnH.Visible = true
_WmnH.Media = _bVJUW
_WmnH.Commands = {}
_WmnH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_WmnH.Locked = true
_WmnH.Opened = false
_4A2 = _CQPB("qQ\002IHf")
_yk7g = _CQPB("b+]]?")
_qAV = _CQPB("qY_7+")
_0uld0 = _CQPB("b+]]?")
_6arm2 = _CQPB("b+]]?")
_R8J = _CQPB("b+]]?")
_ZPAkP.ZVariables = {
  _4A2 = _CQPB("qQ\002IHf"),
  _yk7g = _CQPB("b+]]?"),
  _qAV = _CQPB("qY_7+"),
  _0uld0 = _CQPB("b+]]?"),
  _6arm2 = _CQPB("b+]]?"),
  _R8J = _CQPB("b+]]?")
}
function _ZPAkP:OnStart()
  if _G[_CQPB(">o\006")][_CQPB("\016aP\002iU\018]")] == _CQPB("NfoY\v") or _G[_CQPB(">o\006")][_CQPB("w6\006f@6Qw")] == _CQPB("w6!B\002UX") then
    for k, v in pairs(_G[_CQPB("q'\016eB\016")][_CQPB("eaa'\025}x6@\002!")]) do
      v[_CQPB("\014f!f}a6")] = false
      v[_CQPB("e@\002f\0066")] = false
    end
    _Urwigo.MessageBox({
      Text = tostring(_CQPB(";U3!6P!3\002\018P]XU!U0")),
      Callback = function(action)
        if action ~= nil then
          _G[_CQPB("N_6\018fHU")][_CQPB("VU]]Pob")](_CQPB("%P\0066VaU!6"))
        end
      end
    })
    return
  end
end
function _ZPAkP:OnRestore()
end
function _ItKgi:OnEnter()
  _4A2 = _CQPB("qQ\002IHf")
  Wherigo.PlayAudio(_IQAf)
  _Urwigo.Dialog(false, {
    {
      Text = _CQPB("\025o3w6@6]}6\01835y)3?U+3P\018\018f\00663P\0023\014Paab6]U!!P3^f\002_3\bPbP]63w+b6\006Po\0023Pob3_6\0183\002^U3@_fab\0186od3A_636ab6!\002)3\bP+\018f@6)3_P!3af\0066b35y3!X\018foH!)3^_fa63%UaPoH63Uoa?35{d"),
      Media = _yXJ
    }
  }, function(action)
    _Urwigo.Dialog(false, {
      {
        Text = _CQPB("\029U+3b6@fb63\002U3!\002P?3fo3P3@6aa3Ui3\002_63\bUoP!\0026\018?d3\bUoP!\0026\018?3\002_P\0023aUoH3PHU3^P!3P}PobUo6b3}?3\002_63S\018fP\018!d"),
        Media = _BuTP
      }
    }, function(action)
      _Urwigo.Dialog(false, {
        {
          Text = _CQPB("T+\0023P!3?U+3^6aa3BoU^3S\0186b6\018f@_)3\002_P\0023^P!3P3X\0186\002\002?3@Uab3^fo\0026\0183fo3\bPaaU\018@P)36!X6@fPaa?3iU\0183?U+3Pob3?U+\0183o6^a?3bfPHoU!6b3bf!6P!6d"),
          Media = _MLsvY
        }
      }, function(action)
        _Urwigo.Dialog(false, {
          {
            Text = _CQPB(";6\0066\018\002_6a6!!)3?U+3bU3oU\0023!\002UX3\002_foBfoH3P}U+\0023@U]XU!foH3o6^3Xf6@6!3\002U3XaP?3Uo3\002_63XfPoUd"),
            Media = _7X44
          }
        }, function(action)
          _ItKgi.Active = false
          _ItKgi.Visible = false
          _ieSHa.Active = true
          _ieSHa.Visible = true
        end)
      end)
    end)
  end)
end
function _ItKgi:OnExit()
  _4A2 = _CQPB("qQ\002IHf")
  _Urwigo.GlobalZoneExit()
end
function _ieSHa:OnEnter()
  _4A2 = _CQPB("qf6%EP")
  _Urwigo.MessageBox({
    Text = _CQPB("S\0186b6\018f@_)3S\0186b6\018f@_)3^_P\0023P3@\018Pg?3fb6P!3?U+3_P\006603w6!Xf\00263_P\006foH3!+@_3P3i\018Pfa3_6Pa\002_3Pob3?U+3^Po\0026b3\002U3HU3U+\002!fb63\002U3XaP?3\002_63XfPoUu3f\0023^P!3\018PfofoH3@P\002!3Pob3bUH!03A_P\0023f!3x+!\0023\002_63\002_foH3?U+\0183bf!6P!63o66b6bd"),
    Media = _g4A,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("EU^3aUoH3_P\00663Q3}66o3fobUU\018!J3Q3o66b3\002U3HU3U+\002)3^PaB)3H6\0023fo!Xf\0186b3fo3\002_f!3fo@U]XP\018P}a63!6\002\002foHd3Q\0023f!3oU\00236oU+H_3^f\002_3x+!\0023\002_6!63}6o@_6!3U\0183\002_f!3iU+o\002Pfod"),
          Media = _0tG,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("Q3^Po\0023\002U3HU3\002U3\002_63HP\018b6o!)3Q3^Po\0023fo!Xf\018P\002fUo3\002U3@U]63}P@B)3Pob3P}U\00663Paa)3Q3^Po\0023\002U3XaP?3\002_63XfPoU3PHPfod"),
                Media = _0tG,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("Q3bU3oU\0023\002_foB3?U+\021\01863if\0023iU\0183!+@_3P3\002_foHd3T6!fb6!)3?U+\0183XfPoU3f!3oU3aUoH6\0183_6\0186d3\bP+\018f@6)3%UaPoH63Pob3Q3_P\00663_fbb6o3f\0023P^P?d3ro\002fa3?U+3H6\0023}6\002\0026\018)3?U+3^Uo?\0023XaP?3f\0023PHPfod"),
                      Media = _g4A,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("e!3?U+3!P?)3\bPbP]63w+\0066bPo\002d3T?3\002_63^P?)3bU3?U+3_P\00663Po?3XaPo!3iU\0183\002_f!3Pi\0026\018oUUoJ3Q\0023_P!3!\002UXX6b3\018PfofoH3P\0023aP!\0023Pob3\002_63!+o3!_fo6!3PHPfod"),
                            Media = _0tG,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB("Q3\002_foB3Q?aa3HU3\002U3_P\00663P3^PaB3\002_\018U+H_3\002_63\002U^od3"),
                                  Media = _g4A,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _Urwigo.MessageBox({
                                        Text = _CQPB("e\01863?U+3!+\0186J3\029U+3BoU^3\002_P\0023\002_6!63X6UXa63bUo?\0023afB63^U]6o3^PaBfoH3PaUo6)3^6P\018foH3\002\018U+!6\018!)3Pob3^U\018!\0023Ui3Paa)3!]UBfoHd3"),
                                        Media = _r8v4,
                                        Callback = function(action)
                                          if action ~= nil then
                                            _Urwigo.MessageBox({
                                              Text = _CQPB("S\0186b6\018f@_)3^U+abo?\0023}63}6\002\0026\0183fi3\002_6?3\002UUB3@P\01863Ui3\002_6f\0183U^o3}+!fo6!!6!3fo!\0026Pb3Ui3x+bHfoH3U\002_6\0183X6UXa63U\0066\0183\002_6f\0183@aU\002_6!)3_P}f\002!3U\0183^_P\0026\0066\0183\002_6?3afB63\002U3bUJ"),
                                              Media = _g4A,
                                              Callback = function(action)
                                                if action ~= nil then
                                                  _Urwigo.MessageBox({
                                                    Text = _CQPB("Q3bUo?\0023\002_foB3Q3@U+ab3_P\006636\001X\0186!!6b3f\0023}6\002\0026\018d3;U^3HU)3Pob3_P\00663P3of@63^PaBd"),
                                                    Media = _0tG,
                                                    Callback = function(action)
                                                      if action ~= nil then
                                                        _ieSHa.Active = false
                                                        _ieSHa.Visible = false
                                                        __mrGl.Active = true
                                                        __mrGl.Visible = true
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
end
function _ieSHa:OnExit()
  _4A2 = _CQPB("qf6%EP")
  _Urwigo.GlobalZoneExit()
end
function __mrGl:OnEnter()
  _4A2 = _CQPB("qq]\018\023a")
  _Urwigo.MessageBox({
    Text = _CQPB("E6666aaU3\bP+\018f@6d\"Tn1EU^?!3?U+\0183\018_6+]P\002f!]3bUfoHJ"),
    Media = _0tG,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("e3af\002\002a63}f\0023}6\002\0026\018)3\b\0183V_UXfod"),
          Media = _fq1o,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("T?3\002_63^P?)3f3^P!3\002_foBfoH3\002_P\0023?U+?b3afB63\002U3_P\00663Uo63Ui3\002_U!63b6af@fU+!3@U@P!3b63XP\002P\002P3\002_6?3]PB63fo3\002_f!3\002U^od"),
                Media = _0tG,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("\b]]]]3?U+3BoU^3HUUb3^_P\0023Q3afB6d"),
                      Media = _fq1o,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("N6aa)3fi3?U+3@Po3\0186]6]}6\0183^_6\01863]?3XfPoU3f!)3?U+3@U+ab36P\0023Uo636\0066\018?3bP?3Ui3\002_63^66Bd"),
                            Media = _0tG,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB("N6aa3fi3f\0023f!3\002\018+63^_P\0023?U+3!P?)3?U+3x+!\0023_P\00663\002U3!Ua\00663\002_f!3!f]Xa63\018fbba6d\"Tn1Q\0023f!3^\018f\002\0026o3_6\0186)3B66X3f\0023fo3?U+\0183fo\0066o\002U\018?d"),
                                  Media = _fq1o,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _enK:MoveTo(Player)
                                      __mrGl.Active = false
                                      __mrGl.Visible = false
                                      _XFgZQ.Active = true
                                      _XFgZQ.Visible = false
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
function __mrGl:OnExit()
  _4A2 = _CQPB("qq]\018\023a")
  _Urwigo.GlobalZoneExit()
end
function _XFgZQ:OnEnter()
  _4A2 = _CQPB("qMSH',")
  _Urwigo.MessageBox({
    Text = _CQPB("\029U+3@P]63P\0023aP!\00203Q\0023^P!o?\0023\002_P\0023]+@_3bfiif@+a\002)3^P!3f\002J"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("T+\0023^_P\0023\002_63_6aa3P\01863?U+3bUfoH3S\0186b6\018f@_J\"Tn1N_P\0023P\01863?U+3aUUBfoH3P\002J\"Tn1wU3]?3oU!63aUUB3afB63P3XfPoU3iU\0183?U+J"),
          Media = _qIpc,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("VU]63Uo)3^_?3bU3oU\0023?U+3HU3\002U3}PoB!3fo3\002_63@6o\0026\0183Ui3\002_63HP\018b6o!J3%UaPoH63f!3\002_6\0186)3X6\018_PX!3!_63@Po3_6aX3?U+3ifob3\002_63XfPoUd"),
                Media = _qIpc,
                Callback = function(action)
                  if action ~= nil then
                    _XFgZQ.Active = false
                    _XFgZQ.Visible = false
                    _VfWw.Active = true
                    _VfWw.Visible = true
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
function _XFgZQ:OnExit()
  _4A2 = _CQPB("qMSH',")
  _Urwigo.GlobalZoneExit()
end
function _VfWw:OnEnter()
  _4A2 = _CQPB("q\014iN^")
  _Urwigo.MessageBox({
    Text = _CQPB("\023UUb3Pi\0026\018oUUo3%UaPoH6d3wU3Q3fo\0026\018\018+X\0023?U+J"),
    Media = _0tG,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("\023UUb3Pi\0026\018oUUo3S\0186b6\018f@_)3Xa6P!63!f\0023bU^od3N_P\0023}\018foH!3?U+3_6\0186J"),
          Media = _MnEpq,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("Q?]3aUUBfoH3iU\0183]?3XfPoUu3^U+abo?\0023?U+3_PXX6o3\002U3BoU^3^_6\01863f\0023f!)3}?3Po?3@_Po@6J"),
                Media = _0tG,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("Q3]P?3BoU^3f\002)3}+\0023Q?b3afB63\002U3XaP?3P3tf\002\002a63HP]63}6iU\0186d3\bP?}6)3fi3?U+3XaP?3^f\002_3]6)3?U+3^faa3}63P}a63\002U3ifob3?U+\0183XfPoU3fo3\002_636obd3"),
                      Media = _MnEpq,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("eob3^_?3!_U+ab3Q3XaP?3^f\002_3?U+J"),
                            Media = _r8v4,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB("T6@P+!63Q3bUo?\0023\002_foB3]U]]?3^faa3}63_PXX?3\002U3_6P\0183\002_P\0023?U+3P\01863^PaBfoH3fo3\002_63HP\018b6o!3Pob3\002_P\0023?U+3P\01863aUUBfoH3iU\0183?U+\0183XfPoUd3"),
                                  Media = _MnEpq,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _Urwigo.MessageBox({
                                        Text = _CQPB("Q3!66d3eob3^_P\0023bfb3?U+3!P?3\002_63HP]63^P!J"),
                                        Media = _0tG,
                                        Callback = function(action)
                                          if action ~= nil then
                                            _Urwigo.MessageBox({
                                              Text = _CQPB("Q\0023f!3P3@U]Xaf@P\0026b3HP]6)3P\01863?U3+!+\01863?U+3^Po\0023\002U3XaP?J"),
                                              Media = _MnEpq,
                                              Buttons = {
                                                _CQPB("\0296!"),
                                                _CQPB("U\0183?6!")
                                              },
                                              Callback = function(action)
                                                if action ~= nil then
                                                  _Urwigo.MessageBox({
                                                    Text = _CQPB("VU]63Uo)3iUaaU^3]6d3"),
                                                    Media = _MnEpq,
                                                    Callback = function(action)
                                                      if action ~= nil then
                                                        _VfWw.Active = false
                                                        _VfWw.Active = false
                                                        _Q2mV5.Active = true
                                                        _Q2mV5.Visible = true
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
end
function _VfWw:OnExit()
  _4A2 = _CQPB("q\014iN^")
  _Urwigo.GlobalZoneExit()
end
function _VLHpz:OnEnter()
  _4A2 = _CQPB("q\014tEXg")
  _Urwigo.MessageBox({
    Text = _CQPB("VUoH\018P\002+aP\002fUo!)3\b\0183V_UXfo03\029U+3_P\00663iU+ob3\002_63XfPoU0"),
    Media = _sJkb,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("N_6\01863f!3f\002J3Q3@Po?\0023!663f\0020"),
          Media = _r8v4,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("N_6\01863^U+ab3f\0023}6J3Qo3\002_63HP\018b6o6\018?!3_U+!60"),
                Media = _MnEpq,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("T+HH6\0183]603N_?3bfbo?\0023Q3\002_foB3f\0023}6iU\0186J"),
                      Media = _r8v4,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("N6aa)3Q3P]3HUfoH3\002U3_P\00663Uo63Ui3\002_U!63?+]]?3@U@P!3b63XP\002P\002P3Pob3P3@+X3Ui3_U\0023@_U@UaP\0026d3A_PoB!3iU\0183XaP?foH3]?3HP]6d"),
                            Media = _I62r,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB("A_PoB!3\002U3?U+)3%UaPoH6)3iU\0183a6\002\002foH3]63XaP?3^f\002_3?U+)3Pob3P}U\00663Paa)3iU\0183\002PBfoH3]63\002U3\002_63XfPoUd"),
                                  Media = _0tG,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _Urwigo.MessageBox({
                                        Text = _CQPB("Q?]3HUfoH3\002U3\002PB63f\0023U+\0023i\018U]3\002_63_U+!6u3Q?]3b?foH3\002U3XaP?3f\0023PHPfod"),
                                        Media = _r8v4,
                                        Callback = function(action)
                                          if action ~= nil then
                                            _Urwigo.MessageBox({
                                              Text = _CQPB("N_P\0023\002_63_6@B3f!3\002_f!36o\0066aUX63a?foH3Uo3\002_63XfPoUJ"),
                                              Media = _OP8W4,
                                              Callback = function(action)
                                                if action ~= nil then
                                                  _Urwigo.MessageBox({
                                                    Text = _CQPB("Q?]3UX6ofoH3f\002)3f\0023!66]!3f\0023_P!3!U]6\002_foH3^\018f\002\0026o3Uo3f\002d"),
                                                    Media = _d9IY,
                                                    Callback = function(action)
                                                      if action ~= nil then
                                                        _WmnH:MoveTo(Player)
                                                        _VLHpz.Active = false
                                                        _VLHpz.Visible = false
                                                        _9c9T7.Active = true
                                                        _9c9T7.Visible = true
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
end
function _VLHpz:OnExit()
  _4A2 = _CQPB("q\014tEXg")
  _Urwigo.GlobalZoneExit()
  Wherigo.PlayAudio(_Lsc)
end
function _9c9T7:OnEnter()
  _4A2 = _CQPB("q @ A&")
  Wherigo.PlayAudio(_ZWG)
  _Urwigo.MessageBox({
    Text = _CQPB("Efo\0023f!3?]PHo6\002?"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("A_f!3f!3\002_63!XUfa6\0183X_U\002U"),
          Media = _6S9D,
          Callback = function(action)
            if action ~= nil then
              _ZPAkP.Complete = true
              _Urwigo.MessageBox({
                Text = _CQPB(">a3@UbfHU36!\0193") .. string.sub(Player.CompletionCode, 1, 15),
                Callback = function(action)
                  if action ~= nil then
                    _ZPAkP:RequestSync()
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
function _9c9T7:OnExit()
  _4A2 = _CQPB("q @ A&")
  _Urwigo.GlobalZoneExit()
end
function _Q2mV5:OnEnter()
  _4A2 = _CQPB("q,\v]\014y")
  _Urwigo.MessageBox({
    Text = _CQPB("A_63U\002_6\0183bP?3^_fa63Q3^P!3!a66XfoH)3Q3_Pb3P3\006f!fUod3A_6!63HP\018b6o!3^6\01863P3aP}?\018fo\002_d3"),
    Media = _MnEpq,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("Q\0023!66]!36P!?3\002U3ifob3\002_636\001f\002d"),
          Media = _0tG,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB(";U3!U3iP!\002d3Q\0023f!3P3y\031a6\0066a3aP}?\018fo\002_d"),
                Media = _MnEpq,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("rX!)3]?36P\018!3P\01863Paa3?U+\018!d"),
                      Media = _r8v4,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("nfH_\0023oU\0023^63P\01863P\0023a6\0066a3{d3AU3ifob3\002_63XfPoU3?U+3^faa3_P\00663\002U3\0186P@_3\002U3a6\0066a3yd"),
                            Media = _aGTVp,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB("AU3HU3i\018U]3Uo63a6\0066a3\002U3\002_63o6\001\002)3?U+3^faa3_P\00663\002U3\0186P@_3\002U3Uo63Ui3\002_63iU+\0183afoB!3Ui3P!@6o\002u3^63^faa3@Paa3\002_6]3\023P\00263;)3\023P\00263%)3\023P\00263>3Pob3\023P\00263\02538^63@Paa3\002_6]3\002_f!3^P?3iU\0183\002_6f\0183U\018f6o\002P\002fUoRd3\"Tn1Qo3U\018b6\0183\002U3\0186P@_3\002_63HP\0026!)3?U+3]+!\0023iUaaU^3\002_63^P?3Q3^faa3\0026aa3?U+d"),
                                  Media = _aGTVp,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _Urwigo.MessageBox({
                                        Text = _CQPB("A_f!3f!3\002_63]PX3Ui3a6\0066a3{d\"Tn1N63P\01863P\0023HP\00263%d3Qi3?U+3aUUB3@aU!6a?3?U+?aa3!663P3@f\018@+aP\0183H\018P?3XP\002_u3^63^faa3o6\0066\0183HU3\002_P\0023^P?)3!U3\002_63HP]63}6@U]6!36P!f6\018d"),
                                        Media = _cJ_35,
                                        Callback = function(action)
                                          if action ~= nil then
                                            _Urwigo.MessageBox({
                                              Text = _CQPB("t6\002?!3}6Hfo3\002_6o)3^_P\0023P\01863\002_63if\018!\0023U\018b6\018!J"),
                                              Media = _0tG,
                                              Callback = function(action)
                                                if action ~= nil then
                                                  _Urwigo.MessageBox({
                                                    Text = _CQPB("\023\0186P\002)3Q3!663\002_P\0023?U+3P\01863aUUBfoH3iU\018^P\018b3\002U3ifobfoH3\002_63aUH}UUBd\"Tn1Q3]6Po)3\002_63XfPoU)3\002_63XfPoU0\"Tn1>o\0026\0183\002_63HP\018b6o!3i\018U]3HP\00263%d"),
                                                    Media = _MnEpq,
                                                    Callback = function(action)
                                                      if action ~= nil then
                                                        _Urwigo.MessageBox({
                                                          Text = _CQPB("\025_)3Q3Pa]U!\0023iU\018HU\00203Q3^faa3^PaB3o6\001\0023\002U3?U+3Pob3Q3^faa3\0026aa3?U+3fi3?U+3P\01863iUaaU^foH3\002_63\018fH_\0023XP\002_d3Qi3?U+3\002\018?3\002U3@_6P\002)3\002_63HP]63^faa3!\002UXd3EP\00663P3aUUB3P\0023?U+\0183fo\0066o\002U\018?3Pob3iUaaU^3\002_63U\018b6\018!d"),
                                                          Media = _cJ_35,
                                                          Callback = function(action)
                                                            if action ~= nil then
                                                              _3h6u:MoveTo(Player)
                                                              _Q2mV5.Active = false
                                                              _Q2mV5.Visible = false
                                                              _BoY2.Active = true
                                                              _BoY2.Visible = false
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
      end
    end
  })
end
function _Q2mV5:OnExit()
  _4A2 = _CQPB("q,\v]\014y")
  _Urwigo.GlobalZoneExit()
end
function _BoY2:OnEnter()
  _4A2 = _CQPB("qTU\029\v")
  _Urwigo.MessageBox({
    Text = _CQPB("NUob6\018i+a03\029U+3P\01863Pa\0186Pb?3P\0023a6\0066a35d"),
    Media = _MnEpq,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("Q3\002_foB3?U+3P\01863HUfoH3\002U3bU3ifo63fo3\002_f!3HP]6)3S\0186b6\018f@_d3tUUB3_U^36P!?3f\0023^P!0"),
          Media = _vTb,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("%U]6_U^3Q3BoU^3f\002?!3oU\0023HUfoH3\002U3}63\002_f!36P!?3i\018U]3oU^3Uod"),
                Media = _0tG,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("Nf\002_3\002_P\0023P\002\002f\002+b63?U+3^faa3o6\0066\0183}63P3HUUb3H6U@P@_6\018d3"),
                      Media = _MnEpq,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("e3^_P\002J"),
                            Media = _r8v4,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB(";6\0066\0183]fob)3o6\0066\0183]fobu3a6\002?!3B66X3Uo3^f\002_3a6\0066a35d3SUaaU^3\002_63U\018b6\018!3fo3?U+\0183fo\0066o\002U\018?d3"),
                                  Media = _MnEpq,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _Xhyn:MoveTo(Player)
                                      _BoY2.Active = false
                                      _BoY2.Visible = false
                                      _NB9D2.Active = true
                                      _NB9D2.Visible = false
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
function _BoY2:OnExit()
  _4A2 = _CQPB("qTU\029\v")
  _Urwigo.GlobalZoneExit()
end
function _0aPUO:OnEnter()
  _4A2 = _CQPB("q{P\016r\025")
  _Urwigo.MessageBox({
    Text = _CQPB("e^6!U]603\029U+3_P\00663\0186P@_6b3a6\0066a3\vd"),
    Media = _MnEpq,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("A_f!3^P!3P3af\002\002a63]U\01863\002\018f@B?)3}+\0023f\0023^6o\0023Pa\018fH_\002d"),
          Media = _D3ujN,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("Q?]3Pi\018Pfb3Ui3\002_63iUaaU^foH3a6\0066a!d"),
                Media = _0tG,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("VU]63Uo)3?U+3X+!!?)3HU3}P@B3\002U3\002_63HP\018b6o!3\002_\018U+H_3HP\00263>d3\"Tn1tUUB3P\0023?U+\0183fo\0066o\002U\018?d"),
                      Media = _aPbSt,
                      Callback = function(action)
                        if action ~= nil then
                          _Gcr8:MoveTo(Player)
                          _0aPUO.Active = false
                          _0aPUO.Visible = false
                          _Oui36.Active = true
                          _Oui36.Visible = false
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
function _0aPUO:OnExit()
  _4A2 = _CQPB("q{P\016r\025")
  _Urwigo.GlobalZoneExit()
end
function _wd_Xy:OnEnter()
  _4A2 = _CQPB("q^bqM?")
  _Urwigo.MessageBox({
    Text = _CQPB("\bP\018\0066aaU+!d3\029U+3Pa\0186Pb?3P\01863Uo3a6\0066a3Yd\"Tn1EPai3\002_63^P?0\"Tn1"),
    Media = _nIgBb,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("eoU\002_6\0183UX\002fUo3^U+ab3}63aUUB3iU\0183\002_63XfPoU3\016P\018PbU\001!?!3!\002?a6d3"),
          Media = _r8v4,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("\031q\031+3?6P_)3P}!Ua+\0026a?)3fo3P3!+@_3P3}fH3\002U^o"),
                Media = _w0KGG,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("\025B)3UB)3f?aa3B66X3af!\0026ofoH3\002U3?U+\0183U\018b6\018!d"),
                      Media = _0tG,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("\023U3}P@B3\002U3\002_63HP\018b6o!3\002_\018U+H_3HP\00263;d\"Tn1tUUB3fo3?U+\0183fo\0066o\002U\018?d"),
                            Media = _Qy2,
                            Callback = function(action)
                              if action ~= nil then
                                _kiFzQ:MoveTo(Player)
                                _wd_Xy.Active = false
                                _wd_Xy.Visible = false
                                _IpVk.Active = true
                                _IpVk.Visible = false
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
function _wd_Xy:OnExit()
  _4A2 = _CQPB("q^bqM?")
  _Urwigo.GlobalZoneExit()
end
function _7EEKt:OnEnter()
  _4A2 = _CQPB("q&>>I\002")
  _Urwigo.MessageBox({
    Text = _CQPB("T\018P\006U)3}\018P\006U)3}\018P\006U03t6\0066a3Y3@U]Xa6\0026b)3?U+3P\01863Uo3a6\0066a3\024d"),
    Media = __CNeV,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("Q?]36oxU?foH3\002_f!3HP]63\0066\018?3]+@_d3VUoH\018P\002+aP\002fUo!3iU\0183?U+\0183@\0186P\002fUo0"),
          Media = _0tG,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("wUo?\0023}63Po3P\018!6\031af@B6\018d3VU]63Uo)3a6\002?!3HU3iU\0183\002_63o6\001\0023a6\0066ad\"Tn1"),
                Media = _MnEpq,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("\023U3}P@B3\002U3\002_63HP\018b6o!3\002_\018U+H_3HP\00263%d3tUUB3fo3?U+\0183fo\0066o\002U\018?d"),
                      Media = _yeS,
                      Callback = function(action)
                        if action ~= nil then
                          _Zj_:MoveTo(Player)
                          _7EEKt.Active = false
                          _7EEKt.Visible = false
                          _dLP.Active = true
                          _dLP.Visible = false
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
function _7EEKt:OnExit()
  _4A2 = _CQPB("q&>>I\002")
  _Urwigo.GlobalZoneExit()
end
function _Dok:OnEnter()
  _4A2 = _CQPB("qwUB")
  _Urwigo.MessageBox({
    Text = _CQPB("\0146\018?3HUUb03\029U+3P\01863Uo3\002_63aP!\0023a6\0066a)3o+]}6\0183yd\"Tn1\029U+3@Po3Pa]U!\0023i66a3f\0023Uo3?U+\0183ifoH6\018\002fX!d"),
    Media = _aCtV5,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _CQPB("tUUB3P\0023]63%UaPoH6)3]?3ifoH6\018!3Pa\0186Pb?3BoU^3\002_P\0023\002_63XfPoU3f!3\0066\018?3@aU!6d3tUUB3_U^3\002_6?3]U\0066d"),
          Media = _0tG,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _CQPB("EP_P)3^6aa3bUo63H6U@P@_6\018d"),
                Media = _MnEpq,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = _CQPB("N_P\002J"),
                      Media = _r8v4,
                      Callback = function(action)
                        if action ~= nil then
                          _Urwigo.MessageBox({
                            Text = _CQPB("S\0186b6\018f@_)3S\0186b6\018f@_d\"Tn1VU]63Uo)3Uo63aP!\00236iiU\018\002d"),
                            Media = _MnEpq,
                            Callback = function(action)
                              if action ~= nil then
                                _Urwigo.MessageBox({
                                  Text = _CQPB("\023U3}P@B3\002U3\002_63HP\018b6o!3\002_\018U+H_3HP\00263>d3tUUB3fo3?U+\0183fo\0066o\002U\018?d"),
                                  Media = _ML7x,
                                  Callback = function(action)
                                    if action ~= nil then
                                      _NF7H:MoveTo(Player)
                                      _Dok.Active = false
                                      _Dok.Visible = false
                                      _fr5qr.Active = true
                                      _fr5qr.Visible = false
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
function _Dok:OnExit()
  _4A2 = _CQPB("qwUB")
  _Urwigo.GlobalZoneExit()
end
function _NB9D2:OnEnter()
  _4A2 = _CQPB("q;T w\v")
  _Urwigo.MessageBox({
    Text = _CQPB("\029U+3P\01863Uo3\002_63\018fH_\0023XP\002_)3HU3Uo0"),
    Media = _MnEpq
  })
  _NB9D2.Active = false
  _NB9D2.Visible = false
  _0aPUO.Active = true
  _0aPUO.Visible = false
end
function _NB9D2:OnExit()
  _4A2 = _CQPB("q;T w\v")
  _Urwigo.GlobalZoneExit()
end
function _Oui36:OnEnter()
  _4A2 = _CQPB("q\025+fY7")
  _Urwigo.MessageBox({
    Text = _CQPB("\0146\018?3of@6)3Q3afB63\002_P\0023?U+3bUo?\0023\002\018?3\002U3@_6P\002d3\029U+3P\01863\0066\018?3@aU!60"),
    Media = _MnEpq
  })
  _Oui36.Active = false
  _Oui36.Visible = false
  _wd_Xy.Active = true
  _wd_Xy.Visible = false
end
function _Oui36:OnExit()
  _4A2 = _CQPB("q\025+fY7")
  _Urwigo.GlobalZoneExit()
end
function _IpVk:OnEnter()
  _4A2 = _CQPB("qQX\014B")
  _Urwigo.MessageBox({
    Text = _CQPB(";f@6)3?U+3P\01863o6P\0183?U+\0183b6!\002foP\002fUod"),
    Media = _MnEpq
  })
  _IpVk.Active = false
  _IpVk.Visible = false
  _7EEKt.Active = true
  _7EEKt.Visible = false
end
function _IpVk:OnExit()
  _4A2 = _CQPB("qQX\014B")
  _Urwigo.GlobalZoneExit()
end
function _dLP:OnEnter()
  _4A2 = _CQPB("qbt\016")
  _Urwigo.MessageBox({
    Text = _CQPB("\023UUb)3HUUb)3i+aa3!\0026P]3P_6Pb"),
    Media = _MnEpq,
    Callback = function(action)
      if action ~= nil then
        _dLP.Active = false
        _dLP.Visible = false
        _Dok.Active = true
        _Dok.Visible = false
      end
    end
  })
end
function _dLP:OnExit()
  _4A2 = _CQPB("qbt\016")
  _Urwigo.GlobalZoneExit()
end
function _fr5qr:OnEnter()
  _4A2 = _CQPB("qi\018y\\\018")
  _Urwigo.MessageBox({
    Text = _CQPB("NUob6\018i+a)3Uo63aP!\00236iiU\018\002d"),
    Media = _MnEpq,
    Callback = function(action)
      if action ~= nil then
        _fr5qr.Active = false
        _fr5qr.Visible = false
        _VLHpz.Active = true
        _VLHpz.Visible = false
      end
    end
  })
end
function _fr5qr:OnExit()
  _4A2 = _CQPB("qi\018y\\\018")
  _Urwigo.GlobalZoneExit()
end
function _Urwigo.GlobalZoneExit()
  _ZPAkP:RequestSync()
end
return _ZPAkP
