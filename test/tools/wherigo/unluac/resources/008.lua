require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _y85z(str)
  local res = ""
  local dtable = "h\f\021OW\0184\019\030e&+Ds^x\016\027!=j5\017\015\\}fLt`2P\022Zm~\006$\t\020wG\029\014U?\vE\005l69(\003{\a7qJ8 ca|\002>Mo*S])N,<iR/3\bIY\001\031[0g-Q_Apy:F\r\026.u\024@b%\025\023\004\0001\nXd\"rCk;zTBvnK'\028V#H"
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
_5sy = Wherigo.ZCartridge()
_PNk = Wherigo.ZMedia(_5sy)
_PNk.Id = "dec3f66f-3d1c-4b7e-84d7-93e37af266f0"
_PNk.Name = _y85z("\rD\014\014L\nq")
_PNk.Description = ""
_PNk.AltText = ""
_PNk.Resources = {
  {
    Type = "jpg",
    Filename = "dossier.jpg",
    Directives = {}
  }
}
_WzCT = Wherigo.ZMedia(_5sy)
_WzCT.Id = "bba25622-23ec-40dc-9da2-a40b5146c715"
_WzCT.Name = _y85z("\r\005 ")
_WzCT.Description = ""
_WzCT.AltText = ""
_WzCT.Resources = {
  {
    Type = "jpg",
    Filename = "dwp.jpg",
    Directives = {}
  }
}
_7xy8y = Wherigo.ZMedia(_5sy)
_7xy8y.Id = "c4cf915c-d849-4225-9571-22336c792e81"
_7xy8y.Name = _y85z("*2D>s\n")
_7xy8y.Description = ""
_7xy8y.AltText = ""
_7xy8y.Resources = {
  {
    Type = "jpg",
    Filename = "glocke.jpg",
    Directives = {}
  }
}
_0VC = Wherigo.ZMedia(_5sy)
_0VC.Id = "cd7e3b48-e1c6-4db6-8414-eda22d6d1b6e"
_0VC.Name = _y85z("zy\n>\001\029")
_0VC.Description = ""
_0VC.AltText = ""
_0VC.Resources = {
  {
    Type = "jpg",
    Filename = "knecht.jpg",
    Directives = {}
  }
}
_mp3 = Wherigo.ZMedia(_5sy)
_mp3.Id = "d818525e-8dcb-4df3-89dd-eb7cd2d8a71c"
_mp3.Name = _y85z("zc\n\014\029\nq")
_mp3.Description = ""
_mp3.AltText = ""
_mp3.Resources = {
  {
    Type = "jpg",
    Filename = "kuester.jpg",
    Directives = {}
  }
}
_LaB = Wherigo.ZMedia(_5sy)
_LaB.Id = "cc040f72-0c02-4253-b660-fccf3c839ecb"
_LaB.Name = _y85z("C?WL\nX\r\n\029\ns\029Dq")
_LaB.Description = ""
_LaB.AltText = ""
_LaB.Resources = {
  {
    Type = "jpg",
    Filename = "magiedetektor.jpg",
    Directives = {}
  }
}
_zXiE = Wherigo.ZMedia(_5sy)
_zXiE.Id = "5907c594-9ccb-409c-bd31-37adf6864d2c"
_zXiE.Name = _y85z("CLq\n\029\029?")
_zXiE.Description = ""
_zXiE.AltText = ""
_zXiE.Resources = {
  {
    Type = "jpg",
    Filename = "miretta.jpg",
    Directives = {}
  }
}
_Llkwp = Wherigo.ZMedia(_5sy)
_Llkwp.Id = "a5ba9d0b-2912-4b50-904e-c4d7b66a0388"
_Llkwp.Name = _y85z("v?2?#?\014>?=\127Y")
_Llkwp.Description = ""
_Llkwp.AltText = ""
_Llkwp.Resources = {
  {
    Type = "jpg",
    Filename = "talamasca-hq-london.jpg",
    Directives = {}
  }
}
_y2F1D = Wherigo.ZMedia(_5sy)
_y2F1D.Id = "46c16936-d77d-4784-ba44-5c5483627aef"
_y2F1D.Name = _y85z([[
}
q
y?l]])
_y2F1D.Description = ""
_y2F1D.AltText = ""
_y2F1D.Resources = {
  {
    Type = "jpg",
    Filename = "verena1.jpg",
    Directives = {}
  }
}
_i__G = Wherigo.ZMedia(_5sy)
_i__G.Id = "17503d7b-b637-40d0-82e3-b518b14cd5a0"
_i__G.Name = _y85z("}\nq\ny?\031")
_i__G.Description = ""
_i__G.AltText = ""
_i__G.Resources = {
  {
    Type = "jpg",
    Filename = "verena2.jpg",
    Directives = {}
  }
}
_nj1 = Wherigo.ZMedia(_5sy)
_nj1.Id = "f9421344-8eca-4e32-a1e5-e58343d66806"
_nj1.Name = _y85z("\005Q*")
_nj1.Description = ""
_nj1.AltText = ""
_nj1.Resources = {
  {
    Type = "jpg",
    Filename = "wig.jpg",
    Directives = {}
  }
}
_veY = Wherigo.ZMedia(_5sy)
_veY.Id = "30ca4722-4f1a-4a00-9c83-7a0dfb54e922"
_veY.Name = _y85z([[
"Dy
l]])
_veY.Description = ""
_veY.AltText = ""
_veY.Resources = {
  {
    Type = "JPG",
    Filename = "zone1.JPG",
    Directives = {}
  }
}
_KKu_ = Wherigo.ZMedia(_5sy)
_KKu_.Id = "4fa01c83-bd34-4778-97bd-86a413dfd223"
_KKu_.Name = _y85z("\"Dy\n\031")
_KKu_.Description = ""
_KKu_.AltText = ""
_KKu_.Resources = {
  {
    Type = "JPG",
    Filename = "zone2.JPG",
    Directives = {}
  }
}
_8KC = Wherigo.ZMedia(_5sy)
_8KC.Id = "bb957efe-8199-464e-9d5a-e6f8cd2f41c4"
_8KC.Name = _y85z([[
"Dy
O]])
_8KC.Description = ""
_8KC.AltText = ""
_8KC.Resources = {
  {
    Type = "JPG",
    Filename = "zone3.JPG",
    Directives = {}
  }
}
_YWo7 = Wherigo.ZMedia(_5sy)
_YWo7.Id = "9d6c5c8c-d392-4914-be01-a15c37c0995b"
_YWo7.Name = _y85z("\"Dy\n\a")
_YWo7.Description = ""
_YWo7.AltText = ""
_YWo7.Resources = {
  {
    Type = "JPG",
    Filename = "zone4.JPG",
    Directives = {}
  }
}
_YdwSz = Wherigo.ZMedia(_5sy)
_YdwSz.Id = "2a4279ec-bd83-4af6-8268-961fcf223240"
_YdwSz.Name = _y85z("[coLDX*2D>s\n")
_YdwSz.Description = ""
_YdwSz.AltText = ""
_YdwSz.Resources = {
  {
    Type = "mp3",
    Filename = "glocke.mp3",
    Directives = {}
  }
}
_ECbC = Wherigo.ZMedia(_5sy)
_ECbC.Id = "4fa7e308-08cb-4986-8da6-da14d3e70283"
_ECbC.Name = _y85z(" L\n\\X\005\n\014\ny")
_ECbC.Description = ""
_ECbC.AltText = ""
_ECbC.Resources = {
  {
    Type = "wav",
    Filename = "StrangeBeeping-SoundBiblecom-2088039238.wav",
    Directives = {}
  }
}
_sJ0OX = Wherigo.ZMedia(_5sy)
_sJ0OX.Id = "0ca503ef-f376-4f3a-885b-083007ecf5a4"
_sJ0OX.Name = _y85z("C\n\0012\014>\001)?2f\n")
_sJ0OX.Description = ""
_sJ0OX.AltText = ""
_sJ0OX.Resources = {
  {
    Type = "jpg",
    Filename = "mehlschwalbe.jpg",
    Directives = {}
  }
}
_5sy.Id = "b8902042-29fe-42f8-8baa-fc44a5337ba0"
_5sy.Name = "Neues Leben fuer alte Mauern?"
_5sy.Description = [[
<BR>
Alter Kriminalfall.]]
_5sy.Visible = true
_5sy.Activity = "Geocache"
_5sy.StartingLocationDescription = ""
_5sy.StartingLocation = ZonePoint(51.587517, 12.0712, 0)
_5sy.Version = "1"
_5sy.Company = ""
_5sy.Author = "Der Wald-Pirat"
_5sy.BuilderVersion = "URWIGO 1.22.5798.37755"
_5sy.CreateDate = "02/26/2022 17:25:56"
_5sy.PublishDate = "1/1/0001 12:00:00 AM"
_5sy.UpdateDate = "03/25/2022 21:52:06"
_5sy.LastPlayedDate = "1/1/0001 12:00:00 AM"
_5sy.TargetDevice = "PocketPC"
_5sy.TargetDeviceVersion = "0"
_5sy.StateId = "1"
_5sy.CountryId = "2"
_5sy.Complete = false
_5sy.UseLogging = true
_hwZ = Wherigo.Zone(_5sy)
_hwZ.Id = "a866e842-c15c-4bdc-87dc-071058e072d5"
_hwZ.Name = _y85z("l=\rDq\027\\2?\029u")
_hwZ.Description = ""
_hwZ.Visible = true
_hwZ.Commands = {}
_hwZ.DistanceRange = Distance(-1, "feet")
_hwZ.ShowObjects = "OnEnter"
_hwZ.ProximityRange = Distance(60, "meters")
_hwZ.AllowSetPositionTo = false
_hwZ.Active = false
_hwZ.Points = {
  ZonePoint(51.5875252000388, 12.0707525294855, 0),
  ZonePoint(51.5876606034336, 12.0707377773359, 0),
  ZonePoint(51.5877160145526, 12.0709302258327, 0),
  ZonePoint(51.5875135344967, 12.0710878056123, 0)
}
_hwZ.OriginalPoint = ZonePoint(51.5876038381304, 12.0708770845666, 0)
_hwZ.DistanceRangeUOM = "Feet"
_hwZ.ProximityRangeUOM = "Meters"
_hwZ.OutOfRangeName = ""
_hwZ.InRangeName = ""
_xe2C5 = Wherigo.Zone(_5sy)
_xe2C5.Id = "6017132c-4468-4dac-a5c9-2eb63ac52b17"
_xe2C5.Name = _y85z("\031=zLq>\001qcLy\n")
_xe2C5.Description = ""
_xe2C5.Visible = true
_xe2C5.Commands = {}
_xe2C5.DistanceRange = Distance(-1, "feet")
_xe2C5.ShowObjects = "OnEnter"
_xe2C5.ProximityRange = Distance(60, "meters")
_xe2C5.AllowSetPositionTo = false
_xe2C5.Active = false
_xe2C5.Points = {
  ZonePoint(51.5874314546344, 12.0700308876338, 0),
  ZonePoint(51.5874965413141, 12.0706794481457, 0),
  ZonePoint(51.5872170507947, 12.0707595553824, 0),
  ZonePoint(51.5871423920773, 12.0702342367729, 0)
}
_xe2C5.OriginalPoint = ZonePoint(51.5873218597051, 12.0704260319837, 0)
_xe2C5.DistanceRangeUOM = "Feet"
_xe2C5.ProximityRangeUOM = "Meters"
_xe2C5.OutOfRangeName = ""
_xe2C5.InRangeName = ""
_jUmor = Wherigo.Zone(_5sy)
_jUmor.Id = "04c1a7ed-20f0-4235-81b6-b62ad7dd8a05"
_jUmor.Name = _y85z("O=v\nL>\001J=F\\L\n2\\2?\029uJ=FL\029uf?\nys\n")
_jUmor.Description = ""
_jUmor.Visible = true
_jUmor.Commands = {}
_jUmor.DistanceRange = Distance(-1, "feet")
_jUmor.ShowObjects = "OnEnter"
_jUmor.ProximityRange = Distance(60, "meters")
_jUmor.AllowSetPositionTo = false
_jUmor.Active = false
_jUmor.Points = {
  ZonePoint(51.5919305581299, 12.0702845236794, 0),
  ZonePoint(51.592021479094, 12.0710948398536, 0),
  ZonePoint(51.5912730505839, 12.0713505670113, 0),
  ZonePoint(51.5911515015673, 12.0706249797146, 0)
}
_jUmor.OriginalPoint = ZonePoint(51.5915941473438, 12.0708387275647, 0)
_jUmor.DistanceRangeUOM = "Feet"
_jUmor.ProximityRangeUOM = "Meters"
_jUmor.OutOfRangeName = ""
_jUmor.InRangeName = ""
XXX = Wherigo.Zone(_5sy)
XXX.Id = "f5c86472-c0ea-42d8-9e08-f021645c9575"
XXX.Name = _y85z("\a=F>\001?\029u")
XXX.Description = ""
XXX.Visible = true
XXX.Commands = {}
XXX.DistanceRange = Distance(-1, "feet")
XXX.ShowObjects = "OnEnter"
XXX.ProximityRange = Distance(60, "meters")
XXX.AllowSetPositionTo = false
XXX.Active = false
XXX.Points = {
  ZonePoint(51.5931952694745, 12.0680599139988, 0),
  ZonePoint(51.593599369441, 12.068035521179, 0),
  ZonePoint(51.5934326786404, 12.068572163215, 0)
}
XXX.OriginalPoint = ZonePoint(51.593409105852, 12.0682225327976, 0)
XXX.DistanceRangeUOM = "Feet"
XXX.ProximityRangeUOM = "Meters"
XXX.OutOfRangeName = ""
XXX.InRangeName = ""
_EvX = Wherigo.ZCharacter({Cartridge = _5sy, Container = _hwZ})
_EvX.Id = "4339a788-6f8c-44a0-ab94-a960685930d7"
_EvX.Name = _y85z("}\nq\ny?=\005?\001q)Dq\029")
_EvX.Description = ""
_EvX.Visible = true
_EvX.Media = _i__G
_EvX.Commands = {
  _OPzdh = Wherigo.ZCommand({
    Text = _y85z("[y\014\\q\n>\001\ny"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _y85z("IL>\001\029=x\nq\027cWf?q")
  })
}
_EvX.Commands._OPzdh.Custom = true
_EvX.Commands._OPzdh.Id = "6f3ab36c-ce3e-47ef-af50-e1247763de16"
_EvX.Commands._OPzdh.WorksWithAll = true
_EvX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_EvX.Gender = "Female"
_EvX.Type = "NPC"
_4fVx = Wherigo.ZCharacter({Cartridge = _5sy, Container = _xe2C5})
_4fVx.Id = "6c6205a3-2267-454b-8d41-ad132c33c0f0"
_4fVx.Name = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2")
_4fVx.Description = _y85z("*\n\014\\\ny\014\029J=\n\001\n#?2LW\nq=zc\n\014\029\nq")
_4fVx.Visible = false
_4fVx.Media = _mp3
_4fVx.Commands = {
  _ZNHO = Wherigo.ZCommand({
    Text = _y85z("[y\029)Dq\029\ny"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _y85z("IL>\001\029=x\nq\027cWf?q")
  })
}
_4fVx.Commands._ZNHO.Custom = true
_4fVx.Commands._ZNHO.Id = "dcee6d3c-cb9f-4cc7-8064-3496777ff952"
_4fVx.Commands._ZNHO.WorksWithAll = true
_4fVx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_4fVx.Gender = "Male"
_4fVx.Type = "NPC"
_hdA0F = Wherigo.ZItem({Cartridge = _5sy, Container = Player})
_hdA0F.Id = "cf5d47c1-7143-44dd-a287-a2111bc16512"
_hdA0F.Name = _y85z("*2D>s\n")
_hdA0F.Description = _y85z("#?WL\014>\001")
_hdA0F.Visible = true
_hdA0F.Media = _7xy8y
_hdA0F.Commands = {
  _GFv = Wherigo.ZCommand({
    Text = _y85z("z2LyW\ny=2?\014\014\ny"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _y85z("IL>\001\029=x\nq\027cWf?q")
  })
}
_hdA0F.Commands._GFv.Custom = true
_hdA0F.Commands._GFv.Id = "fcb918b5-e70b-4310-9446-7edf7065966c"
_hdA0F.Commands._GFv.WorksWithAll = true
_hdA0F.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_hdA0F.Locked = false
_hdA0F.Opened = false
_1nNhf = Wherigo.ZItem({Cartridge = _5sy, Container = Player})
_1nNhf.Id = "977a628c-93bb-4b1d-ade6-6ef93b7f209e"
_1nNhf.Name = _y85z("\rD\014\014L\nq")
_1nNhf.Description = ""
_1nNhf.Visible = true
_1nNhf.Media = _PNk
_1nNhf.Commands = {
  _20ND = Wherigo.ZCommand({
    Text = _y85z("\028\n\014\ny"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _y85z("IL>\001\029=x\nq\027cWf?q")
  })
}
_1nNhf.Commands._20ND.Custom = true
_1nNhf.Commands._20ND.Id = "ce58ec3c-8bad-4e13-ab1d-1b13aa2d1097"
_1nNhf.Commands._20ND.WorksWithAll = true
_1nNhf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_1nNhf.Locked = false
_1nNhf.Opened = false
_VJZmW = Wherigo.ZItem({Cartridge = _5sy, Container = Player})
_VJZmW.Id = "208724c8-2436-430c-9f81-2eb9dc168539"
_VJZmW.Name = _y85z("\r\n\029\ns\029Dq=\027c\nq=-\nf\nqy?\029c\nq2L>\001\n\014")
_VJZmW.Description = ""
_VJZmW.Visible = true
_VJZmW.Media = _LaB
_VJZmW.Commands = {}
_VJZmW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_VJZmW.Locked = false
_VJZmW.Opened = false
_HsvhP = false
ZZZ = ""
_yeA7 = _y85z("Z\001)\"")
_tyj5T = _y85z("Z0xn")
_TPCO = _y85z("Z\001o[V_")
_99O = _y85z("oc##]")
_k7wEL = _y85z("Z-QV#Z")
_lNoc = _y85z("oc##]")
_5sy.ZVariables = {
  _HsvhP = false,
  ZZZ = "",
  _yeA7 = _y85z("Z\001)\""),
  _tyj5T = _y85z("Z0xn"),
  _TPCO = _y85z("Z\001o[V_"),
  _99O = _y85z("oc##]"),
  _k7wEL = _y85z("Z-QV#Z"),
  _lNoc = _y85z("oc##]")
}
_UI0m_ = Wherigo.ZInput(_5sy)
_UI0m_.Id = "c739fcb6-c9f8-4f49-bb2a-c0dd717c510a"
_UI0m_.Name = _y85z([[
"Dy
l_q?W
l]])
_UI0m_.Description = ""
_UI0m_.Visible = true
_UI0m_.InputType = "Text"
_UI0m_.Text = _y85z("\005L\n=WqD\014u=L\014\029=o\nq=Df\nq\n=\005Lys\n2=L#=\rq\nL\n>s=Ly=*q?o.")
_SdQo = Wherigo.ZInput(_5sy)
_SdQo.Id = "3527a629-6242-4dce-b290-4b9429ed325f"
_SdQo.Name = _y85z("\"Dy\n\031_q?W\nl")
_SdQo.Description = ""
_SdQo.Visible = true
_SdQo.InputType = "Text"
_SdQo.Text = _y85z("Qy=)\n2>\001\n#=;?\001q\n=)cqo\n=\127\nLyqL>\001=F>\0012cqL>s=W\nfDq\ny.")
_cck = Wherigo.ZInput(_5sy)
_cck.Id = "85715247-a7be-4e77-b5ad-3e7710cc69f3"
_cck.Name = _y85z("\"Dy\n\031_q?W\n\031")
_cck.Description = ""
_cck.Visible = true
_cck.InputType = "Text"
_cck.Text = _y85z("Qy=)\n2>\001\n#=;?\001q\n=\014\029?qf=C?qL?=M\nWLy?=F>\0012cqL>s.")
_Hud = Wherigo.ZInput(_5sy)
_Hud.Id = "c5623d72-72e9-4fad-8552-c41964a4ea0d"
_Hud.Name = _y85z([[
"Dy
O_q?W
l]])
_Hud.Description = ""
_Hud.Visible = true
_Hud.InputType = "Text"
_Hud.Text = _y85z("\005?\014=L\014\029=oL\n=[yu?\0012=o\nq=\027?qfLW\ny=Yc?oq?\029\n=cy\029\ny=?c\027=o\n#=F\\L\n2\\2?\029u\014>\001L2o.")
function _5sy:OnStart()
  if _G[_y85z("0yx")][_y85z(" 2?\029\027Dq#")] == _y85z("\005LyO\031") or _G[_y85z("0yx")][_y85z("\r\nxL>\nQ\r")] == _y85z("\r\n\014s\029D\\") then
    for k, v in pairs(_G[_y85z("Z\022\014]")][_y85z("[22\"\004f\021\n>\029\014")]) do
      v[_y85z("}L\014Lf2\n")] = false
      v[_y85z("[>\029Lx\n")] = false
    end
    _G[_y85z("\005\001\nqLWD")][_y85z("rD##?yo")](_y85z("F?x\nr2D\014\n"))
    return
  end
  _vyD()
  _Urwigo.Dialog(false, {
    {
      Text = _y85z("\127\nqu2L>\001=)L22sD##\ny=f\nL#=\005\001\nqLWD=pI\nc\n\014=\028\nf\ny=\027c\nq=?2\029\n=C?c\nqy.p=xD#=\005?2oX Lq?\029\ny\019KwMB"),
      Media = _WzCT
    },
    {
      Text = _y85z("0*r[^=C\n\014\014D#?\029\019KwMBKwMB0\014=\014D22\029\ny=s\nLy\n=?yo\nq\ny=[\\\\\014=L#=\127Ly\029\nqWqcyo=2?c\027\nyJ=o?=oL\n\014=uc=[f\014\029c\nqu\ny=\027c\n\001q\ny=s?yy\019KwMBKwMB\005\nyy=oc=Ly=\nLy\n=\"Dy\n=\001Ly\nLysD##\014\029J=\014D=f2\nLf\n=yL>\001\029=?y=o\nq\ny=M?yo=\014\029\n\001\nyJ=\014Dyo\nqy=W\n\001\n=\029L\n\027\nq=\001Ly\nLy\019KwMBKwMBQ##\nq=Mcy\029\nq\014>qD22\nyJ=?c>\001=)\nyy=o\nq=F>qD22f?2s\ny=f\nL=\nc>\001=\027\n\0012\ny=\014D22\029\n\019KwMB"),
      Media = _nj1
    },
    {
      Text = _y85z("FD22\029\n=y?>\001=\nLy\n#=YMXrDo\n=W\n\027q?W\029=)\nqo\nyJ=\014D=L\014\029=oL\n\014=\nLy\n=_\n\0012\027cys\029LDyJ=oL\n=LWyDqL\nq\029=)\nqo\ny=#c\014u\019KwMBKwMB0Ly\n=\014>\001\nLyf?q=sDqq\ns\029\n=0LyW?f\n=y?>\001=\nLy\nq=_q?W\n=s?yy=ocq>\001=\nLy=cy\014L>\001\029f?q\n\014=\"\nL>\001\ny=5ubwb=\028\n\nqu\nL>\001\nyH=\014>\001\nL\029\nqyb=\rL\n\014\n\014=s?yy=ocq>\001=\nLy\n=[c\029Dx\nqxD22\014\029?\nyoLWcyW=\\?\014\014L\nq\nybKwMB"),
      Media = _nj1
    },
    {
      Text = _y85z("\rc=fL\014\029=CLq\n\029\029?=CLq?yo?=?c\014= Lq?yDX Dq\029DqD\014\nJ=\nLy\n=Q\029?2L\ny\nqLy=?c\014=F2D)\nyL\nyb=\rc=fL\014\029=\021cyWJ=q\nL>\001J=?f\ny\029\nc\nq2c\014\029LW=cyo=?22W\n#\nLy=\014\n\001q=f\n2L\nf\029bKwMB_c\nq=oL\n=*\n\001\nL#DqW?yL\014?\029LDy=v?2?#?\014>?=fL\014\029=oc=?y=?22\ny=#D\nW2L>\001\ny=\004q\029\ny=cy\029\nq)\nW\014b=CD#\ny\029?y=x\nq\029qL\029\029\014\029=oc=\005L22L?#=\005Dyo\nq)Dqs\014J=o\nq=ucq=\127D>\001u\nL\029=\014\nLy\nq=F>\001)\n\014\029\nq=y?>\001=0yW2?yo=q\nL\014\ny=#c\014u\029\nb"),
      Media = _zXiE
    },
    {
      Text = _y85z("C\n\001q=o\n\029?L22L\nq\029\n=Qy\027D\014=uc=o\nLy\n#=\127Ly\029\nqWqcyo=\014\029\n\001\ny=Ly=o\nLy\n#=\rD\014\014L\nqb"),
      Media = _PNk
    },
    {
      Text = _y85z("\"L\n2=o\nq=v?2?#?\014>?=L\014\029=oL\n=\rDsc#\ny\029?\029LDy=?22\nq= \001?\nyD#\ny\n=?c\014=o\nq=\005\n2\029=o\n\014=-\nf\nq\014Lyy2L>\001\nyb=Q\001q=FL\029u=L\014\029=Ly=\028DyoDyJ=cyo=oc=\001?\014\029=oDq\029\001Ly=\nLy\n=\014\029?\nyoLW\n=_cysx\nqfLyocyWbKwMBv?2?#?\014>?X[W\ny\029\ny=\001?\029\029\ny=L#=\028?c\027\n=o\nq=\"\nL\029=zDy\029?s\029=uc=?22\nq2\nL=\014\n2\029\014?#\ny=\005\n\014\ny=)L\n=o\n#=}?#\\Lq=\028\n\014\029?\029J=o\n#=\028D>\001XI\n\014\014XCDy\014\029\nqJ=I]?q2?\029\001D\029\n\\J=o\n#=0)LW\ny=;co\nyJ=o\n#=wDo\001L\014?\029\029x?=z\014\001L\029LW?qf\001?J=o\n#=\")\nqW\nysD\nyLW=\004qDyD#?\014\014?y=cyo=xL\n2\ny=?yo\nq\ny=\005\n\014\nyb"),
      Media = _Llkwp
    },
    {
      Text = _y85z("Qy=o\nLy\nq=[c\014qc\n\014\029cyW=f\n\027Lyo\n\029=\014L>\001=\nLy\n=#?WL\014>\001\n=*2D>s\nJ=#L\029=o\nq=oc=?c\027W\nfq?>\001\029\nJ=x\nq)Lqq\029\n=cyo=\027\nLyo\014\n2LW\n=zq\n?\029cq\ny=xL\n2\nq=[q\029\ny=f\nqc\001LW\ny=cyo=?c\027=o\nLy\n=F\nL\029\n=uL\n\001\ny=s?yy\014\029b=\rL\n=#?WL\014>\001\ny=z2?\nyW\n=\001D\nq\ny=\014L>\001=W?yu=?yo\nq\014=?y=?2\014=\nLy\n=\029]\\L\014>\001\n=*2D>s\nb"),
      Media = _7xy8y
    },
    {
      Text = _y85z("\r\nLy=\014DWb=*qc\014\n2XDXC\n\029\nq=\014>\0012?\nW\029=xDy=?22\nLy\n=?c\014J=)\nyy=oc=?c\027=#?WL\014>\001\n=\005\n\014\ny=Do\nq=*\nW\ny\014\029?\nyo\n=\029qL\027\027\014\029b"),
      Media = _LaB
    },
    {
      Text = _y85z("}Dy=o\nq=sLq>\0012L>\001\ny=;cW\nyo=o\n\014=I?>\001f?qDq\029\n\014=\005\nL\014u?yo\029X*D\n2u?c=\001?\014\029=oc=W\n\001D\nq\029J=o?\014u=\001L\nq=\014\n2\029\014?#\n=\rLyW\n=xDq=\014L>\001=W\n\001\ny=\014D22\nyJ=cyo=\027?\n\001q\014\029=\001\nqf\nLJ=c#=oL\n\014\n=uc=cy\029\nq\014c>\001\nyb"),
      Media = _zXiE
    }
  }, function(action)
    _hwZ.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _5sy:OnRestore()
end
function _hwZ:OnEnter()
  _yeA7 = _y85z("Z\001)\"")
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_UI0m_)
  end)
end
function _hwZ:OnExit()
  _yeA7 = _y85z("Z\001)\"")
  if _xe2C5.Active == true then
    _hwZ.Active = false
  end
end
function _xe2C5:OnEnter()
  _yeA7 = _y85z("Z\016\n\031r\022")
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_SdQo)
  end)
end
function _xe2C5:OnExit()
  _yeA7 = _y85z("Z\016\n\031r\022")
  if _jUmor.Active == true then
    _xe2C5.Active = false
  end
end
function _jUmor:OnEnter()
  _yeA7 = _y85z("Z\021-#Dq")
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Hud)
  end)
