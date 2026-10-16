require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _MEVz(str)
  local res = ""
  local dtable = "u<\001l`qSQ1\002\0188\006o\bie)\020\v\004\003A(3t%h\0057/\015\\-\028FyEc,N:M\"=aGd_C2*.\027r^$\fO>\030bn\025D?9\021|Js\016m[;fR6\a]&\022{ZI\000xk\0140\017#4XB}v5HP~Ww\024\031@'VY\nzT\t!\029\023Ug\r\026p \019jL+K"
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
_d3K = Wherigo.ZCartridge()
_uUmIF = Wherigo.ZMedia(_d3K)
_uUmIF.Id = "e9e27d92-25ea-4125-bd1a-3473ed3ae5c3"
_uUmIF.Name = _MEVz("c\014\026\017\004")
_uUmIF.Description = ""
_uUmIF.AltText = ""
_uUmIF.Resources = {
  {
    Type = "jpg",
    Filename = "MurderCastle-klein.jpg",
    Directives = {}
  }
}
_Nc06Z = Wherigo.ZMedia(_d3K)
_Nc06Z.Id = "67efa6ce-8ee7-4a6e-83ae-a4471f15df00"
_Nc06Z.Name = _MEVz("/\0177\016'\028\026Ga\0177\028.?0\004\001?v")
_Nc06Z.Description = ""
_Nc06Z.AltText = ""
_Nc06Z.Resources = {
  {
    Type = "jpg",
    Filename = "Gerichtsverhandlungklein.jpg",
    Directives = {}
  }
}
_qy6 = Wherigo.ZMedia(_d3K)
_qy6.Id = "8b7cfdd9-0705-46b3-b935-e9ba019fadcf"
_qy6.Name = _MEVz("T\017\001v\017z\t")
_qy6.Description = ""
_qy6.AltText = ""
_qy6.Resources = {
  {
    Type = "jpg",
    Filename = "Zeuge1.jpg",
    Directives = {}
  }
}
_LeB = Wherigo.ZMedia(_d3K)
_LeB.Id = "14318eca-47f5-4366-9195-f6d354711077"
_LeB.Name = _MEVz("T\017\001v\017z3")
_LeB.Description = ""
_LeB.AltText = ""
_LeB.Resources = {
  {
    Type = "jpg",
    Filename = "Zeuge2.jpg",
    Directives = {}
  }
}
_c4G = Wherigo.ZMedia(_d3K)
_c4G.Id = "105db2a1-611e-4889-bb9f-b77dfa065a2d"
_c4G.Name = _MEVz("T\017\001v\017z\025")
_c4G.Description = ""
_c4G.AltText = ""
_c4G.Resources = {
  {
    Type = "jpg",
    Filename = "Zeuge3.jpg",
    Directives = {}
  }
}
_qLZ9D = Wherigo.ZMedia(_d3K)
_qLZ9D.Id = "fe8bdee1-f133-46f8-a564-3cae0cead84f"
_qLZ9D.Name = _MEVz("A\0170\017X\026\016a\t")
_qLZ9D.Description = ""
_qLZ9D.AltText = ""
_qLZ9D.Resources = {
  {
    Type = "jpg",
    Filename = "2.jpg",
    Directives = {}
  }
}
_LSn = Wherigo.ZMedia(_d3K)
_LSn.Id = "bf56e08f-f5d1-423b-a3e0-f0de1f25d29a"
_LSn.Name = _MEVz("A\0170\017X\026\016a3")
_LSn.Description = ""
_LSn.AltText = ""
_LSn.Resources = {
  {
    Type = "jpg",
    Filename = "Dedektiv8.jpg",
    Directives = {}
  }
}
_iAK0 = Wherigo.ZMedia(_d3K)
_iAK0.Id = "da9560b6-8aa3-49a9-8925-60c9c2f2ccdb"
_iAK0.Name = _MEVz("A\0170\017X\026\016a\025")
_iAK0.Description = ""
_iAK0.AltText = ""
_iAK0.Resources = {
  {
    Type = "jpg",
    Filename = "Dedektiv3.jpg",
    Directives = {}
  }
}
_Ya9Q = Wherigo.ZMedia(_d3K)
_Ya9Q.Id = "0cb2f3fb-51b3-48b2-b71a-5e835c2d3689"
_Ya9Q.Name = _MEVz("A\0170\017X\026\016a]")
_Ya9Q.Description = ""
_Ya9Q.AltText = ""
_Ya9Q.Resources = {
  {
    Type = "jpg",
    Filename = "12.jpg",
    Directives = {}
  }
}
_LEowF = Wherigo.ZMedia(_d3K)
_LEowF.Id = "8cf98b43-0916-4eda-9dbb-0fcfef40c2ef"
_LEowF.Name = _MEVz("A\0170\017X\026\016ab")
_LEowF.Description = ""
_LEowF.AltText = ""
_LEowF.Resources = {
  {
    Type = "jpg",
    Filename = "Dedektiv5.jpg",
    Directives = {}
  }
}
_CXi = Wherigo.ZMedia(_d3K)
_CXi.Id = "c39890ff-0c59-44a2-85fe-0d5a0918c7ec"
_CXi.Name = _MEVz("A\0170\017X\026\016aN")
_CXi.Description = ""
_CXi.AltText = ""
_CXi.Resources = {
  {
    Type = "jpg",
    Filename = "1.jpg",
    Directives = {}
  }
}
_QBnp = Wherigo.ZMedia(_d3K)
_QBnp.Id = "81862741-d2c5-4543-8ca0-d5a509add97b"
_QBnp.Name = _MEVz("A\0170\017X\026\016a\030")
_QBnp.Description = ""
_QBnp.AltText = ""
_QBnp.Resources = {
  {
    Type = "jpg",
    Filename = "Dedektiv7.jpg",
    Directives = {}
  }
}
_5bP = Wherigo.ZMedia(_d3K)
_5bP.Id = "5fd6d38c-e3ee-431f-9d20-bd1670152add"
_5bP.Name = _MEVz("T\017\016\026\001?v")
_5bP.Description = ""
_5bP.AltText = ""
_5bP.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung.jpg",
    Directives = {}
  }
}
_Stg5 = Wherigo.ZMedia(_d3K)
_Stg5.Id = "09e3c706-18f1-4a7b-a90a-68ec8e868503"
_Stg5.Name = _MEVz(";yL\0177z2\016v7.?0")
_Stg5.Description = ""
_Stg5.AltText = ""
_Stg5.Resources = {
  {
    Type = "jpg",
    Filename = "OpferCigrand.jpg",
    Directives = {}
  }
}
_qECMB = Wherigo.ZMedia(_d3K)
_qECMB.Id = "22775a56-8084-4a62-92b8-c0d955b345e7"
_qECMB.Name = _MEVz(";yL\0177z2\014??\0177")
_qECMB.Description = ""
_qECMB.AltText = ""
_qECMB.Resources = {
  {
    Type = "jpg",
    Filename = "OpferConner.jpg",
    Directives = {}
  }
}
_menM = Wherigo.ZMedia(_d3K)
_menM.Id = "b0f7673a-ed16-4d63-b14b-0ad33c05fdb9"
_menM.Name = _MEVz(";yL\0177zA75z}\017.'\014'X")
_menM.Description = ""
_menM.AltText = ""
_menM.Resources = {
  {
    Type = "jpg",
    Filename = "OpferDrLeacock.jpg",
    Directives = {}
  }
}
_WwCC = Wherigo.ZMedia(_d3K)
_WwCC.Id = "1b9341ec-3bed-41d1-bbd5-a061bdea2bb9"
_WwCC.Name = _MEVz(";yL\0177zd\016\017\026o\017\004")
_WwCC.Description = ""
_WwCC.AltText = ""
_WwCC.Resources = {
  {
    Type = "jpg",
    Filename = "OpferPietzel2.jpg",
    Directives = {}
  }
}
_ZZJ = Wherigo.ZMedia(_d3K)
_ZZJ.Id = "ccdbf98d-3fbe-46d2-a298-496d9bc3a955"
_ZZJ.Name = _MEVz(";yL\0177zf\016\004\004\016.IG")
_ZZJ.Description = ""
_ZZJ.AltText = ""
_ZZJ.Resources = {
  {
    Type = "jpg",
    Filename = "OpferWilliams.jpg",
    Directives = {}
  }
}
_TRnu = Wherigo.ZMedia(_d3K)
_TRnu.Id = "bde849b8-694b-41d4-813c-091703a7e7a1"
_TRnu.Name = _MEVz("\a'\028\001\028.>07\001'X")
_TRnu.Description = ""
_TRnu.AltText = ""
_TRnu.Resources = {
  {
    Type = "jpg",
    Filename = "Schuhabdruck.jpg",
    Directives = {}
  }
}
_UXwy0 = Wherigo.ZMedia(_d3K)
_UXwy0.Id = "bf77ef99-e3c7-4939-89f4-11d1d9156930"
_UXwy0.Name = _MEVz("T\017\016\026\001?v\t")
_UXwy0.Description = ""
_UXwy0.AltText = ""
_UXwy0.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung1kl.jpg",
    Directives = {}
  }
}
_ELxg = Wherigo.ZMedia(_d3K)
_ELxg.Id = "c82123e5-ff29-43ab-834e-05eb8a6e9b70"
_ELxg.Name = _MEVz("T\017\016\026\001?vz3")
_ELxg.Description = ""
_ELxg.AltText = ""
_ELxg.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung2kl.jpg",
    Directives = {}
  }
}
_S1w = Wherigo.ZMedia(_d3K)
_S1w.Id = "b68d96ca-f662-4446-8077-d2c2cf3cc2f9"
_S1w.Name = _MEVz("c\014\004I\017GzI\016\026zc\014\026\017\004")
_S1w.Description = ""
_S1w.AltText = ""
_S1w.Resources = {
  {
    Type = "jpg",
    Filename = "Das-grausame-Folterhotel-von-Dr-Holmeskl.jpg",
    Directives = {}
  }
}
_ALoM = Wherigo.ZMedia(_d3K)
_ALoM.Id = "e901fe22-d3c7-4f46-8f03-4b199989dca2"
_ALoM.Name = _MEVz("/.\004\004\0177%")
_ALoM.Description = ""
_ALoM.AltText = ""
_ALoM.Resources = {
  {
    Type = "jpg",
    Filename = "Gallery1kl.jpg",
    Directives = {}
  }
}
_GIJmp = Wherigo.ZMedia(_d3K)
_GIJmp.Id = "fd0182bc-9c89-4610-a828-deecbcfbecee"
_GIJmp.Name = _MEVz("T\017\016\026\001?v\025")
_GIJmp.Description = ""
_GIJmp.AltText = ""
_GIJmp.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung3kl.jpg",
    Directives = {}
  }
}
_FHuiJ = Wherigo.ZMedia(_d3K)
_FHuiJ.Id = "4424a600-ca59-436a-9492-a920a7f5dcde"
_FHuiJ.Name = _MEVz("\023W\026")
_FHuiJ.Description = ""
_FHuiJ.AltText = ""
_FHuiJ.Resources = {
  {
    Type = "jpg",
    Filename = "Axt2.jpg",
    Directives = {}
  }
}
_h7R = Wherigo.ZMedia(_d3K)
_h7R.Id = "afbc3904-ed0a-4d24-aac5-887efe469ff4"
_h7R.Name = _MEVz("p\028\017zA\017a\016\004z\016?z\026\028\017zg\028\016\026\017z2\016\026%")
_h7R.Description = ""
_h7R.AltText = ""
_h7R.Resources = {
  {
    Type = "jpg",
    Filename = "Devil-in-the-White-City.jpg",
    Directives = {}
  }
}
_2Rpa4 = Wherigo.ZMedia(_d3K)
_2Rpa4.Id = "14763c4f-55e5-43e3-8287-0f477110d3ed"
_2Rpa4.Name = _MEVz("\a'\028\004\001\017GG\017\004")
_2Rpa4.Description = ""
_2Rpa4.AltText = ""
_2Rpa4.Resources = {
  {
    Type = "jpg",
    Filename = "Schluessel.jpg",
    Directives = {}
  }
}
_0wB = Wherigo.ZMedia(_d3K)
_0wB.Id = "f6cd22c7-c88a-4049-a8bf-3102835d6cf8"
_0wB.Name = _MEVz("T\014?\017\t")
_0wB.Description = ""
_0wB.AltText = ""
_0wB.Resources = {
  {
    Type = "jpg",
    Filename = "Zone01.jpg",
    Directives = {}
  }
}
__Cej = Wherigo.ZMedia(_d3K)
__Cej.Id = "0891fb8e-446c-4dea-9c20-edc1607f161c"
__Cej.Name = _MEVz("T\014?\0173")
__Cej.Description = ""
__Cej.AltText = ""
__Cej.Resources = {
  {
    Type = "jpg",
    Filename = "Zone02.jpg",
    Directives = {}
  }
}
_DLC = Wherigo.ZMedia(_d3K)
_DLC.Id = "58100879-2fa8-4d0d-ab19-2ad942d42b21"
_DLC.Name = _MEVz("T\014?\017\025")
_DLC.Description = ""
_DLC.AltText = ""
_DLC.Resources = {
  {
    Type = "jpg",
    Filename = "Zone03.jpg",
    Directives = {}
  }
}
_mnj = Wherigo.ZMedia(_d3K)
_mnj.Id = "eed6b8ff-844c-4c84-be01-2bbe699c61d9"
_mnj.Name = _MEVz("T\014?\017]")
_mnj.Description = ""
_mnj.AltText = ""
_mnj.Resources = {
  {
    Type = "jpg",
    Filename = "Zone04.jpg",
    Directives = {}
  }
}
_fg8 = Wherigo.ZMedia(_d3K)
_fg8.Id = "72704b89-de14-48fb-ad4f-54202037f2d3"
_fg8.Name = _MEVz("T\014?\017b")
_fg8.Description = ""
_fg8.AltText = ""
_fg8.Resources = {
  {
    Type = "jpg",
    Filename = "Zone05.jpg",
    Directives = {}
  }
}
_pHU = Wherigo.ZMedia(_d3K)
_pHU.Id = "07052c3d-2fa9-4e52-8d69-7bfc6c92847d"
_pHU.Name = _MEVz("T\014?\017N")
_pHU.Description = ""
_pHU.AltText = ""
_pHU.Resources = {
  {
    Type = "jpg",
    Filename = "Zone06.jpg",
    Directives = {}
  }
}
_6PPK = Wherigo.ZMedia(_d3K)
_6PPK.Id = "9de3d42b-e65a-42af-bc18-bda63b8a013b"
_6PPK.Name = _MEVz("T\014?\017\030")
_6PPK.Description = ""
_6PPK.AltText = ""
_6PPK.Resources = {
  {
    Type = "jpg",
    Filename = "Zone07.jpg",
    Directives = {}
  }
}
__M_uJ = Wherigo.ZMedia(_d3K)
__M_uJ.Id = "e80aff81-719a-4632-a3f4-910889b77172"
__M_uJ.Name = _MEVz("T\014?\017\f")
__M_uJ.Description = ""
__M_uJ.AltText = ""
__M_uJ.Resources = {
  {
    Type = "jpg",
    Filename = "Zone08.jpg",
    Directives = {}
  }
}
_WO5 = Wherigo.ZMedia(_d3K)
_WO5.Id = "ba9c8046-7580-4b9c-9479-64854c9cb0ac"
_WO5.Name = _MEVz("T\014?\017C")
_WO5.Description = ""
_WO5.AltText = ""
_WO5.Resources = {
  {
    Type = "jpg",
    Filename = "Zone09.jpg",
    Directives = {}
  }
}
_Dka = Wherigo.ZMedia(_d3K)
_Dka.Id = "fb1b55eb-0b42-48e7-bae4-e38b0d18d424"
_Dka.Name = _MEVz("T\014?\017\tZ")
_Dka.Description = ""
_Dka.AltText = ""
_Dka.Resources = {
  {
    Type = "jpg",
    Filename = "Zone10.jpg",
    Directives = {}
  }
}
_QQV = Wherigo.ZMedia(_d3K)
_QQV.Id = "a94d9ea4-f061-4ea9-888e-dd523b923b08"
_QQV.Name = _MEVz("T\014?\017\t\t")
_QQV.Description = ""
_QQV.AltText = ""
_QQV.Resources = {
  {
    Type = "jpg",
    Filename = "Zone11.jpg",
    Directives = {}
  }
}
_NSJj = Wherigo.ZMedia(_d3K)
_NSJj.Id = "f5d04b2a-ffd2-4b45-afe5-0e45d1a2819d"
_NSJj.Name = _MEVz("T\014?\017\t3")
_NSJj.Description = ""
_NSJj.AltText = ""
_NSJj.Resources = {
  {
    Type = "jpg",
    Filename = "Zone12.jpg",
    Directives = {}
  }
}
_86UZR = Wherigo.ZMedia(_d3K)
_86UZR.Id = "c8a7d63d-e625-4ed9-841e-da932fc03990"
_86UZR.Name = _MEVz("T\014?\017\t\025")
_86UZR.Description = ""
_86UZR.AltText = ""
_86UZR.Resources = {
  {
    Type = "jpg",
    Filename = "Zone13.jpg",
    Directives = {}
  }
}
_fYA = Wherigo.ZMedia(_d3K)
_fYA.Id = "1970cc19-a64a-4f8b-be8a-105efb4f111e"
_fYA.Name = _MEVz("T\014?\017\t]")
_fYA.Description = ""
_fYA.AltText = ""
_fYA.Resources = {
  {
    Type = "jpg",
    Filename = "Zone14.jpg",
    Directives = {}
  }
}
_oD_D = Wherigo.ZMedia(_d3K)
_oD_D.Id = "41cb1ce0-cd0d-4ebd-b79e-6eb1645b8088"
_oD_D.Name = _MEVz("$\016?.\004")
_oD_D.Description = ""
_oD_D.AltText = ""
_oD_D.Resources = {
  {
    Type = "jpg",
    Filename = "Final.jpg",
    Directives = {}
  }
}
_NbyFl = Wherigo.ZMedia(_d3K)
_NbyFl.Id = "8bd97e91-20c2-4534-97b7-a0fead535192"
_NbyFl.Name = _MEVz("_\014?\001G")
_NbyFl.Description = ""
_NbyFl.AltText = ""
_NbyFl.Resources = {
  {
    Type = "jpg",
    Filename = "Bonus.jpg",
    Directives = {}
  }
}
_Dgp = Wherigo.ZMedia(_d3K)
_Dgp.Id = "2401121d-d63f-46b1-90b5-5fc037a718fe"
_Dgp.Name = _MEVz("A.Gz$\001?0G\026\001\017'X")
_Dgp.Description = ""
_Dgp.AltText = ""
_Dgp.Resources = {
  {
    Type = "jpg",
    Filename = "CoinMorderhotelWIG1.jpg",
    Directives = {}
  }
}
_d6kj = Wherigo.ZMedia(_d3K)
_d6kj.Id = "ceaadc3c-1a32-4979-8d38-1d257de3a17a"
_d6kj.Name = _MEVz("U?L\014Gzo\001zul")
_d6kj.Description = ""
_d6kj.AltText = ""
_d6kj.Resources = {
  {
    Type = "jpg",
    Filename = "InfozuUV5.jpg",
    Directives = {}
  }
}
_4v1 = Wherigo.ZMedia(_d3K)
_4v1.Id = "57cc0e70-f52e-4bb7-b2ae-d1d4e4f3758a"
_4v1.Name = _MEVz("p\028\017z&?0")
_4v1.Description = ""
_4v1.AltText = ""
_4v1.Resources = {
  {
    Type = "jpg",
    Filename = "the-end-4.jpg",
    Directives = {}
  }
}
_d3K.Id = "192febad-7f91-4970-a325-945423a599f0"
_d3K.Name = "(NC) Vers. 1.4 Das Moerderhotel GC84BJF"
_d3K.Description = "Neue Vers.1.4 ab 12.08.2019. Diese wird auf dieser Homepage eigenst\195\164ndig als 1.5 gekennzeichnet.<BR>\n<BR>\n<BR>\n<BR>\n<BR>\n<BR>\n<BR>\nNachdem der erste Serienmoerder der Geschichte Amerikas mit dem Namen H.H. Holmes am 01.11.1896 gefasst wurde, musst du dich nun auf die Spurensicherung begeben. Bisher konnte dem Moerder nichts bewiesen werden und er schweigt beharrlich zu den Tatvorwuerfen. Holmes befindet sich in Untersuchungshaft und solltest du kein belastendes Beweismaterial sicherstellen koennen, muss er wieder freigelassen werden. Jedoch hat sich ein Zeuge gemeldet. Mit dem wirst du dich nun treffen....."
_d3K.Visible = true
_d3K.Activity = "TourGuide"
_d3K.StartingLocationDescription = [[
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
Lest die Anleitung in eurem Inventar, um gut vorbereitet zu sein beachtet das Listing!]]
_d3K.StartingLocation = ZonePoint(52.565267, 13.155683, 0)
_d3K.Version = "1.5"
_d3K.Company = ""
_d3K.Author = "Aski-Team"
_d3K.BuilderVersion = "URWIGO 1.22.5798.37755"
_d3K.CreateDate = "01/22/2017 18:13:30"
_d3K.PublishDate = "1/1/0001 12:00:00 AM"
_d3K.UpdateDate = "08/12/2019 20:56:49"
_d3K.LastPlayedDate = "1/1/0001 12:00:00 AM"
_d3K.TargetDevice = "PocketPC"
_d3K.TargetDeviceVersion = "0"
_d3K.StateId = "1"
_d3K.CountryId = "2"
_d3K.Complete = false
_d3K.UseLogging = true
_d3K.Media = _S1w
_dA1xe = Wherigo.Zone(_d3K)
_dA1xe.Id = "ed4192d6-14eb-4ac7-9406-85d29cebabb6"
_dA1xe.Name = _MEVz("Z5A\0177zT\017\001v\017z")
_dA1xe.Description = ""
_dA1xe.Visible = true
_dA1xe.Commands = {}
_dA1xe.DistanceRange = Distance(-1, "feet")
_dA1xe.ShowObjects = "OnEnter"
_dA1xe.ProximityRange = Distance(60, "meters")
_dA1xe.AllowSetPositionTo = false
_dA1xe.Active = true
_dA1xe.Points = {
  ZonePoint(52.5651942645396, 13.1555829988297, 0),
  ZonePoint(52.5651492207524, 13.1557387042308, 0),
  ZonePoint(52.5652730751259, 13.1558176074469, 0),
  ZonePoint(52.5653052178532, 13.155675972323, 0)
}
_dA1xe.OriginalPoint = ZonePoint(52.5652304445678, 13.1557038207076, 0)
_dA1xe.DistanceRangeUOM = "Feet"
_dA1xe.ProximityRangeUOM = "Meters"
_dA1xe.OutOfRangeName = ""
_dA1xe.InRangeName = ""
_ZpdL = Wherigo.Zone(_d3K)
_ZpdL.Id = "e2af5e06-acdb-4245-9ea3-ac7166d32f95"
_ZpdL.Name = _MEVz("b5T\014?\017")
_ZpdL.Description = ""
_ZpdL.Visible = true
_ZpdL.Media = _fg8
_ZpdL.Commands = {}
_ZpdL.DistanceRange = Distance(-1, "feet")
_ZpdL.ShowObjects = "OnEnter"
_ZpdL.ProximityRange = Distance(60, "meters")
_ZpdL.AllowSetPositionTo = false
_ZpdL.Active = false
_ZpdL.Points = {
  ZonePoint(52.5719953992421, 13.1604122905186, 0),
  ZonePoint(52.5719512120307, 13.1604477516555, 0),
  ZonePoint(52.5719667110941, 13.1606007621903, 0),
  ZonePoint(52.572003908824, 13.1605786606686, 0)
}
_ZpdL.OriginalPoint = ZonePoint(52.5719793077977, 13.1605098662583, 0)
_ZpdL.DistanceRangeUOM = "Feet"
_ZpdL.ProximityRangeUOM = "Meters"
_ZpdL.OutOfRangeName = ""
_ZpdL.InRangeName = ""
_ORm54 = Wherigo.Zone(_d3K)
_ORm54.Id = "6f16d1d1-77c4-4d1d-9a0f-98a74d2cc449"
_ORm54.Name = _MEVz("C5T\014?\017")
_ORm54.Description = ""
_ORm54.Visible = true
_ORm54.Media = _WO5
_ORm54.Commands = {}
_ORm54.DistanceRange = Distance(-1, "feet")
_ORm54.ShowObjects = "OnEnter"
_ORm54.ProximityRange = Distance(60, "meters")
_ORm54.AllowSetPositionTo = false
_ORm54.Active = false
_ORm54.Points = {
  ZonePoint(52.577702516344, 13.1525322380207, 0),
  ZonePoint(52.5777271256835, 13.152354283118, 0),
  ZonePoint(52.5776354104799, 13.1522928724375, 0),
  ZonePoint(52.577613419298, 13.1524956983855, 0)
}
_ORm54.OriginalPoint = ZonePoint(52.5776696179514, 13.1524187729904, 0)
_ORm54.DistanceRangeUOM = "Feet"
_ORm54.ProximityRangeUOM = "Meters"
_ORm54.OutOfRangeName = ""
_ORm54.InRangeName = ""
_te01 = Wherigo.Zone(_d3K)
_te01.Id = "6ab95ae5-8566-45a0-84d4-e3e87fa834e9"
_te01.Name = _MEVz("\f5T\014?\017")
_te01.Description = ""
_te01.Visible = true
_te01.Media = __M_uJ
_te01.Commands = {
  _ZFyO = Wherigo.ZCommand({
    Text = "",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_te01.Commands._ZFyO.Custom = true
_te01.Commands._ZFyO.Id = "13a5a9b8-7601-4798-a47e-66b5c3211dd0"
_te01.Commands._ZFyO.WorksWithAll = false
_te01.Commands._ZFyO.WorksWithListIds = {}
_te01.DistanceRange = Distance(-1, "feet")
_te01.ShowObjects = "OnEnter"
_te01.ProximityRange = Distance(60, "meters")
_te01.AllowSetPositionTo = false
_te01.Active = false
_te01.Points = {
  ZonePoint(52.5781399389202, 13.1567251205286, 0),
  ZonePoint(52.5781312071268, 13.1566840811267, 0),
  ZonePoint(52.5781182802013, 13.1566573143383, 0),
  ZonePoint(52.5780726358306, 13.1567103669292, 0),
  ZonePoint(52.5780957910339, 13.1567820937794, 0)
}
_te01.OriginalPoint = ZonePoint(52.5781115706226, 13.1567117953404, 0)
_te01.DistanceRangeUOM = "Feet"
_te01.ProximityRangeUOM = "Meters"
_te01.OutOfRangeName = ""
_te01.InRangeName = ""
_6Oy = Wherigo.Zone(_d3K)
_6Oy.Id = "f59cb80a-8f58-4f1d-8c7c-aa311711122a"
_6Oy.Name = _MEVz("35zT\014?\017")
_6Oy.Description = ""
_6Oy.Visible = true
_6Oy.Media = __Cej
_6Oy.Commands = {}
_6Oy.DistanceRange = Distance(-1, "feet")
_6Oy.ShowObjects = "OnEnter"
_6Oy.ProximityRange = Distance(60, "meters")
_6Oy.AllowSetPositionTo = false
_6Oy.Active = false
_6Oy.Points = {
  ZonePoint(52.5680570070847, 13.152023122963, 0),
  ZonePoint(52.5681120211264, 13.1520710717006, 0),
  ZonePoint(52.5680922808017, 13.1521827594438, 0),
  ZonePoint(52.5680310994989, 13.1521298591261, 0)
}
_6Oy.OriginalPoint = ZonePoint(52.5680731021279, 13.1521017033084, 0)
_6Oy.DistanceRangeUOM = "Feet"
_6Oy.ProximityRangeUOM = "Meters"
_6Oy.OutOfRangeName = ""
_6Oy.InRangeName = ""
_4NsAA = Wherigo.Zone(_d3K)
_4NsAA.Id = "8737d456-311a-41d5-b492-b9360fb66ae8"
_4NsAA.Name = _MEVz("\0305T\014?\017")
_4NsAA.Description = ""
_4NsAA.Visible = true
_4NsAA.Media = _6PPK
_4NsAA.Commands = {}
_4NsAA.DistanceRange = Distance(-1, "feet")
_4NsAA.ShowObjects = "OnEnter"
_4NsAA.ProximityRange = Distance(60, "meters")
_4NsAA.AllowSetPositionTo = false
_4NsAA.Active = false
_4NsAA.Points = {
  ZonePoint(52.5761413866569, 13.1591499346754, 0),
  ZonePoint(52.5760990281666, 13.1590585199421, 0),
  ZonePoint(52.5760447648477, 13.1591345797342, 0),
  ZonePoint(52.576093419559, 13.1592358960955, 0)
}
_4NsAA.OriginalPoint = ZonePoint(52.5760946498075, 13.1591447326118, 0)
_4NsAA.DistanceRangeUOM = "Feet"
_4NsAA.ProximityRangeUOM = "Meters"
_4NsAA.OutOfRangeName = ""
_4NsAA.InRangeName = ""
_Ot5wZ = Wherigo.Zone(_d3K)
_Ot5wZ.Id = "0dee5480-ae6b-44f7-a1ff-d6aa39af46b1"
_Ot5wZ.Name = _MEVz("]5T\014?\017")
_Ot5wZ.Description = ""
_Ot5wZ.Visible = true
_Ot5wZ.Media = _mnj
_Ot5wZ.Commands = {}
_Ot5wZ.DistanceRange = Distance(-1, "feet")
_Ot5wZ.ShowObjects = "OnEnter"
_Ot5wZ.ProximityRange = Distance(60, "meters")
_Ot5wZ.AllowSetPositionTo = false
_Ot5wZ.Active = false
_Ot5wZ.Points = {
  ZonePoint(52.5716968353174, 13.156994201873, 0),
  ZonePoint(52.5716908269459, 13.1569115081846, 0),
  ZonePoint(52.5717466238798, 13.1568979072482, 0),
  ZonePoint(52.571751790259, 13.1569710122815, 0)
}
_Ot5wZ.OriginalPoint = ZonePoint(52.5717215191005, 13.1569436573968, 0)
_Ot5wZ.DistanceRangeUOM = "Feet"
_Ot5wZ.ProximityRangeUOM = "Meters"
_Ot5wZ.OutOfRangeName = ""
_Ot5wZ.InRangeName = ""
_FDXx = Wherigo.Zone(_d3K)
_FDXx.Id = "7455529f-96ab-4acf-9c0d-11c3352fdf64"
_FDXx.Name = _MEVz("\tb5$\016?.\004")
_FDXx.Description = ""
_FDXx.Visible = true
_FDXx.Media = _oD_D
_FDXx.Commands = {}
_FDXx.DistanceRange = Distance(-1, "feet")
_FDXx.ShowObjects = "OnEnter"
_FDXx.ProximityRange = Distance(60, "meters")
_FDXx.AllowSetPositionTo = false
_FDXx.Active = false
_FDXx.Points = {
  ZonePoint(52.5700523758887, 13.1475587740182, 0),
  ZonePoint(52.5700179175405, 13.1475592388969, 0),
  ZonePoint(52.5700191710341, 13.1475107085709, 0),
  ZonePoint(52.5700502839455, 13.1475167310532, 0)
}
_FDXx.OriginalPoint = ZonePoint(52.5700349371022, 13.1475363631348, 0)
_FDXx.DistanceRangeUOM = "Feet"
_FDXx.ProximityRangeUOM = "Meters"
_FDXx.OutOfRangeName = ""
_FDXx.InRangeName = ""
_qrzJr = Wherigo.Zone(_d3K)
_qrzJr.Id = "3e0520a7-69b8-4d05-a529-939630afe6bf"
_qrzJr.Name = _MEVz("\t]5d7\017L\016?.\004")
_qrzJr.Description = ""
_qrzJr.Visible = true
_qrzJr.Media = _fYA
_qrzJr.Commands = {}
_qrzJr.DistanceRange = Distance(-1, "feet")
_qrzJr.ShowObjects = "OnEnter"
_qrzJr.ProximityRange = Distance(60, "meters")
_qrzJr.AllowSetPositionTo = false
_qrzJr.Active = false
_qrzJr.Points = {
  ZonePoint(52.5689593881369, 13.1501530926474, 0),
  ZonePoint(52.5689597886077, 13.1500904126258, 0),
  ZonePoint(52.5689174210406, 13.1500787398273, 0),
  ZonePoint(52.5689133873753, 13.1501363475531, 0)
}
_qrzJr.OriginalPoint = ZonePoint(52.5689374962901, 13.1501146481634, 0)
_qrzJr.DistanceRangeUOM = "Feet"
_qrzJr.ProximityRangeUOM = "Meters"
_qrzJr.OutOfRangeName = ""
_qrzJr.InRangeName = ""
_3KLu_ = Wherigo.Zone(_d3K)
_3KLu_.Id = "a92a5768-25b2-4f9a-9054-223099d817d6"
_3KLu_.Name = _MEVz("\t\t5T\014?\017")
_3KLu_.Description = ""
_3KLu_.Visible = true
_3KLu_.Media = _QQV
_3KLu_.Commands = {}
_3KLu_.DistanceRange = Distance(-1, "feet")
_3KLu_.ShowObjects = "OnEnter"
_3KLu_.ProximityRange = Distance(60, "meters")
_3KLu_.AllowSetPositionTo = false
_3KLu_.Active = false
_3KLu_.Points = {
  ZonePoint(52.5747824980681, 13.149682997659, 0),
  ZonePoint(52.5747799820537, 13.1497377122449, 0),
  ZonePoint(52.5747402504249, 13.1497455935955, 0),
  ZonePoint(52.5747430216007, 13.1496775101197, 0)
}
_3KLu_.OriginalPoint = ZonePoint(52.5747614380369, 13.1497109534048, 0)
_3KLu_.DistanceRangeUOM = "Feet"
_3KLu_.ProximityRangeUOM = "Meters"
_3KLu_.OutOfRangeName = ""
_3KLu_.InRangeName = ""
_D5LP = Wherigo.Zone(_d3K)
_D5LP.Id = "5f4088eb-d02c-42f7-8802-290dae6673a6"
_D5LP.Name = _MEVz("\0255T\014?\017")
_D5LP.Description = ""
_D5LP.Visible = true
_D5LP.Media = _DLC
_D5LP.Commands = {}
_D5LP.DistanceRange = Distance(-1, "feet")
_D5LP.ShowObjects = "OnEnter"
_D5LP.ProximityRange = Distance(60, "meters")
_D5LP.AllowSetPositionTo = false
_D5LP.Active = false
_D5LP.Points = {
  ZonePoint(52.5694554024694, 13.1532926995596, 0),
  ZonePoint(52.5694814397732, 13.1533930678014, 0),
  ZonePoint(52.5694330976168, 13.1534570848952, 0),
  ZonePoint(52.5693882926437, 13.1533639691224, 0)
}
_D5LP.OriginalPoint = ZonePoint(52.5694395581258, 13.1533767053447, 0)
_D5LP.DistanceRangeUOM = "Feet"
_D5LP.ProximityRangeUOM = "Meters"
_D5LP.OutOfRangeName = ""
_D5LP.InRangeName = ""
_4azXD = Wherigo.Zone(_d3K)
_4azXD.Id = "b424c5e4-1ab4-486f-bb30-e2d31ed20467"
_4azXD.Name = _MEVz("\tZ5T\014?\017")
_4azXD.Description = ""
_4azXD.Visible = true
_4azXD.Media = _Dka
_4azXD.Commands = {}
_4azXD.DistanceRange = Distance(-1, "feet")
_4azXD.ShowObjects = "OnEnter"
_4azXD.ProximityRange = Distance(60, "meters")
_4azXD.AllowSetPositionTo = false
_4azXD.Active = false
_4azXD.Points = {
  ZonePoint(52.5766287498057, 13.1510342376241, 0),
  ZonePoint(52.5765967244477, 13.1512263194552, 0),
  ZonePoint(52.5765035342833, 13.1511941982659, 0),
  ZonePoint(52.576519127273, 13.1509852588861, 0)
}
_4azXD.OriginalPoint = ZonePoint(52.5765620339524, 13.1511100035578, 0)
_4azXD.DistanceRangeUOM = "Feet"
_4azXD.ProximityRangeUOM = "Meters"
_4azXD.OutOfRangeName = ""
_4azXD.InRangeName = ""
_0ak = Wherigo.Zone(_d3K)
_0ak.Id = "e90f9a5c-d958-4e7f-a45a-e813b6e4aaa0"
_0ak.Name = _MEVz("N5zT\014?\017")
_0ak.Description = ""
_0ak.Visible = true
_0ak.Media = _pHU
_0ak.Commands = {}
_0ak.DistanceRange = Distance(-1, "feet")
_0ak.ShowObjects = "OnEnter"
_0ak.ProximityRange = Distance(60, "meters")
_0ak.AllowSetPositionTo = false
_0ak.Active = false
_0ak.Points = {
  ZonePoint(52.574573001637, 13.1610259557671, 0),
  ZonePoint(52.5745942147863, 13.1612194305112, 0),
  ZonePoint(52.5745134835688, 13.1613273142347, 0),
  ZonePoint(52.5744837678852, 13.1611578646946, 0)
}
_0ak.OriginalPoint = ZonePoint(52.5745411169693, 13.1611826413019, 0)
_0ak.DistanceRangeUOM = "Feet"
_0ak.ProximityRangeUOM = "Meters"
_0ak.OutOfRangeName = ""
_0ak.InRangeName = ""
_bdtc = Wherigo.Zone(_d3K)
_bdtc.Id = "8c8c926c-6858-415a-8f14-ebccf76c5b20"
_bdtc.Name = _MEVz("\t35T\014?\017")
_bdtc.Description = ""
_bdtc.Visible = true
_bdtc.Media = _NSJj
_bdtc.Commands = {}
_bdtc.DistanceRange = Distance(-1, "feet")
_bdtc.ShowObjects = "OnEnter"
_bdtc.ProximityRange = Distance(60, "meters")
_bdtc.AllowSetPositionTo = false
_bdtc.Active = false
_bdtc.Points = {
  ZonePoint(52.5733282027511, 13.1489255985635, 0),
  ZonePoint(52.5733263551746, 13.1489901076199, 0),
  ZonePoint(52.5733904754712, 13.1489970387257, 0),
  ZonePoint(52.5733904953199, 13.1489364550406, 0)
}
_bdtc.OriginalPoint = ZonePoint(52.5733588821792, 13.1489622999874, 0)
_bdtc.DistanceRangeUOM = "Feet"
_bdtc.ProximityRangeUOM = "Meters"
_bdtc.OutOfRangeName = ""
_bdtc.InRangeName = ""
_qAPx = Wherigo.Zone(_d3K)
_qAPx.Id = "0a948d2b-2f70-42ed-8329-ddb0efcb9d4f"
_qAPx.Name = _MEVz("\t5T\014?\017z")
_qAPx.Description = ""
_qAPx.Visible = true
_qAPx.Media = _0wB
_qAPx.Commands = {}
_qAPx.DistanceRange = Distance(-1, "feet")
_qAPx.ShowObjects = "OnEnter"
_qAPx.ProximityRange = Distance(60, "meters")
_qAPx.AllowSetPositionTo = false
_qAPx.Active = false
_qAPx.Points = {
  ZonePoint(52.5659057105294, 13.1547794321796, 0),
  ZonePoint(52.5658203739493, 13.1547108625, 0),
  ZonePoint(52.565778507579, 13.1548719401468, 0),
  ZonePoint(52.5658557506247, 13.1549410803348, 0)
}
_qAPx.OriginalPoint = ZonePoint(52.5658400856706, 13.1548258287903, 0)
_qAPx.DistanceRangeUOM = "Feet"
_qAPx.ProximityRangeUOM = "Meters"
_qAPx.OutOfRangeName = ""
_qAPx.InRangeName = ""
_iMWA1 = Wherigo.Zone(_d3K)
_iMWA1.Id = "86eb37c4-bf84-46fb-8760-ecd2454ebd47"
_iMWA1.Name = _MEVz("\t\0255T\014?\017")
_iMWA1.Description = ""
_iMWA1.Visible = true
_iMWA1.Media = _86UZR
_iMWA1.Commands = {}
_iMWA1.DistanceRange = Distance(-1, "feet")
_iMWA1.ShowObjects = "OnEnter"
_iMWA1.ProximityRange = Distance(60, "meters")
_iMWA1.AllowSetPositionTo = false
_iMWA1.Active = false
_iMWA1.Points = {
  ZonePoint(52.5710027859969, 13.1489932384218, 0),
  ZonePoint(52.5709386660181, 13.1489894891344, 0),
  ZonePoint(52.5709578553337, 13.1490877556942, 0),
  ZonePoint(52.5710130148885, 13.1490717931297, 0)
}
_iMWA1.OriginalPoint = ZonePoint(52.5709780805593, 13.149035569095, 0)
_iMWA1.DistanceRangeUOM = "Feet"
_iMWA1.ProximityRangeUOM = "Meters"
_iMWA1.OutOfRangeName = ""
_iMWA1.InRangeName = ""
_DP4BD = Wherigo.Zone(_d3K)
_DP4BD.Id = "f47aac6d-0472-49b4-9554-796eeb0d8be1"
_DP4BD.Name = _MEVz("\tN5zf\017vzo\001Iz_\014?\001G")
_DP4BD.Description = ""
_DP4BD.Visible = true
_DP4BD.Commands = {}
_DP4BD.DistanceRange = Distance(-1, "feet")
_DP4BD.ShowObjects = "OnEnter"
_DP4BD.ProximityRange = Distance(60, "meters")
_DP4BD.AllowSetPositionTo = false
_DP4BD.Active = false
_DP4BD.Points = {
  ZonePoint(52.5692036520119, 13.146914525692, 0),
  ZonePoint(52.5690591016103, 13.1468249110562, 0),
  ZonePoint(52.5690107057683, 13.1470901182878, 0),
  ZonePoint(52.5691442371438, 13.1471491796289, 0)
}
_DP4BD.OriginalPoint = ZonePoint(52.5691044241336, 13.1469946836662, 0)
_DP4BD.DistanceRangeUOM = "Feet"
_DP4BD.ProximityRangeUOM = "Meters"
_DP4BD.OutOfRangeName = ""
_DP4BD.InRangeName = ""
_VMK = Wherigo.Zone(_d3K)
_VMK.Id = "f6f51e19-ef9e-456c-98e1-a6ed8424028c"
_VMK.Name = _MEVz("\t\0305_\014?\001G")
_VMK.Description = ""
_VMK.Visible = true
_VMK.Media = _NbyFl
_VMK.Commands = {}
_VMK.DistanceRange = Distance(-1, "feet")
_VMK.ShowObjects = "OnEnter"
_VMK.ProximityRange = Distance(60, "meters")
_VMK.AllowSetPositionTo = false
_VMK.Active = false
_VMK.Points = {
  ZonePoint(52.566665001542, 13.1524493440369, 0),
  ZonePoint(52.5665824869649, 13.1527391927427, 0),
  ZonePoint(52.5664742135367, 13.1526725531451, 0),
  ZonePoint(52.5665547249074, 13.1523590129143, 0)
}
_VMK.OriginalPoint = ZonePoint(52.5665691067378, 13.1525550257097, 0)
_VMK.DistanceRangeUOM = "Feet"
_VMK.ProximityRangeUOM = "Meters"
_VMK.OutOfRangeName = ""
_VMK.InRangeName = ""
_06XlB = Wherigo.ZCharacter(_d3K)
_06XlB.Id = "36347f84-5722-4555-ac90-ae466add93b6"
_06XlB.Name = _MEVz("$.\004G'\028")
_06XlB.Description = ""
_06XlB.Visible = false
_06XlB.Commands = {}
_06XlB.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_06XlB.Gender = "It"
_06XlB.Type = "NPC"
_hp2G = Wherigo.ZItem({Cartridge = _d3K, Container = _ZpdL})
_hp2G.Id = "8d63af6e-f7b1-4cbd-8e1e-701fd590f86f"
_hp2G.Name = _MEVz("\aZbzU77v.7\026\017?7.\017\026G\017\004")
_hp2G.Description = ""
_hp2G.Visible = true
_hp2G.Commands = {
  _syk = Wherigo.ZCommand({
    Text = _MEVz("/\001'Xz\017Gz0\0167zv\017?.\001z.?"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_hp2G.Commands._syk.Custom = true
_hp2G.Commands._syk.Id = "4d64d287-4ac7-4350-be81-0f1726ba0418"
_hp2G.Commands._syk.WorksWithAll = true
_hp2G.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_hp2G.Locked = true
_hp2G.Opened = false
_onQ = Wherigo.ZItem({Cartridge = _d3K, Container = _te01})
_onQ.Id = "974315e6-1b2a-47c1-aa45-046d043e7dba"
_onQ.Name = _MEVz("\aZ\fz\a'\028\004\001\017GG\017\004")
_onQ.Description = ""
_onQ.Visible = true
_onQ.Commands = {
  _rp08O = Wherigo.ZCommand({
    Text = _MEVz("v\017L\001?0\017?"),
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_onQ.Commands._rp08O.Custom = true
_onQ.Commands._rp08O.Id = "bac08ea8-e548-460e-9982-2d512fcfcc0e"
_onQ.Commands._rp08O.WorksWithAll = false
_onQ.Commands._rp08O.WorksWithListIds = {
  "6ab95ae5-8566-45a0-84d4-e3e87fa834e9"
}
_onQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_onQ.Locked = true
_onQ.Opened = false
_uhUj = Wherigo.ZItem({Cartridge = _d3K, Container = _ORm54})
_uhUj.Id = "bd261e1a-42a4-42bd-9118-8228691867d4"
_uhUj.Name = _MEVz("\aZCz+\01470\016?G\0267\001I\017?\026")
_uhUj.Description = ""
_uhUj.Visible = true
_uhUj.Commands = {
  _tSCZs = Wherigo.ZCommand({
    Text = _MEVz("0.Gz\016G\026zG\017\0287z>\004\001\026\016v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_uhUj.Commands._tSCZs.Custom = true
_uhUj.Commands._tSCZs.Id = "63140fda-0126-4129-afa0-05d506d3b8e5"
_uhUj.Commands._tSCZs.WorksWithAll = true
_uhUj.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_uhUj.Locked = true
_uhUj.Opened = false
_4lJJ = Wherigo.ZItem({Cartridge = _d3K, Container = _4NsAA})
_4lJJ.Id = "9974a64a-681b-4c6f-bcef-dd4996d0b037"
_4lJJ.Name = _MEVz("\aZ\030z\127\014\0177y\0177\026\017\016\004\017y\001oo\004\017")
_4lJJ.Description = ""
_4lJJ.Visible = true
_4lJJ.Commands = {
  _HKuH = Wherigo.ZCommand({
    Text = _MEVz("A.Gz\016G\026zG\017\0287z>\004\001\026\016v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_4lJJ.Commands._HKuH.Custom = true
_4lJJ.Commands._HKuH.Id = "a1f92743-308a-40df-a34a-75bdb462bead"
_4lJJ.Commands._HKuH.WorksWithAll = true
_4lJJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_4lJJ.Locked = true
_4lJJ.Opened = false
_rSy = Wherigo.ZItem({Cartridge = _d3K, Container = _0ak})
_rSy.Id = "cf4809f0-9ca3-4981-8c14-14b11ea11a92"
_rSy.Name = _MEVz("\aZNz\a'\028\001\028.>07\001'X")
_rSy.Description = ""
_rSy.Visible = true
_rSy.Media = _TRnu
_rSy.Commands = {
  _af1 = Wherigo.ZCommand({
    Text = _MEVz("_\017L\017\028\004"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_rSy.Commands._af1.Custom = true
_rSy.Commands._af1.Id = "04b77d6a-2e3f-41df-a06d-6fdeadfebf56"
_rSy.Commands._af1.WorksWithAll = true
_rSy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rSy.Locked = true
_rSy.Opened = false
_I_0 = Wherigo.ZItem({Cartridge = _d3K, Container = _6Oy})
_I_0.Id = "be541729-8cc5-4417-a15d-5a6fd8bf2e09"
_I_0.Name = _MEVz("\aZ3z)\017gzc.IyG\028\0167\017")
_I_0.Description = ""
_I_0.Visible = true
_I_0.Commands = {}
_I_0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_I_0.Locked = true
_I_0.Opened = false
_KhB = Wherigo.ZItem({Cartridge = _d3K, Container = _Ot5wZ})
_KhB.Id = "616393e9-1d2d-4428-b527-46c2fbf5eb46"
_KhB.Name = _MEVz("\aZ\025z/\004.GzI\016\026z\023\001v\017?")
_KhB.Description = ""
_KhB.Visible = true
_KhB.Commands = {}
_KhB.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_KhB.Locked = true
_KhB.Opened = false
_gdnK = Wherigo.ZItem({Cartridge = _d3K, Container = _D5LP})
_gdnK.Id = "d036a443-444f-4fa7-be6a-d5ab7fe62949"
_gdnK.Name = _MEVz("\aZ]z+.GG>.?0zI\016\026z$\016?v\0177")
_gdnK.Description = ""
_gdnK.Visible = true
_gdnK.Commands = {}
_gdnK.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_gdnK.Locked = true
_gdnK.Opened = false
_J4Hwb = Wherigo.ZItem({Cartridge = _d3K, Container = _4azXD})
_J4Hwb.Id = "22097adc-6b9a-48fa-a54e-a562870f1827"
_J4Hwb.Name = _MEVz("\a\tZzA\017'7%y\026z_\004\014'X\017")
_J4Hwb.Description = ""
_J4Hwb.Visible = true
_J4Hwb.Commands = {}
_J4Hwb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_J4Hwb.Locked = true
_J4Hwb.Opened = false
_nXT = Wherigo.ZItem({Cartridge = _d3K, Container = _3KLu_})
_nXT.Id = "7429594b-4648-4467-88a7-9fe1063c1ace"
_nXT.Name = _MEVz("\a\t\tz\023\004.>G\026\0177g\017\016GG")
_nXT.Description = ""
_nXT.Visible = true
_nXT.Commands = {}
_nXT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nXT.Locked = true
_nXT.Opened = false
_NhBc = Wherigo.ZItem({Cartridge = _d3K, Container = _bdtc})
_NhBc.Id = "b56c5a85-7c15-4fb0-a2ed-c40ab2097b68"
_NhBc.Name = _MEVz("\a\t3zc.?0z}\017G\017Gy\016\017\004zF\001\004\016.")
_NhBc.Description = ""
_NhBc.Visible = true
_NhBc.Commands = {}
_NhBc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NhBc.Locked = true
_NhBc.Opened = false
_v6Wo = Wherigo.ZItem({Cartridge = _d3K, Container = _qrzJr})
_v6Wo.Id = "d1b70a9c-b675-4a7d-98b4-e8c50ab3e754"
_v6Wo.Name = _MEVz("\a\t\025zp\014\026\0177z\127\014yLzI\016\026z\127\0017>\017\004")
_v6Wo.Description = ""
_v6Wo.Visible = true
_v6Wo.Commands = {}
_v6Wo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_v6Wo.Locked = true
_v6Wo.Opened = false
_jrsHU = Wherigo.ZItem({Cartridge = _d3K, Container = _qAPx})
_jrsHU.Id = "dc836e20-e09c-4548-bf54-8ce98b00d85f"
_jrsHU.Name = _MEVz("\aZ\tz\a'\028\016\0040")
_jrsHU.Description = ""
_jrsHU.Visible = true
_jrsHU.Commands = {
  _ChhA = Wherigo.ZCommand({
    Text = _MEVz("_\017L\017\028\004"),
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_jrsHU.Commands._ChhA.Custom = true
_jrsHU.Commands._ChhA.Id = "cfbf8cb4-2ede-4204-ac71-7afb95c8273e"
_jrsHU.Commands._ChhA.WorksWithAll = false
_jrsHU.Commands._ChhA.WorksWithListIds = {
  "0a948d2b-2f70-42ed-8329-ddb0efcb9d4f"
}
_jrsHU.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jrsHU.Locked = true
_jrsHU.Opened = false
_g8uT = Wherigo.ZItem({Cartridge = _d3K, Container = Player})
_g8uT.Id = "74a44a23-b9a7-4a8f-82af-702d8a091ebb"
_g8uT.Name = _MEVz("\023?\004\017\016\026\001?v")
_g8uT.Description = ""
_g8uT.Visible = true
_g8uT.Commands = {}
_g8uT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g8uT.Locked = false
_g8uT.Opened = false
_23_9N = Wherigo.ZItem({Cartridge = _d3K, Container = _VMK})
_23_9N.Id = "a2650b82-16b6-4f37-bd3c-e07ddd1993cd"
_23_9N.Name = _MEVz("u?\004\014'X'\0140\017")
_23_9N.Description = ""
_23_9N.Visible = true
_23_9N.Commands = {
  _ZMvb = Wherigo.ZCommand({
    Text = _MEVz("2\0140\017z.>7\001L\017?"),
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = _MEVz(")\016'\028\026za\0177L\001v>.7")
  })
}
_23_9N.Commands._ZMvb.Custom = true
_23_9N.Commands._ZMvb.Id = "53a88246-9a84-4333-8df1-d0eb735b8d53"
_23_9N.Commands._ZMvb.WorksWithAll = false
_23_9N.Commands._ZMvb.WorksWithListIds = {
  "f6f51e19-ef9e-456c-98e1-a6ed8424028c"
}
_23_9N.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_23_9N.Locked = false
_23_9N.Opened = false
_ecc = Wherigo.ZItem(_d3K)
_ecc.Id = "3366cedc-aa9a-4deb-b075-4615f0027d14"
_ecc.Name = _MEVz("$\001?0G\026\001\017'X")
_ecc.Description = ""
_ecc.Visible = true
_ecc.Media = _Dgp
_ecc.Commands = {}
_ecc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ecc.Locked = true
_ecc.Opened = false
_r_S = Wherigo.ZItem(_d3K)
_r_S.Id = "1c19b447-2bab-437e-b7ed-bc0413b9f8af"
_r_S.Name = _MEVz("U?L\014zo\001zul")
_r_S.Description = ""
_r_S.Visible = true
_r_S.Media = _d6kj
_r_S.Commands = {}
_r_S.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_r_S.Locked = false
_r_S.Opened = false
_rKaMA = Wherigo.ZItem({Cartridge = _d3K, Container = _te01})
_rKaMA.Id = "81a2ca50-0cce-4396-ac79-ab7bac0714b7"
_rKaMA.Name = _MEVz("}\016a\017\"F\014X\0177\"c\016\004L\017")
_rKaMA.Description = ""
_rKaMA.Visible = true
_rKaMA.Commands = {}
_rKaMA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rKaMA.Locked = false
_rKaMA.Opened = true
_fQs3H = Wherigo.ZItem({Cartridge = _d3K, Container = _te01})
_fQs3H.Id = "5f2f0e0a-e898-4ae6-9e2b-74598fb808db"
_fQs3H.Name = _MEVz("c\016\004L\017zT\014?\017z\a\f")
_fQs3H.Description = ""
_fQs3H.Visible = true
_fQs3H.Commands = {}
_fQs3H.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fQs3H.Locked = false
_fQs3H.Opened = true
_huK = Wherigo.ZItem({Cartridge = _d3K, Container = _3KLu_})
_huK.Id = "569e9646-af2d-4d2e-b7e3-0744ad5de654"
_huK.Name = _MEVz("c\016\004L\017zT\014?\017z\a\t\t")
_huK.Description = ""
_huK.Visible = true
_huK.Commands = {}
_huK.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_huK.Locked = false
_huK.Opened = true
_cXqp = Wherigo.ZItem({Cartridge = _d3K, Container = _bdtc})
_cXqp.Id = "13f07fca-a694-42a9-bdaa-8853d52cd70e"
_cXqp.Name = _MEVz("c\016\004L\017zT\014?\017z\a\t3")
_cXqp.Description = ""
_cXqp.Visible = true
_cXqp.Commands = {}
_cXqp.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_cXqp.Locked = false
_cXqp.Opened = true
_CRlT = Wherigo.ZItem({Cartridge = _d3K, Container = _iMWA1})
_CRlT.Id = "e40b0a99-a3cc-4dc5-a421-56a7bc6bf2c3"
_CRlT.Name = _MEVz("c\016\004L\017zT\014?\017z\a\t\025")
_CRlT.Description = ""
_CRlT.Visible = true
_CRlT.Commands = {}
_CRlT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_CRlT.Locked = false
_CRlT.Opened = true
_xfep = false
_gpN = ""
_p2qJ = _MEVz("10\023\tW\017")
_I2H = _MEVz("1ZN^\004_")
_Z3bUD = _MEVz("1\028y3/")
_iFUD = _MEVz("0\001II%")
_Z5Z = _MEVz("1\fG1}'")
_A7E5 = _MEVz("0\001II%")
_d3K.ZVariables = {
  _xfep = false,
  _gpN = "",
  _p2qJ = _MEVz("10\023\tW\017"),
  _I2H = _MEVz("1ZN^\004_"),
  _Z3bUD = _MEVz("1\028y3/"),
  _iFUD = _MEVz("0\001II%"),
  _Z5Z = _MEVz("1\fG1}'"),
  _A7E5 = _MEVz("0\001II%")
}
_8s_Lc = Wherigo.ZInput(_d3K)
_8s_Lc.Id = "c612c9d9-e5ca-4855-a299-cbcdcb15a379"
_8s_Lc.Name = _MEVz("\aZbzU77v.7\026\017?7.\017\026G\017\004")
_8s_Lc.Description = ""
_8s_Lc.Visible = true
_8s_Lc.InputType = "Text"
_8s_Lc.Text = _MEVz("u?\026\0177zg.Gz\004\016\017v\026z0.Gz$\001?0G\026\001\017'Xz\024?\0017z&\016?o\017\004g\0147\026\018z\001?0zg\017\004'\028\017z$.7>\017z\028.\026z\017GBz\002_M<\a'\0287\017\016>\017z0\016\017zf\0147\026\017z0\0177zM\017\016\028\017?L\014\004v\017z?.'\028z\024zu)Az;c)&z}&&MT&U2c&)zrz\018zI\016\026z\017\016?\017Iz\127\014II.zv\017\0267\017??\0265")
_NXn = Wherigo.ZInput(_d3K)
_NXn.Id = "883aedd6-03ab-4a23-9977-ca809fe7fb18"
_NXn.Name = _MEVz("\aZ\fz\a'\028\004\001\017GG\017\004z>\017L7\017\016\017?")
_NXn.Description = ""
_NXn.Visible = false
_NXn.InputType = "Text"
_NXn.Text = _MEVz("f\017\004'\028\017z)75zG\026\017\028\026z.\001Lz0\017Iz\a'\028\004\001\017GG\017\004B\002_M<\a\016\017\028z\016\028?z0\0167zv7\001\017?0\004\016'\028z.?5")
_SX79x = Wherigo.ZInput(_d3K)
_SX79x.Id = "5662868a-c50d-4a17-963e-29395d877146"
_SX79x.Name = _MEVz("\aZCz$\016?v\0177.>07\001\017'X\017")
_SX79x.Description = ""
_SX79x.Visible = true
_SX79x.Media = _FHuiJ
_SX79x.InputType = "Text"
_SX79x.Text = _MEVz("\a\014z>\004\001\026\016v(zg\016\017z0.Gz_\017\016\004z\016G\026(zL\016?0\017?zG\016'\028zI\016\026z\a\016'\028\0177\028\017\016\026z.\001'\028z$\016?v\0177.>07\001\017'X\017z0.7.\001L5z\a\001'\028\017zog\017\016z0\016\017z\0160\017?\026\016G'\028zG\016?0z\001?0zG'\0287\017\016>\017z0\016\017z]z_\001'\028\026G\026.>\017?z\028\016?\026\0177\017\016?.?0\0177z.\001L5z_\017v\016??\017z\028\016\0177>\017\016zI\016\026z0\017?zog\017\016z_\001'\028G\026.>\017?za\014?z0\017?\017?z0\0177z\0177G\026\017z_\001'\028G\026.>\017za\0147z0\017Iz0\0177z.?0\0177\017?z\016Iz\023\004y\028.>\017\026zG\026\017\028\0265")
_CONGh = Wherigo.ZInput(_d3K)
_CONGh.Id = "16aa7e7a-be77-40ae-8a1c-11af20a87124"
_CONGh.Name = _MEVz("\aZ\030z\127\014\0177y\0177\026\017\016\004\017y\001oo\004\017")
_CONGh.Description = ""
_CONGh.Visible = true
_CONGh.InputType = "Text"
_CONGh.Text = _MEVz("\a'\0287\017\016>\017z0\016\017zT.\028\004\017?z0\017\016?\0177z}\014\017G\001?vz>\017v\016??\017?0zI\016\026z0\0177zX\004\017\016?G\026\017?zT.\028\004z\016Izu\0287o\017\016v\0177G\016??z.\001L5zA\016\017zT.\028\004z\016?z0\0177z+\016\026\026\017zg\01670z.\001Gv\017\004.GG\017?5z")
_xWJNw = Wherigo.ZInput(_d3K)
_xWJNw.Id = "5e4d8a66-0149-4562-ba3d-daeb985e23ef"
_xWJNw.Name = _MEVz("\aZ3zA7\017\028Gy\016\017\004")
_xWJNw.Description = ""
_xWJNw.Visible = true
_xWJNw.InputType = "Text"
_xWJNw.Text = _MEVz("f\017\004'\028\017?z;7\026zX.??G\026z0\001z\004\017G\017?B")
_xNa = Wherigo.ZInput(_d3K)
_xNa.Id = "3ba794c7-c4c8-4071-8198-b9d1c541b068"
_xNa.Name = _MEVz("\aZNz\a'\028\001\028")
_xNa.Description = ""
_xNa.Visible = true
_xNa.InputType = "Text"
_xNa.Text = _MEVz("f\017\004'\028\017z\a'\028\001\028v7\014\017GG\017z\028.\026z0\0177z\023>07\001'XB\002_M<")
_pFgz = Wherigo.ZInput(_d3K)
_pFgz.Id = "c756ee18-cd54-4360-a636-e1797c8f605e"
_pFgz.Name = _MEVz("\a\t3zA\0177zc\016?g\017\016Gz\016?z0\0177zc.?0z")
_pFgz.Description = ""
_pFgz.Visible = true
_pFgz.InputType = "Text"
_pFgz.Text = _MEVz("f\016\017z\028\016\017GGz0.Gz+\01470\014yL\0177z0\017GG\017?zc.?0zL\017\028\004\026\017B")
_H1i7v = Wherigo.ZInput(_d3K)
_H1i7v.Id = "d90e361e-9fc0-4cc7-9adb-8a8920669a85"
_H1i7v.Name = _MEVz("\aZ]z/\004.GzI\016\026z\023\001v\017?")
_H1i7v.Description = ""
_H1i7v.Visible = true
_H1i7v.InputType = "Text"
_H1i7v.Text = _MEVz("f.Gz\0267.\017?X\026\017z0\0177z+\014\01770\0177zv\0177?zI\016\026z2\028\004\0147\014L\0147I(z\001IzG\017\016?\017z;yL\0177zo\001z>\017\026.\017\001>\017?B")
_WVs = Wherigo.ZInput(_d3K)
_WVs.Id = "69278360-a188-449f-b572-854ba43f2f19"
_WVs.Name = _MEVz("\aZ\025z+.GG>.?0zI\016\026z$\016?v\0177")
_WVs.Description = ""
_WVs.Visible = true
_WVs.InputType = "Text"
_WVs.Text = _MEVz("l\014?zg\017IzG\026.II\026z0.Gz;>|\017X\026Bz\024\a\001'\028\026z\017\016?zc\016\004LGI\016\026\026\017\004z\016IzuIX7\017\016G\018")
_7CbEO = Wherigo.ZInput(_d3K)
_7CbEO.Id = "fd5a5e0f-c12c-425a-bf9e-3edbd705c0fc"
_7CbEO.Name = _MEVz("\a\tZzA\017'7%y\026z_\004\014\017'X\017")
_7CbEO.Description = ""
_7CbEO.Visible = true
_7CbEO.InputType = "Text"
_7CbEO.Text = _MEVz("f\016\017a\016\017\004\017zT\016II\0177z\028.\026\026\017z0.Gzc\014\026\017\004zB")
_f65c = Wherigo.ZInput(_d3K)
_f65c.Id = "d57a0670-36d3-468e-8a57-45f4200ebb84"
_f65c.Name = _MEVz("\a\t\tz$.7>\017")
_f65c.Description = ""
_f65c.Visible = true
_f65c.InputType = "Text"
_f65c.Text = _MEVz("f\017\004'\028\017z$.7>\017z\028.\026\026\017z0.Gz\127\004\017\0160z0\017Gz\0255z;yL\0177Gz.\004Gz\017Gza\0177G'\028g.?0")
_7r0 = Wherigo.ZInput(_d3K)
_7r0.Id = "651e98df-dcc1-41bb-ad61-90c958b64b52"
_7r0.Name = _MEVz("\a\t]zp\014\026\0177z\127\014yLzI\016\026z\127\0017>\017\004")
_7r0.Description = ""
_7r0.Visible = true
_7r0.InputType = "Text"
_7r0.Text = _MEVz("f.Gz\028.\026zc\014\004I\017Gz>\017\016z0\016\017G\017Iz;yL\0177za\0177\004\0147\017?B")
_zL9k = Wherigo.ZInput(_d3K)
_zL9k.Id = "f68d14ed-dc13-46f1-b348-b464ea69727f"
_zL9k.Name = _MEVz("\aZ\tz\a'\028\016\0040")
_zL9k.Description = ""
_zL9k.Visible = false
_zL9k.InputType = "Text"
_zL9k.Text = _MEVz("f\016\017z\028\017\016GG\026z0.Gz+.\0170'\028\017?(z0.GGzv\017G\001'\028\026zg\01670B")
_A397 = Wherigo.ZInput(_d3K)
_A397.Id = "ffcbbc87-07e3-42fa-853b-40e0ceaeb8f1"
_A397.Name = _MEVz("\0237I>.?0")
_A397.Description = ""
_A397.Visible = true
_A397.InputType = "Text"
_A397.Text = _MEVz("f\017\004'\028\0177zd\0177G\014?zv\017\028\014\0177\026\017z0\016\017G\017Gz\0237I>.?0B")
_YFKWD = Wherigo.ZInput(_d3K)
_YFKWD.Id = "0fe24845-1173-48fc-9f53-c849156c4fdb"
_YFKWD.Name = _MEVz("f\017vzo\001Iz_\014?\001G")
_YFKWD.Description = ""
_YFKWD.Visible = true
_YFKWD.InputType = "Text"
_YFKWD.Text = _MEVz("U?zg\017\004'\028\0177z\a\0267.GG\017zL\016?0\017\026z0\016\017z&\0287\001?vzL\001\0177z0\017\016?\017zA\016\017?G\026\017zG\026.\026\026B")
_onQ.Commands._rp08O.WorksWithList = {_te01}
_jrsHU.Commands._ChhA.WorksWithList = {_qAPx}
_23_9N.Commands._ZMvb.WorksWithList = {_VMK}
function _d3K:OnStart()
  if _G[_MEVz("&?a")][_MEVz("d\004.\026L\0147I")] == _MEVz("f\016?\0253") or _G[_MEVz("&?a")][_MEVz("A\017a\016'\017UA")] == _MEVz("A\017GX\026\014y") then
    for k, v in pairs(_G[_MEVz("10\025\127")][_MEVz("\023\004\004T;>|\017'\026G")]) do
      v[_MEVz("l\016G\016>\004\017")] = false
      v[_MEVz("\023'\026\016a\017")] = false
    end
    _G[_MEVz("f\028\0177\016v\014")][_MEVz("2\014II.?0")](_MEVz("\a.a\0172\004\014G\017"))
    return
  end
end
function _d3K:OnRestore()
end
function _dA1xe:OnEnter()
  _p2qJ = _MEVz("10\023\tW\017")
  _dA1xe.Active = true
  _dA1xe.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("c\016\0177zg\014\004\004\026\017zG\016'\028z0\0177zT\017\001v\017z0\014'\028zI\016\026zI\0167z\0267\017LL\017?5\002_M<f\014z>\004\017\016>\026z\0177z0\017??z?\0017B\002_M<U'\028zg\016\004\004z?\016'\028\026GzI\017\0287(z.\004Gz\017?0\004\016'\028z0\016\017G\017?z+.GG\017?I\014\01770\0177\002_M<o\001z\001\017>\0177L\001\017\0287\017?5\002_M<A.z\028\016?\026\017?z>\017g\017v\026zG\016'\028z\017\026g.G5zA.Gzg\01670z\0177zG\017\016?5\002_M<"),
      Media = _QBnp
    },
    {
      Text = _MEVz("c.\004\004\014rz+75zd\028\016>>GB"),
      Media = _LSn
    },
    {
      Text = _MEVz("c.\004\004\014zA\017\026\017'\026\016a\017rz"),
      Media = _qy6
    },
    {
      Text = _MEVz("f\016\017G\014zI\001\017GG\017?zg\0167z\001?Gz\028\016\0177z\016IzA\001?X\017\004?z\0267\017LL\017?B"),
      Media = _CXi
    },
    {
      Text = _MEVz("U'\028zI\014\017'\028\026\017z?\016'\028\026z\016?z0\016\017z\a'\028\001GG\004\016?\016\017z0\016\017G\017GzX7.?X\017?\002_M<p.\017\026\0177Gzv\0177.\026\017?r\002_M<"),
      Media = _LeB
    },
    {
      Text = _MEVz("f.Gz\028.>\017?z\a\016\017z0\017??zv\017G\017\028\017?B"),
      Media = _qLZ9D
    },
    {
      Text = _MEVz("A\0177z+.??z\016G\026zI\016\026z0\017Iza\0177I\016GG\026\017?z+.\0170'\028\017?z.\001Gz0\0177zT\017\016\026\001?v\002_M<0\0147\026z\028\016?\026\017?z\016?z0\017?zf.\0040z\028\016?\017\016?v\017v.?v\017?5zU'\028zg.7z\028\016\0177zI\016\026\002_M<I\017\016?\017Izc\001?0z\001?\026\0177g\017vGz\001?0z0.'\028\026\017z.?z\017\016?z.I\014\0017\014\017G\017G\002_M<\023>\017?\026\017\001\0177z0\0177z>\017\0160\017?5zU'\028z\028.\017\026\026\017z0\014'\028z?\016\017za\0177I\001\026\017\026(z0.GG\002_M<\017GzG\016'\028z>\017\016z0\017Iz+.??z\001Iz\017\016?\017?z+\014\01770\0177z\028.?0\017\004?zX\014\017??\026\0175\002_M<"),
      Media = _LeB
    },
    {
      Text = _MEVz("\a\016\017zG\016?0zG'\028\004\016\017GG\004\016'\028z0\0147\026z\028\016?\026\017?z\016Izf.\0040za\0177G'\028g\001?0\017?5zl\016\017\004\004\017\016'\028\026zL\016?0\017?z\a\016\017z0.z\017\026g.GzBr"),
      Media = _qy6
    },
    {
      Text = _MEVz("A.?X\017(z0.GGzG\016\017zG\016'\028z0\016\017zT\017\016\026zv\017?\014II\017?z\028.>\017?(z\001IzI\0167zo\001z>\0177\016'\028\026\017?zrz)\001?zX\014II\017z\016'\028z.\004\004\017\016?zg\017\016\026\01775\002_M<U'\028zg\001\017?G'\028\017zU\028?\017?z?\014'\028z\017\016?\017?zG'\028\014\017?\017?z\023>\017?0zr"),
      Media = _Ya9Q
    },
    {
      Text = _MEVz("l\016\017\004\017?zA.?Xzrzu?0zL\001\0177zG\016\017za\016\017\004z&7L\014\004vzr"),
      Media = _c4G
    },
    {Text = "", Media = _d6kj}
  }, function(action)
    _d3K:RequestSync()
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    _qAPx.Active = true
  end)
end
function _ZpdL:OnEnter()
  _p2qJ = _MEVz("1Ty0}")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("c\014\004I\017Gzg.7z.\001Lv7\001?0zG\017\016?\017Gzv\017yL\004\017v\026\017?z\001?0zX\001\004\026\016a\016\0177\026\017?zQ?>GyK\023\001L\0267\017\026\017?Gz>\017\016z.\004\004\017?z+\017?G'\028\017?zG\017\0287z>\017\004\016\017>\026z\001?0zG\014zX\014??\026\017z\0177z|.\0287\017\004.?vzG\017\016?\017zp.\026\017?z>\017v\017\028\017?5\002_M<"),
      Media = _qLZ9D
    },
    {
      Text = _MEVz("\023'\0285555zg.GzG\017\028\017z\016'\028z0\017??z\028\016\0177Br\002_M<"),
      Media = _iAK0
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_8s_Lc)
    end)
  end)
end
function _ORm54:OnEnter()
  _p2qJ = _MEVz("1;MIb]")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("\t\f\fNzg.7zc\014\004I\017Gz\016?z2\028\016'.v\014z.\001Lv\017\026.\001'\028\026z\001?0zL.?0z\017\016?\017z\0237>\017\016\026GG\026\017\004\004\017z\016?z0\0177z\023y\014\026\028\017X\017z\017\016?\0177zv\017g\016GG\017?z$7.\001zc\014\0040\017?5\002_M<+\016\026z$7.\001zc\014\0040\017?zL7\017\001?0\017\026\017z\0177zG\016'\028z\016II\0177zI\017\0287z.?5z\023\004\004\01770\016?vGza\0177G'\028g.?0z$7.\001zc\014\0040\017?z\017\016?\017Gzp.v\017GzGy\0017\004\014G5zU?z0\0177z$\014\004v\017o\017\016\026zv\017\004.?vz\017Gz\016\028I(z\017\016?z>\017.'\028\026\004\016'\028\017Gzl\0177I\014\017v\017?zo\001z\0177g\0177>\017?(zg\014I\016\026z\0177zG\016'\028zo\001z_\017v\016??z0\0177z\t\fCZ\0177zF.\0287\017z\017\016?z07\017\016G\026\014\017'X\016v\017Gzc\014\026\017\004z>.\001\017?z\004\016\017GG5"),
      Media = _iAK0
    },
    {
      Text = _MEVz("A\014'\028z0\016\017G\017Gz/\017>.\017\0010\017zg.7zX\017\016?z?\0147I.\004\017Gzc\014\026\017\0045z&Gzv.>z0.7\016?z$.\004\004\026\001\0177\017?(za\0177G\026\017'X\026\017zM.\017\001I\017z\001?0z/\017\028\017\016Iv.\017?v\0175zUIz\127\017\004\004\0177z>\017L.?0\017?zG\016'\028z\017\016?zGy\017o\016\017\004\004\0177z$\014\004\026\0177\026\016G'\028(z\017\016?z\a.\017\0017\017>.0zG\014g\016\017z\017\016?\017z/.GX.II\01775\002_M<c\014\004I\017Gzf\0167X\001?vG>\0177\017\016'\028z\001?0z0\016\017zM.\017\001I\017(z\016?z0\017?\017?z0\016\017zl\0177>7\017'\028\017?zv\017G'\028.\028\017?(z\0177G\0267\017'X\026\017?zG\016'\028z\001\017>\0177z0\017?z\0177G\026\017?z\a\026\014'X5zUIz\a\026\014'Xg\0177Xz0.7\001\017>\0177z>\017L.?0\017?zG\016'\028z0\016\017z\017\016v\017?\026\004\016'\028\017?zc\014\026\017\004o\016II\01775zA\016\017zM\017o\017y\026\016\014?z\001?0z\017\016?zf.7\026\0177.\001Iz\004.v\017?z\016Iz&70v\017G'\028\014GG5zA\0177z\127\017\004\004\0177zg.7z0\0177z&?\026G\0147v\001?vza\0147>\017\028.\004\026\017?z\001?0za\0177L\001\017v\026\017z\001\017>\0177z\017\016?\017?z_7\017??\014L\017?5z")
    },
    {
      Text = _MEVz("\023\004\004\017Gz0\017\001\026\017\026z0.7.\001Lz\028\016?(z0.GGzc\014\004I\017Gz0\0177zp.\017\026\0177z\016G\0265zU'\028z0\017?X\017(z0.GGz\016'\028zI\016\026\026\004\0177g\017\016\004\017zv\017?\001vzv\017v\017?z\016\028?zv\017L\001?0\017?z\028.>\0175\002_M<"),
      Media = _QBnp
    },
    {
      Text = _MEVz("A\0147\026z\004\016\017v\026z\017\026g.Gza\0177v7.>\017?5z")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_SX79x)
    end)
  end)
  _fQs3H:MoveTo(nil)
end
function _te01:On_ZFyO(target)
  _p2qJ = _MEVz("1\026\017Z\t")
end
function _te01:OnEnter()
  _p2qJ = _MEVz("1\026\017Z\t")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("U'\028zG\017\028\017z0\0147\026z\017\016?\017?z\a'\028\004\001\017GG\017\004\002_M<"),
      Media = _2Rpa4
    },
    {
      Text = _MEVz("T\001zg\017\004'\028\017Iz\a'\028\004\014GGzy.GG\026z\0177zg\014\028\004B\002_M<"),
      Media = _LEowF
    },
    {
      Text = _MEVz("f\0177zX\014\017??\026\017z\016\028?z\028\016\0177za\0177\004\0147\017?z\028.>\017?B\002_M<"),
      Media = _QBnp
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_NXn)
    end)
  end)
  _fQs3H:MoveTo(Player)
end
function _6Oy:OnEnter()
  _p2qJ = _MEVz("1N;%")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("\a\017\016?\017z&\004\026\0177?zg.7\017?z\017\016?L.'\028\017(z7.\001\017z_.\001\0177G\004\017\001\026\0175z\001?0z\0177za\0177>7.'\028\026\017zQ?>GyKG\017\016?\017z\127\016?0\028\017\016\026z.\001Lz\016\0287\0177z$.7I5\002_M<"),
      Media = _LEowF
    },
    {
      Text = _MEVz("&7z>\017X.Iz.\004Gz\127\016?0zQ?>GyKo\0017z\a\0267.L\017z\017?\026g\0170\0177z0\017?zM\014\0287G\026\014'Xzo\001zGy\001\0177\017?(z\0140\0177zg\00170\017z\014L\026I.\004Gz.\001Lz0\017IzA.'\028>\0140\017?z\017\016?v\017Gy\01777\0265\002_M<"),
      Media = _qLZ9D
    },
    {
      Text = _MEVz("&7zL\016?vz>\0177\017\016\026GzL7\001\017\028z.?(zp\016\0177\017zo\001zL.?v\017?z\001?0z>\017\016z\004\017>\017?0\016v\017?z}\017\016>z.\001Lo\001G'\028?\017\0160\017?5z+\016\026zp\016\0177\017?zv\016?vz\017Gz\004\014Gz\001?0z>\017\016z+\017?G'\028\017?zI.'\028\026\017z\0177zGy.\017\026\0177zg\017\016\026\01775")
    },
    {
      Text = _MEVz("A.Gzg.7z0.??zg\014\028\004z0\0177z\023?L.?vzo\001zG\017\016?\017?z?\014'\028zv7\014\017GG\0177\017?z/7\017\001\017\004\026.\026\017?(z0\016\017z\0177zg\014\028\004za\0177\001\017>\026\0175"),
      Media = _CXi
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_xWJNw)
    end)
  end)
end
function _4NsAA:OnEnter()
  _p2qJ = _MEVz("1])G\023\023")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("&Gz\016G\026zg\0167X\004\016'\028z\0177G\026.\001?\004\016'\028(zg\016\017z?.'\028\004.\017GG\016vzc\014\004I\017Gzv\017g\01470\017?z\016G\026z\001?0zg\017G\028.\004>z\0177zG\014za\016\017\004\017z\ay\0017\017?z\028\016?\026\0177\004.GG\017?z\028.\0265"),
      Media = _CXi
    },
    {
      Text = _MEVz("f.\0287G'\028\017\016?\004\016'\028zL\001\017\028\004\026\017z\0177zG\016'\028zo\001zG\016'\028\0177(z?.'\0280\017Iz\016\028Iz.\004\004z0\016\017zF.\0287\017zX\017\016?\0177z\017\026g.Gz?.'\028g\017\016G\017?zX\014??\026\0175z")
    },
    {
      Text = _MEVz("&Gz\016G\026z0\014'\028zG\017\0287z\0177G'\0287\017'X\017?0(z0.GGzG\014\004'\028\017z+\017?G'\028\017?zI\016\026\026\017?z\001?\026\0177z\001?Gzg\014\028?\017?z\001?0zI.?z\017Gz\016\028?\017?z?\016'\028\026z.?G\016\017\028\0265\002_M<"),
      Media = _QBnp
    },
    {
      Text = _MEVz("c\016\0177z\028.>\017z\016'\028zG'\028\014?z0\016\017z?.\017'\028G\026\017z\ay\0017zv\017L\001?0\017?5555")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_CONGh)
    end)
  end)
end
function _Ot5wZ:OnEnter()
  _p2qJ = _MEVz("1;\026bgT")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("u\017>\0177zc\014\004I\017Gz\028.\026\026\017z\016'\028zG'\028\014?z\017\026g.Gz\028\0177.\001G>\017X\014II\017?555zo5_5z\004\016\017GGz\0177zG\016'\028za\014?zG\017\016?\0177z\0177G\026\017?z$7.\001z?\016\017zG'\028\017\0160\017?5zp7\014\026o0\017Iz\028\017\0167.\026\017\026\017z\0177z\016?z+\016??\017.y\014\004\016GzG\017\016?\017z35z$7.\001z+%7\026.5z\a\014I\016\026z\004.vz\017\016?zX\004.7\0177z$.\004\004za\014?z_\016v.I\016\017za\01475z\023\004\004\01770\016?vGzX\014??\026\017zI.?z+%7\026.z>\016G\028\0177z?\016'\028\026z.\001GL\016?0\016vzI.'\028\017?5"),
      Media = _iAK0
    },
    {
      Text = _MEVz("l\0177I\001\026\004\016'\028zg\01670z\0177zG\016'\028z\016\0287\0177z\017>\017?G\014z.\001Lz0\016\017z\017\016?\017z\0140\0177z.?0\0177\017z\0237\026z\001?0zf\017\016G\017z\017?\026\004\0170\016v\026z\028.>\017?55555\002_M<"),
      Media = _LEowF
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_H1i7v)
    end)
  end)
end
function _FDXx:OnEnter()
  _p2qJ = _MEVz("1$A^W")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("A\001z\028.G\026z\017Gzv\017G'\028.LL\0265zA\017\016?\017z\023>\026\017\016\004\001?vz\016G\026zG\026\014\004oz.\001Lz0\016'\028zQ?>GyK\001?0z0\001z\0177\028.\017\004\026G\026z\017\016?\017?z;70\017?zL\001\0177z>\017G\014?0\0177\017zl\01770\016\017?G\026\0175")
    },
    {
      Text = _MEVz("\023\001Lv7\001?0z0\0177z_\017g\017\016G\004.G\026zv.>zc\014\004I\017Gz3\030z+\01470\017zo\0015z&Gzg\01670za\0177I\001\026\017\026(z0.GGz\017Gz\017\028\0177z3ZZzg.7\017?5zc\014\004I\017GzG.v\026\017z\001\017>\0177zG\016'\028zG\017\004>G\026*z,U'\028zX\014??\026\017z?\016'\028\026Gz0.v\017v\017?z\026\001?(z0.GGz\016'\028z\017\016?z+\014\01770\0177zg\00170\0175z\a\014zg\017?\016v(zg\016\017z\017\016?zA\016'\028\026\0177z0.v\017v\017?z\026\001?zX.??(z0.GGz0\016\017z+\001G\017z\016\028?zo\001Iz\a\016?v\017?za\0177L\001\017\0287\0265zA\0177zp\017\001L\017\004zG\026.?0z?\017>\017?z0\017Iz_\017\026\026(z\016?z0\017Iz\016'\028z\016?z0\016\017zf\017\004\026z\028\016?.\001Gv\017G\026\014GG\017?zg\00170\017(z\001?0zG\017\016\0260\017Izg.7z\0177z\016II\0177z>\017\016zI\01675z,z\023Iz+\0147v\017?z0\017GzZ\0305Zb5\t\fCNzg\00170\017z\0177zo\001Iz\a'\028.LL\014\026\026zv\017L\001\017\0287\0265zuIz\tZ5\t3zu\0287zv\017\028\026z0\016\017z\a'\028\004\016?v\017zo\001zQ?>GyK\001?0z>7\016'\028\026z0\017IzA\017\004\016?\006\001\017?\026\017?z0.Gz/\017?\016'X5z3Zz+\016?\001\026\017?zGy.\017\026\0177zg\01670zG\017\016?zp\0140zL\017G\026v\017G\026\017\004\004\026z\001?0z0.Gz}.?0z.\026I\017\026\017zg\016\0170\0177z.\001L5")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_YFKWD)
    end)
    _d3K:RequestSync()
  end)
end
function _qrzJr:OnEnter()
  _p2qJ = _MEVz("1\0067oF7")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("c\016\0177zg\00170\017z.?G'\028\017\016?\017?0z\017\026g.Gza\0177v7.>\017?5z\023>\0177zg.Gz\016G\026z0.GBzc\016\0177zv\017\028\026z\017Gz|.z?\014'\028zg\017\016\026\01775zf\014o\001z\028.\017?v\026z0.Gz0.Bz"),
      Media = _LSn
    },
    {
      Text = _MEVz("U'\028z\004\017v\017z?\001?z0\016\017z\a\026\017\004\004\017z\016Iz_\0140\017?zL7\017\016z\001?0z0.??zX\001\017II\0177\017z\016'\028zI\016'\028z\001Iz0.Gz.?0\0177\017z;>|\017X\0265\002_M<"),
      Media = _CXi
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_7r0)
    end)
  end)
  _CRlT:MoveTo(nil)
