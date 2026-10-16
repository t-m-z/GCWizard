require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _jTuU(str)
  local res = ""
  local dtable = "LK\v7r'B(WPSYX\018q\024+f}n\b\021p\004#Ia\aMDj\0194]\002_,x\015?h\006dO\"`^T\003m\022<gGF\017@H%c~Ny58\014ke=):!\016{\0200 \029z\n\031\023;\005A\rZ21lV\000\026>\030|Q9.t\025[6\027ov3C*\001\\R&J\t\028-u/bs\fiw$EU"
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
objSilvester = Wherigo.ZCartridge()
obj0 = Wherigo.ZMedia(objSilvester)
obj0.Id = "08a445b8-7853-4da6-8745-7a2f70422efd"
obj0.Name = _jTuU("L")
obj0.Description = ""
obj0.AltText = ""
obj0.Resources = {
  {
    Type = "jpg",
    Filename = "0.jpg",
    Directives = {}
  }
}
obj1 = Wherigo.ZMedia(objSilvester)
obj1.Id = "e519a404-4f08-43cd-8400-0bd303e0e2d0"
obj1.Name = _jTuU("Y")
obj1.Description = ""
obj1.AltText = ""
obj1.Resources = {
  {
    Type = "jpg",
    Filename = "1.jpg",
    Directives = {}
  }
}
obj2 = Wherigo.ZMedia(objSilvester)
obj2.Id = "e076bb9f-3288-44dd-96ce-4da90db7d7cc"
obj2.Name = _jTuU("X")
obj2.Description = ""
obj2.AltText = ""
obj2.Resources = {
  {
    Type = "jpg",
    Filename = "2.jpg",
    Directives = {}
  }
}
obj3 = Wherigo.ZMedia(objSilvester)
obj3.Id = "597fb155-d12d-45da-aa09-f6dbae852f4d"
obj3.Name = _jTuU("k")
obj3.Description = ""
obj3.AltText = ""
obj3.Resources = {
  {
    Type = "jpg",
    Filename = "3.jpg",
    Directives = {}
  }
}
obj4 = Wherigo.ZMedia(objSilvester)
obj4.Id = "c6bb4a7a-cee9-487f-ab32-c08c0b864ee4"
obj4.Name = _jTuU("!")
obj4.Description = ""
obj4.AltText = ""
obj4.Resources = {
  {
    Type = "jpg",
    Filename = "4.jpg",
    Directives = {}
  }
}
obj5 = Wherigo.ZMedia(objSilvester)
obj5.Id = "ee2a9e51-e773-431a-93db-630c83852408"
obj5.Name = _jTuU("@")
obj5.Description = ""
obj5.AltText = ""
obj5.Resources = {
  {
    Type = "jpg",
    Filename = "5.jpg",
    Directives = {}
  }
}
obj6 = Wherigo.ZMedia(objSilvester)
obj6.Id = "0b96b308-3d7a-45b0-8e44-c094eadb564a"
obj6.Name = _jTuU("g")
obj6.Description = ""
obj6.AltText = ""
obj6.Resources = {
  {
    Type = "jpg",
    Filename = "6.jpg",
    Directives = {}
  }
}
obj7 = Wherigo.ZMedia(objSilvester)
obj7.Id = "a74a44f3-e861-43fd-bf30-7bde859b8015"
obj7.Name = _jTuU("\004")
obj7.Description = ""
obj7.AltText = ""
obj7.Resources = {
  {
    Type = "jpg",
    Filename = "7.jpg",
    Directives = {}
  }
}
obj8 = Wherigo.ZMedia(objSilvester)
obj8.Id = "fc75a83f-c273-4a97-8b75-e045eccd5904"
obj8.Name = _jTuU("A")
obj8.Description = ""
obj8.AltText = ""
obj8.Resources = {
  {
    Type = "jpg",
    Filename = "8.jpg",
    Directives = {}
  }
}
obj9 = Wherigo.ZMedia(objSilvester)
obj9.Id = "7918b39b-800a-4c36-816e-6baa509449b8"
obj9.Name = _jTuU("b")
obj9.Description = ""
obj9.AltText = ""
obj9.Resources = {
  {
    Type = "jpg",
    Filename = "9.jpg",
    Directives = {}
  }
}
obj10 = Wherigo.ZMedia(objSilvester)
obj10.Id = "61bdf864-0256-4eef-8a5c-8f3550a8e18d"
obj10.Name = _jTuU("YL")
obj10.Description = ""
obj10.AltText = ""
obj10.Resources = {
  {
    Type = "jpg",
    Filename = "10.jpg",
    Directives = {}
  }
}
obj11 = Wherigo.ZMedia(objSilvester)
obj11.Id = "e8268506-a3a9-4aae-b6cd-05b0c81d3e92"
obj11.Name = _jTuU("YY")
obj11.Description = ""
obj11.AltText = ""
obj11.Resources = {
  {
    Type = "jpg",
    Filename = "11.jpg",
    Directives = {}
  }
}
obj12 = Wherigo.ZMedia(objSilvester)
obj12.Id = "05cc440d-89a9-49ad-819f-065cd804d360"
obj12.Name = _jTuU("YX")
obj12.Description = ""
obj12.AltText = ""
obj12.Resources = {
  {
    Type = "jpg",
    Filename = "12.jpg",
    Directives = {}
  }
}
obj13 = Wherigo.ZMedia(objSilvester)
obj13.Id = "99f90db3-6b87-4cec-8355-e043c10d35c4"
obj13.Name = _jTuU("Yk")
obj13.Description = ""
obj13.AltText = ""
obj13.Resources = {
  {
    Type = "jpg",
    Filename = "13.jpg",
    Directives = {}
  }
}
obj14 = Wherigo.ZMedia(objSilvester)
obj14.Id = "8be5720c-fea9-406f-8b94-6815e5beced6"
obj14.Name = _jTuU("Y!")
obj14.Description = ""
obj14.AltText = ""
obj14.Resources = {
  {
    Type = "jpg",
    Filename = "14.jpg",
    Directives = {}
  }
}
obj15 = Wherigo.ZMedia(objSilvester)
obj15.Id = "6d101a96-7069-4cba-b1eb-dfe7bceb9588"
obj15.Name = _jTuU("Y@")
obj15.Description = ""
obj15.AltText = ""
obj15.Resources = {
  {
    Type = "jpg",
    Filename = "15.jpg",
    Directives = {}
  }
}
obj16 = Wherigo.ZMedia(objSilvester)
obj16.Id = "70e70b3e-1077-49f7-a057-5e32132ff70f"
obj16.Name = _jTuU("Yg")
obj16.Description = ""
obj16.AltText = ""
obj16.Resources = {
  {
    Type = "jpg",
    Filename = "16.jpg",
    Directives = {}
  }
}
objPuzzleteil = Wherigo.ZMedia(objSilvester)
objPuzzleteil.Id = "794e7f14-8a0e-4bf7-973b-17d7915b749a"
objPuzzleteil.Name = _jTuU([[

vOOZDdD{Z]])
objPuzzleteil.Description = ""
objPuzzleteil.AltText = ""
objPuzzleteil.Resources = {
  {
    Type = "jpg",
    Filename = "puzzle.jpg",
    Directives = {}
  }
}
objBox = Wherigo.ZMedia(objSilvester)
objBox.Id = "0192cae0-affd-4bb2-a3d2-7758cfd8a9f1"
objBox.Name = _jTuU("\ai&")
objBox.Description = ""
objBox.AltText = ""
objBox.Resources = {
  {
    Type = "jpg",
    Filename = "Box.jpg",
    Directives = {}
  }
}
objErklarung = Wherigo.ZMedia(objSilvester)
objErklarung.Id = "6c577804-a7ea-4b32-b9c5-fd5d1d5638e8"
objErklarung.Name = _jTuU("~\005CZ\195\164\005v\0205")
objErklarung.Description = ""
objErklarung.AltText = ""
objErklarung.Resources = {
  {
    Type = "jpg",
    Filename = "Erklarung.jpg",
    Directives = {}
  }
}
objFrage01 = Wherigo.ZMedia(objSilvester)
objFrage01.Id = "6f226985-0864-4726-9806-80e6157454b2"
objFrage01.Name = _jTuU("7\005\0275DMLY")
objFrage01.Description = ""
objFrage01.AltText = ""
objFrage01.Resources = {
  {
    Type = "jpg",
    Filename = "Frage01.jpg",
    Directives = {}
  }
}
objError = Wherigo.ZMedia(objSilvester)
objError.Id = "4594af4b-7bf7-4360-b682-65789c9b4ce2"
objError.Name = _jTuU("~\005\005i\005")
objError.Description = ""
objError.AltText = ""
objError.Resources = {
  {
    Type = "jpg",
    Filename = "Error.jpg",
    Directives = {}
  }
}
objFrage03 = Wherigo.ZMedia(objSilvester)
objFrage03.Id = "3b50d70f-001e-438f-ac75-9679b009386f"
objFrage03.Name = _jTuU("7\005\0275DMLk")
objFrage03.Description = ""
objFrage03.AltText = ""
objFrage03.Resources = {
  {
    Type = "jpg",
    Filename = "Frage03.jpg",
    Directives = {}
  }
}
objFrage05 = Wherigo.ZMedia(objSilvester)
objFrage05.Id = "3c63ac4e-4704-45bb-a3f9-29f630228f48"
objFrage05.Name = _jTuU("7\005\0275DML@")
objFrage05.Description = ""
objFrage05.AltText = ""
objFrage05.Resources = {
  {
    Type = "jpg",
    Filename = "Frage05.jpg",
    Directives = {}
  }
}
objFrage06 = Wherigo.ZMedia(objSilvester)
objFrage06.Id = "28bbe636-315c-4871-8299-ccaecbf02129"
objFrage06.Name = _jTuU("7\005\0275DMLg")
objFrage06.Description = ""
objFrage06.AltText = ""
objFrage06.Resources = {
  {
    Type = "jpg",
    Filename = "Frage06.jpg",
    Directives = {}
  }
}
objFrage02 = Wherigo.ZMedia(objSilvester)
objFrage02.Id = "b18c28dc-22ad-448b-9c43-3946d192d5a6"
objFrage02.Name = _jTuU("7\005\0275DMLX")
objFrage02.Description = ""
objFrage02.AltText = ""
objFrage02.Resources = {
  {
    Type = "jpg",
    Filename = "Frage02.jpg",
    Directives = {}
  }
}
objFrage04 = Wherigo.ZMedia(objSilvester)
objFrage04.Id = "98a05c0f-5617-41e7-9c65-0f00e929e547"
objFrage04.Name = _jTuU("7\005\0275DML!")
objFrage04.Description = ""
objFrage04.AltText = ""
objFrage04.Resources = {
  {
    Type = "jpg",
    Filename = "Frage04.jpg",
    Directives = {}
  }
}
objFrage09 = Wherigo.ZMedia(objSilvester)
objFrage09.Id = "69cfddcd-ddf4-4b7e-8e5a-1af07cde4650"
objFrage09.Name = _jTuU("7\005\0275DMLb")
objFrage09.Description = ""
objFrage09.AltText = ""
objFrage09.Resources = {
  {
    Type = "jpg",
    Filename = "Frage09.jpg",
    Directives = {}
  }
}
objFrage10 = Wherigo.ZMedia(objSilvester)
objFrage10.Id = "abe0d3ad-516c-4933-90c5-0d9280881ec4"
objFrage10.Name = _jTuU("7\005\0275DMYL")
objFrage10.Description = ""
objFrage10.AltText = ""
objFrage10.Resources = {
  {
    Type = "jpg",
    Filename = "Frage10.jpg",
    Directives = {}
  }
}
objFrage11 = Wherigo.ZMedia(objSilvester)
objFrage11.Id = "f6ee1356-e16a-40b2-a077-fa825ba2d58f"
objFrage11.Name = _jTuU("7\005\0275DMYY")
objFrage11.Description = ""
objFrage11.AltText = ""
objFrage11.Resources = {
  {
    Type = "jpg",
    Filename = "Frage11.jpg",
    Directives = {}
  }
}
objFrage13 = Wherigo.ZMedia(objSilvester)
objFrage13.Id = "3bcd9493-ac50-459e-8685-8703b183d3c2"
objFrage13.Name = _jTuU("7\005\0275DMYk")
objFrage13.Description = ""
objFrage13.AltText = ""
objFrage13.Resources = {
  {
    Type = "jpg",
    Filename = "Frage13.jpg",
    Directives = {}
  }
}
objFrage12 = Wherigo.ZMedia(objSilvester)
objFrage12.Id = "af470d9e-c0ac-405a-98d1-6050436cafea"
objFrage12.Name = _jTuU("7\005\0275DMYX")
objFrage12.Description = ""
objFrage12.AltText = ""
objFrage12.Resources = {
  {
    Type = "jpg",
    Filename = "Frage12.jpg",
    Directives = {}
  }
}
objFrage14 = Wherigo.ZMedia(objSilvester)
objFrage14.Id = "c9cb4aec-a01c-4fed-bde7-a5006af18a14"
objFrage14.Name = _jTuU("7\005\0275DMY!")
objFrage14.Description = ""
objFrage14.AltText = ""
objFrage14.Resources = {
  {
    Type = "jpg",
    Filename = "Frage14.jpg",
    Directives = {}
  }
}
objFrage15 = Wherigo.ZMedia(objSilvester)
objFrage15.Id = "ef83a663-3163-4529-93fe-a79a5d877359"
objFrage15.Name = _jTuU("7\005\0275DMY@")
objFrage15.Description = ""
objFrage15.AltText = ""
objFrage15.Resources = {
  {
    Type = "jpg",
    Filename = "Frage15.jpg",
    Directives = {}
  }
}
objFrage07 = Wherigo.ZMedia(objSilvester)
objFrage07.Id = "5751c229-4443-40e1-92cf-cba21dd06ea7"
objFrage07.Name = _jTuU("7\005\0275DML\004")
objFrage07.Description = ""
objFrage07.AltText = ""
objFrage07.Resources = {
  {
    Type = "jpg",
    Filename = "Frage07.jpg",
    Directives = {}
  }
}
objFrage08 = Wherigo.ZMedia(objSilvester)
objFrage08.Id = "c8adc2de-4020-41ce-9a63-37a88ad7df09"
objFrage08.Name = _jTuU("7\005\0275DMLA")
objFrage08.Description = ""
objFrage08.AltText = ""
objFrage08.Resources = {
  {
    Type = "jpg",
    Filename = "Frage08.jpg",
    Directives = {}
  }
}
objKlasse = Wherigo.ZMedia(objSilvester)
objKlasse.Id = "b43f49be-de97-4135-b683-a483e06cdd6e"
objKlasse.Name = _jTuU("\002Z\027yyD")
objKlasse.Description = ""
objKlasse.AltText = ""
objKlasse.Resources = {
  {
    Type = "jpg",
    Filename = "Titel.jpg",
    Directives = {}
  }
}
objFrage16 = Wherigo.ZMedia(objSilvester)
objFrage16.Id = "c8a5a05d-ed72-4e47-9375-0f688d399fab"
objFrage16.Name = _jTuU("7\005\0275DMYg")
objFrage16.Description = ""
objFrage16.AltText = ""
objFrage16.Resources = {
  {
    Type = "jpg",
    Filename = "Frage16.jpg",
    Directives = {}
  }
}
objLosung01 = Wherigo.ZMedia(objSilvester)
objLosung01.Id = "9f3d31cf-1e87-4123-bc41-eaec34f6fd7a"
objLosung01.Name = _jTuU("\001\195\182yv\0205MLY")
objLosung01.Description = ""
objLosung01.AltText = ""
objLosung01.Resources = {
  {
    Type = "jpg",
    Filename = "Losung01.jpg",
    Directives = {}
  }
}
obj0Punkte = Wherigo.ZMedia(objSilvester)
obj0Punkte.Id = "34800a95-4278-4872-aad4-0ea2277f1dc1"
obj0Punkte.Name = _jTuU("LM\nv\020CdD")
obj0Punkte.Description = ""
obj0Punkte.AltText = ""
obj0Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "00.jpg",
    Directives = {}
  }
}
obj1Punkt = Wherigo.ZMedia(objSilvester)
obj1Punkt.Id = "52874650-364b-4add-a3b0-d8a61d1ac508"
obj1Punkt.Name = _jTuU("YM\nv\020Cd")
obj1Punkt.Description = ""
obj1Punkt.AltText = ""
obj1Punkt.Resources = {
  {
    Type = "jpg",
    Filename = "01.jpg",
    Directives = {}
  }
}
obj3Punkte = Wherigo.ZMedia(objSilvester)
obj3Punkte.Id = "d2f7f10b-aa98-49f7-90c7-234c2b7bfc3f"
obj3Punkte.Name = _jTuU("kM\nv\020CdD")
obj3Punkte.Description = ""
obj3Punkte.AltText = ""
obj3Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "03.jpg",
    Directives = {}
  }
}
obj2Punkte = Wherigo.ZMedia(objSilvester)
obj2Punkte.Id = "e2f1efcb-d4c7-4114-885a-a62418e52c60"
obj2Punkte.Name = _jTuU("XM\nv\020CdD")
obj2Punkte.Description = ""
obj2Punkte.AltText = ""
obj2Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "02.jpg",
    Directives = {}
  }
}
obj4Punkte = Wherigo.ZMedia(objSilvester)
obj4Punkte.Id = "8d6c1d0f-dcdb-4318-8687-bf6de9f4b651"
obj4Punkte.Name = _jTuU("!M\nv\020CdD")
obj4Punkte.Description = ""
obj4Punkte.AltText = ""
obj4Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "04.jpg",
    Directives = {}
  }
}
obj5Punkte = Wherigo.ZMedia(objSilvester)
obj5Punkte.Id = "d4e8e536-99be-4ed8-aa2d-d50cd8e62a0b"
obj5Punkte.Name = _jTuU("@M\nv\020CdD")
obj5Punkte.Description = ""
obj5Punkte.AltText = ""
obj5Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "05.jpg",
    Directives = {}
  }
}
obj6Punkte = Wherigo.ZMedia(objSilvester)
obj6Punkte.Id = "586b706d-7ccd-4860-9aa6-6dc0d4431c2f"
obj6Punkte.Name = _jTuU("gM\nv\020CdD")
obj6Punkte.Description = ""
obj6Punkte.AltText = ""
obj6Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "06.jpg",
    Directives = {}
  }
}
obj7Punkte = Wherigo.ZMedia(objSilvester)
obj7Punkte.Id = "6867d0d0-d43b-493b-a877-fb8c006f303f"
obj7Punkte.Name = _jTuU("\004M\nv\020CdD")
obj7Punkte.Description = ""
obj7Punkte.AltText = ""
obj7Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "07.jpg",
    Directives = {}
  }
}
obj8Punkte = Wherigo.ZMedia(objSilvester)
obj8Punkte.Id = "d9c593da-bdf6-4e0d-b0fe-bb8ca361d8fb"
obj8Punkte.Name = _jTuU("AM\nv\020CdD")
obj8Punkte.Description = ""
obj8Punkte.AltText = ""
obj8Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "08.jpg",
    Directives = {}
  }
}
obj9Punkte = Wherigo.ZMedia(objSilvester)
obj9Punkte.Id = "a5091741-046e-4bdc-a280-657232637acd"
obj9Punkte.Name = _jTuU("bM\nv\020CdD")
obj9Punkte.Description = ""
obj9Punkte.AltText = ""
obj9Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "09.jpg",
    Directives = {}
  }
}
obj10Punkte = Wherigo.ZMedia(objSilvester)
obj10Punkte.Id = "3d4de541-7f21-43da-b412-a745dab53ba9"
obj10Punkte.Name = _jTuU("YLM\nv\020CdD")
obj10Punkte.Description = ""
obj10Punkte.AltText = ""
obj10Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "010.jpg",
    Directives = {}
  }
}
obj11Punkte = Wherigo.ZMedia(objSilvester)
obj11Punkte.Id = "ac9c576f-7bdb-4dcb-b0af-ab01a8769973"
obj11Punkte.Name = _jTuU("YYM\nv\020CdD")
obj11Punkte.Description = ""
obj11Punkte.AltText = ""
obj11Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "011.jpg",
    Directives = {}
  }
}
obj12Punkte = Wherigo.ZMedia(objSilvester)
obj12Punkte.Id = "b389179b-84be-4943-8751-8af41946f766"
obj12Punkte.Name = _jTuU("YXM\nv\020CdD")
obj12Punkte.Description = ""
obj12Punkte.AltText = ""
obj12Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "012.jpg",
    Directives = {}
  }
}
obj13Punkte = Wherigo.ZMedia(objSilvester)
obj13Punkte.Id = "dbcbabb5-c2be-4091-8b17-5ae1f0eabf35"
obj13Punkte.Name = _jTuU("YkM\nv\020CdD")
obj13Punkte.Description = ""
obj13Punkte.AltText = ""
obj13Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "013.jpg",
    Directives = {}
  }
}
obj14Punkte = Wherigo.ZMedia(objSilvester)
obj14Punkte.Id = "30bf9c93-9f06-488d-a38d-865d769416b6"
obj14Punkte.Name = _jTuU("Y!M\nv\020CdD")
obj14Punkte.Description = ""
obj14Punkte.AltText = ""
obj14Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "014.jpg",
    Directives = {}
  }
}
obj15Punkte = Wherigo.ZMedia(objSilvester)
obj15Punkte.Id = "105cf267-7456-4278-a655-77bbfa3dda7d"
obj15Punkte.Name = _jTuU("Y@M\nv\020CdD")
obj15Punkte.Description = ""
obj15Punkte.AltText = ""
obj15Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "015.jpg",
    Directives = {}
  }
}
obj16Punkte = Wherigo.ZMedia(objSilvester)
obj16Punkte.Id = "ef486631-b257-4109-97e7-ed3c27ad1c5d"
obj16Punkte.Name = _jTuU("YgM\nv\020CdD")
obj16Punkte.Description = ""
obj16Punkte.AltText = ""
obj16Punkte.Resources = {
  {
    Type = "jpg",
    Filename = "016.jpg",
    Directives = {}
  }
}
objAuswertung = Wherigo.ZMedia(objSilvester)
objAuswertung.Id = "0c38bceb-bacb-4cf0-b656-4ee58a99ff96"
objAuswertung.Name = _jTuU("Uvy|D\005dv\0205")
objAuswertung.Description = ""
objAuswertung.AltText = ""
objAuswertung.Resources = {
  {
    Type = "jpg",
    Filename = "Auswertung.jpg",
    Directives = {}
  }
}
objLosung02 = Wherigo.ZMedia(objSilvester)
objLosung02.Id = "8fb9bbe6-3417-4bba-a230-be6c86cf66a6"
objLosung02.Name = _jTuU("\001\195\182yv\0205MLX")
objLosung02.Description = ""
objLosung02.AltText = ""
objLosung02.Resources = {
  {
    Type = "jpg",
    Filename = "Losung02.jpg",
    Directives = {}
  }
}
objLosung03 = Wherigo.ZMedia(objSilvester)
objLosung03.Id = "d982a35e-4155-4821-b1c8-2867a5f37913"
objLosung03.Name = _jTuU("\001\195\182yv\0205MLk")
objLosung03.Description = ""
objLosung03.AltText = ""
objLosung03.Resources = {
  {
    Type = "jpg",
    Filename = "Losung03.jpg",
    Directives = {}
  }
}
objLosung04 = Wherigo.ZMedia(objSilvester)
objLosung04.Id = "e7fb7a76-a1f3-43d9-a97c-6cb0fbbe0392"
objLosung04.Name = _jTuU("\001\195\182yv\0205ML!")
objLosung04.Description = ""
objLosung04.AltText = ""
objLosung04.Resources = {
  {
    Type = "jpg",
    Filename = "Losung04.jpg",
    Directives = {}
  }
}
objLosung05 = Wherigo.ZMedia(objSilvester)
objLosung05.Id = "a1b55617-ad34-400e-87db-84ed3fac574b"
objLosung05.Name = _jTuU("\001\195\182yv\0205ML@")
objLosung05.Description = ""
objLosung05.AltText = ""
objLosung05.Resources = {
  {
    Type = "jpg",
    Filename = "Losung05.jpg",
    Directives = {}
  }
}
objLosung06 = Wherigo.ZMedia(objSilvester)
objLosung06.Id = "0e48a048-ffe2-48fb-810e-ac5b6740f447"
objLosung06.Name = _jTuU("\001\195\182yv\0205MLg")
objLosung06.Description = ""
objLosung06.AltText = ""
objLosung06.Resources = {
  {
    Type = "jpg",
    Filename = "Losung06.jpg",
    Directives = {}
  }
}
objLosung07 = Wherigo.ZMedia(objSilvester)
objLosung07.Id = "06db3cd5-c7ed-49c9-972a-08dc7a58cbbe"
objLosung07.Name = _jTuU("\001\195\182yv\0205ML\004")
objLosung07.Description = ""
objLosung07.AltText = ""
objLosung07.Resources = {
  {
    Type = "jpg",
    Filename = "Losung07.jpg",
    Directives = {}
  }
}
objLosung08 = Wherigo.ZMedia(objSilvester)
objLosung08.Id = "21b3c5f7-4a39-4f96-b949-0cd2694ec5aa"
objLosung08.Name = _jTuU("\001\195\182yv\0205MLA")
objLosung08.Description = ""
objLosung08.AltText = ""
objLosung08.Resources = {
  {
    Type = "jpg",
    Filename = "Losung08.jpg",
    Directives = {}
  }
}
objLosung09 = Wherigo.ZMedia(objSilvester)
objLosung09.Id = "aa8d0bbc-7a7f-4a42-9074-844be24fa964"
objLosung09.Name = _jTuU("\001\195\182yv\0205MLb")
objLosung09.Description = ""
objLosung09.AltText = ""
objLosung09.Resources = {
  {
    Type = "jpg",
    Filename = "Losung09.jpg",
    Directives = {}
  }
}
objLosung10 = Wherigo.ZMedia(objSilvester)
objLosung10.Id = "7e018fd9-154d-47ef-a0e4-75bcc4533025"
objLosung10.Name = _jTuU("\001\195\182yv\0205MYL")
objLosung10.Description = ""
objLosung10.AltText = ""
objLosung10.Resources = {
  {
    Type = "jpg",
    Filename = "Losung10.jpg",
    Directives = {}
  }
}
objLosung11 = Wherigo.ZMedia(objSilvester)
objLosung11.Id = "df4ee479-7ced-4097-9a47-b747cf9ae52d"
objLosung11.Name = _jTuU("\001\195\182yv\0205MYY")
objLosung11.Description = ""
objLosung11.AltText = ""
objLosung11.Resources = {
  {
    Type = "jpg",
    Filename = "Losung11.jpg",
    Directives = {}
  }
}
objLosung12 = Wherigo.ZMedia(objSilvester)
objLosung12.Id = "679fc0b6-2e15-4148-84b6-d7f742884327"
objLosung12.Name = _jTuU("\001\195\182yv\0205MYX")
objLosung12.Description = ""
objLosung12.AltText = ""
objLosung12.Resources = {
  {
    Type = "jpg",
    Filename = "Losung12.jpg",
    Directives = {}
  }
}
objLosung13 = Wherigo.ZMedia(objSilvester)
objLosung13.Id = "c8b7632f-3d37-45e7-aaba-63a79fa24b41"
objLosung13.Name = _jTuU("\001\195\182yv\0205MYk")
objLosung13.Description = ""
objLosung13.AltText = ""
objLosung13.Resources = {
  {
    Type = "jpg",
    Filename = "Losung13.jpg",
    Directives = {}
  }
}
objLosung14 = Wherigo.ZMedia(objSilvester)
objLosung14.Id = "fe5ba21c-3510-4370-8020-8a1b3ef46a28"
objLosung14.Name = _jTuU("\001\195\182yv\0205MY!")
objLosung14.Description = ""
objLosung14.AltText = ""
objLosung14.Resources = {
  {
    Type = "jpg",
    Filename = "Losung14.jpg",
    Directives = {}
  }
}
objLosung15 = Wherigo.ZMedia(objSilvester)
objLosung15.Id = "650870db-6cf0-4c6a-b8fc-d76cea41748b"
objLosung15.Name = _jTuU("\001\195\182yv\0205MY@")
objLosung15.Description = ""
objLosung15.AltText = ""
objLosung15.Resources = {
  {
    Type = "jpg",
    Filename = "Losung15.jpg",
    Directives = {}
  }
}
objLosung16 = Wherigo.ZMedia(objSilvester)
objLosung16.Id = "dd37ed33-2b02-488a-a0fe-8467223563fd"
objLosung16.Name = _jTuU("\001\195\182yv\0205MYg")
objLosung16.Description = ""
objLosung16.AltText = ""
objLosung16.Resources = {
  {
    Type = "jpg",
    Filename = "Losung16.jpg",
    Directives = {}
  }
}
objSilvester.Id = "f79f73f6-6346-48c0-ab53-2aa0e5abd45d"
objSilvester.Name = "Silvester"
objSilvester.Description = ""
objSilvester.Visible = true
objSilvester.Activity = "Puzzle"
objSilvester.StartingLocationDescription = [[
Bildquelle:<BR>
- eigene Werke<BR>
- Pixabay.com<BR>
- Quellenangabe am Bild ]]
objSilvester.StartingLocation = Wherigo.INVALID_ZONEPOINT
objSilvester.Version = ""
objSilvester.Company = ""
objSilvester.Author = "Roesslix"
objSilvester.BuilderVersion = "URWIGO 1.22.5798.37755"
objSilvester.CreateDate = "07/08/2020 13:47:14"
objSilvester.PublishDate = "1/1/0001 12:00:00 AM"
objSilvester.UpdateDate = "01/01/2021 13:58:46"
objSilvester.LastPlayedDate = "1/1/0001 12:00:00 AM"
objSilvester.TargetDevice = "PocketPC"
objSilvester.TargetDeviceVersion = "0"
objSilvester.StateId = "1"
objSilvester.CountryId = "2"
objSilvester.Complete = false
objSilvester.UseLogging = true
objSilvester.Media = objKlasse
objSilvester.Icon = objKlasse
objAufgabenlosen = Wherigo.ZTask(objSilvester)
objAufgabenlosen.Id = "888f97e5-ca12-43f7-98cd-264d59f8708e"
objAufgabenlosen.Name = _jTuU("Uv\0185\027xD\020MZ\195\182yD\020")
objAufgabenlosen.Description = ""
objAufgabenlosen.Visible = true
objAufgabenlosen.Media = objKlasse
objAufgabenlosen.Icon = objKlasse
objAufgabenlosen.Active = true
objAufgabenlosen.Complete = false
objAufgabenlosen.CorrectState = "None"
objPuzzleteile = 15
currentZone = _jTuU("+v22?")
currentCharacter = _jTuU("+v22?")
currentItem = _jTuU("+v22?")
currentTask = _jTuU("ix\031Uv\0185\027xD\020ZiyD\020")
currentInput = _jTuU("ix\0317\005\0275DY")
currentTimer = _jTuU("+v22?")
objSilvester.ZVariables = {
  objPuzzleteile = 15,
  currentZone = _jTuU("+v22?"),
  currentCharacter = _jTuU("+v22?"),
  currentItem = _jTuU("+v22?"),
  currentTask = _jTuU("ix\031Uv\0185\027xD\020ZiyD\020"),
  currentInput = _jTuU("ix\0317\005\0275DY"),
  currentTimer = _jTuU("+v22?")
}
objFrage1 = Wherigo.ZInput(objSilvester)
objFrage1.Id = "9577b6eb-673c-4234-a84b-1edc4ef665e2"
objFrage1.Name = _jTuU("7\005\0275DMY")
objFrage1.Description = ""
objFrage1.Visible = true
objFrage1.Media = objFrage01
objFrage1.Icon = objFrage01
objFrage1.Choices = {
  "A",
  "B",
  "C"
}
objFrage1.InputType = "MultipleChoice"
objFrage1.Text = ""
objFrage2 = Wherigo.ZInput(objSilvester)
objFrage2.Id = "35c968f0-c987-4f5a-b221-79ecc4b041c0"
objFrage2.Name = _jTuU("7\005\0275DMX")
objFrage2.Description = ""
objFrage2.Visible = true
objFrage2.Media = objFrage02
objFrage2.Icon = objFrage02
objFrage2.Choices = {
  "A",
  "B",
  "C"
}
objFrage2.InputType = "MultipleChoice"
objFrage2.Text = ""
objFrage3 = Wherigo.ZInput(objSilvester)
objFrage3.Id = "d386b6ea-7db3-4aa5-84fa-b063fc3df4c0"
objFrage3.Name = _jTuU("7\005\0275DMk")
objFrage3.Description = ""
objFrage3.Visible = true
objFrage3.Media = objFrage03
objFrage3.Icon = objFrage03
objFrage3.Choices = {
  "A",
  "B",
  "C"
}
objFrage3.InputType = "MultipleChoice"
objFrage3.Text = ""
objFrage4 = Wherigo.ZInput(objSilvester)
objFrage4.Id = "edd0b252-374f-4da3-b1af-f134aff9a22f"
objFrage4.Name = _jTuU("7\005\0275DM!")
objFrage4.Description = ""
objFrage4.Visible = true
objFrage4.Media = objFrage04
objFrage4.Icon = objFrage04
objFrage4.Choices = {
  "A",
  "B",
  "C"
}
objFrage4.InputType = "MultipleChoice"
objFrage4.Text = ""
objFrage5 = Wherigo.ZInput(objSilvester)
objFrage5.Id = "3bdc21a4-62f1-457b-8255-9714f8cc0679"
objFrage5.Name = _jTuU("7\005\0275DM@")
objFrage5.Description = ""
objFrage5.Visible = true
objFrage5.Media = objFrage05
objFrage5.Icon = objFrage05
objFrage5.Choices = {
  "A",
  "B",
  "C"
}
objFrage5.InputType = "MultipleChoice"
objFrage5.Text = ""
objFrage6 = Wherigo.ZInput(objSilvester)
objFrage6.Id = "0b2ec918-5534-483f-abf9-19845e930392"
objFrage6.Name = _jTuU("7\005\0275DMg")
objFrage6.Description = ""
objFrage6.Visible = true
objFrage6.Media = objFrage06
objFrage6.Icon = objFrage06
objFrage6.Choices = {
  "A",
  "B",
  "C"
}
objFrage6.InputType = "MultipleChoice"
objFrage6.Text = ""
objFrage7 = Wherigo.ZInput(objSilvester)
objFrage7.Id = "f368d45f-6684-4698-b38c-73281d34117e"
objFrage7.Name = _jTuU("7\005\0275DM\004")
objFrage7.Description = ""
objFrage7.Visible = true
objFrage7.Media = objFrage07
objFrage7.Icon = objFrage07
objFrage7.Choices = {
  "A",
  "B",
  "C"
}
objFrage7.InputType = "MultipleChoice"
objFrage7.Text = ""
objFrage8 = Wherigo.ZInput(objSilvester)
objFrage8.Id = "224b1e0e-947e-420f-867d-a2e1b3a07f6c"
objFrage8.Name = _jTuU("7\005\0275DMA")
objFrage8.Description = ""
objFrage8.Visible = true
objFrage8.Media = objFrage08
objFrage8.Icon = objFrage08
objFrage8.Choices = {
  "A",
  "B",
  "C"
}
objFrage8.InputType = "MultipleChoice"
objFrage8.Text = ""
objFrage9 = Wherigo.ZInput(objSilvester)
objFrage9.Id = "cae2e14d-17a5-43e4-8b2c-3b767eeb6e28"
objFrage9.Name = _jTuU("7\005\0275DMb")
objFrage9.Description = ""
objFrage9.Visible = true
objFrage9.Media = objFrage09
objFrage9.Icon = objFrage09
objFrage9.Choices = {
  "A",
  "B",
  "C"
}
objFrage9.InputType = "MultipleChoice"
objFrage9.Text = ""
objFrage10_1 = Wherigo.ZInput(objSilvester)
objFrage10_1.Id = "415e0e74-8ad2-4abc-95f9-7cbda24b4cd9"
objFrage10_1.Name = _jTuU("7\005\0275DMYL")
objFrage10_1.Description = ""
objFrage10_1.Visible = true
objFrage10_1.Media = objFrage10
objFrage10_1.Icon = objFrage10
objFrage10_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage10_1.InputType = "MultipleChoice"
objFrage10_1.Text = ""
objFrage11_1 = Wherigo.ZInput(objSilvester)
objFrage11_1.Id = "82d20a06-86f6-46be-bb0b-e0f5d6d40a9a"
objFrage11_1.Name = _jTuU("7\005\0275DMYY")
objFrage11_1.Description = ""
objFrage11_1.Visible = true
objFrage11_1.Media = objFrage11
objFrage11_1.Icon = objFrage11
objFrage11_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage11_1.InputType = "MultipleChoice"
objFrage11_1.Text = ""
objFrage12_1 = Wherigo.ZInput(objSilvester)
objFrage12_1.Id = "f83e28bc-56a4-4189-8657-607d3499ba64"
objFrage12_1.Name = _jTuU("7\005\0275DMYX")
objFrage12_1.Description = ""
objFrage12_1.Visible = true
objFrage12_1.Media = objFrage12
objFrage12_1.Icon = objFrage12
objFrage12_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage12_1.InputType = "MultipleChoice"
objFrage12_1.Text = ""
objFrage13_1 = Wherigo.ZInput(objSilvester)
objFrage13_1.Id = "46fcd7af-d3cd-40bb-acd7-aa9508045beb"
objFrage13_1.Name = _jTuU("7\005\0275DMYk")
objFrage13_1.Description = ""
objFrage13_1.Visible = true
objFrage13_1.Media = objFrage13
objFrage13_1.Icon = objFrage13
objFrage13_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage13_1.InputType = "MultipleChoice"
objFrage13_1.Text = ""
objFrage14_1 = Wherigo.ZInput(objSilvester)
objFrage14_1.Id = "a17ec4a9-c642-431e-8d26-abcb801c5cf5"
objFrage14_1.Name = _jTuU("7\005\0275DMY!")
objFrage14_1.Description = ""
objFrage14_1.Visible = true
objFrage14_1.Media = objFrage14
objFrage14_1.Icon = objFrage14
objFrage14_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage14_1.InputType = "MultipleChoice"
objFrage14_1.Text = ""
objFrage15_1 = Wherigo.ZInput(objSilvester)
objFrage15_1.Id = "a5f475e6-210d-4078-9a3a-351a243e95a6"
objFrage15_1.Name = _jTuU("7\005\0275DMY@")
objFrage15_1.Description = ""
objFrage15_1.Visible = true
objFrage15_1.Media = objFrage15
objFrage15_1.Icon = objFrage15
objFrage15_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage15_1.InputType = "MultipleChoice"
objFrage15_1.Text = ""
objFrage16_1 = Wherigo.ZInput(objSilvester)
objFrage16_1.Id = "a268491b-ea7f-40b0-b632-0777cd5d5b20"
objFrage16_1.Name = _jTuU("7\005\0275DMYg")
objFrage16_1.Description = ""
objFrage16_1.Visible = true
objFrage16_1.Media = objFrage16
objFrage16_1.Icon = objFrage16
objFrage16_1.Choices = {
  "A",
  "B",
  "C"
}
objFrage16_1.InputType = "MultipleChoice"
objFrage16_1.Text = ""
objAuswertung1 = Wherigo.ZInput(objSilvester)
objAuswertung1.Id = "6f94c0fb-c46c-4f80-90b1-4917e3b688ff"
objAuswertung1.Name = _jTuU("Uvy|D\005dv\0205")
objAuswertung1.Description = ""
objAuswertung1.Visible = true
objAuswertung1.Media = objAuswertung
objAuswertung1.Icon = objAuswertung
objAuswertung1.Choices = {
  "Ich bin gespannt",
  "Ich will es gar nicht wissen"
}
objAuswertung1.InputType = "MultipleChoice"
objAuswertung1.Text = _jTuU("\127\020+M\020v\020M+{DMUvy|D\005dv\0205Mccc")
function objSilvester:OnStart()
  objPuzzleteile = 0
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objFrage1)
  end)
