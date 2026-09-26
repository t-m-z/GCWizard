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
    local deviceId = "*"
    platform = "iPhone previous version"
    if Env then
      if Env.Platform then
        platform = Env.Platform
      end
      if Env.DeviceID then
        deviceId = Env.DeviceID
      end
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
    elseif string.sub(platform, 1, 6) == "iPhone" then
      WWB_device = "iPhone"
      WWB_strings_unicode = false
    elseif deviceId == "Desktop" then
      WWB_device = "Emulator_GSP"
      WWB_localize_latin1_buttons = true
    elseif deviceId == "webwigo" then
      WWB_device = "WebWiGo"
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
function WWB_localize_split(str)
  local result = {}
  local from = 1
  local delim_from, delim_to = string.find(str, WWB_localize_delim, from, TRUE)
  while delim_from do
    table.insert(result, string.sub(str, from, delim_from - 1, TRUE))
    from = delim_to + 1
    delim_from, delim_to = string.find(str, WWB_localize_delim, from, TRUE)
  end
  table.insert(result, string.sub(str, from))
  return result
end
function WWB_localize(str)
  local split = WWB_localize_split(str)
  result = split[WWB_localize_n + 1]
  if result == nil then
    result = str
  end
  return result
end
function WWB_localize_input_handler(input_object, input_value)
  if WWB_localize_latin1_buttons then
    input_value = WWB_latin1_string(input_value)
  end
  local i = 1
  while i do
    local l = input_object.Choices[i]
    if l == nil then
      i = nil
    elseif l == input_value then
      WWB_localize_n = i - 1
      i = nil
    else
      i = i + 1
    end
  end
  input_object.WWB_cart:OnStart(true)
end
function WWB_localize_init(cart, runtime_languages)
  local rl_choices = WWB_localize_split(runtime_languages)
  if rl_choices[2] then
    Wherigo.GetInput(WWB_localize_input)
  else
    cart:OnStart(true)
  end
end
function WWB_runtime_localize_reciprocal_commands()
  if WWB_device == "Garmin" or WWB_device == "Emulator_GSP" or WWB_device == "iPhone" then
  else
    return
  end
  local ro, recip_object
  for ro, recip_object in pairs(WWB_current_cartridge.AllZObjects) do
    if recip_object.Commands ~= nil then
      local rc, recip_command
      local new_commands = {}
      local any_change = false
      for rc, recip_command in pairs(recip_object.Commands) do
        local copy_command, reciprocal_parent_object
        if tostring(recip_command) == "a ZReciprocalCommand instance" then
          local rp, recip_parent
          for rp, recip_parent in pairs(recip_command.ReciprocalObjects) do
            local po, parent_object
            for po, parent_object in pairs(WWB_current_cartridge.AllZObjects) do
              if parent_object.Id == recip_parent.Id then
                reciprocal_parent_object = parent_object
                break
              end
            end
            break
          end
        else
          reciprocal_parent_object = recip_command.WWB_fake_reciprocal_parent
        end
        if reciprocal_parent_object ~= nil then
          local pc, parent_command
          for pc, parent_command in pairs(reciprocal_parent_object.Commands) do
            if parent_command.Keyword == recip_command.Keyword then
              if WWB_device == "iPhone" then
                do
                  local tf, text_field
                  for tf, text_field in pairs({
                    "Text",
                    "EmptyTargetListText"
                  }) do
                    recip_command[text_field] = parent_command[text_field]
                  end
                end
                break
              end
              if (WWB_device == "Garmin" or WWB_device == "Emulator_GSP") and parent_command.WWB_rebuilt_reciprocal then
                copy_command = parent_command
                copy_command.WWB_fake_reciprocal_parent = reciprocal_parent_object
              end
              break
            end
          end
        end
        if copy_command ~= nil then
          any_change = true
          new_commands[rc] = copy_command
        else
          new_commands[rc] = recip_command
        end
      end
      if any_change then
        recip_object.Commands = new_commands
      end
    end
  end
end
function WWB_runtime_localize_media()
  function WWB_get_resource(object)
    if object == nil then
      return nil
    end
    local k, rldata
    for k, rldata in pairs(WWB_runtime_localize_media_data) do
      if object == rldata[WWB_localize_prev_n] then
        return rldata[WWB_localize_n]
      end
    end
    return nil
  end
  local media_fields = {"Icon", "Media"}
  local k, object
  for k, object in pairs(WWB_current_cartridge.AllZObjects) do
    local f, field
    for f, field in pairs(media_fields) do
      if object[field] ~= nil then
        local new_resource = WWB_get_resource(object[field])
        if new_resource ~= nil then
          object[field] = new_resource
        end
      end
    end
  end
end
function WWB_change_media(new_media)
  local k, rldata
  for k, rldata in pairs(WWB_runtime_localize_media_data) do
    if rldata[0] == new_media then
      return rldata[WWB_localize_n]
    end
  end