end
function _3KLu_:OnEnter()
  _p2qJ = _MEVz("1\025\127}\0011")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz(";>z\0177zG\016'\028z>\017g\001GG\026z0.7\001\017>\0177zg.7(z0.GGzg\0167z\016\028?zI\016\026z0\017?zv.?o\017?z\ay\0017\017?(z0\016\017z\0177z\028\016?\026\0177\004.GG\017?z\028.\026(z\001\017>\0177L\001\017\0287\017?zX\014\017??\026\017?Bzf\014\004\004\026\017z\0177z\004\017\026o\026\017?0\004\016'\028z\001\017>\0177L\001\017\0287\026zg\01770\017?B")
    },
    {
      Text = _MEVz("U'\028z>7\016?v\017zI\017\016?\017z\023\001Lv.>\017z\028\016\0177zo\001z&?0\0175z&Gzv\016>\026z\016?z0\0177z\a.'\028\017z?\014'\028z\017\016?\016v\017zu?v\0177\017\016I\026\028\017\016\026\017?5"),
      Media = _LEowF
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_f65c)
    end)
  end)
  _huK:MoveTo(Player)
end
function _D5LP:OnEnter()
  _p2qJ = _MEVz("1Ab}d")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("f\017\016\004zc\014\004I\017Gz.\004Gz\0237o\026zG\014zg\017?\016vza\01770\016\017?\026\017(za\0177X.\001L\026\017z\0177z?\017>\017?\028\0177z.\004Gzc.\001G\016\0177\0177z.?z0\0177zc.\001G\026\001\0177z_\001\017'\028\0177(zQ?>GyK.7>\017\016\026\017\026\017z.\004Gzf.\0177\026\0177z\016?z\017\016?\0177zdG%'\028\016.\0267\016\017z\001?0z\004\017\016\026\017\026\017zG\014v.7z\017\016?\017z\a'\028\001\004\0175"),
      Media = _Ya9Q
    },
    {
      Text = _MEVz("A\016\017z.7I\017?z\a'\028\001\017\004\01775zc\014LL\017?\026\004\016'\028zI\001GG\026\017?z?\016'\028\026z>\0177\017\016\026GzG\016\017z\001?\026\0177z\016\028Iz\004\017\0160\017?zr")
    },
    {
      Text = _MEVz("U'\028zG\017\028\017z\028\016\0177z\017\026g.G5;\028z/\014\026\026zrzA.Gz\016G\026z0\014'\028z?\016'\028\026z\017\026g.z\017\016?zQ?>GyK555r\002_M<"),
      Media = _QBnp
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_WVs)
    end)
  end)
