require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _9aAn(str)
  local res = ""
  local dtable = "?\029#sMb5\rY\031>hS\005Bm~2\021\016\014\023xN\019gRK\\;p!\002jJ_\t4:-\000vLiA]I=6l\018ec\0248\030w%7\b\0151,\003\004Z)9`{*kP\028F}o\v\n.[EfV\006^\001nC<U\027WQ&\022(\fTD\026Guz/+aO'q3d|H\025 \ay$\"X\017\0200r@t"
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
_9x1 = Wherigo.ZCartridge()
_Nu5 = Wherigo.ZMedia(_9x1)
_Nu5.Id = "31529582-38c5-4ba0-a998-4577cf3037d7"
_Nu5.Name = _9aAn("\f4kp,X\026")
_Nu5.Description = ""
_Nu5.AltText = ""
_Nu5.Resources = {
  {
    Type = "jpg",
    Filename = "heading.jpg",
    Directives = {}
  }
}
_3LwMn = Wherigo.ZMedia(_9x1)
_3LwMn.Id = "ef0464df-7ebc-49d8-ba0e-e753c1de71f6"
_3LwMn.Name = _9aAn(",5MX")
_3LwMn.Description = ""
_3LwMn.AltText = ""
_3LwMn.Resources = {
  {
    Type = "jpg",
    Filename = "icon.jpg",
    Directives = {}
  }
}
_9x1.Id = "01ea16ae-a18a-463b-801b-bd8e4434bb7f"
_9x1.Name = "day1976's Open Source Reverse Wherigo"
_9x1.Description = [[
<BR>
This is an open source Reverse Wherigo cartridge that uses bearing to locate the geocache, rather than distance. &amp;nbsp;Anybody can create a wherigo using this cartridge. &amp;nbsp;Simply either enter in the coordinates of the geocache you have hidden, or use the cartridge on location to determine the coordinates. &amp;nbsp;You will then be given two 5 character codes that you can then share to others, along with this cartridge. &amp;nbsp;The players then enter the codes into the cartridge and are given the bearing to the geocache that you have hidden.]]
_9x1.Visible = true
_9x1.Activity = "Geocache"
_9x1.StartingLocationDescription = ""
_9x1.StartingLocation = Wherigo.INVALID_ZONEPOINT
_9x1.Version = "1.1"
_9x1.Company = ""
_9x1.Author = "day1976"
_9x1.BuilderVersion = "URWIGO 1.22.5798.37755"
_9x1.CreateDate = "05/30/2021 14:42:50"
_9x1.PublishDate = "1/1/0001 12:00:00 AM"
_9x1.UpdateDate = "05/30/2021 18:25:35"
_9x1.LastPlayedDate = "1/1/0001 12:00:00 AM"
_9x1.TargetDevice = "PocketPC"
_9x1.TargetDeviceVersion = "0"
_9x1.StateId = "1"
_9x1.CountryId = "2"
_9x1.Complete = false
_9x1.UseLogging = true
_9x1.Media = _Nu5
_9x1.Icon = _3LwMn
targetzone = Wherigo.Zone(_9x1)
targetzone.Id = "57c2de11-141f-4af8-9646-f5e4896bab01"
targetzone.Name = _9aAn("ck}\0264\127BMX4")
targetzone.Description = ""
targetzone.Visible = false
targetzone.Commands = {}
targetzone.DistanceRange = Distance(-1, "feet")
targetzone.ShowObjects = "OnEnter"
targetzone.ProximityRange = Distance(60, "meters")
targetzone.AllowSetPositionTo = false
targetzone.Active = false
targetzone.Points = {
  ZonePoint(-32.1043284944077, 140.373590556405, 0),
  ZonePoint(-31.3314081723909, 146.128300088764, 0),
  ZonePoint(-38.3653130675436, 148.551335681336, 0)
}
targetzone.OriginalPoint = ZonePoint(-33.9336832447807, 145.017742108835, 0)
targetzone.DistanceRangeUOM = "Feet"
targetzone.ProximityRangeUOM = "Meters"
targetzone.OutOfRangeName = ""
targetzone.InRangeName = ""
s = ""
a = ""
b = ""
c = ""
d = ""
e = ""
t = ""
_vZmW2 = ""
_2kSJl = ""
_5mF = ""
_tFCg = ""
_vRGT = ""
_Gr9 = ""
_FM2 = 0
_IIW = 0
_KsA = 0
_QrbCA = 0
_Avr3k = 0
_rai = 0
_cTzKn = 0
_dJuU = 0
_9Ve7 = 0
_QWQ = 0
_ErSZ = 0
lat = 0
long = 0
_N0OBU = 0
_HAfm2 = 0
_1KnnD = _9aAn("\127k}\0264\127hMX4")
_QcD = _9aAn("pg\016\016v")
_m7aB = _9aAn("pg\016\016v")
_vTlW = _9aAn("pg\016\016v")
_KTK = _9aAn("$-\f\028o")
_IQ4 = _9aAn("pg\016\016v")
_9x1.ZVariables = {
  s = "",
  a = "",
  b = "",
  c = "",
  d = "",
  e = "",
  t = "",
  _vZmW2 = "",
  _2kSJl = "",
  _5mF = "",
  _tFCg = "",
  _vRGT = "",
  _Gr9 = "",
  _FM2 = 0,
  _IIW = 0,
  _KsA = 0,
  _QrbCA = 0,
  _Avr3k = 0,
  _rai = 0,
  _cTzKn = 0,
  _dJuU = 0,
  _9Ve7 = 0,
  _QWQ = 0,
  _ErSZ = 0,
  lat = 0,
  long = 0,
  _N0OBU = 0,
  _HAfm2 = 0,
  _1KnnD = _9aAn("\127k}\0264\127hMX4"),
  _QcD = _9aAn("pg\016\016v"),
  _m7aB = _9aAn("pg\016\016v"),
  _vTlW = _9aAn("pg\016\016v"),
  _KTK = _9aAn("$-\f\028o"),
  _IQ4 = _9aAn("pg\016\016v")
}
_AhK3 = Wherigo.ZInput(_9x1)
_AhK3.Id = "5c43fc7b-e11e-4cea-847c-658b6639124d"
_AhK3.Name = _9aAn("/X\031g\127>")
_AhK3.Description = ""
_AhK3.Visible = true
_AhK3.InputType = "Text"
_AhK3.Text = _9aAn("RX\1274}tvMg}tS,}\004\127t5Mp4")
_q1l = Wherigo.ZInput(_9x1)
_q1l.Id = "346d2546-461c-4324-a4c3-95d8f32ee5dd"
_q1l.Name = _9aAn("/X\031g\127t\018")
_q1l.Description = ""
_q1l.Visible = true
_q1l.InputType = "Text"
_q1l.Text = _9aAn("RX\1274}tvMg}t\00445MXpt5Mp4")
_lbjc = Wherigo.ZInput(_9x1)
_lbjc.Id = "3b39a6a3-a8e4-47d8-8cbb-0685f080feb8"
_lbjc.Name = _9aAn("\r\127k}\127")
_lbjc.Description = ""
_lbjc.Visible = true
_lbjc.Choices = {
  "Get a code",
  "Find a geocache"
}
_lbjc.InputType = "MultipleChoice"
_lbjc.Text = _9aAn("dMtvMgt9kX\127t\127Mt\0264\127tkt5Mp4tSM}tkt\0044\127tMSt5MM}p,Xk\1274\004tM}tpMtvMgt9kX\127t\127Mt4X\1274}tkt5Mp4tkXptS,Xptkt\0264M5k5\f4\001")
_ycWSB = Wherigo.ZInput(_9x1)
_ycWSB.Id = "dba9c3cd-d5dc-415b-aae2-4386548c48a6"
_ycWSB.Name = _9aAn("+k\127,\127gp4")
_ycWSB.Description = ""
_ycWSB.Visible = true
_ycWSB.InputType = "Text"
_ycWSB.Text = _9aAn("RX\1274}t,Xt\127\f4t2k\127,\127gp4tMStvMg}t\0264M5k5\f4Pt\005g\004\127t\0064t,Xt\127\f4tddPdddddtSM}\016k\127tap,\026,\127k2tp4\026}44\004CtkXpt}4\0164\016\0064}t\127Mtg\0044t\031M\004,\127,*4tXg\016\0064}\004tSM}t\024tkXptX4\026k\127,*4tXg\016\0064}\004tSM}t\r")
_xmR = Wherigo.ZInput(_9x1)
_xmR.Id = "b87dc7a5-3032-4e22-8880-d1fa912d9ea7"
_xmR.Name = _9aAn("+MX\026,\127gp4")
_xmR.Description = ""
_xmR.Visible = true
_xmR.InputType = "Text"
_xmR.Text = _9aAn("RX\1274}t,Xt\127\f4t2k\127,\127gp4tMStvMg}t\0264M5k5\f4Pt\005g\004\127t\0064t,Xt\127\f4tdddPdddddtSM}\016k\127tap,\026,\127k2tp4\026}44\004CtkXpt}4\0164\016\0064}t\127Mtg\0044t\031M\004,\127,*4tXg\016\0064}\004tSM}tRtkXptX4\026k\127,*4tXg\016\0064}\004tSM}t]")
_A2tg_ = Wherigo.ZInput(_9x1)
_A2tg_.Id = "3f425bb0-d250-47fe-980f-edfdc376ee2a"
_A2tg_.Name = _9aAn("f4\127-YMp4")
_A2tg_.Description = ""
_A2tg_.Visible = true
_A2tg_.Choices = {
  "Use current Coordinates",
  "Enter a Different Set"
}
_A2tg_.InputType = "MultipleChoice"
_A2tg_.Text = _9aAn("d,ptvMgt9kX\127t\127Mtg\0044tvMg}t5g}}4X\127t5MM}p,Xk\1274\004?tM}t4X\1274}tktp,SS4}4X\127t\0044\127P")
function _9x1:OnStart()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_lbjc)
  end)
