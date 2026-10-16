require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _RRGy(str)
  local res = ""
  local dtable = "b\b|?!`FIZdG,$9hcS\au/Ym\018\020@OU.e}q\rX\017r-\029\024f[Ho{:\000Kw)\025\\\022y3(<P2&v\016kz\004l;j_8\n\"N\00270x6\001>\vQ 5+i]\015t^'\014\fg\003sEDJL\005CW\030*\031%n\t\006\028V4TMA#\027B\021\026~p\023Ra=\0191"
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
_1Cutl = Wherigo.ZCartridge()
_xdSa = Wherigo.ZMedia(_1Cutl)
_xdSa.Id = "e0bb5c6b-4c5a-41a9-bee6-e86441837811"
_xdSa.Name = _RRGy("\aT^\016\015\029#")
_xdSa.Description = ""
_xdSa.AltText = ""
_xdSa.Resources = {
  {
    Type = "jpg",
    Filename = "Seemann.jpg",
    Directives = {}
  }
}
_gHl = Wherigo.ZMedia(_1Cutl)
_gHl.Id = "8063d197-9584-4eee-b4f6-a8dc39ef3322"
_gHl.Name = _RRGy("_Tj'|\015#WQn\029#\001*W\029j")
_gHl.Description = ""
_gHl.AltText = ""
_gHl.Resources = {
  {
    Type = "png",
    Filename = "Durchfahrtverboten.png",
    Directives = {}
  }
}
_1Cutl.Id = "fe850f93-8aca-4ed6-8338-4d6568a4764e"
_1Cutl.Name = "Der Faehrmann von Rahnsdorf"
_1Cutl.Description = ""
_1Cutl.Visible = true
_1Cutl.Activity = "Geocache"
_1Cutl.StartingLocationDescription = ""
_1Cutl.StartingLocation = ZonePoint(52.436717, 13.681133, 0)
_1Cutl.Version = "1"
_1Cutl.Company = ""
_1Cutl.Author = "lingming"
_1Cutl.BuilderVersion = "URWIGO 1.22.5798.37755"
_1Cutl.CreateDate = "06/03/2020 19:11:13"
_1Cutl.PublishDate = "1/1/0001 12:00:00 AM"
_1Cutl.UpdateDate = "06/14/2020 18:17:19"
_1Cutl.LastPlayedDate = "1/1/0001 12:00:00 AM"
_1Cutl.TargetDevice = "PocketPC"
_1Cutl.TargetDeviceVersion = "0"
_1Cutl.StateId = "1"
_1Cutl.CountryId = "2"
_1Cutl.Complete = false
_1Cutl.UseLogging = true
_SGoLK = Wherigo.Zone(_1Cutl)
_SGoLK.Id = "9c99a540-2b1d-4559-8219-81037962365a"
_SGoLK.Name = _RRGy("b*^Q\\\029\015WQ\029^")
_SGoLK.Description = ""
_SGoLK.Visible = false
_SGoLK.Commands = {}
_SGoLK.DistanceRange = Distance(-1, "feet")
_SGoLK.ShowObjects = "OnEnter"
_SGoLK.ProximityRange = Distance(60, "meters")
_SGoLK.AllowSetPositionTo = false
_SGoLK.Active = false
_SGoLK.Points = {
  ZonePoint(52.4367086968625, 13.6810182225083, 0),
  ZonePoint(52.4367215992659, 13.6811028787632, 0),
  ZonePoint(52.436666764025, 13.681192826034, 0),
  ZonePoint(52.4365990262802, 13.6810764236836, 0)
}
_SGoLK.OriginalPoint = ZonePoint(52.4366740216084, 13.6810975877473, 0)
_SGoLK.DistanceRangeUOM = "Feet"
_SGoLK.ProximityRangeUOM = "Meters"
_SGoLK.OutOfRangeName = ""
_SGoLK.InRangeName = ""
_Eqa = Wherigo.Zone(_1Cutl)
_Eqa.Id = "cc37f5f2-a2d6-485e-ab2e-ad9da848d2aa"
_Eqa.Name = _RRGy("\017\016\015T''^\016\015\019yy\029j")
_Eqa.Description = ""
_Eqa.Visible = true
_Eqa.Commands = {}
_Eqa.DistanceRange = Distance(-1, "feet")
_Eqa.ShowObjects = "OnEnter"
_Eqa.ProximityRange = Distance(60, "meters")
_Eqa.AllowSetPositionTo = false
_Eqa.Active = true
_Eqa.Points = {
  ZonePoint(52.4363836345353, 13.6807547287151, 0),
  ZonePoint(52.4361885395307, 13.68064366024, 0),
  ZonePoint(52.4363490502035, 13.6804037941988, 0),
  ZonePoint(52.4364224238131, 13.6806703382109, 0)
}
_Eqa.OriginalPoint = ZonePoint(52.4363359120206, 13.6806181303412, 0)
_Eqa.DistanceRangeUOM = "Feet"
_Eqa.ProximityRangeUOM = "Meters"
_Eqa.OutOfRangeName = ""
_Eqa.InRangeName = ""
_oXw = Wherigo.Zone(_1Cutl)
_oXw.Id = "afa83273-0da6-4d62-8684-e3a5f22086d0"
_oXw.Name = _RRGy("\127Q_Tj'|\015#WQ\\\029^y")
_oXw.Description = ""
_oXw.Visible = false
_oXw.Commands = {}
_oXw.DistanceRange = Distance(-1, "feet")
_oXw.ShowObjects = "OnEnter"
_oXw.ProximityRange = Distance(60, "meters")
_oXw.AllowSetPositionTo = false
_oXw.Active = false
_oXw.Points = {
  ZonePoint(52.4351349205259, 13.680708431823, 0),
  ZonePoint(52.4352333047707, 13.6812243058762, 0),
  ZonePoint(52.4354961992982, 13.6809703371115, 0),
  ZonePoint(52.4353313435622, 13.6805314490427, 0),
  ZonePoint(52.435228120972, 13.6806425603772, 0)
}
_oXw.OriginalPoint = ZonePoint(52.4352847778258, 13.6808154168461, 0)
_oXw.DistanceRangeUOM = "Feet"
_oXw.ProximityRangeUOM = "Meters"
_oXw.OutOfRangeName = ""
_oXw.InRangeName = ""
_e6r2 = Wherigo.Zone(_1Cutl)
_e6r2.Id = "af108f6f-3a43-4efc-a9c5-57123bb908ab"
_e6r2.Name = _RRGy("9Q\017*\\Q\019j\nQ")
_e6r2.Description = ""
_e6r2.Visible = false
_e6r2.Commands = {}
_e6r2.DistanceRange = Distance(-1, "feet")
_e6r2.ShowObjects = "OnEnter"
_e6r2.ProximityRange = Distance(60, "meters")
_e6r2.AllowSetPositionTo = false
_e6r2.Active = false
_e6r2.Points = {
  ZonePoint(52.4341758056512, 13.678998148446, 0),
  ZonePoint(52.4340145160184, 13.6795960332461, 0),
  ZonePoint(52.4336080635257, 13.6794955039434, 0),
  ZonePoint(52.4336200753363, 13.6786637204193, 0),
  ZonePoint(52.4339620117174, 13.6786795934671, 0),
  ZonePoint(52.4339942697296, 13.6788065778494, 0)
}
_e6r2.OriginalPoint = ZonePoint(52.4338957903298, 13.6790399295619, 0)
_e6r2.DistanceRangeUOM = "Feet"
_e6r2.ProximityRangeUOM = "Meters"
_e6r2.OutOfRangeName = ""
_e6r2.InRangeName = ""
_uIptx = Wherigo.Zone(_1Cutl)
_uIptx.Id = "ebdf56e8-c64d-4c9a-a617-9fc5ce493c4e"
_uIptx.Name = _RRGy("5Qq\019\\\\\029@\015*#W")
_uIptx.Description = ""
_uIptx.Visible = false
_uIptx.Commands = {}
_uIptx.DistanceRange = Distance(-1, "feet")
_uIptx.ShowObjects = "OnEnter"
_uIptx.ProximityRange = Distance(60, "meters")
_uIptx.AllowSetPositionTo = false
_uIptx.Active = false
_uIptx.Points = {
  ZonePoint(52.4334026544989, 13.6757293652389, 0),
  ZonePoint(52.4334897521832, 13.6759092597805, 0),
  ZonePoint(52.4335768496953, 13.6756738095716, 0),
  ZonePoint(52.433494267887, 13.6755526030523, 0)
}
_uIptx.OriginalPoint = ZonePoint(52.4334908810661, 13.6757162594108, 0)
_uIptx.DistanceRangeUOM = "Feet"
_uIptx.ProximityRangeUOM = "Meters"
_uIptx.OutOfRangeName = ""
_uIptx.InRangeName = ""
_9h6A = Wherigo.Zone(_1Cutl)
_9h6A.Id = "7eff2f52-4064-4022-9578-6ec740949bb1"
_9h6A.Name = _RRGy("oQp|\019\016\015|#\001\029TW\029j")
_9h6A.Description = ""
_9h6A.Visible = false
_9h6A.Commands = {}
_9h6A.DistanceRange = Distance(-1, "feet")
_9h6A.ShowObjects = "OnEnter"
_9h6A.ProximityRange = Distance(60, "meters")
_9h6A.AllowSetPositionTo = false
_9h6A.Active = false
_9h6A.Points = {
  ZonePoint(52.4316021805446, 13.6774883263646, 0),
  ZonePoint(52.4316747649253, 13.6777449406372, 0),
  ZonePoint(52.4314908842619, 13.6779989094019, 0),
  ZonePoint(52.431449040002, 13.6775975807094, 0)
}
_9h6A.OriginalPoint = ZonePoint(52.4315542174335, 13.6777074392783, 0)
_9h6A.DistanceRangeUOM = "Feet"
_9h6A.ProximityRangeUOM = "Meters"
_9h6A.OutOfRangeName = ""
_9h6A.InRangeName = ""
_9ZS = Wherigo.Zone(_1Cutl)
_9ZS.Id = "d51982ae-3ccf-4498-8be1-ded796eb8d44"
_9ZS.Name = _RRGy("RQG\029\019Q)\029@\\*@|j\n")
_9ZS.Description = ""
_9ZS.Visible = false
_9ZS.Commands = {}
_9ZS.DistanceRange = Distance(-1, "feet")
_9ZS.ShowObjects = "OnEnter"
_9ZS.ProximityRange = Distance(60, "meters")
_9ZS.AllowSetPositionTo = false
_9ZS.Active = false
_9ZS.Points = {
  ZonePoint(52.429276389079, 13.6829801921912, 0),
  ZonePoint(52.4289376425137, 13.6834246375293, 0),
  ZonePoint(52.4290828199319, 13.6824246355185, 0)
}
_9ZS.OriginalPoint = ZonePoint(52.4290989505082, 13.6829431550797, 0)
_9ZS.DistanceRangeUOM = "Feet"
_9ZS.ProximityRangeUOM = "Meters"
_9ZS.OutOfRangeName = ""
_9ZS.InRangeName = ""
_VlC7 = Wherigo.Zone(_1Cutl)
_VlC7.Id = "13511c82-3385-43e5-afa7-c75d08f8d240"
_VlC7.Name = _RRGy("{|\015j^\n*#'")
_VlC7.Description = ""
_VlC7.Visible = false
_VlC7.Commands = {}
_VlC7.DistanceRange = Distance(-1, "feet")
_VlC7.ShowObjects = "OnEnter"
_VlC7.ProximityRange = Distance(60, "meters")
_VlC7.AllowSetPositionTo = false
_VlC7.Active = false
_VlC7.Points = {
  ZonePoint(52.4300167, 13.6889667, 0),
  ZonePoint(52.4300167, 13.6889667, 0),
  ZonePoint(52.4299965369255, 13.6889243718726, 0),
  ZonePoint(52.4299368329621, 13.6889349050938, 0),
  ZonePoint(52.429976352633, 13.6890407254124, 0)
}
_VlC7.OriginalPoint = ZonePoint(52.4299886245041, 13.6889666804758, 0)
_VlC7.DistanceRangeUOM = "Feet"
_VlC7.ProximityRangeUOM = "Meters"
_VlC7.OutOfRangeName = ""
_VlC7.InRangeName = ""
_Mvmtg = Wherigo.Zone(_1Cutl)
_Mvmtg.Id = "1636c5bd-39b8-49d7-a5c9-b10db8ed452e"
_Mvmtg.Name = _RRGy("e|^^\029#y\019\022y\029")
_Mvmtg.Description = ""
_Mvmtg.Visible = false
_Mvmtg.Commands = {}
_Mvmtg.DistanceRange = Distance(-1, "feet")
_Mvmtg.ShowObjects = "OnEnter"
_Mvmtg.ProximityRange = Distance(60, "meters")
_Mvmtg.AllowSetPositionTo = false
_Mvmtg.Active = false
_Mvmtg.Points = {
  ZonePoint(52.4304618609124, 13.6882462628885, 0),
  ZonePoint(52.4304425045565, 13.6882885910159, 0),
  ZonePoint(52.4304554087947, 13.6883335646513, 0),
  ZonePoint(52.4304651031847, 13.688319824492, 0),
  ZonePoint(52.4304804269592, 13.6882960149203, 0)
}
_Mvmtg.OriginalPoint = ZonePoint(52.4304610608815, 13.6882968515936, 0)
_Mvmtg.DistanceRangeUOM = "Feet"
_Mvmtg.ProximityRangeUOM = "Meters"
_Mvmtg.OutOfRangeName = ""
_Mvmtg.InRangeName = ""
_ZbQOf = Wherigo.Zone(_1Cutl)
_ZbQOf.Id = "ae243000-b0f6-482e-b5bb-f8a6cd0c9df7"
_ZbQOf.Name = _RRGy("\aT^\016\015\029#\022\029T^W\029#Qr\019\\\019^WQ)\029#\022|jj")
_ZbQOf.Description = ""
_ZbQOf.Visible = false
_ZbQOf.Commands = {}
_ZbQOf.DistanceRange = Distance(-1, "feet")
_ZbQOf.ShowObjects = "OnEnter"
_ZbQOf.ProximityRange = Distance(60, "meters")
_ZbQOf.AllowSetPositionTo = false
_ZbQOf.Active = false
_ZbQOf.Points = {
  ZonePoint(52.4309207325315, 13.6891878640637, 0),
  ZonePoint(52.4309078284295, 13.6891442131823, 0),
  ZonePoint(52.4308844397351, 13.6892143191433, 0),
  ZonePoint(52.4309054579513, 13.6892391385097, 0)
}
_ZbQOf.OriginalPoint = ZonePoint(52.4309046146618, 13.6891963837248, 0)
_ZbQOf.DistanceRangeUOM = "Feet"
_ZbQOf.ProximityRangeUOM = "Meters"
_ZbQOf.OutOfRangeName = ""
_ZbQOf.InRangeName = ""
_pJ3zC = Wherigo.Zone(_1Cutl)
_pJ3zC.Id = "3c7c18d5-cca0-458c-b59b-a565c43f73f8"
_pJ3zC.Name = _RRGy("\aT^\016\015\029#Q.|\015@\029j\001\029#\\")
_pJ3zC.Description = ""
_pJ3zC.Visible = false
_pJ3zC.Commands = {}
_pJ3zC.DistanceRange = Distance(-1, "feet")
_pJ3zC.ShowObjects = "OnEnter"
_pJ3zC.ProximityRange = Distance(60, "meters")
_pJ3zC.AllowSetPositionTo = false
_pJ3zC.Active = false
_pJ3zC.Points = {
  ZonePoint(52.4306667, 13.68885, 0),
  ZonePoint(52.4306667, 13.68885, 0),
  ZonePoint(52.4306483017551, 13.6888620699406, 0),
  ZonePoint(52.430663706724, 13.6888918284633, 0),
  ZonePoint(52.4306829226618, 13.688875064657, 0)
}
_pJ3zC.OriginalPoint = ZonePoint(52.4306656662282, 13.6888657926122, 0)
_pJ3zC.DistanceRangeUOM = "Feet"
_pJ3zC.ProximityRangeUOM = "Meters"
_pJ3zC.OutOfRangeName = ""
_pJ3zC.InRangeName = ""
_2_N = Wherigo.Zone(_1Cutl)
_2_N.Id = "07b7f41c-c6d5-438b-b700-163bfe78f116"
_2_N.Name = _RRGy("r@W\029^Q\aT^\016\015\029#\n*#'Q{|\015j^\n*#'")
_2_N.Description = ""
_2_N.Visible = false
_2_N.Commands = {}
_2_N.DistanceRange = Distance(-1, "feet")
_2_N.ShowObjects = "OnEnter"
_2_N.ProximityRange = Distance(60, "meters")
_2_N.AllowSetPositionTo = false
_2_N.Active = false
_2_N.Points = {
  ZonePoint(52.4309667, 13.6891833, 0),
  ZonePoint(52.4309667, 13.6891833, 0),
  ZonePoint(52.4309667, 13.6891833, 0),
  ZonePoint(52.4309519449108, 13.6892123524406, 0),
  ZonePoint(52.4309372264108, 13.6891841892459, 0),
  ZonePoint(52.4309531714523, 13.6891452972152, 0)
}
_2_N.OriginalPoint = ZonePoint(52.4309570737956, 13.6891819564836, 0)
_2_N.DistanceRangeUOM = "Feet"
_2_N.ProximityRangeUOM = "Meters"
_2_N.OutOfRangeName = ""
_2_N.InRangeName = ""
_J18 = Wherigo.Zone(_1Cutl)
_J18.Id = "aea295e5-b707-4394-8985-a46e4ce614c9"
_J18.Name = _RRGy("G|W\019#\n\029j=\022|@")
_J18.Description = ""
_J18.Visible = false
_J18.Commands = {}
_J18.DistanceRange = Distance(-1, "feet")
_J18.ShowObjects = "OnEnter"
_J18.ProximityRange = Distance(60, "meters")
_J18.AllowSetPositionTo = false
_J18.Active = false
_J18.Points = {
  ZonePoint(52.4312833, 13.6899333, 0),
  ZonePoint(52.4312833, 13.6899333, 0),
  ZonePoint(52.4312824772427, 13.6899130587233, 0),
  ZonePoint(52.4312565349889, 13.6899372194269, 0),
  ZonePoint(52.431287607147, 13.6900069568612, 0),
  ZonePoint(52.431305859875, 13.6899540014586, 0)
}
_J18.OriginalPoint = ZonePoint(52.4312831798756, 13.6899463060783, 0)
_J18.DistanceRangeUOM = "Feet"
_J18.ProximityRangeUOM = "Meters"
_J18.OutOfRangeName = ""
_J18.InRangeName = ""
_Ae_ = Wherigo.Zone(_1Cutl)
_Ae_.Id = "05383385-386d-4505-a0b8-6b2bbeac3849"
_Ae_.Name = _RRGy("\aTj|@")
_Ae_.Description = ""
_Ae_.Visible = true
_Ae_.Commands = {}
_Ae_.DistanceRange = Distance(-1, "feet")
_Ae_.ShowObjects = "OnEnter"
_Ae_.ProximityRange = Distance(60, "meters")
_Ae_.AllowSetPositionTo = false
_Ae_.Active = false
_Ae_.Points = {
  ZonePoint(52.43335, 13.693, 0),
  ZonePoint(52.43335, 13.693, 0),
  ZonePoint(52.43335, 13.693, 0),
  ZonePoint(52.4333273271128, 13.6930509168054, 0),
  ZonePoint(52.4333577677098, 13.6930927487773, 0),
  ZonePoint(52.4333635267393, 13.6930097595425, 0)
}
_Ae_.OriginalPoint = ZonePoint(52.4333497702603, 13.6930255708542, 0)
_Ae_.DistanceRangeUOM = "Feet"
_Ae_.ProximityRangeUOM = "Meters"
_Ae_.OutOfRangeName = ""
_Ae_.InRangeName = ""
_4Cvc = Wherigo.ZCharacter(_1Cutl)
_4Cvc.Id = "ab6142ee-0d3a-4b62-9df1-e9891692d80d"
_4Cvc.Name = _RRGy("\aT^\016\015\029#")
_4Cvc.Description = ""
_4Cvc.Visible = true
_4Cvc.Media = _xdSa
_4Cvc.Commands = {}
_4Cvc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_4Cvc.Gender = "Male"
_4Cvc.Type = "NPC"
_0v7n = _RRGy("C\017\v*b.")
_Y7Br = _RRGy("Cod;\016")
_tSp = _RRGy("\n\019\022\0224")
_8s0M8 = _RRGy("\n\019\022\0224")
_DXw = _RRGy("C9)\027\016")
_VOz = _RRGy("\n\019\022\0224")
_1Cutl.ZVariables = {
  _0v7n = _RRGy("C\017\v*b."),
  _Y7Br = _RRGy("Cod;\016"),
  _tSp = _RRGy("\n\019\022\0224"),
  _8s0M8 = _RRGy("\n\019\022\0224"),
  _DXw = _RRGy("C9)\027\016"),
  _VOz = _RRGy("\n\019\022\0224")
}
_2HUc = Wherigo.ZInput(_1Cutl)
_2HUc.Id = "6cc4bba5-7c92-4174-976b-abfb2e773464"
_2HUc.Name = _RRGy("\v|#|\\\029")
_2HUc.Description = ""
_2HUc.Visible = true
_2HUc.InputType = "Text"
_2HUc.Text = _RRGy("u\029\\Tjj\029jQ/T#Q\\|j>Q\029Tj'|\016\015\028Q\027\022Q>\019Q\019j^\029#\029\022Qu**WQ>\019Q\\\029@|j\\\029jQ@|\019'\029jQ/T#Q\015T\029#QB\029\022|j\n\029jQ'|^WQ\n\019#\016\015Q\n\029jQ\v|#W\029j\028Qe\029@\016\015\029Q)|\019^j\019\022\022\029#Q^W\029\015WQ|jQ\n\029#Q\\\029@\001\029jQ\v|#|\\\029\004")
_l4e = Wherigo.ZInput(_1Cutl)
_l4e.Id = "1639d2a1-2283-46a7-a0d9-015ea4106d8b"
_l4e.Name = _RRGy("\017\016\015\019yy\029j")
_l4e.Description = ""
_l4e.Visible = true
_l4e.InputType = "Text"
_l4e.Text = _RRGy("u\029;*#Q/T#Q@*^Q'|\015#\029j\028Q\017\016\015|\019Q\022|@\fQ\015T\029#QT^WQj*\016\015Q\029TjQ|@W\029#Q\017\016\015T''^\016\015\019yy\029\028QbTj=^Qj\029\001\029jQ\n\029\022Q_Tj'|\015#W^W*#Q^W\029\015WQ\029Tj\029Qu|j=Q\022TWQ\029Tj\029#Q=@\029Tj\029jQb|W\029#j\029\028Qe\029@\016\015\029Q\a|#\001\029Q\015|WQ\n|^Q\v\029\015|\029\019^\029Q\n\029#Qb|W\029#j\029Q*\001\029j\004")
__BmS = Wherigo.ZInput(_1Cutl)
__BmS.Id = "77bee832-3ce5-4fa9-9242-597aebe2c098"
__BmS.Name = _RRGy("\017*\\Q\019j\nQe\029@@\029j^\016\015@|\\")
__BmS.Description = ""
__BmS.Visible = true
__BmS.InputType = "Text"
__BmS.Text = _RRGy(")T\029#QT^WQ\\@\029T\016\015Q^*Q\029TjQ\017\016\015T@\nQ\n\029#QuTjjj^\016\015T'''|\015#W\028Q_^Q\001\029\n\029\019W\029WQF\017*\\Q\019j\nQe\029@@\029j^\016\015@|\\Q;\029#\022\029T\n\029jFQeT\029Q;T\029@\029Qe\029@@\029jQ^Tj\nQ|\019\016\015Q\n\029\022Q\017\016\015T@\nQ|\001\\\029\001T@\n\029W\004")
_rFOIk = Wherigo.ZInput(_1Cutl)
_rFOIk.Id = "71ea4154-c9b0-489f-94be-0dcb2ca90e8b"
_rFOIk.Name = _RRGy("\127Q_Tj'|\015#WQ\\\029^y\029##W")
_rFOIk.Description = ""
_rFOIk.Visible = true
_rFOIk.InputType = "Text"
_rFOIk.Text = _RRGy("{\029\016\015W^Q\019j\nQ@Tj=^Q^W\029\015\029jQ\\#*^^\029Q\017\016\015T@\n\029#QT\022Qe|^^\029#Q\022TWQ\n#\029TQP\019\029#^W#\029T'\029j\028Q\017T\029Q\001\029\n\029\019W\029jQF_Tj'|\015#WQ\\\029^y\029##WFQe\029@\016\015\029Q\a|#\001\029jQ\015|\001\029jQ\nT\029Q\017W#\029T'\029j\004Q:j\001^yAr@^Qb*\029^\019j\\Q\nT\029Qrj'|j\\^\001\019\016\015^W|\001\029jQ\n\029#Q\a|#\001\029jQ*\015j\029Qb\029\015#>\029T\016\015\029jQ;*jQ*\001\029jQj|\016\015Q\019jW\029jQ\029TjW#|\\\029j\028")
_cu5 = Wherigo.ZInput(_1Cutl)
_cu5.Id = "83f54a84-b97a-4c3f-ad79-4d877444beba"
_cu5.Name = _RRGy("9Q\017*\\Q\019j\nQe\029@@\029j^\016\015@|\\")
_cu5.Description = ""
_cu5.Visible = true
_cu5.InputType = "Text"
_cu5.Text = _RRGy("G*\016\015Q\029TjQ\017\016\015T'''|\015#W^\016\015T@\n\028Qe\029T^^Q\022TWQ#*W\029\022Q{|j\nQ\019j\nQe\029@@\029jQ\n|#Tj\028_^Q\001\029\n\029\019W\029WQF\017*\\Q\019j\nQe\029@@\029j^\016\015@|\\Q;\029#\022\029T\n\029jFQeT\029Q;T\029@\029Qe\029@@\029jQ^Tj\nQ\n|#|\019'Q|\001\\\029\001T@\n\029W\004")
_z36m_ = Wherigo.ZInput(_1Cutl)
_z36m_.Id = "e746e470-818b-44b0-b539-eee2e32f7234"
_z36m_.Name = _RRGy("5Qq\019\\\\\029@\015*#W")
_z36m_.Description = ""
_z36m_.Visible = true
_z36m_.InputType = "Text"
_z36m_.Text = _RRGy("G\019jQ^Tj\nQ/T#Q|jQ\019j^\029#\029\022Q\029#^W\029jQ\017W*yyQ|j\\\029=*\022\022\029j\028QFq\019\029\\\\\029@\015*#WQF\028Qr\022Qrj@\029\\\029#Q^W\029\015WQ\029TjQF8|#=\029jQ;\029#\001*W\029jFQ\017\016\015T@\n\028Q6`|^Q\\#*^^\029Q\017\016\015T@\nQ\022TWQ\n\029\022Q\n\019#\016\015\\\029^W#T\016\015\029j\029jQ80Q#\029\016\015W^Q\019j\nQ@Tj=^Q\n|;*jQ^Tj\nQ\\#*^^\029Q\t|\015@\029j\fQ^T\029Q\\\029\001\029jQ\nT\029Qq\029W\029#QTjQ\001\029T\n\029Q{T\016\015W\019j\\jQTjQ\nT\029Q\n|^Q8|#=\029jQ;\029#\001*W\029jQT^WQ|j\028Q\017\016\015#\029T\001\029Q\001\029T\n\029Q*\015j\029Qb\029\015#\029>T\016\015\029jQ\015TjW\029#\029Tj|j\n\029#Q|@^Qb*\029^\019j\\\028")
_w4d4 = Wherigo.ZInput(_1Cutl)
_w4d4.Id = "0787ef28-c827-4200-a2c2-03880b168b8f"
_w4d4.Name = _RRGy("oQp|\019\016\015|#\001\029TW\029j")
_w4d4.Description = ""
_w4d4.Visible = true
_w4d4.InputType = "Text"
_w4d4.Text = _RRGy("G\019jQ\n#\029\015Q\nT\016\015Q\029TjQ\022|@Q\019\022\028Q_TjQ^\029\015#Q\\#*^^\029^Q\017\016\015T@\nQ/|#jWQ;*#Q\028\028\028\028Qr#\001\029TW\029jQTjQ\n\029\022Qj\019jQ\015TjW\029#Q\019j^Q@T\029\\\029j\n\029jQp\029T@\028Q7u{N7u{Nn*#Q/|^Q'\019#Qr##\001\029TW\029jQ/T#\nQ\015T\029#Q\\\029/|#jW\004Q6`|^Q\\|j>\029Qe*#W0")
_HR6F = Wherigo.ZInput(_1Cutl)
_HR6F.Id = "9015d2b6-de50-4c22-9fe7-c05587af9a46"
_HR6F.Name = _RRGy("RQG\029\019Q)\029@\\*@|j\n")
_HR6F.Description = ""
_HR6F.Visible = true
_HR6F.InputType = "Text"
_HR6F.Text = _RRGy("rj\\\029=*\022\022\029jQ|\022Qrj@\029\\\029#QFG\029\019Q)\029@\\*@|j\nF\028Qn*#Q\019j^QT^WQ\029TjQ\017\016\015T@\nQ\022TWQ\029Tj\029\022Q/\029T^^\029jQ\017\016\015T''Q|\019'Q\001@|\019\029\022Q\v#\019j\n\028Q_^Q\001\029\n\029\019W\029WQF'#\029TQ'|\015#\029j\n\029Q\a|\029\015#\029F\028Q7u{NeT\029Q;T\029@\029Q_\016=\029jQ\015|WQ\n|^Q8T=W*\\#|\022Q\n\029^Q\017\016\015T''\029^\004Q")
_94W = Wherigo.ZInput(_1Cutl)
_94W.Id = "5d644a2a-c288-4a6c-9096-d3f724d501de"
_94W.Name = _RRGy("LQ{|\015j^\n*#'")
_94W.Description = ""
_94W.Visible = true
_94W.InputType = "Text"
_94W.Text = _RRGy("_j\n^W|WT*jQ{|\015j^\n*#'\0287u{N7u{N)T\029#Q\015|\001\029jQ/T#Q\029Tj\029Q=@\029Tj\029Qu\029^*j\n\029#\015\029TW\028Q)T\029#Q'|\029\015#WQ|\022Qe*\016\015\029j\029j\n\029Q\019j\nQ|jQ\a\029T\029#W|\\\029jQ\nT\029Q\029Tj>T\\\029Q\015|j\n\001\029W#T\029\001\029j\029Q\a|\029\015#\029Qu\029#@Tj^\028Q`|^Q{\019\n\029#\001**WQ=*\029jjWQT\015#Q\015T\029#Q@T\029\\\029jQ^\029\015\029j\028Qe\029@\016\015\029QG\019\022\022\029#Q\015|WQ\nT\029Q\a|\029\015#\029\004")
_kVDVF = Wherigo.ZInput(_1Cutl)
_kVDVF.Id = "fa9884df-c539-432b-809e-e7fcc497940a"
_kVDVF.Name = _RRGy("IQe|^^\029#y\019\022y\029")
_kVDVF.Description = ""
_kVDVF.Visible = true
_kVDVF.InputType = "Text"
_kVDVF.Text = _RRGy("G*\016\015Q\022\029\015#Qe|^^\029#\028Q)T\029#Q>\019\022Q8\019\022y\029j\028QeT\029Q@|j\\\029Q\nT\029Q8\019\022y\029Q\015T\029#Q/*\015@Q^\016\015*jQT\015#\029Q`T\029j^W\029Q;\029#T\016\015W\029W\004Q7u{N\027\022Q/\029TW\029#Q>\019Q=*\022\022\029jQTjW\029#\029^^T\029#WQ\019j^QB\029\n*\016\015Q\nT\029Qr\019'^\016\015#T'W\028QeT\029Q@|\019W\029WQ\nT\029^\029\004")
_TtxFa = Wherigo.ZInput(_1Cutl)
_TtxFa.Id = "7b921433-f6ea-481a-a716-08794d487843"
_TtxFa.Name = _RRGy("DQ:j\001^yA\aT^\016\015\029#\022\029T^W\029#Qr\019\\\019^WQ)\029#\022|jj")
_TtxFa.Description = ""
_TtxFa.Visible = true
_TtxFa.InputType = "Text"
_TtxFa.Text = _RRGy("_TjQ\017W\019\029\016=Q>\019#\019\029\016=QTjQ\n\029#Q\t\029TW\028Q)T\029#Q^W\029\015WQT\015#Q;*#Q\n\029\022Q\v\029\n\029j=^W\029TjQ;*jQ\aT^\016\015\029#\022\029T^W\029#Qr\019\\\019^WQ)\029#\022|jj\028Qn\029#\022\019W@T\016\015Q/|#Q\nT\029^\029#Q;*jQ\029Tj\029\022Qp\029T@Q\n\029#Q\bjj^\016\015#T'WQ\n\029^Q.|\015@\029j\001\029#\\=#\029\019>\029^Q6\n|^Q^\016\015|\019\029jQ/T#Q\019j^Q\\@\029T\016\015Q|j0Q\001\029\029Tj\n#\019\016=WQ\019j\nQ'\019\015#Q\n|\015\029#Q\001\029TQ|\019'=*\022\022\029j\n\029\022Q\017W\019#\022Q>\019\022Q\027'\029#Q\n\029^Qq\019\029\\\\\029@^\029\029Q\019\022Q_#W#Tj=\029j\n\029Q>\019Q#\029WW\029j\028Q`|'\019\029#Q\029#\015T\029@WQ\029#Q\nT\029QF{\029WW\019j\\^\022\029\n|T@@\029Q\022TWQ\n\029\022Qu|j\n\029F\028Q7u{Ne|jjQ/|#Q\nT\029^\004")
_2Xavr = Wherigo.ZInput(_1Cutl)
_2Xavr.Id = "b6c4a808-8c80-4144-851e-724a3a1f0498"
_2Xavr.Name = _RRGy("\014Q\aT^\016\015\029#Q.|\015@\029j\001\029#\\")
_2Xavr.Description = ""
_2Xavr.Visible = true
_2Xavr.InputType = "Text"
_2Xavr.Text = _RRGy(")T\029#Q^W\029\015\029jQ/T#Qj\019jQ;*#Q\n\029\022Q.#\029\019>Q\n\029^Q\aT^\016\015\029#Q.|\015@\029j\001\029#\\\fQ\n\029#Q|\022Q\014\028Q\026=W*\001\029#Q\127DL5Q|\019'Q\n\029\022Qq\019\029\\\\\029@^\029\029Q\029#W#|j=\028Q7u{Nr\019'Q\n\029#Q{\019\029\016=^\029TW\029Q\n\029^Q.#\029\019>\029^QT^WQ\029Tj\029Q\bjj^\016\015#T'W\028Q7u{N\027\022Q/\029TW\029#Q>\019Q=*\022\022\029jQW#|\\WQ\nT\029Qrj'|j\\^\001\019\016\015^W|\001\029jQ\n\029#Q\bjj^\016\015#T'WQB\029\n\029#Q{\029T\015\029Q\015TjW\029\029Tj|j\n\029#Q*\015j\029Qb\029\015#>\029T\016\015\029jQ\029Tj\028Q")
_e0OIi = Wherigo.ZInput(_1Cutl)
_e0OIi.Id = "ca5ebe76-9cea-4316-a1a8-02c9304bba22"
_e0OIi.Name = _RRGy("\127JQ|@W\029^Q\aT^\016\015\029#\n*#'Q{|\015j^\n*#'")
_e0OIi.Description = ""
_e0OIi.Visible = true
_e0OIi.InputType = "Text"
_e0OIi.Text = _RRGy("\017\016\015|\019\029jQ/T#Qj*\016\015Q\029TjQ\017W\019\029\016=Q>\019#\019\029\016=\028Qe|jjQ/\019#\n\029Q\n|^Q\017\016\015T''\029#\n*#'Q\n|^Q\029#^W\029Q\022|@Q\029#/|\029\015jWW\004")
_tVZUc = Wherigo.ZInput(_1Cutl)
_tVZUc.Id = "e2d7ec81-e6d6-44ac-b254-8dfac3c74ec5"
_tVZUc.Name = _RRGy("\127\127QG|W\019#\029j=\022|@")
_tVZUc.Description = ""
_tVZUc.Visible = true
_tVZUc.InputType = "Text"
_tVZUc.Text = _RRGy("_TjQ^\029\015#Q|@W\029#Qu|\019\022Q^W\029\015WQ\015T\029#\028Q\026\001Q\029#Q/*\015@Q^\016\015*jQ;*#Q\n\029#Q\t\029TWQ\n\029^Q\027j\\@\019\029\016=Q\n\029^Q\aT^\016\015\029#Q.|\015@\029j\001\029#\\Q^W|j\nQ$Q/T#Q/T^^\029jQ\029^QjT\016\015W\028Q7u{N7u{N`\029#Q\aT^\016\015\029#Q^*@@Q\n|\022|@^Qj*\016\015Q\029TjQb*\\\001\019\016\015Q;\029#^W\029\016=WQ\015|\001\029j\028QeT#Q/\029#\n\029jQ\nT\029^\029^Q^T\016\015\029#Q\001|@\nQ'Tj\n\029j\0287u{N7u{N`|\022TWQ\n\029#Qu|\019\022Qj*\016\015Q@|j\\\029Q\015T\029#Q^W\029\015WQT^WQ\029#Q\\\019WQ\001\029'\029^WT\\W\028QeT\029Q;T\029@\029Q)\019W\022\019WW\029#jQ^Tj\nQB\029/\029T@^Q|\019'Q\029Tj\029\022Qu\029'\029^WT\\\019j\\^#Tj\\\004")
function _1Cutl:OnStart()
end
function _1Cutl:OnRestore()
end
function _SGoLK:OnEnter()
  _0v7n = _RRGy("C\017\v*b.")
  _SGoLK.Active = true
  _SGoLK.Visible = true
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_2HUc)
  end)
  _Eqa.Active = true
  _Eqa.Visible = true
  _1Cutl:RequestSync()
