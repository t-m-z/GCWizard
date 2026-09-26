require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _IHvVl(str)
  local res = ""
  local dtable = "`:\024G\bj\f\003IOY'dAWfC&VbD X\017eJ\0159]\020E}\nLBil^7TP=\vw2!Q\"~1?rs\025\r{-(zF\027kHv\tR.3)N\022\\a;c\014u\002yt>+\026\004K\0304\018\028q[6</\0198_%o\023*\000#\031\005S$\029\001@m\016|n\021x50UhpZ\a,\006Mg"
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
_Jfx = Wherigo.ZCartridge()
_zIHG = Wherigo.ZMedia(_Jfx)
_zIHG.Id = "fb8dff60-ee8c-43ec-a45b-df9c65b4035b"
_zIHG.Name = _IHvVl("\031M%\025")
_zIHG.Description = ""
_zIHG.AltText = ""
_zIHG.Resources = {
  {
    Type = "jpg",
    Filename = "eule.jpg",
    Directives = {}
  }
}
_6ItQ = Wherigo.ZMedia(_Jfx)
_6ItQ.Id = "c35a32e6-ca29-4fe8-8277-fddc7215bb07"
_6ItQ.Name = _IHvVl("<I#")
_6ItQ.Description = ""
_6ItQ.AltText = ""
_6ItQ.Resources = {
  {
    Type = "jpg",
    Filename = "FaB.jpg",
    Directives = {}
  }
}
_FhQ = Wherigo.ZMedia(_Jfx)
_FhQ.Id = "f0915fbd-5c4f-43e0-a8d2-1c57db3db6c3"
_FhQ.Name = _IHvVl("(4c%%")
_FhQ.Description = ""
_FhQ.AltText = ""
_FhQ.Resources = {
  {
    Type = "jpg",
    Filename = "Troll.jpg",
    Directives = {}
  }
}
_lNi = Wherigo.ZMedia(_Jfx)
_lNi.Id = "d6769d1e-f578-49b8-bf2b-b22028d019b2"
_lNi.Name = _IHvVl("P4a\031rP%\025$r")
_lNi.Description = ""
_lNi.AltText = ""
_lNi.Resources = {
  {
    Type = "jpg",
    Filename = "tr_entlein.jpg",
    Directives = {}
  }
}
_QZfY4 = Wherigo.ZMedia(_Jfx)
_QZfY4.Id = "02e2bea1-a8a5-4f30-a88d-f35b64dc5203"
_QZfY4.Name = _IHvVl("<c%P\0254>\025%%\0254")
_QZfY4.Description = ""
_QZfY4.AltText = ""
_QZfY4.Resources = {
  {
    Type = "jpg",
    Filename = "Foterkeller_1.jpg",
    Directives = {}
  }
}
_OBX_ = Wherigo.ZMedia(_Jfx)
_OBX_.Id = "d04239a7-a4d5-4c4c-9c1d-f7d0d348a389"
_OBX_.Name = _IHvVl("\004c%\r>%Moy\025r")
_OBX_.Description = ""
_OBX_.AltText = ""
_OBX_.Resources = {
  {
    Type = "jpg",
    Filename = "Goldklumpen.jpg",
    Directives = {}
  }
}
_mNiN = Wherigo.ZMedia(_Jfx)
_mNiN.Id = "e485bc45-8b71-4e67-b4f3-2749eb440684"
_mNiN.Name = _IHvVl("~$4IKM%$t")
_mNiN.Description = ""
_mNiN.AltText = ""
_mNiN.Resources = {
  {
    Type = "jpg",
    Filename = "Miraculix.jpg",
    Directives = {}
  }
}
_08NEq = Wherigo.ZMedia(_Jfx)
_08NEq.Id = "4e63d07f-698d-4c31-ac30-9db95fd5594d"
_08NEq.Name = _IHvVl(")IyI")
_08NEq.Description = ""
_08NEq.AltText = ""
_08NEq.Resources = {
  {
    Type = "jpg",
    Filename = "Papa_schlumpf_1.jpg",
    Directives = {}
  }
}
_Va5Vc = Wherigo.ZMedia(_Jfx)
_Va5Vc.Id = "dbd207c5-7fae-4b6a-882c-b2cd50bc0203"
_Va5Vc.Name = _IHvVl("jKx%IM\020$")
_Va5Vc.Description = ""
_Va5Vc.AltText = ""
_Va5Vc.Resources = {
  {
    Type = "jpg",
    Filename = "24schlaubi.jpg",
    Directives = {}
  }
}
_PJaK = Wherigo.ZMedia(_Jfx)
_PJaK.Id = "ece94015-9ffd-4b77-a0f7-2d94a2822053"
_PJaK.Name = _IHvVl("?\025<($")
_PJaK.Description = ""
_PJaK.AltText = ""
_PJaK.Resources = {
  {
    Type = "jpg",
    Filename = "Hefti.jpg",
    Directives = {}
  }
}
_wRfx = Wherigo.ZMedia(_Jfx)
_wRfx.Id = "b0a96705-a762-438b-8438-235c0f862c77"
_wRfx.Name = _IHvVl("?M\025PP\025a)j")
_wRfx.Description = ""
_wRfx.AltText = ""
_wRfx.Resources = {
  {
    Type = "jpg",
    Filename = "Schlumpfdorf_1.jpg",
    Directives = {}
  }
}
_Pg3e = Wherigo.ZMedia(_Jfx)
_Pg3e.Id = "ec556764-e764-47cd-8c96-3cca42462beb"
_Pg3e.Name = _IHvVl("~$\rI5")
_Pg3e.Description = ""
_Pg3e.AltText = ""
_Pg3e.Resources = {
  {
    Type = "jpg",
    Filename = "Midas.jpg",
    Directives = {}
  }
}
_IRE = Wherigo.ZMedia(_Jfx)
_IRE.Id = "39e91654-71df-4bd1-bbd0-1a09003eb567"
_IRE.Name = _IHvVl("\031rP\025rP\025$Kx")
_IRE.Description = ""
_IRE.AltText = ""
_IRE.Resources = {
  {
    Type = "jpg",
    Filename = "Ententeich_1.jpg",
    Directives = {}
  }
}
_wFXn = Wherigo.ZMedia(_Jfx)
_wFXn.Id = "649dfaf2-cb16-4167-8196-8613bde34e5a"
_wFXn.Name = _IHvVl("<$5Kx")
_wFXn.Description = ""
_wFXn.AltText = ""
_wFXn.Resources = {
  {
    Type = "jpg",
    Filename = "Fisch-Beisser.jpg",
    Directives = {}
  }
}
_aOD = Wherigo.ZMedia(_Jfx)
_aOD.Id = "beb01a0a-60bb-4f0d-ad71-e6bf4f2e5bfa"
_aOD.Name = _IHvVl("\0164a\031rP%\025$r")
_aOD.Description = ""
_aOD.AltText = ""
_aOD.Resources = {
  {
    Type = "jpg",
    Filename = "Ente.jpg",
    Directives = {}
  }
}
_de5ix = Wherigo.ZMedia(_Jfx)
_de5ix.Id = "6e038cc8-9174-40b4-b265-0e753d178cf8"
_de5ix.Name = _IHvVl("\127I%a\021c4\016")
_de5ix.Description = ""
_de5ix.AltText = ""
_de5ix.Resources = {
  {
    Type = "jpg",
    Filename = "gallierdorf.jpg",
    Directives = {}
  }
}
_Wo0 = Wherigo.ZMedia(_Jfx)
_Wo0.Id = "3a52b593-77ed-4786-beab-cd25c26ea458"
_Wo0.Name = _IHvVl(",$\0255\025")
_Wo0.Description = ""
_Wo0.AltText = ""
_Wo0.Resources = {
  {
    Type = "jpg",
    Filename = "wiese.jpg",
    Directives = {}
  }
}
_WqC = Wherigo.ZMedia(_Jfx)
_WqC.Id = "1e308e56-c251-4759-83ec-2b864d865ccf"
_WqC.Name = _IHvVl("<%M55M\016\0254")
_WqC.Description = ""
_WqC.AltText = ""
_WqC.Resources = {
  {
    Type = "jpg",
    Filename = "Flussufer_1.jpg",
    Directives = {}
  }
}
_FxrG = Wherigo.ZMedia(_Jfx)
_FxrG.Id = "a3904c98-8142-40cc-bfac-3a840d20adef"
_FxrG.Name = _IHvVl("zIM\020\0254P4Ir>")
_FxrG.Description = ""
_FxrG.AltText = ""
_FxrG.Resources = {
  {
    Type = "jpg",
    Filename = "Zaubertrank.jpg",
    Directives = {}
  }
}
_mOnu = Wherigo.ZMedia(_Jfx)
_mOnu.Id = "2e063db4-4a8c-4f90-b3f1-7c4c25eb0b89"
_mOnu.Name = _IHvVl("<I\020a\127\025\016")
_mOnu.Description = ""
_mOnu.AltText = ""
_mOnu.Resources = {
  {
    Type = "jpg",
    Filename = "Folterknecht_gefesselt.jpg",
    Directives = {}
  }
}
_pQ53 = Wherigo.ZMedia(_Jfx)
_pQ53.Id = "8fc38213-c62f-4c75-850f-31409eb5c471"
_pQ53.Name = _IHvVl("~$5P\025%\020IMo")
_pQ53.Description = ""
_pQ53.AltText = ""
_pQ53.Resources = {
  {
    Type = "jpg",
    Filename = "mistelbaum.jpg",
    Directives = {}
  }
}
_XKW5 = Wherigo.ZMedia(_Jfx)
_XKW5.Id = "c457a4ea-7d72-44f5-b45e-1ac8be13b3a9"
_XKW5.Name = _IHvVl("#4M\025K>\025")
_XKW5.Description = ""
_XKW5.AltText = ""
_XKW5.Resources = {
  {
    Type = "jpg",
    Filename = "Bruecke.jpg",
    Directives = {}
  }
}
_btRHU = Wherigo.ZMedia(_Jfx)
_btRHU.Id = "5fd12a6e-7f70-4b6a-b918-d320f5487f31"
_btRHU.Name = _IHvVl("jKx%Moy\016\025r\rc4\016")
_btRHU.Description = ""
_btRHU.AltText = ""
_btRHU.Resources = {
  {
    Type = "jpg",
    Filename = "Schlumpfhausen.jpg",
    Directives = {}
  }
}
_t5JO = Wherigo.ZMedia(_Jfx)
_t5JO.Id = "0f479aa6-1e14-46a2-a369-850d330f6c39"
_t5JO.Name = _IHvVl("~$\rI5P\025oy\025%")
_t5JO.Description = ""
_t5JO.AltText = ""
_t5JO.Resources = {
  {
    Type = "jpg",
    Filename = "Midastempel.jpg",
    Directives = {}
  }
}
_o69s2 = Wherigo.ZMedia(_Jfx)
_o69s2.Id = "16022784-d836-454b-adc4-bc227a7d0100"
_o69s2.Name = _IHvVl("OP4cxj")
_o69s2.Description = ""
_o69s2.AltText = ""
_o69s2.Resources = {
  {
    Type = "jpg",
    Filename = "engel28.jpg",
    Directives = {}
  }
}
_Ecqq2 = Wherigo.ZMedia(_Jfx)
_Ecqq2.Id = "6befd255-a126-41c2-88b1-40e99bc42612"
_Ecqq2.Name = _IHvVl("\031$Kx\025")
_Ecqq2.Description = ""
_Ecqq2.AltText = ""
_Ecqq2.Resources = {
  {
    Type = "jpg",
    Filename = "Eiche.jpg",
    Directives = {}
  }
}
_E5Sv5 = Wherigo.ZMedia(_Jfx)
_E5Sv5.Id = "44c5ea10-df8f-49cf-9e07-fad041f9ffd1"
_E5Sv5.Name = _IHvVl("jKx%Moy\016$rKx\025r")
_E5Sv5.Description = ""
_E5Sv5.AltText = ""
_E5Sv5.Resources = {
  {
    Type = "png",
    Filename = "schlumpfinejpg.png",
    Directives = {}
  }
}
_lD_xP = Wherigo.ZMedia(_Jfx)
_lD_xP.Id = "e8a6da79-5e9b-480f-b97a-8aa04829a36b"
_lD_xP.Name = _IHvVl("\n\020\025%$t")
_lD_xP.Description = ""
_lD_xP.AltText = ""
_lD_xP.Resources = {
  {
    Type = "jpg",
    Filename = "Obelix.jpg",
    Directives = {}
  }
}
_lRVX = Wherigo.ZMedia(_Jfx)
_lRVX.Id = "49450a64-8e81-4ba8-8341-b8ba6cad185c"
_lRVX.Name = _IHvVl("jy$\025%\0254")
_lRVX.Description = ""
_lRVX.AltText = ""
_lRVX.Resources = {
  {
    Type = "jpg",
    Filename = "Denkblase180.jpg",
    Directives = {}
  }
}
_5UORS = Wherigo.ZMedia(_Jfx)
_5UORS.Id = "909c9be9-0650-48a1-af56-57612ebfd3e0"
_5UORS.Name = _IHvVl("\015x\0254$\127c")
_5UORS.Description = ""
_5UORS.AltText = ""
_5UORS.Resources = {
  {
    Type = "jpg",
    Filename = "wherigo.jpg",
    Directives = {}
  }
}
_W8K = Wherigo.ZMedia(_Jfx)
_W8K.Id = "e4ad5b92-508b-449a-854c-88788a83b4d8"
_W8K.Name = _IHvVl("jP4\025K>\020Ir>")
_W8K.Description = ""
_W8K.AltText = ""
_W8K.Resources = {
  {
    Type = "jpg",
    Filename = "Streckbank.jpg",
    Directives = {}
  }
}
_2fUN = Wherigo.ZMedia(_Jfx)
_2fUN.Id = "bbaa08cf-027f-44aa-b6b7-290f31bceb70"
_2fUN.Name = _IHvVl("?Ir\r5Kx\025%%\025")
_2fUN.Description = ""
_2fUN.AltText = ""
_2fUN.Resources = {
  {
    Type = "jpg",
    Filename = "handschelle.jpg",
    Directives = {}
  }
}
_kJnO = Wherigo.ZMedia(_Jfx)
_kJnO.Id = "8b93506d-3c45-495a-bf1a-285d0afc221c"
_kJnO.Name = _IHvVl("jKxIP;")
_kJnO.Description = ""
_kJnO.AltText = ""
_kJnO.Resources = {
  {
    Type = "jpg",
    Filename = "Schatztruhe.jpg",
    Directives = {}
  }
}
_sza = Wherigo.ZMedia(_Jfx)
_sza.Id = "72cf80d8-4a61-43cf-be2d-8ccde51ea78b"
_sza.Name = _IHvVl("jcMr\r\022?$r,\025$5")
_sza.Description = ""
_sza.AltText = ""
_sza.Resources = {
  {
    Type = "fdl",
    Filename = "s1_1.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "hinweis.mp3",
    Directives = {}
  }
}
_Jfx.Id = "4feae4b4-a7f1-46ed-80ab-38788b07a750"
_Jfx.Name = "ytrohS und der Folterknecht aus Bayern"
_Jfx.Description = "Dieser Wherigo haelt einige Field-Puzzle (Mathematik, Physik, Chemie) fuer euch bereit. Um hier erfolgreich zu sein, benoetigt ihr zumindest Tafelwerk und Taschenrechner, sowie einen Blindenuebersetzer. "
_Jfx.Visible = true
_Jfx.Activity = "TourGuide"
_Jfx.StartingLocationDescription = "Rosenthal"
_Jfx.StartingLocation = ZonePoint(51.350817, 12.364517, 0)
_Jfx.Version = "1.9"
_Jfx.Company = ""
_Jfx.Author = "Flo.33"
_Jfx.BuilderVersion = "URWIGO 1.22.5798.37755"
_Jfx.CreateDate = "07/05/2012 18:23:09"
_Jfx.PublishDate = "1/1/0001 12:00:00 AM"
_Jfx.UpdateDate = "03/23/2016 10:00:17"
_Jfx.LastPlayedDate = "1/1/0001 12:00:00 AM"
_Jfx.TargetDevice = "PocketPC"
_Jfx.TargetDeviceVersion = "0"
_Jfx.StateId = "1"
_Jfx.CountryId = "2"
_Jfx.Complete = false
_Jfx.UseLogging = true
_Jfx.Media = _5UORS
_kT2p = Wherigo.Zone(_Jfx)
_kT2p.Id = "8d704a97-e2aa-4e4e-964f-b03d02447eca"
_kT2p.Name = _IHvVl("\014%P\025\022\031$Kx\025")
_kT2p.Description = ""
_kT2p.Visible = true
_kT2p.Commands = {
  _gklS = Wherigo.ZCommand({
    Text = _IHvVl("Ucc4\r$rIP\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_kT2p.Commands._gklS.Custom = true
_kT2p.Commands._gklS.Id = "46805cde-1212-4ed5-86d5-5aec67d1d441"
_kT2p.Commands._gklS.WorksWithAll = true
_kT2p.DistanceRange = Distance(-1, "feet")
_kT2p.ShowObjects = "OnEnter"
_kT2p.ProximityRange = Distance(60, "meters")
_kT2p.AllowSetPositionTo = false
_kT2p.Active = false
_kT2p.Points = {
  ZonePoint(51.353780590056, 12.3612970300019, 0),
  ZonePoint(51.3539614968159, 12.3615116067231, 0),
  ZonePoint(51.3537671895268, 12.3618334718049, 0),
  ZonePoint(51.3535929822911, 12.3618442006409, 0),
  ZonePoint(51.3535929822911, 12.3614794202149, 0)
}
_kT2p.OriginalPoint = ZonePoint(51.3537390481962, 12.3615931458771, 0)
_kT2p.DistanceRangeUOM = "Feet"
_kT2p.ProximityRangeUOM = "Meters"
_kT2p.OutOfRangeName = ""
_kT2p.InRangeName = ""
_xGn = Wherigo.Zone(_Jfx)
_xGn.Id = "44904227-0a35-4da7-a807-befca86207f5"
_xGn.Name = _IHvVl("<c%P\0254>\025%%\0254")
_xGn.Description = ""
_xGn.Visible = true
_xGn.Commands = {}
_xGn.DistanceRange = Distance(-1, "feet")
_xGn.ShowObjects = "OnEnter"
_xGn.ProximityRange = Distance(60, "meters")
_xGn.AllowSetPositionTo = false
_xGn.Active = false
_xGn.Points = {
  ZonePoint(51.3556800754078, 12.3615929111838, 0),
  ZonePoint(51.3555879505104, 12.3618584498763, 0),
  ZonePoint(51.3553802500622, 12.3617162927985, 0),
  ZonePoint(51.3555025254401, 12.3613488301635, 0)
}
_xGn.OriginalPoint = ZonePoint(51.3555377003551, 12.3616291210055, 0)
_xGn.DistanceRangeUOM = "Feet"
_xGn.ProximityRangeUOM = "Meters"
_xGn.OutOfRangeName = ""
_xGn.InRangeName = ""
_W38 = Wherigo.Zone(_Jfx)
_W38.Id = "71e7b757-7f4d-4754-8640-8c1925e9d37c"
_W38.Name = _IHvVl("~$5P\025%\020IMo")
_W38.Description = ""
_W38.Visible = true
_W38.Commands = {}
_W38.DistanceRange = Distance(-1, "feet")
_W38.ShowObjects = "OnEnter"
_W38.ProximityRange = Distance(60, "meters")
_W38.AllowSetPositionTo = false
_W38.Active = false
_W38.Points = {
  ZonePoint(51.3544330235786, 12.3602404072881, 0),
  ZonePoint(51.3541315150183, 12.3604335263371, 0),
  ZonePoint(51.3542856196415, 12.3608090355992, 0),
  ZonePoint(51.3545201256821, 12.3606266453862, 0)
}
_W38.OriginalPoint = ZonePoint(51.3543425709801, 12.3605274036526, 0)
_W38.DistanceRangeUOM = "Feet"
_W38.ProximityRangeUOM = "Meters"
_W38.OutOfRangeName = ""
_W38.InRangeName = ""
_uzvy = Wherigo.Zone(_Jfx)
_uzvy.Id = "cfcdf692-7397-4177-8943-a7ed1e890394"
_uzvy.Name = _IHvVl("#4M\025K>\025")
_uzvy.Description = ""
_uzvy.Visible = true
_uzvy.Commands = {}
_uzvy.DistanceRange = Distance(-1, "feet")
_uzvy.ShowObjects = "OnEnter"
_uzvy.ProximityRange = Distance(60, "meters")
_uzvy.AllowSetPositionTo = false
_uzvy.Active = false
_uzvy.Points = {
  ZonePoint(51.35498662163, 12.3632619157434, 0),
  ZonePoint(51.3549145956358, 12.3635998740792, 0),
  ZonePoint(51.354695166909, 12.3635167255998, 0),
  ZonePoint(51.3547554680379, 12.3630392923951, 0)
}
_uzvy.OriginalPoint = ZonePoint(51.3548379630532, 12.3633544519544, 0)
_uzvy.DistanceRangeUOM = "Feet"
_uzvy.ProximityRangeUOM = "Meters"
_uzvy.OutOfRangeName = ""
_uzvy.InRangeName = ""
_Viv = Wherigo.Zone(_Jfx)
_Viv.Id = "a52c0829-ec9e-4fd6-b7ef-418fdbe111c7"
_Viv.Name = _IHvVl("\031rP\025rP\025$Kx")
_Viv.Description = ""
_Viv.Visible = false
_Viv.Commands = {}
_Viv.DistanceRange = Distance(-1, "feet")
_Viv.ShowObjects = "OnEnter"
_Viv.ProximityRange = Distance(60, "meters")
_Viv.AllowSetPositionTo = false
_Viv.Active = false
_Viv.Points = {
  ZonePoint(51.3510870049125, 12.3645768687129, 0),
  ZonePoint(51.3509998962819, 12.3644588515162, 0),
  ZonePoint(51.3509194881682, 12.3645232245326, 0),
  ZonePoint(51.3508826344023, 12.3646895214915, 0),
  ZonePoint(51.3509998962819, 12.3647914454341, 0)
}
_Viv.OriginalPoint = ZonePoint(51.3509777840094, 12.3646079823375, 0)
_Viv.DistanceRangeUOM = "Feet"
_Viv.ProximityRangeUOM = "Meters"
_Viv.OutOfRangeName = ""
_Viv.InRangeName = ""
_DhVS = Wherigo.Zone(_Jfx)
_DhVS.Id = "e702ff19-bab2-4ba5-992b-53da4846c6ab"
_DhVS.Name = _IHvVl("jKx%Moy\016xIM5\025r")
_DhVS.Description = ""
_DhVS.Visible = false
_DhVS.Commands = {}
_DhVS.DistanceRange = Distance(-1, "feet")
_DhVS.ShowObjects = "OnEnter"
_DhVS.ProximityRange = Distance(60, "meters")
_DhVS.AllowSetPositionTo = false
_DhVS.Active = false
_DhVS.Points = {
  ZonePoint(51.3521674731983, 12.3619087412953, 0),
  ZonePoint(51.3520083360585, 12.3619087412953, 0),
  ZonePoint(51.3519899096172, 12.3621206358075, 0),
  ZonePoint(51.3521440214439, 12.3621528223157, 0)
}
_DhVS.OriginalPoint = ZonePoint(51.3520774350795, 12.3620227351785, 0)
_DhVS.DistanceRangeUOM = "Feet"
_DhVS.ProximityRangeUOM = "Meters"
_DhVS.OutOfRangeName = ""
_DhVS.InRangeName = ""
_UqH_ = Wherigo.Zone(_Jfx)
_UqH_.Id = "b61f3d15-ad03-4f0f-b029-cf4f2355a492"
_UqH_.Name = _IHvVl("?M\025PP\025\022@cr\022)IyI\022jKx%Moy\016")
_UqH_.Description = ""
_UqH_.Visible = false
_UqH_.Commands = {}
_UqH_.DistanceRange = Distance(-1, "feet")
_UqH_.ShowObjects = "OnEnter"
_UqH_.ProximityRange = Distance(60, "meters")
_UqH_.AllowSetPositionTo = false
_UqH_.Active = false
_UqH_.Points = {
  ZonePoint(51.3521842244443, 12.3624170199037, 0),
  ZonePoint(51.3520853920061, 12.3623660579324, 0),
  ZonePoint(51.3521071686634, 12.3626691475511, 0),
  ZonePoint(51.3522395035117, 12.3626208677888, 0)
}
_UqH_.OriginalPoint = ZonePoint(51.3521540721564, 12.362518273294, 0)
_UqH_.DistanceRangeUOM = "Feet"
_UqH_.ProximityRangeUOM = "Meters"
_UqH_.OutOfRangeName = ""
_UqH_.InRangeName = ""
_GGD = Wherigo.Zone(_Jfx)
_GGD.Id = "7e77b368-0e9a-4674-8f4a-cc161e44da8a"
_GGD.Name = _IHvVl("\1274c55\025\022\015$\0255\025")
_GGD.Description = ""
_GGD.Visible = false
_GGD.Commands = {}
_GGD.DistanceRange = Distance(-1, "feet")
_GGD.ShowObjects = "OnEnter"
_GGD.ProximityRange = Distance(60, "meters")
_GGD.AllowSetPositionTo = false
_GGD.Active = false
_GGD.Points = {
  ZonePoint(51.3527830774555, 12.3591755703092, 0),
  ZonePoint(51.352870182696, 12.3597549274564, 0),
  ZonePoint(51.3527294741483, 12.3602055385709, 0),
  ZonePoint(51.3525217607406, 12.360409386456, 0),
  ZonePoint(51.3522537420487, 12.3603342846036, 0),
  ZonePoint(51.3520125238856, 12.3601089790463, 0),
  ZonePoint(51.3518852137875, 12.3595939949155, 0),
  ZonePoint(51.3518986148671, 12.359143383801, 0),
  ZonePoint(51.352099630591, 12.3589180782437, 0),
  ZonePoint(51.3524212539149, 12.3588644340634, 0),
  ZonePoint(51.3526691703528, 12.3588322475553, 0)
}
_GGD.OriginalPoint = ZonePoint(51.3523767858625, 12.3595764386383, 0)
_GGD.DistanceRangeUOM = "Feet"
_GGD.ProximityRangeUOM = "Meters"
_GGD.OutOfRangeName = ""
_GGD.InRangeName = ""
_PyRp = Wherigo.Zone(_Jfx)
_PyRp.Id = "3eb654d0-cf9b-474a-9a60-f56187cd3f11"
_PyRp.Name = _IHvVl("(\025oy\025%\022\r\0255\022~$\rI5")
_PyRp.Description = ""
_PyRp.Visible = false
_PyRp.Commands = {}
_PyRp.DistanceRange = Distance(-1, "feet")
_PyRp.ShowObjects = "OnEnter"
_PyRp.ProximityRange = Distance(60, "meters")
_PyRp.AllowSetPositionTo = false
_PyRp.Active = false
_PyRp.Points = {
  ZonePoint(51.352702672471, 12.3610504344106, 0),
  ZonePoint(51.3524849082632, 12.3611094430089, 0),
  ZonePoint(51.3524782078096, 12.3613562062383, 0),
  ZonePoint(51.3527093728918, 12.3612971976399, 0)
}
_PyRp.OriginalPoint = ZonePoint(51.3525937903589, 12.3612033203244, 0)
_PyRp.DistanceRangeUOM = "Feet"
_PyRp.ProximityRangeUOM = "Meters"
_PyRp.OutOfRangeName = ""
_PyRp.InRangeName = ""
_9GC = Wherigo.Zone(_Jfx)
_9GC.Id = "98f84959-dc61-4980-b4d5-5627e8c8dc60"
_9GC.Name = _IHvVl("<%M55M\016\0254")
_9GC.Description = ""
_9GC.Visible = false
_9GC.Commands = {}
_9GC.DistanceRange = Distance(-1, "feet")
_9GC.ShowObjects = "OnEnter"
_9GC.ProximityRange = Distance(60, "meters")
_9GC.AllowSetPositionTo = false
_9GC.Active = false
_9GC.Points = {
  ZonePoint(51.3553810875672, 12.3622949793935, 0),
  ZonePoint(51.3551968363848, 12.3627992346883, 0),
  ZonePoint(51.3549690338983, 12.3626007512212, 0),
  ZonePoint(51.3551465859337, 12.3621286824346, 0)
}
_9GC.OriginalPoint = ZonePoint(51.355173385946, 12.3624559119344, 0)
_9GC.DistanceRangeUOM = "Feet"
_9GC.ProximityRangeUOM = "Meters"
_9GC.OutOfRangeName = ""
_9GC.InRangeName = ""
_g5eMc = Wherigo.Zone(_Jfx)
_g5eMc.Id = "7678fd4c-bde7-4714-9630-0d835c7a151e"
_g5eMc.Name = _IHvVl("\127I%%$5Kx\0255\022\021c4\016")
_g5eMc.Description = ""
_g5eMc.Visible = false
_g5eMc.Commands = {}
_g5eMc.DistanceRange = Distance(-1, "feet")
_g5eMc.ShowObjects = "OnEnter"
_g5eMc.ProximityRange = Distance(60, "meters")
_g5eMc.AllowSetPositionTo = false
_g5eMc.Active = false
_g5eMc.Points = {
  ZonePoint(51.3546105776926, 12.3593499138951, 0),
  ZonePoint(51.354768030764, 12.3598488047719, 0),
  ZonePoint(51.354486624894, 12.359864898026, 0),
  ZonePoint(51.3543291708554, 12.3595537617803, 0)
}
_g5eMc.OriginalPoint = ZonePoint(51.3545486010515, 12.3596543446183, 0)
_g5eMc.DistanceRangeUOM = "Feet"
_g5eMc.ProximityRangeUOM = "Meters"
_g5eMc.OutOfRangeName = ""
_g5eMc.InRangeName = ""
_DfhfE = Wherigo.Zone(_Jfx)
_DfhfE.Id = "6f07c251-a36a-4cac-aed3-e9c4ce0f0bbb"
_DfhfE.Name = _IHvVl("zM\127Ir\127\022;Mo\022\021c4\016")
_DfhfE.Description = ""
_DfhfE.Visible = false
_DfhfE.Commands = {}
_DfhfE.DistanceRange = Distance(-1, "feet")
_DfhfE.ShowObjects = "OnEnter"
_DfhfE.ProximityRange = Distance(60, "meters")
_DfhfE.AllowSetPositionTo = false
_DfhfE.Active = false
_DfhfE.Points = {
  ZonePoint(51.355300213463, 12.358783967793, 0),
  ZonePoint(51.3554208140486, 12.3591058328748, 0),
  ZonePoint(51.3552064127881, 12.3592989519238, 0),
  ZonePoint(51.3550858116381, 12.3589449003339, 0)
}
_DfhfE.OriginalPoint = ZonePoint(51.3552533129845, 12.3590334132314, 0)
_DfhfE.DistanceRangeUOM = "Feet"
_DfhfE.ProximityRangeUOM = "Meters"
_DfhfE.OutOfRangeName = ""
_DfhfE.InRangeName = ""
_e8v5X = Wherigo.Zone(_Jfx)
_e8v5X.Id = "026ef2bf-cecb-4f52-847b-c67667a187b3"
_e8v5X.Name = _IHvVl("#%MP,M4;")
_e8v5X.Description = ""
_e8v5X.Visible = false
_e8v5X.Commands = {}
_e8v5X.DistanceRange = Distance(-1, "feet")
_e8v5X.ShowObjects = "OnEnter"
_e8v5X.ProximityRange = Distance(60, "meters")
_e8v5X.AllowSetPositionTo = false
_e8v5X.Active = false
_e8v5X.Points = {
  ZonePoint(51.3525468874123, 12.359320409596, 0),
  ZonePoint(51.3523726755365, 12.3592989519238, 0),
  ZonePoint(51.3523726755365, 12.3595349863172, 0),
  ZonePoint(51.3525736891805, 12.3594384267926, 0)
}
_e8v5X.OriginalPoint = ZonePoint(51.3524664819165, 12.3593981936574, 0)
_e8v5X.DistanceRangeUOM = "Feet"
_e8v5X.ProximityRangeUOM = "Meters"
_e8v5X.OutOfRangeName = ""
_e8v5X.InRangeName = ""
_GWSA4 = Wherigo.Zone(_Jfx)
_GWSA4.Id = "577aed7b-6073-4366-8437-07db11661fb6"
_GWSA4.Name = _IHvVl("<$r\127\0254>4IMP")
_GWSA4.Description = ""
_GWSA4.Visible = false
_GWSA4.Commands = {}
_GWSA4.DistanceRange = Distance(-1, "feet")
_GWSA4.ShowObjects = "OnEnter"
_GWSA4.ProximityRange = Distance(60, "meters")
_GWSA4.AllowSetPositionTo = false
_GWSA4.Active = false
_GWSA4.Points = {
  ZonePoint(51.3521540721978, 12.3590723052621, 0),
  ZonePoint(51.3522093513016, 12.3592037335038, 0),
  ZonePoint(51.3521473716959, 12.3592707887292, 0),
  ZonePoint(51.3520150365814, 12.3591447249055, 0)
}
_GWSA4.OriginalPoint = ZonePoint(51.3521314579442, 12.3591728881001, 0)
_GWSA4.DistanceRangeUOM = "Feet"
_GWSA4.ProximityRangeUOM = "Meters"
_GWSA4.OutOfRangeName = ""
_GWSA4.InRangeName = ""
_dRaJG = Wherigo.Zone(_Jfx)
_dRaJG.Id = "7d555b2b-76df-4dce-b9e9-6bb4d409f4d8"
_dRaJG.Name = _IHvVl("jMoy\0169#%MPIM\127\025")
_dRaJG.Description = ""
_dRaJG.Visible = false
_dRaJG.Commands = {}
_dRaJG.DistanceRange = Distance(-1, "feet")
_dRaJG.ShowObjects = "OnEnter"
_dRaJG.ProximityRange = Distance(60, "meters")
_dRaJG.AllowSetPositionTo = false
_dRaJG.Active = false
_dRaJG.Points = {
  ZonePoint(51.3523425234141, 12.3589261248708, 0),
  ZonePoint(51.3523190717494, 12.3595323041081, 0),
  ZonePoint(51.3521448590074, 12.3596127703786, 0),
  ZonePoint(51.3521549097604, 12.359870262444, 0),
  ZonePoint(51.3520041482321, 12.359870262444, 0),
  ZonePoint(51.3519974477082, 12.3593069985509, 0),
  ZonePoint(51.3522252649706, 12.3593123629689, 0),
  ZonePoint(51.3522487166833, 12.3589422181249, 0)
}
_dRaJG.OriginalPoint = ZonePoint(51.3521796176907, 12.3594216629863, 0)
_dRaJG.DistanceRangeUOM = "Feet"
_dRaJG.ProximityRangeUOM = "Meters"
_dRaJG.OutOfRangeName = ""
_dRaJG.InRangeName = ""
_ygb = Wherigo.Zone(_Jfx)
_ygb.Id = "a7001b9a-f4f9-441b-aec4-70dd2573c6cb"
_ygb.Name = _IHvVl("U%\025PP\025r9\"I\020>4IMP")
_ygb.Description = ""
_ygb.Visible = false
_ygb.Commands = {}
_ygb.DistanceRange = Distance(-1, "feet")
_ygb.ShowObjects = "OnEnter"
_ygb.ProximityRange = Distance(60, "meters")
_ygb.AllowSetPositionTo = false
_ygb.Active = false
_ygb.Points = {
  ZonePoint(51.3527311492527, 12.3593552783132, 0),
  ZonePoint(51.3528182545919, 12.3598434403539, 0),
  ZonePoint(51.3527177484166, 12.3601492121816, 0),
  ZonePoint(51.3525971407152, 12.359317727387, 0)
}
_ygb.OriginalPoint = ZonePoint(51.3527160732441, 12.3596664145589, 0)
_ygb.DistanceRangeUOM = "Feet"
_ygb.ProximityRangeUOM = "Meters"
_ygb.OutOfRangeName = ""
_ygb.InRangeName = ""
_PYAh = Wherigo.Zone(_Jfx)
_PYAh.Id = "b9fa893e-a18f-456e-bebc-0c948e4625fd"
_PYAh.Name = _IHvVl("\015I%\ro\025$5P\0254")
_PYAh.Description = ""
_PYAh.Visible = false
_PYAh.Commands = {}
_PYAh.DistanceRange = Distance(-1, "feet")
_PYAh.ShowObjects = "OnEnter"
_PYAh.ProximityRange = Distance(60, "meters")
_PYAh.AllowSetPositionTo = false
_PYAh.Active = false
_PYAh.Points = {
  ZonePoint(51.3526155669123, 12.3602055385709, 0),
  ZonePoint(51.352535161634, 12.3596261814237, 0),
  ZonePoint(51.3521867371308, 12.359679825604, 0),
  ZonePoint(51.3523810511229, 12.360226996243, 0)
}
_PYAh.OriginalPoint = ZonePoint(51.3524296292, 12.3599346354604, 0)
_PYAh.DistanceRangeUOM = "Feet"
_PYAh.ProximityRangeUOM = "Meters"
_PYAh.OutOfRangeName = ""
_PYAh.InRangeName = ""
_VGe = Wherigo.Zone(_Jfx)
_VGe.Id = "61bb7c14-a5d6-4b65-8a67-66172022acd5"
_VGe.Name = _IHvVl("\021\0254\022jKxIP;")
_VGe.Description = ""
_VGe.Visible = false
_VGe.Commands = {}
_VGe.DistanceRange = Distance(-1, "feet")
_VGe.ShowObjects = "OnEnter"
_VGe.ProximityRange = Distance(60, "meters")
_VGe.AllowSetPositionTo = false
_VGe.Active = false
_VGe.Points = {
  ZonePoint(51.3529346739693, 12.3568138852715, 0),
  ZonePoint(51.3527135606544, 12.3573503270745, 0),
  ZonePoint(51.35299665251, 12.3577097430825, 0),
  ZonePoint(51.3531591363943, 12.3571196570992, 0)
}
_VGe.OriginalPoint = ZonePoint(51.352951005882, 12.3572484031319, 0)
_VGe.DistanceRangeUOM = "Feet"
_VGe.ProximityRangeUOM = "Meters"
_VGe.OutOfRangeName = ""
_VGe.InRangeName = ""
_A_OK = Wherigo.Zone(_Jfx)
_A_OK.Id = "78259a05-11dd-4157-a3d0-6812fe2fd5b4"
_A_OK.Name = _IHvVl("\014%P\025\022\031$Kx\025")
_A_OK.Description = ""
_A_OK.Visible = true
_A_OK.Commands = {}
_A_OK.DistanceRange = Distance(-1, "feet")
_A_OK.ShowObjects = "OnEnter"
_A_OK.ProximityRange = Distance(60, "meters")
_A_OK.AllowSetPositionTo = false
_A_OK.Active = false
_A_OK.Points = {
  ZonePoint(51.3547468076155, 12.3625105619431, 0),
  ZonePoint(51.3548422842586, 12.3622959852219, 0),
  ZonePoint(51.3549444607966, 12.3624488711357, 0),
  ZonePoint(51.3548942100687, 12.3626098036766, 0),
  ZonePoint(51.3548406092315, 12.362674176693, 0)
}
_A_OK.OriginalPoint = ZonePoint(51.3548536743942, 12.3625078797341, 0)
_A_OK.DistanceRangeUOM = "Feet"
_A_OK.ProximityRangeUOM = "Meters"
_A_OK.OutOfRangeName = ""
_A_OK.InRangeName = ""
_vwn_ = Wherigo.Zone(_Jfx)
_vwn_.Id = "de954463-7faf-4810-ab91-9d4dec97d389"
_vwn_.Name = _IHvVl("jy\02544;cr\025")
_vwn_.Description = ""
_vwn_.Visible = false
_vwn_.Commands = {}
_vwn_.DistanceRange = Distance(-1, "feet")
_vwn_.ShowObjects = "OnEnter"
_vwn_.ProximityRange = Distance(60, "meters")
_vwn_.AllowSetPositionTo = false
_vwn_.Active = false
_vwn_.Points = {
  ZonePoint(51.3546345804297, 12.3625320196152, 0),
  ZonePoint(51.3547283822755, 12.3627573251724, 0),
  ZonePoint(51.3545474785437, 12.362676858902, 0),
  ZonePoint(51.3544871771411, 12.3624408245087, 0),
  ZonePoint(51.3547962209908, 12.3617649078369, 0),
  ZonePoint(51.3549327356317, 12.3619097471237, 0),
  ZonePoint(51.3551940385953, 12.3619419336319, 0),
  ZonePoint(51.3547953834763, 12.362135052681, 0)
}
_vwn_.OriginalPoint = ZonePoint(51.3547644996355, 12.362269833684, 0)
_vwn_.DistanceRangeUOM = "Feet"
_vwn_.ProximityRangeUOM = "Meters"
_vwn_.OutOfRangeName = ""
_vwn_.InRangeName = ""
_QeQao = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _A_OK})
_QeQao.Id = "d0bd74d7-3aa4-409b-944d-28e4bacb0121"
_QeQao.Name = _IHvVl("\015\025$5\025\022\031M%\025")
_QeQao.Description = ""
_QeQao.Visible = false
_QeQao.Media = _zIHG
_QeQao.Commands = {
  _vW6K = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _SxQTs = Wherigo.ZCommand({
    Text = _IHvVl("BI\025P5\025%\0164I\127\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _EQUW = Wherigo.ZCommand({
    Text = _IHvVl("Ucc4\r$rIP\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _NcC = Wherigo.ZCommand({
    Text = _IHvVl("rIKx\022jPI\0254>\025\022\0164I\127\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _AgJnk = Wherigo.ZCommand({
    Text = _IHvVl("BI\025P5\025%\0164I\127\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _yhvr_ = Wherigo.ZCommand({
    Text = _IHvVl("rIKx\022\004c%\r\022\0164I\127\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _lJ4_M = Wherigo.ZCommand({
    Text = _IHvVl("BI\025P5\025%\0164I\127\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_QeQao.Commands._vW6K.Custom = true
_QeQao.Commands._vW6K.Id = "e273fdc1-725a-411c-b2a2-dfe9c12778e9"
_QeQao.Commands._vW6K.WorksWithAll = true
_QeQao.Commands._SxQTs.Custom = true
_QeQao.Commands._SxQTs.Id = "7cad9d47-920d-4e99-a146-2da331de35af"
_QeQao.Commands._SxQTs.WorksWithAll = true
_QeQao.Commands._EQUW.Custom = true
_QeQao.Commands._EQUW.Id = "0a14d6e3-4e26-4ac1-9f2f-5f07f3efaf91"
_QeQao.Commands._EQUW.WorksWithAll = true
_QeQao.Commands._NcC.Custom = true
_QeQao.Commands._NcC.Id = "cd8682e6-04da-4a25-ad7f-58f058ead9d4"
_QeQao.Commands._NcC.WorksWithAll = true
_QeQao.Commands._AgJnk.Custom = true
_QeQao.Commands._AgJnk.Id = "bd501950-0a59-4a2b-8b62-e3f2376d1e8a"
_QeQao.Commands._AgJnk.WorksWithAll = true
_QeQao.Commands._yhvr_.Custom = true
_QeQao.Commands._yhvr_.Id = "b2aa6278-19ac-4d80-a7dc-5ce1e3f6ace6"
_QeQao.Commands._yhvr_.WorksWithAll = true
_QeQao.Commands._lJ4_M.Custom = true
_QeQao.Commands._lJ4_M.Id = "7035ddb3-f3ce-4a44-b634-77885e42b311"
_QeQao.Commands._lJ4_M.WorksWithAll = true
_QeQao.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QeQao.Gender = "It"
_QeQao.Type = "NPC"
_zTN0 = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _xGn})
_zTN0.Id = "92edca64-5dfb-48fd-a97d-6b78a595c88f"
_zTN0.Name = _IHvVl("<c%P\0254>r\025KxP\022IM5\022#IO\0254r")
_zTN0.Description = ""
_zTN0.Visible = false
_zTN0.Media = _6ItQ
_zTN0.Commands = {
  _jY3Iq = Wherigo.ZCommand({
    Text = _IHvVl("rIKx\022OP4cxj\022\0164I\127\025r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _ABN = Wherigo.ZCommand({
    Text = _IHvVl("@\0254y4M\025\127\025%r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_zTN0.Commands._jY3Iq.Custom = true
_zTN0.Commands._jY3Iq.Id = "880c1209-04ef-4b61-82e0-dfc174eeac0b"
_zTN0.Commands._jY3Iq.WorksWithAll = true
_zTN0.Commands._ABN.Custom = true
_zTN0.Commands._ABN.Id = "65d9e31e-a429-4ed1-b085-2107381ba4cd"
_zTN0.Commands._ABN.WorksWithAll = true
_zTN0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zTN0.Gender = "Male"
_zTN0.Type = "NPC"
_xiom = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _xGn})
_xiom.Id = "b1573151-d4a5-4da7-acdd-c6b11dea5e87"
_xiom.Name = _IHvVl("\020\025;IM\020\0254r\r\025\022OP4cxj")
_xiom.Description = ""
_xiom.Visible = false
_xiom.Commands = {
  _zdtqu = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_xiom.Commands._zdtqu.Custom = true
_xiom.Commands._zdtqu.Id = "814ec765-1d33-435c-a7be-ce7b07b67e56"
_xiom.Commands._zdtqu.WorksWithAll = true
_xiom.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xiom.Gender = "Female"
_xiom.Type = "NPC"
_sVsg = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _W38})
_sVsg.Id = "84ec4a34-d226-480b-83d8-78cd9ff6677c"
_sVsg.Name = _IHvVl("~$4IKM%$t")
_sVsg.Description = ""
_sVsg.Visible = false
_sVsg.Media = _mNiN
_sVsg.Commands = {
  _XOiNU = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _BqA = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _syi5 = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _2woZB = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_sVsg.Commands._XOiNU.Custom = true
_sVsg.Commands._XOiNU.Id = "ccb96bce-c928-49ec-9d57-99f9a18bb1ca"
_sVsg.Commands._XOiNU.WorksWithAll = true
_sVsg.Commands._BqA.Custom = true
_sVsg.Commands._BqA.Id = "d7f77763-2730-4793-9fa3-1b072640da71"
_sVsg.Commands._BqA.WorksWithAll = true
_sVsg.Commands._syi5.Custom = true
_sVsg.Commands._syi5.Id = "5a085b1b-309d-45a7-b06b-3b4aebc95e61"
_sVsg.Commands._syi5.WorksWithAll = true
_sVsg.Commands._2woZB.Custom = true
_sVsg.Commands._2woZB.Id = "13c800bc-0c69-42ba-bd93-7766366e7cb5"
_sVsg.Commands._2woZB.WorksWithAll = true
_sVsg.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_sVsg.Gender = "Male"
_sVsg.Type = "NPC"
_X6fw = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _uzvy})
_X6fw.Id = "fa4f2b6b-a876-4099-8600-4a1276913812"
_X6fw.Name = _IHvVl("#4M\025K>\025rP4c%%")
_X6fw.Description = ""
_X6fw.Visible = false
_X6fw.Media = _FhQ
_X6fw.Commands = {
  _wPA2 = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _KBz = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _XtaZ = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_X6fw.Commands._wPA2.Custom = true
_X6fw.Commands._wPA2.Id = "b456f041-77aa-4dab-a43c-3595ca4c0fa8"
_X6fw.Commands._wPA2.WorksWithAll = true
_X6fw.Commands._KBz.Custom = true
_X6fw.Commands._KBz.Id = "0aab98be-4384-4230-9ae7-32d7eac7dd47"
_X6fw.Commands._KBz.WorksWithAll = true
_X6fw.Commands._XtaZ.Custom = true
_X6fw.Commands._XtaZ.Id = "7d740435-6951-4f84-9905-4ad26a2a53c7"
_X6fw.Commands._XtaZ.WorksWithAll = true
_X6fw.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_X6fw.Gender = "Male"
_X6fw.Type = "NPC"
_R0X = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _Viv})
_R0X.Id = "ada0f981-a1f2-4d47-a14b-19b6d048b83a"
_R0X.Name = _IHvVl("P4IM4$\127\0255\022\031rP%\025$r")
_R0X.Description = ""
_R0X.Visible = true
_R0X.Media = _lNi
_R0X.Commands = {
  _hQl = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _yL8G = Wherigo.ZCommand({
    Text = _IHvVl("\016M\025PP\0254r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_R0X.Commands._hQl.Custom = true
_R0X.Commands._hQl.Id = "b13685f6-6db2-473a-91f1-4f0308727890"
_R0X.Commands._hQl.WorksWithAll = true
_R0X.Commands._yL8G.Custom = true
_R0X.Commands._yL8G.Id = "88bfccfe-f5b2-4159-9558-702a27cf82f3"
_R0X.Commands._yL8G.WorksWithAll = true
_R0X.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_R0X.Gender = "It"
_R0X.Type = "NPC"
_QnaT = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _DhVS})
_QnaT.Id = "d2c18687-7448-4658-82ae-18250e11eb2e"
_QnaT.Name = _IHvVl("jKx%Moy\016$rKx\025r")
_QnaT.Description = ""
_QnaT.Visible = false
_QnaT.Commands = {}
_QnaT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QnaT.Gender = "Female"
_QnaT.Type = "NPC"
_rv4 = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _UqH_})
_rv4.Id = "24a9c801-956d-4328-af7a-58effe1b048b"
_rv4.Name = _IHvVl(")IyI\022jKx%Moy\016")
_rv4.Description = ""
_rv4.Visible = false
_rv4.Media = _08NEq
_rv4.Commands = {
  _2JwS8 = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_rv4.Commands._2JwS8.Custom = true
_rv4.Commands._2JwS8.Id = "6c2639eb-27e2-46d2-89c1-15f5b900d287"
_rv4.Commands._2JwS8.WorksWithAll = true
_rv4.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rv4.Gender = "Male"
_rv4.Type = "NPC"
_CjIwA = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _PyRp})
_CjIwA.Id = "b6cfba86-636a-42d3-82c9-72a811148651"
_CjIwA.Name = _IHvVl("~$\rI5")
_CjIwA.Description = ""
_CjIwA.Visible = false
_CjIwA.Media = _Pg3e
_CjIwA.Commands = {
  _UQ_N9 = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _n_qZ6 = Wherigo.ZCommand({
    Text = _IHvVl("\014M\016\127I\020\025\022%c\0255\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _hWlB = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _qUD = Wherigo.ZCommand({
    Text = _IHvVl("<4I\127\025\022%c\0255\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_CjIwA.Commands._UQ_N9.Custom = true
_CjIwA.Commands._UQ_N9.Id = "b279cb08-f9fb-4c14-b58e-f15624ce62bb"
_CjIwA.Commands._UQ_N9.WorksWithAll = true
_CjIwA.Commands._n_qZ6.Custom = true
_CjIwA.Commands._n_qZ6.Id = "1b8f375c-6dac-455b-bd09-01e3fde76530"
_CjIwA.Commands._n_qZ6.WorksWithAll = true
_CjIwA.Commands._hWlB.Custom = true
_CjIwA.Commands._hWlB.Id = "f32b192a-ed56-4874-a369-23c1d8413912"
_CjIwA.Commands._hWlB.WorksWithAll = true
_CjIwA.Commands._qUD.Custom = true
_CjIwA.Commands._qUD.Id = "5012fce6-c065-4f98-b5f7-cba07218ad03"
_CjIwA.Commands._qUD.WorksWithAll = true
_CjIwA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_CjIwA.Gender = "Male"
_CjIwA.Type = "NPC"
_5io = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _DhVS})
_5io.Id = "5a9e677a-d73a-43ab-9c49-0859695a2fb9"
_5io.Name = _IHvVl("?\025<($9jKx%Moy\016")
_5io.Description = ""
_5io.Visible = false
_5io.Media = _PJaK
_5io.Commands = {
  _zTC7p = Wherigo.ZCommand({
    Text = _IHvVl("5y4\025Kx\025r\022o$P\022"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _LgW = Wherigo.ZCommand({
    Text = _IHvVl("<4I\127\025\022\020\025IrP,c4P\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _IagfL = Wherigo.ZCommand({
    Text = _IHvVl("<4I\127\025\022\020\025IrP,c4P\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _5Hb = Wherigo.ZCommand({
    Text = _IHvVl("<4I\127\025\022\020\025IrP,c4P\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_5io.Commands._zTC7p.Custom = true
_5io.Commands._zTC7p.Id = "da819a37-27a3-4fd5-b20d-15bb6dfece75"
_5io.Commands._zTC7p.WorksWithAll = true
_5io.Commands._LgW.Custom = true
_5io.Commands._LgW.Id = "19baa9fd-7abe-46ce-ae00-d67fc6d550d0"
_5io.Commands._LgW.WorksWithAll = true
_5io.Commands._IagfL.Custom = true
_5io.Commands._IagfL.Id = "e8ed56a0-3ee4-46ac-9e93-ef3a200afb60"
_5io.Commands._IagfL.WorksWithAll = true
_5io.Commands._5Hb.Custom = true
_5io.Commands._5Hb.Id = "7f7ebf59-38aa-4677-9158-c6ddbf530b79"
_5io.Commands._5Hb.WorksWithAll = true
_5io.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_5io.Gender = "Male"
_5io.Type = "NPC"
_1LlI = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _g5eMc})
_1LlI.Id = "6a1cad34-2c4e-4ae9-a811-253fc091b67c"
_1LlI.Name = _IHvVl("\n\020\025%$t")
_1LlI.Description = ""
_1LlI.Visible = false
_1LlI.Commands = {
  _fsM = Wherigo.ZCommand({
    Text = _IHvVl("rIKx\022(M\0254\022\0164I\127\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_1LlI.Commands._fsM.Custom = true
_1LlI.Commands._fsM.Id = "96524045-5964-42a4-9f38-d6f23175f8fc"
_1LlI.Commands._fsM.WorksWithAll = true
_1LlI.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_1LlI.Gender = "Male"
_1LlI.Type = "NPC"
_B1HWR = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _xGn})
_B1HWR.Id = "9a46235e-a5c6-4b28-87a9-92f147177c3e"
_B1HWR.Name = _IHvVl("<c%P\0254>r\025KxP\022:>CcCE")
_B1HWR.Description = ""
_B1HWR.Visible = false
_B1HWR.Commands = {
  _8Vda = Wherigo.ZCommand({
    Text = _IHvVl("\016\02555\025%r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_B1HWR.Commands._8Vda.Custom = true
_B1HWR.Commands._8Vda.Id = "33bc712c-d2d7-4bb8-a058-588d0f6f7df2"
_B1HWR.Commands._8Vda.WorksWithAll = true
_B1HWR.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_B1HWR.Gender = "Male"
_B1HWR.Type = "NPC"
_tBv1N = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _xGn})
_tBv1N.Id = "c9277fac-d0d1-4b55-ba08-1c892c7cee82"
_tBv1N.Name = _IHvVl("<c%P\0254>r\025KxP\022:\127\025\016\02555\025%PE")
_tBv1N.Description = ""
_tBv1N.Visible = false
_tBv1N.Media = _mOnu
_tBv1N.Commands = {
  _9kju = Wherigo.ZCommand({
    Text = _IHvVl("<4I\127\025\022rIKx\022\017c\r\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_tBv1N.Commands._9kju.Custom = true
_tBv1N.Commands._9kju.Id = "ef924bed-5049-4d70-9f94-313e0c1279be"
_tBv1N.Commands._9kju.WorksWithAll = true
_tBv1N.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tBv1N.Gender = "Male"
_tBv1N.Type = "NPC"
_xgJg = Wherigo.ZCharacter({Cartridge = _Jfx, Container = _xGn})
_xgJg.Id = "038a6d7d-a555-4a36-8222-3ac16a20cee4"
_xgJg.Name = _IHvVl("OP4cxj\022IM\016\022jP4\025K>\020Ir>")
_xgJg.Description = ""
_xgJg.Visible = false
_xgJg.Commands = {
  _I66kV = Wherigo.ZCommand({
    Text = _IHvVl("\020\025\0164\025$\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_xgJg.Commands._I66kV.Custom = true
_xgJg.Commands._I66kV.Id = "1a47f20d-ea30-453c-9b57-57f85149b87d"
_xgJg.Commands._I66kV.WorksWithAll = true
_xgJg.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xgJg.Gender = "Male"
_xgJg.Type = "NPC"
_jufap = Wherigo.ZItem({Cartridge = _Jfx, Container = _uzvy})
_jufap.Id = "bf76cb1b-7f87-4218-bf56-ad4f403931cc"
_jufap.Name = _IHvVl("\127c%\r\025r\025\022j$Kx\025%")
_jufap.Description = ""
_jufap.Visible = false
_jufap.Commands = {
  _HOy1 = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_jufap.Commands._HOy1.Custom = true
_jufap.Commands._HOy1.Id = "71616019-3e14-47a1-85ed-c66cc60d7a00"
_jufap.Commands._HOy1.WorksWithAll = true
_jufap.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jufap.Locked = false
_jufap.Opened = false
_qvzq = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_qvzq.Id = "18f8c022-f1ef-422a-a3a7-b10abd716212"
_qvzq.Name = _IHvVl("#\025Kx\0254\022\015I55\0254")
_qvzq.Description = ""
_qvzq.Visible = false
_qvzq.Commands = {
  _7Kih = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_qvzq.Commands._7Kih.Custom = true
_qvzq.Commands._7Kih.Id = "8ee28a62-6957-4480-b46a-50019e071875"
_qvzq.Commands._7Kih.WorksWithAll = true
_qvzq.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_qvzq.Locked = false
_qvzq.Opened = false
_NfDA = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_NfDA.Id = "f32b00f2-ada6-4ba8-a18e-98ec7c5a5ebb"
_NfDA.Name = _IHvVl("#4cP")
_NfDA.Description = ""
_NfDA.Visible = false
_NfDA.Commands = {
  _LUz = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _j2aur = Wherigo.ZCommand({
    Text = _IHvVl(";Mo\022\031rP%\025$r\022,\0254\016\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_NfDA.Commands._LUz.Custom = true
_NfDA.Commands._LUz.Id = "e3946704-e261-41dc-8c26-1bf7d64bba8a"
_NfDA.Commands._LUz.WorksWithAll = true
_NfDA.Commands._j2aur.Custom = true
_NfDA.Commands._j2aur.Id = "b9545427-6e6c-40e4-a33c-169950735e3a"
_NfDA.Commands._j2aur.WorksWithAll = true
_NfDA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NfDA.Locked = false
_NfDA.Opened = false
_VMl = Wherigo.ZItem({Cartridge = _Jfx, Container = _e8v5X})
_VMl.Id = "5afe599d-b7c2-46b5-8d60-d25ba8ff9321"
_VMl.Name = _IHvVl("#%MP,M4;")
_VMl.Description = ""
_VMl.Visible = false
_VMl.Commands = {
  _OF8H = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _2nRJn = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_VMl.Commands._OF8H.Custom = true
_VMl.Commands._OF8H.Id = "d91a3bd4-726a-44cb-b917-98c8064cb57e"
_VMl.Commands._OF8H.WorksWithAll = true
_VMl.Commands._2nRJn.Custom = true
_VMl.Commands._2nRJn.Id = "e9af868a-02b2-4d70-86e9-f7336b4958b5"
_VMl.Commands._2nRJn.WorksWithAll = true
_VMl.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_VMl.Locked = false
_VMl.Opened = false
_vbOGH = Wherigo.ZItem({Cartridge = _Jfx, Container = _g5eMc})
_vbOGH.Id = "65c296e7-4cad-4198-ab76-918ca150c942"
_vbOGH.Name = _IHvVl("U\02555\025%")
_vbOGH.Description = ""
_vbOGH.Visible = false
_vbOGH.Commands = {}
_vbOGH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_vbOGH.Locked = false
_vbOGH.Opened = false
_NLd = Wherigo.ZItem({Cartridge = _Jfx, Container = _g5eMc})
_NLd.Id = "9ac2863c-8035-4563-ae88-f99ab945b1c0"
_NLd.Name = _IHvVl("zIM\020\0254P4Ir>")
_NLd.Description = ""
_NLd.Visible = false
_NLd.Commands = {
  _YoIRQ = Wherigo.ZCommand({
    Text = _IHvVl("P4$r>\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_NLd.Commands._YoIRQ.Custom = true
_NLd.Commands._YoIRQ.Id = "df655b94-32c5-4cfe-8e86-8dcfe2ac9e18"
_NLd.Commands._YoIRQ.WorksWithAll = true
_NLd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NLd.Locked = false
_NLd.Opened = false
_bhp = Wherigo.ZItem({Cartridge = _Jfx, Container = Player})
_bhp.Id = "d6e00a88-a4b4-4cb0-a17f-f67d389b6164"
_bhp.Name = _IHvVl("U$\0255\025%5P\025$rKx\025r")
_bhp.Description = ""
_bhp.Visible = false
_bhp.Commands = {
  _tyLE = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_bhp.Commands._tyLE.Custom = true
_bhp.Commands._tyLE.Id = "669ea69c-4857-4bdf-b53e-e91374e65225"
_bhp.Commands._tyLE.WorksWithAll = true
_bhp.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_bhp.Locked = false
_bhp.Opened = false
_QJNJ_ = Wherigo.ZItem({Cartridge = _Jfx, Container = _9GC})
_QJNJ_.Id = "7bb8d102-918f-459e-9e02-528578e1bbd3"
_QJNJ_.Name = _IHvVl("5Kx,\0254\0254\022jP\025$r")
_QJNJ_.Description = ""
_QJNJ_.Visible = false
_QJNJ_.Commands = {
  _lm2Y1 = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _ZVVh = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_QJNJ_.Commands._lm2Y1.Custom = true
_QJNJ_.Commands._lm2Y1.Id = "9ee670bb-c3ef-45f8-a84f-4ddbdb634bda"
_QJNJ_.Commands._lm2Y1.WorksWithAll = true
_QJNJ_.Commands._ZVVh.Custom = true
_QJNJ_.Commands._ZVVh.Id = "1af03eb5-64cd-4218-a16b-c73ddd517232"
_QJNJ_.Commands._ZVVh.WorksWithAll = true
_QJNJ_.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QJNJ_.Locked = false
_QJNJ_.Opened = false
_iU2 = Wherigo.ZItem({Cartridge = _Jfx, Container = _PyRp})
_iU2.Id = "1777f672-799f-45dc-ba85-4cbd67ec840f"
_iU2.Name = _IHvVl("\004c%\r>%Moy\025r")
_iU2.Description = ""
_iU2.Visible = false
_iU2.Commands = {}
_iU2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_iU2.Locked = false
_iU2.Opened = false
_z1k = Wherigo.ZItem({Cartridge = _Jfx, Container = Player})
_z1k.Id = "edb6ee79-d122-4979-afec-43c88da7361c"
_z1k.Name = _IHvVl("\015M45P\0204cP")
_z1k.Description = ""
_z1k.Visible = false
_z1k.Commands = {
  _mKtM = Wherigo.ZCommand({
    Text = _IHvVl("\015$4\016\022\015M45P\0204cP"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_z1k.Commands._mKtM.Custom = true
_z1k.Commands._mKtM.Id = "0a77f2b0-6c63-426d-a48a-5845d402ee2d"
_z1k.Commands._mKtM.WorksWithAll = true
_z1k.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_z1k.Locked = false
_z1k.Opened = false
_8BjI2 = Wherigo.ZItem({Cartridge = _Jfx, Container = _PyRp})
_8BjI2.Id = "30636802-499a-4e95-a620-2f1f7467a0d3"
_8BjI2.Name = _IHvVl("\004c%\r>$\0255\025%")
_8BjI2.Description = ""
_8BjI2.Visible = false
_8BjI2.Commands = {
  _abe6M = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_8BjI2.Commands._abe6M.Custom = true
_8BjI2.Commands._abe6M.Id = "8503bcc0-4a63-49b4-baa4-5ee8d010eb32"
_8BjI2.Commands._abe6M.WorksWithAll = true
_8BjI2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8BjI2.Locked = false
_8BjI2.Opened = false
_R42 = Wherigo.ZItem({Cartridge = _Jfx, Container = _GWSA4})
_R42.Id = "bfd7d6f0-696f-44b6-abc6-29285c68294d"
_R42.Name = _IHvVl("<$r\127\0254>4IMP")
_R42.Description = ""
_R42.Visible = false
_R42.Commands = {
  _mwEDr = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _2OS = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_R42.Commands._mwEDr.Custom = true
_R42.Commands._mwEDr.Id = "bcf93e31-0458-4142-ac25-7eb550f09d26"
_R42.Commands._mwEDr.WorksWithAll = true
_R42.Commands._2OS.Custom = true
_R42.Commands._2OS.Id = "267f5636-c184-46f9-8ef0-8d7ad6b1ef0d"
_R42.Commands._2OS.WorksWithAll = true
_R42.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_R42.Locked = false
_R42.Opened = false
_TC9 = Wherigo.ZItem({Cartridge = _Jfx, Container = _dRaJG})
_TC9.Id = "0569e84d-5422-434c-88df-a147b98fe626"
_TC9.Name = _IHvVl("jMoy\0169#%MPIM\127\025")
_TC9.Description = ""
_TC9.Visible = false
_TC9.Commands = {
  _t3Kl2 = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _or6e = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_TC9.Commands._t3Kl2.Custom = true
_TC9.Commands._t3Kl2.Id = "079a4636-d116-4786-8fdb-65a9803c0f2e"
_TC9.Commands._t3Kl2.WorksWithAll = true
_TC9.Commands._or6e.Custom = true
_TC9.Commands._or6e.Id = "dc98c368-6727-4667-9a1e-f3e0072314ab"
_TC9.Commands._or6e.WorksWithAll = true
_TC9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_TC9.Locked = false
_TC9.Opened = false
_ae1 = Wherigo.ZItem({Cartridge = _Jfx, Container = _ygb})
_ae1.Id = "709f5329-d64e-480f-88c8-5251036a467f"
_ae1.Name = _IHvVl("U%\025PP\025r9\"I\020>4IMP")
_ae1.Description = ""
_ae1.Visible = false
_ae1.Commands = {
  _oT9 = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _Vao = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_ae1.Commands._oT9.Custom = true
_ae1.Commands._oT9.Id = "21f3e833-d78f-41b2-a233-5423c35f3b5b"
_ae1.Commands._oT9.WorksWithAll = true
_ae1.Commands._Vao.Custom = true
_ae1.Commands._Vao.Id = "1ab08bbd-bce8-4901-a47e-c08494504fc0"
_ae1.Commands._Vao.WorksWithAll = true
_ae1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ae1.Locked = false
_ae1.Opened = false
_iyQKG = Wherigo.ZItem({Cartridge = _Jfx, Container = _PYAh})
_iyQKG.Id = "d5e96ef1-a9b0-4202-b9f1-3ac49e6d0b31"
_iyQKG.Name = _IHvVl("\015I%\ro\025$5P\0254")
_iyQKG.Description = ""
_iyQKG.Visible = false
_iyQKG.Commands = {
  _L9Ier = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _VCGb = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_iyQKG.Commands._L9Ier.Custom = true
_iyQKG.Commands._L9Ier.Id = "d3b7b78c-e121-4a74-9f7f-c463f02e57e1"
_iyQKG.Commands._L9Ier.WorksWithAll = true
_iyQKG.Commands._VCGb.Custom = true
_iyQKG.Commands._VCGb.Id = "f67e62fb-b7a0-42d3-9fca-c696ab13adff"
_iyQKG.Commands._VCGb.WorksWithAll = true
_iyQKG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_iyQKG.Locked = false
_iyQKG.Opened = false
_O6CA = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_O6CA.Id = "e6998925-9e38-4385-8864-66f7c963a4f6"
_O6CA.Name = _IHvVl("jP4$K>")
_O6CA.Description = ""
_O6CA.Visible = false
_O6CA.Commands = {
  _rmbA = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_O6CA.Commands._rmbA.Custom = true
_O6CA.Commands._rmbA.Id = "b9196642-e941-4765-bf2e-e62e942dca4b"
_O6CA.Commands._rmbA.WorksWithAll = true
_O6CA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_O6CA.Locked = false
_O6CA.Opened = false
_IWjn = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_IWjn.Id = "d307d661-194e-4d1f-a34e-2ed1d2bab7f2"
_IWjn.Name = _IHvVl("jP4\025K>\020Ir>")
_IWjn.Description = ""
_IWjn.Visible = false
_IWjn.Commands = {}
_IWjn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_IWjn.Locked = false
_IWjn.Opened = false
_fcBXk = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_fcBXk.Id = "4489f3df-1c11-44bd-97f4-da10d305d9e0"
_fcBXk.Name = _IHvVl("\017c\r\0259jKx%c55")
_fcBXk.Description = ""
_fcBXk.Visible = false
_fcBXk.Commands = {
  _TBtgJ = Wherigo.ZCommand({
    Text = _IHvVl("c\025\016\016r\025"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_fcBXk.Commands._TBtgJ.Custom = true
_fcBXk.Commands._TBtgJ.Id = "e76b2485-8db7-4493-8864-993849e07250"
_fcBXk.Commands._TBtgJ.WorksWithAll = true
_fcBXk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fcBXk.Locked = false
_fcBXk.Opened = false
_XoEWn = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_XoEWn.Id = "71da71d0-3076-42ab-aafb-67efc04471f6"
_XoEWn.Name = _IHvVl("U\0254>\0254PM\0254")
_XoEWn.Description = ""
_XoEWn.Visible = false
_XoEWn.Commands = {
  _2gfWz = Wherigo.ZCommand({
    Text = _IHvVl("c\025\016\016r\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_XoEWn.Commands._2gfWz.Custom = true
_XoEWn.Commands._2gfWz.Id = "5d96baf1-1712-4b8b-aa22-89d355eaa262"
_XoEWn.Commands._2gfWz.WorksWithAll = true
_XoEWn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_XoEWn.Locked = false
_XoEWn.Opened = false
_gEJfx = Wherigo.ZItem({Cartridge = _Jfx, Container = _xGn})
_gEJfx.Id = "c89133eb-bdf1-4b36-9880-f12b37ded2e3"
_gEJfx.Name = _IHvVl("U\0254>\0254PM\0254\022c\016\016\025r")
_gEJfx.Description = ""
_gEJfx.Visible = false
_gEJfx.Commands = {}
_gEJfx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_gEJfx.Locked = false
_gEJfx.Opened = false
_mz3 = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_mz3.Id = "37c8de94-a135-481a-8228-b366f0a92065"
_mz3.Name = _IHvVl("jKx%IM\020$9)xcr")
_mz3.Description = ""
_mz3.Visible = false
_mz3.Commands = {
  _FSbT = Wherigo.ZCommand({
    Text = _IHvVl("jKx%IM\020$\022\0164I\127\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  }),
  _O7Dit = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_mz3.Commands._FSbT.Custom = true
_mz3.Commands._FSbT.Id = "49b3d81a-f491-4b96-9c8b-5d6555554d15"
_mz3.Commands._FSbT.WorksWithAll = true
_mz3.Commands._O7Dit.Custom = true
_mz3.Commands._O7Dit.Id = "a4a467ac-7b79-43d8-bc2c-7cf14a49023c"
_mz3.Commands._O7Dit.WorksWithAll = true
_mz3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_mz3.Locked = false
_mz3.Opened = false
_wAX8S = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_wAX8S.Id = "cd94bb9b-3722-47a4-9458-08a2dce58ecb"
_wAX8S.Name = _IHvVl("#M\025Kx\0254")
_wAX8S.Description = ""
_wAX8S.Visible = false
_wAX8S.Commands = {
  _1sg = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_wAX8S.Commands._1sg.Custom = true
_wAX8S.Commands._1sg.Id = "454abcba-8b83-401b-8c33-23f23f75dc8b"
_wAX8S.Commands._1sg.WorksWithAll = true
_wAX8S.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_wAX8S.Locked = false
_wAX8S.Opened = false
_tOPQR = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_tOPQR.Id = "8feb19c3-667e-4a88-949a-2e238326e008"
_tOPQR.Name = _IHvVl("#MKx\022\r\0254\022\004Moo$\020I\0254\025r")
_tOPQR.Description = ""
_tOPQR.Visible = true
_tOPQR.Commands = {
  _Neq = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_tOPQR.Commands._Neq.Custom = true
_tOPQR.Commands._Neq.Id = "43560cf9-ab8b-4fef-8c70-e7e812c1c37e"
_tOPQR.Commands._Neq.WorksWithAll = true
_tOPQR.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tOPQR.Locked = false
_tOPQR.Opened = false
_jesTW = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_jesTW.Id = "f6822b37-6019-460a-8bad-ab0b7b1ce139"
_jesTW.Name = _IHvVl("B\025\127I%")
_jesTW.Description = ""
_jesTW.Visible = true
_jesTW.Commands = {
  _EemlN = Wherigo.ZCommand({
    Text = _IHvVl("\020\025P4IKxP\025"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_jesTW.Commands._EemlN.Custom = true
_jesTW.Commands._EemlN.Id = "6441d8f1-8b26-4309-8313-50e058b4b6a3"
_jesTW.Commands._EemlN.WorksWithAll = true
_jesTW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jesTW.Locked = false
_jesTW.Opened = false
_g0Ve = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_g0Ve.Id = "84643afe-6e0d-42db-a550-3be012896041"
_g0Ve.Name = _IHvVl("B\025I\127\025r;\127%I\0255\0254")
_g0Ve.Description = ""
_g0Ve.Visible = false
_g0Ve.Commands = {
  _jPTxh = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_g0Ve.Commands._jPTxh.Custom = true
_g0Ve.Commands._jPTxh.Id = "b3035636-2770-4cdf-8674-beeadb82b07a"
_g0Ve.Commands._jPTxh.WorksWithAll = true
_g0Ve.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g0Ve.Locked = false
_g0Ve.Opened = false
_Ymdwd = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_Ymdwd.Id = "b3f6cbc9-dce5-40df-ae47-0e883ff024c2"
_Ymdwd.Name = _IHvVl("\r$@\02545\025\022#M\025Kx\0254")
_Ymdwd.Description = ""
_Ymdwd.Visible = false
_Ymdwd.Commands = {
  _ysz = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_Ymdwd.Commands._ysz.Custom = true
_Ymdwd.Commands._ysz.Id = "221d62e2-9bd5-421b-abab-0033cd549604"
_Ymdwd.Commands._ysz.WorksWithAll = true
_Ymdwd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Ymdwd.Locked = false
_Ymdwd.Opened = false
_zPrhd = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_zPrhd.Id = "b149508d-6d56-460f-a422-bba4510d81ec"
_zPrhd.Name = _IHvVl("o\0254>,M\0254\r$\127\0255\022\021$r\127")
_zPrhd.Description = ""
_zPrhd.Visible = false
_zPrhd.Commands = {
  _91W = Wherigo.ZCommand({
    Text = _IHvVl("r$oo"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_zPrhd.Commands._91W.Custom = true
_zPrhd.Commands._91W.Id = "1fe4dca0-f885-4aeb-9534-1f0001527f2e"
_zPrhd.Commands._91W.WorksWithAll = true
_zPrhd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zPrhd.Locked = false
_zPrhd.Opened = false
_6eQ = Wherigo.ZItem({Cartridge = _Jfx, Container = _UqH_})
_6eQ.Id = "49823d0e-a9f5-4cd6-936f-668a4c6199b4"
_6eQ.Name = _IHvVl("\1274c55\025\022(4Mx\025")
_6eQ.Description = ""
_6eQ.Visible = true
_6eQ.Commands = {
  _R6NE = Wherigo.ZCommand({
    Text = _IHvVl("\020\025P4IKxP\025"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_6eQ.Commands._R6NE.Custom = true
_6eQ.Commands._R6NE.Id = "94ebcc15-2233-4423-b2ce-52bb17969e09"
_6eQ.Commands._R6NE.WorksWithAll = true
_6eQ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_6eQ.Locked = false
_6eQ.Opened = false
_AHHb = Wherigo.ZItem({Cartridge = _Jfx, Container = Player})
_AHHb.Id = "b18ac439-7248-4da4-84b7-fe8fdc80ecbd"
_AHHb.Name = _IHvVl(")$K>r$K>\r\025K>\025")
_AHHb.Description = ""
_AHHb.Visible = true
_AHHb.Commands = {
  _EHS = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_AHHb.Commands._EHS.Custom = true
_AHHb.Commands._EHS.Id = "c47c75ed-456e-4b4c-a5da-0b58c1bf98aa"
_AHHb.Commands._EHS.WorksWithAll = true
_AHHb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_AHHb.Locked = false
_AHHb.Opened = false
_B5Z4 = Wherigo.ZItem({Cartridge = _Jfx, Container = Player})
_B5Z4.Id = "0e3adbd2-2ea4-4cc0-9832-bc20524c74c2"
_B5Z4.Name = _IHvVl(")$K>r$K>>c4\020")
_B5Z4.Description = ""
_B5Z4.Visible = true
_B5Z4.Commands = {
  _WRu = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_B5Z4.Commands._WRu.Custom = true
_B5Z4.Commands._WRu.Id = "702ad66b-079c-4c7e-b4dc-ad7607a2dab9"
_B5Z4.Commands._WRu.WorksWithAll = true
_B5Z4.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_B5Z4.Locked = false
_B5Z4.Opened = false
_8S_S = Wherigo.ZItem({Cartridge = _Jfx, Container = Player})
_8S_S.Id = "aa2298a1-5e3e-4f76-80cb-a8188ce8b022"
_8S_S.Name = _IHvVl("\015\025$r\016%I5Kx\025")
_8S_S.Description = ""
_8S_S.Visible = true
_8S_S.Commands = {
  _Lb2UH = Wherigo.ZCommand({
    Text = _IHvVl("\127$\020"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_8S_S.Commands._Lb2UH.Custom = true
_8S_S.Commands._Lb2UH.Id = "72b635a2-0b2f-4c89-b90d-a8b4cddbad9a"
_8S_S.Commands._Lb2UH.WorksWithAll = true
_8S_S.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8S_S.Locked = false
_8S_S.Opened = false
_QiH6 = Wherigo.ZItem({Cartridge = _Jfx, Container = _VGe})
_QiH6.Id = "66370935-fc19-445f-8581-9c4b965158c6"
_QiH6.Name = _IHvVl("wr%cK>9\017c\r\025")
_QiH6.Description = ""
_QiH6.Visible = false
_QiH6.Commands = {
  _0v4N8 = Wherigo.ZCommand({
    Text = _IHvVl("%\0255\025r"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _IHvVl("F$KxP\022@\0254\016M\127\020I4")
  })
}
_QiH6.Commands._0v4N8.Custom = true
_QiH6.Commands._0v4N8.Id = "25b459e5-e26e-4d70-b028-c78a8a359a90"
_QiH6.Commands._0v4N8.WorksWithAll = true
_QiH6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QiH6.Locked = false
_QiH6.Opened = false
_HCJz = Wherigo.ZTask(_Jfx)
_HCJz.Id = "8bf8e9e7-fa30-4e7b-af1c-de9400c016a7"
_HCJz.Name = _IHvVl("jy4$Kx\022o$P\022P4IM4$\127\025o\022\031rP%\025$r")
_HCJz.Description = _IHvVl("\021I5\022I4o\025\022\031rP%\025$r\022x$\0254\022Io\022j\025\025\0225$\025xP\0225c\022P4IM4$\127\022IM5C\022\015I5\022,$4\r\022,cx%\022yI55$\0254P\0225\025$r3\022\014o\022\020\0255P\025r\022\rM\0225y4$Kx5P\022o$P\022$xoC")
_HCJz.Visible = false
_HCJz.Active = false
_HCJz.Complete = false
_HCJz.CorrectState = "None"
_rb262 = Wherigo.ZTask(_Jfx)
_rb262.Id = "ef6af5c6-321e-4ed8-b31f-f09c9ba96168"
_rb262.Name = _IHvVl("\015$4\016\022\015M45P\0204cP")
_rb262.Description = _IHvVl("\n>IO\0229\022\025P,I5\022\020\02555\0254\0255\022xI5P\022\rM\022r$KxPC\022\014\020\0254\022\rI5\022\015M45P\0204cP\022$5P\022\rcKx\022;Mo$r\r\0255P\022\025$r\022\014r\016Ir\127C\022<M\025PP\0254\025\022\rcKx\022\rI5\022xMr\1274$\127\025\022\031rP%\025$rC")
_rb262.Visible = false
_rb262.Active = true
_rb262.Complete = false
_rb262.CorrectState = "None"
_ARXE = Wherigo.ZTask(_Jfx)
_ARXE.Id = "5cb78874-148a-4ad2-94e1-d2b6706137c3"
_ARXE.Name = _IHvVl("B\025\r\025\022o$P\022)IyI\022jKx%Moy\016")
_ARXE.Description = _IHvVl("\021I5\022\031rP%\025$r\0225Kx$K>P\022\r$Kx\022I%5c\022;M\022)IyI\022jKx%Moy\016C\022B\025\r\025\022o$P\022$xo|\022Mo\022o\025x4\022;M\022\0254\016Ix4\025rC")
_ARXE.Visible = false
_ARXE.Active = true
_ARXE.Complete = false
_ARXE.CorrectState = "None"
_O8_EU = Wherigo.ZTask(_Jfx)
_O8_EU.Id = "00b497c9-21c0-4841-9490-c90fe9b215ec"
_O8_EU.Name = _IHvVl("\015\0254\r\025\0225PI\0254>\0254.")
_O8_EU.Description = _IHvVl("\to\022~co\025rP\022xI5P\022\rM\022\127\025\127\025r\022\r\025r\022<c%P\0254>r\025KxP\0225c\022>\025$r\025\022\017xIrK\025C\022<$r\r\025\022\025$r\025r\022\015\025\127\0225PI\0254>\0254\022;M\022,\0254\r\025rC")
_O8_EU.Visible = true
_O8_EU.Active = false
_O8_EU.Complete = false
_O8_EU.CorrectState = "None"
_lTs = Wherigo.ZTask(_Jfx)
_lTs.Id = "aba2ab9f-9a53-4ec4-83cb-dca4dd38e16f"
_lTs.Name = _IHvVl("#4$r\127\025\022~$4IKM%$t\0225\025$r\025\022\127c%\r\025r\025\022j$Kx\025%")
_lTs.Description = _IHvVl("\021Io$P\022\r$4\022~$4IKM%$t\022~$5P\025%r\0225Kxr\025$\r\025r\022>Irr|\022\020\025rc\025P$\127P\022\0254\0225\025$r\025\022\004c%\r\025r\025\022j$Kx\025%C\022?c%\025\0225$\025\022@co\022#4M\025K>\025rP4c%%.")
_lTs.Visible = false
_lTs.Active = false
_lTs.Complete = false
_lTs.CorrectState = "None"
_6dpA = Wherigo.ZTask(_Jfx)
_6dpA.Id = "ef22aef0-474d-498e-b50b-336b7ff2bc03"
_6dpA.Name = _IHvVl("#4$r\127\025\022~$4IKM%$t\022U4I\025MP\0254")
_6dpA.Description = _IHvVl("~$4IKM%$t\022\0204IMKxP\022rcKx\022\025$r$\127\025\022U4I\025MP\0254\022\016M\0254\022\r\025r\022(4Mr>C\022)\016%M\025K>\025\022\r$\0255\025\022IM\016\022\r\0254\022\1274c55\025r\022\015$\0255\025C")
_6dpA.Visible = false
_6dpA.Active = false
_6dpA.Complete = false
_6dpA.CorrectState = "None"
_RHskH = Wherigo.ZTask(_Jfx)
_RHskH.Id = "032eb965-ef8a-4ded-bd72-e795812d5cd3"
_RHskH.Name = _IHvVl("\"c\127\127\025r")
_RHskH.Description = _IHvVl("\021M\022>Irr5P\022IM\016\022\r\0254\022\015x\0254$\127c9j\025$P\025\022\r\025r\022\017IKx\025\022I%5\0220Kcoy%\025P\025\r0\022%c\127\127\025rC\022\019\0254,\025r\r\025\022\rI;M\022\r\025r\0220wr%cK>9Kc\r\0250C\022")
_RHskH.Visible = true
_RHskH.Active = false
_RHskH.Complete = false
_RHskH.CorrectState = "None"
_ETV = _IHvVl("\006I")
_5MQtS = _IHvVl("r\025$r")
_hvqR8 = _IHvVl("4cP")
_D6Hq = _IHvVl("W")
_gFx9M = _IHvVl("'2")
_cQ5y = _IHvVl("--")
_8Kkn = _IHvVl("\\v")
_P2y = _IHvVl("2\028`W")
_ALGX = _IHvVl("-2")
_0T4ed = _IHvVl("D")
_Oqsy = _IHvVl("D\\")
_y2s = false
_OOZ = false
_GyRH = false
_xZeiV = false
_G0Lp = false
_VjL1 = false
_9Qs = _IHvVl("Pc4PM4")
_03ZIq = false
_WWequ = false
_mjR = false
_tGG = false
_3pXLP = false
_Ec_B = false
_SyVV = false
__G33 = false
_V6u7 = _IHvVl("\031rP\025rP\025$Kx")
_Ja5K = false
_CkB6T = false
_n55 = false
_UWNT = false
_4Czl = false
_YOP = false
_hvD = false
_sYDiA = false
_gI91b = false
_WM0C = false
_0rMtD = false
_MTu = false
_ZFpYy = false
_IMf7 = false
_w4Nd = false
_MyTEl = false
_mrid = false
_wZR3z = false
_2rc = false
_cN2oa = _IHvVl("a>(-y")
_HuMz_ = _IHvVl("a/\025/Ic")
_IFo = _IHvVl("a\006M\016Iy")
_2Sjt9 = _IHvVl("a?\017\026;")
_uUlX = _IHvVl("a\025%ZK")
_bnKV = _IHvVl("ay%\023/`")
_Jfx.ZVariables = {
  _ETV = _IHvVl("\006I"),
  _5MQtS = _IHvVl("r\025$r"),
  _hvqR8 = _IHvVl("4cP"),
  _D6Hq = _IHvVl("W"),
  _gFx9M = _IHvVl("'2"),
  _cQ5y = _IHvVl("--"),
  _8Kkn = _IHvVl("\\v"),
  _P2y = _IHvVl("2\028`W"),
  _ALGX = _IHvVl("-2"),
  _0T4ed = _IHvVl("D"),
  _Oqsy = _IHvVl("D\\"),
  _y2s = false,
  _OOZ = false,
  _GyRH = false,
  _xZeiV = false,
  _G0Lp = false,
  _VjL1 = false,
  _9Qs = _IHvVl("Pc4PM4"),
  _03ZIq = false,
  _WWequ = false,
  _mjR = false,
  _tGG = false,
  _3pXLP = false,
  _Ec_B = false,
  _SyVV = false,
  __G33 = false,
  _V6u7 = _IHvVl("\031rP\025rP\025$Kx"),
  _Ja5K = false,
  _CkB6T = false,
  _n55 = false,
  _UWNT = false,
  _4Czl = false,
  _YOP = false,
  _hvD = false,
  _sYDiA = false,
  _gI91b = false,
  _WM0C = false,
  _0rMtD = false,
  _MTu = false,
  _ZFpYy = false,
  _IMf7 = false,
  _w4Nd = false,
  _MyTEl = false,
  _mrid = false,
  _wZR3z = false,
  _2rc = false,
  _cN2oa = _IHvVl("a>(-y"),
  _HuMz_ = _IHvVl("a/\025/Ic"),
  _IFo = _IHvVl("a\006M\016Iy"),
  _2Sjt9 = _IHvVl("a?\017\026;"),
  _uUlX = _IHvVl("a\025%ZK"),
  _bnKV = _IHvVl("ay%\023/`")
}
_plXQ8 = Wherigo.ZTimer(_Jfx)
_plXQ8.Id = "efe5de39-415a-4d27-a58b-bbbe5388b400"
_plXQ8.Name = _IHvVl("W5\025>9~$\rI5")
_plXQ8.Description = ""
_plXQ8.Visible = true
_plXQ8.Duration = 4
_plXQ8.Type = "Countdown"
_P3hr = Wherigo.ZTimer(_Jfx)
_P3hr.Id = "2aae367c-8fa6-441f-8c87-4cb4626b9ee9"
_P3hr.Name = _IHvVl("W5\025>a~$\rI5")
_P3hr.Description = ""
_P3hr.Visible = true
_P3hr.Duration = 4
_P3hr.Type = "Countdown"
_OAp = Wherigo.ZTimer(_Jfx)
_OAp.Id = "d2eb2940-fe72-49df-bcdf-da9408f9ec0c"
_OAp.Name = _IHvVl("'5\025>a;IM\020\0254P4Ir>")
_OAp.Description = ""
_OAp.Visible = true
_OAp.Duration = 7
_OAp.Type = "Countdown"
_hUV = Wherigo.ZTimer(_Jfx)
_hUV.Id = "41476e19-d91e-4a6f-8d5c-557391400e93"
_hUV.Name = _IHvVl("?$r,\025$5")
_hUV.Description = ""
_hUV.Visible = true
_hUV.Duration = 4
_hUV.Type = "Interval"
_elqc = Wherigo.ZInput(_Jfx)
_elqc.Id = "88fe91ef-282d-4d94-9d46-53ef51268c0b"
_elqc.Name = _IHvVl("#$5P\022\rM\022\025$r\022<4\025Mr\r\022\004I4\127Io\025%53\022:\006I\022^r\025$rE")
_elqc.Description = ""
_elqc.Visible = true
_elqc.Media = _PJaK
_elqc.Choices = {
  "Aber sicher!",
  "Keines Falls!"
}
_elqc.InputType = "MultipleChoice"
_elqc.Text = _IHvVl("#$5P\022\rM\022\025$r\022<4\025Mr\r\022\004I4\127Io\025%53")
_tgco = Wherigo.ZInput(_Jfx)
_tgco.Id = "41f8ccf2-96d0-4730-b6ab-8097430d21a8"
_tgco.Name = _IHvVl("?\025\016P$\0229\022<4I\127\025\0222")
_tgco.Description = ""
_tgco.Visible = true
_tgco.Media = _PJaK
_tgco.InputType = "Text"
_tgco.Text = _IHvVl("0\015\025%Kx\025\022<I4\020\025\022xIP\022\r$\025\022~M\025P;\025\022@cr\022)IyI\022jKx%Moy\01630")
_Cjvx = Wherigo.ZInput(_Jfx)
_Cjvx.Id = "d97f1f9e-23aa-4130-87f4-f29c646ad212"
_Cjvx.Name = _IHvVl("?\025\016P$\0229\022<4I\127\025\022-")
_Cjvx.Description = ""
_Cjvx.Visible = false
_Cjvx.Media = _PJaK
_Cjvx.InputType = "Text"
_Cjvx.Text = _IHvVl("0\015$\025\022@$\025%\025\022>%\025$r\025\022jKx%Moy\016%$r\127\025\022%\025\020\025r\022x$\0254\022$r\022Mr5\0254\025o\022\021c4\01630\022:z$\016\016\0254E")
_ou6D = Wherigo.ZInput(_Jfx)
_ou6D.Id = "bdd35d10-d43d-4a86-8418-e6e1dff3ebfc"
_ou6D.Name = _IHvVl("?\025\016P$\0229\022<4I\127\025\022D")
_ou6D.Description = ""
_ou6D.Visible = false
_ou6D.Media = _PJaK
_ou6D.InputType = "Text"
_ou6D.Text = _IHvVl("0\015$\025\022@$\025%\025\022\fM\f\022\0204$r\127\025\022$Kx\022IM\016\022\r$\025\022\015II\127\02530\022:\127\0254Mr\r\025PE")
_LHx = Wherigo.ZInput(_Jfx)
_LHx.Id = "ee32c753-9c80-4d3b-8a6a-7c61f3b831ba"
_LHx.Name = _IHvVl("wx4")
_LHx.Description = ""
_LHx.Visible = true
_LHx.Media = _zIHG
_LHx.InputType = "Text"
_LHx.Text = _IHvVl("\021\0254\022jPMr\r\025r;\025$\127\0254\022\025$r\0254\022wx4\022\r4\025xP\022Ir\022\025$r\025o\022(I\127\022\127\025rIM\022;,\025$\022BMr\r\025rC\022\014\020\0254\022,$\025\022c\016P\022$5P\022\0254\022\rI\020\025$\022\127\025rIM\022MrP\0254\022\r\025o\022~$rMP\025r;\025$\127\02543")
_biQ3 = Wherigo.ZInput(_Jfx)
_biQ3.Id = "1e4bc7de-1e61-48cf-a3da-61597b27e805"
_biQ3.Name = _IHvVl("\017IKx\025")
_biQ3.Description = ""
_biQ3.Visible = true
_biQ3.Media = _zIHG
_biQ3.InputType = "Text"
_biQ3.Text = _IHvVl("\tr\022,$\025\022@$\025%\025r\022MrP\02545Kx$\025\r%$Kx\025r\022B\025$x\025r\016c%\127\025r\022>Irr\022oIr\022\r$\025\022#MKx5PI\020\025r\022@cr\022\017\014\017?\031\0225Kx4\025$\020\025r3")
_FmB = Wherigo.ZInput(_Jfx)
_FmB.Id = "2b54dd15-6ae8-49bd-ab0c-0d7cdc25fc73"
_FmB.Name = _IHvVl("Fc4\r9\n5P")
_FmB.Description = ""
_FmB.Visible = true
_FmB.Media = _zIHG
_FmB.InputType = "Text"
_FmB.Text = _IHvVl("\004$\020\022\r$\025\022\127\025\016Mr\r\025r\025\022zIx%\022\025$rC")
_b5nsD = Wherigo.ZInput(_Jfx)
_b5nsD.Id = "c43e4313-fc27-4ba3-8bf1-98c73a103c10"
_b5nsD.Name = _IHvVl("#IM\0254")
_b5nsD.Description = ""
_b5nsD.Visible = true
_b5nsD.Media = _zIHG
_b5nsD.InputType = "Text"
_b5nsD.Text = _IHvVl("?$rP\0254o\022\015I%\r\022,cxrP\022\025$r\022#IM\0254|\022\r\0254\022xIP\022'\022\0314rP\025oI5Kx$r\025r|\022\025$r\022\1274c55\0255\022\0044Mr\r5PM\025K>|\022@$\025%\022\004\025%\r\022Mr\r\022@$\025%\025\022?\025%\016\0254C\022\021$\025\022'\022\0314rP\025oI5Kx$r\025r\022\0204IMKx\025r\022u-\022jPMr\r\025r\022Mo\022\rI5\022\0044Mr\r5PM\025K>\022>coy%\025PP\022I\020;M\0254rP\025rC\022\0314\022,$%%\022\0255\022I\020\0254\022$r\0222D\022jPMr\r\025r\0225KxI\016\016\025rC\022\015$\025\022@$\025%\025\022\0314rP\025oI5Kx$r\025r\022oM55\022\0254\022rcKx\022>IM\016\025r3")
_CWm = Wherigo.ZInput(_Jfx)
_CWm.Id = "f3cb7ed9-986f-4e6e-ac3c-0cfd0b667ca1"
_CWm.Name = _IHvVl("\004c%\r9\"$P\0254")
_CWm.Description = ""
_CWm.Visible = true
_CWm.Media = _Pg3e
_CWm.InputType = "Text"
_CWm.Text = _IHvVl("0UM\0254;%$Kx\022xI\020\025\022$Kx\022\025$r\022u'|\028>\127\0225Kx,\0254\0255\022jKx,\0254P\022IM5\022yM4\025o\022\004c%\r\022\127\025\016Mr\r\025r\022Mr\r\022\0255\022;Mo\022B\025$r$\127\025r\022$r\022-v\022\0044I\r\022\017\025%5$M5\022>I%P\0255\022\015I55\0254\022\127\025%\025\127PC\022\015$\025\022@$\025%\025\022\"$P\0254\022\015I55\0254\022,M4\r\025r\022\rI\020\025$\022@\0254\r4I\025r\127P30\022:\127\0254Mr\r\025PE")
_snYls = Wherigo.ZInput(_Jfx)
_snYls.Id = "e49394ef-60bb-4e46-8956-997ff5580498"
_snYls.Name = _IHvVl(")I%%I\r$Mo")
_snYls.Description = ""
_snYls.Visible = true
_snYls.Media = _Pg3e
_snYls.InputType = "Text"
_snYls.Text = _IHvVl("0\n>IO\022o\025$r\022<4\025Mr\rC\022\015$\025\022@$\025%\025\022U$%c\1274Ioo\022oM\02555P\025\022\025$r\022U%Moy\025r\022)I%%I\r$Mo\022,$\025\127\025r|\022Mo\022\r$\0255\025%\020\025\022~\025r\127\025\022\015I55\0254\022;M\022@\0254\r4I\025r\127\025r30")
_49s = Wherigo.ZInput(_Jfx)
_49s.Id = "be62af00-0493-413e-a828-041a0253e253"
_49s.Name = _IHvVl("\017c\r\025\022\025$r\127\025\020\025r")
_49s.Description = ""
_49s.Visible = false
_49s.InputType = "Text"
_49s.Text = _IHvVl("#$PP\025\022\127$\020\022\rI5\022\017c\r,c4P\022;Mo\022\n\025\016\016r\025r\022\r\0255\022jKx%c55\0255\022\025$rC")
_sOM = Wherigo.ZInput(_Jfx)
_sOM.Id = "258ce5b5-9862-44be-815e-dcf15149e19d"
_sOM.Name = _IHvVl("jKx%IM\020$9?$%\016\0259jPM\016\025a-a2")
_sOM.Description = ""
_sOM.Visible = true
_sOM.Media = _Va5Vc
_sOM.Choices = {
  "Ja, jetzt hab ich es!",
  "Bitte hilf mir - ich bin zu dumm!"
}
_sOM.InputType = "MultipleChoice"
_sOM.Text = _IHvVl("0FI\022,$\025\0225KxIMP\022\0255\022IM53\022Ucoo5P\022\rM\0225\025%\0205P\022IM\016\022\r$\025\022\"c\0255Mr\127|\022c\r\0254\022oM55\022$Kx\022\r$4\022,\025$P\0254\022x\025%\016\025r3\022#\025\r\025r>\025|\022\rI\rM4Kx\0224\025\rM;$\0254P\0225$Kx\022I\020\0254\022\r$\025\022\0219\015\0254PMr\127\022Mo\022\025$r\025r\022xI%\020\025r\022)Mr>P.0")
_fUpNo = Wherigo.ZInput(_Jfx)
_fUpNo.Id = "079002ea-fb30-4f9c-83f2-a5d9e36b8d0e"
_fUpNo.Name = _IHvVl("jKx%IM\020$9?$%\016\0259jPM\016\025a-aD")
_fUpNo.Description = ""
_fUpNo.Visible = true
_fUpNo.Media = _Va5Vc
_fUpNo.Choices = {
  "Ja, jetzt hab ich es!",
  "Bitte hilf mir - ich bin zu dumm!"
}
_fUpNo.InputType = "MultipleChoice"
_fUpNo.Text = _IHvVl("0FI\022,$\025\0225KxIMP\022\0255\022IM53\022Ucoo5P\022\rM\0225\025%\0205P\022IM\016\022\r$\025\022\"c\0255Mr\127|\022c\r\0254\022oM55\022$Kx\022\r$4\022,\025$P\0254\022x\025%\016\025r3\022#\025\r\025r>\025|\022\rI\rM4Kx\0224\025\rM;$\0254P\0225$Kx\022I\020\0254\022\r$\025\022\0219\015\0254PMr\127\022Mo\022\025$r\025r\022xI%\020\025r\022)Mr>P.0")
_Tsbxu = Wherigo.ZInput(_Jfx)
_Tsbxu.Id = "3cfcfd81-b096-4b1a-8972-78c54c39bb0f"
_Tsbxu.Name = _IHvVl("jKx%IM\020$9?$%\016\0259jPM\016\025a-aW")
_Tsbxu.Description = ""
_Tsbxu.Visible = true
_Tsbxu.Media = _Va5Vc
_Tsbxu.Choices = {
  "Ja, jetzt hab ich es!",
  "Bitte hilf mir - ich bin zu dumm!"
}
_Tsbxu.InputType = "MultipleChoice"
_Tsbxu.Text = _IHvVl("0FI\022,$\025\0225KxIMP\022\0255\022IM53\022Ucoo5P\022\rM\0225\025%\0205P\022IM\016\022\r$\025\022\"c\0255Mr\127|\022c\r\0254\022oM55\022$Kx\022\r$4\022,\025$P\0254\022x\025%\016\025r3\022#\025\r\025r>\025|\022\rI\rM4Kx\0224\025\rM;$\0254P\0225$Kx\022I\020\0254\022\r$\025\022\0219\015\0254PMr\127\022Mo\022\025$r\025r\022xI%\020\025r\022)Mr>P.0")
_B82T = Wherigo.ZInput(_Jfx)
_B82T.Id = "3fa3c687-75c9-46e3-bee5-ff502ad08715"
_B82T.Name = _IHvVl("jKx%IM\020$9?$%\016\0259jPM\016\025a-au")
_B82T.Description = ""
_B82T.Visible = true
_B82T.Media = _Va5Vc
_B82T.Choices = {
  "Ja, jetzt hab ich es!",
  "Bitte hilf mir - ich bin zu dumm!"
}
_B82T.InputType = "MultipleChoice"
_B82T.Text = _IHvVl("0FI\022,$\025\0225KxIMP\022\0255\022IM53\022Ucoo5P\022\rM\0225\025%\0205P\022IM\016\022\r$\025\022\"c\0255Mr\127|\022c\r\0254\022oM55\022$Kx\022\r$4\022,\025$P\0254\022x\025%\016\025r3\022#\025\r\025r>\025|\022\rI\rM4Kx\0224\025\rM;$\0254P\0225$Kx\022I\020\0254\022\r$\025\022\0219\015\0254PMr\127\022Mo\022\025$r\025r\022xI%\020\025r\022)Mr>P.0")
_vyK = Wherigo.ZInput(_Jfx)
_vyK.Id = "dbcc217a-aff1-41f7-91cf-e4158f5fef3f"
_vyK.Name = _IHvVl("jKx%IM\020$9?$%\016\0259jPM\016\025a-a\\")
_vyK.Description = ""
_vyK.Visible = true
_vyK.Media = _Va5Vc
_vyK.Choices = {
  "Ja, jetzt hab ich es!",
  "Bitte hilf mir - ich bin zu dumm!"
}
_vyK.InputType = "MultipleChoice"
_vyK.Text = _IHvVl("0FI\022,$\025\0225KxIMP\022\0255\022IM53\022Ucoo5P\022\rM\0225\025%\0205P\022IM\016\022\r$\025\022\"c\0255Mr\127|\022c\r\0254\022oM55\022$Kx\022\r$4\022,\025$P\0254\022x\025%\016\025r3\022#\025\r\025r>\025|\022\rI\rM4Kx\0224\025\rM;$\0254P\0225$Kx\022I\020\0254\022\r$\025\022\0219\015\0254PMr\127\022Mo\022\025$r\025r\022xI%\020\025r\022)Mr>P.0")
_Bn9 = Wherigo.ZInput(_Jfx)
_Bn9.Id = "0e5b95ac-5588-451b-9cf9-cb1c121817a2"
_Bn9.Name = _IHvVl(")I55,c4PajPI4P")
_Bn9.Description = ""
_Bn9.Visible = true
_Bn9.InputType = "Text"
_Bn9.Text = _IHvVl("wo\022\r$\0255\025r\022\015x\0254$\127c\022;M\0225PI4P\025r|\022oM55P\022\rM\022\r\025r\022\017IKx\025\0220\031rP\025\022\127MP\0229\022I%%\0255\022\127MP30\022\127\025\016Mr\r\025r\022xI\020\025rC\022\021I4$r\022\025rPxI%P\025r\022,I4\022\rI5\022)I55,c4P\022;Mo\022jPI4PC\022\004$\020\022\r$\0255\0255\022\025$r\022Mr\r\0225Kxcr\022>Irr\022\0255\022%c5\127\025x\025rC")
function _Jfx:OnStart()
  if _G[_IHvVl("\031r@")][_IHvVl(")%IP\016c4o")] == _IHvVl("\015$rD-") or _G[_IHvVl("\031r@")][_IHvVl("\021\025@$K\025\t\021")] == _IHvVl("\021\0255>Pcy") then
    for k, v in pairs(_G[_IHvVl("a\026\016t")][_IHvVl("\014%%z\n\020\006\025KP5")]) do
      v[_IHvVl("\019$5$\020%\025")] = false
      v[_IHvVl("\014KP$@\025")] = false
    end
    _G[_IHvVl("\015x\0254$\127c")][_IHvVl("\017cooIr\r")](_IHvVl("jI@\025\017%c5\025"))
    return
  end
  _Jfx.Complete = false
  if _G[_IHvVl("\031r@")][_IHvVl("\021\025@$K\025\t\021")] == _IHvVl("\021\0255>Pcy") or _G[_IHvVl("\031r@")][_IHvVl(")%IP\016c4o")] == _IHvVl("\015$rD-") then
    _Urwigo.MessageBox({
      Text = _IHvVl("jc\022\025$r\016IKx\022\127\025xP?5\022\rIrr\022\rcKx\022r$KxPC\022"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.Command("SaveClose")
        end
      end
    })
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_Bn9)
    end)
  end
end
function _Jfx:OnRestore()
end
function _kT2p:On_gklS(target)
  _cN2oa = _IHvVl("a>(-y")
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_FmB)
  end)
end
function _kT2p:OnEnter()
  _cN2oa = _IHvVl("a>(-y")
  _hUV:Start()
  if _WM0C == true then
    _hUV:Stop()
    _QeQao.Visible = true
    _mz3.Commands._FSbT.Enabled = true
    _DhVS.Visible = false
    _DhVS.Active = false
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225P\025x5P\022Ir\022\r\0254\022I%P\025r\022\031$Kx\025\022Mr\r\0225$\025x5P\022xcKx\022c\020\025r\022IM\016\022\025$r\025o\022\0145P\022\r$\025\022,\025$5\025\022\031M%\025C"),
      Media = _Ecqq2,
      Callback = function(action)
        if action ~= nil then
          _QeQao.Visible = true
          _hUV:Stop()
          _WM0C = true
          _mz3.Commands._FSbT.Enabled = true
          _DhVS.Visible = false
          _DhVS.Active = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _kT2p:OnExit()
  _cN2oa = _IHvVl("a>(-y")
  _hUV:Stop()
  _mz3.Commands._FSbT.Enabled = false
  _QeQao.Visible = false
end
function _xGn:OnEnter()
  _cN2oa = _IHvVl("at\004r")
  _hUV:Start()
  if _VjL1 == true then
    _hUV:Stop()
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif _sYDiA == true then
    _hUV:Stop()
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif _G0Lp == true then
    _1LlI:MoveTo(_xGn)
    _zTN0.Commands._jY3Iq.Enabled = false
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\022\020\025P4$PP5\022\r\025r\022<c%P\0254>\025%%\0254\022Mr\r\022@c4\022\r$4\022PM\0254oP\0225$Kx\022\1274c55\022Mr\r\022\0204\025$P\022\r\0254\022<c%P\0254>r\025KxP\022IM5\022#IO\0254r\022IM\016C"),
      Media = _QZfY4,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _Urwigo.Dialog(false, {
            {
              Text = _IHvVl("0\014Kx\0225$\025x\022oI%\022\025$r\0254\022Ir|\022,\0254\022\rI\022o$P\022\025$r\127\025;c\127\025r\025o\022jKx,Ir;\022,$\025\r\0254\022\rI\022$5P.0"),
              Media = _6ItQ
            },
            {
              Text = _IHvVl("0wr\r\022\019\02545PI\0254>Mr\127\022xI5P\022\rM\022IMKx\022\127%\025$Kx\022o$P\127\025\0204IKxP30"),
              Media = _6ItQ
            },
            {
              Text = _IHvVl("0\015I5\022,$%%5P\022\rM\022rMr\022oIKx\025r|\022xI\02530"),
              Media = _6ItQ
            }
          }, function(action)
            _mz3.Commands._FSbT.Enabled = true
            _NLd.Commands._YoIRQ.Enabled = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end)
        end
      end
    })
  elseif _mrid == true then
    _hUV:Stop()
    _zTN0.Visible = true
    _zTN0.Commands._jY3Iq.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\022\020\025P4$PP5\022\r\025r\022<c%P\0254>\025%%\0254\022Mr\r\022@c4\022\r$4\022PM\0254oP\0225$Kx\022\1274c55\022Mr\r\022\0204\025$P\022\r\0254\022<c%P\0254>r\025KxP\022IM5\022#IO\0254r\022IM\016C"),
      Media = _QZfY4,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _mrid = true
          _zTN0.Visible = true
          _zTN0.Commands._jY3Iq.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _xGn:OnExit()
  _cN2oa = _IHvVl("at\004r")
  _mz3.Commands._FSbT.Enabled = false
  _hUV:Stop()
end
function _W38:OnEnter()
  _cN2oa = _IHvVl("a\015D`")
  _hUV:Start()
  if _w4Nd == true then
    _hUV:Stop()
    _Viv.Active = false
    _sVsg.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225P\025x5P\022rMr\022@c4\022\r\025o\022\1274c55\025r\022~$5P\025%\020IMoC\022\to\022\0145P,\0254>\0225$P;P\022~$4IKM%$tC"),
      Media = _pQ53,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _w4Nd = true
          _Viv.Active = false
          _sVsg.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _W38:OnExit()
  _cN2oa = _IHvVl("a\015D`")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _uzvy:OnEnter()
  _cN2oa = _IHvVl("aM;@O")
  _hUV:Start()
  if _IMf7 == true then
    _hUV:Stop()
    _X6fw.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225P\025x5P\022Io\022<M55\025\022\r\0254\022#4M\025K>\025|\022I%5\022\rM\022\r\025r\022(4c%%\0225$r\127\025r\022xc\02545PC"),
      Media = _XKW5,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _IHvVl("0\004c%\r|\022\006I\022\004c%\r.\022~\025$r\022\004c%\r.\022~\025$r\022jKxIIIIIIIPP;;;;.0"),
            Media = _FhQ,
            Callback = function(action)
              if action ~= nil then
                _hUV:Stop()
                _IMf7 = true
                _X6fw.Visible = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  end
end
function _uzvy:OnExit()
  _cN2oa = _IHvVl("aM;@O")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _Viv:OnEnter()
  _cN2oa = _IHvVl("a\019$@")
  _hUV:Start()
  if (_Ja5K and __G33) == true then
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225P\025x5P\022o$P\022\r\0254\022\020\025;IM\020\0254r\r\025r\022OP4cxj\022Io\022(\025$Kx\022Mr\r\022\020\025c\020IKxP\0255P\022\rI5\022P4IM4$\127\025\022\031rP%\025$rC"),
      Media = _IRE,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _xiom:MoveTo(_Viv)
          _NfDA.Commands._j2aur.Enabled = true
          _R0X.Commands._yL8G.Enabled = true
          _R0X.Commands._hQl.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _MTu == true then
    _hUV:Stop()
    _bhp.Visible = true
    _HCJz.Visible = true
    _HCJz.Active = true
    _R0X.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225P\025x5P\022Io\022\031rP\025rP\025$Kx\022Mr\r\022\020\025P4IKxP\0255P\022\025$r\022\025$r5Io\0255\022\031rPKx\025rC"),
      Media = _IRE,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _MTu = true
          _bhp.Visible = true
          _HCJz.Visible = true
          _HCJz.Active = true
          _R0X.Commands._hQl.Enabled = true
          _R0X.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Viv:OnExit()
  _cN2oa = _IHvVl("a\019$@")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _DhVS:OnEnter()
  _cN2oa = _IHvVl("a\021x\019j")
  _hUV:Start()
  if _gI91b == true then
    _hUV:Stop()
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("jKx%Moy\016$rKx\025r\0224\025rrP\0225Kx4\025$\025r\r\022\rI@cr\002\0220\031$r\022\031$r\r4$r\127%$r\127|\022\025$r\022\031$r\r4$r\127%$r\127.0"),
      Media = _E5Sv5,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _gI91b = true
          _5io.Visible = true
          _Urwigo.MessageBox({
            Text = _IHvVl("?\025<($9jKx%Moy\016\022>cooP\022,M\025P\025r\r\022IM\016\022\r$Kx\022;MC\022\021M\0225c%%P\0255P\022@$\025%%\025$KxP\022o$P\022$xo\0224\025\r\025rC"),
            Media = _PJaK,
            Callback = function(action)
              if action ~= nil then
                _5io.Commands._zTC7p.Enabled = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  end
end
function _DhVS:OnExit()
  _cN2oa = _IHvVl("a\021x\019j")
  _hUV:Stop()
end
function _UqH_:OnEnter()
  _cN2oa = _IHvVl("awZ?a")
  _hUV:Start()
  _Urwigo.MessageBox({
    Text = _IHvVl("\021M\022\020$5P\022rMr\022$r\022\r\0254\022?M\025PP\025\022@cr\022)IyI\022jKx%Moy\016C"),
    Media = _wRfx,
    Callback = function(action)
      if action ~= nil then
        _hUV:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _UqH_:OnExit()
  _cN2oa = _IHvVl("awZ?a")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _GGD:OnEnter()
  _cN2oa = _IHvVl("a\004\004\021")
  _hUV:Start()
  _Urwigo.MessageBox({
    Text = _IHvVl("\019c4\022\r$4\022\020\025\016$r\r\025P\0225$Kx\022\025$r\025\022\1274c55\025\022\015$\0255\025C\022#%Mo\025r\0225y4$\02555\025rC\022UI\025MP\0254\022,IKx5\025r|\022\r$\025\022#$\025r\025r\0225Moo\025rC"),
    Media = _Wo0,
    Callback = function(action)
      if action ~= nil then
        _hUV:Stop()
        _DfhfE.Active = false
        _xGn.Active = false
        _kT2p.Active = false
        _Viv.Active = false
        _UqH_.Active = false
        _GWSA4.Visible = true
        _GWSA4.Active = true
        _PYAh.Visible = true
        _PYAh.Active = true
        _ygb.Visible = true
        _ygb.Active = true
        _6dpA.Active = true
        _6dpA.Visible = true
        _e8v5X.Visible = true
        _e8v5X.Active = true
        _dRaJG.Visible = true
        _dRaJG.Active = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _GGD:OnExit()
  _cN2oa = _IHvVl("a\004\004\021")
  _e8v5X.Active = false
  _GWSA4.Active = false
  _ygb.Active = false
  _PYAh.Active = false
  _dRaJG.Active = false
  _DfhfE.Active = true
  _xGn.Active = true
  _Viv.Active = true
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _PyRp:OnEnter()
  _cN2oa = _IHvVl("a)OBy")
  _hUV:Start()
  if _0rMtD == true then
    _hUV:Stop()
    _mz3.Commands._FSbT.Enabled = true
    _AHHb.Commands._EHS.Enabled = true
    _B5Z4.Commands._WRu.Enabled = true
    _mz3.Commands._O7Dit.Enabled = true
    _8S_S.Commands._Lb2UH.Enabled = true
    _CjIwA.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\022\020\025\016$r\r\0255P\022\r$Kx\022rMr\022$o\022(\025oy\025%\022\r\0255\022~$\rI5C"),
      Media = _t5JO,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _0rMtD = true
          _mz3.Commands._FSbT.Enabled = true
          _AHHb.Commands._EHS.Enabled = true
          _B5Z4.Commands._WRu.Enabled = true
          _mz3.Commands._O7Dit.Enabled = true
          _8S_S.Commands._Lb2UH.Enabled = true
          _CjIwA.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _PyRp:OnExit()
  _cN2oa = _IHvVl("a)OBy")
  _hUV:Stop()
  _AHHb.Commands._EHS.Enabled = false
  _B5Z4.Commands._WRu.Enabled = false
  _mz3.Commands._O7Dit.Enabled = false
  _8S_S.Commands._Lb2UH.Enabled = false
  _mz3.Commands._FSbT.Enabled = false
end
function _9GC:OnEnter()
  _cN2oa = _IHvVl("a\028\004\017")
  _hUV:Start()
  _Urwigo.MessageBox({
    Text = _IHvVl("\021M\0225P\025x5P\022rMr\022Io\022w\016\0254\022\r\0255\0224\025$5\025r\r\025r\022<%M55\0255C\022?$\0254\022\016$r\r\0255P\022\rM\022\020\0255P$ooP\022\025$r\025r\022\1274c55\025r\022jP\025$r|\022\r\025r\022\r$4\022~$\rI5\022$r\022\004c%\r\022@\0254,Ir\r\025%PC"),
    Media = _WqC,
    Callback = function(action)
      if action ~= nil then
        _hUV:Stop()
        _QJNJ_.Commands._lm2Y1.Enabled = true
        _QJNJ_.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _9GC:OnExit()
  _cN2oa = _IHvVl("a\028\004\017")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _g5eMc:OnEnter()
  _cN2oa = _IHvVl("a\127u\025~K")
  _hUV:Start()
  _vbOGH.Visible = true
  if _GyRH or _xZeiV then
    _hUV:Stop()
    _sVsg.Commands._2woZB.Enabled = false
    _sVsg.Commands._syi5.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif _MyTEl == true then
    _hUV:Stop()
    _6dpA.Visible = true
    _6dpA.Active = true
    _W38.Active = false
    _W38.Visible = false
    _GGD.Visible = true
    _GGD.Active = true
    _sVsg.Commands._2woZB.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\022xI5P\0225c\025\020\025r\022\rI5\022\127I%%$5Kx\025\022\021c4\016\022\020\025P4\025P\025rC\022wo\022\r$Kx\022x\0254Mo\022x\025445KxP\022(4M\020\025%\022Mr\r\022$r\022\r\0254\022~$PP\025\022\r\0255\022~I4>Py%IP;\0255\022\025rP\r\025K>5P\022\rM\022\r\025r\022\1274c55\025r\022U\02555\025%C"),
      Media = _de5ix,
      Callback = function(action)
        if action ~= nil then
          _hUV:Stop()
          _MyTEl = true
          _Urwigo.Dialog(false, {
            {
              Text = _IHvVl("0~\025$r\022\026Mr\127\025|\022\rI\022\016I\025%%P\022o$4\022\025$r|\022\rI55\022$Kx\022;,I4\022\025\020\025r\022\r$\025\022~$5P\025%r\022\127\0255Kxr$PP\025r\022xI\020\025CCC\022\014\020\0254\022$Kx\022\0204IMKx\025\022rcKx\022\025$r\022yII4\022Ir\r\0254\025\022U4I\025MP\0254C0"),
              Media = _mNiN
            },
            {
              Text = _IHvVl("0j\025$\022\rcKx\0225c\022\127MP|\022Mr\r\022\020\0255c4\127\025\022o$4\022rcKx\022#%MP,M4;\022Mr\r\022<$r\127\0254>4IMPC\022\021M\0225c%%P\0255P\022\020\025$\r\0255\022IM\016\022\r\0254\022\1274c55\025r\022\015$\0255\025\022@c4\022Mr5\0254\025o\022\021c4\016\022\016$r\r\025rC0"),
              Media = _mNiN
            },
            {
              Text = _IHvVl("0\021\025r\022\015\025\127\022IM5\022\r\025o\022\021c4\016\022>\025rr5P\022\rM\022\006IC\022FMP;\025\022$xr\022\020$PP\025\022IMKx.0"),
              Media = _mNiN
            }
          }, function(action)
            _6dpA.Visible = true
            _6dpA.Active = true
            _W38.Active = false
            _W38.Visible = false
            _GGD.Visible = true
            _GGD.Active = true
            _sVsg.Commands._2woZB.Enabled = true
            _hvD = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end)
        end
      end
    })
  end
end
function _g5eMc:OnExit()
  _cN2oa = _IHvVl("a\127u\025~K")
  _hUV:Stop()
  if _G0Lp == true then
    _1LlI:MoveTo(Player)
  else
  end
  _Viv.Active = true
  _iyQKG.Commands._VCGb.Enabled = false
  _TC9.Commands._or6e.Enabled = false
  _ae1.Commands._Vao.Enabled = false
  _VMl.Commands._2nRJn.Enabled = false
  _R42.Commands._2OS.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _DfhfE:OnEnter()
  _cN2oa = _IHvVl("a\021\016x\016\031")
  _hUV:Start()
  if _hvD == false then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("0\n>IO|\022\006\025P;P\022\016c%\127\025\022o$4\022\025$r\016IKx\022,\025$P\0254\022rIKx\022jM\025\r\025rC0"),
        Media = _mNiN
      }
    }, function(action)
      _hUV:Stop()
      _g5eMc.Visible = true
      _W38.Visible = false
      _W38.Active = false
      _sVsg:MoveTo(_g5eMc)
      _g5eMc.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _hUV:Stop()
  end
end
function _DfhfE:OnExit()
  _cN2oa = _IHvVl("a\021\016x\016\031")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _e8v5X:OnEnter()
  _cN2oa = _IHvVl("a\025`@u\023")
  _VMl.Visible = true
end
function _e8v5X:OnExit()
  _cN2oa = _IHvVl("a\025`@u\023")
  _VMl.Visible = true
end
function _GWSA4:OnEnter()
  _cN2oa = _IHvVl("a\004\015j\014W")
  _R42.Visible = true
end
function _GWSA4:OnExit()
  _cN2oa = _IHvVl("a\004\015j\014W")
  _R42.Visible = true
end
function _dRaJG:OnEnter()
  _cN2oa = _IHvVl("a\rBI\026\004")
  _TC9.Visible = true
end
function _dRaJG:OnExit()
  _cN2oa = _IHvVl("a\rBI\026\004")
  _TC9.Visible = true
end
function _ygb:OnEnter()
  _cN2oa = _IHvVl("aO\127\020")
  _ae1.Visible = true
end
function _ygb:OnExit()
  _cN2oa = _IHvVl("aO\127\020")
  _ae1.Visible = true
end
function _PYAh:OnEnter()
  _cN2oa = _IHvVl("a)\v\014x")
  _iyQKG.Visible = true
end
function _PYAh:OnExit()
  _cN2oa = _IHvVl("a)\v\014x")
  _iyQKG.Visible = true
end
function _VGe:OnEnter()
  _cN2oa = _IHvVl("a\019\004\025")
  _hUV:Start()
  _Urwigo.MessageBox({
    Text = _IHvVl("\021M\022\020$5P\022\006\025P;P\022$o\022<$rI%\127\025\020$\025PC\022<$r\r\025\022\r\025r\022jKxIP;."),
    Media = _kJnO,
    Callback = function(action)
      if action ~= nil then
        _hUV:Stop()
        _xiom:MoveTo(_VGe)
        _xiom.Commands._zdtqu.Enabled = false
        _RHskH.Active = true
        _RHskH.Visible = true
        _Jfx.Complete = true
        _QiH6.Commands._0v4N8.Enabled = true
        _QiH6.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _VGe:OnExit()
  _cN2oa = _IHvVl("a\019\004\025")
  _hUV:Stop()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _A_OK:OnEnter()
  _cN2oa = _IHvVl("a\014a\nU")
  _hUV:Start()
  if _WM0C == true then
    _hUV:Stop()
    _QeQao.Visible = true
    _mz3.Commands._FSbT.Enabled = true
    _DhVS.Visible = false
    _DhVS.Active = false
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225P\025x5P\022Ir\022\r\0254\022I%P\025r\022\031$Kx\025\022Mr\r\0225$\025x5P\022xcKx\022c\020\025r\022IM\016\022\025$r\025o\022\0145P\022\r$\025\022,\025$5\025\022\031M%\025C"),
      Media = _Ecqq2,
      Callback = function(action)
        if action ~= nil then
          _QeQao.Visible = true
          _hUV:Stop()
          _WM0C = true
          _mz3.Commands._FSbT.Enabled = true
          _DhVS.Visible = false
          _DhVS.Active = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _A_OK:OnExit()
  _cN2oa = _IHvVl("a\014a\nU")
  _hUV:Stop()
  if _2rc == true then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("jc|\022\rI\022\rM\022o\025$r\022r\025M\0255\022zMxIM5\025\022rMr\022\025rP\r\025K>P\022xI5P|\022\016%$\025\127\025\022$Kx\022\006\025P;P\022oI%\022;M\022o\025$r\025o\022I%P\025r\022\"$\025\020%$r\1275\020IMoC"),
        Media = _zIHG
      },
      {
        Text = _IHvVl("\021\0254\022$5P\022@c4\022\014%P\025455Kx,I\025Kx\025\022;M5Ioo\025r\127\025\0204cKx\025r|\022I\020\0254\022\r\025r\022oI\127\022$Kx\022\025$\127\025rP%$Kx\022@$\025%\022%$\025\020\0254\0229\022Mr\r\022\020\02555\0254\022;M\127I\025r\127%$Kx\022$5P\022\0254\022IMKxC"),
        Media = _zIHG
      }
    }, function(action)
      _kT2p.Visible = true
      _kT2p.Active = true
      _vwn_.Active = false
      _QeQao:MoveTo(_kT2p)
      _A_OK.Active = false
      _mz3.Commands._FSbT.Enabled = false
      _QeQao.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("\021M\022xI5P\022,cx%\022>\025$r\025\022\"M5P\022o\025x43\022FI\022\rM\022,$45P\0225Kxcr\022,$\025\r\0254\022>coo\025r."),
        Media = _zIHG
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _vwn_:OnEnter()
  _cN2oa = _IHvVl("a@,ra")
  _Urwigo.MessageBox({
    Text = _IHvVl("wo\022\r$\025\022FIPM4\022;M\0225Kxcr\025r|\022,I\025x%\025\022\020$PP\025\022\r\025r\022zM\127Ir\127\022@cr\022Fc4\rc5P\025rC"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _elqc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 50847 then
    _5io.Commands._zTC7p.Enabled = false
    _5io.Commands._LgW.Enabled = true
    _tgco.Visible = true
    _Urwigo.MessageBox({
      Text = _IHvVl("\021Irr\022\020$5P\022\rM\022,$%%>coo\025r|\0225c\016\0254r\022\rM\022o$4\022\r4\025$\022<4I\127\025r\022\020\025IrP,c4P\025r\022>Irr5PC"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_tgco)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021Irr\022@\02545Kx,$r\r\025\022\rM\022jIM>\0254%|\0225cr5P\022,\0254\r\025\022$Kx\022\r$Kx\022@\0254y4M\025\127\025%r."),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _5io.Commands._zTC7p.Enabled = true
          _5io.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _tgco:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_hvqR8, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("j\025x4\022\127MPC\022FMr\022\020\025IrP,c4P\025\022o$4\022\r$\025\022;,\025$P\025\022<4I\127\025C"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _5io.Commands._LgW.Enabled = false
          _5io.Commands._IagfL.Enabled = true
          _Cjvx.Visible = true
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_Cjvx)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\"\025$\r\0254\022\016I%5Kx|\022y4c\020$\0254\025\022\0255\022rcKx\022oI%C"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _tgco.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Cjvx:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_D6Hq, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("B$KxP$\127|\022I\020\0254\022\025$r\025\022<4I\127\025\022>cooP\022rcKxC"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _5io.Commands._5Hb.Enabled = true
          _5io.Commands._IagfL.Enabled = false
          _ou6D.Visible = true
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_ou6D)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\"\025$\r\0254\022\016I%5Kx|\022y4c\020$\0254\025\022\0255\022rcKx\022oI%C"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _Cjvx.Visible = true
        end
      end
    })
  end
end
function _ou6D:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_gFx9M, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("?\0254;%$Kx\022,$%%>coo\025r|\022<4\025Mr\r.\022\021M\0225MKx5P\022\r$\025\022\020\025;IM\020\0254r\r\025\022OP4cxj3\022\tKx\022xI\020\025\0225$\025\022%\025$\r\0254\022r$KxP\022\127\0255\025x\025r|\022I\020\0254\022@$\025%%\025$KxP\022>Irr\022\r$4\022)IyI\022jKx%Moy\016\022x\025%\016\025rC\022\004\025x\025\022\rcKx\022;M\0225\025$r\0254\022?M\025PP\025C]#BQ"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _UqH_.Visible = true
          _UqH_.Active = true
          _5io.Commands._5Hb.Enabled = false
          _rv4.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\"\025$\r\0254\022\016I%5Kx|\022y4c\020$\0254\025\022\0255\022rcKx\022oI%C"),
      Media = _PJaK,
      Callback = function(action)
        if action ~= nil then
          _ou6D.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _LHx:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_cQ5y, input) then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("#4I@c.\022\n>IO|\022$Kx\022,\0254\r\025\022\r$4\022\025$r\025r\022($yy\022\127\025\020\025r|\022,$\025\022\rM\022;,I4\022r$KxP\022\1274c\02555\0254|\022I\020\0254\022;Mo$r\r\0255P\0225PI\0254>\0254\022,$45PC"),
        Media = _zIHG
      },
      {
        Text = _IHvVl("\tr\022\r\0254\022FI\025x\025\022$5P\022\rI5\022\021c4\016\022\r\0254\022\004I%%$\0254C\022jMKx\025\022~$4IKM%$t\022IM\016\0225\025$r\025o\022~$5P\025%\020IMo|\022@$\025%%\025$KxP\022\0204IMP\022\0254\022\r$4\022\025$r\025r\022zIM\020\0254P4Ir>C"),
        Media = _zIHG
      },
      {
        Text = _IHvVl("jc%%P\0255P\022\rM\022rcKx\022\025$roI%\022o\025$r\025\022?$%\016\025\022\020\025rc\025P$\127\025r|\022\rIrr\022>Irr5P\022\rM\022\006\025\r\0254\022z\025$P\022,$\025\r\0254\022>coo\025rC"),
        Media = _zIHG
      }
    }, function(action)
      _W38.Active = true
      _W38.Visible = true
      _sVsg.Visible = true
      _QeQao.Commands._AgJnk.Enabled = false
      _sVsg.Commands._XOiNU.Enabled = true
      _mjR = false
      _n55 = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\"\025$\r\0254\022\016I%5Kx|\022y4c\020$\0254\025\022\0255\022rcKx\022oI%C"),
      Media = _zIHG,
      Callback = function(action)
        if action ~= nil then
          _mjR = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _biQ3:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_8Kkn, input) then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("j\025x4\022\127MP|\022o\025$r\0225Kx%IM\0254\022<4\025Mr\rCCC\022<M\0254\022\r\025$r\025\022\0144\020\025$P\0225c%%5P\022\rM\022rMr\022\020\025%cxrP\022,\0254\r\025rC"),
        Media = _zIHG
      },
      {
        Text = _IHvVl("U%\025PP\0254\025\022;M\022o$4\022IM\016\022\r\025r\022#IMo|\022$Kx\022xI\020\025\022x$\0254\022\r$\025\022Ucc4\r$rIP\025r\022@co\022\019\02545P\025K>\022\r\0255\022<c%P\0254>r\025KxP\0255\022Ir\127\025\0204IKxPC\022\004$\020\022\r$\025\022zIx%\022\025$r|\022Mr\r\022\r\0254\022\015\025\127\022,$4\r\0225$Kx\022\r$4\022,\025$5\025rC"),
        Media = _zIHG
      }
    }, function(action)
      _QeQao.Commands._SxQTs.Enabled = false
      _QeQao.Commands._EQUW.Enabled = true
      _FmB.Visible = true
      _QeQao.Commands._vW6K.Enabled = false
      _03ZIq = false
      _CkB6T = false
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_FmB)
      end)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("?$\0254\022oM55P\022\rM\022%\025$\r\0254\022rcKx\022\025$roI%\022M\025\020\0254%\025\127\025rC\022Ucoo\022,$\025\r\0254|\022,\025rr\022\rM\022\r$\025\022\"c\0255Mr\127\022,\025$55PC"),
      Media = _zIHG,
      Callback = function(action)
        if action ~= nil then
          _03ZIq = true
          _QeQao.Commands._vW6K.Enabled = false
          _QeQao.Commands._SxQTs.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _mz3.Commands._FSbT.Enabled = true
end
function _FmB:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_P2y, input) then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("FMr\022>\025rr5P\022\rM\022\r\025r\022\015\025\127\022;Mo\022\019\02545P\025K>\022@co\022<c%P\0254>r\025KxP\022IM5\022#IO\0254rC\022jc%%P\0255P\022\rM\022rcKx\022\025$roI%\022o\025$r\025\022?$%\016\025\022\020\025rc\025P$\127\025r|\0225c\022>coo\025\022\127\0254r\022,$\025\r\0254C"),
        Media = _zIHG
      }
    }, function(action)
      _xGn.Visible = true
      _kT2p.Commands._gklS.Enabled = false
      _FmB.Visible = false
      _QeQao.Commands._EQUW.Enabled = false
      _xGn.Active = true
      _QeQao.Commands._vW6K.Enabled = false
      _WWequ = false
      _2rc = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021I\022xI5P\022\rM\022,cx%\022\016I%5Kx\022I\020\127\025%\0255\025rC"),
      Media = _zIHG,
      Callback = function(action)
        if action ~= nil then
          _QeQao.Commands._vW6K.Enabled = false
          _FmB.Visible = true
          _WWequ = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _b5nsD:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_ALGX, input) then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("FI\127MPC\022\021I5\022%I55\025\022$Kx\022\127\025%P\025rC\022"),
        Media = _zIHG
      },
      {
        Text = _IHvVl("\tKx\022\r\025r>\025|\022~$\rI5\022>Irr\022\r$4\022x\025%\016\025rC\022jMKx\025\022$xr\022$r\0225\025$r\025o\022(\025oy\025%\022IM\016C"),
        Media = _zIHG
      }
    }, function(action)
      _CjIwA.Commands._UQ_N9.Enabled = true
      _PyRp.Visible = true
      _PyRp.Active = true
      _QeQao.Commands._yhvr_.Enabled = false
      _QeQao.Commands._lJ4_M.Enabled = false
      _tGG = false
      _UWNT = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("?I.\022<I%5Kx\022\rM\022\021Moo>cy\016.\022Ucoo\022,$\025\r\0254|\022,\025rr\022\rM\0225Kx%IM\0254\022\020$5P."),
      Media = _zIHG,
      Callback = function(action)
        if action ~= nil then
          _tGG = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _CWm:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_0T4ed, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("0\n>IO|\022\rM\022xI5P\022\r\025$r\025\022)4M\025\016Mr\127\022\020\0255PIr\r\025rC\022FMr\022,$%%\022$Kx\022\r$4\022\025$r\025r\022\004\025\127\025r5PIr\r\022\r\025$r\0254\022\015Ix%\022$r\022\004c%\r\022@\0254,Ir\r\025%rC\022B\025$Kx\025\022o$4|\022,I5\022$oo\0254\022\rM\022xI5PC0]#BQ"),
      Media = _Pg3e,
      Callback = function(action)
        if action ~= nil then
          _CjIwA.Commands._n_qZ6.Enabled = false
          _bhp.Commands._tyLE.Enabled = true
          _Ec_B = false
          _4Czl = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0<\014\"j\017?.\022\021M\022\020$5P\022o\025$r\0254\022r$KxP\022,M\0254\r$r\127C\022Ucoo\025\022,$\025\r\0254|\022,\025rr\022\rM\022\0255\022,\025$55P.0"),
      Media = _Pg3e,
      Callback = function(action)
        if action ~= nil then
          _Ec_B = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _snYls:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_Oqsy, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("0\n>IO|\022c>IO|\022\rM\022xI5P\022\0255\022\r$4\022@\0254\r$\025rPC\022B\025$Kx\025\022o$4|\022,I5\022$oo\0254\022\rM\022xI5PC0]#BQ"),
      Media = _Pg3e,
      Callback = function(action)
        if action ~= nil then
          _CjIwA.Commands._qUD.Enabled = false
          _QJNJ_.Commands._ZVVh.Enabled = true
          _3pXLP = false
          _YOP = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0<\014\"j\017?.\022\021M\022\020$5P\022o\025$r\0254\022r$KxP\022,M\0254\r$r\127C\022Ucoo\025\022,$\025\r\0254|\022,\025rr\022\rM\022\0255\022,\025$55P.0"),
      Media = _Pg3e,
      Callback = function(action)
        if action ~= nil then
          _3pXLP = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _49s:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_9Qs, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("\021I5\022jKx%c55\0225y4$r\127P\022IM\016\022Mr\r\022OP4cxj\022$5P\022\0164\025$C"),
      Media = _2fUN,
      Callback = function(action)
        if action ~= nil then
          _xgJg.Commands._I66kV.Enabled = false
          __G33 = true
          _fcBXk.Visible = false
          _DfhfE.Active = false
          _DfhfE.Visible = false
          _g5eMc.Active = false
          _g5eMc.Visible = false
          _xgJg.Visible = false
          _IWjn.Visible = false
          _xiom.Commands._zdtqu.Enabled = true
          _gEJfx.Visible = false
          _xiom.Visible = true
          _IWjn.Visible = true
          _SyVV = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021I5\022,I4\022%\025$\r\0254\022\016I%5Kx\022Mr\r\022\rI5\022jKx%c55\022c\025\016\016r\025P\0225$Kx\022r$KxPC"),
      Media = _W8K,
      Callback = function(action)
        if action ~= nil then
          _SyVV = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _sOM:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 12190 then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("0\014Kx\022,\025xC\022\021I\022xIP\022\rI5\022#$%\rMr\12755O5P\025o\022oI%\022,$\025\r\0254\022@\02545I\127PCCC0"),
        Media = _Va5Vc
      },
      {
        Text = _IHvVl("0\021I\020\025$\022$5P\022\rcKx\022>%I4|\022\rI55\022\0255\0225$Kx\022x$\0254\022Mo\022\025$r\025\022)\0254oMPIP$cr\022o$P\022\025$r\025o\022,$\025\r\0254xc%P\025o\022\031%\025o\025rP\022xIr\r\025%PC\022\021$\025\022<c4o\025%\022$5P\0225co$P\002\022:u.E^:-.E|\022o$P\022\r\025o\022\0314\127\025\020r$5\022\127%\025$Kx\022\\vC0"),
        Media = _Va5Vc
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0FI\022;Mo\022\004%M\025K>C\022jcr5P\022xI\025PP\0255P\022\rM\022\025$r\022\015\025$P\0254>coo\025r\022x$\0254\022r$KxP\022@\0254\r$\025rPC0"),
      Media = _Va5Vc,
      Callback = function(action)
        if action ~= nil then
          _CkB6T = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _fUpNo:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 12190 then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("0?IP\022\r$4\022r$\025\022\025$r\0254\022\r$\025\022wx4\022\0254>%I\0254P30"),
        Media = _Va5Vc
      },
      {
        Text = _IHvVl("0\021I5\022$5P\022\rcKx\022\025$\127\025rP%$Kx\022\127Ir;\022\025$r\016IKx\002\022\021\0254\022~$rMP\025r;\025$\127\0254\022M\025\020\0254xc%P\022\r\025r\022jPMr\r\025r;\025$\127\0254\022$oo\0254\022rIKx\022\025$r\0254\022jPMr\r\025|\022\016M\025r\016\022~$rMP\025r\022Mr\r\022-'\022j\025>Mr\r\025r\0229\022Mr\r\022\rIo$P\022Mo\022v\002vv\002vv\022wx4|\0222\002vu\002-'\022wx4|\022-\0022v\002uu\022wx4|\022D\0022\\\002--\022wx4\022Mr\r\0225c\022,\025$P\0254\0229\022\020$5\022;Mo\022%\025P;P\025r\022~I%\022Io\022(I\127\022Mo\022--\002uW\002DD\022wx4C\022jco$P\022%$\025\127\025r\022\020\025$\r\025\022z\025$\127\0254\022Io\022(I\127\022\127\025rIM\022--\022oI%\022M\025\020\0254\025$rIr\r\0254C0"),
        Media = _Va5Vc
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0FI\022;Mo\022\004%M\025K>C\022jcr5P\022xI\025PP\0255P\022\rM\022\025$r\022\015\025$P\0254>coo\025r\022x$\0254\022r$KxP\022@\0254\r$\025rPC0"),
      Media = _Va5Vc,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Tsbxu:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 12190 then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("0\014Kx\022,\025xC\022FI\022\rIrr\022>IM\0165P\022\rM\022\r$4\022Io\022\020\0255P\025r\022\025$r\022yII4\022\0314rP\025oI5Kx$r\025r\022Mr\r\022y4c\020$\02545P\022\0255\022oI%\022IM5C0"),
        Media = _Va5Vc
      },
      {
        Text = _IHvVl("0\014%5c\022-`\022\0314rP\025oI5Kx$r\025r\0225c%%P\025r\022\0255\022$r\0222D\022jPMr\r\025r\0225KxI\016\016\025rC\022'\022~I5Kx$r\025r\022xIP\022\0254\0225KxcrC\022\014%5c\0225c%%P\025\022\0254\022Io\022\020\0255P\025r\022rcKx\022-2\022~I5Kx$r\025r\022>IM\016\025rC0"),
        Media = _Va5Vc
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0FI\022;Mo\022\004%M\025K>C\022jcr5P\022xI\025PP\0255P\022\rM\022\025$r\022\015\025$P\0254>coo\025r\022x$\0254\022r$KxP\022@\0254\r$\025rPC0"),
      Media = _Va5Vc,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _B82T:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 12190 then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("0)xO5$>\022$5P\022I%5c\022r$KxP\022\127\0254I\r\025\022\r\025$r\025\022jPI\0254>\02530"),
        Media = _Va5Vc
      },
      {
        Text = _IHvVl("0\004c%\r\022xIP\022\025$r\025\022\021$KxP\025\022@cr\0222\028|D\022\127^KKoC\022\021Io$P\022,\0254\r\025r\022KIC\022DvvvKKo\022\020;,C\022D\022\"$P\0254\022\015I55\0254\022@\0254\r4I\025r\127PC0]#BQ"),
        Media = _Va5Vc
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0FI\022;Mo\022\004%M\025K>C\022jcr5P\022xI\025PP\0255P\022\rM\022\025$r\022\015\025$P\0254>coo\025r\022x$\0254\022r$KxP\022@\0254\r$\025rPC0"),
      Media = _Va5Vc,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _vyK:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 12190 then
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("0\tKx\022xI%P\025\022o$Kx\022\006\025P;P\022oI%\022o$P\022o\025$r\025r\022Ucoo\025rPI4\025r\022;M4M\025K>|\022\r\025rr\022\rI5\022$5P\022\025$\127\025rP%$Kx\022\r$\025\0225\025%\020\025\022B\025KxrMr\127\022,$\025\022\025\020\025r\0225KxcrC0"),
        Media = _Va5Vc
      },
      {
        Text = _IHvVl("0)I%%I\r$Mo\022xIP\022\025$r\025\022\021$KxP\025\022@cr\0222-\022\127^KKoC\022\021Io$P\022\0204IMKxP\022oIr\022KIC\022D\\>\127\022)I%%I\r$Mo\022Mo\022\r$\025\022D\022\"$P\0254\022\015I55\0254\022;M\022@\0254\r4I\025r\127\025rC0]#BQ"),
        Media = _Va5Vc
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("0FI\022;Mo\022\004%M\025K>C\022jcr5P\022xI\025PP\0255P\022\rM\022\025$r\022\015\025$P\0254>coo\025r\022x$\0254\022r$KxP\022@\0254\r$\025rPC0"),
      Media = _Va5Vc,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Bn9:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_V6u7, input) then
    _Urwigo.MessageBox({
      Text = _IHvVl("\n>IOC\022)I55P.\022wr\r\022rMr\022@$\025%\022jyI55."),
      Callback = function(action)
        if action ~= nil then
          _z1k.Visible = true
          _Viv.Visible = true
          _Viv.Active = true
          _Urwigo.Dialog(false, {
            {
              Text = _IHvVl("\031$r\0225crr$\127\0254\022(I\127\022Mr\r\022,I4o\0255\022\015\025PP\0254\0229\022,I5\022\127$\020P\022\0255\022\rI\0225Kxc\025r\0254\0255\022I%5\022$r\022\r\025r\022)I4>\022;M\022\127\025x\025r3\022U%I4\022\025$r\022)$K>r$K>\022o$P\022\r\0254\022\"$\025\0205P\025r\022$o\022\0044M\025r\025rC\022\021Moo\022rM4|\022,\025rr\022\025$r\022\014r4M\016\022>cooP\022Mr\r\022oIr\022\r$4\022I\0205I\127PC\022")
            },
            {
              Text = _IHvVl("<4M5P4$\0254P\022yIK>5P\022\rM\022I%5c\022\021\025K>\025|\022)$K>r$K>>c4\020\022Mr\r\022\r\025$r\025\022Uc\0255P%$Kx>\025$P\025r\022,$\025\r\0254\022\025$r\022Mr\r\022oIKx5P\022\r$Kx\022IM\016\022\r\025r\022?\025$o,\025\127C\022\021cKx\022\rIrr\022>coo5P\022\rM\022Io\022\031rP\025rP\025$Kx\022@c4\020\025$\022Mr\r\022,$%%5P\022\025$r\022jPM\025K>\022@\0254,\025$%\025rC")
            },
            {
              Text = _IHvVl("\tr\022\0314$rr\0254Mr\127\022Ir\022\r\025$r\025\022\026M\127\025r\r\022,$%%5P\022\rM\022>%\025$r\025\022U$\0255\025%5P\025$rKx\025r\022M\025\020\0254\022\rI5\022\015I55\0254\022xM\025y\016\025r\022%I55\025rCCC\022I%5\022\rM\022Mr\0254,I4P\025P\022$r\022\025$r\022>%\025$r\0255\022\014\020\025rP\025M\0254\0225Pc%y\02545PC")
            },
            {
              Text = _IHvVl("#\025\127$rr\025\022rMr\022\r\025$r\025\022jMKx\025\022Io\022\031rP\025rP\025$Kx.")
            }
          }, function(action)
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("\021I5\022yI55P\022%\025$\r\0254\022r$KxPC\022wr\r\022P5KxM\02555."),
      Media = _zIHG,
      Callback = function(action)
        if action ~= nil then
          Wherigo.Command("SaveClose")
        end
      end
    })
  end
end
function _plXQ8:OnStart()
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\015I4P\025\022>M4;|\022$Kx\022\0204IMKx\025\022x$\0254\016M\0254\022rM4\022\025$r\022yII4\022j\025>Mr\r\025rC0"),
      Media = _Pg3e
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
  end)
end
function _plXQ8:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0jc\022o\025$r\022<4\025Mr\r|\022x$\0254\022$5P\022\r\025$r\022\127c%\r\025r\0254\022U$\0255\025%5P\025$rC\022\tKx\022xc\016\016\025|\022\rM\022\020$5P\022rMr\022;M\0164$\025\r\025rC0"),
      Media = _Pg3e
    }
  }, function(action)
    _CjIwA.Commands._n_qZ6.Enabled = false
    _CjIwA.Commands._UQ_N9.Enabled = false
    _8BjI2:MoveTo(Player)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _P3hr:OnStart()
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\031$r\025r\022~co\025rP|\022o\025$r\022<4\025Mr\r.0"),
      Media = _Pg3e
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
  end)
end
function _P3hr:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0jc\022o\025$r\022<4\025Mr\r|\022x$\0254\022$5P\022\r\025$r\022\004c%\r>%Moy\025rC\022\tKx\022xc\016\016\025|\022\rM\022\020$5P\022rMr\022;M\0164$\025\r\025rC0"),
      Media = _Pg3e
    }
  }, function(action)
    _CjIwA.Commands._n_qZ6.Enabled = false
    _CjIwA.Commands._UQ_N9.Enabled = false
    _iU2:MoveTo(Player)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _OAp:OnStart()
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0jc|\022\rIrr\0224M\025x4\025\022$Kx\022oI%\022\016%\025$55$\127C\022\031$r\025r\022~co\025rP\022\004\025\rM%\r\022oM55P\022\rM\022I\020\0254\022o$P\0204$r\127\025rC0"),
      Media = _FxrG
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
  end)
end
function _OAp:OnTick()
  _NLd:MoveTo(Player)
  _NLd.Visible = true
  _6dpA.Complete = true
  _G0Lp = true
  _1LlI.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0jc|\022\rI5\022xI\025PP\025r\022,$4\022\127\0255KxI\016\016P.\022?$\0254\022$5P\022\r\025$r\022<%I\0255KxKx\025r\022zIM\020\0254P4Ir>C0"),
      Media = _FxrG
    },
    {
      Text = _IHvVl("0\014\020\0254\022,\025rr\022\r$\0255\0254\022<c%P\0254>r\025KxP\022IM5\022#IO\0254r\022,$4>%$Kx\0225c\022\020c\0255\025\022$5P|\022\rIrr\022\127\025\020\025\022$Kx\022\r$4\022%$\025\020\0254\022rcKx\022\n\020\025%$t\022I%5\022\019\02545PI\0254>Mr\127\022o$PC0]#BQ"),
      Media = _FxrG
    },
    {
      Text = _IHvVl("0\ncccc\020\025\025\025\025\025%$$$$$$$tCCC\022\018r\0205yJ\ncccc\020\025\025\025\025\025%$$$$$$$tCCCCC\022\ncccc\020\025\025\025\025\025%$$$$$$$tCCC\022\018r\0205yJ....0"),
      Media = _FxrG
    },
    {
      Text = _IHvVl("0\026I|\022,I5\022\127$\020P\022\0255\022\r\025rr3\022\tKx\022\020$r\022\rcKx\022\127\0254I\r\025\022o$P\022\r\025r\022?$r>\025%5P\025$r\025r\022\020\0255KxI\025\016P$\127P.0"),
      Media = _lD_xP
    },
    {
      Text = _IHvVl("0\015M\0254\r\0255P\022\rM\022Mr5\0254\025o\022<4\025Mr\r\022x$\0254\022\020\025$\022\r\0254\022B\025PPMr\127\022@cr\022OP4cxj\022x\025%\016\025r30"),
      Media = _FxrG
    },
    {
      Text = _IHvVl("0\nx\022\006IC\022<\025$r|\022\016\025$r.\022\tKx\022\0204IMKx\025\022rM4\022\025P,I5\022zIM\020\0254P4Ir>.0"),
      Media = _lD_xP
    },
    {
      Text = _IHvVl("0\014Kx\022\n\020\025%$tC\022\021M\022\020$5P\022\rcKx\022I%5\022U$r\r\022$r\022\r\025r\022\1274c55\025r\022U\02555\025%\022\127\025\016I%%\025rC\022\021I5\0224\025$KxP\022\025$r\022\"\025\020\025r\022%Ir\127.\022\021I55\022,\025$55P\022\rM\022\rcKx.0"),
      Media = _FxrG
    },
    {
      Text = _IHvVl("0\014Kx\0225KxI\r\025C\022F$KxP\022oI%\022\025$r\022>%$P;\025\022>%\025$r\0255\022(4c\025y\016Kx\025r3\022FI\006I|\022$Kx\022x\025%\016\025\022P4cP;\r\025oC0"),
      Media = _lD_xP
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _hUV:OnStart()
  Wherigo.PlayAudio(_sza)
end
function _hUV:OnStop()
  Wherigo.Command("StopSound")
end
function _hUV:OnTick()
  Wherigo.Command("StopSound")
end
function _QeQao:On_vW6K(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("j\025$\022\127\025\1274M\02555P\022o\025$r\022<4\025Mr\rC\022)IyI\022jKx%Moy\016\0225Kx$K>P\022\r$Kx\022I%5c3\022\021M\0225MKx5P\022\025$r\025\022xc%\r\025\022~I$\r3"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("\026I|\022\r$\025\022\020\025;IM\020\0254r\r\025\022OP4cxj\022>Io\022x$\0254\022@c4\020\025$C\022j$\025\022,I4\022IM\016\022\r\0254\022jMKx\025\022rIKx\022$x4\0254\0222vvv5P\025r\022\021c5\025C"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("?I\025PP\025\022j$\025\022$x4\022?c\020\020O\022oI%\022%$\025\020\0254\022Ir\022\r\025r\022FI\127\025%\022\127\025xI\025r\127PCCCC"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("wr,\025$P\022@cr\022x$\0254\022P4I\016\0225$\025\022IM\016\022\025$r\025r\022\016$r5P\0254\025r\022U\0254%|\022\r\0254\022$x4\022\025$r\025\022\020\0255cr\r\02545\022\1274c55\025\022Mr\r\0225Kxc\025r\025\022\021c5\025\022;Mo\022\026M\020$%I\025Mo\022@\02545y4IKxC"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("j$\025\022,M4\r\025\022\025$r\022\ny\016\0254\022\r\0255\022<c%P\0254>r\025KxP\0255\022IM5\022#IO\0254rC"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("\tKx\022>c\025rrP\025\022\r$4\022,\025$P\0254x\025%\016\025r|\022I\020\0254\022\0254,\025$5\025\022\r$Kx\022;M\02545P\022I%5\022,M\0254\r$\127\022Mr\r\022%c\0255\025\022o\025$r\022BI\025P5\025%C"),
      Media = _zIHG
    }
  }, function(action)
    _QeQao.Commands._vW6K.Enabled = false
    _QeQao.Commands._SxQTs.Enabled = true
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_biQ3)
    end)
  end)
end
function _QeQao:On_SxQTs(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_biQ3)
  end)
end
function _QeQao:On_EQUW(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_FmB)
  end)
end
function _QeQao:On_NcC(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("?I%%c\022o\025$r\022<4\025Mr\r|\022\rI\022\020$5P\022\rM\022\006I\0225Kxcr\022,$\025\r\0254C"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("\021\0254\022<c%P\0254>r\025KxP\022,c%%P\025\022\r$Kx\022I%5c\022@\0254y4M\025\127\025%r3\022\021I5\022xI\020\025\022$Kx\022o$4\0225Kxcr\022\127\025\rIKxPC\022ex$x$x$e"),
      Media = _zIHG
    },
    {
      Text = _IHvVl("\021M\022,$%%5P\022I%5c\022\1274c\02555\0254\022Mr\r\0225PI\0254>\0254\022,\0254\r\025r3\022\tKx\022,\025$55|\022,\0254\022\r$4\022x$\0254\022x\025%\016\025r\022>IrrC\022\014\020\0254\022@c4x\0254\0225c%%5P\022\rM\022o$4\022\025$r\025\022,\025$P\0254\025\022<4I\127\025\022\020\025IrP,c4P\025rC"),
      Media = _zIHG
    }
  }, function(action)
    _QeQao.Commands._NcC.Enabled = false
    _QeQao.Commands._AgJnk.Enabled = true
    _LHx.Visible = true
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_LHx)
    end)
  end)
end
function _QeQao:On_AgJnk(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_LHx)
  end)
end
function _QeQao:On_yhvr_(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("jKxcr\022,$\025\r\0254\022\rM3\022\021M\0224IM\0205P\022o$4\022o\025$r\025r\022jKxI%\016."),
      Media = _zIHG
    },
    {
      Text = _IHvVl("\004c%\r3\022\021M\022,$%%5P\022\004c%\r3\022\tKx\022\020$r\022\025$r\025\022\031M%\025|\022Mr\r\022>\025$r\022\004c%\r\0255\025%|\022\rM\022F\0254@\025r5I\025\127\025."),
      Media = _zIHG
    },
    {
      Text = _IHvVl("\014\020\0254\022\020\025@c4\022\rM\022o$4\022rcKx\022o\025x4\022o\025$r\0254\022>c5P\020I4\025r\022z\025$P\0224IM\0205P|\022,\0254\r\025\022$Kx\022\r$4\022\025\020\025r\022x\025%\016\025r\0229\022rIKx\r\025o\022\rM\022o$4\022\025$r\025\022,\025$P\0254\025\022<4I\127\025\022\020\025IrP,c4P\025P\022xI5PC"),
      Media = _zIHG
    }
  }, function(action)
    _QeQao.Commands._yhvr_.Enabled = false
    _QeQao.Commands._lJ4_M.Enabled = true
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_b5nsD)
    end)
  end)
end
function _QeQao:On_lJ4_M(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_b5nsD)
  end)
  _QeQao.Commands._NcC.Enabled = false
end
function _zTN0:On_jY3Iq(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("\014Kx\022,$\025\022r$\025\r%$KxC\022\021\0254\022PIy\016\0254\025\022?\025%\r\022\025$%P\022;M4\022B\025PPMr\1273\022exI4\022xI4\022xI4e"),
      Media = _6ItQ
    },
    {
      Text = _IHvVl("\021M\022>coo5P\022o$4\022\127\025rIM\0224\025KxP\022\016M\0254\022o\025$r\025\022\031$5\0254r\025\022\026Mr\127\0164IM.\022exI4\022xI4\022xI4e"),
      Media = _6ItQ
    },
    {
      Text = _IHvVl("\015\025rr\022\rM\022\r$Kx\022o$P\022o$4\022Ir%\025\127\025r\022,$%%5P|\022oM55P\022\rM\0225Kxcr\022rcKx\022\025P,I5\0225PI\0254>\0254\022,\0254\r\025rC\022exI4\022xI4\022xI4e"),
      Media = _6ItQ
    }
  }, function(action)
    _Urwigo.MessageBox({
      Text = _IHvVl("\021M\0225KxI\016\0165P\022\0255\022\127\0254I\r\025\022rcKx\022\r\025o\022<c%P\0254>r\025KxP\022;M\022\025rP>coo\025rC"),
      Callback = function(action)
        if action ~= nil then
          _zTN0.Commands._jY3Iq.Enabled = false
          _QeQao.Commands._vW6K.Enabled = false
          _QeQao.Commands._NcC.Enabled = true
          _O8_EU.Active = true
          _Urwigo.MessageBox({
            Text = _IHvVl("\n>IO|\022x$\0254\022>coo\025\022$Kx\0225c\022r$KxP\022,\025$P\0254C\022\019$\025%%\025$KxP\0225c%%P\025\022$Kx\022\r$\025\022,\025$55\025\022\031M%\025\022Mo\022BIP\022\0164I\127\025r3"),
            Media = _lRVX,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  end)
end
function _zTN0:On_ABN(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021M\022,$%%5P\022\r$Kx\022I%5c\022,$4>%$Kx\022o$P\022o$4\022Ir%\025\127\025r30"),
      Media = _6ItQ
    },
    {
      Text = _IHvVl("0FI\022\rIrr\022>coo\022x\0254\022o\025$r\022#M\02545KxKx\025r.0"),
      Media = _6ItQ
    }
  }, function(action)
    _Urwigo.MessageBox({
      Text = _IHvVl("\031$r\022(4$PP\022$r\022\r$\025\022~I\127\025r\1274M\020\025\022Mr\r\022\025$r\022?Ir\r>IrP\025r5Kx%I\127|\022Mr\r\022\r\0254\022<c%P\0254>r\025KxP\022%$\025\127P\022\020\025,M5P%c5\022Io\022#c\r\025rC"),
      Callback = function(action)
        if action ~= nil then
          _zTN0.Commands._ABN.Enabled = false
          _B1HWR.Visible = true
          _zTN0.Visible = false
          _Urwigo.MessageBox({
            Text = _IHvVl("\021\0254\022<c%P\0254>r\025KxP\0225c%%P\025\022\016M\0254\022\r$\025\022rI\025Kx5P\025r\022~$rMP\025r\022IM55\0254\022\004\025\016\025KxP\0225\025$r|\022I\020\0254\022\r\025$r\022zIM\020\0254P4Ir>\022$5P\022rMr\022@\0254\0204IMKxPC"),
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = _IHvVl("\021M\0225c%%P\0255P\022@$\025%%\025$KxP\022\rI\016M\0254\0225c4\127\025r|\022\rI55\022\0254\022r$KxP\022o\025x4\022IM\0165P\025xPC"),
                  Callback = function(action)
                    if action ~= nil then
                      _XoEWn.Commands._2gfWz.Enabled = true
                      _XoEWn.Visible = true
                      _sYDiA = true
                      _NfDA.Commands._LUz.Enabled = true
                      _qvzq.Visible = true
                      _qvzq.Commands._7Kih.Enabled = true
                      _O6CA.Visible = true
                      _NfDA.Visible = true
                      _O6CA.Commands._rmbA.Enabled = true
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              end
            end
          })
        end
      end
    })
  end)
end
function _xiom:On_zdtqu(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0~\025$r\022?\025%\r.\022\021M\022xI5P\022o$Kx\022\127\0254\025PP\025P.\022\tKx\022,I4\022\127\0254I\r\025\022IM\016\022\r\0254\022jMKx\025\022rIKx\022o\025$r\0254\022PIM5\025r\r5P\025r\022\021c5\025|\022I%5\022o$Kx\022\r$\0255\0254\022\127\025o\025$r\025\022<c%P\0254>r\025KxP\022IM5\022#IO\0254r\022\025rP\016M\025x4P\025\022Mr\r\022x$\0254\022$r\0225\025$r\025o\022<c%P\0254>\025%%\0254\022\127\025\016Ir\127\025r\022rIxoC0"),
      Media = _o69s2
    },
    {
      Text = _IHvVl("0\015$\025\022>Irr\022$Kx\022\r$4\022rM4\022\rIr>\025r3\022~I\1275P\022\rM\022o$Kx\022@$\025%%\025$KxP\022IM\016\022o\025$r\025o\022\015\025\127\022;M4\022\021c5\025\022\020\025\127%\025$P\025r3\022j$\025\0225c%%\022\020\025$\022DDw\022D2u\028`D\022u\\\028-D\028u\022@\02545P\025K>P\0225\025$rC0"),
      Media = _o69s2
    }
  }, function(action)
    _VGe.Visible = false
    _VGe.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _sVsg:On_XOiNU(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("\015\0254\022\rI3\022<4\025Mr\r\022c\r\0254\022<\025$r\r3"),
      Media = _mNiN
    },
    {
      Text = _IHvVl("\014x|\022\r$\025\022I%P\025\022\031M%\025\0225Kx$K>P\022\r$Kx\022I%5c3\022"),
      Media = _mNiN
    },
    {
      Text = _IHvVl("jc|\0225cC\022\021M\022\020\025\127\025x45P\022I%5c\022o\025$r\025r\022zIM\020\0254P4Ir>3\022U\025$r\022)4c\020%\025oCCCC\022\025$\127\025rP%$KxC"),
      Media = _mNiN
    },
    {
      Text = _IHvVl("\014#\031B\002\022\031$r\022(4c%%\022xIP\022o\025$r\025\022\127c%\r\025r\025\022j$Kx\025%\022\127\0255Pcx%\025rC\022\0314\022xcK>P\022MrP\0254\0225\025$r\0254\022#4M\025K>\025\022Mr\r\022\127$\020P\0225$\025\022o$4\022r$KxPC\022\015$%%5P\022\rM\022\r\025$r\022\004%M\025K>\0225\025%\0205P\022y4c\020$\0254\025r3"),
      Media = _mNiN
    }
  }, function(action)
    _uzvy.Visible = true
    _lTs.Visible = true
    _lTs.Active = true
    _X6fw.Commands._wPA2.Enabled = true
    _uzvy.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _sVsg:On_BqA(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\014x|\022\rM\022\020$5P\022;M4M\025K>\022\127\025>coo\025r.\022?I5P\022\rM\022\020\025$\022\r\025$r\0254\022~$55$cr\022\0314\016c%\127\022\127\025xI\020P30"),
      Media = _mNiN
    },
    {
      Text = _IHvVl("0\026I\022,Mr\r\0254\020I4.\022~\025$r\025\022\127c%\r\025r\025\022j$Kx\025%.\022\004$\020\0225$\025\022o$4|\022Mr\r\022$Kx\022,\0254\r\025\022\025$r\022yII4\022~$5P\025%r\022\016M\0254\022\r\025$r\025r\022zIM\020\0254P4Mr>\0225Kxr\025$\r\025rC0"),
      Media = _mNiN
    }
  }, function(action)
    _sVsg.Commands._BqA.Enabled = false
    _jufap.Commands._HOy1.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _sVsg:On_syi5(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0~\025$r\022<4\025Mr\r\0229\022xI5P\022\rM\022\r$\025\022U4I\025MP\0254|\022Mo\022\r$\025\022$Kx\022\r$Kx\022\020IP30"),
      Media = _mNiN
    }
  }, function(action)
    _sVsg.Commands._syi5.Enabled = false
    _ae1.Commands._Vao.Enabled = true
    _R42.Commands._2OS.Enabled = true
    _iyQKG.Commands._VCGb.Enabled = true
    _VMl.Commands._2nRJn.Enabled = true
    _TC9.Commands._or6e.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _sVsg:On_2woZB(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0#4$r\127\025\022o$4\022\rcKx\022\020$PP\025\022o\025$r\025\022U4I\025MP\0254C\022\tKx\022\0204IMKx\025\022\016M\0254\022\r\025$r\025r\022(4Mr>\022rcKx\022$oo\0254\022<$r\127\0254>4IMP\022Mr\r\022#%MP,M4;C0"),
      Media = _mNiN
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _X6fw:On_wPA2(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("\004c%\r.\022\004c%\r.\022\004c%\r.\022\014%%\0255\022o\025$r5."),
      Media = _FhQ
    },
    {
      Text = _IHvVl("\021M\022,$%%5P\022~\031\tF\031\022\127c%\r\025r\025\022j$Kx\025%3\022?o3\022(\006I|\022\r$\025\022>Irr5P\022\rM\022xI\020\025r|\022,\025rr\022\rM\022o$4\022\025P,I5\022\0204$r\1275P|\022,I5\022IM5\022o\025x4\022\004c%\r\022\020\0255P\025xP\022I%5\022\r$\0255\025\022j$Kx\025%C"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("wr\r\022\020$5\022\rIx$r\0229\022xIM\022I\020."),
      Media = _FhQ
    }
  }, function(action)
    _QeQao.Commands._yhvr_.Enabled = true
    _Urwigo.MessageBox({
      Text = _IHvVl("\015c\0225c%%\022$Kx\022\r\025rr\022\004c%\r\022x\0254r\025xo\025r3\022\019$\025%%\025$KxP\022>Irr\022o$4\022\r$\025\022,\025$55\025\022\031M%\025\022rcKx\022\025$roI%\022x\025%\016\025r."),
      Media = _lRVX,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end)
end
function _X6fw:On_KBz(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021I\022\020$5P\022\rM\022\006I\022,$\025\r\0254.0"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0\014x|\022\rM\022,I45P\022I%5c\022\020\025$\022~$\rI53\022?IP\022\r\0254\022UrIM5\0254\022\025P,I5\022@cr\0225\025$r\025o\022\004c%\r\0224IM5\127\0254M\025K>P30"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0\021Irr\022\127$\020\022\0255\022o$4.0"),
      Media = _FhQ
    }
  }, function(action)
    _X6fw.Commands._KBz.Enabled = false
    _8BjI2.Commands._abe6M.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _X6fw:On_XtaZ(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021I5\022xIP\022\006I\022\127\025\rIM\0254PC\022\tKx\022\rIKxP\025\0225Kxcr|\022\rM\022xI\025PP\0255P\022\rI5\022\trP\0254\02555\025\022Ir\022\r\0254\022j$Kx\025%\022@\0254%c4\025r.0"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0wr\r\022,I5\022xIP\022\r\0254\022UrIM5\0254\022@cr\022~$\rI5\022\r$4\022\r$\0255oI%\022o$P\127\025\127\025\020\025r30"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0\031$r\025r\022\004c%\r>%Moy\025r3.\022\021I\022>coo\025r\022,$4\022\r\0254\022jIKx\025\0225Kxcr\022rI\025x\0254.0"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0\n>IO|\0225c\022>coo\025r\022,$4\022$r5\022\004\0255KxI\025\016P.\022\tKx\022r\025xo\025\022o$4\022\r\025r\022>%\025$r\025r\022\004c%\r>%Moy\025r\022Mr\r\022\rM\022\020\025>coo5P\022\r$\0255\025\022\127c%\r\025r\025\022j$Kx\025%CCC\022\014r\022\r\0254\022xI\020\025\022$Kx\022o$Kx\022\025x\022$oo\0254\022rM4\022\127\0255Kxr$PP\025r.0"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0jc|\022Mr\r\022rMr\022@\02545Kx,$r\r\025\022\rM\022\015$KxP.\022\tKx\022,$%%\022\006\025P;P\022$r\022BMx\025\022o\025$r\025r\022jKxIP;\022\020\025,Mr\r\0254r.\022~\025$r\025r\022jKxIIIIIIIP;;;;;.0"),
      Media = _FhQ
    }
  }, function(action)
    _CjIwA.Commands._qUD.Enabled = false
    _X6fw.Commands._XtaZ.Enabled = false
    _CjIwA.Visible = false
    _CjIwA.Commands._hWlB.Enabled = false
    _PyRp.Active = false
    _PyRp.Visible = false
    _UqH_.Visible = false
    _UqH_.Active = false
    _kT2p.Visible = false
    _kT2p.Active = false
    _jufap.Visible = true
    _iU2:MoveTo(_X6fw)
    _jufap:MoveTo(Player)
    _X6fw.Visible = false
    _sVsg.Commands._XOiNU.Enabled = false
    _9GC.Visible = false
    _9GC.Active = false
    _sVsg.Commands._BqA.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _R0X:On_hQl(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0?I%%c\022<4\025o\r\0254|\022xI5P\022\rM\022\025P,I5\022#4cP\022\016M\0254\022o$Kx3\022\tKx\022\020$r\0225c\022xMr\1274$\127C\022jcr5P\022>cooP\022$oo\0254\022o\025$r\025\022OP4cxj\022Mr\r\022\0204$r\127P\022o$4\022\025P,I5C0]#BQ"),
      Media = _lNi
    },
    {
      Text = _IHvVl("0\014\020\0254\022\127\0255P\0254r\022,c%%P\025\0225$\025\022rcKx\022$r\022\r\025r\022\015I%\r\022\021c5\025r\0225MKx\025r\022Mr\r\0225\025$P\r\025o\022xI\020\025\022$Kx\0225$\025\022r$KxP\022o\025x4\022\127\0255\025x\025rC0"),
      Media = _lNi
    }
  }, function(action)
    _z1k.Commands._mKtM.Enabled = true
    _HCJz.Complete = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _R0X:On_yL8G(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("\021M\022,$4\0165P\022\r\025o\022\031rP%\025$r\022\025$r\022yII4\022#4cP5PM\025K>\025\022x$rC"),
    Callback = function(action)
      if action ~= nil then
        _NfDA.Commands._j2aur.Enabled = false
        _NfDA.Visible = false
        _Urwigo.Dialog(false, {
          {
            Text = _IHvVl("0\nx|\022,$\025\022$Kx\0225\025x\025\022xI5P\022\rM\022OP4cxj\022,$\025\r\0254\127\025\016Mr\r\025rC\022?I\020\022IMKx\022@$\025%\025r\022\021Ir>\022\016M\0254\022\r\025$r\025\022#4cP>4Mo\025rC0]#BQ"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0\tKx\0225\025x\025|\022\rM\022\020$5P\022\025$r\022\127MP\0254\022~\025r5KxC\022\021Ix\0254\022,$%%\022$Kx\022\r$4\022@\02544IP\025r|\022,c\022$Kx\022o\025$r\025r\022\025$\127\025r\025r\022>%\025$r\025r\022jKxIP;\022@\02545P\025K>\025C0"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0U\025$r\022jKxIP;\022\r\0254\022\015\025%P\022\0204$r\127P\022o$4\022\025P,I5|\022,\025rr\022$Kx\022x$\0254\022?Mr\127\0254\022%\025$\r\025C\022\019\02545y4$Kx\022o$4\022\rIx\0254\022rM4|\022o$Kx\0224\025\127\025%oI\02555$\127\022\020\0255MKx\025r\022;M\022>coo\025r\022Mr\r\022o$4\022$oo\0254\022\025P,I5\022P4cK>\025r\0255\022#4cP\022o$P;M\0204$r\127\025rC0"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0~\025$r\025r\022\017IKx\025\022\016$r\r\0255P\022\rM\022\020\025$\002\022\018r\0205yJ]#BQF\022\018r\0205yJCcCCC\022\018r\0205yJCCcCc\022\018r\0205yJCCcCc\022\018r\0205yJCCccc\022^\022]#BQ\031\022\018r\0205yJCcCCC\022\018r\0205yJCCcCc\022\018r\0205yJCCCcC\022\018r\0205yJCCcCC\022\018r\0205yJ]#BQcCCCC\022\018r\0205yJCcCCc\022\018r\0205yJCCccc\022\018r\0205yJCcccc\022\018r\0205yJCCCcC\022\018r\0205yJccCcc\022\018r\0205yJccCcc\022\018r\0205yJCCcCC\022\018r\0205yJCcccC\022\018r\0205yJ0\022"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0#$5\022oc4\127\025r|\022o\025$r\022<4\025Mr\rC0"),
            Media = _aOD
          }
        }, function(action)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      end
    end
  })
end
function _rv4:On_2JwS8(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\014x|\022\025$r\022PIy\016\0254\0254\022?\025%\r.\022j\025$\022o$4\022\127\025\1274M\02555P\022Mr\r\022P4\025P\025\022\rcKx\022rI\025x\0254C0"),
      Media = _08NEq
    },
    {
      Text = _IHvVl("0\014\020\0254\022$Kx\022oM55\022\r$Kx\022%\025$\r\0254\022\025rPPI\025M5Kx\025rC\022\tKx\022xI\020\025\022x$\0254\022>\025$r\025\022\020\025;IM\020\0254r\r\025\022\004\025cKIKx\0254$r\022@c4\020\025$>coo\025r\0225\025x\025rC0"),
      Media = _08NEq
    },
    {
      Text = _IHvVl("0\014\020\0254\022,$4\0225$r\r\022>%\025$r\022Mr\r\022>coo\025r\022r$KxP\022,\025$P\022$o\022\015I%\r\022x\0254MoC\022<4I\127\025\022\rcKx\022\r$\025\022,\025$5\025\022\031M%\025C\022j$\025\022\016%$\025\127P\022\006\025\r\025\022FIKxP\022M\025\020\0254\022\r$\025\022#I\025Mo\025|\022@$\025%%\025$KxP\022>Irr\0225$\025\022\r$4\022,\025$P\0254x\025%\016\025rC0"),
      Media = _08NEq
    },
    {
      Text = _IHvVl("0\tKx\022,M\025r5Kx\025\022\r$4\022\127MP\0255\022\004\025%$r\127\025r|\022o\025$r\022<4\025Mr\rC\022\014\020\0254\0225\025$\022\127\025,I4rP\002\022\021$\025\022\031M%\025\022$5P\022\025$r\022%$5P$\127\0255\022Mr\r\022PM\025K>$5Kx\0255\022\021$r\127.0"),
      Media = _08NEq
    }
  }, function(action)
    _QeQao.Visible = true
    _5io.Commands._zTC7p.Enabled = false
    _kT2p.Visible = true
    _ARXE.Complete = true
    _A_OK.Active = true
    _vwn_.Active = true
    _QeQao.Commands._vW6K.Enabled = true
    _DhVS.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _CjIwA:On_UQ_N9(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("\015I5\022;Mo\022UMK>MK>\022,$%%5P\022\rM\022x$\02543"),
      Media = _Pg3e
    },
    {
      Text = _IHvVl("\004c%\r3\022\021I@cr\022>Irr\022$Kx\022\r$4\022o\025x4\022I%5\022\127\025rM\127\022\0254;\025M\127\025rC"),
      Media = _Pg3e
    },
    {
      Text = _IHvVl("#\025IrP,c4P\025\022o$4\022\025$r\025\022\025$r\016IKx\025\022<4I\127\025|\022Mr\r\022$Kx\022,\0254\r\025\022\r$4\022\025$r\025r\022\004\025\127\025r5PIr\r\022\r\025$r\0254\022\015Ix%\022$r\022\004c%\r\022@\0254,Ir\r\025%rC"),
      Media = _Pg3e
    }
  }, function(action)
    _CjIwA.Commands._UQ_N9.Enabled = false
    _CjIwA.Commands._n_qZ6.Enabled = true
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_CWm)
    end)
  end)
end
function _CjIwA:On_n_qZ6(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_CWm)
  end)
end
function _CjIwA:On_hWlB(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021M\0225Kxcr\022,$\025\r\0254.3\022\021M\022>Irr5P\022,cx%\022r$KxP\022\127\025rM\127\022@cr\022o\025$r\025o\022\004c%\r\022\020\025>coo\025r3\022\014\020\0254\022oIKx\022\r$4\022r$t\022\r4IM5C\022\tKx\022>\025rr\025\022\rI5\0229\022\r$\025\022\004$\0254\022\r\0254\022~\025r5Kx\025r\022$5P\022Mr\025r\r%$Kx.0"),
      Media = _Pg3e
    },
    {
      Text = _IHvVl("0\015\025rr\022\0255\022\r\025$r\025\022?I\020\127$\0254\022\020\025\0164$\025\r$\127P|\0225c\022,$%%\022$Kx\022\r$4\022rcKx\022\025$r\025r\022\004\025\127\025r5PIr\r\022\r\025$r\0254\022\015Ix%\022$r\022\004c%\r\022@\0254,Ir\r\025%rC0"),
      Media = _Pg3e
    },
    {
      Text = _IHvVl("0\014\020\0254\022@c4x\0254\022\020\025IrP,c4P\025\022o$4\022rcKx\022\025$r\025\022<4I\127\025C0"),
      Media = _Pg3e
    }
  }, function(action)
    _CjIwA.Commands._hWlB.Enabled = false
    _CjIwA.Commands._qUD.Enabled = true
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_snYls)
    end)
  end)
end
function _CjIwA:On_qUD(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_snYls)
  end)
end
function _5io:On_zTC7p(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_elqc)
  end)
end
function _5io:On_LgW(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_tgco)
  end)
end
function _5io:On_IagfL(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Cjvx)
  end)
end
function _5io:On_5Hb(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_ou6D)
  end)
end
function _1LlI:On_fsM(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\n\020\022$Kx\022\r$4\022\020\025$\022\r\0254\022(M\0254\022x$\0254\022\020\025x$%\016%$Kx\0225\025$r\022>Irr30"),
      Media = _lD_xP
    },
    {
      Text = _IHvVl("0\021I5\0225c%%P\025\022\025$r\022U$r\r\02545y$\025%\022\016M\0254\022o$Kx\0225\025$r.\022(4$PP\022oI%\022\020\025$\022j\025$P\0250"),
      Media = _lD_xP
    }
  }, function(action)
    _Urwigo.MessageBox({
      Text = _IHvVl("\031$r\022>%\025$r\0254\022jKx%I\127\022o$P\022\r\0254\022?Ir\r\022@cr\022\n\020\025%$t\022Mr\r\022\r$\025\022(M\0254\022\016%$\025\127P\022IM\016C"),
      Callback = function(action)
        if action ~= nil then
          _xgJg.Visible = true
          _xgJg.Commands._I66kV.Enabled = true
          _IWjn.Visible = false
          _gEJfx.Visible = true
          _XoEWn.Commands._2gfWz.Enabled = false
          _1LlI.Commands._fsM.Enabled = false
          _XoEWn.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end)
end
function _B1HWR:On_8Vda(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("~$P\022\r\025$r\025o\022jP4$K>\022xI5P\022\rM\022rMr\022\r\025r\022<c%P\0254>r\025KxP\022IM5\022#IO\0254r\022Ir\022?I\025r\r\025r\022Mr\r\022<M\02555\025r\022\127\025\016\02555\025%PC"),
    Callback = function(action)
      if action ~= nil then
        _O6CA.Visible = false
        _B1HWR.Commands._8Vda.Enabled = false
        _tBv1N.Visible = true
        _VjL1 = true
        _B1HWR.Visible = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _tBv1N:On_9kju(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\tKx\022,\025$55\022r$KxP|\022,$\025\022\rM\022\015$KxP\022\0255\022\127\0255KxI\016\016P\022xI5P\022o$Kx\022>CcC\022;M\0225Kx%I\127\025r\022Mr\r\022;M\022\016\02555\025%rJ\022I\020\0254\022\r$\025\022U%\025$r\025\022,$45P\022\rM\022r$\025\022\020\025\0164\025$\025rC\022\021\025r\022\017c\r\025\022\016$r\r\0255P\022\rM\022r$\025C\022?I4\022?I4\022?I4.0"),
      Media = _mOnu
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _xgJg:On_I66kV(target)
  if _wZR3z == true then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_49s)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _IHvVl("OP4cxj\022%$\025\127P\022\127\025\016\02555\025%P\022IM\016\022\r\0254\022jP4\025K>\020Ir>C"),
        Media = _W8K
      },
      {
        Text = _IHvVl("\021Moo\0254,\025$5\025\022$5P\022\rI\022rcKx\022\025$r\022\017c\r\0259jKx%c55C\022?$\0254\022>coo5P\022\rM\022o$P\022\0204IKx$I%\0254\022\004\025,I%P\022r$KxP\022,\025$P\0254C\022"),
        Media = _W8K
      },
      {
        Text = _IHvVl("\021I\022\0204IMKx\025\022$Kx\022,cx%\022c\r\0254\022M\025\020\025%\022rcKx\022\rI5\022\017c\r\025,c4PC"),
        Media = _lRVX
      }
    }, function(action)
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\026I|\022\rM\022oM55P\022\r\025r\022\017c\r\025\022\02545P\022\016$r\r\025rC\022\021\0254\022<c%P\0254>r\025KxP\022xIP\022$xr\022IM\016\127\0255Kx4$\025\020\025r\022Mr\r\022x$\0254\022$4\127\025r\r,c\022$r\022\025$r\0254\022<$%o\rc5\025\022@\02545P4\025K>PC0"),
          Media = _o69s2
        },
        {
          Text = _IHvVl("0#$PP\025\022x$%\016\022o$4\022Mr\r\022\020\025\025$%\025\022\r$KxC0"),
          Media = _o69s2
        }
      }, function(action)
        _fcBXk.Commands._TBtgJ.Enabled = true
        _wZR3z = true
        _fcBXk.Visible = true
        _49s.Visible = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_49s)
        end)
      end)
    end)
  end
end
function _jufap:On_HOy1(target)
  _jufap:MoveTo(_sVsg)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\tKx\022\rIr>\025\022\r$4C\022\"I55\022Mr5\022\rcKx\022;Mo\022\021c4\016\022\127\025x\025rC\022\021c4P\0225P\025xP\022\r\0254\022\1274c55\025\022U\02555\025%|\022$r\022\r\025r\022\n\020\025%$t\022I%5\022>%\025$r\0255\022U$r\r\022\127\025\016I%%\025r\022$5PC0"),
      Media = _mNiN
    },
    {
      Text = _IHvVl("0\021Io$P\022\rM\022r$KxP\022ZM\0254\016\025%\r\025$r\022%I\025M\0165P\022Mr\r\022\r\025r\022Bc\025o\0254r\022\020\025\127\025\127r\0255P|\022\020\025\127$\020\022\r$Kx\022;M\02545P\022;Mo\022zM\127Ir\127\022;Mo\022\021c4\016C\022\019cr\022\rc4P\022IM5\022,$45P\022\rM\022\r\025r\022>%\025$r\025r\022)\016I\r\022\127\025r\022jM\025\r\025r\0225\025x\025rC0"),
      Media = _mNiN
    }
  }, function(action)
    _DfhfE.Active = true
    _uzvy.Visible = false
    _uzvy.Active = false
    _sVsg:MoveTo(_DfhfE)
    _DfhfE.Visible = true
    _lTs.Complete = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _qvzq:On_7Kih(target)
  _qvzq.Commands._7Kih.Enabled = false
  _qvzq:MoveTo(Player)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _NfDA:On_LUz(target)
  _NfDA.Commands._LUz.Enabled = false
  _Ja5K = true
  _NfDA:MoveTo(Player)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _NfDA:On_j2aur(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("\021M\022,$4\0165P\022\r\025o\022\031rP%\025$r\022\025$r\022yII4\022#4cP5PM\025K>\025\022x$rC"),
    Callback = function(action)
      if action ~= nil then
        _R0X.Commands._yL8G.Enabled = false
        _NfDA.Visible = false
        _Urwigo.Dialog(false, {
          {
            Text = _IHvVl("0\nx|\022,$\025\022$Kx\0225\025x\025\022xI5P\022\rM\022OP4cxj\022,$\025\r\0254\127\025\016Mr\r\025rC\022?I\020\022IMKx\022@$\025%\025r\022\021Ir>\022\016M\0254\022\r\025$r\025\022#4cP>4Mo\025rC0]#BQ"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0\tKx\0225\025x\025|\022\rM\022\020$5P\022\025$r\022\127MP\0254\022~\025r5KxC\022\021Ix\0254\022,$%%\022$Kx\022\r$4\022@\02544IP\025r|\022,c\022$Kx\022o\025$r\025r\022\025$\127\025r\025r\022>%\025$r\025r\022jKxIP;\022@\02545P\025K>\025C0"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0U\025$r\022jKxIP;\022\r\0254\022\015\025%P\022\0204$r\127P\022o$4\022\025P,I5|\022,\025rr\022$Kx\022x$\0254\022?Mr\127\0254\022%\025$\r\025C\022\019\02545y4$Kx\022o$4\022\rIx\0254\022rM4|\022o$Kx\0224\025\127\025%oI\02555$\127\022\020\0255MKx\025r\022;M\022>coo\025r\022Mr\r\022o$4\022$oo\0254\022\025P,I5\022P4cK>\025r\0255\022#4cP\022o$P;M\0204$r\127\025rC0"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0~\025$r\025r\022\017IKx\025\022\016$r\r\0255P\022\rM\022\020\025$\002\022\018r\0205yJ]#BQF\022\018r\0205yJCcCCC\022\018r\0205yJCCCCc\022\018r\0205yJCcCCc\022\018r\0205yJCcCcC\022^\022]#BQ\031\022\018r\0205yJCcCCC\022\018r\0205yJCCccc\022\018r\0205yJCcCCc\022\018r\0205yJCcccc\022\018r\0205yJ0"),
            Media = _aOD
          },
          {
            Text = _IHvVl("0#$5\022oc4\127\025r|\022o\025$r\022<4\025Mr\rC0"),
            Media = _aOD
          }
        }, function(action)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      end
    end
  })
end
function _VMl:On_OF8H(target)
  _VMl:MoveTo(Player)
  _VMl.Commands._OF8H.Enabled = false
  _GyRH = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _VMl:On_2nRJn(target)
  _VMl:MoveTo(_sVsg)
  _VMl.Commands._2nRJn.Enabled = false
  _y2s = true
  _VMl.Visible = false
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021Ir>\025|\022\127\025rIM\022\rI5\022xI\020\025\022$Kx\022\127\025\0204IMKxPC0"),
      Media = _FxrG
    }
  }, function(action)
    if (_OOZ and _y2s) == true then
      _6dpA.Complete = true
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\n>IO|\022rMr\022xI\020\025\022$Kx\022I%%\025\022zMPIP\025r|\022\r$\025\022$Kx\022\0204IMKx\025C0"),
          Media = _FxrG
        }
      }, function(action)
        _GGD.Visible = false
        _GGD.Active = false
        _OAp:Start()
      end)
    else
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  end)
end
function _NLd:On_YoIRQ(target)
  _NLd.Commands._YoIRQ.Enabled = false
  _NLd.Visible = false
  _Urwigo.MessageBox({
    Text = _IHvVl("\021\0254\022zIM\020\0254P4Ir>\022xIP\022rMr\0225\025$r\025\022\015$4>Mr\127\022\02544\025$KxPC\022\026\025P;P\022>Irr5P\022\rM\022\0255\022o$P\022\r\025o\022<c%P\0254>r\025KxP\022IM\016r\025xo\025rC"),
    Callback = function(action)
      if action ~= nil then
        _O8_EU.Complete = true
        _zTN0.Commands._ABN.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _bhp:On_tyLE(target)
  _bhp:MoveTo(_CjIwA)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\031$r\022U$\0255\025%3\022\026I\022,\025\127\025r\022o$4CCC\022\015I4P\025\022>M4;C0"),
      Media = _Pg3e
    }
  }, function(action)
    _plXQ8:Start()
    _bhp.Visible = false
    _8BjI2.Visible = true
    _X6fw.Commands._KBz.Enabled = true
    _X6fw.Commands._wPA2.Enabled = false
    Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
  end)
end
function _QJNJ_:On_lm2Y1(target)
  _QJNJ_:MoveTo(Player)
  _CjIwA.Commands._hWlB.Enabled = true
  _QJNJ_.Commands._lm2Y1.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _QJNJ_:On_ZVVh(target)
  _QJNJ_:MoveTo(_CjIwA)
  _P3hr:Start()
  _QJNJ_.Visible = false
  _iU2.Visible = true
  _X6fw.Commands._KBz.Enabled = false
  _X6fw.Commands._XtaZ.Enabled = true
end
function _z1k:On_mKtM(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("\031$r\022<$5Kx\0225KxrIyyP\022\r\025o\022\031rP%\025$r\022\rI5\022#4cP\022,\025\127C"),
    Media = _wFXn,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _IHvVl("0\021I\022,I4\022$Kx\022,cx%\022;M\022%Ir\1275IoC\022\014\020\0254\022@$\025%%\025$KxP\022,\025$55\022)IyI\022jKx%Moy\016|\022,c\022\r$\025\022\020\025;IM\020\0254r\r\025\022OP4cxj\0225P\025K>PC\022<4I\127\022\rcKx\022oI%\022$o\022\021c4\016\022\r\0254\022jKx%M\025oy\016\025C0"),
          Media = _lNi,
          Callback = function(action)
            if action ~= nil then
              _rb262.Visible = false
              _z1k.Commands._mKtM.Enabled = false
              _z1k.Visible = false
              _rb262.Complete = true
              _ARXE.Visible = true
              _R0X.Commands._hQl.Enabled = false
              _DhVS.Active = true
              _DhVS.Visible = true
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function _8BjI2:On_abe6M(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0)Ix.\022\015I5\0225c%%\022$Kx\022\r\025rr\022o$P\022\r$\0255\025o\022jPIM\020>c4r.30\022"),
      Media = _FhQ
    },
    {
      Text = _IHvVl("0wrP\025r\022Io\022<%M55|\022\rI\022%$\025\127\025r\022\1274c55\025\022jP\025$r\025C\022)4c\020$\0254\025\022\0255\022oI%\022o$P\0225c\022\025$r\025o.0"),
      Media = _FhQ
    }
  }, function(action)
    _8BjI2.Commands._abe6M.Enabled = false
    _9GC.Visible = true
    _9GC.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _R42:On_mwEDr(target)
  _R42:MoveTo(Player)
  _R42.Commands._mwEDr.Enabled = false
  _xZeiV = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _R42:On_2OS(target)
  _R42:MoveTo(_sVsg)
  _R42.Visible = false
  _OOZ = true
  _R42.Commands._2OS.Enabled = false
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\015Mr\r\0254\020I4\0229\022\127\025rIM\022\rI5\022B$KxP$\127\025.0"),
      Media = _FxrG
    }
  }, function(action)
    if (_OOZ and _y2s) == true then
      _6dpA.Complete = true
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\n>IO|\022rMr\022xI\020\025\022$Kx\022I%%\025\022zMPIP\025r|\022\r$\025\022$Kx\022\0204IMKx\025C0"),
          Media = _FxrG
        }
      }, function(action)
        _GGD.Visible = false
        _GGD.Active = false
        _OAp:Start()
      end)
    else
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  end)
end
function _TC9:On_t3Kl2(target)
  _TC9:MoveTo(Player)
  _TC9.Commands._t3Kl2.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _TC9:On_or6e(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0#%\025$\020\022o$4\022rM4\022,\025\127\022o$P\022\r\025$r\025o\022jMoy\0169U4IMP.0"),
      Media = _mNiN
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _ae1:On_oT9(target)
  _ae1:MoveTo(Player)
  _ae1.Commands._oT9.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _ae1:On_Vao(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\031%\025r\r\0254\022(IM\127\025r$KxP5.\022\021M\022,$%%5P\022,cx%\022\r\025r\022(4Ir>\022@\0254\r\0254\020\025r3.0"),
      Media = _mNiN
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _iyQKG:On_L9Ier(target)
  _iyQKG:MoveTo(Player)
  _iyQKG.Commands._L9Ier.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _iyQKG:On_VCGb(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021M\022\0204$r\1275P\022o$4\022,cx%\022I\0205$KxP%$Kx\022\r$\025\022\016I%5Kx\025r\022zMPIP\025r30"),
      Media = _mNiN
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _O6CA:On_rmbA(target)
  _O6CA:MoveTo(Player)
  _O6CA.Commands._rmbA.Enabled = false
  _B1HWR.Commands._8Vda.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _fcBXk:On_TBtgJ(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("?o|\022x$\0254\022oM55\022$Kx\022,cx%\022\025$r\025r\022\017c\r\025\022\025$r\127\025\020\025rC\022\014\020\0254\022,c\022\016$r\r\025\022$Kx\022\r\025r3"),
    Media = _lRVX,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_49s)
        end)
      end
    end
  })
end
function _XoEWn:On_2gfWz(target)
  if _VjL1 == true then
    _Urwigo.MessageBox({
      Text = _IHvVl("\021$\025\022(M\0254\022$5P\022\016\0255P\022@\02545Kx%c55\025rC\022?$\0254\022>coo5P\022\rM\022$o\022~co\025rP\022r$KxP\022,\025$P\0254C"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _IHvVl("\019$\025%%\025$KxP\022>Irr\022o$4\022\006I\022\n\020\025%$t\022x$\0254\022x\025%\016\025r."),
            Media = _lRVX,
            Callback = function(action)
              if action ~= nil then
                _1LlI.Commands._fsM.Enabled = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _IHvVl("UM\025oo\0254\025\022\r$Kx\022%$\025\020\0254\022\02545P\022\025$roI%\022Mo\022\r\025r\022<c%P\0254>r\025KxP|\022r$KxP\022\rI55\022\0254\022,$\025\r\0254\022IM\016,IKxPC"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _mz3:On_FSbT(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0?I%%c|\022xI%%c.\022jKx%IM\020$\022x$\0254.\022\015$\025\022>Irr\022$Kx\022\r$4\022x\025%\016\025r3"),
      Media = _Va5Vc
    }
  }, function(action)
    if _SyVV == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0(\006I|\022\rI5\022$5P\022\rcKx\022rMr\022,$4>%$Kx\022>\025$r\025\022<4I\127\025\022\016M\0254\022o$Kx|\022c\r\02543\022jMKx\025\022xI%P\022@c4\022\n4PC\022\t4\127\025r\r,c\022,$4\r\022\r\0254\022(Oy\022\r\025r\022\017c\r\025\0225Kxcr\022@\02545P\025K>P\022xI\020\025r.0"),
          Media = _Va5Vc
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif (_3pXLP and _YOP) == true then
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_vyK)
      end)
    elseif _3pXLP == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0UM4;;\025$P\127\025\rI\025KxrP$5|\022,I53\022\014%5c\022rcKx\022oI%\002\022\021$\025\022\021$KxP\025\022$5P\022\rcKx\022I%5\022~I55\025\022\006\025\022\019c%Mo\025r\022\r\025\016$r$\0254PC0"),
          Media = _Va5Vc
        }
      }, function(action)
        _YOP = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_vyK)
        end)
      end)
    elseif (_Ec_B and _4Czl) == true then
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_B82T)
      end)
    elseif _Ec_B == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0?I5P\022\rM\022\025P,I\022\r$\025\022<c4o\025%\022\016M\0254\022\r$\025\022\021$KxP\025\020\0254\025KxrMr\127\022@\0254\127\02555\025r30]#BQ"),
          Media = _Va5Vc
        },
        {
          Text = _IHvVl("0\021$\025\022\021$KxP\025\022$5P\022\rcKx\022I%5\022~I55\025\022\006\025\022\019c%Mo\025r\022\r\025\016$r$\0254PC0"),
          Media = _Va5Vc
        }
      }, function(action)
        _4Czl = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_B82T)
        end)
      end)
    elseif (_tGG and _UWNT) == true then
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_Tsbxu)
      end)
    elseif _tGG == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\031rPPI\025M5Kx\025\022o$Kx\022\rcKx\022r$KxP.\022\021\0254\022#IM\0254\022oc\025KxP\025\022\0255\022\rcKx\022ZMI5$\022$r\022\025$r\025o\022\019$\0254P\025%\022\r\0254\022\020$5x\0254$\127\025r\022z\025$P\0225KxI\016\016\025r.0"),
          Media = _Va5Vc
        }
      }, function(action)
        _UWNT = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_Tsbxu)
        end)
      end)
    elseif (_mjR and _n55) == true then
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_fUpNo)
      end)
    elseif _mjR == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\026\025P;P\022M\025\020\0254%\025\127\025\022\rcKx\022oI%|\022,$\025\022%Ir\127\022\r\0254\022~$rMP\025r;\025$\127\0254\022\0204IMKxP|\022Mo\022\r\025r\022jPMr\r\025r;\025$\127\0254\022\025$roI%\022\025$r;Mxc%\025r.0"),
          Media = _Va5Vc
        }
      }, function(action)
        _n55 = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_fUpNo)
        end)
      end)
    elseif _WWequ == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\tKx\022\020$r\022;,I4\022>%M\127|\022I\020\0254\022>\025$r\022\127MP\0254\022U%\025PP\0254\0254C\022\014M\016\022\r\025r\022#IMo\022,$45P\022\rM\022,cx%\0225\025%\020\0254\022xcKx\022oM\02555\025r.0"),
          Media = _Va5Vc
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif (_03ZIq and _CkB6T) == true then
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_sOM)
      end)
    elseif _03ZIq == true then
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\014Kx\022>coo|\022\rI5\022$5P\022\rcKx\022\025$r\016IKxC\022?$\0254\022\127$\020P\022\0255\022\025$r\025\0225Kxc\025r\025\022<c4o\025%\002\022\f\022r.\022\f|\022\r$\025\022\rM\022rM4\022rcKx\022IM\016\022\rI5\022#\025$5y$\025%\022IryI55\025r\022oM55PC0"),
          Media = _Va5Vc
        }
      }, function(action)
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_sOM)
        end)
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = _IHvVl("0\021M\022xI5P\022\rcKx\022\127I4\022>\025$r\025\022<4I\127\025\022\016M\0254\022o$Kx|\022\rM\022(c\025%y\025%.0"),
          Media = _Va5Vc
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  end)
end
function _mz3:On_O7Dit(target)
  _Urwigo.OldDialog({
    {
      Text = _IHvVl("\tKx\022\127%IM\020\025\022r$KxPC\022\015\025rr\022$Kx\022\rI5\022rMr\022rcKx\022oI%\022\0204IMKx\0253."),
      Media = _lRVX
    }
  })
