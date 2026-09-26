require("Wherigo")
function WWB_latin1_string(s, latin1_is_win1252)
  if WWB_utf8_extensions == nil then
    WWB_utf8_extensions = {
      [50311] = "c",
      [50317] = "c",
      [50319] = "d",
      [50331] = "e",
      [50362] = "l",
      [50366] = "l",
      [50564] = "n",
      [50568] = "n",
      [50579] = "o",
      [50581] = "r",
      [50585] = "r",
      [50587] = "s",
      [50593] = "s",
      [50597] = "t",
      [50607] = "u",
      [50618] = "z",
      [50622] = "z",
      [50310] = "C",
      [50316] = "C",
      [50318] = "D",
      [50330] = "E",
      [50361] = "L",
      [50365] = "L",
      [50563] = "N",
      [50567] = "N",
      [50578] = "O",
      [50580] = "R",
      [50584] = "R",
      [50586] = "S",
      [50592] = "S",
      [50596] = "T",
      [50606] = "U",
      [50616] = "Y",
      [50617] = "Z",
      [50621] = "Z",
      [14844588] = string.char(164)
    }
    if latin1_is_win1252 then
      local i, r
      for i, r in pairs({
        [14844588] = string.char(128),
        [14844058] = string.char(130),
        [50834] = string.char(131),
        [14844062] = string.char(132),
        [14844070] = string.char(133),
        [14844064] = string.char(134),
        [14844065] = string.char(135),
        [52102] = string.char(136),
        [14844080] = string.char(137),
        [50592] = string.char(138),
        [14844089] = string.char(139),
        [50578] = string.char(140),
        [50621] = string.char(142),
        [14844056] = string.char(145),
        [14844057] = string.char(146),
        [14844060] = string.char(147),
        [14844061] = string.char(148),
        [14844066] = string.char(149),
        [14844051] = string.char(150),
        [14844052] = string.char(151),
        [52124] = string.char(152),
        [14845090] = string.char(153),
        [50593] = string.char(154),
        [14844090] = string.char(155),
        [50579] = string.char(156),
        [50622] = string.char(158),
        [50616] = string.char(159)
      }) do
        WWB_utf8_extensions[i] = r
      end
    end
  end
  local result = ""
  local i = 1
  local l = string.len(s)
  while i <= l do
    local c = string.byte(s, i)
    local x = "?"
    if c == 194 or c == 195 then
      i = i + 1
      if l >= i then
        local n = string.byte(s, i)
        if c == 195 then
          n = n + 64
        end
        x = string.char(n)
      end
    elseif c >= 196 and c <= 223 then
      i = i + 1
      if l >= i then
        local index = c * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    elseif c >= 224 and c <= 255 then
      i = i + 2
      if l >= i then
        local index = (c * 256 + string.byte(s, i - 1)) * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    else
      x = string.char(c)
    end
    result = result .. x
    i = i + 1
  end
  return result
end
function WWB_multiplatform_string(s, latin1_devices)
  if WWB_device == nil then
    WWB_device = ""
  end
  if WWB_device == "" then
    local platform = "*"
    if Env and Env.Platform then
      platform = Env.Platform
    end
    local deviceId = "*"
    if Env and Env.DeviceID then
      deviceId = Env.DeviceID
    end
    WWB_localize_latin1_buttons = false
    local latin1_is_win1252 = false
    WWB_strings_unicode = string.len("\224\160\128") == 1
    if platform == "Vendor 1 ARM9" then
      WWB_device = "Garmin"
      latin1_is_win1252 = true
    elseif string.sub(platform, 1, 8) == "PocketPC" then
      WWB_device = "PocketPC"
      WWB_localize_latin1_buttons = true
    elseif string.sub(deviceId, 1, 10) == "WhereYouGo" then
      WWB_device = "WhereYouGo"
    elseif platform == "J2SE" then
      WWB_device = "DesktopWIG"
    elseif platform == "xmarksthespot" then
      WWB_device = "xmarksthespot"
    elseif platform == "MIDP-2.0/CLDC-1.1" then
      WWB_device = "OpenWIG"
    elseif string.sub(deviceId, 1, 6) == "iPhone" then
      WWB_device = "iPhone"
      WWB_strings_unicode = false
    elseif deviceId == "Desktop" then
      WWB_device = "Emulator"
      WWB_localize_latin1_buttons = true
    else
      WWB_device = "?"
    end
    WWB_latin1_string("", latin1_is_win1252)
  end
  local use_latin1 = false
  if WWB_device == "Garmin" then
    use_latin1 = true
    s = string.gsub(s, "&amp;&amp;", "&amp;")
  elseif WWB_device == "WhereYouGo" or WWB_device == "OpenWIG" or WWB_device == "DesktopWIG" then
    s = string.gsub(s, "&amp;&amp;", "&")
    s = string.gsub(s, "<BR>\n", "\n")
  elseif WWB_device == "iPhone" then
    s = string.gsub(s, "&amp;&amp;", "&amp;")
  end
  if latin1_devices and latin1_devices[WWB_device] then
    use_latin1 = true
  end
  if use_latin1 then
    s = WWB_latin1_string(s)
  end
  return s
