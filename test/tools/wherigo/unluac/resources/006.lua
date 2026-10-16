require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
_qQ8E3 = Wherigo.ZCartridge()
function _LXU(str)
  local res = ""
  local dtable = "\023X~nTe\t\a\015s\027<B]z\v7`*Q\0001:Ld/\rp;)oc'.+M\fZS\\iAH\018D\021G\01948{ \ny32(\003&O9\"m$6%Y,>V\004ar\031\030k-Kf\002Jg\0265v\016w\024lFRqh#C^N\014\001Ubj|}u\028[\022\029?t@PIxW=!_\005\006\025\b0\017\020E"
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
_lzY = Wherigo.ZMedia(_qQ8E3)
_lzY.Id = "a5088562-bcee-4cb8-a21c-89443690e79a"
_lzY.Name = _LXU("+\031o\006Y4'oH\025o4\r\006IY)\004")
_lzY.Description = ""
_lzY.AltText = ""
_lzY.Resources = {
  {
    Type = "jpg",
    Filename = "Hotelruine.jpg",
    Directives = {}
  }
}
_OKELP = Wherigo.ZMedia(_qQ8E3)
_OKELP.Id = "0f920740-87aa-4304-9fe8-7c41ad136613"
_OKELP.Name = _LXU("N\031\004R\031o)\006I")
_OKELP.Description = ""
_OKELP.AltText = ""
_OKELP.Resources = {
  {
    Type = "jpg",
    Filename = "Kongoneu2.jpg",
    Directives = {}
  }
}
_MoOmF = Wherigo.ZMedia(_qQ8E3)
_MoOmF.Id = "8cb80049-a9a5-4aa7-9abf-2100022f9e9f"
_MoOmF.Name = _LXU("NiI]Hi\n")
_MoOmF.Description = ""
_MoOmF.AltText = ""
_MoOmF.Resources = {
  {
    Type = "jpg",
    Filename = "kurhaus.jpg",
    Directives = {}
  }
}
_2P8W9 = Wherigo.ZMedia(_qQ8E3)
_2P8W9.Id = "da808db6-16c8-426d-988d-b8b691b4f39a"
_2P8W9.Name = _LXU("qi\006 LY\006I")
_2P8W9.Description = ""
_2P8W9.AltText = ""
_2P8W9.Resources = {
  {
    Type = "jpg",
    Filename = "puckler1.jpg",
    Directives = {}
  }
}
_Zu4 = Wherigo.ZMedia(_qQ8E3)
_Zu4.Id = "a44afbd9-d570-40d9-848f-a55beb6ff66f"
_Zu4.Name = _LXU("' ]Y\031\n\n4[i\006 L\n\006)o\006")
_Zu4.Description = ""
_Zu4.AltText = ""
_Zu4.Resources = {
  {
    Type = "jpg",
    Filename = "SchlossRuckseite.jpg",
    Directives = {}
  }
}
_sc2W = Wherigo.ZMedia(_qQ8E3)
_sc2W.Id = "7ac1af8b-901f-4a98-9f6a-fc963a02d35f"
_sc2W.Name = _LXU("' ]Y\031\n\n4\127)\004RH\004R")
_sc2W.Description = ""
_sc2W.AltText = ""
_sc2W.Resources = {
  {
    Type = "jpg",
    Filename = "schlossruine.jpg",
    Directives = {}
  }
}
_EIDF = Wherigo.ZMedia(_qQ8E3)
_EIDF.Id = "798ba463-c202-4798-89ef-f99b7f46917c"
_EIDF.Name = _LXU("'\028\031)Y\006I")
_EIDF.Description = ""
_EIDF.AltText = ""
_EIDF.Resources = {
  {
    Type = "jpg",
    Filename = "SpoilerGrenzenlos.jpg",
    Directives = {}
  }
}
_mRU = Wherigo.ZMedia(_qQ8E3)
_mRU.Id = "c3fdd870-cfa6-450d-878f-13d4b9a87b7e"
_mRU.Name = _LXU("tH\028\028\006\004")
_mRU.Description = ""
_mRU.AltText = ""
_mRU.Resources = {
  {
    Type = "jpg",
    Filename = "wappen2.jpg",
    Directives = {}
  }
}
_hDZo = Wherigo.ZMedia(_qQ8E3)
_hDZo.Id = "6d480b7f-2e9c-494c-a4ca-86f46a39f79a"
_hDZo.Name = _LXU("Z)\004HY\025\031\n\006")
_hDZo.Description = ""
_hDZo.AltText = ""
_hDZo.Resources = {
  {
    Type = "jpg",
    Filename = "Finaldose.jpg",
    Directives = {}
  }
}
_IgGV6 = Wherigo.ZMedia(_qQ8E3)
_IgGV6.Id = "7983ca26-00dd-43f9-9dc7-ea7b457c91ad"
_IgGV6.Name = _LXU("qHIL\028YHo\015")
_IgGV6.Description = ""
_IgGV6.AltText = ""
_IgGV6.Resources = {
  {
    Type = "jpg",
    Filename = "Park_Bus.jpg",
    Directives = {}
  }
}
_16x = Wherigo.ZMedia(_qQ8E3)
_16x.Id = "a2cb89c4-bbb7-41d3-9b6d-c5c0e8b01ecc"
_16x.Name = _LXU("NHIo\006")
_16x.Description = ""
_16x.AltText = ""
_16x.Resources = {
  {
    Type = "jpg",
    Filename = "map.jpg",
    Directives = {}
  }
}
_qQ8E3.Id = "5d70bd95-4f92-4ee6-a48f-7451289cef16"
_qQ8E3.Name = "Grenzenlos"
_qQ8E3.Description = "Willkommen in der Kur- und Parkstadt Bad Muskau"
_qQ8E3.Visible = true
_qQ8E3.Activity = "Geocache"
_qQ8E3.StartingLocationDescription = [[
Cache Grenzenlos<BR>
GC34CGC]]
_qQ8E3.StartingLocation = Wherigo.INVALID_ZONEPOINT
_qQ8E3.Version = "1"
_qQ8E3.Company = ""
_qQ8E3.Author = "Kongotier80"
_qQ8E3.BuilderVersion = "URWIGO 1.12.4281.38707"
_qQ8E3.CreateDate = "09/13/2010 08:38:30"
_qQ8E3.PublishDate = "1/1/0001 12:00:00 AM"
_qQ8E3.UpdateDate = "10/10/2011 19:06:26"
_qQ8E3.LastPlayedDate = "1/1/0001 12:00:00 AM"
_qQ8E3.TargetDevice = "PocketPC"
_qQ8E3.TargetDeviceVersion = "0"
_qQ8E3.StateId = "1"
_qQ8E3.CountryId = "2"
_qQ8E3.Complete = false
_qQ8E3.UseLogging = true
_qQ8E3.Media = _OKELP
_eKE = Wherigo.Zone(_qQ8E3)
_eKE.Id = "a6a6c60d-cd83-4556-9301-b29c52bd89de"
_eKE.Name = _LXU("Z)\004HY")
_eKE.Description = _LXU("\127\004\025Y) ]4M4-)\0064-\031\n\006vvv")
_eKE.Visible = true
_eKE.Media = _hDZo
_eKE.Commands = {}
_eKE.DistanceRange = Distance(-1, "feet")
_eKE.ShowObjects = "OnEnter"
_eKE.ProximityRange = Distance(60, "meters")
_eKE.AllowSetPositionTo = false
_eKE.Active = false
_eKE.Points = {
  ZonePoint(51.5539119325968, 14.7202160380289, 0),
  ZonePoint(51.5539269230271, 14.7203567374344, 0),
  ZonePoint(51.5540803418604, 14.7203526441804, 0),
  ZonePoint(51.5540653482729, 14.7201690061169, 0)
}
_eKE.OriginalPoint = ZonePoint(51.5539961364393, 14.7202736064402, 0)
_eKE.DistanceRangeUOM = "Feet"
_eKE.ProximityRangeUOM = "Meters"
_eKE.OutOfRangeName = ""
_eKE.InRangeName = ""
_msBV5 = Wherigo.Zone(_qQ8E3)
_msBV5.Id = "d7b1844e-4c1c-4856-85f5-c4620f2dc877"
_msBV5.Name = _LXU("\024\006o\015o\0064&\031\004\006")
_msBV5.Description = _LXU("kNY\006)\004\0064\r\006\n ]I\006)ei\004R\014")
_msBV5.Visible = false
_msBV5.Commands = {}
_msBV5.DistanceRange = Distance(-1, "feet")
_msBV5.ShowObjects = "OnEnter"
_msBV5.ProximityRange = Distance(60, "meters")
_msBV5.AllowSetPositionTo = false
_msBV5.Active = false
_msBV5.Points = {
  ZonePoint(52.04922916402, 8.15704822540283, 0),
  ZonePoint(52.0496671084021, 8.15717563033104, 0),
  ZonePoint(52.0496613351519, 8.15641790628433, 0),
  ZonePoint(52.0493545270688, 8.15659493207932, 0)
}
_msBV5.OriginalPoint = ZonePoint(52.0494780336607, 8.15680917352438, 0)
_msBV5.DistanceRangeUOM = "Feet"
_msBV5.ProximityRangeUOM = "Meters"
_msBV5.OutOfRangeName = ""
_msBV5.InRangeName = ""
_iRkR = Wherigo.Zone(_qQ8E3)
_iRkR.Id = "d7ccdd24-4b4e-4f8b-83c3-4671b06c9259"
_iRkR.Name = _LXU("&\031\004\0064\022")
_iRkR.Description = _LXU("+)\006I4\n\006]o4)]I4\025\006\00448|\022|4L\031?\028Y\006oo4I\006L\031\004\noIi)\006Io\006\0044$HILo\028YHo\0154?)o4\025\006?4NiYoiI]\031o\006Y\"4*\0044\025)\006\n\006I4'o\006YY\0064e\006OH\004\0254\n) ]4\006)\004\no4\025H\n4+\031o\006Y4'oH\025o4\r\006IY)\004\"\f\r[E")
_iRkR.Visible = true
_iRkR.Media = _lzY
_iRkR.Commands = {}
_iRkR.DistanceRange = Distance(-1, "feet")
_iRkR.ShowObjects = "OnEnter"
_iRkR.ProximityRange = Distance(10, "meters")
_iRkR.AllowSetPositionTo = false
_iRkR.Active = false
_iRkR.Points = {
  ZonePoint(51.5468449242374, 14.7200642281723, 0),
  ZonePoint(51.5470734393316, 14.7207014282417, 0),
  ZonePoint(51.5468700399272, 14.7208328564834, 0),
  ZonePoint(51.5466098317048, 14.7201554232788, 0)
}
_iRkR.OriginalPoint = ZonePoint(51.5468495588002, 14.720438484044, 0)
_iRkR.DistanceRangeUOM = "Feet"
_iRkR.ProximityRangeUOM = "Meters"
_iRkR.OutOfRangeName = ""
_iRkR.InRangeName = ""
_Ij6M = Wherigo.Zone(_qQ8E3)
_Ij6M.Id = "d4f8ef6b-aae5-43c9-89c4-1372dc8e8cca"
_Ij6M.Name = _LXU("&\031\004\00648")
_Ij6M.Description = _LXU("-H\n4' ]Y\031\n\n4)\no4\006)\004\0064-I\006)OYi\006R\006YH\004YHR\0064)?4a\006\031I\006\004H)\n\nH\004 \006\no)Y\"4\025)\0064\006I\no\0064' ]Y\031\n\nH\004YHR\0064WHI4\006)\004\0064tH\n\n\006IeiIR4i?4\022T8|\"4aH ]4?\006]I\006I\006\0044d?eHio\006\0044\006I])\006Yo4\025H\n4' ]Y\031\n\n4i?4\022A\01784\n\006)\0044]\006io)R\006\n4*i\n\n\006]\006\004\"4-\006I4' ]Y\031\n\noiI?47T4?4]\031 ]4\006I?\031\006RY) ]o4\006)\004\006\0044d\006e\006IeY) L4i\006e\006I4qi\006 LY\006I\n4/HIo\006\004I\006) ]\"")
_Ij6M.Visible = true
_Ij6M.Media = _Zu4
_Ij6M.Commands = {}
_Ij6M.DistanceRange = Distance(-1, "feet")
_Ij6M.ShowObjects = "OnEnter"
_Ij6M.ProximityRange = Distance(10, "meters")
_Ij6M.AllowSetPositionTo = false
_Ij6M.Active = false
_Ij6M.Points = {
  ZonePoint(51.5476899766112, 14.7221809619713, 0),
  ZonePoint(51.5477475214223, 14.7219657146979, 0),
  ZonePoint(51.5479068117521, 14.7220287466097, 0),
  ZonePoint(51.5478425952988, 14.7222312533903, 0)
}
_Ij6M.OriginalPoint = ZonePoint(51.5477967262711, 14.7221016691673, 0)
_Ij6M.DistanceRangeUOM = "Feet"
_Ij6M.ProximityRangeUOM = "Meters"
_Ij6M.OutOfRangeName = ""
_Ij6M.InRangeName = ""
_EsLu = Wherigo.Zone(_qQ8E3)
_EsLu.Id = "feb6909c-9cef-464d-a5a0-a653718b2a45"
_EsLu.Name = _LXU("qHIL\028YHo\015")
_EsLu.Description = _LXU("*iO4t)\006\025\006I\n\006]\006\0044)\0044\025\006I4NiIM4i\004\0254qHIL\noH\025o4\rH\0254$i\nLHi\"4t)I4W\031YYo\006\0044\127i ]4\006)\004\006\0044LY\006)\004\006\0044\005\006)Y4U\031\0044qHILD4' ]Y\031\n\n4i\004\0254'oH\025o4U\031I\no\006YY\006\004\"\f\r[E\f\r[E")
_EsLu.Visible = false
_EsLu.Media = _IgGV6
_EsLu.Commands = {}
_EsLu.DistanceRange = Distance(-1, "feet")
_EsLu.ShowObjects = "OnEnter"
_EsLu.ProximityRange = Distance(60, "meters")
_EsLu.AllowSetPositionTo = false
_EsLu.Active = false
_EsLu.Points = {
  ZonePoint(51.5487033661862, 14.7181351607132, 0),
  ZonePoint(51.548706702045, 14.71838, 0),
  ZonePoint(51.5485416222993, 14.7184631484795, 0),
  ZonePoint(51.5484849124613, 14.7183175509263, 0),
  ZonePoint(51.5485949734216, 14.7182052772808, 0)
}
_EsLu.OriginalPoint = ZonePoint(51.5486063152827, 14.71830022748, 0)
_EsLu.DistanceRangeUOM = "Feet"
_EsLu.ProximityRangeUOM = "Meters"
_EsLu.OutOfRangeName = ""
_EsLu.InRangeName = ""
_vWr = Wherigo.Zone(_qQ8E3)
_vWr.Id = "0d86fbc3-031b-4b4b-9156-9151e0cb273c"
_vWr.Name = _LXU("'oIHO\015\031\004\006")
_vWr.Description = _LXU("aiI4e\006)4OHY\n ]\006\0044*\004oW\031Io\006\0044?i\n\no4-i4U\031I?4Z)\004HY4\006I\no4])\006I]\006I\"")
_vWr.Visible = true
_vWr.Commands = {}
_vWr.DistanceRange = Distance(-1, "feet")
_vWr.ShowObjects = "OnEnter"
_vWr.ProximityRange = Distance(60, "meters")
_vWr.AllowSetPositionTo = false
_vWr.Active = false
_vWr.Points = {
  ZonePoint(52.0517701713424, 8.15816000103951, 0),
  ZonePoint(52.0511103975462, 8.1578166782856, 0),
  ZonePoint(52.0509124635076, 8.15814390778542, 0),
  ZonePoint(52.050945452575, 8.15864279866219, 0),
  ZonePoint(52.0515887345196, 8.15906658768654, 0)
}
_vWr.OriginalPoint = ZonePoint(52.0512654438982, 8.15836599469185, 0)
_vWr.DistanceRangeUOM = "Feet"
_vWr.ProximityRangeUOM = "Meters"
_vWr.OutOfRangeName = ""
_vWr.InRangeName = ""
_QXJlx = Wherigo.Zone(_qQ8E3)
_QXJlx.Id = "176841aa-2084-4433-9875-97d7b3a116cf"
_QXJlx.Name = _LXU("&\031\004\00647")
_QXJlx.Description = _LXU("\127IeHio4\025iI ]4_iIo4[\006)\004) L\0064rr4HY\n4/HIo\006\004\028HYH)\n4WiI\025\0064\025H\n4/\006eH\006i\025\0064\n\028H\006o\006I4HY\n4\005]\006Ho\006I4i\004\0254/H\006\no\006]Hi\n4R\006\004io\015o\"4\022=714e\006OH\004\0254\n) ]4])\006I4\025\006I4t)oW\006\004\n)o\0154\025\006I4$ioo\006I4U\031\0044/IHO4*I\004)?4M4$i\nLHi\"4F\031\0044\022=T|4M48||=4WiI\025\0064\025H\n4/\006eH\006i\025\0064HY\n4NiI?)oo\006Y]Hi\n4e\006oI)\006e\006\004\"")
_QXJlx.Visible = true
_QXJlx.Media = _MoOmF
_QXJlx.Commands = {}
_QXJlx.DistanceRange = Distance(-1, "feet")
_QXJlx.ShowObjects = "OnEnter"
_QXJlx.ProximityRange = Distance(10, "meters")
_QXJlx.AllowSetPositionTo = false
_QXJlx.Active = false
_QXJlx.Points = {
  ZonePoint(51.5481065794514, 14.7235756852674, 0),
  ZonePoint(51.5482608646872, 14.7237044313002, 0),
  ZonePoint(51.5482983934493, 14.7232725956488, 0),
  ZonePoint(51.5481833051476, 14.7232082226324, 0)
}
_QXJlx.OriginalPoint = ZonePoint(51.5482122856839, 14.7234402337122, 0)
_QXJlx.DistanceRangeUOM = "Feet"
_QXJlx.ProximityRangeUOM = "Meters"
_QXJlx.OutOfRangeName = ""
_QXJlx.InRangeName = ""
_JTTI = Wherigo.Zone(_qQ8E3)
_JTTI.Id = "423f1cda-be6d-41fd-9eed-2cbb6d3da26e"
_JTTI.Name = _LXU("&\031\004\00641")
_JTTI.Description = _LXU("-H\n4' ]Y\031\n\n4WHI4\025\006I4/\006eiIo\n\031Io4\025\006\n4Zi\006I\no\006\0044+\006I?H\004\0044U\031\0044qi\006 LY\006I4M4$i\nLHiD4\025)\006\n\006I4\n ]iO4])\006I4\006)\004\006427|4]H4RI\031\n\n\0064qHILH\004YHR\006\"4t\006)o\006I\0064r\004O\031\n4\025H\015i4e\006L\031??o4r]I4)?4$i\n\006i?4])\006I4)?4' ]Y\031\n\n\"")
_JTTI.Visible = true
_JTTI.Media = _sc2W
_JTTI.Commands = {}
_JTTI.DistanceRange = Distance(-1, "feet")
_JTTI.ShowObjects = "OnEnter"
_JTTI.ProximityRange = Distance(60, "meters")
_JTTI.AllowSetPositionTo = false
_JTTI.Active = false
_JTTI.Points = {
  ZonePoint(51.5476784101607, 14.7234547527266, 0),
  ZonePoint(51.5476759082101, 14.7238785417509, 0),
  ZonePoint(51.5472680884232, 14.7238356264066, 0),
  ZonePoint(51.5473406455853, 14.7233957441282, 0)
}
_JTTI.OriginalPoint = ZonePoint(51.5474907630948, 14.7236411662531, 0)
_JTTI.DistanceRangeUOM = "Feet"
_JTTI.ProximityRangeUOM = "Meters"
_JTTI.OutOfRangeName = ""
_JTTI.InRangeName = ""
_RT7 = Wherigo.Zone(_qQ8E3)
_RT7.Id = "64f2bbd5-b03c-4b39-95a5-657baab46737"
_RT7.Name = _LXU("&\031\004\0064T")
_RT7.Description = _LXU("-)\0064\rIi\006 L\0064WiI\025\0064\0222884\006IeHio4i\004\0254LiI\0154U\031I4NI)\006R\n\006\004\025\0064R\006\n\028I\006\004Ro\"4-\006I4\rIi\006 L\006\004\n ]YHR4\006IO\031YRo\00648||7\"4\127I4oIiR4\025H\015i4e\006)D4\025H\n4\025\006I4qHIL4)\0044\025)\0064\024)\no\0064da\127'_<4M4t\006YoLiYoiI\006Ie\0064HiOR\006\004\031??\006\0044WiI\025\006\"\f\r[E")
_RT7.Visible = true
_RT7.Commands = {}
_RT7.DistanceRange = Distance(-1, "feet")
_RT7.ShowObjects = "OnEnter"
_RT7.ProximityRange = Distance(60, "meters")
_RT7.AllowSetPositionTo = false
_RT7.Active = false
_RT7.Points = {
  ZonePoint(51.5477707338717, 14.7280829102383, 0),
  ZonePoint(51.5475438902517, 14.7279756218777, 0),
  ZonePoint(51.5470635117934, 14.7297244221554, 0),
  ZonePoint(51.5479575454155, 14.7296600491391, 0)
}
_RT7.OriginalPoint = ZonePoint(51.5475839203331, 14.7288607508526, 0)
_RT7.DistanceRangeUOM = "Feet"
_RT7.ProximityRangeUOM = "Meters"
_RT7.OutOfRangeName = ""
_RT7.InRangeName = ""
_337Zz = Wherigo.Zone(_qQ8E3)
_337Zz.Id = "f7c18554-dc3f-45d1-8402-b0802afb0db1"
_337Zz.Name = _LXU("&\031\004\0064A")
_337Zz.Description = _LXU("-\006I4qi\006 LY\006I\no\006)\0044WiI\025\0064\022=|\0224U\031?4*e\031I\006oi?4HiO4\025\006\0044\r\006IR4i?R\006\n\006o\015\"4*i\n4*\004YH\n\n4\025\006\n48|A\"4/\006eiIo\noHR\006\n4\025\006\n4Zi\006I\no\006\0044U\031\0044qi\006 LY\006IM$i\nLHi4WiI\025\0064\025)\0064\005HO\006Y4H?47|\"\022|\"\022==\0224\006I\004\006i\006Io\"")
_337Zz.Visible = true
_337Zz.Media = _2P8W9
_337Zz.Commands = {}
_337Zz.DistanceRange = Distance(-1, "feet")
_337Zz.ShowObjects = "OnEnter"
_337Zz.ProximityRange = Distance(60, "meters")
_337Zz.AllowSetPositionTo = false
_337Zz.Active = false
_337Zz.Points = {
  ZonePoint(51.5499089932736, 14.7304645099564, 0),
  ZonePoint(51.549987014593, 14.7307356269837, 0),
  ZonePoint(51.5497187046882, 14.7309908442498, 0),
  ZonePoint(51.5496437241117, 14.7305759285889, 0)
}
_337Zz.OriginalPoint = ZonePoint(51.5498146091666, 14.7306917274447, 0)
_337Zz.DistanceRangeUOM = "Feet"
_337Zz.ProximityRangeUOM = "Meters"
_337Zz.OutOfRangeName = ""
_337Zz.InRangeName = ""
_77tT = Wherigo.Zone(_qQ8E3)
_77tT.Id = "3b643caa-9e85-45c6-a7bd-91be9789e52e"
_77tT.Name = _LXU("&\031\004\0064\017")
_77tT.Description = _LXU("\0222T14HY\n4\r\031R\006\004eIi\006 L\0064Hi\n4'o\006)\004D4\015i?4i\006e\006I\\i\006I\006\0044\025\006I4' ]Yi ]o4\006IeHio\"\f\r[E\127)\004\0064\025\006I4W\006\004)R\006\0044\rIi\006 L\006\0044\025)\0064\004\031 ]4)?4<I)R)\004HY4\006I]HYo\006\0044)\no\"")
_77tT.Visible = true
_77tT.Commands = {}
_77tT.DistanceRange = Distance(-1, "feet")
_77tT.ShowObjects = "OnEnter"
_77tT.ProximityRange = Distance(60, "meters")
_77tT.AllowSetPositionTo = false
_77tT.Active = false
_77tT.Points = {
  ZonePoint(51.551334563107, 14.7309873472213, 0),
  ZonePoint(51.5515169305324, 14.730369588955, 0),
  ZonePoint(51.5516936989787, 14.7305132417335, 0),
  ZonePoint(51.5515533253007, 14.7311210325756, 0)
}
_77tT.OriginalPoint = ZonePoint(51.5515246294797, 14.7307478026213, 0)
_77tT.DistanceRangeUOM = "Feet"
_77tT.ProximityRangeUOM = "Meters"
_77tT.OutOfRangeName = ""
_77tT.InRangeName = ""
_X_jO = Wherigo.Zone(_qQ8E3)
_X_jO.Id = "1a4d1b1a-cf93-4388-a857-206145274322"
_X_jO.Name = _LXU("&\031\004\0064=")
_X_jO.Description = _LXU("r]I4e\006O)\004\025\006o4\127i ]4)\0044 H\"48||4?4;\004e\n\028\029H\0044\025\006I4\127\004RY)\n ]\0064\rIi\006 L\006\"4-)\006\n\0064WiI\025\0064\0222884\006IeHio4i\004\0254LiI\0154U\031I4NI)\006R\n\006\004\025\0064\022=1T4R\006\n\028I\006\004Ro\"4$)o4N\031\no\006\0044U\031\0044?\006]I4HY\n484$)\0314\127d[4WiI\025\0064\025)\0064\rIi\006 L\0064U\031\00448|\022|4e)\n4<Lo48|\022\0224W)\006\025\006I4HiOR\006eHio\"4")
_X_jO.Visible = true
_X_jO.Commands = {}
_X_jO.DistanceRange = Distance(-1, "feet")
_X_jO.ShowObjects = "OnEnter"
_X_jO.ProximityRange = Distance(60, "meters")
_X_jO.AllowSetPositionTo = false
_X_jO.Active = false
_X_jO.Points = {
  ZonePoint(51.5550250154721, 14.7215378098563, 0),
  ZonePoint(51.554258820879, 14.7213881633683, 0),
  ZonePoint(51.5543021689172, 14.720834170639, 0),
  ZonePoint(51.5550905320294, 14.7210660196781, 0)
}
_X_jO.OriginalPoint = ZonePoint(51.5546691343244, 14.7212065408854, 0)
_X_jO.DistanceRangeUOM = "Feet"
_X_jO.ProximityRangeUOM = "Meters"
_X_jO.OutOfRangeName = ""
_X_jO.InRangeName = ""
_Gj1nJ = Wherigo.Zone(_qQ8E3)
_Gj1nJ.Id = "abd8eda3-14d5-4f1f-b01e-83c7a2654a88"
_Gj1nJ.Name = _LXU("&\031\004\0064\022|")
_Gj1nJ.Description = _LXU("*iO4\015i?4\024\031R4\025\006\n4>\r\031\004i\n4/I\006\004\015\006\004Y\031\n>")
_Gj1nJ.Visible = true
_Gj1nJ.Commands = {}
_Gj1nJ.DistanceRange = Distance(-1, "feet")
_Gj1nJ.ShowObjects = "OnEnter"
_Gj1nJ.ProximityRange = Distance(60, "meters")
_Gj1nJ.AllowSetPositionTo = false
_Gj1nJ.Active = false
_Gj1nJ.Points = {
  ZonePoint(51.5500952088474, 14.7311568809509, 0),
  ZonePoint(51.5501518949899, 14.7313183091926, 0),
  ZonePoint(51.5500131940405, 14.7314540085983, 0),
  ZonePoint(51.5499624571301, 14.7312182729817, 0)
}
_Gj1nJ.OriginalPoint = ZonePoint(51.550055688752, 14.7312868679309, 0)
_Gj1nJ.DistanceRangeUOM = "Feet"
_Gj1nJ.ProximityRangeUOM = "Meters"
_Gj1nJ.OutOfRangeName = ""
_Gj1nJ.InRangeName = ""
_GYqX = Wherigo.Zone(_qQ8E3)
_GYqX.Id = "269c1665-82c8-41fa-a0fe-715a512926c3"
_GYqX.Name = _LXU("&\031\004\0064\022\022")
_GYqX.Description = _LXU("-i4e)\no4RY\006) ]4e\006)4\025\006?4_H ]\0064>dI\noI\031?oHY>4H\004R\006L\031??\006\004D4U)\006Y4'\028H\n\n4e\006)?4\ni ]\006\0044i\004\0254Y\031RR\006\004\"")
_GYqX.Visible = true
_GYqX.Commands = {}
_GYqX.DistanceRange = Distance(-1, "feet")
_GYqX.ShowObjects = "OnEnter"
_GYqX.ProximityRange = Distance(60, "meters")
_GYqX.AllowSetPositionTo = false
_GYqX.Active = false
_GYqX.Points = {
  ZonePoint(51.5524515667517, 14.7266310760574, 0),
  ZonePoint(51.5525452750759, 14.7264719656067, 0),
  ZonePoint(51.5526653422755, 14.7267342245369, 0),
  ZonePoint(51.5525492818037, 14.726820354002, 0)
}
_GYqX.OriginalPoint = ZonePoint(51.5525528664767, 14.7266644050507, 0)
_GYqX.DistanceRangeUOM = "Feet"
_GYqX.ProximityRangeUOM = "Meters"
_GYqX.OutOfRangeName = ""
_GYqX.InRangeName = ""
_BxJ0W = Wherigo.Zone(_qQ8E3)
_BxJ0W.Id = "4f74c2d9-d63e-4d05-ac93-cea7bd51de4d"
_BxJ0W.Name = _LXU("&\031\004\006424")
_BxJ0W.Description = _LXU("-\006I4$i\nLHi\006I4ZHYo\006\004e\031R\006\0044\006\004o\noH\004\0254Hi\n4'oHi ]\006\004\025?\031IH\006\004\006\0044)\0044\025\006I4\127Y\no\006I\006)\n\015\006)o\"4-He\006)4e)Y\025\006o\006\0044\n) ]4OYH ]W\006YY)R\0064+i\006R\006Y\015i\006R\0064e\006)\025\006I\n\006)o\n4\025\006I4\024Hi\n)o\015\006I4a\006)\n\n\006\"4-H\n4/\006e)\006o4WiI\025\00648||74U\031\0044\025\006I4\024H\004\025\006\nI\006R)\006Ii\004R4'H ]\n\006\0044\015i?4/\006\031\028HIL4\006ILYH\006Io\"")
_BxJ0W.Visible = true
_BxJ0W.Commands = {}
_BxJ0W.DistanceRange = Distance(-1, "feet")
_BxJ0W.ShowObjects = "OnEnter"
_BxJ0W.ProximityRange = Distance(60, "meters")
_BxJ0W.AllowSetPositionTo = false
_BxJ0W.Active = false
_BxJ0W.Points = {
  ZonePoint(51.5538718188145, 14.7250246150666, 0),
  ZonePoint(51.5535649536275, 14.7255825145417, 0),
  ZonePoint(51.5532447442688, 14.7252177341156, 0),
  ZonePoint(51.5536116506373, 14.7245418174439, 0)
}
_BxJ0W.OriginalPoint = ZonePoint(51.553573291837, 14.725091670292, 0)
_BxJ0W.DistanceRangeUOM = "Feet"
_BxJ0W.ProximityRangeUOM = "Meters"
_BxJ0W.OutOfRangeName = ""
_BxJ0W.InRangeName = ""
_TDDz = Wherigo.ZItem({Cartridge = _qQ8E3, Container = Player})
_TDDz.Id = "a73a802d-0905-4347-93d7-26fe70d58d2c"
_TDDz.Name = _LXU("\005\031\028\031LHIo\006")
_TDDz.Description = _LXU("ZHYY\n4-i4?HY4\004) ]o4W\006)o\006I4W\006)\n\no\"")
_TDDz.Visible = true
_TDDz.Media = _16x
_TDDz.Commands = {}
_TDDz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_TDDz.Locked = false
_TDDz.Opened = false
_3JU3q = Wherigo.ZItem({Cartridge = _qQ8E3, Container = Player})
_3JU3q.Id = "5cf16677-5b4a-4239-9dc7-c9f86c054a20"
_3JU3q.Name = _LXU("_\031\025\0064\015i?4\024\031RR\006\004")
_3JU3q.Description = _LXU("t\006\004\0044-i4\025H\n4Z)\004HY4R\006Oi\004\025\006\0044]H\noD4\no\006]o4])\006I4\025\006I4_\031\025\0064\015i?4<\004Y)\004\0064\024\031RR\006\0044\025I)\004\"")
_3JU3q.Visible = false
_3JU3q.Commands = {}
_3JU3q.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3JU3q.Locked = false
_3JU3q.Opened = false
_VOKK = Wherigo.ZTask(_qQ8E3)
_VOKK.Id = "3643982e-e528-4422-a102-acafa835f922"
_VOKK.Name = _LXU("/\006]\0064\015i?4$HILo\028YHo\015")
_VOKK.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015iI4\004H\006 ]\no\006\0044'oHo)\031\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_VOKK.Visible = true
_VOKK.Active = true
_VOKK.Complete = false
_VOKK.CorrectState = "None"
_QHH = Wherigo.ZTask(_qQ8E3)
_QHH.Id = "0ae39695-451c-4d6c-9d4e-e1333f1a901b"
_QHH.Name = _LXU("/\006]\0064\015iI4Y\006o\015o\006\0044'oHo)\031\004")
_QHH.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015iI4Y\006o\015o\006\0044'oHo)\031\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_QHH.Visible = true
_QHH.Active = false
_QHH.Complete = false
_QHH.CorrectState = "None"
_Suswi = Wherigo.ZTask(_qQ8E3)
_Suswi.Id = "82df6d16-e49a-46fa-aadc-b9e71b2e01fa"
_Suswi.Name = _LXU("/\006]\0064\015iI4' ]Y\031\n\n4[i\006 L\n\006)o\006")
_Suswi.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015iI4\004H\006 ]\no\006\0044'oHo)\031\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_Suswi.Visible = true
_Suswi.Active = false
_Suswi.Complete = false
_Suswi.CorrectState = "None"
_NHEJ = Wherigo.ZTask(_qQ8E3)
_NHEJ.Id = "75769025-22b0-4bbd-b3af-1c32d1a28805"
_NHEJ.Name = _LXU("/\006]\0064\015i?4Z)\004HY")
_NHEJ.Description = _LXU("+)\006I4O)\004\025\006\no4-i4\025)\0064YH\004R4\006I\n\006]\004o\0064-\031\n\006\"")
_NHEJ.Visible = true
_NHEJ.Active = false
_NHEJ.Complete = false
_NHEJ.CorrectState = "None"
_V1BqQ = Wherigo.ZTask(_qQ8E3)
_V1BqQ.Id = "de75aac7-6b75-464e-84d8-0dbb006b1b90"
_V1BqQ.Name = _LXU("/\006]\0064\015iI4k'oIHO\015\031\004\006\014")
_V1BqQ.Description = _LXU("/\006]\0064\015i?4k'oIHO\015\031\004\006\014D4i?4\025)\0064'oIHOHiORHe\0064\015i4Y\031\006\n\006\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_V1BqQ.Visible = true
_V1BqQ.Active = false
_V1BqQ.Complete = false
_V1BqQ.CorrectState = "None"
_CJs = Wherigo.ZTask(_qQ8E3)
_CJs.Id = "e887265f-5d1c-4393-bf58-ff26b55a28da"
_CJs.Name = _LXU("Q\006o\015o4R\006]o4\006\n4\015i?4_HUHY)\006I\n]Hi\n")
_CJs.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015iI4\004H\006 ]\no\006\0044'oHo)\031\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_CJs.Visible = true
_CJs.Active = false
_CJs.Complete = false
_CJs.CorrectState = "None"
_DRs = Wherigo.ZTask(_qQ8E3)
_DRs.Id = "a6add5b5-6dc1-4e15-aef6-69f78457e3a3"
_DRs.Name = _LXU("t\006)o\006I4\015i?4' ]Y\031\n\n4\127)\004RH\004R")
_DRs.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015i?4' ]Y\031\n\n\006)\004RH\004R\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_DRs.Visible = true
_DRs.Active = false
_DRs.Complete = false
_DRs.CorrectState = "None"
_cNm = Wherigo.ZTask(_qQ8E3)
_cNm.Id = "9b4eaae6-420b-44ab-a1b8-84da0970fcd9"
_cNm.Name = _LXU("/\006]\0064\015iI4-\031\028\028\006YeIi\006 L\006")
_cNm.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015iI4\rIi\006 L\006\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_cNm.Visible = true
_cNm.Active = false
_cNm.Complete = false
_cNm.CorrectState = "None"
_xRc = Wherigo.ZTask(_qQ8E3)
_xRc.Id = "f89a62ec-15c8-4735-b8e6-639141727be9"
_xRc.Name = _LXU("'i ]\0064\025\006\0044qi\006 LY\006I\no\006)\004")
_xRc.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015i?4/\006\025\006\004L\no\006)\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_xRc.Visible = true
_xRc.Active = false
_xRc.Complete = false
_xRc.CorrectState = "None"
_4Ozk = Wherigo.ZTask(_qQ8E3)
_4Ozk.Id = "96c4d49c-c5bc-43e1-9890-90eee389df52"
_4Ozk.Name = _LXU("/\006]\0064\015iI4\rIi\006 L\006")
_4Ozk.Description = _LXU("/\006]\0064W\006)o\006I4e)\n4\015iI4\004H\006 ]\no\006\0044'oHo)\031\004\"4-)\0064[) ]oi\004R4i\004\0254\127\004oO\006I\004i\004R4e)\n4\025\031Io])\0044LH\004\004\no4-i4i\004o\006I4q\031\n)o)\031\004\006\0044HeY\006\n\006\004\"")
_4Ozk.Visible = true
_4Ozk.Active = false
_4Ozk.Complete = false
_4Ozk.CorrectState = "None"
_rzo = Wherigo.ZTask(_qQ8E3)
_rzo.Id = "a826efd6-e70f-4b3e-836a-8455135f3f35"
_rzo.Name = _LXU("\ni ]\0064\025\006\0044>\r\031\004i\n4/I\006\004\015\006\004Y\031\n>")
_rzo.Description = _LXU("*iO4\015i?4_H ]\0064>\r\031\004i\n4/I\006\004\015\006\004Y\031\n>")
_rzo.Visible = true
_rzo.Active = false
_rzo.Complete = false
_rzo.CorrectState = "None"
_psG = Wherigo.ZTask(_qQ8E3)
_psG.Id = "1f225f54-9835-44af-82dc-81d3fd806162"
_psG.Name = _LXU("*iO4\015i?4>dI\noI\031?oHY>")
_psG.Description = _LXU("'i ]\0064\025\006\0044_H ]\0064>dI\noI\031?oHY>")
_psG.Visible = true
_psG.Active = false
_psG.Complete = false
_psG.CorrectState = "None"
_7nt64 = Wherigo.ZTask(_qQ8E3)
_7nt64.Id = "073db545-03ef-4718-b950-a7a5beebec5a"
_7nt64.Name = _LXU("/\006]\0064W\006)o\006I4\025iI ]4\025H\n4dI\noI\031?oHY")
_7nt64.Description = _LXU("t\006)o\006I4R\006]o4\006\n4\004i\0044\025iI ]4\025H\n4dI\noI\031?oHY")
_7nt64.Visible = true
_7nt64.Active = false
_7nt64.Complete = false
_7nt64.CorrectState = "None"
_0pN = 0
_qQ8E3.ZVariables = {_0pN = 0}
_N_t = Wherigo.ZInput(_qQ8E3)
_N_t.Id = "1eabb96c-cab6-4161-8ffc-911989a8c869"
_N_t.Name = _LXU("&\031\004\0064\022")
_N_t.Description = _LXU("\r)oo\0064R)e4\025)\0064I) ]o)R\0064QH]I\006\n\015H]Y4\006)\004\"")
_N_t.Visible = true
_N_t.InputType = "Text"
_N_t.Text = _LXU("tH\004\0044WiI\025\0064\025\006I4\rIi\004\004\006\0044\006II) ]o\006o4n")
_7Bs = Wherigo.ZInput(_qQ8E3)
_7Bs.Id = "a541bff6-2882-49c0-9cb1-8172d9f1f6ca"
_7Bs.Name = _LXU("\rIi\006 L\006")
_7Bs.Description = _LXU("tH\006]Y\0064\025)\0064I) ]o)R\0064*\004oW\031Io\"")
_7Bs.Visible = true
_7Bs.Choices = {"Antwort A", "Antwort B"}
_7Bs.InputType = "MultipleChoice"
_7Bs.Text = _LXU("t)\0064W)I\0254\025)\0064\rIi\006 L\0064R\006\004H\004\004o4n\f\r[E\f\r[E*4u4qI)\004\015\006\004eIi\006 L\006\f\r[E\r4u4Zi\n\nRH\006\004R\006Ii\006e\006IW\006R")
_3St = Wherigo.ZInput(_qQ8E3)
_3St.Id = "90cf3984-920a-43b6-9013-c025223aee17"
_3St.Name = _LXU("' ]Y\031\n\n4\127)\004RH\004R")
_3St.Description = _LXU("tH\006]Y\0064\025)\0064I) ]o)R\0064*\004oW\031Io\"")
_3St.Visible = true
_3St.Choices = {"Antwort A", "Antwort B"}
_3St.InputType = "MultipleChoice"
_3St.Text = _LXU("t\006I4WiI\025\0064])\006I4R\006e\031I\006\004\"\f\r[E\f\r[E*4u4Zi\006I\no4+\006I?H\004\0044U\031\0044qi\006 LY\006I4M4$i\nLHi\f\r[E\r4u4-)\006o\006I4\r\031]Y\006\004")
function _qQ8E3:OnStart()
  if _G[_LXU("\127\004U")][_LXU("-\006U) \006r-")] == _LXU("-\006\nLo\031\028") or _G[_LXU("\127\004U")][_LXU("qYHoO\031I?")] == _LXU("t)\00478") then
    for k, v in pairs(_G[_LXU("w\\\0202\1277")][_LXU("*YY&<ef\006 o\n")]) do
      v[_LXU("F)\n)eY\006")] = false
      v[_LXU("* o)U\006")] = false
    end
    _G[_LXU("t]\006I)R\031")][_LXU("_\031??H\004\025")](_LXU("'HU\006_Y\031\n\006"))
    return
  end
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("+\006I\015Y) ]4t)YYL\031??\006\0044;\004e\n\028\029)\0044\025\006I4NiIM4i\004\0254qHIL\noH\025o4\rH\0254$i\nLHi4v\f\r[E-)\0064'oH\025o4]Ho4 H41T||4\127)\004W\031]\004\006I4i\004\0254WiI\025\0064\02281=4\006I\no?HY\n4\006IWH\006]\004o\"\f\r[E")
    }
  }, function(action)
    _EsLu.Active = true
    _iRkR.Active = true
  end)
