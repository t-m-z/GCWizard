require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _Tho(str)
  local res = ""
  local dtable = "\020x&\027@\005Z1SXr.6/J+!;b= c\022p\t,h:7\004wyuB%Rm_-G\015\\[F\021\0143\0068(~QAH#P\n\018\002?\f\r\028^M\026az<$95v4O]\031dnL\vN\000tKs)|\"i'C\023le\019\001>YVk\016o\017{T\030Df}\024g\0030W\025\029\a`*j2\bqUIE"
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
_vKBT1 = Wherigo.ZCartridge()
_PxpE = Wherigo.ZMedia(_vKBT1)
_PxpE.Id = "2786a820-8548-4532-a9c6-cb9425e4428e"
_PxpE.Name = _Tho("eT\027_sC^eZOpl_CN")
_PxpE.Description = ""
_PxpE.AltText = ""
_PxpE.Resources = {
  {
    Type = "jpg",
    Filename = "kTheWalkingDead.jpg",
    Directives = {}
  }
}
_wn0xl = Wherigo.ZMedia(_vKBT1)
_wn0xl.Id = "aec01a06-7bc2-4b2b-ae87-f6e48ee3d16e"
_wn0xl.Name = _Tho("e\be\vCOe_O\019_TT")
_wn0xl.Description = ""
_wn0xl.AltText = ""
_wn0xl.Resources = {
  {
    Type = "jpg",
    Filename = "k1bett.jpg",
    Directives = {}
  }
}
_h9nv = Wherigo.ZMedia(_vKBT1)
_h9nv.Id = "691e2d2f-17c0-4f0b-8608-971b2fb08d07"
_h9nv.Name = _Tho("e\be\vCOe_O\019_TT\tT_\027_ON")
_h9nv.Description = ""
_h9nv.AltText = ""
_h9nv.Resources = {
  {
    Type = "jpg",
    Filename = "k1Aufstehen.jpg",
    Directives = {}
  }
}
_I_O = Wherigo.ZMedia(_vKBT1)
_I_O.Id = "7912fc78-df0b-4afe-9df9-40c99ecb93a6"
_I_O.Name = _Tho("e\b\v!mT\t\022\027\031_VT_\v")
_I_O.Description = ""
_I_O.AltText = ""
_I_O.Resources = {
  {
    Type = "jpg",
    Filename = "k1schwester.jpg",
    Directives = {}
  }
}
_5aE = Wherigo.ZMedia(_vKBT1)
_5aE.Id = "c8597efc-2000-491d-9ce2-e25d1e3a3806"
_5aE.Name = _Tho("e\bm^!\022\027TU\vCOe_O\027C!V")
_5aE.Description = ""
_5aE.AltText = ""
_5aE.Resources = {
  {
    Type = "jpg",
    Filename = "k1Krankenhaus.jpg",
    Directives = {}
  }
}
_svK = Wherigo.ZMedia(_vKBT1)
_svK.Id = "9c7736ce-4c5d-4bcf-a392-cd74a969db7e"
_svK.Name = _Tho("\tg!ON\127U(")
_svK.Description = _Tho("\tg!ON")
_svK.AltText = ""
_svK.Resources = {
  {
    Type = "mp3",
    Filename = "eCG.mp3",
    Directives = {}
  }
}
_L5U = Wherigo.ZMedia(_vKBT1)
_L5U.Id = "6033190e-9936-4196-869d-9a2306cad0a8"
_L5U.Name = _Tho("eN!Oe_^\027_ZT")
_L5U.Description = ""
_L5U.AltText = ""
_L5U.Resources = {
  {
    Type = "jpg",
    Filename = "k1dunkelheit.jpg",
    Directives = {}
  }
}
_IrJu0 = Wherigo.ZMedia(_vKBT1)
_IrJu0.Id = "e0448166-a5f2-4f27-a43f-d174e96eed4d"
_IrJu0.Name = _Tho("\tg!ON6g\vN_'$!V\027")
_IrJu0.Description = _Tho("\tg!ON")
_IrJu0.AltText = ""
_IrJu0.Resources = {
  {
    Type = "mp3",
    Filename = "infected-rush.mp3",
    Directives = {}
  }
}
_yI_L = Wherigo.ZMedia(_vKBT1)
_yI_L.Id = "d1af795f-2b0a-468b-a462-ad7d435cffd9"
_yI_L.Name = _Tho("e\bVTg^\024_\vO")
_yI_L.Description = ""
_yI_L.AltText = ""
_yI_L.Resources = {
  {
    Type = "jpg",
    Filename = "k1Fall.jpg",
    Directives = {}
  }
}
_tNMj = Wherigo.ZMedia(_vKBT1)
_tNMj.Id = "4a94b8fa-706b-44cb-b344-961c0fb130af"
_tNMj.Name = _Tho("e\bV\022\027Z_VV_\v_Z")
_tNMj.Description = ""
_tNMj.AltText = ""
_tNMj.Resources = {
  {
    Type = "jpg",
    Filename = "k1schusswunde.jpg",
    Directives = {}
  }
}
_Eqb = Wherigo.ZMedia(_vKBT1)
_Eqb.Id = "67e2291b-884c-45d2-bfe0-88f5483afe79"
_Eqb.Name = _Tho("e\b\t\022\027C!m_^")
_Eqb.Description = ""
_Eqb.AltText = ""
_Eqb.Resources = {
  {
    Type = "JPG",
    Filename = "k1schaufel.JPG",
    Directives = {}
  }
}
_eOEP = Wherigo.ZMedia(_vKBT1)
_eOEP.Id = "03c4699e-b2e9-43cf-ae3f-cc69858a98d7"
_eOEP.Name = _Tho("\tg!ON\"\v_\022\027_ON_\vUOg\022\027_O")
_eOEP.Description = _Tho("\tg!ON")
_eOEP.AltText = ""
_eOEP.Resources = {
  {
    Type = "mp3",
    Filename = "boneCrushing.mp3",
    Directives = {}
  }
}
_alyWm = Wherigo.ZMedia(_vKBT1)
_alyWm.Id = "dc007bcf-1498-41e4-9a35-0502e44d9bbe"
_alyWm.Name = _Tho("e\b\019ggT")
_alyWm.Description = ""
_alyWm.AltText = ""
_alyWm.Resources = {
  {
    Type = "JPG",
    Filename = "k1boot.JPG",
    Directives = {}
  }
}
_ECQJ = Wherigo.ZMedia(_vKBT1)
_ECQJ.Id = "593c6caa-6744-45ed-b549-9c4fdb058d1f"
_ECQJ.Name = _Tho("e\bU\vCOe_O\027C!V\ag%\019Z_V")
_ECQJ.Description = ""
_ECQJ.AltText = ""
_ECQJ.Resources = {
  {
    Type = "jpg",
    Filename = "k1Zombies.jpg",
    Directives = {}
  }
}
_Pbf_L = Wherigo.ZMedia(_vKBT1)
_Pbf_L.Id = "d267dec2-c940-4e11-a620-f739a2d16e01"
_Pbf_L.Name = _Tho("e\b\t\022\027C!m_^\t\022\027^Cp(_OZ\022e")
_Pbf_L.Description = ""
_Pbf_L.AltText = ""
_Pbf_L.Resources = {
  {
    Type = "jpg",
    Filename = "k1schaufelSchlagGenick.jpg",
    Directives = {}
  }
}
_msF = Wherigo.ZMedia(_vKBT1)
_msF.Id = "6c999172-654c-457a-a7c9-ada0423efae2"
_msF.Name = _Tho("Vg!ONjCOe(\vg\031^")
_msF.Description = _Tho("Vg!ON")
_msF.AltText = ""
_msF.Resources = {
  {
    Type = "mp3",
    Filename = "tank-growl.mp3",
    Directives = {}
  }
}
_LQl = Wherigo.ZMedia(_vKBT1)
_LQl.Id = "0862d3b4-f7d6-43ed-a44d-3ca2d72bba33"
_LQl.Name = _Tho("er\024\vg^gp")
_LQl.Description = ""
_LQl.AltText = ""
_LQl.Resources = {
  {
    Type = "jpg",
    Filename = "k0schrift.jpg",
    Directives = {}
  }
}
_Hu3r = Wherigo.ZMedia(_vKBT1)
_Hu3r.Id = "49ff95e6-f7e8-45a3-932e-46d3bf2cfd7a"
_Hu3r.Name = _Tho("e\bp!T_5^T_\a_ZT")
_Hu3r.Description = ""
_Hu3r.AltText = ""
_Hu3r.Resources = {
  {
    Type = "jpg",
    Filename = "k1schrift.jpg",
    Directives = {}
  }
}
_5Y6B9 = Wherigo.ZMedia(_vKBT1)
_5Y6B9.Id = "23ef99e0-37ea-43e3-80c0-a96b8dab2e33"
_5Y6B9.Name = _Tho("eDg%\019Z_")
_5Y6B9.Description = ""
_5Y6B9.AltText = ""
_5Y6B9.Resources = {
  {
    Type = "jpg",
    Filename = "kZombie.jpg",
    Directives = {}
  }
}
__XYn = Wherigo.ZMedia(_vKBT1)
__XYn.Id = "299e543c-736a-4766-946f-a94f729b55b4"
__XYn.Name = _Tho("e\027g\vN_")
__XYn.Description = ""
__XYn.AltText = ""
__XYn.Resources = {
  {
    Type = "jpg",
    Filename = "kHorde.jpg",
    Directives = {}
  }
}
_38c = Wherigo.ZMedia(_vKBT1)
_38c.Id = "e0341fae-e520-4865-ac63-80b9e43861de"
_38c.Name = _Tho("e\t\024Z_^_\v")
_38c.Description = ""
_38c.AltText = ""
_38c.Resources = {
  {
    Type = "jpg",
    Filename = "kSpieler.jpg",
    Directives = {}
  }
}
_wDkb = Wherigo.ZMedia(_vKBT1)
_wDkb.Id = "952bf30e-3ea2-4379-b800-10858c7f2da8"
_wDkb.Name = _Tho("e\b\019ggT8Z\022T")
_wDkb.Description = ""
_wDkb.AltText = ""
_wDkb.Resources = {
  {
    Type = "JPG",
    Filename = "k1bootPict.JPG",
    Directives = {}
  }
}
_0CljT = Wherigo.ZMedia(_vKBT1)
_0CljT.Id = "9ca3b91d-c2eb-42a9-b414-137a474598e3"
_0CljT.Name = _Tho("e\027g\vN_8Z\022T")
_0CljT.Description = ""
_0CljT.AltText = ""
_0CljT.Resources = {
  {
    Type = "jpg",
    Filename = "kHordePict.jpg",
    Directives = {}
  }
}
_FnmP = Wherigo.ZMedia(_vKBT1)
_FnmP.Id = "9aaee415-f96e-4f24-af5a-a0adcd05a173"
_FnmP.Name = _Tho("eDg%\019Z_8Z\022T")
_FnmP.Description = ""
_FnmP.AltText = ""
_FnmP.Resources = {
  {
    Type = "jpg",
    Filename = "kZombiePict.jpg",
    Directives = {}
  }
}
_MkZ = Wherigo.ZMedia(_vKBT1)
_MkZ.Id = "68baabb8-07fd-43ce-b86b-e2d140ef6551"
_MkZ.Name = _Tho("ez_\v\031C\022\027_O")
_MkZ.Description = ""
_MkZ.AltText = ""
_MkZ.Resources = {
  {
    Type = "jpg",
    Filename = "k2schrift.jpg",
    Directives = {}
  }
}
_4VKhN = Wherigo.ZMedia(_vKBT1)
_4VKhN.Id = "4356f2b0-3dd6-4961-bef8-697ab4088464"
_4VKhN.Name = _Tho("e/V\022\027\vZmT")
_4VKhN.Description = ""
_4VKhN.AltText = ""
_4VKhN.Resources = {
  {
    Type = "jpg",
    Filename = "k3schrift.jpg",
    Directives = {}
  }
}
_tyfD = Wherigo.ZMedia(_vKBT1)
_tyfD.Id = "7672150d-95c1-4ed7-936e-b3572ecfba2c"
_tyfD.Name = _Tho("eJV\022\027\vZmT")
_tyfD.Description = ""
_tyfD.AltText = ""
_tyfD.Resources = {
  {
    Type = "jpg",
    Filename = "k4schrift.jpg",
    Directives = {}
  }
}
_PNS = Wherigo.ZMedia(_vKBT1)
_PNS.Id = "a816f611-872a-48d8-b9b0-e4719ac00da2"
_PNS.Name = _Tho("e6C\024\024 \127ON")
_PNS.Description = ""
_PNS.AltText = ""
_PNS.Resources = {
  {
    Type = "jpg",
    Filename = "kEndeHappyEnd.jpg",
    Directives = {}
  }
}
_ej1 = Wherigo.ZMedia(_vKBT1)
_ej1.Id = "c3879f65-7996-4a1e-b333-b16ae3aaa92c"
_ej1.Name = _Tho("e\127ON_jKj")
_ej1.Description = ""
_ej1.AltText = ""
_ej1.Resources = {
  {
    Type = "jpg",
    Filename = "kEndeTot.jpg",
    Directives = {}
  }
}
_4BMV = Wherigo.ZMedia(_vKBT1)
_4BMV.Id = "5e24cb75-2f65-41ce-a3d3-9906dab77231"
_4BMV.Name = _Tho("Vg!ON\027_^^g")
_4BMV.Description = _Tho("Vg!ON")
_4BMV.AltText = ""
_4BMV.Resources = {
  {
    Type = "mp3",
    Filename = "k1hello.mp3",
    Directives = {}
  }
}
_J3XLi = Wherigo.ZMedia(_vKBT1)
_J3XLi.Id = "7360635a-ae38-45a9-8ed3-3ce5bcaf80ed"
_J3XLi.Name = _Tho("Vg!ONA_OVC")
_J3XLi.Description = _Tho("Vg!ON")
_J3XLi.AltText = ""
_J3XLi.Resources = {
  {
    Type = "mp3",
    Filename = "k1mensa.mp3",
    Directives = {}
  }
}
_ARh = Wherigo.ZMedia(_vKBT1)
_ARh.Id = "85ab4ab9-e812-462d-b9cb-18529d1a213b"
_ARh.Name = _Tho("ezAC\v^_ ")
_ARh.Description = ""
_ARh.AltText = ""
_ARh.Resources = {
  {
    Type = "jpg",
    Filename = "k2Marley.jpg",
    Directives = {}
  }
}
_LM4d = Wherigo.ZMedia(_vKBT1)
_LM4d.Id = "54cf7417-6bd6-4130-b6cb-b69acdfaf30a"
_LM4d.Name = _Tho("ej\027_sC^eZOpl_CN8Z\022T")
_LM4d.Description = ""
_LM4d.AltText = ""
_LM4d.Resources = {
  {
    Type = "jpg",
    Filename = "ktheWalkingDeadPict.jpg",
    Directives = {}
  }
}
_pPdg = Wherigo.ZMedia(_vKBT1)
_pPdg.Id = "a2147c82-287f-4ff3-9903-634765b1048a"
_pPdg.Name = _Tho("ez8g^ZD_Z\031C\022\027_")
_pPdg.Description = ""
_pPdg.AltText = ""
_pPdg.Resources = {
  {
    Type = "jpg",
    Filename = "k2Polizeiwache.jpg",
    Directives = {}
  }
}
_zV3F9 = Wherigo.ZMedia(_vKBT1)
_zV3F9.Id = "42e30c5e-04d8-4400-bebd-e6098d70ed45"
_zV3F9.Name = _Tho("ezsCmm_OeC%%_\v")
_zV3F9.Description = ""
_zV3F9.AltText = ""
_zV3F9.Resources = {
  {
    Type = "JPG",
    Filename = "k2Waffenkammer.JPG",
    Directives = {}
  }
}
_5WU8 = Wherigo.ZMedia(_vKBT1)
_5WU8.Id = "80776789-fbfe-4876-ab63-552ec4448773"
_5WU8.Name = _Tho("Vg!ON\t\027gTp!O")
_5WU8.Description = _Tho("Vg!ON")
_5WU8.AltText = ""
_5WU8.Resources = {
  {
    Type = "mp3",
    Filename = "shotgun-fire.mp3",
    Directives = {}
  }
}
_q_3 = Wherigo.ZMedia(_vKBT1)
_q_3.Id = "ef8e34ec-23b9-4a46-b36e-43e006a400ff"
_q_3.Name = _Tho("Vg!ON\t\027gTp!O8!%\024")
_q_3.Description = _Tho("Vg!ON")
_q_3.AltText = ""
_q_3.Resources = {
  {
    Type = "mp3",
    Filename = "shotgun-reload-old_school.mp3",
    Directives = {}
  }
}
_WZTq = Wherigo.ZMedia(_vKBT1)
_WZTq.Id = "82f5eaa0-99bd-4f99-a4bc-51bf3dda552a"
_WZTq.Name = _Tho("UJUgOTCeT%COO")
_WZTq.Description = ""
_WZTq.AltText = ""
_WZTq.Resources = {
  {
    Type = "JPG",
    Filename = "k4Kontaktmann.JPG",
    Directives = {}
  }
}
_dMHqh = Wherigo.ZMedia(_vKBT1)
_dMHqh.Id = "3fed36fd-49de-4487-be74-6c487249a564"
_dMHqh.Name = _Tho(",\v_ZV\022\027C^T\022gN_")
_dMHqh.Description = ""
_dMHqh.AltText = ""
_dMHqh.Resources = {
  {
    Type = "jpg",
    Filename = "kcode.jpg",
    Directives = {}
  }
}
_lgCl = Wherigo.ZMedia(_vKBT1)
_lgCl.Id = "3881b23f-53ae-4b32-b91c-bf401e827586"
_lgCl.Name = _Tho("e/6ZOT_\v\027C^T")
_lgCl.Description = ""
_lgCl.AltText = ""
_lgCl.Resources = {
  {
    Type = "jpg",
    Filename = "k3Hinterhalt.jpg",
    Directives = {}
  }
}
_yGe = Wherigo.ZMedia(_vKBT1)
_yGe.Id = "a8e42a6e-d177-4323-a161-4f6a0cf4a80c"
_yGe.Name = _Tho("ezUC%\024m")
_yGe.Description = ""
_yGe.AltText = ""
_yGe.Resources = {
  {
    Type = "jpg",
    Filename = "k2Kampf.jpg",
    Directives = {}
  }
}
_Y_s = Wherigo.ZMedia(_vKBT1)
_Y_s.Id = "71bb4a88-bc0a-4ba2-9ede-6866f50ce3cf"
_Y_s.Name = _Tho("eJ,\vC!")
_Y_s.Description = ""
_Y_s.AltText = ""
_Y_s.Resources = {
  {
    Type = "jpg",
    Filename = "k4Frau.jpg",
    Directives = {}
  }
}
_HqO9 = Wherigo.ZMedia(_vKBT1)
_HqO9.Id = "ee21d9fb-b1b9-45a3-a726-0cc22d7c3046"
_HqO9.Name = _Tho("ezsCmm_OeC%%_\vz")
_HqO9.Description = ""
_HqO9.AltText = ""
_HqO9.Resources = {
  {
    Type = "jpg",
    Filename = "k2waffenkammer2.jpg",
    Directives = {}
  }
}
_iuM = Wherigo.ZMedia(_vKBT1)
_iuM.Id = "c649c56d-c063-42df-a3d3-78cf50d10bfd"
_iuM.Name = _Tho("eJjg\022\027T_\v")
_iuM.Description = ""
_iuM.AltText = ""
_iuM.Resources = {
  {
    Type = "jpg",
    Filename = "k4Tochter.jpg",
    Directives = {}
  }
}
_ENB = Wherigo.ZMedia(_vKBT1)
_ENB.Id = "6de0e357-f1aa-4db5-b3e7-b6e6d0385993"
_ENB.Name = _Tho("eJ\127ON_")
_ENB.Description = ""
_ENB.AltText = ""
_ENB.Resources = {
  {
    Type = "jpg",
    Filename = "k4Ende.jpg",
    Directives = {}
  }
}
_XkOXn = Wherigo.ZMedia(_vKBT1)
_XkOXn.Id = "4229217d-1832-4c01-a4d9-0002e3a44241"
_XkOXn.Name = _Tho("\tg!ONAC\022\027ZO_(!O")
_XkOXn.Description = ""
_XkOXn.AltText = ""
_XkOXn.Resources = {
  {
    Type = "mp3",
    Filename = "machineGun.mp3",
    Directives = {}
  }
}
_xvzY = Wherigo.ZMedia(_vKBT1)
_xvzY.Id = "b66c1f28-3df7-4749-84ac-32dcdef9e351"
_xvzY.Name = _Tho("\tg!ON6_\vDV\022\027^Cp")
_xvzY.Description = ""
_xvzY.AltText = ""
_xvzY.Resources = {
  {
    Type = "mp3",
    Filename = "herzschlag.mp3",
    Directives = {}
  }
}
_IT2 = Wherigo.ZMedia(_vKBT1)
_IT2.Id = "46b2e667-79ab-44db-b181-0f832b1d666a"
_IT2.Name = _Tho("\019ggT")
_IT2.Description = ""
_IT2.AltText = ""
_IT2.Resources = {
  {
    Type = "jpg",
    Filename = "boot.jpg",
    Directives = {}
  }
}
_7JVXH = Wherigo.ZMedia(_vKBT1)
_7JVXH.Id = "2645a807-ab4d-4cf4-becb-b79a38855475"
_7JVXH.Name = _Tho("C\002T")
_7JVXH.Description = ""
_7JVXH.AltText = ""
_7JVXH.Resources = {
  {
    Type = "jpg",
    Filename = "axt.jpg",
    Directives = {}
  }
}
_TQA = Wherigo.ZMedia(_vKBT1)
_TQA.Id = "e32c998f-65dc-4bc1-b07d-96ea97a93b27"
_TQA.Name = _Tho("C\002T8Z\022Tg")
_TQA.Description = ""
_TQA.AltText = ""
_TQA.Resources = {
  {
    Type = "jpg",
    Filename = "axtPicto.jpg",
    Directives = {}
  }
}
_whXa = Wherigo.ZMedia(_vKBT1)
_whXa.Id = "f0c33f90-5407-42e0-ab3c-9fd988197617"
_whXa.Name = _Tho("\024!%\024p!O")
_whXa.Description = ""
_whXa.AltText = ""
_whXa.Resources = {
  {
    Type = "jpg",
    Filename = "pumpgun.jpg",
    Directives = {}
  }
}
_MZV = Wherigo.ZMedia(_vKBT1)
_MZV.Id = "0e402094-f51e-4762-8fb9-b00d8870dfd0"
_MZV.Name = _Tho("\024!%\024p!O8Z\022Tg")
_MZV.Description = ""
_MZV.AltText = ""
_MZV.Resources = {
  {
    Type = "jpg",
    Filename = "pumpgunPicto.jpg",
    Directives = {}
  }
}
_LwA = Wherigo.ZMedia(_vKBT1)
_LwA.Id = "2f4702cc-ed14-4738-bd67-533a8849991d"
_LwA.Name = _Tho("%!_^^TgO_8Z\022Tg")
_LwA.Description = ""
_LwA.AltText = ""
_LwA.Resources = {
  {
    Type = "jpg",
    Filename = "muelltonne.jpg",
    Directives = {}
  }
}
_Lx6r = Wherigo.ZMedia(_vKBT1)
_Lx6r.Id = "c2ef0821-57ef-4ef4-a33f-38d4fe99291f"
_Lx6r.Name = _Tho("p!^^Z")
_Lx6r.Description = ""
_Lx6r.AltText = ""
_Lx6r.Resources = {
  {
    Type = "jpg",
    Filename = "gulliPicto.jpg",
    Directives = {}
  }
}
_DtA = Wherigo.ZMedia(_vKBT1)
_DtA.Id = "3676053c-1e34-4696-a346-8731967cabc8"
_DtA.Name = _Tho("_\v\v!Op_OV\022\027CmT_O")
_DtA.Description = ""
_DtA.AltText = ""
_DtA.Resources = {
  {
    Type = "jpg",
    Filename = "erungenschaften.jpg",
    Directives = {}
  }
}
_sKQC = Wherigo.ZMedia(_vKBT1)
_sKQC.Id = "36bc5f23-832d-4340-9088-94503504d560"
_sKQC.Name = _Tho("D_TT_^")
_sKQC.Description = ""
_sKQC.AltText = ""
_sKQC.Resources = {
  {
    Type = "jpg",
    Filename = "zettel.jpg",
    Directives = {}
  }
}
_151eF = Wherigo.ZMedia(_vKBT1)
_151eF.Id = "ab4e4d1c-2d9b-47c3-80d3-82af459e832a"
_151eF.Name = _Tho("OgTZD\019!\022\027")
_151eF.Description = ""
_151eF.AltText = ""
_151eF.Resources = {
  {
    Type = "jpg",
    Filename = "notizblock.jpg",
    Directives = {}
  }
}
_i2E = Wherigo.ZMedia(_vKBT1)
_i2E.Id = "325d189d-aab0-45d8-bc10-87fc83218bc8"
_i2E.Name = _Tho("%!OZTZgO")
_i2E.Description = ""
_i2E.AltText = ""
_i2E.Resources = {
  {
    Type = "jpg",
    Filename = "munition.jpg",
    Directives = {}
  }
}
_vplF = Wherigo.ZMedia(_vKBT1)
_vplF.Id = "dc2ef30a-2b7b-4b74-b59c-0d066614cefd"
_vplF.Name = _Tho("T!_\vV\022\027^gVV")
_vplF.Description = ""
_vplF.AltText = ""
_vplF.Resources = {
  {
    Type = "jpg",
    Filename = "schloss.jpg",
    Directives = {}
  }
}
_vKBT1.Id = "ffdcf96e-5f12-4633-aac4-6ab684763bc0"
_vKBT1.Name = "The Walking Dead"
_vKBT1.Description = "Die Jagd auf Zombies ist eroeffnet. Oder werden sie Euch jagen? Packt euren Cowboyhut, die Axt, ein Katana-Schwert, den Baseball-Schlaeger und die Pumpgun ein und los gehts. Diesen Spiel funktioniert bis zum Ende aus einer Mischung von sich bewegenden Zonen, die sichtbar und unsichtbar sind, euch verfolgen und angreifen oder die ihr verfolgen und betreten werdet."
_vKBT1.Visible = true
_vKBT1.Activity = "Geocache"
_vKBT1.StartingLocationDescription = "Berlin, Kreuzberg, Urbankrankenhaus"
_vKBT1.StartingLocation = ZonePoint(52.494933, 13.40925, 0)
_vKBT1.Version = "1.4"
_vKBT1.Company = ""
_vKBT1.Author = "Vansen"
_vKBT1.BuilderVersion = "URWIGO 1.20.5218.24064"
_vKBT1.CreateDate = "08/02/2012 21:09:52"
_vKBT1.PublishDate = "1/1/0001 12:00:00 AM"
_vKBT1.UpdateDate = "12/13/2014 22:46:28"
_vKBT1.LastPlayedDate = "1/1/0001 12:00:00 AM"
_vKBT1.TargetDevice = "PocketPC"
_vKBT1.TargetDeviceVersion = "0"
_vKBT1.StateId = "1"
_vKBT1.CountryId = "2"
_vKBT1.Complete = false
_vKBT1.UseLogging = true
_vKBT1.Media = _PxpE
_vKBT1.Icon = _LM4d
horde_zone = Wherigo.Zone(_vKBT1)
horde_zone.Id = "016644aa-762a-45a1-8604-7ef259d075c7"
horde_zone.Name = _Tho("6g\vN_")
horde_zone.Description = ""
horde_zone.Visible = true
horde_zone.Media = __XYn
horde_zone.Icon = _0CljT
horde_zone.Commands = {}
horde_zone.DistanceRange = Distance(-1, "feet")
horde_zone.ShowObjects = "OnEnter"
horde_zone.ProximityRange = Distance(60, "meters")
horde_zone.AllowSetPositionTo = false
horde_zone.Active = false
horde_zone.Points = {
  ZonePoint(52.4950621628929, 13.4100687503815, 0),
  ZonePoint(52.4950295027053, 13.4099400043488, 0),
  ZonePoint(52.4949968424934, 13.4101331233978, 0)
}
horde_zone.OriginalPoint = ZonePoint(52.4950295026972, 13.4100472927094, 0)
horde_zone.DistanceRangeUOM = "Feet"
horde_zone.ProximityRangeUOM = "Meters"
horde_zone.OutOfRangeName = ""
horde_zone.InRangeName = ""
_BpyFc = Wherigo.Zone(_vKBT1)
_BpyFc.Id = "d08b5c95-925c-440d-8575-ef5c828fc54e"
_BpyFc.Name = _Tho("$Z_VZp_\0216g\vN_")
_BpyFc.Description = ""
_BpyFc.Visible = true
_BpyFc.Media = __XYn
_BpyFc.Icon = _0CljT
_BpyFc.Commands = {}
_BpyFc.DistanceRange = Distance(-1, "feet")
_BpyFc.ShowObjects = "OnEnter"
_BpyFc.ProximityRange = Distance(60, "meters")
_BpyFc.AllowSetPositionTo = false
_BpyFc.Active = false
_BpyFc.Points = {
  ZonePoint(52.4935989626862, 13.4092479944229, 0),
  ZonePoint(52.4959211171195, 13.4038782119751, 0),
  ZonePoint(52.4972438084951, 13.4048920869827, 0),
  ZonePoint(52.496433868869, 13.4064853191376, 0),
  ZonePoint(52.4967147367195, 13.4069734811783, 0),
  ZonePoint(52.4978153294948, 13.4045380353928, 0),
  ZonePoint(52.4958427341596, 13.4030789136887, 0),
  ZonePoint(52.4929816604964, 13.4095215797424, 0),
  ZonePoint(52.4951732073495, 13.4113132953644, 0),
  ZonePoint(52.495316911524, 13.4106105566025, 0)
}
_BpyFc.OriginalPoint = ZonePoint(52.4957042336914, 13.4070539474487, 0)
_BpyFc.DistanceRangeUOM = "Feet"
_BpyFc.ProximityRangeUOM = "Meters"
_BpyFc.OutOfRangeName = ""
_BpyFc.InRangeName = ""
zone_boot = Wherigo.Zone(_vKBT1)
zone_boot.Id = "4c3aa38c-73fe-4458-b3d4-1c55f73975fc"
zone_boot.Name = _Tho("\"ggT")
zone_boot.Description = ""
zone_boot.Visible = true
zone_boot.Media = _alyWm
zone_boot.Icon = _wDkb
zone_boot.Commands = {}
zone_boot.DistanceRange = Distance(-1, "feet")
zone_boot.ShowObjects = "OnEnter"
zone_boot.ProximityRange = Distance(60, "meters")
zone_boot.AllowSetPositionTo = false
zone_boot.Active = false
zone_boot.Points = {
  ZonePoint(52.4959113192571, 13.4086525440216, 0),
  ZonePoint(52.4959570425961, 13.4084594249725, 0),
  ZonePoint(52.4959439787898, 13.4083360433578, 0),
  ZonePoint(52.4958786597002, 13.4083735942841, 0),
  ZonePoint(52.4958198724366, 13.4085881710052, 0)
}
zone_boot.OriginalPoint = ZonePoint(52.495902174556, 13.4084819555282, 0)
zone_boot.DistanceRangeUOM = "Feet"
zone_boot.ProximityRangeUOM = "Meters"
zone_boot.OutOfRangeName = ""
zone_boot.InRangeName = ""
_zMZ = Wherigo.Zone(_vKBT1)
_zMZ.Id = "a5dfda07-54bb-4b4f-918a-e667091b94f9"
_zMZ.Name = _Tho("U\b\"ggT}OVZ\022\027T\019C\v")
_zMZ.Description = ""
_zMZ.Visible = false
_zMZ.Commands = {}
_zMZ.DistanceRange = Distance(-1, "feet")
_zMZ.ShowObjects = "OnEnter"
_zMZ.ProximityRange = Distance(60, "meters")
_zMZ.AllowSetPositionTo = false
_zMZ.Active = false
_zMZ.Points = {
  ZonePoint(52.4963171122289, 13.4053909778595, 0),
  ZonePoint(52.496583284257, 13.4055465459824, 0),
  ZonePoint(52.4966624823715, 13.4049779176712, 0),
  ZonePoint(52.4964355018269, 13.4048250317574, 0)
}
_zMZ.OriginalPoint = ZonePoint(52.4964995951711, 13.4051851183176, 0)
_zMZ.DistanceRangeUOM = "Feet"
_zMZ.ProximityRangeUOM = "Meters"
_zMZ.OutOfRangeName = ""
_zMZ.InRangeName = ""
_ngo5 = Wherigo.Zone(_vKBT1)
_ngo5.Id = "5da869ff-5f8e-4787-8efa-0fc503bbb7be"
_ngo5.Name = _Tho("\tTC\vT")
_ngo5.Description = ""
_ngo5.Visible = true
_ngo5.Commands = {}
_ngo5.DistanceRange = Distance(-1, "feet")
_ngo5.ShowObjects = "OnEnter"
_ngo5.ProximityRange = Distance(60, "meters")
_ngo5.AllowSetPositionTo = false
_ngo5.Active = false
_ngo5.Points = {
  ZonePoint(52.4952793525238, 13.4092935919762, 0),
  ZonePoint(52.49522709647, 13.4096141159534, 0),
  ZonePoint(52.4950548143529, 13.4095242619514, 0),
  ZonePoint(52.4951234006793, 13.4092158079147, 0)
}
_ngo5.OriginalPoint = ZonePoint(52.4951711660065, 13.4094119444489, 0)
_ngo5.DistanceRangeUOM = "Feet"
_ngo5.ProximityRangeUOM = "Meters"
_ngo5.OutOfRangeName = ""
_ngo5.InRangeName = ""
_nuS4_ = Wherigo.Zone(_vKBT1)
_nuS4_.Id = "59550d03-1202-4f6a-9d63-4c543ecd9892"
_nuS4_.Name = _Tho("PZOZ_\"ggT")
_nuS4_.Description = _Tho("5!V^g_V_^ZOZ_\026\021\031Z\vN\021OZ\022\027T\021\019_Og_TZpT\026\021O!\v\021!%\021egg\vNZOCT_O\021D!\021eg\024Z_\v_O\021!ON\021!%\021\031C_\027\v_ON\021N_\v\021_OT\031Z\022e^!Op\021C!m\021N_\v\021eC\vT_\021D!\021V_\027_O")
_nuS4_.Visible = true
_nuS4_.Commands = {}
_nuS4_.DistanceRange = Distance(-1, "feet")
_nuS4_.ShowObjects = "OnEnter"
_nuS4_.ProximityRange = Distance(60, "meters")
_nuS4_.AllowSetPositionTo = false
_nuS4_.Active = false
_nuS4_.Points = {
  ZonePoint(52.4945951199028, 13.4087061882019, 0),
  ZonePoint(52.4957022976736, 13.4090334177017, 0),
  ZonePoint(52.4950719609445, 13.409081697464, 0)
}
_nuS4_.OriginalPoint = ZonePoint(52.4951231261736, 13.4089404344559, 0)
_nuS4_.DistanceRangeUOM = "Feet"
_nuS4_.ProximityRangeUOM = "Meters"
_nuS4_.OutOfRangeName = ""
_nuS4_.InRangeName = ""
zombie_zone = Wherigo.Zone(_vKBT1)
zombie_zone.Id = "e57102c1-729c-4766-a0b6-a8d0244b8289"
zombie_zone.Name = _Tho("\ag%\019Z_")
zombie_zone.Description = ""
zombie_zone.Visible = true
zombie_zone.Media = _5Y6B9
zombie_zone.Icon = _FnmP
zombie_zone.Commands = {}
zombie_zone.DistanceRange = Distance(-1, "feet")
zombie_zone.ShowObjects = "OnEnter"
zombie_zone.ProximityRange = Distance(60, "meters")
zombie_zone.AllowSetPositionTo = false
zombie_zone.Active = false
zombie_zone.Points = {
  ZonePoint(52.4958492660782, 13.4061071276665, 0),
  ZonePoint(52.4958370187299, 13.4061205387115, 0),
  ZonePoint(52.4958394681998, 13.4060963988304, 0)
}
zombie_zone.OriginalPoint = ZonePoint(52.4958419176693, 13.4061080217361, 0)
zombie_zone.DistanceRangeUOM = "Feet"
zombie_zone.ProximityRangeUOM = "Meters"
zombie_zone.OutOfRangeName = ""
zombie_zone.InRangeName = ""
_CH3mx = Wherigo.Zone(_vKBT1)
_CH3mx.Id = "cd2d41b3-22e3-4cea-918e-75dfe15d039c"
_CH3mx.Name = _Tho("U\bPZOZ_\ag%\019Z_\b")
_CH3mx.Description = _Tho("5!V^g_V_^ZOZ_\026\021\031Z\vN\021OZ\022\027T\021\019_Og_TZpT\026\021O!\v\021!%\021egg\vNZOCT_O\021D!\021eg\024Z_\v_O\021!ON\021!%\021\031C_\027\v_ON\021N_\v\021_OT\031Z\022e^!Op\021C!m\021N_\v\021eC\vT_\021D!\021V_\027_O")
_CH3mx.Visible = true
_CH3mx.Commands = {}
_CH3mx.DistanceRange = Distance(-1, "feet")
_CH3mx.ShowObjects = "OnEnter"
_CH3mx.ProximityRange = Distance(60, "meters")
_CH3mx.AllowSetPositionTo = false
_CH3mx.Active = false
_CH3mx.Points = {
  ZonePoint(52.4951862713848, 13.4057289361954, 0),
  ZonePoint(52.4961595310971, 13.4066247940063, 0),
  ZonePoint(52.4956924997625, 13.4063994884491, 0)
}
_CH3mx.OriginalPoint = ZonePoint(52.4956794340815, 13.4062510728836, 0)
_CH3mx.DistanceRangeUOM = "Feet"
_CH3mx.ProximityRangeUOM = "Meters"
_CH3mx.OutOfRangeName = ""
_CH3mx.InRangeName = ""
_5v84r = Wherigo.Zone(_vKBT1)
_5v84r.Id = "494c2c0d-565f-4719-9d7c-f3debc574888"
_5v84r.Name = _Tho("\127\v\031C\022\027_O")
_5v84r.Description = ""
_5v84r.Visible = true
_5v84r.Commands = {}
_5v84r.DistanceRange = Distance(-1, "feet")
_5v84r.ShowObjects = "OnEnter"
_5v84r.ProximityRange = Distance(60, "meters")
_5v84r.AllowSetPositionTo = false
_5v84r.Active = false
_5v84r.Points = {
  ZonePoint(52.4964632621002, 13.4069359302521, 0),
  ZonePoint(52.4965922654937, 13.4069627523422, 0),
  ZonePoint(52.4966183927172, 13.4067602455616, 0),
  ZonePoint(52.4964779587085, 13.4067320823669, 0)
}
_5v84r.OriginalPoint = ZonePoint(52.4965379697549, 13.4068477526307, 0)
_5v84r.DistanceRangeUOM = "Feet"
_5v84r.ProximityRangeUOM = "Meters"
_5v84r.OutOfRangeName = ""
_5v84r.InRangeName = ""
_Mbcll = Wherigo.Zone(_vKBT1)
_Mbcll.Id = "a8ee7f93-0b72-4426-85ad-f97234654758"
_Mbcll.Name = _Tho("5\002T")
_Mbcll.Description = ""
_Mbcll.Visible = false
_Mbcll.Commands = {}
_Mbcll.DistanceRange = Distance(-1, "feet")
_Mbcll.ShowObjects = "OnEnter"
_Mbcll.ProximityRange = Distance(60, "meters")
_Mbcll.AllowSetPositionTo = false
_Mbcll.Active = false
_Mbcll.Points = {
  ZonePoint(52.4964910223562, 13.4061647951603, 0),
  ZonePoint(52.4964893894004, 13.4063619375229, 0),
  ZonePoint(52.4966861601305, 13.406386077404, 0),
  ZonePoint(52.4966984072424, 13.4061875939369, 0)
}
_Mbcll.OriginalPoint = ZonePoint(52.4965912447824, 13.406275101006, 0)
_Mbcll.DistanceRangeUOM = "Feet"
_Mbcll.ProximityRangeUOM = "Meters"
_Mbcll.OutOfRangeName = ""
_Mbcll.InRangeName = ""
_IBsb = Wherigo.Zone(_vKBT1)
_IBsb.Id = "22fec00f-db9e-4ce5-b84c-5f6ae628e579"
_IBsb.Name = _Tho("}m_\v")
_IBsb.Description = ""
_IBsb.Visible = true
_IBsb.Commands = {}
_IBsb.DistanceRange = Distance(-1, "feet")
_IBsb.ShowObjects = "OnEnter"
_IBsb.ProximityRange = Distance(60, "meters")
_IBsb.AllowSetPositionTo = false
_IBsb.Active = false
_IBsb.Points = {
  ZonePoint(52.4964861234887, 13.4061339497566, 0),
  ZonePoint(52.496474692796, 13.4067106246948, 0),
  ZonePoint(52.4964526478802, 13.4069587290287, 0),
  ZonePoint(52.4966567670485, 13.4070056676865, 0),
  ZonePoint(52.4967114708245, 13.4061607718468, 0)
}
_IBsb.OriginalPoint = ZonePoint(52.4965563404076, 13.4065939486027, 0)
_IBsb.DistanceRangeUOM = "Feet"
_IBsb.ProximityRangeUOM = "Meters"
_IBsb.OutOfRangeName = ""
_IBsb.InRangeName = ""
_rh69 = Wherigo.Zone(_vKBT1)
_rh69.Id = "4ee9b766-cff1-49af-957a-b898180f59d0"
_rh69.Name = _Tho("8g^ZD_Z\031C\022\027_")
_rh69.Description = ""
_rh69.Visible = true
_rh69.Media = _pPdg
_rh69.Commands = {}
_rh69.DistanceRange = Distance(-1, "feet")
_rh69.ShowObjects = "OnEnter"
_rh69.ProximityRange = Distance(60, "meters")
_rh69.AllowSetPositionTo = false
_rh69.Active = false
_rh69.Points = {
  ZonePoint(52.4964142733707, 13.408370912075, 0),
  ZonePoint(52.4964877564447, 13.4078975021839, 0),
  ZonePoint(52.4966698306429, 13.4079524874687, 0),
  ZonePoint(52.4966861601306, 13.4078586101532, 0),
  ZonePoint(52.4969858051528, 13.4079632163048, 0),
  ZonePoint(52.4969090570311, 13.4086552262306, 0),
  ZonePoint(52.4966020632043, 13.4086002409458, 0),
  ZonePoint(52.4966085950101, 13.4084339439869, 0)
}
_rh69.OriginalPoint = ZonePoint(52.4966704426234, 13.4082165174186, 0)
_rh69.DistanceRangeUOM = "Feet"
_rh69.ProximityRangeUOM = "Meters"
_rh69.OutOfRangeName = ""
_rh69.InRangeName = ""
_xaHsG = Wherigo.Zone(_vKBT1)
_xaHsG.Id = "441010fb-fe48-4afe-844b-b65c986ec963"
_xaHsG.Name = _Tho("\"ggT\0212COp_^_pTW")
_xaHsG.Description = _Tho("lCV\021\"ggT\021^Z_pT\021p!T\021\019_Vm_VTZpT\021C%\0215Oe_\v\024^CTD\f")
_xaHsG.Visible = true
_xaHsG.Media = _IT2
_xaHsG.Commands = {}
_xaHsG.DistanceRange = Distance(-1, "feet")
_xaHsG.ShowObjects = "OnEnter"
_xaHsG.ProximityRange = Distance(60, "meters")
_xaHsG.AllowSetPositionTo = false
_xaHsG.Active = false
_xaHsG.Points = {
  ZonePoint(52.4964616291435, 13.4067562222481, 0),
  ZonePoint(52.4964493819657, 13.4068782627583, 0),
  ZonePoint(52.4964052920977, 13.4068675339222, 0),
  ZonePoint(52.4964167228085, 13.4067468345165, 0),
  ZonePoint(52.4964452995724, 13.4067066013813, 0)
}
_xaHsG.OriginalPoint = ZonePoint(52.4964356651176, 13.4067910909653, 0)
_xaHsG.DistanceRangeUOM = "Feet"
_xaHsG.ProximityRangeUOM = "Meters"
_xaHsG.OutOfRangeName = ""
_xaHsG.InRangeName = ""
_0THsQ = Wherigo.Zone(_vKBT1)
_0THsQ.Id = "0d679d3a-1760-4682-b198-b9ba168fa1c4"
_0THsQ.Name = _Tho("6Cm_O")
_0THsQ.Description = ""
_0THsQ.Visible = true
_0THsQ.Commands = {}
_0THsQ.DistanceRange = Distance(-1, "feet")
_0THsQ.ShowObjects = "OnEnter"
_0THsQ.ProximityRange = Distance(60, "meters")
_0THsQ.AllowSetPositionTo = false
_0THsQ.Active = false
_0THsQ.Points = {
  ZonePoint(52.4957610850944, 13.4109833836555, 0),
  ZonePoint(52.4956924997624, 13.4113213419914, 0),
  ZonePoint(52.4958868245917, 13.4114098548889, 0),
  ZonePoint(52.4959374468852, 13.4111094474792, 0)
}
_0THsQ.OriginalPoint = ZonePoint(52.4958194640834, 13.4112060070038, 0)
_0THsQ.DistanceRangeUOM = "Feet"
_0THsQ.ProximityRangeUOM = "Meters"
_0THsQ.OutOfRangeName = ""
_0THsQ.InRangeName = ""
_Gr3S = Wherigo.Zone(_vKBT1)
_Gr3S.Id = "0873d86f-636a-4aed-9c2f-51cfbbe4b622"
_Gr3S.Name = _Tho("6ZOT_\v\027C^T")
_Gr3S.Description = ""
_Gr3S.Visible = false
_Gr3S.Commands = {}
_Gr3S.DistanceRange = Distance(-1, "feet")
_Gr3S.ShowObjects = "OnEnter"
_Gr3S.ProximityRange = Distance(60, "meters")
_Gr3S.AllowSetPositionTo = false
_Gr3S.Active = false
_Gr3S.Points = {
  ZonePoint(52.4967784216221, 13.4114715456963, 0),
  ZonePoint(52.4966837107079, 13.4119945764542, 0),
  ZonePoint(52.4968959935077, 13.4121662378311, 0),
  ZonePoint(52.4970266285673, 13.4116351604462, 0)
}
_Gr3S.OriginalPoint = ZonePoint(52.4968461886013, 13.411816880107, 0)
_Gr3S.DistanceRangeUOM = "Feet"
_Gr3S.ProximityRangeUOM = "Meters"
_Gr3S.OutOfRangeName = ""
_Gr3S.InRangeName = ""
_tM3Xb = Wherigo.Zone(_vKBT1)
_tM3Xb.Id = "2ecdfce0-fda4-4701-8a7a-f4e36066aa3c"
_tM3Xb.Name = _Tho("5!VV_O\024gVT_O")
_tM3Xb.Description = ""
_tM3Xb.Visible = true
_tM3Xb.Commands = {}
_tM3Xb.DistanceRange = Distance(-1, "feet")
_tM3Xb.ShowObjects = "OnEnter"
_tM3Xb.ProximityRange = Distance(60, "meters")
_tM3Xb.AllowSetPositionTo = false
_tM3Xb.Active = false
_tM3Xb.Points = {
  ZonePoint(52.4971719596152, 13.4121997654438, 0),
  ZonePoint(52.4972683024046, 13.4123177826405, 0),
  ZonePoint(52.4973858729803, 13.4120401740074, 0),
  ZonePoint(52.4972838152069, 13.4119409322739, 0)
}
_tM3Xb.OriginalPoint = ZonePoint(52.4972774875518, 13.4121246635914, 0)
_tM3Xb.DistanceRangeUOM = "Feet"
_tM3Xb.ProximityRangeUOM = "Meters"
_tM3Xb.OutOfRangeName = ""
_tM3Xb.InRangeName = ""
_svJ = Wherigo.Zone(_vKBT1)
_svJ.Id = "74b0e010-690f-42a9-95dd-9493474fbd4c"
_svJ.Name = _Tho("PCp_\v")
_svJ.Description = ""
_svJ.Visible = true
_svJ.Commands = {}
_svJ.DistanceRange = Distance(-1, "feet")
_svJ.ShowObjects = "OnEnter"
_svJ.ProximityRange = Distance(60, "meters")
_svJ.AllowSetPositionTo = false
_svJ.Active = false
_svJ.Points = {
  ZonePoint(52.4972878975223, 13.4073570370674, 0),
  ZonePoint(52.4973181066451, 13.4075206518173, 0),
  ZonePoint(52.4973172901826, 13.4075608849525, 0),
  ZonePoint(52.4973009609293, 13.4075877070427, 0),
  ZonePoint(52.4972707517948, 13.4075890481472, 0),
  ZonePoint(52.497259321306, 13.407548815012, 0),
  ZonePoint(52.4972250298219, 13.4073852002621, 0)
}
_svJ.OriginalPoint = ZonePoint(52.4972827654574, 13.4075070491859, 0)
_svJ.DistanceRangeUOM = "Feet"
_svJ.ProximityRangeUOM = "Meters"
_svJ.OutOfRangeName = ""
_svJ.InRangeName = ""
_AeKf = Wherigo.Zone(_vKBT1)
_AeKf.Id = "8b380dd2-009f-4831-b167-dfd5912552e8"
_AeKf.Name = _Tho("UzPZOZ_\ag%\019Z_z")
_AeKf.Description = _Tho("5!V^g_V_^ZOZ_\026\021\031Z\vN\021OZ\022\027T\021\019_Og_TZpT\026\021O!\v\021!%\021egg\vNZOCT_O\021D!\021eg\024Z_\v_O\021!ON\021!%\021\031C_\027\v_ON\021N_\v\021_OT\031Z\022e^!Op\021C!m\021N_\v\021eC\vT_\021D!\021V_\027_O")
_AeKf.Visible = false
_AeKf.Commands = {}
_AeKf.DistanceRange = Distance(-1, "feet")
_AeKf.ShowObjects = "OnEnter"
_AeKf.ProximityRange = Distance(62, "meters")
_AeKf.AllowSetPositionTo = false
_AeKf.Active = false
_AeKf.Points = {
  ZonePoint(52.4966077785345, 13.4085573256016, 0),
  ZonePoint(52.4961946398956, 13.4083950519562, 0),
  ZonePoint(52.4963718164276, 13.4085774421692, 0)
}
_AeKf.OriginalPoint = ZonePoint(52.4963914116192, 13.408509939909, 0)
_AeKf.DistanceRangeUOM = "Feet"
_AeKf.ProximityRangeUOM = "Meters"
_AeKf.OutOfRangeName = ""
_AeKf.InRangeName = ""
_Wn98 = Wherigo.Zone(_vKBT1)
_Wn98.Id = "de8f3576-f0ea-40bc-b15b-1ec547cdc4b6"
_Wn98.Name = _Tho("UzPZOZ_6g\vN_z")
_Wn98.Description = _Tho("5!V^g_V_^ZOZ_\026\021\031Z\vN\021OZ\022\027T\021\019_Og_TZpT\026\021O!\v\021!%\021egg\vNZOCT_O\021D!\021eg\024Z_\v_O\021!ON\021!%\021\031C_\027\v_ON\021N_\v\021_OT\031Z\022e^!Op\021C!m\021N_\v\021eC\vT_\021D!\021V_\027_O")
_Wn98.Visible = true
_Wn98.Commands = {}
_Wn98.DistanceRange = Distance(-1, "feet")
_Wn98.ShowObjects = "OnEnter"
_Wn98.ProximityRange = Distance(60, "meters")
_Wn98.AllowSetPositionTo = false
_Wn98.Active = false
_Wn98.Points = {
  ZonePoint(52.4966183927171, 13.4100526571274, 0),
  ZonePoint(52.4959390798615, 13.4096959233284, 0),
  ZonePoint(52.4963081309361, 13.4099480509758, 0)
}
_Wn98.OriginalPoint = ZonePoint(52.4962885345049, 13.4098988771439, 0)
_Wn98.DistanceRangeUOM = "Feet"
_Wn98.ProximityRangeUOM = "Meters"
_Wn98.OutOfRangeName = ""
_Wn98.InRangeName = ""
__rQd = Wherigo.Zone(_vKBT1)
__rQd.Id = "354c3eea-1fb5-4fba-9df7-6e1d3255c7e4"
__rQd.Name = _Tho("Uzs_p}OVZ\022\027T\019C\v")
__rQd.Description = ""
__rQd.Visible = false
__rQd.Commands = {}
__rQd.DistanceRange = Distance(1000, "meters")
__rQd.ShowObjects = "Always"
__rQd.ProximityRange = Distance(1000, "meters")
__rQd.AllowSetPositionTo = false
__rQd.Active = false
__rQd.Points = {
  ZonePoint(52.4963587527445, 13.4082502126694, 0),
  ZonePoint(52.496340790174, 13.4084004163742, 0),
  ZonePoint(52.4964061085771, 13.4084191918373, 0),
  ZonePoint(52.4964257040791, 13.4082850813866, 0)
}
__rQd.OriginalPoint = ZonePoint(52.4963828388937, 13.4083387255669, 0)
__rQd.DistanceRangeUOM = "Meters"
__rQd.ProximityRangeUOM = "Meters"
__rQd.OutOfRangeName = ""
__rQd.InRangeName = ""
kontaktmann_zone = Wherigo.Zone(_vKBT1)
kontaktmann_zone.Id = "3d9819a3-5cd9-45a4-84a3-8df0e1505848"
kontaktmann_zone.Name = _Tho("sCOp\0212UgOTCeT%COOW")
kontaktmann_zone.Description = ""
kontaktmann_zone.Visible = true
kontaktmann_zone.Commands = {}
kontaktmann_zone.DistanceRange = Distance(-1, "feet")
kontaktmann_zone.ShowObjects = "OnEnter"
kontaktmann_zone.ProximityRange = Distance(60, "meters")
kontaktmann_zone.AllowSetPositionTo = false
kontaktmann_zone.Active = false
kontaktmann_zone.Points = {
  ZonePoint(52.4973572968276, 13.4121555089951, 0),
  ZonePoint(52.4973728095984, 13.412136733532, 0),
  ZonePoint(52.4973532145185, 13.4121260046959, 0)
}
kontaktmann_zone.OriginalPoint = ZonePoint(52.4973611069815, 13.412139415741, 0)
kontaktmann_zone.DistanceRangeUOM = "Feet"
kontaktmann_zone.ProximityRangeUOM = "Meters"
kontaktmann_zone.OutOfRangeName = ""
kontaktmann_zone.InRangeName = ""
_P4V = Wherigo.Zone(_vKBT1)
_P4V.Id = "ac60032b-eba4-4ef7-b5ea-a04d0aff6919"
_P4V.Name = _Tho("A('R_VT")
_P4V.Description = ""
_P4V.Visible = false
_P4V.Commands = {}
_P4V.DistanceRange = Distance(-1, "feet")
_P4V.ShowObjects = "OnEnter"
_P4V.ProximityRange = Distance(60, "meters")
_P4V.AllowSetPositionTo = false
_P4V.Active = false
_P4V.Points = {
  ZonePoint(52.4977238866341, 13.4075018763542, 0),
  ZonePoint(52.4988252705838, 13.4074482321739, 0),
  ZonePoint(52.4988571115182, 13.4069520235062, 0),
  ZonePoint(52.4977361334568, 13.4069506824017, 0)
}
_P4V.OriginalPoint = ZonePoint(52.4982856005482, 13.407213203609, 0)
_P4V.DistanceRangeUOM = "Feet"
_P4V.ProximityRangeUOM = "Meters"
_P4V.OutOfRangeName = ""
_P4V.InRangeName = ""
_6bj = Wherigo.Zone(_vKBT1)
_6bj.Id = "5c219048-0df1-4738-9950-7b48140c0ca1"
_6bj.Name = _Tho("Pgp\019!\022\027\021N_\v\021}OTgT_O")
_6bj.Description = _Tho("l!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\021D!\021!_\019_\v^_\019_O\f\021l_V\027C^\019\021NC\vmVT\021N!\021C^V\021\ag%\019Z_\021^gpp_O\fE\"$bdZ_^^_Z\022\027T\021I_\vV!\022\027VT\021N!\021NZ\022\027\021Og\022\027%C^\021C%\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O<E\"$bE\"$b\127ZO_O\0216ZO\031_ZV\021pZ\019T\021_V\026\021\031_OO\021N!\021NZ_\021\agO_\021\019_T\vZTTVT\flZ_\021Ugg\vNZOCT_O\021C!m\021N_%\021\a_TT_^\021Z%\021~OI_OTC\v\021VZON\021p_OC!_\v\026\021N_O\021NZ_\021\agO_\021D_ZpT\021_ZO_O\021\"_\v_Z\022\027\021CO\021!ON\021OZ\022\027T\021N_O\0218!OeT\021\031g\021NCV\021Pgp\019!\022\027\021^Z_pT\f")
_6bj.Visible = true
_6bj.Commands = {}
_6bj.DistanceRange = Distance(-1, "feet")
_6bj.ShowObjects = "OnEnter"
_6bj.ProximityRange = Distance(60, "meters")
_6bj.AllowSetPositionTo = false
_6bj.Active = false
_6bj.Points = {
  ZonePoint(52.4972250298219, 13.4082300961018, 0),
  ZonePoint(52.4972274792145, 13.4081563353539, 0),
  ZonePoint(52.497145016255, 13.4081496298313, 0),
  ZonePoint(52.497141750392, 13.4082408249378, 0)
}
_6bj.OriginalPoint = ZonePoint(52.4971848189208, 13.4081942215562, 0)
_6bj.DistanceRangeUOM = "Feet"
_6bj.ProximityRangeUOM = "Meters"
_6bj.OutOfRangeName = ""
_6bj.InRangeName = ""
_wZsf5 = Wherigo.Zone(_vKBT1)
_wZsf5.Id = "25abd576-0714-4742-8fad-ffb2db8e6305"
_wZsf5.Name = _Tho("Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O")
_wZsf5.Description = _Tho("l!\021\027CVT\021!_\019_\v^_\019T\021!ON\021N_ZO_\021,C%Z^Z_\021p_m!ON_O\f\021\127ZO_O\0216ZO\031_ZV\021pZ\019T\021_V\026\021\031_OO\021N!\021NZ_\021\agO_\021\019_T\vZTTVT\f\021E\"$blZ_\021Ugg\vNZOCT_O\021C!m\021N_%\021\a_TT_^\021Z%\021~OI_OTC\v\021VZON\021p_OC!_\v\026\021N_O\021NZ_\021\agO_\021D_ZpT\021_ZO_O\021\"_\v_Z\022\027\021CO\021!ON\021OZ\022\027T\021N_O\0218!OeT\021\031g\021NCV\021Pgp\019!\022\027\021^Z_pT\f")
_wZsf5.Visible = true
_wZsf5.Commands = {}
_wZsf5.DistanceRange = Distance(-1, "feet")
_wZsf5.ShowObjects = "OnEnter"
_wZsf5.ProximityRange = Distance(60, "meters")
_wZsf5.AllowSetPositionTo = false
_wZsf5.Active = false
_wZsf5.Points = {
  ZonePoint(52.4972266627503, 13.4081563353539, 0),
  ZonePoint(52.4971425668577, 13.4081523120403, 0),
  ZonePoint(52.4971401174604, 13.4082421660423, 0),
  ZonePoint(52.4972258462862, 13.4082287549973, 0)
}
_wZsf5.OriginalPoint = ZonePoint(52.4971837983386, 13.4081948921085, 0)
_wZsf5.DistanceRangeUOM = "Feet"
_wZsf5.ProximityRangeUOM = "Meters"
_wZsf5.OutOfRangeName = ""
_wZsf5.InRangeName = ""
_2o99 = Wherigo.Zone(_vKBT1)
_2o99.Id = "6e5559b9-0cc0-4cd5-87db-9405f6415c60"
_2o99.Name = _Tho("U/6g^D\031_p")
_2o99.Description = ""
_2o99.Visible = false
_2o99.Commands = {}
_2o99.DistanceRange = Distance(-1, "feet")
_2o99.ShowObjects = "OnEnter"
_2o99.ProximityRange = Distance(60, "meters")
_2o99.AllowSetPositionTo = false
_2o99.Active = false
_2o99.Points = {
  ZonePoint(52.4957708829902, 13.413046002388, 0),
  ZonePoint(52.4953430395053, 13.4129333496094, 0),
  ZonePoint(52.4952973155279, 13.4135770797729, 0),
  ZonePoint(52.4957055636435, 13.4136897325516, 0)
}
_2o99.OriginalPoint = ZonePoint(52.4955292004167, 13.4133115410805, 0)
_2o99.DistanceRangeUOM = "Feet"
_2o99.ProximityRangeUOM = "Meters"
_2o99.OutOfRangeName = ""
_2o99.InRangeName = ""
_IP9n = Wherigo.Zone(_vKBT1)
_IP9n.Id = "d243402b-5d44-4c36-89f8-2783279a37d1"
_IP9n.Name = _Tho("U/\t_ZT_O\031_pPZOeV")
_IP9n.Description = ""
_IP9n.Visible = false
_IP9n.Commands = {}
_IP9n.DistanceRange = Distance(-1, "feet")
_IP9n.ShowObjects = "OnEnter"
_IP9n.ProximityRange = Distance(60, "meters")
_IP9n.AllowSetPositionTo = false
_IP9n.Active = false
_IP9n.Points = {
  ZonePoint(52.4968363911327, 13.4111899137497, 0),
  ZonePoint(52.4968976264483, 13.4112153947353, 0),
  ZonePoint(52.4968437393751, 13.411507755518, 0),
  ZonePoint(52.4967792380946, 13.4114688634872, 0)
}
_IP9n.OriginalPoint = ZonePoint(52.4968392487627, 13.4113454818726, 0)
_IP9n.DistanceRangeUOM = "Feet"
_IP9n.ProximityRangeUOM = "Meters"
_IP9n.OutOfRangeName = ""
_IP9n.InRangeName = ""
_Qst = Wherigo.Zone(_vKBT1)
_Qst.Id = "4a1d60af-c1f2-4422-ba0a-cdaab6336e5f"
_Qst.Name = _Tho("U/\t_ZT_O\031_p$_\022\027TV")
_Qst.Description = ""
_Qst.Visible = false
_Qst.Commands = {}
_Qst.DistanceRange = Distance(-1, "feet")
_Qst.ShowObjects = "OnEnter"
_Qst.ProximityRange = Distance(60, "meters")
_Qst.AllowSetPositionTo = false
_Qst.Active = false
_Qst.Points = {
  ZonePoint(52.4966779953875, 13.4123928844929, 0),
  ZonePoint(52.4966085950101, 13.4123472869396, 0),
  ZonePoint(52.4966796283363, 13.4120039641857, 0),
  ZonePoint(52.4967522944938, 13.412062972784, 0)
}
_Qst.OriginalPoint = ZonePoint(52.4966796283069, 13.4122017771006, 0)
_Qst.DistanceRangeUOM = "Feet"
_Qst.ProximityRangeUOM = "Meters"
_Qst.OutOfRangeName = ""
_Qst.InRangeName = ""
_w8b8Z = Wherigo.Zone(_vKBT1)
_w8b8Z.Id = "0dff3806-7767-46be-8210-0566bf4dd35b"
_w8b8Z.Name = _Tho("Uz8g^ZD_Z\031C\022\027_6Z^m_")
_w8b8Z.Description = ""
_w8b8Z.Visible = false
_w8b8Z.Commands = {}
_w8b8Z.DistanceRange = Distance(-1, "feet")
_w8b8Z.ShowObjects = "OnEnter"
_w8b8Z.ProximityRange = Distance(60, "meters")
_w8b8Z.AllowSetPositionTo = false
_w8b8Z.Active = false
_w8b8Z.Points = {
  ZonePoint(52.4964836740548, 13.4078773856163, 0),
  ZonePoint(52.496397943782, 13.4084326028824, 0),
  ZonePoint(52.4965955313974, 13.4084956347942, 0),
  ZonePoint(52.4966632988462, 13.4079377353191, 0)
}
_w8b8Z.OriginalPoint = ZonePoint(52.4965351120201, 13.408185839653, 0)
_w8b8Z.DistanceRangeUOM = "Feet"
_w8b8Z.ProximityRangeUOM = "Meters"
_w8b8Z.OutOfRangeName = ""
_w8b8Z.InRangeName = ""
_wrIo = Wherigo.Zone(_vKBT1)
_wrIo.Id = "ccff5495-117e-4ec6-bfd1-f877d680dacb"
_wrIo.Name = _Tho("6_\vDV\022\027^Cp5eTZIZ_\v_O")
_wrIo.Description = ""
_wrIo.Visible = false
_wrIo.Commands = {}
_wrIo.DistanceRange = Distance(-1, "feet")
_wrIo.ShowObjects = "OnEnter"
_wrIo.ProximityRange = Distance(60, "meters")
_wrIo.AllowSetPositionTo = false
_wrIo.Active = false
_wrIo.Points = {
  ZonePoint(52.4975997853046, 13.4064397215843, 0),
  ZonePoint(52.4975361015916, 13.4076574444771, 0),
  ZonePoint(52.49759815239, 13.4076574444771, 0),
  ZonePoint(52.4976651018374, 13.4064558148384, 0)
}
_wrIo.OriginalPoint = ZonePoint(52.4975997852809, 13.4070526063442, 0)
_wrIo.DistanceRangeUOM = "Feet"
_wrIo.ProximityRangeUOM = "Meters"
_wrIo.OutOfRangeName = ""
_wrIo.InRangeName = ""
_Hqto = Wherigo.ZCharacter({Cartridge = _vKBT1, Container = _5v84r})
_Hqto.Id = "8b12fb90-aa94-401b-a87c-31af6bda1858"
_Hqto.Name = _Tho("AC\v^_ ")
_Hqto.Description = ""
_Hqto.Visible = false
_Hqto.Media = _ARh
_Hqto.Commands = {
  _lRu = Wherigo.ZCommand({
    Text = _Tho("COV\024\v_\022\027_O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_Hqto.Commands._lRu.Custom = true
_Hqto.Commands._lRu.Id = "cbf317dc-862e-4b84-ad85-74abc6b41d29"
_Hqto.Commands._lRu.WorksWithAll = true
_Hqto.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Hqto.Gender = "Male"
_Hqto.Type = "NPC"
_fibu = Wherigo.ZCharacter({Cartridge = _vKBT1, Container = __rQd})
_fibu.Id = "41d94424-ba29-4478-9d84-596338b79b94"
_fibu.Name = _Tho("\ag%\019Z_")
_fibu.Description = _Tho("lZ_V_O\021\ag%\019Z_\021pZ^T\021_V\021!%\021NZ_\021\127\022e_\021D!\021\019\vZOp_O\f\021E\"$b\t\022\027C^T_\021C!m\021NZ_\021YPg\022CTZgOY\021\ag%\019Z_\026\021^CVV\021Z\027O\021!OT_\v\021zr\021A_T_\v\021CO\021NZ\022\027\021\vCOeg%%_O\021!ON\021NCOO\021V\022\027C^T_\021\031Z_N_\v\021C!m\021Ycg!\021\t__Y\021\ag%\019Z_\021!ON\021_\vV\022\027Z_VV\021Z\027O\f")
_fibu.Visible = false
_fibu.Commands = {}
_fibu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fibu.Gender = "It"
_fibu.Type = "NPC"
_FPS = Wherigo.ZCharacter({Cartridge = _vKBT1, Container = __rQd})
_FPS.Id = "77afc6af-c025-4499-b3ea-6caabc7c9c0c"
_FPS.Name = _Tho("6g\vN_")
_FPS.Description = _Tho("lZ_V_\0216g\vN_\021pZ^T\021_V\021!%\021NZ_\021\127\022e_\021D!\021\019\vZOp_O\f\021E\"$b\t\022\027C^T_\021C!m\021NZ_\021YPg\022CTZgOY\0216g\vN_\026\021^CVV\021VZ_\021!OT_\v\021zr\021A_T_\v\021CO\021NZ\022\027\021\vCOeg%%_O\021!ON\021NCOO\021V\022\027C^T_\021\031Z_N_\v\021C!m\021NZ_\021Ycg!\021\t__Y\0216g\vN_\021!ON\021_\vV\022\027Z_VV\021VZ_\f")
_FPS.Visible = false
_FPS.Commands = {}
_FPS.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_FPS.Gender = "It"
_FPS.Type = "NPC"
_IBMS = Wherigo.ZCharacter({Cartridge = _vKBT1, Container = _tM3Xb})
_IBMS.Id = "a50041de-56b4-49ca-8a67-94340e87336e"
_IBMS.Name = _Tho("sCOp")
_IBMS.Description = ""
_IBMS.Visible = true
_IBMS.Media = _WZTq
_IBMS.Commands = {}
_IBMS.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_IBMS.Gender = "Male"
_IBMS.Type = "NPC"
_zzY = Wherigo.ZItem({Cartridge = _vKBT1, Container = _zMZ})
_zzY.Id = "3c891c62-2953-422b-85df-0a96693e0405"
_zzY.Name = _Tho("\"ggT")
_zzY.Description = ""
_zzY.Visible = false
_zzY.Media = _IT2
_zzY.Commands = {
  _qB_K = Wherigo.ZCommand({
    Text = _Tho("\t\024\vZOp_\021ZO\021NCV\021\"ggT"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_zzY.Commands._qB_K.Custom = true
_zzY.Commands._qB_K.Id = "df5d6e3f-428f-4b89-9c3d-e0723601dc82"
_zzY.Commands._qB_K.WorksWithAll = true
_zzY.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zzY.Locked = false
_zzY.Opened = false
_Tt3sw = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_Tt3sw.Id = "68a0ba67-cc63-426e-9b45-ba81865422b4"
_Tt3sw.Name = _Tho("\t\024_Z\022\027_\veC\vT_")
_Tt3sw.Description = _Tho("\a!p\vZmm\021C!m\021\t\022\027^!_VV_^\024gVZTZgO_O\021m!_\v\021NCV\021j_VTV\024Z_^_O\021I_\vV\022\027Z_N_O_\v\021UC\024ZT_^")
_Tt3sw.Visible = false
_Tt3sw.Commands = {
  _9a00S = Wherigo.ZCommand({
    Text = _Tho("^CN_\021UC\024ZT_^\021z"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _n6RQu = Wherigo.ZCommand({
    Text = _Tho("^CN_\021UC\024ZT_^\021/\021'\021p_p_OAC\v^_ "),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _PMaXb = Wherigo.ZCommand({
    Text = _Tho("CeTZIZ_\v_\021\agO_O\021ez"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _c6ZD1 = Wherigo.ZCommand({
    Text = _Tho("^CN_\021UC\024ZT_^\021/\021'm!_\v\021AC\v^_ "),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _5NFD = Wherigo.ZCommand({
    Text = _Tho("^CN_\021UC\024ZT_^\021J"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _aAm = Wherigo.ZCommand({
    Text = _Tho("CeTZIZ_\v_\021PCp_\v\021!ON\021%p'O_VT"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_Tt3sw.Commands._9a00S.Custom = true
_Tt3sw.Commands._9a00S.Id = "9b9361d9-801c-4f10-b418-f933b5d97347"
_Tt3sw.Commands._9a00S.WorksWithAll = true
_Tt3sw.Commands._n6RQu.Custom = true
_Tt3sw.Commands._n6RQu.Id = "c5854ed6-fe8d-4829-b96b-713915b15d66"
_Tt3sw.Commands._n6RQu.WorksWithAll = true
_Tt3sw.Commands._PMaXb.Custom = true
_Tt3sw.Commands._PMaXb.Id = "bc375982-44b3-48be-af62-867272306a8d"
_Tt3sw.Commands._PMaXb.WorksWithAll = true
_Tt3sw.Commands._c6ZD1.Custom = true
_Tt3sw.Commands._c6ZD1.Id = "00b045e4-caa8-4544-ab5d-265ab099b615"
_Tt3sw.Commands._c6ZD1.WorksWithAll = true
_Tt3sw.Commands._5NFD.Custom = true
_Tt3sw.Commands._5NFD.Id = "fb40bc74-83d2-4b5f-bf11-b795d7f56894"
_Tt3sw.Commands._5NFD.WorksWithAll = true
_Tt3sw.Commands._aAm.Custom = true
_Tt3sw.Commands._aAm.Id = "3aa7f942-b8c8-47fe-802a-38913bf47fd7"
_Tt3sw.Commands._aAm.WorksWithAll = true
_Tt3sw.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Tt3sw.Locked = false
_Tt3sw.Opened = false
_0SH = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_0SH.Id = "cb2150b3-65ed-4a19-a5e3-17d1bb442aef"
_0SH.Name = _Tho("5\002T")
_0SH.Description = _Tho("PZ_pT\021p!T\021ZO\021N_\v\0216CON\f\021\t_\027\v\021VTC\019Z^\f")
_0SH.Visible = false
_0SH.Media = _7JVXH
_0SH.Icon = _TQA
_0SH.Commands = {}
_0SH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_0SH.Locked = false
_0SH.Opened = false
_Oayl = Wherigo.ZItem({Cartridge = _vKBT1, Container = _rh69})
_Oayl.Id = "bd992890-deb4-49a6-ba32-842a54b0d183"
_Oayl.Name = _Tho("j!_\vV\022\027^gVV")
_Oayl.Description = _Tho("5%\021j!_\vV\022\027^gVV\021\019_mZON_T\021VZ\022\027\021_ZO\021e^_ZO_V\021j_\v%ZOC^\026\021\031_^\022\027_V\021_ZO_O\021\\gN_\021C^V\021\127ZOpC\019_\021_\v\031C\vT_T\f\021\127V\021ZVT\021VgpC\v\021Og\022\027\021\tT\vg%\021N\vC!m\f")
_Oayl.Visible = true
_Oayl.Icon = _vplF
_Oayl.Commands = {
  _gQ7N = Wherigo.ZCommand({
    Text = _Tho("\\gN_\021_ZOp_\019_O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_Oayl.Commands._gQ7N.Custom = true
_Oayl.Commands._gQ7N.Id = "f0f942ed-06b9-4221-a563-7a00f8f91e12"
_Oayl.Commands._gQ7N.WorksWithAll = true
_Oayl.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Oayl.Locked = false
_Oayl.Opened = false
_0Q8 = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_0Q8.Id = "4e73a667-8b10-4165-89c9-e4ec1dbc7c09"
_0Q8.Name = _Tho("(_\031_\027\v")
_0Q8.Description = ""
_0Q8.Visible = false
_0Q8.Media = _whXa
_0Q8.Icon = _MZV
_0Q8.Commands = {
  _cpB = Wherigo.ZCommand({
    Text = _Tho("^CN_O\021!ON\021_OTVZ\022\027_\vO\021%ZT"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _ElJef = Wherigo.ZCommand({
    Text = _Tho("V\022\027Z_VV_O\021%ZT\014C!m"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _VMR = Wherigo.ZCommand({
    Text = "",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  }),
  _hFR = Wherigo.ZCommand({
    Text = "",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_0Q8.Commands._cpB.Custom = true
_0Q8.Commands._cpB.Id = "eb8eb822-9b75-49be-9be0-9aad5e7f79f5"
_0Q8.Commands._cpB.WorksWithAll = false
_0Q8.Commands._cpB.WorksWithListIds = {
  "243eac8b-1761-4fd5-b39b-218fda04603b"
}
_0Q8.Commands._ElJef.Custom = true
_0Q8.Commands._ElJef.Id = "86617221-65ab-401c-8305-d4152102491d"
_0Q8.Commands._ElJef.WorksWithAll = false
_0Q8.Commands._ElJef.WorksWithListIds = {
  "6df59821-971f-44d2-a1fc-89f8aadd1e9b",
  "bd992890-deb4-49a6-ba32-842a54b0d183",
  "41d94424-ba29-4478-9d84-596338b79b94",
  "77afc6af-c025-4499-b3ea-6caabc7c9c0c"
}
_0Q8.Commands._VMR.Custom = true
_0Q8.Commands._VMR.Id = "d434c152-4794-404a-ac16-67f008da7547"
_0Q8.Commands._VMR.WorksWithAll = true
_0Q8.Commands._hFR.Custom = true
_0Q8.Commands._hFR.Id = "37b72f21-e566-4f24-862d-24046b167ecf"
_0Q8.Commands._hFR.WorksWithAll = true
_0Q8.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_0Q8.Locked = false
_0Q8.Opened = false
_DuxZO = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_DuxZO.Id = "243eac8b-1761-4fd5-b39b-218fda04603b"
_DuxZO.Name = _Tho("A!OZTZgO")
_DuxZO.Description = _Tho("\015_N_\021A_Op_\021A!OZTZgO\f\021")
_DuxZO.Visible = false
_DuxZO.Icon = _i2E
_DuxZO.Commands = {}
_DuxZO.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_DuxZO.Locked = false
_DuxZO.Opened = false
_uwkEr = Wherigo.ZItem({Cartridge = _vKBT1, Container = _rh69})
_uwkEr.Id = "6df59821-971f-44d2-a1fc-89f8aadd1e9b"
_uwkEr.Name = _Tho("A!_^^TgOO_")
_uwkEr.Description = _Tho("(!T\021m!_\v\021\aZ_^!_\019!Op_O\f")
_uwkEr.Visible = true
_uwkEr.Icon = _LwA
_uwkEr.Commands = {}
_uwkEr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_uwkEr.Locked = false
_uwkEr.Opened = false
_HXw = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_HXw.Id = "73558193-8004-428a-9669-a8aa765294b9"
_HXw.Name = _Tho("\127\v\v!Op_OV\022\027CmT_O")
_HXw.Description = _Tho("lZ_\021\a!C%%_OmCVV!Op\021N_\v\021\127\v\v!Op_OV\022\027CmT_O\021Z%\021\t\024Z_^\f")
_HXw.Visible = false
_HXw.Icon = _DtA
_HXw.Commands = {
  _x93dn = Wherigo.ZCommand({
    Text = _Tho("COV\022\027C!_O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_HXw.Commands._x93dn.Custom = true
_HXw.Commands._x93dn.Id = "29a8d800-9264-4ad1-a1f1-ac5bcdc15bf4"
_HXw.Commands._x93dn.WorksWithAll = true
_HXw.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_HXw.Locked = false
_HXw.Opened = false
_5K7e = Wherigo.ZItem({Cartridge = _vKBT1, Container = _rh69})
_5K7e.Id = "0840cfa9-9571-4a56-bee5-a0e6b118cf0c"
_5K7e.Name = _Tho("(!^^ZN_\022e_^")
_5K7e.Description = _Tho("l_\v\021(!^^ZN_\022e_^\021ZVT\021_ZO\021p_\027_Z%_\v\021\a!pCOp\021D!\v\0218g^ZD_Z\031C\022\027_\021!ON\021N_%_OTV\024\v_\022\027_ON\021%ZT\021_ZO_%\021\a!pCOp\022gN_\021p_VZ\022\027_\vT\f")
_5K7e.Visible = true
_5K7e.Icon = _Lx6r
_5K7e.Commands = {
  _4AAZ = Wherigo.ZCommand({
    Text = _Tho("\\gN_\021_ZOp_\019_O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_5K7e.Commands._4AAZ.Custom = true
_5K7e.Commands._4AAZ.Id = "df14cbd2-9f01-4294-b427-35c28ff8e55a"
_5K7e.Commands._4AAZ.WorksWithAll = true
_5K7e.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_5K7e.Locked = false
_5K7e.Opened = false
_Odm = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_Odm.Id = "d12a5b85-34b1-4702-bcd5-f94161e5dd76"
_Odm.Name = _Tho("\a_TT_^\021%ZT\021Ugg\vNZOCT_O")
_Odm.Description = _Tho("6Z_\v\021^Z_pT\021NCV\021Pgp\019!\022\027\021N_\v\021}OTgT_O\028E\"$bE\"$bRHz\021(\vCN\021zG\f1/rJ/\021E\"$b\127\b/\021(\vCN\021zJ\fJGz/\029E\"$bE\"$b\019D\031\fE\"$bE\"$bR\021Hz\fJG\029\b\029J\021E\"$b\127\021\b/\fJr1zr\rE\"$bE\"$b\"ZTT_\021OZ\022\027T\021CO\021N_\v\021l_eg\021DZ_\027_O\017")
_Odm.Visible = false
_Odm.Icon = _sKQC
_Odm.Commands = {}
_Odm.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Odm.Locked = false
_Odm.Opened = false
_6nMS = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_6nMS.Id = "52a3cc63-cdec-4c51-bc81-4353e2b57722"
_6nMS.Name = _Tho("\a_TT_^\021%ZT\021Ugg\vNZOCT_O")
_6nMS.Description = _Tho("6Z_\v\021^Z_pT\021NCV\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O\028E\"$bE\"$bRHz\021(\vCN\021zG\f1/rJ/\021E\"$b\127\b/\021(\vCN\021zJ\fJGz/\029E\"$bE\"$b\019D\031\fE\"$bE\"$bR\021Hz\fJG\029\b\029J\021E\"$b\127\021\b/\fJr1zr\rE\"$bE\"$b\"ZTT_\021OZ\022\027T\021CO\021N_\v\021l_eg\021DZ_\027_O\017")
_6nMS.Visible = false
_6nMS.Icon = _sKQC
_6nMS.Commands = {}
_6nMS.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_6nMS.Locked = false
_6nMS.Opened = false
_iaeY = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_iaeY.Id = "468b9d8d-8f4c-4125-b0b3-c5d6ac5207fe"
_iaeY.Name = _Tho("RgTZD\019^g\022e")
_iaeY.Description = _Tho("\127ZO\021p!T_\v\021\"!^^_\021\027CT\021Z%%_\v\021_ZO_O\021RgTZD\019^g\022e\021NC\019_Z\fE\"$bs_OO\021N!\021Z%\021\t\024Z_^\021%C^\021OZ\022\027T\021\031_ZT_\v\021eg%%VT\026\021NCOO\021\027_^m_O\021NZ\v\021\019_VTZ%%T\021N_ZO_\021RgTZD_O\f")
_iaeY.Visible = false
_iaeY.Icon = _151eF
_iaeY.Commands = {
  _Y9p04 = Wherigo.ZCommand({
    Text = _Tho("COV\022\027C!_O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_iaeY.Commands._Y9p04.Custom = true
_iaeY.Commands._Y9p04.Id = "74ae688c-81a8-4c75-97e8-69d44b14bf26"
_iaeY.Commands._Y9p04.WorksWithAll = true
_iaeY.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_iaeY.Locked = false
_iaeY.Opened = false
_NNR = Wherigo.ZItem({Cartridge = _vKBT1, Container = Player})
_NNR.Id = "9c14f416-419a-41b8-ba73-a355f3fdf164"
_NNR.Name = _Tho(",\v_ZV\022\027C^T\022gN_")
_NNR.Description = _Tho("lZ_V_\v\021\\gN_\021eCOO\021C!m\021s\027_\vZpg\f\022g%\021_ZOp_p_\019_O\021\031_\vN_O\f\021lCOO\021\031Z\vN\021N_ZO_\021\\C\vT\vZNp_\021C^V\021N!\v\022\027p_V\024Z_^T\021%C\veZ_\vT\fE\"$bl_\v\021K\031O_\v\021VZ_\027T\021NZ_V\021C!\022\027\021!ON\021m\v_!T\021VZ\022\027\021\018'W")
_NNR.Visible = false
_NNR.Icon = _dMHqh
_NNR.Commands = {
  _BY5 = Wherigo.ZCommand({
    Text = _Tho("COV\022\027C!_O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Tho("RZ\022\027T\021I_\vm!p\019C\v")
  })
}
_NNR.Commands._BY5.Custom = true
_NNR.Commands._BY5.Id = "89019184-756b-4930-a813-7f495bf6c155"
_NNR.Commands._BY5.WorksWithAll = true
_NNR.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NNR.Locked = false
_NNR.Opened = false
_tB8V = Wherigo.ZTask(_vKBT1)
_tB8V.Id = "557b29da-1095-40c7-9da9-d2c90898e861"
_tB8V.Name = _Tho("\127\v\v_Z\022\027_\021NCV\021\"ggT")
_tB8V.Description = _Tho("lZ_\021_ZODZp_\021\\\027CO\022_\021C!m\021$_TT!Op\021ZVT\021NCV\021\"ggT\f\021lCD!\021%!VVT\021N!\021NZ_\021\"\v!_\022e_\021_\v\v_Z\022\027_O\f")
_tB8V.Visible = false
_tB8V.Active = false
_tB8V.Complete = false
_tB8V.CorrectState = "None"
_jPDLV = Wherigo.ZTask(_vKBT1)
_jPDLV.Id = "88517c74-7f3c-4168-b1ee-d4f2fd6b3c39"
_jPDLV.Name = _Tho("\t\024\vZ\022\027\021N_O\021ACOO\021CO")
_jPDLV.Description = _Tho("dZ_^^_Z\022\027T\021\027CT\021N_\v\021\"ggTV\019_VZTD_\v\021~Omg\v%CTZgO_O\021m!_\v\021NZ\022\027\f\021\t\024\vZ\022\027\021Z\027O\021Ng\022\027\021%C^\021CO\026\021Z%%_\v\027ZO\021\027CT\021_\v\021NZ\022\027\021^_\019_O\021^CVV_O\f")
_jPDLV.Visible = false
_jPDLV.Active = false
_jPDLV.Complete = false
_jPDLV.CorrectState = "None"
_kvkDf = Wherigo.ZTask(_vKBT1)
_kvkDf.Id = "70d2b24a-39f1-4878-a0ef-1ed48b942744"
_kvkDf.Name = _Tho("\"_pZ\019\021NZ\022\027\021D!\v\021sC\022\027_")
_kvkDf.Description = _Tho("d_\vV\022\027Cmm_\021NZ\v\021\a!pCOp\021D!\v\021sC\022\027_")
_kvkDf.Visible = false
_kvkDf.Active = false
_kvkDf.Complete = false
_kvkDf.CorrectState = "None"
_1Xiq = Wherigo.ZTask(_vKBT1)
_1Xiq.Id = "781317f4-ca9e-4aaf-9d01-41f3da857b11"
_1Xiq.Name = _Tho("\127\v\031C\022\027_\017")
_1Xiq.Description = _Tho("\"_pZ\019\021NZ\022\027\021D!\v\021\agO_\021\127\v\031C\022\027_O\026\021NC%ZT\021N!\021\031Z_N_\v\021D!\021NZ\v\021eg%%_O\021eCOOVT\f")
_1Xiq.Visible = false
_1Xiq.Active = false
_1Xiq.Complete = false
_1Xiq.CorrectState = "None"
_OCIO = Wherigo.ZTask(_vKBT1)
_OCIO.Id = "7486f993-9d55-4338-9180-6e226e12d2b9"
_OCIO.Name = _Tho("\"_pZ\019\021NZ\022\027\021D!%\0216Cm_O")
_OCIO.Description = _Tho("l_\v\0216Cm_O\021^Z_pT\021\022C\f\021zrr\021g_VT^Z\022\027\021IgO\021N_\v\0215O^_p_VT_^^_\021N_V\021\"ggT_V\f")
_OCIO.Visible = false
_OCIO.Active = false
_OCIO.Complete = false
_OCIO.CorrectState = "None"
_bxfl = Wherigo.ZTask(_vKBT1)
_bxfl.Id = "47e81bd4-4fe0-434c-8f6b-e4c37e5c1126"
_bxfl.Name = _Tho(",ZON_\021N_O\0215!VV_O\024gVT_O")
_bxfl.Description = _Tho("5%\0215!VV_O\024gVT_O\021Vg^^\021COp_\019^Z\022\027\021_ZO\021UgOTCeT%COO\021\031C\vT_O\f")
_bxfl.Visible = false
_bxfl.Active = false
_bxfl.Complete = false
_bxfl.CorrectState = "None"
_ucz = Wherigo.ZTask(_vKBT1)
_ucz.Id = "a6a7538c-55bf-4752-89e5-e199003bb819"
_ucz.Name = _Tho("(_\027_\021D!%\021PCp_\v")
_ucz.Description = ""
_ucz.Visible = false
_ucz.Active = false
_ucz.Complete = false
_ucz.CorrectState = "None"
entfernungHorde = 0
_lqy = 0
entfernung_boot = 0
_iuxF = 0
entfernung_BootSpieler = 0
_T1D = 0
entfernung_Zombie = 0
_MWL = false
_Vt1 = false
_EmcQN = 0
_FJQ = false
_sWs5f = 0
spielzeit = 0
_ia8g = 0
_r1Y = 0
vZombie = 0
radiusZombie = 0
formZombie = 0
formHorde = 0
vHorde = 0
radiusHorde = 0
_2Wu = 0
_gJUJ = 0
entfernungKMFP = 0
zaehlerFixpunkte = 0
vKontaktmann = 0
radiusKontaktmann = 0
formKontaktmann = 0
entfernungSpielerFP = 0
_Rdw0 = 0
_o37E = 0
_HR3SQ = _Tho("RZ\022\027TV\026\021pC\v\021pC\v\021OZ\022\027TV\f")
_4Vw = false
_PnxoO = false
_ul_Kr = ""
_n7mb = ""
_kFT = ""
_nY8 = ""
_u_d = ""
_AoZx = 0
_TEQiu = _Tho("l!\021\027CVT\021r\021%C^\021p_V\022\027gVV_O\f")
cr = ""
_5Q86M = 0
_E8GOf = 0
_pOGCA = _Tho("\027g\vN_&DgO_")
_9uYr = _Tho("&6|Tg")
_JwCl = _Tho("&DDc")
_mSw8 = _Tho("&T\"1d")
_X1Iq4 = _Tho("&V\b\022~")
_vGJUt = _Tho("&_\024e")
_vKBT1.ZVariables = {
  entfernungHorde = 0,
  _lqy = 0,
  entfernung_boot = 0,
  _iuxF = 0,
  entfernung_BootSpieler = 0,
  _T1D = 0,
  entfernung_Zombie = 0,
  _MWL = false,
  _Vt1 = false,
  _EmcQN = 0,
  _FJQ = false,
  _sWs5f = 0,
  spielzeit = 0,
  _ia8g = 0,
  _r1Y = 0,
  vZombie = 0,
  radiusZombie = 0,
  formZombie = 0,
  formHorde = 0,
  vHorde = 0,
  radiusHorde = 0,
  _2Wu = 0,
  _gJUJ = 0,
  entfernungKMFP = 0,
  zaehlerFixpunkte = 0,
  vKontaktmann = 0,
  radiusKontaktmann = 0,
  formKontaktmann = 0,
  entfernungSpielerFP = 0,
  _Rdw0 = 0,
  _o37E = 0,
  _HR3SQ = _Tho("RZ\022\027TV\026\021pC\v\021pC\v\021OZ\022\027TV\f"),
  _4Vw = false,
  _PnxoO = false,
  _ul_Kr = "",
  _n7mb = "",
  _kFT = "",
  _nY8 = "",
  _u_d = "",
  _AoZx = 0,
  _TEQiu = _Tho("l!\021\027CVT\021r\021%C^\021p_V\022\027gVV_O\f"),
  cr = "",
  _5Q86M = 0,
  _E8GOf = 0,
  _pOGCA = _Tho("\027g\vN_&DgO_"),
  _9uYr = _Tho("&6|Tg"),
  _JwCl = _Tho("&DDc"),
  _mSw8 = _Tho("&T\"1d"),
  _X1Iq4 = _Tho("&V\b\022~"),
  _vGJUt = _Tho("&_\024e")
}
_epk = Wherigo.ZTimer(_vKBT1)
_epk.Id = "1de158bd-f908-48c0-b4c6-ca10dee23f84"
_epk.Name = _Tho("\"_\031_p!Op6g\vN_")
_epk.Description = ""
_epk.Visible = true
_epk.Duration = 1
_epk.Type = "Interval"
_7MixJ = Wherigo.ZTimer(_vKBT1)
_7MixJ.Id = "d8d9183b-1e59-4c17-9d53-e5498fb9eed4"
_7MixJ.Name = _Tho("\127U(\031C\vT_O")
_7MixJ.Description = _Tho("1\021V_e!ON_O\021\031C\vT_O\021\019ZV\021N_\v\021_ep\021Vg!ON\021m_\vTZp\021ZVT")
_7MixJ.Visible = true
_7MixJ.Duration = 8
_7MixJ.Type = "Countdown"
_XfU = Wherigo.ZTimer(_vKBT1)
_XfU.Id = "306e9aca-f70d-4f6d-a09d-6def1f22e3b0"
_XfU.Name = _Tho("\"_\031_p!Op\"ggT")
_XfU.Description = ""
_XfU.Visible = true
_XfU.Duration = 1
_XfU.Type = "Interval"
_si3DZ = Wherigo.ZTimer(_vKBT1)
_si3DZ.Id = "153a842d-44ec-46f4-929c-afb6893a37bc"
_si3DZ.Name = _Tho("\022\027_\022e_PZOZ_\"ggT5!V^g_V_O")
_si3DZ.Description = _Tho("!_\019_\v|!_\vT\021N_\v\021\t\024Z_^_\v\021_ZO_\021PZOZ_\026\021\031Z\vN\021NZ_\021\"ggTV\019_\031_p!Op\021Vg\031Z_\021VZ\022\027T\019C\ve_ZT\021C!Vp_^g_VT")
_si3DZ.Visible = true
_si3DZ.Duration = 1
_si3DZ.Type = "Interval"
_lHfPE = Wherigo.ZTimer(_vKBT1)
_lHfPE.Id = "a9928630-1160-4875-98b3-41ecb1c03054"
_lHfPE.Name = _Tho("\022\027_\022e_PZOZ_\ag%\019Z_\b")
_lHfPE.Description = _Tho("OC\022\027\021N_\v\021dCO\021PggO\021Vg^^\021Og\022\027\021_ZO\021\ag%\019Z_\021C!mTC!\022\027_O")
_lHfPE.Visible = true
_lHfPE.Duration = 1
_lHfPE.Type = "Interval"
_TIo15 = Wherigo.ZTimer(_vKBT1)
_TIo15.Id = "0cc9040a-6916-45e4-91c3-b7f953fdf66c"
_TIo15.Name = _Tho("\"_\031_p!Op\ag%\019Z_")
_TIo15.Description = ""
_TIo15.Visible = true
_TIo15.Duration = 1
_TIo15.Type = "Interval"
_f7Ng = Wherigo.ZTimer(_vKBT1)
_f7Ng.Id = "93698ca1-adc9-434b-bc4e-c4920b1e3e54"
_f7Ng.Name = _Tho("Uz5\002T,ZON_O")
_f7Ng.Description = ""
_f7Ng.Visible = true
_f7Ng.Duration = 90
_f7Ng.Type = "Countdown"
_13nA5 = Wherigo.ZTimer(_vKBT1)
_13nA5.Id = "1955406a-ef68-4b4a-802b-c4b4e4126646"
_13nA5.Name = _Tho("\022\027_\022e_PZOZ_\ag%\019Z_z")
_13nA5.Description = _Tho("C!m\021N_%\021\031_p\021D\031ZV\022\027_O\021\024g^ZD_!\021!ON\021\027Cm_O")
_13nA5.Visible = true
_13nA5.Duration = 1
_13nA5.Type = "Interval"
_mFU = Wherigo.ZTimer(_vKBT1)
_mFU.Id = "d06e1c3d-1fd7-437c-a697-cec64ac08707"
_mFU.Name = _Tho("\022\027_\022e_PZOZ_6g\vN_z")
_mFU.Description = _Tho("C!m\021N_%\021\031_p\021D\031ZV\022\027_O\021\024g^ZD_Z\021!ON\021\027Cm_O")
_mFU.Visible = true
_mFU.Duration = 1
_mFU.Type = "Interval"
_VRm = Wherigo.ZTimer(_vKBT1)
_VRm.Id = "4e865e8b-254b-4ad0-9c0b-fa4831b2c542"
_VRm.Name = _Tho("ez6Z^m_\\gN_")
_VRm.Description = ""
_VRm.Visible = true
_VRm.Duration = 120
_VRm.Type = "Countdown"
_g7wf = Wherigo.ZTimer(_vKBT1)
_g7wf.Id = "0331f2cd-7e15-4b24-9a27-0ad78554f5e7"
_g7wf.Name = _Tho("\"_\031_p!Op\bUgOTCeT%COO")
_g7wf.Description = _Tho("N_\v\021V\024CDZ_\vpCOp\021\019ZV\021D!\v\021OC_\022\027VT_O\021VT\vCVV_O_\022e_\fE\"$b2dg\v\021N_%\021\v!V\027\021D!%\021C!mmCOp^Cp_\vW")
_g7wf.Visible = true
_g7wf.Duration = 1
_g7wf.Type = "Interval"
_kGGk = Wherigo.ZTimer(_vKBT1)
_kGGk.Id = "b058ee46-49b8-4403-8bec-18a09538a352"
_kGGk.Name = _Tho("\022\027_\022e_\127OTm_\vO!OpUgOTCe%COO")
_kGGk.Description = _Tho("egOTCeT%COO\021_\v\v_Z\022\027T\021\024!OeT\021CO\021N_\v\021VT\vCVV_O_\022e_\021N!\v\022\027\021C\019C\v\019_ZT_O\021N_V\021TZ%_\vV\021!ON\021N_\v\021mZ\002\024!OeT_E\"$b\031_OO\021N_\v\021V\024Z_^_\v\021C!\022\027\021OC\027\021p_O!p\021CO\021_\019_O\021NZ_V_%\021mZ\002\024!OeT\021ZVT\026\021\019_pZOOT\021N_\v\021\v!V\027\021")
_kGGk.Visible = true
_kGGk.Duration = 1
_kGGk.Type = "Interval"
_KiTpv = Wherigo.ZTimer(_vKBT1)
_KiTpv.Id = "fb89054a-27c3-42d7-b677-c91339f60ad6"
_KiTpv.Name = _Tho("\"_\031_p!OpzUgOTCeT%COO")
_KiTpv.Description = _Tho("\031Z\vN\021\019_Og_TZpT\026\021NC\021CON_\v_\021mZ\002\024!OeT_\021COp_V\024\vg\022\027_O\021\031_\vN_O\f\021NZ_\021m!OeTZgO\021\019_\031_p!OpDg%\019Z_\021\027ZOp_p_O\021eCOO\021Z%%_\v\021\031Z_N_\v\021\019_O!TDT\021\031_\vN_O\026\021NC\021VZ\022\027\021N_\v\021Dg%\019Z_\021C!m\021N_O\021V\024Z_^_\v\021D!\019_\031_pT")
_KiTpv.Visible = true
_KiTpv.Duration = 1
_KiTpv.Type = "Interval"
_s1cI = Wherigo.ZInput(_vKBT1)
_s1cI.Id = "f26dd77d-c74c-46d8-938b-5574725e234d"
_s1cI.Name = _Tho("Ug%\024CVV\vgV_\127ZOpC\019_")
_s1cI.Description = ""
_s1cI.Visible = true
_s1cI.InputType = "Text"
_s1cI.Text = _Tho("(Z\019\021N_O\021\\gN_\021%ZT\021G\021\"!\022\027VTC\019_O\021_ZO\028")
_Ykm = Wherigo.ZInput(_vKBT1)
_Ykm.Id = "1a25b76b-1ccb-43e2-b5f2-ecb3a7fa2780"
_Ykm.Name = _Tho("6Z^m_\\gN_")
_Ykm.Description = _Tho("AC\v^_ \021m\vCpT\026\021g\019\021_\v\021N_O\021\022gN_\021I_\v\vCT_O\021Vg^^\026\021\019D\031\021_ZO_O\021\027ZO\031_ZV\021N\vC!m\021p_\019_O\f")
_Ykm.Visible = true
_Ykm.Choices = {"Ja", "Nein"}
_Ykm.InputType = "MultipleChoice"
_Ykm.Text = _Tho("\tg^^\021Z\022\027\021NZ\v\021_ZO_O\0216ZO\031_ZV\021p_\019_O<E\"$bE\"$bl_\v\0216ZO\031_ZV\021ZVT\021Ig\v\021K\vT\017\021lZ_V_\0216Z^m_\021ZVT\021m!_\v\021!Op_N!^NZp_\021C\019_\v\021O_TT_\021AZT%_OV\022\027_O\021NZ_\0215ON_\v_\021\v_TT_O\021\018'W")
_cMMH = Wherigo.ZInput(_vKBT1)
_cMMH.Id = "9688ea91-d8a6-4198-9464-89a80c910eca"
_cMMH.Name = _Tho("(!^^ZN_\022e_^\127ZOpC\019_")
_cMMH.Description = ""
_cMMH.Visible = true
_cMMH.InputType = "Text"
_cMMH.Text = _Tho("(Z\019\021N_O\021\\gN_\0212RC%_\021N_\v\021\tTCNTW\021_ZO\028")
_n4j = Wherigo.ZInput(_vKBT1)
_n4j.Id = "7ddbcbf4-972e-43df-ae7f-dee0b6421b6b"
_n4j.Name = _Tho("5\019m\vCp_$_p_^\b")
_n4j.Description = ""
_n4j.Visible = true
_n4j.Choices = {
  "Bleib sportlich - reise leicht.",
  "Sei leise in Zombieland!",
  "Sei nicht geizig mit deiner Munition - doppelt haelt besser."
}
_n4j.InputType = "MultipleChoice"
_n4j.Text = _Tho("s_OO\021Z\022\027\021NZ\v\021N_O\021s_p\021D_Zp_O\021Vg^^\026\021NCOO\021%!VV\021Z\022\027\021%Z\v\021VZ\022\027_\v\021V_ZO\026\021NCVV\021N!\021%Z\022\027\021OZ\022\027T\021ZO\021(_mC\027\v\021\019\vZOpVT\fE\"$bsZ_\021^C!T_T\021NZ_\021$_p_^\021\b\021ZO\021\ag%\019Z_^CON<")
_C03bm = Wherigo.ZInput(_vKBT1)
_C03bm.Id = "9d4d2290-4869-46ba-b87b-609ed4e56796"
_C03bm.Name = _Tho("5OT\031g\vT\021AC\v^_ ")
_C03bm.Description = _Tho("\024V_!NgCOT\031g\vT\021\019_Z%\021\027ZOT_\v\027C^T")
_C03bm.Visible = true
_C03bm.Choices = {"A", "B"}
_C03bm.InputType = "MultipleChoice"
_C03bm.Text = _Tho("5\028\021YlCV\021VZON\021\031C\027\vV\022\027_ZO^Z\022\027\021NZ_\021RC\022\027\031Z\ve!Op_O\021N_V\021Ug%CV\f\021A_ZO\021Ug\024m\021\019\v!%%T\021pCOD\021V\022\027g_O\fYE\"$bE\"$b\"\028\021l!\021VT_^^VT\021NZ\022\027\021^Z_\019_\v\021\019^g_N\f\021Y5\022\027Vg\026\021NCV\021\027Z_\v\021Vg^^\021N_\v\021(\v!_OVT_Zm_O\021V_ZO<\0216C\019_\021Z\022\027\021pC\v\021OZ\022\027T\021p_%_\veT\017")
_GT1f7 = Wherigo.ZInput(_vKBT1)
_GT1f7.Id = "e8b5c00e-4cee-4d3c-a900-71075af7b887"
_GT1f7.Name = _Tho("5OT\031g\vT6ZOT_\v\027C^T")
_GT1f7.Description = ""
_GT1f7.Visible = true
_GT1f7.Choices = {
  "Eine Axt",
  "Ein Gewehr und Munition",
  "Ein Notizblock",
  "Geld",
  "Weisheit"
}
_GT1f7.InputType = "MultipleChoice"
_GT1f7.Text = _Tho("\t\024gOTCO\021mC^^_O\021NZ\v\021H\021lZOp_\021_ZO\f")
_uRt = Wherigo.ZInput(_vKBT1)
_uRt.Id = "371c93d0-3061-4aa7-952c-d8189bca0484"
_uRt.Name = _Tho("\t\024gZ^_\vlgV_")
_uRt.Description = ""
_uRt.Visible = true
_uRt.Choices = {"Ja", "Nein"}
_uRt.InputType = "MultipleChoice"
_uRt.Text = _Tho("Ag_\022\027T_VT\021N!\021_ZO_O\0216ZO\031_ZV<E\"$bl!\021eCOOVT\021C!\022\027\021_\vVT%C^\021V!\022\027_O\f\021\"_T\v_T_\021NZ_\021\agO_\021O_!\026\021\031_OO\021N!\021NCOO\021Ng\022\027\0216Z^m_\021\019\vC!\022\027VT\f")
_0Q8.Commands._cpB.WorksWithList = {_DuxZO}
_0Q8.Commands._ElJef.WorksWithList = {
  _uwkEr,
  _Oayl,
  _fibu,
  _FPS
}
function _vKBT1:OnStart()
  _Urwigo.MessageBox({
    Text = _Tho("}%\021NCV\021\t\024Z_^\021D!\021\019_pZOO_O\026\021\019_T\v_T_\021\019ZTT_\021NZ_\021\agO_\021\tTC\vT\f"),
    Callback = function(action)
      if action ~= nil then
        _ngo5.Active = true
      end
    end
  })
end
function _vKBT1:OnRestore()
end
function _BpyFc:OnEnter()
  _pOGCA = _Tho("&\"\024 ,\022")
  _Rdw0 = 0
  _VL8kU()
  _KE2M()
end
function _zMZ:OnEnter()
  _pOGCA = _Tho("&DA\a")
  _zzY.Visible = true
  _zzY.Commands._qB_K.Enabled = true
end
function _ngo5:OnEnter()
  local _Urwigo_Date = os.date("*t")
  _pOGCA = _Tho("&OpgH")
  _ngo5.Active = false
  _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _Urwigo.Dialog(false, {
    {Text = "", Media = _LQl},
    {
      Text = (_Tho("~O\021%_ZO_%\021m\v!_\027_\v_O\021P_\019_O\021\031C\v\021Z\022\027\021_ZO\021\"!^^_\f\021A_ZO\021RC%_\021ZVT\021") .. Player.Name) .. _Tho("\fE\"$b~O\021%_ZO_%\021$_IZ_\v\021pC\019\021_V\021e_ZO_\0218\vg\019^_%_\026\021Z\022\027\021p\vZmm\021Vgmg\vT\021\027C\vT\021N!\v\022\027\f\021~\022\027\021\027C\019_\021_ZO_\021\031!ON_\vV\022\027g_O_\021,\vC!\026\0215%\019_\v\f\021A_ZO_\021jg\022\027T_\v\021\t\027CO_\021eg%%T\021pCOD\021OC\022\027\021%Z\v\026\021V\022\027^Cpm_\vTZp\026\021C!VNC!_\vON\021!ON\021DC_\027\f\021\"ZV\021D!\021NZ_V_%\021_ZO_O\021pgTTI_\vNC%%T_O\021jCp\026\021CO\021N_%\021VZ\022\027\021C^^_V\021C_ON_\vO\021Vg^^T_\f"),
      Media = _38c
    },
    {
      Text = _Tho("~\022\027\021\019ZO\021%C^\021\031Z_N_\v\021C!m\021\tT\v_Zm_\f\021lCV\021\031C\v\021\027_!T_\021V\022\027gO\021N_\v\021m!_OmT_\021\"_Vgmm_O_\021!%\021N_O\021Z\022\027\021%Z\022\027\021e!_%%_\vO\021%!VV\f\021\003O\019V\024\018\127V\021pZ\019T\021jCp_\021CO\021N_O_O\021_ZOmC\022\027\021OZ\022\027TV\021^gV\021Z\f\f\f\f\f\f\f"),
      Media = _Hu3r
    },
    {
      Text = (_Tho("\a_OT\vC^_\028E\"$b\a_OT\vC^_\021CO\021") .. Player.Name) .. _Tho("\026\021\019ZTT_\021eg%%_O\f")
    },
    {
      Text = Player.Name .. _Tho("\021\027Z_\v\026\021\031CV\021pZ\019TV\021N_O\021\a_OT\vC^_<"),
      Media = _38c
    },
    {
      Text = _Tho("\a_OT\vC^_\028E\"$b\127V\021\031!\vN_\021_ZO_\021\t\022\027Z_VV_\v_Z\021C%\021UgTTZ\021p_%_^N_T\021\f\f\f\021")
    },
    {
      Text = _Tho("\f\f\f\019ZO\021V\022\027gO\021!OT_\v\031_pV\f\f\f"),
      Media = _38c
    },
    {
      Text = _Tho("~\022\027\021VT_^^\021N_O\021UCmm__\021\019_ZV_ZT_\021!ON\021p_\019_\021dg^^pCV\f\021\a!\021NZ_V_\v\021\a_ZT\021ZVT\021OZ\022\027T\021IZ_^\021^gV\021C!m\021N_O\021\tT\vCVV_O\f\0215%\021UgTTZ\021\019\v_OOT\021NZ_\021P!mT\f\021A_ZO_\021Ug^^_p_O\021VT_\027_O\021V\022\027\031_\v\021!OT_\v\021\"_V\022\027!VV\f\021E\"$b~\022\027\021VT_Zp_\021C!V\021\f\f\f")
    },
    {
      Text = _Tho("E\"$b555$$$(6666\021\017\017\017E\"$bE\"$b\f\f\f\021NZ_V_\v\021e^_ZO_\021sZ\022\027V_\v\021T\vZmmT\021%Z\022\027\021ZO\021NZ_\021\"\v!VT\f\021\127ZO\021VT_\022\027_ON_\v\021\t\022\027%_\vD\021\f\f\f\0215%\019_\v\021\f\f\f\021\t\027CO_\021\f\f\f"),
      Media = _tNMj
    }
  }, function(action)
    _7MixJ:Start()
    Wherigo.PlayAudio(_svK)
    _Urwigo.OldDialog({
      {
        Text = _Tho("l!Oe_^\027_ZT"),
        Media = _L5U
      }
    })
  end)
end
function _5v84r:OnEnter()
  _pOGCA = _Tho("&HI1J\v")
  _IBsb.Active = true
  _IBsb.Visible = true
  _1Xiq.Complete = true
  _Hqto.Name = _Tho("\127ZO\021!O\019_eCOOT_\v\021ACOO\f")
  _Hqto.Visible = true
  _Urwigo.MessageBox({
    Text = "",
    Media = _MkZ,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.Dialog(false, {
          {
            Text = _Tho("U_ZO_\0215\027O!Op\021\031Z_\021IZ_^\021\a_ZT\021I_\vpCOp_O\021ZVT\026\021C\019_\v\021V\022\027^CpC\vTZp\021eg%%VT\021N!\021D!\021Ig^^_%\021\"_\031!VVTV_ZO\fE\"$bE\"$bdg\v\021NZ\v\021VT_\027T\021_ZO\021ACOO\026\021\031C\027\vV\022\027_ZO^Z\022\027\021N_\v\021\"ggTV\019_VZTD_\v\fE\"$b")
          }
        }, function(action)
          _jPDLV.Active = true
          _jPDLV.Visible = true
          _Hqto:MoveTo(_IBsb)
          _5v84r.Active = false
        end)
      end
    end
  })
end
function _Mbcll:OnEnter()
  _pOGCA = _Tho("&A\019\022^^")
  _f7Ng:Stop()
  _0SH.Visible = true
  _rh69.Active = true
  _w8b8Z.Active = true
  _Mbcll.Active = false
  _IBsb.Active = false
  print("du hast alle gerettet, timer gestoppt")
  _Urwigo.MessageBox({
    Text = _Tho("l!\021mZON_VT\021_ZO_\0215\002T\f\021\tZ_\021^Z_pT\021p!T\021ZO\021N_\v\0216CON\f\021lC%ZT\021^CVV_O\021VZ\022\027\021\031!ON_\v\019C\v\021\ag%\019Z_eg_\024m_\021V\024C^T_O\f"),
    Media = _7JVXH,
    Buttons = {
      _Tho("RZ%%\0215\002T")
    },
    Callback = function(action)
      if action ~= nil then
        _Urwigo.Dialog(false, {
          {
            Text = _Tho("l!\021\v_OOVT\021D!\v!_\022e\021D!\021AC\v^_ \f\021\127V\021ZVT\021C^^_\v\027g_\022\027VT_\021\a_ZT\026\021C!m\021N_%\021s_p\021p\v_Zm_O\021NZ\022\027\021NZ_\021_\vVT_O\021\ag%\019Z_V\021CO\f\021l!\021\031!_T_VT\021\031Z_\021_ZO\021\"_\vV_\ve_\v\f\021l!\021V\022\027^C_pVT\021!ON\021T\vZTTVT\021\031Z_\021_ZO\021d_\v\v!_\022eT_\v\021!%\021NZ\022\027\fE\"$bE\"$bAC\v^_ \021ZVT\021p_VTg^\024_\vT\021!ON\021_ZO\021\"_ZVV_\v\021^Z_pT\021C!m\021Z\027%\026\021\031_OZp_\021\a_OTZ%_T_\v\021T\v_OO_O\021V_ZO_O\0216C^V\021IgO\021N_O\021mC!^Zp_O\021\aC_\027O_O\021N_V\021}OTgT_O\f\021l!\021\v_OOVT\021CO\021Z\027%\021Ig\v\019_Z\026\021V\022\027\031ZOpVT\021NZ_\0215\002T\021ZO\021N_VV_O\021Ug\024m\021!ON\021V\024\vZOpVT\021C!m\021NCV\021\"ggT\f\021~%\021^_TDT_O\0215!p_O\019^Z\022\027\021eCOOVT\021N!\021AC\v^_ V\021\tg\027O\021\v_TT_O\026\021N_\v\021IgO\021D\031_Z\021\031_ZT_\v_O\021\ag%\019Z_V\021CTTC\022eZ_\vT\021\031Z\vN\fE\"$b"),
            Media = _yGe
          },
          {
            Text = Player.Name .. _Tho("\026\021N!\021\027CVT\021!OV\021p_\vCN_\021N_O\0216C^V\021p_\v_TT_T\f\021d_\vNC%%T\026\021%_ZO\021\015!Op_\021eg_OOT_\021y_TDT\021TgT\021V_ZO\f\021lCV\021I_\vp_VV\021Z\022\027\021NZ\v\021OZ_\f"),
            Media = _ARh
          },
          {
            Text = _Tho("l!\021\019ZVT\021mZ\002\021!ON\021m_\vTZp\021%ZT\021N_O\021R_\vI_O\021!ON\021%ZT\021N_\v\021s_^T\f\021\t\022\027C!\021NZ\022\027\021O!\v\021CO\026\021!_\019_\vC^^\021T\vg\024mT\021\"^!T\021IgO\021N_ZO_\v\021U^_ZN!Op\fE\"$bE\"$bl!\021DZTT_\vVT\021Ig\v\0215!m\v_p!Op\f\021l_ZO\0216_\vD\021V\022\027^C_pT\021\031Z_\021I_\v\v!_\022eT\fE\"$bE\"$bPCOpVC%\021^C_VVT\021NZ_\0215OV\024COO!Op\021OC\022\027\fE\"$bE\"$blCV\021\"_VT_\021ZVT\021y_TDT\021D!\v\021sC\022\027_\021D!\021p_\027_O\f\021dZ_^^_Z\022\027T\021mZON_VT\021N!\021Ng\vT\021C!\022\027\021m\vZV\022\027_\021U^_ZN!Op\021ZO\021N_ZO_%\021\t\024ZOT\fE\"$bAC\v^_ \021\031Z\vN\021NZ\v\021mg^p_O\f\021(_\027_\021_ZOmC\022\027\021^gV\f")
          }
        }, function(action)
          _kvkDf.Active = true
          _kvkDf.Visible = true
          _OCIO.Active = true
          _OCIO.Visible = true
          _bxfl.Active = true
          _bxfl.Visible = true
          _vKBT1:RequestSync()
        end)
      end
    end
  })
end
function _0THsQ:OnEnter()
  _pOGCA = _Tho("&rj6V4")
  __rQd.Active = false
  _2o99.Active = true
  _Gr3S.Active = true
  _Gr3S.Visible = false
  _IP9n.Active = true
  _IP9n.Visible = false
  _Qst.Active = true
  _Qst.Visible = false
  _0THsQ.Active = false
  _OCIO.Complete = true
  if _Vt1 == true then
    _Urwigo.OldDialog({
      {
        Text = _Tho("\127ON^Z\022\027\f\021l!\021\027CVT\021N_O\0216Cm_O\021_\v\v_Z\022\027T\f\021\015_TDT\021%!VV\021_V\021OZ\022\027T\021%_\027\v\021\031_ZT\021V_ZO\f\021l!\021I_\vV!\022\027VT\021NZ\022\027\021D!\021_\vZOO_\vO\026\021C\019_\v\021N!\021%_\veVT\021NZ_\021RC\022\027\031Z\ve!Op_O\021N_V\021Ug%CV\f\021s_^\022\027_\021$Z\022\027T!Op\021Vg^^T_\021Z\022\027\021_ZOV\022\027^Cp_O\021!%\021D!\v\021\"\v!_\022e_\021D!\021p_^COp_O<E\"$bE\"$bs_OO\021N!\021NZ\022\027\021_OTV\022\027Z_N_O\021\027CVT\026\021NCOO\021p_\027\021^gV\f\021\003O\019V\024\018\a!%\021(^!_\022e\021pZ\019T\021_V\021yC\021O!\v\021D\031_Z\021$Z\022\027T!Op_O\021D!\v\0215!V\031C\027^\026\021N_OO\021IgO\021s_VT_O\021eg%%VT\021N!\021!ON\021$Z\022\027T!Op\021\t!_N_O\021^Z_pT\021sCVV_\v\f")
      }
    })
  else
    _Urwigo.OldDialog({
      {
        Text = _Tho("\127ON^Z\022\027\f\021l!\021\027CVT\021N_O\0216Cm_O\021_\v\v_Z\022\027T\f\021\015_TDT\021%!VV\021_V\021OZ\022\027T\021%_\027\v\021\031_ZT\021V_ZO\f\021l!\021I_\vV!\022\027VT\021NZ\022\027\021D!\021_\vZOO_\vO\026\021C\019_\v\021N!\021%_\veVT\021NZ_\021RC\022\027\031Z\ve!Op_O\021N_V\021Ug%CV\f\021s_^\022\027_\021$Z\022\027T!Op\021Vg^^T_\021Z\022\027\021_ZOV\022\027^Cp_O\021!%\021D!\v\021\"\v!_\022e_\021D!\021p_^COp_O<E\"$bE\"$bs_OO\021N!\021NZ\022\027\021_OTV\022\027Z_N_O\021\027CVT\026\021NCOO\021p_\027\021^gV\f\021\003O\019V\024\018\a!%\021(^!_\022e\021pZ\019T\021_V\021yC\021O!\v\021D\031_Z\021$Z\022\027T!Op_O\021D!\v\0215!V\031C\027^\026\021N_OO\021IgO\021s_VT_O\021eg%%VT\021N!\021!ON\021$Z\022\027T!Op\021\t!_N_O\021^Z_pT\021sCVV_\v\f")
      },
      {
        Text = _Tho("5^V\021N!\021N_ZO_O\021\"^Z\022e\021!_\019_\v\021NCV\021sCVV_\v\021V\022\027\031_Zm_O\021^C_VVT\026\021_\v\019^Z\022eVT\021N!\021AC\v^_ V\021\"ggT\f\021\127\v\021\031ZOeT\021NZ\v\021D!\021!ON\021%C\022\027T\021_ZO\021\a_Z\022\027_O\021g\019\021C^^_V\021KU\021ZVT\fE\"$bE\"$bl!\021pZ\019TV\021Z\027%\021D!\021I_\vVT_\027_O\026\021NCVV\021C^^_V\021Z%\021PgT\021ZVT\fE\"$bE\"$blC\019_Z\021N_OeVT\021N!\021NZ\v\028E\"$bsC\027\vV\022\027_ZO^Z\022\027\021\031!\vN_\021AC\v^_ \021N!\v\022\027\021%_ZO_O\021UC%\024m\021%ZT\021N_O\021\ag%\019Z_V\021C!m%_\veVC%\021!ON\021\031g^^T_\021%Z\v\021D!\0216Z^m_\021_Z^_O\f\021E\"$bE\"$bl!\021m!_\027^VT\021NZ\022\027\021p!T\f\021\"ZVT\021N!\021C^Vg\021Ng\022\027\021OZ\022\027T\021pCOD\021C^^_ZO\021C!m\021NZ\022\027\021p_VT_^^T\021ZO\021\ag%\019Z_^CON\f")
      }
    })
  end
end
function _Gr3S:OnEnter()
  _pOGCA = _Tho("&(\v/\t")
  _0THsQ.Active = false
  _IP9n.Active = false
  _Qst.Active = false
  _Gr3S.Active = false
  if _Vt1 == true then
    _2o99.Active = false
    _Gr3S.Active = false
    _tM3Xb.Active = false
    _Rdw0 = 4
    _vKBT1:RequestSync()
    Wherigo.PlayAudio(_q_3)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021\027CVT\021NZ_\021\"\v!_\022e_\021mCVT\021_\v\v_Z\022\027T\026\021NC\021\027g_\vVT\021N!\021\024^g_TD^Z\022\027\021NCV\021l!\v\022\027^CN_O\021IgO\021(_\031_\027\v_O\fE\"$b\127ZO_\021TZ_m_\021AC_OO_\vVTZ%%_\021\019_mZ_\027^T\021NZ\v\028\021Y$!OT_\v\021C!m\021NZ_\021UOZ_\021!ON\021,\v_VV_\021\027C^T_O\fY"),
        Media = _lgCl
      },
      {
        Text = _Tho("dgO\021\027ZOT_O\021OC_\027_\vT\021VZ\022\027\021_ZO_\0218_\vVgO\021!ON\021_\027_\021N!\021\v_C^ZVZ_\vVT\026\021\031CV\021\027Z_\v\021_Zp_OT^Z\022\027\021\024CVVZ_\vT\026\021\019ZVT\021N!\021%ZT\021UC\019_^\019ZON_\vO\021CO\021\"_ZO_O\021!ON\0216C_ON_O\021p_m_VV_^T\f"),
        Media = _lgCl
      },
      {
        Text = _Tho("d_\vD\031_Zm_^T\021I_\vV!\022\027T\021N!\021NZ_\021\tZT!CT!ZgO\021D!\021\v_TT_O\028\021E\"$bY6_ \021P_!T_\026\021%C\022\027T\021e_ZO_O\021,_\027^_\v\026\021\031Z\v\021eg_OO_O\021!OV\021Ng\022\027\021VZ\022\027_\v\021_ZOZp_O\f"),
        Media = _38c
      },
      {
        Text = _Tho("\127V\021_\vV\022\027C^^T\021O!\v\021\027g^^_V\021(_^C_\022\027T_\v\fE\"$bE\"$bYsCV\021eCOOVT\021N!\021!OV\021V\022\027gO\021\019Z_T_O\026\021\031CV\021\031Z\v\021NZ\v\021OZ\022\027T\021_ZOmC\022\027\021C\019O_\027%_O\021eg_OO_O<Y"),
        Media = _lgCl
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_GT1f7)
      end)
    end)
  else
    Wherigo.PlayAudio(_q_3)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021\027CVT\021NZ_\021\"\v!_\022e_\021mCVT\021_\v\v_Z\022\027T\026\021NC\021\027g_\vVT\021N!\021\024^g_TD^Z\022\027\021NCV\021l!\v\022\027^CN_O\021IgO\021(_\031_\027\v_O\fE\"$b\127ZO_\021TZ_m_\021AC_OO_\vVTZ%%_\021\019_mZ_\027^T\021NZ\v\028\021Y$!OT_\v\021C!m\021NZ_\021UOZ_\021!ON\021,\v_VV_\021\027C^T_O\fY"),
        Media = _lgCl
      },
      {
        Text = _Tho("dgO\021\027ZOT_O\021OC_\027_\vT\021VZ\022\027\021_ZO_\0218_\vVgO\021!ON\021_\027_\021N!\021\v_C^ZVZ_\vVT\026\021\031CV\021\027Z_\v\021_Zp_OT^Z\022\027\021\024CVVZ_\vT\026\021\019ZVT\021N!\021%ZT\021UC\019_^\019ZON_\vO\021CO\021\"_ZO_O\021!ON\0216C_ON_O\021p_m_VV_^T\f"),
        Media = _lgCl
      },
      {
        Text = _Tho("d_\vD\031_Zm_^T\021I_\vV!\022\027T\021N!\021NZ_\021\tZT!CT!ZgO\021D!\021\v_TT_O\028\021E\"$bY6_ \021P_!T_\026\021%C\022\027T\021e_ZO_O\021,_\027^_\v\026\021\031Z\v\021eg_OO_O\021!OV\021Ng\022\027\021VZ\022\027_\v\021_ZOZp_O\f"),
        Media = _38c
      },
      {
        Text = _Tho("\127V\021_\vV\022\027C^^T\021O!\v\021\027g^^_V\021(_^C_\022\027T_\v\fE\"$bE\"$bYsCV\021eCOOVT\021N!\021!OV\021V\022\027gO\021\019Z_T_O\026\021\031CV\021\031Z\v\021NZ\v\021OZ\022\027T\021_ZOmC\022\027\021C\019O_\027%_O\021eg_OO_O<YE\"$bE\"$bYPgV\021\"g\019\026\021Tg_T_\021N_O\021e^_ZO_O\021\t\022\027_ZVV_\vYE\"$bE\"$bd_\vNC%%T\026\021N!\021\019ZVT\021_\022\027T\021C%\0215\vV\022\027\f"),
        Media = _lgCl
      },
      {
        Text = _Tho("\"g\019\021\031Z^^\021p_\vCN_\021D!%\021mZOC^_O\021\t\022\027^Cp\021C!V\027g^_O\026\021NC\021_\vTg_OT\021_ZO\021NZ\v\021\031g\027^\021\019_eCOOT_V\021(_\vC_!V\022\027\f"),
        Media = _lgCl
      }
    }, function(action)
      Wherigo.PlayAudio(_5WU8)
      _Urwigo.Dialog(false, {
        {
          Text = _Tho("l!\021eO_ZmVT\021NZ_\0215!p_O\021D!VC%%_O\021!ON\021D!\022eVT\026\021C\019_\v\021OZ\022\027TV\021\024CVVZ_\vT\f\021E\"$b\127V\021mg^p_O\021/\021\031_ZT_\v_\021\t\022\027!_VV_\021!ON\021NCOO\021ZVT\021_V\021VTZ^^\fE\"$bE\"$bPCOpVC%\021g_mmO_VT\021N!\021NZ_\0215!p_O\021!ON\021VZ_\027VT\021N_ZO_\0218_ZOZp_\v\021C!m\021N_%\021\"gN_O\021^Z_p_O\f")
        },
        {
          Text = (_Tho("A_OV\022\027\021") .. Player.Name) .. _Tho("\026\021NZ\022\027\021eCOO\021%CO\021C\019_\v\021C!\022\027\021OZ\022\027T\021C^^_ZO_\021^CVV_O\f"),
          Media = _ARh
        },
        {
          Text = _Tho("l!\021\019ZVT\021mCVV!OpV^gV\f\021\015_TDT\021\027CT\021NZ\v\021AC\v^_ \021V\022\027gO\021D!%\021D\031_ZT_O\021AC^\021NZ_\0216C!T\021p_\v_TT_T\fE\"$bd_\vN!TDT\021m\vCpVT\021N!\021AC\v^_ \028\021YsZ_Vg\021\019ZVT\021N!\021\027Z_\v<Y"),
          Media = _38c
        },
        {
          Text = _Tho("RCyC\026\021!OT_O\021C%\0216Cm_O\021\027C\019_\021Z\022\027\021p_V_\027_O\026\021NCVV\021N!\021N_O\0216C!\024T\031_p\021_ZOV\022\027^!pVT\f\0216CVT\021N!\021NZ\022\027\021OZ\022\027T\021CO\021%_ZO_\021sg\vT_\021_\vZOO_\vT<E\"$bE\"$b~\022\027\021\027C\019_\021NZ\v\021e^C\v\021p_VCpT\026\021\019^_Z\019_\021C\019V_ZTV\021N_V\021(\v!_OVT\v_Zm_OV\026\021\031C\v!%\021OZ%%VT\021N!\021OZ\022\027T\021\v_\022\027TV\021gN_\v\021^ZOeV\021N_O\021(_\027\031_p<"),
          Media = _ARh
        },
        {
          Text = _Tho("\t\022\027O_^^\021V!\022\027VT\021N!\021OC\022\027\021_ZO_\v\0215!V\v_N_\f"),
          Media = _38c
        }
      }, function(action)
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_C03bm)
        end)
      end)
    end)
  end
end
function _tM3Xb:OnEnter()
  _pOGCA = _Tho("&TA/\n\019")
  _tM3Xb.Active = false
  _Gr3S.Active = false
  _2o99.Active = false
  _bxfl.Complete = true
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("6C^^g\021,\v_%N_\v\026\021^CVV\021N_ZO_\021sCmm_\021!OT_O\026\021NZ\v\021N\vg\027T\021e_ZO_\021(_mC\027\v\f"),
      Media = _WZTq
    },
    {
      Text = _Tho("2l!\021\019ZVT\021OC\022\027\021N_%\021p_\vCN_\021_\v^_\019T_O\021%ZVVT\vC!ZV\022\027\fWE\"$bE\"$b6%\026\021Z\022\027\021\027C\019_\021%_ZO_\021sCmm_\021^Z_\019_\v\021V\022\027!VV\019_\v_ZT\fE\"$b~\022\027\021\027C\019_\021_ZO_\021,\vCp_\026\021\027Z_\v\021CO\021NZ_V_\v\021\"\v!_\022e_\021Vg^^\021N_\v\021\f\f\f"),
      Media = _38c
    },
    {
      Text = _Tho("\f\f\f\0215!VV_O\024gVT_O\021N_\v\0215\v%__\021^Z_p_O\f\021\003O\019V\024\018(^!_\022e\031!OV\022\027\026\021\027CVT\021Z\027O\021p_\vCN_\021p_m!ON_O\f"),
      Media = _WZTq
    },
    {
      Text = _Tho("K\027\021%_ZO\021(gTT\026\021_ON^Z\022\027\f\0216C\019T\021Z\027T\021IZ_^_\021\aZIZ^ZVT_O\021C!mp_Og%%_O<\021~\022\027\021V!\022\027_\021%_ZO_\021,C%Z^Z_\f\021UCOOVT\021N!\021%Z\v\021VCp_O\021\031g\021Z\022\027\021NCV\021PCp_\v\021mZON_<"),
      Media = _38c
    },
    {
      Text = _Tho("\015C\026\021\031Z\v\021\024^CTD_O\021C!V\021C^^_O\021RC_\027T_O\f\021\a!\v\021\a_ZT\021I_\vV!\022\027_O\021\031Z\v\021_ZO_O\021,^!\022\027Teg\v\vZNg\v\021\vC!V\021C!V\021N_\v\021\tTCNT\021C!mD!\019C!_O\f\021~\022\027\021\031_\vN_\021NZ\022\027\021Ng\vT\027ZO\021\019\vZOp_O\f\021l_\v\021s_p\021ZVT\021OZ\022\027T\021!Op_mC_\027\v^Z\022\027\f\021s_OO\021\031Z\v\021IgO\021}OTgT_O\021COp_p\vZmm_O\021\031_\vN_O\026\021NCOO\021\v_OO_\021%Z\v\021\027ZOT_\v\027_\v\f\021(^C!\019_\021%Z\v\026\021\027Z_\v\021ZO\021N_O\0216C_!V_\vV\022\027^!\022\027T_O\021ZVT\021NCV\021NZ_\021\019_VT_\021Ag_p^Z\022\027e_ZT\021NZ_\021\031Z\v\021\027C\019_O\fE\"$b}_\019\vZp_OV\026\021%_ZO\021RC%_\021ZVT\021sCOp\f"),
      Media = _WZTq
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_n4j)
    end)
  end)
end
function _svJ:OnEnter()
  local _Urwigo_Date = os.date("*t")
  _pOGCA = _Tho("&VI\015")
  _E8GOf = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _uZYu()
  kontaktmann_zone.Active = false
  _svJ.Active = false
  _HXw.Visible = true
  _wZsf5.Active = true
  _6nMS.Visible = true
  _PnxoO = true
  _NNR.Visible = true
  _NNR.Commands._BY5.Enabled = true
  _vKBT1.Complete = true
  _ucz.Complete = true
  _vKBT1:RequestSync()
  _Urwigo.OldDialog({
    {
      Text = _Tho("l!\021\027CVT\021NCV\021PCp_\v\021_\v\v_Z\022\027T\f\021\tgmg\vT\021\019_pZOOVT\021N!\021%ZT\021N_\v\021\t!\022\027_\021OC\022\027\021N_ZO_\v\021,C%Z^Z_\f\0218^g_TD^Z\022\027\021_\vTg_OT\021\027ZOT_\v\021NZ\v\021_ZO\021\t\022\027\v_Z\021!ON\021N!\021N\v_\027VT\021NZ\022\027\021!%\021\f\f\f")
    },
    {
      Text = (_Tho("K\027\021%_ZO\021(gTT\026\021") .. Player.Name) .. _Tho("\026\021N!\021^_\019VT\026\021N!\021^_\019VT\fE\"$bE\"$bl!\021\v_OOVT\021C!m\021N_ZO_\021,\vC!\021D!\021!ON\021\027ZOT_\v\021Z\027\v\021_\v\019^Z\022eVT\021N!\021\f\f\f"),
      Media = _Y_s
    },
    {
      Text = _Tho("\f\f\f\021N_ZO_\021jg\022\027T_\v\fE\"$bE\"$b\tZ_\021\v!mT\021NZ\022\027\021pCOD\021^C!T\028\021Y8C\024C\026\0218C\024C\fY\021\127V\021T!T\021Vg\021p!T\021Z\027\v_\021\tTZ%%_\021D!\021\027g_\v_O\fE\"$bE\"$blZ_\0215OV\024COO!Op\021N_\v\021^_TDT_O\021\tT!ON_O\021mC_^^T\021IgO\021NZ\v\f\021l!\021mC_OpVT\021V\022\027\v_\022e^Z\022\027\021CO\021D!\021\027_!^_O\f"),
      Media = _iuM
    },
    {
      Text = _Tho("l!\021V\022\027^Z_VVT\021N_ZO_\021,C%Z^Z_\021m_VT\021!ON\021!_\019_\vp^!_\022e^Z\022\027\021ZO\021NZ_\0215\v%_\f\021~\027\v\021V_ZN\021\031Z_N_\v\021I_\v_ZOT\026\021y_TDT\021eCOO\021OZ\022\027TV\021%_\027\v\021\024CVVZ_\v_O\017E\"$bE\"$bKN_\v\021Ng\022\027<\021~O\021\ag%\019Z_mZ^%_O\021!_\019_\v^_\019T\021_Zp_OT^Z\022\027\021OZ_\021_ZO_\v\026\021NC\021p_\027_O\021Z%%_\v\021C^^_\021N\vC!m\f"),
      Media = _PNS
    },
    {
      Text = _Tho("6_\vD^Z\022\027_O\021(^!_\022e\031!OV\022\027\f\021lZ_\021Ugg\vNZOCT_O\026\021N_ZO_\021\127\v\v!Op_OV\022\027CmT_O\021!ON\021N_O\021,\v_ZV\022\027C^T\022gN_\021mZON_VT\021N!\021Z%\021~OI_OTC\v\fE\"$bE\"$blZ_\0218!%\024p!O\021!ON\021NZ_\0215\002T\021NC\vmVT\021N!\021\019_\027C^T_O\f"),
      Media = _ENB
    }
  })
end
function _P4V:OnEnter()
  _pOGCA = _Tho("&8Jd")
  _epk.Type = "Countdown"
  _epk.Duration = 10
  _epk:Stop()
  horde_zone.Visible = false
  _P4V.Active = false
  _svJ.Active = true
  _svJ.Visible = true
  _wrIo.Active = true
  _wrIo.Visible = false
  _ucz.Active = true
  _ucz.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("l!\021\v_OOVT\021\003O\019V\024\018!ON\021\v_OOVT\021!ON\021\v_OOVT\021\031Z_\021_ZO\021d_\v\v!_\022eT_\v\f\021\tg\021e!\vD\021Ig\v\021N_%\021\aZ_^\021\031Z^^VT\021N!\021OZ\022\027T\021%_\027\v\021N\vC!m\021p_\027_O\f\021AZT\021_ZO_%\021p_\031CpT_O\0216_\022\027TV\024\v!Op\021V\024\vZOpVT\021N!\021ZO\021NCV\021A('R_VT\f\021")
    }
  }, function(action)
    Wherigo.PlayAudio(_XkOXn)
    _Urwigo.OldDialog({
      {
        Text = _Tho("lZ_\021\tg^NCT_O\021\019C^^_\vO\021Vgmg\vT\021C!V\021C^^_O\021$g\027\v_O\f\021l!\021\019ZVT\021N_OOg\022\027\021V\022\027\031_\v\021\019__ZON\v!\022eT\026\021%ZT\021\031_^\022\027_\v\0218\vCDZVZgO\021VZ_\021NZ_\021Ug_\024m_\021_\v\031ZV\022\027_O\f\021E\"$bRC\022\027\021\031_OZp_O\021\t_e!ON_O\021ZVT\021C^^_V\021Ig\v\019_Z\f\021lZ_\0216g\vN_\021ZVT\021TgT\026\021\031_OO\021%CO\021NCV\021Vg\021O_OO_O\021eCOO\f\f")
      },
      {
        Text = _Tho("RZ\022\027T\021V\022\027^_\022\027T\026\021\027C_TT_\021OZ\022\027T\021p_NC\022\027T\026\021NCVV\021N!\021_V\021Og\022\027\021V\022\027CmmVT\fE\"$b\015_TDT\021eCOO\021NZ\v\021OZ\022\027TV\021%_\027\v\021\024CVVZ_\v_O\f\021(_\027_\021D!%\021PCp_\v\021N!\v\022\027\021N_O\021l!\v\022\027pCOp\021$Z\022\027T!Op\021\t!_N_O\fE\"$bdZ_^^_Z\022\027T\021mZON_VT\021N!\021Ng\vT\021_ON^Z\022\027\021\031gOC\022\027\021N!\021V!\022\027VT\f"),
        Media = _WZTq
      },
      {
        Text = _Tho("lCOe_\021sCOp\f\021ACO\021VZ_\027T\021VZ\022\027\026\021^CVV\021NZ\022\027\021OZ\022\027T\021\019_ZVV_O\f"),
        Media = _38c
      }
    })
  end)
end
function _6bj:OnEnter()
  _pOGCA = _Tho("&\r\019y")
  _Urwigo.MessageBox({
    Text = _Tho("6Z_\v\021^Z_pT\021NCV\021Pgp\019!\022\027\021N_\v\021}OTgT_OE\"$bE\"$b\"ZTT_\021OZ\022\027T\021CO\021N_\v\021l_eg\021DZ_\027_O\017"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_uRt)
        end)
      end
    end
  })
end
function _wZsf5:OnEnter()
  _pOGCA = _Tho("&\031\aVmH")
  _Urwigo.MessageBox({
    Text = _Tho("6Z_\v\021^Z_pT\021NCV\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O\fE\"$bE\"$b\"ZTT_\021OZ\022\027T\021CO\021N_\v\021l_eg\021DZ_\027_O\017\021\\C\022\027_\021^Z_pT\021\027ZOT_\v\021N_%\021\tT_ZO\f"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_uRt)
        end)
      end
    end
  })
end
function _2o99:OnEnter()
  _pOGCA = _Tho("&zgGG")
  _Urwigo.OldDialog({
    {
      Text = _Tho("l!\021\027CVT\021NZ\022\027\021m!_\v\021N_O\021mC^V\022\027_O\021s_p\021_OTV\022\027Z_N_O\fE\"$bE\"$bPZ_V\021NZ\v\021Ng\022\027\021Og\022\027%C^\021NCV\021RgTZD\019!\022\027\021N!\v\022\027\f")
    }
  })
end
function _2o99:OnExit()
  _pOGCA = _Tho("&zgGG")
  _2o99.Active = false
end
function _IP9n:OnEnter()
  _pOGCA = _Tho("&~8GO")
  _Gr3S.Active = false
  _Qst.Active = false
  _IP9n.Active = false
  if _Vt1 == true then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("sC\027OVZOO\017\021l!\021\019ZVT\021_ZO\021eOC^^\027C\vT_\v\021j \024\f\021E\"$bE\"$bl!\021\027CVT\021C!m\021NZ_\021sg\vT_\021IgO\021AC\v^_ \021p_\027g_\vT\021!ON\021\019ZVT\021N_O\0216ZOT_\v\027C^T\021C!m\021N_%\021(\v!_OVT\v_Zm_O\021!%pCOp_O\f\021(^!_\022e\021p_\027C\019T\026\021N_O\021AC\v^_ \021ZVT\021N_ZO_T\031_p_O\021p_VTg\v\019_O\021!ON\021\027C_TT_\021NZ\022\027\021y_TDT\021\027Z_\v\021C^V\021\ag%\019Z_\021COp_mC^^_O\021!ON\021p_Tg_T_T\fE\"$bE\"$blZ_\021!OVZ\022\027\019C\v_\021\agO_\021Y6ZOT_\v\027C^TY\021\031!\vN_\021N_CeTZIZ_\vT\021!ON\021N!\021eCOOVT\021\031_ZT_\v\021D!\v\021\"\v!_\022e_\021p_\027_O\f")
      }
    }, function(action)
      _tM3Xb.Active = true
      _tM3Xb.Visible = false
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("sC\027OVZOO\017\021l!\021\019ZVT\021_ZO\021eOC^^\027C\vT_\v\021j \024\f\021E\"$bE\"$bl!\021\027CVT\021C!m\021NZ_\021sg\vT_\021IgO\021AC\v^_ \021p_\027g_\vT\021!ON\021\019ZVT\021N_O\0216ZOT_\v\027C^T\021C!m\021N_%\021(\v!_OVT\v_Zm_O\021!%pCOp_O\f\021E\"$bAC\v^_ \021\031C_\v_\021NZ\v\021C^^_\vNZOpV\021D!\v\0216Z^m_\021p__Z^T\fE\"$bE\"$b6C_TT_VT\021N!\021AC\v^_ \021NC%C^V\021I_\v\vCT_O\026\021NCOO\021\031C_\vVT\021N!\021Z%\0216ZOT_\v\027C^T\021p_VTg\v\019_O\021!ON\021O!\v\021NZ_\021\t_ZT_O\031_p_\021\031C_\v_O\021N_ZO_\021_ZODZp_\021Ag_p^Z\022\027e_ZT\021p_\031_V_O\021D!\021!_\019_\v^_\019_O\f\021E\"$bE\"$bE\"$blZ_\021!OVZ\022\027\019C\v_\021\agO_\021Y6ZOT_\v\027C^TY\021\031!\vN_\021N_CeTZIZ_\vT\021!ON\021N!\021eCOOVT\021\031_ZT_\v\021D!\v\021\"\v!_\022e_\021p_\027_O\f")
      }
    }, function(action)
      _tM3Xb.Active = true
      _tM3Xb.Visible = false
    end)
  end
end
function _Qst:OnEnter()
  _pOGCA = _Tho("&4VT")
  _Gr3S.Active = false
  _Qst.Active = false
  _IP9n.Active = false
  if _Vt1 == true then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("sC\027OVZOO\017\021l!\021\019ZVT\021_ZO\021eOC^^\027C\vT_\v\021j \024\f\021E\"$bE\"$bl!\021\027CVT\021C!m\021NZ_\021sg\vT_\021IgO\021AC\v^_ \021p_\027g_\vT\021!ON\021\019ZVT\021N_O\0216ZOT_\v\027C^T\021C!m\021N_%\021(\v!_OVT\v_Zm_O\021!%pCOp_O\f\021(^!_\022e\021p_\027C\019T\026\021N_O\021AC\v^_ \021ZVT\021N_ZO_T\031_p_O\021p_VTg\v\019_O\021!ON\021\027C_TT_\021NZ\022\027\021y_TDT\021\027Z_\v\021C^V\021\ag%\019Z_\021COp_mC^^_O\021!ON\021p_Tg_T_T\fE\"$bE\"$blZ_\021!OVZ\022\027\019C\v_\021\agO_\021Y6ZOT_\v\027C^TY\021\031!\vN_\021N_CeTZIZ_\vT\021!ON\021N!\021eCOOVT\021\031_ZT_\v\021D!\v\021\"\v!_\022e_\021p_\027_O\f")
      }
    }, function(action)
      _tM3Xb.Active = true
      _tM3Xb.Visible = false
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("sC\027OVZOO\017\021l!\021\019ZVT\021_ZO\021eOC^^\027C\vT_\v\021j \024\f\021E\"$bE\"$bl!\021\027CVT\021C!m\021NZ_\021sg\vT_\021IgO\021AC\v^_ \021p_\027g_\vT\021!ON\021\019ZVT\021N_O\0216ZOT_\v\027C^T\021C!m\021N_%\021(\v!_OVT\v_Zm_O\021!%pCOp_O\f\021E\"$bAC\v^_ \021\031C_\v_\021NZ\v\021C^^_\vNZOpV\021D!\v\0216Z^m_\021p__Z^T\fE\"$bE\"$b6C_TT_VT\021N!\021AC\v^_ \021NC%C^V\021I_\v\vCT_O\026\021NCOO\021\031C_\vVT\021N!\021Z%\0216ZOT_\v\027C^T\021p_VTg\v\019_O\021!ON\021O!\v\021NZ_\021\t_ZT_O\031_p_\021\031C_\v_O\021N_ZO_\021_ZODZp_\021Ag_p^Z\022\027e_ZT\021p_\031_V_O\021D!\021!_\019_\v^_\019_O\f\021E\"$bE\"$bE\"$blZ_\021!OVZ\022\027\019C\v_\021\agO_\021Y6ZOT_\v\027C^TY\021\031!\vN_\021N_CeTZIZ_\vT\021!ON\021N!\021eCOOVT\021\031_ZT_\v\021D!\v\021\"\v!_\022e_\021p_\027_O\f")
      }
    }, function(action)
      _tM3Xb.Active = true
      _tM3Xb.Visible = false
    end)
  end
end
function _w8b8Z:OnEnter()
  _pOGCA = _Tho("&\0311\0191\a")
  _xaHsG.Active = false
  _IBsb.Active = false
  _uwkEr.Visible = true
  _w8b8Z.Active = false
  _HR3SQ = _Tho("$_p_^\021\b\028\021\t_Z\021^_ZV_\021ZO\021\ag%\019Z_^CON\017E\"$b'''E\"$b$_p_^\021z\028\021\"^_Z\019\021V\024g\vT^Z\022\027\021'\021\v_ZV_\021^_Z\022\027T\fE\"$b'''E\"$b\a_\vVTg_\v_\021NCV\021(_\027Z\vO\021N_\v\021}OTgT_O\f\021R!\v\021Vg\021eCOOVT\021N!\021VZ_\021C!m\027C^T_O\fE\"$b'''E\"$b\\Z\v\022C\021zrr\021A_T_\v\021g_VT^Z\022\027\021IgO\021\027Z_\v\021pZ\019T\021_V\021_ZO_O\021e^_ZO_O\0216Cm_O\f\021dgO\021Ng\vT\021C!V\021mg^pT\021%CO\021ZO\021Og_\vN^Z\022\027_\v\021$Z\022\027T!Op\021_ZO_%\021(\v!_OVT\v_Zm_O\021\019ZV\021%CO\021C!m\021_ZO_\021\"\v!_\022e_\021VTg_VVT\f\0215O\021NZ_V_%\0215!VV_O\024gVT_O\021\031C\vT_T\021_ZO\021UgOTCeT%COO\021!ON\021\019\vZOpT\021NZ\022\027\021NCOO\021ZOV\0215!mmCOp^Cp_\v\fE\"$b'''E\"$bl_\v\021s_p\021D!%\0215!VV_O\024gVT_O\021ZVT\021C^^_\vNZOpV\021p_mC_\027\v^Z\022\027\f\021lZ_\021VgDZC^_O\021\tT\v!eT!\v_O\021mC^^_O\021\vCVCOT\021C!V_ZOCON_\v\f\021\127V\021\031Z\vN\021p_%g\vN_T\021!ON\021p_\024^!_ON_\vT\f\021\127VV_O\026\021A_NZeC%_OT_\021!ON\021sCmm_O\026\021C^^_V\021ZVT\021\031_\vTIg^^\f\021\"^_Z\019_\021!O\019_NZOpT\021C\019V_ZTV\021N_V\0216C!\024T\031_p_V\021Ig%\0216Cm_O\021D!%\0215!VV_O\024gVT_O\fE\"$b'''E\"$blZ_\0215!mpC\019_\021pZ^T\021C^V\021p_^g_VT\026\021\031_OO\021N!\021NZ_\021Ug%\024CVV\vgV_\021\v_\022\027TV\021Ig%\021\127ZOpCOp\021mZON_VT\021!ON\021NCV\021NC\v!OT_\v\021\019_mZON^Z\022\027_\021sg\vT\021%ZT\021G\021\"!\022\027VTC\019_O\021Z%\021j!_\vV\022\027^gVV\021_ZOpZ\019VT\fE\"$b'''E\"$bdg\vO_\021C%\0216C!\024T\031_p\021pZ\019T\021_V\021Z%\021(_\019!_V\022\027\021_ZO_O\021p_VZ\022\027_\vT_O\021(!^^ZN_\022e_^\021%ZT\021_ZO_%\021p_\027_Z%_O\021\a!pCOp\021D!\v\021sC\022\027_\f\0215!m\021N_%\021(!^^ZN_\022e_^\021VT_\027T\021N_\v\021RC%_\021_ZO_\v\021N_!TV\022\027_O\021\tTCNT\f\021lZ_V\021ZVT\021NCV\0218CVV\031g\vT\f")
  if _Vt1 == true then
    _Urwigo.OldDialog({
      {
        Text = _Tho("l!\021\027CVT\021NZ_\0218g^ZD_Z\031C\022\027_\021_\v\v_Z\022\027T\026\021pCOD\021C^^_ZO\fE\"$bE\"$b}%\021ZO\021NZ_\021sC\022\027_\021D!\021p_^COp_O\026\021%!VVT\021N!\021N_O\021\a!pCOpV\022gN_\021_ZOp_\019_O\f\021l_O\021\027C\019T\021Z\027\v\021m\v!_\027_\v\021CO\021N_\v\0218g^ZD_Z\031C\022\027_\021I_\vVT_\022eT\026\021m!_\v\021C^^_\021,C_^^_\f\021E\"$bE\"$bl!\021\027gmmVT\021ZOVTC_ONZp\026\021NCV\021NZ_\021RgTVT\vg%I_\vVg\vp!Op\021Og\022\027\021ZOTCeT\021ZVT\f\021\tgOVT\021\027_ZVVT\021_V\021OC\022\027\0216C!V_\021^C!m_O\021!ON\021N_O\021\t\022\027^!_VV_^\021\027g^_O\fE\"$bE\"$blZ_\0215!mpC\019_\021pZ^T\021C^V\021p_^g_VT\026\021\031_OO\021N!\021NZ_\021Ug%\024CVV\vgV_\021\v_\022\027TV\021Ig%\021\127ZOpCOp\021mZON_VT\021!ON\021NCV\021NC\v!OT_\v\021\019_mZON^Z\022\027_\021sg\vT\021%ZT\021G\021\"!\022\027VTC\019_O\021Z%\021j!_\vV\022\027^gVV\021_ZOpZ\019VT\f"),
        Media = _pPdg
      },
      {
        Text = _Tho("5^T_\vOCTZI_\v\021Pg_V!OpV\031_p\028E\"$blCV\0216C!V\021ZVT\021_ZO\021,\v_ZD_ZT\022^!\019\f\021\a!\021N_O\021K_mmO!OpVD_ZT_O\021\019ZTT_\021OZ\022\027T\021C%\0216C!V\021V!\022\027_O\f\021E\"$bE\"$bAg\026\021lg\026\021\tC\028\021\bJ'zr\021}\027\vE\"$blZ\026\021AZ\028\021\bJ'z\b\021}\027\vE\"$b,\v\028\021\bH'zr\021}\027\vE\"$bE\"$bdg\vO_\021C%\0216C!\024T\031_p\021pZ\019T\021_V\021Z%\021(_\019!_V\022\027\021_ZO_O\021p_VZ\022\027_\vT_O\021(!^^ZN_\022e_^\021%ZT\021_ZO_%\021p_\027_Z%_O\021\a!pCOp\021D!\v\021sC\022\027_\f\0215!m\021N_%\021(!^^ZN_\022e_^\021VT_\027T\021N_\v\021RC%_\021_ZO_\v\021N_!TV\022\027_O\021\tTCNT\f\021lZ_V\021ZVT\021NCV\0218CVV\031g\vT\f")
      }
    })
  else
    _Hqto:MoveTo(_rh69)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("~\027\v\021\027C\019T\021\019_ZN_\021NZ_\0218g^ZD_Z\031C\022\027_\021_\v\v_Z\022\027T\fE\"$bE\"$b}%\021ZO\021NZ_\021sC\022\027_\021D!\021p_^COp_O\026\021%!VVT\021N!\021N_O\021\a!pCOpV\022gN_\021_ZOp_\019_O\f\021l_O\021\027C\019T\021Z\027\v\021m\v!_\027_\v\021CO\021N_\v\0218g^ZD_Z\031C\022\027_\021I_\vVT_\022eT\026\021m!_\v\021C^^_\021,C_^^_\f\021E\"$bE\"$bl!\021\027gmmVT\021ZOVTC_ONZp\026\021NCV\021NZ_\021RgTVT\vg%I_\vVg\vp!Op\021Og\022\027\021ZOTCeT\021ZVT\f\021\tgOVT\021\027_ZVVT\021_V\021OC\022\027\0216C!V_\021^C!m_O\021!ON\021N_O\021\t\022\027^!_VV_^\021\027g^_O\fE\"$bE\"$blZ_\0215!mpC\019_\021pZ^T\021C^V\021p_^g_VT\026\021\031_OO\021N!\021NZ_\021Ug%\024CVV\vgV_\021\v_\022\027TV\021Ig%\021\127ZOpCOp\021mZON_VT\021!ON\021NCV\021NC\v!OT_\v\021\019_mZON^Z\022\027_\021sg\vT\021%ZT\021G\021\"!\022\027VTC\019_O\021Z%\021j!_\vV\022\027^gVV\021_ZOpZ\019VT\f"),
        Media = _pPdg
      },
      {
        Text = _Tho("5^T_\vOCTZI_\v\021Pg_V!OpV\031_p\028E\"$blCV\0216C!V\021ZVT\021_ZO\021,\v_ZD_ZT\022^!\019\f\021\a!\021N_O\021K_mmO!OpVD_ZT_O\021\019ZTT_\021OZ\022\027T\021C%\0216C!V\021V!\022\027_O\fE\"$bE\"$bAg\026\021lg\026\021\tC\028\021\bJ'zr\021}\027\vE\"$blZ\026\021AZ\028\021\bJ'z\b\021}\027\vE\"$b,\v\028\021\bH'zr\021}\027\vE\"$bE\"$bdg\vO_\021C%\0216C!\024T\031_p\021pZ\019T\021_V\021Z%\021(_\019!_V\022\027\021_ZO_O\021p_VZ\022\027_\vT_O\021(!^^ZN_\022e_^\021%ZT\021_ZO_%\021p_\027_Z%_O\021\a!pCOp\021D!\v\021sC\022\027_\f\0215!m\021N_%\021(!^^ZN_\022e_^\021VT_\027T\021N_\v\021RC%_\021_ZO_\v\021N_!TV\022\027_O\021\tTCNT\f\021lZ_V\021ZVT\021NCV\0218CVV\031g\vT\f")
      }
    }, function(action)
      _VRm:Start()
      print("Timer fuer marleys hilfe (code finden) gestartet")
    end)
  end
end
function _wrIo:OnEnter()
  _pOGCA = _Tho("&\031\v~g")
  _wrIo.Active = false
  Wherigo.PlayAudio(_xvzY)
  _Urwigo.MessageBox({
    Text = _Tho("l!\021eCOOVT\021V\022\027gO\021NZ_\021}%\vZVV_\021N_V\021PCp_\vV\021_\ve_OO_O\f\021l!\021\019_pZOOVT\021V\022\027O_^^_\v\021D!\021^C!m_O\f\021l_ZO\0216_\vD\021V\022\027^C_pT\021\031Z_\021I_\v\v!_\022eT\f")
  })
end
function _s1cI:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 58516 then
    _VRm:Stop()
    print("Timer fuer marleys hilfe (code finden) gestoppt")
    _nY8 = _Tho("l!\021\027CVT\021NZ\022\027\021m!_\v\021NCV\021j!_\vV\022\027^gVV\021_OTV\022\027Z_N_O\f\0216gmm_OT^Z\022\027\021\031C\v\021\tgOOTCp\021!ON\021N_\v\021\015!p_ON\022^!\019\021p_V\022\027^gVV_O\021\018'WE\"$b")
    if _Vt1 == true then
      _Urwigo.MessageBox({
        Text = _Tho("lCV\021j!_\vV\022\027^gVV\021V!%%T\021!ON\021N!\021_\v\027C_^VT\021N_O\021_\v\027gmmT_O\021\a!T\vZTT\f"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.Dialog(false, {
              {
                Text = _Tho("\a!_\vVT\021^C_!mVT\021N!\021D!\021N_ZO_%\021\t\024ZOT\021!ON\021DZ_\027VT\021NZ\v\021VC!\019_\v_\021U^C%gTT_O\021CO\f")
              },
              {
                Text = _Tho("lCOC\022\027\021p_\027TV\021D!\v\021sCmm_OeC%%_\v\f\021l!\021g_mmO_VT\021NZ_\021j!_\v\021!ON\021\f\f\f")
              },
              {
                Text = _Tho("\0155\\U8Kj\fE\"$bE\"$bl!\021_OTV\022\027_ZN_VT\021NZ\022\027\021m!_\v\021_ZO_\021\t\027gTp!O\021!ON\021y_N_\021A_Op_\021A!OZTZgO\f\021lZ_\021_\v\031ZV\022\027T\021y_N_O\021Ug\024m\021C!V\021OC_\027_\v_\v\021\127OTm_\vO!Op\021g\027O_\021p_OC!\021DZ_^_O\021D!\021%!_VV_O\f\021\127ZO_\021p!T_\021\127OTV\022\027_ZN!Op\f\021E\"$bE\"$b}ON\021y_TDT\021\vC!V\021\027Z_\v\f"),
                Media = _zV3F9
              }
            }, function(action)
              _wWT()
            end)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _Tho("lCV\021j!_\vV\022\027^gVV\021V!%%T\021!ON\021Z\027\v\021_\v\027C^T_T\021N_O\021_\v\027gmmT_O\021\a!T\vZTT\f"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.Dialog(false, {
              {
                Text = _Tho("\a!_\vVT\021^C_!mVT\021N!\021D!\021N_ZO_%\021\t\024ZOT\021!ON\021DZ_\027VT\021NZ\v\021VC!\019_\v_\021U^C%gTT_O\021CO\f")
              },
              {
                Text = _Tho("lCOC\022\027\021p_\027TV\021D!\v\021sCmm_OeC%%_\v\f\021l!\021g_mmO_VT\021NZ_\021j!_\v\021!ON\021\f\f\f")
              },
              {
                Text = _Tho("\0155\\U8Kj\fE\"$bE\"$bl!\021^C_VVT\021AC\v^_ \021m\v_Z_\021sC\027^\f\021,!_\v\021NZ\022\027\021\031C_\027^VT\021N!\021_ZO_\021\t\027gTp!O\021!ON\021y_N_\021A_Op_\021A!OZTZgO\f\021lZ_\021_\v\031ZV\022\027T\021y_N_O\021Ug\024m\021C!V\021OC_\027_\v_\v\021\127OTm_\vO!Op\021g\027O_\021p_OC!\021DZ_^_O\021D!\021%!_VV_O\f\021\127ZO_\021p!T_\021\127OTV\022\027_ZN!Op\f\021"),
                Media = _HqO9
              },
              {
                Text = _Tho("l!\021pZ\019TV\021AC\v^_ \021Og\022\027\021V\022\027O_^^\021_ZO_\021\127ZO\031_ZV!Op\021ZO\021N_O\021(_\019\vC!\022\027\021V_ZO_\v\021sCmm_\026\021NCOO\021\031Z\vN\021_V\021\a_ZT\021VZ\022\027\021IgO_ZOCON_\v\021D!\021I_\vC\019V\022\027Z_N_O\f"),
                Media = _HqO9
              },
              {
                Text = (_Tho("~\022\027\021NCOe_\021NZ\v\021") .. Player.Name) .. _Tho("\f\0216gmm_OT^Z\022\027\021mZON_VT\021N!\021N_ZO_\021,C%Z^Z_\f\021dZ_^\021(^!_\022e\f"),
                Media = _ARh
              },
              {
                Text = _Tho("lCOe_\021AC\v^_ \f\0218CVV\021p!T\021C!m\021NZ\022\027\021!ON\021N_ZO_O\021\tg\027O\021C!m\f"),
                Media = _38c
              }
            }, function(action)
              _wWT()
            end)
          end
        end
      })
    end
  else
    _Urwigo.MessageBox({
      Text = _Tho("5!m\021N_%\021lZV\024^C \021\019^ZOeT\021mg^p_ON_\v\021\t\022\027\vZmTD!p\028E\"$bE\"$b,5P\t\\6\127$\021\\Kl\127\f")
    })
  end
end
function _Ykm:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 9796 then
    _Urwigo.OldDialog({
      {
        Text = _Tho(",ZON\021Z\022\027\021p!T\f\021l!\021\031Z^^VT\021_V\021C^^_ZO\021V\022\027Cmm_O\f\021$Z\022\027TZp\021Vg\017")
      }
    })
  elseif _Urwigo.Hash(string.lower(input)) == 13166 then
    _Urwigo.OldDialog({
      {
        Text = _Tho("\t\022\027C!\021%C^\021\027Z_\v\021\v_\022\027TV\021O_\019_O\021N_\v\021j!_\v\f\0215O\021N_\v\021lC\022\027\vZOO_\021g\019_O\021C%\021,C^^\vg\027\v\021ZVT\021_ZO_\021!OV\022\027_ZO\019C\v_\021Ug%\024CVV\vgV_\021!ON\021NC\v!OT_\v\021VT_\027T\021NCV\021sg\vT\f")
      }
    })
  end
end
function _cMMH:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 27662 then
    _VRm:Stop()
    print("Timer fuer marleys hilfe (code finden) gestoppt")
    _nY8 = _Tho("l!\021\027CVT\021N_O\021(!^^Z\021p_\031C_\027^T\021!ON\021\vZ_\022\027VT\021N_V\027C^\019\021_ZO\021\019ZVV_^\021OC\022\027\021\t\022\027_ZVV_\fE\"$b")
    if _Vt1 == true then
      _Urwigo.MessageBox({
        Text = _Tho("}OT_\v\021N_%\021(!^^Z\021\027g_\vVT\021N!\021NCV\021D!\v!_\022emC\027\v_O\021N_\v\021$Z_p_^\021!ON\021N!\021_\v\027C_^VT\021N_O\021_\v\027gmmT_O\021\a!T\vZTT\fE\"$bE\"$bl_\v\021l_\022e_^\021ZVT\021Z\v\v_\021V\022\027\031_\v\021!ON\021N_\v\021(COp\021DZ_%^Z\022\027\021_Op\f\021l!\021D\031C_OpVT\021NZ\022\027\021N!\v\022\027\f\021\127V\021VTZOeT\021m!_\v\022\027T_\v^Z\022\027\021\027Z_\v\021!OT_O\f"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.Dialog(false, {
              {
                Text = _Tho("\a!_\vVT\021^C_!mVT\021N!\021D!\021N_ZO_%\021\t\024ZOT\021!ON\021DZ_\027VT\021NZ\v\021VC!\019_\v_\021U^C%gTT_O\021CO\f")
              },
              {
                Text = _Tho("lCOC\022\027\021p_\027TV\021D!\v\021sCmm_OeC%%_\v\f\021l!\021g_mmO_VT\021NZ_\021j!_\v\021!ON\021\f\f\f")
              },
              {
                Text = _Tho("\0155\\U8Kj\fE\"$bE\"$bl!\021_OTV\022\027_ZN_VT\021NZ\022\027\021m!_\v\021_ZO_\021\t\027gTp!O\021!ON\021y_N_\021A_Op_\021A!OZTZgO\f\021lZ_\021_\v\031ZV\022\027T\021y_N_O\021Ug\024m\021C!V\021OC_\027_\v_\v\021\127OTm_\vO!Op\021g\027O_\021p_OC!\021DZ_^_O\021D!\021%!_VV_O\f\021\127ZO_\021p!T_\021\127OTV\022\027_ZN!Op\f\021E\"$bE\"$b}ON\021y_TDT\021\vC!V\021\027Z_\v\f"),
                Media = _zV3F9
              }
            }, function(action)
              _wWT()
            end)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _Tho("}OT_\v\021N_%\021(!^^Z\021\027g_\vT\021Z\027\v\021NCV\021D!\v!_\022emC\027\v_O\021N_\v\021$Z_p_^\021!ON\021_\v\027C_^T_T\021N_O\021_\v\027gmmT_O\021\a!T\vZTT\fE\"$bE\"$bl_\v\021l_\022e_^\021ZVT\021Z\v\v_\021V\022\027\031_\v\026\021AC\v^_ \021p_\027T\021NZ\v\021D!\v\0216CON\f\021l_\v\021(COp\021ZVT\021DZ_%^Z\022\027\021_Op\021!ON\021_V\021VTZOeT\021m!_\v\022\027T_\v^Z\022\027\021\027Z_\v\021!OT_O\f"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.Dialog(false, {
              {
                Text = _Tho("\a!_\vVT\021^C_!mVT\021N!\021D!\021N_ZO_%\021\t\024ZOT\021!ON\021DZ_\027VT\021NZ\v\021VC!\019_\v_\021U^C%gTT_O\021CO\f")
              },
              {
                Text = _Tho("lCOC\022\027\021p_\027TV\021D!\v\021sCmm_OeC%%_\v\f\021l!\021g_mmO_VT\021NZ_\021j!_\v\021!ON\021\f\f\f")
              },
              {
                Text = _Tho("\0155\\U8Kj\fE\"$bE\"$bl!\021^C_VVT\021AC\v^_ \021m\v_Z_\021sC\027^\f\021,!_\v\021NZ\022\027\021\031C_\027^VT\021N!\021_ZO_\021\t\027gTp!O\021!ON\021y_N_\021A_Op_\021A!OZTZgO\f\021lZ_\021_\v\031ZV\022\027T\021y_N_O\021Ug\024m\021C!V\021OC_\027_\v_\v\021\127OTm_\vO!Op\021g\027O_\021p_OC!\021DZ_^_O\021D!\021%!_VV_O\f\021\127ZO_\021p!T_\021\127OTV\022\027_ZN!Op\f\021"),
                Media = _HqO9
              },
              {
                Text = _Tho("l!\021pZ\019TV\021AC\v^_ \021Og\022\027\021V\022\027O_^^\021_ZO_\021\127ZO\031_ZV!Op\021ZO\021N_O\021(_\019\vC!\022\027\021V_ZO_\v\021sCmm_\026\021NCOO\021\031Z\vN\021_V\021\a_ZT\021VZ\022\027\021IgO_ZOCON_\v\021D!\021I_\vC\019V\022\027Z_N_O\f"),
                Media = _HqO9
              },
              {
                Text = (_Tho("~\022\027\021NCOe_\021NZ\v\021") .. Player.Name) .. _Tho("\f\0216gmm_OT^Z\022\027\021mZON_VT\021N!\021N_ZO_\021,C%Z^Z_\f\021dZ_^\021(^!_\022e\f"),
                Media = _ARh
              },
              {
                Text = _Tho("lCOe_\021AC\v^_ \f\0218CVV\021p!T\021C!m\021NZ\022\027\021!ON\021N_ZO_O\021\tg\027O\021C!m\f"),
                Media = _38c
              }
            }, function(action)
              _wWT()
            end)
          end
        end
      })
    end
  else
    _Urwigo.MessageBox({
      Text = _Tho("5!m\021N_%\021lZV\024^C \021\019^ZOeT\021mg^p_ON_\v\021\t\022\027\vZmTD!p\028E\"$bE\"$b,5P\t\\6\127$\021\\Kl\127\f")
    })
  end
end
function _n4j:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 47760 then
    _4Vw = true
    _u_d = _Tho("l_ZO\021(_\027Z\vO\021m!OeTZgO_\vT\021T\vgTD\021Ug%C\021\027_\vIg\v\vCp_ON\026\021N_OO\021N!\021\027CVT\021NZ\v\021NZ_\021\ag%\019Z_^CON'$_p_^O\021p_%_\veT\f")
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("\t_\027\v\021p!T\f\021lC\021\031_\vN_\021Z\022\027\021\031g\027^\021OZ\022\027T\021Vg\021V\022\027O_^^\021\v_OO_O\021%!_VV_O\026\021NC\021N!\021NZ_\021$_p_^O\021D!%\021}_\019_\v^_\019_O\021I_\vZOO_\v^Z\022\027T\021\027CVT\fE\"$bE\"$b26ZO\031_ZV\028\021\"_Z\021N_\v\021mC^V\022\027_O\0215OT\031g\vT\021\031C_\v_\021sCOp\021\019_Z\021(_mC\027\v\021V\022\027O_^^_\v\021p_\vCOOTW"),
        Media = _WZTq
      },
      {
        Text = _Tho(",g^p_\021%Z\v\026\021Z\022\027\021p_\027_\021^gV\f"),
        Media = _WZTq
      }
    }, function(action)
      _ThHCZ()
    end)
  else
    _4Vw = false
    _u_d = _Tho("$_p_^O\021%_\ve_O\021ZVT\021OZ\022\027T\021N_ZO\021lZOp\026\021IZ_^^_Z\022\027T\021^CpV\021C!\022\027\021C%\021^COp_O\021Ug%C\f")
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("R_ZO\026\021^_ZN_\v\021OZ\022\027T\f\021s_OO\021_T\031CV\021!OT_\v\031_pV\021\024CVVZ_\vT\026\021NCOO\021\v_OO_\021Z\022\027\021\031Z_\021_ZO\021p_g_^T_\v\021\"^ZTD\f\021lC\021\031Z\vVT\021N!\021D!\021V_\027_O\021%!_VV_O\026\021\031Z_\021N!\021CO\021%Z\v\021N\vCO\021\019^_Z\019VT\fE\"$bE\"$b26ZO\031_ZV\028\021\"_Z\021N_\v\021\vZ\022\027TZp_O\0215OT\031g\vT\021\031C_\v_\021sCOp\021^COpVC%_\v\021p_\vCOOTW"),
        Media = _WZTq
      },
      {
        Text = _Tho(",g^p_\021%Z\v\026\021Z\022\027\021p_\027_\021^gV\f"),
        Media = _WZTq
      }
    }, function(action)
      _ThHCZ()
    end)
  end
end
function _C03bm:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if (_Urwigo.Hash(string.lower(input)) == 97 or _Urwigo.Hash(string.lower(input)) == 98) == true then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("5\022\027\021eg%%\026\021^CVV\021p!T\021V_ZO\f\021AC\v^_ \021p\vZOVT\021ZO\021VZ\022\027\021\027ZO_ZO\fE\"$b6CVT\021N!\021N_O\021\031_OZpVT_OV\021N_O\0215!VV_O\024gVT_O\021p_m!ON_O<"),
        Media = _ARh
      },
      {
        Text = _Tho("\015C\026\021V\022\027C!\026\021NC\021\027ZOT_O\021eCOO\021%CO\021NZ_\021\"\v!_\022e_\021V\022\027gO\021_\ve_OO_O\f\021PgV\021AC\v^_ \026\021eg%%\021%ZT\021%Z\v\021%ZT\f\021dZ_^^_Z\022\027T\021ZVT\021NCV\021NZ_\021$_TT!Op\f"),
        Media = _38c
      },
      {
        Text = _Tho("(_\027\021V\022\027gO\021%C^\021^gV\026\021Z\022\027\021%!VV\021%_ZO_O\021\tg\027O\021\027g^_O\f\021sZ\v\021V_\027_O\021!OV\021Z%\021PCp_\v\026\021\031_OO\021_V\021N_OO\021Og\022\027\021_\002ZVTZ_\vT\fE\"$bE\"$bAC\v^_ \021I_\vV\022\027\031ZON_T\021ZO\021$Z\022\027T!Op\0216Cm_O\f"),
        Media = _ARh
      }
    }, function(action)
      _tM3Xb.Active = true
      _tM3Xb.Visible = false
      _vKBT1:RequestSync()
    end)
  end
end
function _GT1f7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("lCIgO\021\019_VZTD_O\021\031Z\v\021\027Z_\v\021C^^_\021\v_Z\022\027^Z\022\027\fE\"$bE\"$bYPgV\021\"g\019\026\021Tg_T_\021N_O\021e^_ZO_O\021\t\022\027_ZVV_\vYE\"$bE\"$bd_\vNC%%T\026\021N!\021\019ZVT\021_\022\027T\021C%\0215\vV\022\027\f")
    },
    {
      Text = _Tho("\"g\019\021\031Z^^\021p_\vCN_\021D!%\021mZOC^_O\021\t\022\027^Cp\021C!V\027g^_O\026\021NC\021_\vTg_OT\021_ZO\021NZ\v\021\031g\027^\021\019_eCOOT_V\021(_\vC_!V\022\027\f"),
      Media = _lgCl
    }
  }, function(action)
    Wherigo.PlayAudio(_IrJu0)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("Ke\026\021P_!T_\026\021\031_p\021\027Z_\v\026\021\031Z\v\021eg%%_O\021OC\022\027\027_\v\021\031Z_N_\v\026\021\031_OO\021NZ_\021%ZT\021N_%\021\027Z_\v\021m_\vTZp\021VZON\f"),
        Media = _lgCl
      },
      {
        Text = _Tho("R_____ZO\026\021NCV\021eg_OOT\021Z\027\v\021OZ\022\027T\021%C\022\027_O\f\0216_^mT\021%Z\v\021Ng\022\021\f\021\f\021\f"),
        Media = _38c
      },
      {
        Text = _Tho("lZ_\0216g\vN_\021\027CT\021NZ\022\027\021_\v\v_Z\022\027T\fE\"$bE\"$b}OT_\v\021N_O\021\ag%\019Z_V\021_\ve_OOVT\021N!\021N_O\021I_\v\031CON_^T_O\021AC\v^_ \f\021E\"$bl!\021N_OeVT\021CO\021AC\v^_ \f\021AC\v^_ \026\021N_O\021N!\021D!\v!_\022e\021p_^CVV_O\021\027CVT\f\021E\"$bE\"$b\127\v\021ZVT\021N_\v\021\127\vVT_\021N_\v\021D!\019_ZVVT\f"),
        Media = __XYn
      }
    }, function(action)
      _KE2M()
    end)
  end)
end
function _uRt:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _Urwigo.MessageBox({
      Text = _Tho("5%\021\aC!O\026\021g\019_O\021ZO\021N_\v\021P!_\022e_\021C%\021AC!_\v\031_\ve\f")
    })
  else
    _Urwigo.MessageBox({
      Text = _Tho("(_OC!\026\021Vg\031_ZT\021eg%%TV\021Og\022\027\f\021~\022\027\021V\022\027Cmm\021NCV\021C!\022\027\021g\027O_\0216Z^m_\f")
    })
  end
end
function _epk:OnTick()
  if _lqy == 1 then
    horde_zone.Active = false
    entfernungHorde = move_zoneConstV(horde_zone, Player.ObjectLocation, vHorde, radiusHorde, formHorde)
    horde_zone.Active = true
    if entfernungHorde < radiusHorde then
      _lqy = 2
    end
  elseif _lqy == 2 then
    _Rdw0 = 1
    _VL8kU()
    _KE2M()
  end
end
function _7MixJ:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("\tTZ^^_\f\0215\019Vg^!T_\021\tTZ^^_\fE\"$bjZ_m\021Z%\021}OT_\v\019_\031!VVT_ZO\021I_\v%ZVVT\021N!\021NCV\021I_\vT\vC!T_\0218Z_\024_O\f\0215O\021\031CV\021_\vZOO_\vT\021NZ\022\027\021NZ_V_V\021(_\vC_!V\022\027\021O!\v<E\"$b~\vp_ON_T\031CV\021VTZ%%T\021\027Z_\v\021OZ\022\027T\fE\"$b")
    },
    {
      Text = (_Tho("l!\021D\031ZOpVT\021NZ\022\027\021_ZO_O\021e^C\v_O\021d_\vVTCON\021D!\021\019_eg%%_O\fE\"$bE\"$b\"55555AAA\fE\"$bE\"$b\127V\021m!_\027^T\021VZ\022\027\021CO\026\021C^V\021g\019\021p_\vCN_\021_ZO\021(!_T_\vD!p\021N!\v\022\027\021N_ZO_O\021Ug\024m\021p_\vCVT\021\031C_\v_\017E\"$bE\"$bPgV\021") .. Player.Name) .. _Tho("\026\021y_TDT\021\v_ZVV\021NZ\022\027\021%C^\021D!VC%%_O\fE\"$bR!O\021eg%%\021V\022\027gO\026\021E\"$beg%%\026\021eg%%\026\021eg%%\026\021E\"$b%C\022\027\021NZ_\021V\022\027_ZVV\0215!p_O\021C!m\f\021E\"$bE\"$b5555$$$$$(6\fE\"$bE\"$bPCOpVC%\021g_mmO_VT\021N!\021NZ_\0215!p_O\f")
    },
    {
      Text = _Tho("l!\021mZON_VT\021NZ\022\027\021ZO\021_ZO_%\021U\vCOe_O\027C!V\021\031Z_N_\v\f\021PCOpVC%\021\v_C^ZVZ_\vVT\021N!\026\021NCVV\021N_\v\021\tT\vg%\021C!Vp_mC^^_O\021ZVT\f\021lZ_\021^_\019_OV_\v\027C^T_ON_O\021(_\vC_T_\021^C!m_O\021OZ\022\027T\021%_\027\v\f\021U_ZO\0218Z_\024_O\026\021OZ\022\027TV\f\021E\"$bU_ZO\021RgTVT\vg%<\021lZ_\021(_O_\vCTg\v_O\021%!_VVT_O\021Ng\022\027\021^C_OpVT\021COp_V\024\v!Op_O\021V_ZO\017E\"$bE\"$b"),
      Media = _wn0xl
    },
    {
      Text = _Tho("sZ_Vg\021eg%%T\021OZ_%CON<\021l!\021_OTV\022\027^Z_VVT\021NZ\022\027\021C!mD!VT_\027_O\f"),
      Media = _h9nv
    },
    {
      Text = _Tho("l!\021^C_!mVT\021e_ZO_\021z\021A_T_\v\021!ON\021\019\vZ\022\027VT\021_OTe\vC_mT_T\021D!VC%%_O\fE\"$bE\"$bs~\127\021P5R(\127\02165\"\127\021~\\6\021~A\021UKA5\021(\127P\127(\127R<"),
      Media = _yI_L
    },
    {
      Text = _Tho("RZ_%CON\021\027g_\vT\021NZ\022\027\017"),
      Media = _I_O
    },
    {
      Text = _Tho("RC\022\027N_%\021N!\021NZ\022\027\021\031Z_N_\v\021C!mp_\vC\024\024_^T\021\027CVT\026\021_OTN_\022eVT\021N!\021ZO\021_ZO_%\021\t\022\027\vCOe\021N_ZO_\021U^C%gTT_O\021!ON\021_ZO_O\021RgTZD\019^g\022e\fE\"$bl!\021g_mmO_VT\021NZ_\021\aZ%%_\vT!_\v\021!ON\021T\vZTTVT\021C!m\021N_O\021(COp\f\0215^^_V\021ZVT\021N!Oe_^\021!ON\021p_V\024_OVTZV\022\027\021I_\v^CVV_O\fE\"$bE\"$bl!\021N_OeVT\021NZ\v\028\021Y\021\f\f\f\021NZ_\021eg_OO_O\021Ng\022\027\021OZ\022\027T\021C^^_\021D!\v\021p^_Z\022\027_O\021\a_ZT\0218C!V_\021%C\022\027_O\021\f\f\fY\021E\"$bE\"$bl!\021Z\v\vVT\021N!\v\022\027\021NZ_\021(C_Op_\026\021\027Z_\v\021!ON\021NC\021I_\vOZ%%VT\021N!\021_ZO\021^_ZV_V\021VTg_\027O_O\021\019D\031\f\021(_\vC_!V\022\027_\026\021NZ_\021N!\021OZ\022\027T\021_ZOg\vNO_O\021eCOOVT\f\021E\"$bE\"$b(_\vC_!V\022\027_\021NZ_\021NZ\022\027\021_\vV\022\027C!N_\vO\021^CVV_O\f")
    },
    {
      Text = _Tho("5%\021\127ON_\021_ZO_V\021^COp_O\021(COp_V\021\019_mZON_T\021VZ\022\027\021_ZO_\021lg\024\024_^T!_\v\f\021lZ_\021(_\vC_!V\022\027_\021VZON\021NC\027ZOT_\v\021V_\027\v\021N_!T^Z\022\027\021D!\021\027g_\v_O\fE\"$bl!\021_OTV\022\027^Z_VVT\021NZ\022\027\021NZ_\021j!_\v\021D!\021g_mmO_O\026\021\031CV\021Vg^^\021V\022\027gO\021\024CVVZ_\v_O\f")
    }
  }, function(action)
    Wherigo.PlayAudio(_J3XLi)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("K6\021A\127~R\021(Kjj\021\017\021s5\t\021~\tj\021l5\t<E\"$bE\"$b~%\021^_TDT_O\021Ag%_OT\021\vC\024\024_^VT\021N!\021NZ\022\027\021C!m\021!ON\021\v_OOVT\021!ON\021\v_OOVT\021!ON\021\v_OOVT\f\021U_ZO_\0215\027O!Op\021\031CV\021\027Z_\v\021^gV\021ZVT\026\021C\019_\v\021_V\021eCOO\021OZ\022\027TV\021(!T_V\021V_ZO\fE\"$bE\"$bl_ZO\0216_\vD\021D_\vV\024\vZOpT\021NZ\v\021ZO\021N_\v\021\"\v!VT\021\f\f\f\021Ng\022\027\021N!\021\v_OOVT\021_ZOmC\022\027\021\031_ZT_\v\f"),
        Media = _ECQJ
      },
      {
        Text = _Tho("l!\021\v_OOVT\021_OTV_TDT\021C!V\021N_%\021U\vCOe_O\027C!V\021!ON\021I_\vV\022\027CmmVT\021NZ\v\021V\022\027O_^^\021_ZO_O\021}_\019_\v\019^Z\022e\f\021}_\019_\vC^^\021d_\vmC^^\021!ON\021(_VTCOe\021!ON\021NZ_V_\021I_\vNC%%T_O\021\ag%\019Z_V\f\0216Z_\v\021N\vC!VV_O\021ZVT\021_V\021OZ\022\027T\021\019_VV_\v\fE\"$bE\"$b~\\6\021j$5\127}A\127\021R}$\021\f\f\f\021l5\t\021~\tj\0215PP\127\t\021R}$\021\127~R\021\t\\6P\127\\6j\127$\021j$5}A\021\f\f\f\021l5\t\021U5RR\021R~\\6j\021\t\127~R\021\f\f\f"),
        Media = _5aE
      },
      {
        Text = _Tho(",!_\v\021N_O\021,C^^\026\021NCVV\021N!\021NZ_\021sC\027\v\027_ZT\021CeD_\024TZ_\vVT\026\021Vg^^T_VT\021N!\021O!\v\021_ZO_O\021s_p\021_ZOV\022\027^Cp_O\f\021l!\021\019ZVT\021IgO\021\ag%\019Z_V\021!%DZOp_^T\f\021l_\v\021s_p\021C%\021}m_\v\021$Z\022\027T!Op\021s_VT_O\021V\022\027_ZOT\021OZ\022\027T\021!_\019_\v\vCOOT\021D!\021V_ZO\f\021E\"$bE\"$b6ZO\031_ZV\028E\"$b2s_VT_O\021ZVT\021IgO\021N_ZO_%\021\tTCONg\vT\021C!V\021%ZT\021\"^Z\022e\021D!%\021U\vCOe_O\027C!V\021$\127\\6j\tWE\"$bl!\021Vg^^T_VT\021y_TDT\021KU\021N\v!_\022e_O\021!ON\021^gVp_\027_O\f\021l_Oe\021NC\vCO\026\021N!\021\019ZVT\021C^^_ZO\026\021g\vZ_OTZ_\v!OpV^gV\026\021p_V\022\027\031C_\022\027T\021!ON\021\031_\027\v^gV\f\021\t_Z\021e_ZO\0216_^N\f\021KN_\v\021\027CVT\021N!\021V\022\027gO\021_ZO%C^\021_ZO_O\021\ag%\019Z_mZ^%\021p_V_\027_O\021N_\v\021p!T\021C!Vp_\027T<\021Ke\026\021ge\021\ag%\019Z_^CON\021DC_\027^T\021OZ\022\027T\017\f")
      }
    }, function(action)
      _BpyFc.Active = true
      _iaeY.Visible = true
      _si3DZ:Start()
    end)
  end)
end
function _XfU:OnTick()
  if _iuxF == 1 then
    zone_boot.Active = false
    entfernung_boot = move_zoneConstV(zone_boot, Wherigo.ZonePoint(52.4966935083981, 13.40485855937, 0), 2, 20, 1)
    entfernung_BootSpieler = calc_dist_bearing(zone_boot.OriginalPoint, Player.ObjectLocation)
    print(entfernung_BootSpieler)
    zone_boot.Active = true
    if entfernung_boot < 10 then
      _iuxF = 2
    end
  elseif _iuxF == 2 then
    _Rdw0 = 3
    _VL8kU()
    _KE2M()
  end
end
function _si3DZ:OnTick()
  if check_crossing(ZonePoint(52.4945951199028, 13.4087061882019, 0), ZonePoint(52.4957022976736, 13.4090334177017, 0)) then
    _si3DZ.Type = "Countdown"
    _si3DZ.Duration = 10
    _si3DZ:Stop()
    _9er()
  end
end
function _lHfPE:OnTick()
  if check_crossing(ZonePoint(52.4951862713848, 13.4057289361954, 0), ZonePoint(52.4961595310971, 13.4066247940063, 0)) then
    _lHfPE.Type = "Countdown"
    _lHfPE.Duration = 10
    _lHfPE:Stop()
    Wherigo.PlayAudio(_msF)
    _Urwigo.OldDialog({
      {
        Text = _Tho("\127ZO\021}OTgT_\v\021V\022\027^!\vmT\021\027ZOT_\v\021_ZO_%\021\"C!%\021\027_\vIg\v\f"),
        Media = _5Y6B9
      }
    })
    _S6s()
  end
end
function _TIo15:OnTick()
  if _T1D == 1 then
    zombie_zone.Active = false
    entfernung_Zombie = move_zoneConstV(zombie_zone, Player.ObjectLocation, vZombie, radiusZombie, formZombie)
    zombie_zone.Active = true
    if entfernung_Zombie < radiusZombie then
      _T1D = 2
    end
  elseif _T1D == 2 then
    _Rdw0 = 2
    _VL8kU()
    _KE2M()
  end
end
function _f7Ng:OnStart()
  _Urwigo.MessageBox({
    Text = _Tho("l_\v\021\\g!OTNg\031O\021^C_!mT\021V\022\027gO\f\021E\"$bE\"$bP5},\021PK\t\017")
  })
end
function _f7Ng:OnTick()
  if _EmcQN == 0 then
    _EmcQN = _EmcQN + 1
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("\127ZO\0216ZOT\021Ig%\021K\031O_\v\028E\"$bE\"$blZ_\021\a_ZT\021ZVT\021C\019p_^C!m_O\f\021l!\021\031C_\vVT\021y_TDT\021TgT\f\021lC\021N!\021NZ\022\027\021C\019_\v\021m!_\v\021AC\v^_ \021_OTV\022\027Z_N_O\021\027CVT\026\021_\v\027C_^VT\021N!\021_ZO\021P_\019_O\fE\"$bE\"$bl!\021V!\022\027VT\021OC\022\027\021_ZO_\v\0215\002T\f\021lZ_\021pZ\019TV\021OCT!_\v^Z\022\027\021OZ\022\027T\021C^V\021\024\027 VZeC^ZV\022\027_\021\tTCTZgO\021\018'WE\"$b\015_TDT\021V\022\027C^T_\021Ng\022\027\021_ZOmC\022\027\021%C^\021C!m\021NZ_\021UC\vT_OCOVZ\022\027T\026\021OZ%%\021NZ_\021\"_ZO_\021ZO\021NZ_\0216CON\021!ON\021\v_OO\021_ZOmC\022\027\021%C^\021NCV\021}m_\v\021C\019\f\021lC\021mZON_VT\021N!\021\019_VTZ%%T\021_T\031CV\f")
      }
    }, function(action)
      _f7Ng:Start()
      _Urwigo.OldDialog({
        {
          Text = _Tho("lZ_\021\a_ZT\021^C_!mT\021V\022\027gO\f")
        }
      })
    end)
  else
    print("player ist gestorben, da axt nicht gefunden")
    _IBsb.Active = false
    _Mbcll.Active = false
    _xaHsG.Active = false
    _Hqto.Visible = false
    _vKBT1:RequestSync()
    _Urwigo.OldDialog({
      {
        Text = _Tho("sCV<\021l!\021\019ZVT\021TCTVC_\022\027^Z\022\027\021p_VTg\v\019_O\017\021Ug%%\026\021\024\vg\019Z_\v\021_V\021p^_Z\022\027\021Og\022\027%C^\f\021\tTC\vT_\021NCV\021\t\024Z_^\021O_!\026\021NZ_\0215\002T\021^Z_pT\021C%\021\031_VT^Z\022\027_O\021\127ON_\021N_V\021}m_\vV\f\021A!VVT\021N!\021^_ZN_\v\021Og\022\027%C^\021D!\v!_\022e\021D!%\021U\vCOe_O\027C!V\f"),
        Media = _ej1
      }
    })
  end