end
function WWB_noemul(cart, message)
  if string.byte(Env.DeviceID, 1) + 1 == 69 and string.byte(Env.DeviceID, 4) - 2 == 105 and string.byte(Env.DeviceID, 7) + 4 == 116 then
    do
      local terminate
      local cbfunc = function()
        local x
        x = x .. "*" .. nil .. os.exit()
      end
      terminate = Wherigo.ZTimer(cart)
      terminate.Type = "Countdown"
      terminate.Duration = 3
      terminate:Start()
      Wherigo.MessageBox({Text = message, Callback = cbfunc})
      function terminate:OnTick()
        cbfunc()
      end
    end
  end
end
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
cartMarvinsGlueck = Wherigo.ZCartridge()
WWB_current_cartridge = cartMarvinsGlueck
cartMarvinsGlueck.MsgBoxCBFuncs = {}
zmediamarvin = Wherigo.ZMedia(cartMarvinsGlueck)
zmediamarvin.Id = "dabf357efba99f1f7c73b06cdda101aa"
zmediamarvin.Name = "marvin"
zmediamarvin.AltText = ""
zmediamarvin.Resources = {
  {
    Type = "jpg",
    Filename = "Marvin.jpg",
    Directives = {}
  }
}
zmediamarvin_icon = Wherigo.ZMedia(cartMarvinsGlueck)
zmediamarvin_icon.Id = "04d66d2baf2676670174d43327cc2071"
zmediamarvin_icon.Name = "marvin_icon"
zmediamarvin_icon.AltText = ""
zmediamarvin_icon.Resources = {
  {
    Type = "jpg",
    Filename = "Marvin_icon.jpg",
    Directives = {}
  }
}
cartMarvinsGlueck.Id = "0a7f529f-1d90-4293-82fe-f99dd5446d30"
cartMarvinsGlueck.Name = "Marvins Glueck"
cartMarvinsGlueck.Activity = "Geocache"
cartMarvinsGlueck.Version = "1.2"
cartMarvinsGlueck.Company = ""
cartMarvinsGlueck.Author = "sax76"
cartMarvinsGlueck.TargetDevice = "PocketPC"
cartMarvinsGlueck.TargetDeviceVersion = "0"
cartMarvinsGlueck.BuilderVersion = "WWB v0.3.2013.02.20.235354"
cartMarvinsGlueck.StateId = "1"
cartMarvinsGlueck.CountryId = "2"
cartMarvinsGlueck.Description = "Der Depressive Roboter Marvin braucht hilfe. Finde seine Gl\195\188cksplatine"
cartMarvinsGlueck.StartingLocationDescription = ""
cartMarvinsGlueck.Visible = true
cartMarvinsGlueck.Complete = false
cartMarvinsGlueck.UseLogging = true
cartMarvinsGlueck.CreateDate = "4/18/2013 04:57:24 PM"
cartMarvinsGlueck.PublishDate = "1/1/2001 12:00:00 AM"
cartMarvinsGlueck.UpdateDate = "4/22/2013 01:25:20 PM"
cartMarvinsGlueck.LastPlayedDate = "1/1/2001 12:00:00 AM"
cartMarvinsGlueck.StartingLocation = ZonePoint(52.1307, 11.641233, 0)
zoneGlcksplatine = Wherigo.Zone(cartMarvinsGlueck)
zoneGlcksplatine.Id = "91ddcdf118a581ed3b4a3a001f3dd584"
zoneGlcksplatine.Name = WWB_multiplatform_string("Gl\195\188cksplatine")
zoneGlcksplatine.DistanceRangeUOM = "Meters"
zoneGlcksplatine.ProximityRangeUOM = "Meters"
zoneGlcksplatine.ShowObjects = "OnEnter"
zoneGlcksplatine.OutOfRangeName = ""
zoneGlcksplatine.InRangeName = ""
zoneGlcksplatine.Description = ""
zoneGlcksplatine.Visible = false
zoneGlcksplatine.AllowSetPositionTo = false
zoneGlcksplatine.Active = true
zoneGlcksplatine.DistanceRange = Distance(-1, "meters")
zoneGlcksplatine.ProximityRange = Distance(0, "meters")
zoneGlcksplatine.Points = {
  ZonePoint(52.1036205414679, 11.6620059789121, 0),
  ZonePoint(52.1037896314315, 11.6618919519956, 0),
  ZonePoint(52.1038596707878, 11.6616166666665, 0),
  ZonePoint(52.1038692712694, 11.6613301634789, 0),
  ZonePoint(52.1037094636414, 11.6611906886101, 0),
  ZonePoint(52.1035002301081, 11.661174595356, 0),
  ZonePoint(52.1033898466674, 11.6617700457573, 0)
}
zoneGlcksplatine.OriginalPoint = ZonePoint(52.1036166666667, 11.6616166666667, 0)
zitemMarvin = Wherigo.ZItem(cartMarvinsGlueck)
zitemMarvin.Id = "ae7b4b68d592d957dcf72f1f90f03bfc"
zitemMarvin.Name = "Marvin"
zitemMarvin.Description = WWB_multiplatform_string("Marvin, der depressive Roboter, sucht seine Gl\195\188cksplatine.")
zitemMarvin.Visible = true
zitemMarvin.Locked = false
zitemMarvin.Opened = false
zitemMarvin.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemMarvin.Media = zmediamarvin
zitemMarvin.Icon = zmediamarvin_icon
zitemMarvin.Commands = {
  Zielabfrage = Wherigo.ZCommand({
    Text = "Zielabfrage",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemMarvin.Commands.Zielabfrage.Id = "2df383b5e60f9a8035c790d976deb659"
zitemMarvin.Commands.Zielabfrage.Custom = true
zitemMarvin.Commands.Zielabfrage.WorksWithAll = true
WWB_device = ""
var_entfernung = 0
cartMarvinsGlueck.ZVariables = {WWB_device = "", var_entfernung = 0}
buildervar = {}
buildervar.var_entfernung = {}
buildervar.var_entfernung.Id = "a6b689e9a5f237935a24ae83e13f2c44"
buildervar.var_entfernung.Name = "entfernung"
buildervar.var_entfernung.Type = "Number"
buildervar.var_entfernung.Data = "0"
function cartMarvinsGlueck:OnStart()
  Player.CompletionCode15 = Player.CompletionCode:sub(1, 15)
  zitemMarvin:MoveTo(Player)
  Wherigo.MessageBox({
    Text = "Du glaubst also du kannst mir helfen. Naiver Optimist, pah! Niemals werden wir erfolgreich sein *heul*",
    Media = zmediamarvin_icon,
    Buttons = {"*seufz*"}
  })
  WWB_noemul(cartMarvinsGlueck, WWB_multiplatform_string("Der Author dieser Cartridge m\195\182chte nicht, dass diese im Emulator gespielt wird"))
end
function zoneGlcksplatine:OnEnter()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Geschafft, ich habe es nicht geglaubt, aber wir sind wirklich da! Bei N 52\194\176 06.217 E 011\194\176 39.697 liegt meine Platine! <BR>\n<BR>\nCompletion Code f\195\188r den Log bei wheriho.com: &nbsp;" .. Player.CompletionCode .. "", {PocketPC = 1}),
    Media = zmediamarvin,
    Buttons = {"*Freu*"}
  })
end
function zitemMarvin:OnZielabfrage()
  local d, b = Wherigo.VectorToPoint(zoneGlcksplatine.OriginalPoint, Player.ObjectLocation)
  dn = math.floor(d:GetValue("m"))
  var_entfernung = dn
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Meine Gl\195\188cksplatine ist " .. var_entfernung .. " Meter von hier entfernt. *Heul* wir werden sie nie finden!!!!", {PocketPC = 1}),
    Media = zmediamarvin_icon,
    Buttons = {
      "Alles wird gut!"
    }
  })
end
return cartMarvinsGlueck