end
function _qQ8E3:OnRestore()
end
function _eKE:OnEnter()
  _qQ8E3.Complete = true
  _qQ8E3:RequestSync()
  _Urwigo.MessageBox({
    Text = _LXU("+\006I\015Y) ]\006\0044/Yi\006 LWi\004\n ]4vvv\f\r[E\f\r[E-i4]H\no4\025\006\0044t]\006I)R\031M_H ]\0064>/I\006\004\015\006\004Y\031\n>4\006IO\031YRI\006) ]4e\006\006\004\025\006o\"\f\r[Et)I4]\031OO\006\004D4\006\n4]Ho4'\028H\n\n4R\006?H ]ov4\023\031-\f\r[EQ\006o\015o4\n\031YYo\006\no4-i4)\0044\025\006I4aH\006]\0064\025\006\n4Z)\004HY\n4\n\006)\0044i\004\0254\025HIO\no4\025)\0064-\031\n\0064;\004e\n\028\029\ni ]\006\0044i\004\0254\025HI)\0044Y\031RR\006\004\""),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = (_LXU("\f\r[Ed?4Hi ]4<\004Y)\004\0064HiO4W]\006I\006)R\031\" \031?4\015i4Y\031RR\006\004D4eIHi ]\no4-i4\025)\006\n\006\0044d\004Y\031 LM_\031\025\006\023\f\r[E>") .. string.sub(Player.CompletionCode, 1, 15)) .. _LXU(">\"\f\r[E\f\r[EF)\006Y4'\028H\n\n4e\006)?4'i ]\006\0044i\004\0254\024\031RR\006\004vvv"),
          Buttons = {
            _LXU("'\028\031)Y\006Ie)Y\0254H\004\015\006)R\006\004")
          },
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = _LXU("kF)\006Y4/Yi\006 L4e\006)4\025\006I4'i ]\006\014"),
                Media = _EIDF
              })
            end
          end
        })
      end
    end
  })
  _NHEJ.Visible = false
  _NHEJ.Active = false
  _3JU3q.Description = (_LXU("\024\031RR\0064\025)\006\n\006\0044_H ]\0064Hi ]4<\004Y)\004\0064HiO\023\f\r[ER\006\031 H ])\004R\" \031?\f\r[Ei\004\0254e\006)\f\r[EW]\006I\006)R\031\" \031?\f\r[E\f\r[E-H\015i4eIHi ]\no4-i4\025)\006\n\006\0044d\004Y\031 LM_\031\025\006\023\f\r[E>") .. string.sub(Player.CompletionCode, 1, 15)) .. _LXU(">")
  _3JU3q.Visible = true
  _EsLu.Active = true
  _EsLu.Visible = true
  _qQ8E3:RequestSync()