end
function _4azXD:OnEnter()
  _p2qJ = _MEVz("1].o^A")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("&Gz\028.\017\026\026\017z0\0177zd\014\004\016o\017\016z.\001'\028z>\0177\017\016\026Gz.\001LL.\004\004\017?zI\001\017GG\017?(z0.GGz0\016\017zT.\028\004z0\0177zl\0177I\016GG\026\017?.?o\017\016v\017?zy7\014o\017?\026\001.\004z.?G\026\016\017v(zI\016\026z0\0177zT.\028\004zQ?>GyK0\0177z+\016\017\026\0177(z0\016\017z\016Izc\014\026\017\004z>\017\016zc\014\004I\017Gz\017\016?o\014v\017?zg.7\017?5"),
      Media = _iAK0
    },
    {
      Text = _MEVz("f\0167z\028.\026\026\017?z\017\016?\016v\017z+.\017??\0177z.\001GL\016?0\016vzv\017I.'\028\026(z0\016\017z\016?z0\017Izc\014\026\017\004z?.'\028z\017\016?\017IzT\016II\0177zL7.v\026\017?5zF\0170\014'\028zg\00170\017z0\017?\017?zv\017G.v\026(z0.GGz0.Gzc\014\026\017\004z>\0177\017\016\026Gz.\001Gv\017>\001'\028\026zg.\0177\0175z$\0017z$7.\001\017?z\028\016?v\017v\017?zg.7z\016II\0177z\017\016?zT\016II\0177zL7\017\0165"),
      Media = _LEowF
    },
    {
      Text = _MEVz("c\014\004I\017Gz\028.\026\026\017z.\001'\028zg\0167X\004\016'\028z/\004\001\017'X(z0.GGz\016IzF.\0287z\t\fC\025z0\016\017zf\017\004\026.\001GG\026\017\004\004\001?vz\016?z2\028\016'.v\014zG\026.\026\026L.?05zA\016\017z\a\026.0\026z>\017\028\0177>\0177v\026\017za\016\017\004\017z$7\017I0\017za\014?z\001\017>\0177.\004\004z\028\01775zA\016\017z;yL\0177zX.I\017?z.\004G\014zG'\028.7\017?g\017\016G\017zo\001z\016\028I5\002_M<")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_7CbEO)
    end)
  end)