end
function objSilvester:OnRestore()
end
function objAufgabenlosen:OnClick()
  objPuzzleteile = 0
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objFrage1)
  end)
end
function objFrage1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage2)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage2)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage2)
          end)
        end
      end
    })
  end
end
function objFrage2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage3)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage3)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage3)
          end)
        end
      end
    })
  end
end
function objFrage3:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage4)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage4)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage4)
          end)
        end
      end
    })
  end
end
function objFrage4:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage5)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage5)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage5)
          end)
        end
      end
    })
  end
end
function objFrage5:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage6)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage6)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage6)
          end)
        end
      end
    })
  end
end
function objFrage6:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage7)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage7)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage7)
          end)
        end
      end
    })
  end
end
function objFrage7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage8)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage8)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage8)
          end)
        end
      end
    })
  end
end
function objFrage8:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage9)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage9)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage9)
          end)
        end
      end
    })
  end
end
function objFrage9:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage10_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage10_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage10_1)
          end)
        end
      end
    })
  end
end
function objFrage10_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage11_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage11_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage11_1)
          end)
        end
      end
    })
  end
end
function objFrage11_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage12_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage12_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage12_1)
          end)
        end
      end
    })
  end
end
function objFrage12_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage13_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage13_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage13_1)
          end)
        end
      end
    })
  end
