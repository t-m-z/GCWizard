require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _kk2B(str)
  local res = ""
  local dtable = "B\014fEJ.p\027]\003&\nu\tq\023\026!\0027%3`\005~Xr/+'dj\000\024\018Lay\015*\"(\022e=K$#txN4C\a>\020^@\f:HhI}FW_-bwl\030VZoU\017,<\006iR6\b\004A\028kSv\001{\v;gO\019Q89GYM5m?\0250c\021\\\031[1)D\r2T|s\016Pn\029 z"
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
_2P9 = Wherigo.ZCartridge()
_zEYSE = Wherigo.ZMedia(_2P9)
_zEYSE.Id = "013f2567-5770-440d-a722-39e4b54eb804"
_zEYSE.Name = _kk2B("\027,Z,\027y,Cm%m>,")
_zEYSE.Description = ""
_zEYSE.AltText = ""
_zEYSE.Resources = {
  {
    Type = "jpg",
    Filename = "reverse_cache.jpg",
    Directives = {}
  }
}
_2xHNM = Wherigo.ZMedia(_2P9)
_2xHNM.Id = "516dc3e2-2398-476d-8b16-ae04fd843e3a"
_2xHNM.Name = _kk2B("\027,Z,\027y,~m%m>,~QmK|")
_2xHNM.Description = ""
_2xHNM.AltText = ""
_2xHNM.Resources = {
  {
    Type = "jpg",
    Filename = "reverse_cache_icon.jpg",
    Directives = {}
  }
}
_nFWPm = Wherigo.ZMedia(_2P9)
_nFWPm.Id = "efef0c8d-d63d-4b80-a890-4a650efb42de"
_nFWPm.Name = _kk2B("GKm%1QK|G,yy")
_nFWPm.Description = ""
_nFWPm.AltText = ""
_nFWPm.Resources = {
  {
    Type = "jpg",
    Filename = "locationless.jpg",
    Directives = {}
  }
}
_Hrf = Wherigo.ZMedia(_2P9)
_Hrf.Id = "4a16fd23-5347-4392-99e5-10007880aa51"
_Hrf.Name = _kk2B("\015\r,y1QK|Ci%\027X")
_Hrf.Description = ""
_Hrf.AltText = ""
_Hrf.Resources = {
  {
    Type = "jpg",
    Filename = "smaller.jpg",
    Directives = {}
  }
}
_eHW0b = Wherigo.ZMedia(_2P9)
_eHW0b.Id = "9850f87d-9dc6-4aab-b0b6-b9124067767a"
_eHW0b.Name = _kk2B("ZQm1K\027&")
_eHW0b.Description = ""
_eHW0b.AltText = ""
_eHW0b.Resources = {
  {
    Type = "jpg",
    Filename = "victory.jpg",
    Directives = {}
  }
}
_dWDlR = Wherigo.ZMedia(_2P9)
_dWDlR.Id = "eec3c7df-9c0a-4c92-9e93-a0fcf7874a60"
_dWDlR.Name = _kk2B("w>,C\004|\031")
_dWDlR.Description = ""
_dWDlR.AltText = ""
_dWDlR.Resources = {
  {
    Type = "jpg",
    Filename = "The_End.jpg",
    Directives = {}
  }
}
_oUQGL = Wherigo.ZMedia(_2P9)
_oUQGL.Id = "c25fd5ff-0b63-47e3-a5db-1726dfb96399"
_oUQGL.Name = _kk2B("\aKy1,\027")
_oUQGL.Description = ""
_oUQGL.AltText = ""
_oUQGL.Resources = {
  {
    Type = "jpg",
    Filename = "ShowImage.jpg",
    Directives = {}
  }
}
_bns = Wherigo.ZMedia(_2P9)
_bns.Id = "863e3be4-1390-4fdd-a753-debbc70183f5"
_bns.Name = _kk2B("tQy1%|m,")
_bns.Description = ""
_bns.AltText = ""
_bns.Resources = {
  {
    Type = "jpg",
    Filename = "icon_gps.jpg",
    Directives = {}
  }
}
_9t9v = Wherigo.ZMedia(_2P9)
_9t9v.Id = "46f2a954-e420-4e57-955f-eba7a9c587aa"
_9t9v.Name = _kk2B("3%i,")
_9t9v.Description = ""
_9t9v.AltText = ""
_9t9v.Resources = {
  {
    Type = "jpg",
    Filename = "indiana.jpg",
    Directives = {}
  }
}
_DPDAR = Wherigo.ZMedia(_2P9)
_DPDAR.Id = "d60000d3-6bc4-420f-b0dd-c844f16590e2"
_DPDAR.Name = _kk2B("BK\027G\031")
_DPDAR.Description = ""
_DPDAR.AltText = ""
_DPDAR.Resources = {
  {
    Type = "jpg",
    Filename = "world.jpg",
    Directives = {}
  }
}
_JAq8F = Wherigo.ZMedia(_2P9)
_JAq8F.Id = "3a7688ee-3037-4bd7-b222-3cc82a5c7744"
_JAq8F.Name = _kk2B("F>,\027Q_KCQmK|")
_JAq8F.Description = ""
_JAq8F.AltText = ""
_JAq8F.Resources = {
  {
    Type = "jpg",
    Filename = "wherigo_icon.jpg",
    Directives = {}
  }
}
_4uVkB = Wherigo.ZMedia(_2P9)
_4uVkB.Id = "193e5e0d-d9b7-47e8-b480-2d0ea5cde5a5"
_4uVkB.Name = _kk2B("1\027%\031Q1QK|%GCQmK|")
_4uVkB.Description = ""
_4uVkB.AltText = ""
_4uVkB.Resources = {
  {
    Type = "jpg",
    Filename = "traditional.jpg",
    Directives = {}
  }
}
_Drb = Wherigo.ZMedia(_2P9)
_Drb.Id = "94e4c2cb-4499-4962-b019-ebfe3a7f627f"
_Drb.Name = _kk2B("1\027%\031Q1QK|%G")
_Drb.Description = ""
_Drb.AltText = ""
_Drb.Resources = {
  {
    Type = "jpg",
    Filename = "traditional1.jpg",
    Directives = {}
  }
}
_QLtp4 = Wherigo.ZMedia(_2P9)
_QLtp4.Id = "a8f5b412-7e0b-4f9b-a8c6-73119a64d24d"
_QLtp4.Name = _kk2B("Y%11,GQ1,")
_QLtp4.Description = ""
_QLtp4.AltText = ""
_QLtp4.Resources = {
  {
    Type = "jpg",
    Filename = "sattelite.jpg",
    Directives = {}
  }
}
_LKDb = Wherigo.ZMedia(_2P9)
_LKDb.Id = "55ff487f-e636-4346-b7a0-21b34cf29c79"
_LKDb.Name = _kk2B("|KQy,")
_LKDb.Description = ""
_LKDb.AltText = ""
_LKDb.Resources = {
  {
    Type = "mp3",
    Filename = "noise.mp3",
    Directives = {}
  }
}
_tLh_W = Wherigo.ZMedia(_2P9)
_tLh_W.Id = "2c4e5cbd-6b2a-4a4c-a464-0e0abc8d068c"
_tLh_W.Name = _kk2B("5>,mX~g%\027X")
_tLh_W.Description = ""
_tLh_W.AltText = ""
_tLh_W.Resources = {
  {
    Type = "jpg",
    Filename = "Check_Mark.jpg",
    Directives = {}
  }
}
_cPu = Wherigo.ZMedia(_2P9)
_cPu.Id = "98c6654c-e3c7-4271-8766-40fb299525c6"
_cPu.Name = _kk2B("EKKX")
_cPu.Description = ""
_cPu.AltText = ""
_cPu.Resources = {
  {
    Type = "jpeg",
    Filename = "book.jpeg",
    Directives = {}
  }
}
_Kfxj = Wherigo.ZMedia(_2P9)
_Kfxj.Id = "1bec6bba-8a06-4d24-9495-6a6d3717f025"
_Kfxj.Name = _kk2B("\001KKXCQmK|")
_Kfxj.Description = ""
_Kfxj.AltText = ""
_Kfxj.Resources = {
  {
    Type = "jpg",
    Filename = "book_icon.jpg",
    Directives = {}
  }
}
_ItHiF = Wherigo.ZMedia(_2P9)
_ItHiF.Id = "fb774ef4-c366-44e7-ba8f-3317a7cb3146"
_ItHiF.Name = _kk2B("FK\027G\031")
_ItHiF.Description = ""
_ItHiF.AltText = ""
_ItHiF.Resources = {
  {
    Type = "jpg",
    Filename = "world2.jpg",
    Directives = {}
  }
}
_PD0 = Wherigo.ZMedia(_2P9)
_PD0.Id = "5e6ed111-0224-4860-8695-94eeb3a2e842"
_PD0.Name = _kk2B("FK\027G\031v")
_PD0.Description = ""
_PD0.AltText = ""
_PD0.Resources = {
  {
    Type = "jpg",
    Filename = "world2_1.jpg",
    Directives = {}
  }
}
_2P9.Id = "9cf252df-2dbb-4ac9-ac90-4327d828886b"
_2P9.Name = "KGB 7"
_2P9.Description = ""
_2P9.Visible = true
_2P9.Activity = "Puzzle"
_2P9.StartingLocationDescription = ""
_2P9.StartingLocation = ZonePoint(53.127567, 12.815167, 0)
_2P9.Version = "1.1"
_2P9.Company = ""
_2P9.Author = ""
_2P9.BuilderVersion = "URWIGO 1.22.5798.37755"
_2P9.CreateDate = "01/28/2015 10:03:49"
_2P9.PublishDate = "1/1/0001 12:00:00 AM"
_2P9.UpdateDate = "04/22/2020 16:45:55"
_2P9.LastPlayedDate = "1/1/0001 12:00:00 AM"
_2P9.TargetDevice = "PocketPC"
_2P9.TargetDeviceVersion = "0"
_2P9.StateId = "1"
_2P9.CountryId = "2"
_2P9.Complete = false
_2P9.UseLogging = true
_2P9.Media = _PD0
_2P9.Icon = _JAq8F
_hBZb1 = Wherigo.Zone(_2P9)
_hBZb1.Id = "b1dba1a4-7225-49b9-8be0-1d04bbe52ead"
_hBZb1.Name = _kk2B("AQ|%G")
_hBZb1.Description = ""
_hBZb1.Visible = false
_hBZb1.Commands = {}
_hBZb1.DistanceRange = Distance(-1, "feet")
_hBZb1.ShowObjects = "OnEnter"
_hBZb1.ProximityRange = Distance(10, "meters")
_hBZb1.AllowSetPositionTo = false
_hBZb1.Active = true
_hBZb1.Points = {
  ZonePoint(53.1359804484105, 12.8334694772334, 0),
  ZonePoint(53.1360565559066, 12.8336201260705, 0),
  ZonePoint(53.1361046155758, 12.8335525938332, 0),
  ZonePoint(53.136036328411, 12.8334244557419, 0)
}
_hBZb1.OriginalPoint = ZonePoint(53.136044487076, 12.8335166632197, 0)
_hBZb1.DistanceRangeUOM = "Feet"
_hBZb1.ProximityRangeUOM = "Meters"
_hBZb1.OutOfRangeName = ""
_hBZb1.InRangeName = ""
_EEjKU = Wherigo.ZItem({Cartridge = _2P9, Container = Player})
_EEjKU.Id = "69ae83e9-36d1-4669-ba63-d01418a770fb"
_EEjKU.Name = _kk2B("R,Z,\027y,~5%m>,~\001K2")
_EEjKU.Description = ""
_EEjKU.Visible = true
_EEjKU.Media = _zEYSE
_EEjKU.Icon = _2xHNM
_EEjKU.Commands = {
  _lQjA = Wherigo.ZCommand({
    Text = _kk2B("tQy1%|m,~1K~1>,~5%m>,"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _kk2B("3K1>Q|_~%Z%QG%EG,")
  })
}
_EEjKU.Commands._lQjA.Custom = true
_EEjKU.Commands._lQjA.Id = "e3fc6548-87a6-4603-a92f-e8fdb8bcc7c3"
_EEjKU.Commands._lQjA.WorksWithAll = true
_EEjKU.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_EEjKU.Locked = false
_EEjKU.Opened = false
_RKgG = Wherigo.ZItem(_2P9)
_RKgG.Id = "ec792278-916f-4bfd-8ba7-f2c184348880"
_RKgG.Name = _kk2B("{G%&,\027~5Ki\aG,1QK|~5K\031,")
_RKgG.Description = ""
_RKgG.Visible = true
_RKgG.Commands = {}
_RKgG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_RKgG.Locked = false
_RKgG.Opened = false
_g0asd = Wherigo.ZItem(_2P9)
_g0asd.Id = "3721b71b-b04f-4184-a548-d4976d7ed44f"
_g0asd.Name = _kk2B("?|y1\027\rm1QK|y")
_g0asd.Description = _kk2B("t,\027~V\0271QX,G~Q|~?>\027,i~?|Z,|1%\027~Qy1~,Q|,~R,Z,\027y,D5%m>,D\001K2\006~V|y1%11~?>|,|~.KK\027\031Q|%1,|~\003\195\188\027~\031,|~5%m>,~%|\127\r_,E,|N~\127,Q_1~\031%y~A,G\031~\003\195\188\027~\031,|~\ri_,X,>\0271,|~5%m>,~\031,|~VEy1%|\031~\127\ri~5%m>,~%|\006~?>\027,~V\r\003_%E,~Qy1~,yN~\031,|~e,Km%m>,~|\r\027~\195\188E,\027~\031Q,~\004|1\003,\027|\r|_~\127\r~\003Q|\031,|\006~I,\027y\rm>,|~YQ,N~\031Q,~\001K2~yK~F,|Q_~FQ,~i\195\182_GQm>~\127\r~Z,\027F,|\031,|N~\r|\031~Z,\027\195\182\003\003,|1GQm>,|~YQ,~?>\027,~V|\127%>G~ZK|~I,\027y\rm>,|~Q|~?>\027,i~_,\003\r|\031,|,|~{\027K1KXKGG\006O\001R7w>,~Q1,i~Q|~&K\r\027~Q|Z,|1K\027&~Qy~%~\027,Z,\027y,~m%m>,~EK2\006~?|y1,%\031~K\003~_QZQ|_~&K\r~mKK\027\031Q|%1,y~1K~1>,~m%m>,N~1>,~\027,Z,\027y,~m%m>,~EK2~FQGG~Q|\031Qm%1,\031~1>,~\031Qy1%|m,~1K~1>,~m%m>,\006~fK\r\027~1%yX~Qy~1K~\003Q|\031~1>,~_,Km%m>,~\ryQ|_~K|G&~\031Qy1%|m,\006~w\027&~\ryQ|_~1>,~EK2~%y~GQ11G,~%y~\aKyyQEG,~%|\031~\aKy1~&K\r\027~|\riE,\027~K\003~1\027Q,y~1K~&K\r\027~\003K\r|\031~Q1~GK_\006")
_g0asd.Visible = true
_g0asd.Media = _cPu
_g0asd.Icon = _Kfxj
_g0asd.Commands = {}
_g0asd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g0asd.Locked = false
_g0asd.Opened = false
_GNP = Wherigo.ZTask(_2P9)
_GNP.Id = "95ed7428-c0fe-46b8-b494-f06aaaea3572"
_GNP.Name = _kk2B("AQ|\031~1>,~5%m>,")
_GNP.Description = _kk2B("AQ|\031,~\031,|~e,Km%m>,O\001R7AQ|\031~1>,~_,Km%m>,")
_GNP.Visible = true
_GNP.Media = _Drb
_GNP.Icon = _4uVkB
_GNP.Active = false
_GNP.Complete = false
_GNP.CorrectState = "None"
_igP = ""
_oNFT = 1
_LoJ = ""
_5h3 = ""
_eC954 = _kk2B("C>\001JEr")
_kv2b = _kk2B("\031\rii&")
_Nk0H = _kk2B("C\004\004 .L")
_NFebL = _kk2B("Ce3{")
__l3 = _kk2B("CSw=")
_gklvB = _kk2B("CR|\a")
_2P9.ZVariables = {
  _igP = "",
  _oNFT = 1,
  _LoJ = "",
  _5h3 = "",
  _eC954 = _kk2B("C>\001JEr"),
  _kv2b = _kk2B("\031\rii&"),
  _Nk0H = _kk2B("C\004\004 .L"),
  _NFebL = _kk2B("Ce3{"),
  __l3 = _kk2B("CSw="),
  _gklvB = _kk2B("CR|\a")
}
_Rnp = Wherigo.ZTimer(_2P9)
_Rnp.Id = "2297f50d-09f4-424d-afb4-1cbf4815c69a"
_Rnp.Name = _kk2B("y%11,GQ1,~mKi\aG,1,")
_Rnp.Description = ""
_Rnp.Visible = true
_Rnp.Duration = 4
_Rnp.Type = "Countdown"
_6TH = Wherigo.ZInput(_2P9)
_6TH.Id = "337dc319-4015-4f42-8a6c-27b5e6ad461e"
_6TH.Name = _kk2B("=%y1~t\r~\031,|~5%m>,~_,\003\r|\031,|j")
_6TH.Description = ""
_6TH.Visible = true
_6TH.Media = _Hrf
_6TH.Choices = {"Ja", "Nein"}
_6TH.InputType = "MultipleChoice"
_6TH.Text = _kk2B("=%y1~t\r~\031,|~5%m>,~_,\003\r|\031,|j")
function _2P9:OnStart()
  if _G[_kk2B("\004|Z")][_kk2B("{G%1\003K\027i")] == _kk2B("BQ|\022v") or _G[_kk2B("\004|Z")][_kk2B("t,ZQm,?t")] == _kk2B("t,yX1K\a") then
    for k, v in pairs(_G[_kk2B("Cv{d")][_kk2B("VGGJ`E ,m1y")]) do
      v[_kk2B("IQyQEG,")] = false
      v[_kk2B("Vm1QZ,")] = false
    end
    _Urwigo.MessageBox({
      Text = tostring(_kk2B("fK\r~m%||K1~\027\r|~1>Qy~m%\0271\027Q\031_,~Q|~,i\rG%1K\027~iK\031,\006")),
      Callback = function(action)
        if action ~= nil then
          _G[_kk2B("B>,\027Q_K")][_kk2B("5Kii%|\031")](_kk2B("Y%Z,5GKy,"))
        end
      end
    })
    return
  end
  if _G[_kk2B("\004|Z")][_kk2B("{G%1\003K\027i")] == _kk2B("BQ|\022v") or _G[_kk2B("\004|Z")][_kk2B("t,ZQm,?t")] == _kk2B("t,yX1K\a") then
    _hBZb1.Active = false
    _EEjKU.Visible = false
    Wherigo.Command("SaveClose")
  end
  _Urwigo.MessageBox({
    Text = _kk2B("BQGGXKii,|~Qi~R,Z,\027y,~5%m>,\006~?|~\031Q,y,i~B>,\027,Q_K~,\027>%G1,|~YQ,~\031,|~VEy1%|\031~\127\ri~e,Km%m>,N~%E,\027~|Qm>1~\031Q,~RQm>1\r|_\006O\001R7B,GmKi,~1K~1>,~\027,Z,\027y,~m%m>,\006~?|~1>Qy~F>,\027Q_K~&K\r~FQGG~E,~_QZ,|~1>,~\031Qy1%|m,~1K~1>,~_,Km%m>,~E\r1~|K1~1>,~E,%\027Q|_\006~"),
    Media = _nFWPm,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _kk2B("t%y~R,Z,\027y,D5%m>,DA,G\031~\127\195\164>G1~\031Q,~V|\127%>G~\031,\027~I,\027y\rm>,N~\031Q,~t\r~E%\rm>y1\006~t\r~X%||y1~\031Q,~V|\127%>G~Q|~t,Q|,i~$K_~Z,\027i,\027X,|\006O\001R7w>,~\027,Z,\027y,~m%m>,~EK2~FQGG~X,,\a~1\027%mX~K\003~1>,~|\riE,\027~K\003~1\027Q,y~&K\r~i%X,\006~A,,G~\003\027,,~1K~\aKy1~1>Qy~|\riE,\027~1K~&K\r\027~\003K\r|\031~Q1~GK_\006~"),
          Media = _nFWPm,
          Callback = function(action)
            if action ~= nil then
              Wherigo.PlayAudio(_LKDb)
              _Rnp:Start()
              _GNP.Active = true
              _Urwigo.MessageBox({
                Text = _kk2B("\001Q11,~F%\0271,|N~F\195\164>\027,|\031~FQ\027~Y%1,GGQ1,|~y\rm>,|~\006\006\006O\001R7{G,%y,~F%Q1~F>QG,~F,~%m\015\rQ\027,~y%1,GGQ1,y\006\006\006"),
                Media = _QLtp4
              })
            end
          end
        })
      end
    end
  })