end
function _9x1:OnRestore()
end
function _AhK3:OnGetInput(input)
  if input == nil then
    input = ""
  end
  s = input
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_q1l)
  end)
end
function _q1l:OnGetInput(input)
  if input == nil then
    input = ""
  end
  t = input
  _YvIY7()
end
function _lbjc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49469 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_AhK3)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_A2tg_)
    end)
  end
end
function _ycWSB:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  lat = input
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_xmR)
  end)
end
function _xmR:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  long = input
  _6u3VL()
end
function _A2tg_:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13660 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_ycWSB)
    end)
  else
    _4Hj()
  end
end
function _YvIY7()
  a = tostring(string.sub(s, 1, 1))
  b = tostring(string.sub(s, 2, 2))
  c = tostring(string.sub(s, 3, 3))
  d = tostring(string.sub(s, 4, 4))
  e = tostring(string.sub(s, 5, 5))
  _vZmW2 = tostring(string.sub(t, 1, 1))
  _2kSJl = tostring(string.sub(t, 2, 2))
  _5mF = tostring(string.sub(t, 3, 3))
  _tFCg = tostring(string.sub(t, 4, 4))
  _vRGT = tostring(string.sub(t, 5, 5))
  _Gr9 = c
  _0YvH()
  _IIW = _FM2
  _Gr9 = e
  _0YvH()
  _KsA = _FM2
  _Gr9 = _vZmW2
  _0YvH()
  _QrbCA = _FM2
  _Gr9 = _2kSJl
  _0YvH()
  _Avr3k = _FM2
  _Gr9 = _vRGT
  _0YvH()
  _rai = _FM2
  _Gr9 = a
  _0YvH()
  _cTzKn = _FM2
  _Gr9 = b
  _0YvH()
  _dJuU = _FM2
  _Gr9 = d
  _0YvH()
  _9Ve7 = _FM2
  _Gr9 = _5mF
  _0YvH()
  _QWQ = _FM2
  _Gr9 = _tFCg
  _0YvH()
  _ErSZ = _FM2
  lat = _IIW * 1679616 + _KsA * 46656 + _QrbCA * 1296 + _Avr3k * 36 + _rai
  long = _cTzKn * 1679616 + _dJuU * 46656 + _9Ve7 * 1296 + _QWQ * 36 + _ErSZ
  lat = lat / 100000
  long = long / 100000
  lat = lat - 90
  long = long - 180
  targetzone.Active = false
  MoveZone(lat, long)
  targetzone.Active = true
  _N0OBU = tonumber(Locate(targetzone))
  _N0OBU = _Urwigo.Round(_N0OBU, 0)
  _Urwigo.MessageBox({
    Text = (_9aAn("c\f4t\0064k},X\026t\127Mt\127\f,\004t\0264M5k5\f4t,\004t") .. _N0OBU) .. _9aAn("tp4\026}44\004P"),
    Buttons = {
      _9aAn("RX\1274}tktX49t5Mp4"),
      _9aAn("f,*4t\0164tktX49t\0064k},X\026tSM}t\127\f,\004t5Mp4")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_AhK3)
          end)
        else
          _YvIY7()
        end
      end
    end
  })