end
function _0ak:OnEnter()
  _p2qJ = _MEVz("1Z.X")
  _0ak.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("c\016\0177zG\016?0zG\017\0287za\016\017\004\017z\a'\028\001\028.>07\001\017'X\0175zA.7.\001Lz\004\016\017v\026z\017\016?\017zc..7?.0\017\0045z\a\014\004'\028\017za\0177o\016\0177\026\017?zc..7?.0\017\004?z>\017?\001\026o\026\017z\017\016?GzG\017\016?\0177z;yL\01775"),
      Media = _qLZ9D
    },
    {
      Text = _MEVz("A\016\017z\023>07\001\017'X\017zX.??z\001?G\0177z}.>\0147zI\016\026z0\017?z\a'\028\001\028\017?za\014?zc\014\004I\017Gza\0177v\004\017\016'\028\017?5"),
      Media = _QBnp
    },
    {
      Text = _MEVz("&Gz\028.?0\017\004\026zG\016'\028z\001Iz\017\016?zG\017\0287zv7\014>\017Gz\a'\028\001\028y7\014L\016\0045\002_M<&7zg.7z.\004G\014z?\016'\028\026zI\016\026zG\017\016?\017?z>\017G\026\017?z\a'\028\001\028\017?z\028\016\0177\002_M<\001?\026\0177g\017vG5z"),
      Media = _TRnu
    },
    {
      Text = _MEVz("U'\028zg\01770\017z\016\028?zv\017?.\001\017G\026\017?Gz\001?\026\0177G\001'\028\017?5zl\016\017\004\004\017\016'\028\026z\004.\017GG\026zG\016'\028z.\001'\028z?\014'\028z0\016\017z\a'\028\001\028v7\014\017GG\017zL\017G\026G\026\017\004\004\017?5"),
      Media = _LEowF
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_xNa)
    end)
  end)