end
function _msBV5:OnEnter()
  _Urwigo.MessageBox({
    Text = _LXU("k\r\006\n ]I\006)ei\004R4\025\006\n4<ef\006Lo\n\014"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_7Bs)
        end)
      end
    end
  })
end
function _iRkR:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("+)\006I4H?4$HILo\028YHo\0154e\006R)\004\004o4i\004\n\006I4t]\006I)R\031M_H ]\006\"4")
    },
    {
      Text = _LXU("+)\006I4\n\031YYo\0064\006)\004\0064\005)\006ORHIHR\0064R\006eHio4W\006I\025\006\004\"4\024\006)\025\006I4WiI\025\0064\025H\n4qI\031f\006Lo4Hi\n4N\031\no\006\004RIi\006\004\025\006\0044\004) ]o4U\006IW)LY) ]o\"")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_N_t)
    end)
  end)
end
function _Ij6M:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("[\006 ]o\n4\n\006]o4r]I4\025\006\0044\rHYL\031\004D4U\031\0044\025\006?4;\004e\n\028\029dI\niYH4NHo]HI)\004H4\riIRRIH\006O)\0044\015i4-\031]\004H4HiO4\025)\0064t)\006\n\0064eY) Lo\0064i\004\0254\"\"\"\"4vvv\f\r[Et\006)o\006I\0064r\004O\031\nD4\n)\006]\0064_H ]\0064>'HR\006\0044\025\006I4\024Hi\n)o\0154aI48>")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_3St)
    end)
  end)