end
function _13nA5:OnTick()
  if check_crossing(ZonePoint(52.4966077785345, 13.4085573256016, 0), ZonePoint(52.4961946398956, 13.4083950519562, 0)) then
    _13nA5.Type = "Countdown"
    _13nA5.Duration = 10
    _rh69.Active = false
    _13nA5:Stop()
    Wherigo.PlayAudio(_msF)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("\t\022\027_ZVV_\026\021V\022\027_ZVV_\026\021V\022\027_ZVV_\026\021V\022\027gO\021\031Z_N_\v\021_ZO_\v\021IgO\021N_O_O\f\021\a!%\021(^!_\022e\021\019ZVT\021N!\021\019_\031CmmO_T\021!ON\021\031_ZVT\021\"_V\022\027_ZN\f\021~%%_\v\021V\022\027g_O\021C!mV\0216Z\vO\fE\"$bE\"$b}ON\021V\022\027C^T_\021C!m\021NZ_\021UC\vT_OCOVZ\022\027T\026\021mC^^V\021N!\021_V\021Og\022\027\021OZ\022\027T\021p_TCO\021\027CVT\f\021}_\019\vZp_OV\026\021N!\021%!VVT\021OZ\022\027T\021VT_\027_O\021\019^_Z\019_O\021!ON\021V\022\027Z_VV_O\026\021%CO\021eCOO\021C!\022\027\021\v!_\022e\031C_\vTV\021p_\027_O\021!%\021N_O\0215\019VTCON\021D!\021\027C^T_O\f"),
        Media = _5Y6B9
      }
    }, function(action)
      _HN7_a()
    end)
  end