end
function _2P9:OnRestore()
end
function _hBZb1:OnProximity()
  _eC954 = _kk2B("C>\001JEr")
  _Urwigo.MessageBox({
    Text = _kk2B("t\r~EQy1~FQ\027XGQm>~|%>~\006\006\006O\001R7fK\r~%\027,~\027,%GG&~mGKy,\006\006\006"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_6TH)
        end)
      end
    end
  })
end
function _6TH:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _LoJ = input
  if Wherigo.NoCaseEquals(_LoJ, _kk2B("\005%")) then
    _Urwigo.MessageBox({
      Text = "",
      Media = _eHW0b,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = (_kk2B("t,\027~\aG%&,\027~mKi\aG,1QK|~5K\031,~Qy1<O\001R7fK\r\027~\aG%&,\027~mKi\aG,1QK|~5K\031,~Qy<~") .. string.sub(Player.CompletionCode, 1, 15)) .. _kk2B("t,|X,~\031%\027%|N~t,Q|~Y\aQ,G,\027G,E|Qy~\r|1,\027~FFF\006F>,\027Q_K\006mKi~\127\r~\a\027K1KXKGGQ,\027,|\006~t%|X,~\003\195\188\027y~Y\aQ,G,|\018O\001R7R,i,iE,\027~1K~GK_~&K\r\027~\aG%&Q|_~,2\a,\027Q,|m,~%1~FFF\006F>,\027Q_K\006mKi\006~w>%|Xy~\003K\027~\aG%&Q|_\018"),
            Media = _dWDlR,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
    _RKgG:MoveTo(Player)
    _GNP.Complete = true
    _2P9.Complete = true
    _RKgG.Description = _kk2B("fK\r\027~{G%&,\027~5Ki\aG,1QK|~5K\031,~Qy") .. string.sub(Player.CompletionCode, 1, 15)
  else
    _Urwigo.MessageBox({
      Text = _kk2B("\004y~1\r1~iQ\027~G,Q\031N~\031%yy~t\r~Q>|~|Qm>1~_,\003\r|\031,|~>%y1\006~t\r~EQy1~ ,\031Km>~y,>\027~|%>\006~B,||~t\r~\031,\027~g,Q|\r|_~EQy1N~\031%yy~\031,\027~5%m>,~\003,>G1N~i,G\031,~tQm>~E,Qi~`F|,\027\006O\001R7?~%i~yK\027\027&~1>%1~&K\r~\031Q\031|\0301~\003Q|\031~Q1\006~fK\r~%\027,~Z,\027&~mGKy,~1>K\r_>\006~?\003~&K\r~1>Q|X~1>,~m%m>,~Qy~iQyyQ|_~\aG,%y,~mK|1%m1~1>,~5`\006"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_6TH)
          end)
        end
      end
    })
  end
end
function _Rnp:OnTick()
  _Urwigo.MessageBox({
    Text = _kk2B("`X%&N~FQ\027~>%E,|~,Q|,~_\r1,~$\195\182y\r|_~_,\003\r|\031,|\006~\195\150\003\003|,|~YQ,~\031%y~)Q1,iy~i,|\r)N~Q|~\031,i~YQ,~\031,|~R,Z,\027y,D5%m>,~\003Q|\031,|\006O\001R7`X%&N~F,~>%Z,~%\015\rQ\027,\031~%~_KK\031~\003Q2\006~`\a,|~1>,~)Q1,iy~i,|\r)~F>,\027,~&K\r~FQGG~\003Q|\031~1>,~\027,Z,\027y,~m%m>,~EK2\006~"),
    Media = _QLtp4,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _kk2B("?|~?>\027,i~?|Z,|1%\027~\003Q|\031,|~YQ,~V|F,Qy\r|_,|~\127\ri~Y\aQ,G,|~\031,y~Y\aQ,Gy\006O\001R7w>,\027,~%\027,~Q|y1\027\rm1QK|y~\003K\027~\aG%&Q|_~1>,~_%i,~Q|~&K\r\027~Q|Z,|1K\027&\006"),
          Callback = function(action)
            if action ~= nil then
              _g0asd:MoveTo(Player)
            end
          end
        })
      end
    end
  })
end
function _EEjKU:On_lQjA(target)
  _igP = (_kk2B("t\r~EQy1O\001R7fK\r~%\027,~") .. 1 * Wherigo.VectorToPoint(Player.ObjectLocation, _hBZb1.OriginalPoint):GetValue("m")) .. _kk2B("g,1,\027~ZKi~5%m>,~,|1\003,\027|1\006O\001R7i,1,\027~\003\027Ki~1>,~m%m>,\006")
  _5h3 = (_kk2B("tQ,y~F%\027~\031Q,~VE\003\027%_,O\001R7w>Qy~F%y~\015\r,\027&~|\riE,\027~") .. _oNFT) .. _kk2B("\006")
  _EEjKU.Description = _5h3
  _Urwigo.MessageBox({Text = _igP, Media = _bns})
  _oNFT = _oNFT + 1
end
function _oxL9()
  _hBZb1.Active = false
end
function _6NR()
  _EEjKU.Visible = false
end
return _2P9