end
function _EsLu:OnEnter()
  if _qQ8E3.Complete == false then
    _Urwigo.OldDialog({
      {
        Text = _LXU("<ND4\025\006\0044qHIL\028YHo\0154]H\no4-i4\n ]\031\0044?HY4R\006Oi\004\025\006\004\"\f\r[E-H\004\0044LH\004\004!\n4fH4Y\031\nR\006]\006\004\"4\f\r[E-\006I4_H ]\0064\noHIo\006o4e\006)?4$HILo\028YHo\015\f\r[E\r\006R)e4-) ]4\025\031Io4])\004v")
      }
    })
  else
    _Urwigo.OldDialog({
      {
        Text = _LXU("F)\006Y\006\0044-H\004L4Oi\006I!\n4'\028)\006Y\006\0044M4W)I4]\031OO\006\004D4r]I4]Hoo\006o4'\028H\n\n4\025He\006)\"\f\r[E\f\r[E\005\n ]i\006\n\n4i\004\0254*iO4t)\006\025\006I\n\006]\006\0044e\006)?4\004H\006 ]\no\006\0044t]\006I)R\0314v\f\r[E\f\r[EM4N\031??o4Rio4\004H ]4+Hi\n\006v4M")
      }
    })
  end
end
function _vWr:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("<LH6D4\025H\n4\n\031YY4W\031]Y4HY\n4'oIHO\0064I\006) ]\006\004\"\f\r[E\f\r[Eai\0044\006\004\025Y) ]4LH\004\004\no4-i4-) ]4HiO4\025\006\0044t\006R4\015i?4Z)\004HY4?H ]\006\004v")
    }
  }, function(action)
    _eKE.Active = true
    _vWr.Active = false
    _NHEJ.Active = true
    _V1BqQ.Active = false
    _V1BqQ.Complete = true
  end)
