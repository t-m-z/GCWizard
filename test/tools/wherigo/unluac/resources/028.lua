require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _kuU1(str)
  local res = ""
  local dtable = ";nvQL\002a\019.b\v~`3@6\003$\028\024\018]E2^\031dr9K&)HZ\b0kw\006T\025>_\f\020\aW\015\004\\7%/zg:U4OhX{o1A\000fR*V(=x\ttB!\023[J\016\022\030M\014Py\"\005\026e5Iu-<G\001j?S+l\029DY|\027\nis\rC\021F#'\017 p}Nqcm,8"
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
_MgpFT = Wherigo.ZCartridge()
_M3O = Wherigo.ZMedia(_MgpFT)
_M3O.Id = "c3f9c57f-250d-4da9-82c7-847bcf85383a"
_M3O.Name = _kuU1("\"n[g")
_M3O.Description = ""
_M3O.AltText = ""
_M3O.Resources = {
  {
    Type = "jpg",
    Filename = "final.jpg",
    Directives = {}
  }
}
_CMP = Wherigo.ZMedia(_MgpFT)
_CMP.Id = "cd86db46-4ddb-45d2-a50d-768206469d52"
_CMP.Name = _kuU1("A\002C\a\0027")
_CMP.Description = ""
_CMP.AltText = ""
_CMP.Resources = {
  {
    Type = "jpg",
    Filename = "Start.jpg",
    Directives = {}
  }
}
_B_V = Wherigo.ZMedia(_MgpFT)
_B_V.Id = "9ca63182-9f78-4195-a3cd-d6d27f730eec"
_B_V.Name = _kuU1("eK\a\028K")
_B_V.Description = ""
_B_V.AltText = ""
_B_V.Resources = {
  {
    Type = "jpg",
    Filename = "Anfang.jpg",
    Directives = {}
  }
}
_J9I = Wherigo.ZMedia(_MgpFT)
_J9I.Id = "b688aacb-d54f-4070-a61d-6aadcfcc6d2b"
_J9I.Name = _kuU1("D^\002\027%^\028o")
_J9I.Description = ""
_J9I.AltText = ""
_J9I.Resources = {
  {
    Type = "jpg",
    Filename = "Rundkurs.jpg",
    Directives = {}
  }
}
_eoCox = Wherigo.ZMedia(_MgpFT)
_eoCox.Id = "d29075c9-ce54-4162-a834-e9aa9a915c2c"
_eoCox.Name = _kuU1("L[K\028^7")
_eoCox.Description = ""
_eoCox.AltText = ""
_eoCox.Resources = {
  {
    Type = "jpg",
    Filename = "roterDaumen.jpg",
    Directives = {}
  }
}
_E7cyv = Wherigo.ZMedia(_MgpFT)
_E7cyv.Id = "29687698-768a-4a04-8bcd-90d823ffafd3"
_E7cyv.Name = _kuU1("Vn\002%[g\002")
_E7cyv.Description = ""
_E7cyv.AltText = ""
_E7cyv.Resources = {
  {
    Type = "jpg",
    Filename = "pinkeln.jpg",
    Directives = {}
  }
}
_MgpFT.Id = "fea63ef3-cc7b-41b2-aa60-eb156bb5802f"
_MgpFT.Name = "Rundkurs"
_MgpFT.Description = "Bist Du wirklich bereit wegen einen oeden Micro dich aufs Fahrrad zu schwingen?"
_MgpFT.Visible = true
_MgpFT.Activity = "TourGuide"
_MgpFT.StartingLocationDescription = ""
_MgpFT.StartingLocation = ZonePoint(51.316383, 12.334967, 0)
_MgpFT.Version = "1.5"
_MgpFT.Company = ""
_MgpFT.Author = "Schmunzelhaase"
_MgpFT.BuilderVersion = "URWIGO 1.22.5798.37755"
_MgpFT.CreateDate = "06/02/2017 19:13:50"
_MgpFT.PublishDate = "1/1/0001 12:00:00 AM"
_MgpFT.UpdateDate = "09/11/2017 19:20:56"
_MgpFT.LastPlayedDate = "1/1/0001 12:00:00 AM"
_MgpFT.TargetDevice = "PocketPC"
_MgpFT.TargetDeviceVersion = "0"
_MgpFT.StateId = "1"
_MgpFT.CountryId = "2"
_MgpFT.Complete = false
_MgpFT.UseLogging = true
_MgpFT.Media = _B_V
_GFa3l = Wherigo.Zone(_MgpFT)
_GFa3l.Id = "33467e88-0e4f-4259-a90e-6ca2c8177b9d"
_GFa3l.Name = _kuU1("D^\002\027%^\028o")
_GFa3l.Description = ""
_GFa3l.Visible = false
_GFa3l.Commands = {}
_GFa3l.DistanceRange = Distance(-1, "feet")
_GFa3l.ShowObjects = "OnEnter"
_GFa3l.ProximityRange = Distance(60, "meters")
_GFa3l.AllowSetPositionTo = false
_GFa3l.Active = false
_GFa3l.Points = {
  ZonePoint(51.3154390722888, 12.3359439231648, 0),
  ZonePoint(51.3147273222645, 12.335391638005, 0),
  ZonePoint(51.3140725024897, 12.3350614056413, 0),
  ZonePoint(51.3132895535345, 12.3348735148137, 0),
  ZonePoint(51.3127770706199, 12.3348165781993, 0),
  ZonePoint(51.3126809794361, 12.3345831380802, 0),
  ZonePoint(51.3132539646282, 12.3326302122054, 0),
  ZonePoint(51.3138732076596, 12.3312067968448, 0),
  ZonePoint(51.3141543554726, 12.330591881409, 0),
  ZonePoint(51.3144105899534, 12.3305121701488, 0),
  ZonePoint(51.3151259036385, 12.3312523461364, 0),
  ZonePoint(51.3154106024998, 12.3315598038542, 0),
  ZonePoint(51.316385682712, 12.3339511416601, 0),
  ZonePoint(51.3158483235528, 12.336188750607, 0),
  ZonePoint(51.3156739473736, 12.336638549861, 0),
  ZonePoint(51.3151436973691, 12.3363538667888, 0),
  ZonePoint(51.3143821195263, 12.335841437259, 0),
  ZonePoint(51.3136952651155, 12.3359040675349, 0),
  ZonePoint(51.3128696026807, 12.335892680212, 0),
  ZonePoint(51.311695143446, 12.3357161767073, 0),
  ZonePoint(51.3124425300738, 12.3340365465817, 0),
  ZonePoint(51.3128304545239, 12.3327953283872, 0),
  ZonePoint(51.3132254934832, 12.331673677083, 0),
  ZonePoint(51.3136703531043, 12.3309164201112, 0),
  ZonePoint(51.3140120023649, 12.3301022265249, 0),
  ZonePoint(51.3143892371347, 12.3298289307757, 0),
  ZonePoint(51.3146063236622, 12.3298004624685, 0),
  ZonePoint(51.3150440523888, 12.3304666208573, 0),
  ZonePoint(51.3154497484551, 12.3308139342052, 0),
  ZonePoint(51.3158732343814, 12.3311156982617, 0),
  ZonePoint(51.3159799949222, 12.3317249200362, 0),
  ZonePoint(51.3163892413609, 12.3328465713403, 0),
  ZonePoint(51.3164853247782, 12.3333590008701, 0),
  ZonePoint(51.3164070346015, 12.3340023846132, 0),
  ZonePoint(51.316166825271, 12.3334159374848, 0)
}
_GFa3l.OriginalPoint = ZonePoint(51.3145108787648, 12.3331945353924, 0)
_GFa3l.DistanceRangeUOM = "Feet"
_GFa3l.ProximityRangeUOM = "Meters"
_GFa3l.OutOfRangeName = ""
_GFa3l.InRangeName = ""
_3frpP = Wherigo.Zone(_MgpFT)
_3frpP.Id = "e8f8f00d-51b3-4b69-85c1-ba2c4dc63df2"
_3frpP.Name = _kuU1("\"n[g")
_3frpP.Description = ""
_3frpP.Visible = false
_3frpP.Commands = {}
_3frpP.DistanceRange = Distance(-1, "feet")
_3frpP.ShowObjects = "OnEnter"
_3frpP.ProximityRange = Distance(60, "meters")
_3frpP.AllowSetPositionTo = false
_3frpP.Active = false
_3frpP.Points = {
  ZonePoint(51.3165511595957, 12.3333760818549, 0),
  ZonePoint(51.3165298077732, 12.3340707085509, 0),
  ZonePoint(51.3159675395383, 12.3337860254787, 0),
  ZonePoint(51.3160387131135, 12.3331938846887, 0)
}
_3frpP.OriginalPoint = ZonePoint(51.3162718050052, 12.3336066751433, 0)
_3frpP.DistanceRangeUOM = "Feet"
_3frpP.ProximityRangeUOM = "Meters"
_3frpP.OutOfRangeName = ""
_3frpP.InRangeName = ""
_6RTQ = Wherigo.Zone(_MgpFT)
_6RTQ.Id = "efaf2d16-e6d6-46d1-9e1e-bfbe4553ae46"
_6RTQ.Name = _kuU1("q<[|%x?n\002Kw@")
_6RTQ.Description = ""
_6RTQ.Visible = false
_6RTQ.Commands = {}
_6RTQ.DistanceRange = Distance(-1, "feet")
_6RTQ.ShowObjects = "OnEnter"
_6RTQ.ProximityRange = Distance(60, "meters")
_6RTQ.AllowSetPositionTo = false
_6RTQ.Active = false
_6RTQ.Points = {
  ZonePoint(51.3151276830114, 12.3357560323378, 0),
  ZonePoint(51.3150351555047, 12.3362570745448, 0),
  ZonePoint(51.3145867503285, 12.3359496168269, 0),
  ZonePoint(51.3146792787396, 12.3354599619428, 0)
}
_6RTQ.OriginalPoint = ZonePoint(51.3148572168961, 12.3358556714131, 0)
_6RTQ.DistanceRangeUOM = "Feet"
_6RTQ.ProximityRangeUOM = "Meters"
_6RTQ.OutOfRangeName = ""
_6RTQ.InRangeName = ""
_kl3z = Wherigo.Zone(_MgpFT)
_kl3z.Id = "5146c9b0-40f6-4497-b5ef-1a4c3273ec18"
_kl3z.Name = _kuU1("q<[|%x?n\002Kw\024")
_kl3z.Description = ""
_kl3z.Visible = false
_kl3z.Commands = {}
_kl3z.DistanceRange = Distance(-1, "feet")
_kl3z.ShowObjects = "OnEnter"
_kl3z.ProximityRange = Distance(60, "meters")
_kl3z.AllowSetPositionTo = false
_kl3z.Active = false
_kl3z.Points = {
  ZonePoint(51.3129212070178, 12.3342415183942, 0),
  ZonePoint(51.3124941348911, 12.3338771240618, 0),
  ZonePoint(51.3123446587076, 12.3343667789459, 0),
  ZonePoint(51.3128215572104, 12.3346059127265, 0)
}
_kl3z.OriginalPoint = ZonePoint(51.3126453894567, 12.3342728335321, 0)
_kl3z.DistanceRangeUOM = "Feet"
_kl3z.ProximityRangeUOM = "Meters"
_kl3z.OutOfRangeName = ""
_kl3z.InRangeName = ""
_cbcF9 = Wherigo.Zone(_MgpFT)
_cbcF9.Id = "a0768c22-9d1c-4dff-8468-dbf7a3ac7077"
_cbcF9.Name = _kuU1("q<[|%x?n\002Kw\014")
_cbcF9.Description = ""
_cbcF9.Visible = false
_cbcF9.Commands = {}
_cbcF9.DistanceRange = Distance(-1, "feet")
_cbcF9.ShowObjects = "OnEnter"
_cbcF9.ProximityRange = Distance(60, "meters")
_cbcF9.AllowSetPositionTo = false
_cbcF9.Active = false
_cbcF9.Points = {
  ZonePoint(51.3140813995596, 12.3310189060177, 0),
  ZonePoint(51.3137255153963, 12.3303812159361, 0),
  ZonePoint(51.3135475722794, 12.3308253215286, 0),
  ZonePoint(51.3139248108679, 12.33138330035, 0)
}
_cbcF9.OriginalPoint = ZonePoint(51.3138198245258, 12.3309021859581, 0)
_cbcF9.DistanceRangeUOM = "Feet"
_cbcF9.ProximityRangeUOM = "Meters"
_cbcF9.OutOfRangeName = ""
_cbcF9.InRangeName = ""
_xSqd = Wherigo.Zone(_MgpFT)
_xSqd.Id = "1c184dac-9d7f-4b1a-8a0a-becf7b9c3991"
_xSqd.Name = _kuU1("q<[|%x?n\002Kw:")
_xSqd.Description = ""
_xSqd.Visible = false
_xSqd.Commands = {}
_xSqd.DistanceRange = Distance(-1, "feet")
_xSqd.ShowObjects = "OnEnter"
_xSqd.ProximityRange = Distance(60, "meters")
_xSqd.AllowSetPositionTo = false
_xSqd.Active = false
_xSqd.Points = {
  ZonePoint(51.3155760829006, 12.3306089623938, 0),
  ZonePoint(51.3152842675977, 12.3315313355475, 0),
  ZonePoint(51.3156045525869, 12.3322145749206, 0),
  ZonePoint(51.3162166465685, 12.3319868284629, 0)
}
_xSqd.OriginalPoint = ZonePoint(51.3156703874134, 12.3315854253312, 0)
_xSqd.DistanceRangeUOM = "Feet"
_xSqd.ProximityRangeUOM = "Meters"
_xSqd.OutOfRangeName = ""
_xSqd.InRangeName = ""
_6Z7 = Wherigo.Zone(_MgpFT)
_6Z7.Id = "3a991389-2e4c-4853-8c51-af792220b816"
_6Z7.Name = _kuU1("eK\a\028K")
_6Z7.Description = ""
_6Z7.Visible = false
_6Z7.Commands = {}
_6Z7.DistanceRange = Distance(-1, "feet")
_6Z7.ShowObjects = "OnEnter"
_6Z7.ProximityRange = Distance(60, "meters")
_6Z7.AllowSetPositionTo = false
_6Z7.Active = false
_6Z7.Points = {
  ZonePoint(51.3162138413806, 12.3345279904523, 0),
  ZonePoint(51.3160971620783, 12.3349946908035, 0),
  ZonePoint(51.3158054625242, 12.3348409542172, 0),
  ZonePoint(51.3159427331336, 12.3343577820889, 0)
}
_6Z7.OriginalPoint = ZonePoint(51.3160147997792, 12.3346803543905, 0)
_6Z7.DistanceRangeUOM = "Feet"
_6Z7.ProximityRangeUOM = "Meters"
_6Z7.OutOfRangeName = ""
_6Z7.InRangeName = ""
_50NgC = Wherigo.Zone(_MgpFT)
_50NgC.Id = "4036f188-f09c-4eeb-9e8c-75f32a53a7ae"
_50NgC.Name = _kuU1("V^gg[\028\ag\a\028}")
_50NgC.Description = ""
_50NgC.Visible = true
_50NgC.Media = _E7cyv
_50NgC.Commands = {}
_50NgC.DistanceRange = Distance(-1, "feet")
_50NgC.ShowObjects = "OnEnter"
_50NgC.ProximityRange = Distance(60, "meters")
_50NgC.AllowSetPositionTo = false
_50NgC.Active = false
_50NgC.Points = {
  ZonePoint(51.3160438023951, 12.3353886557776, 0),
  ZonePoint(51.3156682771177, 12.3351579858023, 0),
  ZonePoint(51.3155073367721, 12.3357427073676, 0),
  ZonePoint(51.3159096865774, 12.3359358264166, 0)
}
_50NgC.OriginalPoint = ZonePoint(51.3157822757156, 12.335556293841, 0)
_50NgC.DistanceRangeUOM = "Feet"
_50NgC.ProximityRangeUOM = "Meters"
_50NgC.OutOfRangeName = ""
_50NgC.InRangeName = ""
_ZJ1u = Wherigo.ZItem(_MgpFT)
_ZJ1u.Id = "3009d53e-224a-4864-9664-7423538c33b8"
_ZJ1u.Name = _kuU1("9\002g?|%wq?\027[")
_ZJ1u.Description = _kuU1("9\002g?|%wq?\027[w^}w\027n[wq\a\028K\028n\0277[w\a^Cw/<[\028n7?\t|?}wC\028[n6^o|<\agK[\002\t")
_ZJ1u.Visible = true
_ZJ1u.Commands = {
  _qZH3n = Wherigo.ZCommand({
    Text = _kuU1("A\0026[n7[\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _kuU1("zn|<Kw\003[\028C^7\n\a\028")
  })
}
_ZJ1u.Commands._qZH3n.Custom = true
_ZJ1u.Commands._qZH3n.Id = "9963e8b7-194f-4ec0-ad2d-938e848531c8"
_ZJ1u.Commands._qZH3n.WorksWithAll = true
_ZJ1u.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ZJ1u.Locked = false
_ZJ1u.Opened = false
_vND_ = Wherigo.ZItem(_MgpFT)
_vND_.Id = "6e361133-ea04-418e-991e-5a907ea34d35"
_vND_.Name = _kuU1("eK\028[|%[")
_vND_.Description = ""
_vND_.Visible = true
_vND_.Media = _J9I
_vND_.Commands = {}
_vND_.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_vND_.Locked = false
_vND_.Opened = false
_R0pTJ = Wherigo.ZItem(_MgpFT)
_R0pTJ.Id = "e549f218-2bc1-4542-a657-1f064dd2419d"
_R0pTJ.Name = _kuU1("sn\002\ag")
_R0pTJ.Description = ""
_R0pTJ.Visible = false
_R0pTJ.Commands = {
  _Mw_4Y = Wherigo.ZCommand({
    Text = _kuU1("A\0026[n7[\002"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _kuU1("zn|<Kw\003[\028C^7\n\a\028")
  })
}
_R0pTJ.Commands._Mw_4Y.Custom = true
_R0pTJ.Commands._Mw_4Y.Id = "6e0e3b05-403d-46bb-9625-8feb77251c8f"
_R0pTJ.Commands._Mw_4Y.WorksWithAll = true
_R0pTJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_R0pTJ.Locked = false
_R0pTJ.Opened = false
_FlIV8 = Wherigo.ZItem({Cartridge = _MgpFT, Container = _50NgC})
_FlIV8.Id = "f70d9dc1-0eb1-48ce-9b96-b4b9e97c55d2"
_FlIV8.Name = _kuU1("V^gg[\028\ag\a\028}")
_FlIV8.Description = ""
_FlIV8.Visible = true
_FlIV8.Media = _E7cyv
_FlIV8.Commands = {
  _nCmk = Wherigo.ZCommand({
    Text = _kuU1("Vn\002%[gx\a^o["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _kuU1("zn|<Kw\003[\028C^7\n\a\028")
  }),
  _vIl = Wherigo.ZCommand({
    Text = _kuU1("]|<w<\a\n[wC[\028Kn7"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _kuU1("zn|<Kw\003[\028C^7\n\a\028")
  })
}
_FlIV8.Commands._nCmk.Custom = true
_FlIV8.Commands._nCmk.Id = "86a0529f-d2be-4804-846d-dfb1fbe03e15"
_FlIV8.Commands._nCmk.WorksWithAll = true
_FlIV8.Commands._vIl.Custom = true
_FlIV8.Commands._vIl.Id = "d4258b8e-07b2-42e0-bf7d-fb64ffc8fba4"
_FlIV8.Commands._vIl.WorksWithAll = true
_FlIV8.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_FlIV8.Locked = false
_FlIV8.Opened = false
_1WJl = Wherigo.ZTask(_MgpFT)
_1WJl.Id = "baf4fe1f-b0ab-4b13-93b8-2e0d58385f1c"
_1WJl.Name = _kuU1("A\0026\a<gw\027[\028wD^\002\027[\002")
_1WJl.Description = ""
_1WJl.Visible = false
_1WJl.Active = false
_1WJl.Complete = false
_1WJl.CorrectState = "None"
__fsP = Wherigo.ZTask(_MgpFT)
__fsP.Id = "7b930103-2f89-474d-8776-0003e7d2cb4d"
__fsP.Name = _kuU1("D[oK6[nK")
__fsP.Description = ""
__fsP.Visible = false
__fsP.Active = false
__fsP.Complete = false
__fsP.CorrectState = "None"
_U419E = 0
_YDib = ""
_QTzlq = ""
_MGR5 = 0
_yLW = 0
_ARuR = 0
_545n = 0
_xFT1 = _kuU1("+as\a\014g")
_3zkT = _kuU1("\027^}}W")
_cka = _kuU1("+\"P@^")
_DDW = _kuU1("+@/Pg")
_9IFpm = _kuU1("\027^}}W")
_6gjCL = _kuU1("+j@gT:")
_MgpFT.ZVariables = {
  _U419E = 0,
  _YDib = "",
  _QTzlq = "",
  _MGR5 = 0,
  _yLW = 0,
  _ARuR = 0,
  _545n = 0,
  _xFT1 = _kuU1("+as\a\014g"),
  _3zkT = _kuU1("\027^}}W"),
  _cka = _kuU1("+\"P@^"),
  _DDW = _kuU1("+@/Pg"),
  _9IFpm = _kuU1("\027^}}W"),
  _6gjCL = _kuU1("+j@gT:")
}
_Y1lM4 = Wherigo.ZTimer(_MgpFT)
_Y1lM4.Id = "e8bd0a93-d57d-4424-95b4-d2f8051f21f7"
_Y1lM4.Name = _kuU1("q?^\002K\027?&\002")
_Y1lM4.Description = ""
_Y1lM4.Visible = true
_Y1lM4.Duration = 28800
_Y1lM4.Type = "Countdown"
_4Rn = Wherigo.ZTimer(_MgpFT)
_4Rn.Id = "f33ebe28-fc44-4b74-8935-e0b16e8f4f79"
_4Rn.Name = _kuU1("]\002K[\028\003\agg")
_4Rn.Description = ""
_4Rn.Visible = true
_4Rn.Duration = 5
_4Rn.Type = "Interval"
function _MgpFT:OnStart()
  _QTzlq = Player.Name
  _YDib = (_kuU1("!\agg?w") .. _QTzlq) .. _kuU1("`LD*`LD*i[n\002[wA^C7\a\n[w\n[oK[<Kw\027\a\028n\002w\\$wD^\002\027[\002w6^w\027\028[<[\002\twLg[n\n[w\a\n[\028wn\002w\027[}wD^\002\027%^\028o~wo?\002oKw}^ooKwi^w\003?\002w\003?\028\002[w\n[7n\002\002[\002\tw`LD*`LD*L[7n\nwin|<w6^}weK\a\028KM")
  _Urwigo.MessageBox({
    Text = _YDib,
    Callback = function(action)
      if action ~= nil then
        _6Z7.Active = true
        _6Z7.Visible = true
        _vND_:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _MgpFT:OnRestore()
end
function _GFa3l:OnEnter()
  _xFT1 = _kuU1("+as\a\014g")
  _Urwigo.MessageBox({
    Text = _kuU1("]|<w&^[\002o|<[win\028w\003n[gwex\aoo\t"),
    Media = _CMP,
    Callback = function(action)
      if action ~= nil then
        _4Rn.Duration = 5
        _Y1lM4.Duration = 28800
        _4Rn:Start()
        _Y1lM4:Start()
        _1WJl.Active = true
        _1WJl.Visible = true
        __fsP.Name = _Y1lM4.Remaining .. _kuU1("we[%^\002\027[\002")
        _1WJl.Name = _545n .. _kuU1("wD^\002\027[G\002 ")
        _6RTQ.Active = true
        _kl3z.Active = true
        _cbcF9.Active = true
        _xSqd.Active = true
        _6Z7.Active = false
        _6Z7.Visible = false
      end
    end
  })
end
function _GFa3l:OnExit()
  _xFT1 = _kuU1("+as\a\014g")
  _3frpP.Active = false
  _GFa3l.Active = false
  _6RTQ.Active = false
  _kl3z.Active = false
  _cbcF9.Active = false
  _xSqd.Active = false
  _6Z7.Active = true
  _6Z7.Visible = true
  _Y1lM4:Stop()
  _4Rn:Stop()
  _Urwigo.MessageBox({
    Text = _kuU1("P[K6Kw}^ooKwi^w\003?\002w\003?\028\002[w\n[7n\002\002[\002\t"),
    Callback = function(action)
      if action ~= nil then
        _U419E = 0
        _yLW = 0
        _ARuR = 0
        _MGR5 = 0
        _545n = 0
      end
    end
  })
end
function _3frpP:OnEnter()
  _xFT1 = _kuU1("+\014C\028xV")
  if _U419E >= 50 and 50 <= _yLW and 50 <= _ARuR and 50 <= _MGR5 then
    _545n = _545n + 1
    _1WJl.Name = _545n .. _kuU1("wD^\002\027[G\002 ")
    _6RTQ.Active = false
    _kl3z.Active = false
    _cbcF9.Active = false
    _xSqd.Active = false
    _3frpP.Active = false
    _GFa3l.Active = false
    _GFa3l.Visible = false
    _50NgC.Visible = false
    _50NgC.Active = false
    _Y1lM4:Stop()
    _4Rn:Stop()
    _Urwigo.MessageBox({
      Text = _kuU1("![\0286gn|<[\002wag^[|%&^\002o|<\twi^w<\aoKw[ow7[o|<\aCCK\tw]|<w<\aKK[w\002n[w7[\027\a|<K~w\027\aoow\027n\028w\027n[o[\028wTn|\028?wo?w&n|<Kn7wnoK\twA\n[\028w[n\002[\002wx?onKn\003[\002w\023CC[%Kw<\aKw\027\aowc\aw\agg[}\ag\t`LD*i^w<\aoKwc[K6Kwc[\027[}[\0027[w\030\ag?\028n[\002w\003[\028\n\028\a\002\002K\tw8 `LD*`LD*i\aowexn[gwnoKwc[K6Kw\agow\027^\028|<7[oxn[gKw}\a%n[\028K\t"),
      Media = _M3O,
      Callback = function(action)
        if action ~= nil then
          _R0pTJ:MoveTo(Player)
          _R0pTJ.Visible = true
          _MgpFT.Complete = true
          _ZJ1u:MoveTo(Player)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          _MgpFT:RequestSync()
        end
      end
    })
  elseif _545n >= 49 then
    _6RTQ.Active = false
    _kl3z.Active = false
    _cbcF9.Active = false
    _xSqd.Active = false
    _3frpP.Active = false
    _GFa3l.Active = false
    _GFa3l.Visible = false
    _50NgC.Active = false
    _50NgC.Visible = false
    _4Rn:Stop()
    _Y1lM4:Stop()
    _MgpFT:RequestSync()
    _Urwigo.MessageBox({
      Text = _kuU1("i^w&\a\028oKw\002n|<Kw7\a\0026w[<\028gn|<\twi^w<\aooKw7\a\0026w\n[oKn}}Kw\002n|<Kwi[n\002[wD^\002\027[\002w7[\027\028[<K\tw\002^\002w}^ooKwi^w\002?|<[n\002}\agw\003?\002w7\a\0026w\003?\028\002[w\n[7n\002\002[\002M"),
      Media = _eoCox,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Wn4()
    _MgpFT:RequestSync()
  end
end
function _6RTQ:OnEnter()
  _xFT1 = _kuU1("+\016D(\004")
  _U419E = _U419E + 1
  _3frpP.Active = true
end
function _kl3z:OnEnter()
  _xFT1 = _kuU1("+%g\0146")
  _yLW = _yLW + 1
end
function _cbcF9:OnEnter()
  _xFT1 = _kuU1("+|\n|s\029")
  _ARuR = _ARuR + 1
end
function _xSqd:OnEnter()
  _xFT1 = _kuU1("+Ie{\027")
  _MGR5 = _MGR5 + 1
end
function _6Z7:OnEnter()
  _xFT1 = _kuU1("+\016\"3")
  _1WJl.Active = true
  _1WJl.Visible = true
  __fsP.Active = true
  __fsP.Visible = true
  __fsP.Name = _Y1lM4.Remaining .. _kuU1("we[%^\002\027[\002")
  _1WJl.Name = _545n .. _kuU1("wD^\002\027[G\002 ")
  _GFa3l.Active = true
  _GFa3l.Visible = true
  _50NgC.Active = true
end
function _Y1lM4:OnTick()
  _Urwigo.MessageBox({
    Text = _kuU1("i^w<\aKK[oKw\028[n|<gn|<w\"[nK\twz^\002w}^ooKwi^w\002?|<}\agw\003?\002w\003?\028\002[w\n[7n\002\002[\002\t`LD*"),
    Callback = function(action)
      if action ~= nil then
        _GFa3l.Active = false
        _GFa3l.Visible = false
        _3frpP.Active = false
        _3frpP.Visible = false
      end
    end
  })
end
function _4Rn:OnTick()
  __fsP.Name = (_kuU1("D[oK6[nKw") .. _Urwigo.Floor(_Y1lM4.Remaining + 0, 0)) .. _kuU1("we[%^\002\027[\002")
end
function _ZJ1u:On_qZH3n(target)
  _Urwigo.MessageBox({
    Text = string.sub(Player.CompletionCode, 1, 15),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _R0pTJ:On_Mw_4Y(target)
  _Urwigo.MessageBox({
    Text = _kuU1("/n[w\003[\028ox\028?|<[\002won\002\027w<n[\028w\027n[w\030??\028\027n\002\aK[\002\t`LD*`LD*zw\\@w@\029\t\014\029\024w\023w$@\024w@\029\t\0293$`LD*`LD*!n\002K8wzn|<Kw%g[KK[\028\002MMMws^[oo[w\ng[n\n[\002w\a^Cw\027[}wL^[\0287[\028oK[n7\twe|<\a^[win\028w\027[\002w\"\a^\002w\a\002Mwi?\028Kw[\002K\027[|%oKwi^w[K&\aow\a^oo[\0287&?[<\002gn|<[own\002w\027[\028w\023|%[\tw\023\028oKw\027\a\002\002w6^7\028[nC[\002\twLnKK[w\a|<K[Kw\a^CwT^77[go\t")
  })
end
function _FlIV8:On_nCmk(target)
  _Urwigo.MessageBox({
    Text = _kuU1("!n[\028w<\aoKwi^w\027n[wT?[7gn|<%[nKw\a^|<w}\agw7[&noo[\002wL[\027^[\028C\002noo[\002w\002\a|<6^7[<[\002\twA\n[\028wx\aoow\a^C~w\027n[w\"[nKwg\a[^CKw&[nK[\028MMM"),
    Media = _E7cyv,
    Callback = function(action)
      if action ~= nil then
        _GFa3l.Active = false
        _6RTQ.Active = false
        _kl3z.Active = false
        _cbcF9.Active = false
        _xSqd.Active = false
        _FlIV8.Commands._nCmk.Enabled = false
        _FlIV8.Commands._vIl.Enabled = true
        _3frpP.Active = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _FlIV8:On_vIl(target)
  if _U419E >= 1 then
    _Urwigo.MessageBox({
      Text = _kuU1("/[nK[\028w7[<Kw[o\t"),
      Media = _CMP,
      Callback = function(action)
        if action ~= nil then
          _GFa3l.Active = true
          _6RTQ.Active = true
          _kl3z.Active = true
          _cbcF9.Active = true
          _xSqd.Active = true
          _FlIV8.Commands._vIl.Enabled = false
          _FlIV8.Commands._nCmk.Enabled = true
          _3frpP.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _kuU1("/[nK[\028w7[<Kw[o\t"),
      Media = _CMP,
      Callback = function(action)
        if action ~= nil then
          _GFa3l.Active = true
          _6RTQ.Active = true
          _kl3z.Active = true
          _cbcF9.Active = true
          _xSqd.Active = true
          _FlIV8.Commands._vIl.Enabled = false
          _FlIV8.Commands._nCmk.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Wn4()
  _545n = _545n + 1
  _1WJl.Name = _545n .. _kuU1("wD^\002\027[G\002 ")
end
return _MgpFT