end
function _0YvH()
  if Wherigo.NoCaseEquals(_Gr9, _9aAn("|")) then
    _FM2 = 0
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn(">")) then
    _FM2 = 1
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\018")) then
    _FM2 = 2
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("o")) then
    _FM2 = 3
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("&")) then
    _FM2 = 4
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\a")) then
    _FM2 = 5
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("1")) then
    _FM2 = 6
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn(";")) then
    _FM2 = 7
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("7")) then
    _FM2 = 8
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("D")) then
    _FM2 = 9
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("k")) then
    _FM2 = 10
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\006")) then
    _FM2 = 11
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("5")) then
    _FM2 = 12
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("p")) then
    _FM2 = 13
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("4")) then
    _FM2 = 14
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("S")) then
    _FM2 = 15
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\026")) then
    _FM2 = 16
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\f")) then
    _FM2 = 17
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn(",")) then
    _FM2 = 18
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\"")) then
    _FM2 = 19
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("H")) then
    _FM2 = 20
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("2")) then
    _FM2 = 21
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\016")) then
    _FM2 = 22
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("X")) then
    _FM2 = 23
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("M")) then
    _FM2 = 24
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\031")) then
    _FM2 = 25
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("n")) then
    _FM2 = 26
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("}")) then
    _FM2 = 27
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\004")) then
    _FM2 = 28
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\127")) then
    _FM2 = 29
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("g")) then
    _FM2 = 30
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("*")) then
    _FM2 = 31
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("9")) then
    _FM2 = 32
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("\023")) then
    _FM2 = 33
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("v")) then
    _FM2 = 34
  elseif Wherigo.NoCaseEquals(_Gr9, _9aAn("h")) then
    _FM2 = 35
  end