end
function _QXJlx:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("+)\006I4\n\006]o4r]I4\025H\n4_HUHY)\006I\nM4i\004\0254\n\028H\006o\006I\0064NiI]Hi\n\"4t)\0064\025H\n4/\006eHi\025\0064\004H ]4\025\006I4$\031\025\006I\004)\n)\006Ii\004R4R\006\004io\015o4W\006I\025\006\0044\n\031YYD4)\no4\004\031 ]4\004) ]o4e\006LH\004\004o\"")
    }
  }, function(action)
    _QXJlx.Active = false
    _CJs.Complete = true
    _JTTI.Active = true
    _DRs.Active = true
  end)
end
function _JTTI:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("-\006I4' ]Y\031\n\n\006)\004RH\004R4?)o4\025\006\0044\024\031\006W\006\004D4W\006Y ]\00648|\022|4\006\004\025Ri\006Yo)R4O\006Io)RR\006\no\006YYo4WiI\025\006\004\"\f\r[E")
    }
  }, function(action)
    _JTTI.Active = false
    _DRs.Complete = true
    _RT7.Active = true
    _cNm.Active = true
  end)
  _qQ8E3:RequestSync()
end
function _RT7:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("r]I4]Heo4\025)\0064-\031\028\028\006YeIi\006 L\0064R\006Oi\004\025\006\0044vv4ai\0044U\006IYH\n\no4r]I4-\006io\n ]YH\004\0254i\004\0254e\006R\006eo4\127i ]4)\0044\025\006\0044\028\031Y\004)\n ]\006\0044\005\006)Y4\025\006\n4qHIL\n\"")
    }
  }, function(action)
    _RT7.Active = false
    _cNm.Complete = true
    _337Zz.Active = true
    _xRc.Active = true
  end)
  _qQ8E3:RequestSync()