end
function _bdtc:OnEnter()
  _p2qJ = _MEVz("1>0\026'")
  _huK:MoveTo(nil)
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz(";\028zg\016\017zG'\0287\017'X\004\016'\0285zA.Gz\016G\026z0\016\017zc.?0z\017\016?\017GzG\017\016?\0177z;yL\0177r\002_M<"),
      Media = _CXi
    },
    {
      Text = _MEVz("&Gzg\00170\017z0\016\017z}\017\016'\028\017z\017\016?\0177zA.I\017zv\017L\001?0\017?(z0\0177z\017\016?\017zc.?0zL\017\028\004\026\0175"),
      Media = _qLZ9D
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_pFgz)
    end)
  end)
  _cXqp:MoveTo(Player)
end
function _qAPx:OnEnter()
  _p2qJ = _MEVz("1\006\023dW")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("&Gz\028.\026\026\017z\017\026g.Gzv\0170.\001\0177\026(z>\016Gz\016'\028z0\016\017zM\001\017'XI\017\0040\001?vz.\001Gz+\016'\028\016v.?z\0177\028\016\017\004\026(z.>\0177zc\014\004I\017Gz\028\016\017GGzL7\001\017\028\0177zc\0177I.?zf\017>G\026\0177z+\0010v\017\026\0265z&7z\028.\026\026\017z\016?z|\001?v\017?zF.\0287\017?z\016?z+\016'\028\016v.?z.?z0\0177zu?\016a\0177G\016\026.\017\026z\023?.\026\014I\016\017zG\026\0010\016\0177\0265zl\0177I\001\026\004\016'\028z\028.\004Lz\016\028Iz0\016\017Gz\016IzuIv.?vzI\016\026z0\017?z}\017\016'\028\017?5z"),
      Media = _QBnp
    },
    {
      Text = _MEVz("&7zy7.X\026\016o\016\0177\026\017z0.??z\0167v\017?0g.??z.\004GzQ?>GyK\0237o\026z\016?z)\017gzm\0147X5z+\0010v\017\026\026zG'\028\004\014GGz\016?z0\0177zT\017\016\026z}\017>\017?Ga\0177G\016'\028\0177\001?v\017?z.\001Lz\0177L\001?0\017?\017z).I\017?z.>(zG\026.\028\004z0\016\017z}\017\016'\028\017?zX\001\0177o\004\016'\028zl\0177G\026\0147>\017?\0177z.\001Gz\1277.?X\017?\028.\017\001G\0177?z\001?0zv.>z0\016\017G\017z\016?z0\0177z$\014\004v\017z.\004Gz0\016\017za\0177G\016'\028\0177\026\017?zd\0177G\014?\017?z.\001G5z\023?G'\028\004\016\017GG\017?0zX.GG\016\0177\026\017z\0177z0\016\017zl\0177G\016'\028\0177\001?vGG\001II\017?5\002_M<A\0177z\a'\028g\016?0\017\004zL\004\014vz|\0170\014'\028z7\017\004.\026\016azG'\028?\017\004\004z.\001L(z\001?0zG\014zI\001GG\026\017z\0177zL\004\016\017\028\017?z\001?0z.\017?0\0177\026\017za\014?z0.z.?zG\017\016?\017?z).I\017?z.\001Lzc5c5zc\014\004I\017G5"),
      Media = _iAK0
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_zL9k)
    end)
  end)