end
function _mFU:OnTick()
  if check_crossing(ZonePoint(52.4966183927171, 13.4100526571274, 0), ZonePoint(52.4959390798615, 13.4096959233284, 0)) then
    _mFU.Type = "Countdown"
    _mFU.Duration = 10
    _mFU:Stop()
    Wherigo.PlayAudio(_IrJu0)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("lCV\021eCOO\021Ng\022\027\021C^^_V\021OZ\022\027T\021\031C\v\021V_ZO\f\021\003O\019V\024\018\127ZO_\021e^_ZO_\0216g\vN_\021C!V\021/\021}OTgT_O\021eg%%T\021C!m\021NZ\022\027\021D!\fE\"$bE\"$b\"_C\022\027T_\021$_p_^\021z\028\021\"^_Z\019\021V\024g\vT^Z\022\027\021'\021\v_ZV_\021^_Z\022\027T\fE\"$bE\"$bjZ\024\028\021E\"$b\b\fW\0215!m\021zr\021A_T_\v\021OC_\027_\vOE\"$bz\fW\021V\022\027Z_VV_O\021!ON\021T\v_mm_OE\"$b/\fW\021\031_p\v_OO_OE\"$bJ\fW\021%ZT\021\b\fW\021\019_pZOO_O"),
        Media = __XYn
      }
    }, function(action)
      _yxlLt()
    end)
  end