end
function _Eqa:OnEnter()
  _0v7n = _RRGy("C_\031|")
  _SGoLK.Active = false
  _SGoLK.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_l4e)
  end)
  _oXw.Active = true
  _Eqa.Visible = false
  _Eqa.Active = false
  _1Cutl:RequestSync()
end
function _oXw:OnEnter()
  _0v7n = _RRGy("C*!/")
  _Eqa.Active = false
  _Eqa.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_rFOIk)
  end)
  _e6r2.Active = true
  _1Cutl:RequestSync()
end
function _e6r2:OnEnter()
  _0v7n = _RRGy("C\029L#9")
  _oXw.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_cu5)
  end)
  _uIptx.Active = true
  _1Cutl:RequestSync()
end
function _uIptx:OnEnter()
  _0v7n = _RRGy("C\019\byWK")
  _e6r2.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_z36m_)
  end)
  _9h6A.Active = true
  _1Cutl:RequestSync()
end
function _9h6A:OnEnter()
  _0v7n = _RRGy("C\014\015Lr")
  _uIptx.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_w4d4)
  end)
  _9ZS.Active = true
  _1Cutl:RequestSync()
end
function _9ZS:OnEnter()
  _0v7n = _RRGy("C\014\t\017")
  _9h6A.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_HR6F)
  end)
  _VlC7.Active = true
  _VlC7.Visible = true
  _1Cutl:RequestSync()