end
function WWB_change_language_author()
end
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
cart17_Black_Coin_Edition = Wherigo.ZCartridge()
WWB_current_cartridge = cart17_Black_Coin_Edition
cart17_Black_Coin_Edition.MsgBoxCBFuncs = {}
zmedia00_Alarm = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia00_Alarm.Id = "28281977f2c4491c6f0abf9e61feb492"
zmedia00_Alarm.Name = "00_Alarm"
zmedia00_Alarm.AltText = ""
zmedia00_Alarm.Resources = {
  {
    Type = "fdl",
    Filename = "alarm.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "Purr1.mp3",
    Directives = {}
  }
}
zmedia01_Parkplatz = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia01_Parkplatz.Id = "9c878653355bbbc288ce9580d4d029ff"
zmedia01_Parkplatz.Name = "01_Parkplatz"
zmedia01_Parkplatz.AltText = ""
zmedia01_Parkplatz.Resources = {
  {
    Type = "jpg",
    Filename = "01_Parkplatz.jpg",
    Directives = {}
  }
}
zmedia01_Parkplatz_leer = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia01_Parkplatz_leer.Id = "2f6a7383584d04ce412a9f7f743080ea"
zmedia01_Parkplatz_leer.Name = "01_Parkplatz_leer"
zmedia01_Parkplatz_leer.AltText = ""
zmedia01_Parkplatz_leer.Resources = {
  {
    Type = "jpg",
    Filename = "01_Parkplatz_leer.jpg",
    Directives = {}
  }
}
zmedia01_Parkplatz_voll = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia01_Parkplatz_voll.Id = "84222248c186a9f28deed9e6f6101c54"
zmedia01_Parkplatz_voll.Name = "01_Parkplatz_voll"
zmedia01_Parkplatz_voll.AltText = ""
zmedia01_Parkplatz_voll.Resources = {
  {
    Type = "jpg",
    Filename = "01_Parkplatz_voll.jpg",
    Directives = {}
  }
}
zmedia02_Eingang = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia02_Eingang.Id = "44cbb900d69f622652f1a4e9a6160026"
zmedia02_Eingang.Name = "02_Eingang"
zmedia02_Eingang.AltText = ""
zmedia02_Eingang.Resources = {
  {
    Type = "jpg",
    Filename = "02_Eingang.jpg",
    Directives = {}
  }
}
zmedia02_Stand_1 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia02_Stand_1.Id = "3a3d2f700ee16ce45b2fdc8ae2f66303"
zmedia02_Stand_1.Name = "02_Stand_1"
zmedia02_Stand_1.AltText = ""
zmedia02_Stand_1.Resources = {
  {
    Type = "jpg",
    Filename = "02_Stand_1.jpg",
    Directives = {}
  }
}
zmedia02_Stand_2 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia02_Stand_2.Id = "d60ca3e13c5ec11fe3e04438a7e1f5b6"
zmedia02_Stand_2.Name = "02_Stand_2"
zmedia02_Stand_2.AltText = ""
zmedia02_Stand_2.Resources = {
  {
    Type = "jpg",
    Filename = "02_Stand_2.jpg",
    Directives = {}
  }
}
zmedia02_Stand_3 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia02_Stand_3.Id = "d1ab7d79d6e64f0d3bcbcd551810cf83"
zmedia02_Stand_3.Name = "02_Stand_3"
zmedia02_Stand_3.AltText = ""
zmedia02_Stand_3.Resources = {
  {
    Type = "jpg",
    Filename = "02_Stand_3.jpg",
    Directives = {}
  }
}
zmedia03_Donauufer_Bastion = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia03_Donauufer_Bastion.Id = "cafdcfefd7e71d9665dd382e0c4b6f1f"
zmedia03_Donauufer_Bastion.Name = "03_Donauufer_Bastion"
zmedia03_Donauufer_Bastion.AltText = ""
zmedia03_Donauufer_Bastion.Resources = {
  {
    Type = "jpg",
    Filename = "03_Donauufer_Bastion.jpg",
    Directives = {}
  }
}
zmedia04_Eisenbahnbrcke = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia04_Eisenbahnbrcke.Id = "b5d8409b271a6b735faa767d06adaeb0"
zmedia04_Eisenbahnbrcke.Name = WWB_multiplatform_string("04_Eisenbahnbr\195\188cke")
zmedia04_Eisenbahnbrcke.AltText = ""
zmedia04_Eisenbahnbrcke.Resources = {
  {
    Type = "jpg",
    Filename = "04_Eisenbahnbruecke.jpg",
    Directives = {}
  }
}
zmedia05_Eisenbahnbrcke_Mitte = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia05_Eisenbahnbrcke_Mitte.Id = "21290a414b5fab54fb58f18634d153f5"
zmedia05_Eisenbahnbrcke_Mitte.Name = WWB_multiplatform_string("05_Eisenbahnbr\195\188cke_Mitte")
zmedia05_Eisenbahnbrcke_Mitte.AltText = ""
zmedia05_Eisenbahnbrcke_Mitte.Resources = {
  {
    Type = "jpg",
    Filename = "05_Mitte_Bruecke.jpg",
    Directives = {}
  }
}
zmedia06_Donauufer_Mitte = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia06_Donauufer_Mitte.Id = "6353f69bd7e4284b9969e6156dfba0f6"
zmedia06_Donauufer_Mitte.Name = "06_Donauufer_Mitte"
zmedia06_Donauufer_Mitte.AltText = ""
zmedia06_Donauufer_Mitte.Resources = {
  {
    Type = "jpg",
    Filename = "06_Donauufer_Mitte.jpg",
    Directives = {}
  }
}
zmedia07_Fischerpltzle = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia07_Fischerpltzle.Id = "6a7b37aa3d6ae8c6776d2d7982400b1e"
zmedia07_Fischerpltzle.Name = WWB_multiplatform_string("07_Fischerpl\195\164tzle")
zmedia07_Fischerpltzle.AltText = ""
zmedia07_Fischerpltzle.Resources = {
  {
    Type = "jpg",
    Filename = "07_Fischerplaetzle.jpg",
    Directives = {}
  }
}
zmedia07_Stadtmauer = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia07_Stadtmauer.Id = "58f73e59cc46fb98792125dc176815d5"
zmedia07_Stadtmauer.Name = "07_Stadtmauer"
zmedia07_Stadtmauer.AltText = ""
zmedia07_Stadtmauer.Resources = {
  {
    Type = "jpg",
    Filename = "07_Stadtmauer.jpg",
    Directives = {}
  }
}
zmedia07_Ufertribne = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia07_Ufertribne.Id = "9a6f81aa88c68e0ae65e0b16a1c541b6"
zmedia07_Ufertribne.Name = WWB_multiplatform_string("07_Ufertrib\195\188ne")
zmedia07_Ufertribne.AltText = ""
zmedia07_Ufertribne.Resources = {
  {
    Type = "jpg",
    Filename = "07_Ufertribuene.jpg",
    Directives = {}
  }
}
zmedia08_Tradi = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmedia08_Tradi.Id = "3cc08bcd65eedd29a719e3a73e30f467"
zmedia08_Tradi.Name = "08_Tradi"
zmedia08_Tradi.AltText = ""
zmedia08_Tradi.Resources = {
  {
    Type = "jpg",
    Filename = "08_Tradi.jpg",
    Directives = {}
  }
}
zmediabernhard = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediabernhard.Id = "5e3cf13bb206be320d1a00ab9f96aa31"
zmediabernhard.Name = "bernhard"
zmediabernhard.AltText = ""
zmediabernhard.Resources = {
  {
    Type = "jpg",
    Filename = "Bernhard.jpg",
    Directives = {}
  }
}
zmediabernhard_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediabernhard_ico.Id = "3a8a3b19af9e20bbc0f71bc97ace337a"
zmediabernhard_ico.Name = "bernhard_ico"
zmediabernhard_ico.AltText = ""
zmediabernhard_ico.Resources = {
  {
    Type = "jpg",
    Filename = "bernhard_ico.jpg",
    Directives = {}
  }
}
zmediabjoern = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediabjoern.Id = "cb88fafc4cae117a8a4bb2c328db113b"
zmediabjoern.Name = "bjoern"
zmediabjoern.AltText = ""
zmediabjoern.Resources = {
  {
    Type = "jpg",
    Filename = "bjoern.jpg",
    Directives = {}
  }
}
zmediacode = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediacode.Id = "44a7faecfaa6b60a09531c9287bc6591"
zmediacode.Name = "code"
zmediacode.AltText = ""
zmediacode.Resources = {
  {
    Type = "jpg",
    Filename = "code.jpg",
    Directives = {}
  }
}
zmediacoin_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediacoin_ico.Id = "607b1bb0ed6754ea88be213e15916835"
zmediacoin_ico.Name = "coin_ico"
zmediacoin_ico.AltText = ""
zmediacoin_ico.Resources = {
  {
    Type = "jpg",
    Filename = "Start_ico.jpg",
    Directives = {}
  }
}
zmediadigicam = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediadigicam.Id = "aed78a26d81dfebe2ae0460215384527"
zmediadigicam.Name = "digicam"
zmediadigicam.AltText = ""
zmediadigicam.Resources = {
  {
    Type = "jpg",
    Filename = "digicam.jpg",
    Directives = {}
  }
}
zmediadigicam_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediadigicam_ico.Id = "c23242b1839c2aae03747c14197109b1"
zmediadigicam_ico.Name = "digicam_ico"
zmediadigicam_ico.AltText = ""
zmediadigicam_ico.Resources = {
  {
    Type = "jpg",
    Filename = "digicam_ico.jpg",
    Directives = {}
  }
}
zmediafragezeichen = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediafragezeichen.Id = "d70a3f20d84d2360f4aa244717d1c03c"
zmediafragezeichen.Name = "fragezeichen"
zmediafragezeichen.AltText = ""
zmediafragezeichen.Resources = {
  {
    Type = "jpg",
    Filename = "fragezeichn.jpg",
    Directives = {}
  }
}
zmediafrage_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediafrage_ico.Id = "4b8108b66c8af21b4f28e17099bf8206"
zmediafrage_ico.Name = "frage_ico"
zmediafrage_ico.AltText = ""
zmediafrage_ico.Resources = {
  {
    Type = "jpg",
    Filename = "fragezeichn_ico.jpg",
    Directives = {}
  }
}
zmediagackerhaufen = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediagackerhaufen.Id = "02ecf64ecb9cce5c006ddd2f180185a5"
zmediagackerhaufen.Name = "gackerhaufen"
zmediagackerhaufen.AltText = ""
zmediagackerhaufen.Resources = {
  {
    Type = "jpg",
    Filename = "gackerhaufen.jpg",
    Directives = {}
  }
}
zmediagackerhaufen_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediagackerhaufen_ico.Id = "0f25d60e27ab60acf2a3186fb8699c11"
zmediagackerhaufen_ico.Name = "gackerhaufen_ico"
zmediagackerhaufen_ico.AltText = ""
zmediagackerhaufen_ico.Resources = {
  {
    Type = "jpg",
    Filename = "gackerhaufen_ico.jpg",
    Directives = {}
  }
}
zmediageigi22 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediageigi22.Id = "95e6fa016719848f6d170b5e96ae006d"
zmediageigi22.Name = "geigi22"
zmediageigi22.AltText = ""
zmediageigi22.Resources = {
  {
    Type = "jpg",
    Filename = "geigi22.jpg",
    Directives = {}
  }
}
zmediageigi22_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediageigi22_ico.Id = "e4b09273a6fbda5c5385fd3f33911a04"
zmediageigi22_ico.Name = "geigi22_ico"
zmediageigi22_ico.AltText = ""
zmediageigi22_ico.Resources = {
  {
    Type = "jpg",
    Filename = "geigi22_ico.jpg",
    Directives = {}
  }
}
zmediageldbeutel = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediageldbeutel.Id = "134e3d7c3f8e3e70c92b23796456ac10"
zmediageldbeutel.Name = "geldbeutel"
zmediageldbeutel.AltText = ""
zmediageldbeutel.Resources = {
  {
    Type = "jpg",
    Filename = "geldbeutel.jpg",
    Directives = {}
  }
}
zmediageld_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediageld_ico.Id = "715c3fa86f41c7c692afb2446bdb501a"
zmediageld_ico.Name = "geld_ico"
zmediageld_ico.AltText = ""
zmediageld_ico.Resources = {
  {
    Type = "jpg",
    Filename = "geldbeutel_ico.jpg",
    Directives = {}
  }
}
zmediagiga_coin = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediagiga_coin.Id = "d5b9fbd0e50ca687f3a13c8bff605f62"
zmediagiga_coin.Name = "giga_coin"
zmediagiga_coin.AltText = ""
zmediagiga_coin.Resources = {
  {
    Type = "jpg",
    Filename = "gig_coin.jpg",
    Directives = {}
  }
}
zmediagps = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediagps.Id = "91b4afdad7e451fd059324140c9783ce"
zmediagps.Name = "gps"
zmediagps.AltText = ""
zmediagps.Resources = {
  {
    Type = "jpg",
    Filename = "gps.jpg",
    Directives = {}
  }
}
zmediagps_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediagps_ico.Id = "de2304285818f66bb13acf2c2ee9e0bc"
zmediagps_ico.Name = "gps_ico"
zmediagps_ico.AltText = ""
zmediagps_ico.Resources = {
  {
    Type = "jpg",
    Filename = "gps_ico.jpg",
    Directives = {}
  }
}
zmediah1_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediah1_ico.Id = "18215998925b51f92cf8f98733f8ee10"
zmediah1_ico.Name = "h1_ico"
zmediah1_ico.AltText = ""
zmediah1_ico.Resources = {
  {
    Type = "jpg",
    Filename = "haendler_1_ico.jpg",
    Directives = {}
  }
}
zmediah2_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediah2_ico.Id = "b507bd69bb4fea79fac2bbe7422e1b37"
zmediah2_ico.Name = "h2_ico"
zmediah2_ico.AltText = ""
zmediah2_ico.Resources = {
  {
    Type = "jpg",
    Filename = "haendler_2_ico.jpg",
    Directives = {}
  }
}
zmediah3w_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediah3w_ico.Id = "115b4acf49f25e442797bb14fb585179"
zmediah3w_ico.Name = "h3w_ico"
zmediah3w_ico.AltText = ""
zmediah3w_ico.Resources = {
  {
    Type = "jpg",
    Filename = "haendlerin_3_ico.jpg",
    Directives = {}
  }
}
zmediah3_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediah3_ico.Id = "68df83d70d89ef331120947675fd6ea3"
zmediah3_ico.Name = "h3_ico"
zmediah3_ico.AltText = ""
zmediah3_ico.Resources = {
  {
    Type = "jpg",
    Filename = "haendler_3_ico.jpg",
    Directives = {}
  }
}
zmediahaendlerin_3 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediahaendlerin_3.Id = "dda15d6e8618b2bdd8df94efb266973c"
zmediahaendlerin_3.Name = "haendlerin_3"
zmediahaendlerin_3.AltText = ""
zmediahaendlerin_3.Resources = {
  {
    Type = "jpg",
    Filename = "haendlerin_3.jpg",
    Directives = {}
  }
}
zmediahaendler_1 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediahaendler_1.Id = "1db494dd21b3ec201a7b15da5a6a6d10"
zmediahaendler_1.Name = "haendler_1"
zmediahaendler_1.AltText = ""
zmediahaendler_1.Resources = {
  {
    Type = "jpg",
    Filename = "haendler_1.jpg",
    Directives = {}
  }
}
zmediahaendler_2 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediahaendler_2.Id = "a4f381622c22eff436560f32c210c226"
zmediahaendler_2.Name = "haendler_2"
zmediahaendler_2.AltText = ""
zmediahaendler_2.Resources = {
  {
    Type = "jpg",
    Filename = "haendler_2.jpg",
    Directives = {}
  }
}
zmediahaendler_3 = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediahaendler_3.Id = "c3736b993f7752695577e2363a8cd8be"
zmediahaendler_3.Name = "haendler_3"
zmediahaendler_3.AltText = ""
zmediahaendler_3.Resources = {
  {
    Type = "jpg",
    Filename = "haendler_3.jpg",
    Directives = {}
  }
}
zmediaLM_Coins = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaLM_Coins.Id = "9d33266a7689eebb30e07e0bf367b05e"
zmediaLM_Coins.Name = "LM_Coins"
zmediaLM_Coins.AltText = ""
zmediaLM_Coins.Resources = {
  {
    Type = "jpg",
    Filename = "Black_Coin_Edition_LM.jpg",
    Directives = {}
  }
}
zmediarucksack = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediarucksack.Id = "fd0a09d5d50b070ded14a1230fba345e"
zmediarucksack.Name = "rucksack"
zmediarucksack.AltText = ""
zmediarucksack.Resources = {
  {
    Type = "jpg",
    Filename = "rucksack.jpg",
    Directives = {}
  }
}
zmediarucksack_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediarucksack_ico.Id = "5dafffae44fc730ed12f17cde5306ea8"
zmediarucksack_ico.Name = "rucksack_ico"
zmediarucksack_ico.AltText = ""
zmediarucksack_ico.Resources = {
  {
    Type = "jpg",
    Filename = "rucksack_ico.jpg",
    Directives = {}
  }
}
zmediaspiegel = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaspiegel.Id = "d54b151b5a37111d0f5d9097d5b14fb5"
zmediaspiegel.Name = "spiegel"
zmediaspiegel.AltText = ""
zmediaspiegel.Resources = {
  {
    Type = "jpg",
    Filename = "spiegel.jpg",
    Directives = {}
  }
}
zmediaspiegel_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaspiegel_ico.Id = "2d476d157e71549f7c8dc81b90e40fff"
zmediaspiegel_ico.Name = "spiegel_ico"
zmediaspiegel_ico.AltText = ""
zmediaspiegel_ico.Resources = {
  {
    Type = "jpg",
    Filename = "spiegel_ico.jpg",
    Directives = {}
  }
}
zmediaSpieler = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaSpieler.Id = "9563f9034bfe1a4102574c4dfa327ce4"
zmediaSpieler.Name = "Spieler"
zmediaSpieler.AltText = ""
zmediaSpieler.Resources = {
  {
    Type = "jpg",
    Filename = "Spieler.jpg",
    Directives = {}
  }
}
zmediaStart = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaStart.Id = "41483fc568cf4818d60aa2b63f7fc3d6"
zmediaStart.Name = "Start"
zmediaStart.AltText = ""
zmediaStart.Resources = {
  {
    Type = "jpg",
    Filename = "Start.jpg",
    Directives = {}
  }
}
zmediastirnlampe = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediastirnlampe.Id = "f63a542d9006de73526572837cad2be3"
zmediastirnlampe.Name = "stirnlampe"
zmediastirnlampe.AltText = ""
zmediastirnlampe.Resources = {
  {
    Type = "jpg",
    Filename = "stirnlampe.jpg",
    Directives = {}
  }
}
zmediastirnlampe_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediastirnlampe_ico.Id = "6707a39a5890c7eadb2f47b2c0721243"
zmediastirnlampe_ico.Name = "stirnlampe_ico"
zmediastirnlampe_ico.AltText = ""
zmediastirnlampe_ico.Resources = {
  {
    Type = "jpg",
    Filename = "stirnlampe_ico.jpg",
    Directives = {}
  }
}
zmediaulmer = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaulmer.Id = "197272f971a60c5027521ad31eef8a3f"
zmediaulmer.Name = "ulmer"
zmediaulmer.AltText = ""
zmediaulmer.Resources = {
  {
    Type = "jpg",
    Filename = "ulmer.jpg",
    Directives = {}
  }
}
zmediaulmer_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaulmer_ico.Id = "e47b022d0cc4880bcf2c76661aaf03fb"
zmediaulmer_ico.Name = "ulmer_ico"
zmediaulmer_ico.AltText = ""
zmediaulmer_ico.Resources = {
  {
    Type = "jpg",
    Filename = "ulmer_ico.jpg",
    Directives = {}
  }
}
zmediaulmer_spatz = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaulmer_spatz.Id = "8f983d2c09706c402bb379db25dab4a8"
zmediaulmer_spatz.Name = "ulmer_spatz"
zmediaulmer_spatz.AltText = ""
zmediaulmer_spatz.Resources = {
  {
    Type = "jpg",
    Filename = "ulmer_spatz.jpg",
    Directives = {}
  }
}
zmediaulmer_spatz_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaulmer_spatz_ico.Id = "2009a4df8738508e2757f41c7dfa3043"
zmediaulmer_spatz_ico.Name = "ulmer_spatz_ico"
zmediaulmer_spatz_ico.AltText = ""
zmediaulmer_spatz_ico.Resources = {
  {
    Type = "jpg",
    Filename = "ulmer_spatz_ico.jpg",
    Directives = {}
  }
}
zmediaULM_Coins = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaULM_Coins.Id = "8f8037e0305b94e2437b07eacbf97d79"
zmediaULM_Coins.Name = "ULM_Coins"
zmediaULM_Coins.AltText = ""
zmediaULM_Coins.Resources = {
  {
    Type = "jpg",
    Filename = "Black_Coin_Edition.jpg",
    Directives = {}
  }
}
zmediauv_ico = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediauv_ico.Id = "052f8fb2d68c9a530701e3a986d67159"
zmediauv_ico.Name = "uv_ico"
zmediauv_ico.AltText = ""
zmediauv_ico.Resources = {
  {
    Type = "jpg",
    Filename = "uv_lampe_ico.jpg",
    Directives = {}
  }
}
zmediauv_lampe = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediauv_lampe.Id = "b6cde10c8a97303b12445769cf8427f7"
zmediauv_lampe.Name = "uv_lampe"
zmediauv_lampe.AltText = ""
zmediauv_lampe.Resources = {
  {
    Type = "jpg",
    Filename = "uv_lampe.jpg",
    Directives = {}
  }
}
zmediaU_Coins = Wherigo.ZMedia(cart17_Black_Coin_Edition)
zmediaU_Coins.Id = "978d202eda88d666bd355d4132247f6a"
zmediaU_Coins.Name = "U_Coins"
zmediaU_Coins.AltText = ""
zmediaU_Coins.Resources = {
  {
    Type = "jpg",
    Filename = "Black_Coin_Edition_U.jpg",
    Directives = {}
  }
}
cart17_Black_Coin_Edition.Id = "99117e4d-affa-46ad-b134-e09cf3f0f029"
cart17_Black_Coin_Edition.Name = "Auf der Suche nach der Black Coin Edition"
cart17_Black_Coin_Edition.Activity = "Geocache"
cart17_Black_Coin_Edition.Version = "1.7"
cart17_Black_Coin_Edition.Company = ""
cart17_Black_Coin_Edition.Author = "TuJu-TGID"
cart17_Black_Coin_Edition.TargetDevice = "PocketPC"
cart17_Black_Coin_Edition.TargetDeviceVersion = "0"
cart17_Black_Coin_Edition.BuilderVersion = "WWB v0.3.2014.02.11.013057"
cart17_Black_Coin_Edition.StateId = "1"
cart17_Black_Coin_Edition.CountryId = "2"
cart17_Black_Coin_Edition.Description = [[
Wir schreiben den 04. Oktober 2014, der Tag an dem das "Geocoinfest Europe 2014" in Ulm stattfindet. Dort gibt es auch die "Black Edition" der GFC-Coins - aber leider nur fuer Helfer.<BR>
Kaum hast du doch diese spezielle Edition ergattert, ist auch schon eine Coin des 3er-Sets verschwunden. Begib dich nun auf die Suche nach der "Black Coin Edition".<BR>
<BR>
Dies ist ein multilingualer WIG, den man auf "Schwaebisch", "Deutsch" oder "Englisch" spielen kann.<BR>
<BR>
---------------------------------<BR>
<BR>
It's the "GFC Europe 2014" in Ulm. You've heard about a "Black Coin Edition" of the GFC-Coins - but this special edition is only available for the staff. But just as you could get this "Black Coin Edition", one coin is missing. Go to the quest for the "Black Coin Edition".<BR>
<BR>
This is a multilingual WIG, that you can play in "Swabian", "German" or "English".]]
cart17_Black_Coin_Edition.StartingLocationDescription = ""
cart17_Black_Coin_Edition.Visible = true
cart17_Black_Coin_Edition.Complete = false
cart17_Black_Coin_Edition.UseLogging = true
cart17_Black_Coin_Edition.CreateDate = "8/24/2014 08:17:58 PM"
cart17_Black_Coin_Edition.PublishDate = "1/1/2001 12:00:00 AM"
cart17_Black_Coin_Edition.UpdateDate = "10/4/2014 06:50:48 AM"
cart17_Black_Coin_Edition.LastPlayedDate = "1/1/2001 12:00:00 AM"
cart17_Black_Coin_Edition.Media = zmediaStart
cart17_Black_Coin_Edition.Icon = zmediacoin_ico
cart17_Black_Coin_Edition.StartingLocation = ZonePoint(48.392167, 9.984333, 0)
zone01_Parkplatz = Wherigo.Zone(cart17_Black_Coin_Edition)
zone01_Parkplatz.Id = "d986e00ead3bd79c5c58feb2cf46e07f"
zone01_Parkplatz.Name = "01_Parkplatz"
zone01_Parkplatz.DistanceRangeUOM = "Meters"
zone01_Parkplatz.ProximityRangeUOM = "Meters"
zone01_Parkplatz.ShowObjects = "OnEnter"
zone01_Parkplatz.OutOfRangeName = ""
zone01_Parkplatz.InRangeName = ""
zone01_Parkplatz.Description = "#zone01_Parkplatz"
zone01_Parkplatz.Visible = true
zone01_Parkplatz.AllowSetPositionTo = false
zone01_Parkplatz.Active = false
zone01_Parkplatz.DistanceRange = Distance(-1, "meters")
zone01_Parkplatz.ProximityRange = Distance(0, "meters")
zone01_Parkplatz.Points = {
  ZonePoint(48.39281849868, 9.98448566143213, 0),
  ZonePoint(48.392881124593, 9.98444659558447, 0),
  ZonePoint(48.3929070650953, 9.98435228228368, 0),
  ZonePoint(48.392881124594, 9.98425796898164, 0),
  ZonePoint(48.39281849868, 9.98421890313512, 0),
  ZonePoint(48.3927558727689, 9.98425796898141, 0),
  ZonePoint(48.3927299322664, 9.98435228228368, 0),
  ZonePoint(48.3927558727692, 9.9844465955855, 0)
}
zone01_Parkplatz.OriginalPoint = ZonePoint(48.3928245176356, 9.98436686094601, 0)
zone01_Parkplatz.Media = zmedia01_Parkplatz
zone01_Parkplatz_1eer = Wherigo.Zone(cart17_Black_Coin_Edition)
zone01_Parkplatz_1eer.Id = "4a9a58d44ced42a1fbfbeb97c4411d22"
zone01_Parkplatz_1eer.Name = "01_Parkplatz_1eer"
zone01_Parkplatz_1eer.DistanceRangeUOM = "Meters"
zone01_Parkplatz_1eer.ProximityRangeUOM = "Meters"
zone01_Parkplatz_1eer.ShowObjects = "OnEnter"
zone01_Parkplatz_1eer.OutOfRangeName = ""
zone01_Parkplatz_1eer.InRangeName = ""
zone01_Parkplatz_1eer.Description = "#zone01_Parkplatz_1eer"
zone01_Parkplatz_1eer.Visible = true
zone01_Parkplatz_1eer.AllowSetPositionTo = false
zone01_Parkplatz_1eer.Active = false
zone01_Parkplatz_1eer.DistanceRange = Distance(-1, "meters")
zone01_Parkplatz_1eer.ProximityRange = Distance(0, "meters")
zone01_Parkplatz_1eer.Points = {
  ZonePoint(48.3924266047321, 9.98444699553374, 0),
  ZonePoint(48.3924805215366, 9.9844133626608, 0),
  ZonePoint(48.3925028546075, 9.98433216571811, 0),
  ZonePoint(48.3924805215366, 9.98425096877634, 0),
  ZonePoint(48.3924266047321, 9.98421733589976, 0),
  ZonePoint(48.3923726879293, 9.98425096877622, 0),
  ZonePoint(48.3923503548579, 9.98433216571811, 0),
  ZonePoint(48.3923726879293, 9.9844133626608, 0)
}
zone01_Parkplatz_1eer.OriginalPoint = ZonePoint(48.392426604735, 9.98433216571811, 0)
zone01_Parkplatz_1eer.Media = zmedia01_Parkplatz_leer
zone01_Parkplatz_voll = Wherigo.Zone(cart17_Black_Coin_Edition)
zone01_Parkplatz_voll.Id = "ddb04c646310896256a3c4415caa7a56"
zone01_Parkplatz_voll.Name = "01_Parkplatz_voll"
zone01_Parkplatz_voll.DistanceRangeUOM = "Meters"
zone01_Parkplatz_voll.ProximityRangeUOM = "Meters"
zone01_Parkplatz_voll.ShowObjects = "OnEnter"
zone01_Parkplatz_voll.OutOfRangeName = ""
zone01_Parkplatz_voll.InRangeName = ""
zone01_Parkplatz_voll.Description = "#zone01_Parkplatz_voll"
zone01_Parkplatz_voll.Visible = true
zone01_Parkplatz_voll.AllowSetPositionTo = false
zone01_Parkplatz_voll.Active = false
zone01_Parkplatz_voll.DistanceRange = Distance(-1, "meters")
zone01_Parkplatz_voll.ProximityRange = Distance(0, "meters")
zone01_Parkplatz_voll.Points = {
  ZonePoint(48.3922033459797, 9.98511218286876, 0),
  ZonePoint(48.3922572627833, 9.98507855014145, 0),
  ZonePoint(48.3922795958549, 9.98499735355381, 0),
  ZonePoint(48.3922572627833, 9.98491615696742, 0),
  ZonePoint(48.3922033459797, 9.98488252423999, 0),
  ZonePoint(48.392149429176, 9.98491615696742, 0),
  ZonePoint(48.3921270961051, 9.98499735355381, 0),
  ZonePoint(48.392149429176, 9.98507855013998, 0)
}
zone01_Parkplatz_voll.OriginalPoint = ZonePoint(48.3922033459803, 9.98499735355381, 0)
zone01_Parkplatz_voll.Media = zmedia01_Parkplatz_voll
zone02_Ausgang = Wherigo.Zone(cart17_Black_Coin_Edition)
zone02_Ausgang.Id = "e630b568fbd416cd55c102e9449419e1"
zone02_Ausgang.Name = "02_Ausgang"
zone02_Ausgang.DistanceRangeUOM = "Meters"
zone02_Ausgang.ProximityRangeUOM = "Meters"
zone02_Ausgang.ShowObjects = "OnEnter"
zone02_Ausgang.OutOfRangeName = ""
zone02_Ausgang.InRangeName = ""
zone02_Ausgang.Description = "#zone02_Ausgang"
zone02_Ausgang.Visible = true
zone02_Ausgang.AllowSetPositionTo = false
zone02_Ausgang.Active = false
zone02_Ausgang.DistanceRange = Distance(-1, "meters")
zone02_Ausgang.ProximityRange = Distance(0, "meters")
zone02_Ausgang.Points = {
  ZonePoint(48.3918521827315, 9.98527476661093, 0),
  ZonePoint(48.3919037266928, 9.98524261425803, 0),
  ZonePoint(48.3919250768999, 9.98516499161724, 0),
  ZonePoint(48.3919037266928, 9.98508736897486, 0),
  ZonePoint(48.3918521827315, 9.98505521662355, 0),
  ZonePoint(48.3918006387711, 9.98508736897486, 0),
  ZonePoint(48.3917792885628, 9.98516499161724, 0),
  ZonePoint(48.3918006387711, 9.98524261425985, 0)
}
zone02_Ausgang.OriginalPoint = ZonePoint(48.3918521827351, 9.98516499161724, 0)
zone02_Ausgang.Media = zmedia02_Eingang
zone02_Stand_1 = Wherigo.Zone(cart17_Black_Coin_Edition)
zone02_Stand_1.Id = "16ca32d8145ac6305141b0aae2ca6142"
zone02_Stand_1.Name = "02_Stand_1"
zone02_Stand_1.DistanceRangeUOM = "Meters"
zone02_Stand_1.ProximityRangeUOM = "Meters"
zone02_Stand_1.ShowObjects = "OnEnter"
zone02_Stand_1.OutOfRangeName = ""
zone02_Stand_1.InRangeName = ""
zone02_Stand_1.Description = "#zone02_Stand_1"
zone02_Stand_1.Visible = true
zone02_Stand_1.AllowSetPositionTo = false
zone02_Stand_1.Active = false
zone02_Stand_1.DistanceRange = Distance(-1, "meters")
zone02_Stand_1.ProximityRange = Distance(0, "meters")
zone02_Stand_1.Points = {
  ZonePoint(48.3920497549936, 9.98547644208515, 0),
  ZonePoint(48.3921012989537, 9.98544428961005, 0),
  ZonePoint(48.392122649161, 9.98536666666664, 0),
  ZonePoint(48.3921012989537, 9.98528904372343, 0),
  ZonePoint(48.3920497549936, 9.98525689124802, 0),
  ZonePoint(48.391998211032, 9.98528904372139, 0),
  ZonePoint(48.3919768608241, 9.98536666666664, 0),
  ZonePoint(48.391998211032, 9.98544428961107, 0)
}
zone02_Stand_1.OriginalPoint = ZonePoint(48.3920497549981, 9.98536666666667, 0)
zone02_Stand_1.Media = zmedia02_Stand_1
zone02_Stand_2 = Wherigo.Zone(cart17_Black_Coin_Edition)
zone02_Stand_2.Id = "7bae40c9495c58e8af5e8d5b1fc37f18"
zone02_Stand_2.Name = "02_Stand_2"
zone02_Stand_2.DistanceRangeUOM = "Meters"
zone02_Stand_2.ProximityRangeUOM = "Meters"
zone02_Stand_2.ShowObjects = "OnEnter"
zone02_Stand_2.OutOfRangeName = ""
zone02_Stand_2.InRangeName = ""
zone02_Stand_2.Description = "#zone02_Stand_2"
zone02_Stand_2.Visible = true
zone02_Stand_2.AllowSetPositionTo = false
zone02_Stand_2.Active = false
zone02_Stand_2.DistanceRange = Distance(-1, "meters")
zone02_Stand_2.ProximityRange = Distance(0, "meters")
zone02_Stand_2.Points = {
  ZonePoint(48.3918207345562, 9.98614112005498, 0),
  ZonePoint(48.3918722785167, 9.98610896772243, 0),
  ZonePoint(48.3918936287244, 9.98603134512905, 0),
  ZonePoint(48.3918722785167, 9.98595372253282, 0),
  ZonePoint(48.3918207345562, 9.98592157020585, 0),
  ZonePoint(48.3917691905951, 9.98595372253396, 0),
  ZonePoint(48.3917478403872, 9.98603134512905, 0),
  ZonePoint(48.3917691905951, 9.98610896772345, 0)
}
zone02_Stand_2.OriginalPoint = ZonePoint(48.3918207345598, 9.98603134512905, 0)
zone02_Stand_2.Media = zmedia02_Stand_2
zone02_Stand_3 = Wherigo.Zone(cart17_Black_Coin_Edition)
zone02_Stand_3.Id = "a3a899687da0d070afaa2f93fc9c5276"
zone02_Stand_3.Name = "02_Stand_3"
zone02_Stand_3.DistanceRangeUOM = "Meters"
zone02_Stand_3.ProximityRangeUOM = "Meters"
zone02_Stand_3.ShowObjects = "OnEnter"
zone02_Stand_3.OutOfRangeName = ""
zone02_Stand_3.InRangeName = ""
zone02_Stand_3.Description = "#zone02_Stand_3"
zone02_Stand_3.Visible = true
zone02_Stand_3.AllowSetPositionTo = false
zone02_Stand_3.Active = false
zone02_Stand_3.DistanceRange = Distance(-1, "meters")
zone02_Stand_3.ProximityRange = Distance(0, "meters")
zone02_Stand_3.Points = {
  ZonePoint(48.3914107339591, 9.98588899152219, 0),
  ZonePoint(48.3914622779199, 9.98585683945044, 0),
  ZonePoint(48.391483628127, 9.98577921748165, 0),
  ZonePoint(48.3914622779199, 9.98570159551184, 0),
  ZonePoint(48.3914107339591, 9.98566944344157, 0),
  ZonePoint(48.3913591899986, 9.9857015955115, 0),
  ZonePoint(48.3913378397901, 9.98577921748165, 0),
  ZonePoint(48.3913591899986, 9.98585683945044, 0)
}
zone02_Stand_3.OriginalPoint = ZonePoint(48.3914107339619, 9.98577921748165, 0)
zone02_Stand_3.Media = zmedia02_Stand_3
zone03_Donauufer_Bastion = Wherigo.Zone(cart17_Black_Coin_Edition)
zone03_Donauufer_Bastion.Id = "cf54c2314df5337738621332c33010b0"
zone03_Donauufer_Bastion.Name = "03_Donauufer_Bastion"
zone03_Donauufer_Bastion.DistanceRangeUOM = "Meters"
zone03_Donauufer_Bastion.ProximityRangeUOM = "Meters"
zone03_Donauufer_Bastion.ShowObjects = "OnEnter"
zone03_Donauufer_Bastion.OutOfRangeName = ""
zone03_Donauufer_Bastion.InRangeName = ""
zone03_Donauufer_Bastion.Description = "#zone03_Donauufer_Bastion"
zone03_Donauufer_Bastion.Visible = true
zone03_Donauufer_Bastion.AllowSetPositionTo = false
zone03_Donauufer_Bastion.Active = false
zone03_Donauufer_Bastion.DistanceRange = Distance(-1, "meters")
zone03_Donauufer_Bastion.ProximityRange = Distance(0, "meters")
zone03_Donauufer_Bastion.Points = {
  ZonePoint(48.3921333333294, 9.98707520026197, 0),
  ZonePoint(48.392231248053, 9.98701412218835, 0),
  ZonePoint(48.3922718056599, 9.98686666666667, 0),
  ZonePoint(48.392231248053, 9.98671921114702, 0),
  ZonePoint(48.3921333333294, 9.98665813307218, 0),
  ZonePoint(48.3920354186052, 9.98671921114702, 0),
  ZonePoint(48.3919948609994, 9.98686666666667, 0),
  ZonePoint(48.3920354186052, 9.98701412218845, 0)
}
zone03_Donauufer_Bastion.OriginalPoint = ZonePoint(48.3921333333333, 9.98686666666667, 0)
zone03_Donauufer_Bastion.Media = zmedia03_Donauufer_Bastion
zone04_Eisenbahnbrcke = Wherigo.Zone(cart17_Black_Coin_Edition)
zone04_Eisenbahnbrcke.Id = "9e984335ef85282eec8ab2ed08627b35"
zone04_Eisenbahnbrcke.Name = WWB_multiplatform_string("04_Eisenbahnbr\195\188cke")
zone04_Eisenbahnbrcke.DistanceRangeUOM = "Meters"
zone04_Eisenbahnbrcke.ProximityRangeUOM = "Meters"
zone04_Eisenbahnbrcke.ShowObjects = "OnEnter"
zone04_Eisenbahnbrcke.OutOfRangeName = ""
zone04_Eisenbahnbrcke.InRangeName = ""
zone04_Eisenbahnbrcke.Description = "#zone04_Eisenbahnbrcke"
zone04_Eisenbahnbrcke.Visible = false
zone04_Eisenbahnbrcke.AllowSetPositionTo = false
zone04_Eisenbahnbrcke.Active = false
zone04_Eisenbahnbrcke.DistanceRange = Distance(-1, "meters")
zone04_Eisenbahnbrcke.ProximityRange = Distance(0, "meters")
zone04_Eisenbahnbrcke.Points = {
  ZonePoint(48.3935424411284, 9.98844485341635, 0),
  ZonePoint(48.3936713010318, 9.98836446987184, 0),
  ZonePoint(48.3937246765498, 9.98817040681843, 0),
  ZonePoint(48.3936713010318, 9.98797634376467, 0),
  ZonePoint(48.3935424411284, 9.98789596021948, 0),
  ZonePoint(48.3934135812277, 9.98797634376911, 0),
  ZonePoint(48.3933602057077, 9.98817040681843, 0),
  ZonePoint(48.3934135812277, 9.98836446987013, 0)
}
zone04_Eisenbahnbrcke.OriginalPoint = ZonePoint(48.3935424411281, 9.98817040681843, 0)
zone04_Eisenbahnbrcke.Media = zmedia04_Eisenbahnbrcke
zone05_Mitte_Brcke = Wherigo.Zone(cart17_Black_Coin_Edition)
zone05_Mitte_Brcke.Id = "0e03820eec4b14d07ccf34355ee8554a"
zone05_Mitte_Brcke.Name = WWB_multiplatform_string("05_Mitte_Br\195\188cke")
zone05_Mitte_Brcke.DistanceRangeUOM = "Meters"
zone05_Mitte_Brcke.ProximityRangeUOM = "Meters"
zone05_Mitte_Brcke.ShowObjects = "OnEnter"
zone05_Mitte_Brcke.OutOfRangeName = ""
zone05_Mitte_Brcke.InRangeName = ""
zone05_Mitte_Brcke.Description = "#zone05_Mitte_Brcke"
zone05_Mitte_Brcke.Visible = true
zone05_Mitte_Brcke.AllowSetPositionTo = false
zone05_Mitte_Brcke.Active = false
zone05_Mitte_Brcke.DistanceRange = Distance(-1, "meters")
zone05_Mitte_Brcke.ProximityRange = Distance(0, "meters")
zone05_Mitte_Brcke.Points = {
  ZonePoint(48.3932123396021, 9.98887956214184, 0),
  ZonePoint(48.3932896555435, 9.98883133232857, 0),
  ZonePoint(48.393321680855, 9.98871489524845, 0),
  ZonePoint(48.3932896555435, 9.98859845816878, 0),
  ZonePoint(48.3932123396021, 9.9885502283571, 0),
  ZonePoint(48.3931350236607, 9.98859845816787, 0),
  ZonePoint(48.3931029983496, 9.98871489524845, 0),
  ZonePoint(48.3931350236607, 9.98883133232971, 0)
}
zone05_Mitte_Brcke.OriginalPoint = ZonePoint(48.3932123396059, 9.98871489524845, 0)
zone05_Mitte_Brcke.Media = zmedia05_Eisenbahnbrcke_Mitte
zone06_Donauufer_Mitte = Wherigo.Zone(cart17_Black_Coin_Edition)
zone06_Donauufer_Mitte.Id = "79b043a1238a2ad30062fef8e7292dfb"
zone06_Donauufer_Mitte.Name = "06_Donauufer_Mitte"
zone06_Donauufer_Mitte.DistanceRangeUOM = "Meters"
zone06_Donauufer_Mitte.ProximityRangeUOM = "Meters"
zone06_Donauufer_Mitte.ShowObjects = "OnEnter"
zone06_Donauufer_Mitte.OutOfRangeName = ""
zone06_Donauufer_Mitte.InRangeName = ""
zone06_Donauufer_Mitte.Description = "#zone06_Donauufer_Mitte"
zone06_Donauufer_Mitte.Visible = true
zone06_Donauufer_Mitte.AllowSetPositionTo = false
zone06_Donauufer_Mitte.Active = false
zone06_Donauufer_Mitte.DistanceRange = Distance(-1, "meters")
zone06_Donauufer_Mitte.ProximityRange = Distance(0, "meters")
zone06_Donauufer_Mitte.Points = {
  ZonePoint(48.3940893977611, 9.98940796015506, 0),
  ZonePoint(48.394166713702, 9.98935972950585, 0),
  ZonePoint(48.3941987390135, 9.98924329042438, 0),
  ZonePoint(48.394166713702, 9.98912685134189, 0),
  ZonePoint(48.3940893977611, 9.98907862069484, 0),
  ZonePoint(48.3940120818202, 9.98912685134189, 0),
  ZonePoint(48.3939800565081, 9.98924329042438, 0),
  ZonePoint(48.3940120818202, 9.98935972950585, 0)
}
zone06_Donauufer_Mitte.OriginalPoint = ZonePoint(48.3940893977652, 9.98924329042438, 0)
zone06_Donauufer_Mitte.Media = zmedia06_Donauufer_Mitte
zone07_Fischerpltzle = Wherigo.Zone(cart17_Black_Coin_Edition)
zone07_Fischerpltzle.Id = "f19de110c4d1622fed13a4028ed038f9"
zone07_Fischerpltzle.Name = WWB_multiplatform_string("07_Fischerpl\195\164tzle")
zone07_Fischerpltzle.DistanceRangeUOM = "Meters"
zone07_Fischerpltzle.ProximityRangeUOM = "Meters"
zone07_Fischerpltzle.ShowObjects = "OnEnter"
zone07_Fischerpltzle.OutOfRangeName = ""
zone07_Fischerpltzle.InRangeName = ""
zone07_Fischerpltzle.Description = "#zone07_Fischerpltzle"
zone07_Fischerpltzle.Visible = true
zone07_Fischerpltzle.AllowSetPositionTo = false
zone07_Fischerpltzle.Active = false
zone07_Fischerpltzle.DistanceRange = Distance(-1, "meters")
zone07_Fischerpltzle.ProximityRange = Distance(0, "meters")
zone07_Fischerpltzle.Points = {
  ZonePoint(48.3951340466859, 9.99095381454515, 0),
  ZonePoint(48.3951966725989, 9.99091474692102, 0),
  ZonePoint(48.3952226131009, 9.99082042932514, 0),
  ZonePoint(48.3951966725989, 9.99072611173131, 0),
  ZonePoint(48.3951340466859, 9.99068704410593, 0),
  ZonePoint(48.395071420774, 9.99072611173256, 0),
  ZonePoint(48.3950454802716, 9.99082042932514, 0),
  ZonePoint(48.395071420774, 9.9909147469184, 0)
}
zone07_Fischerpltzle.OriginalPoint = ZonePoint(48.3951340466902, 9.99082042932514, 0)
zone07_Fischerpltzle.Media = zmedia07_Fischerpltzle
zone07_Stadtmauer = Wherigo.Zone(cart17_Black_Coin_Edition)
zone07_Stadtmauer.Id = "05628579ff86eb9d1ba2fb549d78daaa"
zone07_Stadtmauer.Name = "07_Stadtmauer"
zone07_Stadtmauer.DistanceRangeUOM = "Meters"
zone07_Stadtmauer.ProximityRangeUOM = "Meters"
zone07_Stadtmauer.ShowObjects = "OnEnter"
zone07_Stadtmauer.OutOfRangeName = ""
zone07_Stadtmauer.InRangeName = ""
zone07_Stadtmauer.Description = "#zone07_Stadtmauer"
zone07_Stadtmauer.Visible = true
zone07_Stadtmauer.AllowSetPositionTo = false
zone07_Stadtmauer.Active = false
zone07_Stadtmauer.DistanceRange = Distance(-1, "meters")
zone07_Stadtmauer.ProximityRange = Distance(0, "meters")
zone07_Stadtmauer.Points = {
  ZonePoint(48.3946618068453, 9.98990506958307, 0),
  ZonePoint(48.3947244327577, 9.98986600231706, 0),
  ZonePoint(48.3947503732598, 9.98977168560032, 0),
  ZonePoint(48.3947244327577, 9.98967736888176, 0),
  ZonePoint(48.3946618068453, 9.98963830161711, 0),
  ZonePoint(48.3945991809328, 9.98967736888176, 0),
  ZonePoint(48.3945732404303, 9.98977168560032, 0),
  ZonePoint(48.3945991809328, 9.98986600231763, 0)
}
zone07_Stadtmauer.OriginalPoint = ZonePoint(48.3946618068456, 9.98977168560032, 0)
zone07_Stadtmauer.Media = zmedia07_Stadtmauer
zone07_Ufertribne = Wherigo.Zone(cart17_Black_Coin_Edition)
zone07_Ufertribne.Id = "e313c7e6939fcff0ffbdf873ce5f60a2"
zone07_Ufertribne.Name = WWB_multiplatform_string("07_Ufertrib\195\188ne")
zone07_Ufertribne.DistanceRangeUOM = "Meters"
zone07_Ufertribne.ProximityRangeUOM = "Meters"
zone07_Ufertribne.ShowObjects = "OnEnter"
zone07_Ufertribne.OutOfRangeName = ""
zone07_Ufertribne.InRangeName = ""
zone07_Ufertribne.Description = "#zone07_Ufertribne"
zone07_Ufertribne.Visible = true
zone07_Ufertribne.AllowSetPositionTo = false
zone07_Ufertribne.Active = false
zone07_Ufertribne.DistanceRange = Distance(-1, "meters")
zone07_Ufertribne.ProximityRange = Distance(0, "meters")
zone07_Ufertribne.Points = {
  ZonePoint(48.3950427315825, 9.99191726411777, 0),
  ZonePoint(48.3950942755437, 9.99188510975227, 0),
  ZonePoint(48.3951156257505, 9.99180748224262, 0),
  ZonePoint(48.3950942755437, 9.99172985473297, 0),
  ZonePoint(48.3950427315825, 9.99169770036519, 0),
  ZonePoint(48.3949911876214, 9.99172985473092, 0),
  ZonePoint(48.394969837414, 9.99180748224262, 0),
  ZonePoint(48.3949911876214, 9.99188510975068, 0)
}
zone07_Ufertribne.OriginalPoint = ZonePoint(48.3950427315856, 9.99180748224262, 0)
zone07_Ufertribne.Media = zmedia07_Ufertribne
zone08_Tradi = Wherigo.Zone(cart17_Black_Coin_Edition)
zone08_Tradi.Id = "9dc5df6d2fab03b83de41bfc95fd1806"
zone08_Tradi.Name = "08_Tradi"
zone08_Tradi.DistanceRangeUOM = "Meters"
zone08_Tradi.ProximityRangeUOM = "Meters"
zone08_Tradi.ShowObjects = "OnEnter"
zone08_Tradi.OutOfRangeName = ""
zone08_Tradi.InRangeName = ""
zone08_Tradi.Description = "#zone08_Tradi"
zone08_Tradi.Visible = true
zone08_Tradi.AllowSetPositionTo = false
zone08_Tradi.Active = false
zone08_Tradi.DistanceRange = Distance(-1, "meters")
zone08_Tradi.ProximityRange = Distance(0, "meters")
zone08_Tradi.Points = {
  ZonePoint(48.3937277059942, 9.98668841988285, 0),
  ZonePoint(48.3938050219357, 9.98664018957811, 0),
  ZonePoint(48.3938370472471, 9.98652375132247, 0),
  ZonePoint(48.3938050219357, 9.98640731306693, 0),
  ZonePoint(48.3937277059942, 9.98635908276253, 0),
  ZonePoint(48.3936503900531, 9.98640731306693, 0),
  ZonePoint(48.3936183647416, 9.98652375132247, 0),
  ZonePoint(48.3936503900531, 9.98664018957788, 0)
}
zone08_Tradi.OriginalPoint = ZonePoint(48.3937277059967, 9.98652375132247, 0)
zone08_Tradi.Media = zmedia08_Tradi
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Stand_3})
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Id = "a4af71faedb18424cb1994c602252b92"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Name = "#zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Gender = "Male"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Type = "NPC"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Description = "#zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Visible = true
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.ObjectLocation = ZonePoint(48.3914107339619, 9.98577921748165, 0)
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Media = zmediahaendler_3
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Icon = zmediah3_ico
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands = {
  NachdeMnzlafragaNachCoinfragenAskforcoins = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Nach de M\195\188nzla fraga@@Nach Coin fragen@@Ask for coins"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Id = "210a44de377db7f2b60cbfdc86e38d13"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Custom = true
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.WorksWithAll = true
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Id = "f9cce68e9dd41b1dbf7dde7a85550055"
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Stand_2})
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Id = "a4dce28591531dc1c4c81011b3ce80b1"
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Name = "#zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian"
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Gender = "Male"
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Type = "NPC"
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Description = "#zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian"
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Visible = true
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.ObjectLocation = ZonePoint(48.3918207345598, 9.98603134512905, 0)
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Media = zmediahaendler_2
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Icon = zmediah2_ico
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands = {
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.Id = "1038f32c4bee7e18b613a0e89af9124b"
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Stand_1})
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Id = "dd369a6fd517a6c07f7257231596fc46"
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Name = "#zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin"
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Gender = "Male"
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Type = "NPC"
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Description = "#zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin"
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Visible = true
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.ObjectLocation = ZonePoint(48.3920497549981, 9.98541443705562, 0)
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Media = zmediahaendler_1
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Icon = zmediah1_ico
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands = {
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.Id = "30a47b74a8a14940ef6fa20e15d5f98d"
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterDBernhardBernhardBernhard = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Ausgang})
zcharacterDBernhardBernhardBernhard.Id = "bca08b4a215bf81788339a8f02850961"
zcharacterDBernhardBernhardBernhard.Name = "#zcharacterDBernhardBernhardBernhard"
zcharacterDBernhardBernhardBernhard.Gender = "Male"
zcharacterDBernhardBernhardBernhard.Type = "NPC"
zcharacterDBernhardBernhardBernhard.Description = "#zcharacterDBernhardBernhardBernhard"
zcharacterDBernhardBernhardBernhard.Visible = true
zcharacterDBernhardBernhardBernhard.ObjectLocation = ZonePoint(48.3918521827351, 9.98516499161724, 0)
zcharacterDBernhardBernhardBernhard.Media = zmediabernhard
zcharacterDBernhardBernhardBernhard.Icon = zmediabernhard_ico
zcharacterDBernhardBernhardBernhard.Commands = {
  MnzlazoigaCoinszeigenShowcoins = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("M\195\188nzla zoiga@@Coins zeigen@@Show coins"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Id = "346637cd22e12fba96dc6ee1c4c18b35"
zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Custom = true
zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.WorksWithAll = true
zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Id = "13e49bb14584f9e83c46c108a1f27f26"
zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Stand_3})
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Id = "bfb813a5622b574d300e30233a4ff890"
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Name = "#zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore"
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Gender = "Female"
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Type = "NPC"
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Description = "#zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore"
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Visible = true
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.ObjectLocation = ZonePoint(48.3914107339619, 9.98577921748165, 0)
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Media = zmediahaendlerin_3
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Icon = zmediah3w_ico
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands = {
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.Id = "5a1970a51ad3f75361f5f69309560bd0"
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterDGackahaufaGackerhaufenTheGackerhaufen = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone07_Ufertribne})
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Id = "6774fabb14a9e7ad9a7f1922e38c3d9c"
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Name = "#zcharacterDGackahaufaGackerhaufenTheGackerhaufen"
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Gender = "Male"
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Type = "NPC"
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Description = "#zcharacterDGackahaufaGackerhaufenTheGackerhaufen"
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Visible = true
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.ObjectLocation = ZonePoint(48.3950427315856, 9.99180748224262, 0)
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Media = zmediagackerhaufen
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Icon = zmediagackerhaufen_ico
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands = {
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.Id = "c798f0f178663359466112e1dfa00c66"
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterDUlmaDieUlmerTheUlmer = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone06_Donauufer_Mitte})
zcharacterDUlmaDieUlmerTheUlmer.Id = "90a0a46e1affcf5edf5aefd1f8b85647"
zcharacterDUlmaDieUlmerTheUlmer.Name = "#zcharacterDUlmaDieUlmerTheUlmer"
zcharacterDUlmaDieUlmerTheUlmer.Gender = "Male"
zcharacterDUlmaDieUlmerTheUlmer.Type = "NPC"
zcharacterDUlmaDieUlmerTheUlmer.Description = "#zcharacterDUlmaDieUlmerTheUlmer"
zcharacterDUlmaDieUlmerTheUlmer.Visible = true
zcharacterDUlmaDieUlmerTheUlmer.ObjectLocation = ZonePoint(48.3940893977652, 9.98924329042438, 0)
zcharacterDUlmaDieUlmerTheUlmer.Media = zmediaulmer
zcharacterDUlmaDieUlmerTheUlmer.Icon = zmediaulmer_ico
zcharacterDUlmaDieUlmerTheUlmer.Commands = {
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.Id = "d08d2baab7799b9eec79883bade735e0"
zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Stand_2})
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Id = "9419dfdac0f21379d09af67e57f4be19"
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Name = "#zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow"
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Gender = "It"
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Type = "NPC"
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Description = "#zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow"
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Visible = true
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.ObjectLocation = ZonePoint(48.3918207345598, 9.98603134512905, 0)
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Media = zmediaulmer_spatz
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Icon = zmediaulmer_spatz_ico
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands = {
  MachaFotoMaskottchenfotografierenTakeapicture = Wherigo.ZCommand({
    Text = "Mach a Foto@@Maskottchen fotografieren@@Take a picture",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Id = "d7744ae20e061551a538204f3a8c5728"
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Custom = true
zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.WorksWithAll = true
zcharacterDrGeigiGeigi22Geigi22 = Wherigo.ZCharacter({Cartridge = cart17_Black_Coin_Edition, Container = zone02_Ausgang})
zcharacterDrGeigiGeigi22Geigi22.Id = "eedb953ada37d5644269bdb3836c444b"
zcharacterDrGeigiGeigi22Geigi22.Name = "#zcharacterDrGeigiGeigi22Geigi22"
zcharacterDrGeigiGeigi22Geigi22.Gender = "Male"
zcharacterDrGeigiGeigi22Geigi22.Type = "NPC"
zcharacterDrGeigiGeigi22Geigi22.Description = "#zcharacterDrGeigiGeigi22Geigi22"
zcharacterDrGeigiGeigi22Geigi22.Visible = false
zcharacterDrGeigiGeigi22Geigi22.ObjectLocation = ZonePoint(48.3918521827351, 9.98516499161724, 0)
zcharacterDrGeigiGeigi22Geigi22.Media = zmediageigi22
zcharacterDrGeigiGeigi22Geigi22.Icon = zmediageigi22_ico
zcharacterDrGeigiGeigi22Geigi22.Commands = {
  SchwtzaAnsprechenTalkto = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Id = "ccab53751674804cf9301d7bc9dce59e"
zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Custom = true
zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.WorksWithAll = true
zitemSHiraLichtStirnLampeTorch = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemSHiraLichtStirnLampeTorch.Id = "9e46075e77d7045a8cd97424614f2276"
zitemSHiraLichtStirnLampeTorch.Name = "#zitemSHiraLichtStirnLampeTorch"
zitemSHiraLichtStirnLampeTorch.Description = "#zitemSHiraLichtStirnLampeTorch"
zitemSHiraLichtStirnLampeTorch.Visible = false
zitemSHiraLichtStirnLampeTorch.Locked = false
zitemSHiraLichtStirnLampeTorch.Opened = false
zitemSHiraLichtStirnLampeTorch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemSHiraLichtStirnLampeTorch.Media = zmediastirnlampe
zitemSHiraLichtStirnLampeTorch.Icon = zmediastirnlampe_ico
zitemSHiraLichtStirnLampeTorch.Commands = {
  EischaltaBenutzenUse = Wherigo.ZCommand({
    Text = "Eischalta@@Benutzen@@Use",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.Id = "94883efd288ac332539070b9a171b0a1"
zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.Custom = true
zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.WorksWithAll = true
zitemSKscherSckleCacherRucksackCacherbag = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemSKscherSckleCacherRucksackCacherbag.Id = "3de0ec106b8f499f29680a4751456d8a"
zitemSKscherSckleCacherRucksackCacherbag.Name = "#zitemSKscherSckleCacherRucksackCacherbag"
zitemSKscherSckleCacherRucksackCacherbag.Description = "#zitemSKscherSckleCacherRucksackCacherbag"
zitemSKscherSckleCacherRucksackCacherbag.Visible = true
zitemSKscherSckleCacherRucksackCacherbag.Locked = false
zitemSKscherSckleCacherRucksackCacherbag.Opened = false
zitemSKscherSckleCacherRucksackCacherbag.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemSKscherSckleCacherRucksackCacherbag.Media = zmediarucksack
zitemSKscherSckleCacherRucksackCacherbag.Icon = zmediarucksack_ico
zitemSKscherSckleCacherRucksackCacherbag.Commands = {
  AufmachaffnenOpen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Aufmacha@@\195\150ffnen@@Open"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ZumachaSchlieenClose = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Zumacha@@Schlie\195\159en@@Close"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Id = "375ac4775ea7e0bc43abee83b5b6bfea"
zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Custom = true
zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.WorksWithAll = true
zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Id = "2d2a0ec77675756662833e1cfa33354b"
zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Custom = true
zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.WorksWithAll = true
zitemASchwarzlichtUVLampeUVTorch = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemASchwarzlichtUVLampeUVTorch.Id = "e5afd27e5ac258499e6223837eca58aa"
zitemASchwarzlichtUVLampeUVTorch.Name = "#zitemASchwarzlichtUVLampeUVTorch"
zitemASchwarzlichtUVLampeUVTorch.Description = "#zitemASchwarzlichtUVLampeUVTorch"
zitemASchwarzlichtUVLampeUVTorch.Visible = false
zitemASchwarzlichtUVLampeUVTorch.Locked = false
zitemASchwarzlichtUVLampeUVTorch.Opened = false
zitemASchwarzlichtUVLampeUVTorch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemASchwarzlichtUVLampeUVTorch.Media = zmediauv_lampe
zitemASchwarzlichtUVLampeUVTorch.Icon = zmediauv_ico
zitemASchwarzlichtUVLampeUVTorch.Commands = {
  AufhebaAufhebenPickup = Wherigo.ZCommand({
    Text = "Aufheba@@Aufheben@@Pick up",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  EischaltaBenutzenUse = Wherigo.ZCommand({
    Text = "Eischalta@@Benutzen@@Use",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Id = "c17fde86d3d9959ae39895421276af88"
zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Custom = true
zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.WorksWithAll = true
zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.Id = "e1d24abbdf6e13ab1ad469ecf20f8833"
zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.Custom = true
zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.WorksWithAll = true
zitemAusziehschpieglTeleskopspiegelTelescpoemirror = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Id = "2e255031d82d6c9f5499ec821553a901"
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Name = "#zitemAusziehschpieglTeleskopspiegelTelescpoemirror"
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Description = "#zitemAusziehschpieglTeleskopspiegelTelescpoemirror"
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Visible = false
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Locked = false
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Opened = false
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Media = zmediaspiegel
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Icon = zmediaspiegel_ico
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands = {
  BenutzaBenutzenUse = Wherigo.ZCommand({
    Text = "Benutza@@Benutzen@@Use",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.Id = "5b44f781b5926791f4c0bb90b7773575"
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.Custom = true
zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.WorksWithAll = true
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Id = "58029b684961f01db8185f517ef9e8dd"
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Name = "#zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition"
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Description = "#zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition"
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Visible = false
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Locked = false
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Opened = false
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Media = zmediaULM_Coins
zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Icon = zmediacoin_ico
zitemDHilfaHintHint = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemDHilfaHintHint.Id = "9eb7de35894f97293e11b4224cd3081a"
zitemDHilfaHintHint.Name = "#zitemDHilfaHintHint"
zitemDHilfaHintHint.Description = "#zitemDHilfaHintHint"
zitemDHilfaHintHint.Visible = false
zitemDHilfaHintHint.Locked = false
zitemDHilfaHintHint.Opened = false
zitemDHilfaHintHint.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDHilfaHintHint.Media = zmedia08_Tradi
zitemDHilfaHintHint.Icon = zmediafrage_ico
zitemDrFainalCodeCompletionCodeCompletionCode = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemDrFainalCodeCompletionCodeCompletionCode.Id = "27df3228b104a8a7e2b456bc5bc41b16"
zitemDrFainalCodeCompletionCodeCompletionCode.Name = "#zitemDrFainalCodeCompletionCodeCompletionCode"
zitemDrFainalCodeCompletionCodeCompletionCode.Description = "#zitemDrFainalCodeCompletionCodeCompletionCode"
zitemDrFainalCodeCompletionCodeCompletionCode.Visible = false
zitemDrFainalCodeCompletionCodeCompletionCode.Locked = false
zitemDrFainalCodeCompletionCodeCompletionCode.Opened = false
zitemDrFainalCodeCompletionCodeCompletionCode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDrFainalCodeCompletionCodeCompletionCode.Media = zmediacode
zitemDrFainalCodeCompletionCodeCompletionCode.Icon = zmediafrage_ico
zitemDrFainalCodeCompletionCodeCompletionCode.Commands = {
  DrFainalCodeCompletionCodeCompletionCode = Wherigo.ZCommand({
    Text = "D'r Fainal-Code@@Completion-Code@@Completion-Code",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.Id = "f4910b872a19892cf853db1389270b31"
zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.Custom = true
zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.WorksWithAll = true
zitemDrFotoaparatDigiCamTheDigiCam = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemDrFotoaparatDigiCamTheDigiCam.Id = "60da213138c7ec1a81e5981a9ed9e0e1"
zitemDrFotoaparatDigiCamTheDigiCam.Name = "#zitemDrFotoaparatDigiCamTheDigiCam"
zitemDrFotoaparatDigiCamTheDigiCam.Description = "#zitemDrFotoaparatDigiCamTheDigiCam"
zitemDrFotoaparatDigiCamTheDigiCam.Visible = false
zitemDrFotoaparatDigiCamTheDigiCam.Locked = false
zitemDrFotoaparatDigiCamTheDigiCam.Opened = false
zitemDrFotoaparatDigiCamTheDigiCam.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDrFotoaparatDigiCamTheDigiCam.Media = zmediadigicam
zitemDrFotoaparatDigiCamTheDigiCam.Icon = zmediadigicam_ico
zitemDrFotoaparatDigiCamTheDigiCam.Commands = {
  DurchguggaBenutzenUse = Wherigo.ZCommand({
    Text = "Durchgugga@@Benutzen@@Use",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.Id = "e5a3a59b5f4c66632e464fd2adaed31b"
zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.Custom = true
zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.WorksWithAll = true
zitemGeldsckleGeldbeutelPurse = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemGeldsckleGeldbeutelPurse.Id = "55cea377ebd22f8aa683e410a2017039"
zitemGeldsckleGeldbeutelPurse.Name = "#zitemGeldsckleGeldbeutelPurse"
zitemGeldsckleGeldbeutelPurse.Description = "#zitemGeldsckleGeldbeutelPurse"
zitemGeldsckleGeldbeutelPurse.Visible = true
zitemGeldsckleGeldbeutelPurse.Locked = false
zitemGeldsckleGeldbeutelPurse.Opened = false
zitemGeldsckleGeldbeutelPurse.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemGeldsckleGeldbeutelPurse.Media = zmediageldbeutel
zitemGeldsckleGeldbeutelPurse.Icon = zmediageld_ico
zitemGeldsckleGeldbeutelPurse.Commands = {
  DrParkplatzzahlaParkplatzzahlenPayfee = Wherigo.ZCommand({
    Text = "D'r Parkplatz zahla@@Parkplatz zahlen@@Pay fee",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  GeldzhlaGeldzhlenCheckmoney = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Geld z\195\164hla@@Geld z\195\164hlen@@Check money"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  MnzlazahlaCoinbezahlenPaythecoins = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("M\195\188nzla zahla@@Coin bezahlen@@Pay the coins"),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Id = "d2d494c126731b001c353687fb0890f9"
zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Custom = true
zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.WorksWithAll = true
zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.Id = "d53398f7742074f9f4eeddeb139a0289"
zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.Custom = true
zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.WorksWithAll = true
zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Id = "bfd62753b25c7fcd1107116e56542ff2"
zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Custom = true
zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.WorksWithAll = true
zitemTschiePieEssGPSGPS = Wherigo.ZItem(cart17_Black_Coin_Edition)
zitemTschiePieEssGPSGPS.Id = "aaa2b4c149a6d66575ffbae0dd18d245"
zitemTschiePieEssGPSGPS.Name = "#zitemTschiePieEssGPSGPS"
zitemTschiePieEssGPSGPS.Description = "#zitemTschiePieEssGPSGPS"
zitemTschiePieEssGPSGPS.Visible = false
zitemTschiePieEssGPSGPS.Locked = false
zitemTschiePieEssGPSGPS.Opened = false
zitemTschiePieEssGPSGPS.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemTschiePieEssGPSGPS.Media = zmediagps
zitemTschiePieEssGPSGPS.Icon = zmediagps_ico
zitemTschiePieEssGPSGPS.Commands = {
  EischaltaBenutzenUse = Wherigo.ZCommand({
    Text = "Eischalta@@Benutzen@@Use",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Id = "ddcfead16b4882337dc5473308986128"
zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Custom = true
zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.WorksWithAll = true
WWB_localize_delim = "@@"
WWB_localize_n = 0
WWB_localize_prev_n = 0
WWB_localize_latin1_buttons = false
WWB_device = nil
var_00_Button = ""
var_00_Code = ""
var_00_Geld = 125
var_01_PP = 0
var_02_Aus = 0
var_02_S1 = 0
var_02_S2 = 0
var_02_S3 = 0
var_03_Bastion = 0
var_04_Eingabe = ""
var_07_UV_weg = 0
var_99_Rucksack = 0
var_99_Rucksack_auf = 0
cart17_Black_Coin_Edition.ZVariables = {
  WWB_localize_delim = "@@",
  WWB_localize_n = 0,
  WWB_localize_prev_n = 0,
  WWB_localize_latin1_buttons = false,
  WWB_device = nil,
  var_00_Button = "",
  var_00_Code = "",
  var_00_Geld = 125,
  var_01_PP = 0,
  var_02_Aus = 0,
  var_02_S1 = 0,
  var_02_S2 = 0,
  var_02_S3 = 0,
  var_03_Bastion = 0,
  var_04_Eingabe = "",
  var_07_UV_weg = 0,
  var_99_Rucksack = 0,
  var_99_Rucksack_auf = 0
}
buildervar = {}
buildervar.var_00_Button = {}
buildervar.var_00_Button.Id = "6fdbbebeaaaed65ed35ed0d2f718e1f4"
buildervar.var_00_Button.Name = "00_Button"
buildervar.var_00_Button.Type = "String"
buildervar.var_00_Button.Data = ""
buildervar.var_00_Code = {}
buildervar.var_00_Code.Id = "83cc26d75b1e6fd3e5e6572adefe1cef"
buildervar.var_00_Code.Name = "00_Code"
buildervar.var_00_Code.Type = "String"
buildervar.var_00_Code.Data = ""
buildervar.var_00_Geld = {}
buildervar.var_00_Geld.Id = "92c6831d3d4ae1f7e5cf6cc5221e81a3"
buildervar.var_00_Geld.Name = "00_Geld"
buildervar.var_00_Geld.Type = "Number"
buildervar.var_00_Geld.Data = "125"
buildervar.var_01_PP = {}
buildervar.var_01_PP.Id = "0a20246d70470e50ec034f5e778a747a"
buildervar.var_01_PP.Name = "01_PP"
buildervar.var_01_PP.Type = "Number"
buildervar.var_01_PP.Data = "0"
buildervar.var_02_Aus = {}
buildervar.var_02_Aus.Id = "409c4fdc734a74697e573b4b34868a58"
buildervar.var_02_Aus.Name = "02_Aus"
buildervar.var_02_Aus.Type = "Number"
buildervar.var_02_Aus.Data = "0"
buildervar.var_02_S1 = {}
buildervar.var_02_S1.Id = "7b08a0fbfe408d3ceda5b2ba3b3f256c"
buildervar.var_02_S1.Name = "02_S1"
buildervar.var_02_S1.Type = "Number"
buildervar.var_02_S1.Data = "0"
buildervar.var_02_S2 = {}
buildervar.var_02_S2.Id = "ea04d1212f85440ab83427fecf19acc6"
buildervar.var_02_S2.Name = "02_S2"
buildervar.var_02_S2.Type = "Number"
buildervar.var_02_S2.Data = "0"
buildervar.var_02_S3 = {}
buildervar.var_02_S3.Id = "0fd6f1d9a09513d053e1e574bfcb5e23"
buildervar.var_02_S3.Name = "02_S3"
buildervar.var_02_S3.Type = "Number"
buildervar.var_02_S3.Data = "0"
buildervar.var_03_Bastion = {}
buildervar.var_03_Bastion.Id = "99dfc6a574423f8aad986d6b9151a755"
buildervar.var_03_Bastion.Name = "03_Bastion"
buildervar.var_03_Bastion.Type = "Number"
buildervar.var_03_Bastion.Data = "0"
buildervar.var_04_Eingabe = {}
buildervar.var_04_Eingabe.Id = "06c37751e6bac0dfd4e3b88eee535d9c"
buildervar.var_04_Eingabe.Name = "04_Eingabe"
buildervar.var_04_Eingabe.Type = "String"
buildervar.var_04_Eingabe.Data = ""
buildervar.var_07_UV_weg = {}
buildervar.var_07_UV_weg.Id = "25d71476fdfb6292a15b9ba63e22e841"
buildervar.var_07_UV_weg.Name = "07_UV_weg"
buildervar.var_07_UV_weg.Type = "Number"
buildervar.var_07_UV_weg.Data = "0"
buildervar.var_99_Rucksack = {}
buildervar.var_99_Rucksack.Id = "52bc710ab2ad9427ee8f18de2ff3d266"
buildervar.var_99_Rucksack.Name = "99_Rucksack"
buildervar.var_99_Rucksack.Type = "Number"
buildervar.var_99_Rucksack.Data = "0"
buildervar.var_99_Rucksack_auf = {}
buildervar.var_99_Rucksack_auf.Id = "7a89802f485239423a07af41b8e4aca2"
buildervar.var_99_Rucksack_auf.Name = "99_Rucksack_auf"
buildervar.var_99_Rucksack_auf.Type = "Number"
buildervar.var_99_Rucksack_auf.Data = "0"
ztimer01_Bastion = Wherigo.ZTimer(cart17_Black_Coin_Edition)
ztimer01_Bastion.Id = "2cf0b297527dfeb064abaf0192e6a0a6"
ztimer01_Bastion.Name = "01_Bastion"
ztimer01_Bastion.Type = "Countdown"
ztimer01_Bastion.Visible = false
ztimer01_Bastion.Duration = 70
ztimer01_Parkplatz = Wherigo.ZTimer(cart17_Black_Coin_Edition)
ztimer01_Parkplatz.Id = "64480cc791aa0306690c426194157733"
ztimer01_Parkplatz.Name = "01_Parkplatz"
ztimer01_Parkplatz.Type = "Countdown"
ztimer01_Parkplatz.Visible = false
ztimer01_Parkplatz.Duration = 35
ztimer03_Bastion = Wherigo.ZTimer(cart17_Black_Coin_Edition)
ztimer03_Bastion.Id = "557f6ea1e528f2491c83b3527191f260"
ztimer03_Bastion.Name = "03_Bastion"
ztimer03_Bastion.Type = "Countdown"
ztimer03_Bastion.Visible = false
ztimer03_Bastion.Duration = 20
zinput00_Code = Wherigo.ZInput(cart17_Black_Coin_Edition)
zinput00_Code.Id = "0f82d9cf752d137009ce262935d81e5a"
zinput00_Code.Name = "00_Code"
zinput00_Code.InputType = "Text"
zinput00_Code.Text = "#zinput00_Code"
zinput00_Code.Visible = false
zinput00_Code.InputVariableId = "83cc26d75b1e6fd3e5e6572adefe1cef"
zinput00_Code.Media = zmediafragezeichen
zinput04_Eingabe = Wherigo.ZInput(cart17_Black_Coin_Edition)
zinput04_Eingabe.Id = "555b9f0edf5111de4d080220e38c08bd"
zinput04_Eingabe.Name = "04_Eingabe"
zinput04_Eingabe.InputType = "MultipleChoice"
zinput04_Eingabe.Choices = {
  "#zinput04_Eingabe_1",
  "#zinput04_Eingabe_2",
  "#zinput04_Eingabe_3"
}
zinput04_Eingabe.Text = "#zinput04_Eingabe"
zinput04_Eingabe.Visible = false
zinput04_Eingabe.InputVariableId = "06c37751e6bac0dfd4e3b88eee535d9c"
zinput04_Eingabe.Media = zmediafragezeichen
function WWB_change_language(n)
  if n ~= nil then
    WWB_localize_prev_n = WWB_localize_n
    WWB_localize_n = n
  end
  WWB_runtime_localize_media()
  zone01_Parkplatz.Description = WWB_localize("D'r Parkplatz, driekt vor d'r Iwent-Halla@@Der Parkplatz direkt vor der Event-Halle.@@The parking area, directly in front of the event-hall.")
  zone01_Parkplatz_1eer.Description = WWB_localize(WWB_multiplatform_string("A Parkl\195\188cka, am Arsch d'r Welt.@@Eine Parkl\195\188cke abseits der Event-Halle.@@A parkinglot far away from the event-hall."))
  zone01_Parkplatz_voll.Description = WWB_localize(WWB_multiplatform_string("A Parkl\195\188cka, direkt vor'm Loch@@Ein \"hart\" umk\195\164mpfter Parkplatz.@@A parkinglot, directly in front of the event-hall."))
  zone02_Ausgang.Description = WWB_localize("D'r Ein- ond Ausgang von d'r Iwent-Halla@@Der Eingang/ Ausgang von der Event-Halle@@The entrance/ exit of the even-hall.")
  zone02_Stand_1.Description = WWB_localize("D'r Lada vom \"Happy Coin\".@@Der Messestand des Geocoin-Shops \"The Happy Coin\".@@The geocoinshop \"The Happy Coin\".")
  zone02_Stand_2.Description = WWB_localize("D'r Lada vom \"The Bavarian - Coins and More\"@@Der Messestand des Geocoin-Shops \"The Bavarian - Coins and More\"@@The geocoinshop \"The Bavarian - Coins and More\".")
  zone02_Stand_3.Description = WWB_localize(WWB_multiplatform_string("D'r Lada vom \"Schw\195\164bischa M\195\188nzla ond Soschtiga Gruscht\".@@Der Messestand des Geocoinshops \"Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht\".@@The geocoinshop of \"Swabian Coins and More\"."))
  zone03_Donauufer_Bastion.Description = WWB_localize("'S Donauufa an d'r \"Ob'ra Donaubastion\"@@Das Donauufer an der \"Oberen Donaubastion\"@@The \"Upper Danube bastion\"")
  zone04_Eisenbahnbrcke.Description = WWB_localize(WWB_multiplatform_string("D' Eisabahbruck.@@Die Eisenbahnbr\195\188cke \195\188ber die Donau.@@The railwaybridge."))
  zone05_Mitte_Brcke.Description = WWB_localize(WWB_multiplatform_string("D' Mitta von der Eisabahbruck.@@Hier ist ungef\195\164hr die Mitte der Eisenbahnbr\195\188cke. Von hier aus kannst du die gesamte Ufferregion \195\188berblicken.@@The middle of the railwaybridge."))
  zone06_Donauufer_Mitte.Description = WWB_localize(WWB_multiplatform_string("'S Ulma Ufa.@@Das Ulmer Donauufer kurz vor dem Beginn des ber\195\188hmten Ulmer \"Fischerviertel\".@@The Ulm shoreside."))
  zone07_Fischerpltzle.Description = WWB_localize(WWB_multiplatform_string("'S \"Fischapl\195\164tzle\" im Ulma \"Fischaviertl\"@@Das \"Fischerpl\195\164tzle - das Herzst\195\188ck von ber\195\188hmten Ulmer \"Fischerviertel\".@@The \"Fishersplace\"."))
  zone07_Stadtmauer.Description = WWB_localize("D' Schtadtmaua beim \"Saumarkt\".@@Die Stadtmauer, oberhalb vom \"Saumarkt\".@@The \"Town Wall\" near the \"Pigmarket\".")
  zone07_Ufertribne.Description = WWB_localize(WWB_multiplatform_string("D' Ufatrib\195\188n direkt an d'r Donau.@@Eine Zuschauertrib\195\188ne, direkt am Ufer der Donau.@@A shore platform near the Danube."))
  zone08_Tradi.Description = WWB_localize(WWB_multiplatform_string("D'r Tradi: \"HfK+G\".<BR>\n<BR>\nKoordinata: N 48\194\17623.622, E 009\194\17659.194@@Der Tradi: \"HfK+G\".<BR>\n<BR>\nKoordinaten: N 48\194\17623.622, E 009\194\17659.194@@The Traditional: \"HfK+G\".<BR>\n<BR>\nCoordinates: N 48\194\17623.622, E 009\194\17659.194"))
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Name = WWB_localize(WWB_multiplatform_string("B'sitza - Schw\195\164bische M\195\188nzla\"@@H\195\164ndler - Schw\195\164bische M\195\188nzla@@Owner - Swabian Coins"))
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Description = WWB_localize(WWB_multiplatform_string("D'r B'sitza vom \"Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht\".@@\"Der H\195\164ndler des Geocoinshops \"Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht\".@@The owner of the geocoinshop \"Swabian Coins and More\"."))
  zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Name = WWB_localize(WWB_multiplatform_string("B'sitza - The Bavarian@@H\195\164ndler - The Bavarian@@Owner - The Bavarian"))
  zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Description = WWB_localize(WWB_multiplatform_string("D'r B'sitza vom \"The Bavarian - Coins and More\".@@Der H\195\164ndler des Geocoinshops \"The Bavarian - Coins and More\".@@The owner of the geocoinshop \"The Bavarian - Coins and More\".<BR>\n<BR>\nDer H\195\164ndler ist gerade im Gespr\195\164ch mit zwei Geocachern.@@The owner of \"The Bavarian - Coins and More\"."))
  zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Name = WWB_localize(WWB_multiplatform_string("B'sitza - The Happy Coin@@H\195\164ndler - The Happy Coin@@Owner - The Happy Coin"))
  zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Description = WWB_localize(WWB_multiplatform_string("D'r B'sitza vom \"Happy Coin\"@@Der H\195\164ndler des Geocoinshops \"The Happy Coin\".<BR>\n<BR>\nDer H\195\164ndler sitzt etwas lustlos vor seinen ganzen Coins.@@The owner of the geocoinshop \"The Happy Coin\".<BR>\n<BR>\nHe looks very boring."))
  zcharacterDBernhardBernhardBernhard.Name = WWB_localize("D' Bernhard@@Bernhard@@Bernhard")
  zcharacterDBernhardBernhardBernhard.Description = WWB_localize(WWB_multiplatform_string("D'r Bernhard von d'r Mau-Schtadt Memminga - Wurschtbudabesitza mit 'em zwoita Schtandboi ond wahnsinniga WIG-F\195\164n.@@Der Bernhard - Wurstbudenbesitzer mit zweitem Standbein und bekennender WIG-Fan - ein sympatischer Cacher aus Memmingen.@@Bernhard - a famous \"virtual\" cacher from Memmingen and WIG-fan."))
  zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Name = WWB_localize(WWB_multiplatform_string("D' Frau vom B'sitza - Schw\195\164bische M\195\188nzla@@H\195\164ndlerin - Schw\195\164bische M\195\188nzla@@Owners wife of \"Swabian Coins and More\""))
  zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Description = WWB_localize(WWB_multiplatform_string("D' Frau vom B'sitza vom Lada \"Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht\"@@Die Frau vom H\195\164ndler des Geocoinshops \"Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht\"@@The owners wife of the geocoinshop \"Swabian Coins and More\"."))
  zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Name = WWB_localize("D' Gackahaufa@@Gackerhaufen@@The \"Gackerhaufen\"")
  zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Description = WWB_localize("Des isch d'r \"Gackahaufa\" von de \"Ulma\".@@Der \"Gackerhaufen\" ist auch Mitglied der \"Ulmer\".@@The \"Gackerhaufen\" - member of \"The Ulmer\"")
  zcharacterDUlmaDieUlmerTheUlmer.Name = WWB_localize("D' Ulma@@Die Ulmer@@The Ulmer")
  zcharacterDUlmaDieUlmerTheUlmer.Description = WWB_localize(WWB_multiplatform_string("\"D' Ulma\" - \"D'DickichtDuggre\", d' \"Geoquax\" ond d' \"Fr\195\164ggae\".@@\"Die Ulmer\" - Frau \"DieDickichtDugger\", \"geoquax\" und \"Fr\195\164ggae\", die sich durch Zufall hier treffen.@@Some of \"The Ulmer\" - Mrs. \"DieDickichtDugger\", Mr. \"Geoquax\" and \"Fr\195\164ggae\"."))
  zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Name = WWB_localize("D'r \"Ulma Schpatz\"@@Ulmer Spatz@@The \"Ulm Sparrow\"")
  zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Description = WWB_localize(WWB_multiplatform_string("D'r \"Ulma Schpatz\" is des Maskottchen vom Gecoinfescht ond lauft w\195\164hrend des Iwents in d'r Halla oder im Fischerviertl omanand@@Der \"Ulmer Spatz\" - das Maskottchen des Ulmer Geocoinfests. Es l\195\164uft w\195\164hrend des ganzen Events durch die Event-Halle und durch das Ulmer Fischerviertel damit sich die Eventteilnehmer mit ihm fotografieren lassen k\195\182nnen.@@The \"Ulm Sparrow\" is the mascot of the \"GCF Europe 2014\"."))
  zcharacterDrGeigiGeigi22Geigi22.Name = WWB_localize("D'r Geigi@@Geigi22@@Geigi22")
  zcharacterDrGeigiGeigi22Geigi22.Description = WWB_localize(WWB_multiplatform_string("D'r \"Geigi\" aus Memminga - WIG-F\195\164n ond beschta Kumpel vom Bernhard.@@\"Geigi22\" - ein bekennender \"WIG-Fan\" - aus Memmingen und bester Kumpel von Bernhard.@@\"Geigi22\" a \"real\" cacher from Memmingen - WIG-fan and best buddy of Bernhard."))
  zitemSHiraLichtStirnLampeTorch.Name = WWB_localize("'S Hira-Licht@@Stirn-Lampe@@Torch")
  zitemSHiraLichtStirnLampeTorch.Description = WWB_localize(WWB_multiplatform_string("A Hira-Licht, des de fir \"Andrgraunds\" benedigscht.@@Eine Stirn-Lampe, die du f\195\188r Undergrounds oder Nachtcaches ben\195\182tigst.@@A torch, you need for undergrounds."))
  zitemSKscherSckleCacherRucksackCacherbag.Name = WWB_localize(WWB_multiplatform_string("'S K\195\164scher-S\195\164ckle@@Cacher-Rucksack@@Cacher-bag"))
  zitemSKscherSckleCacherRucksackCacherbag.Description = WWB_localize(WWB_multiplatform_string("'S K\195\164scher-S\195\164ckle mit jeda Menge Gruscht@@Dein Cacher-Rucksack. Hier drin befinden sich alle m\195\182glichen Cacher-Utensilien.@@Your cacher-bag with a lot of useful tools."))
  zitemASchwarzlichtUVLampeUVTorch.Name = WWB_localize("A Schwarzlicht@@UV-Lampe@@UV-Torch")
  zitemASchwarzlichtUVLampeUVTorch.Description = WWB_localize(WWB_multiplatform_string("A Schwarzlicht fir spezielle K\195\164schs.@@Eine UV-Lampe - man wei\195\159 nie, bei welchem Cache diese n\195\188tzlich sein kann.@@A UV-Torch for special caches."))
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Name = WWB_localize("Ausziehschpiegl@@Teleskopspiegel@@Telescpoe mirror")
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Description = WWB_localize(WWB_multiplatform_string("A Schpiegl zom Ausfahra@@Ein Teleskopspiegel kann bei dem ein oder anderen Cache auch mal n\195\188tzlich sein.@@A telescope mirror for special caches."))
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Name = WWB_localize(WWB_multiplatform_string("D' \"Bl\195\164ck-Edischn\"@@Die Event-Coin \"Black Edition\"@@The \"Black Coin Edition\""))
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Description = WWB_localize(WWB_multiplatform_string("D' \"Bl\195\164ck Edischn\" von dene Iwent-Coins. Die geits eigentlich nur fir'd Helfa@@Die \"Black Edition\" der 3 Event-Coins des Geocoinfests in Ulm. Eigentlich gibt es die nur f\195\188r die Helfer.@@The \"Black Coin Edition\" of the GCF Event-Coins."))
  zitemDHilfaHintHint.Name = WWB_localize("D' Hilfa@@Hint@@Hint")
  zitemDHilfaHintHint.Description = WWB_localize(WWB_multiplatform_string("D' Hilfa:<BR>\n<BR>\nZwisch'n de St\195\164mm von der Drei-Schtamm-Kaschtanie, neba d'r gro\195\159a Wurzl.@@HINT:<BR>\n<BR>\nZwischen den Staemmen der Drei-Stamm-Kastanie, rechts neben der grossen Wurzel.@@HINT:<BR>\n<BR>\nbetween the three-pole-tree, next to the big root."))
  zitemDrFainalCodeCompletionCodeCompletionCode.Name = WWB_localize("D'r Fainal-Code@@Completion-Code@@Completion-Code")
  zitemDrFainalCodeCompletionCodeCompletionCode.Description = WWB_localize(WWB_multiplatform_string("Wenn'd auf's Kn\195\182pfle druckscht, kriagscht d'r Fainal-Code zom Logga auf \"Wereigo-dot-Komm\"@@Wenn du auf den Button dr\195\188ckst, bekommst du deinen Completion-Code, den du zum Loggen auf \"Wherigo.com\" ben\195\182tigst.@@Press the button to get your Completon-Code."))
  zitemDrFotoaparatDigiCamTheDigiCam.Name = WWB_localize("D'r Fotoaparat@@Digi-Cam@@The Digi-Cam")
  zitemDrFotoaparatDigiCamTheDigiCam.Description = WWB_localize(WWB_multiplatform_string("A Fotoaparat, mit dem de elles herzuuma kaasch.@@Eine Digi-Cam mit 10-fach Zoom, die dir schon \195\182fters bei Multis behilflich war.@@A Digi-Cam with 10 x Zoom."))
  zitemGeldsckleGeldbeutelPurse.Name = WWB_localize(WWB_multiplatform_string("Gelds\195\164ckle@@Geldbeutel@@Purse"))
  zitemGeldsckleGeldbeutelPurse.Description = WWB_localize(WWB_multiplatform_string("Dei Gelds\195\164ckle.@@Dein Geldbeutel.@@Your purse."))
  zitemTschiePieEssGPSGPS.Name = WWB_localize("Tschie-Pie-Ess@@GPS@@GPS")
  zitemTschiePieEssGPSGPS.Description = WWB_localize(WWB_multiplatform_string("Dei \"Tschie-Pie-Ess\"@@Dein GPS, welches du zum Geocachen ben\195\182tigst.@@Your GPS - you need for Geocaching"))
  zinput00_Code.Text = WWB_localize(WWB_multiplatform_string("Hier musch d'r \"Schtart-Code\" eingeba, den de im Lischting vom K\195\164sch \"GC5C1P1\" auf \"Geok\195\164sching-dot-Komm\" findesch.@@Bitte gib nun den Start-Code ein, den du im Listing bzw. Hint von \"GC5C1P1\" auf Geocaching.com findest.@@Please insert the \"Start-Code\" - you can find the code in the listing of GC5C1P1 on \"geocaching.com\".", {PocketPC = 1}))
  zinput04_Eingabe.Choices[1] = WWB_localize(WWB_multiplatform_string("Schr\195\164bergarta zor Linka@@Schreberg\195\164rten zur Linken@@The garden left of you", {Emulator_GSP = 1, PocketPC = 1}))
  zinput04_Eingabe.Choices[2] = WWB_localize("Dro'm auf'm Berg@@Berg links vor dir@@Top of the hill")
  zinput04_Eingabe.Choices[3] = WWB_localize(WWB_multiplatform_string("In d'r Mitt von der Bruck@@Mitte der Eisenbahnbr\195\188cke@@Middle of the bridge", {Emulator_GSP = 1, PocketPC = 1}))
  zinput04_Eingabe.Text = WWB_localize(WWB_multiplatform_string("Ha, hier siagt ma ja gar nix. Wo geits 'etza an Ort, wo d' elles \195\188b'rblicksch ?@@Wo gibt es hier in der N\195\164he einen Punkt, von dem aus du die komplette Uferregion \195\188berblicken kannst ?@@Here you can see nothing. Look for a place, from where you can see the whole shore of the Danube.", {PocketPC = 1}))
  local new_command_list, new_command
  new_command_list = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands
  if WWB_device == "iPhone" then
    zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Text = WWB_localize(WWB_multiplatform_string("Nach de M\195\188nzla fraga@@Nach Coin fragen@@Ask for coins", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Nach de M\195\188nzla fraga@@Nach Coin fragen@@Ask for coins", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.CmdWith,
      Enabled = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Enabled,
      MakeReciprocal = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.MakeReciprocal,
      Id = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Id,
      Custom = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Custom,
      WorksWith = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.NachdeMnzlafragaNachCoinfragenAskforcoins = new_command
  end
  if WWB_device == "iPhone" then
    zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands = new_command_list
  end
  new_command_list = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands
  if WWB_device == "iPhone" then
    zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian.Commands = new_command_list
  end
  new_command_list = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands
  if WWB_device == "iPhone" then
    zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin.Commands = new_command_list
  end
  new_command_list = zcharacterDBernhardBernhardBernhard.Commands
  if WWB_device == "iPhone" then
    zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Text = WWB_localize(WWB_multiplatform_string("M\195\188nzla zoiga@@Coins zeigen@@Show coins", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("M\195\188nzla zoiga@@Coins zeigen@@Show coins", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.CmdWith,
      Enabled = zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Enabled,
      MakeReciprocal = zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.MakeReciprocal,
      Id = zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Id,
      Custom = zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Custom,
      WorksWith = zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.MnzlazoigaCoinszeigenShowcoins = new_command
  end
  if WWB_device == "iPhone" then
    zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterDBernhardBernhardBernhard.Commands = new_command_list
  end
  new_command_list = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands
  if WWB_device == "iPhone" then
    zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Commands = new_command_list
  end
  new_command_list = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands
  if WWB_device == "iPhone" then
    zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterDGackahaufaGackerhaufenTheGackerhaufen.Commands = new_command_list
  end
  new_command_list = zcharacterDUlmaDieUlmerTheUlmer.Commands
  if WWB_device == "iPhone" then
    zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterDUlmaDieUlmerTheUlmer.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterDUlmaDieUlmerTheUlmer.Commands = new_command_list
  end
  new_command_list = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands
  if WWB_device == "iPhone" then
    zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Text = WWB_localize("Mach a Foto@@Maskottchen fotografieren@@Take a picture")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Mach a Foto@@Maskottchen fotografieren@@Take a picture"),
      CmdWith = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.CmdWith,
      Enabled = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Enabled,
      MakeReciprocal = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.MakeReciprocal,
      Id = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Id,
      Custom = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Custom,
      WorksWith = zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.MachaFotoMaskottchenfotografierenTakeapicture = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands = new_command_list
  end
  new_command_list = zcharacterDrGeigiGeigi22Geigi22.Commands
  if WWB_device == "iPhone" then
    zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Schw\195\164tza@@Ansprechen@@Talk to", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.CmdWith,
      Enabled = zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Enabled,
      MakeReciprocal = zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.MakeReciprocal,
      Id = zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Id,
      Custom = zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Custom,
      WorksWith = zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.SchwtzaAnsprechenTalkto = new_command
  end
  if WWB_device ~= "iPhone" then
    zcharacterDrGeigiGeigi22Geigi22.Commands = new_command_list
  end
  new_command_list = zitemSHiraLichtStirnLampeTorch.Commands
  if WWB_device == "iPhone" then
    zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.Text = WWB_localize("Eischalta@@Benutzen@@Use")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Eischalta@@Benutzen@@Use"),
      CmdWith = zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.CmdWith,
      Enabled = zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.Enabled,
      MakeReciprocal = zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.MakeReciprocal,
      Id = zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.Id,
      Custom = zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.Custom,
      WorksWith = zitemSHiraLichtStirnLampeTorch.Commands.EischaltaBenutzenUse.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.EischaltaBenutzenUse = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemSHiraLichtStirnLampeTorch.Commands = new_command_list
  end
  new_command_list = zitemSKscherSckleCacherRucksackCacherbag.Commands
  if WWB_device == "iPhone" then
    zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Text = WWB_localize(WWB_multiplatform_string("Aufmacha@@\195\150ffnen@@Open", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Aufmacha@@\195\150ffnen@@Open", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.CmdWith,
      Enabled = zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Enabled,
      MakeReciprocal = zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.MakeReciprocal,
      Id = zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Id,
      Custom = zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Custom,
      WorksWith = zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.AufmachaffnenOpen = new_command
  end
  if WWB_device == "iPhone" then
    zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Text = WWB_localize(WWB_multiplatform_string("Zumacha@@Schlie\195\159en@@Close", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Zumacha@@Schlie\195\159en@@Close", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.CmdWith,
      Enabled = zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Enabled,
      MakeReciprocal = zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.MakeReciprocal,
      Id = zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Id,
      Custom = zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Custom,
      WorksWith = zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.ZumachaSchlieenClose = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemSKscherSckleCacherRucksackCacherbag.Commands = new_command_list
  end
  new_command_list = zitemASchwarzlichtUVLampeUVTorch.Commands
  if WWB_device == "iPhone" then
    zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Text = WWB_localize("Aufheba@@Aufheben@@Pick up")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Aufheba@@Aufheben@@Pick up"),
      CmdWith = zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.CmdWith,
      Enabled = zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Enabled,
      MakeReciprocal = zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.MakeReciprocal,
      Id = zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Id,
      Custom = zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Custom,
      WorksWith = zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.AufhebaAufhebenPickup = new_command
  end
  if WWB_device == "iPhone" then
    zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.Text = WWB_localize("Eischalta@@Benutzen@@Use")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Eischalta@@Benutzen@@Use"),
      CmdWith = zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.CmdWith,
      Enabled = zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.Enabled,
      MakeReciprocal = zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.MakeReciprocal,
      Id = zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.Id,
      Custom = zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.Custom,
      WorksWith = zitemASchwarzlichtUVLampeUVTorch.Commands.EischaltaBenutzenUse.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.EischaltaBenutzenUse = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemASchwarzlichtUVLampeUVTorch.Commands = new_command_list
  end
  new_command_list = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands
  if WWB_device == "iPhone" then
    zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.Text = WWB_localize("Benutza@@Benutzen@@Use")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Benutza@@Benutzen@@Use"),
      CmdWith = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.CmdWith,
      Enabled = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.Enabled,
      MakeReciprocal = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.MakeReciprocal,
      Id = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.Id,
      Custom = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.Custom,
      WorksWith = zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands.BenutzaBenutzenUse.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.BenutzaBenutzenUse = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Commands = new_command_list
  end
  new_command_list = zitemDrFainalCodeCompletionCodeCompletionCode.Commands
  if WWB_device == "iPhone" then
    zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.Text = WWB_localize("D'r Fainal-Code@@Completion-Code@@Completion-Code")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("D'r Fainal-Code@@Completion-Code@@Completion-Code"),
      CmdWith = zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.CmdWith,
      Enabled = zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.Enabled,
      MakeReciprocal = zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.MakeReciprocal,
      Id = zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.Id,
      Custom = zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.Custom,
      WorksWith = zitemDrFainalCodeCompletionCodeCompletionCode.Commands.DrFainalCodeCompletionCodeCompletionCode.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.DrFainalCodeCompletionCodeCompletionCode = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemDrFainalCodeCompletionCodeCompletionCode.Commands = new_command_list
  end
  new_command_list = zitemDrFotoaparatDigiCamTheDigiCam.Commands
  if WWB_device == "iPhone" then
    zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.Text = WWB_localize("Durchgugga@@Benutzen@@Use")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Durchgugga@@Benutzen@@Use"),
      CmdWith = zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.CmdWith,
      Enabled = zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.Enabled,
      MakeReciprocal = zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.MakeReciprocal,
      Id = zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.Id,
      Custom = zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.Custom,
      WorksWith = zitemDrFotoaparatDigiCamTheDigiCam.Commands.DurchguggaBenutzenUse.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.DurchguggaBenutzenUse = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemDrFotoaparatDigiCamTheDigiCam.Commands = new_command_list
  end
  new_command_list = zitemGeldsckleGeldbeutelPurse.Commands
  if WWB_device == "iPhone" then
    zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Text = WWB_localize("D'r Parkplatz zahla@@Parkplatz zahlen@@Pay fee")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("D'r Parkplatz zahla@@Parkplatz zahlen@@Pay fee"),
      CmdWith = zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.CmdWith,
      Enabled = zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Enabled,
      MakeReciprocal = zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.MakeReciprocal,
      Id = zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Id,
      Custom = zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Custom,
      WorksWith = zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.DrParkplatzzahlaParkplatzzahlenPayfee = new_command
  end
  if WWB_device == "iPhone" then
    zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.Text = WWB_localize(WWB_multiplatform_string("Geld z\195\164hla@@Geld z\195\164hlen@@Check money", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("Geld z\195\164hla@@Geld z\195\164hlen@@Check money", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.CmdWith,
      Enabled = zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.Enabled,
      MakeReciprocal = zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.MakeReciprocal,
      Id = zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.Id,
      Custom = zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.Custom,
      WorksWith = zitemGeldsckleGeldbeutelPurse.Commands.GeldzhlaGeldzhlenCheckmoney.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.GeldzhlaGeldzhlenCheckmoney = new_command
  end
  if WWB_device == "iPhone" then
    zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Text = WWB_localize(WWB_multiplatform_string("M\195\188nzla zahla@@Coin bezahlen@@Pay the coins", {Emulator_GSP = 1, PocketPC = 1}))
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize(WWB_multiplatform_string("M\195\188nzla zahla@@Coin bezahlen@@Pay the coins", {Emulator_GSP = 1, PocketPC = 1})),
      CmdWith = zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.CmdWith,
      Enabled = zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Enabled,
      MakeReciprocal = zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.MakeReciprocal,
      Id = zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Id,
      Custom = zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Custom,
      WorksWith = zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.MnzlazahlaCoinbezahlenPaythecoins = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemGeldsckleGeldbeutelPurse.Commands = new_command_list
  end
  new_command_list = zitemTschiePieEssGPSGPS.Commands
  if WWB_device == "iPhone" then
    zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Text = WWB_localize("Eischalta@@Benutzen@@Use")
  else
    new_command = Wherigo.ZCommand({
      Text = WWB_localize("Eischalta@@Benutzen@@Use"),
      CmdWith = zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.CmdWith,
      Enabled = zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Enabled,
      MakeReciprocal = zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.MakeReciprocal,
      Id = zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Id,
      Custom = zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Custom,
      WorksWith = zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.WorksWith
    })
    new_command.WWB_rebuilt_reciprocal = true
    new_command_list.EischaltaBenutzenUse = new_command
  end
  if WWB_device ~= "iPhone" then
    zitemTschiePieEssGPSGPS.Commands = new_command_list
  end
  new_command = nil
  new_command_list = nil
  WWB_runtime_localize_reciprocal_commands()
  WWB_change_language_author(WWB_localize_n)
end
WWB_runtime_localize_media_data = {}
WWB_localize_input = Wherigo.ZInput(cart17_Black_Coin_Edition)
WWB_localize_input.InputType = "MultipleChoice"
WWB_localize_input.Choices = {
  "Originalton Sued",
  "Hochdeutsch",
  "English"
}
WWB_localize_input.Text = [[
Willst du den WIG im "Originalton Sued" oder auf "Hochdeutsch" spielen ?<BR>
<BR>
Please select "English" if you want to play the WIG in "English".]]
WWB_localize_input.WWB_cart = cart17_Black_Coin_Edition
function WWB_localize_input:OnGetInput(input)
  WWB_localize_input_handler(self, input)
end
function cart17_Black_Coin_Edition:OnStart(restart)
  if restart == nil then
    WWB_localize_init(cart17_Black_Coin_Edition, "Originalton Sued@@Hochdeutsch@@English")
    return
  end
  WWB_change_language()
  Player.CompletionCode15 = Player.CompletionCode:sub(1, 15)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition:MoveTo(Player)
  zitemDrFainalCodeCompletionCodeCompletionCode:MoveTo(Player)
  zitemDHilfaHintHint:MoveTo(Player)
  zitemGeldsckleGeldbeutelPurse:MoveTo(Player)
  zitemTschiePieEssGPSGPS:MoveTo(Player)
  zitemSKscherSckleCacherRucksackCacherbag:MoveTo(Player)
  zitemDrFotoaparatDigiCamTheDigiCam:MoveTo(Player)
  zitemSHiraLichtStirnLampeTorch:MoveTo(Player)
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror:MoveTo(Player)
  zitemASchwarzlichtUVLampeUVTorch:MoveTo(Player)
  zone01_Parkplatz.Name = WWB_localize("D' Einfahrt zom Parkplatz@@Einfahrt - Parkplatz@@Entrance to the parking area")
  zone01_Parkplatz_voll.Name = WWB_localize("Leerar Parkplatz@@Leere Parkbucht@@Empty parkinglot")
  zone01_Parkplatz_1eer.Name = WWB_localize("Leerar Plarkplatz - am Arsch d'r Welt@@Leere Parkbucht - weit entfernt@@Empty parkinglot")
  zone02_Ausgang.Name = WWB_localize("D'r Eingang@@Halle - Eingang@@Entrance")
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("'S \"Geocoinfescht\" fendet huier z' Ulm statt ond du gfreisch di scho narrisch d'rauf. Da geits au a \"Bl\195\164ck Edischn\" von dene Iwent-Coins - ab'r nur fir d' Helfa. Vielleicht kriagscht die ja au so.@@Jetzt ist es soweit. Das \"Geocoinfest\" findet dieses Jahr in Ulm statt und du hast dich schon so lange darauf gefreut. Du hast davon erfahren, dass es eine \"Black Edition\" der Event-Coins gibt - aber leider nur f\195\188r Helfer. Vielleicht kannst du ja doch irgendwo diese \"Black Edition\" ergattern.@@The GCF Europe is this year in Ulm and you've heard about a \"Black Coin Edition\" of the Event-Coins - but only the staff can get this special edition. May be there is a way to get some, too.", {PocketPC = 1})),
    Media = zmediaULM_Coins,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB1
  })
end
function ztimer01_Bastion:OnTick()
  var_03_Bastion = 1
end
function ztimer01_Parkplatz:OnTick()
  Wherigo.MessageBox({
    Text = WWB_localize([[
Hurahagel-zack-Zement ab'r au, 'etzt schnappt der Seggel mir doch glatt d'r Parkplatz weg.<BR>
<BR>
So, wo isch denn no oina ?@@So ein Mist !!! Kurz bevor du den Parkplatz erreicht hast, schnappt dir ein anderer diesen vor der Nase weg. <BR>
<BR>
Nicht verzagen, weiter suchen !@@Shit ! Another cacher was faster and parked his cachemobile at this parkinglot.]]),
    Media = zmedia01_Parkplatz_voll,
    Buttons = {
      WWB_localize("Weida sucha@@Weiter suchen@@Go on")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB2
  })
end
function ztimer03_Bastion:OnTick()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Da kommt ja d'r \"newnoiseedition\", doch &nbsp;der hat koin Schpatz g'seha. Dann muass d'r \"Ulma Schpatz\" doch nach links g'loffa sei.@@Auf deinem Weg nach rechts triffst du auf \"newnoiseedition\". Du fragst ihn, ob er vielleicht das Maskottchen - den \"Ulmer Spatz\" - gesehen hat, aber er sch\195\188tteln mit dem Kopf.<BR>\n<BR>\nScheint so, als sei das Maskottchen doch nach \"links\" gelaufen.@@On your way to the right you meet \"newnoiseedition\" and he told you that he hasn't seen anybody. <BR>\n<BR>\nSo go back and follow the way towards the railwaybridge.", {PocketPC = 1})),
    Media = zmediabjoern,
    Buttons = {
      WWB_localize(WWB_multiplatform_string("Z'ruck - zur Eisabahbruck@@Zur\195\188ck - Richtung Eisenbahnbr\195\188cke@@To the railwaybridge", {PocketPC = 1}))
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB3
  })
end
function zone01_Parkplatz:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_01_PP == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Schaug, da vorn ischa, d'r \"Ulma Schpatz\", d'r got Richtung Donau. <BR>\n<BR>\n'Etzt sau 'em ab'r schnell hintaher !!!@@Als du an der Parkplatz-Einfahrt ankommst, siehst du tats\195\164chlich noch das Maskottchen - den \"Ulmer Spatz\" - wie er sich mit Cachern kurz vor der Unterf\195\188hrung fotografieren l\195\164sst.<BR>\n<BR>\nAnschlie\195\159end geht er weiter Richtung Donau.<BR>\n<BR>\nJetzt aber - nimm deine F\195\188\195\159e in die Hand und jage schnell dem \"Ulmer Spatz\" hinterher !!!@@When you arrive at the entrance of the parking area, you see the \"Ulm Sparrow\" running towards the river Danube.<BR>\n<BR>\nNow hurry up !!!", {PocketPC = 1})),
      Media = zmediaulmer_spatz,
      Buttons = {
        WWB_localize("Sau hintaher@@Schnell hinterher@@Hurry up")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB4
    })
  else
    zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Enabled = true
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, 'etzt bisch grad am Parkplatz a'komma ond muasch scho blecha. 4,00 Euro willa hann, d'r Parkw\195\164chta.@@Du biegst soeben auf den Parkplatz vor der Event-Halle ein und musst erst einmal 4,00 Euro zahlen. <BR>\n<BR>\nTja - Parken direkt vor der Event-Location hat eben ihren Preis.@@You're arriving at the parking area and you've to pay 4,00 Euro. Ok, look for your purse.", {PocketPC = 1})),
      Media = zmedia01_Parkplatz,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      }
    })
  end
end
function zone01_Parkplatz_1eer:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Mei, dann nimmsch halt den Parkplatz, am Arsch d'r Welt.@@Ok, dann nimmst du halt diesen Parkplatz. Der ist zwar nicht direkt vor dem Eingang, aber immerhin hast du doch noch einen Parkplatz auf dem Eventgel\195\164nde gefunden.<BR>\n<BR>\nJetzt aber auf zur Coin-Messe.@@Ok, then you take this parkinglot, far, far away from the entrance.", {PocketPC = 1})),
    Media = zmedia01_Parkplatz_leer,
    Buttons = {
      WWB_localize("Auf got's@@Auf zur Coin-Messe@@Go to the GCF")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB6
  })
end
function zone01_Parkplatz_voll:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  ztimer01_Parkplatz:Stop()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("So a Dusel ab'r au. Kaum hasch dei K\195\164schmobil g'parkt, kommt au scho an ander's K\195\164schmobil om'd Ecke g'boga.@@Da hast du jetzt aber Gl\195\188ck gehabt - gerade als du in die Parkl\195\188cke einbiegst, kommt dir ein anderes Cachemobil entgegen. Der hat nun leider Pech gehabt !<BR>\n<BR>\nDu parkst dein Cachemobil und machst dich auf zum \"Geocoinfest\".@@You lucky guy - you arrived at the parkinglot just bevore an other cacher could claim this parkinglot.", {PocketPC = 1})),
    Media = zmedia01_Parkplatz_voll,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB7
  })
end
function zone02_Ausgang:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_02_Aus == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, da war doch oi Ladab'sitza, mit dem hasch doch no gar it so recht g'schw\195\164tzt.@@Als du gerade die Halle verlassen willst, hast du das Gef\195\188hl, dass doch einer der H\195\164ndler die \"Black Edition\" haben k\195\182nnte. Mit einem hattest du doch garnicht richtig geredet.@@Just wait - there was one dealer you haven't really talked to.", {PocketPC = 1})),
      Media = zmedia02_Eingang,
      Buttons = {
        WWB_localize(WWB_multiplatform_string("B'sitza aufsucha@@H\195\164ndler aufsuchen@@Go to dealer", {PocketPC = 1}))
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB8
    })
  elseif var_02_Aus == 2 then
    zcharacterDBernhardBernhardBernhard.Visible = true
    zcharacterDBernhardBernhardBernhard.Commands.SchwtzaAnsprechenTalkto.Enabled = false
    zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Enabled = true
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Beim Rausganga schtolpersch du \195\188b'r d'r \"Ulma Schpatz\" ond der f\195\164ngt di grad no auf bevor d' auf da Boda knalsch.<BR>\n<BR>\nWieda dussa, siagscht d'r Bernhard mit seine Memminga \"FTF-Radl'r-Freund\".@@Beim Verlassen der Halle st\195\182\195\159t du unfreiwillig mit dem Maskottchen des \"Geocoinfests\", dem \"Ulmer Spatz\" zusammen. Beinahe h\195\164ttest du eine Bauchlandung gemacht, wenn dir nicht der nette \"Spatz\" unter die Arme gegriffen und dich so aufgefangen h\195\164tte.<BR>\n<BR>\nIm &nbsp;Freien triffst du erneut auf Bernhard der gerade mit seinen Memminger \"FTF-Freunden\" die Lab-Caches angehen will.@@At the exit you stumble and the mascot of the GFC the \"Ulm Sparrow\" catches you up.<BR>\n<BR>\nBack at the parking area, you see Bernhard and his \"FTF-Biking-Friends\" from Memmingen.", {PocketPC = 1})),
      Media = zmedia02_Eingang,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB9
    })
  else
    var_02_Aus = 1
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("So, 'etzat bisch endlich in d'r Iwent-Halla mit all' de scheene M\195\188nzla. Ab'r wo kriagsch 'etzt die \"Bl\195\164ck Edischn\" hera. <BR>\n<BR>\nVielleicht siagscht ja oin Bekannta.@@Du betrittst nun die \"Heilige Halle\" mit den ganzen Coins auf die du dich schon seit dem letzten Geocoin Festival gefreut hast. Aber wo findet man nur die \"Black Edition\" der Event-Coins ?<BR>\n<BR>\nVielleicht siehst du ja einen Bekannten den du fragen kannst?@@You enter the hall with all the beautyful coins. But where can you find the special \"Black Coin Edition\". <BR>\n<BR>\nMay be you see someone known.", {PocketPC = 1})),
      Media = zmedia02_Eingang,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      }
    })
  end
end
function zone02_Stand_1:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_02_S1 == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, 'etzt sitzt der Bachel imma no so faul rum. Hat der vielleicht ebbes g'raucht ? Noi, der hat koi \"Bl\195\164ck Edischn\".@@Der H\195\164ndler sitzt immer noch etwas Abwesend hinter seinem Stand - als h\195\164tte er ein paar \"Space Cookies\" zu viel gegessen. &nbsp;Nein hier gibt es wirklich keine \"Black Edition\" der Ulmer Event-Coins.@@The daeler still looks boring. No, here you won't find the \"Black Coin Edition\". ", {PocketPC = 1})),
      Media = zmediahaendler_1,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB11
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Da Schtasch nun vor'm Lada vom \"H\195\164ppy Coin\" ond d'r B'sitza guckt bleed aus d'r W\195\164sch.@@Du stehst nun vor dem Stand von \"The Happy Coin\". Hier gibt es sehr viele sehr sch\195\182ne und exklusive Coins. Der H\195\164ndler sitzt etwas lustlos auf seinem Stuhl.@@Now you are in front of the geocoinshop \"The Happy Coin\". The owner looks very boring.", {PocketPC = 1})),
      Media = zmedia02_Stand_1,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      }
    })
  end
end
function zone02_Stand_2:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_02_S2 == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Na, da issa ja wied'r d'r K\195\164scha. Host der's doch no anders \195\188berlegt, h\195\164. Mogst doch no a \"Bl\195\164ck \195\132dischn\" von de \"Giga-Coins\" ?@@Ah, da bist du ja wieder. Hast du es dir doch noch \195\188berlegt. Willst du jetzt die \"Black-Giga-Coin-Edition\" ?@@Hi, here you are again. Do you now wanna buy the \"Black Giga Coin Edition\" ?", {PocketPC = 1})),
      Media = zmediahaendler_2,
      Buttons = {
        WWB_localize("I will@@Ja@@Yes"),
        WWB_localize("Naa@@Nein@@No")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB13
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Du bisch 'etzt am Lada vom \"Bavarian - Coins and More\" a'komma. D'r H\195\164ndla verhand'lt g'rad mit zwoi K\195\164scha d'r Preis von so 'em M\195\188nzla.@@Du kommst am Stand von \"The Bavarian - Coins and More\" an. Der H\195\164ndler unterh\195\164lt sich gerade sehr angeregt mit zwei Cachern und fuchtelt dabei wie wild mit seinen Armen umeinander.@@Now you are in front of the geocoinshop \"The Bavarian - Coins and More\".", {PocketPC = 1})),
      Media = zmedia02_Stand_2,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      }
    })
  end
end
function zone02_Stand_3:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_02_S3 == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("D'r B'sitza vom \"Schw\195\164bischa M\195\188nzla\" isch 'etzt wieda in sei'm Lada.@@Nun ist der H\195\164ndler des Geocoin-Shops \"Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht\" wieder allein hinter seinem Stand und er scheint auch nicht besch\195\164ftigt zu sein.@@The dealer of the \"Swabian Coins and More\" is back now in his shop.", {PocketPC = 1})),
      Media = zmediahaendler_3,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB18
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Am Lada vom \"Schw\195\164bischa M\195\188nzla\" schtod d'r B'sitza ond sei Weib ond raumat a paar M\195\188nzla omanand.@@Am Stand vom \"Schw\195\164bischen M\195\188nzla\" sortiert gerade eine Frau Coins ein und ein Mann stapelt leere Kartons aufeinander.@@At the geocoinshop of \"Swabian Coins and More\" you see the owner and his wife.", {PocketPC = 1})),
      Media = zmedia02_Stand_3,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      }
    })
  end
end
function zone03_Donauufer_Bastion:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_03_Bastion == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, wo isch'r denn 'etzt ? Koina weit ond breit in Siacht.<BR>\n<BR>\nWo gasch 'etzt na ?@@Scheint so, als w\195\164rst du nicht schnell genug gerannt. Weit und breit keine Spur vom \"Ulmer Spatz\" und auch sonst niemand da den du fragen k\195\182nntest.<BR>\n<BR>\nWo soll's nun weiter gehen - rechts oder links ?@@While arriving at the shore, you don't see anybody. <BR>\n<BR>\nWhere you wanna go now ?", {PocketPC = 1})),
      Media = zmediafragezeichen,
      Buttons = {
        WWB_localize("Links@@Links@@Left"),
        WWB_localize("Rechts@@Rechts@@Right")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB20
    })
  else
    ztimer01_Bastion:Stop()
    zone03_Donauufer_Bastion.Active = false
    zone03_Donauufer_Bastion.Visible = false
    zone04_Eisenbahnbrcke.Active = true
    zone04_Eisenbahnbrcke.Visible = true
    zone04_Eisenbahnbrcke.Name = WWB_localize(WWB_multiplatform_string("D' Eisabahbruck@@Eisenbahnbr\195\188cke@@Railwaybridge"))
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, da isch a ja - 'etzt goat d'r Schpatz nach links, Richtung d'r Eisabahbruck.@@Als du am Donauufer ankommst, siehst du wie der \"Ulmer Spatz\" auf dem Uferweg links Richtung Eisenbahnbr\195\188cke l\195\164uft. Laufe nun nach links Richtung Eisenbahnbr\195\188cke am Donauufer entlang.@@You see the sparrow walking left towards the railwaybrige.", {PocketPC = 1})),
      Media = zmediaulmer_spatz,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB23
    })
  end