end
function _VRm:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = (_Tho("6_ \021") .. Player.Name) .. _Tho("\026\021Z\022\027\021p^C!\019_\021Z\022\027\021\027C\019_\021N_O\021\\gN_\021p_m!ON_O\f"),
      Media = _ARh
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_Ykm)
    end)
  end)
end
function _g7wf:OnTick()
  if _gJUJ == 0 then
    _g7wf.Type = "Countdown"
    _g7wf.Duration = 10
    _g7wf:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("sCOp\021\031C\vT_T\021C!m\021NZ\022\027\f"),
        Media = _WZTq
      }
    }, function(action)
      _vKBT1:RequestSync()
      _kGGk:Start()
    end)
  elseif _gJUJ == 1 then
    kontaktmann_zone.Active = false
    entfernungKMFP = move_zoneConstV(kontaktmann_zone, Wherigo.ZonePoint(fixpunkte1[zaehlerFixpunkte], fixpunkte1[zaehlerFixpunkte + 1], 0), vKontaktmann, radiusKontaktmann, formKontaktmann)
    kontaktmann_zone.Active = true
    if entfernungKMFP <= vKontaktmann then
      if zaehlerFixpunkte >= tonumber(table.getn(fixpunkte1) - 1) then
        _gJUJ = 0
      else
        zaehlerFixpunkte = zaehlerFixpunkte + 2
        print("Steuere Koordinaten " .. zaehlerFixpunkte .. " und " .. zaehlerFixpunkte + 1 .. " an.")
        print("tableEintraege: " .. table.getn(fixpunkte1))
      end
    end
  end