end
function _337Zz:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("ai\0044W\031YY\0044W)I4?HY4\n ]Hi\006\0044\031e4r]I4\025)\0064ZIHR\006\0044I) ]o)R\f\r[Ee\006H\004oW\031Io\006o4]Heo4vv")
    }
  }, function(action)
    if _0pN < 1 then
      _Gj1nJ.Active = true
      _rzo.Active = true
      _Urwigo.OldDialog({
        {
          Text = _LXU("*YY\0064*\004oW\031Io\006\0044WHI\006\0044I) ]o)R4vv\f\r[EtH]\004\n)\004\004D4]H\006oo\0064) ]4\004) ]o4R\006\025H ]o\"\f\r[E&iI4\r\006Y\031]\004i\004R4\025HIO\no4-i4\025\006\0044\006I\no\006\0044_H ]\0064\ni ]\006\004\"\f\r[E\024\031\n4R\006]on\n4v")
        }
      })
    else
      _77tT.Active = true
      _4Ozk.Active = true
      _Urwigo.OldDialog({
        {
          Text = _LXU("\005fH4Y\006)\025\006ID4\025H4WHI4W\031]Y4\006)\004\0064*\004oW\031Io4OHY\n ]4vvv\f\r[E' ]H\025\0064\004i\0044R\006]o4\006\n4\031]\004\0064\025)\0064\006I\no\0064-\031\n\0064W\006)o\006I\"")
        }
      })
    end
    _337Zz.Active = false
    _xRc.Complete = true
    _qQ8E3:RequestSync()
  end)