end
function zone04_Eisenbahnbrcke:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  zone05_Mitte_Brcke.Name = WWB_localize(WWB_multiplatform_string("In d'r Mitta von d'r Bruck@@Mitte der Eisenbahnbr\195\188cke@@Middle of the bridge"))
  zone04_Eisenbahnbrcke.Name = WWB_localize(WWB_multiplatform_string("D' Eisabahbruck@@Die Eisenbahnbr\195\188cke@@Railwaybridge"))
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("'Etzt bisch an d'r Eisabahbruck a'komma. Ab'r da isch koi alte Sau.@@Du bist nun an der Eisenbahnbr\195\188cke, die \195\188ber die Donau f\195\188hrt, angekommen. Weit und breit ist keine Menschenseele, geschweige denn ein \"Ulmer Spatz\" zu sehen.@@You arrive at the railwaybridge, but there's nobody.", {PocketPC = 1})),
    Media = zmedia04_Eisenbahnbrcke,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB24
  })
end
function zone05_Mitte_Brcke:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  zone06_Donauufer_Mitte.Name = WWB_localize("'S Ulma Ufa@@Ulmer Donauufer@@The Ulm shoreside")
  var_99_Rucksack = 1
  zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Enabled = true
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("'Etzt siagscht zwar die ganze Ufaregion, ab'r koine Details !<BR>\n<BR>\nOnd was machsch 'etzt ?@@Du kommst auf der Mitte der Br\195\188cke an. Ja, von hier aus kann man die gesamte Uferregion \195\188berblicken. Leider kannst du keine Details am Ufer erkennen.<BR>\n<BR>\nWas nun ?@@From the railwaybridge you have a view of the whole shore but you can't see any details.<BR>\n<BR>\nWhat you wanna do now ?", {PocketPC = 1})),
    Media = zmedia05_Eisenbahnbrcke_Mitte,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    }
  })