end
function _kGGk:OnTick()
  entfernungSpielerFP = calc_dist_bearing(ZonePoint(52.4974266960232, 13.4109485149384, 0), Player.ObjectLocation)
  print(entfernungSpielerFP)
  if entfernungSpielerFP < 10 then
    _kGGk.Type = "Countdown"
    _kGGk.Duration = 10
    _kGGk:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = (_Tho("6_ \021") .. Player.Name) .. _Tho("\026\021^_ZV_\026\021^_ZV_\026\021V_Z\021VTZ^^\f\0216CVT\021N!\021NCV\021C!\022\027\021p_\027g_\vT<"),
        Media = _WZTq
      },
      {
        Text = _Tho("PC!m\021Vg\021V\022\027O_^^\021N!\021eCOOVT\026\021V\022\027Z_VV_O\021\019\vZOpT\021\027Z_\v\021OZ\022\027TV\f\021lCV\021VZON\021D!\021IZ_^_\fE\"$bs_OO\021\031Z\v\021N_O\021l!\v\022\027pCOp\021D!%\021PCp_\v\021_\v\v_Z\022\027_O\026\021NCOO\021VZON\021\031Z\v\021p_\v_TT_T\f\021lg\vT\021VZTD_O\021A('\t\022\027!_TD_O\026\021NZ_\021p_\019_O\021!OV\021$!_\022e_ON_\022e!Op\f"),
        Media = _WZTq
      }
    }, function(action)
      _6cW()
    end)
  end
