require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _p0t(str)
  local res = ""
  local dtable = "\026xL$@o\003RAO#{kTE\\n\0045\022vK]F'G0mY.QM9X=\031\006\019?d[\"yf}&Z\023:\aCj\014u\ba\0153r\029bt\030\002ig(H7zl\000\025UB!/%\r`\016wIe\v\024\021\nc\027DV_<\028P,\001*\005> 1\020\f|\t-2W;\017qp6S4N\0188h~^sJ+)"
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
_5wacS = Wherigo.ZMedia(var_cartridge)
_5wacS.Id = "b28c0eca-fbb5-457c-8082-2abfade2f599"
_5wacS.Name = _p0t("8G>TJ\017A\021T;|A>8T>\014\006;")
_5wacS.Description = ""
_5wacS.AltText = ""
_5wacS.Resources = {
  {
    Type = "jpg",
    Filename = "AlteUniversitatTor230.jpg",
    Directives = {}
  }
}
_fvtiJ = Wherigo.ZMedia(var_cartridge)
_fvtiJ.Id = "4fe25ec6-2adf-42e3-96ff-bfd4e5b97258"
_fvtiJ.Name = _p0t("AY\006\0178G>TJ\017A\014\006;")
_fvtiJ.Description = ""
_fvtiJ.AltText = ""
_fvtiJ.Resources = {
  {
    Type = "jpg",
    Filename = "iconalteUniTor3.jpg",
    Directives = {}
  }
}
_b7O = Wherigo.ZMedia(var_cartridge)
_b7O.Id = "c93e5588-a33f-43fd-b47c-b222f5b3cc1e"
_b7O.Name = _p0t("\014AGG")
_b7O.Description = ""
_b7O.AltText = ""
_b7O.Resources = {
  {
    Type = "jpg",
    Filename = "Till230.jpg",
    Directives = {}
  }
}
_bFQA = Wherigo.ZMedia(var_cartridge)
_bFQA.Id = "24d9e99e-e08d-4564-90ff-d6f14ee9f9fd"
_bFQA.Name = _p0t("8G>TJ\017A")
_bFQA.Description = ""
_bFQA.AltText = ""
_bFQA.Resources = {
  {
    Type = "jpg",
    Filename = "alteUni.jpg",
    Directives = {}
  }
}
_DAep9 = Wherigo.ZMedia(var_cartridge)
_DAep9.Id = "976d93c6-3b08-4675-9dee-e03374fee4b1"
_DAep9.Name = _p0t("AY\006\0178G>TJ\017A")
_DAep9.Description = ""
_DAep9.AltText = ""
_DAep9.Resources = {
  {
    Type = "jpg",
    Filename = "iconalteUni1.jpg",
    Directives = {}
  }
}
_QNc = Wherigo.ZMedia(var_cartridge)
_QNc.Id = "48d5f0cd-8ada-4f45-b4a8-01c48a5f97fc"
_QNc.Name = _p0t("/T>>TG")
_QNc.Description = ""
_QNc.AltText = ""
_QNc.Resources = {
  {
    Type = "jpg",
    Filename = "Schriftrolle230.jpg",
    Directives = {}
  }
}
_IiD = Wherigo.ZMedia(var_cartridge)
_IiD.Id = "a88e4fb8-1199-4ceb-a4a7-67031ed89a68"
_IiD.Name = _p0t("AY\006\017\014AGG")
_IiD.Description = ""
_IiD.AltText = ""
_IiD.Resources = {
  {
    Type = "jpg",
    Filename = "iconTill1.jpg",
    Directives = {}
  }
}
_gPKAR = Wherigo.ZMedia(var_cartridge)
_gPKAR.Id = "db4b458d-a1b2-4b2c-a5fc-9de555a42283"
_gPKAR.Name = _p0t("AY\006\017/T>>TG")
_gPKAR.Description = ""
_gPKAR.AltText = ""
_gPKAR.Resources = {
  {
    Type = "jpg",
    Filename = "iconaltesPapierus2.jpg",
    Directives = {}
  }
}
_GV85L = Wherigo.ZMedia(var_cartridge)
_GV85L.Id = "551224dc-43cf-4dd6-a227-5033c549a168"
_GV85L.Name = _p0t("KT\017T(A\r>|rG8>F")
_GV85L.Description = ""
_GV85L.AltText = ""
_GV85L.Resources = {
  {
    Type = "jpg",
    Filename = "Benediktsplatz.jpg",
    Directives = {}
  }
}
_eZMjU = Wherigo.ZMedia(var_cartridge)
_eZMjU.Id = "7b3d9c6c-a98a-467a-9feb-92ef23c97828"
_eZMjU.Name = _p0t("AY\006\017KT\017T(A\r>|rG8>F")
_eZMjU.Description = ""
_eZMjU.AltText = ""
_eZMjU.Resources = {
  {
    Type = "jpg",
    Filename = "iconBenediktsplatz.jpg",
    Directives = {}
  }
}
_55A = Wherigo.ZMedia(var_cartridge)
_55A.Id = "b5aa8372-4fdc-4428-8255-11cd503185f3"
_55A.Name = _p0t(" T>FBT;")
_55A.Description = ""
_55A.AltText = ""
_55A.Resources = {
  {
    Type = "jpg",
    Filename = "Metzger230.jpg",
    Directives = {}
  }
}
_8XUQA = Wherigo.ZMedia(var_cartridge)
_8XUQA.Id = "16abd193-60fb-45b2-b9cc-99ba558ec037"
_8XUQA.Name = _p0t("AY\006\017 T>FBT;")
_8XUQA.Description = ""
_8XUQA.AltText = ""
_8XUQA.Resources = {
  {
    Type = "jpg",
    Filename = "iconMetzger.jpg",
    Directives = {}
  }
}
_r_bbI = Wherigo.ZMedia(var_cartridge)
_r_bbI.Id = "70ceb24a-7292-4781-a91d-838e68360b3d"
_r_bbI.Name = _p0t("K;8>T\017")
_r_bbI.Description = ""
_r_bbI.AltText = ""
_r_bbI.Resources = {
  {
    Type = "jpg",
    Filename = "braten1.jpg",
    Directives = {}
  }
}
_H9Bf0 = Wherigo.ZMedia(var_cartridge)
_H9Bf0.Id = "67d2b7df-17cc-491a-a0f0-27f5db0356e8"
_H9Bf0.Name = _p0t("AY\006\017K;8>T\017")
_H9Bf0.Description = ""
_H9Bf0.AltText = ""
_H9Bf0.Resources = {
  {
    Type = "jpg",
    Filename = "braten32.jpg",
    Directives = {}
  }
}
_ASDk = Wherigo.ZMedia(var_cartridge)
_ASDk.Id = "7f4938f4-4aae-46e0-a656-a8381a1a8a2b"
_ASDk.Name = _p0t("AY\006\017\bT\r>\006;")
_ASDk.Description = ""
_ASDk.AltText = ""
_ASDk.Resources = {
  {
    Type = "jpg",
    Filename = "iconProfessor.jpg",
    Directives = {}
  }
}
_bo2a = Wherigo.ZMedia(var_cartridge)
_bo2a.Id = "ab9486c2-fb18-44f0-be66-f865a3956147"
_bo2a.Name = _p0t("\bT\r>\006;")
_bo2a.Description = ""
_bo2a.AltText = ""
_bo2a.Resources = {
  {
    Type = "jpg",
    Filename = "Rektor230.jpg",
    Directives = {}
  }
}
_AqpJK = Wherigo.ZMedia(var_cartridge)
_AqpJK.Id = "c935e473-c92b-450c-b70d-7b989781ade4"
_AqpJK.Name = _p0t("\015|TG")
_AqpJK.Description = ""
_AqpJK.AltText = ""
_AqpJK.Resources = {
  {
    Type = "jpg",
    Filename = "Esel.jpg",
    Directives = {}
  }
}
_TYQ = Wherigo.ZMedia(var_cartridge)
_TYQ.Id = "1abaa0a2-7c9c-427e-95a6-4142c0f2e493"
_TYQ.Name = _p0t("AY\006\017\015|TG")
_TYQ.Description = ""
_TYQ.AltText = ""
_TYQ.Resources = {
  {
    Type = "jpg",
    Filename = "iconEsel.jpg",
    Directives = {}
  }
}
_zXE = Wherigo.ZMedia(var_cartridge)
_zXE.Id = "76e74d34-2b95-4eb0-9da0-a09774781bef"
_zXE.Name = _p0t("\0246>>T;\r;ArrT")
_zXE.Description = ""
_zXE.AltText = ""
_zXE.Resources = {
  {
    Type = "jpg",
    Filename = "Futterkrippe.jpg",
    Directives = {}
  }
}
_4Jyjr = Wherigo.ZMedia(var_cartridge)
_4Jyjr.Id = "1da0a8ff-d7be-458a-976a-12f948a4bd16"
_4Jyjr.Name = _p0t("AY\006\017\0246>>T;\r;ArrT")
_4Jyjr.Description = ""
_4Jyjr.AltText = ""
_4Jyjr.Resources = {
  {
    Type = "jpg",
    Filename = "iconFutterkrippe.jpg",
    Directives = {}
  }
}
_SOtt = Wherigo.ZMedia(var_cartridge)
_SOtt.Id = "e5424873-80b8-4681-95ce-2dbc661b49a6"
_SOtt.Name = _p0t("D8,T;")
_SOtt.Description = ""
_SOtt.AltText = ""
_SOtt.Resources = {
  {
    Type = "jpg",
    Filename = "Hafer_Korn.jpg",
    Directives = {}
  }
}
_SDWh = Wherigo.ZMedia(var_cartridge)
_SDWh.Id = "174d9494-bec7-4b5a-ac24-5906435c8333"
_SDWh.Name = _p0t("AY\006\017D8,T;")
_SDWh.Description = ""
_SDWh.AltText = ""
_SDWh.Resources = {
  {
    Type = "jpg",
    Filename = "iconHafer_Korn.jpg",
    Directives = {}
  }
}
_CJTyK = Wherigo.ZMedia(var_cartridge)
_CJTyK.Id = "1641dc9e-74fb-4e44-a053-7434b52c8063"
_CJTyK.Name = _p0t("t>8GG")
_CJTyK.Description = ""
_CJTyK.AltText = ""
_CJTyK.Resources = {
  {
    Type = "jpg",
    Filename = "Esel-Holzschnitt230.jpg",
    Directives = {}
  }
}
_X_wxp = Wherigo.ZMedia(var_cartridge)
_X_wxp.Id = "1d466125-1ab2-4657-880f-875d88e54950"
_X_wxp.Name = _p0t("AY\006\017t>8GG")
_X_wxp.Description = ""
_X_wxp.AltText = ""
_X_wxp.Resources = {
  {
    Type = "jpg",
    Filename = "iconEeeeeesel-Holzschnitt.jpg",
    Directives = {}
  }
}
_A9lO = Wherigo.ZMedia(var_cartridge)
_A9lO.Id = "5ddffca0-fcb3-42ae-9ef5-a0ec934851d8"
_A9lO.Name = _p0t("\024GTA|Yy=8\017\r")
_A9lO.Description = ""
_A9lO.AltText = ""
_A9lO.Resources = {
  {
    Type = "jpg",
    Filename = "Fleischbank230.jpg",
    Directives = {}
  }
}
_Gsg = Wherigo.ZMedia(var_cartridge)
_Gsg.Id = "a916e384-b71e-4ab2-9f60-02c351b273d7"
_Gsg.Name = _p0t("AY\006\017\024GTA|Yy=8\017\r")
_Gsg.Description = ""
_Gsg.AltText = ""
_Gsg.Resources = {
  {
    Type = "jpg",
    Filename = "iconFleischbank.jpg",
    Directives = {}
  }
}
_fJvl = Wherigo.ZMedia(var_cartridge)
_fJvl.Id = "dbd46667-0c18-490e-b99d-7e24d7978d65"
_fJvl.Name = _p0t("`|8G>T;")
_fJvl.Description = ""
_fJvl.AltText = ""
_fJvl.Resources = {
  {
    Type = "jpg",
    Filename = "psalter230.jpg",
    Directives = {}
  }
}
_87f3R = Wherigo.ZMedia(var_cartridge)
_87f3R.Id = "b02f2eff-7a72-4105-8eea-32c58e72cd15"
_87f3R.Name = _p0t("AY\006\017`|8G>T;")
_87f3R.Description = ""
_87f3R.AltText = ""
_87f3R.Resources = {
  {
    Type = "jpg",
    Filename = "iconpsalter.jpg",
    Directives = {}
  }
}
_Q9K2e = Wherigo.ZMedia(var_cartridge)
_Q9K2e.Id = "a9a5565f-0445-40da-a2a8-b9aeb29edf33"
_Q9K2e.Name = _p0t("\b\006>T;\0146;\028")
_Q9K2e.Description = ""
_Q9K2e.AltText = ""
_Q9K2e.Resources = {
  {
    Type = "jpg",
    Filename = "RoterTurm230.jpg",
    Directives = {}
  }
}
_yhX = Wherigo.ZMedia(var_cartridge)
_yhX.Id = "2b65074d-3ed9-4697-a4ce-e2cd83798838"
_yhX.Name = _p0t("AY\006\017\b\006>T;\0146;\028")
_yhX.Description = ""
_yhX.AltText = ""
_yhX.Resources = {
  {
    Type = "jpg",
    Filename = "iconRoterTurmk.jpg",
    Directives = {}
  }
}
_Y6Ad = Wherigo.ZMedia(var_cartridge)
_Y6Ad.Id = "f2deba89-dddf-4034-bde5-c67849613f0a"
_Y6Ad.Name = _p0t("\014AGGB8\017F")
_Y6Ad.Description = ""
_Y6Ad.AltText = ""
_Y6Ad.Resources = {
  {
    Type = "jpg",
    Filename = "Eulenspiegel.jpg",
    Directives = {}
  }
}
_wi1 = Wherigo.ZMedia(var_cartridge)
_wi1.Id = "9b12f9fe-ab78-44e0-809e-c4d3e6f277d7"
_wi1.Name = _p0t(" T>FBT;B8\017F")
_wi1.Description = ""
_wi1.AltText = ""
_wi1.Resources = {
  {
    Type = "jpg",
    Filename = "Metzgerganz230.jpg",
    Directives = {}
  }
}
_9Dbe = Wherigo.ZMedia(var_cartridge)
_9Dbe.Id = "c9c35cfa-e988-422a-a005-3436358488d2"
_9Dbe.Name = _p0t("\bT\r>\006;B8\017F")
_9Dbe.Description = ""
_9Dbe.AltText = ""
_9Dbe.Resources = {
  {
    Type = "jpg",
    Filename = "Rektorganz2.jpg",
    Directives = {}
  }
}
__xnY = Wherigo.ZMedia(var_cartridge)
__xnY.Id = "f4c2318d-cf9a-4b80-b6d8-c394526542b8"
__xnY.Name = _p0t("/T>>TGF6|8\028\028T\017")
__xnY.Description = ""
__xnY.AltText = ""
__xnY.Resources = {
  {
    Type = "jpg",
    Filename = "Schriftrollezusammen230.jpg",
    Directives = {}
  }
}
_25EQs = Wherigo.ZMedia(var_cartridge)
_25EQs.Id = "6abf5714-2f23-4631-baf7-4aad88d47b70"
_25EQs.Name = _p0t("AY\006\017/T>>TGF6|8\028\028T\017")
_25EQs.Description = ""
_25EQs.AltText = ""
_25EQs.Resources = {
  {
    Type = "jpg",
    Filename = "iconSchriftrollezusammen.jpg",
    Directives = {}
  }
}
_CyuJj = Wherigo.ZMedia(var_cartridge)
_CyuJj.Id = "90ed1cef-c5b4-4505-a612-92cc7f8f9ef4"
_CyuJj.Name = _p0t("\0148,TG\017T=T\017(T\028\014\006;")
_CyuJj.Description = ""
_CyuJj.AltText = ""
_CyuJj.Resources = {
  {
    Type = "jpg",
    Filename = "TafelnebendemTor230.jpg",
    Directives = {}
  }
}
_ltp = Wherigo.ZMedia(var_cartridge)
_ltp.Id = "d47476a0-862d-4255-a0c7-3f2476878d45"
_ltp.Name = _p0t("/\006\017\r")
_ltp.Description = ""
_ltp.AltText = ""
_ltp.Resources = {
  {
    Type = "jpg",
    Filename = "Zopf230_2.jpg",
    Directives = {}
  }
}
_P7i = Wherigo.ZMedia(var_cartridge)
_P7i.Id = "bfa8156e-dc30-41a4-8faf-c59421202a7f"
_P7i.Name = _p0t("AY\006\017\tG>TJ\017A\014\006;")
_P7i.Description = ""
_P7i.AltText = ""
_P7i.Resources = {
  {
    Type = "jpg",
    Filename = "iconAlteUniTor4.jpg",
    Directives = {}
  }
}
_LXqy = Wherigo.ZMedia(var_cartridge)
_LXqy.Id = "25108157-f136-4100-9989-95d384199788"
_LXqy.Name = _p0t("\tG>TJ\017A\014\006;")
_LXqy.Description = ""
_LXqy.AltText = ""
_LXqy.Resources = {
  {
    Type = "jpg",
    Filename = "AlteUniTor230.jpg",
    Directives = {}
  },
  {
    Type = "jpg",
    Filename = "AlteUniTor230_1.jpg",
    Directives = {}
  }
}
_DO4n2 = Wherigo.ZMedia(var_cartridge)
_DO4n2.Id = "c242ab48-3a9f-4641-a42f-7e576592fed7"
_DO4n2.Name = _p0t("\014\006;\006=T\017")
_DO4n2.Description = ""
_DO4n2.AltText = ""
_DO4n2.Resources = {
  {
    Type = "jpg",
    Filename = "Toroben.jpg",
    Directives = {}
  }
}
_4Ks7F = Wherigo.ZMedia(var_cartridge)
_4Ks7F.Id = "aecf5c29-2e16-4410-ac5e-18f853d15c0a"
_4Ks7F.Name = _p0t("\024T6T;")
_4Ks7F.Description = ""
_4Ks7F.AltText = ""
_4Ks7F.Resources = {
  {
    Type = "jpg",
    Filename = "Feuer230.jpg",
    Directives = {}
  }
}
_phe = Wherigo.ZMedia(var_cartridge)
_phe.Id = "a37c113a-2308-4bc5-9e9b-2eafdd8e3910"
_phe.Name = _p0t("KT|T\017")
_phe.Description = ""
_phe.AltText = ""
_phe.Resources = {
  {
    Type = "jpg",
    Filename = "Besen.jpg",
    Directives = {}
  }
}
_9Zqu1 = Wherigo.ZMedia(var_cartridge)
_9Zqu1.Id = "89fb9084-b02b-49c3-8b7e-dd9cc2f43ab8"
_9Zqu1.Name = _p0t("/\006r,")
_9Zqu1.Description = ""
_9Zqu1.AltText = ""
_9Zqu1.Resources = {
  {
    Type = "jpg",
    Filename = "Zopf230_1.jpg",
    Directives = {}
  }
}
_SZe = Wherigo.ZMedia(var_cartridge)
_SZe.Id = "81d55a16-ed39-414d-b6a7-82166f55cece"
_SZe.Name = _p0t("\014\006;|r;8+")
_SZe.Description = ""
_SZe.AltText = ""
_SZe.Resources = {
  {
    Type = "jpg",
    Filename = "Torspay230.jpg",
    Directives = {}
  }
}
_Bero = Wherigo.ZMedia(var_cartridge)
_Bero.Id = "0557f253-6f82-4cb6-b10c-62c2fdc0f229"
_Bero.Name = _p0t("/T>>TGFT;A||T\017")
_Bero.Description = ""
_Bero.AltText = ""
_Bero.Resources = {
  {
    Type = "jpg",
    Filename = "Zettelzerrissen230.jpg",
    Directives = {}
  }
}
_Of8 = Wherigo.ZMedia(var_cartridge)
_Of8.Id = "20401aeb-e6f2-4d8c-a996-fe116241e268"
_Of8.Name = _p0t("/T>>TG8\017\014\006;")
_Of8.Description = ""
_Of8.AltText = ""
_Of8.Resources = {
  {
    Type = "jpg",
    Filename = "ZettelanTor230.jpg",
    Directives = {}
  }
}
_vKlD3 = Wherigo.ZMedia(var_cartridge)
_vKlD3.Id = "0d9566fd-db24-4dc1-8b68-50b61a37da7d"
_vKlD3.Name = _p0t("\015|TGGATB>")
_vKlD3.Description = ""
_vKlD3.AltText = ""
_vKlD3.Resources = {
  {
    Type = "jpg",
    Filename = "Eselliegt230.jpg",
    Directives = {}
  }
}
_I5y = Wherigo.ZMedia(var_cartridge)
_I5y.Id = "9246c5d5-6eba-4baa-bc2f-ae83b9255eae"
_I5y.Name = _p0t("\0246>>T;\r;ArrTBT\rArr>")
_I5y.Description = ""
_I5y.AltText = ""
_I5y.Resources = {
  {
    Type = "jpg",
    Filename = "Futterkrippegekippt230.jpg",
    Directives = {}
  }
}
_0AZdW = Wherigo.ZMedia(var_cartridge)
_0AZdW.Id = "ff5b19c4-4d1d-4922-a254-28250442a902"
_0AZdW.Name = _p0t("\015|TG,6>>T;\017")
_0AZdW.Description = ""
_0AZdW.AltText = ""
_0AZdW.Resources = {
  {
    Type = "jpg",
    Filename = "eselfuttern230.jpg",
    Directives = {}
  }
}
_0_d6 = Wherigo.ZMedia(var_cartridge)
_0_d6.Id = "818a75bb-a3f2-4088-bad2-7f30a9e11ff2"
_0_d6.Name = _p0t("\015|TG\021\006\017yA\017>T\017")
_0_d6.Description = ""
_0_d6.AltText = ""
_0_d6.Resources = {
  {
    Type = "jpg",
    Filename = "Eselhinten230.jpg",
    Directives = {}
  }
}
_7ej = Wherigo.ZMedia(var_cartridge)
_7ej.Id = "fefcd04f-d01c-4a52-b979-dd98d73e8e08"
_7ej.Name = _p0t("\015|TG\021\006\017yA\017>T\017\017TA\017")
_7ej.Description = ""
_7ej.AltText = ""
_7ej.Resources = {
  {
    Type = "jpg",
    Filename = "Eselhintennein230.jpg",
    Directives = {}
  }
}
_qYte = Wherigo.ZMedia(var_cartridge)
_qYte.Id = "5260497e-10d4-48bc-ba6f-4eab878055df"
_qYte.Name = _p0t("3\006(TF6\028J\017G\006Y\rT\017")
_qYte.Description = ""
_qYte.AltText = ""
_qYte.Resources = {
  {
    Type = "jpg",
    Filename = "CodezumUnlocken230.jpg",
    Directives = {}
  }
}
_3ntrU = Wherigo.ZMedia(var_cartridge)
_3ntrU.Id = "f866274e-882c-4ef0-9211-35e202b7ae63"
_3ntrU.Name = _p0t("\0148,TG8\017K;6TY\rT")
_3ntrU.Description = ""
_3ntrU.AltText = ""
_3ntrU.Resources = {
  {
    Type = "jpg",
    Filename = "TafelanBruecke230.jpg",
    Directives = {}
  }
}
_Xvy = Wherigo.ZMedia(var_cartridge)
_Xvy.Id = "642c26b0-ae47-495e-bbd6-e6042eb542d3"
_Xvy.Name = _p0t("\022;8T\028T;=;6TY\rT")
_Xvy.Description = ""
_Xvy.AltText = ""
_Xvy.Resources = {
  {
    Type = "jpg",
    Filename = "Kraemerbruecke230.jpg",
    Directives = {}
  }
}
_syu = Wherigo.ZMedia(var_cartridge)
_syu.Id = "9591c0da-6d68-4772-bca7-fee20b0f6479"
_syu.Name = _p0t("\t;\028T\017=6;|T")
_syu.Description = ""
_syu.AltText = ""
_syu.Resources = {
  {
    Type = "JPG",
    Filename = "Armenburse230.JPG",
    Directives = {}
  }
}
_f7N = Wherigo.ZMedia(var_cartridge)
_f7N.Id = "c7425d04-68b2-4905-9642-fcaf49e38fd6"
_f7N.Name = _p0t("\0148,TGf8\028fKT\017T(A\r>|rG8>F")
_f7N.Description = ""
_f7N.AltText = ""
_f7N.Resources = {
  {
    Type = "jpg",
    Filename = "TafelamBenediktsplatz230.jpg",
    Directives = {}
  }
}
_FLe = Wherigo.ZMedia(var_cartridge)
_FLe.Id = "7e81a309-2759-47ac-947f-1f40e048d8b8"
_FLe.Name = _p0t("[T\017\r\0288G")
_FLe.Description = ""
_FLe.AltText = ""
_FLe.Resources = {
  {
    Type = "jpg",
    Filename = "Denkmal230.jpg",
    Directives = {}
  }
}
_bbOz = Wherigo.ZMedia(var_cartridge)
_bbOz.Id = "2986fccc-e99e-42d8-ad20-c2b8675ef6b3"
_bbOz.Name = _p0t("AY\006\0173\006(TF6\028J\017G\006Y\rT\017")
_bbOz.Description = ""
_bbOz.AltText = ""
_bbOz.Resources = {
  {
    Type = "jpg",
    Filename = "CodezumUnlocken32.jpg",
    Directives = {}
  }
}
_b9MC = Wherigo.ZMedia(var_cartridge)
_b9MC.Id = "971c61e6-2290-456d-9ff6-f0befe975ecb"
_b9MC.Name = _p0t("tYyG\006||F8yGT\017")
_b9MC.Description = ""
_b9MC.AltText = ""
_b9MC.Resources = {
  {
    Type = "jpg",
    Filename = "Schlosszahlen230.jpg",
    Directives = {}
  }
}
_ZF5 = Wherigo.ZMedia(var_cartridge)
_ZF5.Id = "4c653e1c-6e3f-40e7-8aec-92400937fdc2"
_ZF5.Name = _p0t("AY\006\017tYyG\006||F8yGT\017")
_ZF5.Description = ""
_ZF5.AltText = ""
_ZF5.Resources = {
  {
    Type = "jpg",
    Filename = "Schlosszahlen32.jpg",
    Directives = {}
  }
}
_hHuJ2 = Wherigo.ZMedia(var_cartridge)
_hHuJ2.Id = "f1780f19-e248-4f79-a2d4-0042665b06c5"
_hHuJ2.Name = _p0t("D\006>TGFA\028\028T;")
_hHuJ2.Description = ""
_hHuJ2.AltText = ""
_hHuJ2.Resources = {
  {
    Type = "jpg",
    Filename = "Hotelzimmer.jpg",
    Directives = {}
  }
}
_L_MX = Wherigo.ZMedia(var_cartridge)
_L_MX.Id = "64076873-99b8-4879-adaf-01ccd0c04297"
_L_MX.Name = _p0t("\b8>y86|B8||T")
_L_MX.Description = ""
_L_MX.AltText = ""
_L_MX.Resources = {
  {
    Type = "jpg",
    Filename = "Rathausgasse230.jpg",
    Directives = {}
  }
}
__dKO = Wherigo.ZMedia(var_cartridge)
__dKO.Id = "6a580776-c234-4a85-bee1-5c28986cb604"
__dKO.Name = _p0t("AY\006\017\b8>y86|B8||T")
__dKO.Description = ""
__dKO.AltText = ""
__dKO.Resources = {
  {
    Type = "jpg",
    Filename = "iconRathausgasse.jpg",
    Directives = {}
  }
}
_YEYmm = Wherigo.ZMedia(var_cartridge)
_YEYmm.Id = "18f9f692-2b88-4d09-9f02-03240b181407"
_YEYmm.Name = _p0t("\0038\017BTK;6TY\rT")
_YEYmm.Description = ""
_YEYmm.AltText = ""
_YEYmm.Resources = {
  {
    Type = "jpg",
    Filename = "LangeBruecke230.jpg",
    Directives = {}
  }
}
_NuR = Wherigo.ZMedia(var_cartridge)
_NuR.Id = "c82aa434-f309-4dee-97f6-5620ab422aa0"
_NuR.Name = _p0t("AY\006\017\0038\017BTK;6TY\rT")
_NuR.Description = ""
_NuR.AltText = ""
_NuR.Resources = {
  {
    Type = "jpg",
    Filename = "iconLangeBruecke.jpg",
    Directives = {}
  }
}
_xXMdK = Wherigo.ZMedia(var_cartridge)
_xXMdK.Id = "9270aa6a-c332-4e43-8c43-22b5e680be32"
_xXMdK.Name = _p0t("\t6|RT;>6\017BvT6BAT;")
_xXMdK.Description = ""
_xXMdK.AltText = ""
_xXMdK.Resources = {
  {
    Type = "jpg",
    Filename = "AuswertungNeugier.jpg",
    Directives = {}
  }
}
_luZfR = Wherigo.ZMedia(var_cartridge)
_luZfR.Id = "7dec9e98-ac98-4088-b0ba-97dcbf3beb6d"
_luZfR.Name = _p0t("\t6|RT;>6\017B\0248G|YyT\015A\017B8=T")
_luZfR.Description = ""
_luZfR.AltText = ""
_luZfR.Resources = {
  {
    Type = "jpg",
    Filename = "AuswertungFalscheEingabe.jpg",
    Directives = {}
  }
}
_UAdbA = Wherigo.ZMedia(var_cartridge)
_UAdbA.Id = "538fed78-1b1d-4ae6-bcf0-f2f50d8ba308"
_UAdbA.Name = _p0t("\t6|RT;>6\017BtYy8=T;\0178Y\r")
_UAdbA.Description = ""
_UAdbA.AltText = ""
_UAdbA.Resources = {
  {
    Type = "jpg",
    Filename = "AuswertungSchabernack.jpg",
    Directives = {}
  }
}
_ZG0y0 = Wherigo.ZMedia(var_cartridge)
_ZG0y0.Id = "8aa4b036-9b85-4e1b-9b37-5f0cd3afe5dd"
_ZG0y0.Name = _p0t("\t6|RT;>6\017B")
_ZG0y0.Description = ""
_ZG0y0.AltText = ""
_ZG0y0.Resources = {
  {
    Type = "jpg",
    Filename = "Auswertung.jpg",
    Directives = {}
  }
}
_AvSR = Wherigo.ZMedia(var_cartridge)
_AvSR.Id = "ce9a8607-6711-445c-9fad-10720b602fe7"
_AvSR.Name = _p0t("AY\006\017\t6|RT;>6\017B")
_AvSR.Description = ""
_AvSR.AltText = ""
_AvSR.Resources = {
  {
    Type = "jpg",
    Filename = "iconAuswertung.jpg",
    Directives = {}
  }
}
_16_4 = Wherigo.ZMedia(var_cartridge)
_16_4.Id = "6fba2261-107e-4765-88e2-d95144afe0ae"
_16_4.Name = _p0t("t>A,>T")
_16_4.Description = ""
_16_4.AltText = ""
_16_4.Resources = {
  {
    Type = "jpg",
    Filename = "Stifte.jpg",
    Directives = {}
  }
}
_rZy = Wherigo.ZMedia(var_cartridge)
_rZy.Id = "efd6716a-4eb8-4026-aec8-48eaf5a93e2c"
_rZy.Name = _p0t("DA\017>T;\017")
_rZy.Description = ""
_rZy.AltText = ""
_rZy.Resources = {
  {
    Type = "jpg",
    Filename = "Hintern.jpg",
    Directives = {}
  }
}
_nWYU = Wherigo.ZMedia(var_cartridge)
_nWYU.Id = "9b5fc932-8a75-4b48-80ec-1c233cc921ce"
_nWYU.Name = _p0t("\022;T6F")
_nWYU.Description = ""
_nWYU.AltText = ""
_nWYU.Resources = {
  {
    Type = "jpg",
    Filename = "kreuz230.jpg",
    Directives = {}
  }
}
_Jg3Ux = Wherigo.ZMedia(var_cartridge)
_Jg3Ux.Id = "9b06f5f2-95ca-4174-8e1b-4d22434cf3cd"
_Jg3Ux.Name = _p0t("t>8>A|>A\r")
_Jg3Ux.Description = ""
_Jg3Ux.AltText = ""
_Jg3Ux.Resources = {
  {
    Type = "jpg",
    Filename = "Statistik230.jpg",
    Directives = {}
  }
}
_k3W = Wherigo.ZMedia(var_cartridge)
_k3W.Id = "406f59ab-7d69-4094-9b41-d7ce87167e3e"
_k3W.Name = _p0t("AY\006\017t>8>A|>A\r")
_k3W.Description = ""
_k3W.AltText = ""
_k3W.Resources = {
  {
    Type = "jpg",
    Filename = "iconStatistik.jpg",
    Directives = {}
  }
}
_lX_Y = Wherigo.ZMedia(var_cartridge)
_lX_Y.Id = "ca5e3b2d-70c2-4fe1-a271-a79b5e08e82f"
_lX_Y.Name = _p0t("AY\006\017\022;8T\028T;=;6TY\rT")
_lX_Y.Description = ""
_lX_Y.AltText = ""
_lX_Y.Resources = {
  {
    Type = "jpg",
    Filename = "iconKraemerbruecke.jpg",
    Directives = {}
  }
}
_OphFV = Wherigo.ZMedia(var_cartridge)
_OphFV.Id = "def2500c-a151-4d65-8aa0-362f412babbd"
_OphFV.Name = _p0t("T\017(T")
_OphFV.Description = ""
_OphFV.AltText = ""
_OphFV.Resources = {
  {
    Type = "jpg",
    Filename = "ende.jpg",
    Directives = {}
  }
}
_kReOj = Wherigo.ZMedia(var_cartridge)
_kReOj.Id = "20cf283b-f61d-4578-85dd-580f860c6ec1"
_kReOj.Name = _p0t("AY\006\017\015\017(T")
_kReOj.Description = ""
_kReOj.AltText = ""
_kReOj.Resources = {
  {
    Type = "jpg",
    Filename = "iconende.jpg",
    Directives = {}
  }
}
_O3P = Wherigo.ZMedia(var_cartridge)
_O3P.Id = "c790a518-1e50-4550-ad19-417ec68f9c86"
_O3P.Name = _p0t(" A\rRTm:\027")
_O3P.Description = ""
_O3P.AltText = ""
_O3P.Resources = {
  {
    Type = "jpg",
    Filename = "Mikwe230.jpg",
    Directives = {}
  }
}
_SoN = Wherigo.ZMedia(var_cartridge)
_SoN.Id = "395a2a9e-917e-41a6-a3d4-045403a4ab0a"
_SoN.Name = _p0t("AY\006\017 A\rRT")
_SoN.Description = ""
_SoN.AltText = ""
_SoN.Resources = {
  {
    Type = "jpg",
    Filename = "Mikwe32.jpg",
    Directives = {}
  }
}
_JILu = Wherigo.ZMedia(var_cartridge)
_JILu.Id = "70a43d31-aea8-4ec0-98fe-b43dc77244c0"
_JILu.Name = _p0t("\t6B6|>A\017T;m:\027")
_JILu.Description = ""
_JILu.AltText = ""
_JILu.Resources = {
  {
    Type = "jpg",
    Filename = "Augustiner230.jpg",
    Directives = {}
  }
}
_z0iE = Wherigo.ZMedia(var_cartridge)
_z0iE.Id = "58218ac7-17e6-450b-adca-22e6de253b8b"
_z0iE.Name = _p0t("\t6BT")
_z0iE.Description = ""
_z0iE.AltText = ""
_z0iE.Resources = {
  {
    Type = "jpg",
    Filename = "Auge1.jpg",
    Directives = {}
  }
}
_traB6 = Wherigo.ZMedia(var_cartridge)
_traB6.Id = "0aad8112-6644-4432-bbb4-822ee5ce4d9e"
_traB6.Name = _p0t("\b8>y86|")
_traB6.Description = ""
_traB6.AltText = ""
_traB6.Resources = {
  {
    Type = "jpg",
    Filename = "Rathaus.jpg",
    Directives = {}
  }
}
_Ot0Xy = Wherigo.ZMedia(var_cartridge)
_Ot0Xy.Id = "e952c714-b423-4bbf-be89-cd12d057a9fb"
_Ot0Xy.Name = _p0t("K;T\017\017T\017(T\022A;YyTm:\027")
_Ot0Xy.Description = ""
_Ot0Xy.AltText = ""
_Ot0Xy.Resources = {
  {
    Type = "jpg",
    Filename = "BrennendeKirche230.jpg",
    Directives = {}
  }
}
_Yfn5 = Wherigo.ZMedia(var_cartridge)
_Yfn5.Id = "3c5fd1fd-214b-4bda-99ca-7bbb9048fed5"
_Yfn5.Name = _p0t("trTAYyT;\017")
_Yfn5.Description = ""
_Yfn5.AltText = ""
_Yfn5.Resources = {
  {
    Type = "jpg",
    Filename = "Diskette.jpg",
    Directives = {}
  }
}
__hDD = Wherigo.ZMedia(var_cartridge)
__hDD.Id = "d2a9ec25-f253-441b-b745-b6c3abc0b4ed"
__hDD.Name = _p0t("KTGG")
__hDD.Description = ""
__hDD.AltText = ""
__hDD.Resources = {
  {
    Type = "mp3",
    Filename = "XMasBell.mp3",
    Directives = {}
  }
}
_xxyf = Wherigo.ZMedia(var_cartridge)
_xxyf.Id = "a4b28acd-3921-4354-a35d-f995a0b1cbda"
_xxyf.Name = _p0t("KTGGB8;\028A\017")
_xxyf.Description = ""
_xxyf.AltText = ""
_xxyf.Resources = {
  {
    Type = "fdl",
    Filename = "Beepgarmin.fdl",
    Directives = {}
  }
}
_X9w_ = Wherigo.ZMedia(var_cartridge)
_X9w_.Id = "b1c719ba-d56b-47b5-ae28-527ef2aa866d"
_X9w_.Name = _p0t("t\0066\017(8\017")
_X9w_.Description = ""
_X9w_.AltText = ""
_X9w_.Resources = {
  {
    Type = "jpg",
    Filename = "Soundan1.jpg",
    Directives = {}
  }
}
_nxu = Wherigo.ZMedia(var_cartridge)
_nxu.Id = "ab1d9fe7-3cdd-43f3-ac03-56e11b5aba1d"
_nxu.Name = _p0t("t\0066\017(86|")
_nxu.Description = ""
_nxu.AltText = ""
_nxu.Resources = {
  {
    Type = "jpg",
    Filename = "Soundaus.jpg",
    Directives = {}
  }
}
_on8Ry = Wherigo.ZMedia(var_cartridge)
_on8Ry.Id = "aa82a5ed-9c01-43d5-94c1-c6e7213a4eff"
_on8Ry.Name = _p0t("AY\006\017t\0066\017(86|")
_on8Ry.Description = ""
_on8Ry.AltText = ""
_on8Ry.Resources = {
  {
    Type = "jpg",
    Filename = "iconSoundaus.jpg",
    Directives = {}
  }
}
_p1cj = Wherigo.ZMedia(var_cartridge)
_p1cj.Id = "9e6444f1-c369-4593-90e5-4fc00604407f"
_p1cj.Name = _p0t("AY\006\017t\0066\017(TA\017")
_p1cj.Description = ""
_p1cj.AltText = ""
_p1cj.Resources = {
  {
    Type = "jpg",
    Filename = "iconSoundan.jpg",
    Directives = {}
  }
}
_GhO40 = Wherigo.ZMedia(var_cartridge)
_GhO40.Id = "ceec8fc5-f01b-4111-9326-9bc0838a3c15"
_GhO40.Name = _p0t("v8\028T")
_GhO40.Description = ""
_GhO40.AltText = ""
_GhO40.Resources = {
  {
    Type = "jpg",
    Filename = "Papierflieger.jpg",
    Directives = {}
  }
}
_anW = Wherigo.ZMedia(var_cartridge)
_anW.Id = "da5b9ff2-084b-4d9e-ad52-d8fd55ae8410"
_anW.Name = _p0t("A\t6BT")
_anW.Description = ""
_anW.AltText = ""
_anW.Resources = {
  {
    Type = "jpg",
    Filename = "iAuge.jpg",
    Directives = {}
  }
}
_NdZu2 = Wherigo.ZMedia(var_cartridge)
_NdZu2.Id = "d2150811-9361-4083-a141-f8ac276c396b"
_NdZu2.Name = _p0t("tYyG\006||")
_NdZu2.Description = ""
_NdZu2.AltText = ""
_NdZu2.Resources = {
  {
    Type = "jpg",
    Filename = "2018Schloss230_1.jpg",
    Directives = {}
  }
}
_NXvm = Wherigo.ZMedia(var_cartridge)
_NXvm.Id = "0c7790e9-93cb-4a0a-8a5d-9b610825553e"
_NXvm.Name = _p0t("v8\017\006")
_NXvm.Description = ""
_NXvm.AltText = ""
_NXvm.Resources = {
  {
    Type = "JPG",
    Filename = "Nano230_1.JPG",
    Directives = {}
  }
}
_VvPs = Wherigo.ZMedia(var_cartridge)
_VvPs.Id = "4241f051-2512-4a3c-9acc-459982066880"
_VvPs.Name = _p0t("DAG,|\028A>>TG")
_VvPs.Description = ""
_VvPs.AltText = ""
_VvPs.Resources = {
  {
    Type = "jpg",
    Filename = "Hilfe_230.jpg",
    Directives = {}
  }
}
_Bfe = Wherigo.ZMedia(var_cartridge)
_Bfe.Id = "df18d77a-608e-494a-99bf-c1a7fb22415e"
_Bfe.Name = _p0t("tr\006AGT;\030DAG,|\028A>>TG")
_Bfe.Description = ""
_Bfe.AltText = ""
_Bfe.Resources = {
  {
    Type = "jpg",
    Filename = "IMG_20140630_151939752b.jpg",
    Directives = {}
  }
}
_Hvo = Wherigo.ZMedia(var_cartridge)
_Hvo.Id = "cff52673-04d5-4703-8f50-6ce4ceef1314"
_Hvo.Name = _p0t("AY\006\017DAG,|\028A>>TG")
_Hvo.Description = ""
_Hvo.AltText = ""
_Hvo.Resources = {
  {
    Type = "jpg",
    Filename = "Hilfe_32.jpg",
    Directives = {}
  }
}
var_cartridge.Id = "2c411833-fa0c-4e3e-a247-504ee7f05d9b"
var_cartridge.Name = "Der Narr geht um"
var_cartridge.Description = [[
<BR>
Till Eulenspiegel sucht eine Begleitung, um seine 3 Episoden in Erfurt zu erleben. Dabei braucht er etwas Hilfe bei kleineren Aufgaben. Es ist nirgends Eile notwendig, in allen Zonen und auch dazwischen ist genug Zeit den Blick umherschweifen zu lassen. Diese Cartridge gehoert zum Cache GC41NCH.]]
var_cartridge.Visible = true
var_cartridge.Activity = "TourGuide"
var_cartridge.StartingLocationDescription = [[
<BR>
Es gilt die Alte Universitaet zu finden. Die Richtung und Entfernung dorthin bekommst du bereits nach Spielstart angezeigt. Suche einfach in der Michaelisstrasse.]]
var_cartridge.StartingLocation = ZonePoint(50.979517, 11.02795, 0)
var_cartridge.Version = "2.1"
var_cartridge.Company = ""
var_cartridge.Author = "hippomenes"
var_cartridge.BuilderVersion = "URWIGO 1.22.5798.37755"
var_cartridge.CreateDate = "09/02/2012 20:50:23"
var_cartridge.PublishDate = "1/1/0001 12:00:00 AM"
var_cartridge.UpdateDate = "08/16/2018 20:55:31"
var_cartridge.LastPlayedDate = "1/1/0001 12:00:00 AM"
var_cartridge.TargetDevice = "PocketPC"
var_cartridge.TargetDeviceVersion = "0"
var_cartridge.StateId = "1"
var_cartridge.CountryId = "2"
var_cartridge.Complete = false
var_cartridge.UseLogging = true
var_cartridge.Media = _Y6Ad
var_cartridge.Icon = _IiD
_iQuD = Wherigo.Zone(var_cartridge)
_iQuD.Id = "75e6bc9e-7e70-469c-964e-6841e702ad78"
_iQuD.Name = _p0t("\tG>TfJ\017A\021T;|A>z8>")
_iQuD.Description = _p0t("[ATf\tG>TfJ\017A\021T;|A>z8>fA|>f;TYy>fGTAYy>fA\017f(T;f AYy8TGA||>;8z|TfF6f,A\017(T\017\030f\\\006;f\n;>fBA=>fT|f86YyfTA\017ABTfS\017,\006;\0288>A\006\017T\017fF6;f\026T|YyAYy>Tf(T|fTA\017(;6Y\r|\021\006GGT\017f\026T=z86(T|\030fJ\017(fT|fBAG>f(\006;>f(ATfT;|>Tf\t6,B8=TfF6fT;,z6GGT\017\030")
_iQuD.Visible = true
_iQuD.Media = _LXqy
_iQuD.Icon = _P7i
_iQuD.Commands = {}
_iQuD.DistanceRange = Distance(-1, "feet")
_iQuD.ShowObjects = "OnEnter"
_iQuD.ProximityRange = Distance(15, "meters")
_iQuD.AllowSetPositionTo = false
_iQuD.Active = false
_iQuD.Points = {
  ZonePoint(50.9797962744725, 11.0278527438641, 0),
  ZonePoint(50.9795412795061, 11.0284776985645, 0),
  ZonePoint(50.9792162011111, 11.0280874371529, 0),
  ZonePoint(50.9795193262317, 11.0274329781532, 0)
}
_iQuD.OriginalPoint = ZonePoint(50.9795182703303, 11.0279627144337, 0)
_iQuD.DistanceRangeUOM = "Feet"
_iQuD.ProximityRangeUOM = "Meters"
_iQuD.OutOfRangeName = ""
_iQuD.InRangeName = ""
_bmj = Wherigo.Zone(var_cartridge)
_bmj.Id = "61ccca7c-99ae-4284-9ccf-9a9191e73fcc"
_bmj.Name = _p0t("KT\017T(A\r>|rG8>Ffg")
_bmj.Description = _p0t("\t\028fRT|>GAYyT\017f\015\017(Tf(T;f\022;z8\028T;=;z6Y\rTf|>8\017(f|TA>f(T\028fgg\030f}8y;y6\017(T;>f(ATfKT\017T(A\r>A\rA;YyTaf(ATfgx!\027f8=BT;A||T\017fR6;(Tf6\017(f8\017f(ATfyT6>Tf\0176;f\017\006Yyf(T;fv8\028Tf(T|fKT\017T(A\r>|rG8>FT|fT;A\017\017T;>\030")
_bmj.Visible = false
_bmj.Media = _GV85L
_bmj.Icon = _eZMjU
_bmj.Commands = {}
_bmj.DistanceRange = Distance(-1, "feet")
_bmj.ShowObjects = "OnEnter"
_bmj.ProximityRange = Distance(20, "meters")
_bmj.AllowSetPositionTo = false
_bmj.Active = false
_bmj.Points = {
  ZonePoint(50.9788822545718, 11.0301366448402, 0),
  ZonePoint(50.9787074699641, 11.0294654220343, 0),
  ZonePoint(50.9783313008592, 11.0298670828342, 0),
  ZonePoint(50.9784592240281, 11.0304142534733, 0)
}
_bmj.OriginalPoint = ZonePoint(50.9785950623558, 11.0299708507955, 0)
_bmj.DistanceRangeUOM = "Feet"
_bmj.ProximityRangeUOM = "Meters"
_bmj.OutOfRangeName = ""
_bmj.InRangeName = ""
_9Lkh = Wherigo.Zone(var_cartridge)
_9Lkh.Id = "85e6ee90-40cd-480c-97ba-2ff261cffb74"
_9Lkh.Name = _p0t("\022;T6FB8||T")
_9Lkh.Description = _p0t("[ATf\022;T6FB8||Tf,z6y;>f;TYy>fA(+GGA|YyfF6fTA\017T;fB;z6\017T\017f\n8|TfA\017\028A>>T\017f(T;f\tG>|>8(>\030f\015|f\006,,T\017=8;>f|AYyfTA\017f|Yyz\006\017T;ftTA>T\017=GAY\rf86,f(ATf\022;z8\028T;=;z6Y\rTf6\017(f86Yyf(ATf A\rRTfA|>f\017AYy>fRTA>\030")
_9Lkh.Visible = false
_9Lkh.Media = _Xvy
_9Lkh.Icon = _lX_Y
_9Lkh.Commands = {}
_9Lkh.DistanceRange = Distance(-1, "feet")
_9Lkh.ShowObjects = "OnEnter"
_9Lkh.ProximityRange = Distance(25, "meters")
_9Lkh.AllowSetPositionTo = false
_9Lkh.Active = false
_9Lkh.Points = {
  ZonePoint(50.9795716763306, 11.0290798544884, 0),
  ZonePoint(50.978682560993, 11.0302439332008, 0),
  ZonePoint(50.9787610875345, 11.0309560596943, 0),
  ZonePoint(50.9795091939476, 11.0306462645531, 0),
  ZonePoint(50.9799398140693, 11.0295908153057, 0)
}
_9Lkh.OriginalPoint = ZonePoint(50.979292866575, 11.0301033854485, 0)
_9Lkh.DistanceRangeUOM = "Feet"
_9Lkh.ProximityRangeUOM = "Meters"
_9Lkh.OutOfRangeName = ""
_9Lkh.InRangeName = ""
_HdNc = Wherigo.Zone(var_cartridge)
_HdNc.Id = "f209d001-1e79-4f91-9820-971465de4f18"
_HdNc.Name = _p0t("KT\017T(A\r>|rG8>Ffm")
_HdNc.Description = _p0t("\t\028fRT|>GAYyT\017f\015\017(Tf(T;f\022;z8\028T;=;z6Y\rTf|>8\017(f|TA>f(T\028fgg\030f}8y;y6\017(T;>f(ATfKT\017T(A\r>A\rA;YyTaf(ATfgx!\027f8=BT;A||T\017fR6;(Tf6\017(f8\017f(ATfyT6>Tf\0176;f\017\006Yyf(T;fv8\028Tf(T|fKT\017T(A\r>|rG8>FT|fT;A\017\017T;>\030")
_HdNc.Visible = false
_HdNc.Media = _GV85L
_HdNc.Icon = _eZMjU
_HdNc.Commands = {}
_HdNc.DistanceRange = Distance(-1, "feet")
_HdNc.ShowObjects = "OnEnter"
_HdNc.ProximityRange = Distance(20, "meters")
_HdNc.AllowSetPositionTo = false
_HdNc.Active = false
_HdNc.Points = {
  ZonePoint(50.9786969153169, 11.0303257405758, 0),
  ZonePoint(50.9784233380262, 11.030540317297, 0),
  ZonePoint(50.9782417966503, 11.02991938591, 0),
  ZonePoint(50.9787028259196, 11.0294768214226, 0),
  ZonePoint(50.9788767661762, 11.0301326215267, 0)
}
_HdNc.OriginalPoint = ZonePoint(50.9785883284178, 11.0300789773464, 0)
_HdNc.DistanceRangeUOM = "Feet"
_HdNc.ProximityRangeUOM = "Meters"
_HdNc.OutOfRangeName = ""
_HdNc.InRangeName = ""
_9uVW0 = Wherigo.Zone(var_cartridge)
_9uVW0.Id = "f1280faa-6aa9-408c-a1d2-1d0bf8e711a1"
_9uVW0.Name = _p0t("\b\006>T;f\0146;\028")
_9uVW0.Description = _p0t("[T;f\014\006;=\006BT\017f=AG(T>f(T\017fz\006|>GAYyT\017f/6B8\017BfF6;f\022;z8\028T;=;z6Y\rT\030f[T;f::f T>T;fy\006yTf\0146;\028fRA;(f86Yyf8G|f*\b\006>T;f\0146;\028*f=TFTAYy\017T>f6\017(fA|>f>z8BGAYyf,6;fKT|6YyT;fBTz\006,,\017T>\030")
_9uVW0.Visible = false
_9uVW0.Media = _Q9K2e
_9uVW0.Icon = _yhX
_9uVW0.Commands = {}
_9uVW0.DistanceRange = Distance(-1, "feet")
_9uVW0.ShowObjects = "OnEnter"
_9uVW0.ProximityRange = Distance(25, "meters")
_9uVW0.AllowSetPositionTo = false
_9uVW0.Active = false
_9uVW0.Points = {
  ZonePoint(50.9789341832052, 11.0314509272575, 0),
  ZonePoint(50.9790355072009, 11.0323441028595, 0),
  ZonePoint(50.9782232202834, 11.0327276587486, 0),
  ZonePoint(50.9782612173895, 11.0314938426018, 0)
}
_9uVW0.OriginalPoint = ZonePoint(50.9786135320198, 11.0320041328668, 0)
_9uVW0.DistanceRangeUOM = "Feet"
_9uVW0.ProximityRangeUOM = "Meters"
_9uVW0.OutOfRangeName = ""
_9uVW0.InRangeName = ""
_7K7j = Wherigo.Zone(var_cartridge)
_7K7j.Id = "9e9e19d3-d98c-4a33-8274-6ae779892327"
_7K7j.Name = _p0t("\b8>y86|B8||T")
_7K7j.Description = _p0t("[ATfJ;|r;6\017BTf(T|f\b8>y86|T|f;TAYyT\017f=A|fA\017f(8|fgg\030f}8y;y6\017(T;>fF6;z6Y\r\030f[8|fgmE\019fT;|>\0288G|fT;Rz8y\017>Tf\b8>y86|fR8;fr\006GA>A|YyT|fDT;F|>z6Y\rf(T;f\r\006\028\0286\0178GT\017ftTG=|>\021T;R8G>6\017Bf(T;f A>>TG8G>T;\028T>;\006r\006GTf\021\006\028fg:\030f=A|fgE\030f}8y;y6\017(T;>\030fS\028f}8y;fgx:\027fR6;(Tf=TB\006\017\017T\017f(8|f8G>Tf\b8>y86|f8=F6;TAz|T\017af8G|f\026;6\017(fB8G>f\0176;fTA\017f\rGTA\017T;T;ftYy8(T\017f8\028f[8Yy\030fv8YyfKT;TA>|>TGG6\017Bf(T;f,A\0178\017FATGGT\017f A>>TGf=TB8\017\017fA\028f}8y;fgxs!f(T;f\t6,=86f(T|f\b8>y86|T|fA\017f|TA\017T;fyT6>ABT\017f\024\006;\028fA\028ft>AGf(T;fvT6B\006>A\r\030")
_7K7j.Visible = false
_7K7j.Media = _L_MX
_7K7j.Icon = __dKO
_7K7j.Commands = {}
_7K7j.DistanceRange = Distance(-1, "feet")
_7K7j.ShowObjects = "OnEnter"
_7K7j.ProximityRange = Distance(20, "meters")
_7K7j.AllowSetPositionTo = false
_7K7j.Active = false
_7K7j.Points = {
  ZonePoint(50.9782016885762, 11.0306113958359, 0),
  ZonePoint(50.9781109175438, 11.02972894907, 0),
  ZonePoint(50.9775920415844, 11.0298342257738, 0),
  ZonePoint(50.9776443938562, 11.0307247191668, 0)
}
_7K7j.OriginalPoint = ZonePoint(50.9778872603902, 11.0302248224616, 0)
_7K7j.DistanceRangeUOM = "Feet"
_7K7j.ProximityRangeUOM = "Meters"
_7K7j.OutOfRangeName = ""
_7K7j.InRangeName = ""
_xsZE = Wherigo.Zone(var_cartridge)
_xsZE.Id = "36ed69d5-a8b0-4d2b-aa58-02c821fe98b1"
_xsZE.Name = _p0t("\0038\017BTfK;z6Y\rT")
_xsZE.Description = _p0t("[ATfT;|>Tf6;\r6\017(GAYyTf\015;Rz8y\0176\017BfTA\017T;fK;z6Y\rTf8\017f(AT|T;ft>TGGTfA|>f,z6;f(8|f}8y;fgm!:f\0178YyRTA|=8;\030f\t\017,z8\017BGAYyfR8;fT|fTA\017fK86RT;\raf(8|f=TA(Tf\026T;88;\028Tfz6=T;|r8\017\017>T\030f[AT|T|fR6;(Tf8=T;f|Yy\006\017f,;z6yf(6;YyfFRTAfBT>;T\017\017>TfK;z6Y\rT\017fT;|T>F>\030fJ;|r;z6\017BGAYyfB8G>f(T;fv8\028Tf\0176;f,z6;f(T\017ft>;8z|T\017F6Baf|\006RTA>f(ATfK;z6Y\rT\017f6\017(f`,TAGT;f;TAYy>T\017\030fv8YyfgxgEf,z6y;>Tf(ATft>;8z|Tf\021\006\017f(T;f\bTBAT;6\017B||>;8z|Tf=A|fF6;f\026;\006z|T\017f\t;YyTafgxE\027f\r8\028T\017f(8|f`Gz8\017YyT\017f6\017(f(T;ft>6\017FT\017rG8>FfyA\017F6\030f\t\017f(T;f\015Y\rTf\bTBAT;6\017B||>;8z|TM\0038\017BTfK;z6Y\rTfB8=fT|f\028A>f(T;f\\A>A\rA;YyTfTA\017TfK;z6Y\rT\017\r\006r,\rA;YyTaf(ATfgx\027!f8=BT=;\006YyT\017fR6;(T\030")
_xsZE.Visible = false
_xsZE.Media = _YEYmm
_xsZE.Icon = _NuR
_xsZE.Commands = {}
_xsZE.DistanceRange = Distance(-1, "feet")
_xsZE.ShowObjects = "OnEnter"
_xsZE.ProximityRange = Distance(20, "meters")
_xsZE.AllowSetPositionTo = false
_xsZE.Active = false
_xsZE.Points = {
  ZonePoint(50.975505079962, 11.0260610282421, 0),
  ZonePoint(50.975630899848, 11.0266913473606, 0),
  ZonePoint(50.9751428181183, 11.0270065069199, 0),
  ZonePoint(50.9750144635935, 11.0263104736805, 0)
}
_xsZE.OriginalPoint = ZonePoint(50.9753233153805, 11.0265173390508, 0)
_xsZE.DistanceRangeUOM = "Feet"
_xsZE.ProximityRangeUOM = "Meters"
_xsZE.OutOfRangeName = ""
_xsZE.InRangeName = ""
_lbk = Wherigo.Zone(var_cartridge)
_lbk.Id = "a5406f45-67bd-48ad-b23b-82289081d903"
_lbk.Name = _p0t("\022;T6FB8||Tm")
_lbk.Description = ""
_lbk.Visible = true
_lbk.Commands = {}
_lbk.DistanceRange = Distance(-1, "feet")
_lbk.ShowObjects = "OnEnter"
_lbk.ProximityRange = Distance(20, "meters")
_lbk.AllowSetPositionTo = false
_lbk.Active = false
_lbk.Points = {
  ZonePoint(50.9796096723332, 11.0298576951027, 0),
  ZonePoint(50.9796096723331, 11.0298576951027, 0),
  ZonePoint(50.9796096723332, 11.0298576951026, 0)
}
_lbk.OriginalPoint = ZonePoint(50.9796096723332, 11.0298576951027, 0)
_lbk.DistanceRangeUOM = "Feet"
_lbk.ProximityRangeUOM = "Meters"
_lbk.OutOfRangeName = ""
_lbk.InRangeName = ""
_tarmy = Wherigo.Zone(var_cartridge)
_tarmy.Id = "2fe60c61-6fd9-4620-9e1b-4e3e48389d34"
_tarmy.Name = _p0t("\tG>TfJ\017A\021T;|A>z8>\030")
_tarmy.Description = _p0t("[ATf\tG>TfJ\017A\021T;|A>z8>fA|>f;TYy>fGTAYy>fA\017f(T;f AYy8TGA||>;8z|TfF6f,A\017(T\017\030f\\\006;f\n;>fBA=>fT|f86YyfTA\017ABTfS\017,\006;\0288>A\006\017T\017fF6;f\026T|YyAYy>Tf(T|fTA\017(;6Y\r|\021\006GGT\017f\026T=z86(T|\030fJ\017(fT|fBAG>f(\006;>f(ATfT;|>Tf\t6,B8=TfF6fT;,z6GGT\017\030")
_tarmy.Visible = true
_tarmy.Media = _LXqy
_tarmy.Icon = _P7i
_tarmy.Commands = {}
_tarmy.DistanceRange = Distance(-1, "feet")
_tarmy.ShowObjects = "OnEnter"
_tarmy.ProximityRange = Distance(10, "meters")
_tarmy.AllowSetPositionTo = false
_tarmy.Active = false
_tarmy.Points = {
  ZonePoint(50.9795395907931, 11.027929186821, 0),
  ZonePoint(50.9795395907931, 11.027929186821, 0),
  ZonePoint(50.9795395907931, 11.027929186821, 0)
}
_tarmy.OriginalPoint = ZonePoint(50.9795395907931, 11.027929186821, 0)
_tarmy.DistanceRangeUOM = "Feet"
_tarmy.ProximityRangeUOM = "Meters"
_tarmy.OutOfRangeName = ""
_tarmy.InRangeName = ""
_i7e = Wherigo.Zone(var_cartridge)
_i7e.Id = "53400e30-8db7-4fb9-a9ad-95c2160447ad"
_i7e.Name = _p0t("KT\017T(A\r>|rG8>Ffg\030")
_i7e.Description = _p0t("\t\028fRT|>GAYyT\017f\015\017(Tf(T;f\022;z8\028T;=;z6Y\rTf|>8\017(f|TA>f(T\028fgg\030f}8y;y6\017(T;>f(ATfKT\017T(A\r>A\rA;YyTaf(ATfgx!\027f8=BT;A||T\017fR6;(Tf6\017(f8\017f(ATfyT6>Tf\0176;f\017\006Yyf(T;fv8\028Tf(T|fKT\017T(A\r>|rG8>FT|fT;A\017\017T;>\030")
_i7e.Visible = true
_i7e.Media = _GV85L
_i7e.Icon = _eZMjU
_i7e.Commands = {}
_i7e.DistanceRange = Distance(-1, "feet")
_i7e.ShowObjects = "OnEnter"
_i7e.ProximityRange = Distance(15, "meters")
_i7e.AllowSetPositionTo = false
_i7e.Active = false
_i7e.Points = {
  ZonePoint(50.9785837693489, 11.0299609601498, 0),
  ZonePoint(50.9785837693489, 11.0299609601498, 0),
  ZonePoint(50.9785837693489, 11.0299609601498, 0)
}
_i7e.OriginalPoint = ZonePoint(50.9785837693489, 11.0299609601498, 0)
_i7e.DistanceRangeUOM = "Feet"
_i7e.ProximityRangeUOM = "Meters"
_i7e.OutOfRangeName = ""
_i7e.InRangeName = ""
_bQEO = Wherigo.Zone(var_cartridge)
_bQEO.Id = "3433fd24-094e-4d46-8f23-53ac8804c41b"
_bQEO.Name = _p0t("KT\017T(A\r>|rG8>Ffm\030")
_bQEO.Description = _p0t("\t\028fRT|>GAYyT\017f\015\017(Tf(T;f\022;z8\028T;=;z6Y\rTf|>8\017(f|TA>f(T\028fgg\030f}8y;y6\017(T;>f(ATfKT\017T(A\r>A\rA;YyTaf(ATfgx!\027f8=BT;A||T\017fR6;(Tf6\017(f8\017f(ATfyT6>Tf\0176;f\017\006Yyf(T;fv8\028Tf(T|fKT\017T(A\r>|rG8>FT|fT;A\017\017T;>\030")
_bQEO.Visible = true
_bQEO.Media = _GV85L
_bQEO.Icon = _eZMjU
_bQEO.Commands = {}
_bQEO.DistanceRange = Distance(-1, "feet")
_bQEO.ShowObjects = "OnEnter"
_bQEO.ProximityRange = Distance(15, "meters")
_bQEO.AllowSetPositionTo = false
_bQEO.Active = false
_bQEO.Points = {
  ZonePoint(50.9785846137229, 11.0299596190453, 0),
  ZonePoint(50.9785846137229, 11.0299596190453, 0),
  ZonePoint(50.9785846137229, 11.0299596190453, 0)
}
_bQEO.OriginalPoint = ZonePoint(50.9785846137229, 11.0299596190453, 0)
_bQEO.DistanceRangeUOM = "Feet"
_bQEO.ProximityRangeUOM = "Meters"
_bQEO.OutOfRangeName = ""
_bQEO.InRangeName = ""
_by6 = Wherigo.Zone(var_cartridge)
_by6.Id = "406b663e-1edf-4f03-854e-7391d9823426"
_by6.Name = _p0t("\022;T6FB8||T\030")
_by6.Description = _p0t("[ATf\022;T6FB8||Tf,z6y;>f;TYy>fA(+GGA|YyfF6fTA\017T;fB;z6\017T\017f\n8|TfA\017\028A>>T\017f(T;f\tG>|>8(>\030f\015|f\006,,T\017=8;>f|AYyfTA\017f|Yyz\006\017T;ftTA>T\017=GAY\rf86,f(ATf\022;z8\028T;=;z6Y\rTf6\017(f86Yyf(ATf A\rRTfA|>f\017AYy>fRTA>\030")
_by6.Visible = true
_by6.Media = _Xvy
_by6.Icon = _lX_Y
_by6.Commands = {}
_by6.DistanceRange = Distance(-1, "feet")
_by6.ShowObjects = "OnEnter"
_by6.ProximityRange = Distance(20, "meters")
_by6.AllowSetPositionTo = false
_by6.Active = false
_by6.Points = {
  ZonePoint(50.9792465981484, 11.0301929712296, 0),
  ZonePoint(50.9792465981484, 11.0301929712296, 0),
  ZonePoint(50.9792465981484, 11.0301929712296, 0)
}
_by6.OriginalPoint = ZonePoint(50.9792465981484, 11.0301929712296, 0)
_by6.DistanceRangeUOM = "Feet"
_by6.ProximityRangeUOM = "Meters"
_by6.OutOfRangeName = ""
_by6.InRangeName = ""
_4fCr = Wherigo.Zone(var_cartridge)
_4fCr.Id = "d11f0f38-3593-4c4f-97d4-a54295e05a21"
_4fCr.Name = _p0t("\0038\017BTfK;z6Y\rT\030")
_4fCr.Description = _p0t("[ATfT;|>Tf6;\r6\017(GAYyTf\015;Rz8y\0176\017BfTA\017T;fK;z6Y\rTf8\017f(AT|T;ft>TGGTfA|>f,z6;f(8|f}8y;fgm!:f\0178YyRTA|=8;\030f\t\017,z8\017BGAYyfR8;fT|fTA\017fK86RT;\raf(8|f=TA(Tf\026T;88;\028Tfz6=T;|r8\017\017>T\030f[AT|T|fR6;(Tf8=T;f|Yy\006\017f,;z6yf(6;YyfFRTAfBT>;T\017\017>TfK;z6Y\rT\017fT;|T>F>\030fJ;|r;z6\017BGAYyfB8G>f(T;fv8\028Tf\0176;f,z6;f(T\017ft>;8z|T\017F6Baf|\006RTA>f(ATfK;z6Y\rT\017f6\017(f`,TAGT;f;TAYy>T\017\030fv8YyfgxgEf,z6y;>Tf(ATft>;8z|Tf\021\006\017f(T;f\bTBAT;6\017B||>;8z|Tf=A|fF6;f\026;\006z|T\017f\t;YyTafgxE\027f\r8\028T\017f(8|f`Gz8\017YyT\017f6\017(f(T;ft>6\017FT\017rG8>FfyA\017F6\030f\t\017f(T;f\015Y\rTf\bTBAT;6\017B||>;8z|TM\0038\017BTfK;z6Y\rTfB8=fT|f\028A>f(T;f\\A>A\rA;YyTfTA\017TfK;z6Y\rT\017\r\006r,\rA;YyTaf(ATfgx\027!f8=BT=;\006YyT\017fR6;(T\030")
_4fCr.Visible = true
_4fCr.Media = _YEYmm
_4fCr.Icon = _NuR
_4fCr.Commands = {}
_4fCr.DistanceRange = Distance(-1, "feet")
_4fCr.ShowObjects = "OnEnter"
_4fCr.ProximityRange = Distance(10, "meters")
_4fCr.AllowSetPositionTo = false
_4fCr.Active = false
_4fCr.Points = {
  ZonePoint(50.9753032607753, 11.0265156626701, 0),
  ZonePoint(50.9753032607753, 11.0265156626701, 0),
  ZonePoint(50.9753032607753, 11.0265156626701, 0)
}
_4fCr.OriginalPoint = ZonePoint(50.9753032607753, 11.0265156626701, 0)
_4fCr.DistanceRangeUOM = "Feet"
_4fCr.ProximityRangeUOM = "Meters"
_4fCr.OutOfRangeName = ""
_4fCr.InRangeName = ""
_gKt = Wherigo.Zone(var_cartridge)
_gKt.Id = "9300089e-ef92-48d5-9c6d-13f47e0e1fc9"
_gKt.Name = _p0t("\b8>y86|B8||T\030")
_gKt.Description = _p0t("[ATfJ;|r;6\017BTf(T|f\b8>y86|T|f;TAYyT\017f=A|fA\017f(8|fgg\030f}8y;y6\017(T;>fF6;z6Y\r\030f[8|fgmE\019fT;|>\0288G|fT;Rz8y\017>Tf\b8>y86|fR8;fr\006GA>A|YyT|fDT;F|>z6Y\rf(T;f\r\006\028\0286\0178GT\017ftTG=|>\021T;R8G>6\017Bf(T;f A>>TG8G>T;\028T>;\006r\006GTf\021\006\028fg:\030f=A|fgE\030f}8y;y6\017(T;>\030fS\028f}8y;fgx:\027fR6;(Tf=TB\006\017\017T\017f(8|f8G>Tf\b8>y86|f8=F6;TAz|T\017af8G|f\026;6\017(fB8G>f\0176;fTA\017f\rGTA\017T;T;ftYy8(T\017f8\028f[8Yy\030fv8YyfKT;TA>|>TGG6\017Bf(T;f,A\0178\017FATGGT\017f A>>TGf=TB8\017\017fA\028f}8y;fgxs!f(T;f\t6,=86f(T|f\b8>y86|T|fA\017f|TA\017T;fyT6>ABT\017f\024\006;\028fA\028ft>AGf(T;fvT6B\006>A\r\030")
_gKt.Visible = true
_gKt.Media = _L_MX
_gKt.Icon = __dKO
_gKt.Commands = {}
_gKt.DistanceRange = Distance(-1, "feet")
_gKt.ShowObjects = "OnEnter"
_gKt.ProximityRange = Distance(10, "meters")
_gKt.AllowSetPositionTo = false
_gKt.Active = false
_gKt.Points = {
  ZonePoint(50.9778896887957, 11.030180901289, 0),
  ZonePoint(50.9778896887957, 11.030180901289, 0),
  ZonePoint(50.9778896887957, 11.030180901289, 0)
}
_gKt.OriginalPoint = ZonePoint(50.9778896887957, 11.030180901289, 0)
_gKt.DistanceRangeUOM = "Feet"
_gKt.ProximityRangeUOM = "Meters"
_gKt.OutOfRangeName = ""
_gKt.InRangeName = ""
_Okwc = Wherigo.Zone(var_cartridge)
_Okwc.Id = "40be94e0-7e87-47fe-a622-60231a81acde"
_Okwc.Name = _p0t("\b\006>T;f\0146;\028\030")
_Okwc.Description = _p0t("[T;f\014\006;=\006BT\017f=AG(T>f(T\017fz\006|>GAYyT\017f/6B8\017BfF6;f\022;z8\028T;=;z6Y\rT\030f[T;f::f T>T;fy\006yTf\0146;\028fRA;(f86Yyf8G|f*\b\006>T;f\0146;\028*f=TFTAYy\017T>f6\017(fA|>f>z8BGAYyf,6;fKT|6YyT;fBTz\006,,\017T>\030")
_Okwc.Visible = true
_Okwc.Media = _Q9K2e
_Okwc.Icon = _yhX
_Okwc.Commands = {}
_Okwc.DistanceRange = Distance(-1, "feet")
_Okwc.ShowObjects = "OnEnter"
_Okwc.ProximityRange = Distance(20, "meters")
_Okwc.AllowSetPositionTo = false
_Okwc.Active = false
_Okwc.Points = {
  ZonePoint(50.9787002928043, 11.0319297015667, 0),
  ZonePoint(50.9787002928043, 11.0319297015667, 0),
  ZonePoint(50.9787002928043, 11.0319297015667, 0)
}
_Okwc.OriginalPoint = ZonePoint(50.9787002928043, 11.0319297015667, 0)
_Okwc.DistanceRangeUOM = "Feet"
_Okwc.ProximityRangeUOM = "Meters"
_Okwc.OutOfRangeName = ""
_Okwc.InRangeName = ""
_qy9c = Wherigo.ZCharacter(var_cartridge)
_qy9c.Id = "223d0944-abad-4e40-b635-cfad9579c5d3"
_qy9c.Name = _p0t("\014AGGf\0156GT\017|rATBTG")
_qy9c.Description = ""
_qy9c.Visible = true
_qy9c.Media = _Y6Ad
_qy9c.Icon = _IiD
_qy9c.Commands = {
  _y6C_ = Wherigo.ZCommand({
    Text = _p0t("tr;TYyT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_qy9c.Commands._y6C_.Custom = true
_qy9c.Commands._y6C_.Id = "7418206a-ba73-4112-8627-7ac50f92ccbc"
_qy9c.Commands._y6C_.WorksWithAll = true
_qy9c.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_qy9c.Gender = "Male"
_qy9c.Type = "NPC"
_xiX4 = Wherigo.ZCharacter(var_cartridge)
_xiX4.Id = "4d501fa3-5660-4beb-9575-372c2305e0eb"
_xiX4.Name = _p0t(" T>FBT;")
_xiX4.Description = ""
_xiX4.Visible = true
_xiX4.Media = _wi1
_xiX4.Icon = _8XUQA
_xiX4.Commands = {
  _IDZq = Wherigo.ZCommand({
    Text = _p0t("tr;TYyT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _rR3Tr = Wherigo.ZCommand({
    Text = _p0t("8\017|Yy86T\017"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_xiX4.Commands._IDZq.Custom = true
_xiX4.Commands._IDZq.Id = "49608682-b1c1-40b8-917d-6f9d44390ed6"
_xiX4.Commands._IDZq.WorksWithAll = true
_xiX4.Commands._rR3Tr.Custom = true
_xiX4.Commands._rR3Tr.Id = "eb2a2620-181b-4d8f-a102-99ead1c8f219"
_xiX4.Commands._rR3Tr.WorksWithAll = true
_xiX4.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xiX4.Gender = "Male"
_xiX4.Type = "NPC"
_YVX = Wherigo.ZCharacter(var_cartridge)
_YVX.Id = "f64db203-597f-4b02-b204-71cddbf5322e"
_YVX.Name = _p0t("\bT\r>\006;")
_YVX.Description = ""
_YVX.Visible = true
_YVX.Media = _9Dbe
_YVX.Icon = _ASDk
_YVX.Commands = {
  _6m_ = Wherigo.ZCommand({
    Text = _p0t("tr;TYyT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_YVX.Commands._6m_.Custom = true
_YVX.Commands._6m_.Id = "7864551a-3511-492f-a873-e98ea5e9c7d5"
_YVX.Commands._6m_.WorksWithAll = true
_YVX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_YVX.Gender = "Male"
_YVX.Type = "NPC"
_oqu = Wherigo.ZItem({Cartridge = var_cartridge, Container = _iQuD})
_oqu.Id = "85e312e2-45f1-4afe-a5f3-3a8d9c28b56e"
_oqu.Name = _p0t("~\tG>TfJ\017A\021T;|A>z8>")
_oqu.Description = _p0t("[ATf\tG>TfJ\017A\021T;|A>z8>f=AG(T>f(T\017f\t6,>8\r>fF6f(AT|T;f\026T|YyAYy>T\030f[6f|>Ty|>f|AYyT;fBT;8(Tf(A;T\r>f(8\021\006;\030")
_oqu.Visible = true
_oqu.Media = _bFQA
_oqu.Icon = _anW
_oqu.Commands = {
  _1HBBf = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_oqu.Commands._1HBBf.Custom = true
_oqu.Commands._1HBBf.Id = "19d5d2eb-9e5a-492e-bc9a-b6c1b77a2cde"
_oqu.Commands._1HBBf.WorksWithAll = true
_oqu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_oqu.Locked = false
_oqu.Opened = false
_53tRP = Wherigo.ZItem({Cartridge = var_cartridge, Container = _iQuD})
_53tRP.Id = "6153c0b6-ceac-4dce-a0e9-09a98828451c"
_53tRP.Name = _p0t("\014\006;f(T;f\tG>T\017fJ\017A")
_53tRP.Description = ""
_53tRP.Visible = true
_53tRP.Media = _LXqy
_53tRP.Icon = _P7i
_53tRP.Commands = {
  _kwfwl = Wherigo.ZCommand({
    Text = _p0t("8\017|Yy86T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _GoWD = Wherigo.ZCommand({
    Text = _p0t("\026;8,,A>Af|r;6TyT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _kPRK = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_53tRP.Commands._kwfwl.Custom = true
_53tRP.Commands._kwfwl.Id = "3ce4a0f8-2b14-484e-a3c0-cf320ca77b64"
_53tRP.Commands._kwfwl.WorksWithAll = true
_53tRP.Commands._GoWD.Custom = true
_53tRP.Commands._GoWD.Id = "edce8175-4598-4896-b94f-644cd12b9b16"
_53tRP.Commands._GoWD.WorksWithAll = true
_53tRP.Commands._kPRK.Custom = true
_53tRP.Commands._kPRK.Id = "2809e8f6-da47-4180-a550-b28b18844607"
_53tRP.Commands._kPRK.WorksWithAll = true
_53tRP.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_53tRP.Locked = false
_53tRP.Opened = false
_jKP = Wherigo.ZItem(var_cartridge)
_jKP.Id = "aa32c03d-8a71-4ca5-9e5b-e0c15780899e"
_jKP.Name = _p0t("/T>>TG")
_jKP.Description = ""
_jKP.Visible = true
_jKP.Media = __xnY
_jKP.Icon = _25EQs
_jKP.Commands = {
  _oE0U = Wherigo.ZCommand({
    Text = _p0t("GT|T\017"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _2M6 = Wherigo.ZCommand({
    Text = _p0t("8\017f\014\006;f8\017|YyG8BT\017"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _zXhf0 = Wherigo.ZCommand({
    Text = _p0t("FT;;TA||T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _JgN = Wherigo.ZCommand({
    Text = _p0t("`8rAT;,GATBT;f=8|>TG\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_jKP.Commands._oE0U.Custom = true
_jKP.Commands._oE0U.Id = "b088c448-b136-4b4f-9366-ad99850e38ca"
_jKP.Commands._oE0U.WorksWithAll = true
_jKP.Commands._2M6.Custom = true
_jKP.Commands._2M6.Id = "e53e45d0-3942-4986-b96b-30b1bf619200"
_jKP.Commands._2M6.WorksWithAll = true
_jKP.Commands._zXhf0.Custom = true
_jKP.Commands._zXhf0.Id = "505d430d-c3fe-43c9-8ec2-cf3c955e957d"
_jKP.Commands._zXhf0.WorksWithAll = true
_jKP.Commands._JgN.Custom = true
_jKP.Commands._JgN.Id = "b46a4010-e8b8-4b50-a4ad-7dba6b616577"
_jKP.Commands._JgN.WorksWithAll = true
_jKP.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jKP.Locked = false
_jKP.Opened = false
_PUf = Wherigo.ZItem(var_cartridge)
_PUf.Id = "31397fa0-4992-4867-aee5-6f3c2ef2a9c1"
_PUf.Name = _p0t("K;8>T\017")
_PUf.Description = ""
_PUf.Visible = true
_PUf.Media = _r_bbI
_PUf.Icon = _H9Bf0
_PUf.Commands = {
  _x8r = Wherigo.ZCommand({
    Text = _p0t("\017Ty\028T\017"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _yxTTU = Wherigo.ZCommand({
    Text = _p0t("8\017|Yy86T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _rKR = Wherigo.ZCommand({
    Text = _p0t("T||T\017"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_PUf.Commands._x8r.Custom = true
_PUf.Commands._x8r.Id = "be93ea39-599a-400e-94cb-b45f14ea8731"
_PUf.Commands._x8r.WorksWithAll = true
_PUf.Commands._yxTTU.Custom = true
_PUf.Commands._yxTTU.Id = "ec5e81e6-c7e8-45f2-ab08-f0e1998e8b7a"
_PUf.Commands._yxTTU.WorksWithAll = true
_PUf.Commands._rKR.Custom = true
_PUf.Commands._rKR.Id = "3cf35948-ac14-404c-8481-57901321ca70"
_PUf.Commands._rKR.WorksWithAll = true
_PUf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_PUf.Locked = false
_PUf.Opened = false
_viu9 = Wherigo.ZItem({Cartridge = var_cartridge, Container = _9uVW0})
_viu9.Id = "75dc1dc9-6fa7-4df7-a2fd-cd8d21e4f6dc"
_viu9.Name = _p0t("\015|TG")
_viu9.Description = ""
_viu9.Visible = false
_viu9.Media = _AqpJK
_viu9.Icon = _TYQ
_viu9.Commands = {
  _ywQD = Wherigo.ZCommand({
    Text = _p0t("8\017|Yy;TAT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _QKb = Wherigo.ZCommand({
    Text = _p0t("F6f,;T||T\017fBT=T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _HI_ = Wherigo.ZCommand({
    Text = _p0t("(8\021\006\017f48BT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _irMY = Wherigo.ZCommand({
    Text = _p0t("/\006Tr,Tf,GTYy>T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _fnIgQ = Wherigo.ZCommand({
    Text = _p0t("\015|TGf,;TAG8||T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_viu9.Commands._ywQD.Custom = true
_viu9.Commands._ywQD.Id = "03c48646-e91e-45ee-a051-9d559a3d68d5"
_viu9.Commands._ywQD.WorksWithAll = true
_viu9.Commands._QKb.Custom = true
_viu9.Commands._QKb.Id = "50003579-bb3f-4c4b-bb91-e166e0c20f1d"
_viu9.Commands._QKb.WorksWithAll = true
_viu9.Commands._HI_.Custom = true
_viu9.Commands._HI_.Id = "6baae50a-7e31-481f-9794-edfe1dc24c38"
_viu9.Commands._HI_.WorksWithAll = true
_viu9.Commands._irMY.Custom = true
_viu9.Commands._irMY.Id = "ff3a49a9-908a-45ff-92f9-e5aede566403"
_viu9.Commands._irMY.WorksWithAll = true
_viu9.Commands._fnIgQ.Custom = true
_viu9.Commands._fnIgQ.Id = "33797d29-f1fa-45c4-800a-ab746d409306"
_viu9.Commands._fnIgQ.WorksWithAll = true
_viu9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_viu9.Locked = false
_viu9.Opened = false
_fZz = Wherigo.ZItem(var_cartridge)
_fZz.Id = "e0c6cb86-858e-4848-ba00-8112f4b1ac9b"
_fZz.Name = _p0t("`|8G>T;")
_fZz.Description = ""
_fZz.Visible = false
_fZz.Media = _fJvl
_fZz.Icon = _87f3R
_fZz.Commands = {
  _mWES = Wherigo.ZCommand({
    Text = _p0t("8\017|Yy86T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _iS2RE = Wherigo.ZCommand({
    Text = _p0t("A\017f(ATf\022;ArrTfGTBT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _fZv = Wherigo.ZCommand({
    Text = _p0t("\021T;|YyT\017\rT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _mmcN = Wherigo.ZCommand({
    Text = _p0t("8\017\0288GT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_fZz.Commands._mWES.Custom = true
_fZz.Commands._mWES.Id = "b9e297f5-bd5b-4cac-8922-c27d33837ae9"
_fZz.Commands._mWES.WorksWithAll = true
_fZz.Commands._iS2RE.Custom = true
_fZz.Commands._iS2RE.Id = "64c3ae80-c11c-4ba6-ac82-3fc60b9c622a"
_fZz.Commands._iS2RE.WorksWithAll = true
_fZz.Commands._fZv.Custom = true
_fZz.Commands._fZv.Id = "30fb5bea-eba1-44eb-82d8-8a6adf1bfcfe"
_fZz.Commands._fZv.WorksWithAll = true
_fZz.Commands._mmcN.Custom = true
_fZz.Commands._mmcN.Id = "cd7d48d5-f712-4fb7-a6f8-b241e6c3febb"
_fZz.Commands._mmcN.WorksWithAll = true
_fZz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fZz.Locked = false
_fZz.Opened = false
_zVIl = Wherigo.ZItem(var_cartridge)
_zVIl.Id = "522d8941-7dbb-4899-b0b2-81fe465ba75c"
_zVIl.Name = _p0t("\0246>>T;\r;ArrT")
_zVIl.Description = ""
_zVIl.Visible = false
_zVIl.Media = _zXE
_zVIl.Icon = _4Jyjr
_zVIl.Commands = {
  _Uds = Wherigo.ZCommand({
    Text = _p0t("6\028|>\006||T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _Oypri = Wherigo.ZCommand({
    Text = _p0t("|86=T;f\0288YyT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _tc1rG = Wherigo.ZCommand({
    Text = _p0t("8\017=;T\017\017T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_zVIl.Commands._Uds.Custom = true
_zVIl.Commands._Uds.Id = "8ef1fc77-f1b5-43cb-a4a7-7b992ca4bec2"
_zVIl.Commands._Uds.WorksWithAll = true
_zVIl.Commands._Oypri.Custom = true
_zVIl.Commands._Oypri.Id = "92f4f2e4-40d4-4f36-81e0-627670a2f333"
_zVIl.Commands._Oypri.WorksWithAll = true
_zVIl.Commands._tc1rG.Custom = true
_zVIl.Commands._tc1rG.Id = "6735ebd8-2a2a-45e2-82db-2c3a724549c1"
_zVIl.Commands._tc1rG.WorksWithAll = true
_zVIl.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zVIl.Locked = false
_zVIl.Opened = false
_A7tU = Wherigo.ZItem(var_cartridge)
_A7tU.Id = "d92ae034-24e2-45f5-b5e8-f80ff6f1f483"
_A7tU.Name = _p0t("D8,T;")
_A7tU.Description = ""
_A7tU.Visible = false
_A7tU.Media = _SOtt
_A7tU.Icon = _SDWh
_A7tU.Commands = {
  _zmD = Wherigo.ZCommand({
    Text = _p0t("A\017f\022;ArrTfGTBT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _1cm8 = Wherigo.ZCommand({
    Text = _p0t("A\017f`|8G>T;fGTBT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _Cnt = Wherigo.ZCommand({
    Text = _p0t("FT;>;8\028rTG\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _0ezl = Wherigo.ZCommand({
    Text = _p0t("(T\017f\01486=T\017fBT=T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_A7tU.Commands._zmD.Custom = true
_A7tU.Commands._zmD.Id = "55297e9e-5f40-4203-9f21-0d195841e636"
_A7tU.Commands._zmD.WorksWithAll = true
_A7tU.Commands._1cm8.Custom = true
_A7tU.Commands._1cm8.Id = "7be71211-3b75-40da-adf4-77fdd8d890ba"
_A7tU.Commands._1cm8.WorksWithAll = true
_A7tU.Commands._Cnt.Custom = true
_A7tU.Commands._Cnt.Id = "a4334219-0c3b-4a45-8e32-29fd58c546c4"
_A7tU.Commands._Cnt.WorksWithAll = true
_A7tU.Commands._0ezl.Custom = true
_A7tU.Commands._0ezl.Id = "32aea34b-bdc4-4a73-93eb-bcba26609b46"
_A7tU.Commands._0ezl.WorksWithAll = true
_A7tU.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_A7tU.Locked = false
_A7tU.Opened = false
_g9Y = Wherigo.ZItem(var_cartridge)
_g9Y.Id = "7a8c2d87-1e43-49ec-8f19-da552d35d462"
_g9Y.Name = _p0t("t>8GGf8\028f\b\006>T\017f\0146;\028")
_g9Y.Description = ""
_g9Y.Visible = true
_g9Y.Media = _CJTyK
_g9Y.Icon = _X_wxp
_g9Y.Commands = {
  _HvkwV = Wherigo.ZCommand({
    Text = _p0t("6\028|Yy86T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_g9Y.Commands._HvkwV.Custom = true
_g9Y.Commands._HvkwV.Id = "ace5b797-e5e3-4c70-9383-6f8f4dfbc0da"
_g9Y.Commands._HvkwV.WorksWithAll = true
_g9Y.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g9Y.Locked = false
_g9Y.Opened = false
_b_Z = Wherigo.ZItem(var_cartridge)
_b_Z.Id = "a219c0b3-37e5-474f-8f40-26f1dff766a6"
_b_Z.Name = _p0t("\024GTA|Yy=8\017\r")
_b_Z.Description = _p0t("\tG|f\024GTA|Yy=z8\017\rTfR6;(T\017fA\028fD\006Yylf6\017(ftrz8>\028A>>TG8G>T;f(ATfFT\017>;8Gaf\028TA|>f8\028f 8;\r>rG8>FfTA\017T;ft>8(>fF6|8\028\028T\017BT,8||>T\017f T>FBT;lf6\017(f\024GTA|Yyy86T;|>z8\017(Tf=TFTAYy\017T>\030f[ATfK8\017\r,\006;\028fAy;T;f\\T;\r86,|>A|YyTfB8=fAy\017T\017f(T\017fv8\028T\017\030")
_b_Z.Visible = false
_b_Z.Media = _A9lO
_b_Z.Icon = _Gsg
_b_Z.Commands = {
  _Bpv = Wherigo.ZCommand({
    Text = _p0t("8\017|Yy86T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_b_Z.Commands._Bpv.Custom = true
_b_Z.Commands._Bpv.Id = "73f9c5e5-5d09-453d-b81e-851cf6aa5a0d"
_b_Z.Commands._Bpv.WorksWithAll = true
_b_Z.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_b_Z.Locked = false
_b_Z.Opened = false
_ZmYvd = Wherigo.ZItem({Cartridge = var_cartridge, Container = _bmj})
_ZmYvd.Id = "9347cb92-2090-4a2d-8de9-01ab29c32fa2"
_ZmYvd.Name = _p0t("~KT\017T(A\r>|rG8>F")
_ZmYvd.Description = _p0t("DAT;f,A\017(T>fA\017f(T;f\026T|YyAYy>Tf(T;f 8;\r>f\028A>f(T\017f\024GTA|Yy|>z8\017(T\017f|>8>>\030")
_ZmYvd.Visible = true
_ZmYvd.Media = _GV85L
_ZmYvd.Icon = _anW
_ZmYvd.Commands = {
  _gxfT = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_ZmYvd.Commands._gxfT.Custom = true
_ZmYvd.Commands._gxfT.Id = "2154f365-a2ae-468d-ad1c-9cabf42c0e88"
_ZmYvd.Commands._gxfT.WorksWithAll = true
_ZmYvd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ZmYvd.Locked = false
_ZmYvd.Opened = false
_tBbp = Wherigo.ZItem(var_cartridge)
_tBbp.Id = "88ed09ef-1538-40a6-aa81-60a6d9866c1d"
_tBbp.Name = _p0t("\022;T6FB8||T")
_tBbp.Description = ""
_tBbp.Visible = true
_tBbp.Media = _syu
_tBbp.Commands = {}
_tBbp.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tBbp.Locked = false
_tBbp.Opened = false
_nXmTQ = Wherigo.ZItem(var_cartridge)
_nXmTQ.Id = "33c0a42d-934f-46c1-93b3-5a18f5e207f5"
_nXmTQ.Name = _p0t("\b8>y86|B8||T")
_nXmTQ.Description = ""
_nXmTQ.Visible = true
_nXmTQ.Media = _L_MX
_nXmTQ.Commands = {}
_nXmTQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nXmTQ.Locked = false
_nXmTQ.Opened = false
_tEs = Wherigo.ZItem(var_cartridge)
_tEs.Id = "6daa1b43-e332-4555-b34f-b6310dc00917"
_tEs.Name = _p0t("RTA>T;T;fK;8>T\017")
_tEs.Description = ""
_tEs.Visible = true
_tEs.Media = _r_bbI
_tEs.Icon = _H9Bf0
_tEs.Commands = {}
_tEs.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tEs.Locked = false
_tEs.Opened = false
_7cN = Wherigo.ZItem(var_cartridge)
_7cN.Id = "b6999751-29d8-4413-a351-f4540521ebb5"
_7cN.Name = _p0t("J\017G\006Y\rY\006(T")
_7cN.Description = _p0t("DAT;f\r8\017\017|>f(6f(A;f(TA\017T\017fJ\017G\006Y\rl3\006(Tf,z6;f(ATf\003\006B|f86,fRyT;AB\006\030Y\006\028f8\017FTABT\017fG8||T\017\030")
_7cN.Visible = false
_7cN.Media = _qYte
_7cN.Icon = _bbOz
_7cN.Commands = {
  _3mNnL = Wherigo.ZCommand({
    Text = _p0t("3\006(Tf8\017FTABT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_7cN.Commands._3mNnL.Custom = true
_7cN.Commands._3mNnL.Id = "c7a3ec69-d90d-4a67-b25f-3e96edadb7d8"
_7cN.Commands._3mNnL.WorksWithAll = true
_7cN.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_7cN.Locked = false
_7cN.Opened = false
_pV6DJ = Wherigo.ZItem(var_cartridge)
_pV6DJ.Id = "0dcc595d-9420-4bcb-874b-3b9278075f6e"
_pV6DJ.Name = _p0t("\t6|RT;>6\017B")
_pV6DJ.Description = _p0t("DAT;f,A\017(T>f|AYyfTA\017Tf\rGTA\017Tf\t6|RT;>6\017Bfz6=T;f(ATfBTG86,T\017Tf\b6\017(T\030f\\ATGftr8z|f=TA\028f\003T|T\017\030")
_pV6DJ.Visible = false
_pV6DJ.Media = _ZG0y0
_pV6DJ.Icon = _AvSR
_pV6DJ.Commands = {
  _pB0 = Wherigo.ZCommand({
    Text = _p0t(",8G|YyTf\015A\017B8=T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _PaV8 = Wherigo.ZCommand({
    Text = _p0t("vT6BAT;"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _PdN = Wherigo.ZCommand({
    Text = _p0t("tYy8=T;\0178Y\r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_pV6DJ.Commands._pB0.Custom = true
_pV6DJ.Commands._pB0.Id = "4619bf01-48c3-402b-9c0e-b7ccd4bdae89"
_pV6DJ.Commands._pB0.WorksWithAll = true
_pV6DJ.Commands._PaV8.Custom = true
_pV6DJ.Commands._PaV8.Id = "f266c2fb-11a4-4f9d-a5ae-6d1090ffb5f1"
_pV6DJ.Commands._PaV8.WorksWithAll = true
_pV6DJ.Commands._PdN.Custom = true
_pV6DJ.Commands._PdN.Id = "2ec450e2-28b3-4872-8019-d3404cabfa29"
_pV6DJ.Commands._PdN.WorksWithAll = true
_pV6DJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_pV6DJ.Locked = false
_pV6DJ.Opened = false
_R4u = Wherigo.ZItem({Cartridge = var_cartridge, Container = _7K7j})
_R4u.Id = "92a08eeb-cb1c-49c1-a130-10f663ffeaa3"
_R4u.Name = _p0t("~[T\017\r\0288G")
_R4u.Description = _p0t("[T;f\026;6\017(f6\017(fS(TT\017BT=T;f,z6;f(AT|T|fnyT;AB\006fA|>f(AT|T|f[T\017\r\0288G\030")
_R4u.Visible = true
_R4u.Media = _FLe
_R4u.Icon = _anW
_R4u.Commands = {
  _9Ae = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_R4u.Commands._9Ae.Custom = true
_R4u.Commands._9Ae.Id = "d8be89b4-44b1-4a12-b725-510a9d436607"
_R4u.Commands._9Ae.WorksWithAll = true
_R4u.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_R4u.Locked = false
_R4u.Opened = false
_g3lRn = Wherigo.ZItem(var_cartridge)
_g3lRn.Id = "5dc11abd-22d8-41dc-9cbd-822f3aa3b07f"
_g3lRn.Name = _p0t("t>8>A|>A\r")
_g3lRn.Description = _p0t("t>8>A|>A\rf,z6;fS\017>T;T||AT;>TfBA=>fT|f86YyfyAT;\030f[ATf\t\017B8=T\017f|A\017(f\006y\017Tf\026TRz8y;\030")
_g3lRn.Visible = false
_g3lRn.Media = _Jg3Ux
_g3lRn.Icon = _k3W
_g3lRn.Commands = {
  _qOC3 = Wherigo.ZCommand({
    Text = _p0t("8\017FTABT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_g3lRn.Commands._qOC3.Custom = true
_g3lRn.Commands._qOC3.Id = "49f1f9e1-3f30-4b54-b613-aac6e1557862"
_g3lRn.Commands._qOC3.WorksWithAll = true
_g3lRn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g3lRn.Locked = false
_g3lRn.Opened = false
_jF44F = Wherigo.ZItem(var_cartridge)
_jF44F.Id = "4af06bfa-a6e3-492c-b38c-d28c20cdc406"
_jF44F.Name = _p0t("trATGf=TT\017(T\017")
_jF44F.Description = _p0t("DAT;f,A\017(T>f|AYyfTA\017Tf\nr>A\006\017af6\028f(8|ftrATGf\006;(T\017>GAYyfF6f=TT\017(T\017\030fKTAf\0268;\028A\017|f,6\017\r>A\006\017AT;>f(AT|fR\006yGf\017AYy>\030f[8=TAf|\006GG>TfA\028fnyT;AB\006\021T;FTAYy\017A|fTA\017Tf\030BR|l[8>TAfT;|>TGG>fRT;(T\017\030f[AT|Tf\r8\017\017f86,fRyT;AB\006\030Y\006\028fy\006YyBTG8(T\017fRT;(T\017af6\028f(\006;>fTA\017T\017f\003\006BfF6f\0288YyT\017\030")
_jF44F.Visible = true
_jF44F.Media = _OphFV
_jF44F.Icon = _kReOj
_jF44F.Commands = {
  _B6rR9 = Wherigo.ZCommand({
    Text = _p0t("trATGf=TT\017(T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_jF44F.Commands._B6rR9.Custom = true
_jF44F.Commands._B6rR9.Id = "28c9fc79-99bb-4c44-8bb0-df78f72405f7"
_jF44F.Commands._B6rR9.WorksWithAll = true
_jF44F.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jF44F.Locked = false
_jF44F.Opened = false
_jab = Wherigo.ZItem(var_cartridge)
_jab.Id = "c1c6615b-a91f-4cba-af98-64eb062579e7"
_jab.Name = _p0t("~ A\rRT")
_jab.Description = _p0t("[8f(AT|Tf A\rRTfKT;z6y\028>yTA>fT;G8\017B>fy8>afBA=>fT|fyAT;fTA\017ABTfS\017,\006;\0288>A\006\017T\017f(8;z6=T;\030^K\be")
_jab.Visible = true
_jab.Media = _O3P
_jab.Icon = _anW
_jab.Commands = {
  _f6S9d = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_jab.Commands._f6S9d.Custom = true
_jab.Commands._f6S9d.Id = "f9f2c8ad-d5bb-49af-8db8-71443dc89a2e"
_jab.Commands._f6S9d.WorksWithAll = true
_jab.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jab.Locked = false
_jab.Opened = false
_AiKY = Wherigo.ZItem(var_cartridge)
_AiKY.Id = "09474040-b3d1-40f4-bae5-14297d810449"
_AiKY.Name = _p0t("~\t6B6|>A\017T;")
_AiKY.Description = _p0t("[8|f\026T=z86(Tf=T,A\017(T>f|AYyfA\017f(T;fD\006;\017B8||Tf6\017(fR8;f,;z6yT;f(8|fJ\017A\021T;|A>z8>|y\006|rA>8G\030fDAT;fBA=>fT|fS\017,\006;\0288>A\006\017T\017f(8;z6=T;\030")
_AiKY.Visible = true
_AiKY.Media = _JILu
_AiKY.Icon = _anW
_AiKY.Commands = {
  _BKEsJ = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_AiKY.Commands._BKEsJ.Custom = true
_AiKY.Commands._BKEsJ.Id = "92d9fc1c-91a3-46c2-838d-72e080045f55"
_AiKY.Commands._BKEsJ.WorksWithAll = true
_AiKY.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_AiKY.Locked = false
_AiKY.Opened = false
_tDRZa = Wherigo.ZItem({Cartridge = var_cartridge, Container = _bmj})
_tDRZa.Id = "aff95d33-ab80-4470-bcfb-9119a6876315"
_tDRZa.Name = _p0t("~KT\017T(A\r>A\rA;YyT")
_tDRZa.Description = _p0t("n\006yT;f(AT|T;f`G8>Ff|TA\017T\017fv8\028T\017fy8>fT;,z8y;|>f(6fA\017f(T;fS\017,\006;\0288>A\006\017\030")
_tDRZa.Visible = true
_tDRZa.Media = _Ot0Xy
_tDRZa.Icon = _anW
_tDRZa.Commands = {
  _mHFYc = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_tDRZa.Commands._mHFYc.Custom = true
_tDRZa.Commands._mHFYc.Id = "ee21bbb0-4d97-4631-910c-92354d4c8a02"
_tDRZa.Commands._mHFYc.WorksWithAll = true
_tDRZa.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tDRZa.Locked = false
_tDRZa.Opened = false
_ObQ = Wherigo.ZItem({Cartridge = var_cartridge, Container = _9uVW0})
_ObQ.Id = "2b7f1e69-32bb-4cdc-b77a-fac78351749f"
_ObQ.Name = _p0t("~z\tBA(AT\017\rA;YyT")
_ObQ.Description = _p0t("\014AGGfz6=T;\0178Yy>T>Tf6;|r;z6\017BGAYyfA\028f\0268|>y86|f*/6\028f\0146;\028*\030fDAT;f(AT\017>f6\017|f(T;f*\b\006>Tf\0146;\028*f8G|fRz6;(ABT;f\015;|8>F\030")
_ObQ.Visible = true
_ObQ.Media = _Q9K2e
_ObQ.Icon = _anW
_ObQ.Commands = {
  _HkT = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_ObQ.Commands._HkT.Custom = true
_ObQ.Commands._HkT.Id = "2c173955-0ed8-4471-9c41-2f187d55088a"
_ObQ.Commands._HkT.WorksWithAll = true
_ObQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ObQ.Locked = false
_ObQ.Opened = false
_6RPeV = Wherigo.ZItem({Cartridge = var_cartridge, Container = _9uVW0})
_6RPeV.Id = "3ca128ac-61aa-4768-941d-5cb925be0a26"
_6RPeV.Name = _p0t("~nT\017ABT\0288;\r>")
_6RPeV.Description = _p0t("\t\028fnT\017ABT\0288;\r>f,A\017(T>f|AYyf(T;f\b\006>Tf\0146;\028\030f.\017=|ro\015;f(AT\017>f8G|f\015;|8>Ff,z6;f(8|f\0268|>y86|f*/6\028f\0146;\028*fA\017f(T;f\026T|YyAYy>T\030^K\be^K\be")
_6RPeV.Visible = true
_6RPeV.Media = _Q9K2e
_6RPeV.Icon = _anW
_6RPeV.Commands = {
  _Sg_ = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_6RPeV.Commands._Sg_.Custom = true
_6RPeV.Commands._Sg_.Id = "405d180b-2cb6-42f0-8a71-37ce7051fb40"
_6RPeV.Commands._Sg_.WorksWithAll = true
_6RPeV.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_6RPeV.Locked = false
_6RPeV.Opened = false
_Yyy = Wherigo.ZItem(var_cartridge)
_Yyy.Id = "8bf6b303-77da-44fb-99f6-6397ceaa7ab9"
_Yyy.Name = _p0t("~\b8>y86|")
_Yyy.Description = _p0t("nA;f=T,A\017(T\017f6\017|fyAT;fyA\017>T;f(T\028f\b8>y86|f(T;ft>8(>\030f[T|y8G=f86YyfyAT;\021\006\017fTA\017ABTfS\017,\006;\0288>A\006\017T\017\030")
_Yyy.Visible = true
_Yyy.Media = _traB6
_Yyy.Icon = _anW
_Yyy.Commands = {
  _2Ivf = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_Yyy.Commands._2Ivf.Custom = true
_Yyy.Commands._2Ivf.Id = "69af8466-13b8-43e6-8bf2-a535600d4a56"
_Yyy.Commands._2Ivf.WorksWithAll = true
_Yyy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Yyy.Locked = false
_Yyy.Opened = false
_gGA = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
_gGA.Id = "dfbad0d5-317a-4019-9b70-1bf45ac78c5d"
_gGA.Name = _p0t("\014\006\017fTA\017BT|Yy8G>T>")
_gGA.Description = _p0t("\015|fRA;(f=TAf4T(T\028fKT>;T>T\017fTA\017T;f/\006\017TfTA\017ft\0066\017(f8=BT|rATG>\030f")
_gGA.Visible = true
_gGA.Media = _X9w_
_gGA.Icon = _p1cj
_gGA.Commands = {
  _Rx_7 = Wherigo.ZCommand({
    Text = _p0t("\014\006\017f86||Yy8G>T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  }),
  _epdtK = Wherigo.ZCommand({
    Text = _p0t("\014\006\017f8=|rATGT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_gGA.Commands._Rx_7.Custom = true
_gGA.Commands._Rx_7.Id = "f9617ac6-497c-417f-84bd-75e578b6cc94"
_gGA.Commands._Rx_7.WorksWithAll = true
_gGA.Commands._epdtK.Custom = true
_gGA.Commands._epdtK.Id = "e638bf81-0b95-4612-9913-dabcdb115b87"
_gGA.Commands._epdtK.WorksWithAll = true
_gGA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_gGA.Locked = false
_gGA.Opened = false
_4NYMd = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
_4NYMd.Id = "f480583b-e744-4b5f-8cb0-6a85a2bfacb6"
_4NYMd.Name = _p0t("\014\006\017f86|BT|Yy8G>T>")
_4NYMd.Description = _p0t("\015|fRA;(f\rTA\017f\014\006\017f=TA\028fKT>;T>T\017f(T;f/\006\017T\017f8=BT|rATG>\030")
_4NYMd.Visible = false
_4NYMd.Media = _nxu
_4NYMd.Icon = _on8Ry
_4NYMd.Commands = {
  _hgIk_ = Wherigo.ZCommand({
    Text = _p0t("\014\006\017fTA\017|Yy8G>T\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_4NYMd.Commands._hgIk_.Custom = true
_4NYMd.Commands._hgIk_.Id = "4672dffb-9ad0-4f22-9a63-6e4996604205"
_4NYMd.Commands._hgIk_.WorksWithAll = true
_4NYMd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_4NYMd.Locked = false
_4NYMd.Opened = false
_Voli = Wherigo.ZItem(var_cartridge)
_Voli.Id = "56186acf-323b-4f96-93bd-bcf1a7958727"
_Voli.Name = _p0t("~\t;\028T\017=6;|T\017")
_Voli.Description = _p0t("[ATfDz86|T;f=T,A\017(T\017f|AYyfA\028f\022;T6F|8\017(f\bAYy>6\017Bft>6(T\017>T\017B8||Tf6\017(f;8BT\017fz6=T;f(8|fn8||T;\030")
_Voli.Visible = true
_Voli.Media = _syu
_Voli.Icon = _anW
_Voli.Commands = {
  _CfNoE = Wherigo.ZCommand({
    Text = _p0t("S\017,\006;\0288>A\006\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_Voli.Commands._CfNoE.Custom = true
_Voli.Commands._CfNoE.Id = "2cdcd9a5-3e75-4167-a296-1abc15be72f7"
_Voli.Commands._CfNoE.WorksWithAll = true
_Voli.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Voli.Locked = false
_Voli.Opened = false
_9SV = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
_9SV.Id = "7b8cf1e1-8a7c-46ec-8532-16c19ee3e353"
_9SV.Name = _p0t("DAG,|\028A>>TG")
_9SV.Description = _p0t("[8|fDAG,|\028A>>TGf=T,A\017(T>f|AYyf\006=T;y8G=f(T|ftYyG\006||T|f6\017>T;f(T\028fD8\017(G86,f(T|f\026TG8T\017(T;|\030")
_9SV.Visible = false
_9SV.Media = _VvPs
_9SV.Icon = _Hvo
_9SV.Commands = {}
_9SV.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_9SV.Locked = false
_9SV.Opened = false
_7bUr = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
_7bUr.Id = "f4f79c52-395b-439d-add1-f16195a82d34"
_7bUr.Name = _p0t("tr\006AGT;")
_7bUr.Description = _p0t("t\006GG>T|>f(6f\017\006Yyf\0178Yyf(T\028ftYyG\006||f|6YyT\017f\006(T;f(8|fDAG,|\028A>>TGf=;86YyT\017af,A\017(T>f|AYyfyAT;f(T;ftr\006AGT;\030")
_7bUr.Visible = false
_7bUr.Media = _NdZu2
_7bUr.Commands = {
  _ZJHn = Wherigo.ZCommand({
    Text = _p0t("8\017FTABT\017"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _p0t("vAYy>f\021T;,6B=8;")
  })
}
_7bUr.Commands._ZJHn.Custom = true
_7bUr.Commands._ZJHn.Id = "e482f2e0-5a4d-460b-b091-4baaf799f93e"
_7bUr.Commands._ZJHn.WorksWithAll = true
_7bUr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_7bUr.Locked = false
_7bUr.Opened = false
_Ubz_A = Wherigo.ZTask(var_cartridge)
_Ubz_A.Id = "8a4b440c-ecd5-422d-b748-2c3a8432350c"
_Ubz_A.Name = _p0t("\t\017\r6\017,>f\r6\017(BT=T\017")
_Ubz_A.Description = _p0t("[8\028A>f4T\0288\017(fA\017f(T;ft>8(>f\021\006\017f\014AGG|f\t\017\r6\017,>fT;,z8y;>af\0286||f(AT|T;f|TA\017T\017f/T>>TGfz\006,,T\017>GAYyf8\017=;A\017BT\017\030")
_Ubz_A.Visible = false
_Ubz_A.Media = __xnY
_Ubz_A.Active = false
_Ubz_A.Complete = false
_Ubz_A.CorrectState = "None"
_xSTpR = Wherigo.ZTask(var_cartridge)
_xSTpR.Id = "7ced782c-b530-43a1-a142-fee4ae25ac99"
_xSTpR.Name = _p0t("\tG>TfJ\017Af,A\017(T\017")
_xSTpR.Description = _p0t("[ATf\tG>TfJ\017A\021T;|A>z8>f=T,A\017(T>f|AYyfA\017f(T;f AYy8TGA||>;8z|T\030ftATf|\006GG>Tf\017AYy>fF6fz6=T;|TyT\017f|TA\017\030f\t6Yyf\014AGGfRA;|>f(6f(\006;>f8\017>;T,,T\017afT;fR8;>T>f|AYyT;f|Yy\006\017f86,f(AYy\030")
_xSTpR.Visible = true
_xSTpR.Media = _LXqy
_xSTpR.Icon = _P7i
_xSTpR.Active = true
_xSTpR.Complete = false
_xSTpR.CorrectState = "None"
_8zMo = Wherigo.ZTask(var_cartridge)
_8zMo.Id = "420b6360-8601-4f34-b58a-e36d26ece528"
_8zMo.Name = _p0t("KT\017T(A\r>|rG8>Ff,A\017(T\017")
_8zMo.Description = _p0t("[ATf AYy8TGA||>;8z|Tf,z6y;>f(A;T\r>fF6\028fKT\017T(A\r>|rG8>F\030")
_8zMo.Visible = false
_8zMo.Media = _GV85L
_8zMo.Active = false
_8zMo.Complete = false
_8zMo.CorrectState = "None"
_LyE26 = Wherigo.ZTask(var_cartridge)
_LyE26.Id = "1c4c98b7-683b-4299-9099-0312232de2e5"
_LyE26.Name = _p0t("K;8>T\017f=T|\006;BT\017")
_LyE26.Description = _p0t("nT;fD6\017BT;fy8>f\0286||fT||T\017\030fnT;f\017AYy>|fF6fT||T\017fy8>af=T|\006;B>f|AYyfT>R8|\030")
_LyE26.Visible = false
_LyE26.Media = _r_bbI
_LyE26.Active = false
_LyE26.Complete = false
_LyE26.CorrectState = "None"
_tle = Wherigo.ZTask(var_cartridge)
_tle.Id = "196ba8de-1a4a-4c35-bc03-a1ba231df668"
_tle.Name = _p0t("\022;T6FB8||Tf(6;YyG86,T\017")
_tle.Description = _p0t("J=T;f\022;T6FB8||Tf6\017(fD\006;\017B8||TfG86,T\017(afGz8||>f|AYyf|Ty;f|Yyz\006\017fTA\017fKGAY\rf86,f(ATftTA>Tf(T;f\022;z8\028T;=;z6Y\rTfRT;,T\017\030")
_tle.Visible = false
_tle.Active = false
_tle.Complete = false
_tle.CorrectState = "None"
_5G1lR = Wherigo.ZTask(var_cartridge)
_5G1lR.Id = "1e974b98-59fc-43c2-a9d5-b42d18dcfd4f"
_5G1lR.Name = _p0t("K;8>T\017fT||T\017")
_5G1lR.Description = _p0t("[T;fK;8>T\017fA|>fF6\028f\015||T\017f(8af8G|\006f;TA\017=TAz|T\017f6\017(fBT\017ATz|T\017\030\030")
_5G1lR.Visible = false
_5G1lR.Media = _r_bbI
_5G1lR.Active = false
_5G1lR.Complete = false
_5G1lR.CorrectState = "None"
_zgAQO = Wherigo.ZTask(var_cartridge)
_zgAQO.Id = "dc52784c-132a-45d2-9001-f6dbdab94241"
_zgAQO.Name = _p0t("BTyTfF6\028f\b\006>T\017f\0146;\028")
_zgAQO.Description = _p0t("zJ=T;f(ATfD\006;\017B8||Tf6\017(f(8\017\017f\0178Yyf;TYy>|fA\017f(ATf\026\006>>y8;(>|>;8z|Tf.\017=|ro8==ATBT\017afGz8||>f|AYyf|Ty;f|Yyz\006\017f(T;f\b\006>Tf\0146;\028fT;;TAYyT\017\030fnz8y;T\017(f(AT|T|f\rGTA\017T\017ftr8FAT;B8\017BT|f\r8\017\017f(T;fyA\017>T;Tf\014TAGf(T;f\022;z8\028T;=;z6Y\rTf=T>;8Yy>T>fRT;(T\017\030")
_zgAQO.Visible = false
_zgAQO.Active = false
_zgAQO.Complete = false
_zgAQO.CorrectState = "None"
_LWq0G = Wherigo.ZTask(var_cartridge)
_LWq0G.Id = "5c021848-213a-4853-9953-9ef898b0f52f"
_LWq0G.Name = _p0t("RTA>T;T\017fK;8>T\017fy\006GT\017")
_LWq0G.Description = _p0t("KTA\028f T>FBT;fBAG>fT|fT;\017T6>fTA\017T\017fK;8>T\017fF6fT;B86\017T;\017\030")
_LWq0G.Visible = false
_LWq0G.Media = _r_bbI
_LWq0G.Active = false
_LWq0G.Complete = false
_LWq0G.CorrectState = "None"
_vfvQq = Wherigo.ZTask(var_cartridge)
_vfvQq.Id = "4d48ef71-0272-4026-ab0f-625b9948d15d"
_vfvQq.Name = _p0t("\015|TGfGT|T\017fGT;\017T\017")
_vfvQq.Description = _p0t("[T;f\015|TGfy8>fT>R8|fF6fGT;\017T\017f6\017(f\014AGGf=;86Yy>f(TA\017TfDAG,Tf=TAf(T;f\003Ty;|>6\017(T\030")
_vfvQq.Visible = false
_vfvQq.Active = false
_vfvQq.Complete = false
_vfvQq.CorrectState = "None"
_9iT51 = Wherigo.ZTask(var_cartridge)
_9iT51.Id = "768ea512-3422-4316-bfd0-1f801dac3e18"
_9iT51.Name = _p0t("\t6,>;8BfT;y8G>T\017")
_9iT51.Description = _p0t("[ATfnT;=6\017Bfy8>>Tf\015;,\006GB\030f[T;f\bT\r>\006;fA|>f86,f(T;ft6YyTf\0178Yyf\014AGGf6\017(fy8>fTA\017Tf\t6,B8=Tf,z6;fAy\017\030fJ\017(f4T(T;f(T;f=TA(T\017f\0288Yy>f|AYyf|TA\017TfTABT\017T\017f\026T(8\017\rT\017f(8F6\030")
_9iT51.Visible = false
_9iT51.Active = false
_9iT51.Complete = false
_9iT51.CorrectState = "None"
_gYvfD = Wherigo.ZTask(var_cartridge)
_gYvfD.Id = "343c8ef6-2d2c-44c8-bb7e-c7810a5c0643"
_gYvfD.Name = _p0t("T;\017T6>fF6\028fKT\017T(A\r>|rG8>F")
_gYvfD.Description = _p0t("zJ=T;f(ATf\022;z8\028T;=;z6Y\rTfG86,T\017(afGz8z|>f|AYyf(8|f\024G8A;f(T;f=T=86>T\017fK;z6Y\rTfBT\017ATz|T\017f6\017(f8\017f(T;T\017f\015\017(Tf,A\017(T>f|AYyfRAT(T;f(T;fKT\017T(A\r>|rG8>F\030")
_gYvfD.Visible = false
_gYvfD.Media = _GV85L
_gYvfD.Active = false
_gYvfD.Complete = false
_gYvfD.CorrectState = "None"
_5d_ = Wherigo.ZTask(var_cartridge)
_5d_.Id = "f5d2a09a-a70b-4cc2-a9fa-288e4c1f3e4e"
_5d_.Name = _p0t("\bT\r>\006;f=T;AYy>T\017")
_5d_.Description = _p0t("[T;f\bT\r>\006;f|\006GG>Tf\0176\017fT;,8y;T\017af(8||f(T;f\015|TGfT;|>Tf\003T;\017T;,\006GBTfBTFTAB>fy8>\030")
_5d_.Visible = false
_5d_.Active = false
_5d_.Complete = false
_5d_.CorrectState = "None"
_IslI = Wherigo.ZTask(var_cartridge)
_IslI.Id = "6e862427-b50b-4203-8d64-27690466e753"
_IslI.Name = _p0t("\b8>y86|B8||Tf(6;YyG86,T\017")
_IslI.Description = _p0t("S\017f(T;f\b8>y86|B8||TfBA=>fT|fTA\017f[T\017\r\0288GfF6;f\015;A\017\017T;6\017Bf8\017f\014AGGf\0156GT\017|rATBTG\030f[AT|T|fBAG>fT|fF6f,A\017(T\017\030")
_IslI.Visible = false
_IslI.Media = _L_MX
_IslI.Active = false
_IslI.Complete = false
_IslI.CorrectState = "None"
_XYT = Wherigo.ZTask(var_cartridge)
_XYT.Id = "8ee0f37a-4661-4fc6-84a7-53607a25d630"
_XYT.Name = _p0t("\015|TGr;6T,6\017Bf8=GTBT\017")
_XYT.Description = _p0t("[T;f\015|TGf\0286||f\0176\017fFTABT\017afR8|fT;fBTGT;\017>fy8>\030f[T;f\bT\r>\006;fA|>fBT|r8\017\017>f6\017(fRAGGf(T\017f\015|TGfGT|T\017f|TyT\017\030")
_XYT.Visible = false
_XYT.Active = false
_XYT.Complete = false
_XYT.CorrectState = "None"
_7XM2 = Wherigo.ZTask(var_cartridge)
_7XM2.Id = "ef4f93a6-c986-4222-8d89-17277d623349"
_7XM2.Name = _p0t("\015|TGf>T|>T\017")
_7XM2.Description = _p0t("[T;f\015|TGf|YyTA\017>f|TA\017Tf\003T\r>A\006\017fBTGT;\017>fF6fy8=T\017\030f\tGGT;(A\017B|f|\006GG>Tf(8|f\026TGT;\017>TfRAT(T;y\006G>fRT;(T\017af(8\028A>f(T;f\015|TGf\017AYy>|f\021T;BA||>\030")
_7XM2.Visible = false
_7XM2.Active = false
_7XM2.Complete = false
_7XM2.CorrectState = "None"
_Dop0n = Wherigo.ZTask(var_cartridge)
_Dop0n.Id = "11b469c0-2f0c-437e-be75-422e914f14d2"
_Dop0n.Name = _p0t("\015|TGf(ATf\024;TAyTA>f|YyT\017\rT\017")
_Dop0n.Description = _p0t("[6f=;86Yy|>f(T\017f\015|TGf\017AYy>f\028Ty;f6\017(f\r8\017\017|>fAy\017fA\017f(ATf\024;TAyTA>fT\017>G8||T\017\030")
_Dop0n.Visible = false
_Dop0n.Active = false
_Dop0n.Complete = false
_Dop0n.CorrectState = "None"
_pFrS = Wherigo.ZTask(var_cartridge)
_pFrS.Id = "e4ef853b-5119-4d9e-954e-f0b085274658"
_pFrS.Name = _p0t("\0038\017BTfK;z6Y\rTf,A\017(T\017")
_pFrS.Description = _p0t("\024A\017(Tf(ATft>;8z|Tf\0038\017BTfK;z6Y\rTaf(\006;>fBA=>fT|f86YyfTA\017Tf;AYy>ABTfK;z6Y\rT\030f[8f>;T,,T\017fRA;f6\017|fRAT(T;\030f.\017=|ro[6f\r8\017\017|>f(6;Yyf(ATf\b8>y86|B8||Taf`;T(ABT;|>;8z|Tf6\017(f`86G|>;8z|TfF6;ft>;8z|Tf\0038\017BTfK;z6Y\rTfBTG8\017BT\017\030")
_pFrS.Visible = false
_pFrS.Media = _YEYmm
_pFrS.Active = false
_pFrS.Complete = false
_pFrS.CorrectState = "None"
_1DGs = Wherigo.ZTask(var_cartridge)
_1DGs.Id = "d1a4bd98-61e5-4ab5-98f3-61682f1aeda8"
_1DGs.Name = _p0t("R8|f\0176\017'")
_1DGs.Description = _p0t("S\017f(T;ft>8(>fA|>f\014AGGf\0156GT\017|rATBTGf,T;>AB\030fn8|fRA;(fT;f\0176\017f\017\006Yyf\0288YyT\017fR\006GGT\017'")
_1DGs.Visible = false
_1DGs.Active = false
_1DGs.Complete = false
_1DGs.CorrectState = "None"
_fDS = Wherigo.ZTask(var_cartridge)
_fDS.Id = "fa1c05e4-cfe5-46e9-83ff-f3ced3406ee6"
_fDS.Name = _p0t("\026T(8\017\rT\017fGT|T\017")
_fDS.Description = _p0t("n8|fBTy>fR\006yGf4T>F>fA\017f(T\017f\022\006r,T\017f(T|f\014AGGf6\017(f(T|f\bT\r>\006;|f\021\006;'")
_fDS.Visible = false
_fDS.Active = false
_fDS.Complete = false
_fDS.CorrectState = "None"
_HcESI = Wherigo.ZTask(var_cartridge)
_HcESI.Id = "4b8bb397-8b5c-4eca-8c40-14db343beb2b"
_HcESI.Name = _p0t("RTA>T;T\017fK;8>T\017fT||T\017")
_HcESI.Description = _p0t("v6\017fy8=TfAYyf\028A;f86Yyf(T\017fFRTA>T\017fK;8>T\017fy\006GT\017f\rz\006\017\017T\017\030f[AT|T\017f\028z\006Yy>TfAYyf4T>F>f86YyfT||T\017\030")
_HcESI.Visible = false
_HcESI.Media = _r_bbI
_HcESI.Active = false
_HcESI.Complete = false
_HcESI.CorrectState = "None"
_vat = Wherigo.ZTask(var_cartridge)
_vat.Id = "79d6b1cd-850e-48cc-8ff9-66a6d52fd0bb"
_vat.Name = _p0t("\014|Yyz6||f|8BT\017")
_vat.Description = _p0t("DAT;fRA;(f\021T;8=|YyAT(T>\030")
_vat.Visible = false
_vat.Active = false
_vat.Complete = false
_vat.CorrectState = "None"
_8F9wM = Wherigo.ZTask(var_cartridge)
_8F9wM.Id = "7cfbf50f-431b-44fd-9d2b-ed3ebd2984b8"
_8F9wM.Name = _p0t("\t;\028T\017=6;|Tf,A\017(T\017")
_8F9wM.Description = _p0t("[ATf\t;\028T\017=6;|TfA|>fB6>fF6f,A\017(T\017afRT\017\017f(6fRTA>T;f(6;Yyf(T\017f\022;T6F|8\017(fG86,|>af\006y\017Tf(ATfK;z6Y\rTfF6fz6=T;q6T;T\017\030")
_8F9wM.Visible = false
_8F9wM.Media = _syu
_8F9wM.Active = false
_8F9wM.Complete = false
_8F9wM.CorrectState = "None"
_862 = Wherigo.ZTask(var_cartridge)
_862.Id = "5bd0456e-3783-46e1-94ac-ca21c878fc45"
_862.Name = _p0t("v8\028T")
_862.Description = ""
_862.Visible = true
_862.Active = false
_862.Complete = false
_862.CorrectState = "None"
_ycbE = 0
_EurAG = 0
_t6iCA = 0
_IAcno = 0
_xVf = 0
_g5cik = 0
_quEb = 0
_Ue2 = 0
_KXd = 0
_K15l = 0
_zFYo = 0
_1PT = 0
_Mnxxy = 0
_ROZ9z = 0
_YwmiO = 0
_tiFd = 0
_THT = 0
_ZbkPw = 0
_3DN = 0
_mzy88 = 0
_7XW = 0
_iMfF = 0
_vLxJ = 0
_P1P = 0
Gesamtstrecke = 0
Gesamtzeit = 0
zeit_verstrichen = 1
GesamtzeitGerundet = 0
_3NO = 0
_cD8 = 1
Gesamtzeitstunden = 0
GesamtstundenGerundet = 0
_JCB_7 = 1
cr = ""
_Jcs = _p0t("]A\0316[")
_WiHn7 = _p0t("]q+!Y")
_naQE = _p0t("]\006q6")
_NcxVx = _p0t("]J=F]\t")
_uxM = _p0t("]>`rY\n")
_BAz = _p0t("(6\028\028+")
var_cartridge.ZVariables = {
  _ycbE = 0,
  _EurAG = 0,
  _t6iCA = 0,
  _IAcno = 0,
  _xVf = 0,
  _g5cik = 0,
  _quEb = 0,
  _Ue2 = 0,
  _KXd = 0,
  _K15l = 0,
  _zFYo = 0,
  _1PT = 0,
  _Mnxxy = 0,
  _ROZ9z = 0,
  _YwmiO = 0,
  _tiFd = 0,
  _THT = 0,
  _ZbkPw = 0,
  _3DN = 0,
  _mzy88 = 0,
  _7XW = 0,
  _iMfF = 0,
  _vLxJ = 0,
  _P1P = 0,
  Gesamtstrecke = 0,
  Gesamtzeit = 0,
  zeit_verstrichen = 1,
  GesamtzeitGerundet = 0,
  _3NO = 0,
  _cD8 = 1,
  Gesamtzeitstunden = 0,
  GesamtstundenGerundet = 0,
  _JCB_7 = 1,
  cr = "",
  _Jcs = _p0t("]A\0316["),
  _WiHn7 = _p0t("]q+!Y"),
  _naQE = _p0t("]\006q6"),
  _NcxVx = _p0t("]J=F]\t"),
  _uxM = _p0t("]>`rY\n"),
  _BAz = _p0t("(6\028\028+")
}
_tPpcO = Wherigo.ZInput(var_cartridge)
_tPpcO.Id = "32b5eee1-8de1-4c00-91fb-72da999bb714"
_tPpcO.Name = _p0t("\0148,TGf\017T=T\017f(T\028f\014\006;")
_tPpcO.Description = ""
_tPpcO.Visible = true
_tPpcO.Media = _CyuJj
_tPpcO.InputType = "Text"
_tPpcO.Text = _p0t("t6YyTf\017T=T\017f(T\028f\014\006;f(T;f\tG>T\017fJ\017A\030f[AT|Tf/8yGfGA\017\r|f\006=T\017f6\017>T;f(T\028fn\006;>f*\tG>T*fr8||>f\017AYy>fRA;\rGAYyf86,f(ATf\0148,TGf\030\030\030f|TG>|8\028\030fn8|fA|>f(8|f,z6;fTA\017Tf/8yG'")
_GTTeH = Wherigo.ZInput(var_cartridge)
_GTTeH.Id = "6e26a1f4-f447-4698-9dc6-206a01662408"
_GTTeH.Name = _p0t("\0148,TGf8\017f(T;fK;6TY\rT")
_GTTeH.Description = ""
_GTTeH.Visible = true
_GTTeH.Media = _3ntrU
_GTTeH.InputType = "Text"
_GTTeH.Text = _p0t("n8\017\017f,8\017(f(ATf\022;z8\028T;=;z6Y\rTf(ATfT;|>Tf6;\r6\017(GAYyTf\015;Rz8y\0176\017Bf8G|fD\006GF=;z6Y\rT'")
_PR_g = Wherigo.ZInput(var_cartridge)
_PR_g.Id = "906c8640-722f-43b5-8b44-e649375307cb"
_PR_g.Name = _p0t("\024;8BTf\022;T6FB8||T")
_PR_g.Description = ""
_PR_g.Visible = true
_PR_g.Media = _syu
_PR_g.InputType = "Text"
_PR_g.Text = _p0t("\015A\017|>fR8;fyAT;fTA\017fS\017>T;\0178>afA\017f(T\028f\028A>>TGG\006|Tft>6(T\017>T\017f(T;f\015;,6;>T;fJ\017A\021T;|A>z8>f6\017>T;\r\006\028\028T\017f\r\006\017\017>T\017\030ftAYyT;fy8|>f(6f=T;TA>|fTA\017Tf\ty\0176\017BafR8|f\028AYyfyAT;fA\017>T;T||AT;T\017fRA;(\030fn8\017\017fR6;(T\017f(\006YyfBGTAYyf(ATft>6(T\017>T\017=6;|T\017f8G|f\t;\028T\017=6;|T\017fBT|>A,>T>'")
_XD_ = Wherigo.ZInput(var_cartridge)
_XD_.Id = "8d582654-cd64-46e5-a2e1-7d69542ed246"
_XD_.Name = _p0t("\024;8BTf\0148,TGf8\028fKT\017T(A\r>|rG8>F")
_XD_.Description = ""
_XD_.Visible = true
_XD_.Media = _f7N
_XD_.InputType = "Text"
_XD_.Text = _p0t("S\017fRTGYyT\028f}8y;f\021T;G\006;f(ATfKT\017T(A\r>A\rA;YyTfAy;ftYyA,,'")
_zepJh = Wherigo.ZInput(var_cartridge)
_zepJh.Id = "f18c3663-f606-424a-95ba-5717cd067c11"
_zepJh.Name = _p0t("\024;8BTf\014AGG|f[T\017\r\0288G")
_zepJh.Description = ""
_zepJh.Visible = true
_zepJh.Media = _FLe
_zepJh.InputType = "Text"
_zepJh.Text = _p0t("nTGYyTf/8yGf=T,A\017(T>f|AYyf6\017>T;f(T\017fS\017A>A8GT\017'")
_QQm = Wherigo.ZInput(var_cartridge)
_QQm.Id = "ed56713a-954e-4ea7-8e47-7fe17eaeec5c"
_QQm.Name = _p0t("\0148,TGf8\028f\b\006>T\017f\0146;\028")
_QQm.Description = ""
_QQm.Visible = true
_QQm.Media = _hHuJ2
_QQm.InputType = "Text"
_QQm.Text = _p0t("v6\017f\030\030\030fRATf\021ATGTfD\006>TGFA\028\028T;f=AT>T>f(8|fD86|fF6\028f\b\006>T\017f\0146;\028f8\017'")
function var_cartridge:OnStart()
  replace_alluml(var_cartridge)
  _Drls()
  _Urwigo.Dialog(false, {
    {
      Text = tostring(replace_uml("In den Items findet sich die M~oglichkeit den Sound ein- bzw auszuschalten. Dieser wird beim Betreten einer Zone abgespielt. (leider nicht von jedem Ger~at unterst~utzt)")),
      Media = _X9w_
    },
    {
      Text = tostring(replace_uml("Dieses Augen-Symbol vor den Items kennzeichnet zus~atzliche Informationen zu Sehensw~urdigkeiten an der jeweiligen Station unabh~angig von der Spielhandlung. Da dieses Symbol nicht auf allen Abspielger~aten angezeigt wird, sind Sehensw~urdigkeiten zus~atzlich durch + gekennzeichnet.")),
      Media = _z0iE
    },
    {
      Text = tostring(replace_uml("Hall~ole ... guten Tag ... gute Nacht ... oder wie auch immer du es gern h~attest. Ich bin der Till und gerade auf dem Weg aus dem fernen Prag nach Erfurt. In der dortigen Stadt wurde es recht ungem~utlich und ich musste mich schleunigst entfernen, dort hatte ich meine Sp~a~se wohl etwas zu wild getrieben. Lass uns doch in Erfurt an der Alten Universit~at treffen und etwas in der Stadt unternehmen.")),
      Media = _Y6Ad
    }
  }, function(action)
    _tarmy.Active = true
    _tarmy.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function var_cartridge:OnRestore()
end
function _iQuD:OnEnter()
  _Jcs = _p0t("]A\0316[")
  if _t6iCA < 1 then
    _Drls()
    _t6iCA = 1
    _mzy88 = 0
    _qy9c:MoveTo(_iQuD)
    _qy9c.Commands._y6C_.Enabled = true
    _jKP:MoveTo(Player)
    _jKP.Commands._oE0U.Enabled = true
    _jKP.Commands._2M6.Enabled = true
    _xSTpR.Complete = true
    _Ubz_A.Active = true
    _Ubz_A.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = (_p0t("D8GGAfD8GG\006fD\006GG8(;A\006f") .. Player.Name) .. replace_uml("!! Dein Weg war wohl lang oder warum kommst du jetzt erst? Nein Quatsch, ich bin auch noch nicht lange hier. Meine Reise aus Prag dauerte doch l~anger als erwartet. Die Alte Universit~at haben wir beide gefunden, doch bevor wir die Stadt unsicher machen, gebe ich dir mal ein paar Infos von dem Geb~aude hier, welche mir gerade ein Einheimischer ins Ohr gefl~ustert hat."),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("1392 wurde die Universit~at als F~unfte im deutschsprachigen Raum er~offnet. Schnell wuchs ihr Bekanntheitsgrad, da von Anfang an alle vier Fakult~aten zugelassen waren. Theologie, Jura, Medizin und Philosophie. Damals gab es nur diese vier Fachbereiche. 1816 wurde die Universit~at durch die preu~sische Regierung geschlossen. Erst 1994 kam es zu einer Neugr~undung, doch wegen fehlenden Platzes im Zentrum befinden sich die Universit~atsgeb~aude jetzt au~serhalb der Stadt.")),
        Media = _bFQA
      },
      {
        Text = tostring(replace_uml("Nun aber los, auch hier gel~ustet es mich bereits, etwas Schabernack zu treiben und du kannst mich gern dabei begleiten. Lass uns einen geeigneten Platz finden, um meinen Zettel anzubringen. Oh wie aufregend ... der Spa~s beginnt. Mit dem Zettel werde ich meine Ankunft bekannt geben. An der Universit~at finden sich sicher schlaue Leute, mit einem offenen Ohr f~ur meine Ideen.")),
        Media = _b7O
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _tiFd == 1 and _IAcno == 0 then
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Lass mal sehen, was an der Alten Universit~at noch zu erledigen ist.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  elseif _tiFd == 1 and _IAcno == 1 then
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Der Zettel h~angt und wir sind hier fertig. Lass uns weiter gehen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _iQuD:OnExit()
  _Jcs = _p0t("]A\0316[")
  _iMfF = _iMfF + 1
  if _IAcno == 0 then
    _tiFd = 1
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Habe ich nicht noch etwas vergessen? Es wei~s hier noch niemand von meiner Ankunft. Ich sollte meinen Zettel noch an das Tor h~angen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _IAcno == 1 then
    _iQuD.Active = false
    _iQuD.Visible = false
    _Ubz_A.Visible = false
    _xSTpR.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = ((replace_uml("!!! &nbsp;Automatisch gespeichert &nbsp;!!!") .. cr) .. cr) .. replace_uml("Wird eine Zone verlassen UND alle Aufgaben sind erf~ullt, speichert das Spiel automatisch. Sollte das Programm h~angen bleiben oder abst~urzen, sollte ein Neustart helfen."),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _bmj:OnEnter()
  _Jcs = _p0t("]=\0284")
  _iMfF = _iMfF + 1
  if _t6iCA < 2 then
    _Drls()
    _t6iCA = 2
    _qy9c:MoveTo(_bmj)
    _qy9c.Commands._y6C_.Enabled = true
    _xiX4:MoveTo(_bmj)
    _b_Z:MoveTo(_bmj)
    _PUf:MoveTo(_bmj)
    _PUf.Visible = false
    _b_Z.Visible = true
    _b_Z.Commands._Bpv.Enabled = true
    _8zMo.Complete = true
    _LyE26.Active = true
    _LyE26.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Das ist also der Benediktsplatz ... ich bekomme h~ollischen Hunger.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Am westlichen Ende der Kr~amerbr~ucke stand seit dem 11. Jahrhundert die Benediktikirche, die 1890 abgerissen wurde und an die heute nur noch der Name des Benediktsplatzes erinnert.")),
        Media = _GV85L
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _tiFd == 2 then
    _Urwigo.MessageBox({
      Text = _p0t("\0038||f\0288Gf|TyT\017afR8|fT|fyAT;f8\028fKT\017T(A\r>|rG8>Ff\017\006YyfF6f>6\017fBA=>\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  end
end
function _bmj:OnExit()
  _Jcs = _p0t("]=\0284")
  _iMfF = _iMfF + 1
  if _g5cik == 0 or _xVf == 0 then
    _tiFd = 2
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = _p0t("\\\006\017f(AT|T\028f`G8>Ff\r8\017\017fAYyf\017\006Yyf\017AYy>fRTBBTyT\017\030f\015|fBA=>f\017\006YyfT>R8|fF6fT;GT(ABT\017\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _g5cik == 1 and _xVf == 1 then
    _bmj.Visible = false
    _bmj.Active = false
    _by6.Active = false
    _by6.Visible = false
    _LyE26.Complete = true
    _xiX4.Commands._rR3Tr.Enabled = false
    _PUf.Commands._rKR.Enabled = true
    _LyE26.Visible = false
    _8zMo.Visible = false
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Nein, nicht so! Du mu~st den Braten bezahlen!")),
        Media = _55A
      },
      {
        Text = _p0t("\\\006\017fTA\017T;fKTF8yG6\017Bfy8=>fSy;f\028A;f\017AYy>|fBT|8B>af|\006\017(T;\017fSy;f|8B>T>af\006=fAYyf\017AYy>fT>R8|f\028A>f\028A;f\017Ty\028T\017fR\006GGT\030^K\be[8|f\r8\017\017fAYyf\028A>f\0156;T\017ft>8\017(\0178Yy=8;\017f=TRTA|T\017af(ATf(8=TA|>8\017(T\017\030"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Die anderen Metzger kamen dazu und sagten aus Hass, dass es wahr sei. Denn die andern waren dem Metzger feindlich gesonnen. Wenn jemand n~amlich zu ihnen kam und etwas kaufen wollte, rief er die Leute zu sich und zog sie damit von ihnen ab. Darum stimmten sie zu, dass Eulenspiegel den Braten behielte. W~ahrend der Metzger also zankte, nahm Eulenspiegel den Braten unter den Rock, ging damit hinweg und liess sie sich dar~uber einigen, so gut sie konnten."))
      }
    }, function(action)
      _by6.Active = true
      _by6.Visible = true
      var_cartridge:RequestSync()
      _Urwigo.MessageBox({
        Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030f"),
        Media = _Yfn5,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end)
  elseif _g5cik == 2 then
    _bmj.Active = false
    _bmj.Visible = false
    _8zMo.Visible = false
    _LyE26.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030"),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _9Lkh:OnEnter()
  _Jcs = _p0t("]!\003\ry")
  _iMfF = _iMfF + 1
  if _t6iCA < 3 then
    _Drls()
    _t6iCA = 3
    _qy9c:MoveTo(_9Lkh)
    _qy9c.Commands._y6C_.Enabled = true
    _YVX:MoveTo(_9Lkh)
    _YVX.Commands._6m_.Enabled = true
    _jab:MoveTo(_9Lkh)
    _AiKY:MoveTo(_9Lkh)
    _Voli:MoveTo(_9Lkh)
    _PUf.Commands._rKR.Enabled = true
    _5G1lR.Active = true
    _5G1lR.Visible = true
    _tle.Complete = true
    _9iT51.Active = true
    _9iT51.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Gut, die Kreuzgasse habe ich durchlaufen. Die Kr~amerbr~ucke rechts sieht sehr interessant aus. Kurz davor ist auch die ber~uhmte Mikwe.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Ein sehr bekanntes Bauwerk der Stadt, Zeit f~ur ein paar kleine Informationen soll es trotzdem geben. Auf den sechs Br~uckenb~ogen standen urspr~unglich 62 schmale H~auser, die inzwischen auf 32 zusammengefasst wurden. Die beidseitige, geschlossene Br~uckenbebauung mit Fachwerkh~ausern ist n~ordlich der Alpen einmalig. ")),
        Media = _Xvy
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _tiFd == 3 then
    _Urwigo.MessageBox({
      Text = _p0t("\0038||f\0288Gf|TyT\017afR8|fA\028fKT;TAYyf(T;f\022;T6FB8||Tf\017\006YyfF6fT;GT(ABT\017fA|>\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  end
end
function _9Lkh:OnExit()
  _Jcs = _p0t("]!\003\ry")
  _iMfF = _iMfF + 1
  if _Ue2 == 1 and _quEb == 2 then
    _9Lkh.Active = false
    _9Lkh.Visible = false
    _tle.Visible = false
    _5G1lR.Visible = false
    _9iT51.Visible = false
    _fDS.Visible = false
    _8F9wM.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030"),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _tiFd = 3
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Du verl~asst diesen Platz zu fr~uh. Ich habe das Gef~uhl, es wurde hier noch nicht alles erledigt.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _HdNc:OnEnter()
  _Jcs = _p0t("]D(vY")
  _iMfF = _iMfF + 1
  if _t6iCA < 5 then
    _Drls()
    _t6iCA = 5
    _ZmYvd:MoveTo(_HdNc)
    _qy9c:MoveTo(_HdNc)
    _qy9c.Commands._y6C_.Enabled = true
    _xiX4:MoveTo(_HdNc)
    _g5cik = 0
    _xiX4.Commands._IDZq.Enabled = true
    _xiX4.Commands._rR3Tr.Enabled = false
    _YVX:MoveTo(_HdNc)
    _YVX.Visible = true
    _YwmiO = 0
    _b_Z:MoveTo(_HdNc)
    _PUf:MoveTo(_HdNc)
    _PUf.Visible = true
    _PUf.Commands._rKR.Enabled = false
    _PUf.Commands._yxTTU.Enabled = true
    _PUf.Commands._x8r.Enabled = true
    _xVf = 0
    _Ue2 = 0
    _gYvfD.Complete = true
    _LWq0G.Active = true
    _LWq0G.Visible = true
    _5d_.Active = true
    _5d_.Visible = true
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Hier ist er wieder, der Benediktsplatz. Und es ist Markt ... der Metzger ist auch wieder da und den Rektor sehe ich da dr~uben ebenfalls. Dies ist ein vortrefflicher Augenblick.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _tiFd == 5 then
    _Urwigo.MessageBox({
      Text = _p0t("\0038||f\0288Gf|TyT\017afR8|f8\028fKT\017T(A\r>|rG8>Ff\017\006YyfF6fT;GT(ABT\017fA|>\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  end
end
function _HdNc:OnExit()
  _Jcs = _p0t("]D(vY")
  _iMfF = _iMfF + 1
  if _Ue2 == 0 or _YwmiO == 0 then
    _tiFd = 5
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = _p0t("SYyf=A\017fyAT;af6\028fTA\017T\017fRTA>T;T\017fK;8>T\017fF6f=T\r\006\028\028T\017\030f\t6Yyf|\006GGf(T;f\bT\r>\006;f\021\006\017f(T\017f\003T;\017,\006;>|Yy;A>>T\017fT;,8y;T\017\030f\015;|>f(8\0178YyfBTyTfAYyfRTA>T;\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Ue2 == 1 and _YwmiO == 1 then
    _HdNc.Visible = false
    _HdNc.Active = false
    _gYvfD.Visible = false
    _LWq0G.Visible = false
    _HcESI.Visible = false
    _5d_.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030"),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _9uVW0:OnEnter()
  _Jcs = _p0t("]!6\\n\027")
  _iMfF = _iMfF + 1
  if _t6iCA < 4 then
    _Drls()
    _t6iCA = 4
    _qy9c:MoveTo(_9uVW0)
    _qy9c.Commands._y6C_.Enabled = true
    _THT = 0
    _g9Y:MoveTo(_9uVW0)
    _viu9:MoveTo(_9uVW0)
    _viu9.Commands._irMY.Enabled = false
    _zVIl:MoveTo(_9uVW0)
    _zVIl.Commands._tc1rG.Enabled = false
    _A7tU:MoveTo(_9uVW0)
    _fZz:MoveTo(_9uVW0)
    _fZz.Commands._fZv.Enabled = false
    _zgAQO.Complete = true
    _vfvQq.Active = true
    _vfvQq.Visible = true
    _9Lkh.Visible = false
    _9Lkh.Active = false
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Das nenne ich doch mal das erste und beste Gasthaus am Platze. Leider halten es die Leute nie lange mit mir aus und ich werde bald weiter ziehen m~ussen. Hier k~onnte es mir sehr gefallen. Ich werde die Zeit nutzen, welche mir in dieser Stadt bleibt und diese Herberge genie~sen.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Der Torbogen bildet den ~ostlichen Zugang zur Kr~amerbr~ucke. Vom Turm der ~Agidienkirche bietet sich ein guter Blick ~uber die Dachlandschaft der Kr~amerbr~ucke bis hin zu den Wahrzeichen Erfurts, dem Domplatz mit Mariendom und St. Severi sowie dem Panorama der Zitadelle Petersberg. Der 33 Meter hohe Turm wird auch als Roter Turm bezeichnet und ist t~aglich f~ur Besucher ge~offnet.")),
        Media = _Q9K2e
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _tiFd == 4 then
    _Urwigo.MessageBox({
      Text = _p0t("\0038||f\0288Gf|TyT\017afR8|fyAT;f8\028f\b\006>T\017f\0146;\028f\017\006YyfF6fT;GT(ABT\017fA|>\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  end
end
function _9uVW0:OnExit()
  _Jcs = _p0t("]!6\\n\027")
  _iMfF = _iMfF + 1
  if _Mnxxy == 0 then
    _tiFd = 4
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = _p0t("[T;f\015|TGf\0286||f6\017=T(A\017B>f\003T;\017T;,\006GBTfFTABT\017af\021\006;yT;f\r8\017\017fAYyfyAT;f\017AYy>fRTB\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Mnxxy == 1 then
    _tiFd = 4
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = _p0t("[T;f\015|TGfy8>f|Yy\006\017fTA\017ABT|fBTGT;\017>af8=T;f\0288Yy>fT;fRA;\rGAYyf8GGT|f;AYy>AB'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Mnxxy == 2 then
    _9uVW0.Visible = false
    _9uVW0.Active = false
    _zgAQO.Visible = false
    _vfvQq.Visible = false
    _7XM2.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030"),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _7K7j:OnEnter()
  _Jcs = _p0t("]E\022E4")
  _iMfF = _iMfF + 1
  if _t6iCA < 6 then
    _Drls()
    _t6iCA = 6
    _IslI.Complete = true
    _qy9c:MoveTo(_7K7j)
    _YVX:MoveTo(_7K7j)
    _YVX.Visible = true
    _YVX.Commands._6m_.Enabled = true
    _zVIl:MoveTo(_7K7j)
    _zVIl.Visible = true
    _zVIl.Commands._tc1rG.Enabled = true
    _viu9:MoveTo(_7K7j)
    _viu9.Visible = true
    _viu9.Commands._QKb.Enabled = false
    _viu9.Commands._irMY.Enabled = true
    _fZz:MoveTo(_7K7j)
    _zFYo = 0
    _fZz.Visible = true
    _fZz.Commands._mWES.Enabled = false
    _fZz.Commands._fZv.Enabled = true
    _fZz.Commands._iS2RE.Enabled = true
    _viu9.Commands._fnIgQ.Enabled = false
    _XYT.Active = true
    _XYT.Visible = true
    _7K7j.Active = false
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("In der Rathausgasse, gleich hinter dem Rathaus, steht ein Denkmal f~ur mich ... mit mir ... von mir ... ~ah ... mir zu Ehren. Kannst du es auch sehen?")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Das Denkmal wurde von Bildhauerin Anke Besser-G~uth geschaffen und steht vor dem Haus \"Zur Narrenschelle\", das sich seit 2000 im Besitz der Erfurter Karnevalsgemeinschaft befindet. Auf dem Denkmal sind die Initialen der K~unstlerin zu finden und eine Zahl.")),
        Media = _FLe
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_zepJh)
      end)
    end)
  elseif _tiFd == 6 then
    _Urwigo.MessageBox({
      Text = _p0t("D8|>f(6f(8|f[T\017\r\0288GfBT,6\017(T\017'f^K\ben8|fA|>f(T\017\017f\017\006YyfF6f>6\017'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  end
end
function _7K7j:OnExit()
  _Jcs = _p0t("]E\022E4")
  _iMfF = _iMfF + 1
  if _ROZ9z == 0 or _3DN == 0 or _vLxJ == 0 then
    _tiFd = 6
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = _p0t("D8|>f(6f(8|f[T\017\r\0288Gf=T;TA>|fBT,6\017(T\017'fJ\017(f86Yyf8GGTf\t6,B8=T\017fT;,6GG>'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _ROZ9z == 1 and _3DN == 1 and _vLxJ == 1 then
    _7K7j.Visible = false
    _7K7j.Active = false
    _IslI.Visible = false
    _XYT.Visible = false
    _Dop0n.Visible = false
    _1DGs.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030"),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _xsZE:OnEnter()
  _Jcs = _p0t("]\002|/\015")
  _iMfF = _iMfF + 1
  if _t6iCA < 7 then
    _Drls()
    _t6iCA = 7
    _pFrS.Complete = true
    _xsZE.Active = false
    _qy9c:MoveTo(_xsZE)
    _qy9c.Visible = true
    _qy9c.Commands._y6C_.Enabled = false
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Da bist du ja, fein. Habe ich dir schon von meiner Freundin Nele erz~ahlt? Ich versprach ihr, hier in Erfurt ein Zeichen unserer Liebe zu hinterlassen. Und wie ich sehe hat auch in dieser Stadt der Brauch der Liebes-Schl~osser an Br~uckengel~andern Einzug gehalten. Das macht es mir leicht auch eines dieser Schl~osser zu hinterlassen. Dieses Schloss gibt auch dir die M~oglichkeit f~ur einen Log.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Bevor du nun wild zu suchen beginnst, erz~ahle ich dir noch ein paar Dinge. Sobald ich dich nachher verlasse, findest du in deinem Rucksack einen Code f~ur den Log auf Wherigo.com. Weiterhin liegt darin eine kleine Zusammenfassung, wie du dich auf unserer kleinen Runde geschlagen hast. Auch eine kleine Statistik wirst du dort finden. Ein Blick dort hinein wird dir sicher nicht schaden, aber erst nach unserer Verabschiedung. Diese Dinge bleiben nach Beendigung des Spieles im Rucksack enthalten.")),
        Media = _b7O
      }
    }, function(action)
      _pV6DJ:MoveTo(Player)
      _g3lRn:MoveTo(Player)
      _7cN:MoveTo(Player)
      _7bUr.Visible = true
      _5tsn()
    end)
  elseif _tiFd == 7 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Wir werden das hier schon noch zu Ende bringen, keine Sorge..")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _XLrP()
        end
      end
    })
  end
end
function _xsZE:OnExit()
  _Jcs = _p0t("]\002|/\015")
  _iMfF = _iMfF + 1
  _tiFd = 7
  if _P1P == 0 then
    _iMfF = _iMfF + 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Wo willst du hin? Versuche mal bei der Br~ucke zu bleiben.")),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _P1P == 1 then
    _xsZE.Active = false
    _xsZE.Visible = false
    _pFrS.Visible = false
    _vat.Visible = false
    var_cartridge:RequestSync()
    _Urwigo.MessageBox({
      Text = _p0t("[T;ftrATG|>8\017(fR6;(TfBT|rTAYyT;>\030"),
      Media = _Yfn5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _lbk:OnProximity()
  _Jcs = _p0t("]G=\r")
  _Drls()
  _9Lkh.Active = false
  _9Lkh.Visible = false
  _lbk.Active = false
  _lbk.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_PR_g)
  end)
end
function _tarmy:OnProximity()
  _Jcs = _p0t("]>8;\028+")
  _tarmy.Active = false
  _tarmy.Visible = false
  _iQuD.Active = true
  _iQuD.Visible = true
end
function _i7e:OnProximity()
  _Jcs = _p0t("]AET")
  _i7e.Active = false
  _i7e.Visible = false
  _bmj.Active = true
  _bmj.Visible = true
end
function _bQEO:OnProximity()
  _Jcs = _p0t("]=\031\015\n")
  _bQEO.Active = false
  _bQEO.Visible = false
  _HdNc.Active = true
  _HdNc.Visible = true
end
function _by6:OnProximity()
  _Jcs = _p0t("]=+s")
  _by6.Active = false
  _by6.Visible = false
  _9Lkh.Active = true
  _9Lkh.Visible = true
end
function _4fCr:OnProximity()
  _Jcs = _p0t("]u,3;")
  _4fCr.Active = false
  _4fCr.Visible = false
  _xsZE.Active = true
  _xsZE.Visible = true
end
function _gKt:OnProximity()
  _Jcs = _p0t("]B\022>")
  _gKt.Active = false
  _gKt.Visible = false
  _7K7j.Active = true
  _7K7j.Visible = true
end
function _Okwc:OnProximity()
  _Jcs = _p0t("]\n\rRY")
  _Okwc.Active = false
  _Okwc.Visible = false
  _9uVW0.Active = true
  _9uVW0.Visible = true
end
function _tPpcO:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _iMfF = _iMfF + 1
  if _Urwigo.Hash(string.lower(input)) == 23184 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Jaaaa ... richtig. Mit Brille h~atte ich das auch geschafft. Wie mir scheint, brauche ich dir nicht das Lesen beibringen. Hast du ein Gl~uck!!!")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _p0t("}T>F>f|A\017(fRA;fyAT;fRA;\rGAYyf,T;>ABafG8||f6\017|fRTA>T;f(6;Yyf(ATft>8(>fG86,T\017\030f\t6,fBTy>fT|fF6\028fKT\017T(A\r>|rG8>F\030"),
            Media = _b7O,
            Callback = function(action)
              if action ~= nil then
                _iQuD.Active = true
                _iQuD.Visible = true
                _8zMo.Active = true
                _8zMo.Visible = true
                _i7e.Active = true
                _i7e.Visible = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  elseif _mzy88 == 0 then
    _mzy88 = 1
    _Urwigo.MessageBox({
      Text = _p0t("[AT|Tf\t\017>R\006;>fA|>fTA\017(T6>ABf\0248G|Yy\030f\t\017(T;|fBT|8B>f\030\030\030f(6fy8|>f(T\017f/\nv\022fBTF\006BT\017\030^K\be^K\bev6\017f\030\030\030fGATB>f(8|f4T>F>f8\017f(T;f\0148,TGf\030\030\030f8\028f\003AYy>f\030\030\030f8\017f(TA\017T\017f\t6BT\017af(T;f,TyGT\017(T\017fK;AGGTf\006(T;f6\017|AYyT;T\017f\024A\017BT;\017f=TA\028f\014ArrT\017'fn8\017\017f=A|>f(6f(8|fGT>F>Tf 8Gf=TAfTA\017T\028f\nr>A\rT;fBTRT|T\017'f[6f|\006GG>T|>f=TAf\026TGTBT\017yTA>fTA\017T\017f\014T;\028A\017f\0288YyT\017\030f\\T;|6YyfT|f\017\006Yy\0288Gf\017T6f\030\030\030f"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tPpcO)
          end)
        end
      end
    })
  elseif _mzy88 > 0 then
    _mzy88 = _mzy88 + 1
    _Urwigo.MessageBox({
      Text = (_p0t("[6fy8|>f4T>F>f|Yy\006\017fRATf\006,>fTA\017Tf\t\017>R\006;>f,8G|YyfTA\017BTBT=T\017'f") .. _mzy88) .. _p0t("f\0288GfA|>fT|f|YyAT,fBTB8\017BT\017\030f}T>F>f|T>F>f(ATfK;AGGTf86,f\006(T;fy\006Gf(A;fDAG,T\030f A;f|YyTA\017>af8GGTA\017f|Yy8,,|>f(6f(8|f\017AYy>\030f\n(T;f|A\017(f(ATf\0148,TG\017f(\006Yyf|\006f|YyRT;fF6fT\017>FA,,T;\017'f\tG|\006f86,fF6\028fRTA>T;T\017f\\T;|6Yy\030"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tPpcO)
          end)
        end
      end
    })
  end
end
function _GTTeH:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _iMfF = _iMfF + 1
  if _Urwigo.Hash(string.lower(input)) == 50391 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Jaaaa ... richtig. Ohne Fernglas f~allt mir das Lesen auf diese Entfernung etwas schwer. Danke f~ur deine Hilfe.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _p0t("[T;fnTBfF6;f\022;T6FB8||TfA|>f,;TA\030f\n\006\006yyyf\030\030\030f(T;f T>FBT;af(T;fFATy>f8=T;fTA\017f\026T|AYy>f\030\030\030fRAGGfT;fRA;\rGAYyf\026TG(fy8=T\017'f\n(T;f|\006GG>T\017fRA;f8=y86T\017'"),
            Media = _b7O,
            Callback = function(action)
              if action ~= nil then
                _bmj.Active = true
                _bmj.Visible = true
                _by6.Active = true
                _by6.Visible = true
                _tle.Active = true
                _tle.Visible = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  elseif _mzy88 == 0 then
    _mzy88 = 1
    _Urwigo.MessageBox({
      Text = _p0t("[AT|Tf\t\017>R\006;>fA|>fTA\017(T6>ABf\0248G|Yy\030f\t\017(T;|fBT|8B>f\030\030\030f(6fy8|>f(T\017f/\nv\022fBTF\006BT\017\030^K\be^K\bev6\017f\030\030\030fGATB>f(8|f4T>F>f8\017f(T;f\0148,TGf\030\030\030f8\028f\003AYy>f\030\030\030f8\017f(TA\017T\017f\t6BT\017af(T;f,TyGT\017(T\017fK;AGGTf\006(T;f6\017|AYyT;T\017f\024A\017BT;\017f=TA\028f\014ArrT\017'fn8\017\017f=A|>f(6f(8|fGT>F>Tf 8Gf=TAfTA\017T\028f\nr>A\rT;fBTRT|T\017'f[6f|\006GG>T|>f=TAf\026TGTBT\017yTA>fTA\017T\017f\014T;\028A\017f\0288YyT\017\030f\\T;|6YyfT|f\017\006Yy\0288Gf\017T6f\030\030\030f"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_GTTeH)
          end)
        end
      end
    })
  elseif _mzy88 > 0 then
    _mzy88 = _mzy88 + 1
    _Urwigo.MessageBox({
      Text = (_p0t("S|>f(ATf\024;8BTfF6f|YyRT;af(ATf\0148,TGfF6f\rGTA\017f\006(T;f|A\017(f(TA\017Tf\t6BT\017fF6f|YyGTYy>'fD8|>f(6f6=T;y86r>f(ATf;AYy>ABTf\0148,TGfBT,6\017(T\017'") .. _mzy88) .. _p0t("f\0288GfA|>fT|f|YyAT,fBTB8\017BT\017\030f\tYyf\021T;|6YyTfT|fTA\017,8YyfT;\017T6>af(8\017\017fRA;(fT|f=T|>A\028\028>f;AYy>ABf|TA\017\030"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_GTTeH)
          end)
        end
      end
    })
  end
end
function _PR_g:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _iMfF = _iMfF + 1
  if _Urwigo.Hash(string.lower(input)) == 61900 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Ich bin sowas von begeistert, du glaubst es nicht. Mit dir ist es eine Freude durch die Stadt zu tingeln.")),
        Media = _b7O
      },
      {
        Text = _p0t("v6\017fG8||f6\017|fRTA>T;fF6\028f\b\006>T\017f\0146;\028fBTyT\017\030"),
        Media = _b7O
      }
    }, function(action)
      _lbk.Active = false
      _lbk.Visible = false
      _9Lkh.Active = true
      _9Lkh.Visible = true
      _qy9c.Commands._y6C_.Enabled = false
      _YVX.Visible = false
      _8F9wM.Complete = true
      _zgAQO.Active = true
      _zgAQO.Visible = true
      _9uVW0.Active = true
      _9uVW0.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _mzy88 == 0 then
    _mzy88 = 1
    _Urwigo.MessageBox({
      Text = _p0t("[AT|Tf\t\017>R\006;>fA|>fTA\017(T6>ABf\0248G|Yy\030f\t\017(T;|fBT|8B>f\030\030\030f(6fy8|>f(T\017f/\nv\022fBTF\006BT\017\030^K\be^K\bev6\017f\030\030\030fGATB>f(8|f4T>F>f8\017f(T;f\0148,TGf\030\030\030f8\028f\003AYy>f\030\030\030f8\017f(TA\017T\017f\t6BT\017af(T;f,TyGT\017(T\017fK;AGGTf\006(T;f6\017|AYyT;T\017f\024A\017BT;\017f=TA\028f\014ArrT\017'fn8\017\017f=A|>f(6f(8|fGT>F>Tf 8Gf=TAfTA\017T\028f\nr>A\rT;fBTRT|T\017'f[6f|\006GG>T|>f=TAf\026TGTBT\017yTA>fTA\017T\017f\014T;\028A\017f\0288YyT\017\030f\\T;|6YyfT|f\017\006Yy\0288Gf\017T6f\030\030\030f"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_PR_g)
          end)
        end
      end
    })
  elseif _mzy88 > 0 then
    _mzy88 = _mzy88 + 1
    _Urwigo.MessageBox({
      Text = (_p0t("[6fy8|>f4T>F>f|Yy\006\017fRATf\006,>f(ATf\t\017>R\006;>f,8G|YyfTA\017BTBT=T\017'f") .. _mzy88) .. _p0t("f\0288GfA|>fT|f|YyAT,fBTB8\017BT\017\030f}T>F>f|T>F>f(ATfK;AGGTf86,f\006(T;fy\006Gf(A;fDAG,T\030f A;f|YyTA\017>af8GGTA\017f|Yy8,,|>f(6f(8|f\017AYy>\030"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_PR_g)
          end)
        end
      end
    })
  end
end
function _XD_:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _iMfF = _iMfF + 1
  if _Urwigo.Hash(string.lower(input)) == 11701 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Dinge gibt es, die gibt es nicht. Wie du die Tafel nur wieder gefunden hast. Und die Zahl hat auch gestimmt.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = tostring(replace_uml("Nun denn, Zeit f~ur einen Verdauungsspaziergang. Mir liegt der Braten etwas im Magen. Lass uns hinter das Rathaus gehen, der Esel wartet bestimmt schon auf uns.")),
            Media = _b7O,
            Callback = function(action)
              if action ~= nil then
                _HdNc.Active = true
                _HdNc.Visible = true
                _qy9c.Commands._y6C_.Enabled = false
                _IslI.Active = true
                _IslI.Visible = true
                _gKt.Active = true
                _gKt.Visible = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  elseif _mzy88 == 0 then
    _mzy88 = 1
    _Urwigo.MessageBox({
      Text = _p0t("[AT|Tf\t\017>R\006;>fA|>fTA\017(T6>ABf\0248G|Yy\030f\t\017(T;|fBT|8B>f\030\030\030f(6fy8|>f(T\017f/\nv\022fBTF\006BT\017\030^K\be^K\bev6\017f\030\030\030fGATB>f(8|f4T>F>f8\017f(T;f\0148,TGf\030\030\030f8\028f|YyGTYy>T\017f\003AYy>f\030\030\030f8\017f(TA\017T\017f\t6BT\017af(T;f,TyGT\017(T\017fK;AGGTf\006(T;f6\017|AYyT;T\017f\024A\017BT;\017f=TA\028f\014ArrT\017'fn8\017\017f=A|>f(6f(8|fGT>F>Tf 8Gf=TAfTA\017T\028f\nr>A\rT;fBTRT|T\017'f[6f|\006GG>T|>f=TAf\026TGTBT\017yTA>fTA\017T\017f\014T;\028A\017f\0288YyT\017\030f\\T;|6YyfT|f\017\006Yy\0288Gf\017T6f\030\030\030f"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_XD_)
          end)
        end
      end
    })
  elseif _mzy88 > 0 then
    _mzy88 = _mzy88 + 1
    _Urwigo.MessageBox({
      Text = (replace_uml("Ist die Frage zu schwer? Die Zahl ist doch recht gro~s.") .. _mzy88) .. _p0t("f\0288GfA|>fT|f|YyAT,fBTB8\017BT\017\030f\tYyf\021T;|6YyTfT|fTA\017,8YyfT;\017T6>af(8\017\017fRA;(fT|f=T|>A\028\028>f;AYy>ABf|TA\017\030"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_XD_)
          end)
        end
      end
    })
  end
end
function _zepJh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _iMfF = _iMfF + 1
  if _Urwigo.Hash(string.lower(input)) == 12723 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Soll ich dir was sagen? Die Zahl ist goldrichtig. Nun ...wir sind hier, der Esel ist hier und der Rektor mit seinen Magistern hat auch hierher gefunden. Es wird Zeit mit der Vorstellung zu beginnen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _7K7j.Active = true
          _7K7j.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _mzy88 == 0 then
    _mzy88 = 1
    _Urwigo.MessageBox({
      Text = _p0t("[AT|Tf\t\017>R\006;>fA|>fTA\017(T6>ABf\0248G|Yy\030f\t\017(T;|fBT|8B>f\030\030\030f(6fy8|>f(T\017f/\nv\022fBTF\006BT\017\030^K\be^K\ben\006yT;f|\006GG|>f(6f86YyfRA||T\017fRTGYyTf/TAYyT\017fAYyf\028TA\017Taf\rG8;\030ftYy86f\0288Gf8\017f\028TA\017T\028fDA\017>T;\017f\030\030\030f\017AYy>f8\017f(AT|T\028f\030\030\030f8\028fDA\017>T;\017f(T|f[T\017\r\0288G|LLL"),
      Media = _rZy,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_zepJh)
          end)
        end
      end
    })
  elseif _mzy88 > 0 then
    _mzy88 = _mzy88 + 1
    _Urwigo.MessageBox({
      Text = (_p0t("SYyf\028TA\017>Tf\017AYy>f(ATfK6Yy|>8=T\017f86,f(T\017fK6Yy|TA>T\017\030ftYy86f(A;f\0288Gf(8|f[T\017\r\0288GfBT\01786f8\017\030fKT|\006\017(T;|f(8|fDA\017>T;>TAGf\028TA\017T;f\024AB6;\030f") .. _mzy88) .. _p0t("f\0288GfA|>fT|f|YyAT,fBTB8\017BT\017\030f}T>F>f|T>F>f(ATfK;AGGTf86,f\006(T;fy\006Gf(A;fDAG,T\030f A;f|YyTA\017>af8GGTA\017f|Yy8,,|>f(6f(8|f\017AYy>\030"),
      Media = _rZy,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_zepJh)
          end)
        end
      end
    })
  end
end
function _QQm:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _iMfF = _iMfF + 1
  if _Urwigo.Hash(string.lower(input)) == 54 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Ich bin ersch~uttert ... in den Grundfesten meines Glaubens ... die Antwort ist korrekt. Oder sollte ich sagen - begeistert? Nat~urlich h~atte ich dir das zutrauen m~ussen, aber ich habe oft genug feststellen k~onnen, wie unbeholfen Leute manchmal sein k~onnen. Komm lass uns weiter gehen.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Ich empfehle den Weg durch den Roten Turm ~UBER die Kr~amerbr~ucke.")),
        Media = _b7O
      }
    }, function(action)
      _qy9c.Commands._y6C_.Enabled = false
      _9uVW0.Active = true
      _9uVW0.Visible = true
      _bQEO.Active = true
      _bQEO.Visible = true
      _gYvfD.Active = true
      _gYvfD.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _mzy88 == 0 then
    _mzy88 = 1
    _Urwigo.MessageBox({
      Text = _p0t("[AT|Tf\t\017>R\006;>fA|>fTA\017(T6>ABf\0248G|Yy\030f\t\017(T;|fBT|8B>f\030\030\030f(6fy8|>f(T\017f/\nv\022fBTF\006BT\017\030^K\be^K\bev6\017f\030\030\030fGATB>f(8|f4T>F>f8\017f(T;f\0148,TGf\030\030\030f8\028f|YyGTYy>T\017f\003AYy>f\030\030\030f8\017f(TA\017T\017f\t6BT\017af(T;f,TyGT\017(T\017fK;AGGTf\006(T;f6\017|AYyT;T\017f\024A\017BT;\017f=TA\028f\014ArrT\017'fn8\017\017f=A|>f(6f(8|fGT>F>Tf 8Gf=TAfTA\017T\028f\nr>A\rT;fBTRT|T\017'f[6f|\006GG>T|>f=TAf\026TGTBT\017yTA>fTA\017T\017f\014T;\028A\017f\0288YyT\017\030f\\T;|6YyfT|f\017\006Yy\0288Gf\017T6f\030\030\030f"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_QQm)
          end)
        end
      end
    })
  elseif _mzy88 > 0 then
    _mzy88 = _mzy88 + 1
    _Urwigo.MessageBox({
      Text = (replace_uml("Hi Hi Hi ... ist das jetzt zu frech von mir? Tut mir Leid, aber die Eingabe war schon wieder falsch.") .. _mzy88) .. _p0t("f,8G|YyTf\015A\017B8=T\017fy8|>f(6fR8y;T\017(f6\017|T;T;f\b6\017(Tf\0176\017f=T;TA>|fBT\0288Yy>\030f}T>F>fBA=f(A;f\0288Gf=A||Gf 6yT\030f\003\006|af\017\006Yy\0288G\030"),
      Media = _ltp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_QQm)
          end)
        end
      end
    })
  end
end
function _qy9c:On_y6C_(target)
  _iMfF = _iMfF + 1
  if _t6iCA == 1 and _THT == 0 and _EurAG == 0 and _ycbE == 0 then
    _THT = 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Ein wundersch~on beschriebener Zettel mit Werbung in eigener Sache w~are jetzt sehr brauchbar. Den m~usste ich dann aufh~angen. Vielleicht am Tor der Alten Universit~at, das scheint mir eine gute Idee zu sein.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    })
  elseif _t6iCA == 1 and _EurAG == 1 and _ycbE == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Hier an der Alten Universit~at kann ich den Zettel anschlagen und meine Dienste anbieten. Einen besseren Ort werde ich daf~ur nicht finden. Aber wo kann ich ihn an dem Geb~aude befestigen?")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _53tRP)
        end
      end
    })
  elseif _t6iCA == 1 and _EurAG == 1 and _ycbE == 1 and _IAcno == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Einen Zettel habe ich dabei und einen Platz zum Aufh~angen habe ich auch gefunden. Also dran mit meiner Werbung, damit ich weiter komme.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    })
  elseif _t6iCA == 1 and _IAcno == 1 then
    _qy9c.Commands._y6C_.Enabled = false
    _Urwigo.MessageBox({
      Text = _p0t("DAT;f=A\017fAYyf,T;>AB\030f[T;f/T>>TGfA|>f8\028f\014\006;f(;8\017f6\017(fAYyf\r8\017\017f\028A;fRTA>T;f(ATft>8(>f8\017|Yy86T\017\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 2 and _g5cik == 0 and _xVf == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Hier auf dem Markt ist aber was los. Wann habe ich das letzte Mal etwas gegessen? Gro~ser Hunger l~asst meinen Magen knurren und meine Kr~afte schwinden. An diesem Platz gibt es jede Menge zu essen. &nbsp;Auf den Fleischb~anken finden sich reichlich leckere Dinge und ich werde bei dem Metzger mein Gl~uck versuchen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _xiX4)
        end
      end
    })
  elseif _t6iCA == 2 and _g5cik == 1 and _xVf == 0 then
    _qy9c.Commands._y6C_.Enabled = false
    _Urwigo.MessageBox({
      Text = _p0t("\015;fy8>f\028A;fTA\017T\017fK;8>T\017f8\017BT=\006>T\017f\030\030\030fAYyf|\006GG>Tf(8|f\t\017BT=\006>f(8\017\rT\017(f8\017\017Ty\028T\017f6\017(f\028A;f(T\017fK;8>T\017fB;TA,T\017\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _PUf)
        end
      end
    })
  elseif _t6iCA == 2 and _g5cik == 1 and _xVf == 1 then
    _qy9c.Commands._y6C_.Enabled = false
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Meinen Braten habe ich mir mit List und T~ucke geholt. Nun sollte ich weiter gehen, bevor es ~Arger gibt. Der Metzger schaut mich wartend an, schnell weg hier.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 2 and _g5cik == 2 and _xVf == 1 then
    _qy9c.Commands._y6C_.Enabled = false
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Nun ja, der Metzger ist sauer und schaut betr~oppelt ... ich habe noch immer gro~sen Hunger und einen Braten ergattert ... mich h~alt hier nichts mehr. Das Beste w~are, jetzt weiter zu gehen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 3 and _quEb == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("H~ore ich da jemanden meinen Namen rufen? Der Metzger sollte sich doch langsam beruhigt haben. Dort dr~uben kommt jemand gelaufen, der mich zu rufen scheint. Jedenfalls kennt er meinen Namen, ob er mich an meiner schicken Kappe erkannt hat?")),
        Media = _b7O
      },
      {
        Text = _p0t("tTA(fSy;f(T;f\014AGGf\0156GT\017|rATBTG'"),
        Media = _bo2a
      },
      {
        Text = _p0t("t\006fA|>fT|fR\006yG\030fn8;6\028f,;8B>fSy;'"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Magister, Ihr habt ein interessantes Schreiben angeschlagen, dass Ihr eine jegliche Kreatur in kurzer Zeit Lesen und Schreiben lehren wollt. Darum bin ich von der Universit~at durch die Stadt geeilt, um euch zu finden. Und ich wollte Euch einen jungen Esel in die Lehre geben. Traut Ihr es Euch zu, auch ihn zu lehren?")),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Selbstverst~andlich. Doch da so ein Esel ein dummes Tier ist, wird der Unterricht ziehmlich lange dauern.")),
        Media = _b7O
      },
      {
        Text = _p0t("nATfG8\017BTf(T\017\017'"),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Sch~atzungsweise zwanzig Jahre. Ich werde im Gasthaus \"Zum Roten Turm\" wohnen. Dorthin k~onnt ihr mir den Esel bringen. Als Entgelt f~ur den Unterricht gebt mir 500 alte Groschen.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("So soll es sein. Ihr werdet den Esel im Stall des Gasthauses finden und einen Vorschuss gebe ich Euch hiermit in diesem Geldbeutel. Meldet Euch, wenn das Tier bereit zur Pr~ufung ist.")),
        Media = _bo2a
      }
    }, function(action)
      _quEb = 1
      _9iT51.Complete = true
      _fDS.Active = true
      _fDS.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _t6iCA == 3 and _quEb == 1 then
    _quEb = 2
    _fDS.Complete = true
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Puh, da geht der Rektor dahin. Jetzt muss ich mir aber ordentlich etwas einfallen lassen. Die Leute hier denken, sie w~aren schlau. Na, denen werde ich es schon zeigen.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Der Till denkt, er w~are besonders schlau und k~onnte uns etwas vorgaukeln. Diesem Esel wird er nie das Lesen beibringen. So, ich habe zu tun und muss meinen Weg fortsetzen.")),
        Media = _bo2a
      }
    }, function(action)
      if _Ue2 == 0 then
        _qy9c.Commands._y6C_.Enabled = false
        _YVX.Visible = false
        _Urwigo.MessageBox({
          Text = _p0t("SYyf|YyGTrrTf\017\006YyfA\028\028T;f(AT|T\017fK;8>T\017f\028A>f\028A;f;6\028\030f TA\017fD6\017BT;fA|>f;AT|ABaf(T;f T>FBT;fA|>fRTBf\030\030\030f8G|\006f\030\030\030f"),
          Media = _b7O,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _PUf)
            end
          end
        })
      elseif _Ue2 == 1 then
        _9Lkh.Active = false
        _9Lkh.Visible = false
        _lbk.Active = true
        _lbk.Visible = true
        _Urwigo.Dialog(false, {
          {
            Text = tostring(replace_uml("Nun denn, ich werde mich hier noch etwas umsehen und dann kann es weiter zum \"Roten Turm\" gehen. Oh warte, mir f~allt etwas ein. Hier im Kreuzsand ragen die beiden H~auser der ehemaligen Armenburse ~uber das Wasser. Diese m~ochte ich mir noch etwas n~aher anschauen. Lauf einfach den Weg weiter und gehe nicht ~uber die Br~ucke.")),
            Media = _syu
          }
        }, function(action)
          _8F9wM.Active = true
          _8F9wM.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      end
    end)
  elseif _t6iCA == 4 and _THT == 0 and _Mnxxy == 0 then
    _THT = 1
    _qy9c.Commands._y6C_.Enabled = false
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Ob das Eseltier schon im Stall steht und auf seine erste Lektion wartet? Es wird Zeit mit dem Unterricht zu beginnen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _g9Y)
        end
      end
    })
  elseif _t6iCA == 4 and _Mnxxy == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Ach das liebe Eseltier scheint doch schneller zu begreifen als ich dachte. Ob dies auch ein zweites Mal funktioniert?")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 5 and _g5cik == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("v6\017fA|>fT|f|Yy\006\017f8Yy>f\0148BTfyT;af(8||fAYyfyAT;fTA\017T\017fK;8>T\017f=T\r8\028\030f\trrT>A>fy8=TfAYyfRAT(T;\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 5 and _g5cik == 1 and _xVf == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("v6\017f=;86YyTfAYyf\028A;f\0176;f\017\006Yyf(T\017fK;8>T\017fF6f\017Ty\028T\017\030f[8BTBT\017f\r8\017\017f(T;f T>FBT;f\017AYy>|f\028Ty;fTA\017RT\017(T\017\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
        end
      end
    })
  elseif _t6iCA == 5 and _YwmiO == 0 and _xVf == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Den Braten habe ich, aber er wird gerade kalt. Ach und dem Rektor k~onnte ich von den Lernerfolgen berichten.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 5 and _YwmiO == 1 and _Ue2 == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Der Rektor ist informiert, aber ich habe noch immer Hunger.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _PUf)
        end
      end
    })
  elseif _t6iCA == 5 and _YwmiO == 1 and _Ue2 == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Der Rektor und seine Gefolgschaft werden Augen machen ... oh ist das spannend. Das wird ein Spa~s werden. Lass uns zum Platz hinter dem Rathaus gehen. Zuvor suchen wir aber erst wieder eine gut versteckte Tafel.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_XD_)
          end)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Zeit f?r die Pr~ufung ... wer ist wohl aufgeregter? Der Rektor, der Esel oder ich? Also dem Esel scheint das hier m~achtig am Schwanz vorbei zu gehen. Ich wei~s von den besonderen F~ahigkeiten des Tieres und bin ganz beruhigt. Bleibt der Rektor, er ahnt nichts von der kommenden ~Uberraschung und wird sicher staunen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 1 and _ZbkPw == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Was ist denn mit dem Rektor los? Er sieht mir sehr mitgenommen aus. Sollte diese Geschichte zu einem &nbsp;schlimmen Ende f~uhren? Der armer Rektor scheint sich die Sache sehr zu Herzen zu nehmen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 1 and _ZbkPw == 1 and _3DN == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Sag mal, ich habe einen Esel ~ubrig. Kannst du einen brauchen?")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _qy9c.Commands._y6C_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 1 and _ZbkPw == 1 and _3DN == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Meine Zeit in dieser Stadt neigt sich dem Ende. Der Metzger hat seine Lektionen gelernt. &nbsp;Auch der Rektor, Gott hab ihn seelig, nahm mit seinen Gelehrten den Mund m~achtig voll und wurde in seine Schranken verwiesen. Hier bin ich fertig und sicher derzeit nicht mehr gern gesehen. &nbsp;Als n~achstes werde ich mich im \"Goldene Buch\" eintragen. F~ur dich habe ich noch eine kleine ~Uberraschung. Lauf zur Br~ucke in der Stra~se Lange Br~ucke, dort treffen wir uns wieder.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _vLxJ = 1
          _qy9c.Visible = false
          _1DGs.Complete = true
          _pFrS.Active = true
          _pFrS.Visible = true
          _4fCr.Active = true
          _4fCr.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 7 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Im besten Fall hast du das Logbuch bekommen und geloggt. Im schlechtesten Fall ist das Schloss oder das Logbuch verschwunden, das t~ate mir sehr Leid. Ich freue mich nun auf deinen Log und bin gespannt, was gefallen oder nicht gefallen hat.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Mir bleibt nun, dir f~ur deine Hilfe zu Danken. Die Runde hat dir hoffentlich ebenso viel Spa~s gemacht wie mir. Ich verabschiede mich und w~unsche dir noch einen sch~onen Tag, gute Nacht oder was auch immer.")),
        Media = _b7O
      }
    }, function(action)
      _iMfF = _iMfF - 1
      _qy9c.Visible = false
      var_cartridge.Complete = true
      _7cN.Visible = true
      _g3lRn.Visible = true
      _pV6DJ.Visible = true
      _jF44F:MoveTo(Player)
      _jF44F.Visible = true
      _vat.Complete = true
      _xsZE.Active = false
      _xsZE.Visible = false
      var_cartridge:RequestSync()
      _Urwigo.MessageBox({
        Text = _p0t("[8|ftrATGfR6;(TfT;\017T6>fBT|rTAYyT;>af(8\028A>f(ATfS>T\028|fA\017f(TA\017T\028f\b6Y\r|8Y\rf=GTA=T\017f6\017(fA|>fyAT;\028A>f=TT\017(T>\030f\t\017BT\017Ty\028TfDTA\028;TA|T\030"),
        Media = _Y6Ad,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end)
  else
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Ich wei~s jetzt auch nicht mehr weiter. Hab ich noch etwas Brauchbares im Rucksack oder gibt es hier irgendwo noch was zu entdecken?")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _xiX4:On_IDZq(target)
  _iMfF = _iMfF + 1
  if _t6iCA == 2 and _g5cik == 0 and _xVf == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Nun, werter Herr, m~ochtet ihr nicht etwas kaufen, was ihr dann mit euch nach Hause tragen wollt?")),
        Media = _55A
      },
      {
        Text = _p0t("tTy;fBT;\017f\017Ty\028TfAYyfTA\017f|\006GYyT|f\t\017BT=\006>f8\017\030ft8B>afR8|f|\006GGfAYyf\028A>f\028A;f\017Ty\028T\017'"),
        Media = _b7O
      },
      {
        Text = _p0t("\015A\017T\017fK;8>T\017f86|f\028TA\017T;f\t6|G8BTf\r8\017\017fAYyfT6Yyf8\017=AT>T\017\030"),
        Media = _55A
      }
    }, function(action)
      _g5cik = 1
      _PUf.Visible = true
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _PUf)
    end)
  elseif _t6iCA == 2 and _g5cik == 1 and _xVf == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("n8|fA|>f\0176\017f\028A>f(T\028fK;8>T\017'fn\006GG>fSy;fAy\017f\028A>\017Ty\028T\017'"),
      Callback = function(action)
        if action ~= nil then
          _xiX4.Commands._IDZq.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _PUf)
        end
      end
    })
  elseif _t6iCA == 2 and _xVf == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = _p0t("v6\017f\030\030\030fAYyfR8;>Tf86,f\0156;TfKTF8yG6\017B\030"),
        Media = _55A
      },
      {
        Text = _p0t("\\\006\017fTA\017T;fKTF8yG6\017Bfy8=>fSy;f\028A;f\017AYy>|fBT|8B>af|\006\017(T;\017fSy;f|8B>T>af\006=fAYyf\017AYy>fT>R8|f\028A>f\028A;f\017Ty\028T\017fR\006GGT\030"),
        Media = _b7O
      },
      {
        Text = _p0t("[8|f\r8\017\017fAYyf\028A>f\0156;T\017ft>8\017(\0178Yy=8;\017f=TRTA|T\017af(ATf(8=TA|>8\017(T\017\030"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Die anderen Metzger kamen dazu und sagten aus Ha~s, da~s es wahr sei. Denn die andern waren dem Metzger feindlich gesonnen. Wenn jemand n~amlich zu ihnen kam und etwas kaufen wollte, rief er die Leute zu sich und zog sie damit von ihnen ab. Darum stimmten sie zu, da~s Eulenspiegel den Braten behielte. W~ahrend der Metzger also zankte, behielt Eulenspiegel den Braten unter dem Rock, ging damit hinweg und lie~s sie sich dar~uber einigen, so gut sie konnten."))
      }
    }, function(action)
      _g5cik = 2
      _xiX4.Commands._IDZq.Enabled = false
      _xiX4.Commands._rR3Tr.Enabled = true
      _PUf.Commands._rKR.Enabled = true
      _LyE26.Complete = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _t6iCA == 5 and _g5cik == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = _p0t("D8GG\006f\014AGGLf\022\006\028\028fRAT(T;fyT;f6\017(fy\006Gf(A;fTA\017T\017fK;8>T\017\030"),
        Media = _55A
      },
      {
        Text = _p0t("}8f|Ty;fBT;\017\030fnATf\017T>>f\021\006\017f\0156Yy\030"),
        Media = _b7O
      }
    }, function(action)
      _g5cik = 1
      _xiX4.Commands._IDZq.Enabled = false
      _qy9c.Commands._y6C_.Enabled = true
      _PUf.Commands._x8r.Enabled = true
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _PUf)
    end)
  elseif _t6iCA == 5 and _g5cik == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Tja, da wei~s ich nicht mehr was ich sagen soll. Zweimal bin ich genarrt worden und hatte zu meinem Schaden den Spott meiner Nachbarn, die bei mir standen und jetzt ~uber mich lachen.")),
        Media = _55A
      }
    }, function(action)
      _xiX4.Commands._IDZq.Enabled = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _p0t("\tYyfG8||f\028AYyf(\006YyfTA\017,8YyfA\017f\b6yT\030"),
      Media = _55A,
      Callback = function(action)
        if action ~= nil then
          _xiX4.Commands._IDZq.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _xiX4:On_rR3Tr(target)
  _Urwigo.MessageBox({
    Text = _p0t("[T;f T>FBT;fA|>fRA;\rGAYyf|Ty;f86,BT=;8Yy>\030fSYyf|\006GG>Tf4T>F>f\021T;|YyRA\017(T\017f6\017(fRTA>T;f(ATft>8(>f8\017|Yy86T\017\030"),
    Callback = function(action)
      if action ~= nil then
        _iMfF = _iMfF + 1
        _xiX4.Commands._rR3Tr.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _YVX:On_6m_(target)
  _iMfF = _iMfF + 1
  if _t6iCA == 3 and _quEb == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Hallo ihr da, mit den Gl~ockchen an der Kappe!!! Seid Ihr der Till Eulenspiegel?")),
        Media = _bo2a
      },
      {
        Text = _p0t("t\006fA|>fT|fR\006yG\030fSYyfR6\017(T;>Tf\028AYyf|Yy\006\017af(8||fyAT;f4T\0288\017(f\028A>f\028TA\017T\028fv8\028T\017fGT=T\017f|\006GG>T\030fn8;6\028f,;8B>fSy;f6\017(fRT;f|TA(fAy;'"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Ich bin der Rektor der Alten Universit~at und auf der Suche nach Euch. Magister, Ihr habt ein interessantes Schreiben angeschlagen, dass Ihr eine jegliche Kreatur in kurzer Zeit Lesen und Schreiben lehren wollt. Darum bin ich von der Universit~at durch die Stadt geeilt, um euch zu finden. Und ich wollte Euch einen jungen Esel in die Lehre geben. Traut Ihr es Euch zu, auch ihn zu lehren?")),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Selbstverst~andlich. Doch da so ein Esel ein dummes Tier ist, wird der Unterricht ziehmlich lange dauern.")),
        Media = _b7O
      },
      {
        Text = _p0t("nATfG8\017BTf(T\017\017'"),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Sch~atzungsweise zwanzig Jahre. Ich werde im Gasthaus \"Zum Roten Turm\" wohnen. Dorthin k~onnt ihr mir den Esel bringen. Als Entgelt f~ur den Unterricht gebt mir 500 alte Groschen.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("So soll es sein. Ihr werdet den Esel im Stall des Gasthauses finden und einen Vorschuss gebe ich Euch hiermit in diesem Geldbeutel. Meldet Euch, wenn das Tier bereit zur Pr~ufung ist.")),
        Media = _bo2a
      }
    }, function(action)
      _quEb = 1
      _9iT51.Complete = true
      _fDS.Active = true
      _fDS.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _t6iCA == 3 and _quEb == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Der Till denkt, er w~are besonders schlau und k~onnte uns etwas vorgaukeln. Diesem Esel wird er nie das Lesen beibringen. So, ich habe zu tun und muss meinen Weg fortsetzen.")),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Puh, der Rektor geht er dahin. Da muss ich mir aber ordentlich etwas einfallen lassen. Die Leute hier denken, sie w~aren schlau. Na, denen werde ich es schon zeigen.")),
        Media = _b7O
      }
    }, function(action)
      _quEb = 2
      _YVX.Visible = false
      _qy9c.Commands._y6C_.Enabled = false
      _fDS.Complete = true
      if _Ue2 == 0 then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      elseif _Ue2 == 1 then
        _9Lkh.Active = false
        _9Lkh.Visible = false
        _lbk.Active = true
        _Urwigo.MessageBox({
          Text = tostring(replace_uml("Nun denn, ich werde mich hier noch etwas umsehen und dann kann es weiter zum \"Roten Turm\" gehen. Oh warte, mir f~allt etwas ein. Hier im Kreuzsand ragen die beiden H~auser der ehemaligen Armenburse ~uber das Wasser. Diese m~ochte ich mir noch etwas n~aher anschauen. Lauf einfach den Weg weiter und gehe nicht ~uber die Br~ucke.")),
          Media = _b7O,
          Callback = function(action)
            if action ~= nil then
              _8F9wM.Active = true
              _8F9wM.Visible = true
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif _t6iCA == 5 and _YwmiO == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Seid gegr~u~st mein lieber Till! Wie laufen die Gesch~afte des Unterrichts mit dummen Tieren? Habt ihr Euch zur Gen~uge mit dem Esel angefreundet?")),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Guten Tag werter Rektor! Sch~on Sie hier zu treffen, ich war gerade auf dem Weg zu Ihnen. Und dies mit guten Nachrichten. Es ist nun acht Tage her, seit ich mit dem Unterricht begann. Das Eseltier zeigt erste Fortschritte beim Erlernen der Lesef~ahigkeit und wenn es Euch beliebt, k~onnte ich mit dem Esel eine kleine Lehrvorf~uhrung einrichten. Herr Rektor, wann wollt Ihr einmal sehen, was mein Sch~uler macht?")),
        Media = _b7O
      },
      {
        Text = _p0t("\003AT=T;f 8BA|>T;afRAGGfT;f(ATf\003Ty;Tf(T\017\017f8\017\017Ty\028T\017'"),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Er ist von unm~a~sig grober Art, und es wird mir sehr schwer, ihn zu lehren. Jedoch habe ich es mit gro~sem Flei~s und vieler Arbeit erreicht, dass er einige Buchstaben und besonders etliche Vokale kennt und nennen kann. Wenn Ihr wollt, so geht mit mir, Ihr sollt es dann h~oren und sehen.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Nun mein lieber Till, das sind doch wundervolle Nachrichten. Lasst uns das Schauspiel auf dem Platz hinter dem Rathaus veranstalten. Bringt ihr nur den Esel und den Psalter, ich k~ummere mich um einige Zuschauer f~ur die w~urdige Kulisse.")),
        Media = _bo2a
      }
    }, function(action)
      _qy9c.Commands._y6C_.Enabled = true
      _YwmiO = 1
      _5d_.Complete = true
      if _Ue2 == 0 then
        _Urwigo.MessageBox({
          Text = tostring(replace_uml("Da geht er hin, der Rektor und ahnt nicht das Geringste. Ich werde noch eine kleine St~arkung zu mir nehmen und dann k~onnen wir durch die Rathausgasse schlendern.")),
          Media = _b7O,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      elseif _Ue2 == 1 then
        _HdNc.Active = false
        _YVX.Visible = false
        _Urwigo.MessageBox({
          Text = tostring(replace_uml("Da geht er hin, der Rektor und ahnt nicht das Geringste. Auch hier sind wir nun fertig. Es wird Zeit durch die Rathausgasse zu laufen und uns beim Pr~ufungsort einzufinden. Zuvor suchen wir aber erst wieder eine gut versteckte Tafel.")),
          Media = _b7O,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.RunDialogs(function()
                Wherigo.GetInput(_XD_)
              end)
            end
          end
        })
      end
    end)
  elseif _t6iCA == 5 and _YwmiO == 1 then
    _Urwigo.MessageBox({
      Text = _p0t("\015\017>|Yy6G(AB>f\028AYyaf\028TA\017Tf/TA>fA|>f\r\0178rrf6\017(fT|fBA=>f;TAYyGAYyfF6f>6\017\030fnA;f|TyT\017f6\017|fyA\017>T;f(T\028f\b8>y86|\030"),
      Media = _bo2a,
      Callback = function(action)
        if action ~= nil then
          _YVX.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Auf dieses Schauspiel bin ich m~achtig gespannt. Der Till wird sich pr~achtig blamieren, wie sollte er auch diesem dummen Tier das Lesen beibringen k~onnen.")),
      Media = _bo2a,
      Callback = function(action)
        if action ~= nil then
          _YVX.Commands._6m_.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Aber ... wie ... das ... dieser Teufel!!! Er h~alt uns zum Narren und ist doch selbst der leibhaftige Narr. Mir dreht sich der Kopf, mir schwinden die Sinne. Haben wir dies wirklich verdient? Mir wird schwarz vor Augen ... ... ...")),
        Media = _bo2a
      },
      {
        Text = tostring(replace_uml("Bald danach starb der Rektor. (Ja ich wei~s, es klingt und ist grausam, aber ich habe mir die Geschichte nicht ausgedacht und halte mich zu gro~sen Teilen an die Vorlage. Also nicht so ernst nehmen.)")),
        Media = _nWYU
      }
    }, function(action)
      _YVX.Visible = false
      _ZbkPw = 1
      _qy9c.Commands._y6C_.Enabled = true
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _qy9c)
    end)
  end
end
function _oqu:On_1HBBf(target)
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("1392 wurde die Universit~at als F~unfte im deutschsprachigen Raum er~offnet. Schnell wuchs ihr Bekanntheitsgrad, da von Anfang an alle vier Fakult~aten zugelassen waren (Theologie, Jura, Medizin und Philosophie). Damals gab es nur diese vier Fachbereiche. 1816 wurde die Universit~at durch die preu~sische Regierung geschlossen. Erst 1994 kam es zu einer Neugr~undung, doch wegen fehlenden Platzes im Zentrum befinden sich die Universit~atsgeb~ude jetzt au~serhalb der Stadt."))
  })
end
function _53tRP:On_kwfwl(target)
  _iMfF = _iMfF + 1
  _qy9c.Commands._y6C_.Enabled = true
  if _ycbE == 0 and (_EurAG == 0 or _EurAG == 1) then
    _ycbE = 1
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Es ist eine sehr gute Idee, dieses Tor genauer anzuschauen. Wie ich sehe, ist dies das Tor der Alten Universit~at. Genau richtig, um meinen Zettel dran zu h~angen.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _jKP.Commands._2M6.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _ycbE == 1 and _EurAG == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("[8|f\014\006;fy8=TfAYyf\0176\017f|Yy\006\017f6\017>T;|6Yy>af8=T;fy8=TfAYyfTA\017T\017fr8||T\017(T\017f/T>>TGfF6\028f(;8\017f\0288YyT\017f(8=TA'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    })
  elseif _ycbE == 1 and _EurAG == 1 and _IAcno == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("}T>F>fG8||f\028AYyfT\017(GAYyf(T\017f/T>>TGf8\017f(8|f\014\006;f\0288YyT\017\030f\t\017BT|Yy86>fy8=TfAYyf\028A;f\014\006;f6\017(f/T>>TGf4T>F>fBT\0176B\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _jKP.Commands._2M6.Enabled = true
          _53tRP.Commands._kwfwl.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    })
  elseif _ycbE == 1 and _EurAG == 1 and _IAcno == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Mein Zettel h~angt und macht sich richtig gut an dem Tor. Ich k~onnte jetzt wirklich weiter laufen. Es steht immer noch drauf: \"Hiermit gebe ich kund, ich bin in der Lage einer jeglichen Kreatur in kurzer Zeit Lesen und Schreiben zu lehren!!! Till\"")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _53tRP.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _53tRP:On_GoWD(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = _p0t("trA>FT\017A(TTf\030\030\030fR\006fy8=TfAYyf(\006YyfBGTAYyf(ATf\0248;=T'^K\be[A;fBT,8GGT\017f8G|\006f(AT|TftYy\028AT;T;TAT\017f8\017f(T\017f\017T6fBT|>8G>T>T\017f\0248||8(T\017'f A;fTy;GAYyfBT|8B>f\017AYy>\030fKTAf(TA\017T\017fS(TT\017f\r8\017\017f(8|fyAT;fTA\017TfG6|>ABTf\\T;8\017|>8G>6\017BfRT;(T\017\030"),
    Media = _SZe,
    Callback = function(action)
      if action ~= nil then
        _53tRP.Commands._GoWD.Enabled = false
      end
    end
  })
end
function _53tRP:On_kPRK(target)
  _Urwigo.MessageBox({
    Text = ((replace_uml("Die Alte Universit~at - das Collegium Maius - wurde im Zweiten Weltkrieg zerst~ort, nur das Kielbogenportal blieb erhalten. 1992 begann der Neubau nach historischem Vorbild. Dieser konnte 1994 abgeschlossen werden. ") .. cr) .. cr) .. replace_uml("Heute finden in dem Geb~aude der Alten Universit~at keine Vorlesungen mehr statt, der Platz w~urde einfach nicht ausreichen. Ein genauer Blick auf die sch~onen Details lohnt sich trotzdem."),
    Media = _5wacS
  })
end
function _jKP:On_oE0U(target)
  _iMfF = _iMfF + 1
  _EurAG = 1
  _Urwigo.MessageBox({
    Text = "",
    Media = _QNc,
    Callback = function(action)
      if action ~= nil then
        if _IAcno == 0 then
          _jKP.Commands._2M6.Enabled = true
        end
        _qy9c.Commands._y6C_.Enabled = true
        if _ycbE == 0 then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        elseif _ycbE == 1 then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    end
  })
end
function _jKP:On_2M6(target)
  _iMfF = _iMfF + 1
  if _EurAG == 0 and _ycbE == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Na du bist mir ein lustiges Gesch~opf! Ich kann doch nicht irgendwelche Zettel an irgendwelche Tore schlagen. Erst muss ich wissen, was auf dem Zettel drauf steht und was das f~ur ein Tor ist!")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _jKP.Commands._2M6.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    })
  elseif _EurAG == 0 and _ycbE == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Bevor ich irgendeinen Zettel an das Tor der Alten Universit~at &nbsp;h~ange, muss ich wissen, was da ~uberhaupt drauf steht. Zu meinem Gl~uck bin ich des Lesens m~achtig.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _jKP.Commands._2M6.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
        end
      end
    })
  elseif _EurAG == 1 and _ycbE == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml([[
H~angst du gern Zettel an fremde Tore?<BR>
Wer wei~s wer hier wohnt. Erst mal schauen, was das f~ur ein Tor ist!]])),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _jKP.Commands._2M6.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _53tRP)
        end
      end
    })
  elseif _EurAG == 1 and _ycbE == 1 then
    _iQuD.Active = false
    _Urwigo.MessageBox({
      Text = (((((replace_uml("Raschel ... Bastel ... Klopf ... Kleb ... Festmach ... !!!") .. cr) .. cr) .. replace_uml("So, das sollte halten. Der Zettel h~angt. Mal schauen, ob das auch einer liest.")) .. cr) .. cr) .. replace_uml("Ach ... bevor ich weiter gehe ... was steht denn Interessantes dort auf der Tafel neben dem Tor geschrieben."),
      Media = _Of8,
      Callback = function(action)
        if action ~= nil then
          _jKP.Visible = false
          _53tRP.Commands._kwfwl.Enabled = true
          _IAcno = 1
          _Ubz_A.Complete = true
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tPpcO)
          end)
        end
      end
    })
  end
end
function _jKP:On_zXhf0(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Bist du bei Trost? Nun ist er hin~uber und wie soll ich jetzt meine Dienste anpreisen? ~Uberleg doch mal! ... Ach du wolltest nur testen, ob ich deine Vorschl~age annehme? Mit dir kann man was erleben. Du hast gro~ses Gl~uck, ich habe noch einen weiteren solchen Zettel in der Tasche.")),
    Media = _Bero,
    Callback = function(action)
      if action ~= nil then
        _jKP.Commands._zXhf0.Enabled = false
        Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
      end
    end
  })
end
function _jKP:On_JgN(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Also einmal in der Mitte falten, zwei Ecken nach innen knicken, die Fl~ugel wieder nach au~sen falten und die kleinen Teilchen an den Fl~ugeln gestalten. Fertig ist das Fliegerchen ... aber dann fliegt das Teil vielleicht richtig gut und ich bekomme es nicht wieder! Was sollte ich dann an das Tor anschlagen?")),
    Media = _GhO40,
    Callback = function(action)
      if action ~= nil then
        _jKP.Commands._JgN.Enabled = false
        Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _jKP)
      end
    end
  })
end
function _PUf:On_x8r(target)
  _iMfF = _iMfF + 1
  if _t6iCA == 2 and _g5cik == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Ein leckerer Braten und ich w~urde ihn sehr gern essen. Aber wenn ich ihn einfach so nehme wird das gro~sen ~Arger geben. Ich sollte erst mit dem Metzger reden.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _PUf.Commands._yxTTU.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _xiX4)
        end
      end
    })
  elseif _t6iCA == 2 and _g5cik == 1 then
    _bmj.Active = false
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Ein solches Angebot kann ich nicht ausschlagen, mein lieber Metzger. Vielen Dank f~ur die freundliche Gabe. Und nun schnell weg hier, so richtig einverstanden scheint mir der Bursche nicht zu sein.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Aber Halt!!! Ist dies hier nicht das eine Ende der ber~uhmten Kr~amerbr~ucke? Wenn ich schon mal hier bin m~ochte ich das doch etwas genauer wissen. Hier muss es eine Tafel geben, die mir weiter helfen kann.")),
        Media = _b7O
      }
    }, function(action)
      _PUf:MoveTo(Player)
      _xVf = 1
      _Ue2 = 0
      _PUf.Commands._yxTTU.Enabled = true
      _xiX4.Commands._IDZq.Enabled = true
      _qy9c.Commands._y6C_.Enabled = true
      _PUf.Commands._x8r.Enabled = false
      _PUf.Commands._rKR.Enabled = true
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_GTTeH)
      end)
    end)
  elseif _t6iCA == 5 and _g5cik == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("SYyfy8=TfD6\017BT;f6\017(fyAT;f(6,>T>fT|fR6\017(T;=8;\030f[T;fGT>F>TfK;8>T\017fA|>f8Yy>f\0148BTfyT;f6\017(fAYyfRT;(Tf\028A;fRAT(T;fTA\017T\017f\017T6T\017f\003TY\rT;=A||T\017fy\006GT\017\030f\t=T;f\rG86T\017fBAG>f\017AYy>afT;|>f\0286||fAYyf\028A>f(T\028f T>FBT;f;T(T\017\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _PUf.Commands._x8r.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _xiX4)
        end
      end
    })
  elseif _t6iCA == 5 and _g5cik == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = _p0t("\0156GT\017|rATBTGfRAGGf\0178Yyf(T\028fK;8>T\017fB;TA,T\017\030f[8fA|>f(T;f T>FBT;f,GA\017\rf6\017(f\017A\028\028>f(T\017fK;8>T\017f|Yy\017TGGf8\017f|AYy\030")
      },
      {
        Text = tostring(replace_uml("Warte, la~s den Braten liegen, ich will ihn bezahlen.")),
        Media = _b7O
      },
      {
        Text = _p0t("[T;f T>FBT;fGTB>f(T\017fK;8>T\017fRAT(T;f86,f(ATfK8\017\r\030")
      },
      {
        Text = _p0t("nT\017\017fAYyf(A;fTA\017fn\006;>f|8BTaf(8|f(A;f\021\006\017fv6>FT\017fA|>af|\006GGf(8\017\017f(T;fK;8>T\017f\028TA\017f|TA\017'"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Du k~onntest mir solche Worte sagen, die mir nichts n~utzen. Du k~onntest mir aber auch Worte sagen, die mir von Nutzen sind, und dabei den Braten hinwegnehmen.")),
        Media = _55A
      },
      {
        Text = tostring(replace_uml("Ich will den Braten nicht anr~uhren, wenn dir meine Worte nicht gefallen. Ich spreche jetzt dies: \"Wohlauf, her, mein S~ackel, und bezahle die Leute!\" Wie gef~allt dir das? Gef~allt dir das etwa nicht?")),
        Media = _b7O
      },
      {
        Text = _p0t("[ATfn\006;>TfBT,8GGT\017f\028A;fR\006yGaf|ATf=Ty8BT\017f\028A;f|Ty;\030"),
        Media = _55A
      },
      {
        Text = tostring(replace_uml("Liebe Freunde, das h~ortet ihr wohl. Ihm gefallen meine Worte und wie abgesprochen ist der Braten damit mein.")),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Nun habe ich mir wieder einen Braten geholt, wie du mich ansprachst. Her mit dem Braten und sch~onen Tag!!")),
        Media = _b7O
      }
    }, function(action)
      _xVf = 1
      _qy9c.Commands._y6C_.Enabled = true
      _xiX4.Commands._IDZq.Enabled = true
      _PUf:MoveTo(Player)
      _PUf.Commands._yxTTU.Enabled = true
      _PUf.Commands._x8r.Enabled = false
      _PUf.Commands._rKR.Enabled = true
      _LWq0G.Complete = true
      _HcESI.Active = true
      _HcESI.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _PUf:On_yxTTU(target)
  _iMfF = _iMfF + 1
  if _xVf == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Der Braten sieht wirklich sehr saftig aus. Der wird mir k~ostlich schmecken, den m~ochte ich haben.")),
      Media = _r_bbI,
      Callback = function(action)
        if action ~= nil then
          _PUf.Commands._yxTTU.Enabled = false
          _PUf.Commands._x8r.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _xVf == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Der Braten sieht sehr saftig aus. Der wird mir k~ostlich schmecken. Ich sollte ihn aber essen, solange er warm ist.")),
      Media = _r_bbI,
      Callback = function(action)
        if action ~= nil then
          _PUf.Commands._yxTTU.Enabled = false
          _PUf.Commands._x8r.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _PUf:On_rKR(target)
  _iMfF = _iMfF + 1
  if _t6iCA == 2 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Hier esse ich den Braten lieber nicht. Der Metzger steht in der N~ahe und ist doch recht aufgebracht.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _PUf.Commands._rKR.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 3 then
    _PUf.Visible = false
    _PUf:MoveTo(_HdNc)
    _5G1lR.Complete = true
    _Ue2 = 1
    if _quEb == 2 then
      _Urwigo.Dialog(false, {
        {
          Text = tostring(replace_uml("Bevor der Braten kalt wird oder in den Schmutz f~allt, esse ich ihn lieber auf ... der schmeckt aber auch lecker ... schmatz.")),
          Media = _r_bbI
        },
        {
          Text = tostring(replace_uml("Nun denn, ich werde mich hier noch etwas umsehen und dann kann es weiter zum \"Roten Turm\" &nbsp;gehen. Oh warte, mir f~allt etwas ein. Hier im Kreuzsand ragen die beiden H~auser der ehemaligen Armenburse ~uber das Wasser. Diese m~ochte ich mir noch etwas n~aher anschauen. Einst war hier ein Internat, in dem mittellose Studenten der Erfurter Universit~at unterkommen konnten.")),
          Media = _b7O
        }
      }, function(action)
        _9Lkh.Active = false
        _9Lkh.Visible = false
        _lbk.Active = true
        _lbk.Visible = true
        _8F9wM.Active = true
        _8F9wM.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      _Urwigo.MessageBox({
        Text = tostring(replace_uml("Na gut ... bevor der Braten kalt wird oder in den Schmutz f~allt, esse ich ihn lieber auf ... der schmeckt aber auch lecker ... schmatz.")),
        Media = _r_bbI,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif _t6iCA == 5 and _g5cik == 1 and _xVf == 1 then
    _Ue2 = 1
    _qy9c.Commands._y6C_.Enabled = false
    _HcESI.Complete = true
    if _YwmiO == 0 then
      _PUf.Visible = false
      _Urwigo.MessageBox({
        Text = tostring(replace_uml("Hmmm ... lecker, das ~argert den Metzger sehr und f~ullt meinen Magen. Nun ist es an der Zeit dem Rektor dort dr~uben vom Lernerfolg des Esels berichten.")),
        Media = _b7O,
        Callback = function(action)
          if action ~= nil then
            _qy9c.Commands._y6C_.Enabled = true
            Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _YVX)
          end
        end
      })
    elseif _YwmiO == 1 then
      _HdNc.Active = false
      _PUf.Visible = false
      _Urwigo.MessageBox({
        Text = tostring(replace_uml("Hmmm ... lecker, das ~argert den Metzger sehr und f~ullt meinen Magen. Mit dem Rektor sind wir auch verabredet, er und seine Gefolgschaft werden Augen machen ... oh ist das spannend. Das wird ein Spa~s werden. Uns h~alt hier nichts mehr, es wird Zeit durch die Rathausgasse zu laufen. Zuvor suchen wir aber erst wieder eine gut versteckte Tafel.")),
        Media = _b7O,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_XD_)
            end)
          end
        end
      })
    end
  end
end
function _viu9:On_ywQD(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = ((replace_uml("AAAHHH!!!") .. cr) .. cr) .. replace_uml("Huch ... das arme Tier ... steh wieder auf du Kreatur ... warum ist der denn umgefallen ... sein Herz schl~agt noch ... ja komm, steh wieder auf ... was hat mich da nur geritten ... zum Gl~uck, er lebt noch."),
    Media = _vKlD3,
    Callback = function(action)
      if action ~= nil then
        _viu9.Commands._ywQD.Enabled = false
      end
    end
  })
end
function _viu9:On_QKb(target)
  _iMfF = _iMfF + 1
  if _KXd == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("}8f(8|fA|>fTA\017TfB6>TfS(TTf\030\030\030fyAT;f\028TA\017f\022GTA\017T;f,;A||\030"),
      Media = _0AZdW,
      Callback = function(action)
        if action ~= nil then
          _KXd = _KXd + 1
        end
      end
    })
  elseif _KXd == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Na da hat aber einer m~achtig gro~sen Appetit ... na hier, ist ja genug Futter da.")),
      Media = _0AZdW,
      Callback = function(action)
        if action ~= nil then
          _KXd = _KXd + 1
        end
      end
    })
  elseif _KXd == 2 then
    _Urwigo.MessageBox({
      Text = _p0t("DT+afAYyf(8Yy>Tf(6f|TAT|>fTA\017f\015|TGf\030\030\030f(8=TAf=T\017A\028\028|>f(6f(AYyfRATfTA\017f\024;T|||YyRTA\017f\030\030\030f(8\0178YyfA|>fT|fBT\0176B\030"),
      Media = _0AZdW,
      Callback = function(action)
        if action ~= nil then
          _viu9.Commands._QKb.Enabled = false
          _KXd = _KXd + 1
        end
      end
    })
  elseif _KXd == 3 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Vergiss es, genug ist genug!!! Bevor du mir platzt, ziehe ich jetzt die Rei~sleine. Futter gibt es so nicht mehr.")),
      Media = _0AZdW,
      Callback = function(action)
        if action ~= nil then
          _A7tU.Commands._zmD.Enabled = false
          _viu9.Commands._QKb.Enabled = false
          _KXd = _KXd + 1
        end
      end
    })
  end
end
function _viu9:On_HI_(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Mir scheinen meine Streiche langsam zu Kopf zu steigen. Was habe ich nur f~ur Gedanken? Wenn ich den Esel davon jage, muss ich das Geld zur~uck zahlen. Oder ich br~auchte einen neuen Esel. Also behalte ich den Esel lieber.")),
    Media = _b7O,
    Callback = function(action)
      if action ~= nil then
        _viu9.Commands._HI_.Enabled = false
      end
    end
  })
end
function _viu9:On_irMY(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Z~opfe f~ur den Esel ... eine gute Idee. Das wird die Leute erfreuen und belustigen, wenn der Esel sch~on zurecht gemacht ist ... Du hast aber auch Ideen.")),
    Media = _9Zqu1,
    Callback = function(action)
      if action ~= nil then
        _viu9.Commands._irMY.Enabled = false
      end
    end
  })
end
function _viu9:On_fnIgQ(target)
  _iMfF = _iMfF + 1
  if _ROZ9z == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Dies ist ein ehrenwerter Wunsch. Nur der Zeitpunkt ist wenig schlau gew~ahlt. Der Esel muss eine Pr~ufung ablegen, vorher kann ich ihn nicht gehen lassen.")),
      Media = _7ej,
      Callback = function(action)
        if action ~= nil then
          _7XW = _7XW + 1
          _viu9.Commands._fnIgQ.Enabled = false
        end
      end
    })
  elseif _ROZ9z == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml([[
Der Esel hat seine Aufgabe wirklich prima erf~ullt und sich seine Freiheit und Ruhe verdient.<BR>
Lauf, mein Kleiner und lass es dir gut ergehen.]])),
      Media = _0_d6,
      Callback = function(action)
        if action ~= nil then
          _3DN = 1
          _qy9c.Commands._y6C_.Enabled = true
          _viu9.Visible = false
          _Dop0n.Complete = true
          _1DGs.Active = true
          _1DGs.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _fZz:On_mWES(target)
  _iMfF = _iMfF + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Ein Psalter (Psalterium) ist ein Buch (Handschrift oder Druck), das allein oder im Kern die biblischen Psalmen enth~alt, entweder in der hebr~aischen Originalsprache oder in einer der vielen ~Ubersetzungen.")),
    Media = _fJvl,
    Callback = function(action)
      if action ~= nil then
        _fZz.Commands._mWES.Enabled = false
        _K15l = 1
      end
    end
  })
end
function _fZz:On_iS2RE(target)
  _iMfF = _iMfF + 1
  if _t6iCA == 4 and _K15l == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("SYyf|\006GGf(T\017fn\ttfA\017f(ATf\022;ArrTfGTBT\017'fn8|f=A>>TfA|>fTA\017f`t\t\003\014\015\b'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _fZz)
        end
      end
    })
  elseif _t6iCA == 4 and _K15l == 1 and _1PT == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("[8fGTBTfAYyf(T\017f`|8G>T;f\0288GfA\017f(ATf\0246>>T;\r;ArrTf\030\030\030f\006=f(T;f\015|TGf(8\021\006\017fGT|T\017fGT;\017>'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _zFYo = 1
          _fZz.Commands._iS2RE.Enabled = false
          _A7tU.Commands._1cm8.Enabled = true
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _A7tU)
        end
      end
    })
  elseif _t6iCA == 4 and _K15l == 1 and _1PT == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Na wer h~atte das gedacht. Das klappt doch pr~achtig. Nun liegt der Hafer zwischen den ersten Seiten des Psalters und dieses Buch liegt in der Futterkrippe. Der Esel f~angt an zu fressen und um an die K~orner unter den Seiten zu kommen, bl~attert er mit seinem Maul um. Jetzt ist das Korn alle und ... er schreit so laut er kann \"IA IA ... IA\". Toll.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _1PT = 2
          _zFYo = 1
          _fZz.Commands._iS2RE.Enabled = false
          _A7tU.Commands._1cm8.Enabled = true
          _Mnxxy = 1
          _vfvQq.Complete = true
          _7XM2.Active = true
          _7XM2.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _t6iCA == 6 and _zFYo == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = _p0t("t\006f\028TA\017f\rGTA\017T|f\015|TG>AT;\030fDAT;fy8|>f(6f(T\017f`|8G>T;\030fv6\017fFTABfR8|f(6fBTGT;\017>fy8|>f6\017(fGAT|f(T\028f\bT\r>\006;f\021\006;\030"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Der gute Sch~uler hatte aber den ganzen Tag gefastet. Sobald dieser den Psalter in der Krippe bemerkte, warf er die Bl~atter hin und her und suchte den Hafer. Als er nichts fand, begann er mit lauter Stimme zu schreien: \"I - A, I - A!\"")),
        Media = _AqpJK
      },
      {
        Text = _p0t("tTy>afGAT=T;fDT;;af(ATf=TA(T\017f\\\006\r8GTfSf6\017(f\taf(ATf\r8\017\017fT;f4T>F>f|Yy\006\017ofAYyfy\006,,TafT;fRA;(f\017\006YyfB6>fRT;(T\017\030"),
        Media = _b7O
      }
    }, function(action)
      _fZz.Visible = false
      _viu9.Commands._HI_.Enabled = false
      _viu9.Commands._fnIgQ.Enabled = true
      _XYT.Complete = true
      _Dop0n.Active = true
      _Dop0n.Visible = true
      _zFYo = 1
      _ROZ9z = 1
      _YVX.Commands._6m_.Enabled = true
      _qy9c.Commands._y6C_.Enabled = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _fZz:On_fZv(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Bevor ich den Psalter verschenken kann, muss der Esel daraus vorlesen. Sonst kann er die Pr~ufung doch nicht ablegen.")),
    Media = _b7O,
    Callback = function(action)
      if action ~= nil then
        _fZz.Commands._fZv.Enabled = false
      end
    end
  })
end
function _fZz:On_mmcN(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Moment mal ... ich schau, ob ich ein paar Buntstifte einstecken habe ... letztens hatte ich noch welche ... hm, tut mir sehr Leid. Das Buch geh~ort sowieso nicht mir und ist nur geborgt. Lassen wir das mit dem Anmalen.")),
    Media = _16_4,
    Callback = function(action)
      if action ~= nil then
        _fZz.Commands._mmcN.Enabled = false
      end
    end
  })
end
function _zVIl:On_Uds(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Raus ... raus aus meinem Kopf ... welch seltsame Gedanken ... was sollte das bringen, wenn ich die Futterkrippe umsto~se? Also bitte ...")),
    Media = _I5y,
    Callback = function(action)
      if action ~= nil then
        _zVIl.Commands._Uds.Enabled = false
      end
    end
  })
end
function _zVIl:On_Oypri(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Naja, die Krippe sieht sehr sauber aus ... ja ... das kann ich so lassen. Wollen es mit der Sauberkeit nicht ~ubertreiben, schlie~slich bin ich ein Narr und keine Putzfee.")),
    Media = _phe,
    Callback = function(action)
      if action ~= nil then
        _zVIl.Commands._Oypri.Enabled = false
      end
    end
  })
end
function _zVIl:On_tc1rG(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Diese Stadt scheint auf mich Narren nicht angewiesen zu sein. Mit dir als Bewohner hat sie genug auszustehen. Du scheinst diese Stadt nicht zu m~ogen? Ich kann doch hier nicht die Krippe anz~unden? H~altst du mich etwa f~ur einen Feuerteufel?")),
    Media = _4Ks7F,
    Callback = function(action)
      if action ~= nil then
        _zVIl.Commands._tc1rG.Enabled = false
      end
    end
  })
end
function _A7tU:On_zmD(target)
  _iMfF = _iMfF + 1
  if _KXd == 0 then
    _Urwigo.MessageBox({
      Text = _p0t("}8f(8|fA|>fTA\017TfB6>TfS(TTf\030\030\030fyAT;f\028TA\017f\022GTA\017T;f,;A||\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _KXd = _KXd + 1
        end
      end
    })
  elseif _KXd == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Na da hat aber einer m~achtig gro~sen Appetit ... na hier, ist ja genug Futter da.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _KXd = _KXd + 1
        end
      end
    })
  elseif _KXd == 2 then
    _Urwigo.MessageBox({
      Text = _p0t("DT+afAYyf(8Yy>Tf(6f|TAT|>fTA\017f\015|TGf\030\030\030f(8=TAf=T\017A\028\028|>f(6f(AYyfRATfTA\017f\024;T|||YyRTA\017f\030\030\030f(8\0178YyfA|>fT|fBT\0176B\030"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _KXd = _KXd + 1
        end
      end
    })
  elseif _KXd == 3 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Vergiss es!!! Bevor du mir platzt, ziehe ich jetzt die Rei~sleine. Futter gibt es so nicht mehr.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _A7tU.Commands._zmD.Enabled = false
          _viu9.Commands._QKb.Enabled = false
          _KXd = _KXd + 1
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Jetzt ist es aber wirklich genug. Du bekommst nichts mehr.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _A7tU.Commands._zmD.Enabled = false
          _viu9.Commands._QKb.Enabled = false
          _KXd = _KXd + 1
        end
      end
    })
  end
end
function _A7tU:On_1cm8(target)
  _iMfF = _iMfF + 1
  if _K15l == 0 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Bevor ich den Hafer in den Psalter lege m~ochte ich erst wissen, was ein PSALTER ~uberhaupt ist.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _fZz)
        end
      end
    })
  elseif _zFYo == 0 and _1PT == 0 and _K15l == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("So ... verr~uckte Sache ... jetzt liegt der Hafer im Psalter zwischen den ersten Seiten. Und was mache ich nun damit?")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _1PT = 1
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _fZz)
        end
      end
    })
  elseif _zFYo == 0 and _1PT == 1 and _K15l == 1 then
    _Urwigo.MessageBox({
      Text = _p0t("[8fGATB>f|Yy\006\017fBT\0176BfD8,T;fA\028f`|8G>T;af\0176;fR\006F6f|\006GGf(8|fB6>f|TA\017'"),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _A7tU.Commands._1cm8.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _fZz)
        end
      end
    })
  elseif _zFYo == 1 and (_1PT == 0 or _1PT == 1) and _K15l == 1 then
    _Urwigo.MessageBox({
      Text = tostring(replace_uml("Na wer h~atte das gedacht. Das klappt doch pr~achtig. Nun liegt der Hafer zwischen den ersten Seiten des Psalters und dieses Buch liegt in der Futterkrippe. Der Esel f~angt an zu fressen und um an die K~orner unter den Seiten zu kommen, bl~attert er mit seinem Maul um. Jetzt ist das Korn alle und ... er schreit so laut er kann \"I-A I-A ... I-A\" ... Toll.")),
      Media = _b7O,
      Callback = function(action)
        if action ~= nil then
          _1PT = 2
          _Mnxxy = 1
          _qy9c.Commands._y6C_.Enabled = true
          _vfvQq.Complete = true
          _7XM2.Active = true
          _7XM2.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _zFYo == 1 and _1PT == 2 and _K15l == 1 then
    _9uVW0.Active = false
    _Urwigo.Dialog(false, {
      {
        Text = _p0t("\tG|\006f\017\006YyfTA\017\0288Gf(T\017fD8,T;fFRA|YyT\017f(ATfT;|>T\017ftTA>T\017f(T|fK6YyT|f|>;T6T\017f\030\030\030f48fT|f\rG8rr>\030fnT\017\017f(8|f\022\006;\017f8GGTfA|>af|Yy;TA>fT;fRAT(T;f*Sl\t*\030"),
        Media = _b7O
      },
      {
        Text = tostring(replace_uml("Der Esel hat seinen Teil gelernt. Nun kann ich zum Rektor gehen und die ersten Erfolge vorweisen. Auf dessen Gesicht bin ich gespannt. Als n~achstes werde ich ~uber die Kr~amerbr~ucke zum Benediktsplatz laufen. Vielleicht treffe ich dort den Rektor. Bevor wir dort hin gehen, aber erst wieder eine kleine Frage. Die Antwort findest du unter dem Roten Turm.")),
        Media = _b7O
      }
    }, function(action)
      _A7tU.Commands._1cm8.Enabled = false
      _7XM2.Complete = true
      _Mnxxy = 2
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_QQm)
      end)
    end)
  end
end
function _A7tU:On_Cnt(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Deine Ideen werden mir immer suspekter. Ich w~urde deine Vorschl~age sehr gern befolgen, aber das Korn zertrampeln? Das will der Esel dann sicher nicht mehr fressen und lesen lernt er davon sicher auch nicht.")),
    Media = _b7O,
    Callback = function(action)
      if action ~= nil then
        _A7tU.Commands._Cnt.Enabled = false
      end
    end
  })
end
function _A7tU:On_0ezl(target)
  _iMfF = _iMfF + 1
  _7XW = _7XW + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Endlich eine gute Idee. Die T~aubchen werden sich freuen und mir aus der Hand picken. Ich habe genug von den K~ornern.")),
    Media = _b7O,
    Callback = function(action)
      if action ~= nil then
        _A7tU.Commands._Cnt.Enabled = false
      end
    end
  })
end
function _g9Y:On_HvkwV(target)
  _iMfF = _iMfF + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Schau sich einer diesen Stall an. So wohnlich hat es manch Einwohner in Prag nicht, wie hier dieser Esel untergebracht ist. Und was dies erst f~ur ein h~ubsches Gesch~opf ist. Ob ich gleich mit der ersten Lehrstunde beginne? Was habe ich denn f~ur Lehrmittel zur Verf~ugung ...")),
    Media = _b7O,
    Callback = function(action)
      if action ~= nil then
        _qy9c.Commands._y6C_.Enabled = false
        _g9Y.Commands._HvkwV.Enabled = false
        _viu9.Visible = true
        _zVIl.Visible = true
        _A7tU.Visible = true
        _fZz.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _b_Z:On_Bpv(target)
  _iMfF = _iMfF + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Lecker, was dieser Metzger f~ur tolle Braten auf seinen Fleischb~anken liegen hat.")),
    Media = _b7O,
    Callback = function(action)
      if action ~= nil then
        if _xVf == 0 then
          _PUf.Visible = true
        end
        _b_Z.Visible = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _ZmYvd:On_gxfT(target)
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Der Benediktsplatz in Erfurt befindet sich am westlichen Zugang der Kr~amerbr~ucke in der historischen Altstadt. Er wurde unter dem Namen \"F?r der Kremerbrucken\" 1510 erstmals erw~ahnt. 1817 erfolgte die Umbenennung in \"Vor der Kr~amerbr~ucke\". 1831 wurde er zur Erinnerung an die Benediktikirche, die hier stand und 1809/1810 durch den franz~osischen General-Dom~anendirektor Gentil meistbietend zum Abbruch verkauft wurde, in Benediktsplatz umbenannt. Am Benediktsplatz treffen Michaelisstra~se, Kreuzgasse, Kr~amerbr~ucke, Rathausbr~ucke und Fischmarkt zusammen."))
  })
end
function _7cN:On_3mNnL(target)
  _Urwigo.MessageBox({
    Text = ((((replace_uml("Der abgebildete Code geh~ort ") .. Player.Name) .. replace_uml(" als Belohnung f~ur die erfolgreiche Begleitung bei den Abenteuern des Till in Erfurt.. Damit kann auf wherigo.com geloggt werden.")) .. cr) .. cr) .. string.sub(Player.CompletionCode, 1, 15),
    Media = _qYte,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _pV6DJ:On_pB0(target)
  if _mzy88 == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Wie irre ist das denn? Keinerlei falsche Eingaben! Das muss dir erst einmal jemand nachmachen. Darauf kannst du echt stolz sein. Maximale Wertung. Du brauchst keine Nachhilfe im Lesen oder schreiben und eine Brille scheinst du auch nicht zu ben~otigen.")),
        Media = _luZfR
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  elseif _mzy88 == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Eine falsche Eingabe kann ja mal passieren ... muss nicht, aber ich will nicht so sein. Vertippt? Falsch abgelesen? Ach egal, musst dich nicht ~argern. H~atte mir auch passieren k~onnen. Ich finde das ist eine Topleistung.")),
        Media = _luZfR
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  elseif _mzy88 < 5 then
    _Urwigo.Dialog(false, {
      {
        Text = (_p0t("[6fy8|>f") .. _mzy88) .. replace_uml(" falsche Eingaben gemacht ... hm ... war das vertippt, falsch abgelesen, Unf~ahigkeit? Hat dir jemand falsch vorgelesen? Zumindest hast du die richtigen Ergebnisse gefunden und soooo viel war nun auch nicht falsch. Kann ja ab und an mal passieren."),
        Media = _luZfR
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  elseif _mzy88 > 4 then
    _Urwigo.Dialog(false, {
      {
        Text = (_p0t("\nyf4Taf\006yf4Tf\030\030\030f(6fy8|>f") .. _mzy88) .. replace_uml(" falsche Eingaben fabriziert. Du sch~amst dich jetzt hoffentlich etwas? Und suche die Gr~unde jetzt blo~s nicht bei anderen. Wer hat denn die Fehler produziert? Also bitte ... jetzt stehe zu deinen Fehlern. Mich wundert, wie wir doch noch die Runde schaffen konnten."),
        Media = _luZfR
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  end
end
function _pV6DJ:On_PaV8(target)
  if _iMfF > 41 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Vielen Dank f~ur deine Geduld und Neugier. Durch deinen Wissensdurst hast du auch unwesentliche Teile entdecken k~onnen. Das hat uns eine lustige Runde mit einigen Extras beschert und du hast so auch etwas mehr vom Spiel gehabt.")),
        Media = _xXMdK
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  elseif _iMfF < 42 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("So geradlinig w~are ich sicher nicht durch diese Runde gerannt. Du hast geschafft nur die n~otigsten Handlungen und Situationen zu meistern, um die Runde abzulaufen und die Leute zu verulken. Respekt. So humorlos wie du bist, kannst du dich gleich bei der Universit~at auf die eben frei gewordene Anstellung als Rektor bewerben.")),
        Media = _xXMdK
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  end
end
function _pV6DJ:On_PdN(target)
  if _7XW == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Es ist wirklich kaum zu glauben, aber du hast w~ahrend der ganzen Runde keinerlei unsinnige Ideen umgesetzt. Somit sind uns einige Sp~a~se durch die Lappen gegangen. Hoffentlich hat es dir wenigstens Freude gemacht, ich h~atte es mir etwas lustiger vorstellen k~onnen. Wenn du weiter so ordentlich durchs Leben gehst, wird dir sicher viel ~Arger erspart werden ... ist doch auch nicht schlecht.")),
        Media = _UAdbA
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  elseif _7XW < 5 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Dir sitzt der kleine Schalk im Nacken und du bist gelegentlichen Verr~ucktheiten nicht abgeneigt. Trotzdem scheinst du nicht jeden Bl~odsinn mitmachen zu m~ussen. Das wird dir so manchen ~Arger mit Mitmenschen ersparen. Wenn ich nun die Stadt verlasse, wird es den Einwohnern nicht zu langweilig werden. Du kannst mit deinen Ideen f~ur ~Uberraschungen sorgen.")),
        Media = _UAdbA
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  elseif _7XW > 4 then
    _Urwigo.Dialog(false, {
      {
        Text = tostring(replace_uml("Dich kann ich wohl zu Recht einen Filou nennen. Wei~st du was das ist? Filou nenne ich einen Schelm, der den Schalk im Nacken hat. Dies ist ein Kompliment und keine Beleidigung. Jedoch solltest du nun nicht ~uberm~utig werden. Machst du mit deinen Ideen so weiter, wird es dich in Teufels K~uche bringen. Musst du selbst wissen, ist schlie~slich dein Kopf, der dann rollen k~onnte.")),
        Media = _UAdbA
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _pV6DJ)
    end)
  end
end
function _R4u:On_9Ae(target)
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Dank der heute in Mecklenburg-Vorpommern lebenden Erfurter Bildhauerin Anke Besser-G~uth ziert das Erfurter Stadtbild seit 2001 dieses minimalistische und sch~one Denkmal. Bezugnehmend auf eine Sage, in der erz~ahlt wird, wie Till Eulenspiegel in Erfurt einem Esel in einem alten Psalter lesen lehrte, gestaltete sie diese Skulptur, die sich hier hinter dem Rathaus befindet. Der Standort wurde nicht zuf~allig gew~ahlt, befindet sich doch hier auch das \"Haus zur Narrenschelle\"."))
  })
end
function _g3lRn:On_qOC3(target)
  _Urwigo.MessageBox({
    Text = ((((((((((((replace_uml("Vom Start bis hierher hat ") .. Player.Name) .. _p0t("f\021\006\017f(T\017fBT|6Yy>T\017fnT;>T\017f")) .. _mzy88) .. _p0t("f\0288Gf,8G|YyfTA\017BTBT=T\017\030f")) .. _7XW) .. replace_uml(" N~ackereien bzw. Schalkelemente wurden versucht und ")) .. _iMfF - 41) .. _p0t("fKT;TAYyTf8=|TA>|f(T;fD86r>y8\017(G6\017BfR6;(T\017f=T|6Yy>\030f\003T>F>T;T|fR6;(Tfr;\006B;8\028\028AT;>af6\028f\021T;RT\017(T>fF6fRT;(T\017f6\017(f(8|ftrATGfF6f=T;TAYyT;\017\030f\015A\017Tfy\006yTf/8yGfA|>f8G|\006fT;,;T6GAYy\030^K\be^K\be\015A\017ABTftrATGT;fy8=T\017f(AT|Tf/8yGT\017fA\028f\003\006Bf8\017BTBT=T\017\030f[AT|fBA=>f\028A;fTA\017T\017f\015A\017=GAY\raf\006=fT|f`;\006=GT\028Tf=TAf(T\017f\015A\017B8=T\017fB8=f6\017(f86Yyf[A\017BTf8=|TA>|f(T;fD86r>y8\017(G6\017Bf=T8Yy>6\017Bf,A\017(T\017\030f[AT|fFTAB>Tf\028A;f=T;TA>|af(T;f\t6,R8\017(f\021\006\017fvT=T\017(A\017BT\017fA\028fnyT;AB\006fRA;(fBT;\017f8\017BT\017\006\028\028T\017\030^K\be^K\be")) .. _mzy88) .. _p0t("l")) .. _7XW) .. _p0t("l")) .. _iMfF - 41,
    Media = _Jg3Ux,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _jF44F:On_B6rR9(target)
  Wherigo.Command("SaveClose")
end
function _jab:On_f6S9d(target)
  _Urwigo.MessageBox({
    Text = (((((replace_uml("Eine Mikwe ist ein j~udisches Ritualbad, das der rituellen Reinigung dient.") .. cr) .. cr) .. replace_uml("Die mittelalterliche Mikwe in Erfurt stammt aus dem 13. Jahrhundert, mit einem Vorg~angerbau, der sich ins 12. Jahrhundert datieren l~asst. Die Gemeinde nutzte sie bis zur Ausweisung aller Juden aus Erfurt durch den Stadtrat im Jahr 1453.")) .. cr) .. cr) .. replace_uml("Arch~aologen entdeckten das mittelalterliche Tauchbad 2007. Zuvor war das Ritualbad nur ~uber Schriftquellen bekannt. Die mittelalterliche Mikwe wird heute museal genutzt und geh~ort zum Netzwerk \"J~udisches Leben Erfurt\". Ein moderner Schutzbau dient der Sicherung des Geb~audes. Das Ritualbad kann im Rahmen von F~uhrungen besichtigt werden. Au~serdem ist das Wasserbecken jederzeit von oben durch ein Fenster im Dach des Schutzbaus einsehbar."),
    Media = _O3P
  })
end
function _AiKY:On_BKEsJ(target)
  _Urwigo.MessageBox({
    Text = ((replace_uml("Die Geschichte des heutigen Augustiner an der Kr~amerbr~ucke l~asst sich mehr als 700 Jahre zur~uckverfolgen. ~Uber das Baujahr und die urspr~ungliche Nutzung der beiden Geb~aude ist nichts bekannt. Als sicher gilt, dass sie um 1310 zur \"curia des Apothekers Heinrich von Alch\" geh~ort haben sollen. ~Uberliefert ist auch, dass der angesehene Erfurter B~urger Sigismund Thomae de Stockheym das Haus zur Steinecke (Horngasse 4) im Jahr 1484 erwarb und zum Universit~atshospital umbaute.") .. cr) .. cr) .. replace_uml("Danach wurden die beiden urspr~unglichen H~auser mehrfach umgebaut und dienten verschiedensten Nutzungen, unter anderem als Wohnung oder B~urogeb~aude. Die Edith-Haberland-Wagner-Stiftung erwarb das Geb~aude vor einigen Jahren und lie~s es mit Millionen-Aufwand liebevoll sanieren und zum Gasthaus umbauen."),
    Media = _JILu
  })
end
function _tDRZa:On_mHFYc(target)
  _Urwigo.MessageBox({
    Text = ((replace_uml("Am westlichen Ende der Kr~amerbr~ucke stand seit dem 11. Jahrhundert die Benediktikirche (Br~uckenkopfkirche). 1325 wurde die gotische Benediktikirche gemeinsam mit der Kr~amerbr~ucke errichtet. Beim Stadtbrand von 1472 wurde sie zerst~ort und anschlie~send wiederaufgebaut. Nach der Einf~uhrung der Reformation in Erfurt 1525 wurde die Gemeinde der Benediktikirche mit denen der Paulskirche und der Inneren Martinikirche zusammengelegt, weshalb in der Folgezeit in der Benediktikirche nur noch selten Gottesdienste stattfanden.") .. cr) .. cr) .. replace_uml("1802 wurden die Glocken verkauft, 1807 dann die gesamte Kirche an den Kaufmann Sigismund George, der sie bis 1810 teilweise abrei~sen lie~s. 1895 wurden schlie~slich die letzten baulichen Reste der Kirche abgetragen.")
  })
end
function _ObQ:On_HkT(target)
  _Urwigo.OldDialog({
    {
      Text = tostring(replace_uml("Die ~Agidienkirche wurde bereits 1110 als Kapelle erw~ahnt. Nach der Zerst~orung der Br~ucke und der Kirche im Jahr 1293 wurde sie als steinerner Bau wiedererrichtet und im Jahre 1325 vollendet. Das Erdgeschoss war im Mittelalter offene Halle und diente als Verkaufsraum. Nach mehrfachen Patronatswechseln bis 1525 geh~orte die Kirche den M~onchen des Schottenklosters und danach zur Kaufmannsgemeinde. Der Gottesdienst wurde 1615 eingestellt, die Kirche verkauft und zum Teil als Lagerhaus genutzt. Im Erdgeschoss befand sich ein Gesch~aft, dessen T~ur~offnungen bei Renovierungsarbeiten freigelegt wurden. Im Jahr 1927 wurde das Geb~aude als Mietshaus zur~uckerworben und seit der Restaurierung von 1957 bis 1960 von der Evangelisch-Methodistischen Kirche wieder als Gotteshaus genutzt. Sie ist die ~alteste von Methodisten benutzte Kirche der Welt."))
    },
    {
      Text = ((replace_uml("Der Kircheninnenraum liegt im ersten Geschoss, der Altarraum im sp~atgotischen Erker.") .. cr) .. cr) .. replace_uml("Der Torbogen bildet den ~ostlichen Zugang zur Kr~amerbr~ucke. Vom Turm der ~Agidienkirche bietet sich ein guter Blick ~uber die Dachlandschaft der Kr~amerbr~ucke bis hin zu den Wahrzeichen Erfurts, dem Domplatz mit Mariendom und St. Severi sowie dem Panorama der Zitadelle Petersberg. Der 33 Meter hohe Turm wird auch als Roter Turm bezeichnet und ist t~aglich f?r Besucher ge~offnet.")
    }
  })
end
function _6RPeV:On_Sg_(target)
  _Urwigo.MessageBox({
    Text = ((replace_uml("Der Wenigemarkt tauchte erstmals 1217 in einer Urkunde auf. Ein Handelsplatz bestand hier jedoch wahrscheinlich schon seit dem 11. Jahrhundert. Zun~achst war der Platz ein Markt der Kaufmannssiedlung ~ostlich der Gera. Seinen Namen erhielt er in Abgrenzung zum Domplatz,- dem \"gro~sen Markt\" Erfurts. Im Laufe des Mittelalters erlebte der Markt einen Niedergang, da sich der Handel zum einen auf andere Pl~atze und zum anderen in feste L~aden in Geb~auden verlagerte. So wurde bald nur noch mit lokalen G~utern wie etwa Getreide auf dem Markt gehandelt, jedoch nicht mehr mit hochwertigen oder Fernhandelsg~utern.") .. cr) .. cr) .. replace_uml("Im s~ud~ostlichen Bereich des Platzes steht ein Brunnen, der von der Bronzeskulptur \"Raufende Knaben\" gekr~ont wird."),
    Media = _Q9K2e
  })
end
function _Yyy:On_2Ivf(target)
  _Urwigo.MessageBox({
    Text = ((((((((replace_uml("Die Urspr~unge des Hauses reichen bis in das 11. Jahrhundert zur~uck. Das 1275 erstmals erw~ahnte Rathaus war politisches Herzst~uck der kommunalen Selbstverwaltung der Mittelaltermetropole vom 13. bis 17. Jahrhundert. Bis 1706 erreichte der Geb~audekomplex die heutigen Ausma~se.") .. cr) .. cr) .. replace_uml("Im Jahr 1830 wurde begonnen das alte Rathaus abzurei~sen, als Grund galt nur ein kleinerer Schaden am Dach. Nach Bereitstellung der finanziellen Mittel begann im Jahr 1869 der Aufbau des Rathauses in seiner heutigen Form im Stil der Neugotik. 1875 zogen die ersten Dienststellen ein; die offizielle Einweihung erfolgte am 2. Juni 1882.")) .. cr) .. cr) .. replace_uml("Das Rathaus beinhaltet einen Festsaal, der durch den Historienmaler Johann Peter Theodor Janssen ausgestaltet worden ist und Bilder der Erfurter Geschichte zeigt.")) .. cr) .. cr) .. replace_uml("Die reich bemalten Treppenh~auser sind f~ur Publikum frei zug~anglich und zeigen Werke von Eduard Kaempffer aus den Jahren 1889/96. Darin sind neben Szenen aus der Johann Faust- und der Tannh~ausersage auch Geschichten des Grafen von Gleichen dargestellt.")
  })
end
function _gGA:On_Rx_7(target)
  _JCB_7 = 0
  _gGA.Visible = false
  _4NYMd.Visible = true
end
function _gGA:On_epdtK(target)
  _Drls()
end
function _4NYMd:On_hgIk_(target)
  _JCB_7 = 1
  _4NYMd.Visible = false
  _gGA.Visible = true
  _Drls()
end
function _Voli:On_CfNoE(target)
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("In den beiden gotischen H~ausern am Flussufer der Gera, in der N~ahe der Kramerbr~ucke, waren im 15. Jahrhundert mittellose Studenten untergebracht. Die Bauweise dieser Armenbursen ist ein typisches Beispiel daf~ur, wie der Besitzer des jeweiligen Hauses Steuern sparen konnte. Nur f~ur den Teil des Hauses, welcher auf festem Boden errichtet wurde, mussten Steuern bezahlt werden. So wurden die H~auser zum Teil ~uber dem Wasser oder nach oben hin breiter gebaut."))
  })
end
function _7bUr:On_ZJHn(target)
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Der Logstreifen ist in einem magnetischen schwarzen Nano und muss mit einem STARKEN MAGNET gerade aus dem Messingschloss gezogen werden.")),
    Media = _NdZu2,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = tostring(replace_uml("Einen starken Magneten als Hilfsmittel findest du direkt ~uber dem Schloss unter dem Gel~ander.")),
          Media = _VvPs,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _p0t("\t\017f(AT|T;ft>TGGTf|\006GG>Tf(8|fnT;\rFT6BfF6f,A\017(T\017f|TA\017\030"),
                Media = _Bfe
              })
            end
          end
        })
      end
    end
  })
end
function _XLrP()
  if Wherigo.NoCaseEquals(Env.Platform, _p0t("\\T\017(\006;fgf\t\b !")) then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    Wherigo.ShowScreen(Wherigo.TASKSCREEN)
  end
end
function _5tsn()
  _iMfF = _iMfF + 1
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Ab hier BITTE UMSICHTIG handeln, OHNE EIGENES WERKZEUG!!! Versuche das richtige Schloss zu finden. Kannst du das Schloss ohne Hilfe entdecken? BITTE nach dem Fund die weiteren HINWEISE lesen.")),
    Media = _NdZu2,
    Buttons = {
      _p0t("}8"),
      _p0t("vTA\017afDAG,T")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = tostring(replace_uml("Fein, du hast es gefunden. HALTE DEN NANO BITTE ORDENTLICH FEST und lass ihn nicht ins WASSER fallen. Ich verrate dir gleich, wo sich ein Hilfsmittel befindet. Der Logstreifen ist in einem magnetischen schwarzen Nano und muss mit einem STARKEN MAGNET gerade aus dem Schloss gezogen werden. Dr~ucke weiter und du siehst ein Spoilerfoto f~ur das Werkzeug.")),
            Media = _VvPs,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = tostring(replace_uml("Das Hilfsmittel sollte sich oberhalb des Schlosses unter dem Gel~ander befinden. Damit kannst du leicht an den Nano gelangen.")),
                  Media = _Bfe,
                  Callback = function(action)
                    if action ~= nil then
                      _9SV.Visible = true
                      _qy9c.Commands._y6C_.Enabled = true
                      _qy9c.Visible = true
                      _vat.Active = true
                      _vat.Visible = true
                      _xsZE.Active = true
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              end
            end
          })
        elseif action == "Button2" then
          if _P1P == 0 then
            _Urwigo.MessageBox({
              Text = tostring(replace_uml("Oh wie schade. Da will ich dir etwas helfen. Es sollte ein rotes Schloss sein, mit meinem und Neles Namen. Sicher schwer zu sehen, bei den vielen Schl~ossern. Es h~angt am Gel~ander flussabw~arts, mehr auf der linken Seite.")),
              Media = _NdZu2,
              Callback = function(action)
                if action ~= nil then
                  _P1P = 1
                  _5tsn()
                end
              end
            })
          elseif _P1P == 1 then
            _Urwigo.Dialog(false, {
              {
                Text = tostring(replace_uml("Wie es scheint ist das Schloss nicht mehr da. Hast du richtig geschaut? Eines der vielen roten Schl~osser mit den Namen Till und Nele sollte es sein. Kannst du es wirklich nicht finden? Weil wir nicht weiter kommen, wenn das Schloss nicht mehr hier sein sollte, geht es jetzt ohne Logstreifen weiter.")),
                Media = _b7O
              }
            }, function(action)
              _qy9c.Commands._y6C_.Enabled = true
              _qy9c.Visible = true
              _vat.Active = true
              _vat.Visible = true
              _xsZE.Active = true
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          end
        end
      end
    end
  })