end
function _iMWA1:OnEnter()
  _p2qJ = _MEVz("1\016+f\023\t")
  _CRlT:MoveTo(Player)
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz(").'\0280\017Izg\0167zG\017\016?zc\014\026\017\004zv\017?.\001\017G\026\017?Gz\016?Gy\016o\016\0177\026z\028.\026\026\017?(zX\014??\026\017?zg\0167z\001?Gz\017\016?z_\016\0040za\014?z0\017?zp.\026.>\004.\017\001L\017?zI.'\028\017?*zA\016\017zT\016II\0177zg.7\017?zG\014zv\017G\026.\004\026\017\026(z0.GGzc\014\004I\017Gz\016?z\017>\017?z|\017?\017z\001?>\017I\0177X\026z/.Gz\017\016?\004\017\016\026\017?zX\014??\026\017(zG\014z0.GGzG\017\016?\017z;yL\0177z\014\028?I.\017'\028\026\016vzg\00170\017?5zA.??zX\014??\026\017z\0177zG\016\017z\001\017>\0177z\017\016?\017?z\a'\028.'\028\026z\016?z0\017?z\127\017\004\004\0177zL.\004\004\017?z\004.GG\017?(zg\014z\0177z0.??zI\016\026\026\017\004Gz\aX.\004y\017\004\004z\001?0z\127.7>\014\004G.\017\0017\017z0.Gz$\004\017\016G'\028z.>\004\014\017G\017?zX\014??\026\0175\002_M<$\017\026\026z\001?0z&\016?v\017g\017\0160\017zX\014??\026\017z\0177z\016?zG\017\016?\017Iz;L\017?za\0177>7\017??\017?z\001?0z0\016\017z\127?\014'\028\017?z.\004Gz\aX\017\004\017\026\026\017zo\001G.II\017?>.\001\017?z\001?0za\0177X.\001L\017?5z"),
      Media = _iAK0
    },
    {
      Text = _MEVz("c\016\0177zG\016\017\028\026z\017Gz?.'\028z\ay\0017\017?z.\001G5zA.z\028.\026z|\017I.?0z\017\016?\017zX\004\017\016?\017z_\014Wza\0177\004\0147\017?5\002_M<"),
      Media = _QBnp
    },
    {
      Text = _MEVz("A\016\017z\001?\026\0177G\001'\028\017z\016'\028zv\017?.\001\01775\002_M<")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_A397)
    end)
  end)
  _cXqp:MoveTo(nil)
end
function _DP4BD:OnEnter()
  _p2qJ = _MEVz("1Ad]_A")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("l\014?z\028\016\0177z.\001Gz\004.\001L\026z?\001?zo\0017\001\017'Xz\016?zM\016'\028\026\001?vz\a\001\0170z;G\026z\001?0z.'\028\026\017\026z.\001Lz0\016\017zulz+.7X\016\0177\001?v\017?z.?z0\017?z\1277\017\001o\001?v\017?5")
    }
  }, function(action)
    _VMK.Active = true
    _VMK.Visible = true
    _DP4BD.Active = false
  end)