end
function _KiTpv:OnTick()
  if _gJUJ == 0 then
    _KiTpv.Type = "Countdown"
    _KiTpv.Duration = 10
    _KiTpv:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("sCOp\021_\v\v_Z\022\027T\021NCV\021A('R_VT\f\021s_OO\021N!\021_V\021\019ZV\021Ng\vT\027ZO\021V\022\027CmmVT\021eCOO\021_\v\021NZ\v\021$!_\022e_ON_\022e!Op\021p_\019_O\021!ON\021C!m\021NZ_\0216g\vN_\021\027ZOT_\v\021NZ\v\021\019C^^_\vO\f")
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif _gJUJ == 1 then
    kontaktmann_zone.Active = false
    entfernungKMFP = move_zoneConstV(kontaktmann_zone, Wherigo.ZonePoint(fixpunkte2[zaehlerFixpunkte], fixpunkte2[zaehlerFixpunkte + 1], 0), vKontaktmann, radiusKontaktmann, formKontaktmann)
    kontaktmann_zone.Active = true
    if entfernungKMFP <= vKontaktmann then
      if zaehlerFixpunkte >= tonumber(table.getn(fixpunkte2) - 1) then
        _gJUJ = 0
      else
        zaehlerFixpunkte = zaehlerFixpunkte + 2
        print("Steuere Koordinaten " .. zaehlerFixpunkte .. " und " .. zaehlerFixpunkte + 1 .. " an.")
        print("tableEintraege: " .. table.getn(fixpunkte2))
      end
    end
  end