end
function _ANxGS()
  _Urwigo.MessageBox({
    Text = tostring(replace_uml("Hier kann das Spiel beendet werden. Dabei wird es erneut gespeichert und beendet.")),
    Buttons = {
      _p0t("}8aftYyG6||"),
      _p0t("vTA\017afRTA>T;")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          Wherigo.Command("SaveClose")
        elseif action == "Button2" then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function _Drls()
  if _JCB_7 == 1 then
    if Wherigo.NoCaseEquals(Env.Platform, _p0t("\\T\017(\006;fgf\t\b !")) then
      Wherigo.PlayAudio(_xxyf)
    else
      Wherigo.PlayAudio(__hDD)
    end
  end
end
function _mqfo()
  _iQuD.Active = false
  _tarmy.Active = false
  _bmj.Active = false
  _i7e.Active = false
  _HdNc.Active = false
  _bQEO.Active = false
  _9Lkh.Active = false
  _by6.Active = false
  _xsZE.Active = false
  _4fCr.Active = false
  _7K7j.Active = false
  _gKt.Active = false
  _9uVW0.Active = false
  _Okwc.Active = false
end
function get_type(inhalt)
  local anfang, ende = string.find(tostring(inhalt), "ZCartridge")
  if anfang ~= nil then
    return "ZCartridge"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZCharacter")
  if anfang ~= nil then
    return "ZCharacter"
  end
  local anfang, ende = string.find(tostring(inhalt), "Zone")
  if anfang ~= nil then
    return "Zone"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZInput")
  if anfang ~= nil then
    return "ZInput"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZItem")
  if anfang ~= nil then
    return "ZItem"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZCommand")
  if anfang ~= nil then
    return "ZCommand"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZTask")
  if anfang ~= nil then
    return "ZTask"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZMedia")
  if anfang ~= nil then
    return "ZMedia"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZObject")
  if anfang ~= nil then
    return "ZObject"
  end
  return "Unknown"
end
function get_target_info()
  local target_string = Env.Platform
  local target_identifier = "Unknown"
  if Env.Platform == "Win32" then
    target_identifier = "Emulator"
  elseif Env.Platform == "Vendor 1 ARM9" then
    target_identifier = "Garmin"
  elseif Env.Platform == "PocketPC 2003" then
    target_identifier = "Pocket PC"
  elseif Env.Platform == "MIDP-2.0/CLDC-1.1" then
    target_identifier = "OpenWIG_WhereYouGo"
  elseif Env.Platform == "iPhone OS 4.3.3" then
    target_identifier = "iPhone"
  end
  return target_string, target_identifier
end
function replace_uml(msg)
  local text = msg
  if text ~= nil then
    local target_string, target_identifier = get_target_info()
    if target_identifier == "Emulator" then
      text = string.gsub(text, "~a", "ae")
      text = string.gsub(text, "~o", "oe")
      text = string.gsub(text, "~u", "ue")
      text = string.gsub(text, "~A", "Ae")
      text = string.gsub(text, "~O", "Oe")
      text = string.gsub(text, "~U", "Ue")
      text = string.gsub(text, "~s", "ss")
    elseif target_identifier == "Garmin" then
      text = string.gsub(text, "~a", string.char(228))
      text = string.gsub(text, "~o", string.char(246))
      text = string.gsub(text, "~u", string.char(252))
      text = string.gsub(text, "~A", string.char(196))
      text = string.gsub(text, "~O", string.char(214))
      text = string.gsub(text, "~U", string.char(220))
      text = string.gsub(text, "~s", string.char(223))
    elseif target_identifier == "Pocket PC" then
      text = string.gsub(text, "~a", string.char(228))
      text = string.gsub(text, "~o", string.char(246))
      text = string.gsub(text, "~u", string.char(252))
      text = string.gsub(text, "~A", string.char(196))
      text = string.gsub(text, "~O", string.char(214))
      text = string.gsub(text, "~U", string.char(220))
      text = string.gsub(text, "~s", string.char(223))
    elseif target_identifier == "OpenWIG_WhereYouGo" then
      text = string.gsub(text, "~a", string.char(228))
      text = string.gsub(text, "~o", string.char(246))
      text = string.gsub(text, "~u", string.char(252))
      text = string.gsub(text, "~A", string.char(196))
      text = string.gsub(text, "~O", string.char(214))
      text = string.gsub(text, "~U", string.char(220))
      text = string.gsub(text, "~s", string.char(223))
    elseif target_identifier == "iPhone" then
      text = string.gsub(text, "~a", string.char(228))
      text = string.gsub(text, "~o", string.char(246))
      text = string.gsub(text, "~u", string.char(252))
      text = string.gsub(text, "~A", string.char(196))
      text = string.gsub(text, "~O", string.char(214))
      text = string.gsub(text, "~U", string.char(220))
      text = string.gsub(text, "~s", string.char(223))
    else
      text = string.gsub(text, "~a", string.char(228))
      text = string.gsub(text, "~o", string.char(246))
      text = string.gsub(text, "~u", string.char(252))
      text = string.gsub(text, "~A", string.char(196))
      text = string.gsub(text, "~O", string.char(214))
      text = string.gsub(text, "~U", string.char(220))
      text = string.gsub(text, "~s", string.char(223))
    end
  end
  return text
end
function replace_command_text(var_cartridge, inhalt)
  if inhalt.Commands ~= nil then
    local taget_string, target_identifier = get_target_info()
    for index, command in pairs(inhalt.Commands) do
      if target_identifier ~= "Emulator" and target_identifier ~= "Pocket PC" then
        if target_identifier ~= "Garmin" then
          command.Text = replace_uml(command.Text)
        end
        command.EmptyTargetListText = replace_uml(command.EmptyTargetListText)
      end
    end
  end
end
function replace_multiple_choices(inhalt)
  if inhalt.Choices ~= nil then
    local auswahl_tbl = inhalt.Choices
    for i = 1, #auswahl_tbl do
      auswahl_tbl[i] = replace_uml(auswahl_tbl[i])
    end
    local visible_state = inhalt.Visible
    inhalt.Visible = false
    inhalt.Choices = auswahl_tbl
    inhalt.Visible = visible_state
  end
end
function replace_alluml(var_cartridge)
  local name_objs = "Umlaute wurden ersetzt fuer Objekte: "
  local objects = var_cartridge.AllZObjects
  for index = 1, #objects do
    local inhalt = objects[index]
    local name = inhalt.Name
    if name == nil then
      name = "Unknown"
    end
    name_objs = name_objs .. name .. " " .. get_type(inhalt) .. "|"
    if inhalt.Description ~= nil then
      inhalt.Description = replace_uml(inhalt.Description)
    end
    if inhalt.Name ~= nil then
      inhalt.Name = replace_uml(inhalt.Name)
    end
    if inhalt.Text ~= nil then
      inhalt.Text = replace_uml(inhalt.Text)
    end
    replace_multiple_choices(inhalt)
    replace_command_text(var_cartridge, inhalt)
  end
  return name_objs
end
cr = "<BR>\n"
return var_cartridge