end
function _6u3VL()
  lat = lat + 90
  long = long + 180
  lat = lat * 100000
  long = long * 100000
  _IIW = _Urwigo.Floor(lat / 1679616, 0)
  lat = lat - _IIW * 1679616
  _KsA = _Urwigo.Floor(lat / 46656, 0)
  lat = lat - _KsA * 46656
  _QrbCA = _Urwigo.Floor(lat / 1296, 0)
  lat = lat - _QrbCA * 1296
  _Avr3k = _Urwigo.Floor(lat / 36, 0)
  _rai = lat - _Avr3k * 36
  _cTzKn = _Urwigo.Floor(long / 1679616, 0)
  long = long - _cTzKn * 1679616
  _dJuU = _Urwigo.Floor(long / 46656, 0)
  long = long - _dJuU * 46656
  _9Ve7 = _Urwigo.Floor(long / 1296, 0)
  long = long - _9Ve7 * 1296
  _QWQ = _Urwigo.Floor(long / 36, 0)
  _ErSZ = long - _QWQ * 36
  _FM2 = _IIW
  _SRrF6()
  c = _Gr9
  _FM2 = _KsA
  _SRrF6()
  e = _Gr9
  _FM2 = _QrbCA
  _SRrF6()
  _vZmW2 = _Gr9
  _FM2 = _Avr3k
  _SRrF6()
  _2kSJl = _Gr9
  _FM2 = _rai
  _SRrF6()
  _vRGT = _Gr9
  _FM2 = _cTzKn
  _SRrF6()
  a = _Gr9
  _FM2 = _dJuU
  _SRrF6()
  b = _Gr9
  _FM2 = _9Ve7
  _SRrF6()
  d = _Gr9
  _FM2 = _QWQ
  _SRrF6()
  _5mF = _Gr9
  _FM2 = _ErSZ
  _SRrF6()
  _tFCg = _Gr9
  s = (((a .. b) .. c) .. d) .. e
  t = (((_vZmW2 .. _2kSJl) .. _5mF) .. _tFCg) .. _vRGT
  _Urwigo.MessageBox({
    Text = ((_9aAn("c\f4tS,}\004\127t5Mp4tSM}t\127\fk\127t\0044\127tMSt5MM}p,Xk\1274\004t,\004t") .. s) .. _9aAn("Z\015\027\vc\f4t\00445MXpt5Mp4tSM}t\127\fk\127t\0044\127tMSt5MM}p,Xk\1274\004t,\004t")) .. t,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_lbjc)
        end)
      end
    end
  })