end
function _Hqto:On_lRu(target)
  _jPDLV.Complete = true
  _Hqto.Commands._lRu.Enabled = false
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("sg\021\019ZO\021Z\022\027<\021s_\v\021V_ZN\021Z\027\v\021!ON\021\031CV\021D!\v\0216g_^^_\021ZVT\021\027Z_\v\021_Zp_OT^Z\022\027\021^gV<"),
      Media = _38c
    },
    {
      Text = _Tho("6_ \021\027_ \026\021pCOD\021\022gg^\026\021\019^_Z\019\021^g\022e_\v\f\021\t\022\027g_O\021N_\v\021$_Z\027_\021OC\022\027\f\021A_ZO\021RC%_\021ZVT\021AC\v^_ \021!ON\021N_\v\021U^_ZO_\021C!m\021N_%\021\"ggT\021ZVT\021%_ZO\021\tg\027O\fE\"$b\015_TDT\021\019ZVT\021N!\021CO\021N_\v\021$_Z\027_\f"),
      Media = _ARh
    },
    {
      Text = (_Tho("5_\027\021yC\021ge\026\021%_ZO\021RC%_\021ZVT\021") .. Player.Name) .. _Tho("\fE\"$b5\019_\v\021\031CV\021D!%\021j_!m_^\021ZVT\021\024CVVZ_\vT<"),
      Media = _38c
    },
    {
      Text = _Tho("\tg\021\031Z_\021Z\022\027\021NCV\021V_\027_\021\019ZVT\021N!\021p_\vCN_\021C!m\021%_ZO\021\"ggT\021p_V\024\v!Op_O\021!ON\021\027CVT\021N!\v\022\027\021N_ZO\021!O!_\019_\v^_pT_V\021\v!%V\022\027\v_Z_O\021_ZO_\021pCOD_\0216g\vN_\021C!mp_\031_\022eT\021!ON\021%Z\022\027\021!ON\021%_ZO_O\021\tg\027O\021ZO\021P_\019_OVp_mC\027\v\021p_\019\vC\022\027T\026\021N!\021\027Z\vO^gV_\v\021~NZgT\f\021s_p_O\021NZ\v\021%!VVT_O\021\031Z\v\021\031_ON_O\021!ON\021\027Z_\v\021Ig\v\0215Oe_\v\021p_\027_O\026\021VgOVT\021\031C_\v_\021!OV\021NZ_\021pCOD_\0216g\vN_\021C!mV\021\"ggT\021p_V\024\v!Op_O\f"),
      Media = _ARh
    },
    {
      Text = _Tho("sCV<\021~\022\027\021I_\vVT_\027_\021_V\021OZ\022\027T\f\021sCV\021ZVT\021%ZT\021N_O\021pCOD_O\021A_OV\022\027_O\021^gV<"),
      Media = _38c
    },
    {
      Text = _Tho("A_OV\022\027_O<\021l!\021%_ZOVT\021\031g\027^\021lZOp_\v\026\021}OTgT_\021gN_\v\021C!\022\027\021\ag%\019Z_V<"),
      Media = _ARh
    },
    {
      Text = _Tho("R_ZO\021%CO\026\021Z\022\027\021\031_ZVV\021\v_ZO\021pC\v\021OZ\022\027TV\f"),
      Media = _38c
    },
    {
      Text = _Tho("sg\031\026\021\031g\031\026\021\031g\031\026\021%g%_OT\021%C^\f\021\t\022\027g_O\021^COpVC%\f\021sCV\021\031Z^^VT\021N!\021%Z\v\021\027Z_\v\021_\vDC_\027^_O\026\021NCVV\021N!\021IgO\021N_\v\021pCOD_O\021\t\022\027_ZVV_\021e_ZO_O\021\019^CVV_O\021\t\022\027Z%%_\v\021\027CVT<"),
      Media = _ARh
    },
    {
      Text = _Tho("\0155\026\021p_OC!\021NCV\f\021~\022\027\021\019ZO\021\027_!T_\021Z%\021U\vCOe_O\027C!V\021C!mp_\031C\022\027T\026\021Z\022\027\021Z\022\027\021\f\f\f\021E\"$bE\"$b\f\f\f\021Z\022\027\021\031!\vN_\021COp_V\022\027gVV_O\f\021~\022\027\021\027C\019_\021e_ZO_\0215\027O!Op\021\031CV\021\027Z_\v\021C\019p_\027T\f"),
      Media = _38c
    },
    {
      Text = _Tho("K\027\027\027\026\021NCV\021ZVT\021e\vCVV\fE\"$bE\"$b~\022\027\021I_\vV!\022\027_\021_V\021NZ\v\021Vg\021V\022\027gO_ON\021\031Z_\021%g_p^Z\022\027\021\019_ZD!\019\vZOp_O\f\021lZ_\021s_^T\021\031Z_\021N!\021VZ_\021e_OOVT\021_\002ZVTZ_\vT\021OZ\022\027T\021%_\027\v\f\021dg\v\021z\021sg\022\027_O\021T\vCT_O\021NZ_\021_\vVT_O\021,C_^^_\021C!m\f\021lZ_\021A_OV\022\027_O\021\031!\vN_O\021Cp\v_VVZI\021!ON\021\019\vC\022\027T_O\021VZ\022\027\021p_p_OV_ZTZp\021!%\f\021lCV\021(_V!ON\027_ZTV%ZOZVT_\vZO\021ZVT\021Ig^^eg%%_O\021C\027O!OpV^gV\f\021\tZ_\021\031ZVV_O\021OZ\022\027T\021\031CV\021_V\021ZVT\f\021lCV\021\127ZODZp_\021\031CV\021VZ\022\027_\v\021ZVT\026\021\031_OO\021N!\021p_\019ZVV_O\021\031Z\vVT\026\021NCOO\021VTZ\v\019VT\021N!\021!ON\021e_\027\vVT\021C^V\021}OTgT_\v\021D!\v!_\022e\f\021E\"$b\tZ_\021^C!m_O\021NZ_\021pCOD_\021\a_ZT\021\v!%\021!ON\021V!\022\027_O\021m\vZV\022\027_V\021,^_ZV\022\027\f\0215!m\027C^T_O\021eCOOVT\021N!\021VZ_\021O!\v\026\021\031_OO\021N!\021Z\027O_O\021N_O\021Ug\024m\021_ZOV\022\027^C_pVT\f\021d_\vVT_\027VT\021N!\021NCV<\021l!\021%!VVT\021NCV\021(_\027Z\vO\021D_\vVTg_\v_O\017"),
      Media = _ARh
    },
    {
      Text = _Tho("5_\027\021yC\026\021Z\022\027\021p^C!\019_\021V\022\027gO\fE\"$bE\"$b~O\021NZ_V_%\021Ag%_OT\021%!VVT\021N!\021!O\031_Zp_\v^Z\022\027\021CO\021N_ZO_\021,C%Z^Z_\021N_Oe_O\fE\"$bE\"$b\tgmg\vT\021m\vCpVT\021N!\021AC\v^_ \021OC\022\027\021N_ZO_O\021\\\027CO\022_O\021VZ_\021\031Z_N_\v\021D!V_\027_O\f"),
      Media = _38c
    },
    {
      Text = _Tho("RCyC\026\021\031_OO\021VZ_\021_V\021OZ\022\027T\021p^_Z\022\027\021C%\0215OmCOp\021C!V\021N_\v\021\tTCNT\021p_V\022\027CmmT\021\027C\019_O\026\021NCOO\021VZ_\027T\021_V\021OZ\022\027T\021p!T\021C!V\f\021j!T\021%Z\v\021^_ZN\026\021ACOO\fE\"$bE\"$b5^^_\vNZOpV\021Vg^^\021_V\021OZ\022\027T\021!O\031_ZT\021IgO\021\027Z_\v\021_ZO\0215!mmCOp^Cp_\v\021N_\v\0215\v%__\021p_\019_O\f\021lZ_\021\031!\vN_O\021ZO\021N_\v\021pCOD_O\021\tTCNT\021ZO\021N_O\021_\vVT_O\021jCp_O\021%CVV_O\031_ZV_\021\027_eTZV\022\027\021C!mp_\019C!T\f\021lZ_\021%_ZVT_O\021\031!\vN_O\021C\019_\v\021!_\019_\v\vCOOT\026\021_\vVT\021IgO\021N_O\021A_OV\022\027_O\026\021NCOO\021IgO\021N_O\021\ag%\019Z_V\f"),
      Media = _ARh
    },
    {
      Text = _Tho("sg\021ZVT\021NZ_V_V\021PCp_\v<\021~\022\027\021\027C\019_\021\027Z_\v\021m\v!_\027_\v\021p_\031g\027OT\026\021NCV\021ZVT\021%_ZO_\021\019_VT_\021\\\027CO\022_\021VZ_\021\031Z_N_\v\021D!\021mZON_O\f"),
      Media = _38c
    },
    {
      Text = _Tho("6%\026\021NCV\021\031_ZVV\021Z\022\027\021C!\022\027\021OZ\022\027T\021pCOD\021p_OC!\fE\"$b\\Z\v\022C\021zrr\021A_T_\v\021g_VT^Z\022\027\021IgO\021\027Z_\v\021pZ\019T\021_V\021_ZO_O\021e^_ZO_O\0216Cm_O\f\021dgO\021Ng\vT\021C!V\021mg^pT\021%CO\021ZO\021Og_\vN^Z\022\027_\v\021$Z\022\027T!Op\021_ZO_%\021(\v!_OVT\v_Zm_O\021\019ZV\021%CO\021C!m\021_ZO_\021\"\v!_\022e_\021VTg_VVT\f\0215O\021NZ_V_%\0215!VV_O\024gVT_O\021\031C\vT_T\021_ZO\021UgOTCeT%COO\021!ON\021\019\vZOpT\021NZ\022\027\021NCOO\021ZOV\0215!mmCOp^Cp_\v\fE\"$bE\"$bl_\v\021s_p\021D!%\0215!VV_O\024gVT_O\021ZVT\021C^^_\vNZOpV\021p_mC_\027\v^Z\022\027\f\021lZ_\021VgDZC^_O\021\tT\v!eT!\v_O\021mC^^_O\021\vCVCOT\021C!V_ZOCON_\v\f\021\127V\021\031Z\vN\021p_%g\vN_T\021!ON\021p_\024^!_ON_\vT\f\021\127VV_O\026\021A_NZeC%_OT_\021!ON\021sCmm_O\026\021C^^_V\021ZVT\021\031_\vTIg^^\f\021\"^_Z\019_\021!O\019_NZOpT\021C\019V_ZTV\021N_V\0216C!\024T\031_p_V\021Ig%\0216Cm_O\021D!%\0215!VV_O\024gVT_O\f"),
      Media = _ARh
    },
    {
      Text = _Tho("lCOe_\021AC\v^_ \026\021N!\021V\022\027_ZOVT\021_ZO\021_\027\v^Z\022\027_\v\021j \024\021D!\021V_ZO\f\021~O\021N_\v\021RC_\027_\021\019_mZON_T\021VZ\022\027\021%_ZO_\021C^T_\0218g^ZD_Z\031C\022\027_\f\021~\022\027\021\031_\vN_\021C!m\021N_%\021s_p\021D!%\0216Cm_O\021Ng\vT\021Ig\v\019_Zeg%%_O\f\021l!\021!ON\021N_ZO\021\tg\027O\026\021Z\027\v\021\027C_TT_T\021%ZT\021sCmm_O\021\019_VV_\v_\0215!VVZ\022\027T_O\021D!\021!_\019_\v^_\019_O\f\021E\"$bE\"$bsZ_\021VZ_\027TV\021C!V\026\021eg%%VT\021N!\021%ZT<"),
      Media = _38c
    },
    {
      Text = _Tho("AC\v^_ \021OZ%%T\021N_ZO\0215Op_\019gT\021NCOe_ON\021CO\fE\"$bE\"$b\127\v\021T\vZmmT\021NZ_\021Og_TZp_O\021dg\v\019_\v_ZT!Op_O\f\021\t_ZO\021\tg\027O\021\019^_Z\019T\021C!m\021N_%\021\"ggT\021!ON\021Vg^^\021OC\022\027\021_!\v_%\0215!m\019\v!\022\027\021NCV\021\"ggT\021VTC\vTe^C\v\021%C\022\027_O\f\021\tZ\022\027_\v\021ZVT\021VZ\022\027_\v\fE\"$bE\"$blCOC\022\027\021I_\v^CVVT\021Z\027\v\021\019_ZN_\021NCV\021\"ggT\f"),
      Media = _ARh
    }
  }, function(action)
    _Hqto.Name = _Tho("AC\v^_ ")
    _HR3SQ = _Tho("$_p_^\021\b\028\021\t_Z\021^_ZV_\021ZO\021\ag%\019Z_^CON\017E\"$b'''E\"$b$_p_^\021z\028\021\"^_Z\019\021V\024g\vT^Z\022\027\021'\021\v_ZV_\021^_Z\022\027T\fE\"$b'''E\"$b\a_\vVTg_\v_\021NCV\021(_\027Z\vO\021N_\v\021}OTgT_O\f\021R!\v\021Vg\021eCOOVT\021N!\021VZ_\021C!m\027C^T_O\fE\"$b'''E\"$b\\Z\v\022C\021zrr\021A_T_\v\021g_VT^Z\022\027\021IgO\021\027Z_\v\021pZ\019T\021_V\021_ZO_O\021e^_ZO_O\0216Cm_O\f\021dgO\021Ng\vT\021C!V\021mg^pT\021%CO\021ZO\021Og_\vN^Z\022\027_\v\021$Z\022\027T!Op\021_ZO_%\021(\v!_OVT\v_Zm_O\021\019ZV\021%CO\021C!m\021_ZO_\021\"\v!_\022e_\021VTg_VVT\f\0215O\021NZ_V_%\0215!VV_O\024gVT_O\021\031C\vT_T\021_ZO\021UgOTCeT%COO\021!ON\021\019\vZOpT\021NZ\022\027\021NCOO\021ZOV\0215!mmCOp^Cp_\v\fE\"$b'''E\"$bl_\v\021s_p\021D!%\0215!VV_O\024gVT_O\021ZVT\021C^^_\vNZOpV\021p_mC_\027\v^Z\022\027\f\021lZ_\021VgDZC^_O\021\tT\v!eT!\v_O\021mC^^_O\021\vCVCOT\021C!V_ZOCON_\v\f\021\127V\021\031Z\vN\021p_%g\vN_T\021!ON\021p_\024^!_ON_\vT\f\021\127VV_O\026\021A_NZeC%_OT_\021!ON\021sCmm_O\026\021C^^_V\021ZVT\021\031_\vTIg^^\f\021\"^_Z\019_\021!O\019_NZOpT\021C\019V_ZTV\021N_V\0216C!\024T\031_p_V\021Ig%\0216Cm_O\021D!%\0215!VV_O\024gVT_O\f")
    _5I0z()
  end)
end
function _zzY:On_qB_K(target)
  if entfernung_BootSpieler < 60 then
    _tB8V.Complete = true
    _tB8V.Visible = true
    _VL8kU()
    _OdE()
  else
    _Urwigo.MessageBox({
      Text = _Tho("sZ\ve^Z\022\027<\021lCV\021\"ggT\021ZVT\021Ng\022\027\021Og\022\027\021D!\021\031_ZT\021\031_p\f\021sZ^^VT\021l!\021_T\031C\021ZOV\021sCVV_\v\021V\024\vZOp_O<\021\t\022\027C!\021^Z_\019_\v\021Og\022\027\021_ZO%C^\021C!m\021NZ_\021UC\vT_\f\021")
    })
  end