end
function _wAX8S:On_1sg(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("0F\025$r|\022\r$\025\022,$%%\022$Kx\022r$KxP\022o$P\022o$4\0224Mo5Kx%\025yy\025rC0"),
    Media = _lRVX,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _tOPQR:On_Neq(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021I5\022>Irr\022$Kx\022\r$4\022%\025$\r\0254\022r$KxP\022o$P\127\025\020\025rC\022\021I5\022$5P\022rM4\022\127\025\020c4\127PC0"),
      Media = _08NEq
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _jesTW:On_EemlN(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("\021M\0225$\025x5P\022\r$@\02545\025\022#M\025Kx\0254|\022B\025I\127\025r;\127%I\0255\0254\022Mr\r\022\025$r\022o\0254>,M\0254\r$\127\0255\022\021$r\127C0"),
    Callback = function(action)
      if action ~= nil then
        _g0Ve.Visible = true
        _g0Ve.Commands._jPTxh.Enabled = true
        _zPrhd.Visible = true
        _zPrhd.Commands._91W.Enabled = true
        _wAX8S.Visible = true
        _wAX8S.Commands._1sg.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _g0Ve:On_jPTxh(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0F\025$r.\022\021I5\0225$\025xP\022\127\025\016I\025x4%$Kx\022IM5|\022\rI5\022\016I55\022$Kx\022%$\025\020\0254\022r$KxP\022Ir.0"),
      Media = _lRVX
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _Ymdwd:On_ysz(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\015I5\0225c%%\022$Kx\022\r\025rr\022\006\025P;P\022\rIo$P.3\022\tKx\022\020$r\022IM\016\022\r\0254\022jMKx\025\022rIKx\022OP4cxj\022Mr\r\022xI\020\025\022\006\025P;P\022>\025$r\025\022z\025$P\022;Mo\022\"\0255\025r.0"),
      Media = _lRVX
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _zPrhd:On_91W(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\014x|\022$Kx\0225\025x\025\022\rM\022xI5P\022o\025$r\022>%\025$r\0255\022\015Mr\r\0254,\0254>\022\r\0254\022(\025Kxr$>\022\025rP\r\025K>P\002\022~\025$r\022jKx%IM\020$9)xcrC\022\015\025rr\022oIr\022\0255\022\020\025rMP;P|\022\020\025>cooP\022oIr\022\025$r\025\022\019\0254\020$r\rMr\127\022;M\022jKx%IM\020$\022$r\0225\025$r\0254\022#$\020%$cPx\025>C0\022"),
      Media = _08NEq
    },
    {
      Text = _IHvVl("0\0314\022>Irr\022\r$4\022@$\025%%\025$KxP\022\020\025x$%\016%$Kx\0225\025$r|\022,\025rr\022\rM\022$4\127\025r\r,c\022\020\025$\022\025$r\0254\022BI\025P5\025%\0164I\127\025\022r$KxP\022,\025$P\0254\022>coo5PC\022\014o\022\020\0255P\025r\022$Kx\022\127\025\020\025\022\0255\022\r$4\022o$PC0]#BQ"),
      Media = _08NEq
    }
  }, function(action)
    _mz3.Visible = true
    _zPrhd.Commands._91W.Enabled = false
    _zPrhd.Visible = false
    _mz3:MoveTo(Player)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _6eQ:On_R6NE(target)
  _Urwigo.Dialog(false, {
    {
      Text = _IHvVl("0\021I5\022\021$r\127\022$5P\022@\02545Kx%c55\025r.0"),
      Media = _lRVX
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _AHHb:On_EHS(target)
  _Urwigo.OldDialog({
    {
      Text = _IHvVl("F\025$r|\022\r$\025\022\127\025\020\025\022$Kx\022r$KxP\022x\0254C\022\021$\025\022,I4\022\025$r\022\004\0255Kx\025r>C"),
      Media = _lRVX
    }
  })
end
function _B5Z4:On_WRu(target)
  _Urwigo.OldDialog({
    {
      Text = _IHvVl("\021\0254\022$5P\022\rcKx\022@c%%\0254\022jIKx\025rC\022jc%%\022$Kx\022\r$\025\022\025P,I\022I%%\025\022\025$r;\025%r\022o$P\022o$4\0224MoP4I\127\025r3."),
      Media = _lRVX
    }
  })
end
function _8S_S:On_Lb2UH(target)
  _Urwigo.OldDialog({
    {
      Text = _IHvVl("jc,\025$P\022>cooP\022\0255\022rcKxC\022\021\025r\022P4$r>\025\022$Kx\022\016\025$r\0225\025%\0205\0254."),
      Media = _lRVX
    }
  })
end
function _QiH6:On_0v4N8(target)
  _Urwigo.MessageBox({
    Text = _IHvVl("\004%M\025K>,Mr5Kx.\022\021M\022xI5P\022\r$\0255\025\022~$55$cr\022\0254\016c%\1274\025$Kx\022\020\025\025r\r\025PC\022FcP$\0254\025\022\r$4\022rMr\022\r\025$r\025r\022wr%cK>9\017c\r\025."),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = string.sub(Player.CompletionCode, 1, 15),
          Callback = function(action)
            if action ~= nil then
              _Jfx.Complete = true
            end
          end
        })
      end
    end
  })
end
function _lH6q()
end
return _Jfx