end
function zone06_Donauufer_Mitte:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  Wherigo.MessageBox({
    Text = WWB_localize([[
Kruzefix ab'r au - 'etzt isch d'r Schpatz scho wieda fut !<BR>
<BR>
Ab'r da schtandat ja a paar "Ulma".@@Du kommst an dem Punkt an, an dem du eben noch den "Ulmer Spatz" gesehen hast - aber weder das Maskottchen noch die Cachergruppe sind noch da. <BR>
<BR>
So ein Mist !<BR>
<BR>
Wie gut, dass gerade verschiedene "Ulmer" aus unterschiedlichen Richtungen sich genau hier treffen.@@While arriving, there's no sparrow anymore at the Ulm shoreside.<BR>
<BR>
But you see some of "The Ulmer".]]),
    Media = zmedia06_Donauufer_Mitte,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    }
  })
end
function zone07_Fischerpltzle:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Da isch'r ja der \"Ulma Schpatz\" - mitta in a K\195\164schertraube, die ihn elle fotografiera wolla.@@Du betrittst das \"Fischerpl\195\164tzle\" im Ulmer Fischerviertel. Und tats\195\164chlich - da steht das Maskottchen - der \"Ulmer Spatz\" - mitten in einer Cachertraube, die sich alle mit ihm fotografieren lasen wollen.@@At the \"Fishersplace\" you see the \"Ulm Sparrow\" in a crowd of cacher, who wanna take a picture of the GFC mascot.", {PocketPC = 1})),
    Media = zmedia07_Fischerpltzle,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB27
  })