end
function _VlC7:OnEnter()
  _0v7n = _RRGy("Cn@dI")
  _9ZS.Visible = false
  _9ZS.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_94W)
  end)
  _VlC7.Visible = false
  _Mvmtg.Active = true
  _Mvmtg.Visible = true
  _1Cutl:RequestSync()
end
function _Mvmtg:OnEnter()
  _0v7n = _RRGy("Cq;\022W\\")
  _VlC7.Active = false
  _VlC7.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_kVDVF)
  end)
  _Mvmtg.Visible = false
  _ZbQOf.Active = true
  _ZbQOf.Visible = true
  _1Cutl:RequestSync()
end
function _ZbQOf:OnEnter()
  _0v7n = _RRGy("C\t\001P\026'")
  _Mvmtg.Active = false
  _Mvmtg.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_TtxFa)
  end)
  _ZbQOf.Visible = false
  _pJ3zC.Active = true
  _pJ3zC.Visible = true
  _1Cutl:RequestSync()
end
function _pJ3zC:OnEnter()
  _0v7n = _RRGy("Cya5>d")
  _ZbQOf.Active = false
  _ZbQOf.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_2Xavr)
  end)
  _pJ3zC.Visible = false
  _2_N.Active = true
  _2_N.Visible = true
  _1Cutl:RequestSync()
