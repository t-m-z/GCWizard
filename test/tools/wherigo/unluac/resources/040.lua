require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _1H2A(str)
  local res = ""
  local dtable = "u\029(A\"\015h+*&\022^e#1~\031.KZ\tBNjWyO\018<[\026L\019qGD_!=\024\001f\av7H>|rn0/8$4gzRaEP\v,\014S\006\004isT\n\025p \0009IX\0025']l\023}?UJxd:M6\020\016\003-Y%\021k\f2b\030@C\\Q`w\b\005{\028c)tFV\027m\r;\0173o"
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
_qXCkI = Wherigo.ZCartridge()
_KimOq = Wherigo.ZMedia(_qXCkI)
_KimOq.Id = "b7252f8f-1ed7-4082-805f-ed16618d9c5a"
_KimOq.Name = _1H2A("$;\001z\r2.\127t\a")
_KimOq.Description = ""
_KimOq.AltText = ""
_KimOq.Resources = {
  {
    Type = "jpg",
    Filename = "Richtig_Symbol.jpg",
    Directives = {}
  }
}
_xxuIk = Wherigo.ZMedia(_qXCkI)
_xxuIk.Id = "9d0d5f2a-599a-4b7d-a10b-d881fc5168c8"
_xxuIk.Name = _1H2A("$;\001z\r2:\0012v\r1")
_xxuIk.Description = ""
_xxuIk.AltText = ""
_xxuIk.Resources = {
  {
    Type = "jpg",
    Filename = "Falsch_Symbol.jpg",
    Directives = {}
  }
}
_cDtFD = Wherigo.ZMedia(_qXCkI)
_cDtFD.Id = "b132cd06-7bc3-43ae-95ef-2b9eea67d9e0"
_cDtFD.Name = _1H2A("F\1271")
_cDtFD.Description = ""
_cDtFD.AltText = ""
_cDtFD.Resources = {
  {
    Type = "png",
    Filename = "IMG_20200102_1227521.png",
    Directives = {}
  }
}
_iv59d = Wherigo.ZMedia(_qXCkI)
_iv59d.Id = "142c207d-d67c-4897-aa82-c5601792f01c"
_iv59d.Name = _1H2A("\0191DEv;SSe\0018\rS")
_iv59d.Description = ""
_iv59d.AltText = ""
_iv59d.Resources = {
  {
    Type = "png",
    Filename = "IMG_20200102_1239231.png",
    Directives = {}
  }
}
_nI5 = Wherigo.ZMedia(_qXCkI)
_nI5.Id = "d20fc79a-2fd3-4773-97e3-9492e7aa8dc6"
_nI5.Name = _1H2A(",\r1h\12718\r2\rEJF\1271")
_nI5.Description = ""
_nI5.AltText = ""
_nI5.Resources = {
  {
    Type = "png",
    Filename = "IMG_20200102_1240171.png",
    Directives = {}
  }
}
_nxY = Wherigo.ZMedia(_qXCkI)
_nxY.Id = "6712f21f-a1ca-4517-b32d-8e0402b1735a"
_nxY.Name = _1H2A(":;\rvE\rSJ,\r1h\12718\r2\rEJF\1271")
_nxY.Description = ""
_nxY.AltText = ""
_nxY.Resources = {
  {
    Type = "jpg",
    Filename = "Schloss.jpg",
    Directives = {}
  }
}
_oCa = Wherigo.ZMedia(_qXCkI)
_oCa.Id = "359bfb64-08f1-4acf-bec2-d980e4cd482b"
_oCa.Name = _1H2A("$1\r\aEt\a\rDh\r")
_oCa.Description = ""
_oCa.AltText = ""
_oCa.Resources = {
  {
    Type = "png",
    Filename = "alchemistrad.png",
    Directives = {}
  }
}
_whdd = Wherigo.ZMedia(_qXCkI)
_whdd.Id = "409e641d-55cc-4a98-bd44-fd3f2287c8ea"
_whdd.Name = _1H2A("\004St\a\rzDEv")
_whdd.Description = ""
_whdd.AltText = ""
_whdd.Resources = {
  {
    Type = "jpg",
    Filename = "Alchemistsklein.jpg",
    Directives = {}
  }
}
_lur = Wherigo.ZMedia(_qXCkI)
_lur.Id = "dab69e84-5882-4bbf-8185-6049f0d4880a"
_lur.Name = _1H2A("<SDYD\r1")
_lur.Description = ""
_lur.AltText = ""
_lur.Resources = {
  {
    Type = "png",
    Filename = "elixir.png",
    Directives = {}
  }
}
_qXCkI.Id = "593e6218-e503-4b4d-82b6-ba272d529ab2"
_qXCkI.Name = "Der Alchemist"
_qXCkI.Description = [[
<BR>
<BR>
<BR>
<BR>
Taucht ein in eine fremde Welt, voller Alchemie und loest das Geheimnis, das in den Gemaeuern der Kirche lauert.<BR>
<BR>
Diese kleine Cartridge enthaelt drei Zonen, die alle ganz in der Naehe der Kirche sind. Es ist jeweils eine Zone sichtbar. Nach richtiger Beantwortung der zugehoerigen Frage wird die naechste Zone sichtbar.<BR>
]]
_qXCkI.Visible = true
_qXCkI.Activity = "Geocache"
_qXCkI.StartingLocationDescription = ""
_qXCkI.StartingLocation = ZonePoint(53.275483, 12.8118, 0)
_qXCkI.Version = "1.4"
_qXCkI.Company = ""
_qXCkI.Author = "eddysnz"
_qXCkI.BuilderVersion = "URWIGO 1.22.5798.37755"
_qXCkI.CreateDate = "03/21/2015 21:50:12"
_qXCkI.PublishDate = "1/1/0001 12:00:00 AM"
_qXCkI.UpdateDate = "02/29/2020 17:02:03"
_qXCkI.LastPlayedDate = "1/1/0001 12:00:00 AM"
_qXCkI.TargetDevice = "PocketPC"
_qXCkI.TargetDeviceVersion = "0"
_qXCkI.StateId = "1"
_qXCkI.CountryId = "2"
_qXCkI.Complete = false
_qXCkI.UseLogging = true
_qXCkI.Media = _whdd
__xt8 = Wherigo.Zone(_qXCkI)
__xt8.Id = "57b3854d-c560-4c5e-9d68-4ff1098c1375"
__xt8.Name = _1H2A("F\1271a\020\1272\r")
__xt8.Description = _1H2A("\025;EJo;1JZ;EJZ\r22VJM\a1J\127\r**2\rvJ\r\0011\rJ\004\0018\r2J\0012ZJz\r1evJZ\r2JEv;1e\r2JAt\aoD2Z\rS?JZ\r1J\r\001t\aJv;\001z\rS2JS;\rEEv\018J\025\127JE\rDZJD\a1VJ ;28E;zJ8\ro\127\r\a2\r2JEDt\aJZD\rJ\004\0018\r2J;2JZD\rJ.\rSSD8e\rDvJ\0012ZJD\a1Jh\rz\r1evJZ;EEJD\a1J,\1271J\rD2\rzJF\1271JEv\r\av\018JWzJZD\rE\rEJF\1271JZ\0011t\aEt\a1\rDv\r2J9\001Je\127\r22\r2JEI1\rt\avJ\n2hEI|\020o\rDJ\022\001t\aEv;h\r2J;\001E&")
__xt8.Visible = true
__xt8.Media = _cDtFD
__xt8.Commands = {}
__xt8.DistanceRange = Distance(-1, "feet")
__xt8.ShowObjects = "Always"
__xt8.ProximityRange = Distance(60, "meters")
__xt8.AllowSetPositionTo = false
__xt8.Active = true
__xt8.Points = {
  ZonePoint(53.2764877439462, 12.8107931537327, 0),
  ZonePoint(53.2763738017209, 12.8107212006395, 0),
  ZonePoint(53.2763303933705, 12.8109210833934, 0),
  ZonePoint(53.2764428015616, 12.8109939694051, 0)
}
__xt8.OriginalPoint = ZonePoint(53.2764086851498, 12.8108573517927, 0)
__xt8.DistanceRangeUOM = "Feet"
__xt8.ProximityRangeUOM = "Meters"
__xt8.OutOfRangeName = ""
__xt8.InRangeName = ""
_0sz = Wherigo.Zone(_qXCkI)
_0sz.Id = "873fc4e3-6a7b-463e-9c44-744cacca7151"
_0sz.Name = _1H2A("\0191DEv;SSe\0018\rSa\020\1272\r")
_0sz.Description = _1H2A("$;EJF\1271J\127\r**2\rvJEDt\a?J\127\aJ\022\rE\001t\a&J#1\001\rEE\rvJ<\001t\a\018JMt\aJhD2JM9;1JADSh\r19\00128\rJZ\r1J\aD\rED8\rJ\025;\a1E;8\r1\018JM\a1JE\r\avJ;\001E?J;SEJ\127hJ<\001t\aJ\rD2\rJ\025;\a1E;8\00128J8\001vJv\0012Jo\001\r1Z\r\018J \rDZ\r1Jh1;\001t\aJDt\aJZ;*\0011J\rD2\rJ\0191DEv;Se\0018\rS\018JM\a1J\a;hvJ2Dt\avJ9\001*;\rSSD8J\rD2\rJZ;h\rDV\029\022:/")
_0sz.Visible = false
_0sz.Media = _iv59d
_0sz.Commands = {}
_0sz.DistanceRange = Distance(-1, "feet")
_0sz.ShowObjects = "OnEnter"
_0sz.ProximityRange = Distance(60, "meters")
_0sz.AllowSetPositionTo = false
_0sz.Active = false
_0sz.Points = {
  ZonePoint(53.2765898313209, 12.8100514479345, 0),
  ZonePoint(53.2765344990089, 12.8100534595913, 0),
  ZonePoint(53.2765340980499, 12.810171476788, 0),
  ZonePoint(53.2765910341965, 12.8101748295492, 0)
}
_0sz.OriginalPoint = ZonePoint(53.2765623656441, 12.8101128034657, 0)
_0sz.DistanceRangeUOM = "Feet"
_0sz.ProximityRangeUOM = "Meters"
_0sz.OutOfRangeName = ""
_0sz.InRangeName = ""
_1Me = Wherigo.Zone(_qXCkI)
_1Me.Id = "b5fbd418-ab04-4d59-b10b-34cd7f528491"
_1Me.Name = _1H2A(",\r1h\12718\r2\rEJF\1271a\020\1272\r")
_1Me.Description = _1H2A("Mt\aJe;22J\rEJ\024\rv9vJE\r\a\r2Jo;EJM\a1Jh\r8\r\a1v\018JM\a1JE\001t\avJ\rD2J<SDYD\r1\018J\025\r22JM\a1J\rEJ\a;hvJz\001\rEEvJM\a1J\rEJ9\r1Ev\127\r1\r2\018J\025\r22JM\a1J\rD2JS\rv9v\rEJ:;\rvE\rSJS\127\rEEvJoD1ZJ<\001t\aJZ\r1J\025\r8JZ\0011t\aJZ;EJ,\r1h\12718\r2\rJF\1271J8\ro;\r\a1v\018J")
_1Me.Visible = false
_1Me.Media = _nI5
_1Me.Commands = {}
_1Me.DistanceRange = Distance(-1, "feet")
_1Me.ShowObjects = "OnEnter"
_1Me.ProximityRange = Distance(60, "meters")
_1Me.AllowSetPositionTo = false
_1Me.Active = false
_1Me.Points = {
  ZonePoint(53.276206981963, 12.810006360565, 0),
  ZonePoint(53.2762085486519, 12.8101749508224, 0),
  ZonePoint(53.2761175906951, 12.8101749508224, 0),
  ZonePoint(53.2761175535355, 12.8100089806301, 0)
}
_1Me.OriginalPoint = ZonePoint(53.2761626687114, 12.81009131071, 0)
_1Me.DistanceRangeUOM = "Feet"
_1Me.ProximityRangeUOM = "Meters"
_1Me.OutOfRangeName = ""
_1Me.InRangeName = ""
_AS6tj = Wherigo.Zone(_qXCkI)
_AS6tj.Id = "3f6b4d10-6d95-4ac5-8a0c-df0331a05ca9"
_AS6tj.Name = _1H2A("wD2;Sa\020\1272\r")
_AS6tj.Description = _1H2A("#\001vJ8\rz;t\av\018J\023\0012Je\127\r22vJM\a1JZ;EJ<SDYD\r1JZ\rEJ\004St\a\rzDEv\r2JE\001t\a\r2?J\0012h1;\001t\ah;1Jz;t\a\r2J\0012ZJZD\rJ:\r9\rIv\0011J,\r12Dt\av\r2\018J$D\rJ\025\rSvJE\127SSv\rJ\n2hEI|E\127zDvJ,\1271\r1EvJ8\r1\rvv\rvJE\rD2\018\029\022:/\029\022:/.D\r1JDEvJZ\r1J=\rvSD28JzDvJZ\rzJ \1278h\001t\aJ,\r1Ev\rtev\018\029\022:/\023JP~J\015]\018P53J<J3\015gJ75\018]]\015")
_AS6tj.Visible = true
_AS6tj.Media = _lur
_AS6tj.Commands = {}
_AS6tj.DistanceRange = Distance(-1, "feet")
_AS6tj.ShowObjects = "OnEnter"
_AS6tj.ProximityRange = Distance(60, "meters")
_AS6tj.AllowSetPositionTo = false
_AS6tj.Active = false
_AS6tj.Points = {
  ZonePoint(53.2763806433636, 12.8110341043586, 0),
  ZonePoint(53.2763588959748, 12.8111506694622, 0),
  ZonePoint(53.2762975489451, 12.8111050719089, 0),
  ZonePoint(53.2763212056532, 12.810978337533, 0)
}
_AS6tj.OriginalPoint = ZonePoint(53.2763395734842, 12.8110670458157, 0)
_AS6tj.DistanceRangeUOM = "Feet"
_AS6tj.ProximityRangeUOM = "Meters"
_AS6tj.OutOfRangeName = ""
_AS6tj.InRangeName = ""
_V8NLC = Wherigo.ZItem({Cartridge = _qXCkI, Container = __xt8})
_V8NLC.Id = "f784b14c-f1bb-4263-a4bf-0ee37e75c5bd"
_V8NLC.Name = _1H2A("F\1271J")
_V8NLC.Description = _1H2A("WzJZD\rE\rEJF\1271JZ\0011t\aEt\a1\rDv\r2J9\001Je\127\r22\r2JEI1\rt\avJ\n2hEI|\020o\rDJ\022\001t\aEv;h\r2J;\001E&")
_V8NLC.Visible = false
_V8NLC.Media = _cDtFD
_V8NLC.Commands = {
  _ivZfg = Wherigo.ZCommand({
    Text = _1H2A("w1;8\rJh\r;2vo\1271v\r2"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _1H2A("\023Dt\avJ,\r1*\0018h;1")
  })
}
_V8NLC.Commands._ivZfg.Custom = true
_V8NLC.Commands._ivZfg.Id = "a91042d0-79c5-40a2-bf1e-b5dc529b9702"
_V8NLC.Commands._ivZfg.WorksWithAll = true
_V8NLC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_V8NLC.Locked = false
_V8NLC.Opened = false
_OX8ol = Wherigo.ZItem({Cartridge = _qXCkI, Container = _0sz})
_OX8ol.Id = "ece9067c-613d-4a6c-a3f9-0ca9c17b7709"
_OX8ol.Name = _1H2A("\0191DEv;SSe\0018\rS")
_OX8ol.Description = _1H2A("M\a1Jo\127SSvJ\rD2\rJ\0191DEv;SSe\0018\rSVJ$;22JEID\rSvJZD\rE\rEJAID\rS[\029\022:/\022\rDJZD\rE\r1J\rZS\r2J$1\r\aEt\a\rDh\rJ8\r\avJD18\r2Zo;EJ2Dt\avJzDvJ1\rt\av\r2J$D28\r2J9\001&J$D\rJ\020;\aSJ;zJ1\127v\r2J=*\rDSJS;2Z\rvJ2Dt\avJ9\001*;\rSSD8JZ\1271v?JE\1272Z\r12JEt\a\rD2vJEDt\aJD\a1J\020D\rSJ2;t\aJ\rD2\r1J8;29Jh\rEvDzzv\r2J:\r8\rSJ;\001E9\001E\001t\a\r2\018\029\022:/\029\022:/\022\rDJ*\001\r2*J;\001*\rD2;2Z\r1*\127S8\r2Z\r2JAID\rS\r2Je;z\r2J*\127S8\r2Z\rJ\020;\aS\r2[J~?J\015g?J\015\015?J7J\0012ZJL\018\029\022:/\029\022:/\025\rSt\a\rJ$1\rDJ\020;\aS\r2Je\127zz\r2J;SEJ\023;\rt\aEv\rEVJ")
_OX8ol.Visible = false
_OX8ol.Media = _oCa
_OX8ol.Commands = {
  _h7yF = Wherigo.ZCommand({
    Text = _1H2A("w1;8\rJh\r;2vo\1271v\r2"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _1H2A("\023Dt\avJ,\r1*\0018h;1")
  })
}
_OX8ol.Commands._h7yF.Custom = true
_OX8ol.Commands._h7yF.Id = "473b3e81-e321-4a2f-8a67-1ed06dfcad83"
_OX8ol.Commands._h7yF.WorksWithAll = true
_OX8ol.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_OX8ol.Locked = false
_OX8ol.Opened = false
_iMzHD = Wherigo.ZItem({Cartridge = _qXCkI, Container = _1Me})
_iMzHD.Id = "5f961c35-d4a4-46b5-a388-c0933463e30a"
_iMzHD.Name = _1H2A(",\r1h\12718\r2\rEJF\1271")
_iMzHD.Description = _1H2A(" \127\rE\rJZ;EJ:;\rvE\rSJ\0012ZJ*D2Z\rJZ\r2J~aEv\rSSD8\r2J\020;\aS\r2t\127Z\r&\029\022:/\029\022:/")
_iMzHD.Visible = false
_iMzHD.Media = _nxY
_iMzHD.Commands = {
  _vi7cy = Wherigo.ZCommand({
    Text = _1H2A("w1;8\rJh\r;2vo\1271v\r2"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _1H2A("\023Dt\avJ,\r1*\0018h;1")
  })
}
_iMzHD.Commands._vi7cy.Custom = true
_iMzHD.Commands._vi7cy.Id = "6ce0fe90-9cda-4294-b759-5d4c32321b05"
_iMzHD.Commands._vi7cy.WorksWithAll = true
_iMzHD.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_iMzHD.Locked = false
_iMzHD.Opened = false
_AwX2 = Wherigo.ZItem({Cartridge = _qXCkI, Container = _AS6tj})
_AwX2.Id = "7482fc54-d619-4478-8913-aede20d6074a"
_AwX2.Name = _1H2A("wD2;S")
_AwX2.Description = ""
_AwX2.Visible = false
_AwX2.Media = _lur
_AwX2.Commands = {
  _jNE = Wherigo.ZCommand({
    Text = _1H2A(" \1278h\001t\aJ8\r*\0012Z\r2V"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _1H2A("\023Dt\avJ,\r1*\0018h;1")
  })
}
_AwX2.Commands._jNE.Custom = true
_AwX2.Commands._jNE.Id = "2b440a8b-1dd0-4903-b43d-7c9ff25ac2a0"
_AwX2.Commands._jNE.WorksWithAll = true
_AwX2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_AwX2.Locked = false
_AwX2.Opened = false
_0i9 = Wherigo.ZItem(_qXCkI)
_0i9.Id = "e551b8b9-7f9c-45d5-b917-bfa3ea4096d9"
_0i9.Name = _1H2A("W2S\127tek\127Z\r")
_0i9.Description = _1H2A("$\r1JW2S\127teJk\127Z\rJZD\r2vJZ;9\001?J;\001*J\025\a\r1D8\127\018t\127zJZD\rJk;1v1DZ8\rJ;SEJ8\rEID\rSvJ9\001Jz;1eD\r1\r2\018\029\022:/\019SDte\rJ;\001*JZ\r2J\0192\127I*JQW2S\127teak\127Z\rJ;29\rD8\r2Q?J\001zJD\a2J9\001JE\r\a\r2\018")
_0i9.Visible = true
_0i9.Commands = {
  _9mH = Wherigo.ZCommand({
    Text = _1H2A("W2S\127teJk\127Z\rJ;29\rD8\r2"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _1H2A("\023Dt\avJ,\r1*\0018h;1")
  })
}
_0i9.Commands._9mH.Custom = true
_0i9.Commands._9mH.Id = "bdd8209a-4da5-449a-86a8-77508f4efbe4"
_0i9.Commands._9mH.WorksWithAll = true
_0i9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_0i9.Locked = false
_0i9.Opened = false
_mnJ = Wherigo.ZItem({Cartridge = _qXCkI, Container = Player})
_mnJ.Id = "71764027-7dd5-4710-ad15-68e8a9e7aecd"
_mnJ.Name = _1H2A("AI\rDt\a\r12")
_mnJ.Description = _1H2A("$\001Je;22EvJ\aD\r1J\024\rZ\r19\rDvJZ\r2J;ev\001\rSS\r2JAID\rSEv;2ZJEI\rDt\a\r12\018")
_mnJ.Visible = true
_mnJ.Commands = {
  _hF0 = Wherigo.ZCommand({
    Text = _1H2A("AI\rDt\a\r12"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _1H2A("\023Dt\avJ,\r1*\0018h;1")
  })
}
_mnJ.Commands._hF0.Custom = true
_mnJ.Commands._hF0.Id = "36ef136d-d947-41d5-9c0a-0d541495dd81"
_mnJ.Commands._hF0.WorksWithAll = true
_mnJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_mnJ.Locked = false
_mnJ.Opened = false
_mPO = false
_8lQq = false
_G4y = false
_5XVbF = false
_EBp = _1H2A("%%Yv5")
_GZZT = _1H2A("Z\001zz\026")
_1rs2Y = _1H2A("%x5\023 k")
_bE_ax = _1H2A("Z\001zz\026")
_CSbCt = _1H2A("% v\022")
_nNvEM = _1H2A("Z\001zz\026")
_qXCkI.ZVariables = {
  _mPO = false,
  _8lQq = false,
  _G4y = false,
  _5XVbF = false,
  _EBp = _1H2A("%%Yv5"),
  _GZZT = _1H2A("Z\001zz\026"),
  _1rs2Y = _1H2A("%x5\023 k"),
  _bE_ax = _1H2A("Z\001zz\026"),
  _CSbCt = _1H2A("% v\022"),
  _nNvEM = _1H2A("Z\001zz\026")
}
_LtB = Wherigo.ZInput(_qXCkI)
_LtB.Id = "1910dc8b-3e00-41b0-925c-65ba68e7d5fa"
_LtB.Name = _1H2A("<D28;h\rF\1271")
_LtB.Description = _1H2A("WzJZD\rE\rEJF\1271J9\001JZ\0011t\aEt\a1\rDv\r2J9\001Je\127\r22\r2JEI1\rt\avJ\n2hEI|\020o\rDJ\022\001t\aEv;h\r2J;\001E&")
_LtB.Visible = true
_LtB.Media = _cDtFD
_LtB.InputType = "Text"
_LtB.Text = _1H2A("WzJZD\rE\rEJF\1271J9\001JZ\0011t\aEt\a1\rDv\r2J9\001Je\127\r22\r2JEI1\rt\avJ\n2hEI|\020o\rDJ\022\001t\aEv;h\r2J;\001E&")
_kiPiC = Wherigo.ZInput(_qXCkI)
_kiPiC.Id = "daed51fd-5584-4d70-a835-864ab81ccc98"
_kiPiC.Name = _1H2A("<D28;h\r\0191DEv;SSe\0018\rS")
_kiPiC.Description = _1H2A("$;EJF\1271J\127\r**2\rvJEDt\a?J\127\aJ\022\rE\001t\a&J#1\001\rEE\rvJ<\001t\a\018JMt\aJhD2JM9;1JADSh\r19\00128\rJZ\r1J\aD\rED8\rJ\025;\a1E;8\r1\018JM\a1JE\r\avJ;\001E?J;SEJ\127hJ<\001t\aJ\rD2\rJ\025;\a1E;8\00128J8\001vJv\0012Jo\001\r1Z\r\018J \rDZ\r1Jh1;\001t\aJDt\aJZ;*\0011J\rD2\rJ\0191DEv;SSe\0018\rS\018JM\a1J\a;hvJ2Dt\avJ9\001*;\rSSD8J\rD2\rJZ;h\rDV")
_kiPiC.Visible = true
_kiPiC.Media = _iv59d
_kiPiC.InputType = "Text"
_kiPiC.Text = _1H2A("\025\rSt\a\rJ$1\rDJ\020;\aS\r2Je\127zz\r2J;SEJ\023;\rt\aEv\rEVJ")
_B0nbK = Wherigo.ZInput(_qXCkI)
_B0nbK.Id = "8b29aece-59e3-4287-ba48-f01ad975a49f"
_B0nbK.Name = _1H2A("<D28;h\r,\r1h\12718\r2\rEF\1271")
_B0nbK.Description = _1H2A("wD2Z\rJZ\r2J~JEv\rSSD8\r2J\020;\aS\r2t\127Z\r&")
_B0nbK.Visible = true
_B0nbK.Media = _nxY
_B0nbK.InputType = "Text"
_B0nbK.Text = _1H2A("wD2Z\rJZ\r2J~JEv\rSSD8\r2J\020;\aS\r2t\127Z\r&")
_3sWbh = Wherigo.ZInput(_qXCkI)
_3sWbh.Id = "0290a73d-04ac-4428-b8b9-09c4f346a85c"
_3sWbh.Name = _1H2A("<D28;h\rwD2;S")
_3sWbh.Description = ""
_3sWbh.Visible = true
_3sWbh.Media = _whdd
_3sWbh.Choices = {"Ja", "Nein"}
_3sWbh.InputType = "MultipleChoice"
_3sWbh.Text = _1H2A(".;EvJ$\001J$Dt\aJD2JZ;EJ \1278h\001t\aJ\rD28\rv1;8\r2V")
function _qXCkI:OnStart()
  if _G[_1H2A("<2,")][_1H2A("$\r,Dt\rM$")] == _1H2A("$\rEev\127I") or _G[_1H2A("<2,")][_1H2A("=S;v*\1271z")] == _1H2A("\025D2~g") then
    for k, v in pairs(_G[_1H2A("%\"NkeM")][_1H2A("\004SS\020\027h\024\rtvE")]) do
      v[_1H2A("xDEDhS\r")] = false
      v[_1H2A("\004tvD,\r")] = false
    end
    _G[_1H2A("\025\a\r1D8\127")][_1H2A("k\127zz;2Z")](_1H2A("A;,\rkS\127E\r"))
    return
  end
end
function _qXCkI:OnRestore()
end
function __xt8:OnEnter()
  _EBp = _1H2A("%%Yv5")
  if _mPO == false then
    _mPO = true
    _V8NLC.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A(".D\r1J8DhvJ\rEJ\rD2\rJw1;8\rJ9\001Jh\r;2vo\1271v\r2\018J\029\022:/At\a;\001Jz;SJD2EJb\027WJA<<\018")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _0sz:OnEnter()
  _EBp = _1H2A("%3E9")
  if _G4y == false then
    _G4y = true
    _OX8ol.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A(".D\r1J8DhvJ\rEJ\rD2\rJw1;8\rJ9\001Jh\r;2vo\1271v\r2\018J\029\022:/At\a;\001Jz;SJD2EJb\027WJA<<\018")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _1Me:OnEnter()
  _EBp = _1H2A("%\015\\\r")
  if _5XVbF == false then
    _5XVbF = true
    _iMzHD.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A(".D\r1J8DhvJ\rEJ\rD2\rJw1;8\rJ9\001Jh\r;2vo\1271v\r2\018J\029\022:/At\a;\001Jz;SJD2EJb\027WJA<<\018")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _AS6tj:OnEnter()
  _EBp = _1H2A("%\004A]v\024")
  if _8lQq == false then
    _8lQq = true
    _AwX2.Visible = true
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A("$\001JhDEvJ2\0012J;zJwD2;SJ;28\re\127zz\r2\018\029\022:/.D\r1JDEvJZD\rJ$\127E\rJzDvJZ\rzJ \1278h\001t\aJ,\r1Ev\rtev\018\029\022:/At\a;\001Jz;SJD2EJb\027WJA<<\018")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _LtB:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 34952 then
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A("$;EJF\1271J\127\r**2\rvJEDt\a?J\127\aJ\022\rE\001t\a&J#1\001\r?\rvJ<\001t\a\018JMt\aJhD2JM9;1JADSh\r19\00128\rJZ\r1J\aD\rED8\rJ\025;\a1E;8\r1\018JM\a1JE\r\avJ;\001E?J;SEJ\127hJ<\001t\aJ\rD2\rJ\025;\a1E;8\00128J8\001vJv\0012Jo\001\r1Z\r\018J \rDZ\r1Jh1;\001t\aJDt\aJZ;*\0011J\rD2\rJ\0191DEv;Se\0018\rS\018JM\a1J\a;hvJ2Dt\avJ9\001*;\rSSD8J\rD2\rJZ;h\rDV"),
        Media = _KimOq
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
    __xt8.Active = false
    _0sz.Active = true
    _0sz.Visible = true
  elseif _Urwigo.Hash(string.lower(input)) == 2550 then
    _Urwigo.OldDialog({
      {
        Text = (_1H2A("Q") .. input) .. _1H2A("QJDEvJ*;SEt\a&"),
        Media = _xxuIk
      }
    })
  else
    _Urwigo.OldDialog({
      {
        Text = (_1H2A("Q") .. input) .. _1H2A("QJDEvJ*;SEt\a&"),
        Media = _xxuIk
      }
    })
  end
end
function _kiPiC:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 141011 then
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A("Mt\aJe;22J\rEJ\024\rv9vJE\r\a\r2JM\a1Jh\r8\r\a1v\018J\025\r22JM\a1J\rD2JS\rv9v\rEJ:;\rvE\rSJS\127EEvJoD1ZJ<\001t\aJZ\r1J\025\r8JZ\0011t\aJZ;EJ,\r1h\12718\r2\rJF\1271J8\ro;\r\a1v\018"),
        Media = _KimOq
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
    _0sz.Active = false
    _1Me.Active = true
    _1Me.Visible = true
  else
    _Urwigo.OldDialog({
      {
        Text = (_1H2A("Q") .. input) .. _1H2A("\005JDEvJS\rDZ\r1J*;SEt\a\018"),
        Media = _xxuIk
      }
    })
  end
end
function _B0nbK:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 284 then
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A(".\r19SDt\a\r2J#S\001teo\0012Et\a?JD\a1J\a;hvJ\rEJ8\rEt\a;**v&\029\022:/$;EJ#\r\a\rDz2DEJZ\rEJ<S\rYD1EJo\0011Z\rJ8\rS\127\rEvJ\0012ZJZD\rJ\025\rSvJo\0011Z\rJ,\1271Jo\rDv1\rDt\a\r2Z\r2J\019\1272E\r\"\001\r29\r2Jh\ro;\a1vJo\r1Z\r2\018"),
        Media = _KimOq
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
    _1Me.Active = false
    _AS6tj.Active = true
    _AS6tj.Visible = true
  else
    _Urwigo.OldDialog({
      {
        Text = (_1H2A("Q") .. input) .. _1H2A("QJDEvJS\rDZ\r1JZD\rJ*;SEt\a\rJ\0042vo\1271v\018"),
        Media = _xxuIk
      }
    })
  end
end
function _3sWbh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _AS6tj.Visible = false
    _qXCkI.Complete = true
    _0i9:MoveTo(Player)
    _Urwigo.Dialog(false, {
      {
        Text = _1H2A("A\001I\r1&\029\022:/$\001J\a;EvJ\rEJ8\rEt\a;**v\018\029\022:/$\r2JW2S\127teJk\127Z\rJ*D2Z\rEvJDzJM\023x<\023F\027:b\018"),
        Media = _KimOq
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.OldDialog({
      {
        Text = _1H2A("$\r2JW2S\127teak\127Z\rJh\re\127zzEvJ$\001J\r1Ev?Jo\r22J$\001J$Dt\aJD2EJ \1278h\001t\aJ\rD28\rv1;8\r2J\a;Ev\018"),
        Media = _xxuIk
      }
    })
  end
end
function _V8NLC:On_ivZfg(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_LtB)
  end)
end
function _OX8ol:On_h7yF(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_kiPiC)
  end)
end
function _iMzHD:On_vi7cy(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_B0nbK)
  end)
end
function _AwX2:On_jNE(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_3sWbh)
  end)
end
function _0i9:On_9mH(target)
  _Urwigo.MessageBox({
    Text = _1H2A("$\r1JW2S\127teJk\127Z\rJS;\001v\rv[J") .. string.sub(Player.CompletionCode, 1, 15)
  })
end
function _mnJ:On_hF0(target)
  _qXCkI:RequestSync()
  _Urwigo.Dialog(false, {
    {
      Text = _1H2A("$\r1J;ev\001\rSS\rJAID\rSEv;2ZJo\0011Z\rJ8\rEI\rDt\a\r1v\018\029\022:/$\001Je;22EvJ2\0012JZ;EJAID\rSJ*\1271vE\rv9\r2\018")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
return _qXCkI