end
function zone07_Stadtmauer:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  if var_07_UV_weg == 1 then
    zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Enabled = true
    zitemASchwarzlichtUVLampeUVTorch.Visible = true
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("'Etzt bisch wieda an der Schdatmaua ond tats\195\164chlich da isch es, dei Schwarzlicht.@@Du bist nun wieder auf der Stadtmauer angekommen und suchst nach deiner UV-Lampe und tats\195\164chlich da liegt sie.@@You're back at the \"Town Wall\" and really there is your UV-torch.", {PocketPC = 1})),
      Media = zmedia07_Stadtmauer,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB28
    })
  elseif var_99_Rucksack_auf == 1 then
    var_07_UV_weg = 1
    zitemASchwarzlichtUVLampeUVTorch.Visible = false
    zitemASchwarzlichtUVLampeUVTorch:MoveTo(zone07_Stadtmauer)
    Wherigo.MessageBox({
      Text = WWB_localize("Ha, da isch koi Schpatz weit ond breit - nirgends isch da irgendoina.@@Als du auf der Stadtmauer ankommst, ist kein Maskottchen zu sehen. Auch als du dich umschaust, siehst du keinen \"Ulmer Spatz\".@@When arriving at the \"Town Wall\", there's no sparrow for miles around."),
      Media = zmedia07_Stadtmauer,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB29
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize("Ha, da isch koi Schpatz weit ond breit - nirgends isch da irgendoina.@@Als du auf der Stadtmauer ankommst, ist kein Maskottchen zu sehen. Auch als du dich umschaust, siehst du keinen \"Ulmer Spatz\".@@When arriving at the \"Town Wall\", there's no sparrow for miles around."),
      Media = zmedia07_Stadtmauer,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB29
    })
  end