end
function _2_N:OnEnter()
  _0v7n = _RRGy("C9CG")
  _pJ3zC.Active = false
  _pJ3zC.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_e0OIi)
  end)
  _2_N.Visible = false
  _J18.Active = true
  _J18.Visible = true
  _1Cutl:RequestSync()
end
function _J18:OnEnter()
  _0v7n = _RRGy("Ca\127D")
  _2_N.Active = false
  _2_N.Visible = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_tVZUc)
  end)
  _J18.Visible = false
  _Ae_.Active = true
  _Ae_.Visible = true
  _1Cutl:RequestSync()
end
function _Ae_:OnEnter()
  _0v7n = _RRGy("Cr\029C")
  _Urwigo.OldDialog({
    {
      Text = _RRGy("*\001Q\029^Q\015T\029#Q/*\015@Q\029TjQ)Tj/\029T^^\016\015T@\nQ>\019#Q\a|\029\015#\029Q\\T\001W\004Q_jW@*\016=\029QT\015\022Q\022TWQ\n\029\022Qq|\\j\029W\029jQ\n|^Qb*\\\001\019\016\015\028Q")
    }
  })
  _1Cutl.Complete = true
end
function _2HUc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 33914 then
    _Urwigo.MessageBox({
      Text = _RRGy("\v\029j|\019\fQ^*QT^WQ\029^\028Q@*^\fQ>\019\022Q\017\016\015T''\0057u{N7u{NG\019jQ/*@@\029jQ/T#Q\n*\016\015Q\029TjQ\001T^^\016\015\029jQ/|^Q\019\001\029#Q\nT\029QuTjj\029j^\016\015T''|\015#W^>\029T\016\015\029jQ@\029#j\029j\028Q")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("^\016\015|\019Qj*\016\015Q\022|@Q\\\029j|\019QL\028\028\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_2HUc)
          end)
        end
      end
    })
  end
