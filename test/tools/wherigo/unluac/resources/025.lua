require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _NLP(str)
  local res = ""
  local dtable = "\019@t\015;)\029|f9,b\003MuJwG%?Z*\n4\014RvF\006&L\028_\023W'Y\bV\t<0=sT\000\016hNy26\005QP-i5.dxz\021E\004(\024`[ >\0271\f\025o\aje\018]\0018\026c\017\0027\030a/qOB\\3k\020~!:+Up\"}r^\r$X{\022\031mKn\vSglCIAHD#"
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
_XqoB = Wherigo.ZCartridge()
_0WoU = Wherigo.ZMedia(_XqoB)
_0WoU.Id = "ec958186-a3cc-40b1-a4a1-ff6625730b38"
_0WoU.Name = _NLP("'9kxL")
_0WoU.Description = ""
_0WoU.AltText = ""
_0WoU.Resources = {
  {
    Type = "jpg",
    Filename = "Virgo.jpg",
    Directives = {}
  }
}
_fFsp = Wherigo.ZMedia(_XqoB)
_fFsp.Id = "fe0a2650-e1a9-4ab7-847c-523e26555520"
_fFsp.Name = _NLP("gk,ZF\014ZNLk")
_fFsp.Description = ""
_fFsp.AltText = ""
_fFsp.Resources = {
  {
    Type = "jpg",
    Filename = "UrsaMajor.jpg",
    Directives = {}
  }
}
_qmP = Wherigo.ZMedia(_XqoB)
_qmP.Id = "9b08c401-802d-42b5-b226-8a317c5f621d"
_qmP.Name = _NLP("}ZuxsZu*")
_qmP.Description = ""
_qmP.AltText = ""
_qmP.Resources = {
  {
    Type = "jpg",
    Filename = "Hangman0.jpg",
    Directives = {}
  }
}
_waAJ = Wherigo.ZMedia(_XqoB)
_waAJ.Id = "36fb5e93-7e86-45db-8510-5421fcde55ab"
_waAJ.Name = _NLP("-Z\015k\015,")
_waAJ.Description = ""
_waAJ.AltText = ""
_waAJ.Resources = {
  {
    Type = "jpg",
    Filename = "Taurus.jpg",
    Directives = {}
  }
}
_msl = Wherigo.ZMedia(_XqoB)
_msl.Id = "25c5a3e1-bac6-4fdb-9da5-5e777d3c27af"
_msl.Name = _NLP("}ZuxsZuI")
_msl.Description = ""
_msl.AltText = ""
_msl.Resources = {
  {
    Type = "jpg",
    Filename = "HangmanBlue1.jpg",
    Directives = {}
  }
}
_LUaC = Wherigo.ZMedia(_XqoB)
_LUaC.Id = "1b22621e-b815-467e-bee6-84a23cfee9b3"
_LUaC.Name = _NLP("wOkhOu,")
_LUaC.Description = ""
_LUaC.AltText = ""
_LUaC.Resources = {
  {
    Type = "jpg",
    Filename = "Serpens.jpg",
    Directives = {}
  }
}
_7D_Z8 = Wherigo.ZMedia(_XqoB)
_7D_Z8.Id = "445587c6-7bd2-4ef7-b845-fe5ddc344e36"
_7D_Z8.Name = _NLP("}ZuxsZu3")
_7D_Z8.Description = ""
_7D_Z8.AltText = ""
_7D_Z8.Resources = {
  {
    Type = "jpg",
    Filename = "HangmanBlue2.jpg",
    Directives = {}
  }
}
_fP2 = Wherigo.ZMedia(_XqoB)
_fP2.Id = "6d032e47-3338-4952-9d87-07a51d2e4de7"
_fP2.Name = _NLP("wULkh9\015,")
_fP2.Description = ""
_fP2.AltText = ""
_fP2.Resources = {
  {
    Type = "jpg",
    Filename = "Scorpius.jpg",
    Directives = {}
  }
}
_1Dr = Wherigo.ZMedia(_XqoB)
_1Dr.Id = "4b9f154a-c182-4687-bb8e-973fa8cc7925"
_1Dr.Name = _NLP("}ZuxsZu`")
_1Dr.Description = ""
_1Dr.AltText = ""
_1Dr.Resources = {
  {
    Type = "jpg",
    Filename = "HangmanBlue3.jpg",
    Directives = {}
  }
}
_vR3 = Wherigo.ZMedia(_XqoB)
_vR3.Id = "9e2d4dff-10e4-4dd0-9151-6d96526b6308"
_vR3.Name = _NLP("79,UO,")
_vR3.Description = ""
_vR3.AltText = ""
_vR3.Resources = {
  {
    Type = "jpg",
    Filename = "Pisces.jpg",
    Directives = {}
  }
}
_0ftHx = Wherigo.ZMedia(_XqoB)
_0ftHx.Id = "132d2bae-b9cc-4aa3-9e8a-e5f37ab8e48f"
_0ftHx.Name = _NLP("}ZuxsZu\024")
_0ftHx.Description = ""
_0ftHx.AltText = ""
_0ftHx.Resources = {
  {
    Type = "jpg",
    Filename = "HangmanBlue4.jpg",
    Directives = {}
  }
}
_lomYi = Wherigo.ZMedia(_XqoB)
_lomYi.Id = "9923e6fe-4718-4697-ba5b-4b0f0c1792a3"
_lomYi.Name = _NLP("7OxZ,\015,")
_lomYi.Description = ""
_lomYi.AltText = ""
_lomYi.Resources = {
  {
    Type = "jpg",
    Filename = "Pegasus.jpg",
    Directives = {}
  }
}
__EOY = Wherigo.ZMedia(_XqoB)
__EOY.Id = "f00d8641-dfa1-4a11-b38d-6968e3b45574"
__EOY.Name = _NLP("}ZuxsZu:")
__EOY.Description = ""
__EOY.AltText = ""
__EOY.Resources = {
  {
    Type = "jpg",
    Filename = "HangmanBlue5.jpg",
    Directives = {}
  }
}
_XiBp = Wherigo.ZMedia(_XqoB)
_XiBp.Id = "767e4f52-ca85-43a7-9a33-e46856c45bd9"
_XiBp.Name = _NLP("]k9Lu")
_XiBp.Description = ""
_XiBp.AltText = ""
_XiBp.Resources = {
  {
    Type = "jpg",
    Filename = "Orion.jpg",
    Directives = {}
  }
}
_ASkv = Wherigo.ZMedia(_XqoB)
_ASkv.Id = "745596f9-e5a7-47a4-90f5-bc047fd8e38a"
_ASkv.Name = _NLP("}ZuxsZu4")
_ASkv.Description = ""
_ASkv.AltText = ""
_ASkv.Resources = {
  {
    Type = "jpg",
    Filename = "HangmanBlue6.jpg",
    Directives = {}
  }
}
_K7r18 = Wherigo.ZMedia(_XqoB)
_K7r18.Id = "f71bd8be-a84e-401a-823e-e8708f50faa4"
_K7r18.Name = _NLP("\031ZUOk\003Z")
_K7r18.Description = ""
_K7r18.AltText = ""
_K7r18.Resources = {
  {
    Type = "jpg",
    Filename = "Lacerta.jpg",
    Directives = {}
  }
}
_6cxzz = Wherigo.ZMedia(_XqoB)
_6cxzz.Id = "a16c8dee-a909-410f-bf58-7d4b57177617"
_6cxzz.Name = _NLP("|u<kLsO<Z")
_6cxzz.Description = ""
_6cxzz.AltText = ""
_6cxzz.Resources = {
  {
    Type = "jpg",
    Filename = "Andromeda.jpg",
    Directives = {}
  }
}
_sOT = Wherigo.ZMedia(_XqoB)
_sOT.Id = "d6302bd2-7ef7-41c1-9448-70f1d78786cd"
_sOT.Name = _NLP("}2<kZ")
_sOT.Description = ""
_sOT.AltText = ""
_sOT.Resources = {
  {
    Type = "jpg",
    Filename = "Hydra.jpg",
    Directives = {}
  }
}
_sGnfw = Wherigo.ZMedia(_XqoB)
_sGnfw.Id = "1e42a380-d429-45a0-894d-715d6cf02bfa"
_sGnfw.Name = _NLP("^LL\003O,")
_sGnfw.Description = ""
_sGnfw.AltText = ""
_sGnfw.Resources = {
  {
    Type = "jpg",
    Filename = "Bootes.jpg",
    Directives = {}
  }
}
_EPJJA = Wherigo.ZMedia(_XqoB)
_EPJJA.Id = "31d124b6-75c9-40aa-b695-228c3fc57abc"
_EPJJA.Name = _NLP("}OkU\015yO,")
_EPJJA.Description = ""
_EPJJA.AltText = ""
_EPJJA.Resources = {
  {
    Type = "jpg",
    Filename = "Hercules.jpg",
    Directives = {}
  }
}
_CPLw = Wherigo.ZMedia(_XqoB)
_CPLw.Id = "1cccd64f-dd73-436c-84d1-06d19c4caddf"
_CPLw.Name = _NLP("zZuUOk")
_CPLw.Description = ""
_CPLw.AltText = ""
_CPLw.Resources = {
  {
    Type = "jpg",
    Filename = "Cancer.jpg",
    Directives = {}
  }
}
_8Lt = Wherigo.ZMedia(_XqoB)
_8Lt.Id = "7a47e054-3117-4717-8246-09c1feba109b"
_8Lt.Name = _NLP("\018Os9u9")
_8Lt.Description = ""
_8Lt.AltText = ""
_8Lt.Resources = {
  {
    Type = "jpg",
    Filename = "Gemini.jpg",
    Directives = {}
  }
}
_9m5eB = Wherigo.ZMedia(_XqoB)
_9m5eB.Id = "8208fb98-58ec-44a9-8ed8-8bb95f15e3aa"
_9m5eB.Name = _NLP("zZhk9kLku\015,")
_9m5eB.Description = ""
_9m5eB.AltText = ""
_9m5eB.Resources = {
  {
    Type = "jpg",
    Filename = "Capricornus.jpg",
    Directives = {}
  }
}
_y9R = Wherigo.ZMedia(_XqoB)
_y9R.Id = "151393f5-3468-4445-b3f6-88288c23d5b9"
_y9R.Name = _NLP("~kZUL")
_y9R.Description = ""
_y9R.AltText = ""
_y9R.Resources = {
  {
    Type = "jpg",
    Filename = "Draco.jpg",
    Directives = {}
  }
}
_YHKim = Wherigo.ZMedia(_XqoB)
_YHKim.Id = "f3792c29-ddeb-41a8-ae06-92f6bbe3faf6"
_YHKim.Name = _NLP("zLkLuZF^LkOZy9,")
_YHKim.Description = ""
_YHKim.AltText = ""
_YHKim.Resources = {
  {
    Type = "jpg",
    Filename = "CoronaBorealis.jpg",
    Directives = {}
  }
}
_qyVBM = Wherigo.ZMedia(_XqoB)
_qyVBM.Id = "b5f45ed1-4efa-4614-9cf6-6d4eb5061397"
_qyVBM.Name = _NLP("~Oyh09u\015,")
_qyVBM.Description = ""
_qyVBM.AltText = ""
_qyVBM.Resources = {
  {
    Type = "jpg",
    Filename = "Delphinus.jpg",
    Directives = {}
  }
}
_ytu = Wherigo.ZMedia(_XqoB)
_ytu.Id = "5b356873-5c4f-4bd7-9932-c90ae2537856"
_ytu.Name = _NLP("z2xu\015,")
_ytu.Description = ""
_ytu.AltText = ""
_ytu.Resources = {
  {
    Type = "jpg",
    Filename = "Cygnus.jpg",
    Directives = {}
  }
}
_SYce = Wherigo.ZMedia(_XqoB)
_SYce.Id = "ec690f13-69d8-4220-babc-0323025fabdb"
_SYce.Name = _NLP("wOk9L\015,F\028LLy")
_SYce.Description = ""
_SYce.AltText = ""
_SYce.Resources = {
  {
    Type = "jpg",
    Filename = "SeriousTool.jpg",
    Directives = {}
  }
}
_dzbu = Wherigo.ZMedia(_XqoB)
_dzbu.Id = "ed059aa3-0bb5-448a-bc89-b5cd07195a5d"
_dzbu.Name = _NLP("\014Zh")
_dzbu.Description = ""
_dzbu.AltText = ""
_dzbu.Resources = {
  {
    Type = "jpg",
    Filename = "Map.jpg",
    Directives = {}
  }
}
_ua6 = Wherigo.ZMedia(_XqoB)
_ua6.Id = "4899c742-f89c-4ee2-b56c-0a8d3ec7448e"
_ua6.Name = _NLP("tO2")
_ua6.Description = ""
_ua6.AltText = ""
_ua6.Resources = {
  {
    Type = "jpg",
    Filename = "Key.jpg",
    Directives = {}
  }
}
_fS3T = Wherigo.ZMedia(_XqoB)
_fS3T.Id = "f5a88f9f-caee-412f-91d7-6a72a73aa0f1"
_fS3T.Name = _NLP("zZ,,9LhO9Z")
_fS3T.Description = ""
_fS3T.AltText = ""
_fS3T.Resources = {
  {
    Type = "jpg",
    Filename = "Cassiopeia.jpg",
    Directives = {}
  }
}
_d3Hz = Wherigo.ZMedia(_XqoB)
_d3Hz.Id = "79d3b7aa-db76-4134-ac2a-688b7767957f"
_d3Hz.Name = _NLP("gk\0179xL")
_d3Hz.Description = ""
_d3Hz.AltText = ""
_d3Hz.Resources = {
  {
    Type = "jpg",
    Filename = "ConstellationsUrwigo.jpg",
    Directives = {}
  }
}
_VJ24 = Wherigo.ZMedia(_XqoB)
_VJ24.Id = "4ad8abd3-495f-416d-bed1-2dcd4343f307"
_VJ24.Name = _NLP("gk\0179xLwsZyy")
_VJ24.Description = ""
_VJ24.AltText = ""
_VJ24.Resources = {
  {
    Type = "jpg",
    Filename = "ConstallationsIcon.jpg",
    Directives = {}
  }
}
_XqoB.Id = "ed97648a-094a-4ded-b375-fb495fa20787"
_XqoB.Name = "Hangman Constellations Europe"
_XqoB.Description = "This is a short game of hangman which takes about 5 minutes from start to finish. Or does it? It all depends on you and your knowledge of the subject."
_XqoB.Visible = true
_XqoB.Activity = "Geocache"
_XqoB.StartingLocationDescription = "Play anywhere cartridge, you can even play it in your recliner."
_XqoB.StartingLocation = Wherigo.INVALID_ZONEPOINT
_XqoB.Version = "1.6"
_XqoB.Company = ""
_XqoB.Author = "marcipanek"
_XqoB.BuilderVersion = "URWIGO 1.21.5528.18461"
_XqoB.CreateDate = "03/17/2014 18:30:46"
_XqoB.PublishDate = "1/1/0001 12:00:00 AM"
_XqoB.UpdateDate = "11/13/2019 09:12:16"
_XqoB.LastPlayedDate = "1/1/0001 12:00:00 AM"
_XqoB.TargetDevice = "PocketPC"
_XqoB.TargetDeviceVersion = "0"
_XqoB.StateId = "1"
_XqoB.CountryId = "2"
_XqoB.Complete = false
_XqoB.UseLogging = true
_XqoB.Media = _d3Hz
_XqoB.Icon = _VJ24
_RZK = Wherigo.ZItem(_XqoB)
_RZK.Id = "ed454e65-16ab-4ef6-8d96-75a1392a01da"
_RZK.Name = _NLP("\014Zh")
_RZK.Description = ""
_RZK.Visible = true
_RZK.Media = _dzbu
_RZK.Commands = {}
_RZK.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_RZK.Locked = false
_RZK.Opened = false
_2JK6N = Wherigo.ZItem(_XqoB)
_2JK6N.Id = "01da3bed-8bb9-4b3b-923c-2d96a2521350"
_2JK6N.Name = _NLP("tO2")
_2JK6N.Description = ""
_2JK6N.Visible = true
_2JK6N.Media = _ua6
_2JK6N.Commands = {}
_2JK6N.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2JK6N.Locked = false
_2JK6N.Opened = false
_VhJZ = false
_NqDlv = 0
_zPRqT = 0
_zOt = false
_nHTNF = false
_pdaGX = false
_p47 = false
_SHX = false
_fPHy = false
_j5F = false
_xlr = false
_SHL = false
_mw4bA = false
_1hj = false
_ZuAD = false
_2ZRIa = false
_uw2 = false
_7NuG8 = false
_vvDG = false
_5EQ = false
_RrjV = false
_lS5 = false
_AFa = false
_LG3ab = _NLP("<\015ss2")
_FIG = _NLP("<\015ss2")
_m3D_ = _NLP("!\026\021t")
_9R8ub = _NLP("<\015ss2")
_tdl = _NLP("!#\016ug")
_fCGvU = _NLP("!]N`uy")
_XqoB.ZVariables = {
  _VhJZ = false,
  _NqDlv = 0,
  _zPRqT = 0,
  _zOt = false,
  _nHTNF = false,
  _pdaGX = false,
  _p47 = false,
  _SHX = false,
  _fPHy = false,
  _j5F = false,
  _xlr = false,
  _SHL = false,
  _mw4bA = false,
  _1hj = false,
  _ZuAD = false,
  _2ZRIa = false,
  _uw2 = false,
  _7NuG8 = false,
  _vvDG = false,
  _5EQ = false,
  _RrjV = false,
  _lS5 = false,
  _AFa = false,
  _LG3ab = _NLP("<\015ss2"),
  _FIG = _NLP("<\015ss2"),
  _m3D_ = _NLP("!\026\021t"),
  _9R8ub = _NLP("<\015ss2"),
  _tdl = _NLP("!#\016ug"),
  _fCGvU = _NLP("!]N`uy")
}
_Oj3nl = Wherigo.ZTimer(_XqoB)
_Oj3nl.Id = "25c3af40-3492-4fa5-9e27-42f742e0f263"
_Oj3nl.Name = _NLP("\018ZsOF<\015kZ\0039Lu")
_Oj3nl.Description = ""
_Oj3nl.Visible = true
_Oj3nl.Duration = 120
_Oj3nl.Type = "Countdown"
_WJnU = Wherigo.ZInput(_XqoB)
_WJnU.Id = "b4fcd062-dd17-482e-8dfd-c9d00fb54d75"
_WJnU.Name = _NLP("|u<kLsO<Z")
_WJnU.Description = ""
_WJnU.Visible = true
_WJnU.Media = _6cxzz
_WJnU.Choices = {
  "Ursa Major",
  "Andromeda",
  "Delphinus"
}
_WJnU.InputType = "MultipleChoice"
_WJnU.Text = ""
_lQ84M = Wherigo.ZInput(_XqoB)
_lQ84M.Id = "ee8bab14-d640-442b-a150-173e52fec9c1"
_lQ84M.Name = _NLP("gk,ZF\014ZNLk")
_lQ84M.Description = ""
_lQ84M.Visible = true
_lQ84M.Media = _fFsp
_lQ84M.Choices = {
  "Ursa Major",
  "Serpens",
  "Cygnus"
}
_lQ84M.InputType = "MultipleChoice"
_lQ84M.Text = ""
_V7N = Wherigo.ZInput(_XqoB)
_V7N.Id = "2a61c265-32fb-4632-a828-e3ae10a2209d"
_V7N.Name = _NLP("7OxZ,\015,")
_V7N.Description = ""
_V7N.Visible = true
_V7N.Media = _lomYi
_V7N.Choices = {
  "Pegasus",
  "Sagitarius",
  "Aquarius"
}
_V7N.InputType = "MultipleChoice"
_V7N.Text = ""
_k_7s = Wherigo.ZInput(_XqoB)
_k_7s.Id = "3472d1ba-18be-4b6b-b251-b89d24c97933"
_k_7s.Name = _NLP("]k9Lu")
_k_7s.Description = ""
_k_7s.Visible = true
_k_7s.Media = _XiBp
_k_7s.Choices = {
  "Ursa Major",
  "Orion",
  "Taurus"
}
_k_7s.InputType = "MultipleChoice"
_k_7s.Text = ""
_QAqS = Wherigo.ZInput(_XqoB)
_QAqS.Id = "bdb51415-69ae-4f55-8f6a-63b76115f9f9"
_QAqS.Name = _NLP("^LL\003O,")
_QAqS.Description = ""
_QAqS.Visible = true
_QAqS.Media = _sGnfw
_QAqS.Choices = {
  "Cancer",
  "Perseus",
  "Bootes"
}
_QAqS.InputType = "MultipleChoice"
_QAqS.Text = ""
_YGG = Wherigo.ZInput(_XqoB)
_YGG.Id = "bd663797-db2b-477d-80a0-04437caa0576"
_YGG.Name = _NLP("\031ZUOk\003Z")
_YGG.Description = ""
_YGG.Visible = true
_YGG.Media = _K7r18
_YGG.Choices = {
  "Lacerta",
  "Libra",
  "Cepheus"
}
_YGG.InputType = "MultipleChoice"
_YGG.Text = ""
_vhp_t = Wherigo.ZInput(_XqoB)
_vhp_t.Id = "74d1f495-2171-4bbc-b522-7fc244377ee1"
_vhp_t.Name = _NLP("zZuUOk")
_vhp_t.Description = ""
_vhp_t.Visible = true
_vhp_t.Media = _CPLw
_vhp_t.Choices = {
  "Virgo",
  "Cancer",
  "Hydra"
}
_vhp_t.InputType = "MultipleChoice"
_vhp_t.Text = ""
_eh1h = Wherigo.ZInput(_XqoB)
_eh1h.Id = "ba23f11a-1127-4159-802c-f40ccf85c192"
_eh1h.Name = _NLP("}2<kZ")
_eh1h.Description = ""
_eh1h.Visible = true
_eh1h.Media = _sOT
_eh1h.Choices = {
  "Sagitarius",
  "Hydra",
  "Pisces"
}
_eh1h.InputType = "MultipleChoice"
_eh1h.Text = ""
_ypT = Wherigo.ZInput(_XqoB)
_ypT.Id = "204c4520-6189-4948-9750-59c6659d8c9f"
_ypT.Name = _NLP("zZhk9ULku\015,")
_ypT.Description = ""
_ypT.Visible = true
_ypT.Media = _9m5eB
_ypT.Choices = {
  "Capricornus",
  "Cancer",
  "Lepus"
}
_ypT.InputType = "MultipleChoice"
_ypT.Text = ""
_xDY = Wherigo.ZInput(_XqoB)
_xDY.Id = "16e61573-d61c-423e-8d53-d714a385ebf9"
_xDY.Name = _NLP("}OkU\015yO,")
_xDY.Description = ""
_xDY.Visible = true
_xDY.Media = _EPJJA
_xDY.Choices = {
  "Hercules",
  "Pisces",
  "Scorpius"
}
_xDY.InputType = "MultipleChoice"
_xDY.Text = ""
_MsHA = Wherigo.ZInput(_XqoB)
_MsHA.Id = "7f0e2c54-138b-478c-8ddf-94747f122caa"
_MsHA.Name = _NLP("zLkLuZF^LkOZy9,")
_MsHA.Description = ""
_MsHA.Visible = true
_MsHA.Media = _YHKim
_MsHA.Choices = {
  "Cassiopeia",
  "Hercules",
  "Corona Borealis"
}
_MsHA.InputType = "MultipleChoice"
_MsHA.Text = ""
_F9UM = Wherigo.ZInput(_XqoB)
_F9UM.Id = "74910c75-ccd5-401e-a7b7-7b9bff241e3a"
_F9UM.Name = _NLP("\018Os9u9")
_F9UM.Description = ""
_F9UM.Visible = true
_F9UM.Media = _8Lt
_F9UM.Choices = {
  "Libra",
  "Gemini",
  "Perseus"
}
_F9UM.InputType = "MultipleChoice"
_F9UM.Text = ""
_6iPj = Wherigo.ZInput(_XqoB)
_6iPj.Id = "56761886-cec4-4971-be44-5dd9135c8129"
_6iPj.Name = _NLP("z2xu\015,")
_6iPj.Description = ""
_6iPj.Visible = true
_6iPj.Media = _ytu
_6iPj.Choices = {
  "Cygnus",
  "Leo",
  "Lepus"
}
_6iPj.InputType = "MultipleChoice"
_6iPj.Text = ""
_HE8 = Wherigo.ZInput(_XqoB)
_HE8.Id = "08a3cd80-ca34-42f5-9ec5-3b3fac435ac0"
_HE8.Name = _NLP("~kZUL")
_HE8.Description = ""
_HE8.Visible = true
_HE8.Media = _y9R
_HE8.Choices = {
  "Draco",
  "Cygnus",
  "Gemini"
}
_HE8.InputType = "MultipleChoice"
_HE8.Text = ""
_Ngyck = Wherigo.ZInput(_XqoB)
_Ngyck.Id = "2e8eb06c-25e4-4a8a-ba01-8efe79ff28eb"
_Ngyck.Name = _NLP("~Oyh09u\015,")
_Ngyck.Description = ""
_Ngyck.Visible = true
_Ngyck.Media = _qyVBM
_Ngyck.Choices = {
  "Cygnus",
  "Leo",
  "Delphinus"
}
_Ngyck.InputType = "MultipleChoice"
_Ngyck.Text = ""
_jeBRf = Wherigo.ZInput(_XqoB)
_jeBRf.Id = "72ef22ef-8695-4ce7-8992-ca1273b60d0b"
_jeBRf.Name = _NLP("-Z\015k\015,")
_jeBRf.Description = ""
_jeBRf.Visible = true
_jeBRf.Media = _waAJ
_jeBRf.Choices = {
  "Taurus",
  "Serpens",
  "Draco"
}
_jeBRf.InputType = "MultipleChoice"
_jeBRf.Text = ""
_Zaj5 = Wherigo.ZInput(_XqoB)
_Zaj5.Id = "acef8cee-ada8-420a-92af-b688739e9b64"
_Zaj5.Name = _NLP("wOkhOu,")
_Zaj5.Description = ""
_Zaj5.Visible = true
_Zaj5.Media = _LUaC
_Zaj5.Choices = {
  "Virgo",
  "Serpens",
  "Lepus"
}
_Zaj5.InputType = "MultipleChoice"
_Zaj5.Text = ""
_ZSXF = Wherigo.ZInput(_XqoB)
_ZSXF.Id = "baccb4a2-5ede-48a3-8477-4cf642a8d064"
_ZSXF.Name = _NLP("79,UO,")
_ZSXF.Description = ""
_ZSXF.Visible = true
_ZSXF.Media = _vR3
_ZSXF.Choices = {
  "Aries",
  "Pisces",
  "Ophiuchus"
}
_ZSXF.InputType = "MultipleChoice"
_ZSXF.Text = ""
_YDN7 = Wherigo.ZInput(_XqoB)
_YDN7.Id = "7af33f23-6855-4df3-af86-0eda76d8e801"
_YDN7.Name = _NLP("wULkh9\015,")
_YDN7.Description = ""
_YDN7.Visible = true
_YDN7.Media = _fP2
_YDN7.Choices = {
  "Aquila",
  "Aquarius",
  "Scorpius"
}
_YDN7.InputType = "MultipleChoice"
_YDN7.Text = ""
_DoemR = Wherigo.ZInput(_XqoB)
_DoemR.Id = "3ff3d495-4531-494d-9d7a-4a5c9289430b"
_DoemR.Name = _NLP("'9kxL")
_DoemR.Description = ""
_DoemR.Visible = true
_DoemR.Media = _0WoU
_DoemR.Choices = {
  "Capricornus",
  "Virgo",
  "Andromeda"
}
_DoemR.InputType = "MultipleChoice"
_DoemR.Text = ""
_Slro = Wherigo.ZInput(_XqoB)
_Slro.Id = "9483efff-f417-4ddc-ab3b-66ecb0620c39"
_Slro.Name = _NLP("zZ,,9LhO9Z")
_Slro.Description = ""
_Slro.Visible = true
_Slro.Media = _fS3T
_Slro.Choices = {
  "Cepheus",
  "Orion",
  "Cassiopeia"
}
_Slro.InputType = "MultipleChoice"
_Slro.Text = ""
function _XqoB:OnStart()
  _RZK.Description = _NLP("-0OFxOLUZU0OF9,FyLUZ\003O<FZ\003eF)^\026G1F:3F33;:\024:F@F**\024F:`;I\n`;)^\026G1L\017FxLF\t9u<F9\003d")
  _Urwigo.Dialog(false, {
    {
      Text = (_NLP("}9F") .. Player.Name) .. _NLP("dF\0142FuZsOF9,FwOk9L\015,\028LLy;F%L\015Fs9x0\003FkOsOs\fOkFsOF\tkLsFiwOk9L\015,\028LLy$,F\014\015xxy9uxF\026ZshZxOiF\0170Ok9xLFUZk\003k9<xO;"),
      Media = _SYce
    },
    {
      Text = _NLP("^O,9<O,F\fO9uxF\014k;F}Zu<,LsO\vF{$sFZy,LF\0030OFxkOZ\003O,\003FO<\015UZ\003LkFO\027OkF\003LF\017ZyaF\0030OFOZk\0030;"),
      Media = _SYce
    },
    {
      Text = _NLP("{$\027OFhkOhZkO<FZFy9\003\003yOFxZsOFL\tF0ZuxsZuF\003LF\003O,\003F2L\015kFauL\017yO<xOFL\tFULu,\003OyyZ\0039Lu,;"),
      Media = _SYce
    },
    {
      Text = _NLP("%L\015$kOFxL9uxF\003LF0Z\027OF3Fs9u\015\003O,F\003LFx\015O,,FI:FULu,\003OyyZ\0039Lu,;F-LFsZaOF9\003FOZ,9OkFLuF2L\015\vF{$\027OFsZ<OF9\003Fs\015y\0039hyOFU0L9UO;"),
      Media = _SYce
    },
    {
      Text = _NLP("wLFZkOF2L\015FkOZ<2\020F-0OF\0039sOkF,\003Zk\003,F\0170OuF2L\015FUy9UaF\0030OFLaF\f\015\003\003Lu;F\018LL<Fy\015Ua;"),
      Media = _SYce
    }
  }, function(action)
    _Oj3nl:Start()
    _wNs()
  end)