end
function _77tT:OnEnter()
  _rzo.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_7Bs)
  end)
end
function _X_jO:OnEnter()
  _X_jO.Active = false
  _QHH.Active = false
  _QHH.Complete = true
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("Q\006o\015o4]Heo4r]I4\006\n4OH\no4R\006\n ]HOOo\"4r]I4R\006]o4i\006e\006I4\025)\0064\rIi\006 L\0064W)\006\025\006I4\004H ]4-\006io\n ]YH\004\0254i\004\0254\025H\004\0044?)o4RI\031\n\n\006\0044' ]I)oo\006\0044HiO4\015i?4Z)\004HY4v")
    }
  }, function(action)
    _eKE.Active = true
    _NHEJ.Active = true
    _qQ8E3:RequestSync()
  end)
end
function _Gj1nJ:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("+iIIH4r]I4\n\006)\0254e\006)4\025\006I4\006I\no\006\0044-\031\n\0064H\004R\006L\031??\006\004\"4+)\006I4O)\004\025\006o4r]I4\025\006\0044$) I\0314>\r\031\004i\n4/I\006\004\015\006\004Y\031\n>\"\f\r[EF)\006Y4/Yi\006 L4e\006)?4\ni ]\006\0044i\004\0254Y\031RR\006\004\"")
    }
  }, function(action)
    _Gj1nJ.Active = false
    _rzo.Complete = true
    _77tT.Active = true
    _4Ozk.Active = true
  end)