end
function _l4e:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 6884 then
    _Urwigo.MessageBox({
      Text = _RRGy("`\019Q\015|^WQB|Q#T\016\015WT\\Q\\\019W\029Q\017\016\015T''|\015#\029#Qr\019\\\029j\028QG\019jQ@*^Q|\019'Q\nT\029Q\a|\029\015#\029\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("^\016\015|\019Q#T\016\015WT\\Q\019\022Q\nT\029Q_\016=\029Q\n\029^Q\017\016\015\019yy\029j^\0287u{N#\028\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_l4e)
          end)
        end
      end
    })
  end
end
function __BmS:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 50 then
    _Urwigo.MessageBox({
      Text = _RRGy("r\019^Q\nT#Q/T#\nQj*\016\015Q\029TjQ\029\016\015W\029#QuTjj\029j^\016\015T''\029#\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("^\016\015|\019Qj*\016\015Q\022|@Q\\\029j|\019Q"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(__BmS)
          end)
        end
      end
    })
  end
end
function _rFOIk:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 35074 then
    _Urwigo.MessageBox({
      Text = _RRGy("#T\016\015WT\\")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("^\016\015|\019Qj*\016\015Q\022|@Q\\\029j|\019Q#\028\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_rFOIk)
          end)
        end
      end
    })
  end
