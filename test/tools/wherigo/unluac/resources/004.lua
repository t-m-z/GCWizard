require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _DTX(str)
  local res = ""
  local dtable = ")u|/1LwVP[E4\018J#OU $jn\019\017co<\025\b@N\v`k\002-2\0218\020,\000\fAF?B\005!QiZl9m{C;\02350b&]*\tT\024:f\006r=\001>7y\022(S}\016Xv\004IY\028~t\015ge\r%q^6a'\030\026RM\031\003_Wx3s\nKhd\014D.p\\\"+\027H\a\029Gz"
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
objKlausdenktnach = Wherigo.ZCartridge()
objPortal = Wherigo.ZMedia(objKlausdenktnach)
objPortal.Id = "f14fe143-3025-4345-860e-4bf8097c9d23"
objPortal.Name = _DTX("\t\025GYb4")
objPortal.Description = ""
objPortal.AltText = ""
objPortal.Resources = {
  {
    Type = "jpg",
    Filename = "portal.jpg",
    Directives = {}
  }
}
objicoPortal = Wherigo.ZMedia(objKlausdenktnach)
objicoPortal.Id = "25d02254-0785-4ec2-be5a-8e40f6d076f8"
objicoPortal.Name = _DTX("2\024\025#\t\025GYb4")
objicoPortal.Description = ""
objicoPortal.AltText = ""
objicoPortal.Resources = {
  {
    Type = "jpg",
    Filename = "ico-portal.jpg",
    Directives = {}
  }
}
objBuch = Wherigo.ZMedia(objKlausdenktnach)
objBuch.Id = "758e874c-2d55-4c66-8924-e565ab353edd"
objBuch.Name = _DTX(".\002\024q")
objBuch.Description = ""
objBuch.AltText = ""
objBuch.Resources = {
  {
    Type = "jpg",
    Filename = "buch.jpg",
    Directives = {}
  }
}
objicoBuch = Wherigo.ZMedia(objKlausdenktnach)
objicoBuch.Id = "ac006679-f95b-4135-8943-54767fbf2192"
objicoBuch.Name = _DTX("2\024\025#.\002\024q")
objicoBuch.Description = ""
objicoBuch.AltText = ""
objicoBuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-buch.jpg",
    Directives = {}
  }
}
objVester = Wherigo.ZMedia(objKlausdenktnach)
objVester.Id = "b6b60782-228d-4f7a-981d-c16e64f91e8f"
objVester.Name = _DTX("\b\\nY\\G")
objVester.Description = ""
objVester.AltText = ""
objVester.Resources = {
  {
    Type = "jpg",
    Filename = "vester.jpg",
    Directives = {}
  }
}
objicoIPol1 = Wherigo.ZMedia(objKlausdenktnach)
objicoIPol1.Id = "5fa112ad-8af4-4899-b42a-782f32efeaec"
objicoIPol1.Name = _DTX("2\024\025#U#\t\0254#\005")
objicoIPol1.Description = ""
objicoIPol1.AltText = ""
objicoIPol1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfpol_ak.jpg",
    Directives = {}
  }
}
objicoIBev1 = Wherigo.ZMedia(objKlausdenktnach)
objicoIBev1.Id = "b2d46214-7690-405f-be8c-906bbeccb076"
objicoIBev1.Name = _DTX("2\024\025#U#.\\S#\005")
objicoIBev1.Description = ""
objicoIBev1.AltText = ""
objicoIBev1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfbev_ak.jpg",
    Directives = {}
  }
}
objicoIProd1 = Wherigo.ZMedia(objKlausdenktnach)
objicoIProd1.Id = "dcb43440-78fc-4d06-8809-d7b758feb030"
objicoIProd1.Name = _DTX("2\024\025#U#\tG\025r#\005")
objicoIProd1.Description = ""
objicoIProd1.AltText = ""
objicoIProd1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfpro_ak.jpg",
    Directives = {}
  }
}
objicoISan1 = Wherigo.ZMedia(objKlausdenktnach)
objicoISan1.Id = "e630c932-ec98-4cf8-9550-9e8b761a9520"
objicoISan1.Name = _DTX("2\024\025#U#Ob\021#\005")
objicoISan1.Description = ""
objicoISan1.AltText = ""
objicoISan1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfsan_ak.jpg",
    Directives = {}
  }
}
objicoIUmw1 = Wherigo.ZMedia(objKlausdenktnach)
objicoIUmw1.Id = "e81d29e1-d57d-4f1e-b93e-58ff3d9682e1"
objicoIUmw1.Name = _DTX("2\024\025#U#\0176\a#\005")
objicoIUmw1.Description = ""
objicoIUmw1.AltText = ""
objicoIUmw1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfumw_ak.jpg",
    Directives = {}
  }
}
objicoILeb1 = Wherigo.ZMedia(objKlausdenktnach)
objicoILeb1.Id = "a39040c5-802c-4e74-abc2-eade49b49d51"
objicoILeb1.Name = _DTX("2\024\025#U#\006\\=#\005")
objicoILeb1.Description = ""
objicoILeb1.AltText = ""
objicoILeb1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfleb_ak.jpg",
    Directives = {}
  }
}
objicoIVerm1 = Wherigo.ZMedia(objKlausdenktnach)
objicoIVerm1.Id = "7f8ff8c2-1dd5-433e-9661-3b897f0a3198"
objicoIVerm1.Name = _DTX("2\024\025#U#\b\\G6#\005")
objicoIVerm1.Description = ""
objicoIVerm1.AltText = ""
objicoIVerm1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kfver_ak.jpg",
    Directives = {}
  }
}
objicoIAuf1 = Wherigo.ZMedia(objKlausdenktnach)
objicoIAuf1.Id = "fa7b9339-1f78-4b19-95b1-07a47eeb2995"
objicoIAuf1.Name = _DTX("2\024\025#U#+\002E#\005")
objicoIAuf1.Description = ""
objicoIAuf1.AltText = ""
objicoIAuf1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kfauf_ak.jpg",
    Directives = {}
  }
}
objWordmap = Wherigo.ZMedia(objKlausdenktnach)
objWordmap.Id = "c04bce98-474d-466f-b5ed-69fa106eac6e"
objWordmap.Name = _DTX("k\025Gr6bv")
objWordmap.Description = ""
objWordmap.AltText = ""
objWordmap.Resources = {
  {
    Type = "jpg",
    Filename = "wordmap.jpg",
    Directives = {}
  }
}
obj10lebensqualitaetlebensqualitaet = Wherigo.ZMedia(objKlausdenktnach)
obj10lebensqualitaetlebensqualitaet.Id = "38fc3e63-3bb3-4cc4-b075-c20d3f47e904"
obj10lebensqualitaetlebensqualitaet.Name = _DTX("\005<#4\\=\\\021n_\002b42Yb\\Y#4\\=\\\021n_\002b42Yb\\Y")
obj10lebensqualitaetlebensqualitaet.Description = ""
obj10lebensqualitaetlebensqualitaet.AltText = ""
obj10lebensqualitaetlebensqualitaet.Resources = {
  {
    Type = "jpg",
    Filename = "10-lebensqualitaet-lebensqualitaet.jpg",
    Directives = {}
  }
}
obj11lebensqualitaetvermehrungsrate = Wherigo.ZMedia(objKlausdenktnach)
obj11lebensqualitaetvermehrungsrate.Id = "9ccfe1f4-0728-474b-8b44-6f56b48f8e7f"
obj11lebensqualitaetvermehrungsrate.Name = _DTX("\005\005#4\\=\\\021n_\002b42Yb\\Y#S\\G6\\qG\002\021[nGbY\\")
obj11lebensqualitaetvermehrungsrate.Description = ""
obj11lebensqualitaetvermehrungsrate.AltText = ""
obj11lebensqualitaetvermehrungsrate.Resources = {
  {
    Type = "jpg",
    Filename = "11-lebensqualitaet-vermehrungsrate.jpg",
    Directives = {}
  }
}
obj12lebensqualitaetpolitik = Wherigo.ZMedia(objKlausdenktnach)
obj12lebensqualitaetpolitik.Id = "c7215e91-da09-41a0-9d6c-0e03c67d3f6e"
obj12lebensqualitaetpolitik.Name = _DTX("\005$#4\\=\\\021n_\002b42Yb\\Y#v\02542Y2!")
obj12lebensqualitaetpolitik.Description = ""
obj12lebensqualitaetpolitik.AltText = ""
obj12lebensqualitaetpolitik.Resources = {
  {
    Type = "jpg",
    Filename = "12-lebensqualitaet-politik.jpg",
    Directives = {}
  }
}
objKlaus = Wherigo.ZMedia(objKlausdenktnach)
objKlaus.Id = "84d7acf4-0f73-4577-9888-90cbc52899d7"
objKlaus.Name = _DTX("p4b\002n")
objKlaus.Description = ""
objKlaus.AltText = ""
objKlaus.Resources = {
  {
    Type = "jpg",
    Filename = "Klaus.jpg",
    Directives = {}
  }
}
obj13vermehrungsratebevoelkerung = Wherigo.ZMedia(objKlausdenktnach)
obj13vermehrungsratebevoelkerung.Id = "3189d60f-0a24-494b-8450-a9497548b4f7"
obj13vermehrungsratebevoelkerung.Name = _DTX("\005m#S\\G6\\qG\002\021[nGbY\\#=\\S\025\\4!\\G\002\021[")
obj13vermehrungsratebevoelkerung.Description = ""
obj13vermehrungsratebevoelkerung.AltText = ""
obj13vermehrungsratebevoelkerung.Resources = {
  {
    Type = "jpg",
    Filename = "14-vermehrungsrate-bevoelkerung.jpg",
    Directives = {}
  }
}
obj17produktionaktionspunkte = Wherigo.ZMedia(objKlausdenktnach)
obj17produktionaktionspunkte.Id = "19eb1d8e-9f0f-4a72-8b5e-a2d76d185497"
obj17produktionaktionspunkte.Name = _DTX("\005K#vG\025r\002!Y2\025\021#b!Y2\025\021nv\002\021!Y\\")
obj17produktionaktionspunkte.Description = ""
obj17produktionaktionspunkte.AltText = ""
obj17produktionaktionspunkte.Resources = {
  {
    Type = "jpg",
    Filename = "17-produktion-aktionspunkte.jpg",
    Directives = {}
  }
}
obj18lebensqualitateaktionspunkte = Wherigo.ZMedia(objKlausdenktnach)
obj18lebensqualitateaktionspunkte.Id = "d17f60b4-4e0a-4c07-8413-7e7fde3591bf"
obj18lebensqualitateaktionspunkte.Name = _DTX("\005&#4\\=\\\021n_\002b42YbY\\#b!Y2\025\021nv\002\021!Y\\")
obj18lebensqualitateaktionspunkte.Description = ""
obj18lebensqualitateaktionspunkte.AltText = ""
obj18lebensqualitateaktionspunkte.Resources = {
  {
    Type = "jpg",
    Filename = "18-lebensqualitaet-aktionspunkte.jpg",
    Directives = {}
  }
}
obj9aufklaerungvermehrungsrate = Wherigo.ZMedia(objKlausdenktnach)
obj9aufklaerungvermehrungsrate.Id = "2060b9b3-fc19-4952-9ecd-4b563ecfb26d"
obj9aufklaerungvermehrungsrate.Name = _DTX("5#b\002E!4b\\G\002\021[#S\\G6\\qG\002\021[nGbY\\")
obj9aufklaerungvermehrungsrate.Description = ""
obj9aufklaerungvermehrungsrate.AltText = ""
obj9aufklaerungvermehrungsrate.Resources = {
  {
    Type = "jpg",
    Filename = "9-aufklaerung-vermehrungsrate.jpg",
    Directives = {}
  }
}
obj1SanierungUmweltbelastung = Wherigo.ZMedia(objKlausdenktnach)
obj1SanierungUmweltbelastung.Id = "a6af6d9f-f2e8-4e63-be02-06525c7f68d4"
obj1SanierungUmweltbelastung.Name = _DTX("\005#Ob\0212\\G\002\021[#\0176\a\\4Y=\\4bnY\002\021[")
obj1SanierungUmweltbelastung.Description = ""
obj1SanierungUmweltbelastung.AltText = ""
obj1SanierungUmweltbelastung.Resources = {
  {
    Type = "jpg",
    Filename = "1-sanierung-umweltbelastung.jpg",
    Directives = {}
  }
}
obj8aufklaerunglebensqualitaet = Wherigo.ZMedia(objKlausdenktnach)
obj8aufklaerunglebensqualitaet.Id = "171fd96f-c6d7-4169-ae11-3ea20e5939dd"
obj8aufklaerunglebensqualitaet.Name = _DTX("&#b\002E!4b\\G\002\021[#4\\=\\\021n_\002b42Yb\\Y")
obj8aufklaerunglebensqualitaet.Description = ""
obj8aufklaerunglebensqualitaet.AltText = ""
obj8aufklaerunglebensqualitaet.Resources = {
  {
    Type = "jpg",
    Filename = "8-aufklaerung-lebensqualitaet.jpg",
    Directives = {}
  }
}
obj2sanierungsanierung = Wherigo.ZMedia(objKlausdenktnach)
obj2sanierungsanierung.Id = "2ba04f8d-26c8-4e99-90d1-0348cddce10a"
obj2sanierungsanierung.Name = _DTX("$#nb\0212\\G\002\021[#nb\0212\\G\002\021[")
obj2sanierungsanierung.Description = ""
obj2sanierungsanierung.AltText = ""
obj2sanierungsanierung.Resources = {
  {
    Type = "jpg",
    Filename = "2-sanierung-sanierung.jpg",
    Directives = {}
  }
}
obj5umweltbelastungumweltbelastung = Wherigo.ZMedia(objKlausdenktnach)
obj5umweltbelastungumweltbelastung.Id = "0e36b91f-84a6-48b4-91fe-0fd0f0ea0a2a"
obj5umweltbelastungumweltbelastung.Name = _DTX(";#\0026\a\\4Y=\\4bnY\002\021[#\0026\a\\4Y=\\4bnY\002\021[")
obj5umweltbelastungumweltbelastung.Description = ""
obj5umweltbelastungumweltbelastung.AltText = ""
obj5umweltbelastungumweltbelastung.Resources = {
  {
    Type = "jpg",
    Filename = "5-umweltbelastung-umweltbelastung.jpg",
    Directives = {}
  }
}
obj3produktionproduktion = Wherigo.ZMedia(objKlausdenktnach)
obj3produktionproduktion.Id = "476a1bcc-a4ed-4b91-afa3-7360c94cc206"
obj3produktionproduktion.Name = _DTX("m#vG\025r\002!Y2\025\021#vG\025r\002!Y2\025\021")
obj3produktionproduktion.Description = ""
obj3produktionproduktion.AltText = ""
obj3produktionproduktion.Resources = {
  {
    Type = "jpg",
    Filename = "3-produktion-produktion.jpg",
    Directives = {}
  }
}
obj4produktionumweltbelastung = Wherigo.ZMedia(objKlausdenktnach)
obj4produktionumweltbelastung.Id = "06112bdd-d06e-4e3f-8b69-b55cb569acc1"
obj4produktionumweltbelastung.Name = _DTX("\f#vG\025r\002!Y2\025\021#\0026\a\\4Y=\\4bnY\002\021[")
obj4produktionumweltbelastung.Description = ""
obj4produktionumweltbelastung.AltText = ""
obj4produktionumweltbelastung.Resources = {
  {
    Type = "jpg",
    Filename = "4-produktion-umweltbelastung.jpg",
    Directives = {}
  }
}
obj14bevoelkerunglebensqualitaet = Wherigo.ZMedia(objKlausdenktnach)
obj14bevoelkerunglebensqualitaet.Id = "45635333-3b96-4a1e-99f4-a876735b8352"
obj14bevoelkerunglebensqualitaet.Name = _DTX("\005\f#=\\S\025\\4!\\G\002\021[#4\\=\\\021n_\002b42Yb\\Y")
obj14bevoelkerunglebensqualitaet.Description = ""
obj14bevoelkerunglebensqualitaet.AltText = ""
obj14bevoelkerunglebensqualitaet.Resources = {
  {
    Type = "jpg",
    Filename = "13-bevoelkerung-lebensqualitaet.jpg",
    Directives = {}
  }
}
obj16politikaktionspunkte = Wherigo.ZMedia(objKlausdenktnach)
obj16politikaktionspunkte.Id = "9a6ca3fc-48d1-4557-862d-0c353d8b6e4c"
obj16politikaktionspunkte.Name = _DTX("\005a#v\02542Y2!#b!Y2\025\021nv\002\021!Y\\")
obj16politikaktionspunkte.Description = ""
obj16politikaktionspunkte.AltText = ""
obj16politikaktionspunkte.Resources = {
  {
    Type = "jpg",
    Filename = "16-politik-aktionspunkte.jpg",
    Directives = {}
  }
}
obj15bevoelkerungaktionspunkte = Wherigo.ZMedia(objKlausdenktnach)
obj15bevoelkerungaktionspunkte.Id = "cd64d912-2c5e-42b1-afd9-dbce6df9ecdb"
obj15bevoelkerungaktionspunkte.Name = _DTX("\005;#=\\S\025\\4!\\G\002\021[#b!Y2\025\021nv\002\021!Y\\")
obj15bevoelkerungaktionspunkte.Description = ""
obj15bevoelkerungaktionspunkte.AltText = ""
obj15bevoelkerungaktionspunkte.Resources = {
  {
    Type = "jpg",
    Filename = "15-bevoelkerung-aktionspunkte.jpg",
    Directives = {}
  }
}
obj7aufklaerungaufklaerung = Wherigo.ZMedia(objKlausdenktnach)
obj7aufklaerungaufklaerung.Id = "660bcacc-df5f-4343-aae4-256442d593b1"
obj7aufklaerungaufklaerung.Name = _DTX("K#b\002E!4b\\G\002\021[#b\002E!4b\\G\002\021[")
obj7aufklaerungaufklaerung.Description = ""
obj7aufklaerungaufklaerung.AltText = ""
obj7aufklaerungaufklaerung.Resources = {
  {
    Type = "jpg",
    Filename = "7-aufklaerung-aufklaerung.jpg",
    Directives = {}
  }
}
obj6umweltbelastunglebensqualitaet = Wherigo.ZMedia(objKlausdenktnach)
obj6umweltbelastunglebensqualitaet.Id = "641edcc0-9914-40a2-875b-ce8d722c7750"
obj6umweltbelastunglebensqualitaet.Name = _DTX("a#\0026\a\\4Y=\\4bnY\002\021[#4\\=\\\021n_\002b42Yb\\Y")
obj6umweltbelastunglebensqualitaet.Description = ""
obj6umweltbelastunglebensqualitaet.AltText = ""
obj6umweltbelastunglebensqualitaet.Resources = {
  {
    Type = "jpg",
    Filename = "6-umweltbelastung-lebensqualitaet.jpg",
    Directives = {}
  }
}
objProtokollblatt = Wherigo.ZMedia(objKlausdenktnach)
objProtokollblatt.Id = "88c56c4e-b1b0-4769-8aa3-3ca9ca3f9d28"
objProtokollblatt.Name = _DTX("\tG\025Y\025!\02544=4bYY")
objProtokollblatt.Description = ""
objProtokollblatt.AltText = ""
objProtokollblatt.Resources = {
  {
    Type = "jpg",
    Filename = "protokollblatt.jpg",
    Directives = {}
  }
}
objicoprotokollblatt = Wherigo.ZMedia(objKlausdenktnach)
objicoprotokollblatt.Id = "2fde939b-a2aa-4fdb-b5b4-a1f3ceade206"
objicoprotokollblatt.Name = _DTX("2\024\025#vG\025Y\025!\02544=4bYY")
objicoprotokollblatt.Description = ""
objicoprotokollblatt.AltText = ""
objicoprotokollblatt.Resources = {
  {
    Type = "jpg",
    Filename = "ico-protokollblatt.jpg",
    Directives = {}
  }
}
objicovester = Wherigo.ZMedia(objKlausdenktnach)
objicovester.Id = "db2a5d9f-05e2-43e6-b287-d1450c6193a6"
objicovester.Name = _DTX("2\024\025#S\\nY\\G")
objicovester.Description = ""
objicovester.AltText = ""
objicovester.Resources = {
  {
    Type = "jpg",
    Filename = "ico-vester.jpg",
    Directives = {}
  }
}
objVer = Wherigo.ZMedia(objKlausdenktnach)
objVer.Id = "02bdf39c-0f48-469d-b723-821fce59f646"
objVer.Name = _DTX("\b\\G")
objVer.Description = ""
objVer.AltText = ""
objVer.Resources = {
  {
    Type = "jpg",
    Filename = "kfver_ak.jpg",
    Directives = {}
  }
}
objBev = Wherigo.ZMedia(objKlausdenktnach)
objBev.Id = "724a42cc-32dd-446b-90a5-42b3139345d6"
objBev.Name = _DTX(".\\S")
objBev.Description = ""
objBev.AltText = ""
objBev.Resources = {
  {
    Type = "jpg",
    Filename = "Kfbev_ak.jpg",
    Directives = {}
  }
}
objPol = Wherigo.ZMedia(objKlausdenktnach)
objPol.Id = "5619388a-6545-46aa-9af4-688d8d720158"
objPol.Name = _DTX("\t\0254")
objPol.Description = ""
objPol.AltText = ""
objPol.Resources = {
  {
    Type = "jpg",
    Filename = "Kfpol_ak.jpg",
    Directives = {}
  }
}
objLeb = Wherigo.ZMedia(objKlausdenktnach)
objLeb.Id = "90557fcc-d7b5-4afc-956e-11b01b1b6869"
objLeb.Name = _DTX("\006\\=")
objLeb.Description = ""
objLeb.AltText = ""
objLeb.Resources = {
  {
    Type = "jpg",
    Filename = "Kfleb_ak.jpg",
    Directives = {}
  }
}
objPro = Wherigo.ZMedia(objKlausdenktnach)
objPro.Id = "3d7bf8cc-2f9b-4ddd-9aae-90f60a7efd09"
objPro.Name = _DTX("\tG\025")
objPro.Description = ""
objPro.AltText = ""
objPro.Resources = {
  {
    Type = "jpg",
    Filename = "Kfpro_ak.jpg",
    Directives = {}
  }
}
objSan = Wherigo.ZMedia(objKlausdenktnach)
objSan.Id = "ba5e20f6-d297-4ca3-b36a-1ba9a2446cb7"
objSan.Name = _DTX("Ob\021")
objSan.Description = ""
objSan.AltText = ""
objSan.Resources = {
  {
    Type = "jpg",
    Filename = "Kfsan_ak.jpg",
    Directives = {}
  }
}
objUmw = Wherigo.ZMedia(objKlausdenktnach)
objUmw.Id = "73fc9045-d6dd-427e-85bd-ca513289ba66"
objUmw.Name = _DTX("\0176\a")
objUmw.Description = ""
objUmw.AltText = ""
objUmw.Resources = {
  {
    Type = "jpg",
    Filename = "Kfumw_ak.jpg",
    Directives = {}
  }
}
objAufkl = Wherigo.ZMedia(objKlausdenktnach)
objAufkl.Id = "94f0a45a-55c8-4baf-b46b-0c7120a6cb80"
objAufkl.Name = _DTX("+\002E!4")
objAufkl.Description = ""
objAufkl.AltText = ""
objAufkl.Resources = {
  {
    Type = "jpg",
    Filename = "Kfauf_ak.jpg",
    Directives = {}
  }
}
objicowordmap = Wherigo.ZMedia(objKlausdenktnach)
objicowordmap.Id = "ecd2b4b0-e987-4052-9d46-a6ac219557e4"
objicowordmap.Name = _DTX("2\024\025#\a\025Gr6bv")
objicowordmap.Description = ""
objicowordmap.AltText = ""
objicowordmap.Resources = {
  {
    Type = "jpg",
    Filename = "ico-wordmap.jpg",
    Directives = {}
  }
}
objWirkungsgefuege = Wherigo.ZMedia(objKlausdenktnach)
objWirkungsgefuege.Id = "aa43c3f4-67bf-4747-9937-40c4e3a9635e"
objWirkungsgefuege.Name = _DTX("k2G!\002\021[n[\\E\002\\[\\")
objWirkungsgefuege.Description = ""
objWirkungsgefuege.AltText = ""
objWirkungsgefuege.Resources = {
  {
    Type = "jpg",
    Filename = "wirkungsgefuege.jpg",
    Directives = {}
  }
}
objicowirkungsgefuege = Wherigo.ZMedia(objKlausdenktnach)
objicowirkungsgefuege.Id = "aded02e1-cbf8-41e9-b504-f1b14da519de"
objicowirkungsgefuege.Name = _DTX("2\024\025#\a2G!\002\021[n[\\E\002\\[\\")
objicowirkungsgefuege.Description = ""
objicowirkungsgefuege.AltText = ""
objicowirkungsgefuege.Resources = {
  {
    Type = "jpg",
    Filename = "ico-wirkungsgefuege.jpg",
    Directives = {}
  }
}
obj1 = Wherigo.ZMedia(objKlausdenktnach)
obj1.Id = "4a40f26a-4205-432a-b91a-b6c7ed9c53f2"
obj1.Name = _DTX("\005")
obj1.Description = ""
obj1.AltText = ""
obj1.Resources = {
  {
    Type = "jpg",
    Filename = "t01.jpg",
    Directives = {}
  }
}
obj12 = Wherigo.ZMedia(objKlausdenktnach)
obj12.Id = "d8d241a0-aa64-4a4e-89df-35c30e50319f"
obj12.Name = _DTX("\005$")
obj12.Description = ""
obj12.AltText = ""
obj12.Resources = {
  {
    Type = "jpg",
    Filename = "t12.jpg",
    Directives = {}
  }
}
obj11 = Wherigo.ZMedia(objKlausdenktnach)
obj11.Id = "580028ab-591c-4273-954b-7f9f12242a90"
obj11.Name = _DTX("\005\005")
obj11.Description = ""
obj11.AltText = ""
obj11.Resources = {
  {
    Type = "jpg",
    Filename = "t11.jpg",
    Directives = {}
  }
}
obj10 = Wherigo.ZMedia(objKlausdenktnach)
obj10.Id = "1e2b05b9-ce52-4d1d-8c47-1aeef425f15b"
obj10.Name = _DTX("\005<")
obj10.Description = ""
obj10.AltText = ""
obj10.Resources = {
  {
    Type = "jpg",
    Filename = "t10.jpg",
    Directives = {}
  }
}
obj2 = Wherigo.ZMedia(objKlausdenktnach)
obj2.Id = "c9ddb530-a878-499b-81d0-b1ec77d533b0"
obj2.Name = _DTX("$")
obj2.Description = ""
obj2.AltText = ""
obj2.Resources = {
  {
    Type = "jpg",
    Filename = "t02.jpg",
    Directives = {}
  }
}
obj9 = Wherigo.ZMedia(objKlausdenktnach)
obj9.Id = "460f8171-9bac-4de9-a283-720cc3174ddb"
obj9.Name = _DTX("5")
obj9.Description = ""
obj9.AltText = ""
obj9.Resources = {
  {
    Type = "jpg",
    Filename = "t09.jpg",
    Directives = {}
  }
}
obj3 = Wherigo.ZMedia(objKlausdenktnach)
obj3.Id = "671bbbb6-d64e-408f-a68a-9023f4fc7f49"
obj3.Name = _DTX("m")
obj3.Description = ""
obj3.AltText = ""
obj3.Resources = {
  {
    Type = "jpg",
    Filename = "t03.jpg",
    Directives = {}
  }
}
obj5 = Wherigo.ZMedia(objKlausdenktnach)
obj5.Id = "e2f7cc49-8822-4ec1-8e44-5a63793d33e8"
obj5.Name = _DTX(";")
obj5.Description = ""
obj5.AltText = ""
obj5.Resources = {
  {
    Type = "jpg",
    Filename = "t05.jpg",
    Directives = {}
  }
}
obj4 = Wherigo.ZMedia(objKlausdenktnach)
obj4.Id = "fd3b76ea-8e4b-40a1-8a85-bad844669c08"
obj4.Name = _DTX("\f")
obj4.Description = ""
obj4.AltText = ""
obj4.Resources = {
  {
    Type = "jpg",
    Filename = "t04.jpg",
    Directives = {}
  }
}
obj8 = Wherigo.ZMedia(objKlausdenktnach)
obj8.Id = "e640a93a-bc50-4fa2-b473-46dcb53321e3"
obj8.Name = _DTX("&")
obj8.Description = ""
obj8.AltText = ""
obj8.Resources = {
  {
    Type = "jpg",
    Filename = "t08.jpg",
    Directives = {}
  }
}
obj6 = Wherigo.ZMedia(objKlausdenktnach)
obj6.Id = "6426262d-0652-4ccd-bd36-b48e596523f7"
obj6.Name = _DTX("a")
obj6.Description = ""
obj6.AltText = ""
obj6.Resources = {
  {
    Type = "jpg",
    Filename = "t06.jpg",
    Directives = {}
  }
}
obj7 = Wherigo.ZMedia(objKlausdenktnach)
obj7.Id = "6e0daa59-d35d-4342-8c50-6fd747a55919"
obj7.Name = _DTX("K")
obj7.Description = ""
obj7.AltText = ""
obj7.Resources = {
  {
    Type = "jpg",
    Filename = "t07.jpg",
    Directives = {}
  }
}
objFilmdose = Wherigo.ZMedia(objKlausdenktnach)
objFilmdose.Id = "d287cfb8-bf35-4f15-8d0e-eaba9a37eb63"
objFilmdose.Name = _DTX(",246r\025n\\")
objFilmdose.Description = ""
objFilmdose.AltText = ""
objFilmdose.Resources = {
  {
    Type = "jpg",
    Filename = "filmdose.jpg",
    Directives = {}
  }
}
objicofilmdose = Wherigo.ZMedia(objKlausdenktnach)
objicofilmdose.Id = "53892ccf-6f43-42a0-b190-6dff9672551a"
objicofilmdose.Name = _DTX("2\024\025#E246r\025n\\")
objicofilmdose.Description = ""
objicofilmdose.AltText = ""
objicofilmdose.Resources = {
  {
    Type = "jpg",
    Filename = "ico-filmdose.jpg",
    Directives = {}
  }
}
objLogbuch = Wherigo.ZMedia(objKlausdenktnach)
objLogbuch.Id = "8bd1c8a7-3e6a-4efc-a7f3-b3eafd674b17"
objLogbuch.Name = _DTX("\006\025[=\002\024q")
objLogbuch.Description = ""
objLogbuch.AltText = ""
objLogbuch.Resources = {
  {
    Type = "jpg",
    Filename = "Notizbuch.jpg",
    Directives = {}
  }
}
objiconotizbuch = Wherigo.ZMedia(objKlausdenktnach)
objiconotizbuch.Id = "8d0542a3-1f55-4308-9379-33ebb6e397af"
objiconotizbuch.Name = _DTX("2\024\025#\021\025Y2\127=\002\024q")
objiconotizbuch.Description = ""
objiconotizbuch.AltText = ""
objiconotizbuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Notizbuch.jpg",
    Directives = {}
  }
}
objKoordinaten = Wherigo.ZMedia(objKlausdenktnach)
objKoordinaten.Id = "1c964076-b5f5-4efa-920e-670f2324567b"
objKoordinaten.Name = _DTX("p\025\025Gr2\021bY\\\021")
objKoordinaten.Description = ""
objKoordinaten.AltText = ""
objKoordinaten.Resources = {
  {
    Type = "jpg",
    Filename = "koordinaten.jpg",
    Directives = {}
  }
}
objicokoordinaten = Wherigo.ZMedia(objKlausdenktnach)
objicokoordinaten.Id = "63a74ddb-d302-429b-b2c3-18179a030483"
objicokoordinaten.Name = _DTX("2\024\025#!\025\025Gr2\021bY\\\021")
objicokoordinaten.Description = ""
objicokoordinaten.AltText = ""
objicokoordinaten.Resources = {
  {
    Type = "jpg",
    Filename = "ico-koordinaten.jpg",
    Directives = {}
  }
}
objSpoiler = Wherigo.ZMedia(objKlausdenktnach)
objSpoiler.Id = "2c28fef6-3f42-401b-8d92-2b0879dba593"
objSpoiler.Name = _DTX("Ov\02524\\G")
objSpoiler.Description = ""
objSpoiler.AltText = ""
objSpoiler.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler.jpg",
    Directives = {}
  }
}
objicospoiler = Wherigo.ZMedia(objKlausdenktnach)
objicospoiler.Id = "ddeab8b6-cd08-4ed0-9309-f6fb89fb73ae"
objicospoiler.Name = _DTX("2\024\025#nv\02524\\G")
objicospoiler.Description = ""
objicospoiler.AltText = ""
objicospoiler.Resources = {
  {
    Type = "jpg",
    Filename = "ico-spoiler.jpg",
    Directives = {}
  }
}
objGeocoinDetail = Wherigo.ZMedia(objKlausdenktnach)
objGeocoinDetail.Id = "68aaf2ac-daaf-4aad-91e4-d2476b0dfc55"
objGeocoinDetail.Name = _DTX("~\\\025\024\0252\021#t\\Yb24")
objGeocoinDetail.Description = ""
objGeocoinDetail.AltText = ""
objGeocoinDetail.Resources = {
  {
    Type = "jpg",
    Filename = "geocoin.jpg",
    Directives = {}
  }
}
objGeocoin = Wherigo.ZMedia(objKlausdenktnach)
objGeocoin.Id = "55ab9ce1-b571-4bd6-821c-3c471487b758"
objGeocoin.Name = _DTX("~\\\025\024\0252\021")
objGeocoin.Description = ""
objGeocoin.AltText = ""
objGeocoin.Resources = {
  {
    Type = "jpg",
    Filename = "geocoin-detail.jpg",
    Directives = {}
  }
}
objicogeocoin = Wherigo.ZMedia(objKlausdenktnach)
objicogeocoin.Id = "b303e3e5-e9d3-4074-bad0-4555d8360bd7"
objicogeocoin.Name = _DTX("2\024\025#[\\\025\024\0252\021")
objicogeocoin.Description = ""
objicogeocoin.AltText = ""
objicogeocoin.Resources = {
  {
    Type = "jpg",
    Filename = "ico-geocoin-detail.jpg",
    Directives = {}
  }
}
objParkbank = Wherigo.ZMedia(objKlausdenktnach)
objParkbank.Id = "989c7c40-a829-4c09-8f7a-efd6e96c8680"
objParkbank.Name = _DTX("\tbG!=b\021!")
objParkbank.Description = ""
objParkbank.AltText = ""
objParkbank.Resources = {
  {
    Type = "jpg",
    Filename = "parkbank.jpg",
    Directives = {}
  }
}
objicoparkbank = Wherigo.ZMedia(objKlausdenktnach)
objicoparkbank.Id = "ed76db7d-3355-4328-89d9-05b5540c0bf2"
objicoparkbank.Name = _DTX("2\024\025#vbG!=b\021!")
objicoparkbank.Description = ""
objicoparkbank.AltText = ""
objicoparkbank.Resources = {
  {
    Type = "jpg",
    Filename = "ico-parkbank.jpg",
    Directives = {}
  }
}
objRegieren = Wherigo.ZMedia(objKlausdenktnach)
objRegieren.Id = "b317ecbd-3611-447b-b71e-29eb857feb30"
objRegieren.Name = _DTX("f\\[2\\G\\\021")
objRegieren.Description = ""
objRegieren.AltText = ""
objRegieren.Resources = {
  {
    Type = "jpg",
    Filename = "regieren.jpg",
    Directives = {}
  }
}
objicoregieren = Wherigo.ZMedia(objKlausdenktnach)
objicoregieren.Id = "7afccb15-bffd-46bd-8b32-b3bc156e9263"
objicoregieren.Name = _DTX("2\024\025#G\\[2\\G\\\021")
objicoregieren.Description = ""
objicoregieren.AltText = ""
objicoregieren.Resources = {
  {
    Type = "jpg",
    Filename = "ico-regieren.jpg",
    Directives = {}
  }
}
objStaatsstreich = Wherigo.ZMedia(objKlausdenktnach)
objStaatsstreich.Id = "ad0bafb4-8587-4b9c-b843-d4eeb42de7a0"
objStaatsstreich.Name = _DTX("OYbbYnnYG\\2\024q")
objStaatsstreich.Description = ""
objStaatsstreich.AltText = ""
objStaatsstreich.Resources = {
  {
    Type = "jpg",
    Filename = "staatsstreich.jpg",
    Directives = {}
  }
}
objParadies = Wherigo.ZMedia(objKlausdenktnach)
objParadies.Id = "061f7a2d-1560-455c-b6d6-b4b5c9089ead"
objParadies.Name = _DTX("\tbGbr2\\n")
objParadies.Description = ""
objParadies.AltText = ""
objParadies.Resources = {
  {
    Type = "jpg",
    Filename = "paradies.jpg",
    Directives = {}
  }
}
objBilanz = Wherigo.ZMedia(objKlausdenktnach)
objBilanz.Id = "058b2aab-9ad6-4e83-8fc4-d7e4e952d586"
objBilanz.Name = _DTX(".24b\021\127")
objBilanz.Description = ""
objBilanz.AltText = ""
objBilanz.Resources = {
  {
    Type = "jpg",
    Filename = "bilanz.jpg",
    Directives = {}
  }
}
objicounlockcode = Wherigo.ZMedia(objKlausdenktnach)
objicounlockcode.Id = "0eb1c726-af12-4937-a51a-22bc91c3cd53"
objicounlockcode.Name = _DTX("2\024\025#\002\0214\025\024!\024\025r\\")
objicounlockcode.Description = ""
objicounlockcode.AltText = ""
objicounlockcode.Resources = {
  {
    Type = "jpg",
    Filename = "ico-grundbuch.jpg",
    Directives = {}
  }
}
objUnlockcode = Wherigo.ZMedia(objKlausdenktnach)
objUnlockcode.Id = "d1827040-9791-4191-bb60-76d44bf7c9f4"
objUnlockcode.Name = _DTX("\017\0214\025\024!\024\025r\\")
objUnlockcode.Description = ""
objUnlockcode.AltText = ""
objUnlockcode.Resources = {
  {
    Type = "jpg",
    Filename = "grundbuch.jpg",
    Directives = {}
  }
}
objcache = Wherigo.ZMedia(objKlausdenktnach)
objcache.Id = "fd30d122-1f9e-4ee2-b6f4-a6ecd0602997"
objcache.Name = _DTX("\024b\024q\\")
objcache.Description = ""
objcache.AltText = ""
objcache.Resources = {
  {
    Type = "jpg",
    Filename = "cache.jpg",
    Directives = {}
  }
}
objicocache = Wherigo.ZMedia(objKlausdenktnach)
objicocache.Id = "a8bc5b9c-25e3-4780-a4d3-bc5daa7e33c5"
objicocache.Name = _DTX("2\024\025#\024b\024q\\")
objicocache.Description = ""
objicocache.AltText = ""
objicocache.Resources = {
  {
    Type = "jpg",
    Filename = "ico-cache.jpg",
    Directives = {}
  }
}
objicotabelle18 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle18.Id = "6bc5ea2d-e50d-427a-bb06-95d60670bc50"
objicotabelle18.Name = _DTX("2\024\025#Yb=\\44\\#\005&")
objicotabelle18.Description = ""
objicotabelle18.AltText = ""
objicotabelle18.Resources = {
  {
    Type = "jpg",
    Filename = "ico-18-lebensqualitaet-aktionspunkte.jpg",
    Directives = {}
  }
}
objicotabelle14 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle14.Id = "3a819fb0-a654-49a1-9ed7-d02c4a6c4d82"
objicotabelle14.Name = _DTX("2\024\025#Yb=\\44\\#\005\f")
objicotabelle14.Description = ""
objicotabelle14.AltText = ""
objicotabelle14.Resources = {
  {
    Type = "jpg",
    Filename = "ico-14-vermehrungsrate-bevoelkerung.jpg",
    Directives = {}
  }
}
objicotabelle13 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle13.Id = "8cb28f3d-a2ad-4ec8-9d74-6f6c7258f2e8"
objicotabelle13.Name = _DTX("2\024\025#Yb=\\44\\#\005m")
objicotabelle13.Description = ""
objicotabelle13.AltText = ""
objicotabelle13.Resources = {
  {
    Type = "jpg",
    Filename = "ico-13-bevoelkerung-lebensqualitaet.jpg",
    Directives = {}
  }
}
objicotabelle15 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle15.Id = "a0137f86-6468-46c2-9520-4f6ef6951e52"
objicotabelle15.Name = _DTX("2\024\025#Yb=\\44\\#\005;")
objicotabelle15.Description = ""
objicotabelle15.AltText = ""
objicotabelle15.Resources = {
  {
    Type = "jpg",
    Filename = "ico-15-bevoelkerung-aktionspunkte.jpg",
    Directives = {}
  }
}
objicotabelle16 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle16.Id = "82b51703-44a4-4ebe-8753-19e685ad1277"
objicotabelle16.Name = _DTX("2\024\025#Yb=\\44\\#\005a")
objicotabelle16.Description = ""
objicotabelle16.AltText = ""
objicotabelle16.Resources = {
  {
    Type = "jpg",
    Filename = "ico-16-politik-aktionspunkte.jpg",
    Directives = {}
  }
}
objicotabelle17 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle17.Id = "f2dff3ec-556d-478c-9100-7d0986b65248"
objicotabelle17.Name = _DTX("2\024\025#Yb=\\44\\#\005K")
objicotabelle17.Description = ""
objicotabelle17.AltText = ""
objicotabelle17.Resources = {
  {
    Type = "jpg",
    Filename = "ico-17-produktion-aktionspunkte.jpg",
    Directives = {}
  }
}
objicotabelle12 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle12.Id = "c0d47ff9-6d93-4c6d-9db1-de492f9679c6"
objicotabelle12.Name = _DTX("2\024\025#Yb=\\44\\#\005$")
objicotabelle12.Description = ""
objicotabelle12.AltText = ""
objicotabelle12.Resources = {
  {
    Type = "jpg",
    Filename = "ico-12-lebensqualitaet-politik.jpg",
    Directives = {}
  }
}
objicotabelle3 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle3.Id = "acb2480d-ca0d-4954-95d4-b483dc276272"
objicotabelle3.Name = _DTX("2\024\025#Yb=\\44\\#m")
objicotabelle3.Description = ""
objicotabelle3.AltText = ""
objicotabelle3.Resources = {
  {
    Type = "jpg",
    Filename = "ico-3-produktion-produktion.jpg",
    Directives = {}
  }
}
objicotabelle2 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle2.Id = "00ebda9c-76fb-474b-a13d-851018a581dc"
objicotabelle2.Name = _DTX("2\024\025#Yb=\\44\\#$")
objicotabelle2.Description = ""
objicotabelle2.AltText = ""
objicotabelle2.Resources = {
  {
    Type = "jpg",
    Filename = "ico-2-sanierung-sanierung.jpg",
    Directives = {}
  }
}
objicotabelle4 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle4.Id = "345a11df-b148-44e3-885f-399f433c86b9"
objicotabelle4.Name = _DTX("2\024\025#Yb=\\44\\#\f")
objicotabelle4.Description = ""
objicotabelle4.AltText = ""
objicotabelle4.Resources = {
  {
    Type = "jpg",
    Filename = "ico-4-produktion-umweltbelastung.jpg",
    Directives = {}
  }
}
objicotabelle11 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle11.Id = "fde72cfd-f622-4a60-9070-b66ec082b4f0"
objicotabelle11.Name = _DTX("2\024\025#Yb=\\44\\#\005\005")
objicotabelle11.Description = ""
objicotabelle11.AltText = ""
objicotabelle11.Resources = {
  {
    Type = "jpg",
    Filename = "ico-11-lebensqualitaet-vermehrungsrate.jpg",
    Directives = {}
  }
}
objicotabelle5 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle5.Id = "60d74656-80a8-4649-bb7b-0d00c8c1578b"
objicotabelle5.Name = _DTX("2\024\025#Yb=\\44\\#;")
objicotabelle5.Description = ""
objicotabelle5.AltText = ""
objicotabelle5.Resources = {
  {
    Type = "jpg",
    Filename = "ico-5-umweltbelastung-umweltbelastung.jpg",
    Directives = {}
  }
}
objicotabelle6 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle6.Id = "6177b063-95c0-4d79-9739-3e8ebbe9128d"
objicotabelle6.Name = _DTX("2\024\025#Yb=\\44\\#a")
objicotabelle6.Description = ""
objicotabelle6.AltText = ""
objicotabelle6.Resources = {
  {
    Type = "jpg",
    Filename = "ico-6-umweltbelastung-lebensqualitaet.jpg",
    Directives = {}
  }
}
objicotabelle7 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle7.Id = "9ebb7b9c-32a2-495b-9b7b-6bf5ce805bb3"
objicotabelle7.Name = _DTX("2\024\025#Yb=\\44\\#K")
objicotabelle7.Description = ""
objicotabelle7.AltText = ""
objicotabelle7.Resources = {
  {
    Type = "jpg",
    Filename = "ico-7-aufklaerung-aufklaerung.jpg",
    Directives = {}
  }
}
objicotabelle10 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle10.Id = "ca04e536-8a69-46cd-9ffe-924c53977d4a"
objicotabelle10.Name = _DTX("2\024\025#Yb=\\44\\#\005<")
objicotabelle10.Description = ""
objicotabelle10.AltText = ""
objicotabelle10.Resources = {
  {
    Type = "jpg",
    Filename = "ico-10-lebensqualitaet-lebensqualitaet.jpg",
    Directives = {}
  }
}
objicotabelle8 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle8.Id = "52585bbb-550c-4d86-b419-749d6d258b90"
objicotabelle8.Name = _DTX("2\024\025#Yb=\\44\\#&")
objicotabelle8.Description = ""
objicotabelle8.AltText = ""
objicotabelle8.Resources = {
  {
    Type = "jpg",
    Filename = "ico-8-aufklaerung-lebensqualitaet.jpg",
    Directives = {}
  }
}
objicotabelle9 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle9.Id = "6022564a-1f42-465b-aa37-898fc084aed3"
objicotabelle9.Name = _DTX("2\024\025#Yb=\\44\\#5")
objicotabelle9.Description = ""
objicotabelle9.AltText = ""
objicotabelle9.Resources = {
  {
    Type = "jpg",
    Filename = "ico-9-aufklaerung-vermehrungsrate.jpg",
    Directives = {}
  }
}
objicotabelle1 = Wherigo.ZMedia(objKlausdenktnach)
objicotabelle1.Id = "85e0d41f-4f4f-4e95-815b-e2b412f668c5"
objicotabelle1.Name = _DTX("2\024\025#Yb=\\44\\#\005")
objicotabelle1.Description = ""
objicotabelle1.AltText = ""
objicotabelle1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-1-sanierung-umweltbelastung.jpg",
    Directives = {}
  }
}
objwirkunglinear = Wherigo.ZMedia(objKlausdenktnach)
objwirkunglinear.Id = "06671774-31ad-4eb1-8988-8ed02463fb09"
objwirkunglinear.Name = _DTX("\a2G!\002\021[#42\021\\bG")
objwirkunglinear.Description = ""
objwirkunglinear.AltText = ""
objwirkunglinear.Resources = {
  {
    Type = "jpg",
    Filename = "wirkung-linearebeziehung.jpg",
    Directives = {}
  }
}
objwirkungnichtlinear = Wherigo.ZMedia(objKlausdenktnach)
objwirkungnichtlinear.Id = "f25fa0ee-3eff-4620-a538-21cbd6c635ea"
objwirkungnichtlinear.Name = _DTX("\a2G!\002\021[#\0212\024qY42\021\\bG")
objwirkungnichtlinear.Description = ""
objwirkungnichtlinear.AltText = ""
objwirkungnichtlinear.Resources = {
  {
    Type = "jpg",
    Filename = "wirkung-nichtlinearebeziehung.jpg",
    Directives = {}
  }
}
objwirkunghoehererordnung = Wherigo.ZMedia(objKlausdenktnach)
objwirkunghoehererordnung.Id = "b6514651-2666-4e35-b29b-20505b64a9b1"
objwirkunghoehererordnung.Name = _DTX("\a2G!\002\021[#q\025\\q\\G\\G\025Gr\021\002\021[")
objwirkunghoehererordnung.Description = ""
objwirkunghoehererordnung.AltText = ""
objwirkunghoehererordnung.Resources = {
  {
    Type = "jpg",
    Filename = "wirkung-hoehereordnung.jpg",
    Directives = {}
  }
}
objwirkunggrenz = Wherigo.ZMedia(objKlausdenktnach)
objwirkunggrenz.Id = "1f2d44b4-3da3-4436-818e-e679903b528a"
objwirkunggrenz.Name = _DTX("\a2G!\002\021[#[G\\\021\127")
objwirkunggrenz.Description = ""
objwirkunggrenz.AltText = ""
objwirkunggrenz.Resources = {
  {
    Type = "jpg",
    Filename = "wirkung-grenzschwelle.jpg",
    Directives = {}
  }
}
objwirkungposrueck = Wherigo.ZMedia(objKlausdenktnach)
objwirkungposrueck.Id = "7522d67e-9719-4cf4-ba19-635e03c0b048"
objwirkungposrueck.Name = _DTX("\a2G!\002\021[#v\025n#G\002\\\024!")
objwirkungposrueck.Description = ""
objwirkungposrueck.AltText = ""
objwirkungposrueck.Resources = {
  {
    Type = "jpg",
    Filename = "wirkung-pos-rueckjpg.jpg",
    Directives = {}
  }
}
objwirkungzeit = Wherigo.ZMedia(objKlausdenktnach)
objwirkungzeit.Id = "6229bdf8-0905-4d9f-a3d1-84bef6bfddb6"
objwirkungzeit.Name = _DTX("\a2G!\002\021[#\127\\2Y")
objwirkungzeit.Description = ""
objwirkungzeit.AltText = ""
objwirkungzeit.Resources = {
  {
    Type = "jpg",
    Filename = "wirkung-zeit.jpg",
    Directives = {}
  }
}
objaudiostaatsstreich = Wherigo.ZMedia(objKlausdenktnach)
objaudiostaatsstreich.Id = "26566328-cfee-424e-ace9-054eb7e86c63"
objaudiostaatsstreich.Name = _DTX("b\002r2\025#nYbbYnnYG\\2\024q")
objaudiostaatsstreich.Description = ""
objaudiostaatsstreich.AltText = ""
objaudiostaatsstreich.Resources = {
  {
    Type = "mp3",
    Filename = "staatsstreich.mp3",
    Directives = {}
  }
}
objaudioparadies = Wherigo.ZMedia(objKlausdenktnach)
objaudioparadies.Id = "8b048da7-a219-4920-aacf-b547f8b06705"
objaudioparadies.Name = _DTX("b\002r2\025#vbGbr2\\n")
objaudioparadies.Description = ""
objaudioparadies.AltText = ""
objaudioparadies.Resources = {
  {
    Type = "mp3",
    Filename = "PARADIES.mp3",
    Directives = {}
  }
}
objaudiodieserweg = Wherigo.ZMedia(objKlausdenktnach)
objaudiodieserweg.Id = "1fca0263-aad5-4775-8477-34527a2f8e1f"
objaudiodieserweg.Name = _DTX("b\002r2\025#r2\\n\\G\a\\[")
objaudiodieserweg.Description = ""
objaudiodieserweg.AltText = ""
objaudiodieserweg.Resources = {
  {
    Type = "mp3",
    Filename = "DieserWeg.mp3",
    Directives = {}
  }
}
objaudiotusch = Wherigo.ZMedia(objKlausdenktnach)
objaudiotusch.Id = "52fcfcdd-94d1-45dc-a14e-2aaa6cbc5bb5"
objaudiotusch.Name = _DTX("b\002r2\025#Y\002n\024q")
objaudiotusch.Description = ""
objaudiotusch.AltText = ""
objaudiotusch.Resources = {
  {
    Type = "mp3",
    Filename = "tusch.mp3",
    Directives = {}
  }
}
objaudioportal = Wherigo.ZMedia(objKlausdenktnach)
objaudioportal.Id = "fc45e9f5-ae07-4cc5-b5d9-b2bd62c82536"
objaudioportal.Name = _DTX("b\002r2\025#v\025GYb4")
objaudioportal.Description = ""
objaudioportal.AltText = ""
objaudioportal.Resources = {
  {
    Type = "mp3",
    Filename = "portal.mp3",
    Directives = {}
  }
}
objicoKlaus = Wherigo.ZMedia(objKlausdenktnach)
objicoKlaus.Id = "47d56ad1-4ca7-4303-bdcd-5b276e4c0206"
objicoKlaus.Name = _DTX("2\024\025#p4b\002n")
objicoKlaus.Description = ""
objicoKlaus.AltText = ""
objicoKlaus.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Klaus.jpg",
    Directives = {}
  }
}
objaudiofinal = Wherigo.ZMedia(objKlausdenktnach)
objaudiofinal.Id = "4a47e1a8-0eaf-40ed-9974-d689d451333e"
objaudiofinal.Name = _DTX("b\002r2\025#E2\021b4")
objaudiofinal.Description = ""
objaudiofinal.AltText = ""
objaudiofinal.Resources = {
  {
    Type = "mp3",
    Filename = "final.mp3",
    Directives = {}
  }
}
objfinal = Wherigo.ZMedia(objKlausdenktnach)
objfinal.Id = "29f39244-f4bd-437a-9a6a-660aefb8fdc1"
objfinal.Name = _DTX("E2\021b4")
objfinal.Description = ""
objfinal.AltText = ""
objfinal.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler-unten.jpg",
    Directives = {}
  }
}
objicofinal = Wherigo.ZMedia(objKlausdenktnach)
objicofinal.Id = "56c389dd-c9da-4ce9-b75f-307181288fd5"
objicofinal.Name = _DTX("2\024\025#E2\021b4")
objicofinal.Description = ""
objicofinal.AltText = ""
objicofinal.Resources = {
  {
    Type = "jpg",
    Filename = "ico-spoiler-unten.jpg",
    Directives = {}
  }
}
objspoileroben = Wherigo.ZMedia(objKlausdenktnach)
objspoileroben.Id = "d78582e8-340f-42dc-a9d2-cdb76b7660ce"
objspoileroben.Name = _DTX("nv\02524\\G#\025=\\\021")
objspoileroben.Description = ""
objspoileroben.AltText = ""
objspoileroben.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler-oben.jpg",
    Directives = {}
  }
}
objWirkungsnetzqplan = Wherigo.ZMedia(objKlausdenktnach)
objWirkungsnetzqplan.Id = "d9f304e3-1e42-4b50-8d06-2127996c57cf"
objWirkungsnetzqplan.Name = _DTX("k2G!\002\021[n\021\\Y\127_#v4b\021")
objWirkungsnetzqplan.Description = ""
objWirkungsnetzqplan.AltText = ""
objWirkungsnetzqplan.Resources = {
  {
    Type = "jpg",
    Filename = "wirkungsgefuege-plan.jpg",
    Directives = {}
  }
}
objKlausdenktnach.Id = "d2df4b59-f958-45c1-9c0c-7b2def5c4d61"
objKlausdenktnach.Name = "Klaus denkt nach"
objKlausdenktnach.Description = [[
Fridays for future? Klimawandel? Plastikmuell? Oelpest? Waldsterben? Ueberfischung? Glyphosat? CO2? Massentierhaltung? Atommuell? BSE? Schweinepest? Vogelgrippe? Rezession? Globalisierung? Bevoelkerungsexplosion? Hungersnoete? Entmietung? Wanderungsbewegungen? Fluechtlingsstroeme? ...<BR>
Die Schlagzeilen sind voll! Doch was steckt dahinter? Warum haben wir diese Entwicklungen? Das kann doch alles nicht so schwer sein! Oder doch? Warum gibt es fuer komplexe Probleme keine einfachen Loesungen?<BR>
Klaus faengt an zu denken - aber Denken ist die schwierigste Arbeit die es gibt, sagte schon Henry Ford. <BR>
<BR>
Also hilf ihm doch dabei!]]
objKlausdenktnach.Visible = true
objKlausdenktnach.Activity = "Geocache"
objKlausdenktnach.StartingLocationDescription = ""
objKlausdenktnach.StartingLocation = Wherigo.INVALID_ZONEPOINT
objKlausdenktnach.Version = "1.4"
objKlausdenktnach.Company = ""
objKlausdenktnach.Author = ""
objKlausdenktnach.BuilderVersion = "URWIGO 1.22.5798.37755"
objKlausdenktnach.CreateDate = "06/27/2019 20:25:10"
objKlausdenktnach.PublishDate = "1/1/0001 12:00:00 AM"
objKlausdenktnach.UpdateDate = "12/15/2019 15:55:50"
objKlausdenktnach.LastPlayedDate = "1/1/0001 12:00:00 AM"
objKlausdenktnach.TargetDevice = "PocketPC"
objKlausdenktnach.TargetDeviceVersion = "0"
objKlausdenktnach.StateId = "1"
objKlausdenktnach.CountryId = "2"
objKlausdenktnach.Complete = false
objKlausdenktnach.UseLogging = true
objKlausdenktnach.Media = objWordmap
objKlausdenktnach.Icon = objicowordmap
zCache = Wherigo.Zone(objKlausdenktnach)
zCache.Id = "78f68681-fd69-4450-bfff-e78b0a6970b1"
zCache.Name = _DTX("8b\024q\\")
zCache.Description = _DTX("\v\021r42\024q\018b6\01832\\4u")
zCache.Visible = false
zCache.Media = objfinal
zCache.Icon = objicofinal
zCache.Commands = {}
zCache.DistanceRange = Distance(-1, "feet")
zCache.ShowObjects = "OnEnter"
zCache.ProximityRange = Distance(60, "meters")
zCache.AllowSetPositionTo = false
zCache.Active = false
zCache.Points = {
  ZonePoint(52.4741659925029, 13.1162602483872, 0),
  ZonePoint(52.4740833569583, 13.1160923132123, 0),
  ZonePoint(52.4739308772269, 13.1162502652143, 0),
  ZonePoint(52.4740030797885, 13.1164363508003, 0)
}
zCache.OriginalPoint = ZonePoint(52.4740458266192, 13.1162597944035, 0)
zCache.DistanceRangeUOM = "Feet"
zCache.ProximityRangeUOM = "Meters"
zCache.OutOfRangeName = ""
zCache.InRangeName = ""
zPortal = Wherigo.Zone(objKlausdenktnach)
zPortal.Id = "3b508757-1e58-40c7-a6c7-3454c367e73c"
zPortal.Name = _DTX("OYbGY")
zPortal.Description = _DTX("t\\G\0183\002[b\021[\018\127\002\018\\2\021\\G\018EG\\6r\\\021\018k\\4Yu")
zPortal.Visible = true
zPortal.Media = objPortal
zPortal.Icon = objicoPortal
zPortal.Commands = {}
zPortal.DistanceRange = Distance(-1, "feet")
zPortal.ShowObjects = "OnEnter"
zPortal.ProximityRange = Distance(60, "meters")
zPortal.AllowSetPositionTo = false
zPortal.Active = true
zPortal.Points = {
  ZonePoint(52.4779084049263, 13.1325769994566, 0),
  ZonePoint(52.4779092259875, 13.1329616316536, 0),
  ZonePoint(52.4776711193054, 13.1329711052262, 0),
  ZonePoint(52.4776647943154, 13.1325873841148, 0)
}
zPortal.OriginalPoint = ZonePoint(52.4777883861337, 13.1327742801128, 0)
zPortal.DistanceRangeUOM = "Feet"
zPortal.ProximityRangeUOM = "Meters"
zPortal.OutOfRangeName = ""
zPortal.InRangeName = ""
zAufklaerung = Wherigo.Zone(objKlausdenktnach)
zAufklaerung.Id = "379cfdf3-d0d5-4442-bad7-f8e7119ee62a"
zAufklaerung.Name = _DTX("+\002E!4b\\G\002\021[")
zAufklaerung.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018\0026EbnnY\018\a\\2Y\0186\\qG\018b4n\018k2nn\\\021\018\002\021r\018.24r\002\021[\018r\002G\024q\018O\024q\0024\\\021u\018+\002\024q\018r\\G\018b44[\\6\\2\021\\\018\vG!\\\021\021Y\0212nnYb\021r\018=\127[4u\018[\\n\002\021r\\G\018\006\\=\\\021n\a\\2n\\(\018\0176\a\\4Y=\\\a\002nnYn\\2\021\018\002\021r\018\\2\021\018\\G\a\\2Y\\G\\G\018{\025G2\127\025\021Y\018(\018B\0254\\Gb\021\127\018\\Y\024u\018[\\q\025\\GY\018rb\127\002u\018t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018<\018N\017\021\a2nn\\\021\018\002\021r\018U\021Y\0254\\Gb\021\127\001\018\002\\=\\G\018t\\n2\021Y\\G\\nn\\(\0186b\\nn2[\\G\018U\021E\025G6bY2\025\021nnYb\021r(\018\\G\a\\2Y\\GY\\G\018U\021E\025G6bY2\025\021nnYb\021r\018\002\021r\018\a\\2Y[\\q\\\021r\\\018\v2\021n2\024qY\0182\021\0183\002nb66\\\021qb\\\021[\\\018q2\021\018\127\002\018m<\018N!L=\\G\021\\Y2n\024q\\n\018t\\\021!\\\021\018\002\021r\018{b\021r\\4\021\001u")
zAufklaerung.Visible = false
zAufklaerung.Media = objAufkl
zAufklaerung.Icon = objicoIAuf1
zAufklaerung.Commands = {}
zAufklaerung.DistanceRange = Distance(-1, "feet")
zAufklaerung.ShowObjects = "Always"
zAufklaerung.ProximityRange = Distance(60, "meters")
zAufklaerung.AllowSetPositionTo = false
zAufklaerung.Active = false
zAufklaerung.Points = {
  ZonePoint(52.4776361385276, 13.132597120239, 0),
  ZonePoint(52.4774134324016, 13.1325808692203, 0),
  ZonePoint(52.4774332285474, 13.1330277722357, 0),
  ZonePoint(52.4776460365515, 13.1329952701983, 0)
}
zAufklaerung.OriginalPoint = ZonePoint(52.477532209007, 13.1328002579733, 0)
zAufklaerung.DistanceRangeUOM = "Feet"
zAufklaerung.ProximityRangeUOM = "Meters"
zAufklaerung.OutOfRangeName = ""
zAufklaerung.InRangeName = ""
zLebensqualitaet = Wherigo.Zone(objKlausdenktnach)
zLebensqualitaet.Id = "ed0672b5-2aa7-4942-a2ec-57bb4ae79faf"
zLebensqualitaet.Name = _DTX("\006\\=\\\021n_\002b42Yb\\Y")
zLebensqualitaet.Description = _DTX("t2\\n\\G\018O\024q4\002\\nn\\4=\\G\\2\024q\018=\\YG\\2EEY\018~\\n\002\021rq\\2Y(\018k\025q4=\\E2\021r\\\021\018\002\021r\018O2\024q\\Gq\\2Y\018r\\G\018.\\S\025\\4!\\G\002\021[\018\002\021r\018n\024q42\\nnY\018rb62Y\018n2\021\021S\02544\\\018+G=\\2Y(\018\006\\=\\\021nnYb\021rbGr\018\\=\\\021n\025\018\\2\021\018\a2\\\018k\025q\021_\002b42Yb\\Y\018\002\021r\018,G\\2\127\\2Y[\\nYb4Y\002\021[u\018tb62Y\0182nY\018r2\\n\\G\018.\\G\\2\024q\018r\\G\018\\2[\\\021Y42\024q\\\018U\021r2!bY\025G\018E\002\\G\018r\\\021\0183\002nYb\021r\018r\\n\018\006b\021r\\nu\018t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018<\018N3\002nnb6\021\\=G\002\024q(\018{\002\021[\\G\018\002\021r\018\030\025Y\001\018\002\\=\\G\01862n\\Gb=\\4(\01862YY\\46b\\nn2[(\018n\\qG\018r\002\\GEY2[(\018[\002Y(\018n\\qG\018[\002Y\018=2n\018q2\021\018\127\002\018m<\018Nq\025\\\024qnY\\n\018k\025q4=\\E2\021r\\\021\001u")
zLebensqualitaet.Visible = false
zLebensqualitaet.Media = objLeb
zLebensqualitaet.Icon = objicoILeb1
zLebensqualitaet.Commands = {}
zLebensqualitaet.DistanceRange = Distance(-1, "feet")
zLebensqualitaet.ShowObjects = "OnEnter"
zLebensqualitaet.ProximityRange = Distance(60, "meters")
zLebensqualitaet.AllowSetPositionTo = false
zLebensqualitaet.Active = false
zLebensqualitaet.Points = {
  ZonePoint(52.4776559345731, 13.13310090182, 0),
  ZonePoint(52.477457973717, 13.1331090273294, 0),
  ZonePoint(52.4774530246842, 13.1334340477043, 0),
  ZonePoint(52.4776806796175, 13.1334259221949, 0)
}
zLebensqualitaet.OriginalPoint = ZonePoint(52.477561903148, 13.1332674747622, 0)
zLebensqualitaet.DistanceRangeUOM = "Feet"
zLebensqualitaet.ProximityRangeUOM = "Meters"
zLebensqualitaet.OutOfRangeName = ""
zLebensqualitaet.InRangeName = ""
zPolitik = Wherigo.Zone(objKlausdenktnach)
zPolitik.Id = "715b9864-8f13-4d3b-8358-a87bdd686510"
zPolitik.Name = _DTX("\t\02542Y2!")
zPolitik.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018\0026EbnnY\018r2\\\018,b\\q2[!\\2Y\\\021\018\002\021r\018g\025\\[42\024q!\\2Y\\\021\018r\\G\018f\\[2\\G\002\021[u\018\vG\018nv2\\[\\4Y\018+\002Y\025G2Yb\\Y\018\002\021r\018\v\021Yn\024q\\2r\002\021[n[\\\ab4Y\018\a2r\\G\018\002\021r\018nY\\qY\018\002\021r\018Eb\\44Y\01862Y\018r\\G\018k\\2Yn2\024qY(\0182qG\\G\018.\\42\\=Yq\\2Y\018\002\021r\018r\\G\018\v2\021n2\024qY2[!\\2Y\0182qG\\G\018\tG\025[Gb66\\u\018t2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018#\005\005\018NOYbbYnnYG\\2\024q\001\018=2n\018ymK\018N\tbGbr2\\n\001\018\002\\=\\G\018r2\\\0183\a2n\024q\\\021nY\002E\\\021\018rG\025q\\\021r\\G\018OYbbYnnYG\\2\024q(\018\v6v\025\\G\002\021[\018\002\021r\018+\002EnYb\021r(\018\030\00244\018\b\\GYGb\002\\\021(\018\ab\024!\\42[(\018=4\\2Y=\018b6\018f\002r\\G(\018G\\[2\\GY\01862Y\018g\\qGq\\2Y(\018=\\[\\2nY\\GY\\\018k2\\r\\G\abq4u")
zPolitik.Visible = false
zPolitik.Media = objPol
zPolitik.Icon = objicoIPol1
zPolitik.Commands = {}
zPolitik.DistanceRange = Distance(-1, "feet")
zPolitik.ShowObjects = "OnEnter"
zPolitik.ProximityRange = Distance(60, "meters")
zPolitik.AllowSetPositionTo = false
zPolitik.Active = false
zPolitik.Points = {
  ZonePoint(52.4776905776314, 13.1330846508013, 0),
  ZonePoint(52.4777153226563, 13.1334015456668, 0),
  ZonePoint(52.4779231803162, 13.1334015456668, 0),
  ZonePoint(52.4779380272543, 13.1330765252919, 0)
}
zPolitik.OriginalPoint = ZonePoint(52.4778167769645, 13.1332410668567, 0)
zPolitik.DistanceRangeUOM = "Feet"
zPolitik.ProximityRangeUOM = "Meters"
zPolitik.OutOfRangeName = ""
zPolitik.InRangeName = ""
zProduktion = Wherigo.Zone(objKlausdenktnach)
zProduktion.Id = "48b503f1-1a72-44f6-b07a-cd1acb660a24"
zProduktion.Name = _DTX("\tG\025r\002!Y2\025\021")
zProduktion.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018nv2\\[\\4Y\018\0212\024qY\018\021\002G\018rbn\018kb\024qnY\0026\018S\025\021\018U\021r\002nYG2\\\018\002\021r\018{b\021r\a\\G!\018\a2r\\G(\018n\025\021r\\G\021\018b\002\024q\018r2\\\0184b\021r\a2GYn\024qbEY42\024q\\\018\tG\025r\002!Y2\025\021\018\002\021r\018r\\\021\018\0176nbY\127\018S\025\021\018{b\021r\\4\018\002\021r\018t2\\\021nY4\\2nY\002\021[\\\021u\026.fJt2\\n\\\021\018.\\G\\2\024q\018!b\021\021\0186b\021\018b4n\018\v2\021\1272[\\\021\018b\002\024q\018\127\002G\002\\\024!rG\\q\\\021u\026.fJt2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018<\018Nk2GYn\024qbEY\01842\\[Y\018rbG\0212\\r\\G\001\018\002\\=\\G\018r2\\\0183\a2n\024q\\\021\a\\GY\\\018\021\025Yr\002\\GEY2[(\018[\\G2\021[(\018b\002nG\\2\024q\\\021r(\018q\025\024q\004nYbG!\\G\018\vlv\025GY(\018\\lYG\\6\018q\025\024q\004+=nbY\127vG\025=4\\6\\\018=2n\018\127\002\018m<N\017\\=\\G!bvb\1272Yb\\Y\004p\025\021n\0026Y\\GG\025G\001u")
zProduktion.Visible = false
zProduktion.Media = objPro
zProduktion.Icon = objicoIProd1
zProduktion.Commands = {}
zProduktion.DistanceRange = Distance(-1, "feet")
zProduktion.ShowObjects = "OnEnter"
zProduktion.ProximityRange = Distance(60, "meters")
zProduktion.AllowSetPositionTo = false
zProduktion.Active = false
zProduktion.Points = {
  ZonePoint(52.4774282795117, 13.132507739636, 0),
  ZonePoint(52.4776608835831, 13.1324914886172, 0),
  ZonePoint(52.4776658325926, 13.1321258406955, 0),
  ZonePoint(52.4774480756508, 13.1321177151862, 0)
}
zProduktion.OriginalPoint = ZonePoint(52.4775507678345, 13.1323106960337, 0)
zProduktion.DistanceRangeUOM = "Feet"
zProduktion.ProximityRangeUOM = "Meters"
zProduktion.OutOfRangeName = ""
zProduktion.InRangeName = ""
zSanierung = Wherigo.Zone(objKlausdenktnach)
zSanierung.Id = "9cd93eda-ce28-463b-8429-bb90455221fd"
zSanierung.Name = _DTX("Ob\0212\\G\002\021[")
zSanierung.Description = _DTX("{2\\G\018[\\qY\018\\n\018\0026\018\021b\024qqb4Y2[\\n\018k2GYn\024qbEY\\\021(\018ruqu\018\0176\a\\4Yn\024q\002Y\127(\018nb\021EY\\\018\v\021\\G[2\\\021\\\018\002\021r\018f\\\024L\02442\021[u\018\vn\018[\\qY\018\a\\\0212[\\G\018\0026\018O\024qb\\r\\\021\018\127\002\018G\\vbG2\\G\\\021(\018n\025\021r\\G\021\018\0026\018\v2\021E\002\\qG\002\021[\018\0026\a\\4YEG\\\002\021r42\024q\\G\018\b\\GEbqG\\\021u\018t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018<\018N\b\\G[\\\ab4Y2[\002\021[\018r\\n\018\006\\=\\\021nGb\0026\\n\001\018\002\\=\\G\018S2\\4\018fb\002==b\002(\018\021\002G\018\021\025Yr\002\\GEY2[\\\018O\024q\002Y\1276b?\021bq6\\\021(\018[\\G2\021[(\0186b\\?2[(\018\\GnY\\\0182\021\021\025SbY2S\\\018k\\[\\(\018Y2\\E[\\q\\\021r\\\018\vG\021\\\002\\G\002\021[\018\127\002\018m<\018N2\021Yb!Y\\G\018\006\\=\\\021nGb\0026\001u")
zSanierung.Visible = false
zSanierung.Media = objSan
zSanierung.Icon = objicoISan1
zSanierung.Commands = {}
zSanierung.DistanceRange = Distance(-1, "feet")
zSanierung.ShowObjects = "OnEnter"
zSanierung.ProximityRange = Distance(60, "meters")
zSanierung.AllowSetPositionTo = false
zSanierung.Active = false
zSanierung.Points = {
  ZonePoint(52.477705424648, 13.1324589865798, 0),
  ZonePoint(52.4779479252103, 13.1324346100516, 0),
  ZonePoint(52.4779528741874, 13.1321502172236, 0),
  ZonePoint(52.4776955266375, 13.1321258406956, 0)
}
zSanierung.OriginalPoint = ZonePoint(52.4778254376708, 13.1322924136377, 0)
zSanierung.DistanceRangeUOM = "Feet"
zSanierung.ProximityRangeUOM = "Meters"
zSanierung.OutOfRangeName = ""
zSanierung.InRangeName = ""
zUmweltbelastung = Wherigo.Zone(objKlausdenktnach)
zUmweltbelastung.Id = "b672c8cb-72ff-458f-a24c-3baed939ec17"
zUmweltbelastung.Name = _DTX("\0176\a\\4Y=\\4bnY\002\021[")
zUmweltbelastung.Description = _DTX("{2\\G\018nYG\025\\6\\\021\018b44\\\018\002\021=\\rb\024qY\\\021\018,\0254[\\\021\018r\\G\018U\021r\002nYG2b42n2\\G\002\021[\018\127\002nb66\\\021D\018+=[bn\\(\018\006b\\G6(\018fb\002==b\002(\018\b\\G!\\qGn\024qb\025n(\018OYb\\rY\\\127\\GEb44\018\\Y\024u\018#\01862Y\018b44\\\021\0184b\021[EG2nY2[\\\021\018+\002n\a2G!\002\021[\\\021u\018.\\4bnY\002\021[\018q\\2nnY\018b=\\G\018b\002\024q\018E\\q4\\\021r\\\018O\\4=nYG\\[\0024bY2\025\021\018\002\021r\018\127\\GnY\025\\GY\\n\018~4\\2\024q[\\\a2\024qYu\018t2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018<\018N2\021Yb!Y\\\018\016!\025nLnY\\6\\\001\018\002=\\G\01862\02126b4(\018[\\G2\021[(\018nY\025\\G\\\021r(\018=\\r\\\021!42\024q(\018b4bG62\\G\\\021r(\0182GG\\S\\Gn2=\\4\018q2\021\018\127\002\018m<\018N!\\2\021\\\018f\\[\0024bY2\025\021\001u")
zUmweltbelastung.Visible = false
zUmweltbelastung.Media = objUmw
zUmweltbelastung.Icon = objicoIUmw1
zUmweltbelastung.Commands = {}
zUmweltbelastung.DistanceRange = Distance(-1, "feet")
zUmweltbelastung.ShowObjects = "OnEnter"
zUmweltbelastung.ProximityRange = Distance(60, "meters")
zUmweltbelastung.AllowSetPositionTo = false
zUmweltbelastung.Active = false
zUmweltbelastung.Points = {
  ZonePoint(52.4780073128993, 13.132442735561, 0),
  ZonePoint(52.4782696075672, 13.132442735561, 0),
  ZonePoint(52.4782597096836, 13.1320445856018, 0),
  ZonePoint(52.4780221598091, 13.1320770876393, 0)
}
zUmweltbelastung.OriginalPoint = ZonePoint(52.4781396974898, 13.1322517860908, 0)
zUmweltbelastung.DistanceRangeUOM = "Feet"
zUmweltbelastung.ProximityRangeUOM = "Meters"
zUmweltbelastung.OutOfRangeName = ""
zUmweltbelastung.InRangeName = ""
zBevoelkerung = Wherigo.Zone(objKlausdenktnach)
zBevoelkerung.Id = "81f5cd11-cb94-463e-9da8-1cc83bf2b58a"
zBevoelkerung.Name = _DTX(".\\S\025\\4!\\G\002\021[")
zBevoelkerung.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018nv2\\[\\4Y\018r2\\\018b!Y\002\\44\\\018.\\S\025\\4!\\G\002\021[n\127bq4(\0182qG\\\0183\002nb66\\\021n\\Y\127\002\021[\018\002\021r\018+\021nvG\002\\\024q\\\018\a2r\\Gu\018t2\\\018+\002n\a2G!\002\021[\018n\024q\ab\021!Y\0182\021\018+=qb\\\021[2[!\\2Y\018r\\G\018\002\\=G2[\\\021\018.\\G\\2\024q\\u\018t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018<\018Nb\002n[\\nY\025G=\\\021\001\018\002\\=\\G\01862\02126b4\\\018.\\n2\\r4\002\021[(\018[\\G2\021[\\\018t2\024qY\\(\018[\\\021\002\\[\\\021r\018\t4bY\127\018E\002\\G\018b44\\(\01862YY4\\G\\\018t2\024qY\\(\018q\025q\\\018t2\024qY\\\018\002\021r\018\127\002\018q\025q\\\018t2\024qY\018q2\021\018\127\002\018\f&\018NrG\025q\\\021r\\G\0183\002nb66\\\021=G\002\024q\001u")
zBevoelkerung.Visible = false
zBevoelkerung.Media = objBev
zBevoelkerung.Icon = objicoIBev1
zBevoelkerung.Commands = {}
zBevoelkerung.DistanceRange = Distance(-1, "feet")
zBevoelkerung.ShowObjects = "OnEnter"
zBevoelkerung.ProximityRange = Distance(60, "meters")
zBevoelkerung.AllowSetPositionTo = false
zBevoelkerung.Active = false
zBevoelkerung.Points = {
  ZonePoint(52.4780023639283, 13.1325889947296, 0),
  ZonePoint(52.4780023639283, 13.1329546426513, 0),
  ZonePoint(52.4782844543884, 13.132946517142, 0),
  ZonePoint(52.4782795054486, 13.1325483671828, 0)
}
zBevoelkerung.OriginalPoint = ZonePoint(52.4781421719234, 13.1327596304264, 0)
zBevoelkerung.DistanceRangeUOM = "Feet"
zBevoelkerung.ProximityRangeUOM = "Meters"
zBevoelkerung.OutOfRangeName = ""
zBevoelkerung.InRangeName = ""
zVermehrungsrate = Wherigo.Zone(objKlausdenktnach)
zVermehrungsrate.Id = "de318a18-44cd-40ed-9f8c-a3a13d68c8b7"
zVermehrungsrate.Name = _DTX("\b\\G6\\qG\002\021[nGbY\\")
zVermehrungsrate.Description = _DTX("{2\\G\018[\\qY\018\\n\018\0026\018r2\\\018\t\025v\0024bY2\025\021nrL\021b62!D\018b4n\025\018\0026\0183\002#\018\002\021r\018+=\ab\021r\\G\002\021[\018\002\021r\018\0026\018r2\\\018\b\\Gb\\\021r\\G\002\021[\018r\\G\018~\\=\002GY\\\021#\018\002\021r\018OY\\G=\\GbY\\u\018\026.fJ\v2\021\018r2G\\!Y\\G\018\v2\021[G2EE\018r\002G\024q\018r2\\\018f\\[2\\G\002\021[\0182nY\018\0212\024qY\0186\025\\[42\024q(\018\a\\\021\021[4\\2\024q\01862Y\018p2\021r\\G=\\2q24E\\\021(\018OY\\\002\\G\\G6b\\nn2[\002\021[\\\021\018\002\021r\018b\021r\\G\\\021\018\t\025G[Gb66\\\021\018r\\G\018\v2\021rG\002\024!\018q\\GS\025G[\\G\002E\\\021\018\a2Gru\018\b2\\4\018\\q\\G\018n2\021r\018\\n\018\006\\=\\\021n_\002b42Yb\\Y\018\002\021r\018+\002E!4b\\G\002\021[\018r\\n\018\v2\021\127\\4\021\\\021u\026.fJt2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018<\018N+\002nnY\\G=\\\021\001\018=2n\018m<\018N\vlv4\025n2\025\021\001\01862Y\018r\\\021\0183\a2n\024q\\\021\a\\GY\\\021\018\002\\=\\Gb4Y\\GY(\0184\\2\024qY\018G\002\\\024!4b\\\002E2[(\018\030\00244\ab\024qnY\0026(\0186b\\nn2[\\n\018kb\024qnY\0026\018\002\021r\018nYbG!\\n\018kb\024qnY\0026")
zVermehrungsrate.Visible = false
zVermehrungsrate.Media = objVer
zVermehrungsrate.Icon = objicoIVerm1
zVermehrungsrate.Commands = {}
zVermehrungsrate.DistanceRange = Distance(-1, "feet")
zVermehrungsrate.ShowObjects = "OnEnter"
zVermehrungsrate.ProximityRange = Distance(55, "meters")
zVermehrungsrate.AllowSetPositionTo = false
zVermehrungsrate.Active = false
zVermehrungsrate.Points = {
  ZonePoint(52.4779974149567, 13.1330602742732, 0),
  ZonePoint(52.4780023639283, 13.1333934201574, 0),
  ZonePoint(52.4782795054486, 13.1334096711761, 0),
  ZonePoint(52.4782993012046, 13.1330440232544, 0)
}
zVermehrungsrate.OriginalPoint = ZonePoint(52.4781446463846, 13.1332268472153, 0)
zVermehrungsrate.DistanceRangeUOM = "Feet"
zVermehrungsrate.ProximityRangeUOM = "Meters"
zVermehrungsrate.OutOfRangeName = ""
zVermehrungsrate.InRangeName = ""
objvorfinal = Wherigo.Zone(objKlausdenktnach)
objvorfinal.Id = "892ef34c-4cff-4056-a129-da4073def21c"
objvorfinal.Name = _DTX("S\025GE2\021b4")
objvorfinal.Description = ""
objvorfinal.Visible = false
objvorfinal.Commands = {}
objvorfinal.DistanceRange = Distance(-1, "feet")
objvorfinal.ShowObjects = "OnEnter"
objvorfinal.ProximityRange = Distance(60, "meters")
objvorfinal.AllowSetPositionTo = false
objvorfinal.Active = false
objvorfinal.Points = {
  ZonePoint(52.4739936656376, 13.115871231814, 0),
  ZonePoint(52.4743084655977, 13.1165243260213, 0),
  ZonePoint(52.474558579029, 13.1161738852271, 0),
  ZonePoint(52.4744227417384, 13.1155473395649, 0)
}
objvorfinal.OriginalPoint = ZonePoint(52.4743208630007, 13.1160291956568, 0)
objvorfinal.DistanceRangeUOM = "Feet"
objvorfinal.ProximityRangeUOM = "Meters"
objvorfinal.OutOfRangeName = ""
objvorfinal.InRangeName = ""
objFredericVester = Wherigo.ZCharacter({Cartridge = objKlausdenktnach, Container = zPortal})
objFredericVester.Id = "1cb0425c-d5f9-4252-9f99-d2910900310e"
objFredericVester.Name = _DTX(",G\\r\\G2\024\018\b\\nY\\G")
objFredericVester.Description = _DTX(",G\\r\\G2\024\018\b\\nY\\G\018N@\018$mu\018\030\025S\\6=\\G\018\0055$;\0182\021\018ObbG=G\002\\\024!\\\0219\018y\018$u\018\030\025S\\6=\\G\018$<<m\0182\021\018g\002\\\021\024q\\\021\001\018\abG\018\\2\021\018r\\\002Yn\024q\\G\018.2\025\024q\\62!\\G(\018OLnY\\6E\025Gn\024q\\G(\018\0176\a\\4Y\\lv\\GY\\(\018\017\0212S\\Gn2Yb\\YnvG\025E\\nn\025G\018\002\021r\018v\025v\0024b\\G\a2nn\\\021n\024qbEY42\024q\\G\018+\002Y\025Gu\026.fJ\017\021Y\\G\018.\\G\002E\002\021[\018b\002E\018r2\\\018pL=\\G\021\\Y2!\018N=\127\au\018.2\025!L=\\G\021\\Y2!\001\018qbY\018\b\\nY\\G\018nLnY\\62n\024q\\n(\018S\\G\021\\Y\127Y\\n\018t\\\021!\\\021\018vG\025vb[2\\GY(\018\\2\021\018+\021nbY\127(\0182\021\018r\\6\018r2\\\018\v2[\\\021n\024qbEY\\\021\018\\2\021\\n\018OLnY\\6n\018b4n\018\\2\021\018S\\G\021\\Y\127Y\\n\018k2G!\002\021[n[\\E\002\\[\\\018[\\n\\q\\\021\018\a\\Gr\\\021u\018")
objFredericVester.Visible = false
objFredericVester.Media = objVester
objFredericVester.Icon = objicovester
objFredericVester.Commands = {
  cmdBescheid = Wherigo.ZCommand({
    Text = _DTX(".\\n\024q\\2r0"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdInvestieren = Wherigo.ZCommand({
    Text = _DTX("U\021S\\nY2\\G\\\0210"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdWiestehtes = Wherigo.ZCommand({
    Text = _DTX("k2\\\018nY\\qY\018\\n-"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdBilanz = Wherigo.ZCommand({
    Text = _DTX(".24b\021\127-"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdHilfe = Wherigo.ZCommand({
    Text = _DTX("{24E\\0"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\030\025Yq2\021[\018bSb24b=4\\")
  }),
  cmdAnleitung = Wherigo.ZCommand({
    Text = _DTX("+\0214\\2Y\002\021["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\030\025Yq2\021[\018bSb24b=4\\")
  })
}
objFredericVester.Commands.cmdBescheid.Custom = true
objFredericVester.Commands.cmdBescheid.Id = "de00d699-0924-48aa-9eaf-c9ae6a623b31"
objFredericVester.Commands.cmdBescheid.WorksWithAll = true
objFredericVester.Commands.cmdInvestieren.Custom = true
objFredericVester.Commands.cmdInvestieren.Id = "38895742-8813-4bf0-a6f4-6fba45a20b7a"
objFredericVester.Commands.cmdInvestieren.WorksWithAll = true
objFredericVester.Commands.cmdWiestehtes.Custom = true
objFredericVester.Commands.cmdWiestehtes.Id = "286dc96d-22bf-4058-a989-700604f1aea9"
objFredericVester.Commands.cmdWiestehtes.WorksWithAll = true
objFredericVester.Commands.cmdBilanz.Custom = true
objFredericVester.Commands.cmdBilanz.Id = "b1e801d2-8090-49ee-b682-38a9eebed6f6"
objFredericVester.Commands.cmdBilanz.WorksWithAll = true
objFredericVester.Commands.cmdHilfe.Custom = true
objFredericVester.Commands.cmdHilfe.Id = "518f0769-d396-4b07-bd8c-881ce55118ff"
objFredericVester.Commands.cmdHilfe.WorksWithAll = true
objFredericVester.Commands.cmdAnleitung.Custom = true
objFredericVester.Commands.cmdAnleitung.Id = "529a4519-bbf7-4157-a53f-c0e0115ae663"
objFredericVester.Commands.cmdAnleitung.WorksWithAll = true
objFredericVester.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFredericVester.Gender = "Male"
objFredericVester.Type = "NPC"
objKlausMastermindKlabuster = Wherigo.ZCharacter({Cartridge = objKlausdenktnach, Container = zPortal})
objKlausMastermindKlabuster.Id = "0d276452-8c23-44de-84b0-c24ac4a06f02"
objKlausMastermindKlabuster.Name = _DTX("p4b\002n\018xgbnY\\G62\021rx\018p4b=\002nY\\G")
objKlausMastermindKlabuster.Description = _DTX("p4b\002n(\018\\2\021\01842\\=\\\021n\a\\GY\\G\018\030\\Gr\018b\002n\018p4br\025\a(\0184\\2\024qY\018\024qb\025Y2n\024q\018\002\021r\018266\\G\018b\002E\018r\\G\018O\002\024q\\\018\021b\024q\018r\\6\018~4\002\024!u")
objKlausMastermindKlabuster.Visible = true
objKlausMastermindKlabuster.Media = objKlaus
objKlausMastermindKlabuster.Icon = objicoKlaus
objKlausMastermindKlabuster.Commands = {
  cmdmachmalwas = Wherigo.ZCommand({
    Text = _DTX("6b\024q\0186b4\018\abn"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objKlausMastermindKlabuster.Commands.cmdmachmalwas.Custom = true
objKlausMastermindKlabuster.Commands.cmdmachmalwas.Id = "87786ae4-8b1b-40f1-9c32-a2e5fd5f9db2"
objKlausMastermindKlabuster.Commands.cmdmachmalwas.WorksWithAll = true
objKlausMastermindKlabuster.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKlausMastermindKlabuster.Gender = "Male"
objKlausMastermindKlabuster.Type = "NPC"
objVernetztesDenken = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zPortal})
objVernetztesDenken.Id = "d4666cc2-a614-44bd-b14d-4c137111463b"
objVernetztesDenken.Name = _DTX("\b\\G\021\\Y\127Y\\n\018t\\\021!\\\021")
objVernetztesDenken.Description = _DTX("Bbn\024q\\\021=\002\024qD\018$&\f\018O\\2Y\\\021\026.fJ\b\\G4b[D\018{\\L\021\\9\018+\002E4b[\\D\018Bbn\024q\\\021=\002\024qb\002n[b=\\(\018$u\018+\002E4b[\\(\018N\030\025S\\6=\\G\018$<<\005\001\026.fJUO.\030#\005mD\0185K&#m\f;m<\f<$<;\018")
objVernetztesDenken.Visible = false
objVernetztesDenken.Media = objBuch
objVernetztesDenken.Icon = objicoBuch
objVernetztesDenken.Commands = {
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdmitnehmen = Wherigo.ZCommand({
    Text = _DTX("62Y\021\\q6\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  vLF = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objVernetztesDenken.Commands.cmdlesen.Custom = true
objVernetztesDenken.Commands.cmdlesen.Id = "060c7b7a-6789-4eb5-a62e-c29005ebef10"
objVernetztesDenken.Commands.cmdlesen.WorksWithAll = true
objVernetztesDenken.Commands.cmdmitnehmen.Custom = true
objVernetztesDenken.Commands.cmdmitnehmen.Id = "3fdcf9c4-77b4-45b1-b2a4-4b37c7370da2"
objVernetztesDenken.Commands.cmdmitnehmen.WorksWithAll = true
objVernetztesDenken.Commands.vLF.Custom = true
objVernetztesDenken.Commands.vLF.Id = "46543ef5-56eb-44e8-8595-925e8ac737ee"
objVernetztesDenken.Commands.vLF.WorksWithAll = true
objVernetztesDenken.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objVernetztesDenken.Locked = false
objVernetztesDenken.Opened = false
objProtokollblatt1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objProtokollblatt1.Id = "81731d3a-04f2-45c8-8c95-b6fd77674ed4"
objProtokollblatt1.Name = _DTX("\tG\025Y\025!\02544=4bYY")
objProtokollblatt1.Description = _DTX("g2Y\018r2\\n\\6\018\tG\025Y\025!\02544=4bYY\018!b\021\021nY\018t\002\018f\002\021r\\\018E\002\\G\018f\002\021r\\\018t\\2\021\\\018\v\021Yn\024q\\2r\002\021[\\\021\004U\021S\\nY2Y2\025\021\\\021\018\002\021r\018r2\\\018p\025\021n\\_\002\\\021\127\\\021\004\vG[\\=\0212nn\\\018G\\!bv2Y\00242\\G\\\021u")
objProtokollblatt1.Visible = false
objProtokollblatt1.Media = objProtokollblatt
objProtokollblatt1.Icon = objicoprotokollblatt
objProtokollblatt1.Commands = {}
objProtokollblatt1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objProtokollblatt1.Locked = false
objProtokollblatt1.Opened = false
objWirkungsgefuege1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objWirkungsgefuege1.Id = "67af973f-c203-47db-b21f-b139e8d82fca"
objWirkungsgefuege1.Name = _DTX("k2G!\002\021[n[\\E\002\\[\\")
objWirkungsgefuege1.Description = _DTX("tbn\018k2G!\002\021[n[\\E\002\\[\\\018r\\n\018U\021r\002nYG2\\4b\021r\\n\018=\\nY\\qY\018b\002n\018\005\f\018,\002\021!Y2\025\021\\\021\018E\002\\G\018r2\\\018OY\\\002\\G\002\021[\018r\\G\018\\2\021\127\\4\021\\\021\018.\\G\\2\024q\\\018n\025\a2\\\018b\002n\018\f\018,\002\021!Y2\025\021\\\021(\018r2\\\018r2\\\018\b\\G[b=\\\018r\\G\018+!Y2\025\021nv\002\021!Y\\\018=\\n\024qG\\2=\\\021u")
objWirkungsgefuege1.Visible = false
objWirkungsgefuege1.Media = objWirkungsgefuege
objWirkungsgefuege1.Icon = objicowirkungsgefuege
objWirkungsgefuege1.Commands = {
  cmdanzeigen = Wherigo.ZCommand({
    Text = _DTX("b\021\127\\2[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objWirkungsgefuege1.Commands.cmdanzeigen.Custom = true
objWirkungsgefuege1.Commands.cmdanzeigen.Id = "232d1e3f-f0ec-4de8-9915-f1e07bbffbd1"
objWirkungsgefuege1.Commands.cmdanzeigen.WorksWithAll = true
objWirkungsgefuege1.Commands.cmdablegen.Custom = true
objWirkungsgefuege1.Commands.cmdablegen.Id = "afb023f9-66ee-4e71-9fcc-dceb59f5376f"
objWirkungsgefuege1.Commands.cmdablegen.WorksWithAll = true
objWirkungsgefuege1.Commands.cmdaufnehmen.Custom = true
objWirkungsgefuege1.Commands.cmdaufnehmen.Id = "864eabb9-c14e-4ce1-a8df-b5fae6783c8c"
objWirkungsgefuege1.Commands.cmdaufnehmen.WorksWithAll = true
objWirkungsgefuege1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objWirkungsgefuege1.Locked = false
objWirkungsgefuege1.Opened = false
objTabelleLebensqualitaetAktionspunkte = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleLebensqualitaetAktionspunkte.Id = "b11de57e-5426-4399-b5cf-bebedcdc3397"
objTabelleLebensqualitaetAktionspunkte.Name = _DTX("Bb=\\44\\\018\006\\=\\\021n_\002b42Yb\\Y\018#\018+!Y2\025\021nv\002\021!Y\\")
objTabelleLebensqualitaetAktionspunkte.Description = _DTX(".\\2\018\0212\\rG2[\\G\018\006\\=\\\021n_\002b42YbY\\Y\018S\\GG2\021[\\G\021\018n2\024q\018r2\\\018+!Y2\025\021nv\002\021!Y\\u\018\vGnY\018b=\018\\2\021\\6\018g2\02126\0026\0182nY\018r2\\\018.\\S\025\\4!\\G\002\021[\018\127\002\018\\\021YnvG\\\024q\\\021r\\\021\018\006\\2nY\002\021[\\\021\018=\\G\\2Yu")
objTabelleLebensqualitaetAktionspunkte.Visible = false
objTabelleLebensqualitaetAktionspunkte.Media = obj18lebensqualitateaktionspunkte
objTabelleLebensqualitaetAktionspunkte.Icon = objicotabelle18
objTabelleLebensqualitaetAktionspunkte.Commands = {}
objTabelleLebensqualitaetAktionspunkte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleLebensqualitaetAktionspunkte.Locked = false
objTabelleLebensqualitaetAktionspunkte.Opened = false
objTabelleSanierungSanierung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleSanierungSanierung.Id = "644eaeb6-6b3c-4c10-a3d4-004b91db5047"
objTabelleSanierungSanierung.Name = _DTX("Bb=\\44\\\018Ob\0212\\G\002\021[\018#\018Ob\0212\\G\002\021[")
objTabelleSanierungSanierung.Description = _DTX("t2\\\018\021\\[bY2S\\\018f\002\\\024!!\025vv4\002\021[\018n\02544\018S\025G\018r\\6\018UGG[4b\002=\\\021\018=\\\abqG\\\021(\018rbnn\018\\2\021\\\018q\025q\\\018Ob\0212\\G\002\021[n_\002\025Y\\\018\\2\021\018,G\\2=G2\\E\018E\002\\G\018\\2\021\\\018nYb\\\021r2[\\\018\0176\a\\4Y=\\4bnY\002\021[\018n\\2u")
objTabelleSanierungSanierung.Visible = false
objTabelleSanierungSanierung.Media = obj2sanierungsanierung
objTabelleSanierungSanierung.Icon = objicotabelle2
objTabelleSanierungSanierung.Commands = {}
objTabelleSanierungSanierung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleSanierungSanierung.Locked = false
objTabelleSanierungSanierung.Opened = false
objTabelleSanierungUmweltbelastung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleSanierungUmweltbelastung.Id = "6d8a98a0-3466-4ced-9c0a-9cb53a314131"
objTabelleSanierungUmweltbelastung.Name = _DTX("Bb=\\44\\\018Ob\0212\\G\002\021[\018#\018\0176\a\\4Y=\\4bnY\002\021[")
objTabelleSanierungUmweltbelastung.Description = _DTX("~\\G2\021[E\002\\[2[\\\018gbnn\021bq6\\\021\018\025r\\G\018=4\025nn\\\018f\\vbGbY\002G\\\021\018qb=\\\021\018!\\2\021\\\018+\002n\a2G!\002\021[(\018n\025\021r\\G\021\018\\Gq\025\\q\\\021\018r2\\n\\\018\021\002Gu\018\vGnY\018=\\2\018\\2\021\\G\018\127\002\021\\q6\\\021r\\\021\018Ob\0212\\G\002\021[\018n2\021!Y\018r2\\\018\0176\a\\4Y=\\4bnY\002\021[\018!\025\021Y2\021\0022\\G42\024qu")
objTabelleSanierungUmweltbelastung.Visible = false
objTabelleSanierungUmweltbelastung.Media = obj1SanierungUmweltbelastung
objTabelleSanierungUmweltbelastung.Icon = objicotabelle1
objTabelleSanierungUmweltbelastung.Commands = {}
objTabelleSanierungUmweltbelastung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleSanierungUmweltbelastung.Locked = false
objTabelleSanierungUmweltbelastung.Opened = false
objTabelleProduktionProduktion = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleProduktionProduktion.Id = "dd9c3e6b-e155-4262-bbc5-17dca277e261"
objTabelleProduktionProduktion.Name = _DTX("Bb=\\44\\\018\tG\025r\002!Y2\025\021\018#\018\tG\025r\002!Y2\025\021")
objTabelleProduktionProduktion.Description = _DTX("3\002\021b\\\024qnY\018\\G4\\=\\\021\018\a2G\018\\2\021\\\018v\025n2Y2S\\\018f\002\\\024!!\025vv4\002\021[u\018+44\\Gr2\021[n\018=\\r2\021[Y\018\\2\021\\\018\017\\=\\GvG\025r\002!Y2\025\021\018\\2\021\\\021\018f\002\\\024![b\021[\018r\\Gn\\4=\\\021u")
objTabelleProduktionProduktion.Visible = false
objTabelleProduktionProduktion.Media = obj3produktionproduktion
objTabelleProduktionProduktion.Icon = objicotabelle3
objTabelleProduktionProduktion.Commands = {}
objTabelleProduktionProduktion.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleProduktionProduktion.Locked = false
objTabelleProduktionProduktion.Opened = false
objTabelleProduktionAktionspunkte = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleProduktionAktionspunkte.Id = "5df36770-2225-4bdf-aa3f-84c7698cddd7"
objTabelleProduktionAktionspunkte.Name = _DTX("Bb=\\44\\\018\tG\025r\002!Y2\025\021\018#\018+!Y2\025\021nv\002\021!Y\\")
objTabelleProduktionAktionspunkte.Description = _DTX("t\\G\018.\\2YGb[\0182nY\018\1272\\642\024q\01842\021\\bGu\018\030b\024q\018\\2\021\\6\018nY\\24\\\021\018+\021nY2\\[\018E4b\024qY\018r2\\\018p\002GS\\\018b=u\018\vn\018[24Y\018\021\002\021(\018\tG\025r\002!Y2\025\021\018\002\021r\018.\\S\025\\4!\\G\002\021[nr2\024qY\\\0182\021\018\v2\021!4b\021[\018\127\002\018=G2\021[\\\021u\018.G2\024qY\018r2\\\018\tG\025r\002!Y2\025\021\018\a\\[\\\021\018\017\\=\\G!bvb\1272Yb\\Y\018\127\002nb66\\\021(\018n2\021!\\\021\018r2\\\018+pY2\025\021nv\002\021!Y\\\0182\021\018r\\\021\018g2\021\002n=\\G\\2\024qu")
objTabelleProduktionAktionspunkte.Visible = false
objTabelleProduktionAktionspunkte.Media = obj17produktionaktionspunkte
objTabelleProduktionAktionspunkte.Icon = objicotabelle17
objTabelleProduktionAktionspunkte.Commands = {}
objTabelleProduktionAktionspunkte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleProduktionAktionspunkte.Locked = false
objTabelleProduktionAktionspunkte.Opened = false
objTabelleProduktionUmweltbelastung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleProduktionUmweltbelastung.Id = "6e5bb996-0542-4f73-be75-5d151a877abf"
objTabelleProduktionUmweltbelastung.Name = _DTX("Bb=\\44\\\018\tG\025r\002!Y2\025\021\018#\018\0176\a\\4Y=\\4bnY\002\021[")
objTabelleProduktionUmweltbelastung.Description = _DTX("t2\\\018+\002n\a2G!\002\021[\018S\025\021\018\tG\025r\002!Y2\025\021\018b\002E\018\0176\a\\4Y=\\4bnY\002\021[\0182nY\018\\lv\025\021\\\021Y2\\44u")
objTabelleProduktionUmweltbelastung.Visible = false
objTabelleProduktionUmweltbelastung.Media = obj4produktionumweltbelastung
objTabelleProduktionUmweltbelastung.Icon = objicotabelle4
objTabelleProduktionUmweltbelastung.Commands = {}
objTabelleProduktionUmweltbelastung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleProduktionUmweltbelastung.Locked = false
objTabelleProduktionUmweltbelastung.Opened = false
objTabellePolitikAktionspunkte = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabellePolitikAktionspunkte.Id = "a70abfd8-135a-4a05-85f2-0b77b8a9d32b"
objTabellePolitikAktionspunkte.Name = _DTX("Bb=\\44\\\018\t\02542Y2!\018#\018+!Y2\025\021nv\002\021!Y\\")
objTabellePolitikAktionspunkte.Description = _DTX(".\\2\018\021\\[bY2S\\6\018+\021n\\q\\\021\018r\\G\018\t\02542Y2!\018\a\\Gr\\\021\018r2\\\018+!Y2\025\021nv\002\021!Y\\\018S\\GG2\021[\\GYu\018t\\G\018nY\002E\\\021\a\\2n\\\018+\021nY2\\[\018b\002E\0184\\r2[42\024q\018m\018\t\002\021!Y\\(\018\127\\2[Y(\018rbnn\018\002\021n\\G\\\018\t\02542Y2!\\G\018\0212\024qY\018r2\\\018[G\025nn\\\021\018gb\024q\\G\018n2\021r\018\002\021r\018n2\024q\018\127bq4G\\2\024q\\\021\018~G\\\021\127\\\021\018#\018,Gb!Y2\025\021n\127\ab\021[(\018kb\\q4\\G(\018\006\025==L2nY\\\021\018#\018\002\021Y\\G\a\\GE\\\021(\018\0026\0182qG\\\018k2\\r\\G\abq4\018\0212\024qY\018\127\002\018G2n!2\\G\\\021u")
objTabellePolitikAktionspunkte.Visible = false
objTabellePolitikAktionspunkte.Media = obj16politikaktionspunkte
objTabellePolitikAktionspunkte.Icon = objicotabelle16
objTabellePolitikAktionspunkte.Commands = {}
objTabellePolitikAktionspunkte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabellePolitikAktionspunkte.Locked = false
objTabellePolitikAktionspunkte.Opened = false
objTabelleUmweltbelastungUmweltbelastung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleUmweltbelastungUmweltbelastung.Id = "5ccb0378-0899-4ddb-9ef8-611c8d8277e0"
objTabelleUmweltbelastungUmweltbelastung.Name = _DTX("Bb=\\44\\\018\0176\a\\4Y=\\4bnY\002\021[\018#\018\0176\a\\4Y=\\4bnY\002\021[")
objTabelleUmweltbelastungUmweltbelastung.Description = _DTX("g2Y\018\127\002\021\\q6\\\021r\\G\018\0176\a\\4Y=\\4bnY\002\021[\018nY\\2[\\\021\018\127\002\021b\\\024qnY\018r2\\\018O\\4=nYG\\2\0212[\002\021[n!Gb\\EY\\\018b\021u\018\vGnY\018b=\018\\2\021\\G\018=\\nY266Y\\\021\018O\024q\a\\44\\\018=G2\024qY\018r2\\\018O\\4=nYG\\[\0024bY2\025\021\018\127\002nb66\\\021u")
objTabelleUmweltbelastungUmweltbelastung.Visible = false
objTabelleUmweltbelastungUmweltbelastung.Media = obj5umweltbelastungumweltbelastung
objTabelleUmweltbelastungUmweltbelastung.Icon = objicotabelle5
objTabelleUmweltbelastungUmweltbelastung.Commands = {}
objTabelleUmweltbelastungUmweltbelastung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleUmweltbelastungUmweltbelastung.Locked = false
objTabelleUmweltbelastungUmweltbelastung.Opened = false
objTabelleBevoelkerungAktionspunkte = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleBevoelkerungAktionspunkte.Id = "498f037a-f979-485b-8655-9c8efd202a17"
objTabelleBevoelkerungAktionspunkte.Name = _DTX("Bb=\\44\\\018.\\S\025\\4!\\G\002\021[\018#\018+!Y2\025\021nv\002\021!Y\\")
objTabelleBevoelkerungAktionspunkte.Description = _DTX("t\\G\018.\\2YGb[\018r\\G\018.\\S\025\\4!\\G\002\021[\018\a2G!Y\018n2\024q\018v\025n2Y2S\018b\002n(\018n\025\0184b\021[\\\018r2\\\018\b\\Gn\025G[\002\021[\018[\\n2\024q\\GY\0182nYu\026.fJO\025=b4r\018r2\\\018\tG\025r\002!Y2\025\021\018\\2\021=G2\024qY(\018\a2G!Y\018n2\024q\0182\021\018+=qb\\\021[2[!\\2Y\018r\\G\018\tG\025r\002!Y2\025\021\018r2\\\018\127\002\021\\q6\\\021r\\\018.\\S\025\\4!\\G\002\021[\018\021\\[bY2S\018b\002nu")
objTabelleBevoelkerungAktionspunkte.Visible = false
objTabelleBevoelkerungAktionspunkte.Media = obj15bevoelkerungaktionspunkte
objTabelleBevoelkerungAktionspunkte.Icon = objicotabelle15
objTabelleBevoelkerungAktionspunkte.Commands = {}
objTabelleBevoelkerungAktionspunkte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleBevoelkerungAktionspunkte.Locked = false
objTabelleBevoelkerungAktionspunkte.Opened = false
objTabelleUmweltbelastungLebensqualitaet = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleUmweltbelastungLebensqualitaet.Id = "e21779f2-2342-4811-8ba8-00c1bb60c13f"
objTabelleUmweltbelastungLebensqualitaet.Name = _DTX("Bb=\\44\\\018\0176\a\\4Y=\\4bnY\002\021[\018#\018\006\\=\\\021n_\002b42Yb\\Y")
objTabelleUmweltbelastungLebensqualitaet.Description = _DTX("t2\\\018.\\\1272\\q\002\021[\0182nY\018\021\\[bY2S#\\lv\025\021\\\021Y2\\44u\018g2Y\018\127\002\021\\q6\\\021r\\G\018\0176\a\\4Y=\\4bnY\002\021[\018n2\021!Y\018r2\\\018\006\\=\\\021n_\002b42Yb\\Y\018266\\G\018n\024q\021\\44\\Gu")
objTabelleUmweltbelastungLebensqualitaet.Visible = false
objTabelleUmweltbelastungLebensqualitaet.Media = obj6umweltbelastunglebensqualitaet
objTabelleUmweltbelastungLebensqualitaet.Icon = objicotabelle6
objTabelleUmweltbelastungLebensqualitaet.Commands = {}
objTabelleUmweltbelastungLebensqualitaet.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleUmweltbelastungLebensqualitaet.Locked = false
objTabelleUmweltbelastungLebensqualitaet.Opened = false
objTabelleBevoelkerungLebensqualitaet = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleBevoelkerungLebensqualitaet.Id = "9a2b8cf2-2f90-4efd-a291-2ccb6945e0fe"
objTabelleBevoelkerungLebensqualitaet.Name = _DTX("Bb=\\44\\\018.\\S\025\\4!\\G\002\021[\018#\018\006\\=\\\021n_\002b42Yb\\Y")
objTabelleBevoelkerungLebensqualitaet.Description = _DTX("t2\\\018.\\\1272\\q\002\021[\0182nY\018\021\\[bY2S\\\018\\lv\025\021\\\021Y2\\44u\018g\\qG\018g\\\021n\024q\\\021\018vG\025r\002\1272\\G\\\021\0186\\qG\018g\002\\44(\018\abn\018r2\\\018\006\\=\\\021n_\002b42Yb\\Y\018b=\018\\2\021\\G\018=\\nY266Y\\\021\018O\024q\a\\44\\\018S\\Gn\024q4\\\024qY\\GYu\018+=\018\\2\021\\G\018\a\\2Y\\G\\\021\018O\024q\a\\44\\\018n2\021!Y\018rb\021\021\018r\002G\024q\018t2\024qY\\nYG\\nn\018r2\\\018\006\\=\\\021n_\002b42Yb\\Y\018266\\G\018Gbn\024q\\Gu")
objTabelleBevoelkerungLebensqualitaet.Visible = false
objTabelleBevoelkerungLebensqualitaet.Media = obj14bevoelkerunglebensqualitaet
objTabelleBevoelkerungLebensqualitaet.Icon = objicotabelle14
objTabelleBevoelkerungLebensqualitaet.Commands = {}
objTabelleBevoelkerungLebensqualitaet.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleBevoelkerungLebensqualitaet.Locked = false
objTabelleBevoelkerungLebensqualitaet.Opened = false
objTabelleAufklaerungAufklaerung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleAufklaerungAufklaerung.Id = "37e2c34f-ce93-4180-a410-04f3f62a3a8c"
objTabelleAufklaerungAufklaerung.Name = _DTX("Bb=\\44\\\018+\002E!4b\\G\002\021[\018#\018+\002E!4b\\G\002\021[")
objTabelleAufklaerungAufklaerung.Description = _DTX("t2\\\018f\002\\\024!\a2G!\002\021[\018S\025\021\018+\002E!4b\\G\002\021[\018b\002E\018n2\024q\018n\\4=nY\0182nY\018=\\nY266Y\018S\025\021\018\\2\021\\G\018n2\024q\018S\\Gb\\\021r\\G\021r\\\021\018\v2\021nY\\44\002\021[\018r\\G\018.\\S\025\\4!\\G\002\021[\018[\\[\\\021\002\\=\\G\018U\021E\025G6bY2\025\021\\\021\018\002\021r\018k2nn\\\021u\018.\\2\018\0212\\rG2[\\6\018\0302S\\b\002\018\a\\qY\0186b\021\018n2\024q\018[\\[\\\021\018\a\\2Y\\G\\(\018\\SY4u\018S\\G\002\021n2\024q\\G\021r\\\018U\021E\025G6bY2\025\021\\\021u\018\vGnY\018b=\018\\2\021\\6\018[\\\a2nn\\\021\018OYb\021r\0186\\G!Y\0186b\021(\018rbnn\018r2\\\018\vG\a\\2Y\\G\002\021[\018r\\n\018{\025G2\127\025\021Y\\n\018\\Y\abn\018=G2\021[Yu\018t2\\n\\G\018\b\025G[b\021[\018!\02566Y\018r\002G\024q\018O\\4=nY[\\Eb\\442[!\\2Y\018\a2\\r\\G\0182\021n\018OY\025\024!\\\021u")
objTabelleAufklaerungAufklaerung.Visible = false
objTabelleAufklaerungAufklaerung.Media = obj7aufklaerungaufklaerung
objTabelleAufklaerungAufklaerung.Icon = objicotabelle7
objTabelleAufklaerungAufklaerung.Commands = {}
objTabelleAufklaerungAufklaerung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleAufklaerungAufklaerung.Locked = false
objTabelleAufklaerungAufklaerung.Opened = false
objTabelleVermehrungsrateBevoelkerung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleVermehrungsrateBevoelkerung.Id = "b4e54117-7c32-4d74-bf2a-de1a82bbf427"
objTabelleVermehrungsrateBevoelkerung.Name = _DTX("Bb=\\44\\\018\b\\G6\\qG\002\021[nGbY\\\018#\018.\\S\025\\4!\\G\002\021[")
objTabelleVermehrungsrateBevoelkerung.Description = _DTX("t2\\\018\b\\G6\\qG\002\021[nGbY\\\018n\024q4b\\[Y\018n2\024q\018\002\02162YY\\4=bG\018b\002E\018r2\\\018.\\S\025\\4!\\G\002\021[\018\0212\\r\\Gu\018>\021=nv9U\021\018+=qb\\\021[2[!\\2Y\018S\025\021\018\tG\025r\002!Y2\025\021(\018\006\\=\\\021n_\002b42Yb\\Y\018\002\021r\018+\002E!4b\\G\002\021[\018\\G[2=Y\018n2\024q\018\\2\021\018kb\024qnY\0026nEb!Y\025G(\018r\\G\018\127\002\018\\2\021\\G\018O\\4=nYS\\GnYb\\G!\002\021[\018E\002\\qGYu")
objTabelleVermehrungsrateBevoelkerung.Visible = false
objTabelleVermehrungsrateBevoelkerung.Media = obj13vermehrungsratebevoelkerung
objTabelleVermehrungsrateBevoelkerung.Icon = objicotabelle13
objTabelleVermehrungsrateBevoelkerung.Commands = {}
objTabelleVermehrungsrateBevoelkerung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleVermehrungsrateBevoelkerung.Locked = false
objTabelleVermehrungsrateBevoelkerung.Opened = false
objTabelleAufklaerungLebensqualitaet = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleAufklaerungLebensqualitaet.Id = "18809b3b-bdef-4bcf-9be7-c58f65016b27"
objTabelleAufklaerungLebensqualitaet.Name = _DTX("Bb=\\44\\\018+\002E!4b\\G\002\021[\018#\018\006\\=\\\021n_\002b42Yb\\Y")
objTabelleAufklaerungLebensqualitaet.Description = _DTX("t2\\\018k2G!\002\021[\0182nY\018\\2\021\\\018EbnY\01842\021\\bG\\\018vG\025v\025GY2\025\021b4\\\018.\\\1272\\q\002\021[u\018\017\021Y\\Gqb4=\018\\2\021\\n\018O\024q\a\\44\\\021\a\\GY\\n\018\a2G!Y\018n2\024q\0186b\021[\\4\021r\\n\018k2nn\\\021\018\021b\024qY\\242[\018b\002nu\018\v2\021[G2EE\\\0182\021\018r2\\n\\\021\018.\\G\\2\024q\018b44\\2\021\018\127\\2[\\\021\018\020\\r\025\024q\018!\\2\021\\\018\002\\=\\G6b\\nn2[\\\021\018\vGE\0254[\\u\018t\\\021\021\018r2\\\018\006\025\\n\002\021[\018\a2GYn\024qbEY42\024q\\G\018\002\021r\018v\02542Y2n\024q\\G\018\tG\025=4\\6\\\0182nY\0182\021\018=4\025nn\\G\018+\002E!4b\\G\002\021[\018\021\025\024q\018\0212\024qY\018\\\021Yqb4Y\\\021u")
objTabelleAufklaerungLebensqualitaet.Visible = false
objTabelleAufklaerungLebensqualitaet.Media = obj8aufklaerunglebensqualitaet
objTabelleAufklaerungLebensqualitaet.Icon = objicotabelle8
objTabelleAufklaerungLebensqualitaet.Commands = {}
objTabelleAufklaerungLebensqualitaet.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleAufklaerungLebensqualitaet.Locked = false
objTabelleAufklaerungLebensqualitaet.Opened = false
objTabelleLebensqualitaetPolitik = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleLebensqualitaetPolitik.Id = "7470ff05-9df0-4405-98ce-9312338e6e1f"
objTabelleLebensqualitaetPolitik.Name = _DTX("Bb=\\44\\\018\006\\=\\\021n_\002b42Yb\\Y\018#\018\t\02542Y2!")
objTabelleLebensqualitaetPolitik.Description = _DTX("\v2\021\\\021\018[G\025nn\\\021\018\v2\021E4\002nn\018qbY\018r2\\\018\006\\=\\\021n_\002b42Yb\\Y\018b\002E\018r2\\\018\v2\021n\024qb\\Y\127\002\021[\018r\\G\018\t\02542Y2!u\018~\\G2\021[E\002\\[2[\\\018\b\\G=\\nn\\G\002\021[\018=\\G\002q2[Yu\018tb\021\021\018[\\qY\018\\n\018\021\002G\0184b\021[nb6\018\a\\2Y\\Gu\018t2\\\018\006\\=\\\021n_\002b42Yb\\Y\0186\002nn\018rb\021\021\018\\GnY\018!Gb\\EY2[\018nY\\2[\\\021(\018\0026\018v\025n2Y2S\\\021\018\v2\021E4\002nn\018b\002E\018r2\\\018\t\02542Y2!\018\127\002\018=G2\021[\\\021u")
objTabelleLebensqualitaetPolitik.Visible = false
objTabelleLebensqualitaetPolitik.Media = obj12lebensqualitaetpolitik
objTabelleLebensqualitaetPolitik.Icon = objicotabelle12
objTabelleLebensqualitaetPolitik.Commands = {}
objTabelleLebensqualitaetPolitik.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleLebensqualitaetPolitik.Locked = false
objTabelleLebensqualitaetPolitik.Opened = false
objTabelleAufklaerungVermehrungsrate = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleAufklaerungVermehrungsrate.Id = "d9bf2771-6c96-473b-a95b-f3ed5d76a31d"
objTabelleAufklaerungVermehrungsrate.Name = _DTX("Bb=\\44\\\018+\002E!4b\\G\002\021[\018#\018\b\\G6\\qG\002\021[nGbY\\")
objTabelleAufklaerungVermehrungsrate.Description = _DTX("t2\\\018k2G!\002\021[\0182nY\018n\\qG\018\002\021Y\\Gn\024q\\2r42\024qu\018.\\26\018\002\021Y\\G\\\021\018\vlYG\\6\a\\GY\0184b\\\002EY\018b44\\n\018n\\2\021\\\021\018\021bY\002\\G42\024q\\\021\018~b\021[\018\002\021r\018r2\\\018\b\\G6\\qG\002\021[nGbY\\\018nY\\2[Y\01862Y\018\020\\r\\G\018f\002\021r\\u\018g2Y\018=\\[2\021\021\\\021r\\G\018+\002E!4b\\G\002\021[\018=\\[2\021\021Y\018\\2\021\018~4\\2\024q[\\\a2\024qYu\018\vGnY\018b=\018\\2\021\\G\018q\025\\q\\G\\\021\018+\002E!4b\\G\002\021[\018=\\[2\021\021Y\018,b6242\\\021v4b\021\002\021[(\018r2\\\018\127\002\018G\002\\\024!4b\\\002E2[\\\021\018k\\GY\\\021\018E\002\\qGYu")
objTabelleAufklaerungVermehrungsrate.Visible = false
objTabelleAufklaerungVermehrungsrate.Media = obj9aufklaerungvermehrungsrate
objTabelleAufklaerungVermehrungsrate.Icon = objicotabelle9
objTabelleAufklaerungVermehrungsrate.Commands = {}
objTabelleAufklaerungVermehrungsrate.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleAufklaerungVermehrungsrate.Locked = false
objTabelleAufklaerungVermehrungsrate.Opened = false
objTabelleLebensqualitaetVermehrungsrate = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleLebensqualitaetVermehrungsrate.Id = "1ca12406-da4d-490f-aa5f-36b595f3608a"
objTabelleLebensqualitaetVermehrungsrate.Name = _DTX("Bb=\\44\\\018\006\\=\\\021n_\002b42Yb\\Y\018#\018\b\\G6\\qG\002\021[nGbY\\")
objTabelleLebensqualitaetVermehrungsrate.Description = _DTX("~\\qY\018\\n\018\\2\021\\G\018.\\S\025\\4!\\G\002\021[\018\\2\0212[\\G6bnn\\\021\018[\002Y(\018n\025\018nY\\2[Y\018\002\\=\\G\0184b\021[\\G\\\0183\\2Y\018r2\\\0183bq4\018r\\G\018~\\=\002GY\\\021\018b\021u\018.\\2\018=\\n\025\021r\\Gn\018q\025q\\6\018\006\\=\\\021nnYb\021rbGr\018n2\021!Y\018r\\G\018\v2\021E4\002nn\018b\002E\018\030\00244u")
objTabelleLebensqualitaetVermehrungsrate.Visible = false
objTabelleLebensqualitaetVermehrungsrate.Media = obj11lebensqualitaetvermehrungsrate
objTabelleLebensqualitaetVermehrungsrate.Icon = objicotabelle11
objTabelleLebensqualitaetVermehrungsrate.Commands = {}
objTabelleLebensqualitaetVermehrungsrate.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleLebensqualitaetVermehrungsrate.Locked = false
objTabelleLebensqualitaetVermehrungsrate.Opened = false
objTabelleLebensqualitateLebensqualitaet = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objTabelleLebensqualitateLebensqualitaet.Id = "57e47974-cb4b-4356-94cd-a014f8f7613f"
objTabelleLebensqualitateLebensqualitaet.Name = _DTX("Bb=\\44\\\018\006\\=\\\021n_\002b42YbY\\\018#\018\006\\=\\\021n_\002b42Yb\\Y")
objTabelleLebensqualitateLebensqualitaet.Description = _DTX("t2\\\018f\002\\\024!\a2G!\002\021[\0182nY\018\a\\\024qn\\4qbEYD\018\030b\024q\018\\2\021\\6\018pb6vE\018\0026n\018tbn\\2\021\018E\0254[Y\018\\2\021\\\018\tqbn\\\018r\\G\018~4\\2\024q[\002\\4Y2[!\\2Y\018[\\E\0254[Y\018S\025\021\018\\2\021\\G\018\a\\2Y\\G\\\021\018\tqbn\\\018b\021\018\b\\G=\\nn\\G\002\021[n\a244\\\021u\018t2\\n\\6\018E\0254[Y\018r\002G\024q\018q\025\\q\\G\\\018\tG\025r\002!Y2\025\021\018\\2\021\018+=n2\021!\\\021\018r\\G\018\006\\=\\\021n_\002b42Yb\\Yu")
objTabelleLebensqualitateLebensqualitaet.Visible = false
objTabelleLebensqualitateLebensqualitaet.Media = obj10lebensqualitaetlebensqualitaet
objTabelleLebensqualitateLebensqualitaet.Icon = objicotabelle10
objTabelleLebensqualitateLebensqualitaet.Commands = {}
objTabelleLebensqualitateLebensqualitaet.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTabelleLebensqualitateLebensqualitaet.Locked = false
objTabelleLebensqualitateLebensqualitaet.Opened = false
objPortal1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zPortal})
objPortal1.Id = "6dada9c6-680c-4267-a24e-17b0607661db"
objPortal1.Name = _DTX("\t\025GYb4")
objPortal1.Description = ""
objPortal1.Visible = false
objPortal1.Media = objPortal
objPortal1.Icon = objicoPortal
objPortal1.Commands = {
  cmdbetreten = Wherigo.ZCommand({
    Text = _DTX("=\\YG\\Y\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objPortal1.Commands.cmdbetreten.Custom = true
objPortal1.Commands.cmdbetreten.Id = "3ec543be-b674-4c30-9171-ce6c353ed731"
objPortal1.Commands.cmdbetreten.WorksWithAll = true
objPortal1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPortal1.Locked = false
objPortal1.Opened = false
objLebensqualitaet = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objLebensqualitaet.Id = "5e7c1f6e-0974-4836-b04c-b617daf5b331"
objLebensqualitaet.Name = _DTX("\006\\=\\\021n_\002b42Yb\\Y")
objLebensqualitaet.Description = _DTX("t2\\n\\G\018O\024q4\002\\nn\\4=\\G\\2\024q\018=\\YG2EEY\018~\\n\002\021rq\\2Y(\018k\025q4=\\E2\021r\\\021\018\002\021r\018O2\024q\\Gq\\2Y\018r\\G\018.\\S\025\\4!\\G\002\021[\018\002\021r\018n\024q42\\nnY\018rb62Y\018n2\021\021S\02544\\\018+G=\\2Y(\018\006\\=\\\021nnYb\021rbGr\018\\=\\\021n\025\018\\2\021\018\a2\\\018k\025q\021_\002b42Yb\\Y\018\002\021r\018,G\\2\127\\2Y[\\nYb4Y\002\021[u\018tb62Y\0182nY\018r2\\n\\G\018.\\G\\2\024q\018r\\G\018\\2[\\\021Y42\024q\\\018U\021r2!bY\025G\018E\002\\G\018r\\\021\0183\002nYb\021r\018r\\n\018\006b\021r\\nu\018")
objLebensqualitaet.Visible = false
objLebensqualitaet.Media = objLeb
objLebensqualitaet.Icon = objicoILeb1
objLebensqualitaet.Commands = {
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objLebensqualitaet.Commands.cmdablegen.Custom = true
objLebensqualitaet.Commands.cmdablegen.Id = "53e6e949-bd69-48c6-9e5d-1b4baa182add"
objLebensqualitaet.Commands.cmdablegen.WorksWithAll = true
objLebensqualitaet.Commands.cmdaufnehmen.Custom = true
objLebensqualitaet.Commands.cmdaufnehmen.Id = "2ef2c782-719b-4dbd-aa63-3c0e900362fe"
objLebensqualitaet.Commands.cmdaufnehmen.WorksWithAll = true
objLebensqualitaet.Commands.cmdlesen.Custom = true
objLebensqualitaet.Commands.cmdlesen.Id = "6c36c5ec-90d7-4bc3-9bd0-727af3570ad2"
objLebensqualitaet.Commands.cmdlesen.WorksWithAll = true
objLebensqualitaet.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objLebensqualitaet.Locked = false
objLebensqualitaet.Opened = false
objVermehrungsrate = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objVermehrungsrate.Id = "40044df9-06d5-43d5-8704-be422dd65e73"
objVermehrungsrate.Name = _DTX("\b\\G6\\qG\002\021[nGbY\\")
objVermehrungsrate.Description = _DTX("{2\\G\018[\\qY\018\\n\018\0026\018r2\\\018\t\025v\0024bY2\025\021nrL\021b62!D\018b4n\025\018\0026\0183\002#\018\002\021r\018+=\ab\021r\\G\002\021[\018\002\021r\018\0026\018r2\\\018\b\\Gb\\\021r\\G\002\021[\018r\\G\018~\\=\002GY\\\021#\018\002\021r\018OY\\G=\\GbY\\u\018\026.fJ\v2\021\018r2G\\!Y\\G\018\v2\021[G2EE\018r\002G\024q\018r2\\\018f\\[2\\G\002\021[\0182nY\018\0212\024qY\0186\025\\[42\024q(\018\a\\\021\021[4\\2\024q\01862Y\018p2\021r\\G=\\2q24E\\\021(\018OY\\\002\\G\\G6b\\nn2[\002\021[\\\021\018\002\021r\018b\021r\\G\\\021\018\t\025G[Gb66\\\021\018r\\G\018\v2\021rG\002\024!\018q\\GS\025G[\\G\002E\\\021\018\a2Gru\018\b2\\4\018\\q\\G\018n2\021r\018\\n\018\006\\=\\\021n_\002b42Yb\\Y\018\002\021r\018+\002E!4b\\G\002\021[\018r\\n\018\v2\021\127\\4\021\\\021u")
objVermehrungsrate.Visible = false
objVermehrungsrate.Media = objVer
objVermehrungsrate.Icon = objicoIVerm1
objVermehrungsrate.Commands = {
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objVermehrungsrate.Commands.cmdlesen.Custom = true
objVermehrungsrate.Commands.cmdlesen.Id = "b8f3a9e6-e659-4c65-95c9-4c85fadda29a"
objVermehrungsrate.Commands.cmdlesen.WorksWithAll = true
objVermehrungsrate.Commands.cmdablegen.Custom = true
objVermehrungsrate.Commands.cmdablegen.Id = "18184946-ab1e-48cb-a0b9-c3bbd7ff05e8"
objVermehrungsrate.Commands.cmdablegen.WorksWithAll = true
objVermehrungsrate.Commands.cmdaufnehmen.Custom = true
objVermehrungsrate.Commands.cmdaufnehmen.Id = "73513e1b-af7f-4e0a-adc1-f9f6d5448022"
objVermehrungsrate.Commands.cmdaufnehmen.WorksWithAll = true
objVermehrungsrate.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objVermehrungsrate.Locked = false
objVermehrungsrate.Opened = false
objUmweltbelastung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objUmweltbelastung.Id = "7a766711-ae81-422a-ac95-dc7b021cf6d6"
objUmweltbelastung.Name = _DTX("\0176\a\\4Y=\\4bnY\002\021[")
objUmweltbelastung.Description = _DTX("{2\\G\018nYG\025\\6\\\021\018b44\\\018\002\021=\\rb\024qY\\\021\018,\0254[\\\021\018r\\G\018U\021r\002nYG2b42n2\\G\002\021[\018\127\002nb66\\\021D\018+=[bn\\(\018\006b\\G6(\018fb\002==b\002(\018\b\\G!\\qGn\024qb\025n(\018OYb\\rY\\\127\\GEb44\018\\Y\024u\018#\01862Y\018b44\\\021\0184b\021[EG2nY2[\\\021\018+\002n\a2G!\002\021[\\\021u\018.\\4bnY\002\021[\018q\\2nnY\018b=\\G\018b\002\024q\018E\\q4\\\021r\\\018O\\4=nYG\\[\0024bY2\025\021\018\002\021r\018\127\\GnY\025\\GY\\n\018~4\\2\024q[\\\a2\024qYu\018")
objUmweltbelastung.Visible = false
objUmweltbelastung.Media = objUmw
objUmweltbelastung.Icon = objicoIUmw1
objUmweltbelastung.Commands = {
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objUmweltbelastung.Commands.cmdablegen.Custom = true
objUmweltbelastung.Commands.cmdablegen.Id = "4e6aba20-112c-4d07-be94-21fa917905e1"
objUmweltbelastung.Commands.cmdablegen.WorksWithAll = true
objUmweltbelastung.Commands.cmdaufnehmen.Custom = true
objUmweltbelastung.Commands.cmdaufnehmen.Id = "5edc7456-f380-402e-a62d-e3c294898694"
objUmweltbelastung.Commands.cmdaufnehmen.WorksWithAll = true
objUmweltbelastung.Commands.cmdlesen.Custom = true
objUmweltbelastung.Commands.cmdlesen.Id = "db323f87-bfa8-4e94-8df2-81012e7db528"
objUmweltbelastung.Commands.cmdlesen.WorksWithAll = true
objUmweltbelastung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objUmweltbelastung.Locked = false
objUmweltbelastung.Opened = false
objPolitik = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objPolitik.Id = "9fcfce04-baa9-4be7-bf11-4ec3602e5bb3"
objPolitik.Name = _DTX("\t\02542Y2!")
objPolitik.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018\0026EbnnY\018r2\\\018,b\\q2[!\\2Y\\\021\018\002\021r\018g\025\\[42\024q!\\2Y\\\021\018r\\G\018f\\[2\\G\002\021[u\018\vG\018nv2\\[\\4Y\018+\002Y\025G2Yb\\Y\018\002\021r\018\v\021Yn\024q\\2r\002\021[n[\\\ab4Y\018\a2r\\G\018\002\021r\018nY\\qY\018\002\021r\018Eb\\44Y\01862Y\018r\\G\018k\\2Yn2\024qY(\0182qG\\G\018.\\42\\=Yq\\2Y\018\002\021r\018r\\G\018\v2\021n2\024qY2[!\\2Y\0182qG\\G\018\tG\025[Gb66\\u\018")
objPolitik.Visible = false
objPolitik.Media = objPol
objPolitik.Icon = objicoIPol1
objPolitik.Commands = {
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objPolitik.Commands.cmdablegen.Custom = true
objPolitik.Commands.cmdablegen.Id = "6a2a2932-5f1e-4e9f-8721-5899bd2aa5c1"
objPolitik.Commands.cmdablegen.WorksWithAll = true
objPolitik.Commands.cmdaufnehmen.Custom = true
objPolitik.Commands.cmdaufnehmen.Id = "47e4559f-f4b4-4654-8cc4-6fb204c38491"
objPolitik.Commands.cmdaufnehmen.WorksWithAll = true
objPolitik.Commands.cmdlesen.Custom = true
objPolitik.Commands.cmdlesen.Id = "2beb2d6d-0dd8-4f3b-b04b-a8838c2d7eac"
objPolitik.Commands.cmdlesen.WorksWithAll = true
objPolitik.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPolitik.Locked = false
objPolitik.Opened = false
objSanierung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objSanierung.Id = "26a73d5b-04c7-4460-8a29-5314eea36f29"
objSanierung.Name = _DTX("Ob\0212\\G\002\021[")
objSanierung.Description = _DTX("{2\\G\018[\\qY\018\\n\018\0026\018\021b\024qqb4Y2[\\n\018k2GYn\024qbEY\\\021(\018ruqu\018\0176\a\\4Yn\024q\002Y\127(\018nb\021EY\\\018\v\021\\G[2\\\\\021\018\002\021r\018f\\\024L\02442\021[u\018\vn\018[\\qY\018\a\\\0212[\\G\018\0026\018O\024qb\\r\\\021\018\127\002\018G\\vbG2\\G\\\021(\018n\025\021r\\G\021\018\0026\018\v2\021E\002\\qG\002\021[\018\0026\a\\4YEG\\\002\021r42\024q\\G\018\b\\GEbqG\\\021u\018")
objSanierung.Visible = false
objSanierung.Media = objSan
objSanierung.Icon = objicoISan1
objSanierung.Commands = {
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objSanierung.Commands.cmdablegen.Custom = true
objSanierung.Commands.cmdablegen.Id = "6f8295e3-4424-4676-8050-df2726d1fbb1"
objSanierung.Commands.cmdablegen.WorksWithAll = true
objSanierung.Commands.cmdaufnehmen.Custom = true
objSanierung.Commands.cmdaufnehmen.Id = "502bc4db-05ab-48ae-a2d8-182c3d3de487"
objSanierung.Commands.cmdaufnehmen.WorksWithAll = true
objSanierung.Commands.cmdlesen.Custom = true
objSanierung.Commands.cmdlesen.Id = "931b1c6d-5990-4544-a96e-62e3b94d88ed"
objSanierung.Commands.cmdlesen.WorksWithAll = true
objSanierung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSanierung.Locked = false
objSanierung.Opened = false
objProduktion = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objProduktion.Id = "c90bc1f3-35bf-46a4-be22-ae42bcfaf9d3"
objProduktion.Name = _DTX("\tG\025r\002!Y2\025\021")
objProduktion.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018nv2\\[\\4Y\018\0212\024qY\018\021\002G\018rbn\018kb\024qnY\0026\018S\025\021\018U\021r\002nYG2\\\018\002\021r\018{b\021r\a\\G!\018\a2r\\G(\018n\025\021r\\G\021\018b\002\024q\018r2\\\0184b\021r\a2GYn\024qbEY42\024q\\\018\tG\025r\002!Y2\025\021\018\002\021r\018r\\\021\018\0176nbY\127\018S\025\021\018{b\021r\\4\018\002\021r\018t2\\\021nY4\\2nY\002\021[\\\021u\026.fJt2\\n\\\021\018.\\G\\2\024q\018!b\021\021\0186b\021\018b4n\018\v2\021\1272[\\\021\018b\002\024q\018\127\002G\002\\\024!rG\\q\\\021u")
objProduktion.Visible = false
objProduktion.Media = objPro
objProduktion.Icon = objicoIProd1
objProduktion.Commands = {
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objProduktion.Commands.cmdlesen.Custom = true
objProduktion.Commands.cmdlesen.Id = "ec463fcd-cf28-4d3a-acab-7bdb96e691ab"
objProduktion.Commands.cmdlesen.WorksWithAll = true
objProduktion.Commands.cmdablegen.Custom = true
objProduktion.Commands.cmdablegen.Id = "83d3ffc9-562e-42dc-9189-211c62704f97"
objProduktion.Commands.cmdablegen.WorksWithAll = true
objProduktion.Commands.cmdaufnehmen.Custom = true
objProduktion.Commands.cmdaufnehmen.Id = "0b772f84-bab0-4d4f-8401-3e60620f4e10"
objProduktion.Commands.cmdaufnehmen.WorksWithAll = true
objProduktion.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objProduktion.Locked = false
objProduktion.Opened = false
objBevoelkerung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objBevoelkerung.Id = "9b0414ec-7a4c-4896-836d-00efe969c8de"
objBevoelkerung.Name = _DTX(".\\S\025\\4!\\G\002\021[")
objBevoelkerung.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018nv2\\[\\4Y\018r2\\\018b!Y\002\\44\\\018.\\S\025\\4!\\G\002\021[n\127bq4(\0182qG\\\0183\002nb66\\\021n\\Y\127\002\021[\018\002\021r\018+\021nvG\002\\\024q\\\018\a2r\\Gu\018t2\\\018+\002n\a2G!\002\021[\018n\024q\ab\021!Y\0182\021\018+=qb\\\021[2[!\\2Y\018r\\G\018\002\\=G2[\\\021\018.\\G\\2\024q\\u\018")
objBevoelkerung.Visible = false
objBevoelkerung.Media = objBev
objBevoelkerung.Icon = objicoIBev1
objBevoelkerung.Commands = {
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objBevoelkerung.Commands.cmdablegen.Custom = true
objBevoelkerung.Commands.cmdablegen.Id = "918dffa2-5271-412a-ab63-0f10cab58cac"
objBevoelkerung.Commands.cmdablegen.WorksWithAll = true
objBevoelkerung.Commands.cmdaufnehmen.Custom = true
objBevoelkerung.Commands.cmdaufnehmen.Id = "df158db1-831d-421d-aadd-1f7c82f9c475"
objBevoelkerung.Commands.cmdaufnehmen.WorksWithAll = true
objBevoelkerung.Commands.cmdlesen.Custom = true
objBevoelkerung.Commands.cmdlesen.Id = "b5a82c80-5bd6-40a2-a46f-ca61fb94beda"
objBevoelkerung.Commands.cmdlesen.WorksWithAll = true
objBevoelkerung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBevoelkerung.Locked = false
objBevoelkerung.Opened = false
objAufklaerung = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = Player})
objAufklaerung.Id = "057553b8-dee2-4c22-8aeb-69a44f084aa6"
objAufklaerung.Name = _DTX("+\002E!4b\\G\002\021[")
objAufklaerung.Description = _DTX("t2\\n\\G\018.\\G\\2\024q\018\0026EbnnY\018\a\\2Y\0186\\qG\018b4n\018k2nn\\\021\018\002\021r\018.24r\002\021[\018r\002G\024q\018O\024q\0024\\\021u\018+\002\024q\018r\\G\018b44[\\6\\2\021\\\018\vG!\\\021\021Y\0212nnYb\021r\018=\127[4u\018[\\n\002\021r\\G\018\006\\=\\\021n\a\\2n\\(\018\0176\a\\4Y=\\\a\002nnYn\\2\021\018\002\021r\018\\2\021\018\\G\a\\2Y\\G\\G\018{\025G2\127\025\021Y\018(\018B\0254\\Gb\021\127\018\\Y\024u\018[\\q\025\\GY\018rb\127\002u\018")
objAufklaerung.Visible = false
objAufklaerung.Media = objAufkl
objAufklaerung.Icon = objicoIAuf1
objAufklaerung.Commands = {
  cmdablegen = Wherigo.ZCommand({
    Text = _DTX("b=4\\[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdaufnehmen = Wherigo.ZCommand({
    Text = _DTX("b\002E\021\\q6\\\021"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objAufklaerung.Commands.cmdablegen.Custom = true
objAufklaerung.Commands.cmdablegen.Id = "0c03c625-960f-4efb-8968-f9f9110353ff"
objAufklaerung.Commands.cmdablegen.WorksWithAll = true
objAufklaerung.Commands.cmdaufnehmen.Custom = true
objAufklaerung.Commands.cmdaufnehmen.Id = "c28f083e-1936-4e18-8896-ea912b44bc97"
objAufklaerung.Commands.cmdaufnehmen.WorksWithAll = true
objAufklaerung.Commands.cmdlesen.Custom = true
objAufklaerung.Commands.cmdlesen.Id = "13bceff7-207e-4e3a-a4ec-6db200c94ab7"
objAufklaerung.Commands.cmdlesen.WorksWithAll = true
objAufklaerung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objAufklaerung.Locked = false
objAufklaerung.Opened = false
objParkbank1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zPortal})
objParkbank1.Id = "25d156f2-d8c6-4323-ac44-33f7cf58be69"
objParkbank1.Name = _DTX("\tbG!=b\021!")
objParkbank1.Description = ""
objParkbank1.Visible = true
objParkbank1.Media = objParkbank
objParkbank1.Icon = objicoparkbank
objParkbank1.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = _DTX("b\021n\\q\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdsetzen = Wherigo.ZCommand({
    Text = _DTX("n\\Y\127\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmduntersuchen = Wherigo.ZCommand({
    Text = _DTX("\002\021Y\\Gn\002\024q\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objParkbank1.Commands.cmdansehen.Custom = true
objParkbank1.Commands.cmdansehen.Id = "77c19313-d6fb-4e22-9ce1-305ce01bc834"
objParkbank1.Commands.cmdansehen.WorksWithAll = true
objParkbank1.Commands.cmdsetzen.Custom = true
objParkbank1.Commands.cmdsetzen.Id = "7ea5dceb-a037-48e5-929a-83d1b08f70b6"
objParkbank1.Commands.cmdsetzen.WorksWithAll = true
objParkbank1.Commands.cmduntersuchen.Custom = true
objParkbank1.Commands.cmduntersuchen.Id = "e1b6bc69-9c97-4910-baa6-3db25f788632"
objParkbank1.Commands.cmduntersuchen.WorksWithAll = true
objParkbank1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objParkbank1.Locked = false
objParkbank1.Opened = false
objFilmdose1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zPortal})
objFilmdose1.Id = "a5f31c72-a509-46a8-acec-65d290df00ac"
objFilmdose1.Name = _DTX(",246r\025n\\")
objFilmdose1.Description = _DTX("t\\G\018YGbr2Y2\025\021\\44\\\018p4bnn2!\\Gu")
objFilmdose1.Visible = false
objFilmdose1.Media = objFilmdose
objFilmdose1.Icon = objicofilmdose
objFilmdose1.Commands = {
  cmdoeffnen = Wherigo.ZCommand({
    Text = _DTX("\025\\EE\021\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdmitnehmen = Wherigo.ZCommand({
    Text = _DTX("62Y\021\\q6\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdverstecken = Wherigo.ZCommand({
    Text = _DTX("S\\GnY\\\024!\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objFilmdose1.Commands.cmdoeffnen.Custom = true
objFilmdose1.Commands.cmdoeffnen.Id = "07c9ace5-fa29-4518-b2f0-59d0aaa7112e"
objFilmdose1.Commands.cmdoeffnen.WorksWithAll = true
objFilmdose1.Commands.cmdmitnehmen.Custom = true
objFilmdose1.Commands.cmdmitnehmen.Id = "3e4e3fe2-89b8-434d-8837-97bffed47368"
objFilmdose1.Commands.cmdmitnehmen.WorksWithAll = true
objFilmdose1.Commands.cmdverstecken.Custom = true
objFilmdose1.Commands.cmdverstecken.Id = "861978d6-039f-450c-be49-cb4fa0960527"
objFilmdose1.Commands.cmdverstecken.WorksWithAll = true
objFilmdose1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFilmdose1.Locked = false
objFilmdose1.Opened = false
objLogbuch1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zPortal})
objLogbuch1.Id = "b6a86b15-09f1-4143-b244-f33b0445d843"
objLogbuch1.Name = _DTX("\006\025[=\002\024q")
objLogbuch1.Description = ""
objLogbuch1.Visible = false
objLogbuch1.Media = objLogbuch
objLogbuch1.Icon = objiconotizbuch
objLogbuch1.Commands = {
  cmdloggen = Wherigo.ZCommand({
    Text = _DTX("4\025[[\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = _DTX("4\\n\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdmitnehmen = Wherigo.ZCommand({
    Text = _DTX("62Y\021\\q6\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdverstecken = Wherigo.ZCommand({
    Text = _DTX("S\\GnY\\\024!\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objLogbuch1.Commands.cmdloggen.Custom = true
objLogbuch1.Commands.cmdloggen.Id = "6e7386d4-bf24-43c5-a186-32d79a3b5350"
objLogbuch1.Commands.cmdloggen.WorksWithAll = true
objLogbuch1.Commands.cmdlesen.Custom = true
objLogbuch1.Commands.cmdlesen.Id = "a09a01c4-a7ec-4b02-ad79-94184c1749e1"
objLogbuch1.Commands.cmdlesen.WorksWithAll = true
objLogbuch1.Commands.cmdmitnehmen.Custom = true
objLogbuch1.Commands.cmdmitnehmen.Id = "9b88e756-6505-43c2-8555-b6e374a1cf9a"
objLogbuch1.Commands.cmdmitnehmen.WorksWithAll = true
objLogbuch1.Commands.cmdverstecken.Custom = true
objLogbuch1.Commands.cmdverstecken.Id = "55ca84cd-23f3-4955-85e4-183c3d68dcc3"
objLogbuch1.Commands.cmdverstecken.WorksWithAll = true
objLogbuch1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objLogbuch1.Locked = false
objLogbuch1.Opened = false
objGeocoin1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zPortal})
objGeocoin1.Id = "b2dd2783-c08b-4927-9699-0d377c8e93e9"
objGeocoin1.Name = _DTX("~\\\025\024\0252\021")
objGeocoin1.Description = ""
objGeocoin1.Visible = false
objGeocoin1.Media = objGeocoin
objGeocoin1.Icon = objicogeocoin
objGeocoin1.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = _DTX("b\021n\\q\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdmitnehmen = Wherigo.ZCommand({
    Text = _DTX("62Y\021\\q6\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  }),
  cmdverstecken = Wherigo.ZCommand({
    Text = _DTX("S\\GnY\\\024!\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\0302\024qY\018S\\GE\002[=bG")
  })
}
objGeocoin1.Commands.cmdansehen.Custom = true
objGeocoin1.Commands.cmdansehen.Id = "f83fc7d7-21c9-4824-aadd-10d28ec987e7"
objGeocoin1.Commands.cmdansehen.WorksWithAll = true
objGeocoin1.Commands.cmdmitnehmen.Custom = true
objGeocoin1.Commands.cmdmitnehmen.Id = "e94feab8-8d97-4075-aadb-00b2f80323f6"
objGeocoin1.Commands.cmdmitnehmen.WorksWithAll = true
objGeocoin1.Commands.cmdverstecken.Custom = true
objGeocoin1.Commands.cmdverstecken.Id = "532445e6-5637-41a3-85be-a3d222325882"
objGeocoin1.Commands.cmdverstecken.WorksWithAll = true
objGeocoin1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objGeocoin1.Locked = false
objGeocoin1.Opened = false
objSpoiler1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = zCache})
objSpoiler1.Id = "147a9cec-b91a-4845-ba48-b04b4c0d05b6"
objSpoiler1.Name = _DTX("Ov\02524\\G")
objSpoiler1.Description = ""
objSpoiler1.Visible = true
objSpoiler1.Media = objSpoiler
objSpoiler1.Icon = objicospoiler
objSpoiler1.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = _DTX("\021\\q6\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\030\025Yq2\021[\018bSb24b=4\\")
  }),
  cmdansehen = Wherigo.ZCommand({
    Text = _DTX("b\021n\\q\\\021"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _DTX("\030\025Yq2\021[\018bSb24b=4\\")
  })
}
objSpoiler1.Commands.cmdnehmen.Custom = true
objSpoiler1.Commands.cmdnehmen.Id = "7646f0d4-9f23-46af-9b24-1af07a934b1d"
objSpoiler1.Commands.cmdnehmen.WorksWithAll = true
objSpoiler1.Commands.cmdansehen.Custom = true
objSpoiler1.Commands.cmdansehen.Id = "546ca9bd-9dcd-44e2-a17e-42a75f40ddd5"
objSpoiler1.Commands.cmdansehen.WorksWithAll = true
objSpoiler1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpoiler1.Locked = false
objSpoiler1.Opened = false
objKoordinaten1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = objFredericVester})
objKoordinaten1.Id = "76e3b7d6-7c6a-4637-8496-25f9b29a2f05"
objKoordinaten1.Name = _DTX("p\025\025Gr2\021bY\\\021")
objKoordinaten1.Description = _DTX("\030\018;$?\018>\021=nv9$&(\fm5\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9\v\018\005m?\018<a(5K\005")
objKoordinaten1.Visible = false
objKoordinaten1.Media = objKoordinaten
objKoordinaten1.Icon = objicokoordinaten
objKoordinaten1.Commands = {}
objKoordinaten1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKoordinaten1.Locked = false
objKoordinaten1.Opened = false
objUnlockcode1 = Wherigo.ZItem({Cartridge = objKlausdenktnach, Container = objFredericVester})
objUnlockcode1.Id = "539e2eea-056c-46fb-abb5-ef2abc4f1113"
objUnlockcode1.Name = _DTX("\017\0214\025\024!\024\025r\\")
objUnlockcode1.Description = ""
objUnlockcode1.Visible = true
objUnlockcode1.Media = objUnlockcode
objUnlockcode1.Icon = objicounlockcode
objUnlockcode1.Commands = {}
objUnlockcode1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objUnlockcode1.Locked = false
objUnlockcode1.Opened = false
vIntRundenzaehler = Wherigo.ZTask(objKlausdenktnach)
vIntRundenzaehler.Id = "2d78e5ce-2bb5-43ee-be64-91994b3f5af6"
vIntRundenzaehler.Name = _DTX("f\\[2\\G\002\021[n\020bqG")
vIntRundenzaehler.Description = _DTX("\b\\GY\\24\\\018t\\2\021\\\018+!Y2\025\021nv\002\021!Y\\\018\002\021r\018nY\\\002\\G\\\018rbn\018U\021r\002nYG2\\4b\021ru")
vIntRundenzaehler.Visible = false
vIntRundenzaehler.Media = obj1
vIntRundenzaehler.Icon = obj1
vIntRundenzaehler.Active = true
vIntRundenzaehler.Complete = false
vIntRundenzaehler.CorrectState = "None"
objRegiereweise = Wherigo.ZTask(objKlausdenktnach)
objRegiereweise.Id = "ef015f69-b0c4-4a60-a131-ae7c7cab7f5a"
objRegiereweise.Name = _DTX("f\\[2\\G\\\018\a\\2n\\")
objRegiereweise.Description = _DTX("k\\2n\\\018G\\[2\\G\\\021\018#\018B\\24\\\018t\\2\021\018k2nn\\\021\018\002\021r\018S\\G6\\qG\\\018\\nu\018O\024qbEE\\\018\v2\021n2\024qY\0182\021\018r\\G\018.\\S\025\\4!\\G\002\021[\018\002\021r\018nY\\44\\\018n2\024q\\G(\018rbnn\018b44\\n\018\\GE\025Gr\\G42\024q\\\018\127\0026\018\006\\=\\\021\018S\025Gqb\021r\\\021\0182nYu\026.fJ\026.fJp\025\021!G\\Y\018n2\\qY\018r\\G\018\025vY26b4\\\0183\002nYb\021r\018E\0254[\\\021r\\G6b?\\\021\018b\002nD\026.fJ#\018\t\02542Y2!D\018q\025q\\G\018\t\002\021!Y\a\\GY\018b\021\018r2\\\018>\021=nv9mK\026.fJ#\018Ob\0212\\G\002\021[D\018q\025q\\G\018\t\002\021!Y\a\\GY(\018>\021=nv9b=\\G\018$m\018=2n\018$K\018G\\2\024q\\\021\026.fJ#\018\tG\025r\002!Y2\025\021D\01862YY4\\G\\G\018\t\002\021!Y\a\\GY\018\0026\018r2\\\018\005\005\018=2n\018\005m\026.fJ#\018\0176\a\\4Y=\\4bnY\002\021[D\018\0212\\rG2[\\G\018\t\002\021!Y\a\\GY\018m\018\025r\\G\018=\\nn\\G\026.fJ#\018+\002E!4b\\G\002\021[D\018q\025q\\G\018\t\002\021!Y\a\\GY\018b=\\G\018$K\018G\\2\024qY(\026.fJ#\018\006\\=\\\021n_\002b42Yb\\YD\018q\025q\\G\018\t\002\021!Y\a\\GY(\018b\021\127\002nYG\\=\\\021\018n2\021r\018$5\018\026.fJ#\018\b\\G6\\qG\002\021[nGbY\\D\01862YY4\\G\\G\018\t\002\021!Y\a\\GY\018\005m\018\025r\\G\018\005\f\026.fJ#\018.\\S\025\\4!\\G\002\021[D\01862YY4\\G\\G\018\t\002\021!Y\a\\GY\0186\025\\[42\024qnY\018$\005\018")
objRegiereweise.Visible = false
objRegiereweise.Media = objRegieren
objRegiereweise.Icon = objicoregieren
objRegiereweise.Active = true
objRegiereweise.Complete = false
objRegiereweise.CorrectState = "None"
objTrageDicheininsBuchdervernetztenDenker = Wherigo.ZTask(objKlausdenktnach)
objTrageDicheininsBuchdervernetztenDenker.Id = "1af9d212-a42e-485f-b990-ef6ab58cfea1"
objTrageDicheininsBuchdervernetztenDenker.Name = _DTX("BGb[\\\018t2\024q\018\\2\021\0182\021n\018.\002\024q\018r\\G\018S\\G\021\\Y\127Y\\\021\018t\\\021!\\G")
objTrageDicheininsBuchdervernetztenDenker.Description = _DTX("{\\GS\025GGb[\\\021ru\018t\002\018qbnY\018\\n\018[\\n\024qbEEY\018\002\021r\018r\\\021\018\030b\024q\a\\2n\018\\G=Gb\024qY(\018rbnn\018t\002\018S\\G\021\\Y\127Y\018r\\\021!\\\021\018!b\021\021nYu")
objTrageDicheininsBuchdervernetztenDenker.Visible = false
objTrageDicheininsBuchdervernetztenDenker.Media = objBuch
objTrageDicheininsBuchdervernetztenDenker.Icon = objicoBuch
objTrageDicheininsBuchdervernetztenDenker.Active = true
objTrageDicheininsBuchdervernetztenDenker.Complete = false
objTrageDicheininsBuchdervernetztenDenker.CorrectState = "None"
vAktionspunkte = 8
vAPSanierung = 1
vAPProduktion = 9
vAPPolitik = 0
vAPBevoelkerung = 23
vAPLebensqualitaet = 9
vAPVermehrungsrate = 20
vAPAufklaerung = 4
vAPUmweltbelastung = 13
vRunde = 1
vIntAktionspunkte = 8
vIntAPAuf = 0
vIntAPSan = 0
vIntAPPro = 0
vIntAPLeb = 0
vfirstAPPro = false
vfirstAPSan = false
vfirstAPLeb = false
vfirstAPAuf = false
vMeldung = ""
vLF = _DTX("u\026.fJ")
vBilanz = 0
vEnde = false
vGutesEnde = false
objBuchLesen = false
vParadies = false
vStaatsstreich = false
vEndeMeldung = _DTX("+\002n\018\002\021r\018S\025G=\\20")
vBilanzSan = ""
vBilanzAuf = ""
vBilanzLeb = ""
vBilanzAP = ""
vBilanzPol = ""
vBilanzPro = ""
vBilanzUmw = ""
vBilanzBev = ""
vBilanzVer = ""
vUrsache = ""
vOldAPVer = 20
vOldAPLeb = 9
vOldAPPro = 9
vOldAPPol = 0
vOldAPSan = 1
vOldAPUmw = 13
vOldAPBev = 23
vOldAPAuf = 4
vOldBilanz = 41
objName = ""
objHinweise = 0
currentZone = _DTX("\1278b\024q\\")
currentCharacter = _DTX("\025=\020,G\\r\\G2\024\b\\nY\\G")
currentItem = _DTX("\025=\020\b\\G\021\\Y\127Y\\nt\\\021!\\\021")
currentTask = _DTX("SU\021Yf\002\021r\\\021\127b\\q4\\G")
currentInput = _DTX("\025=\020\t\025GYb4$")
currentTimer = _DTX("r\00266L")
objKlausdenktnach.ZVariables = {
  vAktionspunkte = 8,
  vAPSanierung = 1,
  vAPProduktion = 9,
  vAPPolitik = 0,
  vAPBevoelkerung = 23,
  vAPLebensqualitaet = 9,
  vAPVermehrungsrate = 20,
  vAPAufklaerung = 4,
  vAPUmweltbelastung = 13,
  vRunde = 1,
  vIntAktionspunkte = 8,
  vIntAPAuf = 0,
  vIntAPSan = 0,
  vIntAPPro = 0,
  vIntAPLeb = 0,
  vfirstAPPro = false,
  vfirstAPSan = false,
  vfirstAPLeb = false,
  vfirstAPAuf = false,
  vMeldung = "",
  vLF = _DTX("u\026.fJ"),
  vBilanz = 0,
  vEnde = false,
  vGutesEnde = false,
  objBuchLesen = false,
  vParadies = false,
  vStaatsstreich = false,
  vEndeMeldung = _DTX("+\002n\018\002\021r\018S\025G=\\20"),
  vBilanzSan = "",
  vBilanzAuf = "",
  vBilanzLeb = "",
  vBilanzAP = "",
  vBilanzPol = "",
  vBilanzPro = "",
  vBilanzUmw = "",
  vBilanzBev = "",
  vBilanzVer = "",
  vUrsache = "",
  vOldAPVer = 20,
  vOldAPLeb = 9,
  vOldAPPro = 9,
  vOldAPPol = 0,
  vOldAPSan = 1,
  vOldAPUmw = 13,
  vOldAPBev = 23,
  vOldAPAuf = 4,
  vOldBilanz = 41,
  objName = "",
  objHinweise = 0,
  currentZone = _DTX("\1278b\024q\\"),
  currentCharacter = _DTX("\025=\020,G\\r\\G2\024\b\\nY\\G"),
  currentItem = _DTX("\025=\020\b\\G\021\\Y\127Y\\nt\\\021!\\\021"),
  currentTask = _DTX("SU\021Yf\002\021r\\\021\127b\\q4\\G"),
  currentInput = _DTX("\025=\020\t\025GYb4$"),
  currentTimer = _DTX("r\00266L")
}
objPortal2 = Wherigo.ZInput(objKlausdenktnach)
objPortal2.Id = "58b21b46-f71b-424f-829e-32d0b8268f34"
objPortal2.Name = _DTX("\t\025GYb4")
objPortal2.Description = ""
objPortal2.Visible = true
objPortal2.Media = objPortal
objPortal2.Icon = objicoPortal
objPortal2.Choices = {
  "Industrieland",
  "Schwellenland",
  "Entwicklungsland",
  "Raus",
  "Hilfe"
}
objPortal2.InputType = "MultipleChoice"
objPortal2.Text = _DTX("k\025q2\021\018n\02544\018r2\\\018f\\2n\\\018[\\q\\\021-")
objLebensqualitaet1 = Wherigo.ZInput(objKlausdenktnach)
objLebensqualitaet1.Id = "45f1d5be-85a7-4cbf-8c46-662e25775cc3"
objLebensqualitaet1.Name = _DTX("\006\\=\\\021n_\002b42Yb\\Y")
objLebensqualitaet1.Description = ""
objLebensqualitaet1.Visible = true
objLebensqualitaet1.Media = objVester
objLebensqualitaet1.Icon = objicovester
objLebensqualitaet1.InputType = "Text"
objLebensqualitaet1.Text = _DTX("k2\\\018S2\\4\\\018+!Y2\025\021nv\002\021!Y\\\018n\02544\\\021\0182\021\018r\\\021\018.\\G\\2\024q\018\006\\=\\\021n_\002b42Yb\\Y\0182\021S\\nY2\\GY\018\a\\Gr\\\021-")
objAufklaerung1 = Wherigo.ZInput(objKlausdenktnach)
objAufklaerung1.Id = "e16a29de-48fb-4d76-8fb0-45f8d829345c"
objAufklaerung1.Name = _DTX("+\002E!4b\\G\002\021[")
objAufklaerung1.Description = ""
objAufklaerung1.Visible = true
objAufklaerung1.Media = objVester
objAufklaerung1.Icon = objicovester
objAufklaerung1.InputType = "Text"
objAufklaerung1.Text = _DTX("k2\\S2\\4\\\018+!Y2\025\021nv\002\021!Y\018n\02544\\\021\0182\021\018r\\\021\018.\\G\\2\024q\018+\002E!4b\\G\002\021[\0182\021S\\nY2\\GY\018\a\\Gr\\\021-")
objProduktion1 = Wherigo.ZInput(objKlausdenktnach)
objProduktion1.Id = "b946dd19-2cc4-4fb5-81af-123fcc628b3f"
objProduktion1.Name = _DTX("\tG\025r\002!Y2\025\021")
objProduktion1.Description = ""
objProduktion1.Visible = true
objProduktion1.Media = objVester
objProduktion1.Icon = objicovester
objProduktion1.InputType = "Text"
objProduktion1.Text = _DTX("k2\\S2\\4\\\018+!2\025\021nv\002\021!Y\\\018n\02544\\\021\0182\021\018r\\\021\018.\\G\\2\024q\018\tG\025r\002!Y2\025\021\0182\021S\\nY2\\GY\018\a\\Gr\\\021-")
objSanierung1 = Wherigo.ZInput(objKlausdenktnach)
objSanierung1.Id = "37d22c81-2dc7-467e-a96b-c375b2a65015"
objSanierung1.Name = _DTX("Ob\0212\\G\002\021[")
objSanierung1.Description = ""
objSanierung1.Visible = true
objSanierung1.Media = objVester
objSanierung1.Icon = objicovester
objSanierung1.InputType = "Text"
objSanierung1.Text = _DTX("k2\\S2\\4\\\018+!Y2\025\021nv\002\021!Y\\\018n\02544\\\021\0182\021\018r\\\021\018.\\G\\2\024q\018Ob\0212\\G\002\021[\0182\021S\\nY2\\GY\018\a\\Gr\\\021-")
function objKlausdenktnach:OnStart()
  if _G[_DTX("\v\021S")][_DTX("t\\S2\024\\Ut")] == _DTX("t\\n!Y\025v") or _G[_DTX("\v\021S")][_DTX("\t4bYE\025G6")] == _DTX("k2\021m$") then
    for k, v in pairs(_G[_DTX("\025=\020p4b\002nr\\\021!Y\021b\024q")][_DTX("+443\016=\020\\\024Yn")]) do
      v[_DTX("\b2n2=4\\")] = false
      v[_DTX("+\024Y2S\\")] = false
    end
    _Urwigo.MessageBox({
      Text = tostring(_DTX("+4n\025\01826\018\v6\0024bY\025G\018nv2\\4\\\021\018uuu\018\021\002\021\0186b4\018\\qG42\024q\018uuu")),
      Callback = function(action)
        if action ~= nil then
          _G[_DTX("kq\\G2[\025")][_DTX("8\02566b\021r")](_DTX("ObS\\84\025n\\"))
        end
      end
    })
    return
  end
  initFeld()
  _Urwigo.Dialog(false, {
    {
      Text = (_DTX("{b44\025\018") .. Player.Name) .. _DTX("(\018\\\024qY\018Y\02544(\018rbnn\018t\002\01862G\018q\\4E\\\021\018\a244nY0\018t2\\\018[b\021\127\\\021\018\030b\024qG2\024qY\\\021\018\002\\=\\G\018\t\02542Y2!\018\002\021r\018\0176\a\\4Y\0186b\024q\\\021\01862\024q\018S\025\\442[\018r\002G\024q\\2\021b\021r\\Gu\018tbn\018!\025\021\021\018r\025\024q\018\0212\024qY\018n\025\018n\024q\a2\\G2[\018n\\2\021-\026.fJ\026.fJkbn\018qbY\018\\n\01862Y\018r2\\n\\6\018S\\G\021\\Y\127Y\\\021\018t\\\021!\\\021\018=4\025nn\018b\002E\018n2\024q-\018kbG\0026\0182nY\018G\\[2\\G\\\021\018n\025\018n\024q\a\\G-\018U\024q\018=Gb\002\024q\\\018q2\\G\018\\\024qY\018\\2\021\\\021\018\vG!4b\\G=b\\G(\018r\\G\01862\024q\018b\021\018r2\\\018{b\021r\018\021266Y0"),
      Media = objKlaus
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objKlausdenktnach:OnRestore()
end
function zCache:OnEnter()
  currentZone = _DTX("\1278b\024q\\")
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
  _Urwigo.MessageBox({
    Text = _DTX("\0172\018#\018q2\\G\01842\\[Y\018\\2\021\018.24r0\018tbn\0186\002nn\018\\2\021\018{2\021\a\\2n\018n\\2\021\018uuu"),
    Media = objKlaus,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function zPortal:OnExit()
  currentZone = _DTX("\127\t\025GYb4")
  zPortal.Visible = false
  zPortal.Active = false
end
function zAufklaerung:OnEnter()
  currentZone = _DTX("\127+\002E!4b\\G\002\021[")
  objAufklaerung.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
end
function zLebensqualitaet:OnEnter()
  currentZone = _DTX("\127\006\\=\\\021n_\002b42Yb\\Y")
  objLebensqualitaet.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
end
function zPolitik:OnEnter()
  currentZone = _DTX("\127\t\02542Y2!")
  objPolitik.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
  _Urwigo.Dialog(false, {
    {
      Text = ((((_DTX("t\002\018qbnY\018") .. vIntAktionspunkte) .. _DTX("\018+!Y2\025\021nv\002\021!Y\\u\018")) .. _DTX("t\\G\018.\\G\\2\024q\018\t\02542Y2!\018nY\\qY\018=\\2\018")) .. vAPPolitik) .. _DTX("\018\t\002\021!Y\\"),
      Media = objVester
    },
    {
      Text = _DTX("t\\G\018.\\G\\2\024q\018\t\02542Y2!\0184b\\nnY\018n2\024q\018\021\025G6b4\\G\a\\2n\\\018\0212\024qY\018r2G\\!Y\018nY\\\002\\G\021\018#\018\002\021r\018.\\n\\Y\024q\002\021[nn[\\4r\\G\018[2=Y\018\\n\018q2\\G\018\0212\024qYu\018t2\\\018\t\02542Y2!\018\a2Gr\018#\018\a2\\\01826\018k2G!\002\021[n[\\E\002\\[\\\018rbG[\\nY\\44Y\018#\018r\002G\024q\018r2\\\018\006\\=\\\021n_\002b42Yb\\Y\018=\\\\2\021E4\002nnYu"),
      Media = objWirkungsgefuege
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function zProduktion:OnEnter()
  currentZone = _DTX("\127\tG\025r\002!Y2\025\021")
  objProduktion.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
end
function zSanierung:OnEnter()
  currentZone = _DTX("\127Ob\0212\\G\002\021[")
  objSanierung.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
end
function zUmweltbelastung:OnEnter()
  currentZone = _DTX("\127\0176\a\\4Y=\\4bnY\002\021[")
  objUmweltbelastung.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
  _Urwigo.Dialog(false, {
    {
      Text = (((_DTX("t\\G\018.\\G\\2\024q\018\0176\a\\4Y=\\4bnY\002\021[\018nY\\qY\018=\\2\018") .. vAPUmweltbelastung) .. _DTX("\018\t\002\021!Y\\\021u\018t\002\018qbnY\018")) .. vIntAktionspunkte) .. _DTX("\018+!Y2\025\021nv\002\021!Y\\u\018"),
      Media = objVester
    },
    {
      Text = _DTX("+44\\Gr2\021[n\018!b\021\021nY\018t\002\018r2\\\018\0176\a\\4Y=\\4bnY\002\021[\018\0212\024qY\018r2G\\!Y\018nY\\\002\\G\021u\018O\024qb\002\018t2G\018rbn\018k2G!\002\021[n[\\E\002\\[\\\018[\\\021b\002\018b\021D\018\tG\025r\002!Y2\025\021\018\002\021r\018Ob\0212\\G\002\021[\018\a2G!\\\021\018n2\024q\018q2\\G\018\002\02162YY\\4=bG\018b\002nu\018.n\au\018!b\021\021\018r\002G\024q\018\\2\021\018+=n\\\021!\\\021\018r\\G\018\tG\025r\002!Y2\025\021\018r2\\\018\0176\a\\4Y=\\4bnY\002\021[\018[\\n\\\021!Y\018\a\\Gr\\\021u\018.\\b\024qY\\D\018r2\\\018\0176\a\\4Y=\\4bnY\002\021[\018qbY\018\\2\021\\\018\002\02162YY\\4=bG\\\018f\002\\\024!!\025vv4\002\021[0"),
      Media = objWirkungsgefuege
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function zBevoelkerung:OnEnter()
  currentZone = _DTX("\127.\\S\025\\4!\\G\002\021[")
  objBevoelkerung.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
  _Urwigo.Dialog(false, {
    {
      Text = ((((_DTX("t\\G\018.\\G\\2\024q\018.\\S\025\\4!\\G\002\021[\018nY\\qY\018=\\2\018") .. vAPBevoelkerung) .. _DTX("\018\t\002\021!Y\\u\018")) .. _DTX("t\002\018qbnY\018")) .. vIntAktionspunkte) .. _DTX("\018+!Y2\025\021nv\002\021!Y\\u\018"),
      Media = objVester
    },
    {
      Text = _DTX("+44\\Gr2\021[n\018!b\021\021nY\018t\002\018r2\\n\\\021\018.\\G\\2\024q\018\0212\024qY\018r2G\\!Y\018nY\\\002\\G\0210\018O\024qb\002\018t2G\018rbn\018k2G!\002\021[n[\\E\002\\[\\\018[\\\021b\002\018b\021u\018t\\G\018.\\G\\2\024q\018.\\S\025\\4!\\G\002\021[\018\a2Gr\018=\\\\2\021E4\002nnY\018S\025\021\018r\\G\018\b\\G6\\qG\002\021[nGbY\\u"),
      Media = objWirkungsgefuege
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function zVermehrungsrate:OnEnter()
  currentZone = _DTX("\127\b\\G6\\qG\002\021[nGbY\\")
  objVermehrungsrate.Visible = true
  objFredericVester:MoveTo(_G[currentZone])
  objKlausMastermindKlabuster:MoveTo(_G[currentZone])
  _Urwigo.Dialog(false, {
    {
      Text = (((_DTX("t\\G\018.\\G\\2\024q\018\b\\G6\\qG\002\021[nGbY\\\018nY\\qY\018=\\2\018") .. vAPVermehrungsrate) .. _DTX("\018\t\002\021!Y\\\021u\018t\002\018qbnY\018")) .. vIntAktionspunkte) .. _DTX("\018+!Y2\025\021nv\002\021!Y\\u\018"),
      Media = objVester
    },
    {
      Text = _DTX("+44\\Gr2\021[n\0184b\\nnY\018n2\024q\018r2\\n\\G\018.\\G\\2\024q\018\0212\024qY\018r2G\\!Y\018nY\\\002\\G\021u\018O\024qb\002\018t2G\018rbn\018k2G!\002\021[n[\\E\002\\[\\\018[\\\021b\002\018b\021D\018r2\\\018\b\\G\\6\\qG\002\021[nGbY\\\018\a2Gr\018=\\\\2\021E4\002nnY\018r\002G\024q\018\006\\=\\\021n_\002b42Yb\\Y\018\002\021r\018+\002E4b\\G\002\021[u\018tb\127\002\018!\02566Y\018\021\025\024q\018\\2\021\018kb\024qnY\0026nEb!Y\025G\018=bn2\\G\\\021r\018b\002E\018r\\G\018.\\S\025\\4!\\G\002\021[\018\002\021r\018r\\G\018+\002E!4b\\G\002\021[u"),
      Media = objWirkungsgefuege
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objvorfinal:OnEnter()
  currentZone = _DTX("\025=\020S\025GE2\021b4")
  Wherigo.PlayAudio(objaudiofinal)
end
function objPortal2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 56956 then
    Wherigo.PlayAudio(objaudiodieserweg)
    _Urwigo.MessageBox({
      Text = _DTX("\v2\021\\\018\a\\2n\\\018\v\021Yn\024q\\2r\002\021[u\018U\024q\018\a\002\\\021n\024q\\\018t2G\018S2\\4\018\vGE\0254[\018b\002E\018t\\2\021\\6\018k\\[\018r\002G\024q\018rbn\018U\021r\002nYG2\\4b\021ru\018\026.fJU\024q\018[\\=\\\018t2G\018rb\127\002\018\127\a\\2\018!4\\2\021\\\018{24En62YY\\4\01862YD\026.fJ#\018\\2\021\018\tG\025Y\025!\02544=4bYY(\01862Y\018r\\6\018t\002\018r\\2\021\\\018{b\021r4\002\021[\\\021\018S\\GE\0254[\\\021\018!b\021\021nYu\026.fJ#\018\\2\021\018Bb=\\44\\\021=\002\024q\01862Y\018r\\6\018k2G!\002\021[n[\\E\002\\[\\\018r\\n\018U\021r\002nYG2\\4b\021r\\nu\026.fJ\026.fJg\025\\[\\\018r2\\\018k\\2nq\\2Y\018t2\024q\018b\002\024q\018\a\\2Y\\Gq2\021\018=\\[4\\2Y\\\021\018#\018n\025\018\a2\\\0182\024qu\026.fJOb[\\\01862G\018.\\n\024q\\2r(\018\a\\\021\021\018t\002\018t\\2\021\\\018\v\021Yn\024q\\2r\002\021[\018[\\Eb\\44Y\018qbnY(\018tb62Y\0182\024q\018t2G\018r2\\\018,\0254[\\\021\01862YY\\24\\\021\018!b\021\021u"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          objRegiereweise.Visible = true
          vIntRundenzaehler.Active = true
          vIntRundenzaehler.Visible = true
          objProtokollblatt1.Visible = true
          objWirkungsgefuege1.Visible = true
          objFredericVester.Visible = true
          zPortal.Active = false
          zPortal.Visible = false
          zUmweltbelastung.Active = true
          zUmweltbelastung.Visible = true
          zSanierung.Active = true
          zSanierung.Visible = true
          zProduktion.Active = true
          zProduktion.Visible = true
          zPortal.Active = true
          zPortal.Visible = true
          zPolitik.Active = true
          zPolitik.Visible = true
          zVermehrungsrate.Active = true
          zVermehrungsrate.Visible = true
          zLebensqualitaet.Active = true
          zLebensqualitaet.Visible = true
          zBevoelkerung.Active = true
          zBevoelkerung.Visible = true
          zAufklaerung.Active = true
          zAufklaerung.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 29250 then
    _Urwigo.MessageBox({
      Text = _DTX("tbn\0182nY\018n\\qG\0186\002Y2[0\018+=\\G\0182\024q\018\\6vE\\q4\\\018t2G\018#\018Eb\021[\\\018!4\\2\021\018b\021\01862Y\018r\\6\018U\021r\002nYG2\\4b\021ru"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 54931 then
    _Urwigo.MessageBox({
      Text = _DTX("tbn\0182nY\018n\\qG\0186\002Y2[0\018+=\\G\0182\024q\018\\6vE\\q4\\\018t2G\018#\018Eb\021[\\\018!4\\2\021\018b\021\01862Y\018r\\6\018U\021r\002nYG2\\4b\021ru"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 60651 then
    _Urwigo.MessageBox({
      Text = _DTX("tbn\0182nY\018n\\qG\018n\024qbr\\u"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("\030\002\021\018[\002Y\018#\0182\024q\018[\\=\\\018t2G\018\\2\021\018vbbG\018{2\021\a\\2n\\\018\127\002\018pL=\\G\021\\Y2\\\021u"),
        Media = objVester
      },
      {
        Text = _DTX("pL=\\G\021\\Y2\\\021\0182nY\018\\2\021\018\\2\021Eb\024q\018\\\021Y\a2\024!\\4Y\\n\018U\021r\002nYG2\\4b\021r(\018rbn\018=\\G\\2Yn\018r2\\\018YLv2n\024q\\\021\018\tG\025=4\\6\\\018b\002E\127\\2[Yu\026.fJ")
      },
      {
        Text = _DTX("pL=\\G\021\\Y2\\\021\0182nY\018\\2\021\018\\2\021Eb\024q\018\\\021Y\a2\024!\\4Y\\n\018U\021r\002nYG2\\4b\021r(\018rbn\018=\\G\\2Yn\018r2\\\018YLv2n\024q\\\021\018\tG\025=4\\6\\\018b\002E\127\\2[Yu\026.fJ\026.fJt\\G\018.\\G\\2\024q\018\tG\025r\002!Y2\025\021(\018\0176\a\\4Y=4bnY\002\021[\018\002\021r\018Ob\0212\\G\002\021[\018nYbGY\\Y\01862Y\026.fJ[\\G2\021[\\G\018Ob\0212\\G\002\021[\018N\005\001\026.fJ62YY4\\G\\G\018\tG\025r\002!Y2\025\021\018N5\001\026.fJnY\\2[\\\021r\\G\018\0176\a\\4Y=\\4bnY\002\021[\018N\005m\001\026.fJ")
      },
      {
        Text = _DTX("t2\\\018+\002E!4b\\G\002\021[\01862Y\018r\\6\018k\\GY\018\f\0182nY\018b\002E\018\020\\r\\\021\018,b44\018S\\G=\\nn\\G\002\021[n\a\002\\Gr2[u")
      },
      {
        Text = _DTX("\006\\=\\\021n_\002b42Yb\\Y\0182nY\018=\\G\\2Yn\018S\025Gqb\021r\\\021\018N5\001(\018\abn\018n2\024q\018b\002E\018r2\\\018\b\\G6\\qG\002\021[nGbY\\\018N$<\001\018\002\021r\018rb62Y\018r2\\\018.\\S\025\\4!\\G\002\021[\018N$m\001\018b\002n\a2G!Yu")
      },
      {
        Text = _DTX("+=\\G\018YG\025Y\127\018b44\\6\0182nY\018r2\\\018\t\02542Y2!\018N<\001\018\021\002G\018=\\r2\021[Y\018\127\002EG2\\r\\\021nY\\44\\\021ru")
      },
      {
        Text = _DTX("t2G\\!Y\018=\\\\2\021E4\002nn=bG\018n2\021r\018\020\\r\025\024q\018\021\002G\026.fJ#\018Ob\0212\\G\002\021[\026.fJ#\018\tG\025r\002!Y2\025\021\026.fJ#\018+\002E!4b\\G\002\021[\018\026.fJ#\018\006\\=\\\021n_\002b42Yb\\Y\026.fJt2\\\018G\\nY42\024q\\\021\018.\\G\\2\024q\\\018\a\\Gr\\\021\018\002\\=\\G\018rbn\018k2G!\002\021[n[\\E\002\\[\\\018=\\\\2\021E4\002nnY\\")
      },
      {
        Text = _DTX("\030\002G\018g\002Y\018#\018\005$\018f\002\021r\\\021\018n\024qbEEnY\018t\0020"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objLebensqualitaet1:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _DTX("+4n\025\018rbn\018\abG\018!\\2\021\\\0183bq40"),
      Media = objVester
    })
    return
  end
  if vfirstAPLeb == false then
    if input > vIntAktionspunkte then
      _Urwigo.MessageBox({
        Text = _DTX("+=\\G\018{b44\025\018#\018n\025\018S2\\4\\\018+!Y2\025\021nv\002\021!Y\\\018qbnY\018t\002\018\0212\024qY0"),
        Media = objVester,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      vfirstAPLeb = true
      vIntAPLeb = input
      if vAPLebensqualitaet + vIntAPLeb > 29 then
        _Urwigo.MessageBox({
          Text = _DTX("\017vn\018#\0186\\qG\018b4n\018$5\018\t\002\021!Y\\\018!b\021\021\018r\\G\018.\\G\\2\024q\018\006\\=\\\021n_\002b42YbY\\\018\0212\024qY\018qb=\\\021u\026.fJU\024q\0186\002nn\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018b\021vbnn\\\021u"),
          Media = objVester,
          Callback = function(action)
            if action ~= nil then
              vIntAPLeb = 29 - vAPLebensqualitaet
            end
          end
        })
      end
      vIntAktionspunkte = vIntAktionspunkte - vIntAPLeb
    end
  elseif input == vIntAPLeb then
    _Urwigo.MessageBox({
      Text = _DTX("\030b\018rb\018qbY\018n2\024q\018b=\\G\018\0212\024qYn\018[\\b\\\021r\\GY0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input < vIntAPLeb then
    vIntAktionspunkte = vIntAktionspunkte + (vIntAPLeb - input)
    vIntAPLeb = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018S\\GG2\021[\\GYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input - vIntAPLeb > vIntAktionspunkte then
    _Urwigo.MessageBox({
      Text = _DTX("{6\018#\018E\002\\G\018r2\\n\\\018\vGq\025\\q\002\021[\018G\\2\024q\\\021\018t\\2\021\\\018+!Y2\025\021nv\002\021!Y\\\018\0212\024qY\018b\002n0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    vIntAktionspunkte = vIntAktionspunkte - (input - vIntAPLeb)
    vIntAPLeb = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018\\Gq\025\\qYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objAufklaerung1:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _DTX("+4n\025\018\\2\021\\\0183bq4\018\abG\018rbn\018\0212\024qY0"),
      Media = objVester
    })
    return
  end
  if vfirstAPAuf == false then
    vfirstAPAuf = true
    if input > vIntAktionspunkte then
      _Urwigo.MessageBox({
        Text = _DTX("+=\\G\018{b44\025\018#\018n\025\018S2\\4\\\018+!Y2\025\021nv\002\021!Y\\\018qbnY\018t\002\018\0212\024qY0"),
        Media = objVester
      })
    else
      vIntAPAuf = input
      if vAPAufklaerung + vIntAPAuf > 29 then
        _Urwigo.MessageBox({
          Text = _DTX("\017vn\018#\0186\\qG\018b4n\018$5\018\t\002\021!Y\\\018!b\021\021\018r\\G\018.\\G\\2\024q\018+\002E!4b\\G\002\021[\018\0212\024qY\018qb=\\\021u\026.fJU\024q\0186\002nn\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018b\021vbnn\\\021u"),
          Media = objVester,
          Callback = function(action)
            if action ~= nil then
              vIntAPAuf = 29 - vAPAufklaerung
            end
          end
        })
      end
      vIntAktionspunkte = vIntAktionspunkte - vIntAPAuf
    end
  elseif input == vIntAPAuf then
    _Urwigo.MessageBox({
      Text = _DTX("\030b\018rb\018qbY\018n2\024q\018b=\\G\018\0212\024qYn\018[\\b\\\021r\\GY0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input < vIntAPAuf then
    vIntAktionspunkte = vIntAktionspunkte + (vIntAPAuf - input)
    vIntAPAuf = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018S\\GG2\021[\\GYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input - vIntAPAuf > vIntAktionspunkte then
    _Urwigo.MessageBox({
      Text = _DTX("{6\018#\018E\002\\G\018r2\\n\\\018\vGq\025\\q\002\021[\018G\\2\024q\\\021\018t\\2\021\\\018+!Y2\025\021nv\002\021!Y\\\018\0212\024qY\018b\002n0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif vAPAufklaerung + (vIntAktionspunkte - (input - vIntAPAuf)) > 29 then
    _Urwigo.MessageBox({
      Text = _DTX("\017vn\018#\0186\\qG\018b4n\018$5\018\t\002\021!Y\\\018!b\021\021\018r\\G\018.\\G\\2\024q\018+\002E!4b\\G\002\021[\018\0212\024qY\018qb=\\\021u\026.fJU\024q\0186\002nn\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018b\021vbnn\\\021u"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          vIntAPAuf = 29 - vAPAufklaerung
        end
      end
    })
    vIntAktionspunkte = vIntAktionspunkte - vIntAPAuf
  else
    vIntAktionspunkte = vIntAktionspunkte - (input - vIntAPAuf)
    vIntAPAuf = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018\\Gq\025\\qYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objProduktion1:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _DTX("+4n\025\018\\2\021\\\0183bqq4\018\abG\018rbn\018\0212\024qY0"),
      Media = objVester
    })
    return
  end
  if vfirstAPPro == false then
    vfirstAPPro = true
    if input * input > vIntAktionspunkte * vIntAktionspunkte then
      _Urwigo.MessageBox({
        Text = _DTX("+=\\G\018{b44\025\018#\018n\025\018S2\\4\\\018+!Y2\025\021nv\002\021!Y\\\018qbnY\018t\002\018\0212\024qY0"),
        Media = objVester
      })
    else
      vIntAPPro = input
      if vIntAPPro + vAPProduktion > 29 then
        _Urwigo.MessageBox({
          Text = _DTX("\017vn\018#\0186\\qG\018b4n\018$5\018\t\002\021!Y\\\018!b\021\021\018r\\G\018.\\G\\2\024q\018\tG\025r\002!Y2\025\021\018\0212\024qY\018qb=\\\021u\026.fJU\024q\0186\002nn\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018b\021vbnn\\\021u"),
          Media = objVester,
          Callback = function(action)
            if action ~= nil then
              vIntAPAuf = 29 - vAPProduktion
              vIntAktionspunkte = vIntAktionspunkte - vIntAPPro
            end
          end
        })
      elseif vIntAPPro + vAPProduktion < 0 then
        _Urwigo.MessageBox({
          Text = _DTX("\017vn\018#\018\a\\\0212[\\G\018b4n\018<\018\t\002\021!Y\\\018!b\021\021\018r\\G\018.\\G\\2\024q\018\tG\025r\002!Y2\025\021\018\0212\024qY\018qb=\\\021u\026.fJU\024q\0186\002nn\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018b\021vbnn\\\021u"),
          Media = objVester,
          Callback = function(action)
            if action ~= nil then
              vIntAPAuf = vAPProduktion
              vIntAktionspunkte = vIntAktionspunkte - vIntAPPro
            end
          end
        })
      elseif vIntAPPro < 0 then
        vIntAktionspunkte = vIntAktionspunkte + vIntAPPro
      else
        vIntAktionspunkte = vIntAktionspunkte - vIntAPPro
      end
    end
  elseif input == vIntAPPro then
    _Urwigo.MessageBox({
      Text = _DTX("\030b\018rb\018qbY\018n2\024q\018b=\\G\018\0212\024qYn\018[\\b\\\021r\\GY0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input < 0 then
    if input > vIntAPPro then
      vIntAktionspunkte = vIntAktionspunkte - (vIntAPPro - input)
      vIntAPPro = input
      _Urwigo.MessageBox({
        Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018S\\GG2\021[\\GYu"),
        Media = objVester,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif vIntAPPro - input > vIntAktionspunkte then
      _Urwigo.MessageBox({
        Text = _DTX("{6\018#\018E\002\\G\018r2\\n\\\018\vGq\025\\q\002\021[\018G\\2\024q\\\021\018t\\2\021\\\018+!Y2\025\021nv\002\021!Y\\\018\0212\024qY\018b\002n0"),
        Media = objVester,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      vIntAktionspunkte = vIntAktionspunkte - (vIntAPPro - input)
      vIntAPPro = input
      _Urwigo.MessageBox({
        Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018\\Gq\025\\qYu"),
        Media = objVester,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif input < vIntAPPro then
    vIntAktionspunkte = vIntAktionspunkte + (vIntAPPro - input)
    vIntAPPro = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018S\\GG2\021[\\GYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input - vIntAPPro > vIntAktionspunkte then
    _Urwigo.MessageBox({
      Text = _DTX(",\002\\G\018r2\\n\\\018\vGq\025\\q\002\021[\018G\\2\024q\\\021\018t\\2\021\\\018+!Y2\025\021nv\002\021!Y\\\018\0212\024qY\018b\002n0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    vIntAPPro = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018\\Gq\025\\qYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objSanierung1:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _DTX("+4n\025\018\\2\021\\\0183bq4\018\abG\018rbn\018\0212\024qY0"),
      Media = objVester
    })
    return
  end
  if vfirstAPSan == false then
    vfirstAPSan = true
    if input > vIntAktionspunkte then
      _Urwigo.MessageBox({
        Text = _DTX("+=\\G\018{b44\025\018#\018n\025\018S2\\4\\\018+!Y2\025\021nv\002\021!Y\\\018qbnY\018t\002\018\0212\024qY0"),
        Media = objVester,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      vIntAPSan = input
      if vAPSanierung + vIntAPSan > 29 then
        _Urwigo.MessageBox({
          Text = _DTX("\017vn\018#\0186\\qG\018b4n\018$5\018\t\002\021!Y\\\018!b\021\021\018r\\G\018.\\G\\2\024q\018Ob\0212\\G\002\021[\018\0212\024qY\018qb=\\\021u\026.fJU\024q\0186\002nn\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018b\021vbnn\\\021u"),
          Media = objVester,
          Callback = function(action)
            if action ~= nil then
              vIntAPAuf = 29 - vAPSanierung
            end
          end
        })
      end
      vIntAktionspunkte = vIntAktionspunkte - vIntAPSan
    end
  elseif input == vIntAPSan then
    _Urwigo.MessageBox({
      Text = _DTX("\030b\018rb\018qbY\018n2\024q\018b=\\G\018\0212\024qYn\018[\\b\\\021r\\GY0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input < vIntAPSan then
    vIntAktionspunkte = vIntAktionspunkte + (vIntAPSan - input)
    vIntAPSan = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018S\\GG2\021[\\GYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif input - vIntAPSan > vIntAktionspunkte then
    _Urwigo.MessageBox({
      Text = _DTX("{6\018#\018E\002\\G\018r2\\n\\\018\vGq\025\\q\002\021[\018G\\2\024q\\\021\018t\\2\021\\\018+!Y2\025\021nv\002\021!Y\\\018\0212\024qY\018b\002n0"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    vIntAktionspunkte = vIntAktionspunkte - (input - vIntAPSan)
    vIntAPSan = input
    _Urwigo.MessageBox({
      Text = _DTX("\016!bL\018#\018t\002\018qbnY\018t\\2\021\\\018U\021S\\nY2Y2\025\021\018\\Gq\025\\qYu"),
      Media = objVester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFredericVester:OncmdBescheid(target)
  _Urwigo.MessageBox({
    Text = _DTX("t\002\018=2nY\018t2G\01862Y\018r\\G\018\b\\GY\\24\002\021[\018r\\G\018+!Y2\025\021nv\002\021!Y\\\018n2\024q\\G-"),
    Media = objVester,
    Buttons = {
      _DTX("+=\\G\018\020b"),
      _DTX("{66666")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          vAktionspunkte = vIntAktionspunkte
          ErstelleAusgangsmeldung()
          _Urwigo.Dialog(false, {
            {Text = vMeldung, Media = objVester},
            {
              Text = _DTX("\016!bLu\018tb\021\021\018n\024qb\002\\\0182\024q\0186b4(\018\a2\\\018n2\024q\018t\\2\021\\\018\v\021Yn\024q\\2r\002\021[\018b\002n\a2G!\\\021\018\a2Gr\018uuu"),
              Media = objVester
            }
          }, function(action)
            EntscheidungAusfuehren()
            ErstelleFeedbackmeldung()
            _Urwigo.Dialog(false, {
              {
                Text = _DTX("t\002\018qbnY\018E\0254[\\\021r\\n\018\vG[\\=\0212n\018\\G\1272\\4YD"),
                Media = objVester
              },
              {Text = vMeldung, Media = objVester}
            }, function(action)
              objKlausdenktnach:RequestSync()
              if vEnde == false then
                _Urwigo.MessageBox({
                  Text = _DTX("~4\002\\\024!\a\002\021n\024q\018#\018t\002\018=2nY\01826\018\021b\\\024qnY\\\021\018f\\[2\\G\002\021[n\020bqG0"),
                  Media = objVester,
                  Callback = function(action)
                    if action ~= nil then
                      vRunde = vRunde + 1
                      if vRunde == 2 then
                        vIntRundenzaehler.Media = obj2
                        vIntRundenzaehler.Icon = obj2
                      elseif vRunde == 3 then
                        vIntRundenzaehler.Icon = obj3
                        vIntRundenzaehler.Media = obj3
                      elseif vRunde == 4 then
                        vIntRundenzaehler.Icon = obj4
                        vIntRundenzaehler.Media = obj4
                      elseif vRunde == 5 then
                        vIntRundenzaehler.Icon = obj5
                        vIntRundenzaehler.Media = obj5
                      elseif vRunde == 6 then
                        vIntRundenzaehler.Icon = obj6
                        vIntRundenzaehler.Media = obj6
                      elseif vRunde == 7 then
                        vIntRundenzaehler.Icon = obj7
                        vIntRundenzaehler.Media = obj7
                      elseif vRunde == 8 then
                        vIntRundenzaehler.Icon = obj8
                        vIntRundenzaehler.Media = obj8
                      elseif vRunde == 9 then
                        vIntRundenzaehler.Icon = obj9
                        vIntRundenzaehler.Media = obj9
                      elseif vRunde == 10 then
                        vIntRundenzaehler.Icon = obj10
                        vIntRundenzaehler.Media = obj10
                      elseif vRunde == 11 then
                        vIntRundenzaehler.Icon = obj11
                        vIntRundenzaehler.Media = obj11
                      else
                        vIntRundenzaehler.Icon = obj12
                        vIntRundenzaehler.Media = obj12
                      end
                      vIntAPAuf = 0
                      vIntAPLeb = 0
                      vIntAPPro = 0
                      vIntAPSan = 0
                      vfirstAPAuf = false
                      vfirstAPLeb = false
                      vfirstAPPro = false
                      vfirstAPSan = false
                      vIntAktionspunkte = vAktionspunkte
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              elseif vStaatsstreich == true then
                Wherigo.PlayAudio(objaudiostaatsstreich)
                zAufklaerung.Active = false
                zLebensqualitaet.Active = false
                zPolitik.Active = false
                zProduktion.Active = false
                zSanierung.Active = false
                zUmweltbelastung.Active = false
                zBevoelkerung.Active = false
                zVermehrungsrate.Active = false
                objKlausdenktnach:RequestSync()
                _Urwigo.Dialog(false, {
                  {
                    Text = _DTX("+\002n\018\002\021r\018S\025G=\\20\018t\002\018qbnY\018\\n\0184\\2r\\G\018\0212\024qY\018[\\n\024qbEEY0"),
                    Media = objVester
                  },
                  {
                    Text = _DTX("t\\2\021\\\018\v\021Yn\024q\\2r\002\021[\\\021\018E\002\\qGY\\\021\018\127\002\018\\2\021\\6\018OYbbYnnYG\\2\024qu"),
                    Media = objStaatsstreich
                  },
                  {Text = vEndeMeldung, Media = objBilanz},
                  {
                    Text = _DTX("\017Gnb\024q\\\018\abGD\018") .. vUrsache,
                    Media = objVester
                  },
                  {
                    Text = Player.Name .. _DTX("(\018rbn\0182nY\018\020b\018\\\024qY\018n\024qbr\\u\018U\024q\018qb\\YY\\\018\\n\018t2G\018n\025\018[\\[\025\\\021\021Yu"),
                    Media = objKlaus
                  }
                }, function(action)
                  objKlausdenktnach:RequestSync()
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end)
              elseif vParadies == true then
                Wherigo.PlayAudio(objaudioparadies)
                _Urwigo.Dialog(false, {
                  {
                    Text = _DTX("~\\n\024qbEEY\018#\018\002\021r\018\a2\\0\018"),
                    Media = objVester
                  },
                  {
                    Text = _DTX("t\002\018qbnY\018b\002n\018r\\6\018U\021r\002nYG2\\4b\021r\018\\2\021\018\tbGbr2\\n\018[\\n\024qbEE\\\021u\018f\\nv\\!Y0"),
                    Media = objParadies
                  },
                  {Text = vEndeMeldung, Media = objBilanz},
                  {
                    Text = _DTX("\014\\Y\127Y\018\021266\018r2\\\018p\025\025Gr2\021bY\\\021\018\002\021r\018YGb[\\\018t2\024q\0182\021n\018.\002\024q\018r\\G\018\b\\G\021\\Y\127Y\\\021\018t\\\021!\\G\018\\2\0210\026.fJU\024q\018\a\\Gr\\\018t2\024q\018\020\\r\025\024q\018q2\\G\018S\\G4bnn\\\021u\018t\002\018qbnY\0186\\2\021\\\018{24E\\\018\0212\024qY\0186\\qG\018\021\025\\Y2[u"),
                    Media = objVester
                  },
                  {
                    Text = Player.Name .. _DTX("(\0182\024q\018=2\021\018=\\[\\2nY\\GY0\018t\002\018\abGnY\018nv2Y\127\\\018#\018\020\\Y\127Y\018=2\021\0182\024q\018b\002E\018rbn\018,2\021b4\\\018[\\nvb\021\021Y0"),
                    Media = objKlaus
                  }
                }, function(action)
                  objKoordinaten1:MoveTo(Player)
                  objErfolgreichregiert()
                  objFredericVester.Visible = false
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end)
              else
                Wherigo.PlayAudio(objaudiotusch)
                _Urwigo.Dialog(false, {
                  {
                    Text = _DTX("~\\n\024qbEEY0\018t\002\018qbnY\018\005$\018f\002\021r\\\021\018\\GE\0254[G\\2\024q\018rbn\018U\021r\002nYG2\\4b\021r\018G\\[2\\GY0"),
                    Media = objVester
                  },
                  {Text = vEndeMeldung, Media = objBilanz},
                  {
                    Text = Player.Name .. _DTX("(\0182\024q\018=2\021\018=\\[\\2nY\\GY0\018t\002\018\abGnY\018nv2Y\127\\\018#\018\020\\Y\127Y\018=2\021\0182\024q\018b\002E\018rbn\018,2\021b4\\\018[\\nvb\021\021Y0"),
                    Media = objKlaus
                  }
                }, function(action)
                  if vBilanz > 80 then
                    _Urwigo.MessageBox({
                      Text = _DTX("t\002\018=2nY\018\\2\021\018\abqG\\n\018!L=\\G\021\\Y2n\024q\\n\018~\\\0212\\0\018k\\\021\021\0186\\qG\018\a2\\\018t\002\018b\021\018\\\021Yn\024q\\2r\\\021r\\G\018OY\\44\\\018n2Y\127\\\021\018\a\002\\Gr\\\021(\018\ab\\G\\\018\002\021n\\G\\\018k\\4Y\018\\2\021\\\018=\\nn\\G\\0\026.fJ\014\\Y\127Y\018\021266\018r2\\\018p\025\025Gr2\021bY\\\021\018\002\021r\018YGb[\\\018t2\024q\0182\021n\018.\002\024q\018r\\G\018\b\\G\021\\Y\127Y\\\021\018t\\\021!\\G\018\\2\0210\026.fJU\024q\018\a\\Gr\\\018t2\024q\018\020\\r\025\024q\018q2\\G\018S\\G4bnn\\\021u\018t\002\018qbnY\0186\\2\021\\\018{24E\\\018\0212\024qY\0186\\qG\018\021\025\\Y2[u"),
                      Media = objVester,
                      Callback = function(action)
                        if action ~= nil then
                          objErfolgreichregiert()
                          objKoordinaten1:MoveTo(Player)
                          objFredericVester.Visible = false
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  elseif vBilanz > 60 then
                    _Urwigo.MessageBox({
                      Text = _DTX("t\002\018qbnY\018rbn\01832\\4\01862Y\018.GbS\025\002G\018\\GG\\2\024qYu\018t\002G\024q\018!4\002[\\\018\v\021Yn\024q\\2r\002\021[\\\021\018\002\021r\018S\025Gb\002nn\024qb\002\\\021r\\n\018OY\\\002\\G\021\018qbnY\018t\002\018rbn\018U\021r\002nYG2\\4b\021r\018\0026\018\\2\0212[\\n\018S\\G=\\nn\\GYu\026.fJ\014\\Y\127Y\018\021266\018r2\\\018p\025\025Gr2\021bY\\\021\018\002\021r\018YGb[\\\018t2\024q\0182\021n\018.\002\024q\018r\\G\018\b\\G\021\\Y\127Y\\\021\018t\\\021!\\G\018\\2\0210\026.fJU\024q\018\a\\Gr\\\018t2\024q\018\020\\r\025\024q\018q2\\G\018S\\G4bnn\\\021u\018t\002\018qbnY\0186\\2\021\\\018{24E\\\018\0212\024qY\0186\\qG\018\021\025\\Y2[u"),
                      Media = objVester,
                      Callback = function(action)
                        if action ~= nil then
                          objErfolgreichregiert()
                          objKoordinaten1:MoveTo(Player)
                          objFredericVester.Visible = false
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  elseif vBilanz > 40 then
                    _Urwigo.MessageBox({
                      Text = _DTX("t\002\018=2n\01862Y\018r\\\021\018f\002\\\024!\a2G!\002\021[\\\021\018r\\n\018k2G!\002\021[n[\\E\002\\[\\n\018\\2\0212[\\G6bnn\\\021\018\127\002G\\\024q[\\!\02566\\\021(\018\a\\\021\021\018b\024\002q\018r2\\\018+\002n[b\021[n4b[\\\018\0212\024qY\018[\\Gbr\\\018\0026\a\\GE\\\021r\018S\\G=nn\\GY\018\a\025Gr\\\021\0182nYu\018U66\\Gq2\021\018[2=Y\018\\n\018\\2\021\018nYb=24\\n\018~4\\2\024q[\\\a2\024qY(\018rbn\018r\\\021\018OYb\021r\018\\2\021\\G\018[\\\a2nn\\\021\018\006\\=\\\021n_\002b42Yb\\Y\018b\002\024q\018E\002\\G\018r2\\\0183\002!\002\021EY\018n2\024q\\GYu\026.fJ\014\\Y\127Y\018\021266\018r2\\\018p\025\025Gr2\021bY\\\021\018\002\021r\018YGb[\\\018t2\024q\0182\021n\018.\002\024q\018r\\G\018\b\\G\021\\Y\127Y\\\021\018t\\\021!\\G\018\\2\0210\026.fJU\024q\018\a\\Gr\\\018t2\024q\018\020\\r\025\024q\018q2\\G\018S\\G4bnn\\\021u\018t\002\018qbnY\0186\\2\021\\\018{24E\\\018\0212\024qY\0186\\qG\018\021\025\\Y2[u"),
                      Media = objVester,
                      Callback = function(action)
                        if action ~= nil then
                          objErfolgreichregiert()
                          objKoordinaten1:MoveTo(Player)
                          objFredericVester.Visible = false
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  elseif vBilanz > 20 then
                    _Urwigo.MessageBox({
                      Text = _DTX(",\002\\G\018r\\\021\018+\021Eb\021[\018qbnY\018t\002\018r2\024q\018\0212\024qY\018n\024q4\\\024qY\018[\\n\024q4b[\\\021(\018r\\\021!nY\018b=\\G\018\abqGn\024q\\2\02142\024q\018\021\025\024q\018\127\002\018!\002G\127EG2nY2[u\026.fJ\014\\Y\127Y\018\021266\018r2\\\018p\025\025Gr2\021bY\\\021\018\002\021r\018YGb[\\\018t2\024q\0182\021n\018.\002\024q\018r\\G\018\b\\G\021\\Y\127Y\\\021\018t\\\021!\\G\018\\2\0210\026.fJU\024q\018\a\\Gr\\\018t2\024q\018\020\\r\025\024q\018q2\\G\018S\\G4bnn\\\021u\018t\002\018qbnY\0186\\2\021\\\018{24E\\\018\0212\024qY\0186\\qG\018\021\025\\Y2[u"),
                      Media = objVester,
                      Callback = function(action)
                        if action ~= nil then
                          objErfolgreichregiert()
                          objKoordinaten1:MoveTo(Player)
                          objFredericVester.Visible = false
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = _DTX("\0176\018\127\002\018\\2\021\\6\018[\002Y\\\021\018OY\\\002\\G6b\021\021\018\127\002\018\a\\Gr\\\021(\0186\002nnY\018t\002\0184\\G\021\\\021(\018S\025Gb\002nn\024qb\\\002\021r\\G\018\127\002\018r\\\021!\\\021\018\002\021r\018k\\\024qn\\4\a2G!\002\021[\\\021\018\127\002\018=\\G\002\\\024!n2\024qY2[\\\021u\018tb\021\021\018\a\\Gr\\\021\0182qG\\\018\v\021Yn\024q\\2r\002\021[\\\021\018\a\\\0212[\\G\018\002\021G\\E4\\!Y2\\GY\018=\127\au\018\a\\\0212[\\G\018q\\EY2[\018\002\021r\018t\002\0184\\G\021nY\018!\002G\127n2\024qY2[\\(\018\002\\=\\GnY\\\002\\GY\\\018f\\b!Y2\025\021\\\021\018\127\002\018S\\G6\\2r\\\021u\026.fJ\014\\Y\127Y\018\021266\018r2\\\018p\025\025Gr2\021bY\\\021\018\002\021r\018YGb[\\\018t2\024q\0182\021n\018.\002\024q\018r\\G\018\b\\G\021\\Y\127Y\\\021\018t\\\021!\\G\018\\2\0210\026.fJU\024q\018\a\\Gr\\\018t2\024q\018\020\\r\025\024q\018q2\\G\018S\\G4bnn\\\021u\018t\002\018qbnY\0186\\2\021\\\018{24E\\\018\0212\024qY\0186\\qG\018\021\025\\Y2[u"),
                      Media = objVester,
                      Callback = function(action)
                        if action ~= nil then
                          objErfolgreichregiert()
                          objKoordinaten1:MoveTo(Player)
                          objFredericVester.Visible = false
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  end
                end)
              end
            end)
          end)
        else
          _Urwigo.MessageBox({
            Text = _DTX("\016!bLu\018tb\021\021\018\002\\=\\G4\\[\\\018\021\025\024q6b40"),
            Media = objVester,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function objFredericVester:OncmdInvestieren(target)
  if Wherigo.NoCaseEquals(_G[currentZone].Name, _DTX("\tG\025r\002!Y2\025\021")) then
    if vfirstAPPro == false then
      objProduktion1.Text = (((_DTX("t\\G\018.\\G\\2\024q\018\tG\025r\002!Y2\025\021\018nY\\qY\018=\\2\018") .. vAPProduktion) .. _DTX("\018\t\002\021!Y\\\021\018\002\021r\018t\002\018!b\021\021nY\018")) .. vIntAktionspunkte) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\G\\\021u\018")
    else
      objProduktion1.Text = (((((_DTX("t\\G\018.\\G\\2\024q\018\tG\025r\002!Y2\025\021\018nY\\qY\018=\\2\018") .. vIntAPPro + vAPProduktion) .. _DTX("\018\t\002\021!Y\\\021u\018t\002\018qbnY\018=\\G\\2Yn\018")) .. vIntAPPro) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\GY\018\002\021r\018t\002\018qbnY\018\021\025\024q\018")) .. vIntAktionspunkte) .. _DTX("\018\127\002G\018\b\\GE\002\\[\002\021[u\018")
    end
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objProduktion1)
    end)
  elseif Wherigo.NoCaseEquals(_G[currentZone].Name, _DTX("Ob\0212\\G\002\021[")) then
    if vfirstAPSan == false then
      objSanierung1.Text = (((_DTX("t\\G\018.\\G\\2\024q\018Ob\0212\\G\002\021[\018nY\\qY\018=\\2\018") .. vAPSanierung) .. _DTX("\018\t\002\021!Y\\\021\018\002\021r\018t\002\018!b\021\021nY\018")) .. vIntAktionspunkte) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\G\\\021u\018")
    else
      objSanierung1.Text = (((((_DTX("t\\G\018.\\G\\2\024q\018Ob\0212\\G\002\021[\018nY\\qY\018=\\2\018") .. vIntAPSan + vAPSanierung) .. _DTX("\018\t\002\021!Y\\\021u\018t\002\018qbnY\018=\\G\\2Yn\018")) .. vIntAPSan) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\GY\018\002\021r\018t\002\018qbnY\018\021\025\024q\018")) .. vIntAktionspunkte) .. _DTX("\018\127\002G\018\b\\GE\002\\[\002\021[u\018")
    end
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objSanierung1)
    end)
  elseif Wherigo.NoCaseEquals(_G[currentZone].Name, _DTX("+\002E!4b\\G\002\021[")) then
    if vfirstAPAuf == false then
      objAufklaerung1.Text = (((_DTX("t\\G\018.\\G\\2\024q\018+\002E!4b\\G\002\021[\018nY\\qY\018=\\2\018") .. vAPAufklaerung) .. _DTX("\018\t\002\021!Y\\\021\018\002\021r\018t\002\018!b\021\021nY\018")) .. vIntAktionspunkte) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\G\\\021u\018")
    else
      objAufklaerung1.Text = (((((_DTX("t\\G\018.\\G\\2\024q\018+\002E!4b\\G\002\021[\018nY\\qY\018=\\2\018") .. vIntAPAuf + vAPAufklaerung) .. _DTX("\018\t\002\021!Y\\\021u\018t\002\018qbnY\018=\\G\\2Yn\018")) .. vIntAPAuf) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\GY\018\002\021r\018t\002\018qbnY\018\021\025\024q\018")) .. vIntAktionspunkte) .. _DTX("\018\127\002G\018\b\\GE\002\\[\002\021[u\018")
    end
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objAufklaerung1)
    end)
  elseif Wherigo.NoCaseEquals(_G[currentZone].Name, _DTX("\006\\=\\\021n_\002b42Yb\\Y")) then
    if vfirstAPLeb == false then
      objLebensqualitaet1.Text = (((_DTX("t\\G\018.\\G\\2\024q\018\006\\=\\\021n_\002b42Yb\\Y\018nY\\qY\018=\\2\018") .. vAPLebensqualitaet) .. _DTX("\018\t\002\021!Y\\\021\018\002\021r\018t\002\018!b\021\021nY\018")) .. vIntAktionspunkte) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\G\\\021u\018")
    else
      objLebensqualitaet1.Text = (((((_DTX("t\\G\018.\\G\\2\024q\018\006\\=\\\021n_\002b42Yb\\Y\018nY\\qY\018=\\2\018") .. vIntAPLeb + vAPLebensqualitaet) .. _DTX("\018\t\002\021!Y\\\021u\018t\002\018qbnY\018=\\G\\2Yn\018")) .. vIntAPLeb) .. _DTX("\018\t\002\021!Y\\\0182\021S\\nY2\\GY\018\002\021r\018t\002\018qbnY\018\021\025\024q\018")) .. vIntAktionspunkte) .. _DTX("\018\127\002G\018\b\\GE\002\\[\002\021[u\018")
    end
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objLebensqualitaet1)
    end)
  else
    _Urwigo.MessageBox({
      Text = _DTX("{2\\G\018!b\021\021nY\018t\002\018\0212\024qYn\0182\021S\\nY2\\G\\\0210\018O\024qb\002\018t2G\018=\\nn\\G\018rbn\018k2G!\002\021[n[\\E\002\\[\\\018b\021(\018\a2\\\018t\002\018r2\\n\\\021\018.\\G\\2\024q\018nY\\\002\\G\021\018!b\021\021nYu"),
      Media = objVester
    })
  end
end
function objFredericVester:OncmdWiestehtes(target)
  ErstelleZwischenmeldung()
  _Urwigo.MessageBox({
    Text = vMeldung,
    Media = objVester,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFredericVester:OncmdBilanz(target)
  ErstelleZwischenbilanz()
  _Urwigo.MessageBox({
    Text = ((((_DTX("t\\2\021\\\0186\0256\\\021Yb\021\\\018.24b\021\127\0182nY\018") .. vLF) .. vBilanz) .. _DTX("\018.24b\021\127v\002\021!Y\\")) .. vLF) .. vMeldung,
    Media = objVester,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFredericVester:OncmdHilfe(target)
  if objHinweise == 0 then
    objHinweise = objHinweise + 1
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("O\024qb\002\018t2G\018rbn\018k2G!\002\021[n[\\E\002\\[\\\0186b4\018[\\\021b\002\\G\018b\021u\018\v2\021\018G2\024qY2[\\n\018\030\\Y\127\01862Y\018\\2\021\\6\018f\\[\\4!G\\2n\0182nY\018\\n\018\0212\024qYu\018\b2\\46\\qG\018n2\021r\018\\n\018\127\a\\2\018[G\025?\\\018\0062\0212\\\021(\018r2\\\018\127\002\018+!Y2\025\021nv\002\021!Y\\\021\018E\002\\qG\\\021\018uuu"),
        Media = objVester
      },
      {
        Text = _DTX("t2\\\018\006\\=\\\021n_\002b42Yb\\Y\0182nY\018r\\G\018\127\\\021YGb4\\\018.\\G\\2\024q0"),
        Media = objWirkungsnetzqplan
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif objHinweise == 1 then
    objHinweise = objHinweise + 1
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("k2nn\\\021\0182nY\018gb\024qY0\018kbG\0026\018\a\025q4\018E\002\\G\024qY\\\021\018\0302\024qY#t\\6\025!GbY2\\\021\018\\2\021\018\025EE\\\021\\n\018U\021Y\\G\021\\Y-\018kbn\018\abG\018r\\G\018kbq4nvG\002\024q\018r\\G\018+\002E!4b\\G\002\021[D\018kb[\\\018\\n(\018tU\024q\018r\\2\021\\n\018\\2[\\\021\\\021\018\b\\GnYb\021r\\n\018\127\002\018=\\r2\\\021\\\021u\018\026.fJO\024qb\002\018t2G\018r2\\\018+\002n\a2G!\002\021[\\\021\018r\\n\018.\\G\\2\024q\\n\018+\002E!4b\\G\002\021[\018[\\\021b\002\\G\018b\021u\018\026.fJ+\002E!4b\\G\002\021[\018\a2G!Y\018r2G\\!Y\018\002\021r\0182\021r2G\\!Y\018b\002E\018r2\\\018\006\\=\\\021n_\002b42Yb\\Yu"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif objHinweise == 2 then
    objHinweise = objHinweise + 1
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("+=\\G\018k2nn\\\021\018b44\\2\021\\\018q24EY\018\0212\024qYu\018t2\\\018.\\S\025\\4!\\G\002\021[\018=Gb\002\024qY\018\\=\\\021n\025\018vqLn2n\024q\\\018\030bqG\002\021[u\018t2\\\018\tG\025r\002!Y2\025\021nGbY\\\0186\002nn\018\\=\\\021n\025\018n2\024q\018n\\4=nY\018YGb[\\\021\018!\025\\\021\021\\\021u\018t2\\\018O\024q\a\\44\\\0182nY\0184\\2\024qY\018\127\002\018\002\\=\\Gn\024qG\\2Y\\\021u"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif objHinweise == 3 then
    objHinweise = objHinweise + 1
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("\tbnn\018\020\\r\025\024q\018b\002Eu\018k\\\021\021\018n2\024q\018r2\\\018\tG\025r\002!Y2\025\021\018S\025\021\018b44\\2\021\\\018nY\\2[\\GY(\018nY\\2[Y\018b\002\024q\018r2\\\018\0176\a\\4Y=\\4bnY\002\021[u\018+4n\025\018S\\G[2nn\018r2\\\018Ob\0212\\G\002\021[\018\0212\024qYu"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif objHinweise == 4 then
    objHinweise = objHinweise + 1
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("+4n\025\018#\0182\021S\\nY2\\G\\\018\127\002\\GnY\0182\021\018\tG\025r\002!Y2\025\021\018#\018\\2\021\018\t\002\021!Y\018G\\2\024qY\018\a\025q4u\018\016r\\G-\018\017\021r\018!\002\\66\\G\\\018t2\024q\018rb\021\021\018\0026\018r2\\\018+\002E!4b\\G\002\021[u\026.fJU\021\018r\\G\018,\0254[\\\018=\\\025=b\024qY\\\018r2\\\018\tG\025r\002!Y2\025\021\018\002\021r\018nY\\\002\\G\\\0184b\021[nb6\018r2\\\018Ob\0212\\G\002\021[\018\021b\024q\018#\018\025q\021\\\018r2\\\018+\002E!4b\\G\002\021[\018\127\002\018S\\G\021b\024q4b\\nn2[\\\021u"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    objFredericVester.Commands.cmdHilfe.Enabled = false
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("g\\qG\018{2\021\a\\2n\\\018!b\021\021\0182\024q\018t2G\018=\\26\018=\\nY\\\021\018k244\\\021\018\0212\024qY\0186\\qG\018[\\=\\\021u"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objFredericVester:OncmdAnleitung(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("\b\\G\021\\Y\127Y\\n\018t\\\021!\\\021\0182nY\018\a2\024qY2[\018#\018b=\\G\018r2\\\018Bq\\\025G2\\\018b44\\2\021\\\018q24EY\018\0212\024qYu\026.fJtbn\018\006\\=\\\021\018Y\025=Y\0182\021\018r\\G\018\tGbl2nu\018\017\021r\018\006\\G\021\\\021\018=\\r\\\002Y\\Y\0186b\024q\\\021u\018"),
      Media = objVester
    },
    {
      Text = _DTX("+4n\025\018S\\Gn\002\024q\018t2\024q\0182\021\018r\\G\018\006\\\021!\002\021[\018\\2\021\\n\018U\021r\002nYG2\\4b\021r\\n\018\002\021r\018\\GEbqG\\\018n\025\018b6\018=\\nY\\\021(\018\a2\\\018r2\\\018S\\Gn\024q2\\r\\\021\\\021\018.\\G\\2\024q\\\018\\2\021\\G\018~\\n\\44n\024qbEY\018#\018\tG\025r\002!Y2\025\021(\018Ob\0212\\G\002\021[(\018\0176\a\\4Y=\\4bnY\002\021[(\018\006\\=\\\021n_\002b42Yb\\Y(\018+\002E!4b\\G\002\021[(\018\b\\G6\\qG\002\021[nGbY\\(\018.\\S\025\\4!\\G\002\021[\018\002\021r\018\t\02542Y2!\018#\018\127\002nb66\\\021qb\\\021[\\\021\018\002\021r\018r2\\\018{b\021r4\002\021[nEb\\q2[!\\2Y\018\\2\021\\G\018f\\[2\\G\002\021[\018=\\\\2\021E4\002nn\\\021u"),
      Media = objVester
    },
    {
      Text = _DTX("k\\\021\021\018t\002\018\005$\018f\002\021r\\\021\018\002\\=\\GnY\\qnY(\018qbnY\018t\002\018\\2\021\\\018.\\4\025q\021\002\021[\018S\\Gr2\\\021Y\018\002\021r\018t\002\018rbGEnY\018t2\024q\01826\018x.\002\024q\018r\\G\018S\\G\021\\Y\127Y\\\021\018t\\\021!\\Gx\018\\2\021YGb[\\\021u"),
      Media = objVester
    },
    {
      Text = _DTX("\030\002\021\018n\024qb\002\018t2\024q\018\0026\018\002\021r\018E2\021r\\\018t\\2\021\\\021\018k\\[\0182\021n\018U\021\002r\002nYG2\\4b\021r0\018\026.fJ\026.fJ\030\002G\018g\002Y(\018b44\\n\018\abn\018t\002\018\a2nn\\\021\0186\002nnY(\018E2\021r\\nY\018t\002\018\\=\\\021n\025u"),
      Media = objVester
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objKlausMastermindKlabuster:Oncmdmachmalwas(target)
  if objFredericVester.Visible == false then
    _Urwigo.MessageBox({
      Text = _DTX("\b2\\44\\2\024qY\018n\02544Y\\\021\018\a2G\018\002\021n\0186b4\0182\021\018f\002q\\\018q2\021n\\Y\127\\\021\018\002\021r\018\021b\024qr\\\021!\\\021\018#\018\025r\\G\0186b4\018r2\\\018+\0214\\2Y\002\021[\018nY\002r2\\G\\\021u"),
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          if objVernetztesDenken.Visible == false then
            _Urwigo.MessageBox({
              Text = _DTX("+\018vG\025\018v\025n\018+\0214\\2Y\002\021[-\018>\021=nv9k\025\0182nY\018r2\\-\018{bnY\018t\002\0182G[\\\021r\a\025\018\\2\021\018.\002\024q\018[\\n\\q\\\021-"),
              Media = objKlaus,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.2 then
      _Urwigo.MessageBox({
        Text = _DTX("t\002\018=2nY\018\a2Y\1272[\018#\018\a\\\021\021\0182\024q\018b44\\n\018!\025\\\021\021Y\\(\018\ab\\GnY\018t\002\018\0212\024qY\018q2\\G0"),
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.4 then
      _Urwigo.MessageBox({
        Text = _DTX("k2\\\018n\025\0182\024q-\018U\024q\018=Gb\002\024q\\\018r\025\024q\018{24E\\0"),
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.6 then
      _Urwigo.MessageBox({
        Text = _DTX("\030b\018\020b\018#\018p\025\\\021\021\\\021\018Yb\\Y\0182\024q\018n\024q\025\021(\018b=\\G\018r\002\\GE\\\021\018YGb\002\0182\024q\01862\024q\018\0212\024qYu"),
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.8 then
      _Urwigo.MessageBox({
        Text = _DTX("\014b\018\020b\018#\018\\GnY\018{24E\\\018b\021=2\\Y\\\021(\018rb\021\021\018\\2\021\\\021\018f\002\\\024!\1272\\q\\G\0186b\024q\\\021u"),
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _DTX("k2\\\018n\025\0182\024q-\018.2\021\0182\024q\018r\\\021\018\tG\025E\\nn\025G-\018\016r\\G\018[bG\018r2\\\018{24E\\-"),
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end
end
function objVernetztesDenken:Oncmdlesen(target)
  if objBuchLesen == false then
    Wherigo.PlayAudio(objaudioportal)
    objPortal1.Visible = true
    objFredericVester.Visible = true
    objBuchLesen = true
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("O\\qG\018[\002Yu\018t\002\018qbnY\0186\\2\021\018.\002\024q\018[\\E\002\021r\\\021\018\002\021r\018=2nY\018\021\\\002[2\\G2[u\018\026.fJ\026.fJt\025\024q\018[Gb\002\0182nY\018b44\\\018Bq\\\025G2\\u\018tbn\018\006\\=\\\021\018Y\025=Y\0182\021\018r\\G\018\tGbl2nu\018\017\021r\018\006\\G\021\\\021\018=\\r\\\002Y\\Y\0186b\024q\\\021u\018\026.fJ"),
        Media = objVester
      },
      {
        Text = _DTX("+4n\025\018S\\Gn\002\024q\018t2\024q\0182\021\018r\\G\018\006\\\021!\002\021[\018\\2\021\\n\018U\021r\002nYG2\\4b\021r\\n\018\002\021r\018\\GEbqG\\\018n\025\018b6\018=\\nY\\\021(\018\a2\\\018r2\\\018S\\Gn\024q2\\r\\\021\\\021\018.\\G\\2\024q\\\018\\2\021\\G\018~\\n\\44n\024qbEY\018#\018\tG\025r\002!Y2\025\021(\018Ob\0212\\G\002\021[(\018\0176\a\\4Y=\\4bnY\002\021[(\018\006\\=\\\021n_\002b42Yb\\Y(\018+\002E!4b\\G\002\021[(\018\b\\G6\\qG\002\021[nGbY\\(\018.\\S\025\\4!\\G\002\021[\018\002\021r\018\t\02542Y2!\018#\018\127\002nb66\\\021qb\\\021[\\\021\018\002\021r\018r2\\\018{b\021r4\002\021[nEb\\q2[!\\2Y\018\\2\021\\G\018f\\[2\\G\002\021[\018=\\\\2\021E4\002nn\\\021u"),
        Media = objVester
      },
      {
        Text = _DTX("k\\\021\021\018t\002\018\005$\018f\002\021r\\\021\018\002\\=\\GnY\\qnY(\018qbnY\018t\002\018\\2\021\\\018.\\4\025q\021\002\021[\018S\\Gr2\\\021Y\018\002\021r\018t\002\018rbGEnY\018t2\024q\01826\018x.\002\024q\018r\\G\018S\\G\021\\Y\127Y\\\021\018t\\\021!\\Gx\018\\2\021YGb[\\\021u"),
        Media = objVester
      },
      {
        Text = _DTX("\030\002\021\018n\024qb\002\018t2\024q\018\0026\018\002\021r\018E2\021r\\\018t\\2\021\\\021\018k\\[\0182\021n\018U\021\002r\002nYG2\\4b\021r0\018\026.fJ\026.fJ\030\002G\018g\002Y(\018b44\\n\018\abn\018t\002\018\a2nn\\\021\0186\002nnY(\018E2\021r\\nY\018t\002\018\\=\\\021n\025u"),
        Media = objVester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _DTX("O\\qG\018[\002Yu\018\b\\G\021\\Y\127Y\\n\018t\\\021!\\\021\0182\021Y\\G\\nn2\\GY\018t2\024q\018b4n\025u\018\026.fJ\026.fJ\030\\=\\\021\018r\\6\018E\\q4\\\021r\\\021\018\b\\GnYb\\\021r\0212n\018\002\\=\\G\018r2\\\0183\002nb66\\\021qb\\\021[\\\018S\025\021\018\017Gnb\024q\\\018\002\021r\018k2G!\002\021[\018n2\021r\018\\n\018\021b\024q\018t2\\YG2\024q\018t\025\\G\021\\G\018r2\\\018E\0254[\\\021r\\\021\018n\\\024qn\018,\\q4\\G\01826\018\0176[b\021[\01862Y\018p\0256v4\\l2Yb\\Y(\018r2\\\018\\n\018\127\002\018=\\q\\GGn\024q\\\021\018[24YD\026.fJ\005u\018,b4n\024q\\\01832\\4E\\nY4\\[\002\021[\026.fJ\018>\021=nv9>\021=nv9uuuuuuu\018E\002\\qGY\018\127\002\018f\\vbGbY\002Gr2\\\021nYS\\Gqb4Y\\\021\026.fJ$u\018,\025!\002n\018b\002E\018tbY\\\021nb664\002\021[\026.fJ\018>\021=nv9>\021=nv9uuuuuuuu\018E\002\\qGY\018\127\002\018\002\021S\\G\021\\Y\127Y\\G\018O2Y\002bY2\025\021nb\021b4Ln\\\026.fJmu\018UGG\\S\\Gn2=4\\\018O\024q\a\\Gv\002\021!Y=24r\002\021[\026.fJ\018>\021=nv9>\021=nv9uuuuuuuu\018S\\Gq2\021r\\GY\018r\\\021\018.42\024!\018b\002E\018rbn\018~b\021\127\\\026.fJ\fu\018\017\021=\\b\024qY\\Y\\\018\030\\=\\\021\a2G!\002\021[\\\021\026.fJ\018>\021=nv9>\021=nv9uuuuuuu\018\a\\24\018!\\2\021\\\018k\\\021\021#tb\021\021#,Gb[\\\021\026.fJ;u\018B\\\021r\\\021\127\018\127\002G\018\017\\=\\GnY\\\002\\G\002\021[\026.fJ\018>\021=nv9>\021=nv9uuuuuu\018\a\\24\018!\\2\021\018\b\\GnYb\\\021r\0212n\018E\002\\G\0183\\2YS\\G\127\025\\[\\G\002\021[\026.fJau\018B\\\021r\\\021\127\018\127\002\018b\002Y\025G2Yb\\G\\6\018\b\\Gqb4Y\\\021\026.fJ\018>\021=nv9>\021=nv9uuuuuu\018E\002\\qGY\018\127\002\018r2!YbY\025G2n\024q\\6\018\b\\Gqb4Y\\\021\026.fJ"),
        Media = objVester
      },
      {
        Text = _DTX("+\002E\018r\\\021\018E\0254[\\\021r\\\021\018O\\2Y\\\021\018\\GEb\\qGnY\018t\002\018\\Y\abn\018\002\\=\\G\018k\\\024qn\\4\a2G!\002\021[\\\021u\018t\\\021\021\018b\002n\018r\\G\018p\\\021\021Y\0212n\018r\\G\018B\\24\\\018\\2\021\\n\018OLnY\\6n\0182nY\018\021\025\024q\018\0212\024qY\018S2\\4\018[\\\a\025\021\021\\\021u\018\v\021Yn\024q\\2r\\\021r\0182nY\018rbn\0183\002nb66\\\021\a2G!\\\021\018\002\021r\018rb62Y\018r2\\\018p\\\021\021Y\0212n\018\002\\=\\G\018r2\\\018k\\\024qn\\4\a2G!\002\021[\\\021u\018\026.fJt2\\n\\\018k\\\024qn\\4\a2G!\002\021[\\\021\0184bnn\\\021\018n2\024q\018\a2\\\018E\0254[Y\018\024qbGb!Y\\G2n2\\G\\\021D\026.fJ#\01842\021\\bG\\\018.\\\1272\\q\002\021[\\\021\018\026.fJ#\018\\2\021Eb\024q\\\018\0212\024qY#42\021\\bG\\\018.\\\1272\\q\002\021[\\\021\026.fJ#\018.\\\1272\\q\002\021[\\\021\018q\025\\q\\G\\G\018\016Gr\021\002\021[\026.fJ#\018k2G!\002\021[\\\021\01862Y\018~G\\\021\127#\018\002\021r\018O\024q\a\\44\\\021\a\\GY\\\021\026.fJ#\018k2G!\002\021[\\\021\01862Y\018f\002\\\024!!\025vv4\002\021[\\\021\026.fJ#\018k2G!\002\021[\\\021\01862Y\018\127\\2Y42\024q\\G\018\b\\G\127\025\\[\\G\002\021["),
        Media = objVester
      },
      {
        Text = _DTX("\0062\021\\bG\\\018.\\\1272\\q\002\021[\\\021\026.fJ\026.fJ.\\2\01842\021\\bG\\\021\018.\\\1272\\q\002\021[\\\021\018S\\Gb\\\021r\\GY\018n2\024q\018r2\\\018k2G!\002\021[\0182\021\018[4\\2\024q\\6\018gbnn\\\018\a2\\\018r2\\\018\017Gnb\024q\\u\018\v2\021\018.\\2nv2\\4D\018\a\\\021\021\018\\2\021\\\018=\\nY266Y\\\018,bG=G2!\018\\2\021\\\018=\\nY266Y\\\018g\\\021[\\\018+=Eb44\018vG\025r\002\1272\\GY(\018vG\025r\002\1272\\G\\\021\018rG\\2\018r2\\n\\G\018,b=G2!\\\021\018r2\\\018rG\\2Eb\024q\\\018g\\\021[\\\018b\021\018+=Eb44u\018\026.fJ"),
        Media = objwirkunglinear
      },
      {
        Text = _DTX("\v2\021Eb\024q\\\018\0212\024qY#42\021\\bG\\\018.\\\1272\\q\002\021[\\\021\026.fJ\026.fJ.\\2\018\0212\024qY#42\021\\bG\\\021\018.\\\1272\\q\002\021[\\\021\018=\\G\002qY\018rbn\018k2G!\002\021[n[\\E\002\\[\\\018b\002E\018!\0256v4\\l\\G\\\021\0186bYq\\6bY2n\024q\\\021\018,\002\021!Y2\025\021\\\021u\018>\021=nv9{2\\G\127\002\018[\\q\025\\GY\018=\\2nv2\\4n\a\\2n\\\018rbn\018\\lv\025\021\\\021Y2\\44\\\018kb\024qnY\0026\018r\\G\018k\\4Y=\\S\025\\4!\\G\002\021[u"),
        Media = objwirkungnichtlinear
      },
      {
        Text = _DTX(".\\\1272\\q\002\021[\\\021\018q\025\\q\\G\\G\018\016Gr\021\002\021[\026.fJ\026.fJt2\\n\\\018\0212\024qY#42\021\\bG\\\021\018.\\\1272\\q\002\021[\\\021\018!\025\021\021\\\021\0182\021\0182qG\\G\018p\0256v4\\l2Yb\\Y\018=\\42\\=2[\018[\\nY\\2[\\GY\018\a\\Gr\\\021u\018\v2\021\018.\\2nv2\\4\018b\002n\018r\\G\018\0176\a\\4Y\0182nY\018r2\\\018O\\4=nYG\\2\0212[\002\021[n!GbEY\018\\2\021\\n\018~\\\ab\\nn\\Gn(\018r2\\\018b=\018\\2\021\\6\018=\\nY266Y\\\021\018\b\\Gn\024q6\002Y\127\002\021[n[Gbr\018\0212\024qY\0186\\qG\018\a2G!\\\021\018!b\021\021\018\002\021r\018r\\G\018O\\\\\018\0026!2vvYu"),
        Media = objwirkunghoehererordnung
      },
      {
        Text = _DTX("k2G!\002\021[\\\021\01862Y\018~G\\\021\127#\018\002\021r\018O\024q\a\\44\\\021\a\\GY\\\021\026.fJ\026.fJ.\\26\018Ovb\021\021\\\021\018\\2\021\\n\018.\025[\\\021\018\a2Gr\018\\GnY\018b=\\G\018\\2\021\\G\018=\\nY266Y\\\021\018O\024q\a\\44\\\018r\\G\018\tE\\24\018E42\\[\\\021u\018Ovb\021\021Y\0186b\021\018r\\\021\018.\025[\\\021\018\020\\r\025\024q\018\127\002\018!Gb\\EY2[(\018=G2\024qY\018\\G\018\002\021r\018r\\G\018\tE\\24\018Eb\\44Y\018\127\002\018.\025r\\\021u"),
        Media = objwirkunggrenz
      },
      {
        Text = _DTX("k2G!\002\021[\\\021\01862Y\018v\025n2Y2S\\G\018f\002\\\024!!\025vv4\002\021[\026.fJ\026.fJ\t\025n2Y2S\\\018f\002\\\024!!\025vv4\002\021[\018=\\r\\\002Y\\Y(\018rbnn\018n2\024q\018k2G!\002\021[\018\002\021r\018f\002\\\024!!\025vv4\002\021[\018S\\GnYb\\G!\\\021u\026.fJ\014\\\0186\\qG\018g\\\021n\024q\\\021\018\\n\018[2=Y(\018r\\nY\025\0186\\qG\018p2\021r\\G\018!\025\\\021\021\\\018[\\\127\\\002[Y\018\a\\Gr\\\021(\018r2\\\018\a2\\r\\G\0026\0186\\qG\018p2\021r\\G\018\127\\\002[\\\021\018!\025\\\021\021\\\021\018\\Y\024u\018t\\G\018\0212\024qY#42\021\\bG\\\018\\lv\025\021\\\021Y2\\44\\\018\b\\G4b\002E\018!\02566Y\018q2\\G\018r\002G\024q\018r2\\\018v\025n2Y2S\\\018f\002\\\024!!\025vv4\002\021[\018\127\002nYb\021r\\u"),
        Media = objwirkungposrueck
      },
      {
        Text = _DTX("k2G!\002\021[\\\021\01862Y\018\021\\[bY2S\\G\018f\002\\\024!!\025vv4\002\021[\026.fJ\026.fJ.\\2\018\\2\021\\G\018\021\\[bY2S\\\021\018f\002\\\024!!\025vv4\002\021[\018S\\G4b\002E\\\021\018k2G!\002\021[\018\002\021r\018f\002\\\024!\a2G!\002\021[\018\\\021Y[\\[\\\021[\\n\\Y\127Yu\018\026.fJt2\\\0183\002\021bq6\\\018r\\G\018.\\S\025\\4!\\G\002\021[\018E\002\\qGY\018\127\002\018\\2\021\\G\018[G\025\\nn\\G\\\021\018t2\024qY\\(\018r2\\\018\127\002\018q\025\\q\\G\\6\018OBG\\nn\018\002\021r\018rb62Y\018\127\002\018[\\G2\021[\\G\\G\018\006\\=\\\021n\\G\abGY\002\021[\018\002\021r\018\017\021EG\002\024qY=bG!\\2Y\018\002\021r\018rb62Y\018\127\002\018\\2\021\\G\018+=\021bq6\\\018r\\G\018.\\S\025\\4!\\G\002\021[\018E\002\\qGYu\026.fJg2Y\018\\2\021\\G\018\021\\[bY2S\\\021\018f\002\\\024!!\025vv4\002\021[\018!\025\\\021\021\\\021\018OLnY\\6\\\018n2\024q\018n\\4=nY\018nYb=242n2\\G\\\021u"),
        Media = objwirkungposrueck
      },
      {
        Text = _DTX("k2G!\002\021[\\\021\01862Y\018S\\Gn\024qb\024qY\\4Y\\G\018f\002\\\024!!\025vv4\002\021[\026.fJ\026.fJOLnY\\6\\!\025\\\021\021\\\018b=\\G\018b\002\024q\018S\\Gn\024q2\\r\\\021\\\021\018f\002\\\024!!\025vv4\002\021[n!G\\2n\\\021\018[4\\2\024q\127\\2Y2[\018b\021[\\q\025\\G\\\021u\018\v2\021\018.\\2nv2\\4\0182nY\018r2\\\018p\\G\127\\\021E4b66\\D\018\014\\\018[G\025\\nn\\G\018r2\\\018,4b66\\(\018r\\nY\025\0186\\qG\018kb\024qn\018\a2Gr\018S\\GE4\002\\nn2[Y\018\002\021r\0182\021\018r\\\021\018t\025\024qY\018[\\n\025[\\\021u\018t2\\\018,4b66\\\018\a2Gr\018[G\025\\nn\\G\018\002\021r\018S\\G=G\\\021\021Y\0186\\qG\018kb\024qn(\018r\\G\018\030b\024qn\024q\002=\018!\02566Y\018\020\\r\025\024q\018\0212\024qY\01862Y\018\002\021r\018r\\G\018t\025\024qY\018n\\4=nY\018=\\[2\021\021Y\018\127\002\018S\\G[4266\\\021\018\002\021r\018\a2Gr\018!\002\\G\127\\Gu\018tb62Y\018\a2Gr\018b\002\024q\018r2\\\018,4b66\\\018!4\\2\021\\G\018\002\021r\018r\\G\018t\025\024qY\018!b\021\021\018\a2\\r\\G\0186\\qG\018kb\024qn\018b\002E\021\\q6\\\021(\018\a\025r\002G\024q\018r2\\\018,4b66\\\018\a2\\r\\G\018\ab\\\024qnYu\026.fJ"),
        Media = objwirkungposrueck
      },
      {
        Text = _DTX("k2G!\002\021[\\\021\01862Y\018\127\\2Y42\024q\\G\018\b\\G\127\025\\[\\G\002\021[\026.fJ\026.fJO\024q42\\nn42\024q\0182nY\018\021\\=\\\021\018r\\G\018v\025n2Y2S\\\021\018\025r\\G\018\021\\[bY2S\\\021\018f\002\\\024!!\025vv4\002\021[\018b\002\024q\018r\\G\018\127\\2Y42\024q\\\018\b\\G4b\002E\018\127\002\018=\\YGb\024qY\\\021u\018>\021=nv9O\025=b4r\018r2\\\018f\002\\\024!!\025vv4\002\021[\018S\\G\127\025\\[\\GY\018\\2\021YG2YY(\0182nY\018r2\\n\018=\\2\018p\025GG\\!Y\002G6bnn\021bq6\\\021\01862Y\018\127\002\018=\\G\002\\\024!n2\024qY2[\\\021(\018\0026\018\\2\021\018\017\\=\\GnY\\\002\\G\021\018\127\002\018S\\G6\\2r\\\021u\018~\\Gbr\\\018=\\2\018S\\Gn\024qb\024qY\\4Y\\\021\018f\\[\\4!G\\2n\\\021\018\002\\=\\G\0186\\qG\\G\\\018OY\002E\\\021\018!b\021\021\018\\n\018\127\002\018G\\[\\4G\\\024qY\\\021\0183\\2Y=\0256=\\\021\018!\02566\\\021(\018\a\\\021\021\018[\\G\\[\\4Y\\\018~G\025\\nn\\\021\018\\GnY\018\021b\024q\018S2\\4\\\021\0183\a2n\024q\\\021[42\\r\\G\021\018\a2\\r\\G\018b\002E\018n2\024q\018n\\4=nY\018\a2G!\\\021u"),
        Media = objwirkungzeit
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objVernetztesDenken:Oncmdmitnehmen(target)
  objVernetztesDenken:MoveTo(Player)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objVernetztesDenken:OnvLF(target)
  objVernetztesDenken:MoveTo(_G[currentZone])
  objVernetztesDenken.Commands.vLF.Enabled = false
  objVernetztesDenken.Commands.cmdmitnehmen.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objWirkungsgefuege1:Oncmdanzeigen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("t\002\018E2\021r\\nY\018r2\\\018\\2\021\127\\4\021\\\021\018Bb=\\44\\\021\0182\021\018t\\2\021\\6\018U\021S\\\021YbGu"),
      Media = objVester
    }
  }, function(action)
    objTabelleSanierungUmweltbelastung.Visible = true
    objTabelleSanierungSanierung.Visible = true
    objTabelleProduktionProduktion.Visible = true
    objTabelleProduktionUmweltbelastung.Visible = true
    objTabelleUmweltbelastungUmweltbelastung.Visible = true
    objTabelleUmweltbelastungLebensqualitaet.Visible = true
    objTabelleAufklaerungAufklaerung.Visible = true
    objTabelleAufklaerungLebensqualitaet.Visible = true
    objTabelleAufklaerungVermehrungsrate.Visible = true
    objTabelleLebensqualitateLebensqualitaet.Visible = true
    objTabelleLebensqualitaetVermehrungsrate.Visible = true
    objTabelleLebensqualitaetPolitik.Visible = true
    objTabelleVermehrungsrateBevoelkerung.Visible = true
    objTabelleBevoelkerungLebensqualitaet.Visible = true
    objTabelleBevoelkerungAktionspunkte.Visible = true
    objTabellePolitikAktionspunkte.Visible = true
    objTabelleProduktionAktionspunkte.Visible = true
    objTabelleLebensqualitaetAktionspunkte.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objWirkungsgefuege1:Oncmdablegen(target)
  objWirkungsgefuege1:MoveTo(_G[currentZone])
  objWirkungsgefuege1.Commands.cmdaufnehmen.Enabled = true
  objWirkungsgefuege1.Commands.cmdablegen.Enabled = false
end
function objWirkungsgefuege1:Oncmdaufnehmen(target)
  objWirkungsgefuege1:MoveTo(Player)
  objWirkungsgefuege1.Commands.cmdaufnehmen.Enabled = false
  objWirkungsgefuege1.Commands.cmdablegen.Enabled = true
end
function objPortal1:Oncmdbetreten(target)
  if objFilmdose1.Visible == false then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objPortal2)
    end)
  else
    _Urwigo.MessageBox({
      Text = _DTX("{bnY\018t\002\018\0212\024qY\018\\Y\abn\018S\\G[\\nn\\\021-\018k244nY\018t\002\018YbYnb\\\024q42\024q\018r\002G\024q\018rbn\018\t\025GYb4\018\025q\021\\\018b\002E\127\002Gb\\\0026\\\021-"),
      Media = objVester
    })
  end
end
function objLebensqualitaet:Oncmdablegen(target)
  objLebensqualitaet:MoveTo(_G[currentZone])
  objLebensqualitaet.Commands.cmdaufnehmen.Enabled = true
  objLebensqualitaet.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objLebensqualitaet:Oncmdaufnehmen(target)
  objLebensqualitaet:MoveTo(Player)
  objLebensqualitaet.Commands.cmdablegen.Enabled = true
  objLebensqualitaet.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objLebensqualitaet:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("t2\\n\\G\018O\024q4\002\\nn\\4=\\G\\2\024q\018=\\YG\\2EEY\018~\\n\002\021rq\\2Y(\018k\025q4=\\E2\021r\\\021\018\002\021r\018O2\024q\\Gq\\2Y\018r\\G\018.\\S\025\\4!\\G\002\021[\018\002\021r\018n\024q42\\nnY\018rb62Y\018n2\021\021S\02544\\\018+G=\\2Y\018\002\021r\018\006\\=\\\021nnYb\021rbGr\018\\=\\\021n\025\018\\2\021\018\a2\\\018k\025q\021_\002b42Yb\\Y(\018,G\\2\127\\2Yb\021[\\=\025Y\018\002\021r\018\030bq\\Gq\0254\002\021[\018#\018\a\\nqb4=\018\\G\018S\025\021\018S2\\4\\\021\018O\\2Y\\\021\018=\\\\2\021E4\002nn=bG\0182nYu\018O\025\1272b4\\p\025\021Yb!Y\\\018\002\021r\018\\2\021\018qbG6\025\0212n\024q\\n\018,b6242\\\0214\\=\\\021\018[\\q\025\\G\\\021\018\\=\\\021n\025\018rb\127\002\018\a2\\\018p\002\021nY\018\002\021r\018Ov2\\4(\018\\2\021\018b!Y2S\\n\018O\\l\002b44\\=\\\021(\018[\\2nY2[\\\018+\021G\\[\002\021[\018\002\021r\018rbn\018\vGG\\2\024q\\\021\018\\2\021\\n\018q\025q\\\021\018+4Y\\Gn\0182\021\018[\\2nY2[\\G\018,G2n\024q\\u"),
      Media = objLeb
    },
    {
      Text = _DTX("tb62Y\0182nY\018r2\\\018\006\\=\\\021n_\002b42Yb\\Y\018b\002\024q\018rbn\018\\2[\\\021Y42\024q\\\018gbnn(\018r\\G\018U\021r2!bY\025G\018E\002\\G\018r\\\021\0183\002nYb\021r\018r\\n\018\006b\021r\\nu\018k\\\021\021\018n2\\\018b6\018.\025r\\\021\01842\\[Y(\018\a2Gr\018b\002\024q\018r2\\\018f\\[2\\G\002\021[\018\127\0026\018B\\\002E\\4\018[\\\020b[Y\018\002\021r\018rbn\018Ov2\\4\0182nY\018\127\002\018\v\021r\\u"),
      Media = objLeb
    },
    {
      Text = _DTX("t2\\\018O!b4b\018G\\2\024qY\018S\025\021\026.fJ#\018<\018>\021=nv93\002nnb6\021\\=G\002\024q(\018>\021=nv9{\002\021[\\G\018\002\021r\018\030\025Y\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9\002\\=\\G\01862n\\Gb=\\4\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv962YY\\46b\\nn2[\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9n\\qG\018r\002\\GEY2[(\018\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9[\002Y\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9n\\qG\018[\002Y\026.fJ#\018m<\018q\025\\\024qnY\\n\018k\025q4=\\E2\021r\\\021"),
      Media = objLeb
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objVermehrungsrate:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("{2\\G\018[\\qY\018\\n\018\0026\018r2\\\018\t\025v\0024bY2\025\021nrL\021b62!D\018b4n\025\018\0026\0183\002#\018\002\021r\018+=\ab\021r\\G\002\021[\018\002\021r\018\0026\018r2\\\018\b\\Gb\\\021r\\G\002\021[\018r\\G\018~\\=\002GY\\\021#\018\002\021r\018OY\\G=\\GbY\\u(\018E\002\\G\018r\\G\\\021\018+=n2\021!\\\021\018\021bY\002\\G42\024q\018\017\021Eb\\44\\\018\002\021r\018O\\\002\024q\\\021\018\\=\\\021n\025\018r\\G\018~G\002\021r\018n\\2\021\018!\025\\\021\021\\\021\018\a2\\\018\\2\021\\\018EG\\\a2442[\\\018~\\=\002GY\\\021!\025\021YG\02544\\u"),
      Media = objVer
    },
    {
      Text = _DTX("U\021\018r2\\\018\b\\G6\\qG\002\021[nGbY\\\0184b\\nnY\018n2\024q\018r\002G\024q\018r2\\\018f\\[2\\G\002\021[\018\0212\024qY\018r2G\\!Y\018\\2\021[G\\2E\\\021(\018\025=4\\2\024q\018\025EY\018r\\G\018\v2\021rG\002\024!\018\\\021YnY\\qY(\018r\002G\024q\018p2\021r\\G=\\2q24E\\\021\018\002\021r\018OY\\\002\\G\\G6b\\nn2[\002\021[\\\021\018\a\002\\Gr\\\018n2\\\018\\Gq\025\\qY(\018r\002G\024q\018\tG\025[Gb66\\\021\018r\\G\018,b6242\\\021v4b\021\002\021[\018[\\n\\\021!Yu"),
      Media = objVer
    },
    {
      Text = _DTX("U\021\018k2G!42\024q!\\2Y\018E\002\021!Y2\025\0212\\GY\018=\\2r\\n\018\0212\024qY\018#\018\a\\r\\G\018=\\2\018\002\021n\018\021\025\024q\0182\021\018\006b\\\021r\\G\021\018r\\G\018tG2YY\\\021\018k\\4Yu\018\b2\\4\018\\q\\G\018n2\021r\018\\n\018r\\G\018\006\\=\\\021nnYb\021rbGr(\018r2\\\018f\\42[2\025\021\018\002\021r\018r\\G\018~Gbr\018r\\G\018+\002E[\\n\024q4\025nn\\\021q\\2Y\018r\\n\018\v2\021\127\\4\021\\\021(\018r2\\\018q2\\G\018#\018\021\\=\\\021\018~\\n\002\021rq\\2Yn\127\002nYb\021r\018\002\021r\0186\\r2\1272\0212n\024q\\G\018{24E\\\018#\018\\2\021\\\018f\02544\\\018nv2\\4\\\021u"),
      Media = objVer
    },
    {
      Text = _DTX("t2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018\026.fJ\018>\021=nv9<\018#\018S\0256\018+\002nnY\\G=\\\021\018=\\rG\025qY\01862Y\018r\\\021\018O\024qG2YY\\\021\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018\002\\=\\Gb4Y\\GY\\\018.\\S\025\\4!\\G\002\021[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\0184\\2\024qY\018G\002\\\024!4b\\\002E2[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018\030\00244\ab\024qnY\0026\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018>\021=nv96b\\nn2[\\n\018kb\024qnY\0026\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018nYbG!\\n\018kb\024qnY\0026\026.fJm<\018#\018.\\S\025\\4!\\G\002\021[n\\lv4\025n2\025\021"),
      Media = objVer
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objVermehrungsrate:Oncmdablegen(target)
  objVermehrungsrate:MoveTo(_G[currentZone])
  objVermehrungsrate.Commands.cmdaufnehmen.Enabled = true
  objVermehrungsrate.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objVermehrungsrate:Oncmdaufnehmen(target)
  objWirkungsgefuege1:MoveTo(Player)
  objVermehrungsrate.Commands.cmdablegen.Enabled = true
  objVermehrungsrate.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objUmweltbelastung:Oncmdablegen(target)
  objUmweltbelastung:MoveTo(_G[currentZone])
  objUmweltbelastung.Commands.cmdaufnehmen.Enabled = true
  objUmweltbelastung.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objUmweltbelastung:Oncmdaufnehmen(target)
  objWirkungsgefuege1:MoveTo(Player)
  objUmweltbelastung.Commands.cmdablegen.Enabled = true
  objUmweltbelastung.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objUmweltbelastung:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("{2\\G\018nYG\025\\6\\\021\018b44\\\018\002\021=\\rb\024qY\\\021\018,\0254[\\\021\018\002\021n\\G\\n\018B\002\021n\018\127\002nb66\\\021D\018+=[bn\\(\018+=\ab\\nn\\G(\018\006b\\G6(\018fb\002==b\002(\018\006b\021rn\024qbEYn\127\\GnY\025\\G\002\021[\018\002\021r\018kb4rnY\\G=\\\021(\018BG\\\021\021\002\021[\018\021bY\002\\G42\024q\\G\018pG\\2n4b\\\002E\\(\018\b\\G!\\qGn\024qb\025n\018\002\021r\018OYb\\rY\\\127\\GEb44\018#\01862Y\018b44\\\021\0184b\021[EG2nY2[\\\021\018+\002n\a2G!\002\021[\\\021u\018tb62Y\018=\\\1272\\qY\018r2\\n\\G\018.\\G\\2\024q\018r2\\\018{\0026b\021\025\\!\0254\025[2\\\018\\=\\\021n\025\018\\2\021\018\a2\\\018r2\\\018B\\\024q\021\025nvqb\\G\\\018\002\021r\018r2\\\018.2\025nvqb\\G\\u"),
      Media = objUmw
    },
    {
      Text = _DTX(".\\4bnY\002\021[\018q\\2nnY\018q2\\G\018b4n\025\018\0212\024qY\018\021\002G\0186\\nn=bG\\G\018O\024qbr\\\021(\018n\025\021r\\G\021\018b\002\024q\0186b\021[\\4\021r\\\018OYb=242n2\\G\002\021[(\018E\\q4\\\021r\\\018O\\4=nYG\\[\0024bY2\025\021\018\002\021r\018\127\\GnY\025\\GY\\\018~4\\2\024q[\\\a2\024qY\\u"),
      Media = objUmw
    },
    {
      Text = _DTX("t2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\026.fJ\018>\021=nv9>\021=nv9<\0182\021Yb!Y\\\018\016!\025nLnY\\6\\\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv962\02126b4\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9[\\G2\021[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9nY\025\\G\\\021r\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9=\\r\\\021!42\024q\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9b4bG62\\G\\\021r\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv92GG\\S\\Gn2=\\4\026.fJm<\018!\\2\021\\\018f\\[\0024bY2\025\021"),
      Media = objUmw
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objPolitik:Oncmdablegen(target)
  objPolitik:MoveTo(_G[currentZone])
  objPolitik.Commands.cmdaufnehmen.Enabled = true
  objPolitik.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objPolitik:Oncmdaufnehmen(target)
  objPolitik:MoveTo(Player)
  objPolitik.Commands.cmdablegen.Enabled = true
  objPolitik.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objPolitik:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("t2\\n\\G\018.\\G\\2\024q\018\0026EbnnY\018r2\\\018,b\\q2[!\\2Y\\\021\018\002\021r\018g\025\\[42\024q!\\2Y\\\021\018r\\n\018>\021=nv9f\\[2\\G\002\021[n\024q\\En\018\002\021r\018n\\2\021\\n\018g2\0212nY\\G!b=2\021\\YYn\018=\127\au\018r\\G\018G\\[2\\G\\\021r\\\021\018\tbGY\\2\\\021u\018\vG\018nv2\\[\\4Y\018r2\\\018+\002Y\025G2Yb\\Y\018\002\021r\018\v\021Yn\024q\\2r\002\021[n[\\\ab4Y\018r\\G\018f\\[2\\G\002\021[\018\a2r\\G\018\002\021r\018nY\\qY\018\002\021r\018Eb\\44Y\01862Y\0182qG\\G\018k\\2Yn2\024qY(\0182qG\\G\018.\\42\\=Yq\\2Y\018\002\021r\018r\\G\018\v2\021n2\024qY2[!\\2Y\0182qG\\G\018\tG\025[Gb66\\(\018b=\\G\018b\002\024q\01862Y\018r\\6\018~Gbr\018r\\G\018p\025\025v\\GbY2\025\021\018\127\a2n\024q\\\021\018f\\[2\\G\002\021[\018\002\021r\018\tbG4b6\\\021Yu"),
      Media = objPol
    },
    {
      Text = _DTX("kb\\qG\\\021r\018n2\024q\018r\\G\018b!Y2S\\\018v\02542Y2n\024q\\\018{b\021r4\002\021[nnv2\\4Gb\0026\0182\021\018r\\\021\018\020\\\a\\24n\018\\Gqb4Y\\\021\\\021\018+!Y2\025\021nv\002\021!Y\\\021\018\a2r\\Gnv2\\[\\4Y(\0182nY\018r\\G\018.\\G\\2\024q\018\t\02542Y2!\018b4n\018rbn\018G\\n\0024Y2\\G\\\021r\\\018U6b[\\\018\127\002\018S\\GnY\\q\\\021\018\002\021r\018!b\021\021\018rbq\\G\018\0212\024qY\018r2G\\!Y\018=\\\\2\021E4\002nnY\018\a\\Gr\\\021u"),
      Media = objPol
    },
    {
      Text = _DTX("t2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018\026.fJ#\005\005\018>\021=nv9OYbbYnnYG\\2\024q\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9rG\025q\\\021r\\G\018OYbbYnnYG\\2\024q\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9\v6v\025\\G\002\021[\018\002\021r\018+\002EnYb\021r\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9\030\00244\018\b\\GYGb\002\\\021\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9\ab\024!\\42[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9=4\\2=Y\018b6\018f\002r\\G\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9G\\[2\\GY\01862Y\018g\\qGq\\2Y\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9=\\[\\2nY\\GY\\\018k2\\r\\G\abq4\026.fJ\018>\021=nv9mK\018>\021=nv9\tbGbr2\\n\026.fJ"),
      Media = objPol
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objSanierung:Oncmdablegen(target)
  objSanierung:MoveTo(_G[currentZone])
  objSanierung.Commands.cmdaufnehmen.Enabled = true
  objSanierung.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objSanierung:Oncmdaufnehmen(target)
  objSanierung:MoveTo(Player)
  objSanierung.Commands.cmdablegen.Enabled = true
  objSanierung.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objSanierung:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("{2\\G\018[\\qY\018\\n\018[\\\021\\G\\44\018\0026\018\021b\024qqb4Y2[\\n\018k2GYn\024qbEY\\\021(\018ruqu\018>\021=nv9\0026\018r\\\021\018\0176\a\\4Yn\024q\002Y\127(\018\0026\018f\\\024L\02442\021[\018\002\021r\018nb\021EY\\\018\v\021\\G[2\\\021u\018tb=\\2\018qb\021r\\4Y\018\\n\018n2\024q\018[G\002\021rnb\\Y\12742\024q\018\a\\\0212[\\G\018rbG\0026(\018O\024qb\\r\\\021\018\127\002\018G\\vbG2\\G\\\021(\018b4n\018\0026\018r2\\\018\v2\021E\002\\qG\002\021[\018\0026\a\\4YEG\\\002\021r42\024q\\G\018\b\\GEbqG\\\021\0182\021\018U\021r\002nYG2\\\018\002\021r\018\006b\021r\a2GYn\024qbEY(\018\0026\018r2\\\018\vGqb4Y\002\021[\018\025\\!\0254\025[2n\024q\\G\018pG\\2n4b\\\002E\\u\018t2\\\018\0176\a\\4YEG\\\002\021r42\024q!\\2Y\018r\\G\018\tG\025r\002!Y2\025\021n6\\Yq\025r\\\021\018\127b\\q4Y\018\\=\\\021n\025\018rb\127\002\018\a2\\\018r2\\\020\\\0212[\\\018r\\G\018q\\G[\\nY\\44Y\\\021\018\tG\025r\002!Y\\u"),
      Media = objSan
    },
    {
      Text = _DTX("Ob\0212\\G\002\021[\0182nY\018b4n\025\018\a\\2Y\0186\\qG\018b4n\018Y\\\024q\0212n\024q\\G\018\0176\a\\4Yn\024q\002Y\127(\018\a\\\021\021[4\\2\024q\018b\002\024q\018f\\YY\002\021[n6bnn\021bq6\\\021\018rb\127\002\127b\\q4\\\021u\018tbn\0182nY\018r\\G\018~G\002\021r(\018\a\\nqb4=\0182qG\\\018k2G!\002\021[\018\021\002G\018=2n\018\127\002\018\\2\021\\G\018=\\[G\\\021\127Y\\\021\018{\025\\q\\\018S\025\018tb\002\\G\0182nY\018\002\021r\018=\\2\018\v2\021\127\\4b!Y2\025\021\\\021\018=b4r\018\a2\\r\\G\018b=!42\021[Yu"),
      Media = objSan
    },
    {
      Text = _DTX("t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018\026.fJ\018<\018\b\\G[\\\ab4Y2[\002\021[\018r\\n\018\006\\=\\\021nGb\0026\\n\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9S2\\4\018fb\002==b\002\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9\021\002G\018\021\025Yr\002\\GEY2[\\\018O\024q\002Y\1276b?\021bq6\\\021\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9[\\G2\021[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv96b\\?2[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9\\GnY\\\0182\021\021\025SbY2S\\\018k\\[\\\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9Y2\\E[\\q\\\021r\\\018\vG\021\\\002\\G\002\021[\026.fJm<\0182\021Yb!Y\\G\018\006\\=\\\021nGb\0026"),
      Media = objSan
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objProduktion:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("t2\\n\\G\018.\\G\\2\024q\018nv2\\[\\4Y\018\0212\024qY\018\021\002G\018r2\\\018G\\2\021\\\018\tG\025r\002!Y2S2Yb\\Y\018\002\021r\018rbn\018kb\024qnY\0026\018S\025\021\018U\021r\002nYG2\\\018\002\021r\018{b\021r\a\\G!\018\a2r\\G(\018n\025\021r\\G\021\018b\002\024q\018r2\\\0184b\021r\a2GYn\024qbEY42\024q\\\018\tG\025r\002!Y2\025\021\018\002\021r\018r\\\021\018\0176nbY\127\018S\025\021\018{b\021r\\4\018\002\021r\018t2\\\021nY4\\2nY\002\021[\018#\018\a\\\021\021\0186b\021\018n\025\018\a244D\018r2\\\018[\\nb6Y\a2GYn\024qbEY42\024q\\\018pGbEYuu\026.fJt2\\n\\\021\018.\\G\\2\024q\018!b\021\021\0186b\021\018b4n\018\v2\021\1272[\\\021\018b\002\024q\018\127\002G\002\\\024!n\024qGb\002=\\\021u\018k244\0186b\021\018r\\\021\018+\021Y\\24\018r\\G\018t2\\\021nY4\\2nY\002\021[\018\\Gq\025\\q\\\021(\018\127u.u\018\0026\018r2\\\018\0176\a\\4Y=\\4bnY\002\021[\018r\002G\024q\018\tG\025r\002!Y2\025\021\018\002\021r\018+=Eb\\44\\\018\127\002\018S\\GG2\021[\\G\021(\018n\025\018!b\021\021\018rbn\018\021\002G\0182\021r2G\\!Yr\002G\024q\018\\2\021\\\018\\\021YnvG\\\024q\\\021r\018q\025q\\\018Ob\0212\\G\002\021[\018\025r\\G\018b=\\G\018r\002G\024q\0183\002G\002\\\024!n\024qGb\002=\\\021\018=\\\a2G!Y\018\a\\Gr\\\021\018N\abn\018b=\\G\018\\=\\\021Eb44n\018+!Y2\025\021nv\002\021!Y\\\018!\025nY\\Y\001u"),
      Media = objPro
    },
    {
      Text = _DTX("tbnn\018b\002\024q\018\\2\021\\\018\b\\GG2\021[\\G\002\021[\018r\\G\018\tG\025r\002!Y2\025\021\018#\018n\\2\018\\n\018r\002G\024q\018fbY2\025\021b42n2\\G\002\021[(\018\0176nY\\44\002\021[\018b\002E\0186\\qG\018t2\\\021nY4\\2nY\002\021[\018\025r\\G\018rbn\018+=n\024q\025\\vE\\\021\018S\025\021\018\017\\=\\G!bvb\1272Yb\\Y\\\021\018#\018r2\\\018\b\0254!n\a2GYn\024qbEY\018\\Y\abn\018!\025nY\\nY(\018r\002\\GEY\\\018\\2\0214\\\002\024qY\\\021u\018t\\\021\021\018rb62Y\018n2\021r\018\\\021Y\a\\r\\G\018U\021S\\nY2Y2\025\021\\\021\0182\021\0186\025r\\G\021\\\018G\\nn\025\002G\024\\\021n\024q\025\021\\\021r\\\018\b\\GEbqG\\\021(\018\0176n\024q\0024\002\021[nvG\025[Gb66\\\018\002\021r\018+\\q\02142\024q\\n\018\025r\\G\018b=\\G\018r2\\\018\b\\G4b[\\G\002\021[\0182\021\018.2442[4\025q\0214b\\\021r\\G\018\002\021r\018n\02562Y\018\\2\021\018\b\\G4\002nY\018b\021\018+G=\\2Ynv4b\\Y\127\\\021(\018b4n\025\018\127\002nb\\Y\12742\024q\\\018O\025\1272b4!\025nY\\\021\018S\\G=\002\021r\\\021u\018k\\\021\021\018b\021r\\G\\Gn\\2Yn\018r2\\\018\tG\025r\002!Y2\025\021\018\025q\021\\\0182\021\021\025SbY2S\\\018OY\\\002\\G\002\021[\018>\021=nv9n2\024q\018n\\4=nY\018\002\\=\\G4bnn\\\021\018=4\\2=Y(\018\a2Gr\018n2\\(\018r\\6\018kb\024qnY\0026n\127\ab\021[\018[\\q\025G\024q\\\021r(\018b\021\018\\2\021\\G\018\021b\024qqb4Y2[\\\021\018k2GYn\024qbEYn\a\\2n\\\018S\025G=\\24b\002E\\\021u"),
      Media = objPro
    },
    {
      Text = _DTX("t2\\\018k\\GY\\n!b4b\018G\\2\024qY\018S\025\021\018\026.fJ\018>\021=nv9>\021=nv9<\018#\018k2GYn\024qbEY\01842\\[Y\018rbG\0212\\r\\G\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018\021\025Yr\002\\GEY2[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018[\\G2\021[\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018b\002nG\\2\024q\\\021r\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018q\025\024q\004nYbG!\\G\018\vlv\025GY\026.fJ\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9#\018\\lYG\\6\018q\025\024q\004+=nbY\127vG\025=4\\6\\\026.fJm<\018#\018\017\\=\\G!bvb\1272Yb\\Y\004p\025\021n\0026Y\\GG\025G"),
      Media = objPro
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objProduktion:Oncmdablegen(target)
  objProduktion:MoveTo(_G[currentZone])
  objProduktion.Commands.cmdaufnehmen.Enabled = true
  objProduktion.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objProduktion:Oncmdaufnehmen(target)
  objProduktion:MoveTo(Player)
  objProduktion.Commands.cmdablegen.Enabled = true
  objProduktion.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objBevoelkerung:Oncmdablegen(target)
  objBevoelkerung:MoveTo(_G[currentZone])
  objBevoelkerung.Commands.cmdaufnehmen.Enabled = true
  objBevoelkerung.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objBevoelkerung:Oncmdaufnehmen(target)
  objBevoelkerung:MoveTo(Player)
  objBevoelkerung.Commands.cmdablegen.Enabled = true
  objBevoelkerung.Commands.cmdaufnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objBevoelkerung:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("t2\\n\\G\018.\\G\\2\024q\018nv2\\[\\4Y\018r2\\\018b!Y\002\\44\\\018.\\S\025\\4!\\G\002\021[n\127bq4(\0182qG\\\0183\002nb66\\\021n\\Y\127\002\021[\018\002\021r\018+\021nvG\002\\\024q\\\018\a2r\\GD\018g\\\021n\024q\\\021r2\024qY\\(\018+4Y\\Gnb\002E=b\002(\0183bq4\018r\\G\018+G=\\2Yn!Gb\\EY\\(\018O\025\1272b4nYG\002!Y\002Guk2\\\018E\002\\G\018r2\\\018=\\[G\\\021\127Y\\\018\vGr\\\018b4n\018~b\021\127\\n\018nv2\\4Y\018r2\\\018.\\S\025\\4!\\G\002\021[nr2\024qY\\\018b\002\024q\018E\002\\G\018rbn\018U\021r\002nYG2\\4b\021r\018\\2\021\\\018\\\021Yn\024q\\2r\\\021r\\\018f\02544\\D\018O2\\\018nY\\44Y\018r2\\\018~\\nb6Y!GbEY\018r\\n\018\b\0254!\\n\018\\=\\\021n\025\018rbG\018\a2\\\018r2\\\018~\\nb6Y=\\4bnY\002\021[\018n\\2\021\\n\018\006\\=\\\021nGb\0026\\nu"),
      Media = objBev
    },
    {
      Text = _DTX("t2\\\018+\002n\a2G!\002\021[\018r\\G\018.\\S\025\\4!\\G\002\021[nr2\024qY\\\018b\002E\018rbn\018\006b\021r\018n\024q\ab\021!Y\018rbq\\G\018\020\\r\018\021b\024q\018OY\\4\002\021[\018r\\G\018\002\\=G2[\\\021\018.\\G\\2\024q\\u\018t2\\\0183bq4\\\021\018b\002E\018r\\G\018O!b4b\018!b\021\021\0186b\021\01862Y\018r\\G\018\v2\021\a\025q\021\\G\127bq4\0182\021\018g2442\025\021\\\021\018[4\\2q\024n\\Y\127\\\021u\018O\025\018\a2\\\018r2\\\018\b\\G6\\qG\002\021[nGbY\\\0184b\\nnY\018n2\024q\018\021bY\002\\G42\024q\018b\002\024q\018r2\\\018.\\S\025\\4!\\G\002\021[n\127bq4\018\021\002G\0182\021r2G\\!Y\018\002\021r\018\0212\024qY\018r\002G\024q\018r2\\\018\v2\021[b=\\\018S\025\021\018+!Y2\025\021nv\002\021!Y\\\021\018S\\Gb\\\021r\\G\021u\018k2\\\018=\\2\018r\\G\018\tG\025r\002!Y2\025\021\018[2=Y\018\\n\018b\002\024q\018q2\\G\018\\2\021\018[\002\\\021nY2[\\n\018\016vY26\0026\018\127\a2n\024q\\\021\018r\\\021\018=\\2r\\\021\018\vlYG\\6\a\\GY\\\021u"),
      Media = objBev
    },
    {
      Text = _DTX("t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018\026.fJ#\018<\018>\021=nv9>\021=nv9b\002n[\\nY\025G=\\\021\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv962\02126b4\\\018.\\n2\\r4\002\021[\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9[\\G2\021[\\\018t2\024qY\\\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9[\\\021\002\\[\\\021r\018\t4bY\127\018E\002\\G\018b44\\\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv962YY4\\G\\\018t2\024qY\\\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9q\025q\\\018t2\024qY\\\018\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9>\021=nv9\127\002\018q\025q\\\018t2\024qY\\\018\026.fJ#\018\f&\018rG\025q\\\021r\\G\0183\002nb66\\\021=G\002\024q"),
      Media = objBev
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objAufklaerung:Oncmdablegen(target)
  objAufklaerung:MoveTo(Player)
  objAufklaerung.Commands.cmdaufnehmen.Enabled = true
  objAufklaerung.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objAufklaerung:Oncmdaufnehmen(target)
  objAufklaerung:MoveTo(Player)
  objAufklaerung.Commands.cmdaufnehmen.Enabled = true
  objAufklaerung.Commands.cmdablegen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objAufklaerung:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("t2\\n\\G\018.\\G\\2\024q\018\0026EbnnY\018\a\\2Y\0186\\qG\018b4n\018U\021E\025G6bY2\025\021\018\002\021r\018k2nn\\\021\018r\002G\024q\018O\024q\0024\\\021(\018\vG\ab\024qn\\\021\\\021=24r\002\021[(\018g\\r2\\\021\018\025r\\G\018.\002\\G[\\G2\0212Y2bY2S\\\021u\018+\002\024q\018r\\G\018b44[\\6\\2\021\\\018\vG!\\\021\021Y\0212nnYb\021r\01826\018{2\021=42\024q\018b\002E\018[\\n\002\021r\\\018\006\\=\\\021n\a\\2n\\(\018O\\4=nYS\\G\a2G!42\024q\002\021[(\018\0176\a\\4Y=\\\a\002nnYn\\2\021\018\002\021r\018n2\021\021S\02544\\\018,G\\2\127\\2Y[\\nYb4Y\002\021[\018\002\021r\018\0212\024qY\018\127\0024\\Y\127Y\018\\2\021\018\\G\a\\2Y\\G\\G\018{\025G2\127\025\021Y\018(\018B\0254\\Gb\021\127\018\002\021r\018\\2\021\\\018S\\Gb\021Y\a\025GY42\024q\\\018,b6242\\\0214b\021\002\021[\018N~\\=\002GY\\\021!\025\021YG\02544\\\001\018[\\q\025\\G\\\021\018rb\127\002u\018"),
      Media = objAufkl
    },
    {
      Text = _DTX("\016q\021\\\018b\\\002nn\\G\\\018\v2\021\a2G!\002\021[\018\a2Gr\018\\2\021\\\018\\2\0216b4\018\\GG\\2\024qY\\\018k\\2Yn2\024qY\018\0212\024qY\0186\\qG\018n2\021!\\\021u\018t\025\024q\018[2=Y\018\\n\018b\002\024q\0182\021\018\\2\021\\G\018t\\6\025!GbY2\\\018[\\\021\002\\[\\\021r\018\v2\021E4\002\\nn\\(\018r2\\\018n2\\\018\a2\\r\\G\018\127\002G\002\\\024!\a\\GE\\\021D\018\002\021!G2Y2n\024q\\\018g\\r2\\\021v\02542Y2!\018\025r\\G\018\tG\\nn\\\127\\\021n\002G(\018n\024q4\\\024qY\\\018O\024q\0024\\\021(\0182\021Y\0254\\Gb\021Y\\\018~\\n\\Y\127\\\018#\018r2\\\018q2\\G\018\127\002Eb\\442[\018b4n\018\vG\\2[\0212nn\\\0182\021n\018Ov2\\4\018!\02566\\\021u"),
      Media = objAufkl
    },
    {
      Text = _DTX("t2\\\018O!b4b\018G\\2\024qY\018S\025\021\018\026.fJ#\018>\021=nv9<\018\017\021\a2nn\\\021\018\002\021r\018U\021Y\0254\\Gb\021\127\018\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9t\\n2\021Y\\G\\nn\\\018\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv96b\\nn2[\\G\018U\021E\025G6bY2\025\021nnYb\021r\018\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9\\G\a\\2Y\\GY\\G\018U\021E\025G6bY2\025\021nnYb\021r\026.fJ#\018>\021=nv9>\021=nv9>\021=nv9>\021=nv9\a\\2Y[\\q\\\021r\\\018\v2\021n2\024qY\0182\021\0183\002nb66\\\021qb\\\021[\\\018\026.fJ#\018m<\018!L=\\G\021\\Y2n\024q\\n\018t\\\021!\\\021\018\002\021r\018{b\021r\\4\021"),
      Media = objAufkl
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objParkbank1:Oncmdansehen(target)
  _Urwigo.MessageBox({
    Text = _DTX("Uqqq\018#\018\abn\0182nY\018r\\\021\021\018rbn\018E\002\\G\018\\2\021\\\018S\\G!\025YY\\GY\\\018.b\021!-\018tb\018n\02544\018n2\024q\018\021\025\024q\018\020\\6b\021r\018n\\Y\127\\\021-\018p\\2\021\018k\002\021r\\G(\018rbnn\018rb\018\020\\6\\\021br\018E4\002\024qYbGY2[\018n\\2\021\018.\002\024q\018qbY\01842\\[\\\021\0184bnn\\\021u\018\vG\018\a\002nnY\\\018\a\025q4\018\0212\024qY(\018rbnn\018.\002\\\024q\\G\018\t\025GYb4\\\0182\021\018\\2\021\\\018b\021r\\G\\\018k\\4Y\018n2\021r\018uuu"),
    Media = objParkbank,
    Callback = function(action)
      if action ~= nil then
        objVernetztesDenken.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objParkbank1:Oncmdsetzen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("\v[b4\018\a2\\\018r2\\n\\\018.b\021!\018b\002\024q\018b\002nn\\q\\\021\0186b[u\0183\0026\018t\\\021!\\\021\018=Gb\002\024q\\\0182\024q\0183\\2Y\018\002\021r\018f\002q\\u\018+4n\025\0186b4\018!\002G\127\018r2\\\018.b\021!\018[\\v\002Y\127Y\018\002\021r\018rb\021\021\018[\\n\\Y\127Yu"),
      Media = objParkbank
    },
    {
      Text = _DTX("\vL\018#\018\abn\0182nY\018rbn\018r\\\021\021-\018UG[\\\021r\\Y\abn\018rG\002\\\024!Y\018q2\\Gu\018O\025\018!b\021\021\0182\024q\018\0212\024qY\0182\021\018f\002q\\\018n2Y\127\\\021u"),
      Media = objParkbank
    }
  }, function(action)
    objParkbank1.Opened = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objParkbank1:Oncmduntersuchen(target)
  if objParkbank1.Opened == false then
    _Urwigo.MessageBox({
      Text = _DTX("O\025\018\abn\018#\018\abn\018n\02544\018r\\\021\021\018r2\\n\\n\018.\002\024q\018q2\\G-"),
      Media = objParkbank,
      Callback = function(action)
        if action ~= nil then
          objVernetztesDenken.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _DTX("O\025\018\abn\018#\018\abn\018n\02544\018r\\\021\021\018r2\\n\\\018,246r\025n\\\018q2\\G-"),
      Media = objParkbank,
      Callback = function(action)
        if action ~= nil then
          objFilmdose1.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFilmdose1:Oncmdoeffnen(target)
  _Urwigo.MessageBox({
    Text = _DTX("6b4\018n\\q\\\021(\018\abn\018rbG2\021\0182nY\018uuu"),
    Media = objFilmdose,
    Callback = function(action)
      if action ~= nil then
        objLogbuch1.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFilmdose1:Oncmdmitnehmen(target)
  _Urwigo.MessageBox({
    Text = _DTX("+4n\025\018rbE\002\\G\018qb=\\\021\018\a2G\018\021\002\021\018\a2G!42\024q\018!\\2\021\\\0183\\2Yu\018+\002nn\\Gr\\6\018\a\02544\\\021\018\021\025\024q\0186\\qG\018r2\\n\\\018t\025n\\\018E2\021r\\\0210"),
    Media = objVester,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFilmdose1:Oncmdverstecken(target)
  if objGeocoin1.Visible == false and objLogbuch1.Visible == false then
    objFilmdose1.Visible = false
  else
    _Urwigo.MessageBox({
      Text = _DTX(".2nY\018t\002\018n2\024q\\G(\018rbnn\018t\002\018=\\G\\2Yn\018b44\\n\018\a2\\r\\G\0182\021\018r\\G\018,246r\025n\\\018S\\GnY\\\024!Y\018qbnY-"),
      Media = objVester
    })
  end
end
function objLogbuch1:Oncmdloggen(target)
  _Urwigo.MessageBox({
    Text = _DTX("\017\021r\0186b4\018n\024q\021\\44\018[\\4\025[[Y0"),
    Media = objLogbuch,
    Callback = function(action)
      if action ~= nil then
        objGeocoin1.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objLogbuch1:Oncmdlesen(target)
  _Urwigo.MessageBox({
    Text = _DTX("\016q\018#\018rbn\018n2\\qY\018\021b\024q\018\\2\021\\6\018,B,\018b\002n000"),
    Media = objLogbuch,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objLogbuch1:Oncmdmitnehmen(target)
  _Urwigo.MessageBox({
    Text = _DTX("\030\002\021\018b=\\G\018#\018\abn\018=2nY\018t\002\018E\002\\G\018\\2\021\0188b\024q\\G0\026.fJ"),
    Media = objVester,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objLogbuch1:Oncmdverstecken(target)
  objLogbuch1.Visible = false
end
function objGeocoin1:Oncmdansehen(target)
  _Urwigo.MessageBox({
    Text = _DTX("O\\qG\018n\024q\025\\\021\018#\018\002\021r\018\021\025\024q\018\\Y\abn\018\127\0026\018t2n\024\025S\\G\021D\026.fJ\026.fJ\v+R\030$k"),
    Media = objGeocoinDetail,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objGeocoin1:Oncmdmitnehmen(target)
  _Urwigo.MessageBox({
    Text = _DTX("+4n\025\018\a2G!42\024q\018#\018\\n\018[2=Y\018\021\025\024q\0186\\qG(\018r2\\\018n2\024q\018b\021\018r2\\n\\G\0188\0252\021\018\\GEG\\\002\\\021\018\a\02544\\\0210"),
    Media = objVester,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objGeocoin1:Oncmdverstecken(target)
  objGeocoin1.Visible = false
end
function objSpoiler1:Oncmdnehmen(target)
  objSpoiler1:MoveTo(Player)
end
function objSpoiler1:Oncmdansehen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _DTX("\b\0256\018k\\[\018b\002n\0182\021\018f2\024qY\002\021[\018,2\021b4(\01842\021!n\0184b\\\002EY\018r\\G\018b4Y\\\018~G\\\021\127\127b\002\021\018\\\021Y4b\021[u"),
      Media = objspoileroben
    },
    {
      Text = _DTX("\v2\021\\\018t\\Yb24b\002E\021bq6\\\018S\0256\018b4Y\\\021\018~G\\\021\127\127b\002\021\018\002=\\G\018rbn\018,2\021b4\018\127\0026\018O\\\\u"),
      Media = objfinal
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objErfolgreichregiert()
  objKoordinaten1.Visible = true
  objKoordinaten1:MoveTo(Player)
  zCache.Active = true
  zCache.Visible = true
  objKlausdenktnach.Complete = true
  objUnlockcode1.Description = string.sub(Player.CompletionCode, 1, 15)
  objUnlockcode1:MoveTo(Player)
  objKlausdenktnach:RequestSync()
  zVermehrungsrate.Active = false
  zBevoelkerung.Active = false
  zUmweltbelastung.Active = false
  zSanierung.Active = false
  zProduktion.Active = false
  zPolitik.Active = false
  zLebensqualitaet.Active = false
  zAufklaerung.Active = false
  objKlausdenktnach:RequestSync()
  vIntRundenzaehler.Visible = false
  objRegiereweise.Visible = false
  objTrageDicheininsBuchdervernetztenDenker.Visible = true
  objProtokollblatt1.Visible = false
  objWirkungsgefuege1.Visible = false
  objVernetztesDenken.Visible = false
  objTabelleLebensqualitaetAktionspunkte.Visible = false
  objTabelleSanierungSanierung.Visible = false
  objTabelleSanierungUmweltbelastung.Visible = false
  objTabelleProduktionProduktion.Visible = false
  objTabelleProduktionAktionspunkte.Visible = false
  objTabelleProduktionUmweltbelastung.Visible = false
  objTabellePolitikAktionspunkte.Visible = false
  objTabelleUmweltbelastungUmweltbelastung.Visible = false
  objTabelleBevoelkerungAktionspunkte.Visible = false
  objTabelleUmweltbelastungLebensqualitaet.Visible = false
  objTabelleBevoelkerungLebensqualitaet.Visible = false
  objTabelleAufklaerungAufklaerung.Visible = false
  objTabelleVermehrungsrateBevoelkerung.Visible = false
  objTabelleAufklaerungLebensqualitaet.Visible = false
  objTabelleLebensqualitaetPolitik.Visible = false
  objTabelleAufklaerungVermehrungsrate.Visible = false
  objTabelleLebensqualitaetVermehrungsrate.Visible = false
  objTabelleLebensqualitateLebensqualitaet.Visible = false
  objLebensqualitaet.Visible = false
  objVermehrungsrate.Visible = false
  objUmweltbelastung.Visible = false
  objPolitik.Visible = false
  objSanierung.Visible = false
  objProduktion.Visible = false
  objBevoelkerung.Visible = false
  objAufklaerung.Visible = false
end
tabelle1 = {
  [0] = 2,
  [1] = 2,
  [2] = 1,
  [3] = 0,
  [4] = -1,
  [5] = -1,
  [6] = -1,
  [7] = -1,
  [8] = -2,
  [9] = -2,
  [10] = -2,
  [11] = -2,
  [12] = -2,
  [13] = -3,
  [14] = -3,
  [15] = -3,
  [16] = -3,
  [17] = -3,
  [18] = -4,
  [19] = -4,
  [20] = -4,
  [21] = -5,
  [22] = -5,
  [23] = -5,
  [24] = -6,
  [25] = -6,
  [26] = -7,
  [27] = -7,
  [28] = -8,
  [29] = -9
}
tabelle2 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 0,
  [16] = 0,
  [17] = 0,
  [18] = 0,
  [19] = 0,
  [20] = 0,
  [21] = -1,
  [22] = -1,
  [23] = -2,
  [24] = -2,
  [25] = -3,
  [26] = -3,
  [27] = -2,
  [28] = -1,
  [29] = -1
}
tabelle3 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 1,
  [8] = 1,
  [9] = 1,
  [10] = 1,
  [11] = 1,
  [12] = 1,
  [13] = 1,
  [14] = 1,
  [15] = 1,
  [16] = 1,
  [17] = 1,
  [18] = 1,
  [19] = 1,
  [20] = 1,
  [21] = 1,
  [22] = 2,
  [23] = 2,
  [24] = 2,
  [25] = 2,
  [26] = 2,
  [27] = 2,
  [28] = 1,
  [29] = 1
}
tabelle4 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 1,
  [6] = 1,
  [7] = 1,
  [8] = 1,
  [9] = 2,
  [10] = 2,
  [11] = 2,
  [12] = 2,
  [13] = 3,
  [14] = 3,
  [15] = 4,
  [16] = 4,
  [17] = 5,
  [18] = 5,
  [19] = 6,
  [20] = 6,
  [21] = 7,
  [22] = 7,
  [23] = 8,
  [24] = 9,
  [25] = 10,
  [26] = 12,
  [27] = 14,
  [28] = 18,
  [29] = 22
}
tabelle5 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = -1,
  [5] = -1,
  [6] = -1,
  [7] = -1,
  [8] = -1,
  [9] = -1,
  [10] = -1,
  [11] = -1,
  [12] = -1,
  [13] = -1,
  [14] = -2,
  [15] = -2,
  [16] = -2,
  [17] = -2,
  [18] = -2,
  [19] = -2,
  [20] = -2,
  [21] = -3,
  [22] = -3,
  [23] = -3,
  [24] = -3,
  [25] = 0,
  [26] = 0,
  [27] = 0,
  [28] = 0,
  [29] = 0
}
tabelle6 = {
  [0] = 2,
  [1] = 2,
  [2] = 1,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = -1,
  [9] = -1,
  [10] = -1,
  [11] = -2,
  [12] = -2,
  [13] = -2,
  [14] = -2,
  [15] = -3,
  [16] = -3,
  [17] = -3,
  [18] = -4,
  [19] = -4,
  [20] = -5,
  [21] = -5,
  [22] = -6,
  [23] = -7,
  [24] = -8,
  [25] = -10,
  [26] = -12,
  [27] = -14,
  [28] = -18,
  [29] = -25
}
tabelle7 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = -1,
  [4] = -1,
  [5] = -1,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 1,
  [16] = 1,
  [17] = 1,
  [18] = 1,
  [19] = 1,
  [20] = 1,
  [21] = 2,
  [22] = 2,
  [23] = 2,
  [24] = 1,
  [25] = 1,
  [26] = 1,
  [27] = 0,
  [28] = 0,
  [29] = 0
}
tabelle8 = {
  [0] = -2,
  [1] = -2,
  [2] = -2,
  [3] = -2,
  [4] = -2,
  [5] = -2,
  [6] = -1,
  [7] = -1,
  [8] = -1,
  [9] = -1,
  [10] = 0,
  [11] = 1,
  [12] = 1,
  [13] = 1,
  [14] = 2,
  [15] = 2,
  [16] = 2,
  [17] = 2,
  [18] = 3,
  [19] = 3,
  [20] = 3,
  [21] = 3,
  [22] = 4,
  [23] = 4,
  [24] = 4,
  [25] = 4,
  [26] = 5,
  [27] = 5,
  [28] = 6,
  [29] = 6
}
tabelle9 = {
  [0] = 1,
  [1] = 1,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 1,
  [11] = 1,
  [12] = 1,
  [13] = 1,
  [14] = 2,
  [15] = 2,
  [16] = 2,
  [17] = 2,
  [18] = 2,
  [19] = 3,
  [20] = 3,
  [21] = 3,
  [22] = 3,
  [23] = 3,
  [24] = 4,
  [25] = 4,
  [26] = 4,
  [27] = 4,
  [28] = 4,
  [29] = 4
}
tabelle10 = {
  [0] = 0,
  [1] = 0,
  [2] = 1,
  [3] = 1,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 1,
  [11] = 1,
  [12] = 1,
  [13] = 2,
  [14] = 1,
  [15] = 1,
  [16] = 0,
  [17] = 0,
  [18] = -1,
  [19] = -1,
  [20] = -1,
  [21] = -1,
  [22] = -1,
  [23] = -2,
  [24] = -2,
  [25] = -2,
  [26] = -1,
  [27] = -1,
  [28] = -1,
  [29] = 0
}
tabelle11 = {
  [0] = -15,
  [1] = -15,
  [2] = -8,
  [3] = -6,
  [4] = -4,
  [5] = -3,
  [6] = -2,
  [7] = -1,
  [8] = 0,
  [9] = 1,
  [10] = 2,
  [11] = 3,
  [12] = 2,
  [13] = 1,
  [14] = 1,
  [15] = 1,
  [16] = 1,
  [17] = 1,
  [18] = 1,
  [19] = 1,
  [20] = 1,
  [21] = 0,
  [22] = 0,
  [23] = 0,
  [24] = 0,
  [25] = 0,
  [26] = 0,
  [27] = 0,
  [28] = 0,
  [29] = 0
}
tabelle12 = {
  [0] = -10,
  [1] = -10,
  [2] = -8,
  [3] = -6,
  [4] = -3,
  [5] = -2,
  [6] = -1,
  [7] = -1,
  [8] = -1,
  [9] = -1,
  [10] = 0,
  [11] = 0,
  [12] = 1,
  [13] = 1,
  [14] = 1,
  [15] = 1,
  [16] = 1,
  [17] = 1,
  [18] = 1,
  [19] = 1,
  [20] = 1,
  [21] = 2,
  [22] = 2,
  [23] = 2,
  [24] = 3,
  [25] = 3,
  [26] = 3,
  [27] = 4,
  [28] = 4,
  [29] = 5
}
tabelle13 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 0,
  [16] = -1,
  [17] = -1,
  [18] = -1,
  [19] = -1,
  [20] = -1,
  [21] = -1,
  [22] = -1,
  [23] = -1,
  [24] = -1,
  [25] = -1,
  [26] = -2,
  [27] = -2,
  [28] = -2,
  [29] = -2,
  [30] = -2,
  [31] = -3,
  [32] = -3,
  [33] = -3,
  [34] = -3,
  [35] = -3,
  [36] = -3,
  [37] = -3,
  [38] = -3,
  [39] = -4,
  [40] = -4,
  [41] = -4,
  [42] = -4,
  [43] = -5,
  [44] = -5,
  [45] = -6,
  [46] = -7,
  [47] = -8,
  [48] = -10
}
tabelle14 = {
  [0] = -4,
  [1] = -4,
  [2] = -4,
  [3] = -3,
  [4] = -3,
  [5] = -3,
  [6] = -2,
  [7] = -2,
  [8] = -2,
  [9] = -2,
  [10] = -1,
  [11] = -1,
  [12] = -1,
  [13] = -1,
  [14] = -1,
  [15] = 0,
  [16] = 1,
  [17] = 1,
  [18] = 1,
  [19] = 1,
  [20] = 1,
  [21] = 2,
  [22] = 2,
  [23] = 2,
  [24] = 2,
  [25] = 2,
  [26] = 3,
  [27] = 3,
  [28] = 3,
  [29] = 3
}
tabelle15 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 1,
  [11] = 1,
  [12] = 1,
  [13] = 1,
  [14] = 1,
  [15] = 1,
  [16] = 1,
  [17] = 2,
  [18] = 2,
  [19] = 2,
  [20] = 2,
  [21] = 2,
  [22] = 3,
  [23] = 3,
  [24] = 3,
  [25] = 3,
  [26] = 4,
  [27] = 4,
  [28] = 4,
  [29] = 4,
  [30] = 5,
  [31] = 5,
  [32] = 5,
  [33] = 5,
  [34] = 6,
  [35] = 6,
  [36] = 6,
  [37] = 6,
  [38] = 7,
  [39] = 7,
  [40] = 7,
  [41] = 7,
  [42] = 7,
  [43] = 8,
  [44] = 8,
  [45] = 8,
  [46] = 9,
  [47] = 9,
  [48] = 9
}
tabelle16 = {
  [-11] = -6,
  [-10] = -5,
  [-9] = -2,
  [-8] = -1,
  [-7] = -1,
  [-6] = -1,
  [-5] = -1,
  [-4] = -1,
  [-3] = -1,
  [-2] = 0,
  [-1] = 0,
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 1,
  [8] = 1,
  [9] = 1,
  [10] = 1,
  [11] = 1,
  [12] = 1,
  [13] = 1,
  [14] = 1,
  [15] = 1,
  [16] = 1,
  [17] = 1,
  [18] = 1,
  [19] = 1,
  [20] = 1,
  [21] = 1,
  [22] = 2,
  [23] = 2,
  [25] = 2,
  [26] = 2,
  [27] = 2,
  [28] = 2,
  [29] = 2,
  [30] = 2,
  [31] = 3,
  [32] = 3,
  [33] = 3,
  [34] = 3,
  [35] = 3,
  [36] = 3,
  [37] = 3
}
tabelle17 = {
  [0] = -4,
  [1] = -4,
  [2] = -3,
  [3] = -2,
  [4] = -1,
  [5] = 0,
  [6] = 2,
  [7] = 2,
  [8] = 3,
  [9] = 3,
  [10] = 3,
  [11] = 4,
  [12] = 4,
  [13] = 4,
  [14] = 5,
  [15] = 5,
  [16] = 5,
  [17] = 6,
  [18] = 6,
  [19] = 6,
  [20] = 7,
  [21] = 7,
  [22] = 8,
  [23] = 8,
  [24] = 9,
  [25] = 9,
  [26] = 10,
  [27] = 11,
  [28] = 0,
  [29] = -4
}
tabelle18 = {
  [0] = -6,
  [1] = -6,
  [2] = -4,
  [3] = -2,
  [4] = 0,
  [5] = 0,
  [6] = 1,
  [7] = 1,
  [8] = 1,
  [9] = 2,
  [10] = 2,
  [11] = 2,
  [12] = 2,
  [13] = 2,
  [14] = 2,
  [15] = 2,
  [16] = 2,
  [17] = 2,
  [18] = 3,
  [19] = 3,
  [20] = 3,
  [21] = 3,
  [22] = 3,
  [23] = 4,
  [24] = 4,
  [25] = 4,
  [26] = 4,
  [27] = 5,
  [28] = 5,
  [29] = 5
}
status = {
  Auf = "rot",
  Leb = "rot",
  Pol = "orange",
  San = "rot",
  Pro = "gelb",
  Umw = "gelb",
  Bev = "hellgruen",
  Ver = "gelb"
}
p = ZonePoint(52.47, 13.13, 0)
feldK = {
  Auf = p,
  Leb = p,
  Bev = p,
  Ver = p,
  San = p,
  Pro = p,
  Umw = p,
  Pol = p,
  Portal = p
}
feldZ = {
  Auf = zAufklaerung,
  Leb = zLebensqualitaet,
  Bev = zBevoelkerung,
  Ver = zVermehrungsrate,
  San = zSanierung,
  Pro = zProduktion,
  Umw = zUmweltbelastung,
  Pol = zPolitik,
  Portal = zPortal
}
vLF = ",<BR>\n"
function GetPoint(refPt, entf, winkel)
  local dist = Wherigo.Distance(entf, "m")
  return Wherigo.TranslatePoint(refPt, dist, winkel)
end
function GetZonePoints(refPt)
  local dist = Wherigo.Distance(5, "m")
  local pts = {
    Wherigo.TranslatePoint(refPt, dist, 0),
    Wherigo.TranslatePoint(refPt, dist, 45),
    Wherigo.TranslatePoint(refPt, dist, 90),
    Wherigo.TranslatePoint(refPt, dist, 135),
    Wherigo.TranslatePoint(refPt, dist, 180),
    Wherigo.TranslatePoint(refPt, dist, 225),
    Wherigo.TranslatePoint(refPt, dist, 270),
    Wherigo.TranslatePoint(refPt, dist, 315)
  }
  return pts
end
function initZufall()
  math.randomseed(iSeed)
end
function initFeld()
  local dist = Wherigo.Distance(0, "m")
  feldK.Portal = Player.ObjectLocation
  feldK.Pol = GetPoint(feldK.Portal, 15, 0)
  feldK.Bev = GetPoint(feldK.Portal, 20, 45)
  feldK.Umw = GetPoint(feldK.Portal, 15, 90)
  feldK.Pro = GetPoint(feldK.Portal, 20, 135)
  feldK.San = GetPoint(feldK.Portal, 15, 180)
  feldK.Auf = GetPoint(feldK.Portal, 20, 225)
  feldK.Leb = GetPoint(feldK.Portal, 15, 270)
  feldK.Ver = GetPoint(feldK.Portal, 20, 315)
  feldZ.Portal.Active = false
  feldZ.Portal.OriginalPoint = Wherigo.TranslatePoint(feldK.Portal, dist, 0)
  feldZ.Portal.Points = GetZonePoints(feldK.Portal)
  feldZ.Portal.Active = true
  feldZ.Auf.Active = false
  feldZ.Auf.OriginalPoint = Wherigo.TranslatePoint(feldK.Auf, dist, 0)
  feldZ.Auf.Points = GetZonePoints(feldK.Auf)
  feldZ.Leb.Active = false
  feldZ.Leb.OriginalPoint = Wherigo.TranslatePoint(feldK.Leb, dist, 0)
  feldZ.Leb.Points = GetZonePoints(feldK.Leb)
  feldZ.Bev.Active = false
  feldZ.Bev.OriginalPoint = Wherigo.TranslatePoint(feldK.Bev, dist, 0)
  feldZ.Bev.Points = GetZonePoints(feldK.Bev)
  feldZ.Umw.Active = false
  feldZ.Umw.OriginalPoint = Wherigo.TranslatePoint(feldK.Umw, dist, 0)
  feldZ.Umw.Points = GetZonePoints(feldK.Umw)
  feldZ.San.Active = false
  feldZ.San.OriginalPoint = Wherigo.TranslatePoint(feldK.San, dist, 0)
  feldZ.San.Points = GetZonePoints(feldK.San)
  feldZ.Pro.Active = false
  feldZ.Pro.OriginalPoint = Wherigo.TranslatePoint(feldK.Pro, dist, 0)
  feldZ.Pro.Points = GetZonePoints(feldK.Pro)
  feldZ.Pol.Active = false
  feldZ.Pol.OriginalPoint = Wherigo.TranslatePoint(feldK.Pol, dist, 0)
  feldZ.Pol.Points = GetZonePoints(feldK.Pol)
  feldZ.Ver.Active = false
  feldZ.Ver.OriginalPoint = Wherigo.TranslatePoint(feldK.Ver, dist, 0)
  feldZ.Ver.Points = GetZonePoints(feldK.Ver)
end
function ErstelleAusgangsmeldung()
  vMeldung = "Momentan sieht Deine Entscheidung aus:" .. vLF
  vMeldung = ((((vMeldung .. "- Aufklaerung ") .. vAPAufklaerung) .. " investiert: ") .. vIntAPAuf) .. vLF
  vMeldung = ((((vMeldung .. "- Lebensqualitaet ") .. vAPLebensqualitaet) .. " investiert: ") .. vIntAPLeb) .. vLF
  vMeldung = ((((vMeldung .. "- Sanierung ") .. vAPSanierung) .. " investiert: ") .. vIntAPSan) .. vLF
  vMeldung = ((((vMeldung .. "- Produktion ") .. vAPProduktion) .. " investiert: ") .. vIntAPPro) .. vLF
  vMeldung = ((vMeldung .. "- Vermehrungsrate ") .. vAPVermehrungsrate) .. vLF
  vMeldung = ((vMeldung .. "- Bevoelkerung ") .. vAPBevoelkerung) .. vLF
  vMeldung = ((vMeldung .. "- Umweltbelastung ") .. vAPUmweltbelastung) .. vLF
  vMeldung = (vMeldung .. "- Politik ") .. vAPPolitik
end
function ErstelleZwischenbilanz()
  vMeldung = "Deine Zwischenbilanz ist" .. vLF
  vMeldung = (vMeldung .. vBilanzAP) .. vLF
  vMeldung = (vMeldung .. vBilanzAuf) .. vLF
  vMeldung = (vMeldung .. vBilanzLeb) .. vLF
  vMeldung = (vMeldung .. vBilanzVer) .. vLF
  vMeldung = (vMeldung .. vBilanzBev) .. vLF
  vMeldung = (vMeldung .. vBilanzPol) .. vLF
  vMeldung = (vMeldung .. vBilanzSan) .. vLF
  vMeldung = (vMeldung .. vBilanzPro) .. vLF
  vMeldung = vMeldung .. vBilanzUmw
end
function ErstelleZwischenmeldung()
  vMeldung = "Momentan sieht es in den Bereich wie folgt aus:" .. vLF
  vMeldung = ((((vMeldung .. "- Aufklaerung ") .. vAPAufklaerung) .. " investiert: ") .. vIntAPAuf) .. vLF
  vMeldung = ((((vMeldung .. "- Lebensqualitaet ") .. vAPLebensqualitaet) .. " investiert: ") .. vIntAPLeb) .. vLF
  vMeldung = ((((vMeldung .. "- Sanierung ") .. vAPSanierung) .. " investiert: ") .. vIntAPSan) .. vLF
  vMeldung = ((((vMeldung .. "- Produktion ") .. vAPProduktion) .. " investiert: ") .. vIntAPPro) .. vLF
  vMeldung = ((vMeldung .. "- Vermehrungsrate ") .. vAPVermehrungsrate) .. vLF
  vMeldung = ((vMeldung .. "- Bevoelkerung ") .. vAPBevoelkerung) .. vLF
  vMeldung = ((vMeldung .. "- Umweltbelastung ") .. vAPUmweltbelastung) .. vLF
  vMeldung = (vMeldung .. "- Politik ") .. vAPPolitik
end
function Staatsstreich()
  vUrsache = ""
  if vStaatsstreich then
    if vAPAufklaerung == 0 then
      vUrsache = "Aufklaerung = 0"
    elseif vAPLebensqualitaet == 0 then
      vUrsache = vUrsache .. " Lebensqualitaet = 0"
    elseif vAPBevoelkerung == 0 then
      vUrsache = vUrsache .. " Bevoelkerung = 0"
    elseif vAPBevoelkerung == 48 then
      vUrsache = vUrsache .. " Bevoelkerung = max"
    elseif vAPUmweltbelastung == 29 then
      vUrsache = vUrsache .. " Umweltbelastung = max"
    elseif vAPSanierung == 0 then
      vUrsache = vUrsache .. " Sanierung = 0"
    elseif vAPProduktion == 0 then
      vUrsache = vUrsache .. " Produktion = 0"
    elseif vAPProduktion == 29 then
      vUrsache = vUrsache .. " Produktion = max"
    elseif vAPVermehrungsrate == 0 then
      vUrsache = vUrsache .. " Vermehrungsrate = 0"
    elseif vAPVermehrungsrate == 29 then
      vUrsache = vUrsache .. " Vermehrungsrate = max"
    elseif vAPPolitik == -11 then
      vUrsache = vUrsache .. " Politik = min"
    end
    return true
  else
    vStaatsstreich = false
    return false
  end
end
function Paradies()
  if vAPLebensqualitaet == 29 and status.Auf == "gruen" and status.Pol == "gruen" and status.Bev == "gruen" and status.Ver == "gruen" and status.San == "gruen" and status.Pro == "gruen" and status.Umw == "gruen" then
    vParadies = true
    return true
  else
    vParadies = false
    return false
  end
end
function EntscheidungAusfuehren()
  vOldAPAuf = vAPAufklaerung
  vOldAPLeb = vAPLebensqualitaet
  vOldlAPBev = vAPBevoelkerung
  vOldAPSan = vAPSanierung
  vOldAPPro = vAPProduktion
  vOldAPUmw = vAPUmweltbelastung
  vOldAPVer = vAPVermehrungsrate
  vOldAPPol = vAPPolitik
  vAPSanierung = vAPSanierung + vIntAPSan
  vAPProduktion = vAPProduktion + vIntAPPro
  vAPAufklaerung = vAPAufklaerung + vIntAPAuf
  vAPLebensqualitaet = vAPLebensqualitaet + vIntAPLeb
  if vAPSanierung > 29 then
    vAPSanierung = 29
  end
  if vAPProduktion < 0 then
    vAPProduktion = 0
  end
  if vAPProduktion > 29 then
    vAPProduktion = 29
  end
  if vAPAufklaerung > 29 then
    vAPAufklaerung = 29
  end
  if vAPLebensqualitaet > 29 then
    vAPLebensqualitaet = 29
  end
  vAPUmweltbelastung = vAPUmweltbelastung + tabelle1[vAPSanierung]
  if vAPUmweltbelastung < 0 then
    vAPUmweltbelastung = 0
  end
  if vAPUmweltbelastung > 29 then
    vAPUmweltbelastung = 29
    vStaatsstreich = true
  end
  vAPSanierung = vAPSanierung + tabelle2[vAPSanierung]
  if vAPSanierung < 0 then
    vAPSanierung = 0
    vStaatsstreich = true
  end
  if vAPSanierung > 29 then
    vAPSanierung = 29
  end
  vAPProduktion = vAPProduktion + tabelle3[vAPProduktion]
  if vAPProduktion < 0 then
    vAPProduktion = 0
    vStaatsstreich = true
  end
  if vAPProduktion > 29 then
    vAPProduktion = 29
    vStaatsstreich = true
  end
  vAPUmweltbelastung = vAPUmweltbelastung + tabelle4[vAPProduktion]
  if vAPUmweltbelastung < 0 then
    vAPUmweltbelastung = 0
  end
  if vAPUmweltbelastung > 29 then
    vAPUmweltbelastung = 29
    vStaatsstreich = true
  end
  vAPUmweltbelastung = vAPUmweltbelastung + tabelle5[vAPUmweltbelastung]
  if vAPUmweltbelastung < 0 then
    vAPUmweltbelastung = 0
  end
  if vAPUmweltbelastung > 29 then
    vAPUmweltbelastung = 29
    vStaatsstreich = true
  end
  vAPLebensqualitaet = vAPLebensqualitaet + tabelle6[vAPUmweltbelastung]
  if vAPLebensqualitaet < 0 then
    vStaatsstreich = true
    vAPLebensqualitaet = 0
  end
  if vAPLebensqualitaet > 29 then
    vAPLebensqualitaet = 29
  end
  vAPAufklaerung = vAPAufklaerung + tabelle7[vAPAufklaerung]
  if vAPAufklaerung < 0 then
    vStaatsstreich = true
    vAPAufklaerung = 0
  end
  if vAPAufklaerung > 29 then
    vAPAufklaerung = 29
  end
  vAPLebensqualitaet = vAPLebensqualitaet + tabelle8[vAPAufklaerung]
  if vAPLebensqualitaet < 0 then
    vStaatsstreich = true
    vAPLebensqualitaet = 0
  end
  if vAPLebensqualitaet > 29 then
    vAPLebensqualitaet = 29
  end
  local Bevoelkerungsfaktor = 1
  if status.Bev == "gelb" then
    Bevoelkerungsfaktor = -1
  end
  if vAPAufklaerung > 20 then
    Bevoelkerungsfaktor = -1
    if status.Ver == "gruen" or status.Ver == "l-gelb" or status.Ver == "l-orange" or status.Ver == "l-rot" then
      Bevoelkerungsfaktor = 1
    end
  end
  vAPVermehrungsrate = vAPVermehrungsrate + Bevoelkerungsfaktor * tabelle9[vAPAufklaerung]
  if vAPVermehrungsrate < 0 then
    vStaatsstreich = true
    vAPVermehrungsrate = 0
  end
  if vAPVermehrungsrate > 29 then
    vStaatsstreich = true
    vAPVermehrungsrate = 29
  end
  vAPLebensqualitaet = vAPLebensqualitaet + tabelle10[vAPLebensqualitaet]
  if vAPLebensqualitaet < 0 then
    vStaatsstreich = true
    vAPLebensqualitaet = 0
  end
  if vAPLebensqualitaet > 29 then
    vAPLebensqualitaet = 29
  end
  vAPVermehrungsrate = vAPVermehrungsrate + tabelle11[vAPLebensqualitaet]
  if vAPVermehrungsrate < 0 then
    vAPVermehrungsrate = 0
    vStaatsstreich = true
  end
  if vAPVermehrungsrate > 29 then
    vAPVermehrungsrate = 29
    vStaatsstreich = true
  end
  vAPPolitik = vAPPolitik + tabelle12[vAPLebensqualitaet]
  if vAPPolitik < -11 then
    vAPPolitik = -11
  end
  if vAPPolitik > 37 then
    vAPPolitik = 37
  end
  vAPLebensqualitaet = vAPLebensqualitaet + tabelle13[vAPBevoelkerung]
  if vAPLebensqualitaet < 0 then
    vAPLebensqualitaet = 0
    vStaatsstreich = true
  end
  if vAPLebensqualitaet > 29 then
    vAPLebensqualitaet = 29
  end
  local Wachstumsfaktor = 1
  if status.Auf == "hellgruen" then
    Wachstumsfaktor = -1
  end
  if status.Bev == "l-gelb" then
    Wachstumsfaktor = 2
  end
  if status.Bev == "l-orange" then
    Wachstumsfaktor = 3
  end
  vAPBevoelkerung = vAPBevoelkerung + Wachstumsfaktor * tabelle14[vAPVermehrungsrate]
  if vAPBevoelkerung < 0 then
    vAPBevoelkerung = 0
    vStaatsstreich = true
  end
  if vAPBevoelkerung > 48 then
    vAPBevoelkerung = 48
    vStaatsstreich = true
  end
  status.Umw = "gruen"
  if vAPUmweltbelastung > 5 then
    status.Umw = "hellgruen"
  end
  if vAPUmweltbelastung > 10 then
    status.Umw = "gelb"
  end
  if vAPUmweltbelastung > 22 then
    status.Umw = "orange"
  end
  if vAPUmweltbelastung > 25 then
    status.Umw = "rot"
  end
  status.Pro = "l-rot"
  if vAPProduktion > 2 then
    status.Pro = "l-orange"
  end
  if vAPProduktion > 4 then
    status.Pro = "l-gelb"
  end
  if vAPProduktion > 10 then
    status.Pro = "gruen"
  end
  if vAPProduktion > 16 then
    status.Pro = "gelb"
  end
  if vAPProduktion > 22 then
    status.Pro = "orange"
  end
  if vAPProduktion > 25 then
    status.Pro = "rot"
  end
  status.San = "rot"
  if vAPSanierung > 2 then
    status.San = "orange"
  end
  if vAPSanierung > 6 then
    status.San = "gelb"
  end
  if vAPSanierung > 16 then
    status.San = "hellgruen"
  end
  if vAPSanierung > 20 then
    status.San = "gruen"
  end
  status.Pol = "rot"
  if vAPPolitik > -5 then
    status.Pol = "orange"
  end
  if vAPPolitik > 2 then
    status.Pol = "gelb"
  end
  if vAPPolitik > 15 then
    status.Pol = "hellgruen"
  end
  if vAPPolitik > 21 then
    status.Pol = "gruen"
  end
  status.Bev = "l-rot"
  if vAPBevoelkerung > 2 then
    status.Bev = "l-orange"
  end
  if vAPBevoelkerung > 5 then
    status.Bev = "hellgruen"
  end
  if vAPBevoelkerung > 16 then
    status.Bev = "gruen"
  end
  if vAPBevoelkerung > 21 then
    status.Bev = "hellgruen"
  end
  if vAPBevoelkerung > 32 then
    status.Bev = "gelb"
  end
  if vAPBevoelkerung > 40 then
    status.Bev = "orange"
  end
  if vAPBevoelkerung > 44 then
    status.Bev = "rot"
  end
  status.Ver = "l-rot"
  if vAPVermehrungsrate > 2 then
    status.Ver = "l-orange"
  end
  if vAPVermehrungsrate > 6 then
    status.Ver = "l-gelb"
  end
  if vAPVermehrungsrate > 12 then
    status.Ver = "gruen"
  end
  if vAPVermehrungsrate > 19 then
    status.Ver = "gelb"
  end
  if vAPVermehrungsrate > 23 then
    status.Ver = "orange"
  end
  if vAPVermehrungsrate > 26 then
    status.Ver = "rot"
  end
  status.Leb = "rot"
  if vAPLebensqualitaet > 9 then
    status.Leb = "orange"
  end
  if vAPLebensqualitaet > 15 then
    status.Leb = "gelb"
  end
  if vAPLebensqualitaet > 20 then
    status.Leb = "hellgruen"
  end
  if vAPLebensqualitaet > 23 then
    status.Leb = "gruen"
  end
  status.Auf = "rot"
  if vAPAufklaerung > 9 then
    status.Auf = "orange"
  end
  if vAPAufklaerung > 15 then
    status.Auf = "gelb"
  end
  if vAPAufklaerung > 20 then
    status.Auf = "hellgruen"
  end
  if vAPAufklaerung > 25 then
    status.Auf = "gruen"
  end
  local versorgungsfaktor = 1
  if status.Pro == "gelb" then
    versorgungsfaktor = -1
  end
  if status.Pro == "orange" then
    versorgungsfaktor = -2
  end
  if status.Pro == "rot" then
    versorgungsfaktor = -3
  end
  vAktionspunkte = vAktionspunkte + versorgungsfaktor * tabelle15[vAPBevoelkerung]
  vAktionspunkte = vAktionspunkte + tabelle16[vAPPolitik]
  vAktionspunkte = vAktionspunkte + tabelle17[vAPProduktion]
  vAktionspunkte = vAktionspunkte + tabelle18[vAPLebensqualitaet]
  if 0 > vAktionspunkte then
    vAktionspunkte = 0
  end
  vBilanz = math.floor(10 * (3 * vAPLebensqualitaet + 2 * vAPPolitik + vRunde) / (vRunde + 10) + 2 * vAktionspunkte / vRunde + 0.5)
  vBilanzAP = (vBilanzAP .. vAktionspunkte) .. " "
  vBilanzAuf = (vBilanzAuf .. vAPAufklaerung) .. " "
  vBilanzLeb = (vBilanzLeb .. vAPLebensqualitaet) .. " "
  vBilanzVer = (vBilanzVer .. vAPVermehrungsrate) .. " "
  vBilanzBev = (vBilanzBev .. vAPBevoelkerung) .. " "
  vBilanzPol = (vBilanzPol .. vAPPolitik) .. " "
  vBilanzSan = (vBilanzSan .. vAPSanierung) .. " "
  vBilanzPro = (vBilanzPro .. vAPProduktion) .. " "
  vBilanzUmw = (vBilanzUmw .. vAPUmweltbelastung) .. " "
  vEndeMeldung = ("Bilanzzahl: " .. vBilanz) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Aktionspunkte: ") .. vBilanzAP) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Politik ") .. vBilanzPol) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Lebensqualitaet: ") .. vBilanzLeb) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Aufklaerung: ") .. vBilanzAuf) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Vermehrungsrate: ") .. vBilanzVer) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Bevoelkerung: ") .. vBilanzBev) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Sanierung: ") .. vBilanzSan) .. vLF
  vEndeMeldung = ((vEndeMeldung .. "Produktion: ") .. vBilanzPro) .. vLF
  vEndeMeldung = (vEndeMeldung .. "Umweltbelastung: ") .. vBilanzUmw
  if 37 < vAktionspunkte then
    vAktionspunkte = 37
  end
  if vRunde > 11 then
    vEnde = true
    vGutesEnde = true
  elseif Paradies() then
    vEnde = true
    vGutesEnde = true
  elseif Staatsstreich() then
    vEnde = true
    vGutesEnde = false
  end
end
function ErstelleFeedbackmeldung()
  vMeldung = "Deine Aktionen haben folgende Konsequenzen:" .. vLF
  if vOldAPAuf == vAPAufklaerung then
    vMeldung = ((((vMeldung .. "- Aufklaerung bleibt bei ") .. vAPAufklaerung) .. " =&gt; ") .. status.Auf) .. vLF
  elseif vOldAPAuf > vAPAufklaerung then
    vMeldung = ((((vMeldung .. "- Aufklaerung sinkt auf ") .. vAPAufklaerung) .. " =&gt; ") .. status.Auf) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Aufklaerung steigt auf ") .. vAPAufklaerung) .. " =&gt; ") .. status.Auf) .. vLF
  end
  if vOldAPLeb == vAPLebensqualitaet then
    vMeldung = ((((vMeldung .. "- Lebensqualitaet bleibt bei ") .. vAPLebensqualitaet) .. " =&gt; ") .. status.Leb) .. vLF
  elseif vOldAPLeb > vAPLebensqualitaet then
    vMeldung = ((((vMeldung .. "- Lebensqualitaet sinkt auf ") .. vAPLebensqualitaet) .. " =&gt; ") .. status.Leb) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Lebensqualitaet steigt auf ") .. vAPLebensqualitaet) .. " =&gt; ") .. status.Leb) .. vLF
  end
  if vOldAPSan == vAPSanierung then
    vMeldung = ((((vMeldung .. "- Sanierung bleibt bei ") .. vAPSanierung) .. " =&gt; ") .. status.San) .. vLF
  elseif vOldAPSan > vAPSanierung then
    vMeldung = ((((vMeldung .. "- Sanierung sinkt auf ") .. vAPSanierung) .. " =&gt; ") .. status.San) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Sanierung steigt auf ") .. vAPSanierung) .. " =&gt; ") .. status.San) .. vLF
  end
  if vOldAPPro == vAPProduktion then
    vMeldung = ((((vMeldung .. "- Produktion bleibt bei ") .. vAPProduktion) .. " =&gt; ") .. status.Pro) .. vLF
  elseif vOldAPPro > vAPProduktion then
    vMeldung = ((((vMeldung .. "- Produktion sinkt auf ") .. vAPProduktion) .. " =&gt; ") .. status.Pro) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Produktion steigt auf ") .. vAPProduktion) .. " =&gt; ") .. status.Pro) .. vLF
  end
  if vOldAPVer == vAPVermehrungsrate then
    vMeldung = ((((vMeldung .. "- Vermehrungsrate bleibt bei ") .. vAPVermehrungsrate) .. " =&gt; ") .. status.Ver) .. vLF
  elseif vOldAPVer > vAPVermehrungsrate then
    vMeldung = ((((vMeldung .. "- Vermehrungsrate sinkt auf ") .. vAPVermehrungsrate) .. " =&gt; ") .. status.Ver) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Vermehrungsrate steigt auf ") .. vAPVermehrungsrate) .. " =&gt; ") .. status.Ver) .. vLF
  end
  if vOldAPBev == vAPBevoelkerung then
    vMeldung = ((((vMeldung .. "- Bevoelkerung bleibt bei ") .. vAPBevoelkerung) .. " =&gt; ") .. status.Bev) .. vLF
  elseif vOldAPBev > vAPBevoelkerung then
    vMeldung = ((((vMeldung .. "- Bevoelkerung sinkt auf ") .. vAPBevoelkerung) .. " =&gt; ") .. status.Bev) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Bevoelkerung steigt auf ") .. vAPBevoelkerung) .. " =&gt; ") .. status.Bev) .. vLF
  end
  if vOldAPUmw == vAPUmweltbelastung then
    vMeldung = ((((vMeldung .. "- Umweltbelastung bleibt bei ") .. vAPUmweltbelastung) .. " =&gt; ") .. status.Umw) .. vLF
  elseif vOldAPUmw > vAPUmweltbelastung then
    vMeldung = ((((vMeldung .. "- Umweltbelastung sinkt auf ") .. vAPUmweltbelastung) .. " =&gt; ") .. status.Umw) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Umweltbelastung steigt auf ") .. vAPUmweltbelastung) .. " =&gt; ") .. status.Umw) .. vLF
  end
  if vOldAPPol == vAPPolitik then
    vMeldung = ((((vMeldung .. "- Politik bleibt bei ") .. vAPPolitik) .. " =&gt; ") .. status.Pol) .. vLF
  elseif vOldAPPol > vAPPolitik then
    vMeldung = ((((vMeldung .. "- Politik sinkt auf ") .. vAPPolitik) .. " =&gt; ") .. status.Pol) .. vLF
  else
    vMeldung = ((((vMeldung .. "- Politik steigt auf ") .. vAPPolitik) .. " =&gt; ") .. status.Pol) .. vLF
  end
  vMeldung = vMeldung .. vLF
  if vBilanz == vOldBilanz then
    vMeldung = (vMeldung .. "Insgesamt hat sich nichts geaendert") .. vLF
  elseif vBilanz > vOldBilanz then
    vMeldung = (vMeldung .. "Insgesamt hat sich die Situation verbessert") .. vLF
  else
    vMeldung = (vMeldung .. "Insgesamt hat sich die Situation verschlechtert") .. vLF
  end
  vMeldung = vMeldung .. vLF
  vMeldung = ((vMeldung .. "Du hast jetzt ") .. vAktionspunkte) .. " Aktionspunkte"
end
return objKlausdenktnach