end
function _GYqX:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("+)\006I4Y)\006Ro4\006ID4\025\006I4_H ]\0064>dI\noI\031?oHY>4\"4F)\006Y4/Yi\006 L4e\006)4\025\006I4'i ]\006\"")
    }
  }, function(action)
    _BxJ0W.Active = true
    _7nt64.Active = true
    _qQ8E3:RequestSync()
    _psG.Complete = true
    _psG.Active = false
    _GYqX.Active = false
  end)
end
function _BxJ0W:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _LXU("/\006\004)\006\n\no4\025)\0064aHoiID4\025\006\004\0044\025)\0064Z\031I?4\025)\006\n\006I4\024H\004\025\n ]HOo4)\no4\006)\004?HY)Rvv\f\r[Eai\0044R\006]o4\006\n4\015iI4Y\006o\015o\006\0044'oHo)\031\004\"")
    }
  }, function(action)
    _BxJ0W.Active = false
    _7nt64.Active = false
    _7nt64.Complete = true
    _X_jO.Active = true
    _QHH.Active = true
  end)
  _qQ8E3:RequestSync()
end
function _N_t:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.Dialog(false, {
      {
        Text = _LXU("\127)\004RHe\006MZ\006]Y\006Iv\f\r[E\127)\004\0064QH]I\006\n\015H]Y4WH\006I\0064\n ]\031\006\004\"\f\r[Ea\031 ]?HYD4e)oo\006\"\"\"")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_N_t)
      end)
    end)
    return
  end
  if input == 1850 then
    _Urwigo.OldDialog({
      {
        Text = (_LXU("F\031YYL\031??\006\0044I) ]o)RD4") .. Player.Name) .. _LXU("4vvvv\f\r[E\f\r[Eai\0044e\006R)\004\004o4\025\006I4qHILIi\004\025RH\004R4vv")
      }
    })
  else
    _0pN = _0pN + 1
    _Urwigo.OldDialog({
      {
        Text = _LXU("ZHY\n ]v\f\r[E\f\r[E' ]H\025\0064\025H\n4WHI4Y\006)\025\006I4\004) ]o4I) ]o)R\"\f\r[Et\006)o\006I4R\006]o!\n4?)o4\025\006I4\004H\006 ]\no\006\0044*iORHe\006\"4\f\r[E9')\006]\0064i\004o\006I4*iORHe\006\004\"\030")
      }
    })
  end
  _EsLu.Active = false
  _iRkR.Active = false
  _VOKK.Active = false
  _VOKK.Complete = true
  _Ij6M.Active = true
  _Suswi.Active = true
  _qQ8E3:RequestSync()
end
function _7Bs:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _77tT.Active = false
  _4Ozk.Active = false
  _4Ozk.Complete = true
  if Wherigo.NoCaseEquals(input, _LXU("*\004oW\031Io4*")) then
    _Urwigo.Dialog(false, {
      {
        Text = (_LXU("-H\n4WHI4He\n\031Yio4I) ]o)RD4") .. Player.Name) .. _LXU("4vvvv\f\r[E\f\r[E-\006I4/\006W)\004\0044)\no4\"\"\"4\025\006\0044_H ]\0064>dI\noI\031?oHY>4\ni ]\006\0044i\004\0254Y\031RR\006\004\"4F)\006Y4/Yi\006 L4\025He\006)4vv")
      }
    }, function(action)
      if _0pN < 2 then
        _GYqX.Active = true
        _psG.Active = true
        _Urwigo.OldDialog({
          {
            Text = _LXU("*YY\0064*\004oW\031Io\006\0044WHI\006\0044He\n\031Yio4I) ]o)R4vvv\f\r[EtH]\004\n)\004\0044vvv\f\r[E&iI4\r\006Y\031]\004i\004R4\025HIO\no4-i4f\006o\015o4\025)I\006Lo4\015i?4_H ]\0064R\006]\006\004\"\f\r[E\024\031\n4R\006]o!\n4v")
          },
          {
            Text = _LXU("aH ]4\025\006I4\rIi\006 L\0064e)oo\0064Y)\004L\n4]HYo\006\0044e)\n4\015i?4+Hi\028oW\006R\"")
          }
        })
      else
        _BxJ0W.Active = true
        _7nt64.Active = true
        _Urwigo.OldDialog({
          {
            Text = _LXU("aHD4\n\0314RH\004\0154I) ]o)R4WHI4\025H\n4HYY\006\n4\004) ]o4vvv\f\r[E' ]H\025\0064\015iI4'oIHO\0064W)I\0254\025\006I4_H ]\0064>dI\noI\031?oHY>4Hi\nR\006YH\n\n\006\004\"")
          },
          {
            Text = _LXU("aH ]4\025\006I4\rIi\006 L\0064e)oo\0064Y)\004L\n4]HYo\006\0044e)\n4\015i?4+Hi\028oW\006R\"")
          }
        })
      end
    end)
  else
  end
  _qQ8E3:RequestSync()
end
function _3St:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, _LXU("*\004oW\031Io4*")) then
    _Urwigo.OldDialog({
      {
        Text = (_LXU("-H\n4)\no4He\n\031Yio4I) ]o)RD4") .. Player.Name) .. _LXU("4vvvv\f\r[E\f\r[Et\006)o\006I4R\006]o!\n\"")
      }
    })
  else
    _0pN = _0pN + 1
    _Urwigo.OldDialog({
      {
        Text = _LXU("ZHY\n ]v4\f\r[E\f\r[E\024\006)\025\006I4OHY\n ]D4WHI4He\006I4Hi ]4\n ]W\006I4vv\f\r[E*Y\n\0314e\006)4\025\006I4\004H\006 ]\no\006\0044ZIHR\0064e\006\n\n\006I4R\006\004Hi4HiO\028H\n\n\006\004v\f\r[Et\006)o\006I4R\006]o!\n\"")
      }
    })
  end
  _Ij6M.Active = false
  _Suswi.Active = false
  _Suswi.Complete = true
  _QXJlx.Active = true
  _CJs.Active = true
  _qQ8E3:RequestSync()
end
return _qQ8E3
