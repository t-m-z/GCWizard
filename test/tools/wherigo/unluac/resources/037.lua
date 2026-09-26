require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _jZ4Z(str)
  local res = ""
  local dtable = "2;f\nV\018\0054?'_GUJD\001\r+pN\016k,neO5}{$=6[\a\023]\015SF\024L\019\"mYr 9\002Z0KRw<\027E|\\\003:-qPx(sg@th1X\bcuz\031\025CQMi\021!\014&%\029\017\fI\t\020Tj`)dy.\022/\v3\000vo*W8bH7\006\028BAl~^a>\030\026\004#"
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
_B29S = Wherigo.ZCartridge()
_d_A = Wherigo.ZMedia(_B29S)
_d_A.Id = "85ad178c-229f-4b34-b8e9-9baf48308668"
_d_A.Name = _jZ4Z("9.Mz\025Gw\025.")
_d_A.Description = ""
_d_A.AltText = ""
_d_A.Resources = {
  {
    Type = "jpg",
    Filename = "erzahler.jpg",
    Directives = {}
  }
}
_p8M = Wherigo.ZMedia(_B29S)
_p8M.Id = "9ee4a7af-203a-466c-b10f-803f97fa43cb"
_p8M.Name = _jZ4Z("SKl>9.Mz\025Gw\025.")
_p8M.Description = ""
_p8M.AltText = ""
_p8M.Resources = {
  {
    Type = "jpg",
    Filename = "ico-erzahler.jpg",
    Directives = {}
  }
}
_E7h = Wherigo.ZMedia(_B29S)
_E7h.Id = "02b0db86-fa65-4308-89b9-5194f5971556"
_E7h.Name = _jZ4Z("4ll.cS\024zF\025\024")
_E7h.Description = ""
_E7h.AltText = ""
_E7h.Resources = {
  {
    Type = "jpg",
    Filename = "koordinaten.jpg",
    Directives = {}
  }
}
_E0fT = Wherigo.ZMedia(_B29S)
_E0fT.Id = "c654fd4c-8d8e-445a-b354-20922b1280ae"
_E0fT.Name = _jZ4Z("SKl>4ll.cS\024zF\025\024")
_E0fT.Description = ""
_E0fT.AltText = ""
_E0fT.Resources = {
  {
    Type = "jpg",
    Filename = "ico-koordinaten.jpg",
    Directives = {}
  }
}
_MA38 = Wherigo.ZMedia(_B29S)
_MA38.Id = "88a43322-3c9e-476e-9ac3-e836efa7abc2"
_MA38.Name = _jZ4Z("&\019lSw\025.")
_MA38.Description = ""
_MA38.AltText = ""
_MA38.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler.jpg",
    Directives = {}
  }
}
_Ty93 = Wherigo.ZMedia(_B29S)
_Ty93.Id = "028d3738-4646-4efa-a5e6-6e2cfa53873b"
_Ty93.Name = _jZ4Z("SKl>&\019lSw\025.")
_Ty93.Description = ""
_Ty93.AltText = ""
_Ty93.Resources = {
  {
    Type = "jpg",
    Filename = "ico-spoiler.jpg",
    Directives = {}
  }
}
_RV48 = Wherigo.ZMedia(_B29S)
_RV48.Id = "513dbedc-345e-40d2-bd8b-ead2803d3ed8"
_RV48.Name = _jZ4Z(")lDpLKG")
_RV48.Description = ""
_RV48.AltText = ""
_RV48.Resources = {
  {
    Type = "jpg",
    Filename = "grundbuch.jpg",
    Directives = {}
  }
}
_n6o = Wherigo.ZMedia(_B29S)
_n6o.Id = "60f48659-db11-4a15-8b97-bf6d71856064"
_n6o.Name = _jZ4Z("SKl>)lDpLKG")
_n6o.Description = ""
_n6o.AltText = ""
_n6o.Resources = {
  {
    Type = "jpg",
    Filename = "ico-grundbuch.jpg",
    Directives = {}
  }
}
_DhsSs = Wherigo.ZMedia(_B29S)
_DhsSs.Id = "f68c2346-ad51-408e-9207-667f96f12cf7"
_DhsSs.Name = _jZ4Z("zLcSl>wzKG\025\024")
_DhsSs.Description = ""
_DhsSs.AltText = ""
_DhsSs.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-3987050-langes-schaebiges-lachen.mp3",
    Directives = {}
  }
}
_HVs = Wherigo.ZMedia(_B29S)
_HVs.Id = "4eb6b4ab-37f0-48e8-bcad-6160786fb47f"
_HVs.Name = _jZ4Z("zLcSl>9S\024Dzp\025\003\025Gw\025.")
_HVs.Description = ""
_HVs.AltText = ""
_HVs.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-4265912-lachen-ausgiebig-mit-ein.mp3",
    Directives = {}
  }
}
_v6UP = Wherigo.ZMedia(_B29S)
_v6UP.Id = "3733fc90-b707-4f0a-8f2a-0a4e117584e3"
_v6UP.Name = _jZ4Z("CSwzC")
_v6UP.Description = ""
_v6UP.AltText = ""
_v6UP.Resources = {
  {
    Type = "jpg",
    Filename = "silas.jpg",
    Directives = {}
  }
}
_pI1uN = Wherigo.ZMedia(_B29S)
_pI1uN.Id = "fb95734c-3e80-4201-b1dd-f2ae9650cb27"
_pI1uN.Name = _jZ4Z("SKl>CSwzC")
_pI1uN.Description = ""
_pI1uN.AltText = ""
_pI1uN.Resources = {
  {
    Type = "jpg",
    Filename = "ico-silas.jpg",
    Directives = {}
  }
}
_cqx = Wherigo.ZMedia(_B29S)
_cqx.Id = "8f3a0cde-f23a-4a18-8da5-a940bf9a0478"
_cqx.Name = _jZ4Z("zLcSl>?LS\025FCKG\025\024")
_cqx.Description = ""
_cqx.AltText = ""
_cqx.Resources = {
  {
    Type = "mp3",
    Filename = "salamisound-1142953-alte-quietschende-tuer-langsam.mp3",
    Directives = {}
  }
}
_6JL0 = Wherigo.ZMedia(_B29S)
_6JL0.Id = "24e3a589-d9e5-44fa-8b45-c66b42d554ff"
_6JL0.Name = _jZ4Z("\015.\025GCKG\025Sp\025")
_6JL0.Description = ""
_6JL0.AltText = ""
_6JL0.Resources = {
  {
    Type = "jpg",
    Filename = "Drehscheibe.jpg",
    Directives = {}
  }
}
_sKVqq = Wherigo.ZMedia(_B29S)
_sKVqq.Id = "80d7140c-4bac-472e-807f-471a99099097"
_sKVqq.Name = _jZ4Z("SKl>\015.\025GCKG\025Sp\025")
_sKVqq.Description = ""
_sKVqq.AltText = ""
_sKVqq.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Drehscheibe.jpg",
    Directives = {}
  }
}
_tSJY = Wherigo.ZMedia(_B29S)
_tSJY.Id = "332bd7ba-53cc-43e3-af8b-bee0f7f49121"
_tSJY.Name = _jZ4Z("4z.F\025>u")
_tSJY.Description = ""
_tSJY.AltText = ""
_tSJY.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-B-aussen.jpg",
    Directives = {}
  }
}
_0fuHF = Wherigo.ZMedia(_B29S)
_0fuHF.Id = "37414f0b-2f9b-4c7a-95e3-8fc449952978"
_0fuHF.Name = _jZ4Z("4z.F\025>\f")
_0fuHF.Description = ""
_0fuHF.AltText = ""
_0fuHF.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-G-aussen.jpg",
    Directives = {}
  }
}
_f7SPy = Wherigo.ZMedia(_B29S)
_f7SPy.Id = "6bf99503-4dfd-4e04-be7c-56d99b25c6b7"
_f7SPy.Name = _jZ4Z("4z.F\025>v")
_f7SPy.Description = ""
_f7SPy.AltText = ""
_f7SPy.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-A-aussen.jpg",
    Directives = {}
  }
}
_MIB2 = Wherigo.ZMedia(_B29S)
_MIB2.Id = "308d5168-f09a-4190-8f9a-db37d953cfc9"
_MIB2.Name = _jZ4Z("4z.F\025>v>S\024\024\025\024")
_MIB2.Description = ""
_MIB2.AltText = ""
_MIB2.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-A-innen.jpg",
    Directives = {}
  }
}
_kyK7W = Wherigo.ZMedia(_B29S)
_kyK7W.Id = "cd16a235-caa4-4a1f-a604-329357d5205b"
_kyK7W.Name = _jZ4Z("4z.F\025>\f>S\024\024\025\024")
_kyK7W.Description = ""
_kyK7W.AltText = ""
_kyK7W.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-G-innen.jpg",
    Directives = {}
  }
}
_uVjD = Wherigo.ZMedia(_B29S)
_uVjD.Id = "aa942e89-22c3-46db-b6e1-e9953a71a226"
_uVjD.Name = _jZ4Z("4z.F\025>\015")
_uVjD.Description = ""
_uVjD.AltText = ""
_uVjD.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-D-aussen.jpg",
    Directives = {}
  }
}
_L81q = Wherigo.ZMedia(_B29S)
_L81q.Id = "96096118-d2b7-4b0d-89a0-e644b64251c4"
_L81q.Name = _jZ4Z("4z.F\025>\015>S\024\024\025\024")
_L81q.Description = ""
_L81q.AltText = ""
_L81q.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-D-innen.jpg",
    Directives = {}
  }
}
_Ss97 = Wherigo.ZMedia(_B29S)
_Ss97.Id = "fe3b71b0-2021-4b77-bf32-55b49133e353"
_Ss97.Name = _jZ4Z("@.lD.z,,G\025\003F/&\025SF\025/i")
_Ss97.Description = ""
_Ss97.AltText = ""
_Ss97.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-J-innen.jpg",
    Directives = {}
  }
}
_d9DQr = Wherigo.ZMedia(_B29S)
_d9DQr.Id = "b98d29d1-1901-4a2d-9b69-ef417cf62f28"
_d9DQr.Name = _jZ4Z("&\019S\025w>\005l.c\025.C\025SF\025")
_d9DQr.Description = ""
_d9DQr.AltText = ""
_d9DQr.Resources = {
  {
    Type = "jpg",
    Filename = "Spiel-Karton.jpg",
    Directives = {}
  }
}
_6_j = Wherigo.ZMedia(_B29S)
_6_j.Id = "f30388ba-f957-4266-9541-3764f4371d57"
_6_j.Name = _jZ4Z("SKl>&\019S\025w")
_6_j.Description = ""
_6_j.AltText = ""
_6_j.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Spiel-Karton.jpg",
    Directives = {}
  }
}
_ZFyIl = Wherigo.ZMedia(_B29S)
_ZFyIl.Id = "67a533e8-f98d-4f00-b7f3-c3cc5a77e6e5"
_ZFyIl.Name = _jZ4Z("&\019S\025w>5L\025K\022C\025SF\025")
_ZFyIl.Description = ""
_ZFyIl.AltText = ""
_ZFyIl.Resources = {
  {
    Type = "jpg",
    Filename = "Spiel-Karton-Rueck.jpg",
    Directives = {}
  },
  {
    Type = "jpg",
    Filename = "Spiel-Karton-Rueck1.jpg",
    Directives = {}
  }
}
_0nS = Wherigo.ZMedia(_B29S)
_0nS.Id = "14e68f79-be5d-4825-8c11-093a0ea2ef73"
_0nS.Name = _jZ4Z("9\024D\025w")
_0nS.Description = ""
_0nS.AltText = ""
_0nS.Resources = {
  {
    Type = "jpg",
    Filename = "engel.jpg",
    Directives = {}
  }
}
_WvE = Wherigo.ZMedia(_B29S)
_WvE.Id = "b3e22a8d-7f7a-42af-98d3-a7098c42b393"
_WvE.Name = _jZ4Z("SKl>9\024D\025w")
_WvE.Description = ""
_WvE.AltText = ""
_WvE.Resources = {
  {
    Type = "jpg",
    Filename = "ico-engel.jpg",
    Directives = {}
  }
}
_uWZhe = Wherigo.ZMedia(_B29S)
_uWZhe.Id = "8a9821fd-035f-4894-b2f6-de1258c8fb63"
_uWZhe.Name = _jZ4Z("_\025L\003\025w")
_uWZhe.Description = ""
_uWZhe.AltText = ""
_uWZhe.Resources = {
  {
    Type = "jpg",
    Filename = "teufel.jpg",
    Directives = {}
  }
}
_qD7eg = Wherigo.ZMedia(_B29S)
_qD7eg.Id = "9e777cc3-2658-4d8e-897d-e777fc4084d4"
_qD7eg.Name = _jZ4Z("4z.F\025>\\")
_qD7eg.Description = ""
_qD7eg.AltText = ""
_qD7eg.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-I-aussen.jpg",
    Directives = {}
  }
}
_gqEg = Wherigo.ZMedia(_B29S)
_gqEg.Id = "80cb17b1-387b-458d-bfff-db2443a40fed"
_gqEg.Name = _jZ4Z("4z.F\025>\\/S\024\024\025\024")
_gqEg.Description = ""
_gqEg.AltText = ""
_gqEg.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-I-innen.jpg",
    Directives = {}
  }
}
_VaWK = Wherigo.ZMedia(_B29S)
_VaWK.Id = "9b6fd8a6-b9df-44fd-b9f2-66b8b8c72f5e"
_VaWK.Name = _jZ4Z("4z.F\025>u>S\024\024\025\024")
_VaWK.Description = ""
_VaWK.AltText = ""
_VaWK.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-B-innen.jpg",
    Directives = {}
  }
}
_Isf = Wherigo.ZMedia(_B29S)
_Isf.Id = "713d4a89-cd4a-4d1d-915e-f70cc0b075a5"
_Isf.Name = _jZ4Z("4z.F\025>P")
_Isf.Description = ""
_Isf.AltText = ""
_Isf.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-C-aussen.jpg",
    Directives = {}
  }
}
_Ufq = Wherigo.ZMedia(_B29S)
_Ufq.Id = "3d90ceff-6a39-4ea4-9943-c29a39ac483c"
_Ufq.Name = _jZ4Z("4z.F\025>P>S\024\024\025\024")
_Ufq.Description = ""
_Ufq.AltText = ""
_Ufq.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-C-innen.jpg",
    Directives = {}
  }
}
_eTDYv = Wherigo.ZMedia(_B29S)
_eTDYv.Id = "adb81fc6-454f-42f3-a16e-0c6896f81af9"
_eTDYv.Name = _jZ4Z("zLcSl>nSww\022l,,\025\024")
_eTDYv.Description = ""
_eTDYv.AltText = ""
_eTDYv.Resources = {
  {
    Type = "mp3",
    Filename = "Willkommen.mp3",
    Directives = {}
  }
}
_CX7p = Wherigo.ZMedia(_B29S)
_CX7p.Id = "a835c3fc-3c6a-4bd1-8b2f-6bdd36df09e5"
_CX7p.Name = _jZ4Z("4z.F\025>4")
_CX7p.Description = ""
_CX7p.AltText = ""
_CX7p.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-K-aussen.jpg",
    Directives = {}
  }
}
_wKtC = Wherigo.ZMedia(_B29S)
_wKtC.Id = "a0b30c13-c18b-4ef6-a4a1-09e828d97ebf"
_wKtC.Name = _jZ4Z("4z.F\025>4>S\024\024\025\024")
_wKtC.Description = ""
_wKtC.AltText = ""
_wKtC.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-K-innen.jpg",
    Directives = {}
  }
}
_iTUMK = Wherigo.ZMedia(_B29S)
_iTUMK.Id = "d4a3f1ba-5a4b-4533-963e-592cdfa1c6a4"
_iTUMK.Name = _jZ4Z("4z.F\025>.lF")
_iTUMK.Description = ""
_iTUMK.AltText = ""
_iTUMK.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-rot.jpg",
    Directives = {}
  }
}
_uTf = Wherigo.ZMedia(_B29S)
_uTf.Id = "e378d308-e725-49ab-b932-c81c13fb1e15"
_uTf.Name = _jZ4Z("4z.F\025>D.L\025\024")
_uTf.Description = ""
_uTf.AltText = ""
_uTf.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-gruen.jpg",
    Directives = {}
  }
}
_nHc = Wherigo.ZMedia(_B29S)
_nHc.Id = "682cef02-b826-45a9-a866-ca17402e0c6a"
_nHc.Name = _jZ4Z("4z.F\025>pwzL")
_nHc.Description = ""
_nHc.AltText = ""
_nHc.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-blau.jpg",
    Directives = {}
  }
}
_kkn__ = Wherigo.ZMedia(_B29S)
_kkn__.Id = "7c32d0ee-800b-44d7-84d9-02ea1e23fd79"
_kkn__.Name = _jZ4Z("_SK\022\025F>H")
_kkn__.Description = ""
_kkn__.AltText = ""
_kkn__.Resources = {
  {
    Type = "jpg",
    Filename = "Ticket-15.jpg",
    Directives = {}
  }
}
_9t69 = Wherigo.ZMedia(_B29S)
_9t69.Id = "b9ea16be-fb6c-47cb-b9a6-563d9d23f824"
_9t69.Name = _jZ4Z("_SK\022\025F>\001")
_9t69.Description = ""
_9t69.AltText = ""
_9t69.Resources = {
  {
    Type = "jpg",
    Filename = "Ticket-23.jpg",
    Directives = {}
  }
}
_N1Vt = Wherigo.ZMedia(_B29S)
_N1Vt.Id = "3c47b6fa-8fc6-488b-b69b-b42fcd0869ad"
_N1Vt.Name = _jZ4Z("_SK\022\025F>i")
_N1Vt.Description = ""
_N1Vt.AltText = ""
_N1Vt.Resources = {
  {
    Type = "jpg",
    Filename = "Ticket-34.jpg",
    Directives = {}
  }
}
_Hp1 = Wherigo.ZMedia(_B29S)
_Hp1.Id = "ca542514-ca81-4573-b807-4e9a8a87323f"
_Hp1.Name = _jZ4Z("SKl>_SK\022\025F")
_Hp1.Description = ""
_Hp1.AltText = ""
_Hp1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Ticket.jpg",
    Directives = {}
  }
}
_iav = Wherigo.ZMedia(_B29S)
_iav.Id = "1977e599-8aa1-4076-8606-0b61af1213b9"
_iav.Name = _jZ4Z("SKl>4z.F\025>v")
_iav.Description = ""
_iav.AltText = ""
_iav.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-A.jpg",
    Directives = {}
  }
}
_veyV = Wherigo.ZMedia(_B29S)
_veyV.Id = "c45a0e74-1c7e-408a-97a7-5aa94c6ba139"
_veyV.Name = _jZ4Z("SKl>4z.F\025>u")
_veyV.Description = ""
_veyV.AltText = ""
_veyV.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-B.jpg",
    Directives = {}
  }
}
_ht6Vj = Wherigo.ZMedia(_B29S)
_ht6Vj.Id = "53068069-fdc3-4835-b084-11856dcf348b"
_ht6Vj.Name = _jZ4Z("SKl>4z.F\025>P")
_ht6Vj.Description = ""
_ht6Vj.AltText = ""
_ht6Vj.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-C.jpg",
    Directives = {}
  }
}
_rjK = Wherigo.ZMedia(_B29S)
_rjK.Id = "8dfc931c-e77b-4334-80c9-3aaf978a3ef7"
_rjK.Name = _jZ4Z("SKl>4z.F\025>\015")
_rjK.Description = ""
_rjK.AltText = ""
_rjK.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-D.jpg",
    Directives = {}
  }
}
_dY1 = Wherigo.ZMedia(_B29S)
_dY1.Id = "af318a40-1dfe-4992-807b-ba2ac6a775e6"
_dY1.Name = _jZ4Z("SKl>4z.F\025>\f")
_dY1.Description = ""
_dY1.AltText = ""
_dY1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-G.jpg",
    Directives = {}
  }
}
_W88lJ = Wherigo.ZMedia(_B29S)
_W88lJ.Id = "444ac3f0-2c94-4412-85d5-6af3fbf9738c"
_W88lJ.Name = _jZ4Z("SKl>4z.F\025>\\")
_W88lJ.Description = ""
_W88lJ.AltText = ""
_W88lJ.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-I.jpg",
    Directives = {}
  }
}
_3R9R = Wherigo.ZMedia(_B29S)
_3R9R.Id = "f6883adf-d101-490a-96d1-34fd68cbefef"
_3R9R.Name = _jZ4Z("SKl>4z.F\025>\014")
_3R9R.Description = ""
_3R9R.AltText = ""
_3R9R.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-J.jpg",
    Directives = {}
  }
}
_OjZJP = Wherigo.ZMedia(_B29S)
_OjZJP.Id = "253430a0-089e-4ba6-90b0-a18e08617606"
_OjZJP.Name = _jZ4Z("SKl>4z.F\025>4")
_OjZJP.Description = ""
_OjZJP.AltText = ""
_OjZJP.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-K.jpg",
    Directives = {}
  }
}
__mLYP = Wherigo.ZMedia(_B29S)
__mLYP.Id = "a9cb9fbc-479c-412b-8f5a-13d0085fab94"
__mLYP.Name = _jZ4Z("SKl>@l.D.z,,G\025\003F")
__mLYP.Description = ""
__mLYP.AltText = ""
__mLYP.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Programmheft.jpg",
    Directives = {}
  }
}
_4RQcf = Wherigo.ZMedia(_B29S)
_4RQcf.Id = "5b1437fa-2096-4ada-891e-c19c90d7b38e"
_4RQcf.Name = _jZ4Z("SKl>uL\025G\024\025")
_4RQcf.Description = ""
_4RQcf.AltText = ""
_4RQcf.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Buehne.jpg",
    Directives = {}
  }
}
_7XGtn = Wherigo.ZMedia(_B29S)
_7XGtn.Id = "c3bda578-3e52-4636-9e11-2495bcb1dfbe"
_7XGtn.Name = _jZ4Z("SKl>'ld\025.")
_7XGtn.Description = ""
_7XGtn.AltText = ""
_7XGtn.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Foyer.jpg",
    Directives = {}
  }
}
_Sz5Z = Wherigo.ZMedia(_B29S)
_Sz5Z.Id = "5da396bd-1aca-4f06-992c-d722660928a9"
_Sz5Z.Name = _jZ4Z("SKl>_G\025zF\025.Czzw")
_Sz5Z.Description = ""
_Sz5Z.AltText = ""
_Sz5Z.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Theatersaal-1.jpg",
    Directives = {}
  }
}
_1Avn = Wherigo.ZMedia(_B29S)
_1Avn.Id = "c5b57ba6-37c0-46d1-b3e3-7c3fb315c71d"
_1Avn.Name = _jZ4Z("SKl>\fz.c\025.lp\025")
_1Avn.Description = ""
_1Avn.AltText = ""
_1Avn.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Gardarobe.jpg",
    Directives = {}
  }
}
_F8C = Wherigo.ZMedia(_B29S)
_F8C.Id = "b2dea07d-1e98-44df-9b62-1f41936de5b7"
_F8C.Name = _jZ4Z("\fz.c\025.lp\025")
_F8C.Description = ""
_F8C.AltText = ""
_F8C.Resources = {
  {
    Type = "jpg",
    Filename = "Gardarobe.jpg",
    Directives = {}
  }
}
_7xdM = Wherigo.ZMedia(_B29S)
_7xdM.Id = "7e88a75f-7673-4ed8-b49e-2db5291127fc"
_7xdM.Name = _jZ4Z("uL\025G\024\025")
_7xdM.Description = ""
_7xdM.AltText = ""
_7xdM.Resources = {
  {
    Type = "jpg",
    Filename = "Buehne.jpg",
    Directives = {}
  }
}
_ahn = Wherigo.ZMedia(_B29S)
_ahn.Id = "28af98fb-645f-49d5-ae0c-b7b115f34cee"
_ahn.Name = _jZ4Z("SKl>_L\025./_G\025zF\025.Czzw")
_ahn.Description = ""
_ahn.AltText = ""
_ahn.Resources = {
  {
    Type = "jpg",
    Filename = "ico-tuer-theatersaal.jpg",
    Directives = {}
  }
}
_F5w = Wherigo.ZMedia(_B29S)
_F5w.Id = "640f383d-0f4f-4934-b0c9-763b541662e4"
_F5w.Name = _jZ4Z("_L\025./_G\025zF\025.Czzw")
_F5w.Description = ""
_F5w.AltText = ""
_F5w.Resources = {
  {
    Type = "jpg",
    Filename = "tuer-theatersaal.jpg",
    Directives = {}
  }
}
_Uc6mv = Wherigo.ZMedia(_B29S)
_Uc6mv.Id = "b1ea3df9-299e-4193-aa80-1d1f26ea4d03"
_Uc6mv.Name = _jZ4Z("vLCDz\024DCFL\025.")
_Uc6mv.Description = ""
_Uc6mv.AltText = ""
_Uc6mv.Resources = {
  {
    Type = "jpg",
    Filename = "ausgangstuer.jpg",
    Directives = {}
  }
}
_p2qcl = Wherigo.ZMedia(_B29S)
_p2qcl.Id = "2f4a2e95-49eb-4117-a88c-6d6e1e5fe20c"
_p2qcl.Name = _jZ4Z("SKl>vLCDz\024DCFL\025.")
_p2qcl.Description = ""
_p2qcl.AltText = ""
_p2qcl.Resources = {
  {
    Type = "jpg",
    Filename = "ico-ausgangstuer.jpg",
    Directives = {}
  }
}
_WxtG2 = Wherigo.ZMedia(_B29S)
_WxtG2.Id = "8a18addd-d4c1-4c56-ac1f-4278fb9d4732"
_WxtG2.Name = _jZ4Z("&KG.z\024\022")
_WxtG2.Description = ""
_WxtG2.AltText = ""
_WxtG2.Resources = {
  {
    Type = "jpg",
    Filename = "Schrank.jpg",
    Directives = {}
  }
}
_UKF = Wherigo.ZMedia(_B29S)
_UKF.Id = "0d0348d0-560d-4531-98a8-568f5a4963d8"
_UKF.Name = _jZ4Z("SKl>&KG.z\024\022")
_UKF.Description = ""
_UKF.AltText = ""
_UKF.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Schrank.jpg",
    Directives = {}
  }
}
_IT5 = Wherigo.ZMedia(_B29S)
_IT5.Id = "1e9f7438-0a39-4882-8e60-9001b1970ac5"
_IT5.Name = _jZ4Z("\005l.Gz\024D")
_IT5.Description = ""
_IT5.AltText = ""
_IT5.Resources = {
  {
    Type = "jpg",
    Filename = "Vorhang.jpg",
    Directives = {}
  }
}
_mCF = Wherigo.ZMedia(_B29S)
_mCF.Id = "eb4ba6da-81fe-42c6-8439-7f754580b57e"
_mCF.Name = _jZ4Z("SKl>\005l.Gz\024D")
_mCF.Description = ""
_mCF.AltText = ""
_mCF.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Vorhang.jpg",
    Directives = {}
  }
}
_y7_ = Wherigo.ZMedia(_B29S)
_y7_.Id = "66f21f23-3cdd-4a4a-b46b-6b1823846741"
_y7_.Name = _jZ4Z("SKl>4lCFL\025,\022SCF\025")
_y7_.Description = ""
_y7_.AltText = ""
_y7_.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kostuemkiste.jpg",
    Directives = {}
  }
}
_Rtt = Wherigo.ZMedia(_B29S)
_Rtt.Id = "a95178d1-d8e3-47f1-86cb-b81f0bff7a5b"
_Rtt.Name = _jZ4Z("4lCFL\025,\022SCF\025")
_Rtt.Description = ""
_Rtt.AltText = ""
_Rtt.Resources = {
  {
    Type = "jpg",
    Filename = "Kostuemkiste.jpg",
    Directives = {}
  }
}
_j_nTQ = Wherigo.ZMedia(_B29S)
_j_nTQ.Id = "f60be3c2-bf30-4a62-b1b6-b15da7891c99"
_j_nTQ.Name = _jZ4Z("5\025?LSCSF\025\024\022SCF\025")
_j_nTQ.Description = ""
_j_nTQ.AltText = ""
_j_nTQ.Resources = {
  {
    Type = "jpg",
    Filename = "Requisitenkiste.jpg",
    Directives = {}
  }
}
_4XDN = Wherigo.ZMedia(_B29S)
_4XDN.Id = "771e5ade-768b-4e3f-8ac6-1e893471eabd"
_4XDN.Name = _jZ4Z("SKl>5\025?LSCSF\025\024\022SCF\025")
_4XDN.Description = ""
_4XDN.AltText = ""
_4XDN.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Requisitenkiste.jpg",
    Directives = {}
  }
}
_RntjX = Wherigo.ZMedia(_B29S)
_RntjX.Id = "b311b968-6003-463e-922e-8d493a1fc7c5"
_RntjX.Name = _jZ4Z("4z.F\025>9")
_RntjX.Description = ""
_RntjX.AltText = ""
_RntjX.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-E-aussen.jpg",
    Directives = {}
  }
}
_SEl = Wherigo.ZMedia(_B29S)
_SEl.Id = "431fae98-d744-41cf-8fbd-e7d9905e3913"
_SEl.Name = _jZ4Z("SKl>4z.F\025>9")
_SEl.Description = ""
_SEl.AltText = ""
_SEl.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-E.jpg",
    Directives = {}
  }
}
_rUX = Wherigo.ZMedia(_B29S)
_rUX.Id = "90aa9a43-7dff-4063-805e-81750ecb0326"
_rUX.Name = _jZ4Z("pL\025G\024\025/w\025\025.")
_rUX.Description = ""
_rUX.AltText = ""
_rUX.Resources = {
  {
    Type = "jpg",
    Filename = "Buehne-leer.jpg",
    Directives = {}
  }
}
_7Op1 = Wherigo.ZMedia(_B29S)
_7Op1.Id = "dc6471dc-18f0-45f8-a70a-38da28e13d0e"
_7Op1.Name = _jZ4Z("_G\025zF\025.Czzw")
_7Op1.Description = ""
_7Op1.AltText = ""
_7Op1.Resources = {
  {
    Type = "jpg",
    Filename = "Theatersaal-1.jpg",
    Directives = {}
  }
}
_Ranbb = Wherigo.ZMedia(_B29S)
_Ranbb.Id = "fd5c6123-354f-4c1c-95d6-784300051005"
_Ranbb.Name = _jZ4Z("&KGwlCCFG\025zF\025.")
_Ranbb.Description = ""
_Ranbb.AltText = ""
_Ranbb.Resources = {
  {
    Type = "jpg",
    Filename = "Schlosstheater.jpg",
    Directives = {}
  }
}
_xWxn1 = Wherigo.ZMedia(_B29S)
_xWxn1.Id = "4145374a-394c-4cc7-a4d7-e68393deda2e"
_xWxn1.Name = _jZ4Z("SKl>&KGwlCCFG\025zF\025.")
_xWxn1.Description = ""
_xWxn1.AltText = ""
_xWxn1.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Schlosstheater.jpg",
    Directives = {}
  }
}
_MKP = Wherigo.ZMedia(_B29S)
_MKP.Id = "6f26b83f-45d7-41ca-a616-7bf5dffd2780"
_MKP.Name = _jZ4Z("'ld\025.")
_MKP.Description = ""
_MKP.AltText = ""
_MKP.Resources = {
  {
    Type = "jpg",
    Filename = "Foyer-leer.jpg",
    Directives = {}
  }
}
_hfWnW = Wherigo.ZMedia(_B29S)
_hfWnW.Id = "49df852f-f8a3-46df-83a1-6031fd913747"
_hfWnW.Name = _jZ4Z("SKl>'ld\025.")
_hfWnW.Description = ""
_hfWnW.AltText = ""
_hfWnW.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Foyer-leer.jpg",
    Directives = {}
  }
}
_ZhH4p = Wherigo.ZMedia(_B29S)
_ZhH4p.Id = "8e8ae290-ecf4-40c9-bf34-dfbde9826d3f"
_ZhH4p.Name = _jZ4Z("u\025CFLGwL\024D")
_ZhH4p.Description = ""
_ZhH4p.AltText = ""
_ZhH4p.Resources = {
  {
    Type = "jpg",
    Filename = "Bestuhlung.jpg",
    Directives = {}
  }
}
_xURO = Wherigo.ZMedia(_B29S)
_xURO.Id = "ae6693ba-a1ce-43cf-81d2-4d57fb19b04e"
_xURO.Name = _jZ4Z("&\025SF\025\024\003wL.")
_xURO.Description = ""
_xURO.AltText = ""
_xURO.Resources = {
  {
    Type = "jpg",
    Filename = "Seitenflur.jpg",
    Directives = {}
  }
}
_V8YDl = Wherigo.ZMedia(_B29S)
_V8YDl.Id = "8b8ebc5a-91b5-4393-9343-606904dd60e5"
_V8YDl.Name = _jZ4Z("SKl>&\025SF\025\024\003wL.")
_V8YDl.Description = ""
_V8YDl.AltText = ""
_V8YDl.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Seitenflur.jpg",
    Directives = {}
  }
}
_zzG = Wherigo.ZMedia(_B29S)
_zzG.Id = "b7084972-65dc-4e64-9e0a-4bd2658a5b2d"
_zzG.Name = _jZ4Z("u\025CLKG\025.")
_zzG.Description = ""
_zzG.AltText = ""
_zzG.Resources = {
  {
    Type = "jpg",
    Filename = "Besucher.jpg",
    Directives = {}
  }
}
_qwk = Wherigo.ZMedia(_B29S)
_qwk.Id = "d5ab57f1-81bd-4866-8f5e-6ae9074d2f58"
_qwk.Name = _jZ4Z("@.lD.z,,G\025\003F/&\025SF\025/H")
_qwk.Description = ""
_qwk.AltText = ""
_qwk.Resources = {
  {
    Type = "jpg",
    Filename = "Programmheft-Seite-1.jpg",
    Directives = {}
  }
}
_kiJY = Wherigo.ZMedia(_B29S)
_kiJY.Id = "11793009-ca89-4cba-9716-db7df0e45954"
_kiJY.Name = _jZ4Z("@l.D.z,,G\025\003F/C\025SF\025/\001")
_kiJY.Description = ""
_kiJY.AltText = ""
_kiJY.Resources = {
  {
    Type = "jpg",
    Filename = "Programmheft-Seite-2.jpg",
    Directives = {}
  }
}
_DM8R = Wherigo.ZMedia(_B29S)
_DM8R.Id = "e60c6733-c4c1-4787-9b6a-b2150fb06cc4"
_DM8R.Name = _jZ4Z("SKl>@.lD.z,,G\025\003F")
_DM8R.Description = ""
_DM8R.AltText = ""
_DM8R.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Programmheft1.jpg",
    Directives = {}
  }
}
_gFj = Wherigo.ZMedia(_B29S)
_gFj.Id = "bcb45fe0-529a-4ee2-8a82-a53b2359284a"
_gFj.Name = _jZ4Z("4z.F\025>.lF")
_gFj.Description = ""
_gFj.AltText = ""
_gFj.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-rot1.jpg",
    Directives = {}
  }
}
_9zNG = Wherigo.ZMedia(_B29S)
_9zNG.Id = "27b790bd-53a6-49cf-b54d-1699149ea9d2"
_9zNG.Name = _jZ4Z("4z.F\025>pwzL")
_9zNG.Description = ""
_9zNG.AltText = ""
_9zNG.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-blau1.jpg",
    Directives = {}
  }
}
_l2O = Wherigo.ZMedia(_B29S)
_l2O.Id = "b245eee2-a23d-4b2f-845a-37f4adac328b"
_l2O.Name = _jZ4Z("4z.F\025>D.L\025\024")
_l2O.Description = ""
_l2O.AltText = ""
_l2O.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-gruen1.jpg",
    Directives = {}
  }
}
_u7YwZ = Wherigo.ZMedia(_B29S)
_u7YwZ.Id = "1e99e416-1168-4575-872d-586ade95b7c8"
_u7YwZ.Name = _jZ4Z("SKl>4z.F\025>.lF")
_u7YwZ.Description = ""
_u7YwZ.AltText = ""
_u7YwZ.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-rot.jpg",
    Directives = {}
  }
}
_PIW = Wherigo.ZMedia(_B29S)
_PIW.Id = "2e11c7ed-759e-4bfe-88a8-4d8bdb5e7365"
_PIW.Name = _jZ4Z("SKl>4z.F\025>pwzL")
_PIW.Description = ""
_PIW.AltText = ""
_PIW.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-blau.jpg",
    Directives = {}
  }
}
_nfrY = Wherigo.ZMedia(_B29S)
_nfrY.Id = "10be0815-eaa9-4a2b-bc26-87018361e0f1"
_nfrY.Name = _jZ4Z("SKl>4z.F\025>D.L\025\024")
_nfrY.Description = ""
_nfrY.AltText = ""
_nfrY.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-gruen.jpg",
    Directives = {}
  }
}
_ikuZp = Wherigo.ZMedia(_B29S)
_ikuZp.Id = "88ca1218-7ca3-4bc3-a359-3b2a8be30df7"
_ikuZp.Name = _jZ4Z("4z.F\025>\014>S\024\024\025\024")
_ikuZp.Description = ""
_ikuZp.AltText = ""
_ikuZp.Resources = {
  {
    Type = "jpg",
    Filename = "Karte-J-innen1.jpg",
    Directives = {}
  }
}
_xRi6 = Wherigo.ZMedia(_B29S)
_xRi6.Id = "64ac225f-677b-48c0-a8a8-2f5d3b2ff5a9"
_xRi6.Name = _jZ4Z("SKl>4z.F\025>\014>S\024\024\025\024")
_xRi6.Description = ""
_xRi6.AltText = ""
_xRi6.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Karte-J-innen.jpg",
    Directives = {}
  }
}
_gSVj = Wherigo.ZMedia(_B29S)
_gSVj.Id = "f2dd0805-2c4c-4e1e-b011-4bc09ae9b7f6"
_gSVj.Name = _jZ4Z("p\025CFLGwL\024D>w\025\025.")
_gSVj.Description = ""
_gSVj.AltText = ""
_gSVj.Resources = {
  {
    Type = "jpg",
    Filename = "Bestuhlung-leer.jpg",
    Directives = {}
  }
}
_ZHro3 = Wherigo.ZMedia(_B29S)
_ZHro3.Id = "397257b8-48af-477c-ac04-14e9098cfd03"
_ZHro3.Name = _jZ4Z("\fz.c\025.lp\025>\022w\025ScL\024D")
_ZHro3.Description = ""
_ZHro3.AltText = ""
_ZHro3.Resources = {
  {
    Type = "jpg",
    Filename = "Garderobe-Kleidung.jpg",
    Directives = {}
  }
}
_gYRcO = Wherigo.ZMedia(_B29S)
_gYRcO.Id = "ff4635b0-7c5b-4262-a724-a63a749eb6ee"
_gYRcO.Name = _jZ4Z("SKl>Dz.c\025.lp\025>\022w\025ScL\024D")
_gYRcO.Description = ""
_gYRcO.AltText = ""
_gYRcO.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Garderobe-Kleidung.jpg",
    Directives = {}
  }
}
_j7z = Wherigo.ZMedia(_B29S)
_j7z.Id = "3267c408-33f5-4e03-aad2-121e5b80e907"
_j7z.Name = _jZ4Z("SKl>p\025CFLGwL\024D>w\025\025.")
_j7z.Description = ""
_j7z.AltText = ""
_j7z.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Bestuhlung-leer.jpg",
    Directives = {}
  }
}
_B29S.Id = "84f5ae1a-44e1-4afd-beca-214e2e17be8d"
_B29S.Name = "Das Geheimnis der Premiere"
_B29S.Description = [[
Dieser Wherigo basiert auf der Idee der Exit-Spiele von Inka und Markus Brand erschienen im Kosmos-Verlag.<BR>
<BR>
Die Cartridge setzt mit freundlicher Genehmigung des Kosmos-Verlages das Probierspiel "EXIT - das Geheimnis der Premiere" fuer Geocacher um.<BR>
Naeheres zu den EXIT-Spielen findet ihr beim Kosmos-Verlag unter EXIT-das Spiel.<BR>
<BR>
]]
_B29S.Visible = true
_B29S.Activity = "TourGuide"
_B29S.StartingLocationDescription = "Du stehst vor dem Schlosstheater und fieberst dem Mystery-Schauspiel entgegen. "
_B29S.StartingLocation = Wherigo.INVALID_ZONEPOINT
_B29S.Version = "2.2"
_B29S.Company = ""
_B29S.Author = "tmz"
_B29S.BuilderVersion = "URWIGO 1.22.5798.37755"
_B29S.CreateDate = "01/03/2018 17:28:52"
_B29S.PublishDate = "1/1/0001 12:00:00 AM"
_B29S.UpdateDate = "04/27/2018 21:20:04"
_B29S.LastPlayedDate = "1/1/0001 12:00:00 AM"
_B29S.TargetDevice = "PocketPC"
_B29S.TargetDeviceVersion = "0"
_B29S.StateId = "1"
_B29S.CountryId = "2"
_B29S.Complete = false
_B29S.UseLogging = true
_B29S.Media = _Ranbb
_B29S.Icon = _xWxn1
zGarderobe = Wherigo.Zone(_B29S)
zGarderobe.Id = "315f4b0a-7aa9-4101-b31c-f97108c52eb5"
zGarderobe.Name = _jZ4Z("\fz.c\025.lp\025")
zGarderobe.Description = _jZ4Z("\015S\025/\fz.c\025.lp\025/c\025C/&KGwlCCFG\025zF\025.C/>/kS\025w/SCF/GS\025./\024SKGF/wlCe")
zGarderobe.Visible = false
zGarderobe.Media = _F8C
zGarderobe.Icon = _1Avn
zGarderobe.Commands = {}
zGarderobe.DistanceRange = Distance(-1, "feet")
zGarderobe.ShowObjects = "OnEnter"
zGarderobe.ProximityRange = Distance(60, "meters")
zGarderobe.AllowSetPositionTo = false
zGarderobe.Active = false
zGarderobe.Points = {
  ZonePoint(52.4779305842043, 13.1341848933366, 0),
  ZonePoint(52.4779315313715, 13.1342968654687, 0),
  ZonePoint(52.4778503800721, 13.1343011032504, 0),
  ZonePoint(52.4778506404816, 13.1341852433384, 0)
}
zGarderobe.OriginalPoint = ZonePoint(52.4778907840324, 13.1342420263485, 0)
zGarderobe.DistanceRangeUOM = "Feet"
zGarderobe.ProximityRangeUOM = "Meters"
zGarderobe.OutOfRangeName = ""
zGarderobe.InRangeName = ""
zSeitenflur = Wherigo.Zone(_B29S)
zSeitenflur.Id = "ded7d602-839a-4be6-b78c-58fb51a3a9a2"
zSeitenflur.Name = _jZ4Z("&\025SF\025\024\003wL.")
zSeitenflur.Description = _jZ4Z("\015\025./&\025SF\025\024\003wL./c\025C/&KGwlCCFG\025zF\025.Ce/qS\025./CKG\025S\024\025\024/cS\025/&KGzLC\019S\025w\025./6lGw/SG.\025/&\019S\024c\025/L\024c/&KG.z\025\024\022\025/ML/Gzp\025\024e")
zSeitenflur.Visible = false
zSeitenflur.Media = _xURO
zSeitenflur.Icon = _V8YDl
zSeitenflur.Commands = {}
zSeitenflur.DistanceRange = Distance(-1, "feet")
zSeitenflur.ShowObjects = "OnEnter"
zSeitenflur.ProximityRange = Distance(60, "meters")
zSeitenflur.AllowSetPositionTo = false
zSeitenflur.Active = false
zSeitenflur.Points = {
  ZonePoint(52.4779282200084, 13.1339015864436, 0),
  ZonePoint(52.4779274387814, 13.1339997217468, 0),
  ZonePoint(52.4778495310944, 13.1340046595328, 0),
  ZonePoint(52.4778497915038, 13.1339042691135, 0)
}
zSeitenflur.OriginalPoint = ZonePoint(52.477888745347, 13.1339525592092, 0)
zSeitenflur.DistanceRangeUOM = "Feet"
zSeitenflur.ProximityRangeUOM = "Meters"
zSeitenflur.OutOfRangeName = ""
zSeitenflur.InRangeName = ""
zFoyer = Wherigo.Zone(_B29S)
zFoyer.Id = "33097521-6273-4a5d-bc50-6836bdfd5f5f"
zFoyer.Name = _jZ4Z("'ld\025.")
zFoyer.Description = _jZ4Z("\015zC/'ld\025./>/\024\025p\025\024/c\025\024/_L\025.\025\024/\024zKG/c.zLCC\025\024/pM6e/S\024/c\025\024/_G\025zF\025.Czzw/CS\025GCF/\015L/\024lKG/cS\025/\fz.c\025.lp\025/L\024c/c\025\024/&\025SF\025\024\003wL.e")
zFoyer.Visible = true
zFoyer.Media = _MKP
zFoyer.Icon = _hfWnW
zFoyer.Commands = {}
zFoyer.DistanceRange = Distance(-1, "feet")
zFoyer.ShowObjects = "OnEnter"
zFoyer.ProximityRange = Distance(60, "meters")
zFoyer.AllowSetPositionTo = false
zFoyer.Active = true
zFoyer.Points = {
  ZonePoint(52.4779258483676, 13.1340308832017, 0),
  ZonePoint(52.4779277427024, 13.1341610513656, 0),
  ZonePoint(52.4778534347541, 13.1341638891393, 0),
  ZonePoint(52.4778523216445, 13.1340300280938, 0)
}
zFoyer.OriginalPoint = ZonePoint(52.4778898368671, 13.1340964629501, 0)
zFoyer.DistanceRangeUOM = "Feet"
zFoyer.ProximityRangeUOM = "Meters"
zFoyer.OutOfRangeName = ""
zFoyer.InRangeName = ""
zCache = Wherigo.Zone(_B29S)
zCache.Id = "893d18cb-105e-4174-b6b9-c3959b518c48"
zCache.Name = _jZ4Z("PzKG\025")
zCache.Description = ""
zCache.Visible = false
zCache.Commands = {}
zCache.DistanceRange = Distance(-1, "feet")
zCache.ShowObjects = "OnEnter"
zCache.ProximityRange = Distance(60, "meters")
zCache.AllowSetPositionTo = false
zCache.Active = false
zCache.Points = {
  ZonePoint(52.4804533460224, 13.121494075863, 0),
  ZonePoint(52.4804003076628, 13.1218217715668, 0),
  ZonePoint(52.4803025336376, 13.1218155511191, 0),
  ZonePoint(52.4802637018546, 13.1214660838485, 0)
}
zCache.OriginalPoint = ZonePoint(52.4803549722944, 13.1216493705994, 0)
zCache.DistanceRangeUOM = "Feet"
zCache.ProximityRangeUOM = "Meters"
zCache.OutOfRangeName = ""
zCache.InRangeName = ""
zBuehne = Wherigo.Zone(_B29S)
zBuehne.Id = "2523bd5e-57ed-4e8f-9149-f1ef7d303944"
zBuehne.Name = _jZ4Z("uL\025G\024\025")
zBuehne.Description = _jZ4Z("\015S\025/_G\025zF\025.pL\025G\024\025/>/u.\025FF\025./cS\025/cS\025/n\025wF/p\025c\025LF\025\024e")
zBuehne.Visible = false
zBuehne.Media = _rUX
zBuehne.Icon = _4RQcf
zBuehne.Commands = {}
zBuehne.DistanceRange = Distance(-1, "feet")
zBuehne.ShowObjects = "OnEnter"
zBuehne.ProximityRange = Distance(60, "meters")
zBuehne.AllowSetPositionTo = false
zBuehne.Active = false
zBuehne.Points = {
  ZonePoint(52.4780737569535, 13.1340420597704, 0),
  ZonePoint(52.4780803871025, 13.1341548053841, 0),
  ZonePoint(52.4780178742291, 13.1341610258318, 0),
  ZonePoint(52.4780188213944, 13.1340405046586, 0)
}
zBuehne.OriginalPoint = ZonePoint(52.4780477099199, 13.1340995989112, 0)
zBuehne.DistanceRangeUOM = "Feet"
zBuehne.ProximityRangeUOM = "Meters"
zBuehne.OutOfRangeName = ""
zBuehne.InRangeName = ""
zTheatersaal = Wherigo.Zone(_B29S)
zTheatersaal.Id = "2a1283e4-db33-4e0e-9b6d-1a15259e23c6"
zTheatersaal.Name = _jZ4Z("_G\025zF\025.Czzw")
zTheatersaal.Description = _jZ4Z("\015\025./_G\025zF\025.Czzw/c\025C/&KGwlCCFG\025zF\025.Ce/\005l\024/GS\025./GzCF/\015L/\025S\024\025\024/G\025..wSKG\025\024/\r\025p\025.pwSK\022/L\025p\025./cS\025/uL\025G\024\025/L\024c/cS\025/u\025CFLGwL\024De")
zTheatersaal.Visible = false
zTheatersaal.Media = _7Op1
zTheatersaal.Icon = _Sz5Z
zTheatersaal.Commands = {}
zTheatersaal.DistanceRange = Distance(-1, "feet")
zTheatersaal.ShowObjects = "OnEnter"
zTheatersaal.ProximityRange = Distance(60, "meters")
zTheatersaal.AllowSetPositionTo = false
zTheatersaal.Active = false
zTheatersaal.Points = {
  ZonePoint(52.4780027195796, 13.1341586931639, 0),
  ZonePoint(52.4780046139111, 13.1340373944347, 0),
  ZonePoint(52.4779383122615, 13.1340311739871, 0),
  ZonePoint(52.4779373650944, 13.1341586931639, 0)
}
zTheatersaal.OriginalPoint = ZonePoint(52.4779707527116, 13.1340964886874, 0)
zTheatersaal.DistanceRangeUOM = "Feet"
zTheatersaal.ProximityRangeUOM = "Meters"
zTheatersaal.OutOfRangeName = ""
zTheatersaal.InRangeName = ""
zSchlosstheater = Wherigo.Zone(_B29S)
zSchlosstheater.Id = "a4ec3169-2584-4dd2-8407-4fd491933699"
zSchlosstheater.Name = _jZ4Z("&KGwlCCFG\025zF\025.")
zSchlosstheater.Description = _jZ4Z("\015zC/&KGwlCCFG\025zF\025./>/,SF/c\025,/\024\025L\025\024/RdCF\025.d>&KGzLC\019S\025w/GzF/\025C/\025\024cwSKG/6S\025c\025./2LwzL\003/\025.GzwF\025\024e")
zSchlosstheater.Visible = true
zSchlosstheater.Media = _Ranbb
zSchlosstheater.Icon = _xWxn1
zSchlosstheater.Commands = {}
zSchlosstheater.DistanceRange = Distance(-1, "feet")
zSchlosstheater.ShowObjects = "OnEnter"
zSchlosstheater.ProximityRange = Distance(60, "meters")
zSchlosstheater.AllowSetPositionTo = false
zSchlosstheater.Active = true
zSchlosstheater.Points = {
  ZonePoint(52.4778417011077, 13.1341524727162, 0),
  ZonePoint(52.4778407539384, 13.1340327290989, 0),
  ZonePoint(52.4778047614928, 13.1340342842109, 0),
  ZonePoint(52.4778038143227, 13.1341493624924, 0)
}
zSchlosstheater.OriginalPoint = ZonePoint(52.4778227577154, 13.1340922121296, 0)
zSchlosstheater.DistanceRangeUOM = "Feet"
zSchlosstheater.ProximityRangeUOM = "Meters"
zSchlosstheater.OutOfRangeName = ""
zSchlosstheater.InRangeName = ""
_LRyb3 = Wherigo.ZItem({Cartridge = _B29S, Container = zCache})
_LRyb3.Id = "24a0d603-5f98-46e4-8996-16a58f6e97b5"
_LRyb3.Name = _jZ4Z("\fz\025CF\025pLKG")
_LRyb3.Description = _jZ4Z("9S\024/zwF\025C/\fzCF\025pLKG")
_LRyb3.Visible = true
_LRyb3.Media = _RV48
_LRyb3.Icon = _n6o
_LRyb3.Commands = {
  _yp8 = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _QBx = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_LRyb3.Commands._yp8.Custom = true
_LRyb3.Commands._yp8.Id = "708ab899-d1d6-4c1c-b3ff-73a421c6ff9c"
_LRyb3.Commands._yp8.WorksWithAll = true
_LRyb3.Commands._QBx.Custom = true
_LRyb3.Commands._QBx.Id = "43664d12-833f-4c31-ad20-859d19e25234"
_LRyb3.Commands._QBx.WorksWithAll = true
_LRyb3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_LRyb3.Locked = false
_LRyb3.Opened = false
_8YM = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_8YM.Id = "1bdf7f5a-7f08-4708-9aa4-544b27bea0f0"
_8YM.Name = _jZ4Z("4ll.cS\024zF\025\024")
_8YM.Description = _jZ4Z("9S\024/\022w\025S\024\025./CKG,Lcc\025wSD\025./2\025FF\025w/,SF/\025S\024/\019zz./4ll.cS\024zF\025\024")
_8YM.Visible = false
_8YM.Media = _E7h
_8YM.Icon = _E0fT
_8YM.Commands = {
  _zJaK = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _xdG = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_8YM.Commands._zJaK.Custom = true
_8YM.Commands._zJaK.Id = "23c16451-b7b8-421c-9df9-e48dc09157cf"
_8YM.Commands._zJaK.WorksWithAll = true
_8YM.Commands._xdG.Custom = true
_8YM.Commands._xdG.Id = "428e7b32-addf-4c52-aed1-9de32932e560"
_8YM.Commands._xdG.WorksWithAll = true
_8YM.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8YM.Locked = false
_8YM.Opened = false
_n0d = Wherigo.ZItem({Cartridge = _B29S, Container = zCache})
_n0d.Id = "a9668657-6e1a-4752-9682-85843cfb7726"
_n0d.Name = _jZ4Z("&\019lSw\025.")
_n0d.Description = _jZ4Z("\015\025./\003S\024zw\025/qS\0246\025SCe")
_n0d.Visible = true
_n0d.Media = _MA38
_n0d.Icon = _Ty93
_n0d.Commands = {
  _nGWG = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _whh = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_n0d.Commands._nGWG.Custom = true
_n0d.Commands._nGWG.Id = "ca5f5f86-b09f-420e-99f8-66c4522b04d1"
_n0d.Commands._nGWG.WorksWithAll = true
_n0d.Commands._whh.Custom = true
_n0d.Commands._whh.Id = "5068aaf0-6531-4191-ac2e-be6335f5a195"
_n0d.Commands._whh.WorksWithAll = true
_n0d.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_n0d.Locked = false
_n0d.Opened = false
_ibrNf = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_ibrNf.Id = "766d3a8f-3d67-491e-9f03-d8ec38d12d36"
_ibrNf.Name = _jZ4Z("5\025?LSCSF\025\024\022SCF\025")
_ibrNf.Description = _jZ4Z("\020lKG/\025S\024\025/zwF\025/4SCF\025/,SF/c\025LFwSKG\025\024/\f\025p.zLKGCC\019L.\025\024e/vL\003\003z\025wwSD/SCF/zLKG/GS\025./\025S\024/D.lCC\025C/&KGwlCCe")
_ibrNf.Visible = true
_ibrNf.Media = _j_nTQ
_ibrNf.Icon = _4XDN
_ibrNf.Commands = {
  _BHf1T = Wherigo.ZCommand({
    Text = _jZ4Z("l\025\003\003\024\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _G1PbN = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _0v6 = Wherigo.ZCommand({
    Text = _jZ4Z("_S\019\019/Glw\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_ibrNf.Commands._BHf1T.Custom = true
_ibrNf.Commands._BHf1T.Id = "b589d6ed-0962-443c-9b3f-1e6014cc6bc0"
_ibrNf.Commands._BHf1T.WorksWithAll = true
_ibrNf.Commands._G1PbN.Custom = true
_ibrNf.Commands._G1PbN.Id = "973a9866-3aa4-4e28-8121-48eb5bc65589"
_ibrNf.Commands._G1PbN.WorksWithAll = true
_ibrNf.Commands._0v6.Custom = true
_ibrNf.Commands._0v6.Id = "0aa5d985-1a74-4f15-9b63-a47d4b9e46d1"
_ibrNf.Commands._0v6.WorksWithAll = true
_ibrNf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ibrNf.Locked = false
_ibrNf.Opened = false
_r5S = Wherigo.ZItem({Cartridge = _B29S, Container = zFoyer})
_r5S.Id = "a6c66514-a5c2-46b4-b591-f22abcbb9612"
_r5S.Name = _jZ4Z("\015.\025GCKG\025Sp\025")
_r5S.Description = _jZ4Z("9S\024\025/D\025G\025S,\024SCklww\025/\015.\025GCKG\025Sp\025/,SF/2zGw\025\024\023/'z.p\025\024/L\024c/&d,plw\025\024U7u5{vp\025./GzwF/>/Gzp\025/SKG/cS\025/&d,plw\025/\024SKGF/CKGl\024/,zw/D\025C\025G\025\024\t/\\KG/,LCC/,S./czC/_G\025zF\025./,zw/\024z\025G\025./z\024C\025G\025\024e")
_r5S.Visible = true
_r5S.Media = _6JL0
_r5S.Icon = _sKVqq
_r5S.Commands = {
  _7LO7 = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _EpNA = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _sCsyf = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_r5S.Commands._7LO7.Custom = true
_r5S.Commands._7LO7.Id = "7f3c05ce-ed60-4326-8df7-76ceeb4fb20d"
_r5S.Commands._7LO7.WorksWithAll = true
_r5S.Commands._EpNA.Custom = true
_r5S.Commands._EpNA.Id = "cf84ef5d-c8f8-4851-ab2c-782b73fb9799"
_r5S.Commands._EpNA.WorksWithAll = true
_r5S.Commands._sCsyf.Custom = true
_r5S.Commands._sCsyf.Id = "aa671527-5a16-4e68-abbe-1abd876a15d3"
_r5S.Commands._sCsyf.WorksWithAll = true
_r5S.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_r5S.Locked = false
_r5S.Opened = false
_hiuW = Wherigo.ZItem({Cartridge = _B29S, Container = zFoyer})
_hiuW.Id = "459053a3-f094-411b-b091-5d2f4c0ef2cb"
_hiuW.Name = _jZ4Z("@.lD.z,,G\025\003F")
_hiuW.Description = _jZ4Z("9S\024/zwF\025C\023/,lc.SD\025C/\fz\025CF\025pLKG/,SF/\025FwSKG\025\024/&\025SF\025\024/klww/qS\0246\025SC\025\024/L\024c/z\024c\025.\025\024/\015S\024D\025\024e7u5{9C/CS\024c/zp\025./zLKG/\025FwSKG\025/&\025SF\025\024/G\025.zLCD\025.SCC\025\024e")
_hiuW.Visible = true
_hiuW.Media = _qwk
_hiuW.Icon = __mLYP
_hiuW.Commands = {
  _QgFzw = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _X39 = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _y6NU1 = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_hiuW.Commands._QgFzw.Custom = true
_hiuW.Commands._QgFzw.Id = "cccdfdb2-e36c-4d91-9249-334d6315ccb0"
_hiuW.Commands._QgFzw.WorksWithAll = true
_hiuW.Commands._X39.Custom = true
_hiuW.Commands._X39.Id = "10d42438-f1b5-453d-aa10-29b8d2462dd1"
_hiuW.Commands._X39.WorksWithAll = true
_hiuW.Commands._y6NU1.Custom = true
_hiuW.Commands._y6NU1.Id = "e45cb772-b4cd-4a5d-a5dd-5818bc8a65e7"
_hiuW.Commands._y6NU1.WorksWithAll = true
_hiuW.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_hiuW.Locked = false
_hiuW.Opened = false
_jyoH4 = Wherigo.ZItem({Cartridge = _B29S, Container = zFoyer})
_jyoH4.Id = "1e475c23-4d67-4d85-a8be-f116201a96b9"
_jyoH4.Name = _jZ4Z("_L\025./ML,/_G\025zF\025.Czzw")
_jyoH4.Description = _jZ4Z("9S\024\025/,zCCSk\025/_L\025.CF\025GF/M6SCKG\025\024/\015S./L\024c/c\025,/_G\025zF\025.Czzwe/vwC/6\025\024\024/czC/\024SKGF/CKG6\025./D\025\024LD/6z\025.\025\023/Gz\025\024DF/GS\025./\024lKG/\025S\024/\003\025FF\025C/&KGwlCCe")
_jyoH4.Visible = true
_jyoH4.Media = _F5w
_jyoH4.Icon = _ahn
_jyoH4.Commands = {
  _QTlT = Wherigo.ZCommand({
    Text = _jZ4Z("l\025\003\003\024\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _ptdi = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _8VpF = Wherigo.ZCommand({
    Text = _jZ4Z("_S\019\019/Glw\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_jyoH4.Commands._QTlT.Custom = true
_jyoH4.Commands._QTlT.Id = "f5e3bb7d-296e-4c3c-974c-8f71e3a8d64f"
_jyoH4.Commands._QTlT.WorksWithAll = true
_jyoH4.Commands._ptdi.Custom = true
_jyoH4.Commands._ptdi.Id = "f7b35063-527d-4c9d-83e6-846db63117e2"
_jyoH4.Commands._ptdi.WorksWithAll = true
_jyoH4.Commands._8VpF.Custom = true
_jyoH4.Commands._8VpF.Id = "06be3664-2c65-4865-995f-4c8bd22db4ed"
_jyoH4.Commands._8VpF.WorksWithAll = true
_jyoH4.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_jyoH4.Locked = false
_jyoH4.Opened = false
_Hfv = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_Hfv.Id = "038abebe-49bc-4229-a1b4-d92719b78a8f"
_Hfv.Name = _jZ4Z("5z\025FC\025w\022z.F\025/\f")
_Hfv.Description = _jZ4Z("9S\024\025/4z.F\025/,SF/\025S\024\025,/-\019CSwl\024e/nlML/cS\025C\025/6lGw/D\025Gl\025.F\t")
_Hfv.Visible = false
_Hfv.Media = _0fuHF
_Hfv.Icon = _dY1
_Hfv.Commands = {
  _WDp6 = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _POqR = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _UgoYr = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_Hfv.Commands._WDp6.Custom = true
_Hfv.Commands._WDp6.Id = "9bddfcc6-dcf4-4808-b9fd-0c36de886fb5"
_Hfv.Commands._WDp6.WorksWithAll = true
_Hfv.Commands._POqR.Custom = true
_Hfv.Commands._POqR.Id = "ffa3a8cf-e8dd-407b-a57a-25f35a1e7011"
_Hfv.Commands._POqR.WorksWithAll = true
_Hfv.Commands._UgoYr.Custom = true
_Hfv.Commands._UgoYr.Id = "975776a6-b64b-4bde-9a2d-2687b24a5dc8"
_Hfv.Commands._UgoYr.WorksWithAll = true
_Hfv.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Hfv.Locked = false
_Hfv.Opened = false
_WoOJ = Wherigo.ZItem({Cartridge = _B29S, Container = zTheatersaal})
_WoOJ.Id = "43246621-6a38-442d-8454-016dbf3b021c"
_WoOJ.Name = _jZ4Z("5z\025FC\025w\022z.F\025/v")
_WoOJ.Description = _jZ4Z("9S\024\025/4z.F\025/,SF/\025S\024\025,/4.\025SCe/nlML/cS\025C\025/6lGw/D\025Gl\025.F\t")
_WoOJ.Visible = true
_WoOJ.Media = _f7SPy
_WoOJ.Icon = _iav
_WoOJ.Commands = {
  _I5LZ = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _3FuVN = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _5eh = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_WoOJ.Commands._I5LZ.Custom = true
_WoOJ.Commands._I5LZ.Id = "eaeb4513-d91b-40fa-950b-f423d036af5f"
_WoOJ.Commands._I5LZ.WorksWithAll = true
_WoOJ.Commands._3FuVN.Custom = true
_WoOJ.Commands._3FuVN.Id = "8041e434-ae56-4f92-b47d-b9de811a9c75"
_WoOJ.Commands._3FuVN.WorksWithAll = true
_WoOJ.Commands._5eh.Custom = true
_WoOJ.Commands._5eh.Id = "e5e4ad1e-a093-49e3-b55c-0b8d690ad9bd"
_WoOJ.Commands._5eh.WorksWithAll = true
_WoOJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_WoOJ.Locked = false
_WoOJ.Opened = false
_BZOd8 = Wherigo.ZItem({Cartridge = _B29S, Container = zSeitenflur})
_BZOd8.Id = "2379a082-8dd0-4ff1-b38f-234977ba41a5"
_BZOd8.Name = _jZ4Z("5z\025FC\025w\022z.F\025/\015")
_BZOd8.Description = _jZ4Z("9S\024\025/4z.F\025/,SF/\025S\024\025,/&F\025.\024e/nlML/cS\025C\025/6lGw/D\025Gl\025.F\t")
_BZOd8.Visible = false
_BZOd8.Media = _uVjD
_BZOd8.Icon = _rjK
_BZOd8.Commands = {
  _NfzDT = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _0extB = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _7nJOf = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_BZOd8.Commands._NfzDT.Custom = true
_BZOd8.Commands._NfzDT.Id = "f3110902-19b7-4060-8303-062422c60315"
_BZOd8.Commands._NfzDT.WorksWithAll = true
_BZOd8.Commands._0extB.Custom = true
_BZOd8.Commands._0extB.Id = "1f69bd76-5e81-4aa9-a44d-57f1168a8fe5"
_BZOd8.Commands._0extB.WorksWithAll = true
_BZOd8.Commands._7nJOf.Custom = true
_BZOd8.Commands._7nJOf.Id = "d74fbb97-b204-49a2-8342-9e7741ba0373"
_BZOd8.Commands._7nJOf.WorksWithAll = true
_BZOd8.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_BZOd8.Locked = false
_BZOd8.Opened = false
_Xj78 = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_Xj78.Id = "bcd57189-f46a-4d4c-a215-87719152b177"
_Xj78.Name = _jZ4Z("4lCFL\025,\022SCF\025")
_Xj78.Description = _jZ4Z("9S\024\025/zwF\025.FL\025,wSKG\025/,lc.SD/.S\025KG\025\024c\025/4SCF\025e/vp\025./,SF/\025S\024\025,/\024\025L\025\024\023/,z\025KGFSD\025\024/&KGwlCCe")
_Xj78.Visible = true
_Xj78.Media = _Rtt
_Xj78.Icon = _y7_
_Xj78.Commands = {
  _BnkR = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  __8K = Wherigo.ZCommand({
    Text = _jZ4Z("l\025\003\003\024\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _NI7Z = Wherigo.ZCommand({
    Text = _jZ4Z("_S\019\019/Glw\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_Xj78.Commands._BnkR.Custom = true
_Xj78.Commands._BnkR.Id = "d8145bb4-374b-42c9-9d89-66c2cf92b5c1"
_Xj78.Commands._BnkR.WorksWithAll = true
_Xj78.Commands.__8K.Custom = true
_Xj78.Commands.__8K.Id = "36c88aca-7f99-43ab-b5c8-f7ccfd2bc61f"
_Xj78.Commands.__8K.WorksWithAll = true
_Xj78.Commands._NI7Z.Custom = true
_Xj78.Commands._NI7Z.Id = "5dc91101-bf97-438a-8591-5faa9d3d2bf2"
_Xj78.Commands._NI7Z.WorksWithAll = true
_Xj78.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Xj78.Locked = false
_Xj78.Opened = false
_wo6 = Wherigo.ZItem({Cartridge = _B29S, Container = zGarderobe})
_wo6.Id = "c61f3597-86ed-4ee3-be80-2e20a1cd2b6d"
_wo6.Name = _jZ4Z("9I\\_>&\019S\025w")
_wo6.Description = _jZ4Z("/9I\\_/>/\015zC/&\019S\025w/>/\015S\025/k\025.wzCC\025\024\025/qLFF\025e/kl\024/7u5{\\\024\022z/L\024c/Rz.\022LC/u.z\024c/zLC/c\025,/4lC,lC>\005\025.wzDe7u5{>/vLCD\025M\025SKG\024\025F/ML,/+4\025\024\024\025.C\019S\025w/c\025C/\014zG.\025C/\0013Hr+e7u5{>/)Sk\025>9CKz\019\025>'\025\025wS\024D/S,/'l.FD\025CKG.SFF\025\024\025\024>)\025k\025we7u5{>/\015\025./zF,lC\019Gz.SCKG\025/\020\025.k\025\024\022SFM\025w/\003L./ML/qzLC\025e7u5{7u5{vwF\025.=/zp/H\001/\014zG.\025\0247u5{&\019S\025wczL\025.=/\b\027>03/")
_wo6.Visible = true
_wo6.Media = _d9DQr
_wo6.Icon = _6_j
_wo6.Commands = {
  _qxt3 = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _j5x = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _UdqYd = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_wo6.Commands._qxt3.Custom = true
_wo6.Commands._qxt3.Id = "c70f82ba-9d6c-4918-a9f1-9f878f322ec2"
_wo6.Commands._qxt3.WorksWithAll = true
_wo6.Commands._j5x.Custom = true
_wo6.Commands._j5x.Id = "d60155cc-3459-4ed6-b6bd-a101e007e57a"
_wo6.Commands._j5x.WorksWithAll = true
_wo6.Commands._UdqYd.Custom = true
_wo6.Commands._UdqYd.Id = "a10f82f8-9dbc-47af-82f6-2cf5e1ebe59c"
_wo6.Commands._UdqYd.WorksWithAll = true
_wo6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_wo6.Locked = false
_wo6.Opened = false
_U9qJq = Wherigo.ZItem({Cartridge = _B29S, Container = zSeitenflur})
_U9qJq.Id = "4f43a2e0-f847-44f1-add7-a45b34f61491"
_U9qJq.Name = _jZ4Z("&KG.z\024\022")
_U9qJq.Description = ""
_U9qJq.Visible = true
_U9qJq.Media = _WxtG2
_U9qJq.Icon = _UKF
_U9qJq.Commands = {
  _eBT3 = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _xsV = Wherigo.ZCommand({
    Text = _jZ4Z("l\025\003\003\024\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _Uv3N = Wherigo.ZCommand({
    Text = _jZ4Z("_S\019\019/Glw\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_U9qJq.Commands._eBT3.Custom = true
_U9qJq.Commands._eBT3.Id = "d6988e28-40b7-4603-86f7-0f4e205d020f"
_U9qJq.Commands._eBT3.WorksWithAll = true
_U9qJq.Commands._xsV.Custom = true
_U9qJq.Commands._xsV.Id = "a793077b-ff2c-4c9a-82f6-9e41bf4d196d"
_U9qJq.Commands._xsV.WorksWithAll = true
_U9qJq.Commands._Uv3N.Custom = true
_U9qJq.Commands._Uv3N.Id = "41a6d893-42a5-48e3-b1fc-1875fef03b6b"
_U9qJq.Commands._Uv3N.WorksWithAll = true
_U9qJq.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_U9qJq.Locked = false
_U9qJq.Opened = false
_JcJga = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_JcJga.Id = "7f6c3b0b-331a-438a-918d-5df0287c4093"
_JcJga.Name = _jZ4Z("5z\025FC\025w\022z.F\025/\\")
_JcJga.Description = ""
_JcJga.Visible = false
_JcJga.Media = _qD7eg
_JcJga.Icon = _W88lJ
_JcJga.Commands = {
  _9nnHt = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _Fpfog = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _P4m8K = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_JcJga.Commands._9nnHt.Custom = true
_JcJga.Commands._9nnHt.Id = "07050ac3-7569-4446-97b9-9c68a9bc0b96"
_JcJga.Commands._9nnHt.WorksWithAll = true
_JcJga.Commands._Fpfog.Custom = true
_JcJga.Commands._Fpfog.Id = "593711d6-0aa8-4349-8366-5885c1ad67ac"
_JcJga.Commands._Fpfog.WorksWithAll = true
_JcJga.Commands._P4m8K.Custom = true
_JcJga.Commands._P4m8K.Id = "451eb230-cbfb-4e1a-9d49-a06f5b7e4d6e"
_JcJga.Commands._P4m8K.WorksWithAll = true
_JcJga.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_JcJga.Locked = false
_JcJga.Opened = false
_8WM = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_8WM.Id = "5345b60e-0715-4d21-a1d6-8984221ac18e"
_8WM.Name = _jZ4Z("5z\025FC\025w\022z.F\025/u")
_8WM.Description = ""
_8WM.Visible = false
_8WM.Media = _tSJY
_8WM.Icon = _veyV
_8WM.Commands = {
  _v_Sy = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _xhR = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _jIEQ = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_8WM.Commands._v_Sy.Custom = true
_8WM.Commands._v_Sy.Id = "60ebf11f-e00f-49c2-ac8b-f3d67bb71d3a"
_8WM.Commands._v_Sy.WorksWithAll = true
_8WM.Commands._xhR.Custom = true
_8WM.Commands._xhR.Id = "54543f42-1861-4083-ae2c-67d11b67c45b"
_8WM.Commands._xhR.WorksWithAll = true
_8WM.Commands._jIEQ.Custom = true
_8WM.Commands._jIEQ.Id = "67a28a2c-8f08-4c6b-8803-dcbd9297d9e5"
_8WM.Commands._jIEQ.WorksWithAll = true
_8WM.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8WM.Locked = false
_8WM.Opened = false
_omIv3 = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_omIv3.Id = "1ec18c10-89c7-4ffe-87c2-9d592dcff701"
_omIv3.Name = _jZ4Z("5z\025FC\025w\022z.F\025/P")
_omIv3.Description = ""
_omIv3.Visible = false
_omIv3.Media = _Isf
_omIv3.Icon = _ht6Vj
_omIv3.Commands = {
  _PmO = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _nUEMC = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _jplv = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_omIv3.Commands._PmO.Custom = true
_omIv3.Commands._PmO.Id = "f223aada-224a-499f-927a-1f2f59f99ead"
_omIv3.Commands._PmO.WorksWithAll = true
_omIv3.Commands._nUEMC.Custom = true
_omIv3.Commands._nUEMC.Id = "6e634e8d-65cc-423e-8cd3-53292d943dc2"
_omIv3.Commands._nUEMC.WorksWithAll = true
_omIv3.Commands._jplv.Custom = true
_omIv3.Commands._jplv.Id = "828806c2-40b2-42d6-914c-267b87a81295"
_omIv3.Commands._jplv.WorksWithAll = true
_omIv3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_omIv3.Locked = false
_omIv3.Opened = false
_nZ7Oh = Wherigo.ZItem({Cartridge = _B29S, Container = zFoyer})
_nZ7Oh.Id = "e484cd56-86f3-410e-80c4-477d4ae1d3d9"
_nZ7Oh.Name = _jZ4Z("_SK\022\025F/H")
_nZ7Oh.Description = _jZ4Z("9S\024/zwF\025C/9S\024F.SFFCFSK\022\025F/>/cS\025/@LFM\003.zL/6z./6lGw/CKGl\024/wz\025\024D\025./\024SKGF/,\025G./p\025S/c\025./v.p\025SFe")
_nZ7Oh.Visible = true
_nZ7Oh.Media = _kkn__
_nZ7Oh.Icon = _Hp1
_nZ7Oh.Commands = {
  _y18 = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _kmu = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _yDM5J = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_nZ7Oh.Commands._y18.Custom = true
_nZ7Oh.Commands._y18.Id = "687db941-a8a1-4ff0-8c1c-4687b1044eea"
_nZ7Oh.Commands._y18.WorksWithAll = true
_nZ7Oh.Commands._kmu.Custom = true
_nZ7Oh.Commands._kmu.Id = "6ba3b495-acc4-4886-883a-304f5606d54a"
_nZ7Oh.Commands._kmu.WorksWithAll = true
_nZ7Oh.Commands._yDM5J.Custom = true
_nZ7Oh.Commands._yDM5J.Id = "4c8a4b80-b320-41cf-9c28-92bf9e67b253"
_nZ7Oh.Commands._yDM5J.WorksWithAll = true
_nZ7Oh.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nZ7Oh.Locked = false
_nZ7Oh.Opened = false
_iwckB = Wherigo.ZItem({Cartridge = _B29S, Container = zSeitenflur})
_iwckB.Id = "25e56eca-d294-4946-99ea-d7abe135034e"
_iwckB.Name = _jZ4Z("_SK\022\025F/\001")
_iwckB.Description = _jZ4Z("9S\024/zwF\025C/9S\024F.SFFCFSK\022\025F/>/cS\025/@LFM\003.zL/6z./6lGw/CKGl\024/wz\025\024D\025./\024SKGF/,\025G./p\025S/c\025./v.p\025SFe")
_iwckB.Visible = false
_iwckB.Media = _9t69
_iwckB.Icon = _Hp1
_iwckB.Commands = {
  _Fo2at = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _v_b = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _NRV6 = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_iwckB.Commands._Fo2at.Custom = true
_iwckB.Commands._Fo2at.Id = "0287a77a-d38f-4bb9-9aad-515cf371ad4d"
_iwckB.Commands._Fo2at.WorksWithAll = true
_iwckB.Commands._v_b.Custom = true
_iwckB.Commands._v_b.Id = "10adbfbf-42c5-4fb3-bcc7-992083f8f830"
_iwckB.Commands._v_b.WorksWithAll = true
_iwckB.Commands._NRV6.Custom = true
_iwckB.Commands._NRV6.Id = "ac8175c2-6499-41b5-a783-ea51f0a1d031"
_iwckB.Commands._NRV6.WorksWithAll = true
_iwckB.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_iwckB.Locked = false
_iwckB.Opened = false
_xRH = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_xRH.Id = "86e71e1f-555a-416b-bf16-4afda7efa24e"
_xRH.Name = _jZ4Z("_SK\022\025F/i")
_xRH.Description = _jZ4Z("9S\024/zwF\025C/9S\024F.SFFCFSK\022\025F/>/cS\025/@LFM\003.zL/6z./6lGw/CKGl\024/wz\025\024D\025./\024SKGF/,\025G./p\025S/c\025./v.p\025SFe")
_xRH.Visible = true
_xRH.Media = _N1Vt
_xRH.Icon = _Hp1
_xRH.Commands = {
  _Ij5 = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _gHv = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _yT2W = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_xRH.Commands._Ij5.Custom = true
_xRH.Commands._Ij5.Id = "fb2a5056-371e-4435-bfea-a6758590106c"
_xRH.Commands._Ij5.WorksWithAll = true
_xRH.Commands._gHv.Custom = true
_xRH.Commands._gHv.Id = "0b0445ac-6924-4be3-86c8-475d8c58dce3"
_xRH.Commands._gHv.WorksWithAll = true
_xRH.Commands._yT2W.Custom = true
_xRH.Commands._yT2W.Id = "90ccc759-f470-4ab7-9884-ce91bdd518a3"
_xRH.Commands._yT2W.WorksWithAll = true
_xRH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xRH.Locked = false
_xRH.Opened = false
_noNk_ = Wherigo.ZItem({Cartridge = _B29S, Container = zFoyer})
_noNk_.Id = "9bf85ee8-d6af-430a-89e6-35e69c293d51"
_noNk_.Name = _jZ4Z("5z\025FC\025w\022z.F\025/9")
_noNk_.Description = ""
_noNk_.Visible = true
_noNk_.Media = _RntjX
_noNk_.Icon = _SEl
_noNk_.Commands = {
  _133vS = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _17j = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_noNk_.Commands._133vS.Custom = true
_noNk_.Commands._133vS.Id = "dee202bc-92e0-4454-8c92-1e4023e8cf7b"
_noNk_.Commands._133vS.WorksWithAll = true
_noNk_.Commands._17j.Custom = true
_noNk_.Commands._17j.Id = "7f27ac1d-fb3c-47dd-8c59-975a01892805"
_noNk_.Commands._17j.WorksWithAll = true
_noNk_.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_noNk_.Locked = false
_noNk_.Opened = false
_RWPG = Wherigo.ZItem({Cartridge = _B29S, Container = zFoyer})
_RWPG.Id = "14adc10c-e798-49b6-97f4-cdff64b1d985"
_RWPG.Name = _jZ4Z("vLCDz\024DCFL\025.")
_RWPG.Description = _jZ4Z("\015\025./9S\024Dz\024D/>/lc\025./zLKG/vLCDz\024De/\\,/@.S\024MS\019/`ze/\\,,\025.GS\024/pSCF/\015L/GS\025./G\025.\025S\024D\025\022l,,\025\024e7u5{vp\025./`\025FMF/CS\024c/cS\025/_L\025.\025\024/ML/L\024c/k\025..S\025D\025wFe7u5{vLKG/czC/\fwzC/CS\025GF/9S\024p.LKGCCSKG\025./zLCe/7u5{&l/D\025GF/\025C/zwCl/\024SKGFe")
_RWPG.Visible = true
_RWPG.Media = _Uc6mv
_RWPG.Icon = _p2qcl
_RWPG.Commands = {
  _5VL = Wherigo.ZCommand({
    Text = _jZ4Z("l\025\003\003\024\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _VD9 = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_RWPG.Commands._5VL.Custom = true
_RWPG.Commands._5VL.Id = "e68f387b-6ba3-4085-872c-22ca438b04c7"
_RWPG.Commands._5VL.WorksWithAll = true
_RWPG.Commands._VD9.Custom = true
_RWPG.Commands._VD9.Id = "42591c21-daaa-4e46-9996-31d92e700936"
_RWPG.Commands._VD9.WorksWithAll = true
_RWPG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_RWPG.Locked = false
_RWPG.Opened = false
_8rkM4 = Wherigo.ZItem({Cartridge = _B29S, Container = zSeitenflur})
_8rkM4.Id = "da04ce2e-4fd9-4e2f-9eac-5aa7a7b10027"
_8rkM4.Name = _jZ4Z(".lF\025/)lKG\022z.F\025")
_8rkM4.Description = _jZ4Z("9S\024\025/.z\025FC\025wGz\003F\025/.lF\025/4z.F\025/,SF/)l\025KG\025.\024/L\024c/uLKGCFzp\025\024e")
_8rkM4.Visible = false
_8rkM4.Media = _gFj
_8rkM4.Icon = _u7YwZ
_8rkM4.Commands = {
  _Grgy = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _SlQYm = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _qMl = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_8rkM4.Commands._Grgy.Custom = true
_8rkM4.Commands._Grgy.Id = "7f4f972f-d339-4171-b3bb-81d4a0fa1349"
_8rkM4.Commands._Grgy.WorksWithAll = true
_8rkM4.Commands._SlQYm.Custom = true
_8rkM4.Commands._SlQYm.Id = "bdaf2649-feb5-449c-b01f-53d607b5d291"
_8rkM4.Commands._SlQYm.WorksWithAll = true
_8rkM4.Commands._qMl.Custom = true
_8rkM4.Commands._qMl.Id = "170038b0-0b27-45d4-bb6c-352cfa17f31a"
_8rkM4.Commands._qMl.WorksWithAll = true
_8rkM4.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8rkM4.Locked = false
_8rkM4.Opened = false
_S9lqN = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_S9lqN.Id = "d23180ea-450f-419d-8fd4-9fc9dd18e9b3"
_S9lqN.Name = _jZ4Z("pwzL\025/)lKG\022z.F\025")
_S9lqN.Description = _jZ4Z("9S\024\025/.z\025FC\025wGz\003F\025/pwzL\025/4z.F\025/,SF/)l\025KG\025.\024/L\024c/uLKGCFzp\025\024e")
_S9lqN.Visible = false
_S9lqN.Media = _9zNG
_S9lqN.Icon = _PIW
_S9lqN.Commands = {
  _Dc_ = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _D3l = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _eHy9C = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_S9lqN.Commands._Dc_.Custom = true
_S9lqN.Commands._Dc_.Id = "9a09f347-44ac-4db9-b934-cf7d171dbe95"
_S9lqN.Commands._Dc_.WorksWithAll = true
_S9lqN.Commands._D3l.Custom = true
_S9lqN.Commands._D3l.Id = "4eb755f7-1058-4770-a074-4b5a6f91369a"
_S9lqN.Commands._D3l.WorksWithAll = true
_S9lqN.Commands._eHy9C.Custom = true
_S9lqN.Commands._eHy9C.Id = "01df35fe-a697-4bce-aeff-732fce1c42e5"
_S9lqN.Commands._eHy9C.WorksWithAll = true
_S9lqN.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_S9lqN.Locked = false
_S9lqN.Opened = false
_xKx6 = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_xKx6.Id = "5601cdb9-cf1b-4461-96f9-f17330242f92"
_xKx6.Name = _jZ4Z("D.L\025\024\025/)lKG\022z.F\025")
_xKx6.Description = _jZ4Z("9S\024\025/.z\025FC\025wGz\003F\025/D.L\025\024\025/4z.F\025/,SF/)l\025KG\025.\024/L\024c/uLKGCFzp\025\024e")
_xKx6.Visible = false
_xKx6.Media = _l2O
_xKx6.Icon = _nfrY
_xKx6.Commands = {
  _8n8zf = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _3XTp = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  __wp = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_xKx6.Commands._8n8zf.Custom = true
_xKx6.Commands._8n8zf.Id = "fa305427-aca6-4728-8595-b8a55c697d9c"
_xKx6.Commands._8n8zf.WorksWithAll = true
_xKx6.Commands._3XTp.Custom = true
_xKx6.Commands._3XTp.Id = "d9c2aae3-9fcc-43b3-86d2-cf227394c61d"
_xKx6.Commands._3XTp.WorksWithAll = true
_xKx6.Commands.__wp.Custom = true
_xKx6.Commands.__wp.Id = "7478dc76-424f-472e-94fc-b23045d2fe76"
_xKx6.Commands.__wp.WorksWithAll = true
_xKx6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_xKx6.Locked = false
_xKx6.Opened = false
_dph = Wherigo.ZItem({Cartridge = _B29S, Container = zBuehne})
_dph.Id = "360a2b42-a34b-48f1-9e14-b140365982ea"
_dph.Name = _jZ4Z("\005l.Gz\024D")
_dph.Description = ""
_dph.Visible = true
_dph.Media = _IT5
_dph.Icon = _mCF
_dph.Commands = {
  _s1_ = Wherigo.ZCommand({
    Text = _jZ4Z("l\025\003\003\024\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _UPQsj = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _LiKr = Wherigo.ZCommand({
    Text = _jZ4Z("_S\019\019/Glw\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_dph.Commands._s1_.Custom = true
_dph.Commands._s1_.Id = "d651d43f-ab0f-4b3a-9c2b-7e892d1fc95a"
_dph.Commands._s1_.WorksWithAll = true
_dph.Commands._UPQsj.Custom = true
_dph.Commands._UPQsj.Id = "2e69e6d4-c5b7-4114-9a77-2e64fd76ffbc"
_dph.Commands._UPQsj.WorksWithAll = true
_dph.Commands._LiKr.Custom = true
_dph.Commands._LiKr.Id = "df249297-0ac6-4e6a-8518-79ff882edaa9"
_dph.Commands._LiKr.WorksWithAll = true
_dph.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_dph.Locked = false
_dph.Opened = false
_QhHN = Wherigo.ZItem({Cartridge = _B29S, Container = zSeitenflur})
_QhHN.Id = "0f7f5ec7-da3e-498c-96ae-a708dde63c51"
_QhHN.Name = _jZ4Z("@.lD.z,,G\025\003FC\025SF\025")
_QhHN.Description = ""
_QhHN.Visible = false
_QhHN.Media = _ikuZp
_QhHN.Icon = _xRi6
_QhHN.Commands = {
  _ULfCQ = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _IcTtK = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _DoM = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_QhHN.Commands._ULfCQ.Custom = true
_QhHN.Commands._ULfCQ.Id = "74e4b76b-be8a-4f1f-887b-d3e9dca0a9db"
_QhHN.Commands._ULfCQ.WorksWithAll = true
_QhHN.Commands._IcTtK.Custom = true
_QhHN.Commands._IcTtK.Id = "0778b463-b23d-4a98-b397-e135f983ab98"
_QhHN.Commands._IcTtK.WorksWithAll = true
_QhHN.Commands._DoM.Custom = true
_QhHN.Commands._DoM.Id = "31dac9e9-2fba-40e9-8e2d-545e416e884f"
_QhHN.Commands._DoM.WorksWithAll = true
_QhHN.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QhHN.Locked = false
_QhHN.Opened = false
_8CmUA = Wherigo.ZItem({Cartridge = _B29S, Container = zTheatersaal})
_8CmUA.Id = "3115a24e-772b-441a-a400-2fd9c8635e90"
_8CmUA.Name = _jZ4Z("u\025CFLGwL\024D")
_8CmUA.Description = _jZ4Z("\015S\025/u\025CFLGwL\024D/c\025C/_G\025zF\025.CzzwCe/\015S\025/&FL\025Gw\025/C\025G\025\024/.\025SKGwSKG/zpD\025\024LFMF/zLCe")
_8CmUA.Visible = true
_8CmUA.Media = _gSVj
_8CmUA.Icon = _j7z
_8CmUA.Commands = {
  _Toi = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_8CmUA.Commands._Toi.Custom = true
_8CmUA.Commands._Toi.Id = "422d02ca-8920-4fae-a23b-496feae57b45"
_8CmUA.Commands._Toi.WorksWithAll = true
_8CmUA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8CmUA.Locked = false
_8CmUA.Opened = false
_US5 = Wherigo.ZItem({Cartridge = _B29S, Container = zGarderobe})
_US5.Id = "f0cf0c78-d512-411f-9cae-7a4a4edcfbda"
_US5.Name = _jZ4Z("\fz.c\025.lp\025")
_US5.Description = _jZ4Z("\015S\025/\fz.c\025.lp\025/c\025C/&KGwlCCFG\025zF\025.Ce7u5{9C/CKG\025S\024\025\024/\024lKG/\025S\024/\019zz./\fz\025CF\025/GS\025./ML/C\025S\024/>/lc\025./CS\025/Gzp\025\024/SG.\025/&zKG\025\024/k\025.D\025CC\025\024e")
_US5.Visible = true
_US5.Media = _F8C
_US5.Icon = _1Avn
_US5.Commands = {
  _bGMn = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_US5.Commands._bGMn.Custom = true
_US5.Commands._bGMn.Id = "f9e952c3-9e3c-4936-ad65-90675b0cbd2e"
_US5.Commands._bGMn.WorksWithAll = true
_US5.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_US5.Locked = false
_US5.Opened = false
_RVHf = Wherigo.ZItem({Cartridge = _B29S, Container = zTheatersaal})
_RVHf.Id = "2be81af1-319e-4299-a969-e7eee836f11d"
_RVHf.Name = _jZ4Z("5z\025FC\025w\022z.F\025/4")
_RVHf.Description = ""
_RVHf.Visible = true
_RVHf.Media = _CX7p
_RVHf.Icon = _OjZJP
_RVHf.Commands = {
  _hOK19 = Wherigo.ZCommand({
    Text = _jZ4Z("\024\025G,\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _QwPD = Wherigo.ZCommand({
    Text = _jZ4Z("z\024C\025G\025\024"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  }),
  _Pu5EI = Wherigo.ZCommand({
    Text = _jZ4Z("zpw\025D\025\024"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _jZ4Z("\020SKGF/k\025.\003LDpz.")
  })
}
_RVHf.Commands._hOK19.Custom = true
_RVHf.Commands._hOK19.Id = "a1479835-23c1-4f40-ae61-087d6125e78e"
_RVHf.Commands._hOK19.WorksWithAll = true
_RVHf.Commands._QwPD.Custom = true
_RVHf.Commands._QwPD.Id = "d18e3ce7-ddcb-4492-bb8b-e28428e3151a"
_RVHf.Commands._QwPD.WorksWithAll = true
_RVHf.Commands._Pu5EI.Custom = true
_RVHf.Commands._Pu5EI.Id = "49d13b37-a70d-4100-a9e4-470f7835e5ac"
_RVHf.Commands._Pu5EI.WorksWithAll = true
_RVHf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_RVHf.Locked = false
_RVHf.Opened = false
_2uKb1 = Wherigo.ZTask(_B29S)
_2uKb1.Id = "6a66ed27-51f9-47c8-bc0c-86d725e02f10"
_2uKb1.Name = _jZ4Z("\020SKGFC/6S\025/.zLC/GS\025.")
_2uKb1.Description = _jZ4Z("\015\025S\024/2S\025w/SCF/\025C\023/,l\025DwSKGCF/CKG\024\025ww/czC/\f\025G\025S,\024SC/c\025./@.\025,S\025.\025/L\024c/cz,SF/c\025\024/\005l.Gz\024D/ML/wL\025\003F\025\024e")
_2uKb1.Visible = true
_2uKb1.Active = true
_2uKb1.Complete = false
_2uKb1.CorrectState = "None"
_jse = 0
_pZ7o = 0
_xnMW = 0
_4rPB = 0
_dB1w = 0
_TT3 = 0
_5nF9r = 0
_AI59 = 0
_HUpu = 0
_grT = 0
__KPiO = false
_Su73X = _jZ4Z("M\fz.c\025.lp\025")
_9gum = _jZ4Z("cL,,d")
_quqmv = _jZ4Z("\v)5dpi")
_Rb1t = _jZ4Z("\v\001L4pH")
_Gef = _jZ4Z("\vzo2L")
_xtFY = _jZ4Z("cL,,d")
_B29S.ZVariables = {
  _jse = 0,
  _pZ7o = 0,
  _xnMW = 0,
  _4rPB = 0,
  _dB1w = 0,
  _TT3 = 0,
  _5nF9r = 0,
  _AI59 = 0,
  _HUpu = 0,
  _grT = 0,
  __KPiO = false,
  _Su73X = _jZ4Z("M\fz.c\025.lp\025"),
  _9gum = _jZ4Z("cL,,d"),
  _quqmv = _jZ4Z("\v)5dpi"),
  _Rb1t = _jZ4Z("\v\001L4pH"),
  _Gef = _jZ4Z("\vzo2L"),
  _xtFY = _jZ4Z("cL,,d")
}
_a8Zu = Wherigo.ZInput(_B29S)
_a8Zu.Id = "dba68b6d-a5ea-4571-97b0-b809738d4ba0"
_a8Zu.Name = _jZ4Z("4lCFL\025,\022SCF\025")
_a8Zu.Description = ""
_a8Zu.Visible = true
_a8Zu.Media = _Rtt
_a8Zu.Icon = _y7_
_a8Zu.InputType = "Text"
_a8Zu.Text = _jZ4Z("nS\025/wzLF\025F/cS\025/4l,pS\024zFSl\024\t")
_Mbl = Wherigo.ZInput(_B29S)
_Mbl.Id = "427eb8c7-8ab0-42a7-9d37-7aec22ff495e"
_Mbl.Name = _jZ4Z("5\025?LSCSF\025\024\022SCF\025")
_Mbl.Description = ""
_Mbl.Visible = true
_Mbl.Media = _j_nTQ
_Mbl.Icon = _4XDN
_Mbl.InputType = "Text"
_Mbl.Text = _jZ4Z("nS\025/wzLF\025F/cS\025/4l,pS\024zFSl\024\t")
_KN7hB = Wherigo.ZInput(_B29S)
_KN7hB.Id = "e37b40ef-5464-446f-8f48-41edd53f5484"
_KN7hB.Name = _jZ4Z("&KG.z\024\022")
_KN7hB.Description = ""
_KN7hB.Visible = true
_KN7hB.Media = _WxtG2
_KN7hB.Icon = _UKF
_KN7hB.InputType = "Text"
_KN7hB.Text = _jZ4Z("nS\025/wzLF\025F/cS\025/4l,pS\024zFSl\024\t")
_8CTPm = Wherigo.ZInput(_B29S)
_8CTPm.Id = "54bd2d43-5b38-48bf-abeb-5399d8279697"
_8CTPm.Name = _jZ4Z("_L\025./ML,/_G\025zF\025.Czzw")
_8CTPm.Description = ""
_8CTPm.Visible = true
_8CTPm.Media = _F5w
_8CTPm.Icon = _ahn
_8CTPm.InputType = "Text"
_8CTPm.Text = _jZ4Z("nS\025/wzLF\025F/cS\025/4l,pS\024zFSl\024\t")
_hYDHZ = Wherigo.ZInput(_B29S)
_hYDHZ.Id = "ec98c3c9-98e7-46d7-b04c-2014dcc2195d"
_hYDHZ.Name = _jZ4Z("\005l.Gz\024D")
_hYDHZ.Description = ""
_hYDHZ.Visible = true
_hYDHZ.Media = _IT5
_hYDHZ.Icon = _mCF
_hYDHZ.InputType = "Text"
_hYDHZ.Text = _jZ4Z("nS\025/wzLF\025F/cS\025/4l,pS\024zFSl\024\t")
function _B29S:OnStart()
  initFeld()
  _Urwigo.MessageBox({
    Text = _jZ4Z("u\025kl./\025C/wlCD\025GF/>/p.zLKGCF/\015L/\024lKG/\025F6zC/qSw\003\025\t"),
    Media = _d_A,
    Buttons = {
      _jZ4Z("`z"),
      _jZ4Z("\024\025S\024")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        _Urwigo.Dialog(false, {
          {
            Text = _jZ4Z("9C/DSpF/\022\025S\024\025\024/&\019S\025w\019wz\024e/\015L/p\025CFS,,CF\023/6lGS\024/\015L/D\025GCF/L\024c/6zC/\015L/FLCFe"),
            Media = _0nS
          },
          {
            Text = _jZ4Z("\\\024/c\025\024/2l\024\025\024/\003S\024c\025CF/\015L/\f\025D\025\024CFz\025\024c\025e/\015S\025C\025/\022z\024\024CF/\015L/p\025F.zKGF\025\024/L\024c/zLKG/,SF\024\025G,\025\024e7u5{n\025\024\024/\025F6zC/k\025.CKGwlCC\025\024/SCF\023/DSpF/\025C/zLKG/\025S\024\025\024/n\025D\023/czC/&KGwlCC/ML/l\025\003\003\024\025\024e/7u5{)\025Sc\025./SCF/cS\025C\025./n\025D/\025S\024/5z\025FC\025we"),
            Media = _0nS
          },
          {
            Text = _jZ4Z("\015lKG/\022\025S\024\025/v\024DCF/>/\015S./6S.c/D\025Glw\003\025\024e/\015L/\022z\024\024CF/\015S./_S\019\019C/Glw\025\024U"),
            Media = _0nS
          },
          {
            Text = _jZ4Z("\015zC/&\019S\025w/\025\024c\025F\023/6\025\024\024/\015L/czC/w\025FMF\025/5z\025FC\025w/D\025wl\025CF/GzCFe7u5{9G.\025\024CzKG\025\023/czCC/\015L/cz\024zKG/\015SKG/S\024C/)lDpLKG/\025S\024F.z\025DCFe"),
            Media = _0nS
          },
          {
            Text = _jZ4Z("vp\025./zL\003\019zCC\025\024=/\025S\024/_S,\025./Mz\025GwF/cS\025/RS\024LF\025\024/L\024c/SKG/Mz\025Gw\025/cS\025/2zGw/c\025./_S\019\019Ce7u5{Rzw/C\025G\025\024\023/6S\025/CKG\024\025ww/L\024c/DLF/\015L/pSCF/eee"),
            Media = _uWZhe
          },
          {
            Text = _jZ4Z("\015zC/&\019S\025w/p\025DS\024\024FU"),
            Media = _uWZhe
          }
        }, function(action)
          Wherigo.PlayAudio(_DhsSs)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      else
      end
    end
  })
end
function _B29S:OnRestore()
end
function zFoyer:OnEnter()
  _Su73X = _jZ4Z("M'ld\025.")
  zGarderobe.Visible = true
  zGarderobe.Active = true
  zSeitenflur.Active = true
  zSeitenflur.Visible = true
  if __KPiO == false then
    __KPiO = true
    _Urwigo.Dialog(false, {
      {
        Text = _jZ4Z("vwC/SG./czC/'ld\025./c\025C/_G\025zF\025.C/p\025F.\025F\025F\023/,\025.\022F/SG./Cl\003l.F\023/czCC/\025C/GS\025./\024SKGF/,SF/.\025KGF\025\024/\015S\024D\025\024/MLD\025GFe/"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("\015zC/D\025Cz,F\025/_G\025zF\025./SCF/k\025.wzCC\025\024e/"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("\r\025p\025.zww/k\025.CKGwlCC\025\024\025/_L\025.\025\024/L\024c/4SCF\025\024e"),
        Media = _d_A
      }
    }, function(action)
      Wherigo.PlayAudio(_cqx)
      _Urwigo.MessageBox({
        Text = _jZ4Z("vLKG/c\025./vLCDz\024D/GS\024F\025./9LKG/SCF/\019wl\025FMwSKG/k\025..S\025D\025wFe"),
        Media = _d_A,
        Callback = function(action)
          if action ~= nil then
            Wherigo.PlayAudio(_eTDYv)
            _Urwigo.Dialog(false, {
              {
                Text = _jZ4Z("qzpF/\022\025S\024\025/v\024DCF/>/6\025\024\024/SG./qSw\003\025/p.zLKGF/>/SKG/pS\024/p\025S/9LKGe"),
                Media = _0nS
              },
              {
                Text = _jZ4Z("vp\025./p\025\025SwF/9LKG/>/cS\025/2\025SF/wz\025L\003FU"),
                Media = _uWZhe
              }
            }, function(action)
              local _Urwigo_Date = os.date("*t")
              Wherigo.PlayAudio(_DhsSs)
              _jse = _Urwigo.Date_MinuteInDay(_Urwigo_Date)
            end)
          end
        end
      })
    end)
  else
  end
end
function zBuehne:OnEnter()
  _Su73X = _jZ4Z("MuL\025G\024\025")
  zFoyer.Active = false
  zFoyer.Visible = false
  zBuehne.Media = _7xdM
end
function zBuehne:OnExit()
  _Su73X = _jZ4Z("MuL\025G\024\025")
  if _dph.Opened == true then
    zBuehne.Visible = false
    zBuehne.Active = false
  end
end
function zTheatersaal:OnEnter()
  _Su73X = _jZ4Z("M_G\025zF\025.Czzw")
  zGarderobe.Visible = false
  zGarderobe.Active = false
  zSeitenflur.Active = false
  zSeitenflur.Visible = false
  zBuehne.Active = true
  zBuehne.Visible = true
  zSchlosstheater.Active = false
  zSchlosstheater.Visible = false
end
function zSchlosstheater:OnEnter()
  _Su73X = _jZ4Z("M&KGwlCCFG\025zF\025.")
  zGarderobe.Visible = false
  zGarderobe.Active = false
  zSeitenflur.Active = false
  zSeitenflur.Visible = false
  zTheatersaal.Active = false
  zTheatersaal.Visible = false
end
function _a8Zu:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    Wherigo.PlayAudio(_HVs)
    _Urwigo.MessageBox({
      Text = _jZ4Z("nl/SCF/czC/@.lpw\025,\023/\025S\024\025/2zGw/\025S\024MLD\025p\025\024\t7u5{"),
      Media = _d_A
    })
    return
  end
  if input == 960 then
    _B29S:RequestSync()
    Wherigo.PlayAudio(_cqx)
    _Xj78.Opened = true
    _B29S:RequestSync()
    _S9lqN.Visible = true
    _8WM.Visible = true
    _Hfv.Visible = true
    _JcJga.Visible = true
    _Urwigo.MessageBox({
      Text = _jZ4Z("@\025.\003\025\022FU/vp\025./6zC/SCF/czC\t/4\025S\024/_L\025.CKGwL\025CC\025wU/\015L/\003S\024c\025CF/6\025SF\025.\025/W\024pC\019\0025z\025FC\025w\022z.F\025\024/L\024c/\025S\024\025/pwzL\025/)lKG,zC\022\025e"),
      Media = _d_A,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Wherigo.PlayAudio(_DhsSs)
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.1 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015L/CS\025GCF/Cl/Kw\025k\025./zLC/eee/L\024c/cz\024\024/Cl6zCe7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.2 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zC/6z./\024SA/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.3 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/F.zL.SD/C\025S\024\023/6\025SF\025.,zKG\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.4 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020l\025U/7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.5 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("5z\025FC\025w/wl\025C\025\024/SCF/6lGw/\024SKGF/\015\025S\024/\015S\024D\023/6zC\t7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.6 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zCC/czC/\024SKGFC/6S.c\023/GzF/,z\024/CKGl\024/S,/v\024CzFM/D\025C\025G\025\024/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.7 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015S\025/G\025wwCF\025/4\025.M\025/zL\003/c\025./_l.F\025/SCF/6lGw/zLCU7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.8 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G/lG/lG\023/lp/czC/\024lKG/6zC/6S.c/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.9 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G\023/,zw/6S\025c\025./\003zwCKG/\022l,pS\024S\025.F/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    else
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/.zF\025\024U/7u5{)lDSCKG/\022l,pS\024S\025.\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    end
  end
end
function _Mbl:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    Wherigo.PlayAudio(_HVs)
    _Urwigo.MessageBox({
      Text = _jZ4Z("nl/SCF/czC/@.lpw\025,\023/\025S\024\025/2zGw/\025S\024MLD\025p\025\024\t7u5{"),
      Media = _d_A
    })
    return
  end
  if input == 302 then
    _B29S:RequestSync()
    Wherigo.PlayAudio(_cqx)
    _ibrNf.Opened = true
    _xKx6.Visible = true
    _omIv3.Visible = true
    _B29S:RequestSync()
    _Urwigo.MessageBox({
      Text = _jZ4Z("\\,,\025.GS\024/>/cS\025/4SCF\025/SCF/zL\003U7u5{vp\025./cS\025/5z\025FC\025w/CKG\025S\024\025\024/6\025SF\025./ML/D\025G\025\024e/\015L/\003S\024c\025CF/M6\025S/6\025SF\025.\025/4z.F\025\024e"),
      Media = _d_A,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Wherigo.PlayAudio(_DhsSs)
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.1 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015L/CS\025GCF/Cl/Kw\025k\025./zLC/eee/L\024c/cz\024\024/Cl6zCe7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.2 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zC/6z./\024SA/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.3 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/F.zL.SD/C\025S\024\023/6\025SF\025.,zKG\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.4 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020l\025U/7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.5 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("5z\025FC\025w/wl\025C\025\024/SCF/6lGw/\024SKGF/\015\025S\024/\015S\024D\023/6zC\t7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.6 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zCC/czC/\024SKGFC/6S.c\023/GzF/,z\024/CKGl\024/S,/v\024CzFM/D\025C\025G\025\024/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.7 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015S\025/G\025wwCF\025/4\025.M\025/zL\003/c\025./_l.F\025/SCF/6lGw/zLCU7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.8 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G/lG/lG\023/lp/czC/\024lKG/6zC/6S.c/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.9 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G\023/,zw/6S\025c\025./\003zwCKG/\022l,pS\024S\025.F/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    else
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/.zF\025\024U/7u5{)lDSCKG/\022l,pS\024S\025.\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    end
  end
end
function _KN7hB:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    Wherigo.PlayAudio(_HVs)
    _Urwigo.MessageBox({
      Text = _jZ4Z("nl/SCF/czC/@.lpw\025,\023/\025S\024\025/2zGw/\025S\024MLD\025p\025\024\t7u5{"),
      Media = _d_A
    })
    return
  end
  if input == 653 then
    _B29S:RequestSync()
    Wherigo.PlayAudio(_cqx)
    _U9qJq.Opened = true
    _B29S:RequestSync()
    _BZOd8.Visible = true
    _8rkM4.Visible = true
    _iwckB.Visible = true
    _QhHN.Visible = true
    _Urwigo.MessageBox({
      Text = _jZ4Z("@\025.\003\025\022FU/vp\025./6zC/SCF/czC\t/4\025S\024/qS\0246\025SC/ML./@.\025,S\025.\025U/7u5{\015L/\003S\024c\025CF/\024L./\025S\024\025/6\025SF\025.\025/4z.F\025\024e7u5{vp\025./GzwF/>/cz/SCF/zLKG/\025S\024\025/&\025SF\025/zLC/c\025,/@.lD.z,,G\025\003Fe"),
      Media = _d_A,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Wherigo.PlayAudio(_DhsSs)
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.1 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015L/CS\025GCF/Cl/Kw\025k\025./zLC/eee/L\024c/cz\024\024/Cl6zCe7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.2 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zC/6z./\024SA/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.3 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/F.zL.SD/C\025S\024\023/6\025SF\025.,zKG\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.4 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020l\025U/7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.5 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("5z\025FC\025w/wl\025C\025\024/SCF/6lGw/\024SKGF/\015\025S\024/\015S\024D\023/6zC\t7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.6 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zCC/czC/\024SKGFC/6S.c\023/GzF/,z\024/CKGl\024/S,/v\024CzFM/D\025C\025G\025\024/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.7 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015S\025/G\025wwCF\025/4\025.M\025/zL\003/c\025./_l.F\025/SCF/6lGw/zLCU7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.8 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G/lG/lG\023/lp/czC/\024lKG/6zC/6S.c/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.9 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G\023/,zw/6S\025c\025./\003zwCKG/\022l,pS\024S\025.F/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    else
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/.zF\025\024U/7u5{)lDSCKG/\022l,pS\024S\025.\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    end
  end
end
function _8CTPm:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    Wherigo.PlayAudio(_HVs)
    _Urwigo.MessageBox({
      Text = _jZ4Z("nl/SCF/czC/@.lpw\025,\023/\025S\024\025/2zGw/\025S\024MLD\025p\025\024\t7u5{"),
      Media = _d_A
    })
    return
  end
  if input == 293 then
    _B29S:RequestSync()
    Wherigo.PlayAudio(_cqx)
    zTheatersaal.Active = true
    zTheatersaal.Visible = true
    _jyoH4.Opened = true
    _B29S:RequestSync()
    _Urwigo.MessageBox({
      Text = _jZ4Z("@\025.\003\025\022FU/\015S\025/_L\025./ML,/_G\025zF\025.Czzw/SCF/l\003\003\025\024e"),
      Media = _0nS,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Wherigo.PlayAudio(_DhsSs)
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.1 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015L/CS\025GCF/Cl/Kw\025k\025./zLC/eee/L\024c/cz\024\024/Cl6zCe7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.2 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zC/6z./\024SA/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.3 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/F.zL.SD/C\025S\024\023/6\025SF\025.,zKG\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.4 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020l\025U/7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.5 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("5z\025FC\025w/wl\025C\025\024/SCF/6lGw/\024SKGF/\015\025S\024/\015S\024D\023/6zC\t7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.6 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zCC/czC/\024SKGFC/6S.c\023/GzF/,z\024/CKGl\024/S,/v\024CzFM/D\025C\025G\025\024/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.7 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015S\025/G\025wwCF\025/4\025.M\025/zL\003/c\025./_l.F\025/SCF/6lGw/zLCU7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.8 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G/lG/lG\023/lp/czC/\024lKG/6zC/6S.c/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.9 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G\023/,zw/6S\025c\025./\003zwCKG/\022l,pS\024S\025.F/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    else
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/.zF\025\024U/7u5{)lDSCKG/\022l,pS\024S\025.\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    end
  end
end
function _hYDHZ:OnGetInput(input)
  local _Urwigo_Date = os.date("*t")
  input = tonumber(input)
  if input == nil then
    Wherigo.PlayAudio(_HVs)
    _Urwigo.MessageBox({
      Text = _jZ4Z("nl/SCF/czC/@.lpw\025,\023/\025S\024\025/2zGw/\025S\024MLD\025p\025\024\t7u5{"),
      Media = _d_A
    })
    return
  end
  if input == 542 then
    _B29S:RequestSync()
    _pZ7o = _Urwigo.Date_MinuteInDay(_Urwigo_Date)
    _dph.Opened = true
    _8YM.Visible = true
    _B29S.Complete = true
    _2uKb1.Complete = true
    _B29S:RequestSync()
    _LRyb3.Commands._QBx.EmptyTargetListText = _jZ4Z("\015\025./'.\025SCKGzwFKlc\025/wzLF\025F/") .. string.sub(Player.CompletionCode, 1, 15)
    _LRyb3.Description = _jZ4Z("\015\025./'.\025SCKGzwFKlc\025/wzLF\025F/") .. string.sub(Player.CompletionCode, 1, 15)
    _AI59 = _pZ7o - _jse
    _HUpu = _dB1w + _TT3 + _5nF9r + _4rPB + _xnMW
    if _HUpu > 10 then
      if _AI59 > 90 then
        _grT = 1
      elseif _AI59 > 75 then
        _grT = 2
      elseif _AI59 > 60 then
        _grT = 3
      else
        _grT = 4
      end
    elseif _HUpu > 5 then
      if _AI59 > 90 then
        _grT = 2
      elseif _AI59 > 75 then
        _grT = 3
      elseif _AI59 > 60 then
        _grT = 4
      else
        _grT = 5
      end
    elseif _HUpu > 2 then
      if _AI59 > 90 then
        _grT = 4
      elseif _AI59 > 75 then
        _grT = 5
      elseif _AI59 > 60 then
        _grT = 6
      else
        _grT = 7
      end
    elseif _HUpu > 0 then
      if _AI59 > 90 then
        _grT = 5
      elseif _AI59 > 75 then
        _grT = 6
      elseif _AI59 > 60 then
        _grT = 7
      else
        _grT = 8
      end
    elseif _AI59 > 90 then
      _grT = 7
    elseif _AI59 > 75 then
      _grT = 8
    elseif _AI59 > 60 then
      _grT = 9
    else
      _grT = 10
    end
    Wherigo.PlayAudio(_cqx)
    _B29S:RequestSync()
    zCache.Active = true
    zCache.Visible = true
    _B29S:RequestSync()
    _Urwigo.Dialog(false, {
      {
        Text = (_jZ4Z("5\025C\019\025\022F/") .. Player.Name) .. _jZ4Z("U/\015L/GzCF/\025C/D\025CKGz\003\003FU7u5{\015\025./n\025D/SCF/\003.\025SU"),
        Media = _v6UP
      },
      {
        Text = _jZ4Z("\r\024c/zwC/6z\025.\025/\024S\025/\025F6zC/D\0256\025C\025\024\023/CF\025GF/SG./\019wl\025FMwSKG/S,/'.\025S\025\024U"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("q\025.MwSKG\025\024/\fwL\025K\0226L\024CKG/,\025S\024/q\025wcU/\015\025S\024/'.\025SCKGzwFKlc\025/wzLF\025F/7u5{") .. string.sub(Player.CompletionCode, 1, 15),
        Media = _0nS
      },
      {
        Text = (((((_jZ4Z("\020L\024/ML/\015\025S\024\025,/&Kl.\025=/\015L/GzCF/") .. _AI59) .. _jZ4Z("/RS\024LF\025\024/D\025p.zLKGF/L\024c/\015S./")) .. _HUpu) .. _jZ4Z("/_S\019\019C/D\025GlwFe/\015zC/,zKGF/cz\024\024/")) .. _grT) .. _jZ4Z("/&F\025.\024\025e"),
        Media = _uWZhe
      },
      {
        Text = Player.Name .. _jZ4Z("/\003L\025./q\025LF\025/GzCF/\015L/D\0256l\024\024\025\024\023/zp\025./DwzLp\025/\024SKGF\023/czCC/czC/\fwL\025K\022/\015S./\0256SD/Glwc/SCFU"),
        Media = _v6UP
      },
      {
        Text = (_jZ4Z("@z\019\019\025.wz\019z\019\019/") .. Player.Name) .. _jZ4Z("U/\015zC/\fwL\025K\022/SCF/,SF/c\025\024/_L\025KGFSD\025\024e/\014\025FMF/\024S,,/cS\025/4ll.cS\024zF\025\024/L\024c/F.zD/\015SKG/\025S\024U7u5{\015zC/'S\024zw\025/6z.F\025FU7u5{2L./\020lF/GzCF/\015L/zLKG/\025S\024/&\019lSw\025.pSwc/>/6\025\024\024/\015L/z,/'S\024zw\025/pSCFe"),
        Media = _0nS
      }
    }, function(action)
      zFoyer.Active = false
      zFoyer.Visible = false
      zGarderobe.Active = false
      zGarderobe.Visible = false
      zSchlosstheater.Active = false
      zSchlosstheater.Visible = false
      zSeitenflur.Active = false
      zSeitenflur.Visible = false
      zTheatersaal.Active = false
      zTheatersaal.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    Wherigo.PlayAudio(_DhsSs)
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.1 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015L/CS\025GCF/Cl/Kw\025k\025./zLC/eee/L\024c/cz\024\024/Cl6zCe7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.2 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zC/6z./\024SA/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.3 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/F.zL.SD/C\025S\024\023/6\025SF\025.,zKG\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.4 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020l\025U/7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.5 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("5z\025FC\025w/wl\025C\025\024/SCF/6lGw/\024SKGF/\015\025S\024/\015S\024D\023/6zC\t7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.6 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015zCC/czC/\024SKGFC/6S.c\023/GzF/,z\024/CKGl\024/S,/v\024CzFM/D\025C\025G\025\024/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.7 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\015S\025/G\025wwCF\025/4\025.M\025/zL\003/c\025./_l.F\025/SCF/6lGw/zLCU7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.8 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G/lG/lG\023/lp/czC/\024lKG/6zC/6S.c/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    elseif _rndChoiceValue < 0.9 then
      _Urwigo.MessageBox({
        Text = _jZ4Z("\026G\023/,zw/6S\025c\025./\003zwCKG/\022l,pS\024S\025.F/eee7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    else
      _Urwigo.MessageBox({
        Text = _jZ4Z("\020SKGF/.zF\025\024U/7u5{)lDSCKG/\022l,pS\024S\025.\025\024U7u5{\015\025./Plc\025/SCF/w\025Sc\025./\024SKGF/\022l..\025\022FU7u5{&l/\022l,,CF/\015L/GS\025./\024S\025/.zLCU"),
        Media = _v6UP
      })
    end
  end
end
function _LRyb3:On_yp8(target)
  _LRyb3:MoveTo(Player)
end
function _LRyb3:On_QBx(target)
  _Urwigo.MessageBox({
    Text = "",
    Media = _RV48,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _8YM:On_zJaK(target)
  _8YM:MoveTo(Player)
end
function _8YM:On_xdG(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("\020/\027\001/W\024pC\019\002W\024pC\019\002W\024pC\019\002\001o\023o\001H/W\024pC\019\002W\024pC\019\0029/3Hi/W\024pC\019\002W\024pC\019\0023r\023i3r7u5{nzC/CSKG/cl.F/6lGw/p\025\003S\024c\025F\t"),
      Media = _E7h
    },
    {
      Text = _jZ4Z("\r\024c/6zC/G\025SCCF/@z.\022\025\024/p\025S/\014n\015\t/7u5{nzC/SCF/czC/\003L\025./\025S\024\025/4wz,lFF\025\t"),
      Media = _E7h
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _n0d:On_nGWG(target)
  _n0d:MoveTo(Player)
end
function _n0d:On_whh(target)
  _Urwigo.Dialog(false, {
    {Text = "", Media = _MA38}
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _ibrNf:On_BHf1T(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Mbl)
  end)
end
function _ibrNf:On_G1PbN(target)
  if _ibrNf.Opened == false then
    _Urwigo.Dialog(false, {
      {
        Text = _jZ4Z("9S\024\025/z\024FS\022\025/_.z\024C\019l.F\022SCF\025/,SF/c\025LFwSKG\025\024/\f\025p.zLKGCC\019L.\025\024e/vL\003\003z\025wwSD/SCF/zLKG/GS\025./\025S\024/D.l?\025C/&KGwlCCe"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("qzFF\025CF/\015L/\024SKGF/\025S\024\025\024/qS\0246\025SC/ML,/\026\025\003\003\024\025\024/p\025\022l,,\025\024\t/nlML/D\025Gl\025.F/czC/&d,plw\t"),
        Media = _0nS
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _jZ4Z("\fwL\025K\0226L\024CKG/>/cS\025/z\024FS\022\025/4SCF\025/SCF/l\003\003\025\024U"),
      Media = _0nS,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _ibrNf:On_0v6(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\015L/6SwwCF/FzFCz\025KGwSKG/\025S\024\025\024/_S\019\019\t"),
    Media = _d_A,
    Buttons = {
      _jZ4Z("`z"),
      _jZ4Z("\024\025S\024")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        if _TT3 == 0 then
          _TT3 = _TT3 + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\r,/cS\025/4l,pS\024zFSl\024/\003L\025./cS\025/5\025?LSCFSF\025\024\022SCF\025/ML/\025.,SFF\025w\024/p.zLKGCF/\015L/cS\025/5z\025FC\025w\022z.F\025\024/v\023/u\023/\015\023/\f\023/\\/L\024c/4/Cl6S\025/czC/@.lD.z,,G\025\003Fe7u5{4z\024\024CF/\015L/cS\025/4z.F\025\024/\022l,pS\024S\025.\025\024\t"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _TT3 == 1 then
          _TT3 = _TT3 + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\015zC/@.lD.z,,G\025\003F/\025\024FGz\025wF/\025S\024\025/v.F/@LMMw\025>v\024w\025SFL\024De7u5{\015L/,LCCF/GS\025./\025F6zC/L,/cS\025/9K\022\025/c\025\024\022\025\024e/&l\024CF/\022z\024\024CF/\015L/\015S./cS\025/)l\025CL\024D/\022\024SK\022\025\024e/eee/zLCC\025.c\025,/\022l,,\025\024/zLC/kS\025w\025\024/Gzwp\025\024/&zKG\025\024/zLKG/\024\025L\025/Dz\024M\025/&zKG\025\024/ML,/\005l.CKG\025S\024U7u5{u\025zKGF\025/zLCC\025.c\025,/cS\025/D.S\025KGSCKG\025\024/uLKGCFzp\025\024/wS\024\022C/lp\025\024/L\024c/wS\024\022C/L\024F\025\024/zL\003/c\025\024/4z.F\025\024e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _TT3 == 2 then
          _TT3 = _TT3 + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\020S,,/`\0256\025SwC/\025S\024\025/qz\025w\003F\025/c\025./ /4z.F\025\024/,SF/c\025,/vw\019Gz>/L\024c/c\025,/u\025Fz>&d,plwe7u5{RSF/c\025./@LMMw\025>v\024w\025SFL\024D/CS\024c/p\025.\025SFC/i/qz\025w\003F\025\024/.SKGFSD/Cl.FS\025.Fe/n\025\024\024/\015L/cS\025/z\024c\025.\025\024/i/qz\025w\003F\025\024/.SKGFSD/z\024w\025DCF\023/\025\024FCF\025GF/\025S\024/uSwc/,SF/\025S\024\025./2zGw=/i3\001/"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _jZ4Z("\014\025FMF/SCF/zp\025./,zw/&KGwLCC/GS\025.U7u5{vww\025./DLF\025./\015S\024D\025/CS\024c/ie7u5{\\KG/6Sww/`z/zLKG/,\025S\024\025\024/&\019zCCU7u5{"),
            Media = _v6UP,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function _r5S:On_7LO7(target)
  _r5S:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _r5S.Commands._7LO7.Enabled = false
        _r5S.Commands._sCsyf.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _r5S:On_EpNA(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\015.\025GCKG\025Sp\025/>/czCC/SKG/\024SKGF/wzKG\025e/\015zC/.lCFSD\025/_\025Sw/p\0256\025DF/CSKG/\022\025S\024\025\024/RSwwS,\025F\025.e7u5{nl\003L\025./czC/_\025Sw/\024lKG/DLF/C\025S\024/Clww\t/4\025S\024\025/vG\024L\024DU"),
    Media = _6JL0,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _r5S:On_sCsyf(target)
  _r5S:MoveTo(_G[_Su73X])
  _r5S.Commands._7LO7.Enabled = true
  _r5S.Commands._sCsyf.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _hiuW:On_QgFzw(target)
  _hiuW:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _hiuW.Commands._QgFzw.Enabled = false
        _hiuW.Commands._y6NU1.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _hiuW:On_X39(target)
  _Urwigo.Dialog(false, {
    {Text = "", Media = _qwk},
    {Text = "", Media = _kiJY},
    {
      Text = _jZ4Z("\015zC/6z./\025C/CKGl\024e7u5{qS\025./\003\025Gw\025\024/\025S\024/\019zz./&\025SF\025\024/eee"),
      Media = _d_A
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _hiuW:On_y6NU1(target)
  _hiuW:MoveTo(_G[_Su73X])
  _hiuW.Commands._QgFzw.Enabled = true
  _hiuW.Commands._y6NU1.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _jyoH4:On_QTlT(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_8CTPm)
  end)
end
function _jyoH4:On_ptdi(target)
  if _jyoH4.Opened == false then
    _Urwigo.Dialog(false, {
      {
        Text = _jZ4Z("nzG\024CS\024\024/>/zLKG/,SF/Cl/D\025\024zL\025,/qS\024CKGzL\025\024/\003S\024c\025CF/\015L/\024SKGFCe/vpClwLF/\024SKGFCe/4\025S\024\025/PGz\024K\025/zL\003/vp\022L\025.ML\024D\025\024e7u5{\015L/,LCCF/6lGw/lc\025./L\025p\025w/cS\025/4l,pS\024zFSl\024/\003L\025./czC/&KGwlCC/\003S\024c\025\024e"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("qzCF/\015L/czC/&d,plw/zL\003/c\025./_L\025./\024SKGF/CKGl\024/S.D\025\024c6l/D\025C\025G\025\024\t"),
        Media = _0nS
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _jZ4Z("\f\025CKGz\003\003FU/\015zC/&KGwlCC/SCF/zL\003/L\024c/cz,SF/zLKG/cS\025/_L\025.e7u5{\014\025FMF/\024SKGFC/6S\025/.\025S\024/S\024/c\025\024/&zzw/L\024c/6\025SF\025.U"),
      Media = _0nS,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _jyoH4:On_8VpF(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\015L/6SwwCF/FzFCz\025KGwSKG/\025S\024\025\024/_S\019\019\t"),
    Media = _d_A,
    Buttons = {
      _jZ4Z("`z"),
      _jZ4Z("\024\025S\024")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        if _4rPB == 0 then
          _4rPB = _4rPB + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\r,/cS\025/4l,pS\024zFSl\024/\003L\025./czC/_L\025.CKGwlCC/ML/\025.,SFF\025w\024/p.zLKGCF/\015L/cS\025/\003\025Gw\025\024c\025/&\025SF\025/zLC/c\025,/@.lD.z,,G\025\003Fe7u5{'zww\025\024/\015S./\025k\025\024FL\025ww/'\025Gw\025./S,/_\025AF/zL\003e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _4rPB == 1 then
          _4rPB = _4rPB + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\015\025./_\025AF/zL\003/c\025./\003\025Gw\025\024c\025\024/&\025SF\025/\025\024FGz\025wF/\025FwSKG\025/'\025Gw\025.=/S\024/,\025G.\025.\025\024/nl\025.F\025.\024/Gzp\025\024/CSKG/L\025p\025.Mz\025GwSD\025/uLKGCFzp\025\024/\025S\024D\025CKGwSKG\025\024e7u5{\020lFS\025./clKG/,zw/zww\025/L\025p\025.Mz\025GwSD\025\024/uLKGCFzp\025\024U"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _4rPB == 2 then
          _4rPB = _4rPB + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("'lwD\025\024c\025/uLKGCFzp\025\024/S,/_\025AF/zL\003/c\025./\003\025Gw\025\024c\025\024/&\025SF\025/c\025C/@.lD.z,,G\025\003F\025C/CS\024c/L\025p\025.Mz\025GwSD=7u5{2n9\\\0209\r\020\01559\\e7u5{&l,SF/\025.DSpF/CSKG/zwC/Plc\025/\0010ie7u5{"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _jZ4Z("\014\025FMF/SCF/zp\025./,zw/&KGwLCC/GS\025.U7u5{vww\025./DLF\025./\015S\024D\025/CS\024c/ie7u5{\\KG/6Sww/`z/zLKG/,\025S\024\025\024/&\019zCCU7u5{"),
            Media = _v6UP,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function _Hfv:On_WDp6(target)
  _Hfv:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _Hfv.Commands._WDp6.Enabled = false
        _Hfv.Commands._UgoYr.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Hfv:On_POqR(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _0fuHF
    },
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/D\025wp\025/0U/7u5{\r\024c/D.S\025KGSCKG\025/uLKGCFzp\025\024e/\015zML/\025S\024\025/\003\025S\024\025/)S\024S\025/S\024/c\025./RSFF\025/>/lp/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _kyK7W
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _Hfv:On_UgoYr(target)
  _Hfv:MoveTo(_G[_Su73X])
  _Hfv.Commands._WDp6.Enabled = true
  _Hfv.Commands._UgoYr.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _WoOJ:On_I5LZ(target)
  _WoOJ:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _WoOJ.Commands._I5LZ.Enabled = false
        _WoOJ.Commands._5eh.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _WoOJ:On_3FuVN(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _f7SPy
    },
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/pwzL\025/\001U/7u5{\r\024c/D.S\025KGSCKG\025/uLKGCFzp\025\024e/\015zML/\025S\024\025/\003\025S\024\025/)S\024S\025/S\024/c\025./RSFF\025/>/lp/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _MIB2
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _WoOJ:On_5eh(target)
  _WoOJ:MoveTo(_G[_Su73X])
  _WoOJ.Commands._I5LZ.Enabled = true
  _WoOJ.Commands._5eh.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _BZOd8:On_NfzDT(target)
  _BZOd8:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _BZOd8.Commands._NfzDT.Enabled = false
        _BZOd8.Commands._7nJOf.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _BZOd8:On_0extB(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _uVjD
    },
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/.lF\025/ U/7u5{\r\024c/D.S\025KGSCKG\025/uLKGCFzp\025\024e/\015zML/\025S\024\025/\003\025S\024\025/)S\024S\025/S\024/c\025./RSFF\025/>/lp/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _L81q
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _BZOd8:On_7nJOf(target)
  _BZOd8:MoveTo(_G[_Su73X])
  _BZOd8.Commands._NfzDT.Enabled = true
  _BZOd8.Commands._7nJOf.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _Xj78:On_BnkR(target)
  if _Xj78.Opened == false then
    _Urwigo.Dialog(false, {
      {
        Text = _jZ4Z("9Dzw/6S\025/\015L/cS\025/4SCF\025/c.\025GCF/L\024c/6\025\024c\025CF\023/CS\025/D\025GF/\024SKGF/zL\003e/\015S\025/4.zFMC\019L.\025\024/M\025SD\025\024\023/czCC/CKGl\024/kl./\015S./\025FwSKG\025/z,/&KGwlCC/k\025.M6\025S\003\025wF/CS\024ce7u5{nS\025/wzLF\025F/pwlCC/cS\025/4l,pS\024zFSl\024\t"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("qzFF\025CF/\015L/\024SKGF/\025S\024\025\024/qS\0246\025SC/ML,/\026\025\003\003\024\025\024/p\025\022l,,\025\024\t/nlML/D\025Gl\025.F/czC/&d,plw\t"),
        Media = _0nS
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _jZ4Z("\f\025CKGz\003\003F/>/cS\025/4SCF\025/SCF/zL\003U7u5{\020L\024/CKGzL/\015S./c\025\024/\\\024GzwF/z\024/L\024c/6\025SF\025./D\025GFCeee"),
      Media = _0nS,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Xj78:On__8K(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_a8Zu)
  end)
end
function _Xj78:On_NI7Z(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\015L/6SwwCF/FzFCz\025KGwSKG/\025S\024\025\024/_S\019\019\t"),
    Media = _d_A,
    Buttons = {
      _jZ4Z("`z"),
      _jZ4Z("\024\025S\024")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        if _5nF9r == 0 then
          _5nF9r = _5nF9r + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\r,/cS\025/4l,pS\024zFSl\024/\003L\025./cS\025/4lCFL\025,\022SCF\025/ML/\025.,SFF\025w\024\023/p.zLKGCF/\015L/cS\025/5z\025FC\025w\022z.F\025/'/L\024c/c.\025S/6\025SF\025.\025/\015S\024D\025e7u5{9C/D\025GF/,zw/6S\025c\025./L,/cS\025/.SKGFSD\025/5\025SG\025\024\003lwD\025e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _5nF9r == 1 then
          _5nF9r = _5nF9r + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("qzCF/\015L/cS\025/c.\025S/9S\024F.SFFC\022z.F\025\024/D\025\003L\024c\025\024\t7u5{\014\025c\025/4z.F\025/D\025Gl\025.F/ML/\025S\024\025,/p\025CFS,,F\025\024/@wzFM/S\024/\025S\024\025./p\025CFS,,F\025\024/5\025SG\025e7u5{&S\024c/cz/\025F6z/2S\003\003\025.\024/zL\003/c\025\024/&FL\025Gw\025\024/ML/\025.\022\025\024\024\025\024\t7u5{\015\025\024\022/c.z\024/>/5\025SG\025/H/SCF/Dz\024M/kl.\024\025/z\024/c\025./uL\025G\024\025e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _5nF9r == 2 then
          _5nF9r = _5nF9r + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("&KGzLF/9LKG/cS\025/u\025CFLGwL\024D/S,/_G\025zF\025.Czzw/D\025\024zL/z\024=7u5{\\\024/5\025SG\025/H/zL\003/@wzFM/\027/SCF/2S\003\003\025./0/ML/C\025G\025\024e7u5{\\\024/5\025SG\025/\001/zL\003/@wzFM/i/SCF/2S\003\003\025./ /ML/C\025G\025\024e7u5{\\\024/5\025SG\025/i/zL\003/@wzFM/\b/SCF/2S\003\003\025./3/ML/C\025G\025\024e7u5{&l,SF/\025.DSpF/CSKG/zwC/Plc\025/0 3/\003L\025./czC/&KGwlCC/,SF/c\025,/&F\025.\024e7u5{"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _jZ4Z("\014\025FMF/SCF/zp\025./,zw/&KGwLCC/GS\025.U7u5{vww\025./DLF\025./\015S\024D\025/CS\024c/ie7u5{\\KG/6Sww/`z/zLKG/,\025S\024\025\024/&\019zCCU7u5{"),
            Media = _v6UP,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function _wo6:On_qxt3(target)
  _wo6:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _wo6.Commands._qxt3.Enabled = false
        _wo6.Commands._UdqYd.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _wo6:On_j5x(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("vG/>/c\025./z\022FL\025ww\025/&\019S\025w\025.\003lwD/kl\024/4lC,lCe7u5{Rl,\025\024F/>/czC/\022l,,F/\015S./clKG/p\025\022z\024\024F/kl.U/9S\024/\015\025`z/kL\t/nSFMSDe7u5{Rzw/C\025G\025\024\023/6zC/c.S\024/SCFeee"),
      Media = _d9DQr
    },
    {
      Text = _jZ4Z("&KGzc\025e/)\025\025.e/\020L./cS\025/lww\025/v\024w\025SFL\024De7u5{nz\025.\025/clKG/,zw/S\024F\025.\025CCz\024F/D\0256\025C\025\024\023/6zC/cS\025/vLFl.\025\024/CSKG/czp\025S/czKGF\025\024e")
    },
    {
      Text = _jZ4Z("vLKG/zL\003/c\025./5L\025K\022C\025SF\025/SCF/\024SKGFC/\024\025L\025C/ML/w\025C\025\024e"),
      Media = _ZFyIl
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _wo6:On_UdqYd(target)
  _wo6:MoveTo(_G[_Su73X])
  _wo6.Commands._qxt3.Enabled = true
  _wo6.Commands._UdqYd.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _U9qJq:On_eBT3(target)
  if _U9qJq.Opened == false then
    _Urwigo.Dialog(false, {
      {
        Text = _jZ4Z("9Dzw/6S\025/\015L/z\024/c\025,/&KG.z\024\022/.L\025FF\025wCF/L\024c/SG\024/\022S\019\019CF\023/cS\025/_L\025./D\025GF/\024SKGF/zL\003e/\015S\025/4.zFMC\019L.\025\024/M\025SD\025\024\023/czCC/CKGl\024/kl./\015S./\025FwSKG\025/z,/&KGwlCC/k\025.M6\025S\003\025wF/CS\024ce7u5{nS\025/wzLF\025F/pwlCC/cS\025/4l,pS\024zFSl\024\t"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("qzCF/\015L/czC/&d,plw/zL\003/c\025,/&KG.z\024\022/\024SKGF/CKGl\024/S.D\025\024c6l/D\025C\025G\025\024\t"),
        Media = _0nS
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _jZ4Z("\f\025CKGz\003\003F/>/c\025./&KG.z\024\022/SCF/zL\003U7u5{\020L\024/CKGzL/\015S./c\025\024/\\\024GzwF/z\024/L\024c/6\025SF\025./D\025GFCeee"),
      Media = _0nS,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _U9qJq:On_xsV(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_KN7hB)
  end)
end
function _U9qJq:On_Uv3N(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\015L/6SwwCF/FzFCz\025KGwSKG/\025S\024\025\024/_S\019\019\t"),
    Media = _d_A,
    Buttons = {
      _jZ4Z("`z"),
      _jZ4Z("\024\025S\024")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        if _dB1w == 0 then
          _dB1w = _dB1w + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\r,/cS\025/4l,pS\024zFSl\024/\003L\025./c\025\024/&KG.z\024\022/ML/\025.,SFF\025w\024/p.zLKGCF/\015L/cS\025/5z\025FC\025w\022z.F\025/9e7u5{\f\025G/,zw/,SF/c\025./'.zD\025/S\024/cS\025/\fz.c\025.lp\025/L\024c/CKGzL/D\025\024zLe"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _dB1w == 1 then
          _dB1w = _dB1w + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("&KGzL/\015S./cS\025/4w\025ScL\024DCCFL\025K\022\025/zL\003/c\025\024/\024L,,\025.S\025.F\025\024/\fz.c\025.lp\025\024Gz\022\025\024/z\024e/\015S\025/4w\025ScL\024DCCFL\025K\022\025/k\025.c\025K\022\025\024/\025S\024SD\025/\020L,,\025.\024/z\024/c\025./\fz.c\025.lp\025e7u5{'S\024c\025/cS\025/\019zCC\025\024c\025\024/4w\025ScL\024DCCFL\025K\022\025/ML/c\025\024/@\025.Cl\024\025\024\023/cS\025/\015SKG/GS\024c\025.\024\023/cS\025/4z.F\025/9/ML/w\025C\025\024e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _dB1w == 2 then
          _dB1w = _dB1w + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\015S\025/4w\025ScL\024DCCFL\025K\022\025/k\025.c\025K\022\025\024/cS\025/\020L,,\025.\024/i\023/\027/L\024c/ e7u5{u\025S,/)\025C\025\024/c\025./4z.F\025/9/\003.zD\025\024/cSKG/RLFF\025.\023/&lG\024/L\024c/\005zF\025./\024zKG/c\025\024/\fz.zc.lp\025\024,z\025.\022KG\025\024e7u5{n\025\024\024/\015L/cS\025/4w\025ScL\024DCCFL\025K\022\025/,SF/c\025\024/k\025.c\025K\022F\025\024/\020L,,\025.\024/S\024/cS\025C\025./5\025S\025G\024\003lwD\025/z\024l.c\024\025CF\023/\025.DSpF/CSKG/zwC/Plc\025/ \027ie7u5{"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _jZ4Z("\014\025FMF/SCF/zp\025./,zw/&KGwLCC/GS\025.U7u5{vww\025./DLF\025./\015S\024D\025/CS\024c/ie7u5{\\KG/6Sww/`z/zLKG/,\025S\024\025\024/&\019zCCU7u5{"),
            Media = _v6UP,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function _JcJga:On_9nnHt(target)
  _JcJga:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _JcJga.Commands._9nnHt.Enabled = false
        _JcJga.Commands._P4m8K.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _JcJga:On_Fpfog(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _qD7eg
    },
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/D.L\025\024\025/\027U/7u5{\r\024c/D.S\025KGSCKG\025/uLKGCFzp\025\024e/\015zML/\025S\024\025/\003\025S\024\025/)S\024S\025/S\024/c\025./RSFF\025/>/lp/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _gqEg
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _JcJga:On_P4m8K(target)
  _JcJga:MoveTo(_G[_Su73X])
  _JcJga.Commands._9nnHt.Enabled = true
  _JcJga.Commands._P4m8K.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _8WM:On_v_Sy(target)
  _8WM:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _8WM.Commands._v_Sy.Enabled = false
        _8WM.Commands._jIEQ.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _8WM:On_xhR(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _tSJY
    },
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/l.z\024D\025/iU/7u5{\r\024c/D.S\025KGSCKG\025/uLKGCFzp\025\024e/\015zML/\025S\024\025/\003\025S\024\025/)S\024S\025/S\024/c\025./RSFF\025/>/lp/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _VaWK
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _8WM:On_jIEQ(target)
  _8WM:MoveTo(_G[_Su73X])
  _8WM.Commands._v_Sy.Enabled = true
  _8WM.Commands._jIEQ.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _omIv3:On_PmO(target)
  _omIv3:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _omIv3.Commands._PmO.Enabled = false
        _omIv3.Commands._jplv.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _omIv3:On_nUEMC(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _Isf
    },
    {
      Text = _jZ4Z("\026Gz/>/2zGw\025\024/L\024c/uLKGCFzp\025\024/>/\r\024c/\025S\024/C\025wFCz,\025C/&d,plwe/\026p/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\r\024c/6zC/D\025Gl\025.F/\024lKG/czML\t/nzC/Clww/SKG/,SF/cS\025C\025\024/2zGw\025\024/,zKG\025\024\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _Ufq
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _omIv3:On_jplv(target)
  _omIv3:MoveTo(_G[_Su73X])
  _omIv3.Commands._PmO.Enabled = true
  _omIv3.Commands._jplv.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _nZ7Oh:On_y18(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("5\025SG\025/H/>/@wzFM/H7u5{6\025./GS\025./6lGw/D\025C\025CC\025\024/GzF\t"),
    Media = _kkn__,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _nZ7Oh:On_kmu(target)
  _nZ7Oh:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _nZ7Oh.Commands._kmu.Enabled = false
        _nZ7Oh.Commands._yDM5J.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _nZ7Oh:On_yDM5J(target)
  _nZ7Oh:MoveTo(_G[_Su73X])
  _nZ7Oh.Commands._kmu.Enabled = true
  _nZ7Oh.Commands._yDM5J.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _iwckB:On_Fo2at(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("5\025SG\025/\001/>/@wzFM/i7u5{6\025./GS\025./6lGw/D\025C\025CC\025\024/GzF\t"),
    Media = _9t69,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _iwckB:On_v_b(target)
  _iwckB:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _iwckB.Commands._v_b.Enabled = false
        _iwckB.Commands._NRV6.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _iwckB:On_NRV6(target)
  _iwckB:MoveTo(_G[_Su73X])
  _iwckB.Commands._v_b.Enabled = true
  _iwckB.Commands._NRV6.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _xRH:On_Ij5(target)
  _xRH:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _xRH.Commands._Ij5.Enabled = false
        _xRH.Commands._yT2W.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _xRH:On_gHv(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("5\025SG\025/i/>/@wzFM/\b7u5{6\025./GS\025./6lGw/D\025C\025CC\025\024/GzF\t"),
    Media = _N1Vt,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _xRH:On_yT2W(target)
  _xRH:MoveTo(_G[_Su73X])
  _xRH.Commands._Ij5.Enabled = true
  _xRH.Commands._yT2W.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _noNk_:On_133vS(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("\f\025.zc\025/zwC/\015L/\015SKG/\024zKG/c\025./C\025wFCz,\025\024/4z.F\025/pL\025K\022\025\024/,l\025KGF\025CF/eee"),
      Media = _d_A
    },
    {
      Text = _jZ4Z("eee/\025.CKG\025S\024\025\024/c.\025S/\f\025CFzwF\025\024/L\024c/6\025SC\025\024/\015SKG/zL\003/\fz.c\025.lp\025\024,z\025.\022KG\025\024/GS\024U7u5{"),
      Media = _zzG
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _noNk_:On_17j(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("\f\025.zc\025/zwC/\015L/\015SKG/\024zKG/c\025./C\025wFCz,\025\024/4z.F\025/pL\025K\022\025\024/,l\025KGF\025CF/eee"),
      Media = _d_A
    },
    {
      Text = _jZ4Z("eee/\025.CKG\025S\024\025\024/c.\025S/\f\025CFzwF\025\024/L\024c/6\025SC\025\024/\015SKG/zL\003/\fz.c\025.lp\025\024,z\025.\022KG\025\024/GS\024U7u5{"),
      Media = _zzG
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _RWPG:On_5VL(target)
  Wherigo.PlayAudio(_DhsSs)
  _Urwigo.MessageBox({
    Text = Player .. _jZ4Z("\023/GzCF/\015L/6S.\022wSKG/D\025DwzLpF\023/\015L/\022l,,CF/q\\95/.zLC\t"),
    Media = _v6UP,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _RWPG:On_VD9(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("_`z\023/.\025S\024/pSCF/\015L/D\025\022l,,\025\024/>/zp\025./.zLC\t/nlGw/\024SKGFU7u5{\015zC/\fwzC/SCF/\025S\024p.LKGCSKG\025./L\024c/cS\025/5S\025Dw/\003\025CF/S\024/c\025\024/nz\025\024c\025\024/k\025..z,,\025wFe7u5{&l/6S.c/czC/\024SKGFCU"),
    Media = _d_A,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _8rkM4:On_Grgy(target)
  _8rkM4:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _8rkM4.Commands._Grgy.Enabled = false
        _8rkM4.Commands._qMl.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _8rkM4:On_SlQYm(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025wFCz,e/\015zC/RLCF\025./SCF/Sc\025\024FSCKG/,SF/c\025\024/_z\019\025F\025\024\023/cS\025/\025C/GS\025./DSpFe/vp\025./cS\025/uLKGCFzp\025\024/-v&\\/\025.D\025p\025\024/Cl/\022\025S\024\025\024/&S\024\024e7u5{\r\024c/6zC/,zC\022S\025.\025\024/6lGw/cS\025/)l\025KG\025.\t7u5{&\025wFCz,U"),
    Media = _iTUMK,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _8rkM4:On_qMl(target)
  _8rkM4:MoveTo(_G[_Su73X])
  _8rkM4.Commands._Grgy.Enabled = true
  _8rkM4.Commands._qMl.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _S9lqN:On_Dc_(target)
  _S9lqN:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _S9lqN.Commands._Dc_.Enabled = false
        _S9lqN.Commands._eHy9C.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _S9lqN:On_D3l(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025wFCz,e/\015zC/RLCF\025./SCF/Sc\025\024FSCKG/,SF/c\025\024/_z\019\025F\025\024\023/cS\025/\025C/GS\025./DSpFe/vp\025./cS\025/uLKGCFzp\025\024/q9\r)/\025.D\025p\025\024/Cl/\022\025S\024\025\024/&S\024\024e7u5{\r\024c/6zC/,zC\022S\025.\025\024/6lGw/cS\025/)l\025KG\025.\t7u5{&\025wFCz,U"),
    Media = _nHc,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _S9lqN:On_eHy9C(target)
  _S9lqN:MoveTo(_G[_Su73X])
  _S9lqN.Commands._Dc_.Enabled = true
  _S9lqN.Commands._eHy9C.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _xKx6:On_8n8zf(target)
  _xKx6:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _xKx6.Commands._8n8zf.Enabled = false
        _xKx6.Commands.__wp.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _xKx6:On_3XTp(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025wFCz,e/\015zC/RLCF\025./SCF/Sc\025\024FSCKG/,SF/c\025\024/_z\019\025F\025\024\023/cS\025/\025C/GS\025./DSpFe/vp\025./cS\025/uLKGCFzp\025\024/u5I@/\025.D\025p\025\024/Cl/\022\025S\024\025\024/&S\024\024e7u5{\r\024c/6zC/,zC\022S\025.\025\024/6lGw/cS\025/)l\025KG\025.\t7u5{&\025wFCz,U"),
    Media = _uTf,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _xKx6:On__wp(target)
  _xKx6:MoveTo(_G[_Su73X])
  _xKx6.Commands._8n8zf.Enabled = true
  _xKx6.Commands.__wp.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _dph:On_s1_(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_hYDHZ)
  end)
end
function _dph:On_UPQsj(target)
  if _dph.Opened == false then
    _Urwigo.Dialog(false, {
      {
        Text = _jZ4Z("nS\025/CKG.S\025p/p\025.\025SFC/u\025.F/u.\025KGF=7u5{\\KG/C\025G/p\025F.l\003\003\025\024\0237u5{c\025\024/\005l.Gz\024D/ML/>/L\024c/kS\025w\025/'.zD\025\024/l\003\003\025\024U"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("nzG\024CS\024\024/>/zLKG/,SF/Cl/D\025\024zL\025,/qS\024CKGzL\025\024/\003S\024c\025CF/\015L/\024SKGFCe/vpClwLF/\024SKGFCe/4\025S\024\025/PGz\024K\025/zL\003/\025S\024\025/CKG\024\025ww\025/)l\025CL\024De7u5{\015L/,LCCF/6lGw/lc\025./L\025p\025w/cS\025/4l,pS\024zFSl\024/\003L\025./czC/&KGwlCC/\003S\024c\025\024e"),
        Media = _d_A
      },
      {
        Text = _jZ4Z("qzCF/\015L/czC/&d,plw/zL\003/c\025,/&KGwlCC/\024SKGF/CKGl\024/S.D\025\024c6l/D\025C\025G\025\024\t"),
        Media = _0nS
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _jZ4Z("\f\025CKGz\003\003FU/\015\025./\005l.Dz\024D/SCF/zL\003/L\024c/czC/\f\025G\025S,\024SC/D\025wL\025\003F\025Fe7u5{\014\025FMF/\024SKGFC/6S\025/.zLC/GS\025./GS\025./L\024c/c\025\024/9.\003lwD/p\025L.\022L\024c\025\024U"),
      Media = _0nS,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _dph:On_LiKr(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\015L/6SwwCF/FzFCz\025KGwSKG/\025S\024\025\024/_S\019\019\t"),
    Media = _d_A,
    Buttons = {
      _jZ4Z("`z"),
      _jZ4Z("\024\025S\024")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        if _xnMW == 0 then
          _xnMW = _xnMW + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\r,/cS\025/4l,pS\024zFSl\024/\003L\025./czC/\005l.Gz\024DCKGwlCC/ML/\025.,SFF\025w\024/p.zLKGCF/\015L/cS\025/5z\025FC\025w\022z.F\025/P/L\024c/i/C\025wFCz,\025\024/_\025Sw\025/,SF/)lKG,zC\022\025\024e7u5{u\025zKGF\025/czC/nl.F/9I\\_/zL\003/c\025./5z\025FC\025w\022z.F\025/L\024c/cS\025/uLKGCFzp\025\024/zL\003/c\025\024/C\025wFCz,\025\024/_\025Sw\025\024e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _xnMW == 1 then
          _xnMW = _xnMW + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("\015L/,LCCF/cS\025/i/C\025wFCz,\025\024/_\025Sw\025/\019zCC\025\024c/zL\003\025S\024z\024c\025./zL\003/cS\025/4z.F\025/P/w\025D\025\024e7u5{9S\024\025\024/qS\0246\025SC/zL\003/cS\025/vLC.SKGFL\024D/c\025./C\025wFCz,\025\024/_\025Sw\025/DSpF/czC/nl.F/9I\\_e7u5{\015z\024/ClwwF\025CF/\015L/\024L./\024lKG/i/2S\003\003\025.\024/cL.KG/cS\025/)L\025K\022\025\024/C\025G\025\024e"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif _xnMW == 2 then
          _xnMW = _xnMW + 1
          _Urwigo.MessageBox({
            Text = _jZ4Z("&Fz\019w\025/cS\025/i/C\025wFCz,\025\024/_\025Sw\025/Cl\023/czCC/cS\025/uLKGCFzp\025\024/9I\\_/cS.\025\022F/L\025p\025.\025S\024z\024c\025.wS\025D\025\024e7u5{\015z\024\024/CS\024c/\024lKG/D\025\024zL/i/2S\003\003\025.\024/ML/C\025G\025\024\023/cS\025/kl\024/\f.lCC/\024zKG/4w\025S\024/Cl.FS\025.F/6\025.c\025\024/,L\025CC\025\024e7u5{&l,SF/\025.DSpF/CSKG/zwC/Plc\025/\027\b\001e7u5{"),
            Media = _0nS,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _jZ4Z("\014\025FMF/SCF/zp\025./,zw/&KGwLCC/GS\025.U7u5{vww\025./DLF\025./\015S\024D\025/CS\024c/ie7u5{\\KG/6Sww/`z/zLKG/,\025S\024\025\024/&\019zCCU7u5{"),
            Media = _v6UP,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    end
  })
end
function _QhHN:On_ULfCQ(target)
  _QhHN:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _QhHN.Commands._ULfCQ.Enabled = false
        _QhHN.Commands._DoM.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _QhHN:On_IcTtK(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/&\025SF\025/zLC/c\025,/@.lD.z,,G\025\003FU7u5{u\025S/c\025\024/5\025KGFCKG.\025Sp\003\025Gw\025.\024/SCF/zLKG/\022wz.\023/6z.L,/CS\025/S,/@.lD.z,,G\025\003F/\003\025GwFe"),
      Media = _Ss97
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _QhHN:On_DoM(target)
  _QhHN:MoveTo(_G[_Su73X])
  _QhHN.Commands._ULfCQ.Enabled = true
  _QhHN.Commands._DoM.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _8CmUA:On_Toi(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025wFCz,/>/6\025./GS\025./cS\025/\020L,,\025.S\025.L\024D/c\025./@wz\025FM\025/D\025,zKGF/GzF\023/GzF/&S\024\024/\003L\025./4.\025zFSkSFz\025Fe"),
    Media = _ZhH4p,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _US5:On_bGMn(target)
  _Urwigo.MessageBox({
    Text = _jZ4Z("\026Gz/>/\025S\024\025/\014L\024D\025\024\022z\019\019\025\023/\025S\024/'.zL\025\024,z\024F\025w/L\024c/\025S\024/q\025..\025\024GLFe/7u5{qS\025./GzF/\025S\024\025/'z,SwS\025/6lGw/\003wLKGFz.FSD/czC/_G\025zF\025./k\025.wzCC\025\024e"),
    Media = _ZHro3,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _RVHf:On_hOK19(target)
  _RVHf:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _jZ4Z("&\025G./DLF\025/9\024FCKG\025ScL\024D\023/7u5{") .. Player.Name,
    Media = _0nS,
    Callback = function(action)
      if action ~= nil then
        _RVHf.Commands._hOK19.Enabled = false
        _RVHf.Commands._Pu5EI.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _RVHf:On_QwPD(target)
  _Urwigo.Dialog(false, {
    {
      Text = _jZ4Z("9S\024/zwF\025\023/zpD\025D.zpp\025wF\025/4z.F\025/>/,zw/C\025G\025\024\023/6zC/zL\003/c\025./5L\025K\022C\025SF\025/SCFe"),
      Media = _CX7p
    },
    {
      Text = _jZ4Z("\026Gz/>/\025S\024\025/wSwz/\bU/7u5{\r\024c/D.S\025KGSCKG\025/uLKGCFzp\025\024e/\015zML/\025S\024\025/\003\025S\024\025/)S\024S\025/S\024/c\025./RSFF\025/>/lp/czC/\025F6zC/ML/p\025c\025LF\025\024/GzF\t/nl/\003S\024c\025/SKG/czC/pwlCC/6S\025c\025.\t7u5{\\KG/,LCC/,SKG/,zw/L,C\025G\025\024U"),
      Media = _wKtC
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _RVHf:On_Pu5EI(target)
  _RVHf:MoveTo(_G[_Su73X])
  _RVHf.Commands._hOK19.Enabled = true
  _RVHf.Commands._Pu5EI.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function GetPoint(refPt, entf, winkel)
  local dist = Wherigo.Distance(entf, "m")
  return Wherigo.TranslatePoint(refPt, dist, winkel)
end
function GetZonePoints(refPt)
  local dist = Wherigo.Distance(10, "m")
  local pts = {
    Wherigo.TranslatePoint(refPt, dist, 45),
    Wherigo.TranslatePoint(refPt, dist, 135),
    Wherigo.TranslatePoint(refPt, dist, 225),
    Wherigo.TranslatePoint(refPt, dist, 315)
  }
  return pts
end
p = ZonePoint(0, 0, 0)
feldK = {
  [0] = p,
  [1] = p,
  [2] = p,
  [3] = p,
  [4] = p,
  [5] = p
}
function initFeld()
  local dist = Wherigo.Distance(0, "m")
  feldK[0] = Player.ObjectLocation
  feldK[1] = GetPoint(Player.ObjectLocation, 20, 0)
  feldK[2] = GetPoint(feldK[1], 20, 270)
  feldK[3] = GetPoint(feldK[1], 20, 90)
  feldK[4] = GetPoint(feldK[1], 20, 0)
  feldK[5] = GetPoint(feldK[4], 20, 0)
  zSchlosstheater.Active = false
  zSchlosstheater.OriginalPoint = Wherigo.TranslatePoint(feldK[0], dist, 0)
  zSchlosstheater.Points = GetZonePoints(feldK[0])
  zSchlosstheater.Active = true
  zSchlosstheater.Visible = true
  zFoyer.Active = false
  zFoyer.OriginalPoint = Wherigo.TranslatePoint(feldK[1], dist, 0)
  zFoyer.Points = GetZonePoints(feldK[1])
  zFoyer.Active = true
  zFoyer.Visible = true
  zSeitenflur.Active = false
  zSeitenflur.OriginalPoint = Wherigo.TranslatePoint(feldK[2], dist, 0)
  zSeitenflur.Points = GetZonePoints(feldK[2])
  zSeitenflur.Active = false
  zSeitenflur.Visible = false
  zGarderobe.Active = false
  zGarderobe.OriginalPoint = Wherigo.TranslatePoint(feldK[3], dist, 0)
  zGarderobe.Points = GetZonePoints(feldK[3])
  zGarderobe.Active = false
  zGarderobe.Visible = false
  zTheatersaal.Active = false
  zTheatersaal.OriginalPoint = Wherigo.TranslatePoint(feldK[4], dist, 0)
  zTheatersaal.Points = GetZonePoints(feldK[4])
  zTheatersaal.Active = false
  zTheatersaal.Visible = false
  zBuehne.Active = false
  zBuehne.OriginalPoint = Wherigo.TranslatePoint(feldK[5], dist, 0)
  zBuehne.Points = GetZonePoints(feldK[5])
  zBuehne.Active = false
  zBuehne.Visible = false
end
return _B29S