end
function _jUmor:OnExit()
  _yeA7 = _y85z("Z\021-#Dq")
  if XXX.Active == true then
    _jUmor.Active = false
  end
end
function XXX:OnEnter()
  _yeA7 = _y85z("nnn")
  _Urwigo.Dialog(false, {
    {
      Text = _y85z("Q\001q=\027Lyo\n\029=o\ny=F>\001?\029ub"),
      Media = _YWo7
    },
    {
      Text = _y85z("CL\029=o\n#=F>\001?\029u=sD##\029=oL\n=M\n\014\029?cqL\ncyW=o\nq=zLq>\001qcLy\n=\ny\029\014>\001\nLo\nyo=xDq?yb"),
      Media = _KKu_
    },
    {
      Text = _y85z("}\nq\ny?=\005?\001q)Dq\029^=p\127cqq?\019p"),
      Media = _i__G
    },
    {
      Text = _y85z("\r\nq=\004)y\nq=)Lqo=\014L>\001=\014L>\001\nq=c\nf\nq=\nLy\ny=?c\014\014?W\n\027?\n\001LW\ny=\028DW=\027q\nc\nyJ=?f\nq=yL>\001\029=c\nf\nq=pF\\?\n\029\nq=#\n\001qpXCc\n22=Do\nq=-q2?cf\014q\nL\014\nyX0Ly\001\nL\029\014X\028DW\014bKwMB"),
      Media = _WzCT
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _UI0m_:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_UI0m_)
      end)
    end)
    return
  end
  if input >= 105 and input <= 107 then
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("[c\014=o\n#=_qL\no\001D\027\014\029Dq=\0272L\n\001\029=\nLy=\021cyW\n\014J=?c\027W\nq\nW\029\n\014=C?\no>\001\nyb"),
        Media = _y2F1D
      }
    }, function(action)
      _EvX.Name = _y85z(";cyW\n\014=C?\no>\001\ny")
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_UI0m_)
      end)
    end)
  end