end
function _XqoB:OnRestore()
  _Oj3nl:Stop()
  if Player:Contains(_RZK) then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _RZK.Description = _NLP("-0OFxOLUZU0OF9,FyLUZ\003O<FZ\003eF)^\026G1F:3F33;:\024:F@F**\024F:`;I\n`;)^\026G-0OF09u\003eF1L\017FxLF\t9u<F9\003d")
    _Urwigo.Dialog(false, {
      {
        Text = (_NLP("}9F") .. Player.Name) .. _NLP("dF\0142FuZsOF9,FwOk9L\015,\028LLy;F%L\015Fs9x0\003FkOsOs\fOkFsOF\tkLsFiwOk9L\015,\028LLy$,F\014\015xxy9uxF\026ZshZxOiF\0170Ok9xLFUZk\003k9<xO;"),
        Media = _SYce
      },
      {
        Text = _NLP("^O,9<O,F\fO9uxF\014k;F}Zu<,LsO\vF{$sFZy,LF\0030OFxkOZ\003O,\003FO<\015UZ\003LkFO\027OkF\003LF\017ZyaF\0030OFOZk\0030;"),
        Media = _SYce
      },
      {
        Text = _NLP("{$\027OFhkOhZkO<FZFy9\003\003yOFxZsOFL\tF0ZuxsZuF\003LF\003O,\003F2L\015kFauL\017yO<xOFL\tFULu,\003OyyZ\0039Lu,;"),
        Media = _SYce
      },
      {
        Text = _NLP("%L\015$kOFxL9uxF\003LF0Z\027OF3Fs9u\015\003O,F\003LFx\015O,,FI:FULu,\003OyyZ\0039Lu,;F-LFsZaOF9\003FOZ,9OkFLuF2L\015\vF{$\027OFsZ<OF9\003Fs\015y\0039hyOFU0L9UO;"),
        Media = _SYce
      },
      {
        Text = _NLP("wLFZkOF2L\015FkOZ<2\020F-0OF\0039sOkF,\003Zk\003,F\0170OuF2L\015FUy9UaF\0030OFLaF\f\015\003\003Lu;F\018LL<Fy\015Ua;"),
        Media = _SYce
      }
    }, function(action)
      _Oj3nl:Start()
      _wNs()
    end)
  end
