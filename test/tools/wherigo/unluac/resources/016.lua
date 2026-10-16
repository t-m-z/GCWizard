require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _Q4b(str)
  local res = ""
  local dtable = "\001[\017\nk-LD2`RO*YrlC9\019\023\021b\018Tv(dc\014zGBn\031|p0aI\v3<\aw:\026>q+Z\006J?;m\0001S\00365\t\\'Vt\fH7s#\002Q\b\015\027,E@)!ofj\016U8x\022y%hK\r\004MNu]\028\030e\024\029\"X\020F=&~4{i\025A }./^g_$\005PW"
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
_To3S9 = Wherigo.ZCartridge()
zmediaAlienGeocacher = Wherigo.ZMedia(_To3S9)
zmediaAlienGeocacher.Id = "8783940f-c825-4ed5-b274-1c8f9400092b"
zmediaAlienGeocacher.Name = _Q4b("t\016rf!u\031fR\028&\028\\f\015")
zmediaAlienGeocacher.Description = ""
zmediaAlienGeocacher.AltText = ""
zmediaAlienGeocacher.Resources = {
  {
    Type = "jpg",
    Filename = "alien_geocacher.jpg",
    Directives = {}
  }
}
zmediaAlienMechanic = Wherigo.ZMedia(_To3S9)
zmediaAlienMechanic.Id = "81863ebe-a4b5-4137-a46f-6c1f3469d4a9"
zmediaAlienMechanic.Name = _Q4b("t\016rf!u`f\028\\&!r\028")
zmediaAlienMechanic.Description = ""
zmediaAlienMechanic.AltText = ""
zmediaAlienMechanic.Resources = {
  {
    Type = "jpg",
    Filename = "alien_mechanic.jpg",
    Directives = {}
  }
}
zmediaCar = Wherigo.ZMedia(_To3S9)
zmediaCar.Id = "c44055fa-1d92-4917-8f8c-b51bde63d20c"
zmediaCar.Name = _Q4b("\017&\015")
zmediaCar.Description = ""
zmediaCar.AltText = ""
zmediaCar.Resources = {
  {
    Type = "jpg",
    Filename = "car.jpg",
    Directives = {}
  }
}
zmediaFluxCapacitorOff = Wherigo.ZMedia(_To3S9)
zmediaFluxCapacitorOff.Id = "7ef9ec3d-5802-4c98-89f4-937ebbedda73"
zmediaFluxCapacitorOff.Name = _Q4b("l\016bXu\017&$&\028rBR\015u\fSS")
zmediaFluxCapacitorOff.Description = ""
zmediaFluxCapacitorOff.AltText = ""
zmediaFluxCapacitorOff.Resources = {
  {
    Type = "jpg",
    Filename = "flux_capacitor_off.jpg",
    Directives = {}
  }
}
zmediaFluxCapacitorOn = Wherigo.ZMedia(_To3S9)
zmediaFluxCapacitorOn.Id = "40f77a42-0d45-4895-8755-ffa6177dce35"
zmediaFluxCapacitorOn.Name = _Q4b("l\016bXu\017&$&\028rBR\015u\f!")
zmediaFluxCapacitorOn.Description = ""
zmediaFluxCapacitorOn.AltText = ""
zmediaFluxCapacitorOn.Resources = {
  {
    Type = "jpg",
    Filename = "flux_capacitor_on.jpg",
    Directives = {}
  }
}
zmediaFlyingSaucer = Wherigo.ZMedia(_To3S9)
zmediaFlyingSaucer.Id = "77e13b07-2eb5-4576-a014-3440074bc5ce"
zmediaFlyingSaucer.Name = _Q4b("l\016Zr!zu:&b\028f\015")
zmediaFlyingSaucer.Description = ""
zmediaFlyingSaucer.AltText = ""
zmediaFlyingSaucer.Resources = {
  {
    Type = "jpg",
    Filename = "flying_saucer.jpg",
    Directives = {}
  }
}
zmediaSpaceshipPart1 = Wherigo.ZMedia(_To3S9)
zmediaSpaceshipPart1.Id = "f2c80bf1-2bfb-4dec-a4ff-1c16ec1d5783"
zmediaSpaceshipPart1.Name = _Q4b(":$&\028fF\\r$u~&\015Bu9")
zmediaSpaceshipPart1.Description = ""
zmediaSpaceshipPart1.AltText = ""
zmediaSpaceshipPart1.Resources = {
  {
    Type = "jpg",
    Filename = "gadget_1.jpg",
    Directives = {}
  }
}
zmediaSpaceshipPart2 = Wherigo.ZMedia(_To3S9)
zmediaSpaceshipPart2.Id = "e15e504d-67e4-42c9-8f71-27410802cd31"
zmediaSpaceshipPart2.Name = _Q4b(":$&\028fF\\r$u~&\015Bu\t")
zmediaSpaceshipPart2.Description = ""
zmediaSpaceshipPart2.AltText = ""
zmediaSpaceshipPart2.Resources = {
  {
    Type = "jpg",
    Filename = "gadget_2.jpg",
    Directives = {}
  }
}
zmediaSpaceshipPart3 = Wherigo.ZMedia(_To3S9)
zmediaSpaceshipPart3.Id = "9cb0668d-7c95-47b3-8f17-fb50558aa39b"
zmediaSpaceshipPart3.Name = _Q4b(":$&\028fF\\r$u~&\015Bu)")
zmediaSpaceshipPart3.Description = ""
zmediaSpaceshipPart3.AltText = ""
zmediaSpaceshipPart3.Resources = {
  {
    Type = "jpg",
    Filename = "gadget_3.jpg",
    Directives = {}
  }
}
zmediaGloves = Wherigo.ZMedia(_To3S9)
zmediaGloves.Id = "79b7c3c3-4cc4-4d83-a185-b1ac7655445e"
zmediaGloves.Name = _Q4b("\031\016R\025fF")
zmediaGloves.Description = ""
zmediaGloves.AltText = ""
zmediaGloves.Resources = {
  {
    Type = "jpg",
    Filename = "gloves.jpg",
    Directives = {}
  }
}
zmediaWalkieTalkie = Wherigo.ZMedia(_To3S9)
zmediaWalkieTalkie.Id = "3fb3b7db-1103-4fa6-aa6d-a64b26a1005b"
zmediaWalkieTalkie.Name = _Q4b("\127&\016\005rfu\024&\016\005rf")
zmediaWalkieTalkie.Description = ""
zmediaWalkieTalkie.AltText = ""
zmediaWalkieTalkie.Resources = {
  {
    Type = "jpg",
    Filename = "radio.jpg",
    Directives = {}
  }
}
zmediaSunglasses = Wherigo.ZMedia(_To3S9)
zmediaSunglasses.Id = "b3047f8d-765c-47a3-a94b-9630b64c185b"
zmediaSunglasses.Name = _Q4b(":b!z\016&FFfF")
zmediaSunglasses.Description = ""
zmediaSunglasses.AltText = ""
zmediaSunglasses.Resources = {
  {
    Type = "jpg",
    Filename = "sunglasses.jpg",
    Directives = {}
  }
}
zmediaAlienMultiTool = Wherigo.ZMedia(_To3S9)
zmediaAlienMultiTool.Id = "cd9e6ca2-e040-43b4-89ea-262d5160036e"
zmediaAlienMultiTool.Name = _Q4b("t\016rf!u`b\016Br\024RR\016")
zmediaAlienMultiTool.Description = ""
zmediaAlienMultiTool.AltText = ""
zmediaAlienMultiTool.Resources = {
  {
    Type = "jpg",
    Filename = "wrench.jpg",
    Directives = {}
  }
}
zmediaMap = Wherigo.ZMedia(_To3S9)
zmediaMap.Id = "cd5f071a-2810-48e6-8ca6-e8210ba0032d"
zmediaMap.Name = _Q4b("`&$")
zmediaMap.Description = ""
zmediaMap.AltText = ""
zmediaMap.Resources = {
  {
    Type = "jpg",
    Filename = "map.jpg",
    Directives = {}
  }
}
zmediaGeocacher = Wherigo.ZMedia(_To3S9)
zmediaGeocacher.Id = "c182459a-96ee-47c4-b10c-1f02e1e68493"
zmediaGeocacher.Name = _Q4b("\031fR\028&\028\\f\015")
zmediaGeocacher.Description = ""
zmediaGeocacher.AltText = ""
zmediaGeocacher.Resources = {
  {
    Type = "jpg",
    Filename = "geocacher.jpg",
    Directives = {}
  }
}
zmediaTask = Wherigo.ZMedia(_To3S9)
zmediaTask.Id = "8e86c915-3fd9-415b-832a-5a8613edb5d9"
zmediaTask.Name = _Q4b("\024&F\005")
zmediaTask.Description = ""
zmediaTask.AltText = ""
zmediaTask.Resources = {
  {
    Type = "jpg",
    Filename = "task.jpg",
    Directives = {}
  }
}
zmediaSpaceCraftinOrbit = Wherigo.ZMedia(_To3S9)
zmediaSpaceCraftinOrbit.Id = "959bdfcb-7dfc-443d-b8ec-a31b6f2621b7"
zmediaSpaceCraftinOrbit.Name = _Q4b(":$&\028fu\017\015&SBur!u\f\015\022rB")
zmediaSpaceCraftinOrbit.Description = ""
zmediaSpaceCraftinOrbit.AltText = ""
zmediaSpaceCraftinOrbit.Resources = {
  {
    Type = "jpg",
    Filename = "space_craftinorbit.jpg",
    Directives = {}
  }
}
zmediaWherigo = Wherigo.ZMedia(_To3S9)
zmediaWherigo.Id = "d9ee2918-8c40-4f33-84c2-49b33ad64992"
zmediaWherigo.Name = _Q4b("\127\\f\015rzR")
zmediaWherigo.Description = ""
zmediaWherigo.AltText = ""
zmediaWherigo.Resources = {
  {
    Type = "jpg",
    Filename = "wherigo.jpg",
    Directives = {}
  }
}
zmediaSpoiler = Wherigo.ZMedia(_To3S9)
zmediaSpoiler.Id = "73e28a2d-a546-4cdb-b399-80e1bf87e202"
zmediaSpoiler.Name = _Q4b(":$Rr\016f\015")
zmediaSpoiler.Description = ""
zmediaSpoiler.AltText = ""
zmediaSpoiler.Resources = {
  {
    Type = "jpg",
    Filename = "Falsch_Symbol.jpg",
    Directives = {}
  }
}
zmediaAlienSWAG = Wherigo.ZMedia(_To3S9)
zmediaAlienSWAG.Id = "1f358a00-c6e9-49b7-b083-ab98295a1565"
zmediaAlienSWAG.Name = _Q4b("t\016rf!u:\127t\031")
zmediaAlienSWAG.Description = ""
zmediaAlienSWAG.AltText = ""
zmediaAlienSWAG.Resources = {
  {
    Type = "jpg",
    Filename = "swag.jpg",
    Directives = {}
  }
}
_To3S9.Id = "122fc34b-e5cf-4a00-9151-7e1d9711efbc"
_To3S9.Name = "Louis und seine au\195\159erirdischen Besucher"
_To3S9.Description = " Bauer Louis und sein buckliger Nachbar Franz haben nicht mehr viel vom Leben zu erwarten. Im Wesentlichen vertreiben die beiden sich die Zeit auf ihrem Bauernhof mit froehlichem Trinken von Wein und Pernod sowie dem Essen selbstgekochter Kohlsuppe. Eines Tages verursacht diese in Verbindung mit dem Pernod bei den beiden derartig heftige Blaehungen, dass die Ger\195\164usche im Weltall aufgefangen werden. Noch in der Nacht landet ein Ausserirdischer mit seinem Raumschiff auf dem Hof und steht vor der T\195\188r von Louis.<BR>\n<BR>\nEin kleines Spiel, das dich irgendwann dazu bringt, einen Geocache zu finden. "
_To3S9.Visible = true
_To3S9.Activity = "Fiction"
_To3S9.StartingLocationDescription = ""
_To3S9.StartingLocation = ZonePoint(53.27385, 12.823417, 0)
_To3S9.Version = "1.2"
_To3S9.Company = ""
_To3S9.Author = "eddysnz"
_To3S9.BuilderVersion = "URWIGO 1.22.5798.37755"
_To3S9.CreateDate = "12/03/2012 21:25:00"
_To3S9.PublishDate = "1/1/0001 12:00:00 AM"
_To3S9.UpdateDate = "09/09/2020 17:16:07"
_To3S9.LastPlayedDate = "1/1/0001 12:00:00 AM"
_To3S9.TargetDevice = "PocketPC"
_To3S9.TargetDeviceVersion = "0"
_To3S9.StateId = "1"
_To3S9.CountryId = "2"
_To3S9.Complete = false
_To3S9.UseLogging = true
_NwAT = Wherigo.Zone(_To3S9)
_NwAT.Id = "910c115f-6ca5-44fc-a5a3-e1a2508ca958"
_NwAT.Name = _Q4b("~&\015\005f!")
_NwAT.Description = ""
_NwAT.Visible = true
_NwAT.Media = zmediaMap
_NwAT.Commands = {}
_NwAT.DistanceRange = Distance(-1, "feet")
_NwAT.ShowObjects = "OnEnter"
_NwAT.ProximityRange = Distance(200, "feet")
_NwAT.AllowSetPositionTo = false
_NwAT.Active = true
_NwAT.Points = {
  ZonePoint(53.2734404244469, 12.82416667, 0),
  ZonePoint(53.2734455656906, 12.8240234745622, 0),
  ZonePoint(53.2733231466063, 12.8240160987398, 0),
  ZonePoint(53.2733175740216, 12.8241509735123, 0)
}
_NwAT.OriginalPoint = ZonePoint(42.14445, 24.7408, 0)
_NwAT.DistanceRangeUOM = "Feet"
_NwAT.ProximityRangeUOM = "Feet"
_NwAT.OutOfRangeName = ""
_NwAT.InRangeName = ""
_k_e = Wherigo.Zone(_To3S9)
_k_e.Id = "f09c63a4-91ab-4e2e-9b49-ce25b3e73846"
_k_e.Name = _Q4b("t\022FBb\015\030FBf\016\016f")
_k_e.Description = ""
_k_e.Visible = false
_k_e.Media = zmediaMap
_k_e.Commands = {}
_k_e.DistanceRange = Distance(-1, "feet")
_k_e.ShowObjects = "OnEnter"
_k_e.ProximityRange = Distance(50, "meters")
_k_e.AllowSetPositionTo = false
_k_e.Active = false
_k_e.Points = {
  ZonePoint(53.273558405355, 12.8232838850001, 0),
  ZonePoint(53.2735526309786, 12.8234466159968, 0),
  ZonePoint(53.2734454201415, 12.8234508467747, 0),
  ZonePoint(53.2734522943516, 12.8232840691437, 0)
}
_k_e.OriginalPoint = ZonePoint(42.14435, 24.73994, 0)
_k_e.DistanceRangeUOM = "Feet"
_k_e.ProximityRangeUOM = "Meters"
_k_e.OutOfRangeName = ""
_k_e.InRangeName = ""
_2KH0 = Wherigo.Zone(_To3S9)
_2KH0.Id = "8ea68365-49dd-4c18-a374-50327f8e505b"
_2KH0.Name = _Q4b("\v&b7F\028\\rSSu\024fr\016u9")
_2KH0.Description = ""
_2KH0.Visible = false
_2KH0.Media = zmediaMap
_2KH0.Commands = {}
_2KH0.DistanceRange = Distance(-1, "feet")
_2KH0.ShowObjects = "OnEnter"
_2KH0.ProximityRange = Distance(50, "meters")
_2KH0.AllowSetPositionTo = false
_2KH0.Active = false
_2KH0.Points = {
  ZonePoint(53.2737423214132, 12.8223641601652, 0),
  ZonePoint(53.2738283610858, 12.8223727095343, 0),
  ZonePoint(53.2738294414972, 12.8222402321859, 0),
  ZonePoint(53.2737435547992, 12.8222327946051, 0)
}
_2KH0.OriginalPoint = ZonePoint(42.143856, 24.740758, 0)
_2KH0.DistanceRangeUOM = "Feet"
_2KH0.ProximityRangeUOM = "Meters"
_2KH0.OutOfRangeName = ""
_2KH0.InRangeName = ""
zoneShipPart2 = Wherigo.Zone(_To3S9)
zoneShipPart2.Id = "4924835a-128d-4b13-85a8-3260317c5ebc"
zoneShipPart2.Name = _Q4b("\v&b7F\028\\rSSu\024fr\016u\t")
zoneShipPart2.Description = ""
zoneShipPart2.Visible = false
zoneShipPart2.Media = zmediaMap
zoneShipPart2.Commands = {}
zoneShipPart2.DistanceRange = Distance(-1, "feet")
zoneShipPart2.ShowObjects = "OnEnter"
zoneShipPart2.ProximityRange = Distance(50, "meters")
zoneShipPart2.AllowSetPositionTo = false
zoneShipPart2.Active = false
zoneShipPart2.Points = {
  ZonePoint(53.2739949728018, 12.8229249888419, 0),
  ZonePoint(53.2739902982899, 12.8230527732803, 0),
  ZonePoint(53.2739034632055, 12.8230432091259, 0),
  ZonePoint(53.2739081101977, 12.8229172178249, 0)
}
zoneShipPart2.OriginalPoint = ZonePoint(42.14285, 24.73968, 0)
zoneShipPart2.DistanceRangeUOM = "Feet"
zoneShipPart2.ProximityRangeUOM = "Meters"
zoneShipPart2.OutOfRangeName = ""
zoneShipPart2.InRangeName = ""
_8Fp7 = Wherigo.Zone(_To3S9)
_8Fp7.Id = "6731f638-59f5-4fcb-9881-ca2dd53daaba"
_8Fp7.Name = _Q4b("\v&b7F\028\\rSSu\024fr\016u)")
_8Fp7.Description = ""
_8Fp7.Visible = false
_8Fp7.Media = zmediaMap
_8Fp7.Commands = {}
_8Fp7.DistanceRange = Distance(-1, "feet")
_8Fp7.ShowObjects = "OnEnter"
_8Fp7.ProximityRange = Distance(50, "meters")
_8Fp7.AllowSetPositionTo = false
_8Fp7.Active = false
_8Fp7.Points = {
  ZonePoint(53.2737983161883, 12.8252555101858, 0),
  ZonePoint(53.2739033763437, 12.8252536341261, 0),
  ZonePoint(53.2739047225356, 12.8251154174658, 0),
  ZonePoint(53.2737990419307, 12.8251088095561, 0)
}
_8Fp7.OriginalPoint = ZonePoint(42.14295, 24.741044, 0)
_8Fp7.DistanceRangeUOM = "Feet"
_8Fp7.ProximityRangeUOM = "Meters"
_8Fp7.OutOfRangeName = ""
_8Fp7.InRangeName = ""
_5Dk2l = Wherigo.Zone(_To3S9)
_5Dk2l.Id = "b915da9b-f0d7-4605-9888-57fd0799f268"
_5Dk2l.Name = _Q4b("l\016bX\005R!\027f!F&BR\015")
_5Dk2l.Description = ""
_5Dk2l.Visible = false
_5Dk2l.Media = zmediaMap
_5Dk2l.Commands = {}
_5Dk2l.DistanceRange = Distance(-1, "feet")
_5Dk2l.ShowObjects = "OnEnter"
_5Dk2l.ProximityRange = Distance(50, "meters")
_5Dk2l.AllowSetPositionTo = false
_5Dk2l.Active = false
_5Dk2l.Points = {
  ZonePoint(53.2738086341889, 12.8226659149123, 0),
  ZonePoint(53.2738062849128, 12.8227625127153, 0),
  ZonePoint(53.2737202649912, 12.8227506856522, 0),
  ZonePoint(53.2737235753791, 12.8226550639561, 0)
}
_5Dk2l.OriginalPoint = ZonePoint(42.14505, 24.74032, 0)
_5Dk2l.DistanceRangeUOM = "Feet"
_5Dk2l.ProximityRangeUOM = "Meters"
_5Dk2l.OutOfRangeName = ""
_5Dk2l.InRangeName = ""
_mnH = Wherigo.Zone(_To3S9)
_mnH.Id = "3c1024fd-a2fc-4698-84da-2946c415da69"
_mnH.Name = _Q4b("\017R\027fu9")
_mnH.Description = ""
_mnH.Visible = false
_mnH.Media = zmediaMap
_mnH.Commands = {}
_mnH.DistanceRange = Distance(-1, "feet")
_mnH.ShowObjects = "OnEnter"
_mnH.ProximityRange = Distance(50, "meters")
_mnH.AllowSetPositionTo = false
_mnH.Active = false
_mnH.Points = {
  ZonePoint(53.2731333302462, 12.8233815824097, 0),
  ZonePoint(53.2731195570004, 12.8234818706756, 0),
  ZonePoint(53.2730603174221, 12.8234602314786, 0),
  ZonePoint(53.2730738903611, 12.8233547103127, 0)
}
_mnH.OriginalPoint = ZonePoint(42.145382, 24.739989, 0)
_mnH.DistanceRangeUOM = "Feet"
_mnH.ProximityRangeUOM = "Meters"
_mnH.OutOfRangeName = ""
_mnH.InRangeName = ""
_ZEVP = Wherigo.Zone(_To3S9)
_ZEVP.Id = "0cc2f841-7930-4a5f-9f18-5b62d62959bf"
_ZEVP.Name = _Q4b("\031fR\028&\028\\f")
_ZEVP.Description = ""
_ZEVP.Visible = false
_ZEVP.Media = zmediaMap
_ZEVP.Commands = {}
_ZEVP.DistanceRange = Distance(-1, "feet")
_ZEVP.ShowObjects = "OnEnter"
_ZEVP.ProximityRange = Distance(50, "meters")
_ZEVP.AllowSetPositionTo = false
_ZEVP.Active = false
_ZEVP.Points = {
  ZonePoint(53.2731016879906, 12.8282420908752, 0),
  ZonePoint(53.2730255133303, 12.8284439315659, 0),
  ZonePoint(53.2728883524836, 12.8283332038193, 0),
  ZonePoint(53.2729805813773, 12.828107793764, 0)
}
_ZEVP.OriginalPoint = ZonePoint(42.1447, 24.735433, 0)
_ZEVP.DistanceRangeUOM = "Feet"
_ZEVP.ProximityRangeUOM = "Meters"
_ZEVP.OutOfRangeName = ""
_ZEVP.InRangeName = ""
_Qjc5g = Wherigo.Zone(_To3S9)
_Qjc5g.Id = "e33c104f-c75f-4195-9a86-d0542460528b"
_Qjc5g.Name = _Q4b("\017R\027fu\t")
_Qjc5g.Description = ""
_Qjc5g.Visible = false
_Qjc5g.Media = zmediaMap
_Qjc5g.Commands = {}
_Qjc5g.DistanceRange = Distance(-1, "feet")
_Qjc5g.ShowObjects = "OnEnter"
_Qjc5g.ProximityRange = Distance(50, "meters")
_Qjc5g.AllowSetPositionTo = false
_Qjc5g.Active = false
_Qjc5g.Points = {
  ZonePoint(53.2731371688634, 12.8230018827194, 0),
  ZonePoint(53.2731547476413, 12.8228515382758, 0),
  ZonePoint(53.2730932785639, 12.8228258336204, 0),
  ZonePoint(53.2730756278501, 12.8229786808808, 0)
}
_Qjc5g.OriginalPoint = ZonePoint(42.146883, 24.737983, 0)
_Qjc5g.DistanceRangeUOM = "Feet"
_Qjc5g.ProximityRangeUOM = "Meters"
_Qjc5g.OutOfRangeName = ""
_Qjc5g.InRangeName = ""
_FsKq = Wherigo.ZCharacter({Cartridge = _To3S9, Container = _k_e})
_FsKq.Id = "be9bac21-51f0-42f0-896e-1ea18e51f74d"
_FsKq.Name = _Q4b("\aRbrF")
_FsKq.Description = ""
_FsKq.Visible = false
_FsKq.Media = zmediaGeocacher
_FsKq.Commands = {
  _vcx = Wherigo.ZCommand({
    Text = _Q4b("\aRR\005utB"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_FsKq.Commands._vcx.Custom = true
_FsKq.Commands._vcx.Id = "102085c9-0b87-41d0-b3d8-bcff3fefb47f"
_FsKq.Commands._vcx.WorksWithAll = true
_FsKq.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_FsKq.Gender = "Male"
_FsKq.Type = "NPC"
_UMX_Z = Wherigo.ZCharacter({Cartridge = _To3S9, Container = _k_e})
_UMX_Z.Id = "b9de05d9-f36e-4fd7-b8cf-681b8439b993"
_UMX_Z.Name = _Q4b("]\015&!z")
_UMX_Z.Description = ""
_UMX_Z.Visible = false
_UMX_Z.Media = zmediaAlienMechanic
_UMX_Z.Commands = {
  _DGoS_ = Wherigo.ZCommand({
    Text = _Q4b("\024&\016\005"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_UMX_Z.Commands._DGoS_.Custom = true
_UMX_Z.Commands._DGoS_.Id = "b8fa293f-4ac1-4400-bb5c-2710326ac1b3"
_UMX_Z.Commands._DGoS_.WorksWithAll = true
_UMX_Z.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_UMX_Z.Gender = "Male"
_UMX_Z.Type = "NPC"
_DAOw1 = Wherigo.ZCharacter({Cartridge = _To3S9, Container = _k_e})
_DAOw1.Id = "043f8b5a-1d5b-4c0a-9b86-b6aa166cc9d1"
_DAOw1.Name = _Q4b("]\015&B\\")
_DAOw1.Description = ""
_DAOw1.Visible = false
_DAOw1.Media = zmediaAlienGeocacher
_DAOw1.Commands = {
  _a4XCw = Wherigo.ZCommand({
    Text = _Q4b("\024&\016\005"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_DAOw1.Commands._a4XCw.Custom = true
_DAOw1.Commands._a4XCw.Id = "97b038ad-3fbc-4f37-a93d-6a4ac6649dfe"
_DAOw1.Commands._a4XCw.WorksWithAll = true
_DAOw1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_DAOw1.Gender = "Male"
_DAOw1.Type = "NPC"
_JylKL = Wherigo.ZItem({Cartridge = _To3S9, Container = _NwAT})
_JylKL.Id = "7e0d0f6a-b47e-43e9-992c-64e6142c30f8"
_JylKL.Name = _Q4b("tbBR")
_JylKL.Description = ""
_JylKL.Visible = true
_JylKL.Media = zmediaCar
_JylKL.Commands = {
  _Qj1 = Wherigo.ZCommand({
    Text = _Q4b("\aRR\005u'!Fr\027f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_JylKL.Commands._Qj1.Custom = true
_JylKL.Commands._Qj1.Id = "a2e17b67-3cdc-4291-9ebd-7b32a6cfd78b"
_JylKL.Commands._Qj1.WorksWithAll = true
_JylKL.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_JylKL.Locked = false
_JylKL.Opened = false
_6mSV1 = Wherigo.ZItem({Cartridge = _To3S9, Container = _NwAT})
_6mSV1.Id = "a1b80993-2bdd-4ea0-97b0-a098485edd40"
_6mSV1.Name = _Q4b("D&!\027F\028\\b\\f")
_6mSV1.Description = ""
_6mSV1.Visible = false
_6mSV1.Media = zmediaGloves
_6mSV1.Commands = {
  _mOY = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_6mSV1.Commands._mOY.Custom = true
_6mSV1.Commands._mOY.Id = "290c770d-0732-4de0-8d2b-2b18322eb21f"
_6mSV1.Commands._mOY.WorksWithAll = true
_6mSV1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_6mSV1.Locked = false
_6mSV1.Opened = true
_gDc = Wherigo.ZItem({Cartridge = _To3S9, Container = _NwAT})
_gDc.Id = "1226972d-ded2-465f-835a-ed842b133daf"
_gDc.Name = _Q4b("\127&\016\005rfu\024&\016\005rf")
_gDc.Description = ""
_gDc.Visible = false
_gDc.Media = zmediaWalkieTalkie
_gDc.Commands = {
  _85pDb = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_gDc.Commands._85pDb.Custom = true
_gDc.Commands._85pDb.Id = "88e2a522-b9bb-4ba6-af30-35cf4023b456"
_gDc.Commands._85pDb.WorksWithAll = true
_gDc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_gDc.Locked = false
_gDc.Opened = false
__rp9 = Wherigo.ZItem({Cartridge = _To3S9, Container = _NwAT})
__rp9.Id = "854d02c0-80e6-4587-9ce9-4fde5793d580"
__rp9.Name = _Q4b(":R!!f!\022\015r\016\016f")
__rp9.Description = ""
__rp9.Visible = false
__rp9.Media = zmediaSunglasses
__rp9.Commands = {
  _AR57 = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
__rp9.Commands._AR57.Custom = true
__rp9.Commands._AR57.Id = "26c0253c-bb3c-4936-af62-73b1c4da6b94"
__rp9.Commands._AR57.WorksWithAll = true
__rp9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
__rp9.Locked = false
__rp9.Opened = false
_b1i = Wherigo.ZItem({Cartridge = _To3S9, Container = _k_e})
_b1i.Id = "7cb7d26d-3e7e-408d-af0c-b3152e2e29c2"
_b1i.Name = _Q4b("\v&b7F\028\\rSS")
_b1i.Description = ""
_b1i.Visible = true
_b1i.Media = zmediaFlyingSaucer
_b1i.Commands = {
  _GBOec = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_b1i.Commands._GBOec.Custom = true
_b1i.Commands._GBOec.Id = "f26c62b7-3a8b-4e89-8712-d3ea9f6c606d"
_b1i.Commands._GBOec.WorksWithAll = true
_b1i.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_b1i.Locked = false
_b1i.Opened = false
_QiPkT = Wherigo.ZItem({Cartridge = _To3S9, Container = _2KH0})
_QiPkT.Id = "b2e86065-759d-4a18-8b70-e42235d9f727"
_QiPkT.Name = _Q4b("\v&b7F\028\\rSSu\024fr\016u9")
_QiPkT.Description = ""
_QiPkT.Visible = true
_QiPkT.Media = zmediaSpaceshipPart1
_QiPkT.Commands = {
  _wtN = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_QiPkT.Commands._wtN.Custom = true
_QiPkT.Commands._wtN.Id = "d8478feb-e4d5-4177-9987-ceba7987e66b"
_QiPkT.Commands._wtN.WorksWithAll = true
_QiPkT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QiPkT.Locked = false
_QiPkT.Opened = false
_2niuW = Wherigo.ZItem({Cartridge = _To3S9, Container = zoneShipPart2})
_2niuW.Id = "4a74939f-f1f1-4f74-926e-f38893947941"
_2niuW.Name = _Q4b("\v&b7F\028\\rSSu\024fr\016u\t")
_2niuW.Description = ""
_2niuW.Visible = true
_2niuW.Media = zmediaSpaceshipPart2
_2niuW.Commands = {
  _8VuA = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_2niuW.Commands._8VuA.Custom = true
_2niuW.Commands._8VuA.Id = "86a82499-3949-49ad-93a8-35d24ac6cf87"
_2niuW.Commands._8VuA.WorksWithAll = true
_2niuW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2niuW.Locked = false
_2niuW.Opened = false
_tTPk = Wherigo.ZItem({Cartridge = _To3S9, Container = _8Fp7})
_tTPk.Id = "1ccf0fa5-7886-48bf-a54b-935daaa80c7f"
_tTPk.Name = _Q4b("\v&b7F\028\\rSSu\024fr\016u)")
_tTPk.Description = ""
_tTPk.Visible = true
_tTPk.Media = zmediaSpaceshipPart3
_tTPk.Commands = {
  _vuw = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_tTPk.Commands._vuw.Custom = true
_tTPk.Commands._vuw.Id = "1208f172-3890-4604-8662-8e17631c8402"
_tTPk.Commands._vuw.WorksWithAll = true
_tTPk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tTPk.Locked = false
_tTPk.Opened = false
_plAh = Wherigo.ZItem({Cartridge = _To3S9, Container = _k_e})
_plAh.Id = "5650b9a8-7d25-494c-a706-bce98c7d67cf"
_plAh.Name = _Q4b("t\016rf!u`b\016Bru\024RR\016")
_plAh.Description = ""
_plAh.Visible = false
_plAh.Media = zmediaAlienMultiTool
_plAh.Commands = {
  _2Nfov = Wherigo.ZCommand({
    Text = _Q4b("NX$\016R\015f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_plAh.Commands._2Nfov.Custom = true
_plAh.Commands._2Nfov.Id = "ee76b3f4-7cfc-43e3-aaf4-0b4395a88450"
_plAh.Commands._2Nfov.WorksWithAll = true
_plAh.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_plAh.Locked = false
_plAh.Opened = false
_xqo = Wherigo.ZItem({Cartridge = _To3S9, Container = _5Dk2l})
_xqo.Id = "e19552d3-7efb-4dd9-9531-c12d00dd55e7"
_xqo.Name = _Q4b("l\016bX\005R!\027f!F&BR\015")
_xqo.Description = ""
_xqo.Visible = true
_xqo.Media = zmediaFluxCapacitorOn
_xqo.Commands = {
  _YSY = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_xqo.Commands._YSY.Custom = true
_xqo.Commands._YSY.Id = "600ec83f-8cb9-4390-abc9-069bb45cb868"
_xqo.Commands._YSY.WorksWithAll = true
_xqo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xqo.Locked = false
_xqo.Opened = false
zitemDisabledFluxCapacitor = Wherigo.ZItem({Cartridge = _To3S9, Container = _5Dk2l})
zitemDisabledFluxCapacitor.Id = "f1e5779c-cccd-48bf-b7f1-9da4331e2871"
zitemDisabledFluxCapacitor.Name = _Q4b("\brF&\022\016f\027ul\016bX\005R!\027f!F&BR\015")
zitemDisabledFluxCapacitor.Description = ""
zitemDisabledFluxCapacitor.Visible = false
zitemDisabledFluxCapacitor.Media = zmediaFluxCapacitorOff
zitemDisabledFluxCapacitor.Commands = {
  _4E5VN = Wherigo.ZCommand({
    Text = _Q4b("NX$\016R\015f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
zitemDisabledFluxCapacitor.Commands._4E5VN.Custom = true
zitemDisabledFluxCapacitor.Commands._4E5VN.Id = "a018da6c-208c-45a7-8734-c099a91bfe5a"
zitemDisabledFluxCapacitor.Commands._4E5VN.WorksWithAll = true
zitemDisabledFluxCapacitor.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDisabledFluxCapacitor.Locked = false
zitemDisabledFluxCapacitor.Opened = false
_xA__ = Wherigo.ZItem(_To3S9)
_xA__.Id = "de31ab79-8f0a-4d48-9e3c-ed80e1e38fd6"
_xA__.Name = _Q4b("V7\016&bSf!\027fu\v&b7FR!\027f")
_xA__.Description = ""
_xA__.Visible = false
_xA__.Media = zmediaSpaceCraftinOrbit
_xA__.Commands = {
  _Vb8h = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_xA__.Commands._Vb8h.Custom = true
_xA__.Commands._Vb8h.Id = "3d8110d9-e0f5-4ecb-963e-f6ee5a5d1bad"
_xA__.Commands._Vb8h.WorksWithAll = true
_xA__.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xA__.Locked = false
_xA__.Opened = false
_PYaG = Wherigo.ZItem(_To3S9)
_PYaG.Id = "39d5857d-6b6e-41b8-b874-0ff8c9e5baf3"
_PYaG.Name = _Q4b("t\016rf!u:\127t\031")
_PYaG.Description = ""
_PYaG.Visible = false
_PYaG.Media = zmediaAlienSWAG
_PYaG.Commands = {
  __3G_v = Wherigo.ZCommand({
    Text = _Q4b("NX&7r!f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_PYaG.Commands.__3G_v.Custom = true
_PYaG.Commands.__3G_v.Id = "5f22928a-cc17-4970-9950-733720ae25d7"
_PYaG.Commands.__3G_v.WorksWithAll = true
_PYaG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_PYaG.Locked = false
_PYaG.Opened = false
_cEw = Wherigo.ZItem(_To3S9)
_cEw.Id = "ee5ff11b-db7d-4ffe-bc1a-7777dd5b7b72"
_cEw.Name = _Q4b("\031fR\028&\028\\fu]RR\015\027r!&Bf!")
_cEw.Description = ""
_cEw.Visible = false
_cEw.Commands = {
  _IIyD = Wherigo.ZCommand({
    Text = _Q4b("Arf,"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_cEw.Commands._IIyD.Custom = true
_cEw.Commands._IIyD.Id = "87e7c907-464a-4e8e-9705-89054099f6c3"
_cEw.Commands._IIyD.WorksWithAll = true
_cEw.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_cEw.Locked = false
_cEw.Opened = false
_vBX = Wherigo.ZItem(_To3S9)
_vBX.Id = "d36ce2c7-dbe0-4e57-8d14-6e2372f69b45"
_vBX.Name = _Q4b("\017R7$\016fBrR!u\017R\027f")
_vBX.Description = ""
_vBX.Visible = false
_vBX.Media = zmediaWherigo
_vBX.Commands = {
  _CAOf = Wherigo.ZCommand({
    Text = _Q4b("Arf,"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_vBX.Commands._CAOf.Custom = true
_vBX.Commands._CAOf.Id = "d981c048-84d0-42b1-a568-abae3364a526"
_vBX.Commands._CAOf.WorksWithAll = true
_vBX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_vBX.Locked = false
_vBX.Opened = false
_KcBjY = Wherigo.ZItem(_To3S9)
_KcBjY.Id = "2fc0daa7-6974-4117-93ee-8fa214366de0"
_KcBjY.Name = _Q4b(":$Rr\016f\015")
_KcBjY.Description = ""
_KcBjY.Visible = false
_KcBjY.Commands = {
  _aSra = Wherigo.ZCommand({
    Text = _Q4b("Arf,"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_KcBjY.Commands._aSra.Custom = true
_KcBjY.Commands._aSra.Id = "4fe01638-c622-438b-8570-5c744f9fdc3a"
_KcBjY.Commands._aSra.WorksWithAll = true
_KcBjY.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_KcBjY.Locked = false
_KcBjY.Opened = false
_NyVrD = Wherigo.ZItem({Cartridge = _To3S9, Container = Player})
_NyVrD.Id = "f0840bf4-03e1-4e1f-b22b-77bc2be1ced4"
_NyVrD.Name = _Q4b("\bfr!fu]&\015Bf")
_NyVrD.Description = ""
_NyVrD.Visible = true
_NyVrD.Media = zmediaMap
_NyVrD.Commands = {
  _7NN = Wherigo.ZCommand({
    Text = _Q4b("\017\\f\028\005"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _Q4b("aRB\\r!zu&\025&r\016&\022\016f")
  })
}
_NyVrD.Commands._7NN.Custom = true
_NyVrD.Commands._7NN.Id = "9955ffaf-188e-4b18-b458-8b93b2fd7003"
_NyVrD.Commands._7NN.WorksWithAll = true
_NyVrD.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NyVrD.Locked = false
_NyVrD.Opened = false
_nOEff = Wherigo.ZTask(_To3S9)
_nOEff.Id = "fdc458c1-a536-44b1-9a68-e8896bd7e648"
_nOEff.Name = _Q4b(":\028\\&bu&bSu\027rfu]&\015Bf")
_nOEff.Description = _Q4b(":\028\\&bu&bSu\027rfu]&\015Bf")
_nOEff.Visible = false
_nOEff.Media = zmediaTask
_nOEff.Active = false
_nOEff.Complete = false
_nOEff.CorrectState = "None"
_bze = Wherigo.ZTask(_To3S9)
_bze.Id = "4d376059-f426-4f47-b0cb-fc5c699fc55f"
_bze.Name = _Q4b("N\015\005b!\027f!u\027rfut\022FBb\015\030FBf\016\016f")
_bze.Description = _Q4b("N\015\005b!\027f!u\027rfut\022FBb\015\030FBf\016\016f")
_bze.Visible = false
_bze.Media = zmediaTask
_bze.Active = false
_bze.Complete = false
_bze.CorrectState = "None"
_wWUA = Wherigo.ZTask(_To3S9)
_wWUA.Id = "56d2d958-aae9-4fa7-8719-2f25906b1dca"
_wWUA.Name = _Q4b("lr!\027fu&\016\016fu\025f\015\016R\015f!f!u\024fr\016f")
_wWUA.Description = _Q4b("lr!\027fu&\016\016fu\025f\015\016R\015f!f!u\024fr\016f")
_wWUA.Visible = false
_wWUA.Media = zmediaTask
_wWUA.Active = false
_wWUA.Complete = false
_wWUA.CorrectState = "None"
_L5R = Wherigo.ZTask(_To3S9)
_L5R.Id = "c53bb3bc-9cc1-4c3f-99f3-43bc896c76ef"
_L5R.Name = _Q4b("lr!\027fu\027f!ul\016bXu\017&$&\028rBR\015")
_L5R.Description = ""
_L5R.Visible = false
_L5R.Media = zmediaTask
_L5R.Active = false
_L5R.Complete = false
_L5R.CorrectState = "None"
_w2qxK = Wherigo.ZTask(_To3S9)
_w2qxK.Id = "f878bb46-a5a1-478a-90d9-84258b32a62a"
_w2qxK.Name = _Q4b(" \015r!zu&\016\016fu\024fr\016fu\030bu]\015&!z")
_w2qxK.Description = ""
_w2qxK.Visible = false
_w2qxK.Media = zmediaTask
_w2qxK.Active = false
_w2qxK.Complete = false
_w2qxK.CorrectState = "None"
_9QFj = Wherigo.ZTask(_To3S9)
_9QFj.Id = "aaddf73f-a5d9-49f4-b7da-c333a4e3df57"
_9QFj.Name = _Q4b("\031f\\fu\030b\015b\028\005u\030b\015ut\022FBb\015\030FBf\016\016fQ")
_9QFj.Description = ""
_9QFj.Visible = false
_9QFj.Media = zmediaTask
_9QFj.Active = false
_9QFj.Complete = false
_9QFj.CorrectState = "None"
_FaC = Wherigo.ZTask(_To3S9)
_FaC.Id = "0aa93122-6972-45d5-8c0d-fd56a70d14af"
_FaC.Name = _Q4b("lb!\005u\027&Fu\v&b7F\028\\rSSur!u\027f\015uV7\016&bS\022&\\!u&!")
_FaC.Description = _Q4b("D&FBu\027bu\027fr!ulb!\005zf\015&Bu&bFu\027fr!f7utbBRu\022f\005R77f!5uDrf\0157rBu\015bSf!u:rfu\027&Fut\016rf!\006\v&b7F\028\\rSSur7u\f\015\022rBu&!Mub7u,frBf\015fut!,frFb!zf!u\030buf\015\\&\016Bf!w")
_FaC.Visible = false
_FaC.Media = zmediaTask
_FaC.Active = false
_FaC.Complete = false
_FaC.CorrectState = "None"
_wz9dS = Wherigo.ZTask(_To3S9)
_wz9dS.Id = "3b83c404-e7d9-464d-8523-a2c372d6a83a"
_wz9dS.Name = _Q4b("lr!\027fu\017R\027fu9")
_wz9dS.Description = _Q4b("\031f\\fu\030bu\027f7u&!zfzf\022f!f!u\f\015Bub!\027u\\R\016fun!\022F$6\027rfuf\015FBfu\031f\\fr7\030&\\\016w")
_wz9dS.Visible = false
_wz9dS.Media = zmediaTask
_wz9dS.Active = false
_wz9dS.Complete = false
_wz9dS.CorrectState = "None"
__snG = Wherigo.ZTask(_To3S9)
__snG.Id = "b62defa5-c656-45a9-87fd-61ebddeae212"
__snG.Name = _Q4b("lr!\027fu\017R\027fu\t")
__snG.Description = _Q4b("\031f\\fu\030bu\027f7u&!zfzf\022f!f!u\f\015Bub!\027u\\R\016fun!\022F$6\027rfu\030,frBfu\031f\\fr7\030&\\\016w")
__snG.Visible = false
__snG.Media = zmediaTask
__snG.Active = false
__snG.Complete = false
__snG.CorrectState = "None"
_2Pv0 = Wherigo.ZTask(_To3S9)
_2Pv0.Id = "a3deee95-4693-4ccc-b8cf-ff4c229104b8"
_2Pv0.Name = _Q4b("\031f\\fu\030b7u\031fR\028&\028\\f")
_2Pv0.Description = _Q4b("\031f\\fu\030b7u\031fR\028&\028\\fQQQ")
_2Pv0.Visible = false
_2Pv0.Media = zmediaTask
_2Pv0.Active = false
_2Pv0.Complete = false
_2Pv0.CorrectState = "None"
_Bp5rd = _Q4b("\bfF\005BR$")
_q5RiJ = false
_q8av = false
_3d5 = _Q4b(":\024\f~")
_2_ux = _Q4b(":\024\f~")
_c3bI = false
_vGr = false
_qglYz = 7678
_dwJ = ""
_DcrGm = false
_Xren = false
_pK5G = 0
_z4i2n = false
_0qUpi = false
_PVL = false
_AE6F = 0
_vZbFd = _Q4b("{a,t\024")
_dgaH = _Q4b("{lF]0")
_sEU = _Q4b("{4Z\016]\a")
_nTN = _Q4b("{!\fNSS")
_ebW9 = _Q4b("{\024aBa")
_1f_ = _Q4b("\027b77Z")
_To3S9.ZVariables = {
  _Bp5rd = _Q4b("\bfF\005BR$"),
  _q5RiJ = false,
  _q8av = false,
  _3d5 = _Q4b(":\024\f~"),
  _2_ux = _Q4b(":\024\f~"),
  _c3bI = false,
  _vGr = false,
  _qglYz = 7678,
  _dwJ = "",
  _DcrGm = false,
  _Xren = false,
  _pK5G = 0,
  _z4i2n = false,
  _0qUpi = false,
  _PVL = false,
  _AE6F = 0,
  _vZbFd = _Q4b("{a,t\024"),
  _dgaH = _Q4b("{lF]0"),
  _sEU = _Q4b("{4Z\016]\a"),
  _nTN = _Q4b("{!\fNSS"),
  _ebW9 = _Q4b("{\024aBa"),
  _1f_ = _Q4b("\027b77Z")
}
_TNtN = Wherigo.ZInput(_To3S9)
_TNtN.Id = "a4bb5ad2-44ac-4025-86e1-337333411ee4"
_TNtN.Name = _Q4b("`ZFBf\015Zu\017R\027fu9")
_TNtN.Description = ""
_TNtN.Visible = true
_TNtN.InputType = "Text"
_TNtN.Text = _Q4b("\031f\022fu\bfr!f!u\017R\027fufr!")
_jdd = Wherigo.ZInput(_To3S9)
_jdd.Id = "f82df873-72c5-4f89-921d-99cc34ffca70"
_jdd.Name = _Q4b("`ZFBf\015Zu\017R\027fu\t")
_jdd.Description = ""
_jdd.Visible = true
_jdd.InputType = "Text"
_jdd.Text = _Q4b("\031f\022fu\bfr!f!u\017R\027fufr!")
function _To3S9:OnStart()
  if _G[_Q4b("N!\025")][_Q4b("~\016&BSR\0157")] == _Q4b("\127r!)\t") or _G[_Q4b("N!\025")][_Q4b("\bf\025r\028f'\b")] == _Q4b("\bfF\005BR$") then
    for k, v in pairs(_G[_Q4b("{\024R):\018")][_Q4b("t\016\0162\f\022Tf\028BF")]) do
      v[_Q4b("ArFr\022\016f")] = false
      v[_Q4b("t\028Br\025f")] = false
    end
    _G[_Q4b("\127\\f\015rzR")][_Q4b("\017R77&!\027")](_Q4b(":&\025f\017\016RFf"))
    return
  end
  _dwJ = Env.DeviceID
end
function _To3S9:OnRestore()
end
function _k_e:OnEnter()
  _vZbFd = _Q4b("{\005{f")
  _DcrGm = true
  if _PVL == false then
    _Urwigo.MessageBox({
      Text = _Q4b(":rfu\\&\022f!u\027rfut\022FBb\015\030FBf\016\016fuf\015\015fr\028\\Bwu:rfuFf\\f!uFr\028\\uFf\\\015u\025R\015Fr\028\\Brzub7wuNr!uFf\016BF&7f\015u\031f\015b\028\\u\016rfzBur!u\027f\015u\abSBw"),
      Media = zmediaMap,
      Callback = function(action)
        if action ~= nil then
          _PVL = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          _To3S9:RequestSync()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b(":rfu\022fSr!\027f!uFr\028\\u&!u\027f\015ut\022FBb\015\030FBf\016\016fu\025R7u\v&b7F\028\\rSSw"),
      Media = zmediaMap,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          _To3S9:RequestSync()
        end
      end
    })
  end
end
function _k_e:OnExit()
  _vZbFd = _Q4b("{\005{f")
  _DcrGm = false
end
function _2KH0:OnEnter()
  _vZbFd = _Q4b("{\t]D%")
  _Urwigo.MessageBox({
    Text = _Q4b(":rfu\\&\022f!u\027f!u f\015fr\028\\uf\015\015fr\028\\BMur!u\027f7uFr\028\\ufr!fFu\027f\015u\025f\015\016R\015f!f!u\024fr\016fu\022fSr!\027f!uFR\016\016Bfwu:\028\\&bf!u,r\015ub!Fub7w"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function zoneShipPart2:OnEnter()
  _vZbFd = _Q4b("\030R!f:\\r$~&\015B\t")
  _Urwigo.MessageBox({
    Text = _Q4b(":rfu\\&\022f!u\027f!u f\015fr\028\\uf\015\015fr\028\\BMur!u\027f7uFr\028\\ufr!fFu\027f\015u\025f\015\016R\015f!f!u\024fr\016fu\022fSr!\027f!uFR\016\016wu:\028\\&bf!u,r\015ub!Fub7w"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function _8Fp7:OnEnter()
  _vZbFd = _Q4b("{Wl$E")
  _Urwigo.MessageBox({
    Text = _Q4b(":rfu\\&\022f!u\027f!u f\015fr\028\\uf\015\015fr\028\\BMur!u\027f7uFr\028\\ufr!fFu\027f\015u\025f\015\016R\015f!f!u\024fr\016fu\022fSr!\027f!uFR\016\016wu:\028\\&bf!u,r\015ub!Fub7w"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function _5Dk2l:OnEnter()
  _vZbFd = _Q4b("{=\b\005\t\016")
  _Urwigo.MessageBox({
    Text = _Q4b("Drf\015uSr!\027f!u:rfu\027f!ul\016bX\005R!\027f!F&BR\015w"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        _vGr = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function _5Dk2l:OnExit()
  _vZbFd = _Q4b("{=\b\005\t\016")
  _vGr = false
end
function _mnH:OnEnter()
  _vZbFd = _Q4b("{7!D")
  _Urwigo.MessageBox({
    Text = _Q4b(":\028\\&bf!u:rfuFr\028\\ub7uwwwu'\015zf!\027,RuFR\016\016Bf!u:rfufr!fu\127R\015Bu\026,frFFx\015RBPuFf\\f!uwww"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        _xA__:MoveTo(_mnH)
        _q5RiJ = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function _ZEVP:OnEnter()
  _vZbFd = _Q4b("{2NA~")
  _KcBjY.Visible = true
  _KcBjY:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _Q4b("l&FBuzfF\028\\&SSBwuNr!u:$Rr\016f\015\022r\016\027urFBu!r\028\\Bu!RB,f!\027rzw"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function _Qjc5g:OnEnter()
  _vZbFd = _Q4b("{IT\028=z")
  _Urwigo.MessageBox({
    Text = _Q4b(":\028\\&bf!u:rfuFr\028\\ub7uwwwu'\015zf!\027,RuFR\016\016Bf!u:rfufr!fu\025rf\015FBf\016\016rzfu2&\\\016uFf\\f!uwww"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        _xA__:MoveTo(_Qjc5g)
        _Xren = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        _To3S9:RequestSync()
      end
    end
  })
end
function _TNtN:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _2_ux = input
  if Wherigo.NoCaseEquals(_3d5, _2_ux) then
    _NwAT.Active = false
    _k_e.Active = false
    _mnH.Active = false
    _NwAT.Visible = false
    _k_e.Visible = false
    _mnH.Visible = false
    _wz9dS.Complete = true
    _wz9dS.Visible = false
    _wz9dS.Active = false
    _Urwigo.MessageBox({
      Text = _Q4b(" ffr!\027\015b\028\005f!\027QQQuNFurFBu\027R$$f\016Bu\028R\027rf\015BQu'\028\\u\022\015&b\028\\fufr!f!u\030,frBf!u\v&BFf\016\028R\027fMub7u\027rfFfu\017\\rSS\015fu\030bu\005!&\028\005f!Qu\031bBMu\027&FFur\028\\u,fr?Mu,Ru:rfufFuSr!\027f!u\005R!!f!Qu'\028\\u\016&\027fu\027rfu]RR\015\027r!&Bf!u&bSu'\\\015u\031f\015&Bu\\R\028\\Qulr!\027fu\027rfu\030,frBfu\031f\\fr7\030&\\\016Qu\127f!!u:rfu\027f!u\017R\027fuSr!\027f!Mu\015bSf!u:rfu7r\028\\u\030b\015b\028\005Q"),
      Media = zmediaSpaceCraftinOrbit,
      Callback = function(action)
        if action ~= nil then
          _Qjc5g.Visible = true
          _Qjc5g.Active = true
          __snG.Active = true
          __snG.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("aN'aQu\b'N:N:u\127\f\v\024u':\024ua'\017D\024u\v'\017D\024'\031QuAN\v:V\017DuN:ua\f\017DuN'a`t\aQ"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_TNtN)
          end)
        end
      end
    })
  end
end
function _jdd:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _AE6F = tonumber(input)
  if _qglYz == _AE6F then
    _Urwigo.MessageBox({
      Text = _Q4b("\014b$ffuQQQuNFuSb!\005BrR!rf\015BfQu\b&Fu\v&BFf\016urFBuzf\016RFBQu'\028\\u\016&\027fu\027rfuf!\027zb\016Brzf!u]RR\015\027r!&Bf!u&bSu'\\\015u\031f\015&Bu\\R\028\\QuV\022f\015$\015bSf!u:rfu'\\\015u'!\025f!B&\015QuArf\016u\031\016b\028\005MuN\015\027\016r!zQ"),
      Media = zmediaSpaceCraftinOrbit,
      Callback = function(action)
        if action ~= nil then
          _cEw:MoveTo(Player)
          __snG.Complete = true
          __snG.Visible = false
          __snG.Active = false
          _2Pv0.Active = true
          _2Pv0.Visible = true
          _cEw.Visible = true
          _Qjc5g.Active = false
          _Qjc5g.Visible = false
          _6mSV1:MoveTo(nil)
          _gDc:MoveTo(nil)
          __rp9:MoveTo(nil)
          _NyVrD:MoveTo(nil)
          _ZEVP.Active = true
          _ZEVP.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("aN'aQu\b'N:NuaV``N\vu':\024ua'\017D\024u\v'\017D\024'\031QuAN\v:V\017DuN:ua\f\017DuN'a`t\aQ"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_jdd)
          end)
        end
      end
    })
  end
end
function _FsKq:On_vcx(target)
  _bze.Complete = true
  _bze.Visible = false
  _wWUA.Active = true
  _wWUA.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _Q4b("D&\016\016RuN\015\027\016r!zQu'\028\\u\022r!u]\015&B\\u\025R7ut\028\\f\015R!\006:ZFBf7Qu'\028\\u\005R77fur!ul\015rf\027f!www"),
      Media = zmediaAlienGeocacher
    },
    {
      Text = _Q4b("D\\\\&\016\016RQu'\028\\u\022\022\022r!u\aRbrF"),
      Media = zmediaGeocacher
    },
    {
      Text = _Q4b(":\028\\R!u\027r\028\\u\030buB\015fSSf!wu'\028\\u\022\015&b\028\\fuDr\016Sf"),
      Media = zmediaAlienGeocacher
    },
    {
      Text = _Q4b("\127&\015b7Mu,&FurFBu$&FFrf\015B5"),
      Media = zmediaGeocacher
    },
    {
      Text = _Q4b("`fr!u]R\016\016fzfu\006u]\015&!zurFBufr!uFf\\\015uzbBf\015u`f\028\\&!r\005f\015Mu&\022f\015ufr!u7rfFf\015u~r\016RBuwwwu]b\015\030Mu\\fbBfurFBuf\015u\\rf\015uzfzf!u\027rfu &b7fuzf\005\015&\028\\Bub!\027u,r\015u\\&\022f!ufr!rzfu\024fr\016fub!Ff\015fFu:\028\\rSSfFu\025f\015\016R\015f!wu4fB\030Bu7bFFf!u,r\015u!&\028\\ur\\!f!uFb\028\\f!wu\127r\015FBu\027bub!Fu\\f\016Sf!5"),
      Media = zmediaAlienGeocacher
    },
    {
      Text = _Q4b("a&Bb\015\016r\028\\u,f\015\027fur\028\\Qut\022f\015u\027f\015u~&\015\005$\016&B\030urFBu\015rfFrzMu,rfu\005R!!f!u,r\015u\027rfFfu\024fr\016fuSr!\027f!5"),
      Media = zmediaGeocacher
    },
    {
      Text = _Q4b("'\028\\u\\&\022fufr!fu'\027ffMu,RuFrfuFfr!u\005R!!Bf!uwwwu\031r\022u7r\015u\027fr!fu]&\015BfMur\028\\u\030frzfu\027r\015u\027rfu]RR\015\027r!&Bf!w"),
      Media = zmediaAlienGeocacher
    },
    {
      Text = _Q4b("a&u\027&FurFBu\027R\028\\ufr!u]r!\027f\015F$rf\016Qu\bbu\022\016fr\022FBu\\rf\015u\025f\015FBf\028\005BQu]fr!f\015uFR\016\016Bfu\027r\028\\uFf\\f!Qu'\028\\u,f\015\027fuF\028\\!f\016\016u\016&bSf!ub!\027u\027rfu\024fr\016fuSb\015u\027r\028\\u\\R\016f!uQQQ"),
      Media = zmediaGeocacher
    }
  }, function(action)
    _bze.Visible = false
    _FsKq.Visible = false
    _2KH0.Active = true
    _2KH0.Visible = true
    zoneShipPart2.Active = true
    zoneShipPart2.Visible = true
    _8Fp7.Active = true
    _8Fp7.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _UMX_Z:On_DGoS_(target)
  if not _UMX_Z:Contains(_QiPkT) or not _UMX_Z:Contains(_2niuW) or not _UMX_Z:Contains(_tTPk) then
    _Urwigo.MessageBox({
      Text = _Q4b("D&\022f!u:rfu&\016\016fu\027\015fruSf\\\016f!\027f!u\024fr\016fuzfSb!\027f!5u\031r\022uFrfu7r\015Q"),
      Media = zmediaAlienMechanic,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
        end
      end
    })
  else
    _Urwigo.Dialog(false, {
      {
        Text = _Q4b("\bbu\\&FBufr!f!uBR\016\016f!u4R\022uzf7&\028\\BQuab\015uwwwufFuzr\022Bufr!u&!\027f\015fFu~\015R\022\016f7wu\127r\015u\025f\0157rFFf!ub!Ff\015f!ul\016bX\005R!\027f!F&BR\015wu\brfuzbBfua&\028\\\015r\028\\BurFBMu\027&FFur\028\\uFfr!fu]RR\015\027r!&Bf!u&\022zfS&!zf!u\\&\022fwu\127r\015FBu\027bufFuSb\015u7r\028\\u,rf\027f\015\022fF\028\\&SSf!5"),
        Media = zmediaAlienMechanic
      },
      {
        Text = _Q4b("t\022f\015u!&Bb\015\016r\028\\Qu\031r\022u7r\015u\027rfu]RR\015\027r!&Bf!Q"),
        Media = zmediaGeocacher
      },
      {
        Text = _Q4b("Drf\015uwwwu&\022f\015u,&\015Bfu7&\016Qu\127f!!u\027f\015ul\016bFF\005R!\027f!F&BR\015u!R\028\\u\022fB\015rf\022F\022f\015frBurFBMu\005&!!u\027rfuD&!\027\\&\022b!zuzfS&\\\015\016r\028\\uFfr!wu:rfu7bFFf!ufFu\030bf\015FBu&bFF\028\\&\016Bf!uQQQ"),
        Media = zmediaAlienMechanic
      },
      {
        Text = _Q4b("\127rfu7&\028\\fur\028\\u\027&F5"),
        Media = zmediaGeocacher
      },
      {
        Text = _Q4b("af\\7f!u:rfu7fr!u:$f\030r&\016,f\015\005\030fbzub!\027uF\028\\&\016Bf!u:rfu\027&7rBu\027f!ul\016bFF\005R!\027f!F&BR\015u&bFw"),
        Media = zmediaAlienMechanic
      }
    }, function(action)
      _plAh.Visible = true
      _w2qxK.Visible = false
      _w2qxK.Complete = true
      _L5R.Visible = true
      _UMX_Z.Commands._DGoS_.Enabled = false
      _5Dk2l.Active = true
      _5Dk2l.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _DAOw1:On_a4XCw(target)
  if not _DAOw1:Contains(zitemDisabledFluxCapacitor) then
    _Urwigo.MessageBox({
      Text = _Q4b("`fr!u`f\028\\&!r\005f\015urFBuS&FBuSf\015BrzwuN\015u7bFFu!b\015u\027f!ul\016bX\005R!\027f!F&BR\015u\015f$&\015rf\015f!wuD&FBu\027bufFuzfSb!\027f!5"),
      Media = zmediaAlienGeocacher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
        end
      end
    })
  else
    _Urwigo.Dialog(false, {
      {
        Text = _Q4b(":rfu\\&\022f!ufr!f!uBR\016\016f!u4R\022uzf7&\028\\BMu]b7$f\016Qu'\028\\u,fr?u!r\028\\BMu,rfur\028\\u\027r\028\\uSb\015u\027fr!fu f7b\\b!zf!u\022f\016R\\!f!uFR\016\016uwww"),
        Media = zmediaAlienGeocacher
      },
      {
        Text = _Q4b("ab!MufFu,&\015u,r\015\005\016r\028\\u!r\028\\BuF\028\\,f\015wu'\028\\u\022r!uS\015R\\Mu\027&FFur\028\\u\\f\016Sf!u\005R!!BfQ"),
        Media = zmediaGeocacher
      },
      {
        Text = _Q4b("\127&\015BfQu'\028\\u,fr?u,&Fu\030buBb!urFBQu'\028\\uzf\022fu\br\015u]RR\015\027r!&Bf!uSb\015ufr!fu f\016R\\!b!z"),
        Media = zmediaAlienGeocacher
      },
      {
        Text = _Q4b("\127R,Qu'\028\\u\027&!\005fu\027r\015uFf\\\015Qu"),
        Media = zmediaGeocacher
      },
      {
        Text = _Q4b("'\028\\u\005&!!u'\\!f!u\027rfu]RR\015\027r!&Bf!uzf\022f!Mu&\022f\015ur\028\\u\022\015&b\028\\fufr!f!u\031f\\fr7\028R\027fwuV7u\027f!u\017R\027fu\030bu\025f\015&\015\022frBf!Mu7bFFf!u,r\015ub!Fur!u\027rfu$\016&!fB&\015fuV7\016&bS\022&\\!u\022fzf\022f!Mu\027&u,r\015u\\rf\015u\005fr!fuAf\015\022r!\027b!zu\030b7u`&r!S\015&7f\006\017R7$bBf\015ub!Ff\015fFu:ZFBf7Fu\\&\022f!wu\f]MuTfB\030Bu\\f\022f!u,r\015u&\022ub!\027u,f\015\027f!u$f\015ulb!\005u\005R77b!r\030rf\015f!w* \v/* \v/"),
        Media = zmediaAlienGeocacher
      },
      {
        Text = _Q4b("tbSu\127rf\027f\015Ff\\f!Mu7fr!u&b?f\015r\015\027rF\028\\f\015ul\015fb!\027Qu'\028\\u\\RSSfMu,r\015uFf\\f!ub!Fufr!fFu\024&zfFu,rf\027f\015Q"),
        Media = zmediaGeocacher
      },
      {
        Text = _Q4b("Drf\015Mu!r77u7fr!f!u&b?f\015r\015\027rF\028\\f!u:\127t\031Qu\af\022f,R\\\016MuN\015\027\016r!zQ"),
        Media = zmediaAlienGeocacher
      }
    }, function(action)
      _9QFj.Complete = true
      _9QFj.Visible = false
      _DAOw1.Visible = false
      _xA__:MoveTo(_k_e)
      _xA__.Visible = true
      _PYaG.Visible = true
      _PYaG:MoveTo(Player)
      _FaC.Visible = true
      _FaC.Active = true
      _q8av = true
      Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
    end)
  end
end
function _JylKL:On_Qj1(target)
  _Urwigo.MessageBox({
    Text = _Q4b("\bfr!uzbBfFu&\016BfFutbBRur77f\015!R\028\\u\030b\025f\015\016&FFrz"),
    Media = zmediaCar,
    Callback = function(action)
      if action ~= nil then
        _6mSV1.Visible = true
        _gDc.Visible = true
        __rp9.Visible = true
        _nOEff.Active = true
        _nOEff.Visible = true
        _NyVrD.Commands._7NN.Enabled = true
        _JylKL.Commands._Qj1.Enabled = false
        Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
      end
    end
  })
end
function _6mSV1:On_mOY(target)
  if not Player:Contains(_6mSV1) then
    _Urwigo.MessageBox({
      Text = _Q4b("'\\\015fut\015\022frBF\\&!\027F\028\\b\\fwu:f\\\015u!bB\030\016r\028\\"),
      Media = zmediaGloves,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _6mSV1:MoveTo(Player)
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          end
        end
      end
    })
  elseif _0qUpi == false then
    _Urwigo.MessageBox({
      Text = _Q4b("'\\\015fut\015\022frBF\\&!\027F\028\\b\\fwu:f\\\015u!bB\030\016r\028\\"),
      Media = zmediaGloves,
      Buttons = {
        _Q4b("~V\024u\fa"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _0qUpi = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          elseif action == "Button2" then
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("'\\\015fut\015\022frBF\\&!\027F\028\\b\\fwu:f\\\015u!bB\030\016r\028\\"),
      Media = zmediaGloves,
      Buttons = {
        _Q4b("\024t]Nu\fll"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _0qUpi = false
          elseif action == "Button2" then
          end
        end
      end
    })
  end
end
function _gDc:On_85pDb(target)
  if not Player:Contains(_gDc) then
    _Urwigo.MessageBox({
      Text = _Q4b("Nr!uB\015&z\022&\015fFulb!\005zf\015&Bwu:rfu\005R!!f!ufFu\025f\015,f!\027f!Mub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030buF$\015f\028\\f!w"),
      Media = zmediaWalkieTalkie,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _gDc:MoveTo(Player)
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          else
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          end
        end
      end
    })
  elseif _q8av == true then
    if _wz9dS.Active then
      if _q5RiJ == true then
        _Urwigo.MessageBox({
          Text = _Q4b("'\\\015uB\015&z\022&\015fFulb!\005zf\015&BwuAf\015,f!\027f!u:rfufFMub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030bu\005R77b!r\030rf\015f!wu"),
          Media = zmediaWalkieTalkie,
          Buttons = {
            _Q4b("\017t\a\au]\vt\024D"),
            _Q4b("a\f\024ua\f\127")
          },
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _Q4b("D&FBu\027bu\027&Fu\127\f\v\024uzfSb!\027f!5"),
                Media = zmediaSpaceCraftinOrbit,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_TNtN)
                    end)
                  end
                end
              })
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = _Q4b("'\\\015uB\015&z\022&\015fFulb!\005zf\015&BwuAf\015,f!\027f!u:rfufFMub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030bu\005R77b!r\030rf\015f!wu\vbSf!u:rfu]\015&B\\u\030b\015b\028\005Mu,f!!u:rfu\027&Fu\127\f\v\024uzfSb!\027f!u\\&\022f!w"),
          Media = zmediaWalkieTalkie
        })
      end
    elseif __snG.Active then
      if _Xren == true then
        _Urwigo.MessageBox({
          Text = _Q4b("'\\\015uB\015&z\022&\015fFulb!\005zf\015&BwuAf\015,f!\027f!u:rfufFMub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030bu\005R77b!r\030rf\015f!wu"),
          Media = zmediaWalkieTalkie,
          Buttons = {
            _Q4b("\017t\a\au]\vt\024D"),
            _Q4b("a\f\024ua\f\127")
          },
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _Q4b("D&FBu\027bu\027rfu\030,frBfu\031f\\fr7!b77f\015uzfSb!\027f!5u\026pFBf\016\016rzP"),
                Media = zmediaSpaceCraftinOrbit,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_jdd)
                    end)
                  end
                end
              })
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = _Q4b("'\\\015uB\015&z\022&\015fFulb!\005zf\015&BwuAf\015,f!\027f!u:rfufFMub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030bu\005R77b!r\030rf\015f!wu\vbSf!u:rfu]\015&B\\u\030b\015b\028\005Mu,f!!u:rfu\027rfu\030,frBfu\031f\\fr7!b77f\015uzfSb!\027f!u\\&\022f!w"),
          Media = zmediaWalkieTalkie
        })
      end
    else
      _Urwigo.MessageBox({
        Text = _Q4b("Nr!uB\015&z\022&\015fFulb!\005zf\015&Bwu:rfu\005R!!f!ufFu\025f\015,f!\027f!Mub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030buF$\015f\028\\f!w"),
        Media = zmediaWalkieTalkie,
        Buttons = {
          _Q4b("\017t\a\au]\vt\024D"),
          _Q4b("a\f\024ua\f\127")
        },
        Callback = function(action)
          if action ~= nil then
            _wz9dS.Visible = true
            _wz9dS.Active = true
            _Urwigo.Dialog(false, {
              {
                Text = _Q4b(" \030\030\030\030BuwwwuDRf\015FBu\027bu7r\028\\uN\015\027\016r!z5"),
                Media = zmediaAlienGeocacher
              },
              {
                Text = _Q4b("\a&bBub!\027u\027fbB\016r\028\\Qul&\\\015fuSR\015BQ"),
                Media = zmediaGeocacher
              },
              {
                Text = _Q4b("\031bBQu'\028\\u\016&\027fu\027rfu]RR\015\027r!&Bf!u\027fFu\f\015BfFMu&!u\027f7u:rfu\027f!u`ZFBf\015Zu\017R\027fu\026\127\f\v\024PuSr!\027f!Mu&bSu'\\\015u\031f\015&Bu\\R\028\\wu\127f!!u:rfu\027f!u\017R\027fuSr!\027f!Mu\015bSf!u:rfu7r\028\\u\030b\015b\028\005Q"),
                Media = zmediaAlienGeocacher
              }
            }, function(action)
              _mnH.Active = true
              _mnH.Visible = true
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          end
        end
      })
    end
  else
    _Urwigo.MessageBox({
      Text = _Q4b("Nr!uB\015&z\022&\015fFulb!\005zf\015&Bwu:rfu\005R!!f!ufFu\025f\015,f!\027f!Mub7u7rBu&!\027f\015f!ulb!\005\022fB\015fr\022f\015!u\030buF$\015f\028\\f!w"),
      Media = zmediaWalkieTalkie
    })
  end
end
function __rp9:On_AR57(target)
  if not Player:Contains(__rp9) then
    _Urwigo.MessageBox({
      Text = _Q4b("\bfr!fu:R!!f!\022\015r\016\016fwu\127f!!u:rfuFrfuB\015&zf!Mu,f\015\027f!u'\\\015futbzf!uzfF\028\\bB\030Bw"),
      Media = zmediaSunglasses,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            __rp9:MoveTo(Player)
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          end
        end
      end
    })
  elseif _c3bI == false then
    _Urwigo.MessageBox({
      Text = _Q4b("'\\\015fu:R!!f!\022\015r\016\016fuF\028\\bB\030Bu'\\\015futbzf!u\025R\015u\027f7u\\f\016\016f!u:R!!f!\016r\028\\Bw"),
      Media = zmediaSunglasses,
      Buttons = {
        _Q4b("~V\024u\fa"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _c3bI = true
          elseif action == "Button2" then
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("`rBu\027fr!f\015u:R!!f!\022\015r\016\016fuFrf\\FBu\027buFf\\\015u\028RR\016u&bFwuV!\027u\027fr!futbzf!uFr!\027uzfF\028\\bB\030Bw"),
      Media = zmediaSunglasses,
      Buttons = {
        _Q4b("\024t]Nu\fll"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _c3bI = false
          elseif action == "Button2" then
          end
        end
      end
    })
  end
end
function _b1i:On_GBOec(target)
  _Urwigo.MessageBox({
    Text = _Q4b(":rfuFBf\\f!u\015&B\016RFuQQQu\br\015f\005Bu\025R\015u'\\\015f!utbzf!u\022fSr!\027fBuFr\028\\ufr!u\005\016fr!fFu&b?f\015r\015\027rF\028\\fFu\v&b7F\028\\rSSQu:rfuFr!\027uSb\015ufr!u$&&\015u`r!bBf!u\022f,fzb!zF\016RFwu\b&!!u\\R\015Bu7&!u$\016RB\030\016r\028\\ufr!u\016frFfFu2rF\028\\f!u\025R!u\\r!Bf!w* \v/\006uDfZuN\015\027\016r!zQ* \v/\bbu\027\015f\\FBu\027r\028\\u\016&!zF&7ub7Mu\027&Fu \016bBur!u\027fr!f!ut\027f\015!uzfS\015rf\015BQ"),
    Media = zmediaFlyingSaucer,
    Callback = function(action)
      if action ~= nil then
        _FsKq.Visible = true
        _b1i.Visible = false
        _bze.Visible = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _QiPkT:On_wtN(target)
  if not Player:Contains(_QiPkT) then
    _Urwigo.MessageBox({
      Text = _Q4b(":f\016BF&7u&bFFf\\f!\027fFu\024fr\016Qu\bfSr!rBr\025u!r\028\\Bu\025R!u\\rf\015wuNFu7bFFu\027f\015uSf\\\016f!\027fu\024fr\016uFfr!Q"),
      Media = zmediaSpaceshipPart1,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _QiPkT:MoveTo(Player)
            _pK5G = _pK5G + 1
            _2KH0.Visible = false
            _2KH0.Active = false
            if _pK5G == 3 then
              _Urwigo.MessageBox({
                Text = _Q4b(":rfu\\&\022f!u&\016\016fu\027\015fruSf\\\016f!\027f!u\024fr\016fuzfSb!\027f!wu \015r!zuFrfu\030bu]\015&!zMu\027f7u`f\028\\&!r\005f\015w"),
                Media = zmediaTask,
                Callback = function(action)
                  if action ~= nil then
                    _w2qxK.Active = true
                    _w2qxK.Visible = true
                    _wWUA.Visible = false
                    _wWUA.Complete = true
                    _UMX_Z.Visible = true
                    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                  end
                end
              })
            else
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif _DcrGm == true then
    _Urwigo.MessageBox({
      Text = _Q4b("Af\015\016R\015f!fFu\v&b7F\028\\rSSBfr\016w"),
      Media = zmediaSpaceshipPart1,
      Buttons = {
        _Q4b("\031'ANu\024\fu]\vta\031"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _QiPkT:MoveTo(_UMX_Z)
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("Nr!fFu\027f\015u\025f\015\016R\015f!f!u\v&b7F\028\\rSSBfr\016fw"),
      Media = zmediaSpaceshipPart1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _2niuW:On_8VuA(target)
  if not Player:Contains(_2niuW) then
    _Urwigo.MessageBox({
      Text = _Q4b(":f\016BF&7u&bFFf\\f!\027fFu\024fr\016QutbSuTf\027f!ul&\016\016uS\015f7\027f\015uDf\015\005b!SBwuNFu7bFFu\027f\015uSf\\\016f!\027fu\024fr\016uFfr!Q"),
      Media = zmediaSpaceshipPart2,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" and _0qUpi == true then
            _2niuW:MoveTo(Player)
            _pK5G = _pK5G + 1
            zoneShipPart2.Visible = false
            zoneShipPart2.Active = false
            if _pK5G == 3 then
              _Urwigo.MessageBox({
                Text = _Q4b(":rfu\\&\022f!u&\016\016fu\027\015fruSf\\\016f!\027f!u\024fr\016fuzfSb!\027f!wu \015r!zuFrfu\030bu]\015&!zMu\027f7u`f\028\\&!r\005f\015w"),
                Media = zmediaTask,
                Callback = function(action)
                  if action ~= nil then
                    _w2qxK.Active = true
                    _w2qxK.Visible = true
                    _wWUA.Visible = false
                    _wWUA.Complete = true
                    _UMX_Z.Visible = true
                    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                  end
                end
              })
            else
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          elseif action == "Button1" and _0qUpi == false then
            _Urwigo.MessageBox({
              Text = _Q4b(" ffr!\027\015b\028\005f!\027Qu\b&Fu\br!zuFrf\\Bu\\fr?u&bFQu:rfu\005R!!Bf!uFr\028\\u\027rfuD&!\027fu\025f\015\022\015f!!f!uQQQu\bbu\\&FBu\027fr!fut\015\022frBF\\&!\027F\028\\b\\fur!u\027fr!f7utbBRMuR\027f\0155"),
              Media = zmediaSpaceshipPart2,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
                end
              end
            })
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif _DcrGm == true then
    _Urwigo.MessageBox({
      Text = _Q4b("Af\015\016R\015f!fFu\v&b7F\028\\rSSBfr\016w"),
      Media = zmediaSpaceshipPart2,
      Buttons = {
        _Q4b("\031'ANu\024\fu]\vta\031"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _2niuW:MoveTo(_UMX_Z)
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("Nr!fFu\027f\015u\025f\015\016R\015f!f!u\v&b7F\028\\rSSBfr\016fw"),
      Media = zmediaSpaceshipPart2
    })
  end
end
function _tTPk:On_vuw(target)
  if not Player:Contains(_tTPk) then
    _Urwigo.MessageBox({
      Text = _Q4b(":f\016BF&7u&bFFf\\f!\027fFu\024fr\016Qu\bfSr!rBr\025u!r\028\\Bu\025R!u\\rf\015wuNFu7bFFu\027&FuSf\\\016f!\027fu\024fr\016uFfr!Q"),
      Media = zmediaSpaceshipPart3,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _tTPk:MoveTo(Player)
            _pK5G = _pK5G + 1
            _8Fp7.Visible = false
            _8Fp7.Active = false
            if _pK5G == 3 then
              _Urwigo.MessageBox({
                Text = _Q4b(":rfu\\&\022f!u&\016\016fu\027\015fruSf\\\016f!\027f!u\024fr\016fuzfSb!\027f!wu \015r!zuFrfu\030bu]\015&!zMu\027f7u`f\028\\&!r\005f\015w"),
                Media = zmediaTask,
                Callback = function(action)
                  if action ~= nil then
                    _w2qxK.Active = true
                    _w2qxK.Visible = true
                    _wWUA.Visible = false
                    _wWUA.Complete = true
                    _UMX_Z.Visible = true
                    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                  end
                end
              })
            else
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
          end
        end
      end
    })
  elseif _DcrGm == true then
    _Urwigo.MessageBox({
      Text = _Q4b("Af\015\016R\015f!fFu\v&b7F\028\\rSSBfr\016w"),
      Media = zmediaSpaceshipPart3,
      Buttons = {
        _Q4b("\031'ANu\024\fu]\vta\031"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _tTPk:MoveTo(_UMX_Z)
          elseif action == "Button2" then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("Nr!fFu\027f\015u\025f\015\016R\015f!f!u\v&b7F\028\\rSSBfr\016fw"),
      Media = zmediaSpaceshipPart3
    })
  end
end
function _plAh:On_2Nfov(target)
  if not Player:Contains(_plAh) then
    _Urwigo.MessageBox({
      Text = _Q4b("Nr!uFf\\\015u$\015&\005BrF\028\\fFu`b\016Br\006\024RR\016Q"),
      Media = zmediaAlienMultiTool,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _plAh:MoveTo(Player)
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          elseif action == "Button2" then
          end
        end
      end
    })
  elseif _vGr == true and _c3bI == true then
    _Urwigo.MessageBox({
      Text = _Q4b("`rBu\027rfFf7ut\016rf!u`b\016Bru\024RR\016u\005R!!f!u:rfu\024\\ful\016bXu\017&$&\028rBR\015u\027f&\005Br\025rf\015f!"),
      Media = zmediaAlienMultiTool,
      Buttons = {
        _Q4b("V:Nu\024\f\f\a")
      },
      Callback = function(action)
        if action ~= nil then
          _xqo.Visible = false
          zitemDisabledFluxCapacitor.Visible = true
          _UMX_Z.Visible = false
          _DAOw1.Visible = true
          Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
        end
      end
    })
  elseif _vGr == true and _c3bI == false then
    _Urwigo.MessageBox({
      Text = _Q4b("\b&Fu\ar\028\\Bu\025R7ul\016bFF\005R!\027f!F&BR\015urFBu\030buFB&\015\005wu\bbu\005&!!FBu!r\028\\Bur!u\027rfua&\\fuzf\\f!Mu,fr\016u\027fr!futbzf!u,f\\uBb!w"),
      Media = zmediaAlienMultiTool
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b(":f\\\015u\\&!\027\016r\028\\fFut\016rf!u`b\016Bru\024RR\016wu:rfu\005R!!f!u\027&7rBu\025f\015F\028\\rf\027f!fut\015\022frBf!u&bFSb\\\015f!wu2w wufr!f!ul\016bFF\005R!\027f!F&BR\015u\027f&\005Br\025rf\015f!w"),
      Media = zmediaAlienMultiTool
    })
  end
end
function _xqo:On_YSY(target)
  _Urwigo.MessageBox({
    Text = _Q4b(":rfu\\&\022f!u\027f!ul\016bFF\005R!\027f!F&BR\015uzfSb!\027f!Mu&\022f\015uf\015urFBu!R\028\\u\022fB\015rf\022F\022f\015frBwu:rfu7bFFf!ur\\!uf\015FBu\027f&\005Br\025rf\015f!w"),
    Media = zmediaFluxCapacitorOn,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function zitemDisabledFluxCapacitor:On_4E5VN(target)
  if not Player:Contains(zitemDisabledFluxCapacitor) then
    _Urwigo.MessageBox({
      Text = _Q4b("4fB\030BurFBufFuFr\028\\f\015Mu\027f!ul\016bX\005R!\027f!F&BR\015u7rB\030b!f\\7f!w"),
      Media = zmediaFluxCapacitorOff,
      Buttons = {
        _Q4b("\024t]N"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            zitemDisabledFluxCapacitor:MoveTo(Player)
            _L5R.Complete = true
            _L5R.Visible = false
            _5Dk2l.Active = false
            _5Dk2l.Visible = false
            _9QFj.Visible = true
            _9QFj.Active = true
            _DAOw1.Visible = true
            _vGr = false
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          elseif action == "Button2" then
          end
        end
      end
    })
  elseif _DcrGm == true then
    _Urwigo.MessageBox({
      Text = _Q4b("\b&Fut\016rf!\006:\028\\rSSu\005&!!u!r\028\\BuR\\!fufr!f!ul\016bX\005R!\027f!F&BR\015u\016&bSf!w"),
      Media = zmediaFluxCapacitorOff,
      Buttons = {
        _Q4b("\031'ANu\024\fu]\vt\024D"),
        _Q4b("a\f\024ua\f\127")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            zitemDisabledFluxCapacitor:MoveTo(_DAOw1)
            _plAh:MoveTo(_DAOw1)
            Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
          elseif action == "Button2" then
          end
        end
      end
    })
  elseif _vGr == false then
    _Urwigo.MessageBox({
      Text = _Q4b("\bf&\005Br\025rf\015Bf\015ul\016bFF\005R!\027f!F&BR\015wu\brfut\016rf!Fu,f\015\027f!ufFu\022\015&b\028\\f!Mub7ur\\\015u:\028\\rSSu\030bu\015f$&\015rf\015f!w"),
      Media = zmediaFluxCapacitorOff
    })
  end
end
function _xA__:On_Vb8h(target)
  _Urwigo.MessageBox({
    Text = _Q4b("\b&Fu\v&b7F\028\\rSSu\022fSr!\027fBuFr\028\\ur!ufr!f\015u$\016&!fB&\015rF\028\\f!uV7\016&bS\022&\\!wu:rfu\005R!!f!u$f\015ulb!\005u\005R77b!r\030rf\015f!w"),
    Media = zmediaSpaceCraftinOrbit,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
      end
    end
  })
end
function _PYaG:On__3G_v(target)
  _Urwigo.MessageBox({
    Text = _Q4b("Nr!rzfuFf\\\015u!fBBfu&b?f\015r\015\027rF\028\\fu:\127t\031@FQ"),
    Media = zmediaAlienSWAG,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _cEw:On_IIyD(target)
  _wz9dS.Complete = true
  _FaC.Complete = true
  _wz9dS.Visible = false
  _FaC.Visible = false
  if Wherigo.NoCaseEquals(Env.DeviceID, _Q4b("\bfF\005BR$")) then
    _Urwigo.MessageBox({
      Text = _Q4b(":rfuF$rf\016f!ur!ufr!f7uN7b\016&BR\015wu\brfu]RR\015\027r!&Bf!u,f\015\027f!u!r\028\\Bu&!zf\030frzBuQQQ"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.Command("SaveClose")
        end
      end
    })
  elseif Wherigo.NoCaseEquals(Env.DeviceID, _Q4b(",f\022,,rzR")) then
    _Urwigo.MessageBox({
      Text = _Q4b(":rfuF$rf\016f!ur!ufr!f7uN7b\016&BR\015wu\brfu]RR\015\027r!&Bf!u,f\015\027f!u!r\028\\Bu&!zf\030frzBuQQQ"),
      Callback = function(action)
        if action ~= nil then
          _cEw:MoveTo(nil)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(Env.Platform, _Q4b("\127r!)\t")) then
    _Urwigo.MessageBox({
      Text = _Q4b(":rfuF$rf\016f!ur!ufr!f7uN7b\016&BR\015wu\brfu]RR\015\027r!&Bf!u,f\015\027f!u!r\028\\Bu&!zf\030frzBuQQQ"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.Command("SaveClose")
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _Q4b("\bf\015u\031fR\028&\028\\fu\022fSr!\027fBuFr\028\\ub!Bf\015uau=)?u9<w)W%uNu%9\t?up\018w<\018="),
      Callback = function(action)
        if action ~= nil then
          _2Pv0.Active = true
          _2Pv0.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _vBX:On_CAOf(target)
  _Urwigo.MessageBox({
    Text = (_Q4b("\014Rb\015u\028R7$\016fBrR!u\028R\027furF-u") .. string.sub(Player.CompletionCode, 1, 15)) .. _Q4b("u~\016f&FfubFfuB\\fuSr\015FBu9=u\028\\&\015&\028Bf\015FuRSurBuR!u\127\\f\015rzRw\028R7uBRub!\016R\028\005uB\\fu\028&\015B\015r\027zf")
  })
end
function _KcBjY:On_aSra(target)
  _Urwigo.MessageBox({
    Text = _Q4b(" f\\r!\027u&uFBR!fur!uB\\fu,&\016\016w"),
    Media = zmediaSpoiler,
    Callback = function(action)
      if action ~= nil then
        if Player:Contains(_vBX) then
          _Urwigo.MessageBox({
            Text = _Q4b("D&FBu\027bu\027f!u\031fR\028&\028\\fuzfSb!\027f!5u\127f!!u:rfu\027f!u\f\015BuzfSb!\027f!u\\&\022f!ub!\027uFr\028\\f\015uFr!\027Mu\027&FFu\027f\015u\017&\028\\fuSf\\\016BMu\005R!!f!u:rfu'\\\015f!ulb!\027uzf\015!fu$\015RBR\005R\016\016rf\015f!wuNr!f!u ff!\027rzb!zF\028R\027fu\030b7u\016Rzzf!u\027rfFf\015u\028&\015B\015r\027zfu\022fru,\\f\015frzRw\028R7uSr!\027f!u:rfur!u'\\\015f7u'!\025f!B&\015w"),
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _Q4b("D&FBu\027bu\027f!u\031fR\028&\028\\fuzfSb!\027f!5u\127f!!u:rfu\027f!u\f\015BuzfSb!\027f!u\\&\022f!ub!\027uFr\028\\f\015uFr!\027Mu\027&FFu\027f\015u\017&\028\\fuSf\\\016BMu\005R!!f!u:rfu'\\\015f!ulb!\027uzf\015!fu$\015RBR\005R\016\016rf\015f!wuNr!f!u ff!\027rzb!zF\028R\027fu\030b7u\016Rzzf!u\027rfFf\015u\028&\015B\015r\027zfu\022fru,\\f\015frzRw\028R7uSr!\027f!u:rfur!u'\\\015f7u'!\025f!B&\015w"),
            Callback = function(action)
              if action ~= nil then
                _vBX.Visible = true
                _vBX:MoveTo(Player)
                Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function _NyVrD:On_7NN(target)
  _Urwigo.MessageBox({
    Text = _Q4b(":rfu!f\\7f!u'\\\015fu]&\015Bfu\027fFu\031f\022rfBFu\\f\015&bFub!\027uf\015\005b!\027f!uFrfMub7u\027f!u\005b\015\030fFBf!u\127fzu\030bu'\\\015f7u\\fbBrzf!u2rf\016u\030buSr!\027f!wu~\016RB\030\016r\028\\u\\R\015Bu7&!ufr!uFf\016BF&7fFu\031f\015&bF\028\\ub\022f\015uFr\028\\Mufr!u\\f\016\016fFu\ar\028\\Bu\022\016rB\030Bub!\027ufB,&FuV!zf,R\\!\016r\028\\fFu\005\015&\028\\Bur!u\027rfu!&\\fuzf\016fzf!f!u bF\028\\fw"),
    Media = zmediaMap,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _Q4b(":rfuFr!\027u!fbzrf\015rzMu,&Fu$&FFrf\015BurFBub!\027uf!BF\028\\fr\027f!uFr\028\\uSb\015ufr!f!uzf!&bf\015f!u \016r\028\005"),
          Media = zmediaTask,
          Callback = function(action)
            if action ~= nil then
              _k_e.Visible = true
              _k_e.Active = true
              _nOEff.Complete = true
              _nOEff.Visible = false
              _bze.Visible = true
              _bze.Active = true
              _NyVrD.Commands._7NN.Enabled = false
              if Player:Contains(_6mSV1) and Player:Contains(_gDc) and Player:Contains(__rp9) then
                _NwAT.Visible = false
                _NwAT.Active = false
                _JylKL.Visible = false
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              else
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          end
        })
      end
    end
  })
end
return _To3S9