end
function _SdQo:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_SdQo)
      end)
    end)
    return
  end
  if input == 1805 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_cck)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_SdQo)
      end)
    end)
  end
end
function _cck:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_cck)
      end)
    end)
    return
  end
  if input == 1861 then
    Wherigo.PlayAudio(_ECbC)
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("\r\nLy=C?WL\nX\r\n\029\ns\029Dq=#\n2o\n\029=oL\n=[y\n\014\ny\001\nL\029=\nLy\n\014=*\nL\014\029\n\014b"),
        Media = _LaB
      },
      {
        Text = _y85z("\rc=\014L\n\001\014\029=oL>\001=c#J=?f\nq=yL\016b=}\nqfLqW\029=\014L>\001=o?\014=*\n\014\\\ny\014\029=L#=*\n#?\nc\nq."),
        Media = _KKu_
      }
    }, function(action)
      _HsvhP = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_cck)
      end)
    end)
  end
end
function _Hud:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_Hud)
      end)
    end)
    return
  end
  if input == 18 then
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=p\127L\nq=\ny\0292?yW\019=\005\nL\029\nq=W\n\001\029{\014\019p"),
        Media = _mp3
      }
    }, function(action)
      XXX.Active = true
      _4fVx:MoveTo(XXX)
      _EvX:MoveTo(XXX)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("C\n\0012\014>\001)?2f\n^=p_?2\014>\001\019p"),
        Media = _sJ0OX
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_Hud)
      end)
    end)
  end