end
function _WJnU:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 31963 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _lQ84M:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 16298 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _V7N:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 21530 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _k_7s:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 5471 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _QAqS:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 62637 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _YGG:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 60024 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _vhp_t:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 18595 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _eh1h:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 44091 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _ypT:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13931 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _xDY:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 52922 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _MsHA:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 21062 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _F9UM:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 32779 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _6iPj:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 30242 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _HE8:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 645 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _Ngyck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 58377 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _jeBRf:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 27451 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _Zaj5:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 41047 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _ZSXF:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 4926 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _YDN7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 8723 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _DoemR:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 1080 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _Slro:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 39540 then
    _NqDlv = _NqDlv + 1
    _wNs()
  else
    _HdGk()
  end
end
function _Oj3nl:OnTick()
  _Urwigo.MessageBox({
    Text = _NLP("%L\015$\027OFkZuFL\015\003FL\tF\0039sOdF\030u\f,h\005#L\015y<F2L\015Fy9aOF\003LFhyZ2FZxZ9u\020"),
    Media = _SYce,
    Buttons = {
      _NLP("%O,d"),
      _NLP("1Ld")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _hGq()
        elseif action == "Button2" then
          Wherigo.Command("SaveClose")
        end
      end
    end
  })
end
function _wNs()
  if _NqDlv == 15 then
    _Oj3nl:Stop()
    _XqoB.Complete = true
    _2JK6N.Description = (_NLP("%L\015kFzLshyO\0039LuFzL<OF9,F") .. string.sub(Player.CompletionCode, 1, 15)) .. _NLP(";F#k9\003OF9\003F<L\017uFUZkO\t\015yy2;F%L\015F\0179yyFuOO<F9\003F\003LF\015uyLUaF\00309,FUZk\003k9<xOFZ,FULshyO\003O<FZ\003F#0Ok9xL;ULs;")
    _RZK:MoveTo(Player)
    _2JK6N:MoveTo(Player)
    _XqoB:RequestSync()
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("zLuxkZ\003\015yZ\0039LudF%L\015$\027OFxL\003F9\003Fk9x0\003d"),
        Media = _SYce
      },
      {
        Text = _NLP("|,FZFkO\017Zk<F{$yyFyO\003F2L\015FauL\017F\0170OkOF2L\015FUZuF\t9u<F\0030OFxOLUZU0O;"),
        Media = _SYce
      },
      {
        Text = _NLP("}OkOF9,F\0030OFyLUZ\0039LuFZu<FUL<OF\003LF\015uyLUaF\00309,FUZk\003k9<xOFZ,FULshyO\003O<FZ\003F#0Ok9xL;ULs;F{FZhhkOU9Z\003OFZu2F\tOO<\fZUaF2L\015FyOZ\027OFLuF\0030Z\003F,9\003O;"),
        Media = _SYce
      },
      {
        Text = _NLP("%L\015FUZuF\t9u<F\0030OFULLk<,FZu<F\0030OFaO2F9uF2L\015kF9u\027Ou\003Lk2;F"),
        Media = _SYce
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _RZK)
    end)
  else
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.0476190476190476 then
      if _VhJZ == false then
        _VhJZ = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_WJnU)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.0952380952380952 then
      if _zOt == false then
        _zOt = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_QAqS)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.142857142857143 then
      if _p47 == false then
        _p47 = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_vhp_t)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.19047619047619 then
      if _fPHy == false then
        _fPHy = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_ypT)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.238095238095238 then
      if _xlr == false then
        _xlr = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_MsHA)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.285714285714286 then
      if _mw4bA == false then
        _mw4bA = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_6iPj)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.333333333333333 then
      if _ZuAD == false then
        _ZuAD = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_Ngyck)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.380952380952381 then
      if _uw2 == false then
        _uw2 = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_HE8)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.428571428571429 then
      if _vvDG == false then
        _vvDG = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_F9UM)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.476190476190476 then
      if _RrjV == false then
        _RrjV = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_xDY)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.523809523809524 then
      if _lS5 == false then
        _lS5 = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_eh1h)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.571428571428571 then
      if _5EQ == false then
        _5EQ = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_YGG)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.619047619047619 then
      if _nHTNF == false then
        _nHTNF = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_DoemR)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.666666666666667 then
      if _1hj == false then
        _1hj = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_ZSXF)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.714285714285714 then
      if _SHL == false then
        _SHL = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_YDN7)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.761904761904762 then
      if _j5F == false then
        _j5F = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_Zaj5)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.80952380952381 then
      if _SHX == false then
        _SHX = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_jeBRf)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.857142857142857 then
      if _7NuG8 == false then
        _7NuG8 = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_k_7s)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.904761904761905 then
      if _2ZRIa == false then
        _2ZRIa = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_V7N)
        end)
      else
        _wNs()
      end
    elseif _rndChoiceValue < 0.952380952380953 then
      if _pdaGX == false then
        _pdaGX = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_lQ84M)
        end)
      else
        _wNs()
      end
    elseif _AFa == false then
      _AFa = true
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_Slro)
      end)
    else
      _wNs()
    end
  end