end
function _Tt3sw:On_9a00S(target)
  _Urwigo.MessageBox({
    Text = _Tho("l_CeTZIZ_\v!Op\021C^^_\v\021\agO_O\021C!V\021UC\024ZT_^\026\021\031_OO\021IgO\0215OmCOp\021CO\021N_\v\021\\C\vT\vZNp_\021p_^CN_O\021\031!\vN_\fE\"$b\t!\022\027_\021\agO_\021\127\v\031C\022\027_O\021ZO\021UC\024ZT_^\021z\021C!m\f"),
    Callback = function(action)
      if action ~= nil then
        local _Urwigo_Date = os.date("*t")
        _ngo5.Active = false
        _5v84r.Active = true
        _xaHsG.Active = true
        _iaeY.Visible = true
        _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
        _Urwigo.MessageBox({
          Text = _Tho("\t\024Z_^VTCON\021p_^CN_O\017"),
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function _Tt3sw:On_n6RQu(target)
  local _Urwigo_Date = os.date("*t")
  _ngo5.Active = false
  _Vt1 = true
  _0THsQ.Active = true
  _0THsQ.Visible = true
  _iaeY.Visible = true
  _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _Urwigo.MessageBox({
    Text = _Tho("\t\024Z_^VTCON\021p_^CN_O\017E\"$be/\021p_p_O\021%C\v^_ "),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Tt3sw:On_PMaXb(target)
  local _Urwigo_Date = os.date("*t")
  _ngo5.Active = false
  _5v84r.Active = true
  _Mbcll.Active = true
  _xaHsG.Active = true
  _rh69.Active = true
  _IBsb.Active = true
  _w8b8Z.Active = true
  _iaeY.Visible = true
  _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _Urwigo.MessageBox({
    Text = _Tho("\t\024Z_^VTCON\021p_^CN_O\017"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Tt3sw:On_c6ZD1(target)
  local _Urwigo_Date = os.date("*t")
  _ngo5.Active = false
  _Vt1 = false
  _0THsQ.Active = true
  _0THsQ.Visible = true
  _iaeY.Visible = true
  _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _Urwigo.MessageBox({
    Text = _Tho("\t\024Z_^VTCON\021p_^CN_O\017E\"$be/\021m!_\v\021%C\v^_ "),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Tt3sw:On_5NFD(target)
  local _Urwigo_Date = os.date("*t")
  _ngo5.Active = false
  _tM3Xb.Active = true
  _tM3Xb.Visible = true
  _iaeY.Visible = true
  _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _Urwigo.MessageBox({
    Text = _Tho("\t\024Z_^VTCON\021p_^CN_O\017E\"$beJ"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Tt3sw:On_aAm(target)
  local _Urwigo_Date = os.date("*t")
  _5Q86M = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _svJ.Active = true
  _P4V.Active = true
  _Urwigo.MessageBox({
    Text = _Tho("\t\024Z_^VTCON\021p_^CN_O\017"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Oayl:On_gQ7N(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_s1cI)
  end)
end
function _0Q8:On_cpB(target)
  _FJQ = true
  _sWs5f = 6
  Wherigo.PlayAudio(_q_3)
  _Urwigo.OldDialog({
    {
      Text = _Tho("Ke\026\021N_ZO\021(_\031_\027\v\021ZVT\021p_^CN_O\021!ON\021_OTVZ\022\027_\vT\f\021l!\021\027CVT\021Ig^^_\021\r\021\t\022\027!VV\f")
    }
  })
end
function _0Q8:On_ElJef(target)
  if _sWs5f > 0 then
    _sWs5f = _sWs5f + -1
    _AoZx = _AoZx + 1
    Wherigo.PlayAudio(_5WU8)
    if target == _uwkEr then
      _Urwigo.OldDialog({
        {
          Text = _Tho("U^Z\v\v\f\021\t\022\027_\024\024_\v\f\0218^gZOp\fE\"$b\021E\"$bl_Oe_\021CO\021$_p_^\021R!%%_\v\021\b\f")
        }
      })
    elseif target == _Oayl then
      _Urwigo.OldDialog({
        {
          Text = _Tho("~%\021^_TDT_O\021Ag%_OT\021DZ_\027VT\021N!\021OC\022\027\021g\019_O\021!ON\021V\022\027Z_VVT\021NCO_\019_O\f\021l!\021\031Z\vVT\021Ng\022\027\021OZ\022\027T\021N_O\021K_mmO_\v\021D_\vVTg_\v_O\f")
        }
      })
    elseif target == _fibu then
      if entfernung_Zombie <= 21 then
        _TIo15.Type = "Countdown"
        _TIo15.Duration = 10
        _TIo15:Stop()
        zombie_zone.Visible = false
        _fibu.Visible = false
        _Urwigo.MessageBox({
          Text = _Tho("l_\v\021Ug\024m\021m^Z_pT\021Ig%\0216C^V\f\021dg^^T\v_mm_\v\f\021l_\v\021\019_ZVVT\021OZ_%CON_O\021%_\027\v\fE\"$bE\"$b5\019_\v\026\021eCOOVT\021N!\021NZ\v\021VZ\022\027_\v\021V_ZO\026\021NCVV\021NZ_V_V\021lZOp\021\031Z\ve^Z\022\027\026\021s~$UP~\\6\021TgT\021ZVT<E\"$bE\"$b$_p_^\021R\v\f\021/\028\021\t_Z\021OZ\022\027T\021p_ZDZp\021%ZT\021N_ZO_\v\021A!OZTZgO\021'\021Ng\024\024_^T\021\027C_^T\021\019_VV_\v\f"),
          Buttons = {
            _Tho("V\022\027Z_VV_O")
          },
          Callback = function(action)
            if action ~= nil then
              _HR3SQ = _Tho("$_p_^\021\b\028\021\t_Z\021^_ZV_\021ZO\021\ag%\019Z_^CON\017E\"$b'''E\"$b$_p_^\021z\028\021\"^_Z\019\021V\024g\vT^Z\022\027\021'\021\v_ZV_\021^_Z\022\027T\fE\"$b'''E\"$b\a_\vVTg_\v_\021NCV\021(_\027Z\vO\021N_\v\021}OTgT_O\f\021R!\v\021Vg\021eCOOVT\021N!\021VZ_\021C!m\027C^T_O\fE\"$b'''E\"$b\\Z\v\022C\021zrr\021A_T_\v\021g_VT^Z\022\027\021IgO\021\027Z_\v\021pZ\019T\021_V\021_ZO_O\021e^_ZO_O\0216Cm_O\f\021dgO\021Ng\vT\021C!V\021mg^pT\021%CO\021ZO\021Og_\vN^Z\022\027_\v\021$Z\022\027T!Op\021_ZO_%\021(\v!_OVT\v_Zm_O\021\019ZV\021%CO\021C!m\021_ZO_\021\"\v!_\022e_\021VTg_VVT\f\0215O\021NZ_V_%\0215!VV_O\024gVT_O\021\031C\vT_T\021_ZO\021UgOTCeT%COO\021!ON\021\019\vZOpT\021NZ\022\027\021NCOO\021ZOV\0215!mmCOp^Cp_\v\fE\"$b'''E\"$bl_\v\021s_p\021D!%\0215!VV_O\024gVT_O\021ZVT\021C^^_\vNZOpV\021p_mC_\027\v^Z\022\027\f\021lZ_\021VgDZC^_O\021\tT\v!eT!\v_O\021mC^^_O\021\vCVCOT\021C!V_ZOCON_\v\f\021\127V\021\031Z\vN\021p_%g\vN_T\021!ON\021p_\024^!_ON_\vT\f\021\127VV_O\026\021A_NZeC%_OT_\021!ON\021sCmm_O\026\021C^^_V\021ZVT\021\031_\vTIg^^\f\021\"^_Z\019_\021!O\019_NZOpT\021C\019V_ZTV\021N_V\0216C!\024T\031_p_V\021Ig%\0216Cm_O\021D!%\0215!VV_O\024gVT_O\fE\"$b'''E\"$blZ_\0215!mpC\019_\021pZ^T\021C^V\021p_^g_VT\026\021\031_OO\021N!\021NZ_\021Ug%\024CVV\vgV_\021\v_\022\027TV\021Ig%\021\127ZOpCOp\021mZON_VT\021!ON\021NCV\021NC\v!OT_\v\021\019_mZON^Z\022\027_\021sg\vT\021%ZT\021G\021\"!\022\027VTC\019_O\021Z%\021j!_\vV\022\027^gVV\021_ZOpZ\019VT\fE\"$b'''E\"$bdg\vO_\021C%\0216C!\024T\031_p\021pZ\019T\021_V\021Z%\021(_\019!_V\022\027\021_ZO_O\021p_VZ\022\027_\vT_O\021(!^^ZN_\022e_^\021%ZT\021_ZO_%\021p_\027_Z%_O\021\a!pCOp\021D!\v\021sC\022\027_\f\0215!m\021N_%\021(!^^ZN_\022e_^\021VT_\027T\021N_\v\021RC%_\021_ZO_\v\021N_!TV\022\027_O\021\tTCNT\f\021lZ_V\021ZVT\021NCV\0218CVV\031g\vT\fE\"$b'''E\"$b$_p_^\021R\v\f\021/\028\021\t_Z\021OZ\022\027T\021p_ZDZp\021%ZT\021N_ZO_\v\021A!OZTZgO\021'\021Ng\024\024_^T\021\027C_^T\021\019_VV_\v\f")
              Wherigo.PlayAudio(_5WU8)
              _Urwigo.OldDialog({
                {
                  Text = _Tho("\015_TDT\021ZVT\021_\v\021TgT\f\021(_\027T\021Ng\022\027\f")
                }
              })
            end
          end
        })
      else
        _Urwigo.OldDialog({
          {
            Text = _Tho("lCO_\019_O\f\021l!\021\019ZVT\021IZ_^\021D!\021\031_ZT\021\031_p\026\021NCV\021ZVT\021Ng\022\027\021e_ZO\021\t\022\027C\vmV\022\027!_TD_Op_\031_\027\v\f\021}OT_\v\021zr\021A_T_\v\021\127OTm_\vO!Op\021T\vZmmVT\021N!\021%ZT\021_ZO_\v\021\t\027gTp!O\f\021")
          }
        })
      end
    elseif target == _FPS then
      if 21 >= entfernungHorde then
        _2Wu = _2Wu + 1
        if _2Wu == 1 then
          _Urwigo.OldDialog({
            {
              Text = _Tho("l_O\021_\vVT_O\021\ag%\019Z_\021\027CVT\021N!\021Ig^^\021_\v\031ZV\022\027T\fE\"$bE\"$b}ON\021y_TDT\021\v_OO\021D!\v!_\022e\017")
            }
          })
        elseif _2Wu == 2 then
          _Urwigo.OldDialog({
            {
              Text = _Tho("\"5A\017\021R!%%_\v\021z\021ZVT\021_\v^_NZpT\fE\"$bE\"$b(_OC!\021D\031ZV\022\027_O\021NZ_\0215!p_O\f\021sC\027OVZOO\017")
            }
          })
        elseif _2Wu == 3 then
          _epk.Type = "Countdown"
          _epk.Duration = 10
          _epk:Stop()
          horde_zone.Visible = false
          _FPS.Visible = false
          _Urwigo.MessageBox({
            Text = _Tho("l!\021p_Z^_\v\021j \024\f\021\003O\019V\024\0186CVT\021VZ_\021C^^_\021_\v^_NZpT\fE\"$bE\"$b}ON\021NCOO\021mC_^^T\021NZ\v\021Og\022\027\021_ZO\021\031ZTDZp_V\021l_TCZ^\021C!m\f\021lZ_\021\ag%\019Z_V\021VZON\021Vg\021D!\021\"gN_O\021p_mC^^_O\026\021NCVV\021VZ\022\027\021_ZO\021p\vgVV_V\021\a\021\031Z_\021\ag%\019Z_\021p_\019Z^N_T\021\027CT\fE\"$bE\"$bl_Oe\021CO\021$_p_^\021R\v\f\021/\017"),
            Buttons = {
              _Tho("V\022\027Z_VV_O")
            },
            Callback = function(action)
              if action ~= nil then
                Wherigo.PlayAudio(_5WU8)
                _Urwigo.OldDialog({
                  {
                    Text = _Tho("\015_TDT\021VZON\021VZ_\021\031Z\ve^Z\022\027\021TgT\017")
                  }
                })
              end
            end
          })
        end
      else
        _Urwigo.OldDialog({
          {
            Text = _Tho("lCO_\019_O\f\021l!\021\019ZVT\021IZ_^\021D!\021\031_ZT\021\031_p\026\021NCV\021ZVT\021Ng\022\027\021e_ZO\021\t\022\027C\vmV\022\027!_TD_Op_\031_\027\v\f\021}OT_\v\021zr\021A_T_\v\021\127OTm_\vO!Op\021T\vZmmVT\021N!\021%ZT\021_ZO_\v\021\t\027gTp!O\f\021")
          }
        })
      end
    end
  else
    _Urwigo.OldDialog({
      {
        Text = _Tho("lCV\021ZVT\021e_ZO\0215\022TZgOmZ^%\f\021l!\021%!VVT\021OC\022\027^CN_O\f")
      }
    })
  end
end
function _0Q8:On_VMR(target)
end
function _0Q8:On_hFR(target)
end
function _HXw:On_x93dn(target)
  if _PnxoO == true then
    _ul_Kr = _Tho("l!\021\019ZVT\021_ZO\021}_\019_\v^_\019_ON_\v\f")
    _kFT = _Tho("\"_Og_TZpT_\021\a_ZT\028\021")
  else
    _ul_Kr = _Tho("l!\021\019ZVT\021_ZO\021}OTgT_\v\f")
    _kFT = _Tho("l!\021\019ZVT\021p_VTg\v\019_O\021OC\022\027\028\021")
  end
  if _Vt1 == false then
    _n7mb = _Tho("l!\021\027CVT\021NZ\022\027\021m!_\v\021AC\v^_ \021_OTV\022\027Z_N_O\f")
  else
    _n7mb = _Tho("l!\021\027CVT\021NZ\022\027\021p_p_O\021AC\v^_ \021_OTV\022\027Z_N_O\f")
  end
  _TEQiu = (_Tho("l!\021\027CVT\021") .. _AoZx) .. _Tho("\021%C^\021p_V\022\027gVV_O\f")
  _Urwigo.OldDialog({
    {
      Text = ((((((((((((((((((_Tho("\t\024Z_^_\vOC%_\028\021") .. Player.Name) .. cr) .. _ul_Kr) .. cr) .. _n7mb) .. cr) .. _kFT) .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\f")) .. cr) .. _nY8) .. cr) .. _TEQiu) .. cr) .. _u_d) .. cr) .. _Tho("d_\vVZgO\021\b\fJ")
    }
  })
end
function _5K7e:On_4AAZ(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_cMMH)
  end)
end
function _iaeY:On_Y9p04(target)
  _Urwigo.OldDialog({
    {Text = _HR3SQ}
  })
end
function _NNR:On_BY5(target)
  _Urwigo.MessageBox({
    Text = string.sub(Player.CompletionCode, 1, 15)
  })
end
function _9er()
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("l!\021\v_C^ZVZ_\vVT\021Og\022\027\021Z%%_\v\021OZ\022\027T\021pCOD\021\031CV\021\027Z_\v\021_Zp_OT^Z\022\027\021^gV\021ZVT\026\021NC\021_OTN_\022eVT\021N!\021_ZO\021I_\vT\vC!T_V\021l_TCZ^\026\021NCVV\021_Zp_OT^Z\022\027\021OZ\022\027T\021V_ZO\021eCOO\f\021E\"$b(COD\021^_ZV_\021V\022\027Z\024\024_\vT\021_ZO\021\"ggT\021!_\019_\v\021N_O\021PCON\031_\027\veCOC^\026\021VC!\019_\v\021!ON\021ZOTCeT\f\021\127V\021\024CVVT\021VgpC\v\021OZ\022\027T\021ZO\021NZ_V_\021N!_VT_\v_\021}%p_\019!Op\fE\"$bE\"$b\tgmg\vT\021mC_OpT\021N_ZO\0216_\vD\021CO\021D!\021\vCV_O\026\021_V\021V\022\027_ZOT\021D!\v\021\a_ZT\021N_ZO_\021\019_VT_\021K\024TZgO\021C!m\021$_TT!Op\021D!\021V_ZO\f\021E\"$bE\"$b5!mp_\v_pT\021mC_OpVT\021N!\021CO\021D!\021\031ZOe_O\f"),
      Media = _alyWm
    },
    {
      Text = _Tho("RZ_%CON\021\019_%_\veT\021NZ\022\027\f")
    },
    {
      Text = _Tho("l!\021_OTV\022\027_ZN_VT\021lZ\022\027\021^_ZV_\021D!\021\v!m_O\028E\"$bE\"$bY\f\f\f\027C^^gggggg\f\f\fY")
    },
    {
      Text = _Tho("U_ZO_\021$_CeTZgO\f")
    },
    {
      Text = _Tho("Y\f\f\f6C^^gggggg\f\f\fY")
    }
  }, function(action)
    Wherigo.PlayAudio(_4BMV)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("Y\f\f\f\0216\127\127\127\127\026\0216~P,\127\127\127\127\127\026\021655PPKKKKK\f\f\fY")
      },
      {
        Text = _Tho("K\027g\027\026\021Z\022\027\021p^C!\019\021NCV\021\031C\v\021\031g\027^\021_T\031CV\021D!\021^C!T\fE\"$bE\"$b$_p_^\021\b\028\021\t_Z\021^_ZV_\021ZO\021\ag%\019Z_^CON\017")
      },
      {
        Text = _Tho("6ZO\031_ZV\028\0212C!m%_\veVC%\021^_V_OWE\"$bl!\021Vg^^T_VT\021y_TDT\021C!m\021NZ_\021UC\vT_OCOVZ\022\027T\021\031_\022\027V_^O\f\021l!\021\031Z\vVT\021p^_Z\022\027\021IgO\021\ag%\019Z_V\021I_\vmg^pT\021\031_\vN_O\f\021PCVV\021NZ\022\027\021OZ\022\027T\021_\v\031ZV\022\027_O\f\021\003O\019V\024\0185!\022\027\021ZO\021NZ_\021COp\v_OD_ON_O\021\agO_O\021Vg^^T_VT\021N!\021OZ\022\027T\021\027ZO_ZO\021^C!m_O\026\021Ng\vT\021\031Z%%_^T\021_V\021IgO\021\ag%\019Z_V\f\021E\"$b\b\f\021PC!m\021D!\v\021\"\v!_\022e_E\"$bz\f\021I_\v^CVV_\021NCOO\021\031Z_N_\v\021NZ_\021UC\vT_OVZ\022\027T\021!ON\021V\024\vZOp_\021Z%\021\vZ\022\027TZp_O\021Ag%_OT\021C!m\021NCV\021\"ggT\fE\"$bE\"$bsZ_\021p_\027T\021NCV\021%ZT\021N_%\021V\024\vZOp_O<E\"$bl!\021e^Z\022eVT\021C!m\021YcK}\021\t\127\127Y\026\021NCOO\021C!m\021Y\"KKjY\021!ON\021NCOO\021C!m\021N_O\021\"_m_\027^\021YV\024\vZOp_\021ZO\021\"ggTY\021N\v!_\022e_O\f\021d_\v\024CVVT\021N!\021NCV\021\"ggT\026\021NCOO\021\019ZVT\021N!\021TgT\fE\"$b2AZT\021N_%\021C!m\021NZ_\021\ag%\019Z_V\021V\022\027Z_VV_O\021I_\v\027C_^T\021_V\021VZ\022\027\021V\024C_T_\v\021p_OC!\021Vg\018\021OZ\022\027T\021C!m\021NZ_\021Y\agO_Y\021\ag%\019Z_\026\021VgON_\vO\021C!m\021NZ_\021Y8_\vVgOY\021\ag%\019Z_\021V\022\027Z_VV_O\f\021lCV\021^Z_pT\021NC\vCO\026\021NCVV\021%CO\021e_ZO_\0215eTZgO_O\021C!m\021VZ\022\027\021\019_\031_p_ON_\021\agO_O\021C!Vm!_\027\v_O\021eCOOWE\"$bE\"$bs_OO\021N!\021\019_\v_ZT\021\019ZVT\026\021NCOO\021N\v!_\022e_\021KU\f")
      },
      {
        Text = _Tho("l!\v\022\027\021N_ZO\021(_V\022\027\v_Z\021\027CVT\021N!\021_ZO_\0216g\vN_\021C!mp_V\022\027\v_\022eT\fE\"$bE\"$bP5},\021\017\021\017\021\017E\"$bE\"$b$_p_^\021z\028\021\"^_Z\019\021V\024g\vT^Z\022\027\021'\021\v_ZV_\021^_Z\022\027T\f")
      }
    }, function(action)
      _HR3SQ = _Tho("$_p_^\021\b\028\021\t_Z\021^_ZV_\021ZO\021\ag%\019Z_^CON\017E\"$b'''E\"$b$_p_^\021z\028\021\"^_Z\019\021V\024g\vT^Z\022\027\021'\021\v_ZV_\021^_Z\022\027T\f")
      zone_projection(zone_boot, Wherigo.ZonePoint(52.4966935083981, 13.40485855937, 0), 110, 300, 20, 1)
      _tB8V.Active = true
      _tB8V.Visible = true
      zone_boot.Active = true
      _zMZ.Active = true
      _iuxF = 1
      Wherigo.PlayAudio(_IrJu0)
      _XfU:Start()
      _lHfPE:Start()
      _CHGn()
    end)
  end)
end
function _CHGn()
  vHorde = 2
  radiusHorde = 10
  formHorde = 0
  zone_projection(horde_zone, Player.ObjectLocation, 240, 100, radiusHorde, formHorde)
  horde_zone.Active = true
  _lqy = 1
  _o37E = 0
  _epk:Start()
end
function _VL8kU()
  _epk.Type = "Countdown"
  _epk.Duration = 10
  _epk:Stop()
  _TIo15.Type = "Countdown"
  _TIo15.Duration = 10
  _TIo15:Stop()
  _XfU.Type = "Countdown"
  _XfU.Duration = 10
  _XfU:Stop()
  horde_zone.Active = false
  _BpyFc.Active = false
  zombie_zone.Active = false
  zone_boot.Active = false
  zone_boot.Visible = false
  _zMZ.Active = false
  _vKBT1:RequestSync()
end
function _OdE()
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("l!\021V\022\027\031ZOpVT\021NZ\022\027\021ZO\021^_TDT_\v\021\t_e!ON_\021!_\019_\v\021NCV\021(_^C_ON_\v\021!ON\021V\024\vZOpVT\021ZO\021NCV\021\"ggT\fE\"$bE\"$bl}\02165\tj\021l~\\6\021(\127$\127jj\127j\017")
    },
    {
      Text = _Tho("dg\v_\vVT\f")
    }
  }, function(action)
    Wherigo.PlayAudio(_eOEP)
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021^CON_VT\021C!m\021N_%\021l_\022e\f\021d_\vNC%%T\026\021Z\vp_ON\031CV\021eOC\022eT\021ZO\021N_ZO_%\021UOg_\022\027_^\f")
      },
      {
        Text = _Tho("l_\v\021\t\022\027%_\vD\021eg%%T\021^COpVC%\026\021C\019_\v\021_\v\021eg%%T\f\021l!\021VTg_\027OVT\021!ON\021V\022\027\v_ZVT\021C!m\026\021e^ZOpVT\021NC\019_Z\021V_^\019VT\021\031Z_\021_ZO\021}OTgT_\v\fE\"$bE\"$bK\019_O\021C!m\021N_\v\021\"\v!_\022e_\021VT_\027_O\021NZ_\021\ag%\019Z_V\021!ON\021I_\vV!\022\027_O\021NCV\021(_^C_ON_\v\021D!\021!_\019_\v\031ZON_O\fE\"$bE\"$b\127ZO\021\024CC\v\021IgO\021Z\027O_O\021mC^^_O\021eOC\024\024\021C%\021\"ggT\021Ig\v\019_Z\026\021_ZO_\v\021IgO\021Z\027O_O\021V\024Z_VVT\021VZ\022\027\021C!m\021N_\v\021$_^ZOp\021C!m\f\021\127\022\027T\021_e^Zp\017E\"$bE\"$blZ_\021\"ggTV\019_VZTD_\v\021\031_\vN_O\021VZ\022\027\021\031C\027\vV\022\027_ZO^Z\022\027\021TgTC^\021m!_\v\022\027T_O\f")
      },
      {
        Text = _Tho("8PK~R(E\"$blCV\021\027CVT\021N!\021OZ\022\027T\021eg%%_O\021V_\027_O\017"),
        Media = _Eqb
      },
      {
        Text = _Tho("l!\021%_\veVT\021Og\022\027\021_ZO_O\021N!%\024m_O\021\t\022\027^Cp\021ZO\021N_ZO_%\021(_OZ\022e\026\021NCOC\022\027\021eOZ\024VT\021NZ\v\021y_%CON\021NZ_\021PZ\022\027T_\v\021C!V\021\f\f\f"),
        Media = _Pbf_L
      },
      {
        Text = _Tho("\t\022\027gO\021\031Z_N_\v\021!%\027!_^^T\021NZ\022\027\021NZ_V_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\fE\"$bE\"$b\"_pZ\019\021NZ\022\027\021NZ\022\027\021O!O\021D!\v\021\agO_\021Y\127\v\031C\022\027_OY\021\026\021NC%ZT\021N!\021\031Z_N_\v\021D!\021NZ\v\021eg%%_O\021eCOOVT\f"),
        Media = _L5U
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      _5v84r.Active = true
      _xaHsG.Active = true
      _1Xiq.Active = true
      _1Xiq.Visible = true
      _vKBT1:RequestSync()
    end)
  end)
end
function _S6s()
  vZombie = 1
  radiusZombie = 3
  formZombie = 2
  zone_projection(zombie_zone, Player.ObjectLocation, 330, 50, radiusZombie, formZombie)
  zombie_zone.Active = true
  _T1D = 1
  _o37E = 1
  _TIo15:Start()
end
function _5I0z()
  _Urwigo.Dialog(false, {
    {
      Text = _Tho("(_\vCN_\021ZO\021N_%\021Ag%_OT\026\021C^V\021N!\021%ZT\021AC\v^_ \021NCV\021\"ggT\021I_\v^C_VVT\026\021VZ_\027VT\021N!\021_ZO_\021\027CONIg^^\021}OTgT_\v\021C!m\021_!\022\027\021D!\021eg%%_O\f\021AC\v^_ \021\031Z\vN\021_V\021%ZT\021V_ZO_%\021\015!Op_O\021OZ\022\027T\021V\022\027Cmm_O\021D!\021_OTeg%%_O\026\021N_O\021Vg\021V\022\027O_^^\021\019_eg%%T\021_\v\021NCV\021\"ggT\021OZ\022\027T\021VTC\vTe^C\v\f")
    },
    {
      Text = _Tho("l!\021\031Z\vVT\021NZ\022\027\021y_TDT\021_OTV\022\027_ZN_O\021%!_VV_O\026\021\031_^\022\027_\v\021A_OV\022\027\021N!\021\031_\vN_O\021\031Z^^VT\f\021E\"$bPC_VVT\021N!\021NZ_\021\019_ZN_O\021Z%\021\tTZ\022\027\026\021NCOO\021\031Z\vVT\021N!\021p_O!p\021\a_ZT\021\027C\019_O\021!%\021D!\021_OTeg%%_O\f\021\"_N_Oe_\026\021m!_\v\021N_ZO\0216CON_^O\021T\vC_pVT\021N!\021NZ_\021UgOV_|!_OD_O\026\021_V\021VZON\021N_ZO_\021\127OTV\022\027_ZN!Op_O\fE\"$b\127OTV\022\027_ZN_VT\021N!\021NZ\022\027\021\027ZOp_p_O\021m!_\v\021NZ_\021\019_ZN_O\026\021NCOO\021\027CVT\021N!\021Gr\021\t_e!ON_O\021\a_ZT\026\021_T\031CV\021D!\v\021d_\vT_ZNZp!Op\021D!\021mZON_O\f\021dZ_^^_Z\022\027T\021eg%%T\021NZ\v\021NCV\021Z\vp_ON\031COO\021%C^\021D!\021(!T_\fE\"$b2\127pC^\021\031_^\022\027_O\021s_p\021N!\021_ZOV\022\027^C_pVT\026\021_V\021ZVT\021Z%%_\v\021%g_p^Z\022\027\021NCV\021\127ON_\021N_V\021\t\024Z_^V\021D!\021_\v\v_Z\022\027_O\026\021%C^\021V\022\027_ZO\019C\v\021^_Z\022\027T_\v\021gN_\v\021C!\022\027\021V\022\027\031_\v_\vW\f")
    }
  }, function(action)
    _Urwigo.MessageBox({
      Text = _Tho("5\028E\"$bd_\vNC%%T\021Z\022\027\021\031Z^^\021^_\019_O\026\021%_ZO_\021,C%Z^Z_\021\031Z_N_\vV_\027_O\f\021\"ZV\021D!\v\021sC\022\027_\021ZVT\021_V\021OZ\022\027T\021\031_ZT\f\021~\022\027\021\027C!\021C\019\fE\"$bE\"$b\"\028\021E\"$blZ_\021\019_ZN_O\021\027C\019_O\021%Z\v\021N_O\0215\vV\022\027\021p_\v_TT_T\f\021K\027O_\021VZ_\021\031C_\v_\021Z\022\027\021y_TDT\021V\022\027gO\021TgT\f\021lCV\021\019ZO\021Z\022\027\021Z\027O_O\021V\022\027!^NZp\f\021~\022\027\021\019^_Z\019_\021\027Z_\v\026\021C!\022\027\021\031_OO\021Z\022\027\021NC\019_Z\021N\vC!m\021p_\027_\f"),
      Buttons = {
        _Tho("5"),
        _Tho("\"")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _IBsb.Active = false
            _xaHsG.Active = false
            _rh69.Active = true
            _w8b8Z.Active = true
            _Vt1 = true
            print("gegen marley entschieden")
            _Urwigo.Dialog(false, {
              {
                Text = _Tho("l!\021\027CVT\021NZ\022\027\021_OTV\022\027Z_N_O\021D!\021^_\019_O\f\021~O\021NZ_V_%\021Ag%_OT\021V\024!_\vVT\021N!\026\021\031Z_\021_ZO\021j_Z^\021IgO\021NZ\v\021TZ_m\021Z%\021~OO_\v_O\021VTZ\v\019T\f\021\127V\021V\022\027!_TT_^T\021VZ\022\027\021NZ\v\021\019_Z\021NZ_V_%\021(_NCOe_O\f\021\127pC^\026\021N!\021%!VVT\021y_TDT\021eC^T\019^!_TZp\021V_ZO\fE\"$bE\"$b6ZOT_\v\021NZ\v\021\027g_\vVT\021N!\021N_O\021I_\vD\031_Zm_^T_O\021UC%\024m\021!ON\021NZ_\021\t\022\027\v_Z_\021IgO\021AC\v^_ \021!ON\021N_VV_O\021\tg\027O\f\021l!\021\031CpVT\021_V\021OZ\022\027T\021NZ\022\027\021!%D!N\v_\027_O\f\021\t\022\027O_^^\021p_\027VT\021N!\021\031_ZT_\v\021\f\f\f\021")
              }
            }, function(action)
              _kvkDf.Active = true
              _kvkDf.Visible = true
              _OCIO.Active = true
              _OCIO.Visible = true
              _bxfl.Active = true
              _bxfl.Visible = true
              _vKBT1:RequestSync()
            end)
          else
            _Urwigo.Dialog(false, {
              {
                Text = _Tho("Ke\026\021I_\v^Z_\v\021e_ZO_\021\a_ZT\f\021\t!\022\027_\021Z\vp_ON\021_T\031CV\021\"\vC!\022\027\019C\v_V\021C%\021}m_\v\021D!%\021d_\vT_ZNZp_O\f\021l_Oe\021CO\021AC\v^_ V\021sg\vT_\026\021NC%ZT\021%!_VV_O\021VZ\022\027\021Ug_\024m_\021N!\v\022\027\019g\027\v_O\021^CVV_O\fE\"$bE\"$blZ_\021\a_ZT\021DC_\027^T\026\021\031_OO\021N!\021KU\021N\v!_\022eVT\f\021l!\021\027CVT\021Gr\021\t_e!ON_O\021\a_ZT\021\019ZV\021NZ\022\027\021NZ_\021\ag%\019Z_V\021_\v\v_Z\022\027_O\f\021}ON\021VZ_\021VZON\021V_____\027\v\021\027!Op\vZp\fE\"$b\t\022\027!%%_^O\021p_\027T\021!_\019\vZp_OV\021OZ\022\027T\026\021N!\021eCOOVT\021_\vVT\021_T\031CV\021mZON_O\021\031_OO\021N_\v\021\\g!OTNg\031O\021VTC\vT_T\fE\"$bE\"$b26ZO\031_ZV\028\0215!m\021N_\v\021UC\vT_\021\031Z\vN\021NZ\v\021NZ_\021\agO_\021}m_\v\021COp_D_ZpTW")
              }
            }, function(action)
              _Mbcll.Active = true
              _Mbcll.Visible = false
              _Vt1 = false
              _Hqto:MoveTo(_IBsb)
              _Hqto.Visible = true
              _f7Ng:Start()
            end)
          end
        end
      end
    })
  end)
end
function _uZYu()
  if _5Q86M < _E8GOf then
    spielzeit = _E8GOf - _5Q86M
  else
    spielzeit = 86400 - _5Q86M
    spielzeit = spielzeit + _E8GOf
  end
  if spielzeit > 60 then
    _ia8g = _Urwigo.Floor(spielzeit / 60, 0)
    _r1Y = spielzeit % 60
  else
    _r1Y = spielzeit
  end
end
function _HN7_a()
  vZombie = 1
  radiusZombie = 2
  formZombie = 2
  zone_projection(zombie_zone, Player.ObjectLocation, 100, 30, radiusZombie, formZombie)
  zombie_zone.Active = true
  _fibu.Visible = true
  _T1D = 1
  _TIo15.Type = "Interval"
  _TIo15.Duration = 1
  _o37E = 2
  _TIo15:Start()
end
function _yxlLt()
  vHorde = 1
  radiusHorde = 2
  formHorde = 2
  zone_projection(horde_zone, Player.ObjectLocation, 100, 30, radiusHorde, formHorde)
  horde_zone.Active = true
  _FPS.Visible = true
  _lqy = 1
  _2Wu = 0
  _epk.Type = "Interval"
  _epk.Duration = 1
  _o37E = 3
  _epk:Start()
end
function _ThHCZ()
  vKontaktmann = 1.5
  radiusKontaktmann = 2
  formKontaktmann = 2
  zone_projection(kontaktmann_zone, Wherigo.ZonePoint(fixpunkte1[1], fixpunkte1[2], 0), 0, 0, radiusKontaktmann, formKontaktmann)
  kontaktmann_zone.Active = true
  _gJUJ = 1
  zaehlerFixpunkte = 3
  _tM3Xb.Active = false
  _g7wf:Start()
end
function _6cW()
  if _4Vw == true then
    vKontaktmann = 3.5
  else
    vKontaktmann = 4
  end
  radiusKontaktmann = 2
  formKontaktmann = 2
  zone_projection(kontaktmann_zone, Wherigo.ZonePoint(fixpunkte2[1], fixpunkte2[2], 0), 0, 0, radiusKontaktmann, formKontaktmann)
  kontaktmann_zone.Active = true
  _gJUJ = 1
  zaehlerFixpunkte = 3
  _KiTpv.Type = "Interval"
  _KiTpv.Duration = 1
  _P4V.Active = true
  _KiTpv:Start()
  _5Kbhq()
end
function _wWT()
  _kvkDf.Complete = true
  _0THsQ.Active = true
  __rQd.Active = true
  _0Q8.Visible = true
  _DuxZO.Visible = true
  _0Q8.Commands._cpB.Enabled = true
  _0Q8.Commands._ElJef.Enabled = true
  _Oayl.Commands._gQ7N.Enabled = false
  _5K7e.Commands._4AAZ.Enabled = false
  _Hqto.Visible = false
  _13nA5:Start()
  _mFU:Start()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _KE2M()
  local _Urwigo_Date = os.date("*t")
  _E8GOf = _Urwigo.Date_SecondInDay(_Urwigo_Date)
  _uZYu()
  if _Rdw0 == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("K\027\021%_ZO\021(gTT\f\021l!\021\v_OOVT\021ZO\021NZ_\021\vZ_VZp_\0216g\vN_\021\027ZO_ZO\f\021lCV\021ZVT\021Ng\022\027\021NZ_\021\t\024Z_^m_^N\019_p\v_OD!Op\fE\"$blZ_\021\ag%\019Z_V\021mC^^_O\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027_O\021NZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021NZ\v\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif (_Rdw0 == 1 and _o37E == 0) == true then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\f\021\003O\019V\024\018lZ_\0216g\vN_\021mC_^^T\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027T\021NZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021NZ\v\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif (_Rdw0 == 2 and _o37E == 1) == true then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\f\021\003O\019V\024\018l_\v\021\ag%\019Z_\021mC_^^T\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027T\021NZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021NZ\v\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif _Rdw0 == 3 then
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("d_\vNC%%T\026\021l!\021\031C\vVT\021_OT\031_N_\v\021D!\021^COpVC%\021gN_\v\021N_ZO\021\t%C\vT\024\027gO_\021\027CT\021OZ\022\027T\021\v_CpZ_\vT\0212ZO\021NZ_V_%\021,C^^\026\021\b\021\t_e!ON_\021\031C\vT_O\026\021NZ_\021\\8}\021\027CT\021p_\vCN_\021IZ_^\021C\019D!C\v\019_ZT_O\026\021NZ_V_V\021\t\024Z_^\021ZVT\021V_\027\v\021eg%\024^_\002W\f\021sZ_\021I_\v\v!_\022eT\021\027C_%%_\vVT\021N!\021C!m\021N_%\021\"Z^NV\022\027Z\v%\021\v!%\f\021RC\021\031Z_\021C!\022\027\021Z%%_\v\026\021NCVV\021\v_TT_ON_\021\"ggT\021ZVT\021\031_p\fE\"$bE\"$bl!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\f\021\003O\019V\024\018lZ_\021\ag%\019Z_V\021mC^^_O\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027_O\021lZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021N_ZO_%\021,^_ZV\022\027\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      },
      {
        Text = _Tho("Ug%%\026\021\024\vg\019Z_\v\021_V\021p^_Z\022\027\021Og\022\027%C^\f\021~\022\027\021\027C\019_\021NZ_V_\0215\vT\021N_V\021\t\024Z_^V\021_\002T\vC\021CO\021N_O\0215OmCOp\021p_^_pT\026\021NC%ZT\021%CO\021VZ\022\027\021\003O\019V\024\018C!V\024\vg\019Z_\v_O\021eCOO\026\021g\027O_\021Z%\021mg\vTp_V\022\027\vZTT_O_O\021\t\024Z_^\021Ng\022\027\021Og\022\027\021D!\021VT_\v\019_O\f"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif (_Rdw0 == 2 and _o37E == 2) == true then
    _0THsQ.Active = false
    _mFU.Type = "Countdown"
    _mFU.Duration = 10
    _mFU:Stop()
    _wxWWG()
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\f\021\003O\019V\024\018l_\v\021\ag%\019Z_\021mC_^^T\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027T\021NZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021NZ\v\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      },
      {
        Text = _Tho("l!\021\019ZVT\021DZ_%^Z\022\027\021\031_ZT\021p_eg%%_O\f\021l_V\027C^\019\021NC\vmVT\021N!\021NZ\022\027\021ZOV\021Pgp\019!\022\027\021N_\v\021}OTgT_O\021_ZOT\vCp_O\f\021s_OO\021N!\021\031ZVV_O\021\031Z^^VT\026\021g\019\021N_ZO_\021,C%Z^Z_\021!_\019_\v^_\019T\021\027CT\026\021NCOO\021V\024Z_^_\021Og\022\027%C^\021!ON\021_OTV\022\027_ZN_\021NZ\022\027\021m!_\v\021AC\v^_ \f\021\127V\021ZVT\021NCOO\021eC!%\021%_\027\v\021%g_p^Z\022\027\021D!\021VT_\v\019_O\026\021Ig\vC!Vp_V_TDT\021N!\021eCOOVT\021_T\031CV\021\v_OO_O\021!ON\021V\022\027CmmVT\021_V\021\019_Z%\021OC_\022\027VT_O\021AC^\021NZ_\021\ag%\019Z_V\021\027Z_\v\021D!\021Tg_T_O\fE\"$bE\"$blCD!\021Og\022\027\021_ZO\021e^_ZO_\v\021jZ\024\f\021PCN_\021NCV\021(_\031_\027\v\021Ig\v\027_\v\026\021p_\027_\021C!m\021N_O\021\"_m_\027^\021YV\022\027Z_VV_OY\021!ON\021\019^_Z\019_\021OZ\022\027T\021VT_\027_O\f\021l_\v\021\ag%\019Z_\021\019_\031_pT\021VZ\022\027\021%ZT\021\b%\014V\021C!m\021NZ\022\027\021D!\f\021s_OO\021N!\021\v!_\022e\031C_\vTV\021^C_!mVT\026\021NCOO\021eCOO\021N_\v\021NZ\022\027\021OZ\022\027T\021_\v\031ZV\022\027_O\f\021PCVV\021N_O\021\ag%\019Z_\021^COpVC%\021NZ_\021(\v_OD_\021IgO\021zr%\021!OT_\vV\022\027\v_ZT_O\021!ON\021\019C^^_\v\021Z\027O\021C\019\f\021dZ_^\021\127\vmg^p\017"),
        Media = _ej1
      },
      {
        Text = _Tho("~%\021~OI_OTC\v\021mZON_VT\021N!\021NZ_\021Ugg\vNZOCT_O\026\021N!\021eCOOVT\021NZ\022\027\021C\019_\v\021C!\022\027\021D!\v\021Pgp\019!\022\027'\agO_\021OCIZpZ_\v_O\021^CVV_O\fE\"$bj\vCp_\021NZ\022\027\021\019ZTT_\021OZ\022\027T\021ZO\021NCV\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O\021_ZO\017"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif (_Rdw0 == 1 and _o37E == 3) == true then
    _0THsQ.Active = false
    _wxWWG()
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("l!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\f\021\003O\019V\024\018lZ_\0216g\vN_\021mC_^^T\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027T\021NZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021NZ\v\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      },
      {
        Text = _Tho("l!\021\019ZVT\021DZ_%^Z\022\027\021\031_ZT\021p_eg%%_O\f\021l_V\027C^\019\021NC\vmVT\021N!\021NZ\022\027\021ZOV\021Pgp\019!\022\027\021N_\v\021}OTgT_O\021_ZOT\vCp_O\f\021s_OO\021N!\021\031ZVV_O\021\031Z^^VT\026\021g\019\021N_ZO_\021,C%Z^Z_\021!_\019_\v^_\019T\021\027CT\026\021NCOO\021V\024Z_^_\021Og\022\027%C^\021!ON\021_OTV\022\027_ZN_\021NZ\022\027\021m!_\v\021AC\v^_ \f\021\127V\021ZVT\021NCOO\021eC!%\021%_\027\v\021%g_p^Z\022\027\021D!\021VT_\v\019_O\026\021Ig\vC!Vp_V_TDT\021N!\021eCOOVT\021_T\031CV\021\v_OO_O\021!ON\021V\022\027CmmVT\021_V\021\019_Z%\021OC_\022\027VT_O\021AC^\021NZ_\021\ag%\019Z_V\021\027Z_\v\021D!\021Tg_T_O\fE\"$bE\"$blCD!\021Og\022\027\021_ZO\021e^_ZO_\v\021jZ\024\f\021PCN_\021NCV\021(_\031_\027\v\021Ig\v\027_\v\026\021p_\027_\021C!m\021N_O\021\"_m_\027^\021YV\022\027Z_VV_OY\021!ON\021\019^_Z\019_\021OZ\022\027T\021VT_\027_O\f\021lZ_\0216g\vN_\021\019_\031_pT\021VZ\022\027\021%ZT\021\b%\014V\021C!m\021NZ\022\027\021D!\f\021s_OO\021N!\021\v!_\022e\031C_\vTV\021^C_!mVT\026\021NCOO\021eCOO\021NZ\022\027\021NZ_\0216g\vN_\021OZ\022\027T\021_\v\031ZV\022\027_O\f\021PCVV\021NZ_\0216g\vN_\021^COpVC%\021NZ_\021(\v_OD_\021IgO\021zr%\021!OT_\vV\022\027\v_ZT_O\021!ON\021\019C^^_\v\021VZ_\021C\019\f\021(_p_\019_O_OmC^^V\021%_\027\v%C\027^V\021\031_p\v_OO_O\021!ON\021\vCOeg%%_O\021^CVV_O\f\021dZ_^\021\127\vmg^p\017"),
        Media = _ej1
      },
      {
        Text = _Tho("~%\021~OI_OTC\v\021mZON_VT\021N!\021NZ_\021Ugg\vNZOCT_O\026\021N!\021eCOOVT\021NZ\022\027\021C\019_\v\021C!\022\027\021D!\v\021Pgp\019!\022\027'\agO_\021OCIZpZ_\v_O\021^CVV_O\fE\"$bj\vCp_\021NZ\022\027\021\019ZTT_\021OZ\022\027T\021ZO\021NCV\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O\021_ZO\017"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif _Rdw0 == 4 then
    _wxWWG()
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("\127\vZOO_\vVT\021N!\021NZ\022\027\021CO\021NZ_\021sg\vT_\021IgO\021AC\v^_ <E\"$bE\"$b\127\v\021VCpT_\028\021Y\"^_Z\019_\021!O\019_NZOpT\021C\019V_ZTV\021N_V\0216C!\024T\031_p_V\021Ig%\0216Cm_O\021D!%\0215!VV_O\024gVT_O\fYE\"$bE\"$bR!O\021\019ZVT\021N!\021jKj\f\021E\"$b"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      },
      {
        Text = _Tho("l!\021\019ZVT\021DZ_%^Z\022\027\021\031_ZT\021p_eg%%_O\f\021l_V\027C^\019\021NC\vmVT\021N!\021NZ\022\027\021ZOV\021Pgp\019!\022\027\021N_\v\021}OTgT_O\021_ZOT\vCp_O\f\021s_OO\021N!\021\031ZVV_O\021\031Z^^VT\026\021g\019\021N_ZO_\021,C%Z^Z_\021!_\019_\v^_\019T\021\027CT\026\021NCOO\021V\024Z_^_\021Og\022\027%C^\021!ON\021_OTV\022\027_ZN_\021NZ\022\027\021m!_\v\021AC\v^_ \f\021\127V\021ZVT\021NCOO\021eC!%\021%_\027\v\021%g_p^Z\022\027\021D!\021VT_\v\019_O\026\021NC\021NZ\v\021AC\v^_ \021\027Z_\v\021D!\v\0216Z^m_\021_Z^T\f\021\003O\019V\024\018KN_\v\021N!\021!%p_\027VT\021N_O\0216ZOT_\v\027C^T\026\021ZON_%\021N!\021\v_\022\027TV\021gN_\v\021^ZOeV\021C!m\021N_%\021(_\027\031_p\021\019^_Z\019VT\fE\"$blCOC\022\027\021%!VVT\021N!\021O!\v\021Og\022\027\021_T\031CV\021\v_OO_O\021eg_OO_O\021!ON\021N!\021\027CVT\021yC\021V\022\027gO\021p_D_ZpT\026\021NCVV\021N!\021NCV\021eCOOVT\017E\"$bE\"$bdZ_^\021\127\vmg^p\017"),
        Media = _ej1
      },
      {
        Text = _Tho("~%\021~OI_OTC\v\021mZON_VT\021N!\021NZ_\021Ugg\vNZOCT_O\026\021N!\021eCOOVT\021NZ\022\027\021C\019_\v\021C!\022\027\021D!\v\021Pgp\019!\022\027'\agO_\021OCIZpZ_\v_O\021^CVV_O\fE\"$bj\vCp_\021NZ\022\027\021\019ZTT_\021OZ\022\027T\021ZO\021NCV\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O\021_ZO\017"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  elseif (_Rdw0 == 1 and _o37E == 4) == true then
    _P4V.Active = false
    _KiTpv.Type = "Countdown"
    _KiTpv.Duration = 10
    _KiTpv:Stop()
    _wxWWG()
    _Urwigo.Dialog(false, {
      {
        Text = _Tho("d_\vNC%%T\f\021sZ_\021egOOT_\021NCV\021N_OO\021Vg\021e!\vD\021Ig\v\021N_%\021\aZ_^\021Og\022\027\021\024CVVZ_\v_O<\021E\"$bE\"$bl!\021\027CVT\021_V\021OZ\022\027T\021p_V\022\027CmmT\f\021lZ_\0216g\vN_\021mC_^^T\021!_\019_\v\021NZ\022\027\021\027_\v\021!ON\021D_\vm^_ZV\022\027T\021NZ\022\027\f\021l!\021%_\veVT\021\031Z_\021VZ\022\027\021NZ_\021\aC_\027O_\021ZO\021NZ\v\021I_\v\019_ZVV_O\fE\"$b\tTC\ve\021_OTe\vC_mT_T\026\021p_\vCN_\021C!V\021N_%\021Ug%C\021_\v\031C\022\027T\026\021\027CTT_VT\021N!\021_ZOmC\022\027\021e_ZO_\021\\\027CO\022_\f\021U!\vD\021\019_Ig\v\021NZ\022\027\021\031Z_N_\v\021NZ_\021I_\vT\vC!T_\021l!Oe_^\027_ZT\021_ZOmC_OpT\026\021m\vCpVT\021N!\021NZ\022\027\026\021\031Z_\021_V\021N_ZO_\v\021,\vC!\021!ON\021N_ZO_\v\021jg\022\027T_\v\021_\vpCOp_O\021ZVT\f\0216gmm_OT^Z\022\027\021pZOp\021_V\021V\022\027O_^^\f\021l!\021\031Z\vVT\021_V\021OZ_\021_\vmC\027\v_O\fE\"$bE\"$bl}\021\"~\tj\021jKj\021\017"),
        Media = _ej1
      },
      {
        Text = (((_Tho("l!\021\027CVT\021") .. _ia8g) .. _Tho("\021AZO!T_O\021!ON\021")) .. _r1Y) .. _Tho("\021\t_e!ON_O\021!_\019_\v^_\019T\f"),
        Media = _ej1
      },
      {
        Text = _Tho("l!\021\019ZVT\021DZ_%^Z\022\027\021\031_ZT\021p_eg%%_O\f\021l_V\027C^\019\021NC\vmVT\021N!\021NZ\022\027\021ZOV\021Pgp\019!\022\027\021N_\v\021}OTgT_O\021_ZOT\vCp_O\f\021s_OO\021N!\021\031ZVV_O\021\031Z^^VT\026\021g\019\021N_ZO_\021,C%Z^Z_\021!_\019_\v^_\019T\021\027CT\026\021NCOO\021V\024Z_^_\021Og\022\027%C^\fE\"$bE\"$bl!\021e_OOVT\021y_TDT\021NZ_\021Pg_V!Op\021N_V\021\t\024Z_^V\f\021E\"$bE\"$b\127V\021ZVT\021NCOO\021OZ\022\027T\021%_\027\v\021%g_p^Z\022\027\021D!\021VT_\v\019_O\026\021IZ_^^_Z\022\027T\021OZ%%VT\021N!\021\027Z_\v\021^Z_\019_\v\021_ZO\021,C\027\v\vCN<E\"$bE\"$bdZ_^\021\127\vmg^p\017"),
        Media = _ej1
      },
      {
        Text = _Tho("~%\021~OI_OTC\v\021mZON_VT\021N!\021NZ_\021Ugg\vNZOCT_O\026\021N!\021eCOOVT\021NZ\022\027\021C\019_\v\021C!\022\027\021D!\v\021Pgp\019!\022\027'\agO_\021OCIZpZ_\v_O\021^CVV_O\fE\"$bj\vCp_\021NZ\022\027\021\019ZTT_\021OZ\022\027T\021ZO\021NCV\021Pgp\019!\022\027\021N_\v\021}_\019_\v^_\019_ON_O\021_ZO\017"),
        Media = _ej1
      }
    }, function(action)
      _vKBT1:RequestSync()
    end)
  end
end
function _5Kbhq()
  if _4Vw == true then
    vHorde = 2
  else
    vHorde = 2.7
  end
  radiusHorde = 10
  formHorde = 0
  zone_projection(horde_zone, Player.ObjectLocation, 120, 90, radiusHorde, formHorde)
  horde_zone.Active = true
  horde_zone.Visible = true
  _lqy = 1
  _epk.Type = "Interval"
  _epk.Duration = 1
  _o37E = 4
  _0Q8.Commands._ElJef.Enabled = false
  Wherigo.PlayAudio(_IrJu0)
  _epk:Start()
end
function _wxWWG()
  _vKBT1.Complete = true
  _NNR.Commands._BY5.Enabled = true
  _NNR.Visible = true
  _6bj.Active = true
  _Odm.Visible = true
  _HXw.Visible = true
  _vKBT1:RequestSync()
end
cr = "<BR>\n"
fixpunkte1 = {
  52.497313,
  13.412071,
  52.49738,
  13.41174,
  52.4972503402056,
  13.4116405248642,
  52.4973458663613,
  13.4112770855427,
  52.4974266960232,
  13.4109485149384
}
fixpunkte2 = {
  52.4974528227509,
  13.4105850756168,
  52.4977532790029,
  13.410532772541,
  52.4981380770102,
  13.4104791283607,
  52.4981392034062,
  13.4102645516396,
  52.4980993921375,
  13.4101304957007,
  52.49796,
  13.40996,
  52.4982,
  13.40881,
  52.498199,
  13.4085689999999,
  52.49814,
  13.40841,
  52.49814,
  13.40768,
  52.4981255806407,
  13.4072980284691
}
function zone_projection(zone, point, bearing, entfernung, radius, form)
  local dist = Wherigo.Distance(entfernung, "m")
  zone.OriginalPoint = Wherigo.TranslatePoint(point, dist, bearing)
  zone.Points = GetZonePoints(zone.OriginalPoint, radius, form)
end
function move_zone(zone, point, v_min, v_max)
  local entf
  local radius = 10
  local entf, b = calc_dist_bearing(zone.OriginalPoint, point)
  print(entf, b)
  local speed = entf / 10
  if v_min > speed then
    speed = v_min
  end
  if v_max < speed then
    speed = v_max
  end
  local dist = Wherigo.Distance(speed, "m")
  zone.OriginalPoint = Wherigo.TranslatePoint(zone.OriginalPoint, dist, b)
  zone.Points = GetZonePoints(zone.OriginalPoint, radius)
  return entf
end
function move_zoneConstV(zone, point, v, radius, form)
  local entf
  local entf, b = calc_dist_bearing(zone.OriginalPoint, point)
  print(entf, b)
  local dist = Wherigo.Distance(v, "m")
  zone.OriginalPoint = Wherigo.TranslatePoint(zone.OriginalPoint, dist, b)
  zone.Points = GetZonePoints(zone.OriginalPoint, radius, form)
  return entf
end
function calc_dist_bearing(pt1, pt2)
  local EARTH_RAD = 6378137
  local lat1 = math.rad(pt1.latitude)
  local lat2 = math.rad(pt2.latitude)
  local lon1 = math.rad(pt1.longitude)
  local lon2 = math.rad(pt2.longitude)
  local p1 = math.cos(lat1) * math.cos(lon1) * math.cos(lat2) * math.cos(lon2)
  local p2 = math.cos(lat1) * math.sin(lon1) * math.cos(lat2) * math.sin(lon2)
  local p3 = math.sin(lat1) * math.sin(lat2)
  local distance = math.acos(p1 + p2 + p3) * EARTH_RAD
  local dLon = math.rad(pt2.longitude - pt1.longitude)
  local y = math.sin(dLon) * math.cos(lat2)
  local x = math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(dLon)
  local brg = math.deg(math.atan2(y, x))
  if brg < 0 then
    brg = brg + 360
  end
  return distance, brg
end
function GetZonePoints(refPt, radi, forM)
  local dist = Wherigo.Distance(radi, "m")
  local dist1 = Wherigo.Distance(radi + 10, "m")
  local dist2 = Wherigo.Distance(radi + 5, "m")
  local pts = {}
  if forM == 0 then
    pts = {
      Wherigo.TranslatePoint(refPt, dist2, 0),
      Wherigo.TranslatePoint(refPt, dist, 60),
      Wherigo.TranslatePoint(refPt, dist, 120),
      Wherigo.TranslatePoint(refPt, dist2, 180),
      Wherigo.TranslatePoint(refPt, dist, 240),
      Wherigo.TranslatePoint(refPt, dist, 300)
    }
  end
  if forM == 1 then
    pts = {
      Wherigo.TranslatePoint(refPt, dist, 60),
      Wherigo.TranslatePoint(refPt, dist, 120),
      Wherigo.TranslatePoint(refPt, dist, 240),
      Wherigo.TranslatePoint(refPt, dist1, 270),
      Wherigo.TranslatePoint(refPt, dist, 300)
    }
  end
  if forM == 2 then
    pts = {
      Wherigo.TranslatePoint(refPt, dist, 0),
      Wherigo.TranslatePoint(refPt, dist, 60),
      Wherigo.TranslatePoint(refPt, dist, 120),
      Wherigo.TranslatePoint(refPt, dist, 180),
      Wherigo.TranslatePoint(refPt, dist, 240),
      Wherigo.TranslatePoint(refPt, dist, 300)
    }
  end
  return pts
end
function check_crossing(pt_a, pt_b)
  local d, richtung, entf = calculate_distance(Player.ObjectLocation, pt_a, pt_b)
  if d < 0 then
    return true
  end
  return false
end
function calculate_distance(ref_pt, p_a, p_b)
  local d, b = Wherigo.VectorToPoint(p_a, p_b)
  local d2, b2 = Wherigo.VectorToPoint(ref_pt, p_b)
  local dn = d2:GetValue("m")
  local dist = math.floor(math.sin(math.rad(b - b2)) * dn)
  return dist, math.floor(b2), math.floor(dn)
end
return _vKBT1