end
function _VMK:OnEnter()
  _p2qJ = _MEVz("1l+\127")
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz(")\017\028I\026z\017\0017\017?z}\014\028?z\016?z&IyL.?v5zU\0287zg.7\026zv7\014GG.7\026\016vz\001?0zg\01770\017\026z\017>\017?G\014zg\016\017zc\014\004I\017Gz\016?z0\016\017z/\017G'\028\016'\028\026\017z\017\016?v\017\028\017?r")
    }
  }, function(action)
    _Urwigo.MessageBox({
      Text = _MEVz("u\017>7\016v\017?Gzg\01670z0\016\017z/\017G'\028\016'\028\026\017zo\001zc\014\004I\017Gz\001?\026\0177z0\017Izp\016\026\017\004z,p\028\017zA\017a\016\004z\016?z\026\028\017zg\028\016\026\017z2\016\026%,za\014?z+.7\026\016?z\a'\0147'\017G\017z\001?0z}\017\014?.70\014zA\016z2.y7\016\014z.\004Gz\a\0177\016\017z\001IvG\017\026o\0265z}\017\0160\0177zg\01670z0\016\017G\017z\a\0177\016\017z'.53Z33z\0177G\026z\016?z\023I\0177\016X.z>\017\016IzA\016\017?G\026zc\001\004\001za\0177L\001\017v>.7zG\017\016?z\001?0z0.??z\017a\026\0045z.\001'\028z?.'\028zA\017\001\026G'\028\004.?0zX\014II\017?5zl\016\017\004\004\017\016'\028\026z\028.>\017?zg\0167z.>\0177z.\001'\028z/\004\001\017'Xz\001?0z\017GzL\016?0\017\026zG\016'\028z\017\016?\017zL7\001\017\028\0177\017z+\014\017v\004\016'\028X\017\016\026z0\016\017G\017zl\0177L\016\004I\001?vzo\001zG\017\028\017?zo\001z0\0177z>\0177\017\016\026GzG\017\016\026z\tZzF.\0287\017?z>\017X.??\026z\016G\026(z0.GGzA\016z2.y7\016\014z0\016\017zl\0177L\016\004I\001?vza\0147?\017\028I\017?zI\014\017'\028\026\0175"),
      Media = _h7R,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _MEVz("p7.v\026z\017\001'\028z?\014'\028z\016?z0\016\017z}\016G\026\017z0\0177z&\0287\017?>\001\0177v\0177z0\0177z\a\026.0\026z\017\016?rz\002_M<U\0287z\028.>\026z0\016\017z2.7\0267\0160v\017z?\001?z\0177L\014\004v7\017\016'\028z0\0017'\028v\017Gy\016\017\004\0265\002_M<A\0177zu?\004\014'X'\0140\017z>\017L\016?0\017\026zG\016'\028z\016?z0\017\016?\017IzU?a\017?\026.75z\002_M<f\0167zg\001\017?G'\028\017?z\017\016?\017zv\001\026\017zc\017\016IL.\0287\026r\002_M<zA.Gz\023GX\016\"p\017.I"),
            Media = _4v1
          })
        end
      end
    })
    _23_9N.Visible = true
    _23_9N:MoveTo(Player)
    _d3K.Complete = true
    _gpN = ((_MEVz("A\0177zu?\004\014'X'\0140\017z0\0177z?\0017zL\001\0177z0\017?z\ay\016\017\004\0177\002_M<") .. Player.Name) .. _MEVz("zv\001\017\004\026\016vz\016G\026(z\004.\001\026\017\026z*")) .. string.sub(Player.CompletionCode, 1, 15)
    if _d3K.Complete == true then
      _VMK.Visible = false
      _VMK.Active = false
    end
    _d3K:RequestSync()
  end)
end
function _8s_Lc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49663 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("\a'\028.0\0175zA.Gz\028\016\004L\026zI\0167z?\016'\028\026zg\017\016\026\01775zA.Gzc\017I0zv\017\028\014\0177\026zX\017\016?\0177za\0177I\016GG\026\017?zd\0177G\014?5zA\016\017z?.\017\028\0177\017zu?\026\0177G\001'\028\001?vzX.??z\016'\028zI\0167zGy.7\017?5zU'\028zI\001GGz?.'\028z.?0\0177\017?z\ay\0017\017?z\023\001GG'\028.\001z\028.\004\026\017?5zA.Gzg.\0177\017z.\001'\028zo\001z\004\017\016'\028\026zv\017g\017G\017?5z"),
        Media = _Ya9Q
      }
    }, function(action)
      _0ak.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _d3K:RequestSync()
      _ZpdL.Active = false
      _Ot5wZ.Visible = true
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("/\001'Xzv\017?.\001\0177"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_8s_Lc)
          end)
        end
      end
    })
  end
end
function _NXn:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 50239 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("A.GzI\001GGzc.\001G?\001II\0177z\025\030z>\0170\017\001\026\017?5zA.Gz\004\017\026o\026\017z;yL\0177zg\014\028?\026\017zQ?>GyK\016?z0\0177zc\016v\028z\a\0267\017\017\026z\025\0305z\a\016\017zI\001GGz0\017?z\a'\028\004\001\017GG\017\004z\028\016\0177za\0177\004\0147\017?z\028.>\017?5zU'\028z>\016?z.\004G\014z.\001Lz0\0177z7\016'\028\026\016v\017?z\ay\00175"),
        Media = _qLZ9D
      },
      {
        Text = _MEVz("c\014\004I\017Gz\004\0177?\026\017zg.\017\0287\017?0zG\017\016?\017Gz\a\026\0010\016\001IGz}\017\016'\028\017?zo\001zG\017o\016\0177\017?5zA\016\017z}\017\016'\028\017?z\0177\028\016\017\004\026\017?z0\016\017z\a\026\0010\017?\026\017?z\026\017\016\004g\017\016G\017z.\001Gz\a'\028g.7oa\0177X.\017\001L\017?za\014IzG\026.\0170\026\016G'\028\017?z$7\016\0170\028\014L5z&\016?\017z.>G'\028\017\001\004\016'\028\017zl\0147G\026\017\004\004\001?vzL\001\0177zI\016'\0285"),
        Media = _LSn
      },
      {
        Text = _MEVz("A\016\017z\ay\0017zv\017\028\026z0\0147\026za\0147?zg\017\016\026\01775")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _d3K:RequestSync()
      _ORm54.Visible = true
      _ORm54.Active = true
      _te01.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A.I\016\026zX.??z\016'\028z?\016'\028\026Gz.?L.?v\017?"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_NXn)
          end)
        end
      end
    })
  end
end
function _SX79x:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 11860 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("A\016\017z$\016?v\0177.>07\001\017'X\017zG\016?0z7\017'\028\026z0\017\001\026\004\016'\0285\002_M<U'\028zG\016'\028\0177\017zG\016\017z\001?0z?\017\028I\017zG\016\017zI\016\026z\016?Gz}.>\01475\002_M<"),
        Media = _qLZ9D
      },
      {
        Text = _MEVz("u?0z\028\016\0177z\004\016\017v\026z?\014'\028z\017\016?\017z+\001\017?o\0175z)\017\016?(z0.Gz\016G\026z\017\016?z/\017\014'\014\016?5z&\016?z&\028\017y..7z\016G\026z.\001LzG\017\016?\0177zc\014'\028o\017\016\0267\017\016G\017z\016Izc\014\026\017\004za\014?zc\014\004I\017Gz\001?\026\0177v\017X\014II\017?z\001?0zg.7zG\017\016\0260\017Iza\0177G'\028g\001?0\017?5z$7\017\001?0\017z\028.\026\026\017?z0\017Izd..7z0\016\017G\017?z2\014\016?z.\001LzM\017\016G\017?zI\016\026v\017v\017>\017?z\001?0z0.Gzd..7z.\004Gza\0177I\016GG\026zv\017I\017\0040\017\0265z;>z\0177zG\016\017z\028\016\0177za\0177G'\028.77\026z\028.\026B"),
        Media = _Dgp
      }
    }, function(action)
      _ecc.Locked = false
      _ecc:MoveTo(Player)
      _4azXD.Visible = true
      _4azXD.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _ORm54.Active = false
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("U'\028z\028\014\004zI\017\016?z+\014?\014X\017\004z\028\0177.\001G(z0.I\016\026z\016'\028z0\016\017z$\016?v\0177.>07\001\017'X\017z\017\016?v\017\028\017?0\0177z\001?\026\0177G\001'\028\017?zX.??5\002_M<"),
        Media = _iAK0
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_SX79x)
      end)
    end)
  end
end
function _CONGh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 21458 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("f\017\004'\028zv7.\001G\016v\0177z$\001?05z}.\001\026\0177z\127\014\0177y\0177\026\017\016\004\017")
      },
      {
        Text = _MEVz("A.GzG'\0287\017'X\004\016'\028\017z\023\001GI.GGzG\017\016?\0177zp.\026\017?z\004.\017GG\026zG\016'\028z?\0017z?.'\028z\001?0z?.'\028z>\017v7\017\016L\017?"),
        Media = _qLZ9D
      },
      {
        Text = _MEVz("f\017\004'\028\017z\a\0267.L\017zX.??zG\017\016?\017?zp.\026\017?z\017\016v\017?\026\004\016'\028z|\017I.\004Gzv\0177\017'\028\026zg\01770\017?B\002_M<f\0167zg\01770\017?zG\017\028\017?5555f\017??z\016'\028z.\004\004\017z_\017g\017\016G\017zo\001G.II\017?z>7\016?v\017(z0.??zg\01670z\0177zv\017\028.\017?v\0265\002_M<")
      }
    }, function(action)
      _te01.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _te01.Active = true
      _d3K:RequestSync()
      _4NsAA.Active = false
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("+\017\016?\017z\127\014?o\017?\0267.\026\016\014?zG'\028\017\016?\026z?.'\028o\001\004.GG\017?5zU'\028zv\017?\017\028I\016v\017zI\0167\002_M<?\001?z\017\016?\017?z\a'\028\004\001'Xz.\001GzI\017\016?\017Iz$\004.'\028I.??z\001?0zG\017\028\017z0.??zg\017\016\026\0177555\002_M<")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_CONGh)
      end)
    end)
  end
end
function _xWJNw:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61113 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("U?z)\017gzc.IyG\028\0167\017z\028.\026zc\014\004I\017GzG\017\016?\017z\127\016?0\028\017\016\026za\0177>7.'\028\0265"),
        Media = _qLZ9D
      },
      {
        Text = _MEVz("c\016\0177zg\00170\017z0\0177z/7\001?0G\026\017\016?zL\001\0177zG\017\016?\017zGy.\017\026\0177\017?zp.\026\017?zv\017\004\017v\0265")
      },
      {
        Text = _MEVz("\a\026\017'X\026\017z0.Gz_\014\017G\017z>\0177\017\016\026GzG\017\016\026zG\017\016?\0177z/\017>\0017\026z\016?z\016\028I(z\0140\0177zg.7\017?zG\017\016?\017z&\004\026\0177?z0\0177z\023\001G\004\014\017G\0177zL\001\0177z.\004\004\017GBz;>z\016'\028z\017Gzg\014\028\004z|\017I.\004Gz\0177L.\0287\017B\002_M<"),
        Media = _LEowF
      }
    }, function(action)
      _D5LP.Visible = true
      _D5LP.Active = true
      _d3K:RequestSync()
      _6Oy.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A.Gz\016G\026z0\0177zL.\004G'\028\017z;7\026zr\002_M<"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_xWJNw)
          end)
        end
      end
    })
  end
end
function _xNa:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 44796 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("\a\014g\017\016\026z\016'\028zI\016'\028z\0177\016??\0177\017z\028.\026zc\014\004I\017Gz\017>\017?G\014z\a'\028\001\028v7\014\017GG\017z]b5"),
        Media = _LEowF
      },
      {
        Text = _MEVz("A.Gzg.\0177\017z\017\016?zg\017\016\026\0177\017GzU?0\016ozL\001\0177zG\017\016?\017z\023?g\017G\017?\028\017\016\026z\016?z0\016\017G\0177z/\017v\017?05z"),
        Media = _LSn
      },
      {
        Text = _MEVz("g\017\016\026\0177zv\017\028\026G5555")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _4NsAA.Visible = true
      _4NsAA.Active = true
      _0ak.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A\016\017G\017z\a'\028\001\028v7\014\017GG\017zG.v\026zI\0167z?\016'\028\026Gzr"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_xNa)
          end)
        end
      end
    })
  end
end
function _pFgz:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 21599 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("U'\028z\0177\016??\0177\017zI\016'\0285"),
        Media = _Ya9Q
      },
      {
        Text = _MEVz("U'\028z\028.\026\026\017z\0167v\017?0g\014z\016?z0\017?zu?\026\0177\004.v\017?zv\017\004\017G\017?(z0.GGz\002_M<I.\004z\017\016?\017zF\001\004\016.z2\014??\0177zI\016\026z\016\0287\0177zp\014'\028\026\0177zo\001z/.G\026\002_M<>\017\016zc\014\004I\017Gz\016Izc\014\026\017\004zg.75"),
        Media = _Stg5
      },
      {
        Text = _MEVz("_\016Gz\028\017\001\026\017zX\014??\026\017zG\016\017zX\017\016?\0177z.\001LL\016?0\017?5z)\001?zg\016GG\017?zg\0167(zg\0177z0\016\017z}\017\016'\028\017zg.75"),
        Media = _qLZ9D
      }
    }, function(action)
      _d3K:RequestSync()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _iMWA1.Active = true
      _iMWA1.Visible = true
      _bdtc.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A.GzX.??z?\016'\028\026zG\017\016?zr"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_pFgz)
          end)
        end
      end
    })
  end
end
function _H1i7v:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 47841 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("&7zI\014'\028\026\017z\017Gzg\014\028\004z?\016'\028\026(zg\017??zG\016'\028z0\016\017z$7.\001\017?zv\017g\017\0287\026z\028.>\017?5z"),
        Media = _LSn
      },
      {
        Text = _MEVz("A.z\028.\026z\016\028Iz0.Gz2\028\004\0147\014L\0147Izv\001\026\017zA\016\017?G\026\017zv\017\004\017\016G\026\017\0265\002_M<"),
        Media = _qLZ9D
      },
      {
        Text = _MEVz("A\0177z\023y\014\026\028\017X\0177z\001Iz0\016\017z&'X\017zG\017\016?\017Gzc\014\026\017\004Gzg\001?0\0177\026\017zG\016'\028zG'\028\014?(zg\017G\028.\004>zc\014I\017GzL\004.G'\028\017?g\017\016G\017z0.Gz2\028\004\0147\014L\0147Iz.\001LX.\001L\026\0175z\023\004Gz\0177z0\016\017G>\017o\001\017v\004\016'\028z?.'\028L7.v\026\017(z.?\026g\0147\026\017\026\017zc\014\004I\017G(z0.GGz\017GzL\001\0177z'\028\017I\016G'\028\017z&Wy\0177\016I\017?\026\017zG\017\0165")
      },
      {
        Text = _MEVz("UIzg\017\016\026\017G\026\017?z\a\016??\017z\028.\026\026\017z\0177z|.z.\001'\028z?\016'\028\026zu?7\017'\028\0265")
      }
    }, function(action)
      _d3K:RequestSync()
      _ZpdL.Visible = true
      _ZpdL.Active = true
      _D5LP.Visible = false
      _Ot5wZ.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A.Gz\016G\026z?\016'\028\026z0\0177z7\016'\028\026\016v\017z/\017v\017?G\026.?0r\002_M<"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_H1i7v)
          end)
        end
      end
    })
  end
end
function _WVs:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 43301 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("d\016\026\017o\017\004Gz$\016?v\0177z.\004G\0145zU'\028z\0177X\017??\017z\016\028?z.?z0\0177zI.7X.?\026\017?z).7>\0175zA.Gzg.7z.\001'\028zG\017\0287zI\0177Xg\001\01770\016v5zd\016\026\017o\017\004zg.7zc\014\004I\017Gzc.?0\004.?v\01775z&7zg\01670z\016\028Iz.\001'\028zv\017\028\014\004L\017?z\028.>\017?(z0\016\017z}\017\016'\028\017?za\0177G'\028g\016?0\017?zo\001z\004.GG\017?5"),
        Media = _WwCC
      },
      {
        Text = _MEVz("_\016Gzd\016\026\017o\017\004zG\017\004>G\026za\0177G'\028g.?0"),
        Media = _iAK0
      },
      {
        Text = _MEVz("A\016\017Gz\004.vzg\014\028\004z0.7.?(z0.GGz\0177z\017\016?\017z}\017>\017?Ga\0177G\016'\028\0177\001?vz\028.\026\026\0175zQ?>GyK\023>G\014\004\001\026zX\004.7(zg\0177z0\016\017G\017zg\014\028\004zX.GG\016\0177\026z\028.>\017?zg\01670zr"),
        Media = _Ya9Q
      },
      {
        Text = _MEVz("U'\028zI\001GGzG\014za\016\017\004\017z_\017g\017\016GI\016\026\026\017\004zG.II\017\004?(zg\016\017z\016'\028z>\017X\014II\017?zX.??r"),
        Media = _qLZ9D
      }
    }, function(action)
      _Ot5wZ.Active = true
      _d3K:RequestSync()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _Ot5wZ.Visible = true
      _D5LP.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A\0177z$\016?v\0177zv\017\028\0147\026z\017\016?\0177z.?0\0177\017?zd\0177G\014?r\002_M<"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_WVs)
          end)
        end
      end
    })
  end
