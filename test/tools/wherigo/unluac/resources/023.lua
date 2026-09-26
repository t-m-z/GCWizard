require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _czTN(str)
  local res = ""
  local dtable = "x%\006QF6MLe\022hA)J7o_+\021VK}\n\0162\029\0009$<H\005s0pG\0268T?N-!Z\027D\001]b\019C3(.q~g ;tOB\024/{u>v|nyX\t\0205^[\f41=&c\015I:\004\rf\018S\017\031a@#w\030mi\"\002zU'\014\bkl\\\023\028\003\a`Y*Wd,ER\vPj\025r"
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
_clqD = Wherigo.ZCartridge()
_0ci = Wherigo.ZMedia(_clqD)
_0ci.Id = "2aa88142-645e-4faf-a390-e5e01f23bfc3"
_0ci.Name = _czTN("\f9\tF<:'\016YY\tm:[<^\127<")
_0ci.Description = ""
_0ci.AltText = ""
_0ci.Resources = {
  {
    Type = "jpg",
    Filename = "AgentToffelStart.jpg",
    Directives = {}
  }
}
_GPb = Wherigo.ZMedia(_clqD)
_GPb.Id = "a92a8f5b-fc48-4551-ad7f-3545a0e7f012"
_GPb.Name = _czTN("\f9\tF<:'\016YY\tm:|Y\t\127w")
_GPb.Description = ""
_GPb.AltText = ""
_GPb.Resources = {
  {
    Type = "jpg",
    Filename = "AgentToffelPferd.jpg",
    Directives = {}
  }
}
_j2L = Wherigo.ZMedia(_clqD)
_j2L.Id = "64bd275a-7c97-4d1f-95d3-168cfe5b6f0c"
_j2L.Name = _czTN("\f9\tF<:'\016YY\tm:[l^<\t1\016^\127w")
_j2L.Description = ""
_j2L.AltText = ""
_j2L.Resources = {
  {
    Type = "jpg",
    Filename = "AgentToffelSkateboard.jpg",
    Directives = {}
  }
}
_lCg3k = Wherigo.ZMedia(_clqD)
_lCg3k.Id = "ec9ee58f-0210-417f-a5d7-2091894ec3b2"
_lCg3k.Name = _czTN("\f9\tF<\tF<\127\tYY\tF")
_lCg3k.Description = ""
_lCg3k.AltText = ""
_lCg3k.Resources = {
  {
    Type = "jpg",
    Filename = "Agententreffengro.jpg",
    Directives = {}
  }
}
_74up = Wherigo.ZMedia(_clqD)
_74up.Id = "ebbb58e2-1b18-46d1-a5cd-abd27365d62d"
_74up.Name = _czTN(">^Fl")
_74up.Description = ""
_74up.AltText = ""
_74up.Resources = {
  {
    Type = "jpg",
    Filename = "Bank.jpg",
    Directives = {}
  }
}
_iHc = Wherigo.ZMedia(_clqD)
_iHc.Id = "3fa2c762-755d-4801-b4f3-0aca486c35fd"
_iHc.Name = _czTN(">BS\v\v^FwmBF9")
_iHc.Description = ""
_iHc.AltText = ""
_iHc.Resources = {
  {
    Type = "jpg",
    Filename = "Buchhandlung.jpg",
    Directives = {}
  }
}
_xCiL_ = Wherigo.ZMedia(_clqD)
_xCiL_.Id = "a58c8c3c-ee36-4db9-899a-8f46166dba46"
_xCiL_.Name = _czTN("\005\195\164\v\127\t")
_xCiL_.Description = ""
_xCiL_.AltText = ""
_xCiL_.Resources = {
  {
    Type = "jpg",
    Filename = "Faehre.jpg",
    Directives = {}
  }
}
_L7SHr = Wherigo.ZMedia(_clqD)
_L7SHr.Id = "bf2701ed-e8c9-467a-873c-5fca1981dacc"
_L7SHr.Name = _czTN("\f9\tF<\tFBF<\t\127lBFY<")
_L7SHr.Description = ""
_L7SHr.AltText = ""
_L7SHr.Resources = {
  {
    Type = "jpg",
    Filename = "Fitness.jpg",
    Directives = {}
  }
}
_o6BbT = Wherigo.ZMedia(_clqD)
_o6BbT.Id = "e36fa13a-8961-41bd-bb12-b0521f4342f7"
_o6BbT.Name = _czTN("U<^md\tF\t\127")
_o6BbT.Description = ""
_o6BbT.AltText = ""
_o6BbT.Resources = {
  {
    Type = "jpg",
    Filename = "Italiener.jpg",
    Directives = {}
  }
}
_KIlI = Wherigo.ZMedia(_clqD)
_KIlI.Id = "259197ac-6a23-477d-b417-273abfbba6d6"
_KIlI.Name = _czTN("vd\t!\t")
_KIlI.Description = ""
_KIlI.AltText = ""
_KIlI.Resources = {
  {
    Type = "jpg",
    Filename = "Wiese.jpg",
    Directives = {}
  }
}
_a5I = Wherigo.ZMedia(_clqD)
_a5I.Id = "5efa4f50-de51-4399-86b6-10a5c5c315ee"
_a5I.Name = _czTN("'\016\127:[<^\127<")
_a5I.Description = ""
_a5I.AltText = ""
_a5I.Resources = {
  {
    Type = "jpg",
    Filename = "Flughafen-Gebaeude.jpg",
    Directives = {}
  }
}
_8UW = Wherigo.ZMedia(_clqD)
_8UW.Id = "ab14954f-a8b4-498b-ac8f-153b0fd368e0"
_8UW.Name = _czTN("[^Y\t:dFF\tF")
_8UW.Description = ""
_8UW.AltText = ""
_8UW.Resources = {
  {
    Type = "jpg",
    Filename = "Safeinnen2.jpg",
    Directives = {}
  }
}
_IE3 = Wherigo.ZMedia(_clqD)
_IE3.Id = "122aeb41-84f9-4b8c-983a-37bcfa256f3d"
_IE3.Name = _czTN("\f9\tF<:'\016YY\tm:|\127B\t9\tm\td")
_IE3.Description = ""
_IE3.AltText = ""
_IE3.Resources = {
  {
    Type = "jpg",
    Filename = "Prugelei.jpg",
    Directives = {}
  }
}
_1bqL = Wherigo.ZMedia(_clqD)
_1bqL.Id = "949b1e5d-0351-4e63-a574-33d6ed161899"
_1bqL.Name = _czTN("\f9\tF<:'\016YY\tm:\b^l<\016!\tdF<\016m\t\127^Fg")
_1bqL.Description = ""
_1bqL.AltText = ""
_1bqL.Resources = {
  {
    Type = "jpg",
    Filename = "ToffelLaktoseintoleranz.jpg",
    Directives = {}
  }
}
_KGyu5 = Wherigo.ZMedia(_clqD)
_KGyu5.Id = "1bb8e718-da47-4c3c-a499-d26b098d1797"
_KGyu5.Name = _czTN("\f9\tF<:'\016YY\tm:YmBS\v<:D\016\127:\a^Yd\016!\016")
_KGyu5.Description = ""
_KGyu5.AltText = ""
_KGyu5.Resources = {
  {
    Type = "jpg",
    Filename = "VerfolgtvomMafiosi.jpg",
    Directives = {}
  }
}
_R05nI = Wherigo.ZMedia(_clqD)
_R05nI.Id = "586d99a6-144f-405d-87fa-339b6ab30027"
_R05nI.Name = _czTN("\021\127^F")
_R05nI.Description = ""
_R05nI.AltText = ""
_R05nI.Resources = {
  {
    Type = "jpg",
    Filename = "Kran.jpg",
    Directives = {}
  }
}
_8EMZq = Wherigo.ZMedia(_clqD)
_8EMZq.Id = "0dc7bd92-d8a2-4b23-bb50-ace7d799a3dc"
_8EMZq.Name = _czTN("$\t\016S\016dF:[S\vc\t<<\t\127mdF9")
_8EMZq.Description = ""
_8EMZq.AltText = ""
_8EMZq.Resources = {
  {
    Type = "jpg",
    Filename = "GeocoinSchmetterlinggro.jpg",
    Directives = {}
  }
}
_RCQ = Wherigo.ZMedia(_clqD)
_RCQ.Id = "fd32e47e-eeac-4a47-ae06-57d43947f105"
_RCQ.Name = _czTN("\0216'6")
_RCQ.Description = ""
_RCQ.AltText = ""
_RCQ.Resources = {
  {
    Type = "jpg",
    Filename = "KTbeschnittengro1.jpg",
    Directives = {}
  }
}
_m7HU = Wherigo.ZMedia(_clqD)
_m7HU.Id = "cdcf4f35-c5d5-401e-94bf-db2b6523880b"
_m7HU.Name = _czTN("\021d\127S\v\t")
_m7HU.Description = ""
_m7HU.AltText = ""
_m7HU.Resources = {
  {
    Type = "JPG",
    Filename = "kirche_in_kladow.JPG",
    Directives = {}
  }
}
_xqM = Wherigo.ZMedia(_clqD)
_xqM.Id = "f63644ba-b9b7-4ab7-a6f5-dfa109bb39d9"
_xqM.Name = _czTN("\0216'64\025")
_xqM.Description = ""
_xqM.AltText = ""
_xqM.Resources = {
  {
    Type = "jpg",
    Filename = "KTbeschn32.jpg",
    Directives = {}
  }
}
_D3O = Wherigo.ZMedia(_clqD)
_D3O.Id = "7f8106f3-156a-4a93-a80d-aea5c77ee5be"
_D3O.Name = _czTN("\admS\v")
_D3O.Description = ""
_D3O.AltText = ""
_D3O.Resources = {
  {
    Type = "jpg",
    Filename = "Milch1.jpg",
    Directives = {}
  }
}
_Qj2go = Wherigo.ZMedia(_clqD)
_Qj2go.Id = "499d463a-9117-46f9-b61e-eec96bcbdc54"
_Qj2go.Name = _czTN("\admS\v4\025")
_Qj2go.Description = ""
_Qj2go.AltText = ""
_Qj2go.Resources = {
  {
    Type = "jpg",
    Filename = "Milch32.jpg",
    Directives = {}
  }
}
_pdGou = Wherigo.ZMedia(_clqD)
_pdGou.Id = "807bcd3b-028a-449c-b7a1-9076e9614cd7"
_pdGou.Name = _czTN("|Y\t\127w")
_pdGou.Description = ""
_pdGou.AltText = ""
_pdGou.Resources = {
  {
    Type = "jpg",
    Filename = "Pferd1.jpg",
    Directives = {}
  }
}
__pZJ = Wherigo.ZMedia(_clqD)
__pZJ.Id = "06bff41d-b8d0-4bae-86b4-0b07dc388b0d"
__pZJ.Name = _czTN("|Y\t\127w4\025")
__pZJ.Description = ""
__pZJ.AltText = ""
__pZJ.Resources = {
  {
    Type = "jpg",
    Filename = "Pferd32.jpg",
    Directives = {}
  }
}
_Jiq7u = Wherigo.ZMedia(_clqD)
_Jiq7u.Id = "3fef622d-3fea-4bf4-82d5-bd4455373de1"
_Jiq7u.Name = _czTN("[^Y\t:Y\127\016F<")
_Jiq7u.Description = ""
_Jiq7u.AltText = ""
_Jiq7u.Resources = {
  {
    Type = "jpg",
    Filename = "SafeFrontgro.jpg",
    Directives = {}
  }
}
_YkDt = Wherigo.ZMedia(_clqD)
_YkDt.Id = "2f71e2dd-c9f3-4ab5-9f43-70c63e73fd46"
_YkDt.Name = _czTN("[l^<\t1\016^\127w")
_YkDt.Description = ""
_YkDt.AltText = ""
_YkDt.Resources = {
  {
    Type = "jpg",
    Filename = "Skateboardgro.jpg",
    Directives = {}
  }
}
_rnfZs = Wherigo.ZMedia(_clqD)
_rnfZs.Id = "f33fc561-a810-413e-ad47-1068323a6291"
_rnfZs.Name = _czTN("[l^<\t1\016^\127w4\025")
_rnfZs.Description = ""
_rnfZs.AltText = ""
_rnfZs.Resources = {
  {
    Type = "jpg",
    Filename = "Skateboard32.jpg",
    Directives = {}
  }
}
_8QAb = Wherigo.ZMedia(_clqD)
_8QAb.Id = "ff3367d4-dd70-493d-84c9-8f5173a271eb"
_8QAb.Name = _czTN("\f9\tF<:'\016YY\tm:^BY:z\016mm\t\127YmBS\v<")
_8QAb.Description = ""
_8QAb.AltText = ""
_8QAb.Resources = {
  {
    Type = "jpg",
    Filename = "Rollerfluchtgro.jpg",
    Directives = {}
  }
}
_MALQ = Wherigo.ZMedia(_clqD)
_MALQ.Id = "28d04321-93ed-42e8-b866-64d4de96b2c7"
_MALQ.Name = _czTN("v\tdF")
_MALQ.Description = ""
_MALQ.AltText = ""
_MALQ.Resources = {
  {
    Type = "jpg",
    Filename = "Wein1.jpg",
    Directives = {}
  }
}
_miniB = Wherigo.ZMedia(_clqD)
_miniB.Id = "eb4388fd-0a25-40e3-a7ef-f0742b2aa89b"
_miniB.Name = _czTN("v\tdF4\025")
_miniB.Description = ""
_miniB.AltText = ""
_miniB.Resources = {
  {
    Type = "jpg",
    Filename = "Wein32.jpg",
    Directives = {}
  }
}
_h5T = Wherigo.ZMedia(_clqD)
_h5T.Id = "6eb52906-f2bc-4c61-a0bb-42e31663e538"
_h5T.Name = _czTN(",\td<BF9")
_h5T.Description = ""
_h5T.AltText = ""
_h5T.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung1.jpg",
    Directives = {}
  }
}
_bvSc = Wherigo.ZMedia(_clqD)
_bvSc.Id = "faac4308-7f04-4e43-82c4-a975f38b8249"
_bvSc.Name = _czTN(",\td<BF94\025")
_bvSc.Description = ""
_bvSc.AltText = ""
_bvSc.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung32.jpg",
    Directives = {}
  }
}
_WIHWt = Wherigo.ZMedia(_clqD)
_WIHWt.Id = "3f92fdca-4d72-475e-bbde-fef3f656d11e"
_WIHWt.Name = _czTN("|^\127l\tFP")
_WIHWt.Description = ""
_WIHWt.AltText = ""
_WIHWt.Resources = {
  {
    Type = "jpg",
    Filename = "Parken1.jpg",
    Directives = {}
  }
}
_GsC = Wherigo.ZMedia(_clqD)
_GsC.Id = "bae0545d-d88e-494e-9974-5bf802e25bc4"
_GsC.Name = _czTN("\fB<\016")
_GsC.Description = ""
_GsC.AltText = ""
_GsC.Resources = {
  {
    Type = "jpg",
    Filename = "Auto.jpg",
    Directives = {}
  }
}
_ji4 = Wherigo.ZMedia(_clqD)
_ji4.Id = "114fb62d-6db1-4980-a3d4-22f8c9f4d2f4"
_ji4.Name = _czTN("\fB<\0164\025")
_ji4.Description = ""
_ji4.AltText = ""
_ji4.Resources = {
  {
    Type = "jpg",
    Filename = "Auto32.jpg",
    Directives = {}
  }
}
_H1u = Wherigo.ZMedia(_clqD)
_H1u.Id = "db0fc9d4-0e03-494b-8247-70b11429d959"
_H1u.Name = _czTN("$\tmw:lm\tdF")
_H1u.Description = ""
_H1u.AltText = ""
_H1u.Resources = {
  {
    Type = "jpg",
    Filename = "Geldklein.jpg",
    Directives = {}
  }
}
_VMcp = Wherigo.ZMedia(_clqD)
_VMcp.Id = "5006d407-fe3e-49ec-ab8e-b43687db93db"
_VMcp.Name = _czTN("$\t\016S\016dF:[S\vc\t<<\t\127mdF94\025")
_VMcp.Description = ""
_VMcp.AltText = ""
_VMcp.Resources = {
  {
    Type = "jpg",
    Filename = "GeocoinSchmetterling32.jpg",
    Directives = {}
  }
}
_sog = Wherigo.ZMedia(_clqD)
_sog.Id = "56a8675e-3cf8-4588-8f32-c2700e0d90c8"
_sog.Name = _czTN("$\tmw:9\127\016\195\159")
_sog.Description = ""
_sog.AltText = ""
_sog.Resources = {
  {
    Type = "jpg",
    Filename = "Geldgro.jpg",
    Directives = {}
  }
}
_f6F = Wherigo.ZMedia(_clqD)
_f6F.Id = "125e4984-21c9-424c-9209-1ad7a23301a9"
_f6F.Name = _czTN("\021\127\twd<l^\127<\t\0254\"")
_f6F.Description = ""
_f6F.AltText = ""
_f6F.Resources = {
  {
    Type = "jpg",
    Filename = "KreditkartemitCode.jpg",
    Directives = {}
  }
}
_0xfR = Wherigo.ZMedia(_clqD)
_0xfR.Id = "2878be2d-a253-4d72-986b-bbab4d1eec4f"
_0xfR.Name = _czTN("\021\127\twd<l^\127<\t4\025")
_0xfR.Description = ""
_0xfR.AltText = ""
_0xfR.Resources = {
  {
    Type = "jpg",
    Filename = "Kreditkarte32.jpg",
    Directives = {}
  }
}
_4Zw = Wherigo.ZMedia(_clqD)
_4Zw.Id = "32d1ed63-d9de-4444-8787-acdb34c807dd"
_4Zw.Name = _czTN("$\tmw^B<\016c^<")
_4Zw.Description = ""
_4Zw.AltText = ""
_4Zw.Resources = {
  {
    Type = "jpg",
    Filename = "Geldautomat.jpg",
    Directives = {}
  }
}
_Q2VZ = Wherigo.ZMedia(_clqD)
_Q2VZ.Id = "7020c77c-ce02-4b19-a27c-0495ff000de7"
_Q2VZ.Name = _czTN("$\tmw^B<\016c^<:lm\tdF")
_Q2VZ.Description = ""
_Q2VZ.AltText = ""
_Q2VZ.Resources = {
  {
    Type = "jpg",
    Filename = "Geldautomatklein.jpg",
    Directives = {}
  }
}
_6oY = Wherigo.ZMedia(_clqD)
_6oY.Id = "62bca25c-6b8f-4cba-a167-f0c9b66f25b0"
_6oY.Name = _czTN("$\tmw1\tB<\tm")
_6oY.Description = ""
_6oY.AltText = ""
_6oY.Resources = {
  {
    Type = "jpg",
    Filename = "Portemonnaiegro.jpg",
    Directives = {}
  }
}
_JSR = Wherigo.ZMedia(_clqD)
_JSR.Id = "f1be6b15-5334-47b8-8f4a-5d0aa9bab3c5"
_JSR.Name = _czTN("|\t<\t\127")
_JSR.Description = ""
_JSR.AltText = ""
_JSR.Resources = {
  {
    Type = "jpg",
    Filename = "Peter.jpg",
    Directives = {}
  }
}
_B5Gwp = Wherigo.ZMedia(_clqD)
_B5Gwp.Id = "9f888f80-53e3-43ea-87a4-e440dbc91b4c"
_B5Gwp.Name = _czTN("vd\t!\t:lm\tdF")
_B5Gwp.Description = ""
_B5Gwp.AltText = ""
_B5Gwp.Resources = {
  {
    Type = "jpg",
    Filename = "Wieseklein.jpg",
    Directives = {}
  }
}
_n0Ax = Wherigo.ZMedia(_clqD)
_n0Ax.Id = "45d951f1-69e5-41f0-b059-ce62c37ee4ba"
_n0Ax.Name = _czTN("[d<g1^Fl:")
_n0Ax.Description = ""
_n0Ax.AltText = ""
_n0Ax.Resources = {
  {
    Type = "jpg",
    Filename = "Sitzbankgro.jpg",
    Directives = {}
  }
}
_SlWXz = Wherigo.ZMedia(_clqD)
_SlWXz.Id = "93b44618-1cf6-462f-a7f1-3b8e3d4cbf30"
_SlWXz.Name = _czTN("3\v\tY")
_SlWXz.Description = ""
_SlWXz.AltText = ""
_SlWXz.Resources = {
  {
    Type = "jpg",
    Filename = "Chef.jpg",
    Directives = {}
  }
}
_8Fsn = Wherigo.ZMedia(_clqD)
_8Fsn.Id = "5bd3468a-5291-4b50-b17e-98b1eb481620"
_8Fsn.Name = _czTN("$\tmw:lm\tdF")
_8Fsn.Description = ""
_8Fsn.AltText = ""
_8Fsn.Resources = {
  {
    Type = "jpg",
    Filename = "Geldklein1.jpg",
    Directives = {}
  }
}
_lFwbu = Wherigo.ZMedia(_clqD)
_lFwbu.Id = "33868ca8-4880-4602-b4c4-4d1ce7c88740"
_lFwbu.Name = _czTN("'\tm\tY\016F")
_lFwbu.Description = ""
_lFwbu.AltText = ""
_lFwbu.Resources = {
  {
    Type = "jpg",
    Filename = "Handygro.jpg",
    Directives = {}
  }
}
_x5wY6 = Wherigo.ZMedia(_clqD)
_x5wY6.Id = "cf3377fe-55f9-451e-9e2b-d637ab87251e"
_x5wY6.Name = _czTN("3\v\tY:lm\tdF")
_x5wY6.Description = ""
_x5wY6.AltText = ""
_x5wY6.Resources = {
  {
    Type = "jpg",
    Filename = "Chefklein.jpg",
    Directives = {}
  }
}
_8ll = Wherigo.ZMedia(_clqD)
_8ll.Id = "d68686bc-b548-48c6-9709-a50271a28a76"
_8ll.Name = _czTN("\f9\tF<:Ht,")
_8ll.Description = ""
_8ll.AltText = ""
_8ll.Resources = {
  {
    Type = "jpg",
    Filename = "AgentXYZgro.jpg",
    Directives = {}
  }
}
_OriJq = Wherigo.ZMedia(_clqD)
_OriJq.Id = "d3234131-0a72-4f5f-991d-11816318d96a"
_OriJq.Name = _czTN("'\016YY\tm:cd<:Ht,")
_OriJq.Description = ""
_OriJq.AltText = ""
_OriJq.Resources = {
  {
    Type = "jpg",
    Filename = "Agententreffengro1.jpg",
    Directives = {}
  }
}
_Yhfj = Wherigo.ZMedia(_clqD)
_Yhfj.Id = "e03f9c9d-6c45-4b7f-a642-5c18af52a013"
_Yhfj.Name = _czTN("'\016#:[\tS\127\t<:\fl<\t")
_Yhfj.Description = ""
_Yhfj.AltText = ""
_Yhfj.Resources = {
  {
    Type = "jpg",
    Filename = "top-secret-filegro.jpg",
    Directives = {}
  }
}
_zTMm = Wherigo.ZMedia(_clqD)
_zTMm.Id = "198a64d9-8b70-4c22-9491-4f4f9bf19f19"
_zTMm.Name = _czTN("'\016#:[\tS\127\t<:\fl<\t:lm\tdF")
_zTMm.Description = ""
_zTMm.AltText = ""
_zTMm.Resources = {
  {
    Type = "jpg",
    Filename = "top-secret-file2.jpg",
    Directives = {}
  }
}
_TFTb = Wherigo.ZMedia(_clqD)
_TFTb.Id = "8458155f-77c9-4d8e-8b54-8c951df830f0"
_TFTb.Name = _czTN("\031BF9\t\127")
_TFTb.Description = ""
_TFTb.AltText = ""
_TFTb.Resources = {
  {
    Type = "jpg",
    Filename = "hungry.jpg",
    Directives = {}
  }
}
_oow = Wherigo.ZMedia(_clqD)
_oow.Id = "4a3dbd77-c79a-4d96-aefd-7c4653a097e9"
_oow.Name = _czTN("[#^9\v\t<<d")
_oow.Description = ""
_oow.AltText = ""
_oow.Resources = {
  {
    Type = "jpg",
    Filename = "spaghetti.jpg",
    Directives = {}
  }
}
_GbjX = Wherigo.ZMedia(_clqD)
_GbjX.Id = "56a5a086-21de-41a2-bbf5-701fbd31f7fe"
_GbjX.Name = _czTN("v\tdF")
_GbjX.Description = ""
_GbjX.AltText = ""
_GbjX.Resources = {
  {
    Type = "jpg",
    Filename = "Wein1_1.jpg",
    Directives = {}
  }
}
_ZLn = Wherigo.ZMedia(_clqD)
_ZLn.Id = "02469b19-72e8-4745-9326-679a3d5896d9"
_ZLn.Name = _czTN("v^!!\t\127")
_ZLn.Description = ""
_ZLn.AltText = ""
_ZLn.Resources = {
  {
    Type = "jpg",
    Filename = "Wasser.jpg",
    Directives = {}
  }
}
_tokOQ = Wherigo.ZMedia(_clqD)
_tokOQ.Id = "91b3e195-b86d-4d72-b33b-0b3095b8fde4"
_tokOQ.Name = _czTN("\005\127^9\tg\tdS\v\tF")
_tokOQ.Description = ""
_tokOQ.AltText = ""
_tokOQ.Resources = {
  {
    Type = "jpg",
    Filename = "Fragezeichen.jpg",
    Directives = {}
  }
}
_Ro7lz = Wherigo.ZMedia(_clqD)
_Ro7lz.Id = "1b0e5828-d814-46bf-8d2b-7295fbc9075f"
_Ro7lz.Name = _czTN("'\016YY\tm:v\tdF")
_Ro7lz.Description = ""
_Ro7lz.AltText = ""
_Ro7lz.Resources = {
  {
    Type = "jpg",
    Filename = "ToffelWein.jpg",
    Directives = {}
  }
}
_kVMHt = Wherigo.ZMedia(_clqD)
_kVMHt.Id = "1ea78520-07af-4cf4-b338-b6079dacbb16"
_kVMHt.Name = _czTN("\016YY\tF\t:\fl<\t")
_kVMHt.Description = ""
_kVMHt.AltText = ""
_kVMHt.Resources = {
  {
    Type = "jpg",
    Filename = "offeneAkte.jpg",
    Directives = {}
  }
}
_DjRA = Wherigo.ZMedia(_clqD)
_DjRA.Id = "906a77bb-f36c-423a-8f81-23785af900ef"
_DjRA.Name = _czTN("\fmY\016F!\016")
_DjRA.Description = ""
_DjRA.AltText = ""
_DjRA.Resources = {
  {
    Type = "jpg",
    Filename = "Alfonso.jpg",
    Directives = {}
  }
}
_X0U = Wherigo.ZMedia(_clqD)
_X0U.Id = "a96c67db-f7ab-4bf4-805d-5e7dd7e05688"
_X0U.Name = _czTN("'\016YY\tm:\005mBS\v<:D\016\127:\fmY\016F!\016")
_X0U.Description = ""
_X0U.AltText = ""
_X0U.Resources = {
  {
    Type = "jpg",
    Filename = "ToffelFluchtvorAlfonso.jpg",
    Directives = {}
  }
}
_Ov7u = Wherigo.ZMedia(_clqD)
_Ov7u.Id = "d578e2c7-9d31-4c21-8c91-6702278c1dd7"
_Ov7u.Name = _czTN("'\016YY\tm:\127\tFF<")
_Ov7u.Description = ""
_Ov7u.AltText = ""
_Ov7u.Resources = {
  {
    Type = "jpg",
    Filename = "Toffelrennt.jpg",
    Directives = {}
  }
}
_l9s9n = Wherigo.ZMedia(_clqD)
_l9s9n.Id = "111d1d98-c4ff-4df0-93c7-5ad70e71fd92"
_l9s9n.Name = _czTN("|Y^\127\127\t\127")
_l9s9n.Description = ""
_l9s9n.AltText = ""
_l9s9n.Resources = {
  {
    Type = "jpg",
    Filename = "Pfarrer.jpg",
    Directives = {}
  }
}
_Zau = Wherigo.ZMedia(_clqD)
_Zau.Id = "2633a14c-7e8c-462c-8507-de80c466964e"
_Zau.Name = _czTN("\a\016<\016\127\127\016mm\t\127")
_Zau.Description = ""
_Zau.AltText = ""
_Zau.Resources = {
  {
    Type = "jpg",
    Filename = "Roller.jpg",
    Directives = {}
  }
}
_sd8Nv = Wherigo.ZMedia(_clqD)
_sd8Nv.Id = "a12c1170-4081-4a14-9bf2-921b4c6f90f0"
_sd8Nv.Name = _czTN("[S\vm\016!!")
_sd8Nv.Description = ""
_sd8Nv.AltText = ""
_sd8Nv.Resources = {
  {
    Type = "jpg",
    Filename = "Schloss.jpg",
    Directives = {}
  }
}
_Ip2 = Wherigo.ZMedia(_clqD)
_Ip2.Id = "70688c12-3fa9-4a46-8df6-055c711e07f3"
_Ip2.Name = _czTN("'\016YY\tm:Y^\t\v\127<")
_Ip2.Description = ""
_Ip2.AltText = ""
_Ip2.Resources = {
  {
    Type = "jpg",
    Filename = "Toffelfaehrt.jpg",
    Directives = {}
  }
}
_iee5 = Wherigo.ZMedia(_clqD)
_iee5.Id = "ddd357e7-fe74-4554-b3e0-0d7b91e4305a"
_iee5.Name = _czTN("'\127^dFdF9")
_iee5.Description = ""
_iee5.AltText = ""
_iee5.Resources = {
  {
    Type = "jpg",
    Filename = "Training.jpg",
    Directives = {}
  }
}
_yQ8 = Wherigo.ZMedia(_clqD)
_yQ8.Id = "f61557d2-b078-43b4-9347-1f1120b05527"
_yQ8.Name = _czTN("\adl\127\016S\vd#")
_yQ8.Description = ""
_yQ8.AltText = ""
_yQ8.Resources = {
  {
    Type = "jpg",
    Filename = "Mikrochip.jpg",
    Directives = {}
  }
}
_d5_ = Wherigo.ZMedia(_clqD)
_d5_.Id = "160f3f38-3bc4-4402-ad97-f9b8e71a968e"
_d5_.Name = _czTN(",^BFm\016S\v")
_d5_.Description = ""
_d5_.AltText = ""
_d5_.Resources = {
  {
    Type = "jpg",
    Filename = "Zaunloch.jpg",
    Directives = {}
  }
}
_JXnCO = Wherigo.ZMedia(_clqD)
_JXnCO.Id = "8063aa0a-1580-47b6-9e83-0b8efbd9600f"
_JXnCO.Name = _czTN("P")
_JXnCO.Description = ""
_JXnCO.AltText = ""
_JXnCO.Resources = {
  {
    Type = "jpg",
    Filename = "1.jpg",
    Directives = {}
  }
}
_oOD = Wherigo.ZMedia(_clqD)
_oOD.Id = "c2e10bf1-25a5-4f25-97ea-eac2fc8c1c3a"
_oOD.Name = _czTN("\025")
_oOD.Description = ""
_oOD.AltText = ""
_oOD.Resources = {
  {
    Type = "jpg",
    Filename = "2.jpg",
    Directives = {}
  }
}
_7ha1v = Wherigo.ZMedia(_clqD)
_7ha1v.Id = "0d164545-2063-4726-8284-214901404c42"
_7ha1v.Name = _czTN("4")
_7ha1v.Description = ""
_7ha1v.AltText = ""
_7ha1v.Resources = {
  {
    Type = "jpg",
    Filename = "3.jpg",
    Directives = {}
  }
}
_kfff = Wherigo.ZMedia(_clqD)
_kfff.Id = "535854a2-4ae1-489b-9cf6-058568a373a9"
_kfff.Name = _czTN("O")
_kfff.Description = ""
_kfff.AltText = ""
_kfff.Resources = {
  {
    Type = "jpg",
    Filename = "4.jpg",
    Directives = {}
  }
}
_Sh4zX = Wherigo.ZMedia(_clqD)
_Sh4zX.Id = "1baecb03-b84b-48de-965c-55d041eab793"
_Sh4zX.Name = _czTN("K")
_Sh4zX.Description = ""
_Sh4zX.AltText = ""
_Sh4zX.Resources = {
  {
    Type = "jpg",
    Filename = "5.jpg",
    Directives = {}
  }
}
_z4Tq3 = Wherigo.ZMedia(_clqD)
_z4Tq3.Id = "d994571d-5fb4-4238-b8c7-6329556e7c5a"
_z4Tq3.Name = _czTN("\006")
_z4Tq3.Description = ""
_z4Tq3.AltText = ""
_z4Tq3.Resources = {
  {
    Type = "jpg",
    Filename = "6.jpg",
    Directives = {}
  }
}
_my2 = Wherigo.ZMedia(_clqD)
_my2.Id = "5b8cc034-bbd3-486a-8d8e-67edd58685a1"
_my2.Name = _czTN("\015")
_my2.Description = ""
_my2.AltText = ""
_my2.Resources = {
  {
    Type = "jpg",
    Filename = "7.jpg",
    Directives = {}
  }
}
_167 = Wherigo.ZMedia(_clqD)
_167.Id = "4819d9b5-bebf-408a-bb22-ec657d34042d"
_167.Name = _czTN("&")
_167.Description = ""
_167.AltText = ""
_167.Resources = {
  {
    Type = "jpg",
    Filename = "8.jpg",
    Directives = {}
  }
}
_TQpj = Wherigo.ZMedia(_clqD)
_TQpj.Id = "ffb38b2d-7996-497b-84d6-019f94fc1066"
_TQpj.Name = _czTN("\028")
_TQpj.Description = ""
_TQpj.AltText = ""
_TQpj.Resources = {
  {
    Type = "jpg",
    Filename = "9.jpg",
    Directives = {}
  }
}
_kIvIh = Wherigo.ZMedia(_clqD)
_kIvIh.Id = "e9d93031-88ed-4b26-8132-35cfff10040d"
_kIvIh.Name = _czTN("P\"")
_kIvIh.Description = ""
_kIvIh.AltText = ""
_kIvIh.Resources = {
  {
    Type = "jpg",
    Filename = "10.jpg",
    Directives = {}
  }
}
_Z642P = Wherigo.ZMedia(_clqD)
_Z642P.Id = "93e59147-8ede-4f62-afe4-d6d5c6d79082"
_Z642P.Name = _czTN("PP")
_Z642P.Description = ""
_Z642P.AltText = ""
_Z642P.Resources = {
  {
    Type = "jpg",
    Filename = "11.jpg",
    Directives = {}
  }
}
_c2E = Wherigo.ZMedia(_clqD)
_c2E.Id = "864a19e6-e674-47bd-8188-507da6b5bd10"
_c2E.Name = _czTN("P\025")
_c2E.Description = ""
_c2E.AltText = ""
_c2E.Resources = {
  {
    Type = "jpg",
    Filename = "12.jpg",
    Directives = {}
  }
}
_VUJdZ = Wherigo.ZMedia(_clqD)
_VUJdZ.Id = "41198289-477b-485d-aae6-ae5b0b6929db"
_VUJdZ.Name = _czTN("P4")
_VUJdZ.Description = ""
_VUJdZ.AltText = ""
_VUJdZ.Resources = {
  {
    Type = "jpg",
    Filename = "13.jpg",
    Directives = {}
  }
}
_CFquk = Wherigo.ZMedia(_clqD)
_CFquk.Id = "2b92b0d7-db8c-4da0-8491-cd9fa51ecbb3"
_CFquk.Name = _czTN("PO")
_CFquk.Description = ""
_CFquk.AltText = ""
_CFquk.Resources = {
  {
    Type = "jpg",
    Filename = "14.jpg",
    Directives = {}
  }
}
_Eoc = Wherigo.ZMedia(_clqD)
_Eoc.Id = "c9421a06-376d-4487-ae31-3699667ede26"
_Eoc.Name = _czTN("PK")
_Eoc.Description = ""
_Eoc.AltText = ""
_Eoc.Resources = {
  {
    Type = "jpg",
    Filename = "15.jpg",
    Directives = {}
  }
}
_UNMse = Wherigo.ZMedia(_clqD)
_UNMse.Id = "2628dafe-fd9c-443b-9523-67ef0ff2f770"
_UNMse.Name = _czTN("P\006")
_UNMse.Description = ""
_UNMse.AltText = ""
_UNMse.Resources = {
  {
    Type = "jpg",
    Filename = "16.jpg",
    Directives = {}
  }
}
_Msd = Wherigo.ZMedia(_clqD)
_Msd.Id = "b4aa6707-276e-45d9-a5b6-c994aecfbda3"
_Msd.Name = _czTN("P\015")
_Msd.Description = ""
_Msd.AltText = ""
_Msd.Resources = {
  {
    Type = "jpg",
    Filename = "17.jpg",
    Directives = {}
  }
}
_tHlY = Wherigo.ZMedia(_clqD)
_tHlY.Id = "c18508ec-acb1-4fb5-bca4-febe1dbb3b69"
_tHlY.Name = _czTN("P&")
_tHlY.Description = ""
_tHlY.AltText = ""
_tHlY.Resources = {
  {
    Type = "jpg",
    Filename = "18.jpg",
    Directives = {}
  }
}
_eCX98 = Wherigo.ZMedia(_clqD)
_eCX98.Id = "f176f88a-dd23-43a1-9ac9-742e4e2824b1"
_eCX98.Name = _czTN("P\028")
_eCX98.Description = ""
_eCX98.AltText = ""
_eCX98.Resources = {
  {
    Type = "jpg",
    Filename = "19.jpg",
    Directives = {}
  }
}
_f9xg2 = Wherigo.ZMedia(_clqD)
_f9xg2.Id = "31d1c427-88c0-4061-afda-fe497e1ccb76"
_f9xg2.Name = _czTN("\fB!\127BY\tg\tdS\v\tF")
_f9xg2.Description = ""
_f9xg2.AltText = ""
_f9xg2.Resources = {
  {
    Type = "jpg",
    Filename = "ausrufezeichen.jpg",
    Directives = {}
  }
}
_XYP = Wherigo.ZMedia(_clqD)
_XYP.Id = "aa96670d-6c73-4236-a182-8612805e1b05"
_XYP.Name = _czTN("=1\t\127")
_XYP.Description = ""
_XYP.AltText = ""
_XYP.Resources = {
  {
    Type = "gif",
    Filename = "ober11.gif",
    Directives = {}
  }
}
_OZXK = Wherigo.ZMedia(_clqD)
_OZXK.Id = "4c93b9e0-9e9f-455e-99e7-569065cf1f4e"
_OZXK.Name = _czTN("\025\"")
_OZXK.Description = ""
_OZXK.AltText = ""
_OZXK.Resources = {
  {
    Type = "jpg",
    Filename = "20.jpg",
    Directives = {}
  }
}
_omWB = Wherigo.ZMedia(_clqD)
_omWB.Id = "6f0e67a5-d2b2-4473-9e93-f5d62b90e1b1"
_omWB.Name = _czTN("'^.^:[\016BFw:Y\195\188\127:\005dF^m:\021\016\016\127w!")
_omWB.Description = ""
_omWB.AltText = ""
_omWB.Resources = {
  {
    Type = "mp3",
    Filename = "TaDa-SoundBiblecom-1884170640.mp3",
    Directives = {}
  }
}
_qaA = Wherigo.ZMedia(_clqD)
_qaA.Id = "4af0d468-ad63-46a7-9670-9bcae74dcad5"
_qaA.Name = _czTN("\a\016<\016\127\127\016mm\t\127:$\t\127\195\164B!S\v")
_qaA.Description = ""
_qaA.AltText = ""
_qaA.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-1020092-zuendapp-ks-50-tt-watercooled.mp3",
    Directives = {}
  }
}
_6tCH = Wherigo.ZMedia(_clqD)
_6tCH.Id = "dbd6a277-a17d-4f02-9254-ac8935812d52"
_6tCH.Name = _czTN("'\016YY\tm:#Y\tdY<")
_6tCH.Description = ""
_6tCH.AltText = ""
_6tCH.Resources = {
  {
    Type = "mp3",
    Filename = "WhistlingPerson-SoundBiblecom-1899769180.mp3",
    Directives = {}
  }
}
_RRq = Wherigo.ZMedia(_clqD)
_RRq.Id = "2607cbbf-047a-458a-98ec-26be8599ccc2"
_RRq.Name = _czTN("[S\vdYY!\v\016\127F")
_RRq.Description = ""
_RRq.AltText = ""
_RRq.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-4073743-schiffshorn-eines-grossen.mp3",
    Directives = {}
  }
}
_mPQ = Wherigo.ZMedia(_clqD)
_mPQ.Id = "9ead6e24-f2c3-403f-bd28-ad90c8af0d3f"
_mPQ.Name = _czTN("\fB<\016:!<^\127<\t<")
_mPQ.Description = ""
_mPQ.AltText = ""
_mPQ.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-1020089-land-rover-defender-130.mp3",
    Directives = {}
  }
}
_lnc = Wherigo.ZMedia(_clqD)
_lnc.Id = "759fc6f9-5019-413a-95e2-5b436794461f"
_lnc.Name = _czTN("$\t\v\tdc")
_lnc.Description = ""
_lnc.AltText = ""
_lnc.Resources = {
  {
    Type = "jpg",
    Filename = "X-Geheim.jpg",
    Directives = {}
  }
}
_Ey9PS = Wherigo.ZMedia(_clqD)
_Ey9PS.Id = "dccb3d6b-2a10-4b87-ac57-4e59d9b370c5"
_Ey9PS.Name = _czTN("'\tm\tY\016FlmdF9\tm")
_Ey9PS.Description = ""
_Ey9PS.AltText = ""
_Ey9PS.Resources = {
  {
    Type = "mp3",
    Filename = "Klingelton-altes-Telefon.mp3",
    Directives = {}
  }
}
_ny2q = Wherigo.ZMedia(_clqD)
_ny2q.Id = "cd1dee49-56bb-4692-b080-79650bd5ce55"
_ny2q.Name = _czTN("[\016BFw:[S\vm\195\1649\t\127\td")
_ny2q.Description = ""
_ny2q.AltText = ""
_ny2q.Resources = {
  {
    Type = "mp3",
    Filename = "faustkampf.mp3",
    Directives = {}
  }
}
_HZA = Wherigo.ZMedia(_clqD)
_HZA.Id = "73c16268-93d6-4daf-95df-93836b66787a"
_HZA.Name = _czTN("\021\127dcdcB!dl")
_HZA.Description = ""
_HZA.AltText = ""
_HZA.Resources = {
  {
    Type = "mp3",
    Filename = "krimimusik.mp3",
    Directives = {}
  }
}
_H5l = Wherigo.ZMedia(_clqD)
_H5l.Id = "e2893d73-a06d-4fd9-b818-7a8347f7393f"
_H5l.Name = _czTN("$\tmw^B<\016c^<:[\016BFw")
_H5l.Description = ""
_H5l.AltText = ""
_H5l.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-1081404-banknoten-zaehlmaschine.mp3",
    Directives = {}
  }
}
_2pS0 = Wherigo.ZMedia(_clqD)
_2pS0.Id = "20ab67df-2179-4bbc-9b08-3ad0fcefac1d"
_2pS0.Name = _czTN("\020\016\t9\tm:[\016BFw")
_2pS0.Description = ""
_2pS0.AltText = ""
_2pS0.Resources = {
  {
    Type = "mp3",
    Filename = "voegelSound.mp3",
    Directives = {}
  }
}
_xTL7U = Wherigo.ZMedia(_clqD)
_xTL7U.Id = "533a5ac6-d250-4088-8783-82ab011d7cac"
_xTL7U.Name = _czTN("\f##m^B!")
_xTL7U.Description = ""
_xTL7U.AltText = ""
_xTL7U.Resources = {
  {
    Type = "mp3",
    Filename = "Applaus.mp3",
    Directives = {}
  }
}
_clqD.Id = "f8d030af-9734-41cb-b096-71347d242fb6"
_clqD.Name = "Agent Karl Toffel "
_clqD.Description = "Diese Runde fuehrt durch Kladow. Die grossen Strecken sollten mit einem Fahrzeug bewaeltigt werden. Sobald ihr am Kladower Hafen seid, koennt ihr das Fahrzeug bis zum Final stehen lassen. Viel Spass, das Aski-Team"
_clqD.Visible = true
_clqD.Activity = "Geocache"
_clqD.StartingLocationDescription = "Hier muesst ihr starten"
_clqD.StartingLocation = ZonePoint(52.472533, 13.135383, 0)
_clqD.Version = "1"
_clqD.Company = ""
_clqD.Author = "Aski-Team"
_clqD.BuilderVersion = "URWIGO 1.20.5218.24064"
_clqD.CreateDate = "06/13/2014 20:17:27"
_clqD.PublishDate = "1/1/0001 12:00:00 AM"
_clqD.UpdateDate = "09/21/2014 16:58:43"
_clqD.LastPlayedDate = "1/1/0001 12:00:00 AM"
_clqD.TargetDevice = "PocketPC"
_clqD.TargetDeviceVersion = "0"
_clqD.StateId = "1"
_clqD.CountryId = "2"
_clqD.Complete = false
_clqD.UseLogging = true
_clqD.Media = _0ci
_aIyrW = Wherigo.Zone(_clqD)
_aIyrW.Id = "85b93ab1-7b11-40b6-a74b-fa08082f488c"
_aIyrW.Name = _czTN("|^\127l\tF")
_aIyrW.Description = _czTN("U\v\127:!\tdw:\f9\tF<:\021^\127m:'\016YY\tm:BFw:F^S\v:\tdF\tc:\t\127Y\016m9\127\tdS\v:^19\t!S\vm\016!!\tF\tF:\fBY<\127^9:^c:\005mB9\v^Y\tF:$^<\016a:9\tm^Fw\t<6:yB\t\127:\020\016\1279\t!\t<g<\t\127:\v^<:\tBS\v:F\016S\v:FdS\v<:dFY\016\127cd\t\127<x:a\016\127Bc:\t!:dF:\tB\127\tc:F^\tS\v!<\tF:\fBY<\127^9:9\t\v<6666")
_aIyrW.Visible = true
_aIyrW.Media = _WIHWt
_aIyrW.Commands = {
  _DZm6 = Wherigo.ZCommand({
    Text = _czTN("$\t\v:gBc:'\016\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_aIyrW.Commands._DZm6.Custom = true
_aIyrW.Commands._DZm6.Id = "b30886c8-14a3-4402-8de6-f1e87538b55a"
_aIyrW.Commands._DZm6.WorksWithAll = true
_aIyrW.DistanceRange = Distance(-1, "feet")
_aIyrW.ShowObjects = "OnEnter"
_aIyrW.ProximityRange = Distance(60, "meters")
_aIyrW.AllowSetPositionTo = false
_aIyrW.Active = true
_aIyrW.Points = {
  ZonePoint(52.4723476787536, 13.1354360282421, 0),
  ZonePoint(52.4723762711578, 13.1357753276825, 0),
  ZonePoint(52.4726899694579, 13.1357525289059, 0),
  ZonePoint(52.4726229819878, 13.1350484490395, 0),
  ZonePoint(52.4723386925657, 13.1350672245026, 0)
}
_aIyrW.OriginalPoint = ZonePoint(52.4724751187846, 13.1354159116745, 0)
_aIyrW.DistanceRangeUOM = "Feet"
_aIyrW.ProximityRangeUOM = "Meters"
_aIyrW.OutOfRangeName = ""
_aIyrW.InRangeName = ""
_jpB = Wherigo.Zone(_clqD)
_jpB.Id = "60bc4d80-af51-456e-8878-e62c08c10421"
_jpB.Name = _czTN("\005mB9\v^Y\tF:\fB!9^F9")
_jpB.Description = ""
_jpB.Visible = true
_jpB.Media = _a5I
_jpB.Commands = {}
_jpB.DistanceRange = Distance(-1, "feet")
_jpB.ShowObjects = "OnEnter"
_jpB.ProximityRange = Distance(60, "meters")
_jpB.AllowSetPositionTo = false
_jpB.Active = false
_jpB.Points = {
  ZonePoint(52.4725377976221, 13.1371520110797, 0),
  ZonePoint(52.4728561413409, 13.1370893288708, 0),
  ZonePoint(52.4727877462328, 13.1364884257603, 0),
  ZonePoint(52.4724659955528, 13.1365960932541, 0),
  ZonePoint(52.4725020775155, 13.1368803977966, 0)
}
_jpB.OriginalPoint = ZonePoint(52.4726299516528, 13.1368412513523, 0)
_jpB.DistanceRangeUOM = "Feet"
_jpB.ProximityRangeUOM = "Meters"
_jpB.OutOfRangeName = ""
_jpB.InRangeName = ""
_UrWKi = Wherigo.Zone(_clqD)
_UrWKi.Id = "45089ec7-45d9-471a-8321-feb804a15897"
_UrWKi.Name = _czTN("\f9\tF<\tFBF<\t\127lBFY<")
_UrWKi.Description = ""
_UrWKi.Visible = true
_UrWKi.Media = _L7SHr
_UrWKi.Commands = {}
_UrWKi.DistanceRange = Distance(-1, "feet")
_UrWKi.ShowObjects = "OnEnter"
_UrWKi.ProximityRange = Distance(60, "meters")
_UrWKi.AllowSetPositionTo = false
_UrWKi.Active = false
_UrWKi.Points = {
  ZonePoint(52.4550471750371, 13.1435064135266, 0),
  ZonePoint(52.4548921231207, 13.1432129153443, 0),
  ZonePoint(52.4547288990363, 13.1435243141556, 0),
  ZonePoint(52.4549530759852, 13.1437031190492, 0)
}
_UrWKi.OriginalPoint = ZonePoint(52.4549053182948, 13.1434866905189, 0)
_UrWKi.DistanceRangeUOM = "Feet"
_UrWKi.ProximityRangeUOM = "Meters"
_UrWKi.OutOfRangeName = ""
_UrWKi.InRangeName = ""
__RmL = Wherigo.Zone(_clqD)
__RmL.Id = "dea21f6d-5934-4de7-bf8c-e8adfdae9bbd"
__RmL.Name = _czTN(">^Fl")
__RmL.Description = _czTN("vd\t:9B<x:w^!!:\t!:\vd\t\127:^c:=\127<:\tdF\t:.\f$:5.\tB<!S\v\t:\f9\tF<\tF:>^Fl\r:9d1<6:US\v:1\127^\tBS\v<\t:\t<a^!:$\tmw6")
__RmL.Visible = true
__RmL.Media = _74up
__RmL.Commands = {
  _Aos_Y = Wherigo.ZCommand({
    Text = _czTN("$\t\v\t:gB\127:>^Fl"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
__RmL.Commands._Aos_Y.Custom = true
__RmL.Commands._Aos_Y.Id = "dbc38568-5f1b-499f-a10c-f007cd59c085"
__RmL.Commands._Aos_Y.WorksWithAll = true
__RmL.DistanceRange = Distance(-1, "feet")
__RmL.ShowObjects = "OnEnter"
__RmL.ProximityRange = Distance(60, "meters")
__RmL.AllowSetPositionTo = false
__RmL.Active = false
__RmL.Points = {
  ZonePoint(52.4547157776646, 13.1447589203071, 0),
  ZonePoint(52.4548971170062, 13.1450175497723, 0),
  ZonePoint(52.455047876762, 13.1447613988114, 0),
  ZonePoint(52.4548987967531, 13.1444476674938, 0)
}
__RmL.OriginalPoint = ZonePoint(52.4548898920465, 13.1447463840962, 0)
__RmL.DistanceRangeUOM = "Feet"
__RmL.ProximityRangeUOM = "Meters"
__RmL.OutOfRangeName = ""
__RmL.InRangeName = ""
_P3q = Wherigo.Zone(_clqD)
_P3q.Id = "774a4941-5442-4542-b2f2-88257e2d1d87"
_P3q.Name = _czTN(">BS\v\v^FwmBF9@,\td<BF9!m^w\tF")
_P3q.Description = _czTN(".^!:d!<:\tdF:dF<\t\127\t!!^F<\t\127:\b^w\tF6:.d\t:\v^1\tF:w\016\127<:FdS\v<:FB\127:>B\tS\v\t\127:BFw:,\td<BF9\tFx:!\016Fw\t\127F:^BS\v:$\t\016S^S\vdF91\tw^\127Y6:")
_P3q.Visible = true
_P3q.Media = _iHc
_P3q.Commands = {
  _jIOC = Wherigo.ZCommand({
    Text = _czTN("$\t\v\t:gB\127:>BS\v\v^FwmBF9@,\td<BF9!m^w\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_P3q.Commands._jIOC.Custom = true
_P3q.Commands._jIOC.Id = "c155ed5e-22df-4cff-9443-52ff42106e21"
_P3q.Commands._jIOC.WorksWithAll = true
_P3q.DistanceRange = Distance(-1, "feet")
_P3q.ShowObjects = "OnEnter"
_P3q.ProximityRange = Distance(60, "meters")
_P3q.AllowSetPositionTo = false
_P3q.Active = false
_P3q.Points = {
  ZonePoint(52.4540749035918, 13.1433764723873, 0),
  ZonePoint(52.4538948574645, 13.1432963558198, 0),
  ZonePoint(52.4538499076688, 13.1436366466617, 0),
  ZonePoint(52.4540438475012, 13.1437132356167, 0)
}
_P3q.OriginalPoint = ZonePoint(52.4539658790566, 13.1435056776214, 0)
_P3q.DistanceRangeUOM = "Feet"
_P3q.ProximityRangeUOM = "Meters"
_P3q.OutOfRangeName = ""
_P3q.InRangeName = ""
_e0M = Wherigo.Zone(_clqD)
_e0M.Id = "6916a272-1555-42c1-816f-4471473c5353"
_e0M.Name = _czTN("\031^Y\tF")
_e0M.Description = ""
_e0M.Visible = true
_e0M.Media = _KIlI
_e0M.Commands = {}
_e0M.DistanceRange = Distance(-1, "feet")
_e0M.ShowObjects = "OnEnter"
_e0M.ProximityRange = Distance(60, "meters")
_e0M.AllowSetPositionTo = false
_e0M.Active = false
_e0M.Points = {
  ZonePoint(52.4526285579122, 13.1490029153442, 0),
  ZonePoint(52.4529513949957, 13.1497395042992, 0),
  ZonePoint(52.45232, 13.1504600000001, 0)
}
_e0M.OriginalPoint = ZonePoint(52.452633317636, 13.1497341398812, 0)
_e0M.DistanceRangeUOM = "Feet"
_e0M.ProximityRangeUOM = "Meters"
_e0M.OutOfRangeName = ""
_e0M.InRangeName = ""
_fCHc = Wherigo.Zone(_clqD)
_fCHc.Id = "d1b02e70-4bba-459a-a6e0-529a38dcb320"
_fCHc.Name = _czTN("z\t!<^B\127^F<")
_fCHc.Description = ""
_fCHc.Visible = false
_fCHc.Media = _o6BbT
_fCHc.Commands = {}
_fCHc.DistanceRange = Distance(-1, "feet")
_fCHc.ShowObjects = "OnEnter"
_fCHc.ProximityRange = Distance(60, "meters")
_fCHc.AllowSetPositionTo = false
_fCHc.Active = true
_fCHc.Points = {
  ZonePoint(52.4508289416423, 13.1472251018524, 0),
  ZonePoint(52.4505988923682, 13.1470103497029, 0),
  ZonePoint(52.45065, 13.14685, 0),
  ZonePoint(52.45091, 13.14708, 0)
}
_fCHc.OriginalPoint = ZonePoint(52.4507469585026, 13.1470413628888, 0)
_fCHc.DistanceRangeUOM = "Feet"
_fCHc.ProximityRangeUOM = "Meters"
_fCHc.OutOfRangeName = ""
_fCHc.InRangeName = ""
_CZvL = Wherigo.Zone(_clqD)
_CZvL.Id = "88c1f7df-0f61-4d87-bb89-0bad3131aeea"
_CZvL.Name = _czTN("\005^\t\v\127\t")
_CZvL.Description = ""
_CZvL.Visible = true
_CZvL.Media = _xCiL_
_CZvL.Commands = {}
_CZvL.DistanceRange = Distance(-1, "feet")
_CZvL.ShowObjects = "OnEnter"
_CZvL.ProximityRange = Distance(60, "meters")
_CZvL.AllowSetPositionTo = false
_CZvL.Active = false
_CZvL.Points = {
  ZonePoint(52.4513915862095, 13.1480127693462, 0),
  ZonePoint(52.45145, 13.1478099999999, 0),
  ZonePoint(52.45131, 13.14765, 0),
  ZonePoint(52.4512268743551, 13.1478606994056, 0)
}
_CZvL.OriginalPoint = ZonePoint(52.4513446151412, 13.1478333671879, 0)
_CZvL.DistanceRangeUOM = "Feet"
_CZvL.ProximityRangeUOM = "Meters"
_CZvL.OutOfRangeName = ""
_CZvL.InRangeName = ""
_a3mQ = Wherigo.Zone(_clqD)
_a3mQ.Id = "ce0a862b-820d-42ac-befc-a9461e5cc3f2"
_a3mQ.Name = _czTN(",Bc:'^\127FBF<\t\127!S\vmB#Y")
_a3mQ.Description = ""
_a3mQ.Visible = true
_a3mQ.Commands = {}
_a3mQ.DistanceRange = Distance(-1, "feet")
_a3mQ.ShowObjects = "OnEnter"
_a3mQ.ProximityRange = Distance(60, "meters")
_a3mQ.AllowSetPositionTo = false
_a3mQ.Active = false
_a3mQ.Points = {
  ZonePoint(52.45175, 13.1478999999999, 0),
  ZonePoint(52.4516340383505, 13.1481551018524, 0),
  ZonePoint(52.4517669230726, 13.1482781631946, 0),
  ZonePoint(52.4518587980508, 13.1480236736106, 0)
}
_a3mQ.OriginalPoint = ZonePoint(52.4517524398685, 13.1480892346644, 0)
_a3mQ.DistanceRangeUOM = "Feet"
_a3mQ.ProximityRangeUOM = "Meters"
_a3mQ.OutOfRangeName = ""
_a3mQ.InRangeName = ""
_moHnh = Wherigo.Zone(_clqD)
_moHnh.Id = "ec4e0d01-b7f6-46e7-8f14-ce55c4442d54"
_moHnh.Name = _czTN(",B\127:\021d\127S\v\t")
_moHnh.Description = ""
_moHnh.Visible = true
_moHnh.Commands = {}
_moHnh.DistanceRange = Distance(-1, "feet")
_moHnh.ShowObjects = "OnEnter"
_moHnh.ProximityRange = Distance(60, "meters")
_moHnh.AllowSetPositionTo = false
_moHnh.Active = false
_moHnh.Points = {
  ZonePoint(52.452671587326, 13.1452404662705, 0),
  ZonePoint(52.4527587976666, 13.1450355104162, 0),
  ZonePoint(52.4528924989547, 13.1451961226844, 0),
  ZonePoint(52.4528292298592, 13.1454182797622, 0)
}
_moHnh.OriginalPoint = ZonePoint(52.4527880284516, 13.1452225947833, 0)
_moHnh.DistanceRangeUOM = "Feet"
_moHnh.ProximityRangeUOM = "Meters"
_moHnh.OutOfRangeName = ""
_moHnh.InRangeName = ""
_FykoK = Wherigo.Zone(_clqD)
_FykoK.Id = "59a31406-bfef-411c-96dd-a5e1e4a5654e"
_FykoK.Name = _czTN("gBc:\021d\127S\v\tF#^\127l#m^<g")
_FykoK.Description = ""
_FykoK.Visible = true
_FykoK.Media = _Ov7u
_FykoK.Commands = {}
_FykoK.DistanceRange = Distance(-1, "feet")
_FykoK.ShowObjects = "OnEnter"
_FykoK.ProximityRange = Distance(60, "meters")
_FykoK.AllowSetPositionTo = false
_FykoK.Active = false
_FykoK.Points = {
  ZonePoint(52.4532561392371, 13.1443890403366, 0),
  ZonePoint(52.4531180186249, 13.1446912845515, 0),
  ZonePoint(52.4529564360451, 13.1444886317731, 0),
  ZonePoint(52.4530787106678, 13.1441827118397, 0)
}
_FykoK.OriginalPoint = ZonePoint(52.4531023261437, 13.1444379171252, 0)
_FykoK.DistanceRangeUOM = "Feet"
_FykoK.ProximityRangeUOM = "Meters"
_FykoK.OutOfRangeName = ""
_FykoK.InRangeName = ""
_iiera = Wherigo.Zone(_clqD)
_iiera.Id = "9175bbb5-1f2e-46f5-83d8-c1ed89f46c1b"
_iiera.Name = _czTN("\020\t\127!<\tSl:w\t!:\adl\127\016S\vd#")
_iiera.Description = ""
_iiera.Visible = true
_iiera.Commands = {}
_iiera.DistanceRange = Distance(-1, "feet")
_iiera.ShowObjects = "OnEnter"
_iiera.ProximityRange = Distance(60, "meters")
_iiera.AllowSetPositionTo = false
_iiera.Active = false
_iiera.Points = {
  ZonePoint(52.4531220266847, 13.1485882401466, 0),
  ZonePoint(52.4532756756088, 13.14887188375, 0),
  ZonePoint(52.4530893353551, 13.1490884721279, 0),
  ZonePoint(52.4528862399263, 13.1488671898842, 0)
}
_iiera.OriginalPoint = ZonePoint(52.4530933193937, 13.1488539464772, 0)
_iiera.DistanceRangeUOM = "Feet"
_iiera.ProximityRangeUOM = "Meters"
_iiera.OutOfRangeName = ""
_iiera.InRangeName = ""
_KFu = Wherigo.Zone(_clqD)
_KFu.Id = "9d29427f-9030-4c31-a57c-31cdc9498bb0"
_KFu.Name = _czTN("\f9\tF<\tF:$\t\v\tdcD\t\127!<\tSl:")
_KFu.Description = _czTN(")BF:!S\vF\tmm:F\016S\v:w\tF:3\vd#:gB:BF!\t\127\tc:\f9\tF<\tF:$\t\v\tdcD\t\127!<\tSl:1\127dF9\tF+:v\016:a^\127:\t!:w\tFF:FB\127(:\a\016c\tF<666:US\v:\v^<<\t:cd\127:wd\t:\021\016\016\127wdF^<\tF:w\016S\v:^BY:c\tdF\tc:>\127\016<#^#d\t\127:F\016<d\t\127<66666BFw:dS\v:aBFw\t\127<\t:cdS\v:1\t\127\td<!:wd\t:9^Fg\t:,\td<x:a^!:dS\v:\005\t<<d9\t!:dF:c\tdF\t\127:\031\016!\tF<^!S\v\t:\v^1\t666666\fS\vx:\vd\t\127:!dFw:!d\tV:\025\015644P@\"\028644&:6:)BF:^1\t\127:\vB\127<d9:w\tF:\fBY<\127^9:1\t\tFw\tF+\030>zC")
_KFu.Visible = true
_KFu.Media = _lnc
_KFu.Commands = {}
_KFu.DistanceRange = Distance(-1, "feet")
_KFu.ShowObjects = "OnEnter"
_KFu.ProximityRange = Distance(60, "meters")
_KFu.AllowSetPositionTo = false
_KFu.Active = false
_KFu.Points = {
  ZonePoint(52.4557004788624, 13.1555633246899, 0),
  ZonePoint(52.4556048622537, 13.1553956866264, 0),
  ZonePoint(52.4554945351395, 13.1556504964828, 0),
  ZonePoint(52.4556130346215, 13.1557913124561, 0)
}
_KFu.OriginalPoint = ZonePoint(52.4556032277193, 13.1556002050638, 0)
_KFu.DistanceRangeUOM = "Feet"
_KFu.ProximityRangeUOM = "Meters"
_KFu.OutOfRangeName = ""
_KFu.InRangeName = ""
_lOI08 = Wherigo.ZCharacter({Cartridge = _clqD, Container = _jpB})
_lOI08.Id = "a1a7cc2a-90f1-4905-a1bb-70d0be30fad3"
_lOI08.Name = _czTN("|Y\t\127w")
_lOI08.Description = ""
_lOI08.Visible = true
_lOI08.Media = _pdGou
_lOI08.Icon = __pZJ
_lOI08.Commands = {
  _ppL = Wherigo.ZCommand({
    Text = _czTN("^B!a^\t\vm\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN("z\td<\tF:c^S\v<:[#^!!")
  })
}
_lOI08.Commands._ppL.Custom = true
_lOI08.Commands._ppL.Id = "5476a880-7521-4b63-987d-21227cfb5f04"
_lOI08.Commands._ppL.WorksWithAll = true
_lOI08.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_lOI08.Gender = "It"
_lOI08.Type = "NPC"
_3Op1H = Wherigo.ZCharacter({Cartridge = _clqD, Container = _jpB})
_3Op1H.Id = "15d523f0-316b-403a-9f24-470a3a053196"
_3Op1H.Name = _czTN("\fB<\016")
_3Op1H.Description = ""
_3Op1H.Visible = true
_3Op1H.Media = _GsC
_3Op1H.Icon = _ji4
_3Op1H.Commands = {
  _EQLex = Wherigo.ZCommand({
    Text = _czTN("^B!a^\t\vm\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_3Op1H.Commands._EQLex.Custom = true
_3Op1H.Commands._EQLex.Id = "0187600d-be40-40fd-9c02-fc3109b78574"
_3Op1H.Commands._EQLex.WorksWithAll = true
_3Op1H.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3Op1H.Gender = "It"
_3Op1H.Type = "NPC"
_eTRmG = Wherigo.ZCharacter({Cartridge = _clqD, Container = _jpB})
_eTRmG.Id = "269d66e5-ee29-43b1-b86f-e481b959145b"
_eTRmG.Name = _czTN("[l^<\t1\016^\127w")
_eTRmG.Description = ""
_eTRmG.Visible = true
_eTRmG.Media = _YkDt
_eTRmG.Icon = _rnfZs
_eTRmG.Commands = {
  _aXNl = Wherigo.ZCommand({
    Text = _czTN("^B!a^\t\vm\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_eTRmG.Commands._aXNl.Custom = true
_eTRmG.Commands._aXNl.Id = "6f0ef313-c0f1-4eca-a0b0-d04fe7820ecc"
_eTRmG.Commands._aXNl.WorksWithAll = true
_eTRmG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_eTRmG.Gender = "It"
_eTRmG.Type = "NPC"
_ud5Pj = Wherigo.ZCharacter({Cartridge = _clqD, Container = _CZvL})
_ud5Pj.Id = "267cd214-7eeb-4e9d-afca-9caead6e7143"
_ud5Pj.Name = _czTN("\f9\tF<:Ht,")
_ud5Pj.Description = ""
_ud5Pj.Visible = true
_ud5Pj.Media = _8ll
_ud5Pj.Icon = _8ll
_ud5Pj.Commands = {
  _Bj7NO = Wherigo.ZCommand({
    Text = _czTN("\fBY<\127^9!B\t1\t\1279^1\t"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_ud5Pj.Commands._Bj7NO.Custom = true
_ud5Pj.Commands._Bj7NO.Id = "95cf9547-3156-4e48-92e1-4db4928c1efb"
_ud5Pj.Commands._Bj7NO.WorksWithAll = true
_ud5Pj.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ud5Pj.Gender = "Male"
_ud5Pj.Type = "NPC"
_E5pUo = Wherigo.ZItem(_clqD)
_E5pUo.Id = "96ddf061-3b4a-423a-979b-abbbbbfd02f3"
_E5pUo.Name = _czTN("z\t!<g\td<:")
_E5pUo.Description = _czTN("|Y\t\127w")
_E5pUo.Visible = true
_E5pUo.Commands = {}
_E5pUo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_E5pUo.Locked = false
_E5pUo.Opened = false
_56qG = Wherigo.ZItem(_clqD)
_56qG.Id = "32e49b00-e51c-4032-9312-bddc3f698a07"
_56qG.Name = _czTN("z\t!<g\td<")
_56qG.Description = _czTN("[l^<\t1\016^\127w")
_56qG.Visible = true
_56qG.Commands = {}
_56qG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_56qG.Locked = false
_56qG.Opened = false
_KZsU = Wherigo.ZItem(_clqD)
_KZsU.Id = "fb0f4966-b558-4eb6-8e89-40997691dfdb"
_KZsU.Name = _czTN("$\tmw")
_KZsU.Description = ""
_KZsU.Visible = true
_KZsU.Media = _sog
_KZsU.Icon = _H1u
_KZsU.Commands = {}
_KZsU.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_KZsU.Locked = false
_KZsU.Opened = false
_5pYu = Wherigo.ZItem({Cartridge = _clqD, Container = _P3q})
_5pYu.Id = "ce995b92-9ee4-446f-854a-ee4f90b4f585"
_5pYu.Name = _czTN(",\td<BF9")
_5pYu.Description = ""
_5pYu.Visible = true
_5pYu.Icon = _bvSc
_5pYu.Commands = {
  _07XOg = Wherigo.ZCommand({
    Text = _czTN(",\td<BF9:l^BY\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_5pYu.Commands._07XOg.Custom = true
_5pYu.Commands._07XOg.Id = "db95552a-c394-41fe-9bd9-ef72f878dda6"
_5pYu.Commands._07XOg.WorksWithAll = true
_5pYu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_5pYu.Locked = false
_5pYu.Opened = false
_Rk6B = Wherigo.ZItem({Cartridge = _clqD, Container = _P3q})
_Rk6B.Id = "1f39ea1f-68f0-4e53-b04e-3e5cec6d329c"
_Rk6B.Name = _czTN("$\t\016S\016dF:")
_Rk6B.Description = ""
_Rk6B.Visible = true
_Rk6B.Icon = _VMcp
_Rk6B.Commands = {
  _A3m = Wherigo.ZCommand({
    Text = _czTN("$\t\016S\016dF:^F!\t\v\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_Rk6B.Commands._A3m.Custom = true
_Rk6B.Commands._A3m.Id = "a83aaef8-6424-45d6-b256-2b29d7bce321"
_Rk6B.Commands._A3m.WorksWithAll = true
_Rk6B.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Rk6B.Locked = false
_Rk6B.Opened = false
_rLW = Wherigo.ZItem({Cartridge = _clqD, Container = __RmL})
_rLW.Id = "f627c565-1a6e-416b-907f-deb0d4c480de"
_rLW.Name = _czTN("\021\127\twd<l^\127<\t")
_rLW.Description = ""
_rLW.Visible = true
_rLW.Media = _f6F
_rLW.Icon = _0xfR
_rLW.Commands = {
  _Tqz = Wherigo.ZCommand({
    Text = _czTN("P\"\"x\"\":yB\127\016:!\016mm<\tF:\127\tdS\v\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_rLW.Commands._Tqz.Custom = true
_rLW.Commands._Tqz.Id = "c803fd91-d7fb-4de7-9e07-bb909e55624c"
_rLW.Commands._Tqz.WorksWithAll = true
_rLW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rLW.Locked = false
_rLW.Opened = false
_Ru12p = Wherigo.ZItem(_clqD)
_Ru12p.Id = "0c3af07e-0680-46cb-b2fa-67d43838c5f2"
_Ru12p.Name = _czTN("$\t\016S\016dF:[S\vc\t<<\t\127mdF9")
_Ru12p.Description = _czTN("'\127^SldF9S\016w\tV:3zy\028)>\030>zC$3V:'>4\020&,)")
_Ru12p.Visible = true
_Ru12p.Media = _8EMZq
_Ru12p.Icon = _VMcp
_Ru12p.Commands = {}
_Ru12p.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Ru12p.Locked = false
_Ru12p.Opened = false
_pR1uk = Wherigo.ZItem(_clqD)
_pR1uk.Id = "59e18f5f-7a4a-492d-a29c-fcf38d4ee2a2"
_pR1uk.Name = _czTN("9\tl^BY<\t:,\td<BF9:")
_pR1uk.Description = _czTN("ym\tl<\127\016FdlS\vd#:9\t!<\016\vm\tF66666[#B\127:YB\t\v\127<:F^S\v:\021m^w\016a")
_pR1uk.Visible = true
_pR1uk.Media = _h5T
_pR1uk.Icon = _bvSc
_pR1uk.Commands = {}
_pR1uk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_pR1uk.Locked = false
_pR1uk.Opened = false
_0Cgi = Wherigo.ZItem({Cartridge = _clqD, Container = _e0M})
_0Cgi.Id = "fc3decc4-f78e-4062-b091-b9ac3ac9188f"
_0Cgi.Name = _czTN("'\tm\tY\016F")
_0Cgi.Description = ""
_0Cgi.Visible = true
_0Cgi.Media = _lFwbu
_0Cgi.Icon = _lFwbu
_0Cgi.Commands = {
  _mVv = Wherigo.ZCommand({
    Text = _czTN(".\tF:\fF\127BY:^FF\t\vc\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_0Cgi.Commands._mVv.Custom = true
_0Cgi.Commands._mVv.Id = "5290f2fb-ea9d-4c02-8533-27126b2aed73"
_0Cgi.Commands._mVv.WorksWithAll = true
_0Cgi.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_0Cgi.Locked = false
_0Cgi.Opened = false
_lj9 = Wherigo.ZItem({Cartridge = _clqD, Container = _CZvL})
_lj9.Id = "7c5c2eae-be78-440c-a5ac-830c91a62763"
_lj9.Name = _czTN("'\016#:[\tS\127\t<:\fl<\t")
_lj9.Description = ""
_lj9.Visible = true
_lj9.Media = _Yhfj
_lj9.Icon = _zTMm
_lj9.Commands = {
  _Brs = Wherigo.ZCommand({
    Text = _czTN("\fl<\t:\195\182YYF\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_lj9.Commands._Brs.Custom = true
_lj9.Commands._Brs.Id = "5b74ba92-677b-4060-84ea-b3a3a16f7b67"
_lj9.Commands._Brs.WorksWithAll = true
_lj9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_lj9.Locked = false
_lj9.Opened = true
_MLBK = Wherigo.ZItem({Cartridge = _clqD, Container = _fCHc})
_MLBK.Id = "64be85c5-7b90-4574-b4a6-f9daac7bd031"
_MLBK.Name = _czTN("\admS\v")
_MLBK.Description = ""
_MLBK.Visible = true
_MLBK.Media = _D3O
_MLBK.Commands = {
  _fuq = Wherigo.ZCommand({
    Text = _czTN("\admS\v:<\127dFl\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_MLBK.Commands._fuq.Custom = true
_MLBK.Commands._fuq.Id = "5cf775e4-bf5a-4957-b8ce-14553d25a4a6"
_MLBK.Commands._fuq.WorksWithAll = true
_MLBK.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_MLBK.Locked = false
_MLBK.Opened = false
_CrPV = Wherigo.ZItem({Cartridge = _clqD, Container = _fCHc})
_CrPV.Id = "1ceb3ea8-5743-4a68-a54c-b3adbd48a291"
_CrPV.Name = _czTN("v\tdF")
_CrPV.Description = ""
_CrPV.Visible = true
_CrPV.Media = _MALQ
_CrPV.Commands = {
  _gRRv = Wherigo.ZCommand({
    Text = _czTN("v\tdF:<\127dFl\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_CrPV.Commands._gRRv.Custom = true
_CrPV.Commands._gRRv.Id = "6b98feac-e3cc-4f40-b512-650fd6eac634"
_CrPV.Commands._gRRv.WorksWithAll = true
_CrPV.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_CrPV.Locked = false
_CrPV.Opened = false
_FO9HF = Wherigo.ZItem({Cartridge = _clqD, Container = _fCHc})
_FO9HF.Id = "894159cf-31a3-42a2-b7e3-1615473ee18a"
_FO9HF.Name = _czTN("v^!!\t\127")
_FO9HF.Description = ""
_FO9HF.Visible = true
_FO9HF.Media = _ZLn
_FO9HF.Commands = {
  _UFk = Wherigo.ZCommand({
    Text = _czTN("v^!!\t\127:<\127dFl\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_FO9HF.Commands._UFk.Custom = true
_FO9HF.Commands._UFk.Id = "c5974b46-d703-4052-8c39-2767c5bf1d45"
_FO9HF.Commands._UFk.WorksWithAll = true
_FO9HF.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_FO9HF.Locked = false
_FO9HF.Opened = false
_VZM9n = Wherigo.ZItem({Cartridge = _clqD, Container = _FykoK})
_VZM9n.Id = "30ac6827-3239-499a-b170-b70860b79535"
_VZM9n.Name = _czTN("\a\016<\016\127\127\016mm\t\127")
_VZM9n.Description = ""
_VZM9n.Visible = true
_VZM9n.Media = _Zau
_VZM9n.Commands = {
  _UU8 = Wherigo.ZCommand({
    Text = _czTN("\a\016<\016\127\127\016mm\t\127:1\tFB<g\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_VZM9n.Commands._UU8.Custom = true
_VZM9n.Commands._UU8.Id = "f3291fb1-9a87-4707-9929-544c77765f8d"
_VZM9n.Commands._UU8.WorksWithAll = true
_VZM9n.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_VZM9n.Locked = false
_VZM9n.Opened = false
_xW3WV = Wherigo.ZItem({Cartridge = _clqD, Container = _iiera})
_xW3WV.Id = "eb22cf89-31ca-4ae1-bad3-3d0b023c767b"
_xW3WV.Name = _czTN("\005\127^9\t:P")
_xW3WV.Description = ""
_xW3WV.Visible = true
_xW3WV.Commands = {
  _Qt1d = Wherigo.ZCommand({
    Text = _czTN("\005\127^9\t"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_xW3WV.Commands._Qt1d.Custom = true
_xW3WV.Commands._Qt1d.Id = "5b430e52-d2c4-4433-996e-71a3fc1d4964"
_xW3WV.Commands._Qt1d.WorksWithAll = true
_xW3WV.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xW3WV.Locked = false
_xW3WV.Opened = false
_AfC = Wherigo.ZItem({Cartridge = _clqD, Container = _iiera})
_AfC.Id = "5e8f9df3-d75e-4ab2-9d32-65e8d1b371f9"
_AfC.Name = _czTN("\005\127^9\t:\025")
_AfC.Description = ""
_AfC.Visible = false
_AfC.Commands = {
  _1Pe7G = Wherigo.ZCommand({
    Text = _czTN("\005\127^9\t"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_AfC.Commands._1Pe7G.Custom = true
_AfC.Commands._1Pe7G.Id = "fc661b66-53e8-4e71-bddd-f70e1c22367e"
_AfC.Commands._1Pe7G.WorksWithAll = true
_AfC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_AfC.Locked = false
_AfC.Opened = false
_LjyT = Wherigo.ZItem({Cartridge = _clqD, Container = _iiera})
_LjyT.Id = "bf484179-4ef2-484f-98fe-a4f29eda42c8"
_LjyT.Name = _czTN("\005\127^9\t:4")
_LjyT.Description = ""
_LjyT.Visible = false
_LjyT.Commands = {
  _QSIi = Wherigo.ZCommand({
    Text = _czTN("\005\127^9\t"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_LjyT.Commands._QSIi.Custom = true
_LjyT.Commands._QSIi.Id = "7ca99260-91f2-48a8-8903-80ccc6285e52"
_LjyT.Commands._QSIi.WorksWithAll = true
_LjyT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_LjyT.Locked = false
_LjyT.Opened = false
_9UEC = Wherigo.ZItem(_clqD)
_9UEC.Id = "f5073058-ea28-4a14-9545-8a6a85c20e2f"
_9UEC.Name = _czTN("[^Y\t:dFF\tF")
_9UEC.Description = _czTN("'\127^SldF9S\016w\tV:[3HP,\015\030>zC$3V:'>\006$Ot\"")
_9UEC.Visible = true
_9UEC.Media = _8UW
_9UEC.Commands = {}
_9UEC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_9UEC.Locked = false
_9UEC.Opened = false
_WlWcy = Wherigo.ZItem({Cartridge = _clqD, Container = _CZvL})
_WlWcy.Id = "a9f93d64-f390-4ee4-b4e9-ad873dd43ff8"
_WlWcy.Name = _czTN("=\tYYFBF9!S\016w\t:\fl<\t")
_WlWcy.Description = ""
_WlWcy.Visible = false
_WlWcy.Commands = {
  _QhLv = Wherigo.ZCommand({
    Text = _czTN("=\tYYFBF9!S\016w\t:\fl<\t:\tdF9\t1\tF"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _czTN(")dS\v<:D\t\127Y\195\18891^\127")
  })
}
_WlWcy.Commands._QhLv.Custom = true
_WlWcy.Commands._QhLv.Id = "3f5a75a1-f1c6-4c68-832e-367fcb0c21fa"
_WlWcy.Commands._QhLv.WorksWithAll = true
_WlWcy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_WlWcy.Locked = false
_WlWcy.Opened = true
_jjxJQ = Wherigo.ZItem({Cartridge = _clqD, Container = _KFu})
_jjxJQ.Id = "1a882ae9-0b70-48c3-b671-6e394e80cafb"
_jjxJQ.Name = _czTN("hFm\016SlS\016w\t")
_jjxJQ.Description = ""
_jjxJQ.Visible = false
_jjxJQ.Commands = {}
_jjxJQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jjxJQ.Locked = false
_jjxJQ.Opened = false
_AFXND = Wherigo.ZTask(_clqD)
_AFXND.Id = "932b655c-003b-41d4-a824-0274d32472c7"
_AFXND.Name = _czTN("\005^\v\127g\tB9:1\tFB<g\tF")
_AFXND.Description = ""
_AFXND.Visible = true
_AFXND.Active = false
_AFXND.Complete = false
_AFXND.CorrectState = "Correct"
_hX0 = Wherigo.ZTask(_clqD)
_hX0.Id = "c491421f-a322-48c1-8fa6-62ea749f4129"
_hX0.Name = _czTN("$\tmw:1\t!S\v^YY\tF")
_hX0.Description = ""
_hX0.Visible = false
_hX0.Icon = _H1u
_hX0.Active = false
_hX0.Complete = false
_hX0.CorrectState = "None"
_RQuQL = Wherigo.ZTask(_clqD)
_RQuQL.Id = "447d51d6-1676-4a24-9a8c-d211e8759895"
_RQuQL.Name = _czTN(",\td<BF9:BFw:$\t\016S\016dF:l^BY\tF")
_RQuQL.Description = ""
_RQuQL.Visible = false
_RQuQL.Icon = _bvSc
_RQuQL.Active = false
_RQuQL.Complete = false
_RQuQL.CorrectState = "None"
_edD = Wherigo.ZTask(_clqD)
_edD.Id = "16f94aa4-6d79-41c9-a2fb-fa76cda4eaf3"
_edD.Name = _czTN("\fl<\t:\016\tYYF\tF")
_edD.Description = ""
_edD.Visible = true
_edD.Media = _Yhfj
_edD.Icon = _zTMm
_edD.Active = false
_edD.Complete = false
_edD.CorrectState = "None"
_5i7 = Wherigo.ZTask(_clqD)
_5i7.Id = "a286a7f5-1865-4673-8216-94242006a465"
_5i7.Name = _czTN("$\t\v\tdcg^\vm:\021\127\twd<l^\127<\t")
_5i7.Description = ""
_5i7.Visible = true
_5i7.Active = false
_5i7.Complete = false
_5i7.CorrectState = "None"
_cXx5H = Wherigo.ZTask(_clqD)
_cXx5H.Id = "cbf9f9c9-6773-44e9-8df7-143afec7404d"
_cXx5H.Name = _czTN("\b\016\t!\t:\fBY9^1\t:P")
_cXx5H.Description = ""
_cXx5H.Visible = false
_cXx5H.Active = false
_cXx5H.Complete = false
_cXx5H.CorrectState = "None"
_kKSi = Wherigo.ZTask(_clqD)
_kKSi.Id = "2a622480-3c0b-4312-bbdc-aa367089f2f0"
_kKSi.Name = _czTN("\b\016\t!\t:\fBY9^1\t:\025")
_kKSi.Description = ""
_kKSi.Visible = false
_kKSi.Active = false
_kKSi.Complete = false
_kKSi.CorrectState = "None"
__Qg = Wherigo.ZTask(_clqD)
__Qg.Id = "014a46cb-82bd-42dd-a9e4-a7d71d6251ef"
__Qg.Name = _czTN("\b\016\t!\t:\fBY9^1\t:4")
__Qg.Description = ""
__Qg.Visible = false
__Qg.Active = false
__Qg.Complete = false
__Qg.CorrectState = "None"
_jPp = Wherigo.ZTask(_clqD)
_jPp.Id = "a9e5db97-f18e-432c-8ba0-b22d1bb816a3"
_jPp.Name = _czTN("=\tYYFBF9!S\016w\t:\fl<\t")
_jPp.Description = ""
_jPp.Visible = false
_jPp.Active = true
_jPp.Complete = false
_jPp.CorrectState = "None"
_P0Br = 60
_iiftg = 0
_7sJ3 = 0
_QPnq = false
_Lh0l = false
_Mv0V = false
_OOT = false
_8LF = false
_WyD3D = false
_nbA = ""
_GNFB_ = _czTN("\005P\"")
_e2Cgu = false
_YgJX = false
_rKt6_ = false
_9B3 = true
_UOP9u = false
_HCh = false
_mPTmf = ""
_zxp = ""
_wsRK = ""
_Bg5HC = _czTN("\017^UG\127v")
__idu = _czTN("\017m=U\"&")
_Yi_ = _czTN("\017yK#h\016")
_rPB = _czTN("\017\f\005H).")
_HN2hZ = _czTN("\017v\021m7\021")
_9eb5 = _czTN("\017)\006|")
_clqD.ZVariables = {
  _P0Br = 60,
  _iiftg = 0,
  _7sJ3 = 0,
  _QPnq = false,
  _Lh0l = false,
  _Mv0V = false,
  _OOT = false,
  _8LF = false,
  _WyD3D = false,
  _nbA = "",
  _GNFB_ = _czTN("\005P\""),
  _e2Cgu = false,
  _YgJX = false,
  _rKt6_ = false,
  _9B3 = true,
  _UOP9u = false,
  _HCh = false,
  _mPTmf = "",
  _zxp = "",
  _wsRK = "",
  _Bg5HC = _czTN("\017^UG\127v"),
  __idu = _czTN("\017m=U\"&"),
  _Yi_ = _czTN("\017yK#h\016"),
  _rPB = _czTN("\017\f\005H)."),
  _HN2hZ = _czTN("\017v\021m7\021"),
  _9eb5 = _czTN("\017)\006|")
}
_N6P = Wherigo.ZTimer(_clqD)
_N6P.Id = "428b0359-fb5c-4cab-a817-ad3dfbc16085"
_N6P.Name = _czTN("'dc\t\127")
_N6P.Description = ""
_N6P.Visible = true
_N6P.Duration = 1
_N6P.Type = "Countdown"
_WKlqK = Wherigo.ZInput(_clqD)
_WKlqK.Id = "cb1f724b-3c65-4a01-89ce-0ddbf537f5ae"
_WKlqK.Name = _czTN("UF#B<:")
_WKlqK.Description = ""
_WKlqK.Visible = true
_WKlqK.Choices = {"Ja", "Nein"}
_WKlqK.InputType = "MultipleChoice"
_WKlqK.Text = _czTN("v\td!!<:wB:w\tF:3\016w\t(")
_mHQ = Wherigo.ZInput(_clqD)
_mHQ.Id = "5e0430b4-b1ba-42f9-b8e7-47d3f6fa53b2"
_mHQ.Name = _czTN(".\tdF\t:$\t\v\tdcg^\vm:\tdF9\t1\tF")
_mHQ.Description = ""
_mHQ.Visible = true
_mHQ.InputType = "Text"
_mHQ.Text = _czTN("\a\tdF\t:$\t\v\tdcg^\vm:m^B<\t<(\030>zCvd\t(:\031^1\t:dS\v:!d\t:!S\v\016F:ad\tw\t\127:D\t\1279\t!!\tF(\030>zC[d\t:!<\t\v<:gBc:$mB\tSl:^BY:c\tdF\t\127:\021^\127<\t666US\v:1dF:^BS\v:\tdF\t:[S\vB!!\tm1d\127F\t:+")
_4vry7 = Wherigo.ZInput(_clqD)
_4vry7.Id = "bed42913-d85a-43ea-a07c-a716b3c2d72e"
_4vry7.Name = _czTN(",^\vm\tF!S\vm\016!!:\a\016<\016\127\127\016mm\t\127")
_4vry7.Description = ""
_4vry7.Visible = true
_4vry7.Media = _sd8Nv
_4vry7.InputType = "Text"
_4vry7.Text = _czTN("vd\t:m^B<\t<:wd\t:\021\016c1dF^<d\016F(")
_S3T = Wherigo.ZInput(_clqD)
_S3T.Id = "56356a9d-3a9d-4d9e-9c56-04d3f4baf9c2"
_S3T.Name = _czTN("UF#B<:P")
_S3T.Description = ""
_S3T.Visible = true
_S3T.Choices = {"750 kg", "1000 kg"}
_S3T.InputType = "MultipleChoice"
_S3T.Text = _czTN(">d!:gB:ad\tDd\tm:l9:d!<:w\t\127:\021\127^F:1\tm^!<1^\127(:")
_tK_ = Wherigo.ZInput(_clqD)
_tK_.Id = "324c9714-1928-474b-a7ab-7157f8cd0492"
_tK_.Name = _czTN("UF#B<:\025")
_tK_.Description = ""
_tK_.Visible = true
_tK_.Choices = {"Zeiss Ikon", "Abus"}
_tK_.InputType = "MultipleChoice"
_tK_.Text = _czTN("v\tmS\v\t:[S\vmd\t!!gGmdFw\t\127\v\t\127!<\tmm\t\127:1\tFB<g<:wd\t:\a^Yd^(")
_RR9 = Wherigo.ZInput(_clqD)
_RR9.Id = "bbee7208-66dc-4850-b814-f39ccdb4bf65"
_RR9.Name = _czTN("UF#B<:4")
_RR9.Description = ""
_RR9.Visible = true
_RR9.Choices = {"363 3406", "361 3101"}
_RR9.InputType = "MultipleChoice"
_RR9.Text = _czTN("vd\t:m^B<\t<:wd\t:'\tm\tY\016FFBcc\t\127:w\t\127:\a^Yd^g\tF<\127^m\t:5\fm!:.\tSlF^c\t:e>\t\127mdF\t\127:v^!!\t\1271\t<\127d\t1\te\r:(")
_3D5pU = Wherigo.ZInput(_clqD)
_3D5pU.Id = "889d6356-df41-4d4d-86a7-d7a37ad68e83"
_3D5pU.Name = _czTN("=\tYYFBF9!S\016w\t:\fl<\t")
_3D5pU.Description = ""
_3D5pU.Visible = true
_3D5pU.InputType = "Text"
_3D5pU.Text = _czTN("vd\t:m^B<\t<:w\t\127:3\016w\t:w\tFF:FBF(")
function _clqD:OnStart()
  if _G[_czTN("yFD")][_czTN(".\tDdS\tU.")] == _czTN(".\t!l<\016#") or _G[_czTN("yFD")][_czTN("|m^<Y\016\127c")] == _czTN("vdF4\025") then
    for k, v in pairs(_G[_czTN("\017Sm7.")][_czTN("\fmm,=1}\tS<!")]) do
      v[_czTN("\020d!d1m\t")] = false
      v[_czTN("\fS<dD\t")] = false
    end
    _G[_czTN("v\v\t\127d9\016")][_czTN("3\016cc^Fw")](_czTN("[^D\t3m\016!\t"))
    return
  end
end
function _clqD:OnRestore()
end
function _aIyrW:On_DZm6(target)
  _Bg5HC = _czTN("\017^UG\127v")
  Wherigo.PlayAudio(_HZA)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _aIyrW:OnExit()
  _Bg5HC = _czTN("\017^UG\127v")
  _jpB.Active = true
end
function _jpB:OnEnter()
  _Bg5HC = _czTN("\017}#>")
  Wherigo.Command("StopSound")
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("[BS\v\t:wd\127:\tdF:\005\016\127<1\ta\t9BF9!cd<<\tm:cd<:w\tc:wB:gB:w\tdF\t\127:hF<\t\127lBFY<:9\tm^F9!<6")
    }
  }, function(action)
    _AFXND.Active = true
  end)
end
function _UrWKi:OnEnter()
  _Bg5HC = _czTN("\017h\127v\021d")
  _UrWKi.Active = false
  _jpB.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _czTN(".^:1dF:dS\v:FBF:9B<:cd<:w\tc:\fB<\016c\0161dm:9\tm^Fw\t<6:.d\t:\f9\tF<\tFY^\v\127g\tB9\t:!dFw:ad\127lmdS\v:lm^!!\t6:\020\016\127:^mm\tc:wd\t:\adFd1^\127:d!<:dcc\t\127:\127\tdS\v\v^m<d9:9\tYB\tmm<6\030>zC"),
      Media = _RCQ
    },
    {
      Text = _czTN("v^!:d!<:w\tFF:w^!:\vd\t\127(:\030>zCydF:\005d<F\t!!*[<Bwd\016(")
    },
    {
      Text = _czTN(".d\t:w\tFl\tF:!dS\v:^BS\v:!<^\tFwd9:F\tB\t:.\tSlc^\tF<\tm:Y\195\188\127:wd\t:hF<\t\127lB\tFY<\t:^B!6:\f1\t\127:!\016:9B<x:ad\t:dS\v:\t1\tF:9\t9\t!!\tF:\v^1\tx:l\016\tFF<\t:dS\v:cd\127:\vd\t\127:Dd\tmm\tdS\v<:^BS\v:\tdF:|\016\tm!<\t\127S\v\tF:^1<\127^dFd\t\127\tF6666"),
      Media = _iee5
    },
    {
      Text = _czTN("\f1\t\127:^m!:\t\127!<\t!:1\127dF9\t:dS\v:c\tdF\t:[^S\v\tF:F^S\v:\0161\tF:BFw:w^FF:9\t\v\t:dS\v:\vd\t\127:\tdF:a\tFd9:!S\vm\tFw\t\127F6"),
      Media = _kIvIh
    }
  }, function(action)
    __RmL.Active = true
    _P3q.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _clqD:RequestSync()
  end)
end
function __RmL:On_Aos_Y(target)
  _Bg5HC = _czTN("\017\017zc\b")
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  _rLW.Opened = true
end
function _P3q:On_jIOC(target)
  _Bg5HC = _czTN("\017|47")
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  _5pYu.Opened = true
  _Rk6B.Opened = true
end
function _e0M:OnEnter()
  _Bg5HC = _czTN("\017\t\"\a")
  Wherigo.PlayAudio(_2pS0)
  _aIyrW.Active = false
  _UrWKi.Active = false
  __RmL.Active = false
  _P3q.Active = false
  _lj9.Opened = false
  _lj9.Visible = false
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("US\v:!BS\v\t:cd\127:\t\127!<:\tdFc^m:\tdF\t:!S\v\016\tF\t:>^Fl:^BY:wd\t:dS\v:cdS\v:!\t<g\tF:l^FF6:"),
      Media = _n0Ax
    },
    {
      Text = _czTN(".d\t:\vd\t\127:d!<:Y\127\td6:\031d\t\127:l^FF:dS\v:c\tdF\t:,\td<BF9:m\t!\tF6:\fS\v:dS\v:\v^1\t:}^:\vd\t\127:dF:c\tdF\t\127:'^!S\v\t:F\016S\v:\tdF:>B<<\t\1271\127\016<6:.^!:\t!!\t:dS\v:c^m:\t1\tF:!S\vF\tmm:^BY6:\a^F:a\td!!:}^:Fd\tx:a^FF:c^F:ad\tw\t\127:,\td<:gBc:y!!\tF:\v^<666)BF:l^FF:dS\v:w^1\td:^BS\v:c\tdF\t:,\td<BF9:m\t!\tF"),
      Media = _h5T
    },
    {
      Text = _czTN("\f\v^+:ydF:a\t\127<D\016mm\t\127:3\vd#:aB\127w\t:^B!:BF!\t\127\tF:$\t\v\tdcwd\tF!<l\127\td!\tF:9\t!<\016\vm\tF6:.d\t:[#B\127:YB\t\v\127<:\vd\t\127\v\t\1276666:"),
      Media = _yQ8
    },
    {
      Text = _czTN(">\t!<dcc<:\v^<:cdS\v:w\t\127:>\016!!:w\t!\v^m1:\v\t\1271\t\016\127w\t\127<6"),
      Media = _RCQ
    },
    {
      Text = _czTN(".\tdF:'\tm\tY\016F:lmdF9\tm<"),
      Media = _lFwbu
    },
    {
      Text = _czTN("\ad!<+:\aB!!:w^!:}\t<g<:!\tdF("),
      Media = _OZXK
    },
    {
      Text = _czTN(")dS\v<:\tdFc^m:dF:zB\v\t:,\td<BF9:m\t!\tF:l^FF:dS\v:\vd\t\1276666"),
      Media = _RCQ
    }
  }, function(action)
    _0Cgi.Visible = true
    Wherigo.PlayAudio(_Ey9PS)
    _Urwigo.MessageBox({
      Text = _czTN(")BF:9\t\v:\tFwmdS\v:^F:w^!:'\tm\tY\016F+"),
      Media = _f9xg2,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end)
end
function _fCHc:OnEnter()
  _Bg5HC = _czTN("\017Y3\031S")
  _fCHc.Visible = true
  _Urwigo.MessageBox({
    Text = _czTN("\fS\v:ad\t:\127d\tS\v<:w^!:\vd\t\127:m\tSl\t\127:+:\bd\t1\t\127:9\t\v\t:dS\v:}^:\td9\tF<mdS\v:\0161\tF:^F:w\t\127:\031^B#<!<\127^!!\t:1\td:c\tdF\tc:\005\127\tBFw:\fm1\t\127<\016:\t!!\tFx:^1\t\127:w^:dS\v:}\t<g<:!S\v\016F:c^m:\vd\t\127:1dF:#\127\0161d\t\127:dS\v:wd\t!\t:\021B\tS\v\t:\tdFY^S\v:c^m:^B!6:v^!:1\t!<\tmm\t:dS\v:cd\127:FB\127:gB:<\127dFl\tF(:"),
    Media = _TQpj,
    Callback = function(action)
      if action ~= nil then
        _0Cgi:MoveTo(nil)
      end
    end
  })
  _CZvL.Active = false
  _clqD:RequestSync()
end
function _CZvL:OnEnter()
  _Bg5HC = _czTN("\0173,D\b")
  _lj9.Opened = false
  Wherigo.PlayAudio(_RRq)
  _Urwigo.Dialog(false, {
    {
      Text = _czTN(".^:1dF:dS\v:}^:#B\tFl<mdS\v:^F9\tl\016cc\tF6:.d\t:\005^\t\v\127\t:m\t9<:1\t\127\td<!:^F66666\a^m:9BSl\tFx:\0161:dS\v:Ht,:!\t\v\tF:l^FF6666"),
      Media = _RCQ
    },
    {
      Text = _czTN("\fS\v6666w^:d!<:\t\127:}^:+"),
      Media = _VUJdZ
    },
    {
      Text = _czTN("US\v:9\t\v\t:BF^BYY^\tmmd9:gB:d\vc:\127B\t1\t\127"),
      Media = _Eoc
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.PlayAudio(_6tCH)
  end)
end
function _CZvL:OnExit()
  _Bg5HC = _czTN("\0173,D\b")
  _lj9.Visible = false
  _lj9.Opened = false
end
function _a3mQ:OnEnter()
  _Bg5HC = _czTN("\017^4c\004")
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("\ad!<x:dS\v:a\t\127w\t:D\t\127Y\016m9<:+:.d\t:\014BF9!:D\016F:w\t\127:\a^Yd^:\v^1\tF:cdS\v:\tF<w\tSl<:BFw:d\v\127\tF:1\t!<\tF:\a^FF:9\t!S\vdSl<6:"),
      Media = _UNMse
    },
    {
      Text = _czTN("\fB!9\t\127\tS\vF\t<:\fmY\016F!\016:m\t:|d!<\016m\t\127\0166:"),
      Media = _DjRA
    },
    {
      Text = _czTN("US\v:cB!!:c^m:wd\t:>\tdF\t:dF:wd\t:\031^\tFw\t:F\t\vc\tF:BFw:\tdF\tF:,^\vF:gBm\t9\tF6:"),
      Media = _KGyu5
    },
    {
      Text = _czTN("\020\t\127w^cc<6:y\127:\127B\tSl<:cd\127:dcc\t\127:F^\t\v\t\127:^BY:wd\t:|\tmm\t:+"),
      Media = _X0U
    },
    {
      Text = _czTN("US\v:\127\tFF\t:!S\vF\tmm:gB\127B\tSl:BFw:w\tF:lm\tdF\tF:v\t9:\vdF^BY:gB\127:\021d\127S\v\t6:.\016\127<:D\t\127!BS\v\t:dS\v:d\vF:w^FF:^1gB!S\vB\t<<\tmF6"),
      Media = _Ov7u
    }
  }, function(action)
    _moHnh.Active = true
    _fCHc.Active = false
    _a3mQ.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _moHnh:OnEnter()
  _Bg5HC = _czTN("\017c\016\031F\v")
  _a3mQ.Active = false
  Wherigo.PlayAudio(_ny2q)
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("=S\v:\ad!<:+:\031^\t<<\t:dS\v:D\016\127\vdF:1m\016!!:FdS\v<:!\016:Dd\tm:9\t9\t!!\tF+\030>zC"),
      Media = _X0U
    },
    {
      Text = _czTN("666)BF:\v^<:\t\127:cdS\v:\t\127ad!S\v<+"),
      Media = _Z642P
    },
    {
      Text = _czTN("\031dmY\t\t\t\t+:\a\tdF\t:\005dF9\t\127\195\1881BF9\tF:1\tdc:)^\t\vlB\127!:\v\tmY\tF:cd\127:\vd\t\127:}\t<g<:m\tdw\t\127:^BS\v:FdS\v<:a\td<\t\127666\030>zC"),
      Media = _tHlY
    },
    {
      Text = _czTN("vd\127:l\016cc\t:dS\v:^B!:w\t\127:[d<B^<d\016F:FB\127:\v\t\127^B!(((:US\v:\v^1\t:\tdF\t:Uw\t\t6666v\tFF:dS\v:cdS\v:\vd\t\127:1\tY\127\td\tF:l^FF6666:\a\tdF:\005\127\tBFw:w\t\127\030>zC|Y^\127\127\t\127:\v^<:D\016\127F\t:^c:ydF9^F9:gB\127:\021d\127S\v\t:!\tdF:\a\016<\016\127\127^w:!<\t\v\tF:+"),
      Media = _IE3
    },
    {
      Text = _czTN("\ad<:w\tc:\a\016<\016\127\127^w:w\t!:|Y^\127\127\t\127!:a^\t\127\t:dS\v:!S\vF\tmm:a\t9666"),
      Media = _l9s9n
    },
    {
      Text = _czTN("\031^+:\a\tdF:mdFl\t\127:\031^l\tF:\v^<:9\t!\t!!\tF6:\fmY\016F!\016:d!<:\t\127!<:\tdFc^m:^B!9\tlF\016Sl<:BFw:dS\v:Ymd<g\t:!S\vF\tmm:F^S\v:D\016\127F\t:gBc:\021d\127S\v\tF#^\127l#m^<g6666"),
      Media = _7ha1v
    }
  }, function(action)
    _FykoK.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _e0M.Active = false
    Wherigo.Command("StopSound")
  end)
end
function _FykoK:OnEnter()
  _Bg5HC = _czTN("\017\005Gl\016\021")
  _moHnh.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("\fS\v:w^:!<\t\v<:}^:w^!:\a\016<\016\127666666:v^^^!:d!<:w^^^!(+"),
      Media = _my2
    },
    {
      Text = _czTN(".^!:d!<:}^:\tdF\t:1\t!!\t\127\t:$\t\v\vdmY\t+"),
      Media = _Zau
    },
    {
      Text = _czTN("hFw:w^cd<:admm:dS\v:YmB\tS\v<\tF(\030>zC.^:cB!!:dS\v:cdS\v:}\t<g<:^1\t\127:\127^F\v^m<\tF+"),
      Media = _JXnCO
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _VZM9n.Visible = true
    _clqD:RequestSync()
  end)
end
function _iiera:OnEnter()
  _Bg5HC = _czTN("\017dd\t\127^")
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("y!:!d\t\v<:!\016:^B!x:^m!:a^\t\127\t:w^!:$\tm^\tFw\t:BF1\ta^S\v<666"),
      Media = _R05nI
    },
    {
      Text = _czTN("\031d\t\127:1\tYdFw\t<:!dS\v:^m!\016:w\t\127:\adl\127\016S\vd#6"),
      Media = _Msd
    },
    {
      Text = _czTN(".\016\127<:d!<:\tdF:\b\016S\v:dc:,^BF6:.^:!S\vmB\t#Y\t:dS\v:wB\127S\v6:)B\127:^BY#^!!\tFx:w^cd<:dS\v:FdS\v<:\v^\tF9\tF:1m\td1\t6666.\016\127<:dF:w\tc:3\016F<^dF\t\127:!\016mm:!dS\v:w\t\127:'\127\t!\016\127:1\tYdFw\tF6666"),
      Media = _d5_
    },
    {
      Text = _czTN("\031d\t\127:d!<:\t\127:}^+:$\t!dS\v\t\127<:cd<:\tdF\tc:cd\t!\tFx:Yd\t!\tFx:\tm\tl<\127\016Fd!S\v\tF:\005\127^9\tFm\016\t!\t!S\vm\016!!666666:)^:w^FF:Y^F9\t:dS\v:c^m:^F6666"),
      Media = _Jiq7u
    }
  }, function(action)
    _xW3WV.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _9UEC:MoveTo(Player)
    _FykoK.Active = false
  end)
end
function _KFu:OnEnter()
  _Bg5HC = _czTN("\017\021\005B")
  Wherigo.PlayAudio(_xTL7U)
  _Urwigo.MessageBox({
    Text = _czTN(".B:\v^!<:\t!:1\tdF^\v\t:9\t!S\v^YY<6:\014\t<g<:cB!!<:wB:F\016S\v:w\tF:3\vd#:dc:$\t\v\tdcD\t\127!<\tSl:^1m\t9\tF6:\005^mm!:wB:\tdF\t:F\tB\t:Uw\tF<d<^\t<:1\tF\016\t<d9!<x:w^FF:YdFw\t!<:wB:w\016\127<:^BS\v:wd\t:\t\127Y\016\127w\t\127mdS\v\tF:hF<\t\127m^9\tF6:.B:l^FF!<:w\016\127<:w\t\127:=\1279^Fd!^<d\016F:^BS\v:\tdF\t:D\t\127!S\vmB\t!!\tm<\t:)^S\v\127dS\v<:\vdF<\t\127m^!!\tF6\030>zC\030>zC6666:.\t\127:hFm\016SlS\016w\t:ad\127w:FBF:dF:w\tdF\tc:UFD\tF<^\127:^19\tm\t9<:BFw:wd\t:3^\127<\127dw9\t:d!<:wB\127S\v9\t!#d\tm<6\030>zC\030>zC\020d\tm:$mB\tSl:1\td:w\tdF\tF:a\td<\t\127\tF:\ad!!d\016F\tFx:w^!:\f!ld*'\t^c\030>zC:"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _jjxJQ.Visible = true
  _jjxJQ:MoveTo(Player)
  _clqD.Complete = true
  _wsRK = ((_czTN(".\t\127:hFm\016SlS\016w\t:w\t\127:FB\127:YB\t\127:w\tF:[#d\tm\t\127:") .. Player.Name) .. _czTN(":9B\tm<d9:d!<x:m^B<\t<:V\030>zC")) .. string.sub(Player.CompletionCode, 1, 15)
  _jjxJQ.Description = _wsRK
  _iiera.Active = false
  _clqD:RequestSync()
end
function _AFXND:OnSetActive()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _edD:OnSetActive()
  _WKlqK.Visible = true
end
function _jPp:OnSetActive()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_3D5pU)
  end)
end
function _WKlqK:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _lj9.Visible = false
    _lj9:MoveTo(nil)
    _WlWcy.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _czTN(")^:w^FF:w\tFl\t:c^m:!S\v^\127Y:F^S\vx:a^!:w\t\127:3\v\tY:gB:wd\127:9\t!^9<:\v^<+"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _mHQ:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 4707 then
    _rLW.Visible = false
    Wherigo.PlayAudio(_H5l)
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("\f\vx:w^:l\016cc<:}^:w^!:$\tmw6:US\v:!<\tSl\t:\t!:c^m:!S\vF\tmm:\tdF6"),
        Media = _sog
      },
      {
        Text = _czTN("\adS\v:dF<\t\127\t!!d\t\127\tF:wd\t:)\tBd9l\td<\tF:dF:w\t\127:[<^w<6:US\v:a\t\127w\t:c^m:!S\v^B\tFx:a\016:dS\v:\tdF\t:'^9\t!g\td<BF9:l^BY\tF:l^FF6\030>zC"),
        Media = _kIvIh
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _KZsU:MoveTo(Player)
      _OOT = true
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN("US\v:1dF:a\016\vm:FdS\v<:w\t\127:ydFgd9\tx:w\t\127:dcc\t\127:[S\vad\t\127d9l\td<\tF:\v^<\030>zC!dS\v:w\tF:gB:c\t\127l\tF+:\030>zC"),
      Media = _kfff
    })
  end
end
function _4vry7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 28734 then
    _HCh = true
    _VZM9n:MoveTo(nil)
    Wherigo.PlayAudio(_qaA)
    _Urwigo.Dialog(false, {
      {
        Text = _czTN(")BF:^1\t\127:\vB\127<d9x:1\tD\016\127:\fmY\016F!\016:ad\tw\t\127:gB:!dS\v:l\016cc<:BFw:!d\t\v<:dF:a\tmS\v\t:zdS\v<BF9:dS\v:Y^\v\127\t6:"),
        Media = _RCQ
      },
      {
        Text = _czTN("\014\t<g<:Y^\v\127\t:dS\v:!S\vF\tmm:gBc:\020\t\127!<\tSl:w\t!:\adl\127\016S\vd#!:BFw:D\t\127!BS\v\t:d\vF:dF:[dS\v\t\127\v\td<:gB:1\127dF9\tFx:1\tD\016\127:!d\t:cdS\v:\tF<w\tSl\tF6666666"),
        Media = _8QAb
      }
    }, function(action)
      _iiera.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN(")BF:B\t1\t\127m\t9\t:w\016S\v:F\016S\v:\tdFc^m+:.d\127:1m\td1<:FdS\v<:Dd\tm:,\td<x:!\016F!<:\t\127ad!S\v<:wdS\v:\fmY\016F!\016+"),
      Media = _f9xg2,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _S3T:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 7484 then
    _cXx5H.Complete = true
    _xW3WV:MoveTo(nil)
    _kKSi.Active = true
    _AfC.Visible = true
    _Urwigo.MessageBox({
      Text = _czTN("y!:9\t\v<:D\016\127^F6:v\tFF:dS\v:!\016:a\td<\t\127c^S\v\tx:w^FF:\v^1\t:dS\v:9m\tdS\v:w\tF:\adl\127\016S\vd#:dF:w\tF:\031^\tFw\tF+\030>zC:"),
      Media = _z4Tq3,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _czTN("[\016:l\016cc\t:dS\v:FdS\v<:a\td<\t\1276:>\t!<dcc<:\t\127ad!S\v<:cdS\v:\fmY\016F!\016:9m\tdS\v:ad\tw\t\127+\030>zC\030>zC"),
      Media = _oOD
    })
  end
end
function _tK_:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 25212 then
    _kKSi.Complete = true
    _AfC:MoveTo(nil)
    __Qg.Active = true
    _LjyT.Visible = true
    _Urwigo.MessageBox({
      Text = _czTN("US\v:1dF:9B<6666F^}^6666Bc!\016F!<:\v^<:cdS\v:w\t\127:3\v\tY:}^:FdS\v<:YB\t\127:wd\t!\t:\fBY9^1\t:^B!9\ta^\t\vm<:+\030>zC"),
      Media = _z4Tq3,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _czTN(".d\t:\fF<a\016\127<:d!<:D\t\127l\t\v\127<6:US\v:cB!!:cdS\v:1\t!!\t\127:l\016Fg\tF<\127d\t\127\tF6666"),
      Media = _JXnCO
    })
  end
end
function _RR9:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 39060 then
    __Qg.Complete = true
    _LjyT:MoveTo(nil)
    Wherigo.PlayAudio(_omWB)
    _Urwigo.MessageBox({
      Text = _czTN("US\v:1dF:\tdF:$\tFd\t6:.\t\127:'\127\t!\016\127:d!<:FBF:\016YY\tF6:\014\t<g<:F\t\vc\t:dS\v:w\tF:3\vd#:BFw:1\127dF9\t:d\vF:gB:BF!\t\127\tc:$\t\v\tdcD\t\127!<\tSl+"),
      Media = _kIvIh
    })
    _KFu.Active = true
  else
    _Urwigo.MessageBox({
      Text = _czTN(".^!:9d1<:\t!:w\016S\v:FdS\v<:+:[\016:cd\t!:l^FF:dS\v:w\016S\v:9^\127:FdS\v<:!\tdF:+"),
      Media = _c2E
    })
  end
end
function _3D5pU:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 46091 then
    _jPp.Complete = true
    _WlWcy:MoveTo(nil)
    _Urwigo.Dialog(false, {
      {
        Text = _czTN(")^:w^!:9\t\v<:w\016S\v+:[d\t:d!<:FBF:\016YY\tF6:v^!:!<\t\v<:w\tFF:w^("),
        Media = _kIvIh
      },
      {
        Text = _czTN("\f\v^6666wd\t:d<^md\tFd!S\v\t:\a^Yd^:m^9\t\127<:w\tF:\adl\127\016S\vd#:dF:w\tc:'\127\t!\016\127:^F:w\tc:\vd\t\127:1\t!S\v\127d\t1\tF\tF:=\127<666666.^!:m\t!\t:dS\v:cd\127:c^m:9\tF^B\t\127:wB\127S\v6:"),
        Media = _Msd
      },
      {
        Text = _czTN("hBB#!x:cdS\v:7B^\tm<:w\016S\v:!S\v\016F:ad\tw\t\127:\tdF:\031B\tF9\t\127S\v\tF6:.^:w\127B\t1\tF:!S\v\127^\t9:B\t1\t\127:wd\t:[<\127^!!\t:d!<:\tdF:d<^md\tFd!S\v\t!:z\t!<^B\127^F<:6:US\v:9\t\v\t:}\t<g<:\t\127!<:\tdFc^m:\t<a^!:\t!!\tF:BFw:w^FF:l^FF:dS\v:w^1\td:wd\t\030>zC:\fl<\t:m\t!\tF6:"),
        Media = _VUJdZ
      }
    }, function(action)
      _ud5Pj:MoveTo(nil)
      _e0M.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN(".B:!\016mm<\t!<:ad\tw\t\127:\127\t9\tmc^\t!!d9:w\tdF:'\v^d:$dF!\tF9:F\t\vc\tF+"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _N6P:OnTick()
  if _7sJ3 < _P0Br then
    _7sJ3 = _7sJ3 + 1
    _iiftg = _P0Br - _7sJ3
    _E5pUo.Name = (_czTN("z\t!<g\td<:V") .. _iiftg) .. _czTN("!")
    _E5pUo.Description = ((((_czTN("z\t!<g\td<") .. _iiftg) .. _czTN("!")) .. _czTN("D\t\127!<\127dS\v\tF")) .. _7sJ3) .. _czTN("!")
    _N6P:Start()
  else
    _Urwigo.MessageBox({
      Text = _czTN(".^!:a^\v\127:a\016\vm:FdS\v<!:+"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _lOI08:On_ppL(target)
  if _QPnq == false then
    _QPnq = false
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("wB:c\016\tS\v<\t!<:\127\td<\tF(")
      },
      {
        Text = _czTN("v\tFF:wB:c\tdF!<666"),
        Media = _RCQ
      },
      {
        Text = _czTN(".^!:!d\t\v<:ad\127lmdS\v:^m1\t\127F:^B!+"),
        Media = _GPb
      }
    }, function(action)
      _Urwigo.MessageBox({
        Text = _czTN(".B:1\127^BS\v!<:yad9l\td<\tF:x:Bc:ad\tw\t\127:D\016c:|Y\t\127w:^1gB!<\td9\tF"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN(".^!:1\127dF9<:w\016S\v:FdS\v<!+:.B:1\127dS\v!<:wd\127:F\016S\v:!^\tc<mdS\v\t:\021F\016S\v\tF+"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          _QPnq = false
        end
      end
    })
  end
end
function _3Op1H:On_EQLex(target)
  if _Mv0V == false then
    _Mv0V = true
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("\ad<:\tdF\tc:\fB<\016:l^FF!<:wB:w\016S\v:}\tw\tF:'^9:Y^\v\127\tF+\030>zC")
      },
      {
        Text = _czTN("U!<:w^!:FdS\v<:m^F9a\tdmd9("),
        Media = _GsC
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("\a\tdF!<:wB:ad\127lmdS\v(")
      },
      {
        Text = _czTN("US\v:Y^\v\127\t:!\t\v\127:9\t\127F:cd<:w\tc:\fB<\016:+"),
        Media = _RCQ
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _UrWKi.Active = true
      _AFXND.Active = false
      _aIyrW.Active = false
      Wherigo.PlayAudio(_mPQ)
    end)
  end
end
function _eTRmG:On_aXNl(target)
  if _Lh0l == false then
    _Lh0l = true
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("[\016mS\v:\tdF:[l^<\t1\016^\127w:\v^<<\t!<:wB:c^m:dF:w\tdF\t\127:\014B9\tFw")
      },
      {
        Text = _czTN("y!:a^\t\127\t:Dd\tmm\tdS\v<:\tdF\tF:\020\t\127!BS\v:a\t\127<:(+\030>zC"),
        Media = _RCQ
      },
      {
        Text = _czTN("\fS\v:wB:c\tdF\t:$B\t<\t+:.B:1d!<:\t1\tF:l\tdF\t:P\006:c\t\v\127+"),
        Media = _j2L
      }
    }, function(action)
      _Urwigo.MessageBox({
        Text = _czTN(".\tdF\t:>\tdF\t:!S\vm\016<<\t\127F:\v\tY<d9:BFw:wB:cB!!<:wdS\v:\t\127!<:\tdFc^m:!\t<g\tF6"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN(".B:!\016mm<\t!<:wd\127:D\016\127:\tdF\tc:F\tB\tF:\020\t\127!BS\v:md\t1\t\127:\tdF\t:1\t!!\t\127\t:\021\127^Fl\tFD\t\127!dS\v\t\127BF9:!BS\v\tF+"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _ud5Pj:On_Bj7NO(target)
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("\031B\vB:Ht,:+:)^(:vd\t:a^\127:d\v\127\t:h\t1\t\127Y^\v\127<("),
      Media = _RCQ
    },
    {
      Text = _czTN("US\v:\v^<<\t:$mB\tSlx:w^!!:\t!:\v\tB<\t:\127\tS\v<:adFw!<dmm:a^\1276:US\v:a\t\127w\t:w\016S\v:dcc\t\127:!\016:!S\vF\tmm:[\t\tl\127^Fl+"),
      Media = _8ll
    },
    {
      Text = _czTN("\014^x:YB\t\127:cdS\v:!dFw:wd\t!\t:\005^\t\v\127Y^\v\127<\tF:^BS\v:FdS\v<!666"),
      Media = _VUJdZ
    },
    {
      Text = _czTN("v^!:\v^1\tF:!d\t:w\tFF:YB\t\127:cdS\v("),
      Media = _lCg3k
    },
    {
      Text = _czTN("\031d\t\1276:.d\t!\tF:\fBY<\127^96:|^!!\tF:!d\t:9B<:^BY:wd\t:hF<\t\127m^9\tF:^BY6:.^:!<\t\v<:^mm\t!:w\127dF6"),
      Media = _8ll
    },
    {
      Text = _czTN("US\v:D\t\127^1!S\vd\tw\t:cdS\v:FBF6:\a\tdF\t:\005^\t\v\127\t:Y^\t\v\127<:9m\tdS\v:ad\tw\t\127:^1:BFw:dS\v:admm:gBc:\ad<<^9:gB:\031^B!\t:!\tdF+:'!S\vB\t!!:'\016YY\tmx:1d!:1^mw:c^m:ad\tw\t\127+"),
      Media = _8ll
    },
    {
      Text = _czTN("'!S\vB\t!!:Ht,:BFw:9\127B\t!!\tF:!d\t:cd\127:w\tF:3\v\tY+:"),
      Media = _lCg3k
    },
    {
      Text = _czTN("\031cccc6:\ad!<:^1\t\127:^BS\v6:.^!:wd\t!\t:\fl<\tF:dcc\t\127:cd<:\tdF\tc:=\tYYFBF9!S\016w\t:D\t\127!\t\v\tF:a\t\127w\tF6666:US\v:\v^1\t:D\t\1279\t!!\tF:Ht,:F^S\v:w\tc:3\016w\t:gB:Y\127^9\tF6"),
      Media = _kfff
    },
    {
      Text = _czTN("\f1\t\127:ad\t:a^\127:w^!(:\031^<<\t:FdS\v<:w\t\127:3\v\tY:D\016\127\vdF:1\tdc:'\tm\tY\016F^<:\t<a^!:9\t^\tB!!\t\127<("),
      Media = _oOD
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _lj9.Visible = true
    _lj9.Commands._Brs.Enabled = true
  end)
end
function _5pYu:On_07XOg(target)
  if _OOT == true then
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("v^!:!<\t\v<:w^:^BY:w\t\127:'d<\tm!\td<\t("),
        Media = _RCQ
      },
      {
        Text = _czTN("U!<:w^!:\t<a^:\tdF:\031dFa\td!:^BY:c\tdF\tF:ydF!^<g1\tY\t\vm:\vd\t\127:dF:\021m^w\016a("),
        Media = _Sh4zX
      },
      {
        Text = _czTN("US\v:l^BY\t:wd\t:,\td<BF9:BFw:9\t\v\t:cd<:d\v\127:\127BF<\t\127:gBc:\031^Y\tF6:.\016\127<:!\t<g\t:dS\v:cdS\v:^BY:\tdF\t:>^Fl:BFw:l^FF:dF:zB\v\t:w\tF:\f\127<dl\tm:m\t!\tF6\030>zC"),
        Media = _KIlI
      }
    }, function(action)
      if _WyD3D == true then
        _8LF = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _e0M.Active = true
      else
        _Urwigo.MessageBox({
          Text = _czTN(".^:!\t\v\t:dS\v:F\016S\v:\tdF\tF:!S\v\016\tF\tF:$\t\016S\016dF6:.\tF:c\016\tS\v<\t:dS\v:cd\127:9\tF^B\t\127:1\t<\127^S\v<\tF6"),
          Media = _z4Tq3,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
      _5pYu.Visible = false
      _pR1uk:MoveTo(Player)
      _clqD:RequestSync()
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN("vd\t:admm!<:wB:\016\vF\t:$\tmw:wd\t:,\td<BF9:l^BY\tF("),
      Media = _6oY,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Rk6B:On_A3m(target)
  if _OOT == true then
    _Urwigo.Dialog(false, {
      {
        Text = _czTN(".\t\127:d!<:ad\127lmdS\v:\vB\t1!S\v"),
        Media = _8EMZq
      },
      {
        Text = _czTN("[\016:\tdF\tF:\v^<:cd\127:^BS\v:!S\v\016F:\a^m:c\tdF:\f9\tF<\tF*\021Bc#\tm:|\t<\t\127:9\tg\td9<6:.\tF:\v^<<\t:\t\127:!dS\v:YB\t\127s!:$\t\016S^S\vdF9:9\tl^BY<6"),
        Media = _JSR
      },
      {
        Text = _czTN("y\127:9\tY^\tmm<:cd\127:^BS\v:!\t\v\127:9B<:BFw:dS\v:B\t1\t\127m\t9\tx:\0161:dS\v:d\vF:l^BY\t6")
      },
      {
        Text = _czTN("US\v:l^BY\t:d\vF6:y\127:!\016mm:cdS\v:^m!:$mB\tSl!1\127dF9\t\127:1\t9m\td<\tF+:"),
        Media = _Msd
      }
    }, function(action)
      if _8LF == false then
        _WyD3D = true
        _Ru12p:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _e0M.Active = true
        _Rk6B.Visible = false
      else
        _Urwigo.MessageBox({
          Text = _czTN("US\v:a\016mm<\t:w\016S\v:\td9\tF<mdS\v:\tdF\t:,\td<BF9:l^BY\tF:+:"),
          Media = _h5T,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _czTN(".B:1\tF\016\t<d9!<:\t\127!<:\tdFc^m:$\tmw:+"),
      Media = _6oY,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _clqD:RequestSync()
end
function _rLW:On_Tqz(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_mHQ)
  end)
end
function _0Cgi:On_mVv(target)
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("\014^:\031^mm\016x:\vd\t\127:!#\127dS\v<:wd\t:!<^\tw<d!S\v\t:\f1Y^mm\tF<!\016\1279BF96:v^!:l^FF:dS\v:YB\t\127:!d\t:<BF(:vd\127:\v^1\tF:\v\tB<\t:[\016Fw\t\127\127^1^<<\t:^BY:wd\t:yF<!\016\1279BF9:BFmd\t1!^c\t\127:)^S\v1^\127F+"),
      Media = _RCQ
    },
    {
      Text = _czTN("'\016YY\tm(+:\b^!!\tF:!d\t:w\tF:>m\016\tw!dFF+:\031d\t\127:!#\127dS\v<:d\v\127:\020\016\1279\t!\t<g<\t\127+:US\v:\v^1\t:\tdF\tF:\fBY<\127^9:YB\t\127:!d\t+"),
      Media = _SlWXz
    },
    {
      Text = _czTN("=\v:3\v\tY:+:[\016:\tdF\t:\005\127\tBw\t666666v^!:9d1<:\t!:w\tFF("),
      Media = _z4Tq3
    },
    {
      Text = _czTN("\020d\tmm\tdS\v<:\v^1\tF:!d\t:1\t\127\td<!:D\016F:w\tc:BF!:9\t!<\016\vm\tF\tF:\adl\127\016S\vd#:9\t\v\016\t\127<(:"),
      Media = _SlWXz
    },
    {
      Text = _czTN("US\v:\v^1\t:\t!:!\016\t1\tF:dF:w\t\127:,\td<BF9:9\tm\t!\tF6:hF!S\v\016\tF\t:\fF9\tm\t9\tF\v\td<6666"),
      Media = _RCQ
    },
    {
      Text = _czTN("h)!S\v\016\tF:(((+:.^!:d!<:<\016<^m:Y^<^m+++:v\tFF:w\t\127:dF:wd\t:Y^m!S\v\tF:\031^\tFw\t:9\tm^F9<x:l\016\tFF\tF:^mm\t:9\t\v\tdc\016#\t\127d\t\127\tFw\tF:\f9\tF<\tF:\tF<<^\127F<:a\t\127w\tF++"),
      Media = _SlWXz
    },
    {
      Text = _czTN("[d\t:\t\127\v^m<\tF:FBF:w\tF:\fBY<\127^9:wd\t!\tF:3\vd#:gB\127B\tSlgB1\127dF9\tF6:\f9\tF<:Ht,:l\016cc<:dF:K:\adFB<\tF:cd<:w\t\127:\005^\t\v\127\t:^c:\031^Y\tF:^F:BFw:1\127dF9<:d\vF\tF:a\td<\t\127\t:UF!<\127Bl<d\016F\tF6:\a^S\v\tF:!d\t:!dS\v:^BY:w\tF:v\t9:BFw:#^!!\tF:!d\t:^BYx:w^!!:!d\t:FdS\v<:1\t\0161^S\v<\t<:a\t\127w\tF:+"),
      Media = _SlWXz
    },
    {
      Text = _czTN("\a\t\127l\tF:!d\t:!dS\v:wd\t:)Bcc\t\127:w\t\127:\005^\t\v\127\t6:.d\t:ad\127w:FB\t<gmdS\v:!\tdF+:\020d\tm:y\127Y\016m9:+"),
      Media = _SlWXz
    }
  }, function(action)
    _CZvL.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _clqD:RequestSync()
  end)
end
function _lj9:On_Brs(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_WKlqK)
  end)
end
function _MLBK:On_fuq(target)
  if _YgJX == false then
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("\031cccx:\tdF:$m^!:\admS\v:\v^<<\t:dS\v:}^:1\t\127\td<!:\tad9:FdS\v<:c\t\v\1276:.^!:d!<:!\t\v\127:l\016\t!<mdS\v6:"),
        Media = _RCQ
      },
      {
        Text = _czTN("\fB!!\t\127w\tc:!\016mm:\admS\v:}^:\127\tdS\v\v^m<d9:^F:3^mSdBc:!\tdF:BFw:w^!:l^FF:c\tdF\tF\030>zCc\016\127!S\v\tF:\021F\016S\v\tF:FdS\v<:!S\v^w\tF6:"),
        Media = _D3O
      },
      {
        Text = _czTN("U!<:w^!:\t\127Y\127d!S\v\tFw+"),
        Media = _VUJdZ
      },
      {
        Text = _czTN("\a\016c\tF<6666:a^!:d!<:w^^^^^!:+++"),
        Media = _my2
      },
      {
        Text = _czTN("\fB:a\td^+:US\v:\v^1:c\tdF\t:\b^l<\016!\tdF<\016m\t\127^Fg:D\t\1279\t!!\tF666:dS\v:Ymd<g\t:c^m:!S\vF\tmm:gBc:v36666"),
        Media = _1bqL
      },
      {
        Text = _czTN(")BF:\v^1\t:dS\v:\tdF\t:\v^m1\t:[<BFw\t:^BY:w\tc:v3:D\t\1271\127^S\v<:BFw:YB\t\vm\t:cdS\v:gB:!S\va^S\vx:Bc:wd\t:\fl<\t:wB\127S\vgB^\1271\td<\tF"),
        Media = _RCQ
      }
    }, function(action)
      _MLBK.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _YgJX = true
    end)
  else
    _Urwigo.Dialog(false, {}, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _CrPV:On_gRRv(target)
  if _rKt6_ == false then
    _Urwigo.Dialog(false, {
      {
        Text = _czTN("US\v:F\t\vc\t:\tdF:$m^!:v\tdF:+"),
        Media = _MALQ
      },
      {
        Text = _czTN("v\tFF:\t<a^!:D\016\127:\031\t\127gdFY^\127l<:!S\vB\t<g<x:w^FF:l^FF:\t!:}^:FdS\v<:!S\v^\twmdS\v:!\tdF6:hFw:!S\vmd\t!!mdS\v:md\t9<:dc:v\tdF:wd\t:v^\v\127\v\td<:BFw:F^S\v:d\v\127:1dF:dS\v:^BY:w\t\127:[BS\v\t:+\030>zC"),
        Media = _z4Tq3
      },
      {
        Text = _czTN("[\016mS\v:\tdF\tF:9B<\tF:\014^\v\1279^F9:1\tl\016cc<:c^F:!\tm<\tF6:.^:a\t\127w\t:dS\v:F\016S\v:\tdF:$m^!:D\016F:F\t\vc\tF6666"),
        Media = _MALQ
      },
      {
        Text = _czTN("US\v:<\127dFl:F\016S\v:\tdF!6:v\t\127:a\td!!x:a^FF:dS\v:ad\tw\t\127:$\tm\t9\tF\v\td<:w^gB:\v^1\t666"),
        Media = _RCQ
      },
      {
        Text = _czTN("v\td^^^66666w^!:a^\127\tF:a\016\vm:\t<a^!:Dd\tm\t:$m^\t!\t\12766666:US\v:cB!!:cdS\v:}\t<g<:\t\127!<:\tdFc^m:^B!gBFB\tS\v<\t\127Fx:w\tFF:dF:w\tc:,B!<^Fw:l^FF:dS\v:wd\t:\fl<\t:FdS\v<:wB\127S\vm\t!\tF+:"),
        Media = _Ro7lz
      }
    }, function(action)
      _rKt6_ = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _CrPV.Visible = false
    end)
  else
    _Urwigo.Dialog(false, {}, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _FO9HF:On_UFk(target)
  if (_rKt6_ and _YgJX) == true then
    _Urwigo.Dialog(false, {
      {
        Text = _czTN(".^!:<B<:9B<6:[\016:\tdF:v^!!\t\127:d!<:dcc\t\127:ad\tw\t\127:^BYs!:)\tB\t:\t\127Y\127d!S\v\tFw:BFw:\t!:D\t\127F\t1\tm<:\tdF\tc:FdS\v<:wd\t:[dFF\t6:)BF:l^FF:dS\v:cdS\v:w\t\127:\fl<\t:gBa\tFw\tF6"),
        Media = _kIvIh
      },
      {
        Text = _czTN("v^!:!<\t\v<:w\tFF:w^("),
        Media = _kVMHt
      },
      {
        Text = _czTN("\f\v^6:.d\t:\a^Yd^:\v^<:w\tF:3\vd#:dF:d\v\127\tc:9\t\v\tdc\tF:$\t\v\tdc<\127\t!\016\127:dF:w\tc:'^\127FBF<\t\127!S\vmB#Y:^BY:w\tc:$\tm^\tFw\t:w\t\127:v^!!\t\1271\t<\127d\t1\t6"),
        Media = _RCQ
      },
      {
        Text = _czTN(".^!:F\tFF<:c^F:c^m:9B<\t:\020\016\127^\1271\td<6:.^:cB!!:dS\v:FB\127:F\016S\v:w\tF:'\127\t!\016\127:\016\tYYF\tF:BFw:!S\vaB##wdaB##:\v^1\t:dS\v:w\tF:3\vd#:dF:w\tF:\031^\tFw\tF6:"),
        Media = _z4Tq3
      },
      {
        Text = _czTN("\f\v:}^666BFw:w^F^S\v:!\016mm:dS\v:d\vF:dF:BF!\t\127\tc:$\t\v\tdcD\t\127!<\tSl:^1m\t9\tF6:.\016\127<:\v\016m<:d\vF:w^FF:Ht,:F^S\v<!:^1x:Bc:d\vF:ad\tw\t\127:dF:BF!\t\127:\031^B#<7B^\127<d\t\127:gB:1\127dF9\tF6")
      },
      {
        Text = _czTN("=lx:w^!:\v\016\t\127<:!dS\v:FdS\v<:^mmgB:!S\vad\t\127d9:^F+")
      },
      {
        Text = _czTN("US\v:9\t\v\t:cd\127:FBF:c^m:w\tF:'^\127FBF<\t\127!S\vmB#Y:^F!\t\v\tF6666"),
        Media = _RCQ
      }
    }, function(action)
      _FO9HF:MoveTo(nil)
      _a3mQ.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _czTN(".^:l\016cc<:w\t\127:=1\t\1276666"),
        Media = _XYP
      },
      {
        Text = _czTN("v^!:F\t\vc\t:dS\v:w\tFF("),
        Media = _JXnCO
      },
      {
        Text = _czTN("\020d\tmm\tdS\v<:w\016S\v:\t<a^!:\fFw\t\127\t!("),
        Media = _RCQ
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _VZM9n:On_UU8(target)
  _Urwigo.Dialog(false, {
    {
      Text = _czTN("=\v:F\tdFx6666w^!!:w\t\127:|Y^\127\127\t\127:Fd\t:!\tdF\t\127:$\tc\tdFw\t:<\127^B<:BFw:dcc\t\127:\tdF:[S\vm\016!!:^F1\127dF9\tF:cB!!6666"),
      Media = _167
    },
    {
      Text = _czTN("\a\016c\tF<6666a^!:!^9<\t:\t\127:w\016S\v:9m\tdS\vx:ad\t:\t\127:!dS\v:wd\t:,^\vm\tFl\016c1dF^<d\016F:dcc\t\127:c\t\127l<("),
      Media = _kfff
    },
    {
      Text = _czTN("\fS\v666}\t<g<:Y^\tmm<:\t!:cd\127:ad\tw\t\127:\tdF+:.d\t:\031^B!FBcc\t\127:w\t!:$\tc\tdFw\t\v^B!\t!:w\t\127:\021d\127S\v\t666:\014^+:.^!:a^\127:\t!6666\030>zC"),
      Media = _VUJdZ
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_4vry7)
    end)
  end)
end
function _xW3WV:On_Qt1d(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_S3T)
  end)
end
function _AfC:On_1Pe7G(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_tK_)
  end)
end
function _LjyT:On_QSIi(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_RR9)
  end)
end
function _WlWcy:On_QhLv(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_3D5pU)
  end)
end
function _jjxJQ:OnClick()
  _Urwigo.MessageBox({
    Text = _wsRK,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _goO()
end
return _clqD