end
function _HdGk()
  if _zPRqT == 0 then
    _zPRqT = _zPRqT + 1
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("1LhOd"),
        Media = _qmP
      }
    }, function(action)
      _wNs()
    end)
  elseif _zPRqT == 1 then
    _zPRqT = _zPRqT + 1
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("#kLuxFZxZ9ud"),
        Media = _msl
      }
    }, function(action)
      _wNs()
    end)
  elseif _zPRqT == 2 then
    _zPRqT = _zPRqT + 1
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("#0Z\003F\017OkOF2L\015F\00309ua9ux\020"),
        Media = _7D_Z8
      }
    }, function(action)
      _wNs()
    end)
  elseif _zPRqT == 3 then
    _zPRqT = _zPRqT + 1
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("%OZ0dF\0269x0\003d"),
        Media = _1Dr
      }
    }, function(action)
      _wNs()
    end)
  elseif _zPRqT == 4 then
    _zPRqT = _zPRqT + 1
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("1L\003FO\027OuFUyL,Od"),
        Media = _0ftHx
      }
    }, function(action)
      _wNs()
    end)
  elseif _zPRqT == 5 then
    _zPRqT = _zPRqT + 1
    _Urwigo.Dialog(false, {
      {
        Text = _NLP("%L\015F\0179,0d"),
        Media = __EOY
      }
    }, function(action)
      _wNs()
    end)
  elseif _zPRqT == 6 then
    _zPRqT = _zPRqT + 1
    _Oj3nl:Stop()
    _Urwigo.MessageBox({
      Text = "",
      Media = _ASkv,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _NLP("%L\015$kOF<LuOdF#L\015y<F2L\015Fy9aOF\003LFhyZ2FZxZ9u\020"),
            Media = _SYce,
            Buttons = {
              _NLP("%O,d"),
              _NLP("1Ld")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  _hGq()
                  _Oj3nl:Start()
                  _wNs()
                elseif action == "Button2" then
                  _hGq()
                  Wherigo.Command("SaveClose")
                end
              end
            end
          })
        end
      end
    })
  end
end
function _hGq()
  _VhJZ = false
  _zOt = false
  _nHTNF = false
  _pdaGX = false
  _p47 = false
  _SHX = false
  _fPHy = false
  _j5F = false
  _xlr = false
  _SHL = false
  _mw4bA = false
  _1hj = false
  _ZuAD = false
  _2ZRIa = false
  _uw2 = false
  _7NuG8 = false
  _vvDG = false
  _5EQ = false
  _RrjV = false
  _lS5 = false
  _AFa = false
  _NqDlv = 0
  _zPRqT = 0
end
return _XqoB