end
function _7CbEO:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 33909 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("U?zG\014za\016\017\004\017?zT\016II\0177?z\004\016\017GG\017?zG\016'\028zG\017\0287za\016\017\004\017zy\014\026\017?\026\016\017\004\004\017z;yL\0177z\001?\026\0177>7\016?v\017?5zf.\0287G'\028\017\016?\004\016'\028zg\01770\017?zg\0167z?\016\017z\0177L.\0287\017?(zg\016\017a\016\017\004\017z\017Gz\026.\026G.\017'\028\004\016'\028zg.7\017?5\002_M<")
      },
      {
        Text = _MEVz("\a\017\016\026z\0177z\016?zu?\026\0177G\001'\028\001?vG\028.L\026zG\016\026o\026(zG'\028g\017\016v\026z\0177z>\017\028.77\004\016'\028zo\001z0\017?zl\0147g\001\0177L\017?55z\023>\0177za\016\017\004\004\017\016'\028\026zX?\016'X\026z\0177z\001?\026\0177z0\0177z_\017g\017\016G\004.G\026zGy.\017\026\0177z\017\016?5")
      }
    }, function(action)
      _3KLu_.Active = true
      _3KLu_.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _d3K:RequestSync()
      _4azXD.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("U'\028z\028.>\017z\017\016?\017z.?0\0177\017zT.\028\004z\016?z&7\016??\0177\001?v\002_M<"),
      Media = _LEowF,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_7CbEO)
          end)
        end
      end
    })
  end
end
function _f65c:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 25594 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("A\016\017G\017Gz\127\004\017\0160zg.7zG\017\0287z.\001GG\0177v\017g\014\017\028?\004\016'\028z\001?0za\014?z\017\016?\017Iz0\0177z>\017G\026\017?z\a'\028?\017\0160\0177z0\0177z/\017v\017?05zQ?>GyKf\0167zX\014??\026\017?zo\001Iz/\004\001\017'Xz0\017?z\a'\028?\017\0160\0177z.\001GL\016?0\016vzI.'\028\017?(z0.I\016\026z\0177zG\017\016?z+\017\016G\026\0177G\026\001\017'Xz\0160\017?\026\016L\016o\016\0177\0265"),
        Media = _LEowF
      }
    }, function(action)
      _bdtc.Active = true
      _bdtc.Visible = true
      _d3K:RequestSync()
      _3KLu_.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A\016\017z$.7>\017z\016G\026zg\0167X\004\016'\028z?\0017zG'\028g\0177z\0177X\017??>.7"),
      Media = _QBnp,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_f65c)
          end)
        end
      end
    })
  end
end
function _7r0:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 55904 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("c\014\004I\017Gz\028.\026z0.Gz\1277\017\001ozG\017\016?\0177z+\001\026\026\0177za\0177\004\0147\017?5z&7z\0267\001vz\017Gz\016II\0177z>\017\016zG\016'\028(z.\001'\028zg\017??zG\017\016?\017z\127\016?0\028\017\016\026z?\016'\028\026z0\016\017z>\017G\026\017zg.75"),
        Media = _LSn
      },
      {
        Text = _MEVz("A.Gz\016G\026z0\0177z\127\014yLz0\0177z$7.\001(zI\016\026z0\0177z\0177z\016Izf.\0040za\0177G'\028g\001?0\017?z\016G\0265")
      },
      {
        Text = _MEVz("A.Gzg.7z_\017\026\026%5zU'\028z\0177\016??\0177\017zI\016'\028z.?z0\016\017z_\016\0040\0177z\016?z\001?G\0177\017?z\023X\026\017?5"),
        Media = _5bP
      },
      {
        Text = _MEVz(")\001?z\028.>\017z\016'\028zg\0167X\004\016'\028z\017707\001\017'X\017?0\017z_\017g\017\016G\017z>\017\016G.II\017?5z+\017\0287zg\01770\017?z?\016'\028\026z>\017?\014\017\026\016v\0265zU'\028z>7\016?v\017zG\016\017z|\017\026o\026z0\017IzM\016'\028\026\01775"),
        Media = _CXi
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _FDXx.Active = true
      _FDXx.Visible = true
      _d3K:RequestSync()
      _qrzJr.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("A.Gz\016G\026z?\016'\028\026z0\0177z7\016'\028\026\016v\017z/\017v\017?G\026.?0zr"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_7r0)
          end)
        end
      end
    })
  end
end
function _zL9k:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 53383 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("A.Gz\028.\026zI\0167zG'\028\014?zG\017\0287zg\017\016\026\0177v\017\028\014\004L\017?5z)\001?zg\01770\017z\016'\028z0\016\017z/\017v\017?0z?.'\028zg\017\016\026\0177\017?zc\016?g\017\016G\017?z0\0017'\028L\0147G\026\017?z\001?0zG'\028\004\016\017GG\004\016'\028zI\001GGz\016'\028z0.Gza\0177I\016GG\026\017z+.\0170'\028\017?zL\016?0\017?5z\a\014\004'\028\017zdG%'\028\014y.\026\028\017?zG.II\017\004?z.\001'\028z\014\017L\026\0177z\023?0\017?X\017?z.?z\016\0287\017z;yL\01775zc\014\004I\017Gz\016G\026z\017\016?z\001\017>\0177.\001Gzv\017G\026\014\0177\026\0177z+.??5zU'\028zg\01770\017z?.'\028G'\028.\001\017?(z\014>z?\014'\028zI\017\0287zo\001zL\016?0\017?z\016G\0265"),
        Media = _QBnp
      }
    }, function(action)
      _d3K:RequestSync()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _6Oy.Active = true
      _6Oy.Visible = true
      _dA1xe.Active = false
      _dA1xe.Visible = false
      _d3K:RequestSync()
      _qAPx.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("&GzI\001GGz\028\016\0177zg.Gzo\001zL\016?0\017?zG\017\016?z555"),
      Buttons = {
        _MEVz("c\016\0177zI\001GGz\017\016?zc\016?g\017\016Gzo\001zL\016?0\017?zG\017\016?zr")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_zL9k)
          end)
        end
      end
    })
  end
end
function _A397:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61510 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("f\0167zL.?0\017?zI\0170\016o\016?\016G'\028\017zU?G\026\016\026\001\026\017(z0\016\017za\014?zc\014\004I\017Gz\aX\017\004\017\026\026\017zX.\001L\026\017?5"),
        Media = _LSn
      },
      {
        Text = _MEVz("&7z\028.\026\026\017z\017\016?z$.\02877.0zI\016\026z0\017Iz\0177z0\016\017z\aX\017\004\017\026\026\017z\0267.?Gy\0147\026\016\0177\026\0175\002_M<"),
        Media = _qLZ9D
      },
      {
        Text = _MEVz("+\016\026z0\017?zd\014\004\016o\016G\026\017?z.\001Lz0\0177z\a\0267.GG\017za\0177G\026.?0z\0177zG\016'\028zv\001\026z\001?0z\028.\026\026\017z\016II\0177zT\016v.77\017?z\001?0z}\016X\014\0177zL\001\0177zG\016\0175")
      }
    }, function(action)
      _d3K:RequestSync()
      _qrzJr.Active = true
      _qrzJr.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _iMWA1.Active = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("$\016?0\017z0\016\017zd\0177G\014?z\028\0177.\001G"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_A397)
          end)
        end
      end
    })
  end
end
function _YFKWD:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 53068 then
    _Urwigo.Dialog(false, {
      {
        Text = _MEVz("A\016\017G\017z&\0287\001?vz\028.G\026z0\001z0\0167zg\0167X\004\016'\028za\01770\016\017?\0265\002_M<A\001z\028.G\026z\017\016?\017?z0\0177zGy\017X\026.X\001\004.\0177G\026\017?z\a\0177\016\017?I\014\01770\0177z0\0177z/\017G'\028\016'\028\026\017z\001\017>\0177L\001\017\0287\0265z")
      }
    }, function(action)
      _DP4BD.Visible = true
      _DP4BD.Active = true
      _FDXx.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _MEVz("f\017??z0\001z0\016'\028za\0177\004.\017\001LG\026(z0.??zX\014IIG\026z0\001zo\001zGy.\017\026zo\001z0\017\016?\0177z&\0287\001?vr"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_YFKWD)
          end)
        end
      end
    })
  end
end
function _hp2G:On_syk(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_8s_Lc)
  end)
end
function _onQ:On_rp08O(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_NXn)
  end)
  _NXn.Visible = true
end
function _uhUj:On_tSCZs(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_SX79x)
  end)
end
function _4lJJ:On_HKuH(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_CONGh)
  end)
end
function _rSy:On_af1(target)
  _xNa.Visible = true
end
function _jrsHU:On_ChhA(target)
end
function _jrsHU:OnClick()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_zL9k)
  end)
end
function _g8uT:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("\"A\016\017z)\001II\0177z\001?G\0177\0177zf\028.\026G.yyzc\016\004L\017zc\014\026\004\016?\017z\016G\026z*zQ?>GyKZ\t\030Nz\030\fzNNzZb\025C\002_M<\002_M<\"A\016\017z\023?\026g\0147\026\017?z\016Iz\ay\016\017\004zX\014\017??\026z\016\0287z.\004\004\017zX\004\017\016?zG'\0287\017\016>\017?\002_M<\002_M<\"A\016\017z+\017\0040\001?v\017?z,\bMzG'.??\017?,zG\016?0z?\016'\028\026zo\001z>\017.7>\017\016\026\017?5\002_M<\002_M<\"$.7>\016v\017zdL\017\016\004\017zv\017\028\014\0177\017?z?\016'\028\026zo\001z0\016\017G\017Iz2.'\028\017r\002_M<\002_M<\"\a\014\004\004\026\017z\017\0017\017z2.7\0267\0160v\017z\001?\026\0177g\017vGz\017\016?\017?zc.\017?v\0177z\028.>\017?(z0.??z\002_M<\004.GG\026z\017\001'\028z0\017?z\ay\016\017\004G\026.?0z\017\0017\017Gzd.7\026?\0177Gza\016.z_\004\001\026\014\014\026\028zG\017?0\017?5zA.o\001zv\017\028\026z\016\0287z\016?z0\017?zA.\026\017\016I.?.v\0177(zG\001'\028\026zf\028\0177\017m\014\001/\014z\001?0z\001\017>\0177\0267.v\026z0\016\017zA.\026\017\016\017?zI\016\026z0\017?z&?0\001?v\017?z,vg\004z~z\014gG,5z\a\014zX\014\017??\026z\016\0287zI\016\026z0\017IzL\001?X\026\016\014?\016\0177\017?0\017?z\ay\016\017\004G\026.?0z\017\0017\017Gzd.7\026?\0177Gzg\017\016\026\0177Gy\016\017\004\017?z\024L\001?X\026\016\014?\016\0177\026z?\016'\028\026z>\017\016zUy\028\014?\017\0185z")
    },
    {
      Text = _MEVz("\"f\017??zI.?z>\017\016IzUy\028\014?\017z0.Gz\ay\016\017\004za\0177\004.\017GG\026(zI\001GGzI.?z.?G'\028\004\016\017GG\017?0z.\001LzM&\au+&z\001?0z)U2cpz.\001Gzd}\023mzv\017\028\017?z\024\023?G\014?G\026\017?z\016G\026z\017\001\0177z\ay\016\017\004G\026.?0zg\017vr\018r\002_M<\002_M<\").'\028z\0177\004\0170\016v\026\0177z\023\001Lv.>\017zX\014\017??\026z\016\0287zG\016'\028\0177\028\017\016\026G\028.\004>\0177z0\017?z\ay\016\017\004G\026.?0z|\0170\0177zT\014?\017z.>Gy\017\016'\028\0177?5z\023'\028\026\017\026z0.>\017\016z0.7.\001L(0.GGz0\016\017z.X\026\001\017\004\004\017zu\0287o\017\016\026z.?v\017o\017\016v\026zg\016705z$.\004\004Gz?\016'\028\026(z0.??zv\017\028\026z\017\016?z35z+.\004z.\001LzGy\017\016'\028\0177?zr\002_M<\002_M<\"\023Iz$U)\023}zI\001\017GG\026z\016\0287z?\014'\028z\017\016?\017z\004\017\026o\026\017z\023\001Lv.>\017z\004\014\017G\017?(z\001Iz0\017?zf\017vzo\001Iz_\014?\001Gzo\001z\0177\028.\004\026\017?5")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _23_9N:On_ZMvb(target)
end
function _23_9N:OnClick()
  _Urwigo.MessageBox({
    Text = _gpN,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _rKaMA:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("f\017??z\016\0287z\017\001'\028z.?zG'\028g\016\0177\016v\017?z\a\026.\026\016\014?\017?z\016?z\017\016?\0177z.>G\014\004\001\026z.\001Gg\017v\004\014G\017?z\a\016\026\001.\026\016\014?z>\017L\016?0\017\026(z0.??z\0177\028.\004\026\017\026z\016\0287zc\016\004L\017zo\0017z\a\017\004>G\026\028\016\004L\0175zQ?>GyKA\016\017Gz\016G\026z\016?z]zT\014?\017?z0\0177z$.\004\0045z")
    },
    {
      Text = _MEVz("U?z0\016\017G\017?zT\014?\017?z\0177\028.\004\026\017\026z\016\0287z\017\016?\017z&I.\016\004.07\017GG\017z.?z0\016\017z\016\0287z\017\016?\017z\004\017\0177\017z+.\016\004zG'\028\016'X\017?zI\001\017GG\0265zA.??z\0177\028.\004\026\017\026z\016\0287z.\001\026\014I.\026\016G'\028z0\016\017z}\014\017G\001?vzy\0177z+.\016\004z7\017\026\014\00175")
    },
    {
      Text = _MEVz("F\017z?.'\028z&I.\016\004.?>\016\017\026\0177z\016G\026z\017GzG\016??a\014\004\004zI\017\0287\0177\017z+.\016\004Gza\014?za\0177G'\028\016\0170\017?\017?z\023?>\016\017\026\0177?zo\001zG'\028\016'X\017?(z0.z>\017\016z\017\016?\016v\017?z0\0177z&IyL.?vz\004.\017?v\0177z\001?0z0.\001\0177\026(z.\004Gz>\017\016z.?0\0177\017?5")
    },
    {
      Text = _MEVz("A\016\017G\017zc\016\004L\017zv\016>\026z\017Gz>\017\016z\a\fz(z\a\t\tz(z\a\t3z(z\a\t\025")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _fQs3H:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("A\001z>\016G\026zG\016'\028\0177(z0.GGz0\001z0\016\017G\017zc\016\004L\017z>\017?\014\017\026\016vG\026B")
    },
    {
      Text = _MEVz("l\0177G\001'\028z\017Gz0\014'\028z?\014'\028z\017\016?I.\004zG\017\004>G\026zr")
    },
    {
      Text = _MEVz(")\017\016?zBz_\016G\026z0\001zg\0167X\004\016'\028zG\014za\0177og\017\016L\017\004\026zB")
    },
    {
      Text = _MEVz(";X(z0.??zG\017?0\017z\017\016?\017z+.\016\004z.?*zQ?>GyKI\0285G'\028\004\001\017GG\017\004jg\017>50\017")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _huK:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _MEVz("A.Gzg\016\004\004G\026z0\001z0\014'\028z|\017\026o\026z?\016'\028\026zg\0167X\004\016'\028zB")
    },
    {
      Text = _MEVz("c.G\026z0\001z?\014'\028z\017\016?\017?z$\001?X\017?z&\0287v\017\016ozB")
    },
    {
      Text = _MEVz("$\017\028\004.?o\017\016v\017zBzA.??zG\017?0\017z\017\016?\017z+.\016\004z.?z*zI\0285L.7>\017jg\017>50\017")
    }
  })
end
function _cXqp:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("A\001zI.'\028G\026z\017Gz0\0167z.>\0177z\017\016?L.'\028zr")
    },
    {
      Text = _MEVz("c.G\026z0\001zg\0167X\004\016'\028z\004.?v\017zv\017?\001vz\001\017>\0177\004\017v\026zB")
    },
    {
      Text = _MEVz("f\016\004\004G\026z0\001z\017Gz\017'\028\026z?\016'\028\026z?\014'\028z\017\016?I.\004zG\017\004>G\026zy7\014>\016\0177\017?zB")
    },
    {
      Text = _MEVz("f\017??z0\001z0\0167zg\0167X\004\016'\028zG\016'\028\0177z>\016G\026(z0.GGz0\001z0\016\017G\017zc\016\004L\017z>7.\001'\028G\026z(z0.??zG\017?0\017z\017\016?\017z+.\016\004z.?z*zI\0285\028.?0jg\017>50\017z")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _CRlT:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _MEVz("A\001z\028.G\026zX\017\016?\017zU0\017\017zB")
    },
    {
      Text = _MEVz("\028.G\026z0\001zg\0167X\004\016'\028z.\004\004\017z;y\026\016\014?\017?zv\017\026\017G\026\017\026zB")
    },
    {
      Text = _MEVz("\a'\028.0\017(z0.GGz0\001z?\016'\028\026z0.7.\001LzX\014IIG\026z5")
    },
    {
      Text = _MEVz("f\017??z\017GzG\017\016?zI\001GG(z0.??zG\017?0\017z\017\016?\017z+.\016\004z.?z*zI\0285.7I>.?0jg\017>50\017")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
  _cXqp:MoveTo(nil)
end
return _d3K