end
function objFrage13_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage14_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage14_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage14_1)
          end)
        end
      end
    })
  end
end
function objFrage14_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage15_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage15_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage15_1)
          end)
        end
      end
    })
  end
end
function objFrage15_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage16_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage16_1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\127\020+M\020v\020M\027v\018MOvM\020DvD\020MUv\0185\027xD\020Mv\020+MW{DZD\020Mccc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage16_1)
          end)
        end
      end
    })
  end
end
function objFrage16_1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    objPuzzleteile = objPuzzleteile + 1
    _Urwigo.MessageBox({
      Text = _jTuU("\030vM)\027ydM+{DMUv\0185\027xDMdiZZMD\005ZD+{5dcM4\ap^\030\027\018\195\188\005MD\005)\195\164ZdydM\030vMD{\020M\nvOODZdD{ZM\018\195\188\005M\030D{\020DM\nvOOZDxi&c4\ap^\030\027yM|\027\005M+{DMZDdOdDMUv\0185\027xDc"),
      Media = objPuzzleteil,
      Buttons = {
        _jTuU("\030\027\020CD")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objAuswertung1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 98 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\030\027yM|\027\005M+{DMZDdOdDMUv\0185\027xDc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objAuswertung1)
          end)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 99 then
    _Urwigo.MessageBox({
      Text = _jTuU("\v<)\027+D%M+\027yyM|\027\005M\020{<)dM+{DM\005{<)d{5DM\001\195\182yv\0205cMq\020xy\023S4\ap^\030\027\018\195\188\005MC\027\020\020MDyMCD{\020M\nvOOZDdD{ZM5DxD\020c4\ap^\030\027yM|\027\005M+{DMZDdOdDMUv\0185\027xDc"),
      Media = objError,
      Buttons = {
        _jTuU("\v<)\027+D")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objAuswertung1)
          end)
        end
      end
    })
  end
end
function objAuswertung1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 2040 then
    if objPuzzleteile == 0 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMCD{\020MD{\020O{5DyM\nvOODZdD{ZM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\018\027ydM\020{<)dyMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH4\ap^4\ap^"),
        Media = obj0,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj0Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 1 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM\020v\005MD{\020MD{\020O{5DyM\nvOODZdD{ZM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\018\027ydM\020{<)dyMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj1,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj1Punkt,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 2 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM\020v\005MO|D{M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\018\027ydM\020{<)dyMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj2,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj2Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 3 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM+\005D{M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\020{<)dMj{DZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj3,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj3Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 4 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMj{D\005M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\020{<)dMj{DZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj4,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj4Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 5 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMC\018\195\188\020\018M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\020{<)dMj{DZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj5,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj5Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 6 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMyD<)yM\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\001D{+D\005My{D)ydM\030vM+Dy)\027ZxM\020{<)dMj{DZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dMy<)i\020Mj{DZMxDyyD\005MyD{\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj6,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj6Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 7 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMy{DxD\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030Dy)\027ZxMy{D)ydM\030vM\020v\005MD{\020M0D{ZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dM\020i<)MxDyyD\005M|D\005+D\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj7,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj7Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 8 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM\027<)dM\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030Dy)\027ZxMy{D)ydM\030vM\020v\005MD{\020M0D{ZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dM\020i<)MxDyyD\005M|D\005+D\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj8,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj8Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 9 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM\020Dv\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030Dy)\027ZxMy{D)ydM\030vM\020v\005MD{\020M0D{ZMji2M5Dy\0272dD\020M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M|{\005ydM\030vMxD{2M\020\195\164<)ydD\020M\029\027ZMxDyd{22dM\020i<)MxDyyD\005M|D\005+D\020cM4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj9,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj9Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 10 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMOD)\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030Dy)\027ZxMy{D)ydM\030vM\020v\005M+D\020M\195\188xD\005|{D5D\020+D\020M0D{ZMji2M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M{ydMxDyd{22dM\020i<)M2D)\005M+\005{\020c4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj10,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj10Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 11 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMDZ\018M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030Dy)\027ZxMy{D)ydM\030vM\020v\005M+D\020M\195\188xD\005|{D5D\020+D\020M0D{ZMji2M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M{ydMxDyd{22dM\020i<)M2D)\005M+\005{\020c4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj11,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj11Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 12 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMO|\195\182Z\018M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030Dy)\027ZxMy{D)ydM\030vM\020v\005M+D\020M\195\188xD\005|{D5D\020+D\020M0D{ZMji2M\nvOOZDcM4\ap^\tD\020\020M\030vM\030{<)MxD2\195\188)yd%M{ydMxDyd{22dM\020i<)M2D)\005M+\005{\020c4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj12,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj12Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 13 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM+\005D{OD)\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030vMC\027\020\020ydM\018\027ydM+\027yM5Dy\0272dDM\nvOOZDMyD)D\020cM\tD\020\020M\030vM\030{<)MxD2\195\188)yd%MC\027\020\020ydM+vMDyMCi2\023ZDddMy<)\027\018\018D\020c4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj13,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj13Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 14 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydMj{D\005OD)\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030vMC\027\020\020ydM\018\027ydM+\027yM5Dy\0272dDM\nvOOZDMyD)D\020cM\tD\020\020M\030vM\030{<)MxD2\195\188)yd%MC\027\020\020ydM+vMDyMCi2\023ZDddMy<)\027\018\018D\020c4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj14,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj14Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 15 then
      _Urwigo.MessageBox({
        Text = _jTuU("\030vM)\027ydM\018\195\188\020\018OD)\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^~yM\018D)ZdM\020v\005M\020i<)MD{\020M\nvOOZDdD{ZH4\ap^4\ap^UZyiM\002i\023\018M)i<)Mv\020+MD{\020D\020M\020DvD\020M[D\005yv<)M5Dyd\027\005dDdH"),
        Media = obj15,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj15Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    elseif objPuzzleteile == 16 then
      _Urwigo.MessageBox({
        Text = _jTuU("li\0205\005\027dvZ\027d{i\020MuM:D\005OZ{<)D\020M6Z\195\188<C|v\020y<)4\ap^4\ap^\030vM)\027ydM\027ZZDMyD<)yOD)\020M\nvOODZdD{ZDM{\020M\030D{\020D\005M\nvOOZDxi&c4\ap^4\ap^\030vM)\195\164ddDydMDyM\020{<)dMxDyyD\005M2\027<)D\020MC\195\182\020\020D\020H"),
        Media = obj16,
        Buttons = {
          _jTuU("Wv\005M\aD|D\005dv\0205")
        },
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "",
              Media = obj16Punkte,
              Buttons = {
                _jTuU("0y<)\195\188yyMv\020+M6ii+Mx?D")
              }
            })
          end
        end
      })
    end
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objAuswertung1)
    end)
  end
end
function _Urwigo.GlobalZoneEnter()
  objSilvester:RequestSync()
end
return objSilvester