end
function zone07_Ufertribne:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("An d'r Ufatrib\195\188n siagscht d'r \"Gackahaufa\" die grad de K\195\164scha auf d'r \"Ulma Schacht'l\" zuwinkat.@@Du bist nun an der Trib\195\188ne am Donauufer angekommen. An der Trib\195\188ne steht unter andern der \"Gackerhaufen\" und winkt den Cachern auf der \"Ulmer Schachtel\" zu, die gerade vorbeif\195\164hrt.@@At the shore platform near the Danube you meet the \"Gackerhaufen\".", {PocketPC = 1})),
    Media = zmedia07_Ufertribne,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    }
  })
end
function zone08_Tradi:OnEnter()
  Wherigo.PlayAudio(zmedia00_Alarm)
  Wherigo.MessageBox({
    Text = WWB_localize([[
So, 'etzt bisch bei de Koordinata - wie war 'etzt d'r Hint ?<BR>
<BR>
HINT (ROT 13): Mjvfpun qr Fgnrzz iba q'e Xnfpugnavr, erpugf aron q'e qvpxn Jhem'y@@So, du bist nun bei den Koordinaten angekommen. Wie lautete der Hint noch einmal ? <BR>
<BR>
HINT (ROT 13): Mjvfpura qra Fgnrzzra qre Qerv-Fgnzz-Xnfgnavr, erpugf arora qre tebffra Jhemry.@@You arrive at the coords. The Hint is:<BR>
<BR>
HINT (ROT 13): orgjrra gur guerr-cbyr-gerr, arkg gb gur ovt ebbg.]]),
    Media = zmedia08_Tradi,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next"),
      WWB_localize(WWB_multiplatform_string("Hint Azoiga@@Hint Entschl\195\188sseln@@Decrypt Hint", {PocketPC = 1}))
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB31
  })
end
function zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins:OnNachdeMnzlafragaNachCoinfragenAskforcoins()
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Enabled = false
  zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Enabled = true
  Wherigo.Dialog({
    {
      Text = WWB_localize(WWB_multiplatform_string("I hann vorher scho mit dei'm Weib g'schprocha, ab'r die hat koi Ahnung von 'er \"Bl\195\164ck Edischn\" von dene Iwent-Coins. Woischt du wo i die herkriag ?@@Tschuldigung, ich hatte zwar schon mit deiner Frau gesprochen, aber kannst du mir vielleicht sagen wie man an die \"Black Edition\" der Event-Coins kommt ?@@Can you tell me where I can buy the \"Black Coin Edition\" of the GCF-Event-Coins ?")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha dia geits nur fir'd Helfa vom Iwent. Die kaasch it kaufa.@@Diese gbt es nur f\195\188r Helfer des Geocoinfests, die kann man nicht kaufen.@@The \"Black Coin Edition\" is only for the staff. You can't buy this edition.")),
      Media = zmediahaendler_3
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, geits da koi and're &nbsp;M\195\182glichkeit die z'bsorga ?@@Gibt's denn da keine ander M\195\182glichkeit an diese \"Black Edition\" zu kommen ?@@Is there no possibility to buy this edition.")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Also, i hann da no oi Set von derer \"Bl\195\164ck \195\132dischn\", ab'r des geits fei it umasoscht.<BR>\n<BR>\nFir fuchzg Euro kasches hann.@@Also, ich hab' da noch einen Satz von dieser \"Black Edition\", aber die gibt es nat\195\188rlich nicht umsonst !<BR>\n<BR>\nF\195\188r 50 Euro kannst du sie haben.@@Ok, I\226\128\152ve just one set of this \"Black Coin Edition\" left.<BR>\n<BR>\nIf you want it, give me 50 Euro.")),
      Media = zmediahaendler_3
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, i hann's doch g'wisst. Irgendwia kommt m'r doch no an die \"Bl\195\164ck Edischn\".<BR>\n<BR>\n'Etzad no zahla ond die \"Bl\195\164ck Edischn\" g'h\195\182rt dia.@@ Na also - du hast es ja schon immer gewusst. Irgendwie kommt man doch an diese \"Black Edition\" - auch wenn man kein Helfer ist. <BR>\n<BR>\nJetzt noch schnell zahlen und die \"Black Edition\" geh\195\182rt dir !@@There is always a way to get the \"Black Coin Edition\".<BR>\n<BR>\nYou just have to pay and the \"Black Coin Edition\" is yours.")),
      Media = zmediaSpieler
    }
  })
end
function zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins:OnSchwtzaAnsprechenTalkto()
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Enabled = false
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Enabled = true
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Visible = false
  Wherigo.Dialog({
    {
      Text = WWB_localize(WWB_multiplatform_string("He, kascht du mir saga, wo i die \"Bl\195\164ck Edischn\" von dene Iwent-Coins herbekomm ?@@Hallo, wei\195\159t du vielleicht wo man die \"Black Edition\" der Event-Coins herbekommt.@@Do you know where I can buy the \"Black Coin Edition\" of the GCF-Event-Coins ?")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("I hann 'etzt koi Zeit. Kasch mal mei Frau fraga, i muas no a paar M\195\188nzla aus'm Auto hola.@@Ich habe jetzt keine Zeit, ich muss noch ein paar Coins aus dem Auto holen. Du kannst aber mal meine Frau fragen.@@Sorry, I'm busy - but asked my wife.")),
      Media = zmediahaendler_3
    }
  })
end
function zcharacterBsitzaTheBavarianHndlerTheBavarianOwnerTheBavarian:OnSchwtzaAnsprechenTalkto()
  var_02_S2 = 1
  zone02_Stand_2.Active = false
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("He, hasch a mol a Ohr fier mi ?@@Entschuldigung, kann ich dich mal kurz st\195\182ren ?@@Excuse me, Sir ?", {PocketPC = 1})),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB34
  })
end
function zcharacterBsitzaTheHappyCoinHndlerTheHappyCoinOwnerTheHappyCoin:OnSchwtzaAnsprechenTalkto()
  var_02_S1 = 1
  zone02_Stand_1.Active = false
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("He, kasch du mir saga, wo i d' \"Bl\195\164ck Edischn\" von de Iwent-Coins kriaga ka ?@@Hallo, kannst du mir zuf\195\164llig die \"Black Edition\" der Event-Coins besorgen ?@@Hello, do you know, where I can get the \"Black Coin Edition\" of the Event-Coins ?", {PocketPC = 1})),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB42
  })
end
function zcharacterDBernhardBernhardBernhard:OnMnzlazoigaCoinszeigenShowcoins()
  zcharacterDrGeigiGeigi22Geigi22.Visible = true
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Media = WWB_change_media(zmediaLM_Coins)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Description = WWB_localize(WWB_multiplatform_string("D' \"Bl\195\164ck Edischn\" ab'r ohne des \"U\".@@Die \"Black Edition\" der Event-Coins des Geocoin Festivals in Ulm. Allerdings fehlt das \"schwarze U.\"@@The \"Black Coin Edition\" without the \"black U\"."))
  zcharacterDBernhardBernhardBernhard.Commands.MnzlazoigaCoinszeigenShowcoins.Enabled = false
  Wherigo.Dialog({
    {
      Text = WWB_localize(WWB_multiplatform_string("He Bernhard, schaug mal, was i grad g'kauft hab.@@He Bernhard, vielen, vielen, Dank f\195\188r den Tipp. Auf dich kann man sich halt verlassen, wenn man mal einen guten Rat braucht.<BR>\n<BR>\nSchau mal was ich gerade ergattern konnte.@@Hi Bernhard, thank you very much. Look what I've bought.")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Du gruschtelscht in deina Jacken, aber da sind nur zwoi M\195\188nzla ond koi \"U\" - des fehlt.@@Du holst deine Coins aus der linken Brusttasche deiner Jacke, aber es sind nur zwei !!! - das \"schwarze U\" fehlt.@@You are looking for the \"Black Coin Edition\" in the pocket of your jacket, but the \"black U\" is missing.")),
      Media = zmediaLM_Coins
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, hasch da it oine vergessa. Des sand ja nur zwoi M\195\188nzla. Was hasch denn mit'em \"schwarza U\" g'macht ?@@Nun, das sind aber nur zwei Coins - hast du da nicht eine vergessen ? Fehlt da nicht das \"schwarze U\" ?@@I only see two Coins - where is the \"black U\" ?")),
      Media = zmediabernhard
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, du bischt d'r ganz sicha, dass de elle drui M\195\188nzla in dei Jackentasch nei dau hasch. Da muas oiner des \"U\" g'klaut hann.@@Du bist dir ganz sicher, dass du alle drei Coins in die Tasche gesteckt hast. Das kann nur hei\195\159en, dass dir jemand das \"schwarze U\" geklaut haben muss. Aber wann und wie.@@You're sure, that you put all three coins in your jacket. Someone must have stolen the \"black U\"-coin.")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize("Wia g'klaut ? Ja hat di denn oina a'grempelt od'r so ?@@Wie geklaut ? Hat dich denn jemand in der Event-Halle angerempelt ?@@Oh shit. Someone has stolen the \"U\"-coin ? Do you know who ?"),
      Media = zmediabernhard
    },
    {
      Text = WWB_localize([[
Ha des ka doch blos der "Schpatz" gwea sei, als'r di beim Eingang aufgfanga hat. Ab'r wo isch der 'etzt na ?<BR>
<BR>
So nun kommt au scho d'r "Geigi" vom Bahnhof ond will sich hier mit seine Freund treffa.@@Das kann eigentlich nur das Maskottchen - der "Ulmer Spatz" - gewesen sein, als er dich so hilfsbereit aufgefangen hat. Aber wo ist der nur hin ?<BR>
<BR>
Mittlerweile gesellt sich auch "Geigi22", der gerade vom Bahnhof kommt, zu seinen FTF Radler-Freunden aus Memmingen.@@The thieve must be the "Ulm Sparrow"- he was the only one who touched you. <BR>
<BR>
Meanwhile "Geigi22" arrives from the railwaystation and meets here with his friends.]]),
      Media = zmediaSpieler
    }
  })
end
function zcharacterDBernhardBernhardBernhard:OnSchwtzaAnsprechenTalkto()
  zone02_Ausgang.Name = WWB_localize("D'r Ausgang@@Halle - Ausgang@@Exit")
  zone02_Ausgang.Active = false
  zone02_Stand_1.Name = WWB_localize("The Happy Coin")
  zone02_Stand_1.Active = true
  zone02_Stand_2.Name = WWB_localize("The Bavarian - Coins and More")
  zone02_Stand_2.Active = true
  zone02_Stand_3.Name = WWB_localize(WWB_multiplatform_string("Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht@@Schw\195\164bische M\195\188nzla ond Soschtiga Gruscht@@Swabian Coins and More"))
  zone02_Stand_3.Active = true
  zcharacterDBernhardBernhardBernhard.Visible = false
  Wherigo.Dialog({
    {
      Text = WWB_localize("Ha, d'r Bernhard. Des isch ja klar, dass m'r di hier trifft.@@Hallo Bernhard, ist ja klar, dass man dich auch hier trifft.@@Hello Bernhard, nice to meet you."),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ja " .. Player.Name .. " bischt du au da. Ha mit dir han i 'etzt gar it g'rechnet. Wilscht wied'r nach a paar seltana Coins luaga, ha ?@@Hallo " .. Player.Name .. ", sch\195\182n dich zu sehen. Mit dir habe ich jetzt gar nicht gerechnet. Bist du wieder auf der Suche nach ein paar seltenen Coins ?@@Hello " .. Player.Name .. ", nice to meet you, too. You're looking for some special coins ?")),
      Media = zmediabernhard
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha ja, i suach di \"Bl\195\164ck Edischn\" von dene \"Iwent-Coins\". Hasch du a Ahnung wo i di kriaga ka ?@@Na ja, ich bin auf der Suche nach der \"Black Edition\" der Event-Coins. Hast du vielleicht eine Ahnung, ob irgendein H\195\164ndler diese \"Helfer Edition\" auch unter der Hand verkauft ?@@I'm looking for the special \"Black Coin Edition\" of the GCF. Do you know where I can get this \"Black Coin Edition\" ?")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha da luagascht am beschta moal beim \"Happy Coin\", beim \"Bavarian\" od'r beim \"Schw\195\164bischa M\195\188nzla\" vorbei. Da kedschd vielleicht Gl\195\188ck hann.@@Nun, da schaust du am besten mal beim \"Happy Coin\", beim \"Bavarian\" oder beim \"Schw\195\164bischen M\195\188nzla\" vorbei. Da k\195\182nntest du vielleicht Gl\195\188ck haben.@@May be you can get this \"Black Coin Edition\" at \"The Happy Coin\", \"The Bavarian\" or at \"Swabian Coins and More\".")),
      Media = zmediabernhard
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, dann schaug i halt bei dene vorbei. Ma siagt sich dann beim K\195\164scha.@@Danke, Bernhard. Dann werde ich mal dort mein Gl\195\188ck versuchen. Vielleicht sieht man sich ja noch beim Dosensuchen.@@Thanks a lot. See you while caching.")),
      Media = zmediaSpieler
    }
  })