end
function _SRrF6()
  if _FM2 == 0 then
    _Gr9 = _9aAn("|")
  elseif _FM2 == 1 then
    _Gr9 = _9aAn(">")
  elseif _FM2 == 2 then
    _Gr9 = _9aAn("\018")
  elseif _FM2 == 3 then
    _Gr9 = _9aAn("o")
  elseif _FM2 == 4 then
    _Gr9 = _9aAn("&")
  elseif _FM2 == 5 then
    _Gr9 = _9aAn("\a")
  elseif _FM2 == 6 then
    _Gr9 = _9aAn("1")
  elseif _FM2 == 7 then
    _Gr9 = _9aAn(";")
  elseif _FM2 == 8 then
    _Gr9 = _9aAn("7")
  elseif _FM2 == 9 then
    _Gr9 = _9aAn("D")
  elseif _FM2 == 10 then
    _Gr9 = _9aAn("k")
  elseif _FM2 == 11 then
    _Gr9 = _9aAn("\006")
  elseif _FM2 == 12 then
    _Gr9 = _9aAn("5")
  elseif _FM2 == 13 then
    _Gr9 = _9aAn("p")
  elseif _FM2 == 14 then
    _Gr9 = _9aAn("4")
  elseif _FM2 == 15 then
    _Gr9 = _9aAn("S")
  elseif _FM2 == 16 then
    _Gr9 = _9aAn("\026")
  elseif _FM2 == 17 then
    _Gr9 = _9aAn("\f")
  elseif _FM2 == 18 then
    _Gr9 = _9aAn(",")
  elseif _FM2 == 19 then
    _Gr9 = _9aAn("\"")
  elseif _FM2 == 20 then
    _Gr9 = _9aAn("H")
  elseif _FM2 == 21 then
    _Gr9 = _9aAn("2")
  elseif _FM2 == 22 then
    _Gr9 = _9aAn("\016")
  elseif _FM2 == 23 then
    _Gr9 = _9aAn("X")
  elseif _FM2 == 24 then
    _Gr9 = _9aAn("M")
  elseif _FM2 == 25 then
    _Gr9 = _9aAn("\031")
  elseif _FM2 == 26 then
    _Gr9 = _9aAn("n")
  elseif _FM2 == 27 then
    _Gr9 = _9aAn("}")
  elseif _FM2 == 28 then
    _Gr9 = _9aAn("\004")
  elseif _FM2 == 29 then
    _Gr9 = _9aAn("\127")
  elseif _FM2 == 30 then
    _Gr9 = _9aAn("g")
  elseif _FM2 == 31 then
    _Gr9 = _9aAn("*")
  elseif _FM2 == 32 then
    _Gr9 = _9aAn("9")
  elseif _FM2 == 33 then
    _Gr9 = _9aAn("\023")
  elseif _FM2 == 34 then
    _Gr9 = _9aAn("v")
  elseif _FM2 == 35 then
    _Gr9 = _9aAn("h")
  end
end
function _4Hj()
  _HAfm2 = tonumber(Player.PositionAccuracy:GetValue("m"))
  if _HAfm2 < 5 then
    lat = tonumber(Player.ObjectLocation.latitude)
    long = tonumber(Player.ObjectLocation.longitude)
    _6u3VL()
  else
    _Urwigo.MessageBox({
      Text = (_9aAn("\tMg}t5g}}4X\127tfI\rtk55g}k5vt,\004tk\127t") .. _HAfm2) .. _9aAn("t\0164\1274}\004Pt_X\006\004\031\030/\127tX44p\004t\127Mt\0064t\00642M9t\at\0164\1274}\004tSM}t\127\f,\004t\127Mt9M}HP"),
      Buttons = {
        _9aAn("c}vtk\026k,X"),
        _9aAn("R\0045k\0314")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" == true then
            _4Hj()
          else
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_lbjc)
            end)
          end
        end
      end
    })
  end
end
function MoveZone(lat, long)
  UP = {
    ZonePoint(lat - 1.0E-5, long - 1.0E-5, 0),
    ZonePoint(lat - 1.0E-5, long + 1.0E-5, 0),
    ZonePoint(lat + 1.0E-5, long + 1.0E-5, 0),
    ZonePoint(lat + 1.0E-5, long - 1.0E-5, 0)
  }
  UOP = ZonePoint(lat, long, 0)
  targetzone.Points = UP
  targetzone.OriginalPoint = UOP
end
function Locate(zone)
  local dist, bear = Wherigo.VectorToPoint(Player.ObjectLocation, zone.OriginalPoint)
  return bear
end
return _9x1