end
function _cu5:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 50 then
    _Urwigo.MessageBox({
      Text = _RRGy("\017*QT^WQ\029^\028Q\n\019Q\001T^WQ/*\015@QTjQ\n\029#QuTjj\029j^\016\015T'''|\015#WQ>\019Q\015|\019^\029\028Q")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("T\016\015Q\\@|\019\001\029\fQ\n\019Q\015|^WQ\nT\016\015Q;\029#>|\015@W\028Qr@^Q\tT''\029#\fQjT\016\015WQ|@^Qe*#W\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_cu5)
          end)
        end
      end
    })
  end
end
function _z36m_:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 51440 then
    _Urwigo.MessageBox({
      Text = _RRGy("^*QT^WQ\029^\005")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("^\016\015|\019Qj*\016\015Q\022|@Q\\\029j|\019Q5R\028\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_z36m_)
          end)
        end
      end
    })
  end
end
function _w4d4:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 8442 then
    _Urwigo.MessageBox({
      Text = _RRGy("#T\016\015WT\\\028Q/\029TW\029#Q\\\029\015WQ\nT\029Q\a|\015#W\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("p\028\028\028\028\028|#\001\029TW\029j"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_w4d4)
          end)
        end
      end
    })
  end
end
function _HR6F:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 56 then
    _Urwigo.MessageBox({
      Text = _RRGy("\n\019Q\001T^WQB|Q\029TjQ#T\016\015TW\\\029#QuTjj\029j^\016\015T''\029#\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("T\016\015Q\\@|\019\001\029\fQ\n\019Q\015|^WQ\nT\016\015Q;\029#>|\029\015@W\028Qr@^Q\tT''\029#\fQjT\016\015WQ|@^Qe*#W\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_HR6F)
          end)
        end
      end
    })
  end