end
function zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore:OnSchwtzaAnsprechenTalkto()
  var_02_S3 = 1
  zone02_Stand_3.Active = false
  zcharacterDFrauvomBsitzaSchwbischeMnzlaHndlerinSchwbischeMnzlaOwnerswifeofSwabianCoinsandMore.Visible = false
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("He, hasch du dui \"Bl\195\164ck Iwent Coin Edischn\" ?@@Tschuldigung, hast du vielleicht 'ne Ahnung wo man die \"Black Edition\" der Event-Coins herbekommt ?@@Do you know, where I can get the \"Black Event Coin Edition\" ?", {PocketPC = 1})),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB45
  })
end
function zcharacterDGackahaufaGackerhaufenTheGackerhaufen:OnSchwtzaAnsprechenTalkto()
  zone07_Ufertribne.Active = false
  zone07_Ufertribne.Visible = false
  Wherigo.Dialog({
    {
      Text = WWB_localize(WWB_multiplatform_string("Mensch, d'r \"Gackahaufa\". Hann'd ihr d'r \"Ulma Schpatz\" g'seha ?@@Hallo ihr zwei, habt ihr zuf\195\164llig gesehen, ob das Maskottchen - der \"Ulmer Spatz\" - auf der \"Ulmer Schatel\" ist ?@@Hi, have you seen the \"Ulm Sparrow\" - the mascot of the GCF ?")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Na klar, des iss doch au a Attraktion fir unsera G\195\164schte vom Geocoin Feschtival.@@Na klar, das ist doch eine unserer Attraktionen des Geocoinfests.@@Of course, the \"Sparrow\" is one of our attractions of the GCF 2014.")),
      Media = zmediagackerhaufen
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, der hat g'rad mei M\195\188nzle g'schtola.@@Aber der hat gerade meine Geocoin - das \"schwarze U\" gestohlen.@@This \"Sparrow\" have stolen my \"Black U Coin\".")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Des ka gar it sei. Des isch doch d'r \"octi\", der f\195\164hrt doch scho d'r ganze Tag auf d'r \"Schacht'l\" umanand.@@Das kann gar nicht sein, das ist doch \"octi\". Der f\195\164hrt heute schon den ganzen Tag auf der \"Ulmer Schachtel\" umher.@@That's impossible, the \"Sparrow\" is \"octi\" - an Ulm Geocacher. He's on this boat the whole day long. ")),
      Media = zmediagackerhaufen
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, wenn des d'r \"octi\" isch, dann geids wohl an Dopplg\195\164nga vom \"Ulma Schpatz\".@@Wenn das \"octi\" ist, dann muss es also einen Doppelg\195\164nger vom \"Ulmer Spatz\" geben.@@If the \"Sparrow\" is \"octi\", there must be a double of the \"Ulm Sparrow\".")),
      Media = zmediaSpieler
    }
  })
end
function zcharacterDrGeigiGeigi22Geigi22:OnSchwtzaAnsprechenTalkto()
  zcharacterDrGeigiGeigi22Geigi22.Commands.SchwtzaAnsprechenTalkto.Enabled = false
  zone02_Ausgang.Active = false
  zone02_Ausgang.Visible = false
  zone01_Parkplatz.Active = true
  Wherigo.Dialog({
    {
      Text = WWB_localize(WWB_multiplatform_string("He Geigi, d'r \"Ulma Schpatz\" hat m'r g'rad mei \"U-M\195\188nzle\" g'schtola.@@Mensch Geigi, der \"Ulmer Spatz\" hat mir gerade mein \"schwarzes U\" geklaut.@@Hi Geigi, the \"Ulm Sparrow\" has stolen my \"black U\"-coin.")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize("Wie ? Wer hat dir g'rad ebbes g'klaut ? Irgendwie verstand i grad nur Bahnhof, obwohl, da komm i ja g'rad her !@@Wie ? Wer hat dir gerade was geklaut ? Ich versteh gerade nur Bahnhof, obwohl da komme ich ja gerade her !@@Who has stolen you what ?"),
      Media = zmediageigi22
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("I hann g'rad die \"Bl\195\164ck Edischn\" von dene Iwent-Coins g'kauft ond dann bin i mit'm \"Ulma Schpatz\" zeemag'schtossa ond 'etza fehlt m'r des \"schwarze U\". Hasch du vielleicht d'r \"Schpatz\" g'seha ?@@Ich hab gerade die \"Black Edition\" der Event-Coins ergattert und dann bin ich mit dem \"Ulmer Spatz\" - dem Maskottchen vom GCF - zusammengsto\195\159en und seitdem fehlt mir die Coin mit dem \"schwarzen U\". Hast du vielleicht auf deinem Herweg das \"Ulmer Spatz Maskottchen\" gesehen ?@@Well, I just bought the \"Black Coin Edition\" of the GCF Event-Coins and then I crashed into the \"Ulm Sparrow\" - you know the mascot of the GCF 2014. Have you seen the \"Ulm Sparrow\" on your way to the event ?")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize("Ja, d'r \"Ulma Schpatz\" hann i am Parkplatzeingang g'seha. Der isch dann runter zu d'r Donau gloffa.@@Ja, der \"Ulmer Spatz\" ist vorne am Parkplatzeingang und ist dann Richtung Donau gelaufen.@@I've seen the \"Sparrow\" near the entrance to the parking area and then he got straigt towards the Danube."),
      Media = zmediageigi22
    },
    {
      Text = WWB_localize("'Etzt ab'r g'schwind zom Parkplatzeingang.@@Jetzt aber schnell zum Parkplatzeingang. Vielleicht erwischt du ihn ja noch.@@Go to the entrance of the parking area."),
      Media = zmedia01_Parkplatz
    }
  })
end
function zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow:OnMachaFotoMaskottchenfotografierenTakeapicture()
  zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Enabled = false
  zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Visible = false
  Wherigo.MessageBox({
    Text = WWB_localize("Du machscht an \"Selfie\" von dir ond 'em \"Ulma Schpatz\".@@Du stellst dich schnell neben das Maskottchen des Ulmer Geocoinfests - dem \"Ulmer Spatz\" - und machst ein Selfie von dir mit dem Spatz.@@You take a \"selfie\" - you and the \"Ulm Sparrow\"."),
    Media = zmediaulmer_spatz,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB49
  })
end
function zcharacterDUlmaDieUlmerTheUlmer:OnSchwtzaAnsprechenTalkto()
  zone06_Donauufer_Mitte.Active = false
  zone06_Donauufer_Mitte.Visible = false
  zone07_Stadtmauer.Active = true
  zone07_Stadtmauer.Name = WWB_localize("Schtadtmaua@@Stadtmauer@@Town Wall")
  zone07_Fischerpltzle.Active = true
  zone07_Fischerpltzle.Name = WWB_localize(WWB_multiplatform_string("S' Fischapl\195\164tzle@@Fischerpl\195\164tzle@@Fishersplace"))
  zone07_Ufertribne.Active = true
  zone07_Ufertribne.Name = WWB_localize(WWB_multiplatform_string("D' Ufa-Trib\195\188na@@Ufer-Trib\195\188ne@@Shore platform"))
  Wherigo.Dialog({
    {
      Text = WWB_localize("Ha, da send ja a paar \"Ulma\". Hat denn oiner von ui d'r \"Ulma Schpatz\" hiar g'seha ?@@Hallo zusammen, hat jemand von euch vielleicht den \"Ulmer Spatz\" - das Maskottchen vom Geocoinfest - auf eurem Weg gesehen ?@@Look some of \"The Ulmer\". Have someone of you seen the mascot of the GCF 2014 - the \"Ulm Sparrow\" ?"),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Na klar, der isch auf d'r \"Ulmer Schachtel\" da vorn an d'r Ufatrib\195\188n - kommt als Antwort von \"D'r DickichtDuggre\".@@Na klar, der ist auf der \"Ulmer Schachtel\" da vorne an der Ufertrib\195\188ne - kommt als Antwort von Frau \"DieDickichtDugger\"@@In deed, he's near the shore platform.")),
      Media = zmediaulmer
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Allm\195\164cht naa, da \"Schbads\" woar g'rood no auf'm \"Fischabl\195\164dzle\" - meint \"Fr\195\164ggae\".@@Nein, ich habe den \"Spatz\" gerade noch auf dem \"Fischerpl\195\164tzle\" gesehen - meint Fr\195\164ggae\".@@No way, he's on the \"Fishersplace\".")),
      Media = zmediaulmer
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Bl\195\182dsinn, der war g'rad no da oba auf d'r \"Schdatmaua\" - kommt's aus'm Maul vom \"geoquax\".@@Bl\195\182dsinn, der war gerade noch auf der \"Stadtmauer\" &nbsp;- kommt es aus \"geoquax\" Mund.@@No, I've seen him on the \"Town Wall\".")),
      Media = zmediaulmer
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ond 'etzad ? Wo gasch 'etzt na ?@@Und nun ? 3 Leute, 3 verschiedene Aussagen ! Jeder der \"Ulmer\" schw\195\182rt aber, dass er den \"Ulmer Spatz\" an dem von ihm beschriebenen Ort gesehen hat.<BR>\n<BR>\nAlso, wo willst du nun hingehen ?@@Three persons have seen the \"Sparrow\" at three differnt places ! Where do you want to go now ?")),
      Media = zmediafragezeichen
    }
  })
end
function zitemASchwarzlichtUVLampeUVTorch:OnAufhebaAufhebenPickup()
  zitemASchwarzlichtUVLampeUVTorch:MoveTo(Player)
  zitemASchwarzlichtUVLampeUVTorch.Visible = false
  zone07_Stadtmauer.Active = false
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du hebsch dei Schwarzlicht auf ond v'rschtausch es im K\195\164scher-S\195\164ckle.<BR>\n<BR>\n'Etzt kasch zom K\195\164sch ganga@@Du hebst die UV-Lampe auf und verstaust sie wieder sicher im Rucksack.<BR>\n<BR>\nSo nun kann es aber endlich zum Tradi gehen.@@You pick up your UV-torch and put it into your cacher-bag.<BR>\n<BR>\nNow go to the next cache.", {PocketPC = 1})),
    Media = zmediauv_lampe,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB50
  })
end
function zitemASchwarzlichtUVLampeUVTorch:OnEischaltaBenutzenUse()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du kasch des K\195\164sching-Werkzuig hiar nit benutza.@@Es macht keinen Sinn dieses Cacherwerkzeug hier zu benutzen ! Versuche es einfach mal mit einem anderen Gegenstand aus deinem Rucksack.@@You can't use this caching tool now.", {PocketPC = 1})),
    Media = zmediafragezeichen,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    }
  })
end
function zitemAusziehschpieglTeleskopspiegelTelescpoemirror:OnBenutzaBenutzenUse()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du kasch des K\195\164sching-Werkzuig hiar nit benutza.@@Es macht keinen Sinn dieses Cacherwerkzeug hier zu benutzen ! Versuche es einfach mal mit einem anderen Gegenstand aus deinem Rucksack.@@You can't use this caching tool now.", {PocketPC = 1})),
    Media = zmediafragezeichen,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB52
  })
end
function zitemDrFainalCodeCompletionCodeCompletionCode:OnDrFainalCodeCompletionCodeCompletionCode()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string([[
Hia hasch d'r "Fainal-Code" zom Logga auf "WerEiGo-Dott-Komm":<BR>
<BR>
 ]] .. Player.CompletionCode .. [[
 <BR>
<BR>
od'r wenn der nit goat dann d'r 15-schtellige Code: <BR>
<BR>
]] .. Player.CompletionCode15 .. [[
@@Der Completion-Code - zum Loggen auf "Wherigo.com" - lautet:<BR>
<BR>
 ]] .. Player.CompletionCode .. [[
 <BR>
<BR>
bzw. wenn dieser nicht funktioiert dann diesen 15-stelligen Code: <BR>
<BR>
]] .. Player.CompletionCode15 .. [[
@@The Completion-Code for "Wherigo.com":<BR>
<BR>
 ]] .. Player.CompletionCode .. [[
 <BR>
<BR>
or the 15-digit-Code: <BR>
<BR>
]] .. Player.CompletionCode15 .. "<BR>\n", {PocketPC = 1})),
    Media = zmediacode,
    Buttons = {
      WWB_localize(WWB_multiplatform_string("Aufh\195\182ra@@WIG beenden@@Quit WIG", {PocketPC = 1})),
      WWB_localize(WWB_multiplatform_string("Z'ruck@@Zur\195\188ck@@Back", {PocketPC = 1}))
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB53
  })
end
function zitemDrFotoaparatDigiCamTheDigiCam:OnDurchguggaBenutzenUse()
  if var_99_Rucksack == 1 then
    var_99_Rucksack = 2
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Du nimmsch dei Fotoaparat ond guckscht durch. Da is 'r ja d'r Schpatz - auf der Ulma Ufaseita.@@Du nimmst deine Digi-Cam aus deinem Cacher-Rucksack und suchst damit bei mittlerem Zoom-Faktor die Ufferregion nach dem \"Ulmer Spatz\" ab. Und tats\195\164chlich, da steht er Mitten in einer Cacher-Gruppe, die sich mit ihm fotografieren lassen.@@You take your digi-cam and zoom. Gotcha ! You find the \"Ulm Sparrow\" at the Ulm shoreside.", {PocketPC = 1})),
      Media = zmediadigicam,
      Buttons = {
        WWB_localize("Auf an's Ufa@@Zur Cacher-Gruppe@@Go to the shore")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB54
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Du kasch des K\195\164sching-Werkzuig hiar nit benutza.@@Es macht keinen Sinn dieses Cacherwerkzeug hier zu benutzen ! Versuche es einfach mal mit einem anderen Gegenstand aus deinem Rucksack.@@You can't use this caching tool now.", {PocketPC = 1})),
      Media = zmediafragezeichen,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB52
    })
  end
end
function zitemGeldsckleGeldbeutelPurse:OnDrParkplatzzahlaParkplatzzahlenPayfee()
  zitemGeldsckleGeldbeutelPurse.Commands.DrParkplatzzahlaParkplatzzahlenPayfee.Enabled = false
  var_01_PP = 1
  var_00_Geld = var_00_Geld - 4
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Himm'l, Arsch ond Zwirn - da hasch deine 4,00 Euro.<BR>\n<BR>\nSo, ond wo isch 'etzt a freia Parkplatz - h\195\164 ?@@Missmutig zahlst du deine 4,00 Euro und darfst auf den Parkplatz fahren.<BR>\n<BR>\nDie Idee direkt vor der Halle zu parken hatten schon mehrere Cacher vor dir. Wo ist denn nur ein freier Parkplatz f\195\188r dein Cachemobil ? Ah, da vorne ist noch ein freier Platz. Jetzt aber Gas geben, bevor dir noch jemand anderes ihn dir vor der Nase wegschnappt.@@You pay the fee and then you are looking for an empty parkinglot. <BR>\n<BR>\nWell, here's an empty parkinglot - now hurry up.", {PocketPC = 1})),
    Media = zmedia01_Parkplatz_voll,
    Buttons = {
      WWB_localize("Gib Gummi@@Gas geben@@Hurry up")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB55
  })
end
function zitemGeldsckleGeldbeutelPurse:OnGeldzhlaGeldzhlenCheckmoney()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du hasch grad " .. var_00_Geld .. ",00 Euro im S\195\164ck'l@@Du hast derzeit " .. var_00_Geld .. ",00 Euro in deinem Geldbeutel.@@You've " .. var_00_Geld .. ",00 Euro in your purse.", {PocketPC = 1})),
    Media = zmediageldbeutel,
    Buttons = {
      WWB_localize(WWB_multiplatform_string("Z'ruck@@Zur\195\188ck@@Back", {PocketPC = 1}))
    }
  })
end
function zitemGeldsckleGeldbeutelPurse:OnMnzlazahlaCoinbezahlenPaythecoins()
  zone02_Stand_1.Active = false
  zone02_Stand_1.Visible = false
  zone02_Stand_2.Active = false
  zone02_Stand_2.Visible = false
  zone02_Stand_3.Active = false
  zone02_Stand_3.Visible = false
  zone02_Ausgang.Active = true
  zitemGeldsckleGeldbeutelPurse.Commands.MnzlazahlaCoinbezahlenPaythecoins.Enabled = false
  var_00_Geld = var_00_Geld - 50
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du gibsch dem Halodri seine 50 Euro ond schtecksch die M\195\188nzla in dei linke Bursttascha von deiner K\195\164scha-Jacka.@@Du zahlst schnell die 50,00 Euro - auch wenn der Preis etwas \195\188berteuert erscheint - Hauptsache du bist nun endlich im Besitz der \"Black Edition\" der Event-Coins. Du nimmst die Coins, steckst sie in deine linke Brusttasche deiner Jacke und gehst Richtung Ausgang.@@You pay the 50 Euro, take the \"Black Coin Edition\" and put it into left pocket of your jacket.", {PocketPC = 1})),
    Media = zmediageldbeutel,
    Buttons = {
      WWB_localize("Rausganga@@Zum Ausgang@@To the exit")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB57
  })
end
function zitemSHiraLichtStirnLampeTorch:OnEischaltaBenutzenUse()
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du kasch des K\195\164sching-Werkzuig hiar nit benutza.@@Es macht keinen Sinn dieses Cacherwerkzeug hier zu benutzen ! Versuche es einfach mal mit einem anderen Gegenstand aus deinem Rucksack.@@You can't use this caching tool now.", {PocketPC = 1})),
    Media = zmediafragezeichen,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB52
  })
end
function zitemSKscherSckleCacherRucksackCacherbag:OnAufmachaffnenOpen()
  var_99_Rucksack_auf = 1
  zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Enabled = false
  zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Enabled = true
  zitemDrFotoaparatDigiCamTheDigiCam.Visible = true
  zitemTschiePieEssGPSGPS.Visible = true
  zitemSHiraLichtStirnLampeTorch.Visible = true
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Visible = true
  zitemASchwarzlichtUVLampeUVTorch.Visible = true
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Dei K\195\164scha-S\195\164ckle isch 'etzt auf ond du kasch d'r ganze Gruscht darin benutza@@Dein Rucksack ist nun auf und du kannst jetzt auf deine Cacher-Utensilien zugreifen.@@Your back is unlocked and you can use your caching tools.", {PocketPC = 1})),
    Media = zmediarucksack,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    }
  })
end
function zitemSKscherSckleCacherRucksackCacherbag:OnZumachaSchlieenClose()
  var_99_Rucksack_auf = 0
  zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Enabled = false
  zitemSKscherSckleCacherRucksackCacherbag.Commands.AufmachaffnenOpen.Enabled = true
  zitemDrFotoaparatDigiCamTheDigiCam.Visible = false
  zitemTschiePieEssGPSGPS.Visible = false
  zitemSHiraLichtStirnLampeTorch.Visible = false
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Visible = false
  zitemASchwarzlichtUVLampeUVTorch.Visible = false
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("'S K\195\164scha-S\195\164ckle isch 'etzt wieda zu ond d'r ganze Gruscht verschtaut.@@Dein Rucksack ist nun zu und deine Cacher-Utensilien sind nun wieder sicher verwahrt.@@Your bag is locked again and your caching tools are safe.", {PocketPC = 1})),
    Media = zmediarucksack,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    }
  })
end
function zitemTschiePieEssGPSGPS:OnEischaltaBenutzenUse()
  if var_99_Rucksack == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Du kasch des K\195\164sching-Werkzuig hiar nit benutza.@@Es macht keinen Sinn dieses Cacherwerkzeug hier zu benutzen ! Versuche es einfach mal mit einem anderen Gegenstand aus deinem Rucksack.@@You can't use this caching tool now.", {PocketPC = 1})),
      Media = zmediafragezeichen,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB52
    })
  elseif zone07_Stadtmauer:Contains(zitemASchwarzlichtUVLampeUVTorch) then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Als du dei \"Tschie-Pie-Ess\" hola wilsch, siagscht dass es K\195\164scher-S\195\164ckle offa war ond dei Schwarzlicht fut isch. <BR>\n<BR>\nDes ka eigentlich nur an d'r Schtadtmaua rausg'falla sei, als du dir deine Schuh zu'bunda hasch.@@Gerade als du dein GPS aus dem Rucksack hollen und einschalten willst, stellst du fest, dass dein Rucksack noch offen ist und deine UV-Lampe fehlt.<BR>\n<BR>\nDiese kann eigentlich nur auf der Stadtmauer liegen, da du dich hier kurz geb\195\188ckt hattest, um deine Schuhe neu zu binden.@@While looking for you GPS you recognize that your bag is open and you've lost you UV-torch. <BR>\n<BR>\nThis must happend at the \"Town Wall\" while bending your shoes.", {PocketPC = 1})),
      Media = zmediagps,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB60
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Du machsch dei \"Tschie-Pie-Ess\" a ond dei S\195\164ckle wieda zua.@@Du schaltest dein GPS ein und machst anschlie\195\159end deinen Rucksack wieder zu.@@You turn on your GPS and close your bag.", {PocketPC = 1})),
      Media = zmediagps,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB62
    })
  end
end
function zinput00_Code:OnGetInput(input)
  var_00_Code = input
  if var_00_Code ~= nil then
    if Wherigo.NoCaseEquals(var_00_Code, WWB_localize("GC2MEET04")) then
      Wherigo.MessageBox({
        Text = WWB_localize(WWB_multiplatform_string("'S \"Geocoinfescht\" fendet huier z' Ulm statt ond du gfreisch di scho narrisch d'rauf. Da geits au a \"Bl\195\164ck Edischn\" von dene Iwent-Coins - ab'r nur fir d' Helfa. Vielleicht kriagscht die ja au so.@@Jetzt ist es soweit. Das \"Geocoinfest\" findet dieses Jahr in Ulm statt und du hast dich schon so lange darauf gefreut. Du hast davon erfahren, dass es eine \"Black Edition\" der Event-Coins gibt - aber leider nur f\195\188r Helfer. Vielleicht kannst du ja doch irgendwo diese \"Black Edition\" ergattern.@@The GCF Europe is this year in Ulm and you've heard about a \"Black Coin Edition\" of the Event-Coins - but only the staff can get this special edition. May be there is a way to get some, too.", {PocketPC = 1})),
        Media = zmediaULM_Coins,
        Buttons = {
          WWB_localize("Weida@@Weiter@@Next")
        },
        Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB1
      })
    else
      Wherigo.MessageBox({
        Text = WWB_localize("Was hasch 'etzt da wied'r fir'n Schmarrn eingeba ? Probia's no amol od'r lass bleiba.@@Der eingegebene Start-Code war leider nicht richtig. Versuche es noch einmal oder beende das Spiel.@@Sorry, you entered an incorrect code. Please try again or quit game."),
        Media = zmediacode,
        Buttons = {
          WWB_localize("No amol@@Erneuter Versuch@@Try again"),
          WWB_localize("Lass bleiba@@Spiel beenden@@Quit game")
        },
        Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB64
      })
    end
  end