end
function _EvX:On_OPzdh(target)
  _Urwigo.Dialog(false, {
    {
      Text = _y85z("\rc^=p\127?22D\019=Q>\001=fLy=CLq\n\029\029?=CLq?yo?b=z?yy=L>\001=oLq=\001\n2\027\ny.p"),
      Media = _zXiE
    },
    {
      Text = _y85z(";cyW\n\014=C?\no>\001\ny^=p\127?22D\019=Q>\001=fLy=}\nq\ny?=\005?\001q)Dq\029b=FL\n=sD\nyy\ny=#Lq=?c>\001=yL>\001\029=\001\n2\027\nyb=FL\n=W2?cf\ny=#Lq=\014D)L\n\014D=yL>\001\029\019p"),
      Media = _i__G
    },
    {
      Text = _y85z("\rc^=pQ>\001=\001?f\n=\014>\001Dy=\nLyLW\n=\014\n\001q=\014\n2\029\014?#\n=\rLyW\n=\nq2\nf\029b=CL>\001=\014>\001D>sL\nq\029=s?c#=)?\014b=\005?\014=L\014\029=o\nyy=\\?\014\014L\nq\029.p"),
      Media = _zXiE
    },
    {
      Text = _y85z("}\nq\ny?=\005?\001q)Dq\029^=pC\nLy\n=Cc\029\029L=L\014\029=oL\n=F>\001?\029u#\nL\014\029\nqLy=xDy=o\n#=}\nq\nLyJ=o\nq=oL\n=zLq>\001\n=)L\no\nq?c\027f?c\ny=)L22b=\127L\nq=?#=wq\n\029\029=\001?\nyW\029=\nLy\n=wqD\014>\001c\nq\n=o?ucb=0\014=WLf\029=u)?q=L#\nq=)L\no\nq=FL>\001\nq\001\nL\029\014?qf\nL\029\ny=?y=o\nq=zLq>\001qcLy\nb=[f\nq=L##\nq=)L\no\nq=W\n\001\029=LqW\nyo)?\014=\014>\001L\n\027b=w?c#?\029\nqL?2L\ny=x\nq\014>\001)Lyo\nyb=0Ly=F\029\nLy=\027L\n2=\nLy\n#=C?yy=?c\027=o\ny=zD\\\027bp"),
      Media = _i__G
    },
    {
      Text = _y85z("}\nq\ny?=\005?\001q)Dq\029^=pQ>\001=)\nL\014uJ=)Dq?y=\n\014=2L\nW\029b=[f\nq=s\nLy\nq=o\nq=oDD\027\ny=0q)?>\001\014\ny\ny=?c\014=cy\014\nq\n#=\rDq\027=W2?cf\029=#Lqb=0Ly=*\n\014\\\ny\014\029=W\n\001\029=Ly=o\nq=zLq>\001qcLy\n=c#b=Q>\001=)\nL\014u=?f\nq=yL>\001\029J=)?\014=\n\014=)L22b=Q>\001=\014\n\001\n=\n\014=ycq=cyo\nc\0292L>\001b=\rL\n=?yo\nq\ny=\014\n\001\ny=\n\014=W?q=yL>\001\029=cyo=\014?W\nyJ=o?\014u=L>\001=\014\\Lyy\nb=Q>\001=)\nL\014u=yL>\001\029J=Df=o?\014=*\n\014\\\ny\014\029=)Lqs2L>\001=fD\n\014\n=L\014\029\019pKwMB"),
      Media = _i__G
    },
    {
      Text = _y85z("\rc^=pv?\029\014?\n>\0012L>\001=L\014\029=\n\014=\014DJ=o?\014u=zLyo\nq=oL\n=*\n\014\\\ny\014\029\nq=\014\n\001\ny=sD\nyy\nyJ=oL\n=#\nL\014\029\ny=0q)?>\001\014\ny\ny=\001LyW\nW\ny=yL>\001\029b=\rc=fL\014\029=\021?=yD>\001=L#=-\nf\nqW?yWb=\005?\001q\014>\001\nLy2L>\001=\014L\n\001\014\029=oc=o\n\014)\nW\ny=o?\014=*\n\014\\\ny\014\029=ycq=x\nq\014>\001)D##\nyb=Q>\001=)\nqo\n=#?2=#L\029=o\n#=*\nL\014\029=\014\\q\n>\001\nyb=*\n\001\ny=)Lq=#?2=uc=o\nq=zLq>\001qcLy\n\019p"),
      Media = _zXiE
    }
  }, function(action)
    _EvX.Name = _y85z("}\nq\ny?=\005?\001q)Dq\029")
    _EvX.Commands._OPzdh.Enabled = false
    _xe2C5.Active = true
    _EvX:MoveTo(_xe2C5)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _4fVx:On_ZNHO(target)
  _Urwigo.Dialog(false, {
    {
      Text = _y85z("\rc^=p\127?22D\019=Q>\001=fLy=oL\n=*\nL\014\029\nq\027Dq\014>\001\nqLy=CLq\n\029\029?=CLq?yo?b=\005?qc#=\nq\014>\001q\n>s\014\029=oc=L##\nq=)L\no\nq=o?\014=\021cyW\n=C?\no>\001\ny=\001L\nq.p"),
      Media = _zXiE
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=pQ>\001=x\nq\014c>\001\n=ycqJ=?c\027=#L>\001=?c\027#\nqs\014?#=uc=#?>\001\nyb=;\n\029u\029J=)D=oL\n=zLq>\001\n=)L\no\nq=?c\027W\nf?c\029=)\nqo\ny=\014D22J=\001?f\n=L>\001=\nLy\n=)L>\001\029LW\n=wD\029\014>\001?\027\029=#L\029uc\029\nL2\nybp"),
      Media = _mp3
    },
    {
      Text = _y85z("\rc^=p\005?\014=#D\n>\001\029\n\014\029=oc=cy\014=#L\029\029\nL2\ny.pKwMB"),
      Media = _zXiE
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=pQ>\001=)?q=xDq=\031VV=;?\001q\ny=zc\n\014\029\nq=\001L\nq=?y=o\nq=zLq>\001\nb=Q>\001=f\nDf?>\001\029\n\029\nJ=)L\n=C?q>c\014=CL\029y?\001#\nJ=\nLy=zy\n>\001\029=?c\014=o\n#=ML\029\029\nqWc\029=FL\nW\n2\014oDq\027=#L\029=\nLy\n#=fD\n\014\ny=\127\nqu\nyJ=oL\n=?yW\n\014?##\n2\029\n=zD22\ns\029\n=o\nq=*\n#\nLyo\nJ=oL\n=\027c\nq=oL\n=[q#\ny=f\n\014\029L##\029=)?qJ=W\n\014\029D\0012\ny=\001?\029bpKwMB"),
      Media = _mp3
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=p;\n\014c\014=\001?\029=W\n\014?W\029^=C?\029\029\001?\nc\014=l<^=l\022=Fc\nyoLW\029=?f\nq=o\nLy=wqco\nqJ=\014D=W\n\001=\001Ly=cyo=)\nL\014\n=L\001y=ucq\n>\001\029=u)L\014>\001\ny=oLq=cyo=L\001#=?22\nLyb=\127D\nq\029=\nq=?c\027=oL>\001J=\014D=\001?\014\029=oc=o\nLy\ny=wqco\nq=W\n)Dyy\nyb=l3=\127D\nq\029=\nq=yL>\001\029=?c\027=oL>\001J=\014D=yL##=yD>\001=\nLy\ny=Do\nq=u)\nL=uc=oLqJ=o?#L\029=\021\no\n=F?>\001\n=ocq>\001=u)\nL\nq=Do\nq=oq\nL\nq=\"\ncW\ny=Ccyo=f\n\014\029?\n\029LW\029=)\nqo\nbp"),
      Media = _mp3
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=p\r?\014=\001?f\n=L>\001=\nq\014\029#?2=W\n#?>\001\029b=\rD>\001=)\nL\029\nq=?2\014=uc#=*\n\014\\q?\n>\001=cy\029\nq=xL\nq=[cW\ny=s?#=L>\001=yL>\001\029J=o\nyy=c#=yL>\001\029=\ny\029o\n>s\029=uc=)\nqo\nyJ=\nq\014>\0012cW=#L>\001=o\nq=fD\n\014\n=C?q>c\014=CL\029y?\001#\nb=Q>\001=)cqo\n=uc#=*\nL\014\029=cyo=\014?\001J=)D=\nq=\014\nLy\n=w\nc\029\n=x\nq\014\029\n>s\029\nbp"),
      Media = _mp3
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=pC?q>c\014=CL\029y?\001#\n=\014\029?qf=D\001y\n=M\nc\nq=\014\nLy\nq=c\nf2\ny=v?\029\ny=cyo=sD##\029=o?\001\nq=yL>\001\029=uc#=\n)LW\ny=\028\nf\nyb=lb=;D\001?yy\n\014=O^=\vyf\014\\tl\a=\005Lq=)L\014\014\nyJ=o?\014\014=)Lq=?c\014=o\n#=vDo=Ly=o?\014=\028\nf\ny=\001Lyc\nf\nqW\nW?yW\ny=\014Lyot=o\nyy=)Lq=2L\nf\ny=oL\n=wqc\no\nqb=\005\nq=yL>\001\029=2L\nf\029J=o\nq=f2\nLf\029=L#=vDob=l\022=\005\nq=\014\nLy\ny=wqco\nq=\001?\014\014\029J=o\nq=L\014\029=\nLy=CD\nqo\nqJ=cyo=L\001q=)L\014\014\029J=o?\014\014=s\nLy=CD\nqo\nq=o?\014=\n)LW\n=\028\nf\ny=f2\nLf\nyo=Ly=\014L>\001=\001?\029bp"),
      Media = _mp3
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=pQ>\001=x\nq)\nL2\n=\nLy\014\029=yD>\001=\001L\nqJ=c#=o\ny=\rL\nf\014\029?\0012=cyW\n\014>\001\n\001\ny=uc=#?>\001\nyb=0\014=#c\014u=\014L>\001\nqW\n\014\029\n22\029=)\nqo\nyJ=o?\014u=o?\014=M?cfWc\029=uc=o\ny=qL>\001\029LW\ny=\028\nc\029\ny=sD##\029bp"),
      Media = _mp3
    },
    {
      Text = _y85z("}\nq\ny?=\005?\001q)Dq\029^=pC\nLy\n=Cc\029\029L=x\nq)?2\029\n\029=o?\014=*\n2o=xDy=cy\014\nq\n#=}\nq\nLyJ=o\nq=oL\n=zLq>\001\n=q\n\014\029?cqL\nq\ny=)L22bp"),
      Media = _i__G
    },
    {
      Text = _y85z("*cy\029\001\nq=*2D>s\ny\014\nL2^=pI?=Wc\029J=L>\001=u\nLW\n=\nc>\001=o?\014=}\nq\014\029\n>sb=\127L\nq=W\n\001\029=\n\014=2?yW\019p"),
      Media = _mp3
    }
  }, function(action)
    _4fVx.Commands._ZNHO.Enabled = false
    _jUmor.Active = true
    _4fVx:MoveTo(_jUmor)
    _EvX:MoveTo(_jUmor)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _hdA0F:On_GFv(target)
  Wherigo.PlayAudio(_YdwSz)
  if _HsvhP == true then
    Wherigo.PlayAudio(_YdwSz)
    _Urwigo.Dialog(false, {
      {
        Text = _y85z("[c\014=o\n#=cq?2\029\ny=*\n#?\nc\nq=\014>\001)\nf\029=o\nq=*\nL\014\029=\nLy\n\014=?2\029\ny=C?yy\n\014=\001\nq?c\014=cyo=\001\nqf\nL^=pQ>\001=fLy=o\nq=zc\n\014\029\nq=*cy\029\001\nq=*2D>s\ny\014\nL2b=\005\nq=\ny\029uc\n>s\029=#L>\001=#L\029=oL\n\014\ny=)cyo\nqf?q\ny=z2?\nyW\ny.p"),
        Media = _mp3
      }
    }, function(action)
      _HsvhP = false
      _4fVx.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _1nNhf:On_20ND(target)
  _Urwigo.Dialog(false, {
    {
      Text = _y85z("\rc=)cqo\n\014\029=W\nfDq\ny=?2\014=CLq\n\029\029?=CLq?>c2D\014?b=Qy= Lq?yDJ=\004q\029\014\029\nL2= Dq\029DqD\014\nJ=L\014\029=o\nLy\n=_?#L2L\n=v\nL2=o\nq=L\029?2L\nyL\014>\001\ny=CLyo\nq\001\nL\029=Ly=F2D)\nyL\nyb"),
      Media = _zXiE
    },
    {
      Text = _y85z("CL\029=l\a=;?\001q\ny=2\nqy\029\n\014\029=oc=\nLy\ny=Cc2\029L#L22L?qo?\nq=?c\014=wq?\014L2L\ny=y?#\ny\014=CLWc\n2=CLq?yo?=s\nyy\nyJ=o\nq=\014L>\001=?c\027=\014\nLy\n=?2\029\ny=v?W\n=o?\014=\028\nf\ny=#L\029=\nLy\n#=\021cyW\nyJ=\001c\nf\014>\001\ny=C?\no>\001\ny=x\nq\014c\n\014u\ny=)D22\029\nb=0q=cyo=oc=\001\nLq?\029\n\029\ny=Ly=wq?\014L2L\nyb")
    },
    {
      Text = _y85z("I?>\001=o\n#=M\n>\001\029=o\nq=z?\029\001D2L\014>\001\ny=zLq>\001\nJ=>?yb=lV<O=rQrJ=)?q\014\029=oc=#L\029=l\a=\n\001\n#c\nyoLWJ=y?>\001=o\n#=fq?\014L2L?yL\014>\001\ny=\"LxL2q\n>\001\029=?f\nq=yD>\001=yL>\001\029b=[f\nq=CLWc\n2=CLq?yo?=\001?\029\029\n=#L\029=\014\nLy\n#=}\nq#D\nW\ny=s\nLy= qDf2\n#J=\nLyLW\n=w\n?#\029\n=uc=#D\029LxL\nq\nyJ=oL\n=\\?\014\014\nyo\ny= ?\\L\nq\n=?c\014uc\014\029\n22\nyb=F\nL\029o\n#=fL\014\029=oc=CLq\n\029\029?=CLq?yo?b")
    },
    {
      Text = _y85z("I?>\001=\022=;?\001q\ny=\014\029?qf=o\nLy=?2\029\nq=*?\029\029\n=?y=\nLy\n#=\127\nquLy\027?qs\029J=cyo=oc=)cqo\n\014\029=\nLy\n=\021cyW\nJ=q\nL>\001\n=\005L\029)\n=cyo=)?q\014\029=ycy=\027q\nLJ=o\nLy=\028\nf\ny=uc=W\nyL\n\014u\ny=cyo=[f\ny\029\nc\nq=?22\nq=[q\029=uc=\nq2\nf\nyb=0LyLW\n=;?\001q\n=)?q\014\029=oc=f\n\014>\001?\n\027\029LW\029=#L\029=F\nW\n2y=cyo=w\nqW\014\029\nLW\nyb\014")
    },
    {
      Text = _y85z("[c\027=\nLy\nq=M\nL\014\n=)cqo\n\014\029=oc=xDy=\nLy\n#=CDy\014\029\nq=W\n\027?yW\nyW\nyD##\nyJ=o?\014u=oL>\001=y?>s\029=:c?\n2\nyJ=u\nq\014\029c\n>s\n2y=cyo=?c\027\027q\n\014\014\ny=)D22\029\nb=\rD>\001=oc=)cqo\n\014\029=xDy=\005L22L?#=\005Dyo\nq)Dqs\014=xDy=o\nq=v?2?#?\014>?=W\nq\n\029\029\n\029b=\rcq>\001=oL\n=[c\027q\nWcyW=)cqo\n\014\029=oc=\027c\nq=\nLyLW\n=CDy?\029\n=\014\nLy\n=*\n2L\nf\029\nb=0q=\027c\n\001q\029\n=oL>\001=Ly=oL\n=\005\n2\029=o\n\014=-\nf\nqy?\029c\nq2L>\001\ny=\nLyb")
    },
    {
      Text = _y85z("\rL\n=?f)\n>\001\014\n2cyW\014q\nL>\001\ny=*\n\027?\001q\ny=f\nL=o\nq=[qf\nL\029=\027c\nq=oL\n=v?2?#?\014>?=)?q\ny=\027c\nq=oL>\001=xL\n2=Ly\029\nq\n\014\014?y\029\nq=?2\014=o\nLy\n=fL\014\001\nqLW\ny=\127DffL\n\014b=\005L22L?#=\005Dyo\nq)Dqs\014=\027?yo=f?2o=y\nc\n=_q\ncyoLyy\nyJ=cyo=\014D=\nyo\n\029\n=\ncq\n=\028L\nf\014>\001?\027\029=cyo=)cqo\n=ucq=_q\ncyo\014>\001?\027\029b=\rc=)cqo\n\014\029=ycy=\nLy\n=\nLW\ny\014\029?\nyoLW\n=[W\ny\029Ly=o\nq=v?2?#?\014>?b")
    },
    {
      Text = _y85z("\r?=oc=\014\n\001q=q\nL>\001=fL\014\029=cyo=o\nLy\n=M\nL\014\ny=cyo=0Ly\014?\n\029u\n=WqD\n\014u\029\ny\029\nL2\014=\014\n2f\014\029=\027Ly?yuL\nq\014\029J=fL\014\029=oc=Ly=o\nq=v?2?\014#?\014>?=\014D=\nLy\n=[q\029=p\005L2o>?qopb=\rc=yL##\014\029=s\nLy\n=[y)\nL\014cyW\ny=\ny\029W\nW\nyJ=\014Dyo\nqy=ycq=wL\029\029\ny=cyo=}Dq\014>\0012?\nW\nJ=cyo=s?yy\014\029=oLq=o?\001\nq=oL\n\021\nyLW\ny=[c\027\029q?\nW\n=?c\014\014c>\001\nyJ=oL\n=?#=\014\\?yy\nyo\014\029\ny=s2LyW\nyb=_c\nq=Qy\027Dq#?\029LDy\ny=cyo=#?WL\014>\001\n=\127L2\027\014#L\029\029\n2=fL\014\029=oc=?f\nq=oD>\001=?c\027=oL\n=v?2?#?\014>?=?yW\n)L\n\014\nyb")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _vyD()
  ZZZ = ((_y85z("\022lb") .. 591968) .. _y85z("J=l\031bV")) .. 69430
  erstelleZoneAnhandVonKoords(ZZZ, XXX, 12)
end
function erstelleZoneAnhandVonKoords(koords, zone, radius)
  local laengengrad = string.sub(koords, 1, 9)
  local breitengrad = string.sub(koords, 12, 19)
  local L = tonumber(laengengrad)
  local B = tonumber(breitengrad)
  local zonenMitte = Wherigo.ZonePoint(L, B, 0)
  setZone(zone, zonenMitte, radius)
end
function setZone(zone, center, radius)
  local dist = Wherigo.Distance(radius, "m")
  zone.Active = false
  zone.Points = {
    Wherigo.TranslatePoint(center, dist, 22.5),
    Wherigo.TranslatePoint(center, dist, 67.5),
    Wherigo.TranslatePoint(center, dist, 112.5),
    Wherigo.TranslatePoint(center, dist, 157.5),
    Wherigo.TranslatePoint(center, dist, 202.5),
    Wherigo.TranslatePoint(center, dist, 247.5),
    Wherigo.TranslatePoint(center, dist, 292.5),
    Wherigo.TranslatePoint(center, dist, 337.5)
  }
end
return _5sy