end
function _94W:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 16102 then
    _Urwigo.MessageBox({
      Text = _RRGy("`|^Q^WT\022\022W\028QeT#Q^\029W>W\029jQB\029\n*\016\015QjT\016\015WQ\019\029\001\029#\fQ^*j\n\029#jQ:j\001^yA'\019\029#Q\019j^Q\\\029\015WQ\029^QTjQ\n|^Q\017\016\015T''\029#\n*#'Q{|\015j^\n*#'\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("\a\028\028\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_94W)
          end)
        end
      end
    })
  end
end
function _kVDVF:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 64216 then
    _Urwigo.MessageBox({
      Text = _RRGy("`|^QT^WQ#T\016\015WT\\\028Q")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("^\016\015|\019Q\022|@Q|jQ\n\029#Q{\029\016\015W\029jQ\017\029TW\029Q\n\029#Q8\019\022y\029Qj|\016\015\028Q"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_kVDVF)
          end)
        end
      end
    })
  end
end
function _TtxFa:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 8887 then
    _Urwigo.MessageBox({
      Text = _RRGy("\017*Q/|#Q\029^\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("\017\016\015|\019Qj*\016\015Q\022|@\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_TtxFa)
          end)
        end
      end
    })
  end
end
function _2Xavr:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 22168 then
    _Urwigo.MessageBox({
      Text = _RRGy("@|^^Q\019j^Q/\029TW\029#Q\\\029\015\029j\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("jT\016\015WQ\\|j>\028Q\n|;\028\028\028\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_2Xavr)
          end)
        end
      end
    })
  end
end
function _e0OIi:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 23180 then
    _Urwigo.MessageBox({
      Text = _RRGy("^*Q@|j\\\029QT^WQ\n|^Q^\016\015*jQ\015\029#\028Qb|^^Q\019j^Q/\029TW\029#Q\\\029\015\029j\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("\n|^QT^WQ@\029T\n\029#Q'|@^\016\015\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_e0OIi)
          end)
        end
      end
    })
  end
end
function _tVZUc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(input) == 54 then
    _Urwigo.MessageBox({
      Text = _RRGy("j\019jQ@*^Q>\019\022Q\aTj|@\028")
    })
  else
    _Urwigo.MessageBox({
      Text = _RRGy("`|Q\015|^WQ\n\019Q\nT\016\015Q@\029T\n\029#Q;\029#>|\029\015@W\028Q\017\016\015|\019Qj*\016\015Q\029TjQq|@\028"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tVZUc)
          end)
        end
      end
    })
  end
end
return _1Cutl