end
function zinput04_Eingabe:OnGetInput(input)
  var_04_Eingabe = input
  if var_04_Eingabe ~= nil then
    if Wherigo.NoCaseEquals(var_04_Eingabe, WWB_localize(WWB_multiplatform_string("In d'r Mitt von der Bruck@@Mitte der Eisenbahnbr\195\188cke@@Middle of the bridge"))) then
      zone05_Mitte_Brcke.Active = true
      Wherigo.MessageBox({
        Text = WWB_localize(WWB_multiplatform_string("Hiar von d'r Eisabahbruck aus siagscht die ganze Ufaregion.@@Ja, genau. Von der Mitte der Eisenbahnbr\195\188cke kannst du die gesamte Uferregion \195\188berblicken. Also auf zur Mitte der Eisenbahnbr\195\188cke.@@Yes, from the middle of the bridge you have a view of the whole shore.", {PocketPC = 1})),
        Media = zmedia05_Eisenbahnbrcke_Mitte,
        Buttons = {
          WWB_localize("Weida@@Weiter@@Next")
        }
      })
    else
      Wherigo.MessageBox({
        Text = WWB_localize(WWB_multiplatform_string("Du Bachel, hiar sand doch lauta B\195\164um', da siagscht koin Weg !@@Nein, von hier aus stehen dir viel zu viel B\195\164ume im Weg. Von hier aus siehst du nur ein Teil der Uferregion.@@No, that's the wrong place. Here you can see nobody.", {PocketPC = 1})),
        Buttons = {
          WWB_localize("Weida@@Weiter@@Next")
        },
        Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB66
      })
    end
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB1(action)
  zone01_Parkplatz.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB2(action)
  zone01_Parkplatz_voll.Active = false
  zone01_Parkplatz_voll.Visible = false
  zone01_Parkplatz_1eer.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB3(action)
  zone04_Eisenbahnbrcke.Active = true
  zone04_Eisenbahnbrcke.Visible = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB4(action)
  zone01_Parkplatz.Active = false
  zone01_Parkplatz.Visible = false
  zone03_Donauufer_Bastion.Active = true
  zone03_Donauufer_Bastion.Name = WWB_localize("D' \"Ob're Donaubaschtio\"@@Donauufer - Obere Donaubastion@@The \"Upper Danube Bastion\"")
  ztimer01_Bastion:Start()
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB6(action)
  zone01_Parkplatz_1eer.Active = false
  zone01_Parkplatz_1eer.Visible = false
  zone02_Ausgang.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB7(action)
  zone01_Parkplatz_voll.Active = false
  zone01_Parkplatz_voll.Visible = false
  zone02_Ausgang.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB8(action)
  var_02_Aus = 2
  var_02_S3 = 1
  zone02_Ausgang.Active = false
  zone02_Stand_1.Active = true
  zone02_Stand_2.Active = true
  zone02_Stand_3.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB9(action)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Media = WWB_change_media(zmediaLM_Coins)
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB11(action)
  zone02_Stand_1.Active = false
  zone02_Stand_1.Visible = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB13(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Do Schaug her. San die ned schee. Gib m'r sechzig Euro ond dann sama quitt.@@Hier, schau her, sind die nicht super. F\195\188r 60 Euro kannst du sie haben.@@Look at this beatyful \"Black Giga Coin Edition\". Give me 60 Euro and the coins belong to you.", {PocketPC = 1})),
      Media = zmediahaendler_2,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB14
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Von so 'ner \"Bl\195\164ck Giga Coin Edischn\" hasch du no nie g'h\195\182rt. Des isch garantiert a F\195\164lschung.@@Von einer \"Black Edition\" der Giga-Coins hast du noch nie etwas geh\195\182rt. Wenn das mal kein Betrug ist. Du willst eigentlich nur die \"Black Edition\" vom Ulmer Geocoinfest.@@You never heard about a \"Black Giga Coin Edition\" - this must be a fake.", {PocketPC = 1})),
      Media = zmediagiga_coin,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB16
    })
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB14(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Was wilsch - 60 Euro. Die sind ab'r sch\195\164big - wenn des it a F\195\164lschung isch. Da kauf i lieba nix.@@Was, der will sechzig Euro f\195\188r so eine schlechte Qualit\195\164t. Das sind bestimmt F\195\164lschungen. Da sparst du dir das Geld und suchst lieber weiter nach der \"Black Edition\" von diesem Geocoinfest.@@60 Euro !! The coins really don't look very beautyful - may be they are a fake. So you don't buy the coins.", {PocketPC = 1})),
    Media = zmediagiga_coin,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB15
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB15(action)
  zone02_Stand_2.Active = false
  zone02_Stand_2.Visible = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB16(action)
  zone02_Stand_2.Active = false
  zone02_Stand_2.Visible = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB18(action)
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Visible = true
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.SchwtzaAnsprechenTalkto.Enabled = false
  zcharacterBsitzaSchwbischeMnzlaHndlerSchwbischeMnzlaOwnerSwabianCoins.Commands.NachdeMnzlafragaNachCoinfragenAskforcoins.Enabled = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB20(action)
  zone03_Donauufer_Bastion.Active = false
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, dann gang i halt Richtung Eisabahbruck nach links.@@Ok, du hast dich f\195\188r \"Links\" entschieden. Folge nun dem Uferweg nach links Richtung Eisenbahnbr\195\188cke.@@You turn left towards the railwaybridge.", {PocketPC = 1})),
      Media = zmedia04_Eisenbahnbrcke,
      Buttons = {
        WWB_localize("nach links@@Weg links folgen@@Go left")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB21
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ha, dann gang i halt na rechts. 'etzt gosch au rechts (da geits a verborgana Zone !)@@Ok, du hast dich f\195\188r \"Rechts\" entschieden. Folge nun dem Uferweg nach rechts Richtung Autobahnbr\195\188cke.<BR>\n<BR>\n(Achtung: aktive aber verborgene Zone)@@You trun right towards the highwaybridge (Attention: hidden zone !)", {PocketPC = 1})),
      Media = zmediafragezeichen,
      Buttons = {
        WWB_localize("Nach rechts@@Weg rechts folgen@@Go right")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB22
    })
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB21(action)
  zone04_Eisenbahnbrcke.Active = true
  zone04_Eisenbahnbrcke.Visible = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB22(action)
  ztimer03_Bastion:Start()
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB23(action)
  zone03_Donauufer_Bastion.Active = false
  zone03_Donauufer_Bastion.Visible = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB24(action)
  zone04_Eisenbahnbrcke.Active = false
  zone04_Eisenbahnbrcke.Visible = false
  Wherigo.GetInput(zinput04_Eingabe)
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB27(action)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Media = WWB_change_media(zmediaULM_Coins)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Description = WWB_localize(WWB_multiplatform_string("D' \"Bl\195\164ck Edischn\" von dene Iwent-Coins.@@Die \"Black Edition\" der 3 Event-Coins des Geocoin Festivals in Ulm. Eigentlich gibt es die nur f\195\188r die Helfer.@@The \"Black GCF Coin Edition\"."))
  zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Enabled = true
  Wherigo.Dialog({
    {
      Text = WWB_localize(WWB_multiplatform_string("He, haldet d'r Dieb, d'r \"Schpatz\" hat g'rad mei \"schwarze U-M\195\188nz\" g'klaut.@@Du schreist laut: \"Haltet den Dieb\" und hechtest von hinten auf den \"Ulmer Spatz\". <BR>\n<BR>\n\"Diese Maskottchen hat das \"schwarze U\" meiner \"Black Edition\" gestohlen.\"@@Catch the thieve ! This \"Sparrow\" just have stolen my \"Black-U-Coin\" that I've bought minutes bevore.")),
      Media = zmediaSpieler
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("D'r \"Ulma Schpatz\" guckt ganz bled aus d'r W\195\164sch ond hot gar koi Ahnung it, um was es hiar eigantlich goat. Er isch doch blos 'n Schauschpiela , der g'rad beim Iwent an Auftritt g'habt hat@@Der \"Ulmer Spatz\" wei\195\159 gar nicht um was es geht und erkl\195\164rt, dass er zu einer Truppe von Darstellern der \"Historischen Ulmer Figuren\" geh\195\182rt, die gerade einen Auftritt in der Event-Halle hatten.@@The \"Ulm Sparrow\" is very surprised and tells you he is an actor, who have had an performance at he \"Event-Hall\". And he never heard about geocoins.")),
      Media = zmediaulmer_spatz
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("\"Ha, des ka ja a jed'r saga.\"<BR>\n<BR>\nAlso wilsch ihm die M\195\188nzla zoiga, ab'r dia san 'etzt elle fut.@@\"Ha, das kann ja ein jeder sagen\". <BR>\n<BR>\nDu willst zum Beweis den umstehenden Cachern die restlichen beiden Coins zeigen - doch, oh Schreck, diese sind nun auch weg.@@\"Everybody can affirm this\".<BR>\n<BR>\nSo you will show the surrounding cachers the two coins of the \"Black Coin Edition\" but there are no coins any more.")),
      Media = zmediafragezeichen
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, 'etzt isch da doch glatt a Loch in d'r Jackatasch ond bei g'nauem Sucha findescht au elle drui M\195\188nzla wieda.@@Bei genauer Begutachtung deiner Brusttasche, stellst du pl\195\182tzlich fest, dass diese ein Loch hat. Und bei noch genauerer Inspektion findest du alle 3 Coins zwischen Innen- und Au\195\159enfutter deiner Cacher-Jacke.@@While searching for the coins you detect a \"whole\" inside the jacket - and here they are, all three coins of the \"Black Coin Edition\".")),
      Media = zmediaULM_Coins
    },
    {
      Text = WWB_localize(WWB_multiplatform_string("Ha, 'etzt bisch ab'r baff. Du sagsch no zo elle Entscholdigong ond wilsch nach d'r ganza Uffregung dann no an \"K\195\164sch\" sucha.<BR>\n<BR>\nSo, wo isch au 'etzt des \"Tsch-Pie-Ess\" ?@@Puh, alles noch einmal gut gegangen. Du entschuldigst dich bei dem \"Ulmer Spatz\" und den anderen Cachern und willst nach all der Aufregung noch einen Tradi in der N\195\164he machen. <BR>\n<BR>\nDazu ben\195\182tigst du aber dein GPS.@@Ok, you're lucky, that nobody have stolen your coins. The best would be, now to look for a cache nearby and forget all.<BR>\n<BR>\nNow you need your GPS to find a nearby cache.")),
      Media = zmediaSpieler
    }
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB28(action)
  zitemASchwarzlichtUVLampeUVTorch.Commands.AufhebaAufhebenPickup.Enabled = true
  zitemASchwarzlichtUVLampeUVTorch.Visible = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB29(action)
  zone07_Stadtmauer.Active = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB31(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Guat g'macht - 'etzt brauchsch blos no des Logbuach (Hint). D'r \"Fainal-Code\" ond d'r \"Hint\" findesch 'etzt im Inwentar.@@Herzlichen Gl\195\188ckwunsch - finde nun noch die Dose mit dem Logbuch (Hint). Den \"Completion-Code\" und den \"Hint\" findest du nun auch in deinem Inventar.@@Congratulations, just look for the &nbsp;the Logbook (Hint). You'll find the \"Completion-Code\" and the \"Hint\" in your inventory.", {PocketPC = 1})),
      Media = zmediacode,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB32
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize([[
HINT:<BR>
<BR>
Zwischa de Schtaemm von d'r Kaschtanie, rechts neba d'r dicka Wurz'l.@@HINT:<BR>
<BR>
Zwischen den Staemmen der Drei-Stamm-Kastanie, rechts neben der grossen Wurzel.@@HINT:<BR>
<BR>
Between the three-pole-tree, next to the big root.]]),
      Media = zmedia08_Tradi,
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB33
    })
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB32(action)
  cart17_Black_Coin_Edition.Complete = true
  zitemDrFainalCodeCompletionCodeCompletionCode.Visible = true
  zitemDHilfaHintHint.Visible = true
  zitemSKscherSckleCacherRucksackCacherbag:MoveTo(nil)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition:MoveTo(nil)
  zitemTschiePieEssGPSGPS:MoveTo(nil)
  zitemGeldsckleGeldbeutelPurse:MoveTo(nil)
  cart17_Black_Coin_Edition:RequestSync()
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB33(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Guat g'macht - 'etzt brauchsch blos no des Logbuach (Hint). D'r \"Fainal-Code\" ond d'r \"Hint\" findesch 'etzt im Inwentar.@@Herzlichen Gl\195\188ckwunsch - finde nun noch die Dose mit dem Logbuch (Hint). Den \"Completion-Code\" und den \"Hint\" findest du nun auch in deinem Inventar.@@Congratulations, just look for the &nbsp;the Logbook (Hint). You'll find the \"Completion-Code\" and the \"Hint\" in your inventory.", {PocketPC = 1})),
    Media = zmediacode,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB32
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB34(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Ge, siagst ned, dass i grad z'dua hann. Woas wuilst denn ?@@Siehst du nicht, dass ich gerade besch\195\164ftigt bin.@@Sorry, I'm busy.", {PocketPC = 1})),
    Media = zmediahaendler_2,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB35
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB35(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Hasch du a Ahnung, wo i di \"Bl\195\164ck Edischn\" von dene Iwent-M\195\188nzla her kriaga ka ?@@Wei\195\159t du vielleicht wo ich die \"Black Edition\" der Event-Coins bekommen kann ?@@Can you tell me, where I can get the \"Black Coin Edition\" of the Event-Coins ?", {PocketPC = 1})),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB36
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB36(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Woas mogst ? A \"Bl\195\164g Edischn\" von d'r Iwent-Coin ! Do schaug hera, hia san no a paar Helfa-Coins vom Giga - die san a schwoarz.@@Was ? Du willst die \"Black Edition\" der Event-Coin ! Ich habe hier die Helfer-Edition vom Giga in M\195\188nchen - die ist auch schwarz.@@Sorry, I only have a \"Black Coin Edition\" of the first Giga-Event in Munich.", {PocketPC = 1})),
    Media = zmediahaendler_2,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB37
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB37(action)
  Wherigo.MessageBox({
    Text = WWB_localize("Du Bachel, i suach d' \"Helfa Edischn\" von dem Iwent ond nix vom Giga.@@Nein, ich such die \"Helfer Edition\" der Coins von dem Event hier.@@No, I'm looking for the \"Staff-Edition\"."),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB38
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB38(action)
  Wherigo.MessageBox({
    Text = WWB_localize("Hob i ned. Wenn d' die ned moagst, dann schlaich di.@@Nein, die hab' ich nicht. Entweder du nimmst die hier oder eben keine.@@ Sorry, I only have this \"Black Giga Coin Edition\". Just take it or leave it."),
    Media = zmediahaendler_2,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB39
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB39(action)
  if var_02_S1 == 1 and var_02_S3 == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ze fix ab'r au - koina hat dui \"Black Edischn\". 'Etzt gosch halt wieda zom Ausgang.@@So ein Mist !!! Keiner der H\195\164ndler hatte die \"Black Edition\" der Event-Coins. Mit gesenktem Haupt trottest du Richtung Ausgang.@@F***, no dealer had this \"Black Coin Edition\". Just go to the exit.", {PocketPC = 1})),
      Media = zmedia02_Eingang,
      Buttons = {
        WWB_localize("Rausganga@@Zum Ausgang@@To the exit")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB40
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize("Pech g'habt. Gang oifach zu 'nem andra Lada.@@Das war wohl nichts. Versuche es einfach an einem anderen Stand.@@Try another shop."),
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      }
    })
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB40(action)
  zone02_Ausgang.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB42(action)
  Wherigo.MessageBox({
    Text = WWB_localize("Sorry, I'm from the Nederland. I really don't know what you're looking for."),
    Media = zmediahaendler_1,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB43
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB43(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Ha, der hat ja \195\188b'rhaupt koi Ahnung. Was hat 'etzt da d'r Bernhard g'seit ?@@Ok, der scheint wohl keine Ahnung zu haben. Da hat sich der Bernhard wohl get\195\164uscht.@@Ok, this dealer don't know anything about a \"Black Coin Edition\".", {PocketPC = 1})),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB44
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB44(action)
  if var_02_S2 == 1 and var_02_S3 == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ze fix ab'r au - koina hat dui \"Black Edischn\". 'Etzt gosch halt wieda zom Ausgang.@@So ein Mist !!! Keiner der H\195\164ndler hatte die \"Black Edition\" der Event-Coins. Mit gesenktem Haupt trottest du Richtung Ausgang.@@F***, no dealer had this \"Black Coin Edition\". Just go to the exit.", {PocketPC = 1})),
      Media = zmedia02_Eingang,
      Buttons = {
        WWB_localize("Rausganga@@Zum Ausgang@@To the exit")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB40
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize("Pech g'habt. Gang oifach zu 'nem andra Lada.@@Das war wohl nichts. Versuche es einfach an einem anderen Stand.@@Try another shop."),
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB41
    })
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB45(action)
  Wherigo.MessageBox({
    Text = WWB_localize("Ha die Iwent-Coins hann i in silbr, gold ond broose. Ond dann hann i au no die \"Pink Edischn\" - die geits nur bei oos !@@Die Event-Coins habe ich in silber, gold und bronze. Und dann habe ich noch eine \"Pink Edition\" - die gibt es nur bei uns !@@I only have a \"Gold-, Silver or Bronce-Edition\" and this special \"Pink-Edition\"."),
    Media = zmediahaendlerin_3,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB46
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB46(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Kapiersch des denn nit, i suach die \"Bl\195\164ck Edischn\".@@Nein, ich suche die \"Black Edition\"@@No, I'm looking for the \"Black Coin Edition\".", {PocketPC = 1})),
    Media = zmediaSpieler,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB47
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB47(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Ha die geits nur fir d' Helfa. So ebbes hann i it.@@Die \"Black Edition\" gibt es nur f\195\188r Helfer. Die habe ich nicht.@@The \"Black Coin Edition\" is only for the staff. You can't buy this special edition.", {PocketPC = 1})),
    Media = zmediahaendlerin_3,
    Buttons = {
      WWB_localize("Weida@@Weiter@@Next")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB48
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB48(action)
  if var_02_S1 == 1 and var_02_S2 == 1 then
    Wherigo.MessageBox({
      Text = WWB_localize(WWB_multiplatform_string("Ze fix ab'r au - koina hat dui \"Black Edischn\". 'Etzt gosch halt wieda zom Ausgang.@@So ein Mist !!! Keiner der H\195\164ndler hatte die \"Black Edition\" der Event-Coins. Mit gesenktem Haupt trottest du Richtung Ausgang.@@F***, no dealer had this \"Black Coin Edition\". Just go to the exit.", {PocketPC = 1})),
      Media = zmedia02_Eingang,
      Buttons = {
        WWB_localize("Rausganga@@Zum Ausgang@@To the exit")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB40
    })
  else
    Wherigo.MessageBox({
      Text = WWB_localize("Pech g'habt. Gang oifach zu 'nem andra Lada.@@Das war wohl nichts. Versuche es einfach an einem anderen Stand.@@Try another shop."),
      Buttons = {
        WWB_localize("Weida@@Weiter@@Next")
      },
      Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB41
    })
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB49(action)
  zcharacterDrUlmaSchpatzUlmerSpatzTheUlmSparrow.Commands.MachaFotoMaskottchenfotografierenTakeapicture.Enabled = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB50(action)
  zone07_Stadtmauer.Active = false
  zone08_Tradi.Name = WWB_localize("Tradi - \"HfK+G\"")
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("'Etzt nimmsch dei \"Tschie-Pie-Ess\" ond guckscht nach 'em K\195\164sch. Da isch'r ja der Tradi \"HfK + G\".<BR>\n<BR>\nNun gasch am Ufa wieda z'ruck bis zur \"Hochschul fier Kommunakatio ond G'schtaltung\". Dann gasch weida zu de Koordinata.@@So, wo war nun der Tradi ? Du nimmst dein GPS in die Hand und suchst darin nach nahen Caches - Ah ja, da ist er ja:<BR>\n<BR>\n<BR>\nTradi: \"HfK+G\"<BR>\nN 48\194\176....<BR>\nE 009\194\176...<BR>\n<BR>\n<BR>\nLauf auf dem Uferweg wieder zur\195\188ck Richtung Event-Halle bis zur \"Hochschule f\195\188r Kommunikation und Gestaltung\" und von dort aus weiter bis zum \"Tradi\".@@You take your GPS and you search for nearby caches. Ah, there's the Traditional \"HfK + G\". <BR>\n<BR>\nNow go back to the \"College of arts\" and then follow the coordinates.", {PocketPC = 1})),
    Media = zmediagps,
    Buttons = {
      WWB_localize(WWB_multiplatform_string("Zom K\195\164sch@@Auf zum Tradi@@To the cache", {PocketPC = 1}))
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB51
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB51(action)
  zone07_Stadtmauer.Active = false
  zone08_Tradi.Active = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB53(action)
  if action == "Button1" then
    Wherigo.Command("SaveClose")
  else
    cart17_Black_Coin_Edition:RequestSync()
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB54(action)
  zone05_Mitte_Brcke.Active = false
  zone06_Donauufer_Mitte.Name = WWB_localize("Ulma Ufa@@Ulmer Donauufer@@Ulm shorside")
  zone06_Donauufer_Mitte.Active = true
  zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Enabled = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB55(action)
  zone01_Parkplatz.Active = false
  zone01_Parkplatz_voll.Active = true
  ztimer01_Parkplatz:Start()
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB57(action)
  zitemDBlckEdischnDieEventCoinBlackEditionTheBlackCoinEdition.Visible = true
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB60(action)
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("Du nimmsch dei \"Tschie-Pie-Ess\", machsch dei S\195\164ckle wieda zua ond gosch z'ruck z'r Schdadtmaua.@@Du nimmst dein GPS aus dem Rucksack, machst ihn anschlie\195\159end zu und gehst wieder zur\195\188ck zur Stadtmauer.@@You take your GPS, close the bag and go back to the \"Town Wall\".", {PocketPC = 1})),
    Media = zmediagps,
    Buttons = {
      WWB_localize("Z'r Schdadtmaua@@Zur Stadtmauer@@To the \"Town Wall\"")
    },
    Callback = cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB61
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB61(action)
  zone07_Fischerpltzle.Active = false
  zone07_Fischerpltzle.Visible = false
  zone07_Ufertribne.Active = false
  zone07_Stadtmauer.Active = true
  zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Enabled = false
  zitemDrFotoaparatDigiCamTheDigiCam.Visible = false
  zitemSHiraLichtStirnLampeTorch.Visible = false
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Visible = false
  zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Enabled = false
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB62(action)
  zone07_Fischerpltzle.Active = false
  zone07_Fischerpltzle.Visible = false
  zone07_Stadtmauer.Active = false
  zone07_Ufertribne.Active = false
  zone08_Tradi.Active = true
  zitemSKscherSckleCacherRucksackCacherbag.Commands.ZumachaSchlieenClose.Enabled = false
  zitemDrFotoaparatDigiCamTheDigiCam.Visible = false
  zitemSHiraLichtStirnLampeTorch.Visible = false
  zitemAusziehschpieglTeleskopspiegelTelescpoemirror.Visible = false
  zitemASchwarzlichtUVLampeUVTorch.Visible = false
  zitemTschiePieEssGPSGPS.Commands.EischaltaBenutzenUse.Enabled = false
  Wherigo.MessageBox({
    Text = WWB_localize(WWB_multiplatform_string("'Etzt nimmsch dei \"Tschie-Pie-Ess\" ond guckscht nach 'em K\195\164sch. Da isch'r ja der Tradi \"HfK + G\".<BR>\n<BR>\nNun gasch am Ufa wieda z'ruck bis zur \"Hochschul fier Kommunakatio ond G'schtaltung\". Dann gasch weida zu de Koordinata.@@So, wo war nun der Tradi ? Du nimmst dein GPS in die Hand und suchst darin nach nahen Caches - Ah ja, da ist er ja:<BR>\n<BR>\n<BR>\nTradi: \"HfK+G\"<BR>\nN 48\194\176....<BR>\nE 009\194\176...<BR>\n<BR>\n<BR>\nLauf auf dem Uferweg wieder zur\195\188ck Richtung Event-Halle bis zur \"Hochschule f\195\188r Kommunikation und Gestaltung\" und von dort aus weiter bis zum \"Tradi\".@@You take your GPS and you search for nearby caches. Ah, there's the Traditional \"HfK + G\". <BR>\n<BR>\nNow go back to the \"College of arts\" and then follow the coordinates.", {PocketPC = 1})),
    Media = zmediagps,
    Buttons = {
      WWB_localize(WWB_multiplatform_string("Zom K\195\164sch@@Auf zum Tradi@@To the cache", {PocketPC = 1}))
    }
  })
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB64(action)
  if action == "Button1" then
    Wherigo.GetInput(zinput00_Code)
  else
    Wherigo.Command("SaveClose")
  end
end
function cart17_Black_Coin_Edition.MsgBoxCBFuncs.MsgBoxCB66(action)
  Wherigo.GetInput(zinput04_Eingabe)
end
return cart17_Black_Coin_Edition
