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
      WWB_strings_unicode = true
    elseif deviceId == "Desktop" then
      WWB_device = "EmulatorGSP"
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
function WWB_noemul(cart, message)
  local emulator = false
  if string.byte(Env.DeviceID, 1) + 1 == 69 and string.byte(Env.DeviceID, 4) - 2 == 105 and string.byte(Env.DeviceID, 7) + 4 == 116 then
    emulator = true
  end
  if string.byte(Env.DeviceID, 1) - 3 == 116 and string.byte(Env.DeviceID, 3) + 5 == 103 and string.byte(Env.DeviceID, 6) + 2 == 105 then
    emulator = true
  end
  if emulator then
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
cartMighlaTeil1v3 = Wherigo.ZCartridge()
WWB_current_cartridge = cartMighlaTeil1v3
cartMighlaTeil1v3.MsgBoxCBFuncs = {}
zmediaAufgabe = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaAufgabe.Id = "70ccac2a3f3f0d31aa4e9c00709e2ad0"
zmediaAufgabe.Name = "Aufgabe"
zmediaAufgabe.AltText = ""
zmediaAufgabe.Resources = {
  {
    Type = "jpg",
    Filename = "Aufgabe.jpg",
    Directives = {}
  }
}
zmediaAufgabe_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaAufgabe_32.Id = "9b8dacea0abe921016ba96f47dee6a2b"
zmediaAufgabe_32.Name = "Aufgabe_32"
zmediaAufgabe_32.AltText = ""
zmediaAufgabe_32.Resources = {
  {
    Type = "jpg",
    Filename = "Aufgabe32.jpg",
    Directives = {}
  }
}
zmediaBadebucht_1 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBadebucht_1.Id = "f84f1346ce16206f5c1334c274a6eaa7"
zmediaBadebucht_1.Name = "Badebucht_1"
zmediaBadebucht_1.AltText = ""
zmediaBadebucht_1.Resources = {
  {
    Type = "jpg",
    Filename = "Badebucht_1.jpg",
    Directives = {}
  }
}
zmediaBadebucht_1_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBadebucht_1_32.Id = "f48b000a75f582683b69e71997d246b9"
zmediaBadebucht_1_32.Name = "Badebucht_1_32"
zmediaBadebucht_1_32.AltText = ""
zmediaBadebucht_1_32.Resources = {
  {
    Type = "jpg",
    Filename = "Badebucht_1_32.jpg",
    Directives = {}
  }
}
zmediaBadebucht_2 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBadebucht_2.Id = "b027b503d730e995ca5b3e948032fd1a"
zmediaBadebucht_2.Name = "Badebucht_2"
zmediaBadebucht_2.AltText = ""
zmediaBadebucht_2.Resources = {
  {
    Type = "jpg",
    Filename = "Badebucht_2.jpg",
    Directives = {}
  }
}
zmediaBadebucht_2_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBadebucht_2_32.Id = "1a4577509f8103f8ba90ee6a56e999ec"
zmediaBadebucht_2_32.Name = "Badebucht_2_32"
zmediaBadebucht_2_32.AltText = ""
zmediaBadebucht_2_32.Resources = {
  {
    Type = "jpg",
    Filename = "Badebucht_2_32.jpg",
    Directives = {}
  }
}
zmediaBedrfnisanstalt = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBedrfnisanstalt.Id = "deaee84d5f5b23dfdbbe62487627435d"
zmediaBedrfnisanstalt.Name = WWB_multiplatform_string("Bed\195\188rfnisanstalt")
zmediaBedrfnisanstalt.AltText = ""
zmediaBedrfnisanstalt.Resources = {
  {
    Type = "jpg",
    Filename = "Beduerfnisanstallt_230.jpg",
    Directives = {}
  }
}
zmediaBedrfnisanstalt_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBedrfnisanstalt_32.Id = "69d09a71ade203f188723cfb16ba8832"
zmediaBedrfnisanstalt_32.Name = WWB_multiplatform_string("Bed\195\188rfnisanstalt_32")
zmediaBedrfnisanstalt_32.AltText = ""
zmediaBedrfnisanstalt_32.Resources = {
  {
    Type = "jpg",
    Filename = "Beduerfnisanstallt32.jpg",
    Directives = {}
  }
}
zmediaBlumenfrau = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBlumenfrau.Id = "3ecfbbe28b77cfef5d1ade0f018b8599"
zmediaBlumenfrau.Name = "Blumenfrau"
zmediaBlumenfrau.AltText = ""
zmediaBlumenfrau.Resources = {
  {
    Type = "jpg",
    Filename = "Blumenfrau.jpg",
    Directives = {}
  }
}
zmediaBlumenfrau_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBlumenfrau_32.Id = "d68b3dd2e886726d30960b450f07886d"
zmediaBlumenfrau_32.Name = "Blumenfrau_32"
zmediaBlumenfrau_32.AltText = ""
zmediaBlumenfrau_32.Resources = {
  {
    Type = "jpg",
    Filename = "Blumenfrau32.jpg",
    Directives = {}
  }
}
zmediaBlumenverkauf = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBlumenverkauf.Id = "b1afdf9f9604c8a24c8eb813c8e8209b"
zmediaBlumenverkauf.Name = "Blumenverkauf"
zmediaBlumenverkauf.AltText = ""
zmediaBlumenverkauf.Resources = {
  {
    Type = "jpg",
    Filename = "Blumenfrau_01.jpg",
    Directives = {}
  }
}
zmediaBlumenverkauf_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBlumenverkauf_32.Id = "40ba5bb1dd69154b5015ace9c3bd10bf"
zmediaBlumenverkauf_32.Name = "Blumenverkauf_32"
zmediaBlumenverkauf_32.AltText = ""
zmediaBlumenverkauf_32.Resources = {
  {
    Type = "jpg",
    Filename = "Blumenfrau32.jpg",
    Directives = {}
  }
}
zmediaBrauerei = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBrauerei.Id = "e7166151ffbc9b06dcff369c1860416a"
zmediaBrauerei.Name = "Brauerei"
zmediaBrauerei.AltText = ""
zmediaBrauerei.Resources = {
  {
    Type = "jpg",
    Filename = "Zufahrt_Brauerei.jpg",
    Directives = {}
  }
}
zmediaBrauerei_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBrauerei_32.Id = "7731dd1cd4a68d8bb5abab1a590aa265"
zmediaBrauerei_32.Name = "Brauerei_32"
zmediaBrauerei_32.AltText = ""
zmediaBrauerei_32.Resources = {
  {
    Type = "jpg",
    Filename = "Brauerei32.jpg",
    Directives = {}
  }
}
zmediaBriefDunnemals = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBriefDunnemals.Id = "d12206be3548e1d5611e91bb8a637e79"
zmediaBriefDunnemals.Name = "Brief Dunnemals"
zmediaBriefDunnemals.AltText = ""
zmediaBriefDunnemals.Resources = {
  {
    Type = "jpg",
    Filename = "Briefumschlag_zu_Dunnemals.jpg",
    Directives = {}
  }
}
zmediaBriefDunnemals_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBriefDunnemals_32.Id = "52efa666b876360c71c2afcf3bfe751d"
zmediaBriefDunnemals_32.Name = "Brief Dunnemals_32"
zmediaBriefDunnemals_32.AltText = ""
zmediaBriefDunnemals_32.Resources = {
  {
    Type = "jpg",
    Filename = "Briefumschlag_zu_Dunnemals32.jpg",
    Directives = {}
  }
}
zmediaBriefumschlagoffen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBriefumschlagoffen.Id = "2faf6e679f03ac39896e8bdac53541e3"
zmediaBriefumschlagoffen.Name = "Briefumschlag offen"
zmediaBriefumschlagoffen.AltText = ""
zmediaBriefumschlagoffen.Resources = {
  {
    Type = "jpg",
    Filename = "Briefumschlag_auf.jpg",
    Directives = {}
  }
}
zmediaBrief_Umschlagzu = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBrief_Umschlagzu.Id = "66082567e70d8c5ee517a2b2654e7e9f"
zmediaBrief_Umschlagzu.Name = "Brief_Umschlag zu"
zmediaBrief_Umschlagzu.AltText = ""
zmediaBrief_Umschlagzu.Resources = {
  {
    Type = "jpg",
    Filename = "Briefumschlag_zu.jpg",
    Directives = {}
  }
}
zmediaBrief_Umschlagzu_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaBrief_Umschlagzu_32.Id = "36769d1123616b63d961ab1f7d6e52eb"
zmediaBrief_Umschlagzu_32.Name = "Brief_Umschlag zu_32"
zmediaBrief_Umschlagzu_32.AltText = ""
zmediaBrief_Umschlagzu_32.Resources = {
  {
    Type = "jpg",
    Filename = "Briefumschlag_zu32.jpg",
    Directives = {}
  }
}
zmediaCountdown = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaCountdown.Id = "4716552ac756f6e7f993d394af78437e"
zmediaCountdown.Name = "Countdown"
zmediaCountdown.AltText = ""
zmediaCountdown.Resources = {
  {
    Type = "jpg",
    Filename = "15_sek.jpg",
    Directives = {}
  }
}
zmediaDiskette = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaDiskette.Id = "8f61d9f7480dd353b16f0d2346c37783"
zmediaDiskette.Name = "Diskette"
zmediaDiskette.AltText = ""
zmediaDiskette.Resources = {
  {
    Type = "png",
    Filename = "Speichern.png",
    Directives = {}
  }
}
zmediaDiskette_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaDiskette_32.Id = "a71832bb7f4f84253d0ad9680cd49deb"
zmediaDiskette_32.Name = "Diskette_32"
zmediaDiskette_32.AltText = ""
zmediaDiskette_32.Resources = {
  {
    Type = "jpg",
    Filename = "Diskette32.jpg",
    Directives = {}
  }
}
zmediaEndeT1 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaEndeT1.Id = "57ab4e1267890517d38ff0a994db03ca"
zmediaEndeT1.Name = "Ende T1"
zmediaEndeT1.AltText = ""
zmediaEndeT1.Resources = {
  {
    Type = "jpg",
    Filename = "Logo_Ende_T1.jpg",
    Directives = {}
  }
}
zmediaFalscheEingabe = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFalscheEingabe.Id = "85cb05fdc7ceeef24ab3edc843651f18"
zmediaFalscheEingabe.Name = "Falsche Eingabe"
zmediaFalscheEingabe.AltText = ""
zmediaFalscheEingabe.Resources = {
  {
    Type = "jpg",
    Filename = "falsch_02.jpg",
    Directives = {}
  }
}
zmediaFotobox = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFotobox.Id = "f75e0b8774f76f49fd2319895d189dc4"
zmediaFotobox.Name = "Fotobox"
zmediaFotobox.AltText = ""
zmediaFotobox.Resources = {
  {
    Type = "jpg",
    Filename = "Mimosa_Fotoplatten.jpg",
    Directives = {}
  }
}
zmediaFotobox_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFotobox_32.Id = "15a4bafa99010e259a586c6199e6787d"
zmediaFotobox_32.Name = "Fotobox_32"
zmediaFotobox_32.AltText = ""
zmediaFotobox_32.Resources = {
  {
    Type = "jpg",
    Filename = "Mimosa_Fotoplatten32.jpg",
    Directives = {}
  }
}
zmediaFoto_01 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_01.Id = "6b402b6dbe2b9b601f0cfcff9d31f5c0"
zmediaFoto_01.Name = "Foto_01"
zmediaFoto_01.AltText = ""
zmediaFoto_01.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_1.jpg",
    Directives = {}
  }
}
zmediaFoto_02 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_02.Id = "138407cbdf947aa5dbdd5345fd72a574"
zmediaFoto_02.Name = "Foto_02"
zmediaFoto_02.AltText = ""
zmediaFoto_02.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_2.jpg",
    Directives = {}
  }
}
zmediaFoto_03 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_03.Id = "8a2d441d851bc5d48506db3eeca01ffd"
zmediaFoto_03.Name = "Foto_03"
zmediaFoto_03.AltText = ""
zmediaFoto_03.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_3.jpg",
    Directives = {}
  }
}
zmediaFoto_04 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_04.Id = "d70c0f34a461ee146c2b643e8e6c8a58"
zmediaFoto_04.Name = "Foto_04"
zmediaFoto_04.AltText = ""
zmediaFoto_04.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_4.jpg",
    Directives = {}
  }
}
zmediaFoto_05 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_05.Id = "51a847916d1e0a8565ff98e1601136d3"
zmediaFoto_05.Name = "Foto_05"
zmediaFoto_05.AltText = ""
zmediaFoto_05.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_5.jpg",
    Directives = {}
  }
}
zmediaFoto_06 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_06.Id = "df961625fb5efc3357b801b717c5cbc0"
zmediaFoto_06.Name = "Foto_06"
zmediaFoto_06.AltText = ""
zmediaFoto_06.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_6.jpg",
    Directives = {}
  }
}
zmediaFoto_07 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_07.Id = "c120fa25098a07553b5dd8c76087abd7"
zmediaFoto_07.Name = "Foto_07"
zmediaFoto_07.AltText = ""
zmediaFoto_07.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_7.jpg",
    Directives = {}
  }
}
zmediaFoto_08 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_08.Id = "df2116340ab8def90a02e0bbf87655f4"
zmediaFoto_08.Name = "Foto_08"
zmediaFoto_08.AltText = ""
zmediaFoto_08.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_8.jpg",
    Directives = {}
  }
}
zmediaFoto_09 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_09.Id = "aee3666fdde7bdf1fcc33ce89a1afb77"
zmediaFoto_09.Name = "Foto_09"
zmediaFoto_09.AltText = ""
zmediaFoto_09.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_9.jpg",
    Directives = {}
  }
}
zmediaFoto_10 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_10.Id = "60563e9ce0dcc0f6e112b6b7d57ae09f"
zmediaFoto_10.Name = "Foto_10"
zmediaFoto_10.AltText = ""
zmediaFoto_10.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_10.jpg",
    Directives = {}
  }
}
zmediaFoto_11 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_11.Id = "87e879234508203bda333d9ce0c24c5a"
zmediaFoto_11.Name = "Foto_11"
zmediaFoto_11.AltText = ""
zmediaFoto_11.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_11.jpg",
    Directives = {}
  }
}
zmediaFoto_12 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_12.Id = "c45b166c30f1603a1225c67ebbf59a04"
zmediaFoto_12.Name = "Foto_12"
zmediaFoto_12.AltText = ""
zmediaFoto_12.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_12_Plattenkamera.jpg",
    Directives = {}
  }
}
zmediaFoto_12_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFoto_12_32.Id = "c1bc1106bce53d4af74ea7a9756987bc"
zmediaFoto_12_32.Name = "Foto_12_32"
zmediaFoto_12_32.AltText = ""
zmediaFoto_12_32.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_12_Plattenkamera_32.jpg",
    Directives = {}
  }
}
zmediaFuhrwerk = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaFuhrwerk.Id = "d13ec0ade2e637c415ced18b4deee898"
zmediaFuhrwerk.Name = "Fuhrwerk"
zmediaFuhrwerk.AltText = ""
zmediaFuhrwerk.Resources = {
  {
    Type = "jpg",
    Filename = "Pferdewagen.jpg",
    Directives = {}
  }
}
zmediaGasthausMggelschlsschen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGasthausMggelschlsschen.Id = "e78d06a3b385e1f61049347939d7f64b"
zmediaGasthausMggelschlsschen.Name = WWB_multiplatform_string("Gasthaus M\195\188ggelschl\195\182sschen")
zmediaGasthausMggelschlsschen.AltText = ""
zmediaGasthausMggelschlsschen.Resources = {
  {
    Type = "jpg",
    Filename = "Ausflugslokal_mueggelschloesschen.jpg",
    Directives = {}
  }
}
zmediaGasthausMggelschlsschen_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGasthausMggelschlsschen_32.Id = "db30f471781ebd319e3d707a3f55a75d"
zmediaGasthausMggelschlsschen_32.Name = WWB_multiplatform_string("Gasthaus M\195\188ggelschl\195\182sschen_32")
zmediaGasthausMggelschlsschen_32.AltText = ""
zmediaGasthausMggelschlsschen_32.Resources = {
  {
    Type = "jpg",
    Filename = "Ausflugslokal_mueggelschloesschen32.jpg",
    Directives = {}
  }
}
zmediaGedankenblase = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGedankenblase.Id = "e51c65468e492be64a499ad04ee5a674"
zmediaGedankenblase.Name = "Gedankenblase"
zmediaGedankenblase.AltText = ""
zmediaGedankenblase.Resources = {
  {
    Type = "jpg",
    Filename = "Gedankenblase.jpg",
    Directives = {}
  }
}
zmediaGeld = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGeld.Id = "9237972fd763c1f433959f2c6a81f3bf"
zmediaGeld.Name = "Geld"
zmediaGeld.AltText = ""
zmediaGeld.Resources = {
  {
    Type = "jpg",
    Filename = "Geld.jpg",
    Directives = {}
  }
}
zmediaGeld_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGeld_32.Id = "163a5cc31629be191aaf112e5bab5793"
zmediaGeld_32.Name = "Geld_32"
zmediaGeld_32.AltText = ""
zmediaGeld_32.Resources = {
  {
    Type = "jpg",
    Filename = "Geld32.jpg",
    Directives = {}
  }
}
zmediaGeocache = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGeocache.Id = "441bee435ae0c1cfa65d0f5a5de55b41"
zmediaGeocache.Name = "Geocache"
zmediaGeocache.AltText = ""
zmediaGeocache.Resources = {
  {
    Type = "jpg",
    Filename = "Geocache.jpg",
    Directives = {}
  }
}
zmediaGeocache_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaGeocache_32.Id = "d1db7449a228726daa48984ef4daf544"
zmediaGeocache_32.Name = "Geocache_32"
zmediaGeocache_32.AltText = ""
zmediaGeocache_32.Resources = {
  {
    Type = "jpg",
    Filename = "Geocache32.jpg",
    Directives = {}
  }
}
zmediaHatschi = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaHatschi.Id = "9457dd65cb11df7746830817c54c7379"
zmediaHatschi.Name = "Hatschi"
zmediaHatschi.AltText = ""
zmediaHatschi.Resources = {
  {
    Type = "jpg",
    Filename = "Gesundheit.jpg",
    Directives = {}
  }
}
zmediaHilfe = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaHilfe.Id = "86aa7a52d338a03539b3d64ab60b8cef"
zmediaHilfe.Name = "Hilfe"
zmediaHilfe.AltText = ""
zmediaHilfe.Resources = {
  {
    Type = "jpg",
    Filename = "Hilfe.jpg",
    Directives = {}
  }
}
zmediaHilfe_Anzahl = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaHilfe_Anzahl.Id = "babc753c93f01d74009e2ba543cfcfd2"
zmediaHilfe_Anzahl.Name = "Hilfe_Anzahl"
zmediaHilfe_Anzahl.AltText = ""
zmediaHilfe_Anzahl.Resources = {
  {
    Type = "jpg",
    Filename = "Hilfe_Info.jpg",
    Directives = {}
  }
}
zmediaHilfe_Anzahl_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaHilfe_Anzahl_32.Id = "bc6d222cef7af858ca60a496101ea40f"
zmediaHilfe_Anzahl_32.Name = "Hilfe_Anzahl_32"
zmediaHilfe_Anzahl_32.AltText = ""
zmediaHilfe_Anzahl_32.Resources = {
  {
    Type = "jpg",
    Filename = "Hilfe_Info32.jpg",
    Directives = {}
  }
}
zmediaHilfe_Code = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaHilfe_Code.Id = "977126b9135d2e5b69c0ee92f2529ecf"
zmediaHilfe_Code.Name = "Hilfe_Code"
zmediaHilfe_Code.AltText = ""
zmediaHilfe_Code.Resources = {
  {
    Type = "jpg",
    Filename = "Hilfe_Info_01.jpg",
    Directives = {}
  }
}
zmediaKallebergabe = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKallebergabe.Id = "d276418ea97ceae2fb870ff33e3b8c9a"
zmediaKallebergabe.Name = WWB_multiplatform_string("Kalle \195\188bergabe")
zmediaKallebergabe.AltText = ""
zmediaKallebergabe.Resources = {
  {
    Type = "jpg",
    Filename = "Kalle_Uebergabe.jpg",
    Directives = {}
  }
}
zmediaKallebergabe_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKallebergabe_32.Id = "7953e3886d8544221e457903621abb64"
zmediaKallebergabe_32.Name = WWB_multiplatform_string("Kalle \195\188bergabe_32")
zmediaKallebergabe_32.AltText = ""
zmediaKallebergabe_32.Resources = {
  {
    Type = "jpg",
    Filename = "Kalle_Uebergabe_32.jpg",
    Directives = {}
  }
}
zmediaKapitn = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKapitn.Id = "d8ab1b49cd5d05a7e3f69b2f0244c167"
zmediaKapitn.Name = WWB_multiplatform_string("Kapit\195\164n")
zmediaKapitn.AltText = ""
zmediaKapitn.Resources = {
  {
    Type = "jpg",
    Filename = "Kapitaen.jpg",
    Directives = {}
  }
}
zmediaKapitn_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKapitn_32.Id = "345f70789c51aab4121cc3fe8887304e"
zmediaKapitn_32.Name = WWB_multiplatform_string("Kapit\195\164n_32")
zmediaKapitn_32.AltText = ""
zmediaKapitn_32.Resources = {
  {
    Type = "jpg",
    Filename = "Kapitaen32.jpg",
    Directives = {}
  }
}
zmediaKellnerin = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKellnerin.Id = "00d44ea613da8fa26bab71ddc7129e29"
zmediaKellnerin.Name = "Kellnerin"
zmediaKellnerin.AltText = ""
zmediaKellnerin.Resources = {
  {
    Type = "jpg",
    Filename = "Kellnerin.jpg",
    Directives = {}
  }
}
zmediaKellnerin_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKellnerin_32.Id = "be276dc16ffc80650758e70e59410416"
zmediaKellnerin_32.Name = "Kellnerin_32"
zmediaKellnerin_32.AltText = ""
zmediaKellnerin_32.Resources = {
  {
    Type = "jpg",
    Filename = "Kellnerin32.jpg",
    Directives = {}
  }
}
zmediaKoffer = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKoffer.Id = "3948db9b22eb89e00d3995e802b4d4ee"
zmediaKoffer.Name = "Koffer"
zmediaKoffer.AltText = ""
zmediaKoffer.Resources = {
  {
    Type = "jpg",
    Filename = "Koffer_zu.jpg",
    Directives = {}
  }
}
zmediaKofferauf = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKofferauf.Id = "dfe95cde0ae6107a7552c255e103620d"
zmediaKofferauf.Name = "Koffer auf"
zmediaKofferauf.AltText = ""
zmediaKofferauf.Resources = {
  {
    Type = "jpg",
    Filename = "koffer_offen.jpg",
    Directives = {}
  }
}
zmediaKofferschlsseluStadtkasse = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKofferschlsseluStadtkasse.Id = "ade02219ec313e81788677f3644f17f7"
zmediaKofferschlsseluStadtkasse.Name = WWB_multiplatform_string("Kofferschl\195\188ssel u Stadtkasse")
zmediaKofferschlsseluStadtkasse.AltText = ""
zmediaKofferschlsseluStadtkasse.Resources = {
  {
    Type = "jpg",
    Filename = "Reiseunterlage_Kofferschluessel_Stadtkasse.jpg",
    Directives = {}
  }
}
zmediaKofferschlsseluStadtkasse_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKofferschlsseluStadtkasse_32.Id = "9aba256813a368bc2517a672f59b67c6"
zmediaKofferschlsseluStadtkasse_32.Name = WWB_multiplatform_string("Kofferschl\195\188ssel u Stadtkasse_32")
zmediaKofferschlsseluStadtkasse_32.AltText = ""
zmediaKofferschlsseluStadtkasse_32.Resources = {
  {
    Type = "jpg",
    Filename = "Reiseunterlage_Kofferschluessel_Stadtkasse32.jpg",
    Directives = {}
  }
}
zmediaKofferschlssel_Code = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKofferschlssel_Code.Id = "d62056752d00450f1120c50424177a80"
zmediaKofferschlssel_Code.Name = WWB_multiplatform_string("Kofferschl\195\188ssel_Code")
zmediaKofferschlssel_Code.AltText = ""
zmediaKofferschlssel_Code.Resources = {
  {
    Type = "jpg",
    Filename = "Kofferschluesse_Code.jpg",
    Directives = {}
  }
}
zmediaKofferschlssel_Code_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKofferschlssel_Code_32.Id = "2d3abc371f5b19290726672a3bc8a892"
zmediaKofferschlssel_Code_32.Name = WWB_multiplatform_string("Kofferschl\195\188ssel_Code_32")
zmediaKofferschlssel_Code_32.AltText = ""
zmediaKofferschlssel_Code_32.Resources = {
  {
    Type = "jpg",
    Filename = "Kofferschluesse_Code32.jpg",
    Directives = {}
  }
}
zmediaKoffer_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaKoffer_32.Id = "a5df586967da98a701c8a47e3206cb7e"
zmediaKoffer_32.Name = "Koffer_32"
zmediaKoffer_32.AltText = ""
zmediaKoffer_32.Resources = {
  {
    Type = "jpg",
    Filename = "Koffer_zu32.jpg",
    Directives = {}
  }
}
zmediaLampean = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLampean.Id = "658c949c5382fa41ee08c2d113fe4887"
zmediaLampean.Name = "Lampe an"
zmediaLampean.AltText = ""
zmediaLampean.Resources = {
  {
    Type = "jpg",
    Filename = "lampe_uv.jpg",
    Directives = {}
  }
}
zmediaLampean_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLampean_32.Id = "18fa20c4604e20df1120af503a438c2e"
zmediaLampean_32.Name = "Lampe an_32"
zmediaLampean_32.AltText = ""
zmediaLampean_32.Resources = {
  {
    Type = "jpg",
    Filename = "lampe_uv32.jpg",
    Directives = {}
  }
}
zmediaLampeaus = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLampeaus.Id = "305da18610dfa1cf001a7e85d179bec2"
zmediaLampeaus.Name = "Lampe aus"
zmediaLampeaus.AltText = ""
zmediaLampeaus.Resources = {
  {
    Type = "jpg",
    Filename = "lampe_aus.jpg",
    Directives = {}
  }
}
zmediaLampeaus_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLampeaus_32.Id = "401ac1524ee1387e36f855496de3c7e4"
zmediaLampeaus_32.Name = "Lampe aus_32"
zmediaLampeaus_32.AltText = ""
zmediaLampeaus_32.Resources = {
  {
    Type = "jpg",
    Filename = "lampe_aus32.jpg",
    Directives = {}
  }
}
zmediaLufer = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLufer.Id = "83b45d7dfa02c00405bba1b0e119663a"
zmediaLufer.Name = WWB_multiplatform_string("L\195\164ufer")
zmediaLufer.AltText = ""
zmediaLufer.Resources = {
  {
    Type = "jpg",
    Filename = "Laeufer.jpg",
    Directives = {}
  }
}
zmediaLufer_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLufer_32.Id = "62869f66b9f5f98331cd987d4be08668"
zmediaLufer_32.Name = WWB_multiplatform_string("L\195\164ufer_32")
zmediaLufer_32.AltText = ""
zmediaLufer_32.Resources = {
  {
    Type = "jpg",
    Filename = "Laeufer32.jpg",
    Directives = {}
  }
}
zmediaLogo = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLogo.Id = "ba3088227026de05e23ae9d0f4f44c02"
zmediaLogo.Name = "Logo"
zmediaLogo.AltText = ""
zmediaLogo.Resources = {
  {
    Type = "jpg",
    Filename = "Logo_01.jpg",
    Directives = {}
  }
}
zmediaLogo_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLogo_32.Id = "214401066edf8a738f8b034ffa76cbd5"
zmediaLogo_32.Name = "Logo_32"
zmediaLogo_32.AltText = ""
zmediaLogo_32.Resources = {
  {
    Type = "jpg",
    Filename = "Logo32.jpg",
    Directives = {}
  }
}
zmediaLsung = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLsung.Id = "466a881ba9427241358f838d52e9eac8"
zmediaLsung.Name = WWB_multiplatform_string("L\195\182sung ")
zmediaLsung.AltText = ""
zmediaLsung.Resources = {
  {
    Type = "jpg",
    Filename = "Loesung.jpg",
    Directives = {}
  }
}
zmediaLsungFrage = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaLsungFrage.Id = "3269c7aff086757305d44a47437c6eea"
zmediaLsungFrage.Name = WWB_multiplatform_string("L\195\182sung Frage")
zmediaLsungFrage.AltText = ""
zmediaLsungFrage.Resources = {
  {
    Type = "jpg",
    Filename = "Loesung_frage.jpg",
    Directives = {}
  }
}
zmediaMighlaFinaleTelefonnummer = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaMighlaFinaleTelefonnummer.Id = "d64e6a16c937b8fda2377ab44cad4e9c"
zmediaMighlaFinaleTelefonnummer.Name = "Mighla Finale Telefonnummer"
zmediaMighlaFinaleTelefonnummer.AltText = ""
zmediaMighlaFinaleTelefonnummer.Resources = {
  {
    Type = "jpg",
    Filename = "Mighla_Finale.jpg",
    Directives = {}
  }
}
zmediaMighla_Schlssel = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaMighla_Schlssel.Id = "788c131bbc6719c29e089c7adaddd39e"
zmediaMighla_Schlssel.Name = WWB_multiplatform_string("Mighla_Schl\195\188ssel")
zmediaMighla_Schlssel.AltText = ""
zmediaMighla_Schlssel.Resources = {
  {
    Type = "jpg",
    Filename = "Mighla_Schluessel_Dokument.jpg",
    Directives = {}
  }
}
zmediaMighla_Schlssel_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaMighla_Schlssel_32.Id = "2dfa00ed9995406406d09ea1839eb8b4"
zmediaMighla_Schlssel_32.Name = WWB_multiplatform_string("Mighla_Schl\195\188ssel_32")
zmediaMighla_Schlssel_32.AltText = ""
zmediaMighla_Schlssel_32.Resources = {
  {
    Type = "jpg",
    Filename = "Mighla_Schluessel_Dokument_32.jpg",
    Directives = {}
  }
}
zmediaNavigation = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNavigation.Id = "023873fc1b0efb39a22502e3ab885610"
zmediaNavigation.Name = "Navigation"
zmediaNavigation.AltText = ""
zmediaNavigation.Resources = {
  {
    Type = "jpg",
    Filename = "Navigation.jpg",
    Directives = {}
  }
}
zmediaNavigation_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNavigation_32.Id = "3a7b48e5a53d11773e74a6cbc7b217f0"
zmediaNavigation_32.Name = "Navigation_32"
zmediaNavigation_32.AltText = ""
zmediaNavigation_32.Resources = {
  {
    Type = "jpg",
    Filename = "Navigation32.jpg",
    Directives = {}
  }
}
zmediaNebel = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebel.Id = "33a952ae200eedb48d2f63c617af235e"
zmediaNebel.Name = "Nebel"
zmediaNebel.AltText = ""
zmediaNebel.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel_02.jpg",
    Directives = {}
  }
}
zmediaNebelSHFenster = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebelSHFenster.Id = "11e2ac9bcc1ed1d018341bf893d1a0c3"
zmediaNebelSHFenster.Name = "Nebel SH Fenster"
zmediaNebelSHFenster.AltText = ""
zmediaNebelSHFenster.Resources = {
  {
    Type = "jpg",
    Filename = "Summe.jpg",
    Directives = {}
  }
}
zmediaNebelSHFront = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebelSHFront.Id = "fac0f491b379422f72698afa3c8362a5"
zmediaNebelSHFront.Name = "Nebel SH Front"
zmediaNebelSHFront.AltText = ""
zmediaNebelSHFront.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel_SH_leer_1.jpg",
    Directives = {}
  }
}
zmediaNebelSHlinks = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebelSHlinks.Id = "f665e157a6af8f04f597342de260e4f0"
zmediaNebelSHlinks.Name = "Nebel SH links"
zmediaNebelSHlinks.AltText = ""
zmediaNebelSHlinks.Resources = {
  {
    Type = "jpg",
    Filename = "Elemente.jpg",
    Directives = {}
  }
}
zmediaNebelSHrechts = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebelSHrechts.Id = "eb8fb8b10ebbc4494c42614dc6e85d4e"
zmediaNebelSHrechts.Name = "Nebel SH rechts"
zmediaNebelSHrechts.AltText = ""
zmediaNebelSHrechts.Resources = {
  {
    Type = "jpg",
    Filename = "Ordnungszahl.jpg",
    Directives = {}
  }
}
zmediaNebelSHSeite = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebelSHSeite.Id = "8dd35872f0c543c34f68d96b5e01b982"
zmediaNebelSHSeite.Name = "Nebel SH Seite"
zmediaNebelSHSeite.AltText = ""
zmediaNebelSHSeite.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel_SH_leer.jpg",
    Directives = {}
  }
}
zmediaNebelSHTr = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebelSHTr.Id = "bb5e0f523f088edbfe21a5fbc85ebd31"
zmediaNebelSHTr.Name = WWB_multiplatform_string("Nebel SH T\195\188r")
zmediaNebelSHTr.AltText = ""
zmediaNebelSHTr.Resources = {
  {
    Type = "jpg",
    Filename = "GeHeIMnIS.jpg",
    Directives = {}
  }
}
zmediaNebel_01 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebel_01.Id = "b2d1e81d113b07141f96c7c00d77c0d2"
zmediaNebel_01.Name = "Nebel_01"
zmediaNebel_01.AltText = ""
zmediaNebel_01.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel_1.jpg",
    Directives = {}
  }
}
zmediaNebel_02 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebel_02.Id = "6025059ddbbb5c4c1ba5f697a430b0f2"
zmediaNebel_02.Name = "Nebel_02"
zmediaNebel_02.AltText = ""
zmediaNebel_02.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel.jpg",
    Directives = {}
  }
}
zmediaNebel_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebel_32.Id = "5445877669990ebaa35d5a54e16ce58f"
zmediaNebel_32.Name = "Nebel_32"
zmediaNebel_32.AltText = ""
zmediaNebel_32.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel32.jpg",
    Directives = {}
  }
}
zmediaNebel_Schutzhtte = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNebel_Schutzhtte.Id = "d97900c3e1d1630cc68385ee7e66b79e"
zmediaNebel_Schutzhtte.Name = WWB_multiplatform_string("Nebel_Schutzh\195\188tte")
zmediaNebel_Schutzhtte.AltText = ""
zmediaNebel_Schutzhtte.Resources = {
  {
    Type = "jpg",
    Filename = "Nebel_Schutzhuette.jpg",
    Directives = {}
  }
}
zmediaNelke = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNelke.Id = "ad1a59678936f5496b2f0a54daa26469"
zmediaNelke.Name = "Nelke"
zmediaNelke.AltText = ""
zmediaNelke.Resources = {
  {
    Type = "jpg",
    Filename = "Nelke.jpg",
    Directives = {}
  }
}
zmediaNelke_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNelke_32.Id = "168d62e559e0560976c773e9b89a66d5"
zmediaNelke_32.Name = "Nelke_32"
zmediaNelke_32.AltText = ""
zmediaNelke_32.Resources = {
  {
    Type = "jpg",
    Filename = "Nelke32.jpg",
    Directives = {}
  }
}
zmediaNotiz = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNotiz.Id = "f96c09d1fed03dd5260b188a9727888d"
zmediaNotiz.Name = "Notiz"
zmediaNotiz.AltText = ""
zmediaNotiz.Resources = {
  {
    Type = "jpg",
    Filename = "Notiz.jpg",
    Directives = {}
  }
}
zmediaNotiz_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaNotiz_32.Id = "a3ec9ad302904138a186eb5f743d80c1"
zmediaNotiz_32.Name = "Notiz_32"
zmediaNotiz_32.AltText = ""
zmediaNotiz_32.Resources = {
  {
    Type = "jpg",
    Filename = "Notiz32.jpg",
    Directives = {}
  }
}
zmediaPergament = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPergament.Id = "543e22f64f19fcb870de735f08632cad"
zmediaPergament.Name = "Pergament"
zmediaPergament.AltText = ""
zmediaPergament.Resources = {
  {
    Type = "jpg",
    Filename = "Pergament_2_01.jpg",
    Directives = {}
  }
}
zmediaPergament1 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPergament1.Id = "c0361aeecd3cecf201f552d614451420"
zmediaPergament1.Name = "Pergament 1"
zmediaPergament1.AltText = ""
zmediaPergament1.Resources = {
  {
    Type = "jpg",
    Filename = "Pergament_1.jpg",
    Directives = {}
  }
}
zmediaPergament2 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPergament2.Id = "bfd8d2f6fbc32bca18c583f461425f31"
zmediaPergament2.Name = "Pergament 2"
zmediaPergament2.AltText = ""
zmediaPergament2.Resources = {
  {
    Type = "jpg",
    Filename = "Pergament_2_02.jpg",
    Directives = {}
  }
}
zmediaPergament3 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPergament3.Id = "36d05421ba9ef9f1b43cdb849b227978"
zmediaPergament3.Name = "Pergament 3"
zmediaPergament3.AltText = ""
zmediaPergament3.Resources = {
  {
    Type = "jpg",
    Filename = "Pergament_2_03.jpg",
    Directives = {}
  }
}
zmediaPergament4 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPergament4.Id = "6d7e52c4a77d4c256022a5a856b73d88"
zmediaPergament4.Name = "Pergament 4"
zmediaPergament4.AltText = ""
zmediaPergament4.Resources = {
  {
    Type = "jpg",
    Filename = "Pergament_2_04.jpg",
    Directives = {}
  }
}
zmediaPergament_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPergament_32.Id = "f125b0f18b167b8424fdd2dfb8487fd6"
zmediaPergament_32.Name = "Pergament_32"
zmediaPergament_32.AltText = ""
zmediaPergament_32.Resources = {
  {
    Type = "jpg",
    Filename = "Pergament_2_32.jpg",
    Directives = {}
  }
}
zmediaPortalAktivierungskarten = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPortalAktivierungskarten.Id = "68ac6f6f2597dadd20c643053bd996d3"
zmediaPortalAktivierungskarten.Name = "Portal Aktivierungskarten"
zmediaPortalAktivierungskarten.AltText = ""
zmediaPortalAktivierungskarten.Resources = {
  {
    Type = "jpg",
    Filename = "Reiseunterlage_Aktivierungskarten.jpg",
    Directives = {}
  }
}
zmediaPortalAktivierungskarten_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPortalAktivierungskarten_32.Id = "4709dd5d5c3f2e42bfcab1e0dcde87e6"
zmediaPortalAktivierungskarten_32.Name = "Portal Aktivierungskarten_32"
zmediaPortalAktivierungskarten_32.AltText = ""
zmediaPortalAktivierungskarten_32.Resources = {
  {
    Type = "jpg",
    Filename = "Reiseunterlage_Aktivierungskarten32.jpg",
    Directives = {}
  }
}
zmediaPortalZeitreisemaschiene = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPortalZeitreisemaschiene.Id = "b833e83a2bac4cd0e763570bccbf62e3"
zmediaPortalZeitreisemaschiene.Name = "Portal Zeitreisemaschiene"
zmediaPortalZeitreisemaschiene.AltText = ""
zmediaPortalZeitreisemaschiene.Resources = {
  {
    Type = "jpg",
    Filename = "Reiseunterlage_Zeitmaschiene.jpg",
    Directives = {}
  }
}
zmediaPortalZeitreisemaschiene_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaPortalZeitreisemaschiene_32.Id = "3e2e44d8a6dbdd88d538a1f4183e15c7"
zmediaPortalZeitreisemaschiene_32.Name = "Portal Zeitreisemaschiene_32"
zmediaPortalZeitreisemaschiene_32.AltText = ""
zmediaPortalZeitreisemaschiene_32.Resources = {
  {
    Type = "jpg",
    Filename = "Reiseunterlage_Zeitreisemaschine32.jpg",
    Directives = {}
  }
}
zmediaQR_Code = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaQR_Code.Id = "767fd9d8586e64873f8e2f2c2e939223"
zmediaQR_Code.Name = "QR_Code"
zmediaQR_Code.AltText = ""
zmediaQR_Code.Resources = {
  {
    Type = "jpg",
    Filename = "QR_Code.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS1 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS1.Id = "a31d563f6d31aa9b941e88ae9923a791"
zmediaRadfahrerZeitungS1.Name = "RadfahrerZeitung S1"
zmediaRadfahrerZeitungS1.AltText = ""
zmediaRadfahrerZeitungS1.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_1_WfW.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS1_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS1_32.Id = "ed68902c7ad90218836ea0271a649b3e"
zmediaRadfahrerZeitungS1_32.Name = "RadfahrerZeitung S1_32"
zmediaRadfahrerZeitungS1_32.AltText = ""
zmediaRadfahrerZeitungS1_32.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_1_WfW32.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS37 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS37.Id = "c98c752237854fe1dbcc4ccf0f0a6135"
zmediaRadfahrerZeitungS37.Name = "RadfahrerZeitung S37"
zmediaRadfahrerZeitungS37.AltText = ""
zmediaRadfahrerZeitungS37.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_37.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS37_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS37_32.Id = "255a27ea7b547b243cbd90dfe54ee77e"
zmediaRadfahrerZeitungS37_32.Name = "RadfahrerZeitung S37_32"
zmediaRadfahrerZeitungS37_32.AltText = ""
zmediaRadfahrerZeitungS37_32.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_3732.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS41 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS41.Id = "b09e410f5471e9ff553fd26dd92cf223"
zmediaRadfahrerZeitungS41.Name = "RadfahrerZeitung S41"
zmediaRadfahrerZeitungS41.AltText = ""
zmediaRadfahrerZeitungS41.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_41_WfW.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS41_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS41_32.Id = "a23f9990cd0feaf2fbe7bbf58ff27c1e"
zmediaRadfahrerZeitungS41_32.Name = "RadfahrerZeitung S41_32"
zmediaRadfahrerZeitungS41_32.AltText = ""
zmediaRadfahrerZeitungS41_32.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_41_WfW32.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS45 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS45.Id = "9c60788c9171162145ace26f35ea09f3"
zmediaRadfahrerZeitungS45.Name = "RadfahrerZeitung S45"
zmediaRadfahrerZeitungS45.AltText = ""
zmediaRadfahrerZeitungS45.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_45.jpg",
    Directives = {}
  }
}
zmediaRadfahrerZeitungS45_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRadfahrerZeitungS45_32.Id = "b50062fc6fc9ad5cd8c3aa240042e6f5"
zmediaRadfahrerZeitungS45_32.Name = "RadfahrerZeitung S45_32"
zmediaRadfahrerZeitungS45_32.AltText = ""
zmediaRadfahrerZeitungS45_32.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitung_S_4532.jpg",
    Directives = {}
  }
}
zmediaRettungsschwimmer = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRettungsschwimmer.Id = "943060ccf2441bd5f920b416a2de1085"
zmediaRettungsschwimmer.Name = "Rettungsschwimmer"
zmediaRettungsschwimmer.AltText = ""
zmediaRettungsschwimmer.Resources = {
  {
    Type = "jpg",
    Filename = "Rettungsschwimmer.jpg",
    Directives = {}
  }
}
zmediaRettungsschwimmerin = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRettungsschwimmerin.Id = "9a855d1b5d6fbd30b97e0373c7b40f68"
zmediaRettungsschwimmerin.Name = "Rettungsschwimmerin"
zmediaRettungsschwimmerin.AltText = ""
zmediaRettungsschwimmerin.Resources = {
  {
    Type = "jpg",
    Filename = "Rettungsschwimmerin.jpg",
    Directives = {}
  }
}
zmediaRettungsschwimmerin_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRettungsschwimmerin_32.Id = "eaf110a3d4b204ac0d2026123972f0ca"
zmediaRettungsschwimmerin_32.Name = "Rettungsschwimmerin_32"
zmediaRettungsschwimmerin_32.AltText = ""
zmediaRettungsschwimmerin_32.Resources = {
  {
    Type = "jpg",
    Filename = "Rettungsschwimmerin32.jpg",
    Directives = {}
  }
}
zmediaRettungsschwimmer_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRettungsschwimmer_32.Id = "9da24d6a079313ac23ba7851129547a9"
zmediaRettungsschwimmer_32.Name = "Rettungsschwimmer_32"
zmediaRettungsschwimmer_32.AltText = ""
zmediaRettungsschwimmer_32.Resources = {
  {
    Type = "jpg",
    Filename = "Rettungsschwimmer32.jpg",
    Directives = {}
  }
}
zmediaRbezahl_alt = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRbezahl_alt.Id = "ce3bb7eb58b6f4278912d9ee641bd540"
zmediaRbezahl_alt.Name = WWB_multiplatform_string("R\195\188bezahl_alt")
zmediaRbezahl_alt.AltText = ""
zmediaRbezahl_alt.Resources = {
  {
    Type = "jpg",
    Filename = "Ruebezahl_alt.jpg",
    Directives = {}
  }
}
zmediaRbezahl_neu = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRbezahl_neu.Id = "f3ccbc60703155c92237ea14acfb374a"
zmediaRbezahl_neu.Name = WWB_multiplatform_string("R\195\188bezahl_neu")
zmediaRbezahl_neu.AltText = ""
zmediaRbezahl_neu.Resources = {
  {
    Type = "jpg",
    Filename = "Ruebezahl_neu.jpg",
    Directives = {}
  }
}
zmediaRbezahl_neu_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaRbezahl_neu_32.Id = "8d20a3ae3d6ec36a46688074be0eca98"
zmediaRbezahl_neu_32.Name = WWB_multiplatform_string("R\195\188bezahl_neu_32")
zmediaRbezahl_neu_32.AltText = ""
zmediaRbezahl_neu_32.Resources = {
  {
    Type = "jpg",
    Filename = "Ruebezahl_neu32.jpg",
    Directives = {}
  }
}
zmediaSchliessfach = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchliessfach.Id = "7a3e7f3ceb05656202150599ec3fda76"
zmediaSchliessfach.Name = "Schliessfach"
zmediaSchliessfach.AltText = ""
zmediaSchliessfach.Resources = {
  {
    Type = "jpg",
    Filename = "schiessfach.jpg",
    Directives = {}
  }
}
zmediaSchliessfach_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchliessfach_32.Id = "0f09dc18728db3df1b8f1240620cc78f"
zmediaSchliessfach_32.Name = "Schliessfach_32"
zmediaSchliessfach_32.AltText = ""
zmediaSchliessfach_32.Resources = {
  {
    Type = "jpg",
    Filename = "schiessfach32.jpg",
    Directives = {}
  }
}
zmediaSchlssel1Koffer = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchlssel1Koffer.Id = "d42f56d5cee22afcc0a555b69030ccc7"
zmediaSchlssel1Koffer.Name = WWB_multiplatform_string("Schl\195\188ssel 1 Koffer")
zmediaSchlssel1Koffer.AltText = ""
zmediaSchlssel1Koffer.Resources = {
  {
    Type = "jpg",
    Filename = "Koffer_Schluessel.jpg",
    Directives = {}
  }
}
zmediaSchutzhtte = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchutzhtte.Id = "ca09e918ce77e47eae9db7f7cdf3865e"
zmediaSchutzhtte.Name = WWB_multiplatform_string("Schutzh\195\188tte")
zmediaSchutzhtte.AltText = ""
zmediaSchutzhtte.Resources = {
  {
    Type = "jpg",
    Filename = "Schutzhuette.jpg",
    Directives = {}
  }
}
zmediaSchutzhtte_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchutzhtte_32.Id = "22ff4b889773b3cd4b7ec4e871fce495"
zmediaSchutzhtte_32.Name = WWB_multiplatform_string("Schutzh\195\188tte_32")
zmediaSchutzhtte_32.AltText = ""
zmediaSchutzhtte_32.Resources = {
  {
    Type = "jpg",
    Filename = "Schutzhuette32.jpg",
    Directives = {}
  }
}
zmediaSchutzmann = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchutzmann.Id = "c11845e8661f16f025b3c4bed3b26c0a"
zmediaSchutzmann.Name = "Schutzmann"
zmediaSchutzmann.AltText = ""
zmediaSchutzmann.Resources = {
  {
    Type = "jpg",
    Filename = "Schutzmann.jpg",
    Directives = {}
  }
}
zmediaSchutzmann_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSchutzmann_32.Id = "8ad38167c5a65e0c15cd2316c6a53f44"
zmediaSchutzmann_32.Name = "Schutzmann_32"
zmediaSchutzmann_32.AltText = ""
zmediaSchutzmann_32.Resources = {
  {
    Type = "jpg",
    Filename = "Schutzmann32.jpg",
    Directives = {}
  }
}
zmediaSeebr = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSeebr.Id = "bf6aaea65007e85c320d8a169a3a2035"
zmediaSeebr.Name = WWB_multiplatform_string("Seeb\195\164r")
zmediaSeebr.AltText = ""
zmediaSeebr.Resources = {
  {
    Type = "jpg",
    Filename = "Seebaer.jpg",
    Directives = {}
  }
}
zmediaSeebr_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSeebr_32.Id = "79450e1c3b3ef1d41bd06d8b2d30a4e3"
zmediaSeebr_32.Name = WWB_multiplatform_string("Seeb\195\164r_32")
zmediaSeebr_32.AltText = ""
zmediaSeebr_32.Resources = {
  {
    Type = "jpg",
    Filename = "Seebaer32.jpg",
    Directives = {}
  }
}
zmediaSeglerheim = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSeglerheim.Id = "c21d3817249c4a8616fd05f5cab3b858"
zmediaSeglerheim.Name = "Seglerheim"
zmediaSeglerheim.AltText = ""
zmediaSeglerheim.Resources = {
  {
    Type = "jpg",
    Filename = "Seglerheim.jpg",
    Directives = {}
  }
}
zmediaSeglerheim_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSeglerheim_32.Id = "a426c8489c20740841d1abd792da47a2"
zmediaSeglerheim_32.Name = "Seglerheim_32"
zmediaSeglerheim_32.AltText = ""
zmediaSeglerheim_32.Resources = {
  {
    Type = "jpg",
    Filename = "Seglerheim32.jpg",
    Directives = {}
  }
}
zmediaSpieler = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpieler.Id = "3ec6f97ecb302d51e2237056c11c8919"
zmediaSpieler.Name = "Spieler"
zmediaSpieler.AltText = ""
zmediaSpieler.Resources = {
  {
    Type = "jpg",
    Filename = "cacher.JPG",
    Directives = {}
  }
}
zmediaSpielkarte = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpielkarte.Id = "4add1bc56d5ad7ce3dfa2d32388580dd"
zmediaSpielkarte.Name = "Spielkarte"
zmediaSpielkarte.AltText = ""
zmediaSpielkarte.Resources = {
  {
    Type = "jpg",
    Filename = "Hinweis_WfW.jpg",
    Directives = {}
  }
}
zmediaSpielkarte_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpielkarte_32.Id = "74e5c5441a3ca15371458f727ebeb273"
zmediaSpielkarte_32.Name = "Spielkarte_32"
zmediaSpielkarte_32.AltText = ""
zmediaSpielkarte_32.Resources = {
  {
    Type = "jpg",
    Filename = "Hinweis_WfW32.jpg",
    Directives = {}
  }
}
zmediaSpreetunnelMP = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpreetunnelMP.Id = "feb282e41da1c59a0cde49f67d5d4dd1"
zmediaSpreetunnelMP.Name = "Spreetunnel MP"
zmediaSpreetunnelMP.AltText = ""
zmediaSpreetunnelMP.Resources = {
  {
    Type = "jpg",
    Filename = "Spree_Tunnel.jpg",
    Directives = {}
  }
}
zmediaSpreetunnelMP_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpreetunnelMP_32.Id = "d6dafb54c4c5d615155323b868947f6b"
zmediaSpreetunnelMP_32.Name = "Spreetunnel MP_32"
zmediaSpreetunnelMP_32.AltText = ""
zmediaSpreetunnelMP_32.Resources = {
  {
    Type = "jpg",
    Filename = "Spree_Tunnel32.jpg",
    Directives = {}
  }
}
zmediaSpreetunnel_MW = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpreetunnel_MW.Id = "e2fdfcaf6fdb2c494f6308f6b35d004a"
zmediaSpreetunnel_MW.Name = "Spreetunnel_MW"
zmediaSpreetunnel_MW.AltText = ""
zmediaSpreetunnel_MW.Resources = {
  {
    Type = "jpg",
    Filename = "Spreetunnel_Nord.jpg",
    Directives = {}
  }
}
zmediaSpreetunnel_MW_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpreetunnel_MW_32.Id = "4c6e5407f20bbb1dc6d309263b0d8d5d"
zmediaSpreetunnel_MW_32.Name = "Spreetunnel_MW_32"
zmediaSpreetunnel_MW_32.AltText = ""
zmediaSpreetunnel_MW_32.Resources = {
  {
    Type = "jpg",
    Filename = "Spreetunnel_Nord32.jpg",
    Directives = {}
  }
}
zmediaSpreetunnel_Zeichnung = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaSpreetunnel_Zeichnung.Id = "8271c00a520bacb89488a6510be2a8f2"
zmediaSpreetunnel_Zeichnung.Name = "Spreetunnel_Zeichnung"
zmediaSpreetunnel_Zeichnung.AltText = ""
zmediaSpreetunnel_Zeichnung.Resources = {
  {
    Type = "jpg",
    Filename = "Spree-Bau-Aufriss.jpg",
    Directives = {}
  }
}
zmediaStadtkasse1 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtkasse1.Id = "36f189fb79c29c5c5921e6c7d85e77c3"
zmediaStadtkasse1.Name = "Stadtkasse 1"
zmediaStadtkasse1.AltText = ""
zmediaStadtkasse1.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtkasse_1.jpg",
    Directives = {}
  }
}
zmediaStadtkasse2 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtkasse2.Id = "50ddeb0c27ed25f6df1bed92bcf669d5"
zmediaStadtkasse2.Name = "Stadtkasse 2"
zmediaStadtkasse2.AltText = ""
zmediaStadtkasse2.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtkasse_2.jpg",
    Directives = {}
  }
}
zmediaStadtkasse3 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtkasse3.Id = "60668f3f3a92d67d2028eebeb0ed819c"
zmediaStadtkasse3.Name = "Stadtkasse 3"
zmediaStadtkasse3.AltText = ""
zmediaStadtkasse3.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtkasse_3.jpg",
    Directives = {}
  }
}
zmediaStadtkasse_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtkasse_32.Id = "45c007b640f5ab40bba98fd1c6ac3a6b"
zmediaStadtkasse_32.Name = "Stadtkasse_32"
zmediaStadtkasse_32.AltText = ""
zmediaStadtkasse_32.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtkasse_32.jpg",
    Directives = {}
  }
}
zmediaStadtplanMueggelpark = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtplanMueggelpark.Id = "61e6d1ddea57c066ef22f0f167921c1f"
zmediaStadtplanMueggelpark.Name = "Stadtplan Mueggelpark"
zmediaStadtplanMueggelpark.AltText = ""
zmediaStadtplanMueggelpark.Resources = {
  {
    Type = "png",
    Filename = "Stadtplan_Mueggelpark_WfW.png",
    Directives = {}
  }
}
zmediaStadtplanMueggelpark_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtplanMueggelpark_32.Id = "a4fb27ebb52d04c925fd16dfd2f4bfaa"
zmediaStadtplanMueggelpark_32.Name = "Stadtplan Mueggelpark_32"
zmediaStadtplanMueggelpark_32.AltText = ""
zmediaStadtplanMueggelpark_32.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtplan_Mueggelpark_WfW32.jpg",
    Directives = {}
  }
}
zmediaStadtplanMggelwald = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtplanMggelwald.Id = "bba717d21a16a0c02844d3fe0bd646aa"
zmediaStadtplanMggelwald.Name = WWB_multiplatform_string("Stadtplan M\195\188ggelwald")
zmediaStadtplanMggelwald.AltText = ""
zmediaStadtplanMggelwald.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtplan_Mueggelwald.JPG",
    Directives = {}
  }
}
zmediaStadtplanMggelwald_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaStadtplanMggelwald_32.Id = "f3695b6afbeec2c9956cfbb3c337366b"
zmediaStadtplanMggelwald_32.Name = WWB_multiplatform_string("Stadtplan M\195\188ggelwald_32")
zmediaStadtplanMggelwald_32.AltText = ""
zmediaStadtplanMggelwald_32.Resources = {
  {
    Type = "jpg",
    Filename = "Stadtplan_Mueggelwald32.jpg",
    Directives = {}
  }
}
zmediaS_Alarm = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Alarm.Id = "15aa142b303b9b3d9bd89b0d268b2991"
zmediaS_Alarm.Name = "S_Alarm"
zmediaS_Alarm.AltText = ""
zmediaS_Alarm.Resources = {
  {
    Type = "wav",
    Filename = "alarm.wav",
    Directives = {}
  }
}
zmediaS_Antworteingabe_Portal = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Antworteingabe_Portal.Id = "d9edd7df4dfa188844b1ddc4faacb7f4"
zmediaS_Antworteingabe_Portal.Name = "S_Antworteingabe_Portal"
zmediaS_Antworteingabe_Portal.AltText = ""
zmediaS_Antworteingabe_Portal.Resources = {
  {
    Type = "mp3",
    Filename = "sagmalwasan_modem_2b7f9b37f8.mp3",
    Directives = {}
  }
}
zmediaS_auf_zuschlieen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_auf_zuschlieen.Id = "4eaf5573d68c7345bee4a52c6a3aad22"
zmediaS_auf_zuschlieen.Name = WWB_multiplatform_string("S_auf_zuschlie\195\159en")
zmediaS_auf_zuschlieen.AltText = ""
zmediaS_auf_zuschlieen.Resources = {
  {
    Type = "mp3",
    Filename = "aufschliessen.mp3",
    Directives = {}
  }
}
zmediaS_Beifall = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Beifall.Id = "b1e5a36ad723b1be309f47b7e206e9a0"
zmediaS_Beifall.Name = "S_Beifall"
zmediaS_Beifall.AltText = ""
zmediaS_Beifall.Resources = {
  {
    Type = "wav",
    Filename = "Beifall.wav",
    Directives = {}
  }
}
zmediaS_ein_auspacken = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_ein_auspacken.Id = "33c40581dffd258391b974a73e27236a"
zmediaS_ein_auspacken.Name = "S_ein_auspacken"
zmediaS_ein_auspacken.AltText = ""
zmediaS_ein_auspacken.Resources = {
  {
    Type = "mp3",
    Filename = "packen.mp3",
    Directives = {}
  }
}
zmediaS_Gasthaus = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Gasthaus.Id = "7cde331cb6c6d2305d10e8126b9edbf2"
zmediaS_Gasthaus.Name = "S_Gasthaus"
zmediaS_Gasthaus.AltText = ""
zmediaS_Gasthaus.Resources = {
  {
    Type = "mp3",
    Filename = "Menschen_in_Eckkneipe.mp3",
    Directives = {}
  }
}
zmediaS_HinweisFehler = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_HinweisFehler.Id = "cc3bd654210f761fef73d6c2b04406f2"
zmediaS_HinweisFehler.Name = "S_Hinweis Fehler "
zmediaS_HinweisFehler.AltText = ""
zmediaS_HinweisFehler.Resources = {
  {
    Type = "mp3",
    Filename = "Hinweiston_Fehler.mp3",
    Directives = {}
  }
}
zmediaS_Hinweiston = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Hinweiston.Id = "8124e4f0fcb18e4902e8ed1d0c9f6188"
zmediaS_Hinweiston.Name = "S_Hinweiston"
zmediaS_Hinweiston.AltText = ""
zmediaS_Hinweiston.Resources = {
  {
    Type = "wav",
    Filename = "Hinweis.WAV",
    Directives = {}
  }
}
zmediaS_Klingel = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Klingel.Id = "811bbb4ca36c4683f2679f885c52908d"
zmediaS_Klingel.Name = "S_Klingel"
zmediaS_Klingel.AltText = ""
zmediaS_Klingel.Resources = {
  {
    Type = "wav",
    Filename = "Klingel.wav",
    Directives = {}
  }
}
zmediaS_Niesen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Niesen.Id = "bc9c9eeaaf05ab5d817632dde37a2813"
zmediaS_Niesen.Name = "S_Niesen"
zmediaS_Niesen.AltText = ""
zmediaS_Niesen.Resources = {
  {
    Type = "wav",
    Filename = "Niesen.wav",
    Directives = {}
  }
}
zmediaS_Pferdefuhrwerk = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Pferdefuhrwerk.Id = "e81246786f7d9fbd420131977f0faf74"
zmediaS_Pferdefuhrwerk.Name = "S_Pferdefuhrwerk"
zmediaS_Pferdefuhrwerk.AltText = ""
zmediaS_Pferdefuhrwerk.Resources = {
  {
    Type = "mp3",
    Filename = "Zwei_Pferdekutschen.mp3",
    Directives = {}
  }
}
zmediaS_Portal_Eintritt = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Portal_Eintritt.Id = "168fd44fac6b435ba9479c4680f9305f"
zmediaS_Portal_Eintritt.Name = "S_Portal_Eintritt"
zmediaS_Portal_Eintritt.AltText = ""
zmediaS_Portal_Eintritt.Resources = {
  {
    Type = "wav",
    Filename = "Echolot2.wav",
    Directives = {}
  }
}
zmediaS_Strand = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Strand.Id = "5ae7d4416b59508f6d7b07b55c6186d7"
zmediaS_Strand.Name = "S_Strand"
zmediaS_Strand.AltText = ""
zmediaS_Strand.Resources = {
  {
    Type = "wav",
    Filename = "Strand.wav",
    Directives = {}
  }
}
zmediaS_Taucherblasen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Taucherblasen.Id = "7fa4f3180ebcd2b9f04d2ed7571ce439"
zmediaS_Taucherblasen.Name = "S_Taucherblasen"
zmediaS_Taucherblasen.AltText = ""
zmediaS_Taucherblasen.Resources = {
  {
    Type = "wav",
    Filename = "Taucherblasen.wav",
    Directives = {}
  }
}
zmediaS_Trillerpfeifekurz = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Trillerpfeifekurz.Id = "e61ee9aca595965a08282c51db5479e3"
zmediaS_Trillerpfeifekurz.Name = "S_Trillerpfeife kurz"
zmediaS_Trillerpfeifekurz.AltText = ""
zmediaS_Trillerpfeifekurz.Resources = {
  {
    Type = "wav",
    Filename = "trillerpfeife.wav",
    Directives = {}
  }
}
zmediaS_Trillerpfeifelang = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Trillerpfeifelang.Id = "401cef7a8e16d7262e9a38ce9f774baf"
zmediaS_Trillerpfeifelang.Name = "S_Trillerpfeife lang"
zmediaS_Trillerpfeifelang.AltText = ""
zmediaS_Trillerpfeifelang.Resources = {
  {
    Type = "wav",
    Filename = "Trillerpfeiffe_lang.wav",
    Directives = {}
  }
}
zmediaS_Turmglocke = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Turmglocke.Id = "021f6351b7b6f85a034aad0e2011d3cb"
zmediaS_Turmglocke.Name = "S_Turmglocke"
zmediaS_Turmglocke.AltText = ""
zmediaS_Turmglocke.Resources = {
  {
    Type = "wav",
    Filename = "turmglocke.wav",
    Directives = {}
  }
}
zmediaS_Zoneneintritt = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaS_Zoneneintritt.Id = "5ed7f31b82d3a8f0117899a5e008c93c"
zmediaS_Zoneneintritt.Name = "S_Zoneneintritt"
zmediaS_Zoneneintritt.AltText = ""
zmediaS_Zoneneintritt.Resources = {
  {
    Type = "wav",
    Filename = "Zonenankunft.wav",
    Directives = {}
  }
}
zmediaTaucher = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTaucher.Id = "44f7c03b64f479ce75914834c6723b0f"
zmediaTaucher.Name = "Taucher"
zmediaTaucher.AltText = ""
zmediaTaucher.Resources = {
  {
    Type = "jpg",
    Filename = "Taucher.jpg",
    Directives = {}
  }
}
zmediaTaucher_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTaucher_32.Id = "28c1fffe02ac1f3f86ecd2580d28a4be"
zmediaTaucher_32.Name = "Taucher_32"
zmediaTaucher_32.AltText = ""
zmediaTaucher_32.Resources = {
  {
    Type = "jpg",
    Filename = "Taucher32.jpg",
    Directives = {}
  }
}
zmediaTeppich = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTeppich.Id = "1fa406c9bccf1c58abbf79b8d95fb7ca"
zmediaTeppich.Name = "Teppich"
zmediaTeppich.AltText = ""
zmediaTeppich.Resources = {
  {
    Type = "jpg",
    Filename = "Teppich.jpg",
    Directives = {}
  }
}
zmediaTeppich_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTeppich_32.Id = "e523d6954bcd7642bc50919c855d81ac"
zmediaTeppich_32.Name = "Teppich_32"
zmediaTeppich_32.AltText = ""
zmediaTeppich_32.Resources = {
  {
    Type = "jpg",
    Filename = "Teppich32.jpg",
    Directives = {}
  }
}
zmediaTreibgutoffen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTreibgutoffen.Id = "45daa49dbfb462333b39505ad3250021"
zmediaTreibgutoffen.Name = "Treibgut offen"
zmediaTreibgutoffen.AltText = ""
zmediaTreibgutoffen.Resources = {
  {
    Type = "jpg",
    Filename = "Treibgut_offen.jpg",
    Directives = {}
  }
}
zmediaTreibgutoffen_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTreibgutoffen_32.Id = "0aedb474381cc7bbeb0cb97577debc94"
zmediaTreibgutoffen_32.Name = "Treibgut offen_32"
zmediaTreibgutoffen_32.AltText = ""
zmediaTreibgutoffen_32.Resources = {
  {
    Type = "jpg",
    Filename = "Treibgut_offen32.jpg",
    Directives = {}
  }
}
zmediaTreibgutzu = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTreibgutzu.Id = "b0113d80d96fab4513d303f6c28ada0d"
zmediaTreibgutzu.Name = "Treibgut zu"
zmediaTreibgutzu.AltText = ""
zmediaTreibgutzu.Resources = {
  {
    Type = "jpg",
    Filename = "Treibgut_zu.jpg",
    Directives = {}
  }
}
zmediaTreibgutzu_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTreibgutzu_32.Id = "63ae181933ae83099e894bf13b4e70cb"
zmediaTreibgutzu_32.Name = "Treibgut zu_32"
zmediaTreibgutzu_32.AltText = ""
zmediaTreibgutzu_32.Resources = {
  {
    Type = "jpg",
    Filename = "Treibgut_zu32.jpg",
    Directives = {}
  }
}
zmediaTruheoffen = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruheoffen.Id = "9afc7d42e6abd66f8eba91aad34805a3"
zmediaTruheoffen.Name = "Truhe offen"
zmediaTruheoffen.AltText = ""
zmediaTruheoffen.Resources = {
  {
    Type = "png",
    Filename = "Truhe_auf_1.png",
    Directives = {}
  }
}
zmediaTruheoffen_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruheoffen_32.Id = "519c6b9e1517492919263158e8f4757c"
zmediaTruheoffen_32.Name = "Truhe offen_32"
zmediaTruheoffen_32.AltText = ""
zmediaTruheoffen_32.Resources = {
  {
    Type = "jpg",
    Filename = "Truhe_auf_32.jpg",
    Directives = {}
  }
}
zmediaTruhePergament = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruhePergament.Id = "f4579f4aceb4b8da689eae0b80a4d905"
zmediaTruhePergament.Name = "Truhe Pergament"
zmediaTruhePergament.AltText = ""
zmediaTruhePergament.Resources = {
  {
    Type = "jpg",
    Filename = "Truhe_Pergament.jpg",
    Directives = {}
  }
}
zmediaTruhePergament_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruhePergament_32.Id = "3d3da769e8a3f5d928d160a1ab446034"
zmediaTruhePergament_32.Name = "Truhe Pergament_32"
zmediaTruhePergament_32.AltText = ""
zmediaTruhePergament_32.Resources = {
  {
    Type = "jpg",
    Filename = "Truhe_Pergament32.jpg",
    Directives = {}
  }
}
zmediaTruheUnterseite = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruheUnterseite.Id = "a3b263f6a6a29757a06c38a581184611"
zmediaTruheUnterseite.Name = "Truhe Unterseite"
zmediaTruheUnterseite.AltText = ""
zmediaTruheUnterseite.Resources = {
  {
    Type = "jpg",
    Filename = "Truhenboden_02.jpg",
    Directives = {}
  }
}
zmediaTruhezu = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruhezu.Id = "55ab980cc39b18ed1b68aba2559b3415"
zmediaTruhezu.Name = "Truhe zu"
zmediaTruhezu.AltText = ""
zmediaTruhezu.Resources = {
  {
    Type = "jpg",
    Filename = "Truhe_zu_1.jpg",
    Directives = {}
  }
}
zmediaTruhezu_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaTruhezu_32.Id = "aa55ba506db094aa40beec4c39d30f43"
zmediaTruhezu_32.Name = "Truhe zu_32"
zmediaTruhezu_32.AltText = ""
zmediaTruhezu_32.Resources = {
  {
    Type = "jpg",
    Filename = "Truhe_zu_32.jpg",
    Directives = {}
  }
}
zmediaVertreter = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaVertreter.Id = "24d4f87316ab3e6cab59232b0cf9febc"
zmediaVertreter.Name = "Vertreter"
zmediaVertreter.AltText = ""
zmediaVertreter.Resources = {
  {
    Type = "jpg",
    Filename = "Mitarbeiter_1.jpg",
    Directives = {}
  }
}
zmediaVoigt = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaVoigt.Id = "b612d1baafa9807e1f2491ad72b98024"
zmediaVoigt.Name = "Voigt"
zmediaVoigt.AltText = ""
zmediaVoigt.Resources = {
  {
    Type = "jpg",
    Filename = "Wilhelmvoigt.jpg",
    Directives = {}
  }
}
zmediaVoigt_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaVoigt_32.Id = "f9b8cd4ff283e262a779f931a4d6713e"
zmediaVoigt_32.Name = "Voigt_32"
zmediaVoigt_32.AltText = ""
zmediaVoigt_32.Resources = {
  {
    Type = "jpg",
    Filename = "Wilhelmvoigt32.jpg",
    Directives = {}
  }
}
zmediaVoigt_Akte = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaVoigt_Akte.Id = "94f62a14b715f3402de211d6790875ee"
zmediaVoigt_Akte.Name = "Voigt_Akte"
zmediaVoigt_Akte.AltText = ""
zmediaVoigt_Akte.Resources = {
  {
    Type = "jpg",
    Filename = "Steckbrief_Voigt.jpg",
    Directives = {}
  }
}
zmediaZeitungsjunge = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZeitungsjunge.Id = "63e74b0885c09b57af3de964a3d5c713"
zmediaZeitungsjunge.Name = "Zeitungsjunge"
zmediaZeitungsjunge.AltText = ""
zmediaZeitungsjunge.Resources = {
  {
    Type = "gif",
    Filename = "Zeitungsjunge.gif",
    Directives = {}
  }
}
zmediaZeitungsjunge_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZeitungsjunge_32.Id = "2889a21289ac3c157cca96e9cf5aeeca"
zmediaZeitungsjunge_32.Name = "Zeitungsjunge_32"
zmediaZeitungsjunge_32.AltText = ""
zmediaZeitungsjunge_32.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitungsjunge32.jpg",
    Directives = {}
  }
}
zmediaZettelgefaltet = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZettelgefaltet.Id = "c474bf1cfdc2767aa63b5acc0a39dfbd"
zmediaZettelgefaltet.Name = "Zettel gefaltet"
zmediaZettelgefaltet.AltText = ""
zmediaZettelgefaltet.Resources = {
  {
    Type = "jpg",
    Filename = "Zettel_gefaltet.jpg",
    Directives = {}
  }
}
zmediaZille = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZille.Id = "3bd23a61f59fb0ced6f9743618cc4da5"
zmediaZille.Name = "Zille"
zmediaZille.AltText = ""
zmediaZille.Resources = {
  {
    Type = "jpg",
    Filename = "Zille.jpg",
    Directives = {}
  }
}
zmediaZillebeiderArbeit = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZillebeiderArbeit.Id = "ca7b8b5d875450d9a03095e7fbef37ff"
zmediaZillebeiderArbeit.Name = "Zille bei der Arbeit"
zmediaZillebeiderArbeit.AltText = ""
zmediaZillebeiderArbeit.Resources = {
  {
    Type = "jpg",
    Filename = "Zille_an_der_Staffelei.jpg",
    Directives = {}
  }
}
zmediaZille_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZille_32.Id = "bd954c13c58560bbc15d47cd98af625f"
zmediaZille_32.Name = "Zille_32"
zmediaZille_32.AltText = ""
zmediaZille_32.Resources = {
  {
    Type = "jpg",
    Filename = "Zille32.jpg",
    Directives = {}
  }
}
zmediaZille_Zeichnung = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZille_Zeichnung.Id = "eaa0826ae126dac140773ee54d9ff3d9"
zmediaZille_Zeichnung.Name = "Zille_Zeichnung"
zmediaZille_Zeichnung.AltText = ""
zmediaZille_Zeichnung.Resources = {
  {
    Type = "jpg",
    Filename = "Heinrich_Zille_Zeichnung_WfW.jpg",
    Directives = {}
  }
}
zmediaZille_Zeichnung_32 = Wherigo.ZMedia(cartMighlaTeil1v3)
zmediaZille_Zeichnung_32.Id = "70dd7908196a4be64797b827f30f6a28"
zmediaZille_Zeichnung_32.Name = "Zille_Zeichnung_32"
zmediaZille_Zeichnung_32.AltText = ""
zmediaZille_Zeichnung_32.Resources = {
  {
    Type = "jpg",
    Filename = "Heinrich_Zille_Zeichnung_WfW32.jpg",
    Directives = {}
  }
}
cartMighlaTeil1v3.Id = "8c3c4ce3-4f3e-4b5c-9fa9-147624cf686a"
cartMighlaTeil1v3.Name = "Mighla Teil 1"
cartMighlaTeil1v3.Activity = "Geocache"
cartMighlaTeil1v3.Version = "1.2"
cartMighlaTeil1v3.Company = ""
cartMighlaTeil1v3.Author = "McWood"
cartMighlaTeil1v3.TargetDevice = "SmartPhone"
cartMighlaTeil1v3.TargetDeviceVersion = "0"
cartMighlaTeil1v3.BuilderVersion = "WWB 0000.3.2019.09.16.174037"
cartMighlaTeil1v3.StateId = "1"
cartMighlaTeil1v3.CountryId = "2"
cartMighlaTeil1v3.Description = "<BR>\n<BR>\n<BR>\n<BR>\n<BR>\n<BR>\nWillkommen bei Mighla Teil 1. <BR>\n<BR>\nWichtig! Starte das Spiel und mache Dich erst dann auf den Weg zum Start wenn Deine Vorbereitungen abgeschlossen sind!<BR>\nDas Spiel ist fuer Android und iOS erstellt worden, fuer andere Betriebssysteme kann ich keine Funktionsfaehigkeit gewaehrleisten.<BR>\nEinige Texte sind etwas laenger, bitte das Scrollen nicht vergessen. Desweiteren solltest Du den Ton an Deinem Geraet aktivieren um die Soundelemente hoeren zu koennen.<BR>\n<BR>\nViel Spass und maximale Erfolge w\195\188nscht Dir McWood"
cartMighlaTeil1v3.StartingLocationDescription = [[
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
Die Startkoordinaten liegen in der Naehe der Startzone.]]
cartMighlaTeil1v3.Visible = true
cartMighlaTeil1v3.Complete = false
cartMighlaTeil1v3.UseLogging = true
cartMighlaTeil1v3.CreateDate = "2/16/2020 03:59:23 PM"
cartMighlaTeil1v3.PublishDate = "1/1/1970 01:00:00 AM"
cartMighlaTeil1v3.UpdateDate = "3/19/2021 04:25:09 PM"
cartMighlaTeil1v3.LastPlayedDate = "1/1/1970 01:00:00 AM"
cartMighlaTeil1v3.Media = zmediaLogo
cartMighlaTeil1v3.Icon = zmediaLogo
cartMighlaTeil1v3.StartingLocation = ZonePoint(52.44685, 13.624317, 0)
zone02a_Eingang_MP1 = Wherigo.Zone(cartMighlaTeil1v3)
zone02a_Eingang_MP1.Id = "c3a1247047f72c19e18646fcf692b58c"
zone02a_Eingang_MP1.Name = "02a_Eingang_MP1"
zone02a_Eingang_MP1.DistanceRangeUOM = "Meters"
zone02a_Eingang_MP1.ProximityRangeUOM = "Meters"
zone02a_Eingang_MP1.ShowObjects = "OnEnter"
zone02a_Eingang_MP1.OutOfRangeName = ""
zone02a_Eingang_MP1.InRangeName = ""
zone02a_Eingang_MP1.Description = ""
zone02a_Eingang_MP1.Visible = false
zone02a_Eingang_MP1.AllowSetPositionTo = false
zone02a_Eingang_MP1.Active = false
zone02a_Eingang_MP1.DistanceRange = Distance(-1, "meters")
zone02a_Eingang_MP1.ProximityRange = Distance(0, "meters")
zone02a_Eingang_MP1.Points = {
  ZonePoint(52.44571666667737, 13.626988737236102, 0),
  ZonePoint(52.445841109716675, 13.626904168034748, 0),
  ZonePoint(52.44589265571084, 13.626699999985952, 0),
  ZonePoint(52.445841109716675, 13.6264958319512, 0),
  ZonePoint(52.44571666667737, 13.62641126275239, 0),
  ZonePoint(52.44559222362803, 13.62649583192382, 0),
  ZonePoint(52.4455406776261, 13.626699999985952, 0),
  ZonePoint(52.44559222362803, 13.626904168063858, 0)
}
zone02a_Eingang_MP1.OriginalPoint = ZonePoint(52.44571666666667, 13.6267, 0)
zone02b_Eingang_MP2 = Wherigo.Zone(cartMighlaTeil1v3)
zone02b_Eingang_MP2.Id = "f6132002b4c38dbf30e4fdbf627e94ee"
zone02b_Eingang_MP2.Name = "02b_Eingang_MP2"
zone02b_Eingang_MP2.DistanceRangeUOM = "Meters"
zone02b_Eingang_MP2.ProximityRangeUOM = "Meters"
zone02b_Eingang_MP2.ShowObjects = "OnEnter"
zone02b_Eingang_MP2.OutOfRangeName = ""
zone02b_Eingang_MP2.InRangeName = ""
zone02b_Eingang_MP2.Description = ""
zone02b_Eingang_MP2.Visible = false
zone02b_Eingang_MP2.AllowSetPositionTo = false
zone02b_Eingang_MP2.Active = false
zone02b_Eingang_MP2.DistanceRange = Distance(-1, "meters")
zone02b_Eingang_MP2.ProximityRange = Distance(0, "meters")
zone02b_Eingang_MP2.Points = {
  ZonePoint(52.44568333334753, 13.627592652458032, 0),
  ZonePoint(52.445823830271756, 13.627497173414394, 0),
  ZonePoint(52.445882026000234, 13.627266666663848, 0),
  ZonePoint(52.445823830271756, 13.627036159916154, 0),
  ZonePoint(52.44568333334753, 13.626940680878317, 0),
  ZonePoint(52.44554283642141, 13.627036159883382, 0),
  ZonePoint(52.445484640682494, 13.627266666663848, 0),
  ZonePoint(52.44554283642141, 13.627497173446148, 0)
}
zone02b_Eingang_MP2.OriginalPoint = ZonePoint(52.445683333333335, 13.627266666666667, 0)
zone02c_Eingang_MP3 = Wherigo.Zone(cartMighlaTeil1v3)
zone02c_Eingang_MP3.Id = "a83be06e0e616f614763b86e7d94e4fc"
zone02c_Eingang_MP3.Name = "02c_Eingang_MP3"
zone02c_Eingang_MP3.DistanceRangeUOM = "Meters"
zone02c_Eingang_MP3.ProximityRangeUOM = "Meters"
zone02c_Eingang_MP3.ShowObjects = "OnEnter"
zone02c_Eingang_MP3.OutOfRangeName = ""
zone02c_Eingang_MP3.InRangeName = ""
zone02c_Eingang_MP3.Description = ""
zone02c_Eingang_MP3.Visible = false
zone02c_Eingang_MP3.AllowSetPositionTo = false
zone02c_Eingang_MP3.Active = false
zone02c_Eingang_MP3.DistanceRange = Distance(-1, "meters")
zone02c_Eingang_MP3.ProximityRange = Distance(0, "meters")
zone02c_Eingang_MP3.Points = {
  ZonePoint(52.4455333333445, 13.627981234744313, 0),
  ZonePoint(52.44567609300427, 13.627884218314234, 0),
  ZonePoint(52.445735225988535, 13.627649999999425, 0),
  ZonePoint(52.44567609300427, 13.627415781682993, 0),
  ZonePoint(52.4455333333445, 13.627318765253834, 0),
  ZonePoint(52.445390573671126, 13.627415781639398, 0),
  ZonePoint(52.445331440673314, 13.627649999999425, 0),
  ZonePoint(52.445390573671126, 13.627884218358371, 0)
}
zone02c_Eingang_MP3.OriginalPoint = ZonePoint(52.44553333333333, 13.62765, 0)
zone04_Spreetunnel_Stop = Wherigo.Zone(cartMighlaTeil1v3)
zone04_Spreetunnel_Stop.Id = "a5a9e07f1dbeae18b509491a07efddf7"
zone04_Spreetunnel_Stop.Name = "04_Spreetunnel_Stop"
zone04_Spreetunnel_Stop.DistanceRangeUOM = "Meters"
zone04_Spreetunnel_Stop.ProximityRangeUOM = "Meters"
zone04_Spreetunnel_Stop.ShowObjects = "OnEnter"
zone04_Spreetunnel_Stop.OutOfRangeName = ""
zone04_Spreetunnel_Stop.InRangeName = ""
zone04_Spreetunnel_Stop.Description = WWB_multiplatform_string("Versuch den Spreetunnel vor der Er\195\182ffnung zu betreten unterbinden")
zone04_Spreetunnel_Stop.Visible = false
zone04_Spreetunnel_Stop.AllowSetPositionTo = false
zone04_Spreetunnel_Stop.Active = false
zone04_Spreetunnel_Stop.DistanceRange = Distance(-1, "meters")
zone04_Spreetunnel_Stop.ProximityRange = Distance(0, "meters")
zone04_Spreetunnel_Stop.Points = {
  ZonePoint(52.444900000020745, 13.626512022209804, 0),
  ZonePoint(52.44500574791028, 13.626440159195857, 0),
  ZonePoint(52.44504955011485, 13.626266666669972, 0),
  ZonePoint(52.44500574791028, 13.626093174133906, 0),
  ZonePoint(52.444900000020745, 13.626021311122402, 0),
  ZonePoint(52.44479425210833, 13.62609317406083, 0),
  ZonePoint(52.444750449880274, 13.626266666669972, 0),
  ZonePoint(52.44479425210833, 13.626440159269443, 0)
}
zone04_Spreetunnel_Stop.OriginalPoint = ZonePoint(52.4449, 13.626266666666666, 0)
zone04_Spreetunnel_Stop_gr = Wherigo.Zone(cartMighlaTeil1v3)
zone04_Spreetunnel_Stop_gr.Id = "e23bd199fa0b7cf2ca0943f4bfc13a9c"
zone04_Spreetunnel_Stop_gr.Name = "04_Spreetunnel_Stop_gr"
zone04_Spreetunnel_Stop_gr.DistanceRangeUOM = "Meters"
zone04_Spreetunnel_Stop_gr.ProximityRangeUOM = "Meters"
zone04_Spreetunnel_Stop_gr.ShowObjects = "OnEnter"
zone04_Spreetunnel_Stop_gr.OutOfRangeName = ""
zone04_Spreetunnel_Stop_gr.InRangeName = ""
zone04_Spreetunnel_Stop_gr.Description = WWB_multiplatform_string("Versuch den Spreetunnel vor der Er\195\182ffnung zu betreten unterbinden")
zone04_Spreetunnel_Stop_gr.Visible = false
zone04_Spreetunnel_Stop_gr.AllowSetPositionTo = false
zone04_Spreetunnel_Stop_gr.Active = false
zone04_Spreetunnel_Stop_gr.DistanceRange = Distance(-1, "meters")
zone04_Spreetunnel_Stop_gr.ProximityRange = Distance(0, "meters")
zone04_Spreetunnel_Stop_gr.Points = {
  ZonePoint(52.44490000007877, 13.626787905800763, 0),
  ZonePoint(52.445124653388774, 13.626635238258933, 0),
  ZonePoint(52.44521770780911, 13.62626666666539, 0),
  ZonePoint(52.445124653388774, 13.62589809507592, 0),
  ZonePoint(52.44490000007877, 13.62574542753409, 0),
  ZonePoint(52.444675346689856, 13.625898094808448, 0),
  ZonePoint(52.44458229218525, 13.62626666666539, 0),
  ZonePoint(52.444675346689856, 13.626635238525997, 0)
}
zone04_Spreetunnel_Stop_gr.OriginalPoint = ZonePoint(52.4449, 13.626266666666666, 0)
zone07_Spreetunnel_Ausgang = Wherigo.Zone(cartMighlaTeil1v3)
zone07_Spreetunnel_Ausgang.Id = "995794eeea651142e87959b20ce7fd96"
zone07_Spreetunnel_Ausgang.Name = "07_Spreetunnel_Ausgang"
zone07_Spreetunnel_Ausgang.DistanceRangeUOM = "Meters"
zone07_Spreetunnel_Ausgang.ProximityRangeUOM = "Meters"
zone07_Spreetunnel_Ausgang.ShowObjects = "OnEnter"
zone07_Spreetunnel_Ausgang.OutOfRangeName = ""
zone07_Spreetunnel_Ausgang.InRangeName = ""
zone07_Spreetunnel_Ausgang.Description = ""
zone07_Spreetunnel_Ausgang.Visible = false
zone07_Spreetunnel_Ausgang.AllowSetPositionTo = false
zone07_Spreetunnel_Ausgang.Active = false
zone07_Spreetunnel_Ausgang.DistanceRange = Distance(-1, "meters")
zone07_Spreetunnel_Ausgang.ProximityRange = Distance(0, "meters")
zone07_Spreetunnel_Ausgang.Points = {
  ZonePoint(52.44421666669925, 13.6248259749318, 0),
  ZonePoint(52.4443571636084, 13.62473049902719, 0),
  ZonePoint(52.44441535932361, 13.624499999999033, 0),
  ZonePoint(52.4443571636084, 13.624269500969246, 0),
  ZonePoint(52.44421666669925, 13.624174025063008, 0),
  ZonePoint(52.444076169755746, 13.624269500855458, 0),
  ZonePoint(52.44401797400554, 13.624499999999033, 0),
  ZonePoint(52.444076169755746, 13.624730499139655, 0)
}
zone07_Spreetunnel_Ausgang.OriginalPoint = ZonePoint(52.44421666666667, 13.6245, 0)
zone07_Spreetunnel_Ausgang.Media = zmediaSpreetunnel_MW
zone07_Spreetunnel_Ausgang.Icon = zmediaSpreetunnel_MW_32
zone08_Spreetunnel_Ausgang_ = Wherigo.Zone(cartMighlaTeil1v3)
zone08_Spreetunnel_Ausgang_.Id = "1e62f2b0cb43c3b8cdcbd54407df502e"
zone08_Spreetunnel_Ausgang_.Name = "08_Spreetunnel_Ausgang_"
zone08_Spreetunnel_Ausgang_.DistanceRangeUOM = "Meters"
zone08_Spreetunnel_Ausgang_.ProximityRangeUOM = "Meters"
zone08_Spreetunnel_Ausgang_.ShowObjects = "OnEnter"
zone08_Spreetunnel_Ausgang_.OutOfRangeName = ""
zone08_Spreetunnel_Ausgang_.InRangeName = ""
zone08_Spreetunnel_Ausgang_.Description = ""
zone08_Spreetunnel_Ausgang_.Visible = false
zone08_Spreetunnel_Ausgang_.AllowSetPositionTo = false
zone08_Spreetunnel_Ausgang_.Active = false
zone08_Spreetunnel_Ausgang_.DistanceRange = Distance(-1, "meters")
zone08_Spreetunnel_Ausgang_.ProximityRange = Distance(0, "meters")
zone08_Spreetunnel_Ausgang_.Points = {
  ZonePoint(52.44421666677936, 13.62506093218488, 0),
  ZonePoint(52.44445843147032, 13.624896638758672, 0),
  ZonePoint(52.444558573649125, 13.624500000001069, 0),
  ZonePoint(52.44445843147032, 13.624103361241938, 0),
  ZonePoint(52.44421666677936, 13.623939067814204, 0),
  ZonePoint(52.44397490197178, 13.624103360850704, 0),
  ZonePoint(52.443874759671225, 13.624500000001069, 0),
  ZonePoint(52.44397490197178, 13.624896639150924, 0)
}
zone08_Spreetunnel_Ausgang_.OriginalPoint = ZonePoint(52.44421666666667, 13.6245, 0)
zone08_Spreetunnel_Ausgang_.Media = zmediaSpreetunnel_MW
zone08_Spreetunnel_Ausgang_.Icon = zmediaSpreetunnel_MW_32
zone09_Spree_Ecke = Wherigo.Zone(cartMighlaTeil1v3)
zone09_Spree_Ecke.Id = "160a4ccd21c124091d4106ab1377b8f5"
zone09_Spree_Ecke.Name = "09_Spree_Ecke"
zone09_Spree_Ecke.DistanceRangeUOM = "Meters"
zone09_Spree_Ecke.ProximityRangeUOM = "Meters"
zone09_Spree_Ecke.ShowObjects = "OnEnter"
zone09_Spree_Ecke.OutOfRangeName = ""
zone09_Spree_Ecke.InRangeName = ""
zone09_Spree_Ecke.Description = ""
zone09_Spree_Ecke.Visible = false
zone09_Spree_Ecke.AllowSetPositionTo = false
zone09_Spree_Ecke.Active = false
zone09_Spree_Ecke.DistanceRange = Distance(-1, "meters")
zone09_Spree_Ecke.ProximityRange = Distance(0, "meters")
zone09_Spree_Ecke.Points = {
  ZonePoint(52.44426666668192, 13.625338521384773, 0),
  ZonePoint(52.44435510371092, 13.625278423168599, 0),
  ZonePoint(52.44439173552345, 13.625133333334125, 0),
  ZonePoint(52.44435510371092, 13.624988243499343, 0),
  ZonePoint(52.44426666668192, 13.6249281452848, 0),
  ZonePoint(52.4441782296372, 13.624988243448252, 0),
  ZonePoint(52.44414159780897, 13.625133333334125, 0),
  ZonePoint(52.4441782296372, 13.625278423219997, 0)
}
zone09_Spree_Ecke.OriginalPoint = ZonePoint(52.444266666666664, 13.625133333333334, 0)
zoneBadebucht1 = Wherigo.Zone(cartMighlaTeil1v3)
zoneBadebucht1.Id = "e00e65bac15d797bebf3c715d0027601"
zoneBadebucht1.Name = "Badebucht 1"
zoneBadebucht1.DistanceRangeUOM = "Meters"
zoneBadebucht1.ProximityRangeUOM = "Meters"
zoneBadebucht1.ShowObjects = "OnEnter"
zoneBadebucht1.OutOfRangeName = ""
zoneBadebucht1.InRangeName = ""
zoneBadebucht1.Description = ""
zoneBadebucht1.Visible = false
zoneBadebucht1.AllowSetPositionTo = false
zoneBadebucht1.Active = false
zoneBadebucht1.DistanceRange = Distance(200, "meters")
zoneBadebucht1.ProximityRange = Distance(0, "meters")
zoneBadebucht1.Points = {
  ZonePoint(52.43449537558377, 13.620503298328138, 0),
  ZonePoint(52.43456088448766, 13.620458790984811, 0),
  ZonePoint(52.43458801916247, 13.620351340884174, 0),
  ZonePoint(52.43456088448858, 13.62024389078038, 0),
  ZonePoint(52.43449537558707, 13.620199383438477, 0),
  ZonePoint(52.43442986666081, 13.620243890707709, 0),
  ZonePoint(52.43440273196579, 13.620351340884174, 0),
  ZonePoint(52.43442986665504, 13.62045879105626, 0)
}
zoneBadebucht1.OriginalPoint = ZonePoint(52.4345, 13.62035, 0)
zoneBadebucht1.Media = zmediaBadebucht_1
zoneBadebucht1.Icon = zmediaBadebucht_1_32
zoneBadebucht1_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneBadebucht1_.Id = "b5c65bd655b54ea7de98c6033da08f0f"
zoneBadebucht1_.Name = "Badebucht 1_"
zoneBadebucht1_.DistanceRangeUOM = "Meters"
zoneBadebucht1_.ProximityRangeUOM = "Meters"
zoneBadebucht1_.ShowObjects = "OnEnter"
zoneBadebucht1_.OutOfRangeName = ""
zoneBadebucht1_.InRangeName = ""
zoneBadebucht1_.Description = ""
zoneBadebucht1_.Visible = true
zoneBadebucht1_.AllowSetPositionTo = false
zoneBadebucht1_.Active = false
zoneBadebucht1_.DistanceRange = Distance(-1, "meters")
zoneBadebucht1_.ProximityRange = Distance(0, "meters")
zoneBadebucht1_.Points = {
  ZonePoint(52.434500000105686, 13.620723872332515, 0),
  ZonePoint(52.43466117655239, 13.620614367489535, 0),
  ZonePoint(52.4347279379921, 13.620349999998755, 0),
  ZonePoint(52.43466117655239, 13.620085632506958, 0),
  ZonePoint(52.434500000105686, 13.61997612766286, 0),
  ZonePoint(52.43433882355232, 13.620085632163052, 0),
  ZonePoint(52.43427206200817, 13.620349999998755, 0),
  ZonePoint(52.43433882355232, 13.620614367833442, 0)
}
zoneBadebucht1_.OriginalPoint = ZonePoint(52.4345, 13.62035, 0)
zoneBadebucht1_.Media = zmediaBadebucht_1
zoneBadebucht1_.Icon = zmediaBadebucht_1_32
zoneBadebucht2 = Wherigo.Zone(cartMighlaTeil1v3)
zoneBadebucht2.Id = "be12060abece9eacb825813a47a3612e"
zoneBadebucht2.Name = "Badebucht 2"
zoneBadebucht2.DistanceRangeUOM = "Meters"
zoneBadebucht2.ProximityRangeUOM = "Meters"
zoneBadebucht2.ShowObjects = "OnEnter"
zoneBadebucht2.OutOfRangeName = ""
zoneBadebucht2.InRangeName = ""
zoneBadebucht2.Description = ""
zoneBadebucht2.Visible = false
zoneBadebucht2.AllowSetPositionTo = false
zoneBadebucht2.Active = false
zoneBadebucht2.DistanceRange = Distance(100, "meters")
zoneBadebucht2.ProximityRange = Distance(0, "meters")
zoneBadebucht2.Points = {
  ZonePoint(52.42964931733531, 13.622370079993063, 0),
  ZonePoint(52.4297082753488, 13.622330027796897, 0),
  ZonePoint(52.42973269655805, 13.622233333330698, 0),
  ZonePoint(52.4297082753488, 13.62213663886857, 0),
  ZonePoint(52.42964931733531, 13.622096586674543, 0),
  ZonePoint(52.42959035930354, 13.62213663881707, 0),
  ZonePoint(52.42956593808154, 13.622233333330698, 0),
  ZonePoint(52.42959035930354, 13.622330027848905, 0)
}
zoneBadebucht2.OriginalPoint = ZonePoint(52.42965, 13.622233333333334, 0)
zoneBadebucht2.Media = zmediaBadebucht_2
zoneBadebucht2.Icon = zmediaBadebucht_2_32
zoneBadebucht2_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneBadebucht2_.Id = "bdbf6211c31dfc7e78b49c1b786b2982"
zoneBadebucht2_.Name = "Badebucht 2_"
zoneBadebucht2_.DistanceRangeUOM = "Meters"
zoneBadebucht2_.ProximityRangeUOM = "Meters"
zoneBadebucht2_.ShowObjects = "OnEnter"
zoneBadebucht2_.OutOfRangeName = ""
zoneBadebucht2_.InRangeName = ""
zoneBadebucht2_.Description = ""
zoneBadebucht2_.Visible = true
zoneBadebucht2_.AllowSetPositionTo = false
zoneBadebucht2_.Active = false
zoneBadebucht2_.DistanceRange = Distance(-1, "meters")
zoneBadebucht2_.ProximityRange = Distance(0, "meters")
zoneBadebucht2_.Points = {
  ZonePoint(52.42965758528743, 13.62257198057079, 0),
  ZonePoint(52.42980264409046, 13.622473437045516, 0),
  ZonePoint(52.4298627293854, 13.622235532462588, 0),
  ZonePoint(52.42980264408897, 13.621997627874878, 0),
  ZonePoint(52.429657585286144, 13.621899084352554, 0),
  ZonePoint(52.42951252638873, 13.621997627563744, 0),
  ZonePoint(52.42945244099697, 13.622235532462385, 0),
  ZonePoint(52.42951252638914, 13.622473437357158, 0)
}
zoneBadebucht2_.OriginalPoint = ZonePoint(52.42965, 13.622233333333334, 0)
zoneBadebucht2_.Media = zmediaBadebucht_2
zoneBadebucht2_.Icon = zmediaBadebucht_2_32
zoneBedrfnisanstallt = Wherigo.Zone(cartMighlaTeil1v3)
zoneBedrfnisanstallt.Id = "4d84493c3e739e084e28287d3da27e0b"
zoneBedrfnisanstallt.Name = WWB_multiplatform_string("Bed\195\188rfnisanstallt")
zoneBedrfnisanstallt.DistanceRangeUOM = "Meters"
zoneBedrfnisanstallt.ProximityRangeUOM = "Meters"
zoneBedrfnisanstallt.ShowObjects = "OnEnter"
zoneBedrfnisanstallt.OutOfRangeName = ""
zoneBedrfnisanstallt.InRangeName = ""
zoneBedrfnisanstallt.Description = ""
zoneBedrfnisanstallt.Visible = false
zoneBedrfnisanstallt.AllowSetPositionTo = false
zoneBedrfnisanstallt.Active = false
zoneBedrfnisanstallt.DistanceRange = Distance(-1, "meters")
zoneBedrfnisanstallt.ProximityRange = Distance(0, "meters")
zoneBedrfnisanstallt.Points = {
  ZonePoint(52.445366666665, 13.627224378734276, 0),
  ZonePoint(52.44546337256375, 13.6271586597233, 0),
  ZonePoint(52.445503429459514, 13.627000000001896, 0),
  ZonePoint(52.44546337256375, 13.626841340270925, 0),
  ZonePoint(52.445366666665, 13.626775621270227, 0),
  ZonePoint(52.44526996076513, 13.626841340272756, 0),
  ZonePoint(52.44522990386869, 13.627000000001896, 0),
  ZonePoint(52.44526996076513, 13.62715865972452, 0)
}
zoneBedrfnisanstallt.OriginalPoint = ZonePoint(52.445366666666665, 13.627, 0)
zoneBedrfnisanstallt.Media = zmediaBedrfnisanstalt
zoneBedrfnisanstallt.Icon = zmediaBedrfnisanstalt_32
zoneBedrfnisanstallt_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneBedrfnisanstallt_.Id = "ae0266c0747ad502bcbb6a9a098bf42a"
zoneBedrfnisanstallt_.Name = WWB_multiplatform_string("Bed\195\188rfnisanstallt_")
zoneBedrfnisanstallt_.DistanceRangeUOM = "Meters"
zoneBedrfnisanstallt_.ProximityRangeUOM = "Meters"
zoneBedrfnisanstallt_.ShowObjects = "OnEnter"
zoneBedrfnisanstallt_.OutOfRangeName = ""
zoneBedrfnisanstallt_.InRangeName = ""
zoneBedrfnisanstallt_.Description = ""
zoneBedrfnisanstallt_.Visible = true
zoneBedrfnisanstallt_.AllowSetPositionTo = false
zoneBedrfnisanstallt_.Active = false
zoneBedrfnisanstallt_.DistanceRange = Distance(-1, "meters")
zoneBedrfnisanstallt_.ProximityRange = Distance(0, "meters")
zoneBedrfnisanstallt_.Points = {
  ZonePoint(52.44537446240841, 13.627584291408457, 0),
  ZonePoint(52.44563051800264, 13.627410281800813, 0),
  ZonePoint(52.44573657966869, 13.626990186061608, 0),
  ZonePoint(52.445630518005714, 13.62657009031538, 0),
  ZonePoint(52.445374462407614, 13.626396080720356, 0),
  ZonePoint(52.445118406708595, 13.626570089948572, 0),
  ZonePoint(52.4450123449249, 13.626990186055705, 0),
  ZonePoint(52.44511840670601, 13.627410282157646, 0)
}
zoneBedrfnisanstallt_.OriginalPoint = ZonePoint(52.445366666666665, 13.627, 0)
zoneBedrfnisanstallt_.Media = zmediaBedrfnisanstalt
zoneBedrfnisanstallt_.Icon = zmediaBedrfnisanstalt_32
zoneBiergarten = Wherigo.Zone(cartMighlaTeil1v3)
zoneBiergarten.Id = "ae924d0658a91520b2ee7377f937d574"
zoneBiergarten.Name = "Biergarten"
zoneBiergarten.DistanceRangeUOM = "Meters"
zoneBiergarten.ProximityRangeUOM = "Meters"
zoneBiergarten.ShowObjects = "OnEnter"
zoneBiergarten.OutOfRangeName = ""
zoneBiergarten.InRangeName = ""
zoneBiergarten.Description = ""
zoneBiergarten.Visible = true
zoneBiergarten.AllowSetPositionTo = false
zoneBiergarten.Active = false
zoneBiergarten.DistanceRange = Distance(-1, "meters")
zoneBiergarten.ProximityRange = Distance(0, "meters")
zoneBiergarten.Points = {
  ZonePoint(52.44393333334809, 13.624504493908127, 0),
  ZonePoint(52.443985554526535, 13.624469006770381, 0),
  ZonePoint(52.44400718524298, 13.624383333333986, 0),
  ZonePoint(52.443985554526535, 13.624297659897044, 0),
  ZonePoint(52.44393333334809, 13.62426217275948, 0),
  ZonePoint(52.44388111215423, 13.624297659848494, 0),
  ZonePoint(52.44385948142366, 13.624383333333986, 0),
  ZonePoint(52.44388111215423, 13.62446900681838, 0)
}
zoneBiergarten.OriginalPoint = ZonePoint(52.443933333333334, 13.624383333333334, 0)
zoneBiergarten.Media = zmediaGasthausMggelschlsschen
zoneBiergarten.Icon = zmediaGasthausMggelschlsschen_32
zoneBiergarten_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneBiergarten_.Id = "fdfd0481652b56698b05efa091e80e80"
zoneBiergarten_.Name = "Biergarten_"
zoneBiergarten_.DistanceRangeUOM = "Meters"
zoneBiergarten_.ProximityRangeUOM = "Meters"
zoneBiergarten_.ShowObjects = "OnEnter"
zoneBiergarten_.OutOfRangeName = ""
zoneBiergarten_.InRangeName = ""
zoneBiergarten_.Description = ""
zoneBiergarten_.Visible = true
zoneBiergarten_.AllowSetPositionTo = false
zoneBiergarten_.Active = false
zoneBiergarten_.DistanceRange = Distance(-1, "meters")
zoneBiergarten_.ProximityRange = Distance(0, "meters")
zoneBiergarten_.Points = {
  ZonePoint(52.443933333419125, 13.624691113073672, 0),
  ZonePoint(52.44406598893148, 13.624600966333261, 0),
  ZonePoint(52.44412093661778, 13.624383333332736, 0),
  ZonePoint(52.44406598893148, 13.624165700331703, 0),
  ZonePoint(52.44393333341848, 13.624075553588339, 0),
  ZonePoint(52.44380067782064, 13.624165700046623, 0),
  ZonePoint(52.44374573004595, 13.624383333332736, 0),
  ZonePoint(52.44380067782064, 13.624600966618239, 0)
}
zoneBiergarten_.OriginalPoint = ZonePoint(52.443933333333334, 13.624383333333334, 0)
zoneBiergarten_.Media = zmediaGasthausMggelschlsschen
zoneBiergarten_.Icon = zmediaGasthausMggelschlsschen_32
zoneFotobox = Wherigo.Zone(cartMighlaTeil1v3)
zoneFotobox.Id = "31be4252fd7bbb3d240282de72e92c18"
zoneFotobox.Name = "Fotobox"
zoneFotobox.DistanceRangeUOM = "Meters"
zoneFotobox.ProximityRangeUOM = "Meters"
zoneFotobox.ShowObjects = "OnEnter"
zoneFotobox.OutOfRangeName = ""
zoneFotobox.InRangeName = ""
zoneFotobox.Description = ""
zoneFotobox.Visible = false
zoneFotobox.AllowSetPositionTo = false
zoneFotobox.Active = false
zoneFotobox.DistanceRange = Distance(-1, "meters")
zoneFotobox.ProximityRange = Distance(0, "meters")
zoneFotobox.Points = {
  ZonePoint(52.436633410555174, 13.647268191923768, 0),
  ZonePoint(52.44647701124322, 13.640579889859042, 0),
  ZonePoint(52.45055434151873, 13.624433333255164, 0),
  ZonePoint(52.446477011243985, 13.608286776757199, 0),
  ZonePoint(52.43663341055505, 13.601598474750718, 0),
  ZonePoint(52.42678973256431, 13.608286523296869, 0),
  ZonePoint(52.42271232506294, 13.624433333255164, 0),
  ZonePoint(52.42678973256335, 13.64058014333347, 0)
}
zoneFotobox.OriginalPoint = ZonePoint(52.43663333333333, 13.624433333333334, 0)
zoneKoffer = Wherigo.Zone(cartMighlaTeil1v3)
zoneKoffer.Id = "8755d877483d989867887090ad069473"
zoneKoffer.Name = "Koffer"
zoneKoffer.DistanceRangeUOM = "Meters"
zoneKoffer.ProximityRangeUOM = "Meters"
zoneKoffer.ShowObjects = "OnEnter"
zoneKoffer.OutOfRangeName = ""
zoneKoffer.InRangeName = ""
zoneKoffer.Description = ""
zoneKoffer.Visible = false
zoneKoffer.AllowSetPositionTo = false
zoneKoffer.Active = false
zoneKoffer.DistanceRange = Distance(-1, "meters")
zoneKoffer.ProximityRange = Distance(0, "meters")
zoneKoffer.Points = {
  ZonePoint(52.43663190439303, 13.6472623287114, 0),
  ZonePoint(52.44647552415694, 13.640574089479008, 0),
  ZonePoint(52.450552873508435, 13.624427470898656, 0),
  ZonePoint(52.44647552415774, 13.608280852335204, 0),
  ZonePoint(52.436631904393316, 13.601592613100886, 0),
  ZonePoint(52.42678824550589, 13.608280723988115, 0),
  ZonePoint(52.422710857035305, 13.624427470898656, 0),
  ZonePoint(52.426788245505925, 13.64057421783805, 0)
}
zoneKoffer.OriginalPoint = ZonePoint(52.436631865291055, 13.624427470906557, 0)
zoneLufer = Wherigo.Zone(cartMighlaTeil1v3)
zoneLufer.Id = "2cdd7ee31faa6a65feeb9423d7765080"
zoneLufer.Name = WWB_multiplatform_string("L\195\164ufer")
zoneLufer.DistanceRangeUOM = "Meters"
zoneLufer.ProximityRangeUOM = "Meters"
zoneLufer.ShowObjects = "OnEnter"
zoneLufer.OutOfRangeName = ""
zoneLufer.InRangeName = ""
zoneLufer.Description = ""
zoneLufer.Visible = true
zoneLufer.AllowSetPositionTo = false
zoneLufer.Active = false
zoneLufer.DistanceRange = Distance(-1, "meters")
zoneLufer.ProximityRange = Distance(0, "meters")
zoneLufer.Points = {
  ZonePoint(52.4415000000351, 13.622555891739209, 0),
  ZonePoint(52.44157278780348, 13.622506432102275, 0),
  ZonePoint(52.44160293728776, 13.622387023965572, 0),
  ZonePoint(52.44157278780201, 13.622267615830498, 0),
  ZonePoint(52.4415000000291, 13.622218156198551, 0),
  ZonePoint(52.4414272119653, 13.622267615297488, 0),
  ZonePoint(52.44139706307857, 13.622387023972392, 0),
  ZonePoint(52.44142721196897, 13.622506432644242, 0)
}
zoneLufer.OriginalPoint = ZonePoint(52.4415, 13.6224, 0)
zoneLufer.Media = zmediaLufer
zoneLufer.Icon = zmediaLufer_32
zoneLufer_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneLufer_.Id = "c63541bec3b8762d2a79b6036a96ca0a"
zoneLufer_.Name = WWB_multiplatform_string("L\195\164ufer_")
zoneLufer_.DistanceRangeUOM = "Meters"
zoneLufer_.ProximityRangeUOM = "Meters"
zoneLufer_.ShowObjects = "OnEnter"
zoneLufer_.OutOfRangeName = ""
zoneLufer_.InRangeName = ""
zoneLufer_.Description = ""
zoneLufer_.Visible = true
zoneLufer_.AllowSetPositionTo = false
zoneLufer_.Active = false
zoneLufer_.DistanceRange = Distance(-1, "meters")
zoneLufer_.ProximityRange = Distance(0, "meters")
zoneLufer_.Points = {
  ZonePoint(52.44150000009756, 13.622747465937689, 0),
  ZonePoint(52.44164976894775, 13.62264569536077, 0),
  ZonePoint(52.44171180520777, 13.622399999998668, 0),
  ZonePoint(52.44164976894775, 13.62215430463789, 0),
  ZonePoint(52.44150000009756, 13.622052534061684, 0),
  ZonePoint(52.44135023115012, 13.622154304317188, 0),
  ZonePoint(52.44128819479185, 13.622399999998668, 0),
  ZonePoint(52.44135023115012, 13.622645695681472, 0)
}
zoneLufer_.OriginalPoint = ZonePoint(52.4415, 13.6224, 0)
zoneLufer_.Media = zmediaLufer
zoneLufer_.Icon = zmediaLufer_32
zonePortal1927 = Wherigo.Zone(cartMighlaTeil1v3)
zonePortal1927.Id = "346dc5765406bbfe4e2824f841d2d509"
zonePortal1927.Name = "Portal 1927"
zonePortal1927.DistanceRangeUOM = "Meters"
zonePortal1927.ProximityRangeUOM = "Meters"
zonePortal1927.ShowObjects = "OnEnter"
zonePortal1927.OutOfRangeName = ""
zonePortal1927.InRangeName = ""
zonePortal1927.Description = ""
zonePortal1927.Visible = true
zonePortal1927.AllowSetPositionTo = false
zonePortal1927.Active = false
zonePortal1927.DistanceRange = Distance(-1, "meters")
zonePortal1927.ProximityRange = Distance(0, "meters")
zonePortal1927.Points = {
  ZonePoint(52.44421666669696, 13.628260336879627, 0),
  ZonePoint(52.444336056681124, 13.628179204364193, 0),
  ZonePoint(52.44438550962171, 13.627983333330178, 0),
  ZonePoint(52.444336056681124, 13.627787462299928, 0),
  ZonePoint(52.44421666669696, 13.627706329785003, 0),
  ZonePoint(52.44409727668117, 13.627787462194078, 0),
  ZonePoint(52.44404782370682, 13.627983333330178, 0),
  ZonePoint(52.44409727668117, 13.628179204471161, 0)
}
zonePortal1927.OriginalPoint = ZonePoint(52.44421666666667, 13.627983333333333, 0)
zonePortal1927.Media = zmediaNebel
zonePortal1927.Icon = zmediaNebel_32
zonePortal1927_ = Wherigo.Zone(cartMighlaTeil1v3)
zonePortal1927_.Id = "435754d65bc5d07d61358644db44a0c1"
zonePortal1927_.Name = "Portal 1927_"
zonePortal1927_.DistanceRangeUOM = "Meters"
zonePortal1927_.ProximityRangeUOM = "Meters"
zonePortal1927_.ShowObjects = "OnEnter"
zonePortal1927_.OutOfRangeName = ""
zonePortal1927_.InRangeName = ""
zonePortal1927_.Description = ""
zonePortal1927_.Visible = true
zonePortal1927_.AllowSetPositionTo = false
zonePortal1927_.Active = false
zonePortal1927_.DistanceRange = Distance(-1, "meters")
zonePortal1927_.ProximityRange = Distance(0, "meters")
zonePortal1927_.Points = {
  ZonePoint(52.4442074512032, 13.628553299433673, 0),
  ZonePoint(52.44445310959885, 13.628386360076139, 0),
  ZonePoint(52.44455486460552, 13.627983333332926, 0),
  ZonePoint(52.44445310959885, 13.627580306593172, 0),
  ZonePoint(52.4442074512032, 13.62741336724083, 0),
  ZonePoint(52.44396179272113, 13.627580306300459, 0),
  ZonePoint(52.4438600376219, 13.627983333332926, 0),
  ZonePoint(52.44396179272113, 13.628386360367935, 0)
}
zonePortal1927_.OriginalPoint = ZonePoint(52.44421666666667, 13.627983333333333, 0)
zonePortal1927_.Media = zmediaNebel
zonePortal1927_.Icon = zmediaNebel_32
zonePortalGegenwart = Wherigo.Zone(cartMighlaTeil1v3)
zonePortalGegenwart.Id = "414ab68cf705adca55de344e10576919"
zonePortalGegenwart.Name = "Portal Gegenwart"
zonePortalGegenwart.DistanceRangeUOM = "Meters"
zonePortalGegenwart.ProximityRangeUOM = "Meters"
zonePortalGegenwart.ShowObjects = "OnEnter"
zonePortalGegenwart.OutOfRangeName = ""
zonePortalGegenwart.InRangeName = ""
zonePortalGegenwart.Description = ""
zonePortalGegenwart.Visible = true
zonePortalGegenwart.AllowSetPositionTo = false
zonePortalGegenwart.Active = false
zonePortalGegenwart.DistanceRange = Distance(-1, "meters")
zonePortalGegenwart.ProximityRange = Distance(0, "meters")
zonePortalGegenwart.Points = {
  ZonePoint(52.426134420304834, 13.63084485455794, 0),
  ZonePoint(52.42621529549637, 13.63078991764362, 0),
  ZonePoint(52.42624879508875, 13.630657288361855, 0),
  ZonePoint(52.42621529549637, 13.630524659077649, 0),
  ZonePoint(52.426134420304834, 13.630469722164241, 0),
  ZonePoint(52.426053545085594, 13.63052465898442, 0),
  ZonePoint(52.42602004546413, 13.630657288361855, 0),
  ZonePoint(52.426053545085594, 13.630789917736543, 0)
}
zonePortalGegenwart.OriginalPoint = ZonePoint(52.42613333333333, 13.63065, 0)
zonePortalGegenwart.Media = zmediaNebel
zonePortalGegenwart.Icon = zmediaNebel_32
zonePortalGegenwart_ = Wherigo.Zone(cartMighlaTeil1v3)
zonePortalGegenwart_.Id = "621ad217fe2ba398209e405a9c89a8cb"
zonePortalGegenwart_.Name = "Portal Gegenwart_"
zonePortalGegenwart_.DistanceRangeUOM = "Meters"
zonePortalGegenwart_.ProximityRangeUOM = "Meters"
zonePortalGegenwart_.ShowObjects = "OnEnter"
zonePortalGegenwart_.OutOfRangeName = ""
zonePortalGegenwart_.InRangeName = ""
zonePortalGegenwart_.Description = ""
zonePortalGegenwart_.Visible = true
zonePortalGegenwart_.AllowSetPositionTo = false
zonePortalGegenwart_.Active = false
zonePortalGegenwart_.DistanceRange = Distance(-1, "meters")
zonePortalGegenwart_.ProximityRange = Distance(0, "meters")
zonePortalGegenwart_.Points = {
  ZonePoint(52.426132149641106, 13.631037109891086, 0),
  ZonePoint(52.42629592188183, 13.630925862576085, 0),
  ZonePoint(52.426363758533995, 13.630657288361652, 0),
  ZonePoint(52.42629592188183, 13.630388714146202, 0),
  ZonePoint(52.426132149641106, 13.630277466829876, 0),
  ZonePoint(52.4259683773001, 13.630388713812268, 0),
  ZonePoint(52.425900540544305, 13.630657288361652, 0),
  ZonePoint(52.4259683773001, 13.630925862909304, 0)
}
zonePortalGegenwart_.OriginalPoint = ZonePoint(52.42613333333333, 13.63065, 0)
zonePortalGegenwart_.Media = zmediaRbezahl_neu
zonePortalGegenwart_.Icon = zmediaRbezahl_neu_32
zoneSchliessfach = Wherigo.Zone(cartMighlaTeil1v3)
zoneSchliessfach.Id = "c2c267b9f9dcb9c2ba4901372f5a2fff"
zoneSchliessfach.Name = "Schliessfach"
zoneSchliessfach.DistanceRangeUOM = "Meters"
zoneSchliessfach.ProximityRangeUOM = "Meters"
zoneSchliessfach.ShowObjects = "OnEnter"
zoneSchliessfach.OutOfRangeName = ""
zoneSchliessfach.InRangeName = ""
zoneSchliessfach.Description = ""
zoneSchliessfach.Visible = true
zoneSchliessfach.AllowSetPositionTo = false
zoneSchliessfach.Active = false
zoneSchliessfach.DistanceRange = Distance(-1, "meters")
zoneSchliessfach.ProximityRange = Distance(0, "meters")
zoneSchliessfach.Points = {
  ZonePoint(52.444327703942605, 13.62499175754246, 0),
  ZonePoint(52.44439598543678, 13.624945356128137, 0),
  ZonePoint(52.44442426855116, 13.624833333331004, 0),
  ZonePoint(52.44439598543678, 13.624721310533872, 0),
  ZonePoint(52.444327703942605, 13.62467490912016, 0),
  ZonePoint(52.44425942242421, 13.624721310458455, 0),
  ZonePoint(52.44423113928699, 13.624833333331004, 0),
  ZonePoint(52.44425942242421, 13.624945356203554, 0)
}
zoneSchliessfach.OriginalPoint = ZonePoint(52.44433333333333, 13.624833333333333, 0)
zoneSchliessfach.Media = zmediaSchliessfach
zoneSchliessfach.Icon = zmediaSchliessfach_32
zoneSchliessfach_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneSchliessfach_.Id = "f641006b8afe3ef62852fa44641da729"
zoneSchliessfach_.Name = "Schliessfach_"
zoneSchliessfach_.DistanceRangeUOM = "Meters"
zoneSchliessfach_.ProximityRangeUOM = "Meters"
zoneSchliessfach_.ShowObjects = "OnEnter"
zoneSchliessfach_.OutOfRangeName = ""
zoneSchliessfach_.InRangeName = ""
zoneSchliessfach_.Description = ""
zoneSchliessfach_.Visible = true
zoneSchliessfach_.AllowSetPositionTo = false
zoneSchliessfach_.Active = false
zoneSchliessfach_.DistanceRange = Distance(-1, "meters")
zoneSchliessfach_.ProximityRange = Distance(0, "meters")
zoneSchliessfach_.Points = {
  ZonePoint(52.44433333341115, 13.625101626169753, 0),
  ZonePoint(52.44444896870257, 13.625023044889694, 0),
  ZonePoint(52.44449686638589, 13.624833333332633, 0),
  ZonePoint(52.44444896870257, 13.624643621776997, 0),
  ZonePoint(52.44433333341115, 13.624565040495817, 0),
  ZonePoint(52.44421769804183, 13.624643621521738, 0),
  ZonePoint(52.44416980028061, 13.624833333332633, 0),
  ZonePoint(52.44421769804183, 13.625023045144953, 0)
}
zoneSchliessfach_.OriginalPoint = ZonePoint(52.44433333333333, 13.624833333333333, 0)
zoneSchliessfach_.Media = zmediaSchliessfach
zoneSchliessfach_.Icon = zmediaSchliessfach_32
zoneSchutzhtte = Wherigo.Zone(cartMighlaTeil1v3)
zoneSchutzhtte.Id = "462f0b40d74be310732b30a7ad0362fc"
zoneSchutzhtte.Name = WWB_multiplatform_string("Schutzh\195\188tte")
zoneSchutzhtte.DistanceRangeUOM = "Meters"
zoneSchutzhtte.ProximityRangeUOM = "Meters"
zoneSchutzhtte.ShowObjects = "OnEnter"
zoneSchutzhtte.OutOfRangeName = ""
zoneSchutzhtte.InRangeName = ""
zoneSchutzhtte.Description = ""
zoneSchutzhtte.Visible = false
zoneSchutzhtte.AllowSetPositionTo = false
zoneSchutzhtte.Active = false
zoneSchutzhtte.DistanceRange = Distance(-1, "meters")
zoneSchutzhtte.ProximityRange = Distance(20, "meters")
zoneSchutzhtte.Points = {
  ZonePoint(52.429166666684075, 13.623235272405156, 0),
  ZonePoint(52.4292321755903, 13.623190770449842, 0),
  ZonePoint(52.4292593102625, 13.623083333335128, 0),
  ZonePoint(52.4292321755903, 13.622975896215529, 0),
  ZonePoint(52.429166666684075, 13.622931394261029, 0),
  ZonePoint(52.42910115775803, 13.622975896152528, 0),
  ZonePoint(52.429074023066605, 13.623083333335128, 0),
  ZonePoint(52.42910115775803, 13.623190770513352, 0)
}
zoneSchutzhtte.OriginalPoint = ZonePoint(52.42916666666667, 13.623083333333334, 0)
zoneSchutzhtte.Media = zmediaSchutzhtte
zoneSchutzhtte.Icon = zmediaSchutzhtte_32
zoneSchutzhtte_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneSchutzhtte_.Id = "484921c5dbf412e5bff42214a5800113"
zoneSchutzhtte_.Name = WWB_multiplatform_string("Schutzh\195\188tte_")
zoneSchutzhtte_.DistanceRangeUOM = "Meters"
zoneSchutzhtte_.ProximityRangeUOM = "Meters"
zoneSchutzhtte_.ShowObjects = "OnEnter"
zoneSchutzhtte_.OutOfRangeName = ""
zoneSchutzhtte_.InRangeName = ""
zoneSchutzhtte_.Description = ""
zoneSchutzhtte_.Visible = true
zoneSchutzhtte_.AllowSetPositionTo = false
zoneSchutzhtte_.Active = false
zoneSchutzhtte_.DistanceRange = Distance(-1, "meters")
zoneSchutzhtte_.ProximityRange = Distance(0, "meters")
zoneSchutzhtte_.Points = {
  ZonePoint(52.42916666673402, 13.623336565119152, 0),
  ZonePoint(52.42927584822724, 13.623262395136226, 0),
  ZonePoint(52.429321072662745, 13.623083333334009, 0),
  ZonePoint(52.42927584822724, 13.622904271530466, 0),
  ZonePoint(52.42916666673402, 13.622830101547338, 0),
  ZonePoint(52.429057485172834, 13.622904271308387, 0),
  ZonePoint(52.42901226066952, 13.623083333334009, 0),
  ZonePoint(52.429057485172834, 13.623262395358001, 0)
}
zoneSchutzhtte_.OriginalPoint = ZonePoint(52.42916666666667, 13.623083333333334, 0)
zoneSchutzhtte_.Media = zmediaSchutzhtte
zoneSchutzhtte_.Icon = zmediaSchutzhtte_32
zoneSeglerheim = Wherigo.Zone(cartMighlaTeil1v3)
zoneSeglerheim.Id = "d7a3a7a3681eab4cd7c951aaff141dc5"
zoneSeglerheim.Name = "Seglerheim"
zoneSeglerheim.DistanceRangeUOM = "Meters"
zoneSeglerheim.ProximityRangeUOM = "Meters"
zoneSeglerheim.ShowObjects = "OnEnter"
zoneSeglerheim.OutOfRangeName = ""
zoneSeglerheim.InRangeName = ""
zoneSeglerheim.Description = ""
zoneSeglerheim.Visible = false
zoneSeglerheim.AllowSetPositionTo = false
zoneSeglerheim.Active = false
zoneSeglerheim.DistanceRange = Distance(-1, "meters")
zoneSeglerheim.ProximityRange = Distance(0, "meters")
zoneSeglerheim.Points = {
  ZonePoint(52.44290000001791, 13.62345198642985, 0),
  ZonePoint(52.4429655089248, 13.623407470605587, 0),
  ZonePoint(52.44299264359705, 13.623299999999682, 0),
  ZonePoint(52.4429655089248, 13.62319252939612, 0),
  ZonePoint(52.44290000001791, 13.623148013569311, 0),
  ZonePoint(52.44283449109197, 13.623192529335357, 0),
  ZonePoint(52.442807356401175, 13.623299999999682, 0),
  ZonePoint(52.44283449109197, 13.623407470666857, 0)
}
zoneSeglerheim.OriginalPoint = ZonePoint(52.4429, 13.6233, 0)
zoneSeglerheim.Media = zmediaSeglerheim
zoneSeglerheim.Icon = zmediaSeglerheim_32
zoneSeglerheim_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneSeglerheim_.Id = "fb682a1b8860fde3d39952d4667b13d5"
zoneSeglerheim_.Name = "Seglerheim_"
zoneSeglerheim_.DistanceRangeUOM = "Meters"
zoneSeglerheim_.ProximityRangeUOM = "Meters"
zoneSeglerheim_.ShowObjects = "Always"
zoneSeglerheim_.OutOfRangeName = ""
zoneSeglerheim_.InRangeName = ""
zoneSeglerheim_.Description = ""
zoneSeglerheim_.Visible = true
zoneSeglerheim_.AllowSetPositionTo = false
zoneSeglerheim_.Active = false
zoneSeglerheim_.DistanceRange = Distance(-1, "meters")
zoneSeglerheim_.ProximityRange = Distance(0, "meters")
zoneSeglerheim_.Points = {
  ZonePoint(52.44290000007125, 13.62355331071856, 0),
  ZonePoint(52.44300918156277, 13.623479117611222, 0),
  ZonePoint(52.44305440599654, 13.623299999998157, 0),
  ZonePoint(52.44300918156277, 13.623120882389161, 0),
  ZonePoint(52.44290000007125, 13.623046689281619, 0),
  ZonePoint(52.44279081850874, 13.623120882155582, 0),
  ZonePoint(52.44274559400349, 13.623299999998157, 0),
  ZonePoint(52.44279081850874, 13.6234791178448, 0)
}
zoneSeglerheim_.OriginalPoint = ZonePoint(52.4429, 13.6233, 0)
zoneSeglerheim_.Media = zmediaSeglerheim
zoneSeglerheim_.Icon = zmediaSeglerheim_32
zoneSpreetunnelEingang = Wherigo.Zone(cartMighlaTeil1v3)
zoneSpreetunnelEingang.Id = "c96d375ef11ddc37182196e2e4239154"
zoneSpreetunnelEingang.Name = "Spreetunnel Eingang"
zoneSpreetunnelEingang.DistanceRangeUOM = "Meters"
zoneSpreetunnelEingang.ProximityRangeUOM = "Meters"
zoneSpreetunnelEingang.ShowObjects = "OnEnter"
zoneSpreetunnelEingang.OutOfRangeName = ""
zoneSpreetunnelEingang.InRangeName = ""
zoneSpreetunnelEingang.Description = ""
zoneSpreetunnelEingang.Visible = true
zoneSpreetunnelEingang.AllowSetPositionTo = false
zoneSpreetunnelEingang.Active = false
zoneSpreetunnelEingang.DistanceRange = Distance(-1, "meters")
zoneSpreetunnelEingang.ProximityRange = Distance(0, "meters")
zoneSpreetunnelEingang.Points = {
  ZonePoint(52.44490000002742, 13.62651597372911, 0),
  ZonePoint(52.445007451013836, 13.626442953335841, 0),
  ZonePoint(52.44505195866139, 13.626266666665797, 0),
  ZonePoint(52.445007451013836, 13.626090379996976, 0),
  ZonePoint(52.44490000002742, 13.626017359604523, 0),
  ZonePoint(52.44479254901368, 13.626090379906902, 0),
  ZonePoint(52.44474804133828, 13.626266666665797, 0),
  ZonePoint(52.44479254901368, 13.626442953426423, 0)
}
zoneSpreetunnelEingang.OriginalPoint = ZonePoint(52.4449, 13.626266666666666, 0)
zoneSpreetunnelEingang.Media = zmediaSpreetunnelMP
zoneSpreetunnelEingang.Icon = zmediaSpreetunnelMP_32
zoneSpreetunnelEingang_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneSpreetunnelEingang_.Id = "97cc76a96a3204fc3e65305cda34ae51"
zoneSpreetunnelEingang_.Name = "Spreetunnel Eingang_"
zoneSpreetunnelEingang_.DistanceRangeUOM = "Meters"
zoneSpreetunnelEingang_.ProximityRangeUOM = "Meters"
zoneSpreetunnelEingang_.ShowObjects = "OnEnter"
zoneSpreetunnelEingang_.OutOfRangeName = ""
zoneSpreetunnelEingang_.InRangeName = ""
zoneSpreetunnelEingang_.Description = ""
zoneSpreetunnelEingang_.Visible = true
zoneSpreetunnelEingang_.AllowSetPositionTo = false
zoneSpreetunnelEingang_.Active = false
zoneSpreetunnelEingang_.DistanceRange = Distance(-1, "meters")
zoneSpreetunnelEingang_.ProximityRange = Distance(0, "meters")
zoneSpreetunnelEingang_.Points = {
  ZonePoint(52.44490000007868, 13.626787905798727, 0),
  ZonePoint(52.445124653389165, 13.62663523825812, 0),
  ZonePoint(52.445217707808716, 13.62626666666651, 0),
  ZonePoint(52.445124653389165, 13.62589809507419, 0),
  ZonePoint(52.44490000007868, 13.625745427533888, 0),
  ZonePoint(52.44467534668927, 13.625898094807633, 0),
  ZonePoint(52.44458229218536, 13.62626666666651, 0),
  ZonePoint(52.44467534668927, 13.62663523852549, 0)
}
zoneSpreetunnelEingang_.OriginalPoint = ZonePoint(52.4449, 13.626266666666666, 0)
zoneSpreetunnelEingang_.Media = zmediaSpreetunnelMP
zoneSpreetunnelEingang_.Icon = zmediaSpreetunnelMP_32
zoneStartzone = Wherigo.Zone(cartMighlaTeil1v3)
zoneStartzone.Id = "0f82016a68f7be774766fae62e3efd70"
zoneStartzone.Name = "Startzone"
zoneStartzone.DistanceRangeUOM = "Meters"
zoneStartzone.ProximityRangeUOM = "Meters"
zoneStartzone.ShowObjects = "OnEnter"
zoneStartzone.OutOfRangeName = ""
zoneStartzone.InRangeName = ""
zoneStartzone.Description = ""
zoneStartzone.Visible = true
zoneStartzone.AllowSetPositionTo = false
zoneStartzone.Active = false
zoneStartzone.DistanceRange = Distance(-1, "meters")
zoneStartzone.ProximityRange = Distance(0, "meters")
zoneStartzone.Points = {
  ZonePoint(52.446247340293084, 13.62480424564694, 0),
  ZonePoint(52.44634560365738, 13.624737466843593, 0),
  ZonePoint(52.44638630566978, 13.624576248682272, 0),
  ZonePoint(52.44634560365738, 13.624415030518817, 0),
  ZonePoint(52.44624734029253, 13.624348251715467, 0),
  ZonePoint(52.44614907691019, 13.624415030456325, 0),
  ZonePoint(52.44610837487607, 13.624576248682272, 0),
  ZonePoint(52.44614907691019, 13.624737466906694, 0)
}
zoneStartzone.OriginalPoint = ZonePoint(52.4462428238135, 13.62457624867758, 0)
zoneStartzone.Media = zmediaBrauerei
zoneStartzone.Icon = zmediaBrauerei_32
zoneStartzone_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneStartzone_.Id = "f7269298dd31170ae4493ccc97bb8138"
zoneStartzone_.Name = "Startzone_"
zoneStartzone_.DistanceRangeUOM = "Meters"
zoneStartzone_.ProximityRangeUOM = "Meters"
zoneStartzone_.ShowObjects = "OnEnter"
zoneStartzone_.OutOfRangeName = ""
zoneStartzone_.InRangeName = ""
zoneStartzone_.Description = ""
zoneStartzone_.Visible = true
zoneStartzone_.AllowSetPositionTo = false
zoneStartzone_.Active = false
zoneStartzone_.DistanceRange = Distance(-1, "meters")
zoneStartzone_.ProximityRange = Distance(0, "meters")
zoneStartzone_.Points = {
  ZonePoint(52.446229745328466, 13.625052082186443, 0),
  ZonePoint(52.44642557472918, 13.62491899844545, 0),
  ZonePoint(52.44650668990225, 13.624597706348883, 0),
  ZonePoint(52.44642557472918, 13.624276414255165, 0),
  ZonePoint(52.446229745328466, 13.624143330513052, 0),
  ZonePoint(52.44603391583668, 13.624276413972936, 0),
  ZonePoint(52.445952800581196, 13.624597706348883, 0),
  ZonePoint(52.44603391583668, 13.62491899872768, 0)
}
zoneStartzone_.OriginalPoint = ZonePoint(52.44622974524202, 13.624597706349698, 0)
zoneStartzone_.Media = zmediaBrauerei
zoneStartzone_.Icon = zmediaBrauerei_32
zoneTeppich = Wherigo.Zone(cartMighlaTeil1v3)
zoneTeppich.Id = "2cba08528660bdb69a32e1701ba7a1fc"
zoneTeppich.Name = "Teppich"
zoneTeppich.DistanceRangeUOM = "Meters"
zoneTeppich.ProximityRangeUOM = "Meters"
zoneTeppich.ShowObjects = "OnEnter"
zoneTeppich.OutOfRangeName = ""
zoneTeppich.InRangeName = ""
zoneTeppich.Description = ""
zoneTeppich.Visible = true
zoneTeppich.AllowSetPositionTo = false
zoneTeppich.Active = false
zoneTeppich.DistanceRange = Distance(-1, "meters")
zoneTeppich.ProximityRange = Distance(0, "meters")
zoneTeppich.Points = {
  ZonePoint(52.44370000001356, 13.621968876876293, 0),
  ZonePoint(52.44377278769115, 13.621919413962013, 0),
  ZonePoint(52.443802937330204, 13.62180000000047, 0),
  ZonePoint(52.44377278769115, 13.621680586037295, 0),
  ZonePoint(52.44370000001356, 13.621631123122812, 0),
  ZonePoint(52.4436272123217, 13.62168058599007, 0),
  ZonePoint(52.44359706266804, 13.62180000000047, 0),
  ZonePoint(52.4436272123217, 13.621919414009238, 0)
}
zoneTeppich.OriginalPoint = ZonePoint(52.4437, 13.6218, 0)
zoneTeppich.Media = zmediaTeppich
zoneTeppich.Icon = zmediaTeppich_32
zoneTeppich_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneTeppich_.Id = "e31e478d3eddcfe9e0b6ffd03f5a3723"
zoneTeppich_.Name = "Teppich_"
zoneTeppich_.DistanceRangeUOM = "Meters"
zoneTeppich_.ProximityRangeUOM = "Meters"
zoneTeppich_.ShowObjects = "OnEnter"
zoneTeppich_.OutOfRangeName = ""
zoneTeppich_.InRangeName = ""
zoneTeppich_.Description = ""
zoneTeppich_.Visible = true
zoneTeppich_.AllowSetPositionTo = false
zoneTeppich_.Active = false
zoneTeppich_.DistanceRange = Distance(-1, "meters")
zoneTeppich_.ProximityRange = Distance(0, "meters")
zoneTeppich_.Points = {
  ZonePoint(52.44370000004857, 13.622112734960512, 0),
  ZonePoint(52.443834792032746, 13.622021136930252, 0),
  ZonePoint(52.44389062468634, 13.621799999999858, 0),
  ZonePoint(52.443834792032746, 13.621578863070075, 0),
  ZonePoint(52.44370000004857, 13.621487265038288, 0),
  ZonePoint(52.443565208015045, 13.621578862906926, 0),
  ZonePoint(52.44350937531197, 13.621799999999858, 0),
  ZonePoint(52.443565208015045, 13.622021137092384, 0)
}
zoneTeppich_.OriginalPoint = ZonePoint(52.4437, 13.6218, 0)
zoneTeppich_.Media = zmediaTeppich
zoneTeppich_.Icon = zmediaTeppich_32
zoneTreppezumBiergarten = Wherigo.Zone(cartMighlaTeil1v3)
zoneTreppezumBiergarten.Id = "51ddb70d20f9ac2157d7fd6b53426228"
zoneTreppezumBiergarten.Name = "Treppe zum Biergarten"
zoneTreppezumBiergarten.DistanceRangeUOM = "Meters"
zoneTreppezumBiergarten.ProximityRangeUOM = "Meters"
zoneTreppezumBiergarten.ShowObjects = "OnEnter"
zoneTreppezumBiergarten.OutOfRangeName = ""
zoneTreppezumBiergarten.InRangeName = ""
zoneTreppezumBiergarten.Description = ""
zoneTreppezumBiergarten.Visible = true
zoneTreppezumBiergarten.AllowSetPositionTo = false
zoneTreppezumBiergarten.Active = false
zoneTreppezumBiergarten.DistanceRange = Distance(-1, "meters")
zoneTreppezumBiergarten.ProximityRange = Distance(0, "meters")
zoneTreppezumBiergarten.Points = {
  ZonePoint(52.44418333335635, 13.624666202003434, 0),
  ZonePoint(52.44425496734498, 13.624617522529288, 0),
  ZonePoint(52.444284639108965, 13.624500000002087, 0),
  ZonePoint(52.44425496734498, 13.624382477469593, 0),
  ZonePoint(52.44418333335635, 13.624333797995241, 0),
  ZonePoint(52.444111699344646, 13.624382477398756, 0),
  ZonePoint(52.44408202755992, 13.624500000002087, 0),
  ZonePoint(52.444111699344646, 13.624617522600328, 0)
}
zoneTreppezumBiergarten.OriginalPoint = ZonePoint(52.444183333333335, 13.6245, 0)
zoneTreppezumBiergarten.Media = zmediaBlumenverkauf
zoneTreppezumBiergarten.Icon = zmediaBlumenverkauf_32
zoneTreppezumBiergarten_ = Wherigo.Zone(cartMighlaTeil1v3)
zoneTreppezumBiergarten_.Id = "372310e9754fa0d37625c3a1c14386d4"
zoneTreppezumBiergarten_.Name = "Treppe zum Biergarten_"
zoneTreppezumBiergarten_.DistanceRangeUOM = "Meters"
zoneTreppezumBiergarten_.ProximityRangeUOM = "Meters"
zoneTreppezumBiergarten_.ShowObjects = "OnEnter"
zoneTreppezumBiergarten_.OutOfRangeName = ""
zoneTreppezumBiergarten_.InRangeName = ""
zoneTreppezumBiergarten_.Description = ""
zoneTreppezumBiergarten_.Visible = true
zoneTreppezumBiergarten_.AllowSetPositionTo = false
zoneTreppezumBiergarten_.Active = false
zoneTreppezumBiergarten_.DistanceRange = Distance(-1, "meters")
zoneTreppezumBiergarten_.ProximityRange = Distance(0, "meters")
zoneTreppezumBiergarten_.Points = {
  ZonePoint(52.4441833334198, 13.624807781488103, 0),
  ZonePoint(52.444315988931976, 13.624717634235038, 0),
  ZonePoint(52.44437093661877, 13.624500000000255, 0),
  ZonePoint(52.444315988931976, 13.624282365764351, 0),
  ZonePoint(52.4441833334198, 13.624192218510064, 0),
  ZonePoint(52.44405067782104, 13.624282365480392, 0),
  ZonePoint(52.443995730047085, 13.624500000000255, 0),
  ZonePoint(52.44405067782104, 13.624717634518591, 0)
}
zoneTreppezumBiergarten_.OriginalPoint = ZonePoint(52.444183333333335, 13.6245, 0)
zoneTreppezumBiergarten_.Media = zmediaBlumenverkauf
zoneTreppezumBiergarten_.Icon = zmediaBlumenverkauf_32
zonebergabeKalle = Wherigo.Zone(cartMighlaTeil1v3)
zonebergabeKalle.Id = "cae12ffef0dff96de02b55fb2967710c"
zonebergabeKalle.Name = WWB_multiplatform_string("\195\156bergabe Kalle")
zonebergabeKalle.DistanceRangeUOM = "Meters"
zonebergabeKalle.ProximityRangeUOM = "Meters"
zonebergabeKalle.ShowObjects = "OnEnter"
zonebergabeKalle.OutOfRangeName = ""
zonebergabeKalle.InRangeName = ""
zonebergabeKalle.Description = ""
zonebergabeKalle.Visible = true
zonebergabeKalle.AllowSetPositionTo = false
zonebergabeKalle.Active = false
zonebergabeKalle.DistanceRange = Distance(-1, "meters")
zonebergabeKalle.ProximityRange = Distance(0, "meters")
zonebergabeKalle.Points = {
  ZonePoint(52.442200000028265, 13.622568650683213, 0),
  ZonePoint(52.44226550893015, 13.622524135548495, 0),
  ZonePoint(52.44229264359764, 13.622416666666503, 0),
  ZonePoint(52.44226550893015, 13.622309197785528, 0),
  ZonePoint(52.442200000028265, 13.622264682650199, 0),
  ZonePoint(52.44213449109756, 13.62230919769169, 0),
  ZonePoint(52.442107356401685, 13.622416666666503, 0),
  ZonePoint(52.44213449109756, 13.62252413564254, 0)
}
zonebergabeKalle.OriginalPoint = ZonePoint(52.4422, 13.622416666666666, 0)
zonebergabeKalle.Media = zmediaKallebergabe
zonebergabeKalle.Icon = zmediaKallebergabe_32
zonebergabeKalle_ = Wherigo.Zone(cartMighlaTeil1v3)
zonebergabeKalle_.Id = "365bc4c731e61f853988436280c390fc"
zonebergabeKalle_.Name = WWB_multiplatform_string("\195\156bergabe Kalle_")
zonebergabeKalle_.DistanceRangeUOM = "Meters"
zonebergabeKalle_.ProximityRangeUOM = "Meters"
zonebergabeKalle_.ShowObjects = "OnEnter"
zonebergabeKalle_.OutOfRangeName = ""
zonebergabeKalle_.InRangeName = ""
zonebergabeKalle_.Description = ""
zonebergabeKalle_.Visible = true
zonebergabeKalle_.AllowSetPositionTo = false
zonebergabeKalle_.Active = false
zonebergabeKalle_.DistanceRange = Distance(-1, "meters")
zonebergabeKalle_.ProximityRange = Distance(0, "meters")
zonebergabeKalle_.Points = {
  ZonePoint(52.44219769363375, 13.62266595837715, 0),
  ZonePoint(52.44230514458274, 13.62259294235656, 0),
  ZonePoint(52.44234965219328, 13.622416666667013, 0),
  ZonePoint(52.44230514458274, 13.62224039097767, 0),
  ZonePoint(52.44219769363375, 13.622167374957181, 0),
  ZonePoint(52.44209024258247, 13.62224039063997, 0),
  ZonePoint(52.44204573486863, 13.622416666667013, 0),
  ZonePoint(52.44209024258247, 13.622592942693952, 0)
}
zonebergabeKalle_.OriginalPoint = ZonePoint(52.4422, 13.622416666666666, 0)
zonebergabeKalle_.Media = zmediaKallebergabe
zonebergabeKalle_.Icon = zmediaKallebergabe_32
zcharacterBlumenfrau = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneTreppezumBiergarten_})
zcharacterBlumenfrau.Id = "4e1a8ab4ee5dc9a593960f94cdccaa79"
zcharacterBlumenfrau.Name = "Blumenfrau"
zcharacterBlumenfrau.Gender = "Female"
zcharacterBlumenfrau.Type = "NPC"
zcharacterBlumenfrau.Description = ""
zcharacterBlumenfrau.Visible = false
zcharacterBlumenfrau.ObjectLocation = ZonePoint(52.4358638783634, 13.532229959964752, 0)
zcharacterBlumenfrau.Media = zmediaBlumenfrau
zcharacterBlumenfrau.Icon = zmediaBlumenfrau_32
zcharacterBlumenfrau.Commands = {
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Nelkenehmen = Wherigo.ZCommand({
    Text = "Nelke nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  nochmalsansprechen = Wherigo.ZCommand({
    Text = "nochmals ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schuldbegleichen = Wherigo.ZCommand({
    Text = "Schuld begleichen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterBlumenfrau.Commands.ansprechen.Id = "228c7fb53d03586873f81561bd962b4d"
zcharacterBlumenfrau.Commands.ansprechen.Custom = true
zcharacterBlumenfrau.Commands.ansprechen.WorksWithAll = true
zcharacterBlumenfrau.Commands.Nelkenehmen.Id = "b697638aa98606a67cfdd3e6fc4a9cfb"
zcharacterBlumenfrau.Commands.Nelkenehmen.Custom = true
zcharacterBlumenfrau.Commands.Nelkenehmen.WorksWithAll = true
zcharacterBlumenfrau.Commands.nochmalsansprechen.Id = "a84b3c873f197f78e88f21cc23f76de7"
zcharacterBlumenfrau.Commands.nochmalsansprechen.Custom = true
zcharacterBlumenfrau.Commands.nochmalsansprechen.WorksWithAll = true
zcharacterBlumenfrau.Commands.Schuldbegleichen.Id = "5f8a28ef12b3735b8f119860ed9ac292"
zcharacterBlumenfrau.Commands.Schuldbegleichen.Custom = true
zcharacterBlumenfrau.Commands.Schuldbegleichen.WorksWithAll = true
zcharacterKapitn = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneSeglerheim_})
zcharacterKapitn.Id = "4526ec2788a493b28b54f88922b59bd2"
zcharacterKapitn.Name = WWB_multiplatform_string("Kapit\195\164n")
zcharacterKapitn.Gender = "Male"
zcharacterKapitn.Type = "NPC"
zcharacterKapitn.Description = ""
zcharacterKapitn.Visible = true
zcharacterKapitn.ObjectLocation = ZonePoint(52.43530958691832, 13.531358242034896, 0)
zcharacterKapitn.Media = zmediaKapitn
zcharacterKapitn.Icon = zmediaKapitn_32
zcharacterKapitn.Commands = {
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Antwort = Wherigo.ZCommand({
    Text = "Antwort",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  BriefFotonehemn = Wherigo.ZCommand({
    Text = "Brief + Foto nehemn",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Hallo = Wherigo.ZCommand({
    Text = "Hallo....",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterKapitn.Commands.ansprechen.Id = "28e879d896da5fbb54f2369e50d4076d"
zcharacterKapitn.Commands.ansprechen.Custom = true
zcharacterKapitn.Commands.ansprechen.WorksWithAll = true
zcharacterKapitn.Commands.Antwort.Id = "e617359da5620ebd5a3ecf0374c12245"
zcharacterKapitn.Commands.Antwort.Custom = true
zcharacterKapitn.Commands.Antwort.WorksWithAll = true
zcharacterKapitn.Commands.BriefFotonehemn.Id = "a6802db1707f510e7b7f6cd2b396dad5"
zcharacterKapitn.Commands.BriefFotonehemn.Custom = true
zcharacterKapitn.Commands.BriefFotonehemn.WorksWithAll = true
zcharacterKapitn.Commands.Hallo.Id = "60ba86c873f37727a046694172ce8a65"
zcharacterKapitn.Commands.Hallo.Custom = true
zcharacterKapitn.Commands.Hallo.WorksWithAll = true
zcharacterKellnerin = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneBiergarten_})
zcharacterKellnerin.Id = "49987de7c01ef7a76a6823ec74f03fa8"
zcharacterKellnerin.Name = "Kellnerin"
zcharacterKellnerin.Gender = "It"
zcharacterKellnerin.Type = "NPC"
zcharacterKellnerin.Description = ""
zcharacterKellnerin.Visible = false
zcharacterKellnerin.ObjectLocation = ZonePoint(52.43586141959995, 13.532353341579439, 0)
zcharacterKellnerin.Media = zmediaKellnerin
zcharacterKellnerin.Icon = zmediaKellnerin_32
zcharacterKellnerin.Commands = {
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Fotonehmen = Wherigo.ZCommand({
    Text = "Foto nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  JavielenDank = Wherigo.ZCommand({
    Text = "Ja, vielen Dank!",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Kellnerinrufen = Wherigo.ZCommand({
    Text = "Kellnerin rufen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterKellnerin.Commands.ansprechen.Id = "03fb9ceb77ef316712e1ff11102658a8"
zcharacterKellnerin.Commands.ansprechen.Custom = true
zcharacterKellnerin.Commands.ansprechen.WorksWithAll = true
zcharacterKellnerin.Commands.Fotonehmen.Id = "edd417207ea3c2b13d79664b412ea4b7"
zcharacterKellnerin.Commands.Fotonehmen.Custom = true
zcharacterKellnerin.Commands.Fotonehmen.WorksWithAll = true
zcharacterKellnerin.Commands.JavielenDank.Id = "b1185d79410d63837d0f0663c244a439"
zcharacterKellnerin.Commands.JavielenDank.Custom = true
zcharacterKellnerin.Commands.JavielenDank.WorksWithAll = true
zcharacterKellnerin.Commands.Kellnerinrufen.Id = "8d92661274066ac9fd5de08191467a00"
zcharacterKellnerin.Commands.Kellnerinrufen.Custom = true
zcharacterKellnerin.Commands.Kellnerinrufen.WorksWithAll = true
zcharacterMaler = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneBedrfnisanstallt_})
zcharacterMaler.Id = "c291eadc55a2c09b53de98ea6965dfdf"
zcharacterMaler.Name = "Maler"
zcharacterMaler.Gender = "Male"
zcharacterMaler.Type = "NPC"
zcharacterMaler.Description = ""
zcharacterMaler.Visible = false
zcharacterMaler.ObjectLocation = ZonePoint(52.43400182339417, 13.515691459178942, 0)
zcharacterMaler.Media = zmediaZille
zcharacterMaler.Icon = zmediaZille_32
zcharacterMaler.Commands = {
  annehmen = Wherigo.ZCommand({
    Text = "annehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterMaler.Commands.annehmen.Id = "e48d9a23b2e9cef35e3aa4030cdc1f83"
zcharacterMaler.Commands.annehmen.Custom = true
zcharacterMaler.Commands.annehmen.WorksWithAll = true
zcharacterMaler.Commands.ansprechen.Id = "089872811779f6cb23d12f8b25575bef"
zcharacterMaler.Commands.ansprechen.Custom = true
zcharacterMaler.Commands.ansprechen.WorksWithAll = true
zcharacterMann = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneStartzone_})
zcharacterMann.Id = "8eb789f79898c71c78911c49355f189c"
zcharacterMann.Name = "Mann"
zcharacterMann.Gender = "Male"
zcharacterMann.Type = "NPC"
zcharacterMann.Description = ""
zcharacterMann.Visible = false
zcharacterMann.ObjectLocation = ZonePoint(52.43545059413764, 13.511265814304375, 0)
zcharacterMann.Media = zmediaVoigt
zcharacterMann.Icon = zmediaVoigt_32
zcharacterMann.Commands = {
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Koffernehmen = Wherigo.ZCommand({
    Text = "Koffer nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterMann.Commands.ansprechen.Id = "0a293bbd2a879b71195ed4697b0d18e6"
zcharacterMann.Commands.ansprechen.Custom = true
zcharacterMann.Commands.ansprechen.WorksWithAll = true
zcharacterMann.Commands.Koffernehmen.Id = "29fe063e7c022948bcf3d40b37d6156c"
zcharacterMann.Commands.Koffernehmen.Custom = true
zcharacterMann.Commands.Koffernehmen.WorksWithAll = true
zcharacterRettungsschwimmer = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneTeppich_})
zcharacterRettungsschwimmer.Id = "6b2ce6b03c6e3e05bf917e3b4635113c"
zcharacterRettungsschwimmer.Name = "Rettungsschwimmer"
zcharacterRettungsschwimmer.Gender = "Male"
zcharacterRettungsschwimmer.Type = "NPC"
zcharacterRettungsschwimmer.Description = ""
zcharacterRettungsschwimmer.Visible = true
zcharacterRettungsschwimmer.ObjectLocation = ZonePoint(52.43585855923034, 13.530414104461657, 0)
zcharacterRettungsschwimmer.Media = zmediaRettungsschwimmer
zcharacterRettungsschwimmer.Icon = zmediaRettungsschwimmer_32
zcharacterRettungsschwimmer.Commands = {
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterRettungsschwimmer.Commands.ansprechen.Id = "a28c8e4ada46a043c9469d938768e90f"
zcharacterRettungsschwimmer.Commands.ansprechen.Custom = true
zcharacterRettungsschwimmer.Commands.ansprechen.WorksWithAll = true
zcharacterRettungsschwimmerinMartha = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneTeppich_})
zcharacterRettungsschwimmerinMartha.Id = "36a21f54484b8693ec36696cf255353a"
zcharacterRettungsschwimmerinMartha.Name = "Rettungsschwimmerin Martha"
zcharacterRettungsschwimmerinMartha.Gender = "Female"
zcharacterRettungsschwimmerinMartha.Type = "NPC"
zcharacterRettungsschwimmerinMartha.Description = ""
zcharacterRettungsschwimmerinMartha.Visible = false
zcharacterRettungsschwimmerinMartha.ObjectLocation = ZonePoint(52.43585855923034, 13.530414104461657, 0)
zcharacterRettungsschwimmerinMartha.Media = zmediaRettungsschwimmerin
zcharacterRettungsschwimmerinMartha.Icon = zmediaRettungsschwimmerin_32
zcharacterRettungsschwimmerinMartha.Commands = {
  HalloHerrBeck = Wherigo.ZCommand({
    Text = "Hallo Herr Beck",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterRettungsschwimmerinMartha.Commands.HalloHerrBeck.Id = "4f4d0e9c6630ac17aa9a7f5a97c37a6e"
zcharacterRettungsschwimmerinMartha.Commands.HalloHerrBeck.Custom = true
zcharacterRettungsschwimmerinMartha.Commands.HalloHerrBeck.WorksWithAll = true
zcharacterSeebr = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneBiergarten_})
zcharacterSeebr.Id = "ef08ab31348380bf2d3cf34b4ee5b5b0"
zcharacterSeebr.Name = WWB_multiplatform_string("Seeb\195\164r")
zcharacterSeebr.Gender = "Male"
zcharacterSeebr.Type = "NPC"
zcharacterSeebr.Description = ""
zcharacterSeebr.Visible = false
zcharacterSeebr.ObjectLocation = ZonePoint(52.43586141959995, 13.532353341579439, 0)
zcharacterSeebr.Media = zmediaSeebr
zcharacterSeebr.Icon = zmediaSeebr_32
zcharacterSeebr.Commands = {
  Briefnehmen = Wherigo.ZCommand({
    Text = "Brief nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Gesundheit = Wherigo.ZCommand({
    Text = "Gesundheit...",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  HalloKalle = Wherigo.ZCommand({
    Text = "Hallo Kalle",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Treibgutnehmen = Wherigo.ZCommand({
    Text = "Treibgut nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterSeebr.Commands.Briefnehmen.Id = "6c166400682fbc6faebdb1692cac9bd8"
zcharacterSeebr.Commands.Briefnehmen.Custom = true
zcharacterSeebr.Commands.Briefnehmen.WorksWithAll = true
zcharacterSeebr.Commands.Gesundheit.Id = "20d1d213e26922a13884033efd0aec6b"
zcharacterSeebr.Commands.Gesundheit.Custom = true
zcharacterSeebr.Commands.Gesundheit.WorksWithAll = true
zcharacterSeebr.Commands.HalloKalle.Id = "125d4ba478d04cdecdc0a5a710d38205"
zcharacterSeebr.Commands.HalloKalle.Custom = true
zcharacterSeebr.Commands.HalloKalle.WorksWithAll = true
zcharacterSeebr.Commands.Treibgutnehmen.Id = "9e0456e7a5dffcb12633d3dd06da35cc"
zcharacterSeebr.Commands.Treibgutnehmen.Custom = true
zcharacterSeebr.Commands.Treibgutnehmen.WorksWithAll = true
zcharacterTaucher = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneLufer_})
zcharacterTaucher.Id = "93249dfa34e5e4971497541d0d558d65"
zcharacterTaucher.Name = "Taucher"
zcharacterTaucher.Gender = "Male"
zcharacterTaucher.Type = "NPC"
zcharacterTaucher.Description = ""
zcharacterTaucher.Visible = false
zcharacterTaucher.ObjectLocation = ZonePoint(52.43753691658542, 13.533788323402394, 0)
zcharacterTaucher.Media = zmediaTaucher
zcharacterTaucher.Icon = zmediaTaucher_32
zcharacterTaucher.Commands = {
  Ahoi = Wherigo.ZCommand({
    Text = "Ahoi...",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Binwiederzurck = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Bin wieder zur\195\188ck", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Informationnehmen = Wherigo.ZCommand({
    Text = "Information nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Koordinatenansagen = Wherigo.ZCommand({
    Text = "Koordinaten ansagen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  SchlossInformationen = Wherigo.ZCommand({
    Text = "Schloss Informationen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Truhenehmen = Wherigo.ZCommand({
    Text = "Truhe nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  WarenSieerfolgreich = Wherigo.ZCommand({
    Text = "Waren Sie erfolgreich?",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Zeitungnehmen = Wherigo.ZCommand({
    Text = "Zeitung nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterTaucher.Commands.Ahoi.Id = "1434a6fc9bc0453c1f2ad07f850c39c1"
zcharacterTaucher.Commands.Ahoi.Custom = true
zcharacterTaucher.Commands.Ahoi.WorksWithAll = true
zcharacterTaucher.Commands.ansprechen.Id = "66fbafdf7c163cfc9539462805564e1c"
zcharacterTaucher.Commands.ansprechen.Custom = true
zcharacterTaucher.Commands.ansprechen.WorksWithAll = true
zcharacterTaucher.Commands.Binwiederzurck.Id = "ff3a3990cafebf033e5238bea2375a40"
zcharacterTaucher.Commands.Binwiederzurck.Custom = true
zcharacterTaucher.Commands.Binwiederzurck.WorksWithAll = true
zcharacterTaucher.Commands.Informationnehmen.Id = "ba538f25966b608cb9453286ef2ed568"
zcharacterTaucher.Commands.Informationnehmen.Custom = true
zcharacterTaucher.Commands.Informationnehmen.WorksWithAll = true
zcharacterTaucher.Commands.Koordinatenansagen.Id = "b2bd33bb54dfa87b863e8f5d8b811109"
zcharacterTaucher.Commands.Koordinatenansagen.Custom = true
zcharacterTaucher.Commands.Koordinatenansagen.WorksWithAll = true
zcharacterTaucher.Commands.SchlossInformationen.Id = "96aba57aaf1284f8392200570c9c6915"
zcharacterTaucher.Commands.SchlossInformationen.Custom = true
zcharacterTaucher.Commands.SchlossInformationen.WorksWithAll = true
zcharacterTaucher.Commands.Truhenehmen.Id = "d8c0fbd4927be18811184eb55ef77f23"
zcharacterTaucher.Commands.Truhenehmen.Custom = true
zcharacterTaucher.Commands.Truhenehmen.WorksWithAll = true
zcharacterTaucher.Commands.WarenSieerfolgreich.Id = "59743e53f6a0b4249a0a60523a4f3cbd"
zcharacterTaucher.Commands.WarenSieerfolgreich.Custom = true
zcharacterTaucher.Commands.WarenSieerfolgreich.WorksWithAll = true
zcharacterTaucher.Commands.Zeitungnehmen.Id = "1f2ad5164300defef25c01dd5216bb89"
zcharacterTaucher.Commands.Zeitungnehmen.Custom = true
zcharacterTaucher.Commands.Zeitungnehmen.WorksWithAll = true
zcharacterZeitungsjunge = Wherigo.ZCharacter({Cartridge = cartMighlaTeil1v3, Container = zoneSpreetunnelEingang_})
zcharacterZeitungsjunge.Id = "3b53627b843a1352cd180645ddd3c551"
zcharacterZeitungsjunge.Name = "Zeitungsjunge"
zcharacterZeitungsjunge.Gender = "Male"
zcharacterZeitungsjunge.Type = "NPC"
zcharacterZeitungsjunge.Description = ""
zcharacterZeitungsjunge.Visible = false
zcharacterZeitungsjunge.ObjectLocation = ZonePoint(52.43248795761351, 13.51612597703934, 0)
zcharacterZeitungsjunge.Media = zmediaZeitungsjunge
zcharacterZeitungsjunge.Icon = zmediaZeitungsjunge_32
zcharacterZeitungsjunge.Commands = {
  annehmen = Wherigo.ZCommand({
    Text = "annehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterZeitungsjunge.Commands.annehmen.Id = "6ba04c4892b25dfec24126bc1f77d54f"
zcharacterZeitungsjunge.Commands.annehmen.Custom = true
zcharacterZeitungsjunge.Commands.annehmen.WorksWithAll = true
zcharacterZeitungsjunge.Commands.ansprechen.Id = "28b2d3ee1ff42385b2cecbf36a43f6ad"
zcharacterZeitungsjunge.Commands.ansprechen.Custom = true
zcharacterZeitungsjunge.Commands.ansprechen.WorksWithAll = true
zitemBrief = Wherigo.ZItem(cartMighlaTeil1v3)
zitemBrief.Id = "e1de4721693f59fdf5d0207d2b7e454a"
zitemBrief.Name = "Brief"
zitemBrief.Description = ""
zitemBrief.Visible = true
zitemBrief.Locked = false
zitemBrief.Opened = false
zitemBrief.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemBrief.Media = zmediaBriefDunnemals
zitemBrief.Icon = zmediaBriefDunnemals_32
zitemBrief.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  lesen = Wherigo.ZCommand({
    Text = "lesen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemBrief.Commands.auspacken.Id = "6ab2b95b7ea083399ac0d7c3c51a6be0"
zitemBrief.Commands.auspacken.Custom = true
zitemBrief.Commands.auspacken.WorksWithAll = true
zitemBrief.Commands.einpacken.Id = "22f1e1f805113d6c9b908857ae5b211c"
zitemBrief.Commands.einpacken.Custom = true
zitemBrief.Commands.einpacken.WorksWithAll = true
zitemBrief.Commands.lesen.Id = "e3dad7dacbb631f9cd584f7565afa0cf"
zitemBrief.Commands.lesen.Custom = true
zitemBrief.Commands.lesen.WorksWithAll = true
zitemBrief2vomVoigt = Wherigo.ZItem(cartMighlaTeil1v3)
zitemBrief2vomVoigt.Id = "c9385c49019bd621ac56ec0a048e22b9"
zitemBrief2vomVoigt.Name = "Brief 2 vom Voigt"
zitemBrief2vomVoigt.Description = ""
zitemBrief2vomVoigt.Visible = true
zitemBrief2vomVoigt.Locked = false
zitemBrief2vomVoigt.Opened = false
zitemBrief2vomVoigt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemBrief2vomVoigt.Media = zmediaBrief_Umschlagzu
zitemBrief2vomVoigt.Icon = zmediaBrief_Umschlagzu_32
zitemBrief2vomVoigt.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Briefffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Brief \195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  lesen = Wherigo.ZCommand({
    Text = "lesen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Stadtkasseherausnehmen = Wherigo.ZCommand({
    Text = "Stadtkasse herausnehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemBrief2vomVoigt.Commands.auspacken.Id = "8683f7205d957b7cc501bc3901cda760"
zitemBrief2vomVoigt.Commands.auspacken.Custom = true
zitemBrief2vomVoigt.Commands.auspacken.WorksWithAll = true
zitemBrief2vomVoigt.Commands.Briefffnen.Id = "d7ba002e3a91df05309baa42fd8897c6"
zitemBrief2vomVoigt.Commands.Briefffnen.Custom = true
zitemBrief2vomVoigt.Commands.Briefffnen.WorksWithAll = true
zitemBrief2vomVoigt.Commands.einpacken.Id = "4b9a7ac3074e205dc213464532fe7347"
zitemBrief2vomVoigt.Commands.einpacken.Custom = true
zitemBrief2vomVoigt.Commands.einpacken.WorksWithAll = true
zitemBrief2vomVoigt.Commands.lesen.Id = "460ad9c2720bdaccb0db87eaafea7551"
zitemBrief2vomVoigt.Commands.lesen.Custom = true
zitemBrief2vomVoigt.Commands.lesen.WorksWithAll = true
zitemBrief2vomVoigt.Commands.Stadtkasseherausnehmen.Id = "765bfe98678f1f5c3f691b144637ca94"
zitemBrief2vomVoigt.Commands.Stadtkasseherausnehmen.Custom = true
zitemBrief2vomVoigt.Commands.Stadtkasseherausnehmen.WorksWithAll = true
zitemBrief3vomVoigt = Wherigo.ZItem(cartMighlaTeil1v3)
zitemBrief3vomVoigt.Id = "8d856cf2f484d7cd85ebfbb60d885a6f"
zitemBrief3vomVoigt.Name = "Brief 3 vom Voigt"
zitemBrief3vomVoigt.Description = ""
zitemBrief3vomVoigt.Visible = true
zitemBrief3vomVoigt.Locked = false
zitemBrief3vomVoigt.Opened = false
zitemBrief3vomVoigt.ObjectLocation = ZonePoint(52.43530958691832, 13.531358242034896, 0)
zitemBrief3vomVoigt.Media = zmediaBrief_Umschlagzu
zitemBrief3vomVoigt.Icon = zmediaBrief_Umschlagzu_32
zitemBrief3vomVoigt.Commands = {
  entsorgen = Wherigo.ZCommand({
    Text = "entsorgen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("\195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  FotoindieBox = Wherigo.ZCommand({
    Text = "Foto in die Box",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Navigationherausnehmen = Wherigo.ZCommand({
    Text = "Navigation herausnehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemBrief3vomVoigt.Commands.entsorgen.Id = "ed2868aafd06b130c1c4722196e5bbe0"
zitemBrief3vomVoigt.Commands.entsorgen.Custom = true
zitemBrief3vomVoigt.Commands.entsorgen.WorksWithAll = true
zitemBrief3vomVoigt.Commands.ffnen.Id = "4ad66df414aac4d12445da76a7b687ff"
zitemBrief3vomVoigt.Commands.ffnen.Custom = true
zitemBrief3vomVoigt.Commands.ffnen.WorksWithAll = true
zitemBrief3vomVoigt.Commands.FotoindieBox.Id = "a6a186820a45cbd075610e0c7d8bfbb8"
zitemBrief3vomVoigt.Commands.FotoindieBox.Custom = true
zitemBrief3vomVoigt.Commands.FotoindieBox.WorksWithAll = true
zitemBrief3vomVoigt.Commands.Navigationherausnehmen.Id = "99d4bdc1f8cfc1ba9d2afb2d64bc6e5f"
zitemBrief3vomVoigt.Commands.Navigationherausnehmen.Custom = true
zitemBrief3vomVoigt.Commands.Navigationherausnehmen.WorksWithAll = true
zitemBrief4vomVoigt = Wherigo.ZItem(cartMighlaTeil1v3)
zitemBrief4vomVoigt.Id = "a1ef208504290932834da7866a3d86ee"
zitemBrief4vomVoigt.Name = "Brief 4 vom Voigt"
zitemBrief4vomVoigt.Description = ""
zitemBrief4vomVoigt.Visible = true
zitemBrief4vomVoigt.Locked = false
zitemBrief4vomVoigt.Opened = false
zitemBrief4vomVoigt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemBrief4vomVoigt.Media = zmediaNotiz
zitemBrief4vomVoigt.Icon = zmediaNotiz_32
zitemBrief4vomVoigt.Commands = {
  lesen = Wherigo.ZCommand({
    Text = "lesen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemBrief4vomVoigt.Commands.lesen.Id = "2ed7bb89e6d524f40937d1164a43c32b"
zitemBrief4vomVoigt.Commands.lesen.Custom = true
zitemBrief4vomVoigt.Commands.lesen.WorksWithAll = true
zitemBriefvomVoigt = Wherigo.ZItem(cartMighlaTeil1v3)
zitemBriefvomVoigt.Id = "d64c3b7405014045a14acf3f49909451"
zitemBriefvomVoigt.Name = "Brief vom Voigt"
zitemBriefvomVoigt.Description = WWB_multiplatform_string("\"F\195\188r Beck und nur von ihm zu \195\182ffnen!\"<BR>\n")
zitemBriefvomVoigt.Visible = true
zitemBriefvomVoigt.Locked = false
zitemBriefvomVoigt.Opened = false
zitemBriefvomVoigt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemBriefvomVoigt.Media = zmediaBrief_Umschlagzu
zitemBriefvomVoigt.Icon = zmediaBrief_Umschlagzu_32
zitemBriefvomVoigt.Commands = {
  ffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("\195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemBriefvomVoigt.Commands.ffnen.Id = "55ac24d5e69a06e9679c70d80a7531f8"
zitemBriefvomVoigt.Commands.ffnen.Custom = true
zitemBriefvomVoigt.Commands.ffnen.WorksWithAll = true
zitemDokumentenSchlssel = Wherigo.ZItem(cartMighlaTeil1v3)
zitemDokumentenSchlssel.Id = "febaf7d2913c607b3726851d1e583777"
zitemDokumentenSchlssel.Name = WWB_multiplatform_string("Dokumenten Schl\195\188ssel")
zitemDokumentenSchlssel.Description = WWB_multiplatform_string("Dies ist der Schl\195\188ssel f\195\188r den Dokumenten Download.<BR>\nNutze ihn auch falls Du den Geocache nicht heben m\195\182chtest, so kannst Du per QR Code das Dokument bergen. <BR>\n~<BR>\nPasswort:<BR>\nVoigt1906")
zitemDokumentenSchlssel.Visible = false
zitemDokumentenSchlssel.Locked = false
zitemDokumentenSchlssel.Opened = false
zitemDokumentenSchlssel.ObjectLocation = ZonePoint(52.446844433903564, 13.62431875661215, 0)
zitemDokumentenSchlssel.Media = zmediaMighla_Schlssel
zitemDokumentenSchlssel.Icon = zmediaMighla_Schlssel_32
zitemDokumentenSchlssel.Commands = {
  QRCode = Wherigo.ZCommand({
    Text = "QR Code",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemDokumentenSchlssel.Commands.QRCode.Id = "56d6a470732a12a2c52b1b4d0a63cb29"
zitemDokumentenSchlssel.Commands.QRCode.Custom = true
zitemDokumentenSchlssel.Commands.QRCode.WorksWithAll = true
zitemEingabeNavigation = Wherigo.ZItem(cartMighlaTeil1v3)
zitemEingabeNavigation.Id = "0a5acfdb9ae20b45dcff9567366c8fde"
zitemEingabeNavigation.Name = "Eingabe Navigation"
zitemEingabeNavigation.Description = ""
zitemEingabeNavigation.Visible = true
zitemEingabeNavigation.Locked = false
zitemEingabeNavigation.Opened = false
zitemEingabeNavigation.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemEingabeNavigation.Media = zmediaNavigation
zitemEingabeNavigation.Commands = {
  Dateneingeben = Wherigo.ZCommand({
    Text = "Daten eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemEingabeNavigation.Commands.Dateneingeben.Id = "dfa1383de12faec42efd05be5ba5c7bc"
zitemEingabeNavigation.Commands.Dateneingeben.Custom = true
zitemEingabeNavigation.Commands.Dateneingeben.WorksWithAll = true
zitemEingabeZeitreise1111906 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemEingabeZeitreise1111906.Id = "eb0478fd16a02e447a6731f751938c1f"
zitemEingabeZeitreise1111906.Name = "Eingabe Zeitreise 1.11.1906"
zitemEingabeZeitreise1111906.Description = ""
zitemEingabeZeitreise1111906.Visible = true
zitemEingabeZeitreise1111906.Locked = false
zitemEingabeZeitreise1111906.Opened = false
zitemEingabeZeitreise1111906.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemEingabeZeitreise1111906.Media = zmediaPortalZeitreisemaschiene
zitemEingabeZeitreise1111906.Commands = {
  Dateneingeben = Wherigo.ZCommand({
    Text = "Daten eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemEingabeZeitreise1111906.Commands.Dateneingeben.Id = "9ce7acd5ab39a2175af720317fe80384"
zitemEingabeZeitreise1111906.Commands.Dateneingeben.Custom = true
zitemEingabeZeitreise1111906.Commands.Dateneingeben.WorksWithAll = true
zitemEingabeZeitreise1927 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemEingabeZeitreise1927.Id = "b8c854601a5b5ef7b80a7933360e65ca"
zitemEingabeZeitreise1927.Name = "Eingabe Zeitreise 1927"
zitemEingabeZeitreise1927.Description = ""
zitemEingabeZeitreise1927.Visible = true
zitemEingabeZeitreise1927.Locked = false
zitemEingabeZeitreise1927.Opened = false
zitemEingabeZeitreise1927.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemEingabeZeitreise1927.Media = zmediaPortalZeitreisemaschiene
zitemEingabeZeitreise1927.Commands = {
  Dateneingeben = Wherigo.ZCommand({
    Text = "Daten eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemEingabeZeitreise1927.Commands.Dateneingeben.Id = "ba74e883a781a2f63c6d19ed077fb87d"
zitemEingabeZeitreise1927.Commands.Dateneingeben.Custom = true
zitemEingabeZeitreise1927.Commands.Dateneingeben.WorksWithAll = true
zitemEingabeZeitreise2111906 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemEingabeZeitreise2111906.Id = "b065ed0047001ad474f7189263d85b2d"
zitemEingabeZeitreise2111906.Name = "Eingabe Zeitreise 2.11.1906"
zitemEingabeZeitreise2111906.Description = ""
zitemEingabeZeitreise2111906.Visible = true
zitemEingabeZeitreise2111906.Locked = false
zitemEingabeZeitreise2111906.Opened = false
zitemEingabeZeitreise2111906.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemEingabeZeitreise2111906.Media = zmediaPortalZeitreisemaschiene
zitemEingabeZeitreise2111906.Commands = {
  Dateneingeben = Wherigo.ZCommand({
    Text = "Daten eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemEingabeZeitreise2111906.Commands.Dateneingeben.Id = "589ed9eb3be8bb7407b6a954156c1013"
zitemEingabeZeitreise2111906.Commands.Dateneingeben.Custom = true
zitemEingabeZeitreise2111906.Commands.Dateneingeben.WorksWithAll = true
zitemEingabeZeitreiseGegenwart = Wherigo.ZItem(cartMighlaTeil1v3)
zitemEingabeZeitreiseGegenwart.Id = "c0d387925f757338884e9bafb66021ae"
zitemEingabeZeitreiseGegenwart.Name = "Eingabe Zeitreise Gegenwart"
zitemEingabeZeitreiseGegenwart.Description = ""
zitemEingabeZeitreiseGegenwart.Visible = true
zitemEingabeZeitreiseGegenwart.Locked = false
zitemEingabeZeitreiseGegenwart.Opened = false
zitemEingabeZeitreiseGegenwart.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemEingabeZeitreiseGegenwart.Media = zmediaPortalZeitreisemaschiene
zitemEingabeZeitreiseGegenwart.Commands = {
  Dateneingeben = Wherigo.ZCommand({
    Text = "Daten eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemEingabeZeitreiseGegenwart.Commands.Dateneingeben.Id = "03510d3c6bfe93921403ecb34e8219bb"
zitemEingabeZeitreiseGegenwart.Commands.Dateneingeben.Custom = true
zitemEingabeZeitreiseGegenwart.Commands.Dateneingeben.WorksWithAll = true
zitemEndeTeil1 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemEndeTeil1.Id = "35cfaa31a83c1ce5c5f416e188819f90"
zitemEndeTeil1.Name = "Ende Teil 1"
zitemEndeTeil1.Description = WWB_multiplatform_string("Dies ist das Ende von Mighla Teil 1<BR>\n~<BR>\nIch hoffe der Beginn Deiner Reise in die Vergangenheit hat Dir gefallen. <BR>\nBevor Du Mighla Teil 2 beginnen kannst, musst Du das R\195\164tsel WfW aus aus diesem Teil noch l\195\182sen.<BR>\nAchtung!<BR>\nDer Inhalt aus dem Koffer und der Fotobox ist nur hier in der Spielzone Sichtbar. Falls Du das R\195\164tsel zu Hause l\195\182sen m\195\182chtest kontrolliere ob die 4 notwendigen Gegenst\195\164nde und das Foto von Voigt in Deinem Inventar sind.")
zitemEndeTeil1.Visible = false
zitemEndeTeil1.Locked = false
zitemEndeTeil1.Opened = false
zitemEndeTeil1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemEndeTeil1.Media = zmediaEndeT1
zitemEndeTeil1.Commands = {
  weiter = Wherigo.ZCommand({
    Text = "weiter",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemEndeTeil1.Commands.weiter.Id = "81aa28d0e37c13c3264f587d70c878eb"
zitemEndeTeil1.Commands.weiter.Custom = true
zitemEndeTeil1.Commands.weiter.WorksWithAll = true
zitemFoto01vonVoigt = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneStartzone_})
zitemFoto01vonVoigt.Id = "daed535f7fe464df3e955dbaa2968f19"
zitemFoto01vonVoigt.Name = "Foto 01 von Voigt"
zitemFoto01vonVoigt.Description = "Bitte notiere 21 EI und 45 R<BR>\n"
zitemFoto01vonVoigt.Visible = false
zitemFoto01vonVoigt.Locked = false
zitemFoto01vonVoigt.Opened = false
zitemFoto01vonVoigt.ObjectLocation = ZonePoint(52.43545059413764, 13.511265814304375, 0)
zitemFoto01vonVoigt.Media = zmediaFoto_01
zitemFoto01vonVoigt.Icon = zmediaFoto_12_32
zitemFoto01vonVoigt.Commands = {
  aufheben = Wherigo.ZCommand({
    Text = "aufheben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Hilfe1RtselWfW = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Hilfe 1 R\195\164tsel WfW", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemFoto01vonVoigt.Commands.aufheben.Id = "c07e32369d25b02721230e56a269e236"
zitemFoto01vonVoigt.Commands.aufheben.Custom = true
zitemFoto01vonVoigt.Commands.aufheben.WorksWithAll = true
zitemFoto01vonVoigt.Commands.auspacken.Id = "b53b2acedf04c510e48c461d3ac13aa7"
zitemFoto01vonVoigt.Commands.auspacken.Custom = true
zitemFoto01vonVoigt.Commands.auspacken.WorksWithAll = true
zitemFoto01vonVoigt.Commands.Hilfe1RtselWfW.Id = "22de86c70a6ecfb69a3fcfd2fbf36963"
zitemFoto01vonVoigt.Commands.Hilfe1RtselWfW.Custom = true
zitemFoto01vonVoigt.Commands.Hilfe1RtselWfW.WorksWithAll = true
zitemFoto01vonVoigt.Commands.indieFotoboxpacken.Id = "07e5880d2f9bc1bb9705e8b3945c5fd2"
zitemFoto01vonVoigt.Commands.indieFotoboxpacken.Custom = true
zitemFoto01vonVoigt.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto02ausFotobox = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto02ausFotobox.Id = "dff85dffce10ba60d2b7fbdba4c3ebc6"
zitemFoto02ausFotobox.Name = "Foto 02 aus Fotobox"
zitemFoto02ausFotobox.Description = WWB_multiplatform_string("1906 ist die andere Seite der Spree ohne Schiff nicht zu erreichen. Im Mai 1927 soll der Spreetunnel fertiggestellt sein. Suche Mighla und nutze das Zeitreise-Portal f\195\188r Deine Reise ins Jahr 1927. &nbsp;Ger\195\188chte besagen, dass der Nebel regelm\195\164\195\159ig irgendwo hier im Park auftaucht.")
zitemFoto02ausFotobox.Visible = true
zitemFoto02ausFotobox.Locked = false
zitemFoto02ausFotobox.Opened = false
zitemFoto02ausFotobox.ObjectLocation = ZonePoint(52.44067550099516, 13.51268470287323, 0)
zitemFoto02ausFotobox.Media = zmediaFoto_02
zitemFoto02ausFotobox.Icon = zmediaFoto_12_32
zitemFoto02ausFotobox.Commands = {
  verstanden = Wherigo.ZCommand({
    Text = "verstanden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto02ausFotobox.Commands.verstanden.Id = "a4ddb1db5e7c250e69cd6a9b342f01da"
zitemFoto02ausFotobox.Commands.verstanden.Custom = true
zitemFoto02ausFotobox.Commands.verstanden.WorksWithAll = true
zitemFoto03vonZeitungsjunge = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto03vonZeitungsjunge.Id = "22f192f764c4d8d01d1f4d6a82aecf0d"
zitemFoto03vonZeitungsjunge.Name = "Foto 03 von Zeitungsjunge"
zitemFoto03vonZeitungsjunge.Description = "Bitte notiere 65 TZ und 25 W"
zitemFoto03vonZeitungsjunge.Visible = true
zitemFoto03vonZeitungsjunge.Locked = false
zitemFoto03vonZeitungsjunge.Opened = false
zitemFoto03vonZeitungsjunge.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto03vonZeitungsjunge.Media = zmediaFoto_03
zitemFoto03vonZeitungsjunge.Icon = zmediaFoto_12_32
zitemFoto03vonZeitungsjunge.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto03vonZeitungsjunge.Commands.indieFotoboxpacken.Id = "e9984d2ddf03436a9cef7566401039af"
zitemFoto03vonZeitungsjunge.Commands.indieFotoboxpacken.Custom = true
zitemFoto03vonZeitungsjunge.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto04ausSchliessfach = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchliessfach_})
zitemFoto04ausSchliessfach.Id = "51a6265df9e2d49a0c482f72d61e07f2"
zitemFoto04ausSchliessfach.Name = "Foto 04 aus Schliessfach"
zitemFoto04ausSchliessfach.Description = "Bitte notiere 87 EHE und 15 G"
zitemFoto04ausSchliessfach.Visible = false
zitemFoto04ausSchliessfach.Locked = false
zitemFoto04ausSchliessfach.Opened = false
zitemFoto04ausSchliessfach.ObjectLocation = ZonePoint(52.436129316043626, 13.531921505928045, 0)
zitemFoto04ausSchliessfach.Media = zmediaFoto_04
zitemFoto04ausSchliessfach.Icon = zmediaFoto_12_32
zitemFoto04ausSchliessfach.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  nehmen = Wherigo.ZCommand({
    Text = "nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto04ausSchliessfach.Commands.indieFotoboxpacken.Id = "67ca2003ec8f408d5ce68cf366d52e70"
zitemFoto04ausSchliessfach.Commands.indieFotoboxpacken.Custom = true
zitemFoto04ausSchliessfach.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto04ausSchliessfach.Commands.nehmen.Id = "0d52da08ef512302719257fbfe63694e"
zitemFoto04ausSchliessfach.Commands.nehmen.Custom = true
zitemFoto04ausSchliessfach.Commands.nehmen.WorksWithAll = true
zitemFoto05vonBlumenfrau = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto05vonBlumenfrau.Id = "f7ff8cb89aa5aa3b28d05dd3203d4018"
zitemFoto05vonBlumenfrau.Name = "Foto 05 von Blumenfrau"
zitemFoto05vonBlumenfrau.Description = WWB_multiplatform_string("Bitte notiere 9 H\195\156 und 99 N")
zitemFoto05vonBlumenfrau.Visible = true
zitemFoto05vonBlumenfrau.Locked = false
zitemFoto05vonBlumenfrau.Opened = false
zitemFoto05vonBlumenfrau.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto05vonBlumenfrau.Media = zmediaFoto_05
zitemFoto05vonBlumenfrau.Icon = zmediaFoto_12_32
zitemFoto05vonBlumenfrau.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto05vonBlumenfrau.Commands.indieFotoboxpacken.Id = "e2eff3862fb8d10d2eed3e16a2434d6d"
zitemFoto05vonBlumenfrau.Commands.indieFotoboxpacken.Custom = true
zitemFoto05vonBlumenfrau.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto06vonKalle = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto06vonKalle.Id = "7f3f877594a0eb57563210254d02b907"
zitemFoto06vonKalle.Name = "Foto 06 von Kalle"
zitemFoto06vonKalle.Description = "Bitte notiere 12 TS und 88 JENS"
zitemFoto06vonKalle.Visible = true
zitemFoto06vonKalle.Locked = false
zitemFoto06vonKalle.Opened = false
zitemFoto06vonKalle.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto06vonKalle.Media = zmediaFoto_06
zitemFoto06vonKalle.Icon = zmediaFoto_12_32
zitemFoto06vonKalle.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemFoto06vonKalle.Commands.indieFotoboxpacken.Id = "3c84cfcdac15d9c61accafa934892d3e"
zitemFoto06vonKalle.Commands.indieFotoboxpacken.Custom = true
zitemFoto06vonKalle.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto07ausdemKoffer = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneKoffer})
zitemFoto07ausdemKoffer.Id = "dda3ec8eb4dfbb2267381f1e76772bf2"
zitemFoto07ausdemKoffer.Name = "Foto 07 aus dem Koffer"
zitemFoto07ausdemKoffer.Description = "Bitte notiere 34 VO und 77 TT"
zitemFoto07ausdemKoffer.Visible = true
zitemFoto07ausdemKoffer.Locked = true
zitemFoto07ausdemKoffer.Opened = false
zitemFoto07ausdemKoffer.ObjectLocation = ZonePoint(52.43036929658017, 13.514669537544247, 0)
zitemFoto07ausdemKoffer.Media = zmediaFoto_07
zitemFoto07ausdemKoffer.Icon = zmediaFoto_12_32
zitemFoto07ausdemKoffer.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemFoto07ausdemKoffer.Commands.auspacken.Id = "863b48bca5c8eeab7cfe5c54cbd6cecc"
zitemFoto07ausdemKoffer.Commands.auspacken.Custom = true
zitemFoto07ausdemKoffer.Commands.auspacken.WorksWithAll = true
zitemFoto07ausdemKoffer.Commands.indieFotoboxpacken.Id = "af2ee6b4113198d7907d5181bea32555"
zitemFoto07ausdemKoffer.Commands.indieFotoboxpacken.Custom = true
zitemFoto07ausdemKoffer.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto08vonKellnerin = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto08vonKellnerin.Id = "ef81b8364ec45ebd3ce7f602cddb5ce0"
zitemFoto08vonKellnerin.Name = "Foto 08 von Kellnerin"
zitemFoto08vonKellnerin.Description = "Bitte notiere 56 DO und 66 I"
zitemFoto08vonKellnerin.Visible = true
zitemFoto08vonKellnerin.Locked = false
zitemFoto08vonKellnerin.Opened = false
zitemFoto08vonKellnerin.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto08vonKellnerin.Media = zmediaFoto_08
zitemFoto08vonKellnerin.Icon = zmediaFoto_12_32
zitemFoto08vonKellnerin.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto08vonKellnerin.Commands.indieFotoboxpacken.Id = "6fcbe2f6846eafbb94fbc619cc1cf0a4"
zitemFoto08vonKellnerin.Commands.indieFotoboxpacken.Custom = true
zitemFoto08vonKellnerin.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto09vonKapitn = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto09vonKapitn.Id = "3eb134df97543e8185cd0e5fc8c62777"
zitemFoto09vonKapitn.Name = WWB_multiplatform_string("Foto 09 von Kapit\195\164n")
zitemFoto09vonKapitn.Description = "Bitte notiere 78 V und 55 E"
zitemFoto09vonKapitn.Visible = true
zitemFoto09vonKapitn.Locked = false
zitemFoto09vonKapitn.Opened = false
zitemFoto09vonKapitn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto09vonKapitn.Media = zmediaFoto_09
zitemFoto09vonKapitn.Icon = zmediaFoto_12_32
zitemFoto09vonKapitn.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemFoto09vonKapitn.Commands.indieFotoboxpacken.Id = "af2ab3befac0d1b559f670ee66d49641"
zitemFoto09vonKapitn.Commands.indieFotoboxpacken.Custom = true
zitemFoto09vonKapitn.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto10vonMarta = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto10vonMarta.Id = "658a285aca77fb121c7c52c71730e871"
zitemFoto10vonMarta.Name = "Foto 10 von Marta"
zitemFoto10vonMarta.Description = "Bitte notiere 11 IO und 44 ZU"
zitemFoto10vonMarta.Visible = true
zitemFoto10vonMarta.Locked = false
zitemFoto10vonMarta.Opened = false
zitemFoto10vonMarta.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto10vonMarta.Media = zmediaFoto_10
zitemFoto10vonMarta.Icon = zmediaFoto_12_32
zitemFoto10vonMarta.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto10vonMarta.Commands.indieFotoboxpacken.Id = "23b53ed50eebe7c3a4c9f1915f37bec5"
zitemFoto10vonMarta.Commands.indieFotoboxpacken.Custom = true
zitemFoto10vonMarta.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto11ausTreibgut = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto11ausTreibgut.Id = "91dc82677c02f7ba4d5899881740dfc1"
zitemFoto11ausTreibgut.Name = "Foto 11 aus Treibgut"
zitemFoto11ausTreibgut.Description = "Bitte notiere 22 T und 33 ICH"
zitemFoto11ausTreibgut.Visible = true
zitemFoto11ausTreibgut.Locked = false
zitemFoto11ausTreibgut.Opened = false
zitemFoto11ausTreibgut.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFoto11ausTreibgut.Media = zmediaFoto_11
zitemFoto11ausTreibgut.Icon = zmediaFoto_12_32
zitemFoto11ausTreibgut.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFoto11ausTreibgut.Commands.indieFotoboxpacken.Id = "eca0592620a465969be49caf789f1dec"
zitemFoto11ausTreibgut.Commands.indieFotoboxpacken.Custom = true
zitemFoto11ausTreibgut.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto12ausBrief3 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFoto12ausBrief3.Id = "6a52cf541dbb26c7a4e951ddc21edefc"
zitemFoto12ausBrief3.Name = "Foto 12 aus Brief 3"
zitemFoto12ausBrief3.Description = "<BR>\n"
zitemFoto12ausBrief3.Visible = true
zitemFoto12ausBrief3.Locked = false
zitemFoto12ausBrief3.Opened = false
zitemFoto12ausBrief3.ObjectLocation = ZonePoint(49.871240090297036, 10.21611757939656, 0)
zitemFoto12ausBrief3.Media = zmediaFoto_12
zitemFoto12ausBrief3.Icon = zmediaFoto_12_32
zitemFoto12ausBrief3.Commands = {
  indieFotoboxpacken = Wherigo.ZCommand({
    Text = "in die Fotobox packen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Lsungscodeeingeben = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("L\195\182sungscode eingeben", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemFoto12ausBrief3.Commands.indieFotoboxpacken.Id = "e276a3b1ecc5d9dc1bed2a915c9d3780"
zitemFoto12ausBrief3.Commands.indieFotoboxpacken.Custom = true
zitemFoto12ausBrief3.Commands.indieFotoboxpacken.WorksWithAll = true
zitemFoto12ausBrief3.Commands.Lsungscodeeingeben.Id = "620be19fde32638c31480d707a80c74a"
zitemFoto12ausBrief3.Commands.Lsungscodeeingeben.Custom = true
zitemFoto12ausBrief3.Commands.Lsungscodeeingeben.WorksWithAll = true
zitemFotoboxvonZille = Wherigo.ZItem(cartMighlaTeil1v3)
zitemFotoboxvonZille.Id = "b67d1d55112ca53b5b3e70d87aba23a7"
zitemFotoboxvonZille.Name = "Fotobox von Zille"
zitemFotoboxvonZille.Description = WWB_multiplatform_string("In der Box befindet sich ein Bild.<BR>\n\195\150ffne die Box.")
zitemFotoboxvonZille.Visible = true
zitemFotoboxvonZille.Locked = true
zitemFotoboxvonZille.Opened = false
zitemFotoboxvonZille.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFotoboxvonZille.Media = zmediaFotobox
zitemFotoboxvonZille.Icon = zmediaFotobox_32
zitemFotoboxvonZille.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("\195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  schliessen = Wherigo.ZCommand({
    Text = "schliessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemFotoboxvonZille.Commands.auspacken.Id = "6d8956e09583f59a79fc08271bc89531"
zitemFotoboxvonZille.Commands.auspacken.Custom = true
zitemFotoboxvonZille.Commands.auspacken.WorksWithAll = true
zitemFotoboxvonZille.Commands.einpacken.Id = "1895f43ca511b0773efc3edc751a7281"
zitemFotoboxvonZille.Commands.einpacken.Custom = true
zitemFotoboxvonZille.Commands.einpacken.WorksWithAll = true
zitemFotoboxvonZille.Commands.ffnen.Id = "24c738674b52638577bbc0e2a145d77b"
zitemFotoboxvonZille.Commands.ffnen.Custom = true
zitemFotoboxvonZille.Commands.ffnen.WorksWithAll = false
zitemFotoboxvonZille.Commands.ffnen.WorksWithListIds = {}
zitemFotoboxvonZille.Commands.schliessen.Id = "4910a262b940c45cfcb37bed5364627e"
zitemFotoboxvonZille.Commands.schliessen.Custom = true
zitemFotoboxvonZille.Commands.schliessen.WorksWithAll = true
zitemGeld = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchliessfach_})
zitemGeld.Id = "b88683abb7cfd17f9c90f5a55e330c14"
zitemGeld.Name = "Geld"
zitemGeld.Description = ""
zitemGeld.Visible = false
zitemGeld.Locked = false
zitemGeld.Opened = false
zitemGeld.ObjectLocation = ZonePoint(52.436129316043626, 13.531921505928045, 0)
zitemGeld.Media = zmediaGeld
zitemGeld.Icon = zmediaGeld_32
zitemGeld.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Blumenfraubezahlen = Wherigo.ZCommand({
    Text = "Blumenfrau bezahlen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Kellnerinbezahlen = Wherigo.ZCommand({
    Text = "Kellnerin bezahlen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  nehmen = Wherigo.ZCommand({
    Text = "nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemGeld.Commands.auspacken.Id = "80d99d0066572d726af71627450dab54"
zitemGeld.Commands.auspacken.Custom = true
zitemGeld.Commands.auspacken.WorksWithAll = true
zitemGeld.Commands.Blumenfraubezahlen.Id = "fbc01ef8310bb8c901a983b849a7eaba"
zitemGeld.Commands.Blumenfraubezahlen.Custom = true
zitemGeld.Commands.Blumenfraubezahlen.WorksWithAll = true
zitemGeld.Commands.einpacken.Id = "c851a9bc35e8966efd4e1e89b1e8b05d"
zitemGeld.Commands.einpacken.Custom = true
zitemGeld.Commands.einpacken.WorksWithAll = true
zitemGeld.Commands.Kellnerinbezahlen.Id = "276fadb739fd98e217fb25d943220ff0"
zitemGeld.Commands.Kellnerinbezahlen.Custom = true
zitemGeld.Commands.Kellnerinbezahlen.WorksWithAll = true
zitemGeld.Commands.nehmen.Id = "0d25365d4fdbf7abdcc90ba7c3afd84f"
zitemGeld.Commands.nehmen.Custom = true
zitemGeld.Commands.nehmen.WorksWithAll = true
zitemHilfePunkteTeil1 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemHilfePunkteTeil1.Id = "fe6ca13b7bc3a63416c34e1a29b4b5ea"
zitemHilfePunkteTeil1.Name = "Hilfe Punkte Teil 1"
zitemHilfePunkteTeil1.Description = WWB_multiplatform_string("Punkteabrechnung.<BR>\n~<BR>\n1. Hilfe = 1 Punkte<BR>\n2. Hilfe = 2 Punkte<BR>\n3. Hilfe = 2 Punkte<BR>\nL\195\182sung = 3 Punkte<BR>\nMax. 8 Punkte<BR>\n~")
zitemHilfePunkteTeil1.Visible = false
zitemHilfePunkteTeil1.Locked = false
zitemHilfePunkteTeil1.Opened = false
zitemHilfePunkteTeil1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemHilfePunkteTeil1.Media = zmediaHilfe_Anzahl
zitemHilfePunkteTeil1.Icon = zmediaHilfe_Anzahl_32
zitemHilfePunkteTeil1.Commands = {
  Punkteanzeigen = Wherigo.ZCommand({
    Text = "Punkte anzeigen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemHilfePunkteTeil1.Commands.Punkteanzeigen.Id = "0cd721f7a85ddb172e828bc46f0a3bfb"
zitemHilfePunkteTeil1.Commands.Punkteanzeigen.Custom = true
zitemHilfePunkteTeil1.Commands.Punkteanzeigen.WorksWithAll = true
zitemHilfePunkteTeil2 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemHilfePunkteTeil2.Id = "3490587ac5953d3c3691aefe84a41f3d"
zitemHilfePunkteTeil2.Name = "Hilfe Punkte Teil 2"
zitemHilfePunkteTeil2.Description = WWB_multiplatform_string("Punkteabrechnung.<BR>\n~<BR>\n1. Hilfe = 1 Punkte<BR>\n2. Hilfe = 2 Punkte<BR>\n3. Hilfe = 2 Punkte<BR>\nL\195\182sung = 3 Punkte<BR>\nMax. 8 Punkte<BR>\n~")
zitemHilfePunkteTeil2.Visible = false
zitemHilfePunkteTeil2.Locked = false
zitemHilfePunkteTeil2.Opened = false
zitemHilfePunkteTeil2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemHilfePunkteTeil2.Media = zmediaHilfe_Anzahl
zitemHilfePunkteTeil2.Icon = zmediaHilfe_Anzahl_32
zitemHilfePunkteTeil2.Commands = {
  Punkteanzeigen = Wherigo.ZCommand({
    Text = "Punkte anzeigen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemHilfePunkteTeil2.Commands.Punkteanzeigen.Id = "1a2aa90496b5dc16c7c0402e4e761b2c"
zitemHilfePunkteTeil2.Commands.Punkteanzeigen.Custom = true
zitemHilfePunkteTeil2.Commands.Punkteanzeigen.WorksWithAll = true
zitemHilfeInventarzhler = Wherigo.ZItem(cartMighlaTeil1v3)
zitemHilfeInventarzhler.Id = "719a2132d5f85c6b1e7b95eb1a1cdbb3"
zitemHilfeInventarzhler.Name = WWB_multiplatform_string("Hilfe- Inventarz\195\164hler")
zitemHilfeInventarzhler.Description = WWB_multiplatform_string("Hier kannst Du Dir die Punkte f\195\188r die in Anspruch genommenen Hilfen anzeigen lassen.<BR>\n1. Hilfe = 1 Punkte<BR>\n2. Hilfe = 2 Punkte<BR>\n3. Hilfe = 2 Punkte<BR>\nL\195\182sung = 3 Punkte<BR>\nMax. 8 Punkte<BR>\n~<BR>\nUnd Du kannst Dir anzeigen lassen wieviel Inventar Du gerade in der Hand hast.")
zitemHilfeInventarzhler.Visible = true
zitemHilfeInventarzhler.Locked = false
zitemHilfeInventarzhler.Opened = false
zitemHilfeInventarzhler.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemHilfeInventarzhler.Media = zmediaHilfe_Anzahl
zitemHilfeInventarzhler.Icon = zmediaHilfe_Anzahl_32
zitemHilfeInventarzhler.Commands = {
  Inventaranzeigen = Wherigo.ZCommand({
    Text = "Inventar anzeigen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Punkteanzeigen = Wherigo.ZCommand({
    Text = "Punkte anzeigen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemHilfeInventarzhler.Commands.Inventaranzeigen.Id = "bd203bee1d3cd32ed2d850c99f9a795b"
zitemHilfeInventarzhler.Commands.Inventaranzeigen.Custom = true
zitemHilfeInventarzhler.Commands.Inventaranzeigen.WorksWithAll = true
zitemHilfeInventarzhler.Commands.Punkteanzeigen.Id = "6c8449f543c32b900a44abc99d1dc720"
zitemHilfeInventarzhler.Commands.Punkteanzeigen.Custom = true
zitemHilfeInventarzhler.Commands.Punkteanzeigen.WorksWithAll = true
zitemHinweis = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zone09_Spree_Ecke})
zitemHinweis.Id = "fd4bda31939cf6e11740df1342700d76"
zitemHinweis.Name = "Hinweis"
zitemHinweis.Description = [[
eglofnehieR WfW<BR>
<BR>
Den Hinweis findest Du auch in Deiner Akte:<BR>
~<BR>
geomcwood.wixsite.com/mighla/hinweis<BR>
Inventar Name: Hinweis<BR>
Passwort: yxy]]
zitemHinweis.Visible = false
zitemHinweis.Locked = false
zitemHinweis.Opened = false
zitemHinweis.ObjectLocation = ZonePoint(52.434119665518004, 13.530344367027281, 0)
zitemHinweis.Media = zmediaSpielkarte
zitemHinweis.Icon = zmediaSpielkarte_32
zitemHinweis.Commands = {
  nehmen = Wherigo.ZCommand({
    Text = "nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemHinweis.Commands.nehmen.Id = "3295e2714f18d5e9b712d9f7566a9129"
zitemHinweis.Commands.nehmen.Custom = true
zitemHinweis.Commands.nehmen.WorksWithAll = true
zitemKarte = Wherigo.ZItem(cartMighlaTeil1v3)
zitemKarte.Id = "178da6291e373ad6271a6cf9b37e69e3"
zitemKarte.Name = "Karte"
zitemKarte.Description = WWB_multiplatform_string("Hallo Beck, <BR>\ndiese Karte und ein Teil Ihrer Reiseunterlagen sind zusammen der Kofferschl\195\188ssel zu meinem Koffer. \195\150ffnen Sie den Koffer.<BR>\n~<BR>\nWichtig! Den Schl\195\188ssel ben\195\182tigst Du im 2. Teil von Mighla, also notiere ihn!<BR>\nGru\195\159 Voigt<BR>\n~<BR>\nDie Karte findest Du auch in Deiner Akte: <BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/karte<BR>\nInventar Name: Karte<BR>\nPasswort: ded")
zitemKarte.Visible = true
zitemKarte.Locked = false
zitemKarte.Opened = false
zitemKarte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemKarte.Media = zmediaKofferschlssel_Code
zitemKarte.Icon = zmediaKofferschlssel_Code_32
zitemKarte.Commands = {
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemKarte.Commands.Details.Id = "2bc20ea3efbcfe293dce236ee62cda7e"
zitemKarte.Commands.Details.Custom = true
zitemKarte.Commands.Details.WorksWithAll = true
zitemKoffer = Wherigo.ZItem(cartMighlaTeil1v3)
zitemKoffer.Id = "8a037ac4fd202dca960c5b9a665423c0"
zitemKoffer.Name = "Koffer"
zitemKoffer.Description = ""
zitemKoffer.Visible = true
zitemKoffer.Locked = true
zitemKoffer.Opened = false
zitemKoffer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemKoffer.Media = zmediaKoffer
zitemKoffer.Icon = zmediaKoffer_32
zitemKoffer.Commands = {
  Kofferffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Koffer \195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  schliessen = Wherigo.ZCommand({
    Text = "schliessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schlossffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("Schloss \195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemKoffer.Commands.Kofferffnen.Id = "e3571e4aca79bac0b333b8126202343f"
zitemKoffer.Commands.Kofferffnen.Custom = true
zitemKoffer.Commands.Kofferffnen.WorksWithAll = true
zitemKoffer.Commands.schliessen.Id = "0eb40ff18ac1b17890793f8c5a6bca45"
zitemKoffer.Commands.schliessen.Custom = true
zitemKoffer.Commands.schliessen.WorksWithAll = true
zitemKoffer.Commands.Schlossffnen.Id = "d29af4779a952cc57ebd7d565068c1ad"
zitemKoffer.Commands.Schlossffnen.Custom = true
zitemKoffer.Commands.Schlossffnen.WorksWithAll = true
zitemKofferschlsseluStadtkasse = Wherigo.ZItem(cartMighlaTeil1v3)
zitemKofferschlsseluStadtkasse.Id = "14f95f3ad47018032d71361a7b4b369f"
zitemKofferschlsseluStadtkasse.Name = WWB_multiplatform_string("Kofferschl\195\188ssel u Stadtkasse")
zitemKofferschlsseluStadtkasse.Description = [[
Diese Reiseunterlagen aus Ihrer Reiseakte laden, ausdrucken und auf die Reise mitnehmen.<BR>
~<BR>
Akte Mighla<BR>
geomcwood.wixsite.com/mighla <BR>
Passwort: 1906<BR>
~]]
zitemKofferschlsseluStadtkasse.Visible = true
zitemKofferschlsseluStadtkasse.Locked = false
zitemKofferschlsseluStadtkasse.Opened = false
zitemKofferschlsseluStadtkasse.ObjectLocation = ZonePoint(52.444841354874825, 13.507813811302185, 0)
zitemKofferschlsseluStadtkasse.Media = zmediaKofferschlsseluStadtkasse
zitemKofferschlsseluStadtkasse.Icon = zmediaKofferschlsseluStadtkasse_32
zitemKofferschlsseluStadtkasse.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  zurck = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("zur\195\188ck", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemKofferschlsseluStadtkasse.Commands.auspacken.Id = "e64ceaf59ce88f8f52b6d64f9e3b6f4f"
zitemKofferschlsseluStadtkasse.Commands.auspacken.Custom = true
zitemKofferschlsseluStadtkasse.Commands.auspacken.WorksWithAll = true
zitemKofferschlsseluStadtkasse.Commands.einpacken.Id = "59f3d718631c225cd552d5680bd5c05c"
zitemKofferschlsseluStadtkasse.Commands.einpacken.Custom = true
zitemKofferschlsseluStadtkasse.Commands.einpacken.WorksWithAll = true
zitemKofferschlsseluStadtkasse.Commands.zurck.Id = "85c3f5094cff9f5e3adf862a868913ed"
zitemKofferschlsseluStadtkasse.Commands.zurck.Custom = true
zitemKofferschlsseluStadtkasse.Commands.zurck.WorksWithAll = true
zitemMighla = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zonePortalGegenwart_})
zitemMighla.Id = "f1b211029718f4b2217092a95b3494b5"
zitemMighla.Name = "Mighla"
zitemMighla.Description = [[
Willkommen in der Gegenwart.<BR>
Mighla ist jedoch nicht verschwunden, im Nebel sind Zahlen zu erkennen....<BR>
]]
zitemMighla.Visible = false
zitemMighla.Locked = false
zitemMighla.Opened = false
zitemMighla.ObjectLocation = ZonePoint(49.86558825232734, 10.209863450860947, 0)
zitemMighla.Media = zmediaMighlaFinaleTelefonnummer
zitemMighla.Commands = {
  Hilfe = Wherigo.ZCommand({
    Text = "Hilfe",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  weiter = Wherigo.ZCommand({
    Text = "weiter",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemMighla.Commands.Hilfe.Id = "cee5886c5a38f2ff19c07ef8416e18dc"
zitemMighla.Commands.Hilfe.Custom = true
zitemMighla.Commands.Hilfe.WorksWithAll = true
zitemMighla.Commands.weiter.Id = "72fc5895da8f6dd2c9c0c5cd8f3b7b71"
zitemMighla.Commands.weiter.Custom = true
zitemMighla.Commands.weiter.WorksWithAll = true
zitemMighlaAB = Wherigo.ZItem(cartMighlaTeil1v3)
zitemMighlaAB.Id = "8871ea65018ad349dc40b76872eb2b4c"
zitemMighlaAB.Name = "Mighla AB"
zitemMighlaAB.Description = WWB_multiplatform_string("Hier kannst Du den Mighla Anrufbeantworter abh\195\182ren.")
zitemMighlaAB.Visible = true
zitemMighlaAB.Locked = false
zitemMighlaAB.Opened = false
zitemMighlaAB.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemMighlaAB.Media = zmediaMighlaFinaleTelefonnummer
zitemMighlaAB.Commands = {
  ABabhren = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("AB abh\195\182ren", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemMighlaAB.Commands.ABabhren.Id = "41cd2234c1a307aece95afbdb07b7ff3"
zitemMighlaAB.Commands.ABabhren.Custom = true
zitemMighlaAB.Commands.ABabhren.WorksWithAll = true
zitemNavigationausBrief3 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemNavigationausBrief3.Id = "6210559fdfe8d9467f49f05ebea8f6a5"
zitemNavigationausBrief3.Name = "Navigation aus Brief 3"
zitemNavigationausBrief3.Description = [[
Die Navigation findest Du auch in Deiner Akte:<BR>
~<BR>
geomcwood.wixsite.com/mighla/navi<BR>
Inventar Name: Navi<BR>
Passwort: qwq]]
zitemNavigationausBrief3.Visible = true
zitemNavigationausBrief3.Locked = false
zitemNavigationausBrief3.Opened = false
zitemNavigationausBrief3.ObjectLocation = ZonePoint(52.4385760752797, 13.51519525051117, 0)
zitemNavigationausBrief3.Media = zmediaNavigation
zitemNavigationausBrief3.Icon = zmediaNavigation_32
zitemNavigationausBrief3.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemNavigationausBrief3.Commands.auspacken.Id = "9e336365027b9da16227e6fcc35019ac"
zitemNavigationausBrief3.Commands.auspacken.Custom = true
zitemNavigationausBrief3.Commands.auspacken.WorksWithAll = true
zitemNavigationausBrief3.Commands.Details.Id = "5af53877aad9c214f76263cc41d89fd9"
zitemNavigationausBrief3.Commands.Details.Custom = true
zitemNavigationausBrief3.Commands.Details.WorksWithAll = true
zitemNavigationausBrief3.Commands.einpacken.Id = "4991e4166889be236500ca76f2aa69ee"
zitemNavigationausBrief3.Commands.einpacken.Custom = true
zitemNavigationausBrief3.Commands.einpacken.WorksWithAll = true
zitemNelke = Wherigo.ZItem(cartMighlaTeil1v3)
zitemNelke.Id = "033646ae8f60ac745bb18170a5e1c4bf"
zitemNelke.Name = "Nelke"
zitemNelke.Description = ""
zitemNelke.Visible = true
zitemNelke.Locked = false
zitemNelke.Opened = false
zitemNelke.ObjectLocation = ZonePoint(52.43813132428168, 13.522083163261414, 0)
zitemNelke.Media = zmediaNelke
zitemNelke.Icon = zmediaNelke_32
zitemNotiz = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchliessfach_})
zitemNotiz.Id = "8cebdd8c0ca77a4de49e8001fd064af3"
zitemNotiz.Name = "Notiz"
zitemNotiz.Description = ""
zitemNotiz.Visible = false
zitemNotiz.Locked = false
zitemNotiz.Opened = false
zitemNotiz.ObjectLocation = ZonePoint(52.436129316043626, 13.531921505928045, 0)
zitemNotiz.Media = zmediaNotiz
zitemNotiz.Icon = zmediaNotiz_32
zitemNotiz.Commands = {
  lesen = Wherigo.ZCommand({
    Text = "lesen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemNotiz.Commands.lesen.Id = "4fa62fefa6ce26e9da6488c4e11d6699"
zitemNotiz.Commands.lesen.Custom = true
zitemNotiz.Commands.lesen.WorksWithAll = true
zitemPergament = Wherigo.ZItem(cartMighlaTeil1v3)
zitemPergament.Id = "0f6fefbc39f141189f80c01f2e2acdfb"
zitemPergament.Name = "Pergament"
zitemPergament.Description = ""
zitemPergament.Visible = false
zitemPergament.Locked = false
zitemPergament.Opened = false
zitemPergament.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemPergament.Media = zmediaPergament
zitemPergament.Icon = zmediaPergament_32
zitemPergament.Commands = {
  lesen = Wherigo.ZCommand({
    Text = "lesen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemPergament.Commands.lesen.Id = "31f1bc4b319c61dede875f4c2ea32162"
zitemPergament.Commands.lesen.Custom = true
zitemPergament.Commands.lesen.WorksWithAll = true
zitemPortalAktivierungskarten = Wherigo.ZItem(cartMighlaTeil1v3)
zitemPortalAktivierungskarten.Id = "c13b3ef8841b0b3dd3b2b3354c4d6bfc"
zitemPortalAktivierungskarten.Name = "Portal Aktivierungskarten"
zitemPortalAktivierungskarten.Description = [[
Diese Reiseunterlage aus Ihrer Reiseakte laden, ausdrucken, AUSSCHNEIDEN und auf die Reise mitnehmen.<BR>
~<BR>
Akte Mighla<BR>
geomcwood.wixsite.com/mighla <BR>
Passwort: 1906<BR>
~]]
zitemPortalAktivierungskarten.Visible = true
zitemPortalAktivierungskarten.Locked = false
zitemPortalAktivierungskarten.Opened = false
zitemPortalAktivierungskarten.ObjectLocation = ZonePoint(52.444841354874825, 13.507813811302185, 0)
zitemPortalAktivierungskarten.Media = zmediaPortalAktivierungskarten
zitemPortalAktivierungskarten.Icon = zmediaPortalAktivierungskarten_32
zitemPortalAktivierungskarten.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  zurck = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("zur\195\188ck", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemPortalAktivierungskarten.Commands.auspacken.Id = "248902dff8bdb85c8e76afac9a03c760"
zitemPortalAktivierungskarten.Commands.auspacken.Custom = true
zitemPortalAktivierungskarten.Commands.auspacken.WorksWithAll = true
zitemPortalAktivierungskarten.Commands.einpacken.Id = "c17c663e213f10e37286b9454493cda8"
zitemPortalAktivierungskarten.Commands.einpacken.Custom = true
zitemPortalAktivierungskarten.Commands.einpacken.WorksWithAll = true
zitemPortalAktivierungskarten.Commands.zurck.Id = "8715187ae9f88378821d8a95ccab467f"
zitemPortalAktivierungskarten.Commands.zurck.Custom = true
zitemPortalAktivierungskarten.Commands.zurck.WorksWithAll = true
zitemPortalZeitreisemaschiene = Wherigo.ZItem(cartMighlaTeil1v3)
zitemPortalZeitreisemaschiene.Id = "d2fe6ef5235064cd132a86fe9c490d90"
zitemPortalZeitreisemaschiene.Name = "Portal Zeitreisemaschiene"
zitemPortalZeitreisemaschiene.Description = [[
Diese Reiseunterlage aus Ihrer Reiseakte laden, ausdrucken und auf die Reise mitnehmen.<BR>
~<BR>
Akte Mighla<BR>
geomcwood.wixsite.com/mighla <BR>
Passwort: 1906<BR>
~]]
zitemPortalZeitreisemaschiene.Visible = true
zitemPortalZeitreisemaschiene.Locked = false
zitemPortalZeitreisemaschiene.Opened = false
zitemPortalZeitreisemaschiene.ObjectLocation = ZonePoint(52.444841354874825, 13.507813811302185, 0)
zitemPortalZeitreisemaschiene.Media = zmediaPortalZeitreisemaschiene
zitemPortalZeitreisemaschiene.Icon = zmediaPortalZeitreisemaschiene_32
zitemPortalZeitreisemaschiene.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  zurck = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("zur\195\188ck", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemPortalZeitreisemaschiene.Commands.auspacken.Id = "123ad665f3e3d14ae0f0ee5de31f9501"
zitemPortalZeitreisemaschiene.Commands.auspacken.Custom = true
zitemPortalZeitreisemaschiene.Commands.auspacken.WorksWithAll = true
zitemPortalZeitreisemaschiene.Commands.einpacken.Id = "a43f60b2e3ae0d4af988667777db3b2d"
zitemPortalZeitreisemaschiene.Commands.einpacken.Custom = true
zitemPortalZeitreisemaschiene.Commands.einpacken.WorksWithAll = true
zitemPortalZeitreisemaschiene.Commands.zurck.Id = "f0948ea4096366a5d6f44b8c99de4538"
zitemPortalZeitreisemaschiene.Commands.zurck.Custom = true
zitemPortalZeitreisemaschiene.Commands.zurck.WorksWithAll = true
zitemRadfahrerZeitungS1 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemRadfahrerZeitungS1.Id = "66f1dc7399a3acd93d6069b40efe0163"
zitemRadfahrerZeitungS1.Name = "Radfahrer Zeitung S.1"
zitemRadfahrerZeitungS1.Description = WWB_multiplatform_string("Zeitung S.1 mit Teil 3 von 4 vom R\195\164tsel \"Wort f\195\188r Wort\" (WfW)<BR>\n~<BR>\nDie Zeitung findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/zeitung-s-1<BR>\nInventar Name: Zeitung S.1<BR>\nPasswort: tzt")
zitemRadfahrerZeitungS1.Visible = true
zitemRadfahrerZeitungS1.Locked = true
zitemRadfahrerZeitungS1.Opened = false
zitemRadfahrerZeitungS1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemRadfahrerZeitungS1.Media = zmediaRadfahrerZeitungS1
zitemRadfahrerZeitungS1.Icon = zmediaRadfahrerZeitungS1_32
zitemRadfahrerZeitungS1.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemRadfahrerZeitungS1.Commands.auspacken.Id = "35db4beff494c0b1ea7dd6cbb9ca5544"
zitemRadfahrerZeitungS1.Commands.auspacken.Custom = true
zitemRadfahrerZeitungS1.Commands.auspacken.WorksWithAll = true
zitemRadfahrerZeitungS1.Commands.Details.Id = "b80cd4e2caa92d58be924910859bd692"
zitemRadfahrerZeitungS1.Commands.Details.Custom = true
zitemRadfahrerZeitungS1.Commands.Details.WorksWithAll = true
zitemRadfahrerZeitungS1.Commands.einpacken.Id = "cc1efaf5d403d0224aca7e9b1fe19da8"
zitemRadfahrerZeitungS1.Commands.einpacken.Custom = true
zitemRadfahrerZeitungS1.Commands.einpacken.WorksWithAll = true
zitemRadfahrerZeitungS37 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemRadfahrerZeitungS37.Id = "1802966ca206dd47bf8d48bac8f0e093"
zitemRadfahrerZeitungS37.Name = "Radfahrer Zeitung S.37"
zitemRadfahrerZeitungS37.Description = WWB_multiplatform_string("Zeitung S.37 mit dem Teil 1 von 2 f\195\188r das R\195\164tsel R-A-D<BR>\n~<BR>\nDie Zeitung findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/zeitung-s-37<BR>\nInventar Name: Zeitung S.37<BR>\nPasswort: vbv")
zitemRadfahrerZeitungS37.Visible = true
zitemRadfahrerZeitungS37.Locked = false
zitemRadfahrerZeitungS37.Opened = false
zitemRadfahrerZeitungS37.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemRadfahrerZeitungS37.Media = zmediaRadfahrerZeitungS37
zitemRadfahrerZeitungS37.Icon = zmediaRadfahrerZeitungS37_32
zitemRadfahrerZeitungS37.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemRadfahrerZeitungS37.Commands.auspacken.Id = "2f5c82b71c0934312bfd31cff630fcaa"
zitemRadfahrerZeitungS37.Commands.auspacken.Custom = true
zitemRadfahrerZeitungS37.Commands.auspacken.WorksWithAll = true
zitemRadfahrerZeitungS37.Commands.Details.Id = "1f3979a2791967bcceb9c9afee908827"
zitemRadfahrerZeitungS37.Commands.Details.Custom = true
zitemRadfahrerZeitungS37.Commands.Details.WorksWithAll = true
zitemRadfahrerZeitungS37.Commands.einpacken.Id = "eeb943d84eb14e026456a62eb7b2937b"
zitemRadfahrerZeitungS37.Commands.einpacken.Custom = true
zitemRadfahrerZeitungS37.Commands.einpacken.WorksWithAll = true
zitemRadfahrerZeitungS41 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemRadfahrerZeitungS41.Id = "b75376a524553268a6452ec547bb8c4b"
zitemRadfahrerZeitungS41.Name = "Radfahrer Zeitung S.41"
zitemRadfahrerZeitungS41.Description = WWB_multiplatform_string("Zeitung S.41 und Teil 4 von 4 vom R\195\164tsel \"Wort f\195\188r Wort\" (WfW)<BR>\n~<BR>\nDie Zeitung findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/zeitung-s-41<BR>\nInventar Name: Zeitung S.41<BR>\nPasswort: asa")
zitemRadfahrerZeitungS41.Visible = true
zitemRadfahrerZeitungS41.Locked = true
zitemRadfahrerZeitungS41.Opened = false
zitemRadfahrerZeitungS41.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemRadfahrerZeitungS41.Media = zmediaRadfahrerZeitungS41
zitemRadfahrerZeitungS41.Icon = zmediaRadfahrerZeitungS41_32
zitemRadfahrerZeitungS41.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemRadfahrerZeitungS41.Commands.auspacken.Id = "6c153c960ea101d6f18c62906e11caf3"
zitemRadfahrerZeitungS41.Commands.auspacken.Custom = true
zitemRadfahrerZeitungS41.Commands.auspacken.WorksWithAll = true
zitemRadfahrerZeitungS41.Commands.Details.Id = "a9559cedc1bfe23095aca20404b37b5f"
zitemRadfahrerZeitungS41.Commands.Details.Custom = true
zitemRadfahrerZeitungS41.Commands.Details.WorksWithAll = true
zitemRadfahrerZeitungS41.Commands.einpacken.Id = "cbc4c0c4c0b779069abbc9e34cdb77df"
zitemRadfahrerZeitungS41.Commands.einpacken.Custom = true
zitemRadfahrerZeitungS41.Commands.einpacken.WorksWithAll = true
zitemRadfahrerZeitungS45 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemRadfahrerZeitungS45.Id = "217c637657be481d272e51e17af4e0f0"
zitemRadfahrerZeitungS45.Name = "Radfahrer Zeitung S.45"
zitemRadfahrerZeitungS45.Description = WWB_multiplatform_string("Zeitung S.45 mit dem Teil 2 von 2 f\195\188r das R\195\164tsel R-A-D<BR>\n~<BR>\nDie Zeitung findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/zeitung-s-45<BR>\nInventar Name: Zeitung S.45<BR>\nPasswort: kik")
zitemRadfahrerZeitungS45.Visible = true
zitemRadfahrerZeitungS45.Locked = false
zitemRadfahrerZeitungS45.Opened = false
zitemRadfahrerZeitungS45.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemRadfahrerZeitungS45.Media = zmediaRadfahrerZeitungS45
zitemRadfahrerZeitungS45.Icon = zmediaRadfahrerZeitungS45_32
zitemRadfahrerZeitungS45.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemRadfahrerZeitungS45.Commands.auspacken.Id = "53cc796f702ad59eedcfc5d4253582b7"
zitemRadfahrerZeitungS45.Commands.auspacken.Custom = true
zitemRadfahrerZeitungS45.Commands.auspacken.WorksWithAll = true
zitemRadfahrerZeitungS45.Commands.Details.Id = "35f90de3a4a5f92f7e5985e6bc8e4dca"
zitemRadfahrerZeitungS45.Commands.Details.Custom = true
zitemRadfahrerZeitungS45.Commands.Details.WorksWithAll = true
zitemRadfahrerZeitungS45.Commands.einpacken.Id = "16ddb8bb631301143ac4fda7d2612be4"
zitemRadfahrerZeitungS45.Commands.einpacken.Custom = true
zitemRadfahrerZeitungS45.Commands.einpacken.WorksWithAll = true
zitemSchliessfach = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchliessfach_})
zitemSchliessfach.Id = "1933f3716241bc50a6f58d2a27404c59"
zitemSchliessfach.Name = "Schliessfach"
zitemSchliessfach.Description = ""
zitemSchliessfach.Visible = false
zitemSchliessfach.Locked = false
zitemSchliessfach.Opened = false
zitemSchliessfach.ObjectLocation = ZonePoint(52.436129316043626, 13.531921505928045, 0)
zitemSchliessfach.Media = zmediaSchliessfach
zitemSchliessfach.Icon = zmediaSchliessfach_32
zitemSchliessfach.Commands = {
  Codeeingeben = Wherigo.ZCommand({
    Text = "Code eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Inhaltansehen = Wherigo.ZCommand({
    Text = "Inhalt ansehen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  schliessen = Wherigo.ZCommand({
    Text = "schliessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemSchliessfach.Commands.Codeeingeben.Id = "c5e348b73701df2338a323dcb6556a99"
zitemSchliessfach.Commands.Codeeingeben.Custom = true
zitemSchliessfach.Commands.Codeeingeben.WorksWithAll = true
zitemSchliessfach.Commands.Inhaltansehen.Id = "6aa16757951e1fdf67076ad7bf9ea724"
zitemSchliessfach.Commands.Inhaltansehen.Custom = true
zitemSchliessfach.Commands.Inhaltansehen.WorksWithAll = true
zitemSchliessfach.Commands.schliessen.Id = "93bfba5dcb167c97b61e446ea62b158f"
zitemSchliessfach.Commands.schliessen.Custom = true
zitemSchliessfach.Commands.schliessen.WorksWithAll = true
zitemSchutzhtteInnen = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchutzhtte_})
zitemSchutzhtteInnen.Id = "eb86f1f7fefd5d6bcabd658b4ec3e41c"
zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte Innen")
zitemSchutzhtteInnen.Description = ""
zitemSchutzhtteInnen.Visible = false
zitemSchutzhtteInnen.Locked = false
zitemSchutzhtteInnen.Opened = false
zitemSchutzhtteInnen.ObjectLocation = ZonePoint(52.42916666666667, 13.623083333333334, 0)
zitemSchutzhtteInnen.Media = zmediaNebelSHFront
zitemSchutzhtteInnen.Commands = {
  EingangsSeite = Wherigo.ZCommand({
    Text = "Eingangs Seite",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  FensterSeite = Wherigo.ZCommand({
    Text = "Fenster Seite",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  linkeSeite = Wherigo.ZCommand({
    Text = "linke Seite",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  rechteSeite = Wherigo.ZCommand({
    Text = "rechte Seite",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemSchutzhtteInnen.Commands.EingangsSeite.Id = "842668d4b2bedc096ff98ab647b11b2d"
zitemSchutzhtteInnen.Commands.EingangsSeite.Custom = true
zitemSchutzhtteInnen.Commands.EingangsSeite.WorksWithAll = true
zitemSchutzhtteInnen.Commands.FensterSeite.Id = "8b3234287e0b3149303445143467dac8"
zitemSchutzhtteInnen.Commands.FensterSeite.Custom = true
zitemSchutzhtteInnen.Commands.FensterSeite.WorksWithAll = true
zitemSchutzhtteInnen.Commands.linkeSeite.Id = "51cf0916de0c05fe947f10813b29f0a3"
zitemSchutzhtteInnen.Commands.linkeSeite.Custom = true
zitemSchutzhtteInnen.Commands.linkeSeite.WorksWithAll = true
zitemSchutzhtteInnen.Commands.rechteSeite.Id = "2e011ca2338b82ec56338a179dd69fe5"
zitemSchutzhtteInnen.Commands.rechteSeite.Custom = true
zitemSchutzhtteInnen.Commands.rechteSeite.WorksWithAll = true
zitemSchwarzlicht = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneKoffer})
zitemSchwarzlicht.Id = "d05f38b9108e3336affd57c5e7e3e855"
zitemSchwarzlicht.Name = "Schwarzlicht"
zitemSchwarzlicht.Description = ""
zitemSchwarzlicht.Visible = true
zitemSchwarzlicht.Locked = false
zitemSchwarzlicht.Opened = false
zitemSchwarzlicht.ObjectLocation = ZonePoint(52.436631865291055, 13.624427470906557, 0)
zitemSchwarzlicht.Media = zmediaLampeaus
zitemSchwarzlicht.Icon = zmediaLampeaus_32
zitemSchwarzlicht.Commands = {
  aus = Wherigo.ZCommand({
    Text = "aus",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  ein = Wherigo.ZCommand({
    Text = "ein",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemSchwarzlicht.Commands.aus.Id = "fb885f8b7c56addf0d58dd7c667c61fd"
zitemSchwarzlicht.Commands.aus.Custom = true
zitemSchwarzlicht.Commands.aus.WorksWithAll = true
zitemSchwarzlicht.Commands.auspacken.Id = "c804713ed63f41f0c1a372a631aa8fd0"
zitemSchwarzlicht.Commands.auspacken.Custom = true
zitemSchwarzlicht.Commands.auspacken.WorksWithAll = true
zitemSchwarzlicht.Commands.ein.Id = "56389a0bf7dd74c20ed58381feaf5ce9"
zitemSchwarzlicht.Commands.ein.Custom = true
zitemSchwarzlicht.Commands.ein.WorksWithAll = true
zitemSchwarzlicht.Commands.einpacken.Id = "cf09d9329c274de912da4c060ad08006"
zitemSchwarzlicht.Commands.einpacken.Custom = true
zitemSchwarzlicht.Commands.einpacken.WorksWithAll = true
zitemSpeichern = Wherigo.ZItem(cartMighlaTeil1v3)
zitemSpeichern.Id = "1eb0c69749ca3ec444273fdab502ff32"
zitemSpeichern.Name = "Speichern"
zitemSpeichern.Description = [[
Spiel zwischenspeichern.<BR>
Besonders zu empfehlen bevor auf die Homepage Mighla gewechselt wird.]]
zitemSpeichern.Visible = true
zitemSpeichern.Locked = false
zitemSpeichern.Opened = false
zitemSpeichern.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemSpeichern.Media = zmediaDiskette
zitemSpeichern.Icon = zmediaDiskette_32
zitemSpeichern.Commands = {
  speichern = Wherigo.ZCommand({
    Text = "speichern",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemSpeichern.Commands.speichern.Id = "d263a879cc43365495a6648e1ff0dbac"
zitemSpeichern.Commands.speichern.Custom = true
zitemSpeichern.Commands.speichern.WorksWithAll = true
zitemStadtkasse1von3 = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchliessfach_})
zitemStadtkasse1von3.Id = "1179f5dab141f8d23a88aff2378a037a"
zitemStadtkasse1von3.Name = "Stadtkasse 1 von 3"
zitemStadtkasse1von3.Description = [[
Die Stadtkasse findest Du auch in Deiner Akte:<BR>
~<BR>
geomcwood.wixsite.com/mighla/stadtkasse1<BR>
Inventar Name: Stadtkasse 1<BR>
Passwort: tut]]
zitemStadtkasse1von3.Visible = false
zitemStadtkasse1von3.Locked = true
zitemStadtkasse1von3.Opened = false
zitemStadtkasse1von3.ObjectLocation = ZonePoint(52.436129316043626, 13.531921505928045, 0)
zitemStadtkasse1von3.Media = zmediaStadtkasse1
zitemStadtkasse1von3.Icon = zmediaStadtkasse_32
zitemStadtkasse1von3.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  nehmen = Wherigo.ZCommand({
    Text = "nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemStadtkasse1von3.Commands.auspacken.Id = "ccdfed4f8657cc7f42605f096cd882bc"
zitemStadtkasse1von3.Commands.auspacken.Custom = true
zitemStadtkasse1von3.Commands.auspacken.WorksWithAll = true
zitemStadtkasse1von3.Commands.einpacken.Id = "9302eea97c96cc092928fab2e1a3cfb6"
zitemStadtkasse1von3.Commands.einpacken.Custom = true
zitemStadtkasse1von3.Commands.einpacken.WorksWithAll = true
zitemStadtkasse1von3.Commands.nehmen.Id = "d02d27abc6e1d5f8b205d229379b04b8"
zitemStadtkasse1von3.Commands.nehmen.Custom = true
zitemStadtkasse1von3.Commands.nehmen.WorksWithAll = true
zitemStadtkasse2von3 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemStadtkasse2von3.Id = "99e4e724f44e5ef9b1717797db60ea0e"
zitemStadtkasse2von3.Name = "Stadtkasse 2 von 3"
zitemStadtkasse2von3.Description = [[
Die Stadtkasse findest Du auch in Deiner Akte:<BR>
~<BR>
geomcwood.wixsite.com/mighla/stadtkasse2<BR>
Inventar Name: Stadtkasse 2<BR>
Passwort: sos]]
zitemStadtkasse2von3.Visible = true
zitemStadtkasse2von3.Locked = true
zitemStadtkasse2von3.Opened = false
zitemStadtkasse2von3.ObjectLocation = ZonePoint(52.4385760752797, 13.51519525051117, 0)
zitemStadtkasse2von3.Media = zmediaStadtkasse2
zitemStadtkasse2von3.Icon = zmediaStadtkasse_32
zitemStadtkasse2von3.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemStadtkasse2von3.Commands.auspacken.Id = "c6112b12f10337c7ccdf5226caab41d7"
zitemStadtkasse2von3.Commands.auspacken.Custom = true
zitemStadtkasse2von3.Commands.auspacken.WorksWithAll = true
zitemStadtkasse2von3.Commands.einpacken.Id = "e563c4c17d72c08c24415a78b6db9ddb"
zitemStadtkasse2von3.Commands.einpacken.Custom = true
zitemStadtkasse2von3.Commands.einpacken.WorksWithAll = true
zitemStadtkasse3von3 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemStadtkasse3von3.Id = "0224216783c7a2237f34b2382b52cca6"
zitemStadtkasse3von3.Name = "Stadtkasse 3 von 3"
zitemStadtkasse3von3.Description = [[
Die Stadtkasse findest Du auch in Deiner Akte:<BR>
~<BR>
geomcwood.wixsite.com/mighla/stadtkasse3<BR>
Inventar Name: Stadtkasse 3<BR>
Passwort: ghg]]
zitemStadtkasse3von3.Visible = true
zitemStadtkasse3von3.Locked = false
zitemStadtkasse3von3.Opened = false
zitemStadtkasse3von3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemStadtkasse3von3.Media = zmediaStadtkasse3
zitemStadtkasse3von3.Icon = zmediaStadtkasse_32
zitemStadtkasse3von3.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemStadtkasse3von3.Commands.auspacken.Id = "7af326bf30d8cb0cb19eac77efcdd838"
zitemStadtkasse3von3.Commands.auspacken.Custom = true
zitemStadtkasse3von3.Commands.auspacken.WorksWithAll = true
zitemStadtkasse3von3.Commands.einpacken.Id = "fb10ec66fc176526cae9bce6d46c1566"
zitemStadtkasse3von3.Commands.einpacken.Custom = true
zitemStadtkasse3von3.Commands.einpacken.WorksWithAll = true
zitemStadtplanMggelpark = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneStartzone_})
zitemStadtplanMggelpark.Id = "03ea9f0abf5df0993c50308b4b19b982"
zitemStadtplanMggelpark.Name = WWB_multiplatform_string("Stadtplan M\195\188ggelpark")
zitemStadtplanMggelpark.Description = WWB_multiplatform_string("Der Stadtplan beinhaltet: <BR>\nden Teil 1 von 4 vom R\195\164tsel \"Wort f\195\188r Wort\" (WfW) <BR>\nund einige Informationen zum M\195\188ggelpark<BR>\n~<BR>\nDen Plan findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/stadtplan1<BR>\nInventar Name: Stadtplan 1<BR>\nPasswort: huh")
zitemStadtplanMggelpark.Visible = false
zitemStadtplanMggelpark.Locked = true
zitemStadtplanMggelpark.Opened = false
zitemStadtplanMggelpark.ObjectLocation = ZonePoint(52.43545059413764, 13.511265814304375, 0)
zitemStadtplanMggelpark.Media = zmediaStadtplanMueggelpark
zitemStadtplanMggelpark.Icon = zmediaStadtplanMueggelpark_32
zitemStadtplanMggelpark.Commands = {
  anschauen = Wherigo.ZCommand({
    Text = "anschauen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  aufheben = Wherigo.ZCommand({
    Text = "aufheben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Briefnehmen = Wherigo.ZCommand({
    Text = "Brief nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemStadtplanMggelpark.Commands.anschauen.Id = "94f9cb0ee744248c01cc1f4dbeffa20f"
zitemStadtplanMggelpark.Commands.anschauen.Custom = true
zitemStadtplanMggelpark.Commands.anschauen.WorksWithAll = true
zitemStadtplanMggelpark.Commands.aufheben.Id = "04daa3f214e58b029b61abe0688079d2"
zitemStadtplanMggelpark.Commands.aufheben.Custom = true
zitemStadtplanMggelpark.Commands.aufheben.WorksWithAll = true
zitemStadtplanMggelpark.Commands.auspacken.Id = "52bed5a9d984304b273731103e4e1060"
zitemStadtplanMggelpark.Commands.auspacken.Custom = true
zitemStadtplanMggelpark.Commands.auspacken.WorksWithAll = true
zitemStadtplanMggelpark.Commands.Briefnehmen.Id = "514490f27817ace97c0fc9f867abf694"
zitemStadtplanMggelpark.Commands.Briefnehmen.Custom = true
zitemStadtplanMggelpark.Commands.Briefnehmen.WorksWithAll = true
zitemStadtplanMggelpark.Commands.Details.Id = "ce8988a4012dec8bbd82a0f79c740534"
zitemStadtplanMggelpark.Commands.Details.Custom = true
zitemStadtplanMggelpark.Commands.Details.WorksWithAll = true
zitemStadtplanMggelpark.Commands.einpacken.Id = "89ecd700def41d88411001c6ad52600a"
zitemStadtplanMggelpark.Commands.einpacken.Custom = true
zitemStadtplanMggelpark.Commands.einpacken.WorksWithAll = true
zitemStadtplanMggelwald = Wherigo.ZItem({Cartridge = cartMighlaTeil1v3, Container = zoneSchliessfach_})
zitemStadtplanMggelwald.Id = "d64ef59672f8744fdbb67db5276f2cc5"
zitemStadtplanMggelwald.Name = WWB_multiplatform_string("Stadtplan M\195\188ggelwald")
zitemStadtplanMggelwald.Description = WWB_multiplatform_string("Stadtplan, Auszug mit Informationen zum M\195\188ggelwald<BR>\nDie Karte findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/stadtplan2<BR>\nInventar Name: Stadtplan 2<BR>\nPasswort: rer<BR>\n")
zitemStadtplanMggelwald.Visible = false
zitemStadtplanMggelwald.Locked = true
zitemStadtplanMggelwald.Opened = false
zitemStadtplanMggelwald.ObjectLocation = ZonePoint(52.436129316043626, 13.531921505928045, 0)
zitemStadtplanMggelwald.Media = zmediaStadtplanMggelwald
zitemStadtplanMggelwald.Icon = zmediaStadtplanMggelwald_32
zitemStadtplanMggelwald.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  nehmen = Wherigo.ZCommand({
    Text = "nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemStadtplanMggelwald.Commands.auspacken.Id = "e0ccfe706905dfcb08ef8bfb3775f6de"
zitemStadtplanMggelwald.Commands.auspacken.Custom = true
zitemStadtplanMggelwald.Commands.auspacken.WorksWithAll = true
zitemStadtplanMggelwald.Commands.Details.Id = "0ca84ab1b1fcfabfb5d2405a733ff6f8"
zitemStadtplanMggelwald.Commands.Details.Custom = true
zitemStadtplanMggelwald.Commands.Details.WorksWithAll = true
zitemStadtplanMggelwald.Commands.einpacken.Id = "183fca15317b429bbfebf0ae8db6c50e"
zitemStadtplanMggelwald.Commands.einpacken.Custom = true
zitemStadtplanMggelwald.Commands.einpacken.WorksWithAll = true
zitemStadtplanMggelwald.Commands.nehmen.Id = "8a17f28040ef354a23ba029671f348ff"
zitemStadtplanMggelwald.Commands.nehmen.Custom = true
zitemStadtplanMggelwald.Commands.nehmen.WorksWithAll = true
zitemTimerTeppich = Wherigo.ZItem(cartMighlaTeil1v3)
zitemTimerTeppich.Id = "78ec86f13c5c4da141be24c25ca28b57"
zitemTimerTeppich.Name = "Timer Teppich"
zitemTimerTeppich.Description = ""
zitemTimerTeppich.Visible = true
zitemTimerTeppich.Locked = false
zitemTimerTeppich.Opened = false
zitemTimerTeppich.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemTreibgut = Wherigo.ZItem(cartMighlaTeil1v3)
zitemTreibgut.Id = "eced857a3182e956d821d342f04affdd"
zitemTreibgut.Name = "Treibgut"
zitemTreibgut.Description = ""
zitemTreibgut.Visible = true
zitemTreibgut.Locked = false
zitemTreibgut.Opened = false
zitemTreibgut.ObjectLocation = ZonePoint(52.43585855923034, 13.530414104461657, 0)
zitemTreibgut.Media = zmediaTreibgutzu
zitemTreibgut.Icon = zmediaTreibgutzu_32
zitemTreibgut.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Codeeingeben = Wherigo.ZCommand({
    Text = "Code eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ffnen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("\195\182ffnen", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Inhaltentnehmen = Wherigo.ZCommand({
    Text = " Inhalt entnehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  schlieen = Wherigo.ZCommand({
    Text = WWB_multiplatform_string("schlie\195\159en", {EmulatorGSP = 1, PocketPC = 1}),
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemTreibgut.Commands.auspacken.Id = "1d64b4179aa718b2393558e08913eb3f"
zitemTreibgut.Commands.auspacken.Custom = true
zitemTreibgut.Commands.auspacken.WorksWithAll = true
zitemTreibgut.Commands.Codeeingeben.Id = "ec6531e94d4bf65632df26d1357579e3"
zitemTreibgut.Commands.Codeeingeben.Custom = true
zitemTreibgut.Commands.Codeeingeben.WorksWithAll = true
zitemTreibgut.Commands.ffnen.Id = "f8cb0034e40c8ebcaf9c621e279917e0"
zitemTreibgut.Commands.ffnen.Custom = true
zitemTreibgut.Commands.ffnen.WorksWithAll = true
zitemTreibgut.Commands.Inhaltentnehmen.Id = "b447a9a19d3d63ce9e11a5335128fbed"
zitemTreibgut.Commands.Inhaltentnehmen.Custom = true
zitemTreibgut.Commands.Inhaltentnehmen.WorksWithAll = true
zitemTreibgut.Commands.schlieen.Id = "46ef0a12683ae66e515c94315f53883a"
zitemTreibgut.Commands.schlieen.Custom = true
zitemTreibgut.Commands.schlieen.WorksWithAll = true
zitemTruhe = Wherigo.ZItem(cartMighlaTeil1v3)
zitemTruhe.Id = "2add0d1420f146546a3ea90d64980eff"
zitemTruhe.Name = "Truhe"
zitemTruhe.Description = ""
zitemTruhe.Visible = true
zitemTruhe.Locked = false
zitemTruhe.Opened = false
zitemTruhe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemTruhe.Media = zmediaTruhezu
zitemTruhe.Icon = zmediaTruhezu_32
zitemTruhe.Commands = {
  _1Hilfe = Wherigo.ZCommand({
    Text = "1. Hilfe",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ansehen = Wherigo.ZCommand({
    Text = "ansehen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Briefnehmen = Wherigo.ZCommand({
    Text = "Brief nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Codeeingeben = Wherigo.ZCommand({
    Text = "Code eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Pergamentnehmen = Wherigo.ZCommand({
    Text = "Pergament nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  ZauberCodeeingeben = Wherigo.ZCommand({
    Text = "Zauber Code eingeben",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemTruhe.Commands._1Hilfe.Id = "e6b637c7726cb93e76646ff39371f062"
zitemTruhe.Commands._1Hilfe.Custom = true
zitemTruhe.Commands._1Hilfe.WorksWithAll = true
zitemTruhe.Commands.ansehen.Id = "0071be6ee518a9e0c52bc8797ac64834"
zitemTruhe.Commands.ansehen.Custom = true
zitemTruhe.Commands.ansehen.WorksWithAll = true
zitemTruhe.Commands.Briefnehmen.Id = "e8f74f895ba4772fd14010d91aec0537"
zitemTruhe.Commands.Briefnehmen.Custom = true
zitemTruhe.Commands.Briefnehmen.WorksWithAll = true
zitemTruhe.Commands.Codeeingeben.Id = "e27df45d2c18ff8b5a38a64aaa744e0a"
zitemTruhe.Commands.Codeeingeben.Custom = true
zitemTruhe.Commands.Codeeingeben.WorksWithAll = true
zitemTruhe.Commands.einpacken.Id = "a52002cc9c16eacb979337be473b0f12"
zitemTruhe.Commands.einpacken.Custom = true
zitemTruhe.Commands.einpacken.WorksWithAll = true
zitemTruhe.Commands.Pergamentnehmen.Id = "2221783ae1506bef5670cbabb189229c"
zitemTruhe.Commands.Pergamentnehmen.Custom = true
zitemTruhe.Commands.Pergamentnehmen.WorksWithAll = true
zitemTruhe.Commands.ZauberCodeeingeben.Id = "2544844042a4a6430d56b658abe250dd"
zitemTruhe.Commands.ZauberCodeeingeben.Custom = true
zitemTruhe.Commands.ZauberCodeeingeben.WorksWithAll = true
zitemUnlockCodeT2 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemUnlockCodeT2.Id = "75be567ee455aed25a4ce1d397e9e32c"
zitemUnlockCodeT2.Name = "Unlock Code T2"
zitemUnlockCodeT2.Description = WWB_multiplatform_string("Hier kannst Du Dir den Unlock Code f\195\188r das Loggen des Wherigo auf Wherigo.com ansehen.")
zitemUnlockCodeT2.Visible = true
zitemUnlockCodeT2.Locked = false
zitemUnlockCodeT2.Opened = false
zitemUnlockCodeT2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemUnlockCodeT2.Media = zmediaLogo
zitemUnlockCodeT2.Icon = zmediaLogo_32
zitemUnlockCodeT2.Commands = {
  Codeansehen = Wherigo.ZCommand({
    Text = "Code ansehen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemUnlockCodeT2.Commands.Codeansehen.Id = "c85a47af4395b4f4dfee9159e223655d"
zitemUnlockCodeT2.Commands.Codeansehen.Custom = true
zitemUnlockCodeT2.Commands.Codeansehen.WorksWithAll = true
zitemUnlockCodeTeil1 = Wherigo.ZItem(cartMighlaTeil1v3)
zitemUnlockCodeTeil1.Id = "b915d9ee3e407163df1a392b1220a966"
zitemUnlockCodeTeil1.Name = "Unlock Code Teil 1"
zitemUnlockCodeTeil1.Description = WWB_multiplatform_string("Hier kannst Du Dir den Unlock Code f\195\188r das Loggen des Wherigo auf Wherigo.com ansehen.")
zitemUnlockCodeTeil1.Visible = true
zitemUnlockCodeTeil1.Locked = false
zitemUnlockCodeTeil1.Opened = false
zitemUnlockCodeTeil1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemUnlockCodeTeil1.Media = zmediaLogo
zitemUnlockCodeTeil1.Icon = zmediaLogo_32
zitemUnlockCodeTeil1.Commands = {
  Codeansehen = Wherigo.ZCommand({
    Text = "Code ansehen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemUnlockCodeTeil1.Commands.Codeansehen.Id = "08458e0783017d39770fa1e0a8fbacdc"
zitemUnlockCodeTeil1.Commands.Codeansehen.Custom = true
zitemUnlockCodeTeil1.Commands.Codeansehen.WorksWithAll = true
zitemZeichnungvonZille = Wherigo.ZItem(cartMighlaTeil1v3)
zitemZeichnungvonZille.Id = "2d63b392388c885a95d186db2757682d"
zitemZeichnungvonZille.Name = "Zeichnung von Zille"
zitemZeichnungvonZille.Description = WWB_multiplatform_string("Zeichnung von Zille mit Teil 2 von 4 vom R\195\164tsel \"Wort f\195\188r Wort\" (WfW)<BR>\n~<BR>\nDie Zeichnung findest Du auch in Deiner Akte:<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla/bild<BR>\nInventar Name: Bild<BR>\nPasswort: nun")
zitemZeichnungvonZille.Visible = true
zitemZeichnungvonZille.Locked = true
zitemZeichnungvonZille.Opened = false
zitemZeichnungvonZille.ObjectLocation = ZonePoint(52.44067550099516, 13.51268470287323, 0)
zitemZeichnungvonZille.Media = zmediaZille_Zeichnung
zitemZeichnungvonZille.Icon = zmediaZille_Zeichnung_32
zitemZeichnungvonZille.Commands = {
  auspacken = Wherigo.ZCommand({
    Text = "auspacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Details = Wherigo.ZCommand({
    Text = "Details",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  einpacken = Wherigo.ZCommand({
    Text = "einpacken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemZeichnungvonZille.Commands.auspacken.Id = "841be2d42600f6ae3645d160111a856c"
zitemZeichnungvonZille.Commands.auspacken.Custom = true
zitemZeichnungvonZille.Commands.auspacken.WorksWithAll = true
zitemZeichnungvonZille.Commands.Details.Id = "72c42c75d1300810fff1573e3c4680ee"
zitemZeichnungvonZille.Commands.Details.Custom = true
zitemZeichnungvonZille.Commands.Details.WorksWithAll = true
zitemZeichnungvonZille.Commands.einpacken.Id = "fc6f1d059e9af169399d235f7df30238"
zitemZeichnungvonZille.Commands.einpacken.Custom = true
zitemZeichnungvonZille.Commands.einpacken.WorksWithAll = true
ztaskanrufen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskanrufen.Id = "04268fc46dca3cf6037d58d3a9439827"
ztaskanrufen.Name = "anrufen"
ztaskanrufen.CorrectState = "None"
ztaskanrufen.Description = ""
ztaskanrufen.Visible = true
ztaskanrufen.Active = false
ztaskanrufen.Complete = false
ztaskAufdenBriefwarten = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufdenBriefwarten.Id = "1ef730d4bd0793ed288327d7b39d9d43"
ztaskAufdenBriefwarten.Name = "Auf den Brief warten"
ztaskAufdenBriefwarten.CorrectState = "None"
ztaskAufdenBriefwarten.Description = "Warte auf den Brief der Reiseagentur, vielleicht hast Du ja die Reise gewonnen."
ztaskAufdenBriefwarten.Visible = true
ztaskAufdenBriefwarten.Active = false
ztaskAufdenBriefwarten.Complete = false
ztaskAufdenBriefwarten.Media = zmediaAufgabe
ztaskAufdenBriefwarten.Icon = zmediaAufgabe_32
ztaskAufMighlawarten = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufMighlawarten.Id = "a9cc97adfe2b3444afe94c30f8827b14"
ztaskAufMighlawarten.Name = "Auf Mighla warten"
ztaskAufMighlawarten.CorrectState = "None"
ztaskAufMighlawarten.Description = "Warte hier auf Mighla."
ztaskAufMighlawarten.Visible = false
ztaskAufMighlawarten.Active = true
ztaskAufMighlawarten.Complete = false
ztaskAufMighlawarten.Media = zmediaAufgabe_32
ztaskAufMighlawarten.Icon = zmediaAufgabe_32
ztaskAufgabe1lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe1lsen.Id = "5462fe7aec7287d5d65397bd25a475f2"
ztaskAufgabe1lsen.Name = WWB_multiplatform_string("Aufgabe 1 l\195\182sen")
ztaskAufgabe1lsen.CorrectState = "None"
ztaskAufgabe1lsen.Description = WWB_multiplatform_string("L\195\182se das R\195\164tsel \"Kofferschl\195\188ssel\" und \195\182ffne den Koffer, Du hast nun alle notwendigen Informationen.<BR>\nHast Du Dir den Brief im Stadtplan angesehen?")
ztaskAufgabe1lsen.Visible = true
ztaskAufgabe1lsen.Active = false
ztaskAufgabe1lsen.Complete = false
ztaskAufgabe1lsen.Media = zmediaAufgabe
ztaskAufgabe1lsen.Icon = zmediaAufgabe_32
ztaskAufgabe2lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe2lsen.Id = "4a63bcac370ba10544c99a66cfb224f5"
ztaskAufgabe2lsen.Name = WWB_multiplatform_string("Aufgabe 2 l\195\182sen")
ztaskAufgabe2lsen.CorrectState = "None"
ztaskAufgabe2lsen.Description = WWB_multiplatform_string("Du hast alle Informationen um das R\195\164tsel \"Wort f\195\188r Wort\" (WfW) zu l\195\182sen. Erst die L\195\182sung sagt Dir wie es im Teil 2 weitergeht.<BR>\nFalls Du Hilfe f\195\188r das R\195\164tsel ben\195\182tigst, schaue Dir das Foto vom Voigt noch einmal an.")
ztaskAufgabe2lsen.Visible = true
ztaskAufgabe2lsen.Active = false
ztaskAufgabe2lsen.Complete = false
ztaskAufgabe2lsen.Media = zmediaAufgabe
ztaskAufgabe2lsen.Icon = zmediaAufgabe_32
ztaskAufgabe3lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe3lsen.Id = "0afcc46e837ec382227f529c34b1a48c"
ztaskAufgabe3lsen.Name = WWB_multiplatform_string("Aufgabe 3 l\195\182sen")
ztaskAufgabe3lsen.CorrectState = "None"
ztaskAufgabe3lsen.Description = WWB_multiplatform_string("Du hast alle Informationen um das Schlie\195\159fach zu \195\182ffnen. WfW und der Hinweis sind Voraussetzung.")
ztaskAufgabe3lsen.Visible = true
ztaskAufgabe3lsen.Active = false
ztaskAufgabe3lsen.Complete = false
ztaskAufgabe3lsen.Media = zmediaAufgabe
ztaskAufgabe3lsen.Icon = zmediaAufgabe_32
ztaskAufgabe4lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe4lsen.Id = "2a68812da159f453e2f95be345293aa8"
ztaskAufgabe4lsen.Name = WWB_multiplatform_string("Aufgabe 4 l\195\182sen")
ztaskAufgabe4lsen.CorrectState = "None"
ztaskAufgabe4lsen.Description = WWB_multiplatform_string("Du besitzt mit dem Brief 3 vom Voigt die Information um das R\195\164tsel Navigation zu l\195\182sen, so erh\195\164ltst Du die Koordinaten f\195\188r die Taucher.")
ztaskAufgabe4lsen.Visible = true
ztaskAufgabe4lsen.Active = false
ztaskAufgabe4lsen.Complete = false
ztaskAufgabe4lsen.Media = zmediaAufgabe
ztaskAufgabe4lsen.Icon = zmediaAufgabe_32
ztaskAufgabe5lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe5lsen.Id = "6eb45383dddca53927c93bc20e7f7776"
ztaskAufgabe5lsen.Name = WWB_multiplatform_string("Aufgabe 5 l\195\182sen")
ztaskAufgabe5lsen.CorrectState = "None"
ztaskAufgabe5lsen.Description = WWB_multiplatform_string("Du besitzt jetzt alle Informationen um das R\195\164tsel \"Stadtkasse\" zu l\195\182sen und kannst so das \"Treibgut\" \195\182ffnen. Denke an die Information vom Taucher!<BR>\n\"Reihenfolge von rechts nach links\"")
ztaskAufgabe5lsen.Visible = true
ztaskAufgabe5lsen.Active = false
ztaskAufgabe5lsen.Complete = false
ztaskAufgabe5lsen.Media = zmediaAufgabe
ztaskAufgabe5lsen.Icon = zmediaAufgabe_32
ztaskAufgabe6lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe6lsen.Id = "ed016d74554db4e0a931bb3fdd37912e"
ztaskAufgabe6lsen.Name = WWB_multiplatform_string("Aufgabe 6 l\195\182sen")
ztaskAufgabe6lsen.CorrectState = "None"
ztaskAufgabe6lsen.Description = WWB_multiplatform_string("Wenn Du das Treibgut ge\195\182ffnet hast besitzt Du nun alle Informationen um das R\195\164tsel R-A-D zu l\195\182sen. Mit der L\195\182sung kannst das Schloss im See \195\182ffnen lassen.")
ztaskAufgabe6lsen.Visible = true
ztaskAufgabe6lsen.Active = false
ztaskAufgabe6lsen.Complete = false
ztaskAufgabe6lsen.Media = zmediaAufgabe
ztaskAufgabe6lsen.Icon = zmediaAufgabe_32
ztaskAufgabe7lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe7lsen.Id = "4052b8674832ca64f6f227fc7337b0b1"
ztaskAufgabe7lsen.Name = WWB_multiplatform_string("Aufgabe 7 l\195\182sen")
ztaskAufgabe7lsen.CorrectState = "None"
ztaskAufgabe7lsen.Description = WWB_multiplatform_string("Du besitzt alle Informationen um das R\195\164tsel vom Truhenboden zu l\195\182sen. Hast Du es gel\195\182st, erf\195\164hrst Du wie es weitergeht.<BR>\nFalls Du Hilfe ben\195\182tigst schaue Dir die Truhe noch einmal an.")
ztaskAufgabe7lsen.Visible = true
ztaskAufgabe7lsen.Active = false
ztaskAufgabe7lsen.Complete = false
ztaskAufgabe7lsen.Media = zmediaAufgabe
ztaskAufgabe7lsen.Icon = zmediaAufgabe_32
ztaskAufgabe8lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe8lsen.Id = "9760052d85b198d5094409c9141a320d"
ztaskAufgabe8lsen.Name = WWB_multiplatform_string("Aufgabe 8 l\195\182sen")
ztaskAufgabe8lsen.CorrectState = "None"
ztaskAufgabe8lsen.Description = WWB_multiplatform_string("Ermittle aus den Zeichen in der Schutzh\195\188tte einen Code. Gib den Code in die Truhe ein.")
ztaskAufgabe8lsen.Visible = true
ztaskAufgabe8lsen.Active = false
ztaskAufgabe8lsen.Complete = false
ztaskAufgabe8lsen.Media = zmediaAufgabe
ztaskAufgabe8lsen.Icon = zmediaAufgabe_32
ztaskAufgabe9lsen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskAufgabe9lsen.Id = "6cfea06e4bd57cc544aa8904b6e9118b"
ztaskAufgabe9lsen.Name = WWB_multiplatform_string("Aufgabe 9 l\195\182sen")
ztaskAufgabe9lsen.CorrectState = "None"
ztaskAufgabe9lsen.Description = WWB_multiplatform_string("Du besitzt jetzt alle Informationen um das R\195\164tsel Pellet Zauberei zu l\195\182sen, gib den Code in die Truhe ein.")
ztaskAufgabe9lsen.Visible = true
ztaskAufgabe9lsen.Active = false
ztaskAufgabe9lsen.Complete = false
ztaskAufgabe9lsen.Media = zmediaAufgabe
ztaskAufgabe9lsen.Icon = zmediaAufgabe_32
ztaskBadebuchtaufsuchen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskBadebuchtaufsuchen.Id = "bd19478b90ecdc34956bd78b994b1c7c"
ztaskBadebuchtaufsuchen.Name = "Badebucht aufsuchen"
ztaskBadebuchtaufsuchen.CorrectState = "None"
ztaskBadebuchtaufsuchen.Description = WWB_multiplatform_string("Gehe vom letzten Treffen mit den Tauchern zur Badebucht in ca. 800 Meter Entfernung Richtung S\195\188den.")
ztaskBadebuchtaufsuchen.Visible = true
ztaskBadebuchtaufsuchen.Active = false
ztaskBadebuchtaufsuchen.Complete = false
ztaskBadebuchtaufsuchen.Media = zmediaAufgabe
ztaskBadebuchtaufsuchen.Icon = zmediaAufgabe_32
ztaskBriefgelesen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskBriefgelesen.Id = "89dbadd5412069d91241b508b6331a7f"
ztaskBriefgelesen.Name = "Brief gelesen"
ztaskBriefgelesen.CorrectState = "None"
ztaskBriefgelesen.Description = ""
ztaskBriefgelesen.Visible = false
ztaskBriefgelesen.Active = false
ztaskBriefgelesen.Complete = false
ztaskBriefgelesen.Media = zmediaAufgabe
ztaskBrieflesen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskBrieflesen.Id = "627a596dc84f18c8f7efa793dc14c2c7"
ztaskBrieflesen.Name = "Brief lesen"
ztaskBrieflesen.CorrectState = "None"
ztaskBrieflesen.Description = "Den Brief von Kalle lesen."
ztaskBrieflesen.Visible = true
ztaskBrieflesen.Active = false
ztaskBrieflesen.Complete = false
ztaskBrieflesen.Media = zmediaAufgabe
ztaskBrieflesen.Icon = zmediaAufgabe_32
ztaskDasSpreeuferwechseln = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskDasSpreeuferwechseln.Id = "ed133055df5a4f8e4a0d3b58ac290f49"
ztaskDasSpreeuferwechseln.Name = "Das Spreeufer wechseln"
ztaskDasSpreeuferwechseln.CorrectState = "None"
ztaskDasSpreeuferwechseln.Description = "Gehe auf die andere Seite der Spree."
ztaskDasSpreeuferwechseln.Visible = true
ztaskDasSpreeuferwechseln.Active = false
ztaskDasSpreeuferwechseln.Complete = false
ztaskDasSpreeuferwechseln.Media = zmediaAufgabe
ztaskDasSpreeuferwechseln.Icon = zmediaAufgabe_32
ztaskDemHinweisfolgen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskDemHinweisfolgen.Id = "0fe6b9b3ac4687fd3aa4c56a04d5f8e3"
ztaskDemHinweisfolgen.Name = "Dem Hinweis folgen"
ztaskDemHinweisfolgen.CorrectState = "None"
ztaskDemHinweisfolgen.Description = "Folge dem Hinweis von Voigt. Er hatte etwas auf dem Stadtplan gesucht."
ztaskDemHinweisfolgen.Visible = true
ztaskDemHinweisfolgen.Active = false
ztaskDemHinweisfolgen.Complete = false
ztaskDemHinweisfolgen.Media = zmediaAufgabe
ztaskDemHinweisfolgen.Icon = zmediaAufgabe_32
ztaskEineNelkekaufen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskEineNelkekaufen.Id = "078f81ccea2a2378b052658031136faf"
ztaskEineNelkekaufen.Name = "Eine Nelke kaufen"
ztaskEineNelkekaufen.CorrectState = "None"
ztaskEineNelkekaufen.Description = "Kaufe eine Nelke bevor Du in den Biergarten gehst."
ztaskEineNelkekaufen.Visible = true
ztaskEineNelkekaufen.Active = false
ztaskEineNelkekaufen.Complete = false
ztaskEineNelkekaufen.Media = zmediaAufgabe
ztaskEineNelkekaufen.Icon = zmediaAufgabe_32
ztaskFindedasDokument = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskFindedasDokument.Id = "537cae8caa62ac7e29cbcc35b50bd384"
ztaskFindedasDokument.Name = "Finde das Dokument"
ztaskFindedasDokument.CorrectState = "None"
ztaskFindedasDokument.Description = WWB_multiplatform_string("Finden den Cache an den angegebenen Koordinaten und berge das Dokument.<BR>\n~<BR>\nHinweis: <BR>\nUm kaiserliche Telefonmuggel fernzuhalten wurden die Nord und S\195\188d Koordinaten auf dem Anrufbeantworter jeweils um 10 Minuten gek\195\188rzt. <BR>\nZ\195\164hle also 10 Minuten hinzu um den Cache zu finden!<BR>\n~<BR>\nz.B. 52 25.123' +10 = 52 25.133'")
ztaskFindedasDokument.Visible = true
ztaskFindedasDokument.Active = false
ztaskFindedasDokument.Complete = false
ztaskFindedasDokument.Media = zmediaAufgabe
ztaskFindedasDokument.Icon = zmediaAufgabe_32
ztaskFindedasSeglerheim = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskFindedasSeglerheim.Id = "d66f2b1512b26b88cd1fcc966f184878"
ztaskFindedasSeglerheim.Name = "Finde das Seglerheim"
ztaskFindedasSeglerheim.CorrectState = "None"
ztaskFindedasSeglerheim.Description = WWB_multiplatform_string("Wenn Du den Brief gelesen hast und die Karte vom M\195\188ggelwald in Deinem Besitz ist, wei\195\159t Du wo das Seglerheim ist.")
ztaskFindedasSeglerheim.Visible = true
ztaskFindedasSeglerheim.Active = false
ztaskFindedasSeglerheim.Complete = false
ztaskFindedasSeglerheim.Media = zmediaAufgabe
ztaskFindedasSeglerheim.Icon = zmediaAufgabe_32
ztaskFindedenHinweis = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskFindedenHinweis.Id = "cfbd53096505ef5e864acfb12d02effc"
ztaskFindedenHinweis.Name = "Finde den Hinweis"
ztaskFindedenHinweis.CorrectState = "None"
ztaskFindedenHinweis.Description = WWB_multiplatform_string("Finde den Ort wo der Hinweis versteckt ist. Wenn Du Aufgabe 2 gel\195\182st hast, wei\195\159t Du wo der Ort ist.")
ztaskFindedenHinweis.Visible = true
ztaskFindedenHinweis.Active = false
ztaskFindedenHinweis.Complete = false
ztaskFindedenHinweis.Media = zmediaAufgabe
ztaskFindedenHinweis.Icon = zmediaAufgabe_32
ztaskFotoboxffnen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskFotoboxffnen.Id = "2983beee2f9c133b575cc91f5bb04e1a"
ztaskFotoboxffnen.Name = WWB_multiplatform_string("Fotobox \195\182ffnen")
ztaskFotoboxffnen.CorrectState = "None"
ztaskFotoboxffnen.Description = WWB_multiplatform_string("Du hast die Fotobox von Zille bekommen, \195\182ffne sie und schaue Dir Foto 2 an.")
ztaskFotoboxffnen.Visible = false
ztaskFotoboxffnen.Active = true
ztaskFotoboxffnen.Complete = false
ztaskFotoboxffnen.Media = zmediaAufgabe
ztaskFotoboxffnen.Icon = zmediaAufgabe_32
ztaskFotoboxschlieen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskFotoboxschlieen.Id = "782c982b7d1f859c29d165632afdf145"
ztaskFotoboxschlieen.Name = WWB_multiplatform_string("Fotobox schlie\195\159en")
ztaskFotoboxschlieen.CorrectState = "None"
ztaskFotoboxschlieen.Description = WWB_multiplatform_string("schlie\195\159e die Fotobox um den \195\156berblick \195\188ber die sichtbaren Gegenst\195\164nde zu behalten.")
ztaskFotoboxschlieen.Visible = false
ztaskFotoboxschlieen.Active = true
ztaskFotoboxschlieen.Complete = false
ztaskFotoboxschlieen.Media = zmediaAufgabe
ztaskFotoboxschlieen.Icon = zmediaAufgabe_32
ztaskGegenstndeaufheben = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskGegenstndeaufheben.Id = "bb7c410c060b7b98707df045981ce73c"
ztaskGegenstndeaufheben.Name = WWB_multiplatform_string("Gegenst\195\164nde aufheben")
ztaskGegenstndeaufheben.CorrectState = "None"
ztaskGegenstndeaufheben.Description = ""
ztaskGegenstndeaufheben.Visible = false
ztaskGegenstndeaufheben.Active = false
ztaskGegenstndeaufheben.Complete = false
ztaskGegenstndeaufheben.Media = zmediaAufgabe
ztaskGegenstndemitnehmen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskGegenstndemitnehmen.Id = "22e3011db45d123db25ef1900ae2766b"
ztaskGegenstndemitnehmen.Name = WWB_multiplatform_string("Gegenst\195\164nde mitnehmen")
ztaskGegenstndemitnehmen.CorrectState = "None"
ztaskGegenstndemitnehmen.Description = WWB_multiplatform_string("Gehe zur\195\188ck,Du hast etwas vergessen mitzunehmen.")
ztaskGegenstndemitnehmen.Visible = false
ztaskGegenstndemitnehmen.Active = true
ztaskGegenstndemitnehmen.Complete = false
ztaskGegenstndemitnehmen.Media = zmediaAufgabe
ztaskGegenstndemitnehmen.Icon = zmediaAufgabe_32
ztaskImBiergartenaufKontaktwarten = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskImBiergartenaufKontaktwarten.Id = "f7f59108b11c9ea375224c9934432b2d"
ztaskImBiergartenaufKontaktwarten.Name = "Im Biergarten auf Kontakt warten"
ztaskImBiergartenaufKontaktwarten.CorrectState = "None"
ztaskImBiergartenaufKontaktwarten.Description = "Im Biergarten auf den treuen Freund vom Voigt warten."
ztaskImBiergartenaufKontaktwarten.Visible = true
ztaskImBiergartenaufKontaktwarten.Active = false
ztaskImBiergartenaufKontaktwarten.Complete = false
ztaskImBiergartenaufKontaktwarten.Media = zmediaAufgabe
ztaskImBiergartenaufKontaktwarten.Icon = zmediaAufgabe_32
ztaskKellnerinbezahlen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskKellnerinbezahlen.Id = "d523e53bbb8b9d8623304514bf1a076b"
ztaskKellnerinbezahlen.Name = "Kellnerin bezahlen"
ztaskKellnerinbezahlen.CorrectState = "None"
ztaskKellnerinbezahlen.Description = WWB_multiplatform_string("Gehe zur\195\188ck und bezahle die Kellnerin!")
ztaskKellnerinbezahlen.Visible = true
ztaskKellnerinbezahlen.Active = false
ztaskKellnerinbezahlen.Complete = false
ztaskKellnerinbezahlen.Media = zmediaAufgabe
ztaskKellnerinbezahlen.Icon = zmediaAufgabe_32
ztaskKofferschlieen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskKofferschlieen.Id = "dd9ccf031edbcdee57c4ecb795a6273c"
ztaskKofferschlieen.Name = WWB_multiplatform_string("Koffer schlie\195\159en")
ztaskKofferschlieen.CorrectState = "None"
ztaskKofferschlieen.Description = WWB_multiplatform_string("Schlie\195\159e den Koffer um den \195\156berblick \195\188ber die sichtbaren Gegenst\195\164nde zu behalten.")
ztaskKofferschlieen.Visible = false
ztaskKofferschlieen.Active = true
ztaskKofferschlieen.Complete = false
ztaskKofferschlieen.Media = zmediaAufgabe
ztaskKofferschlieen.Icon = zmediaAufgabe_32
ztaskKofferschlsselbenutzt = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskKofferschlsselbenutzt.Id = "46d91b426d87e6334535b7a500b6d97a"
ztaskKofferschlsselbenutzt.Name = WWB_multiplatform_string("Kofferschl\195\188ssel benutzt")
ztaskKofferschlsselbenutzt.CorrectState = "None"
ztaskKofferschlsselbenutzt.Description = ""
ztaskKofferschlsselbenutzt.Visible = false
ztaskKofferschlsselbenutzt.Active = true
ztaskKofferschlsselbenutzt.Complete = false
ztaskKofferschlsselbenutzt.Media = zmediaAufgabe
ztaskMighlafinden = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskMighlafinden.Id = "c29c55a8ad40659ae386406d1a5c9130"
ztaskMighlafinden.Name = "Mighla finden"
ztaskMighlafinden.CorrectState = "None"
ztaskMighlafinden.Description = WWB_multiplatform_string("Finde das Portal f\195\188r die Reise in das Jahr 1927.")
ztaskMighlafinden.Visible = true
ztaskMighlafinden.Active = false
ztaskMighlafinden.Complete = false
ztaskMighlafinden.Media = zmediaAufgabe
ztaskMighlafinden.Icon = zmediaAufgabe_32
ztaskTreffedieTaucher = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskTreffedieTaucher.Id = "515dd687486e59b0270af0c4ab4553fc"
ztaskTreffedieTaucher.Name = "Treffe die Taucher"
ztaskTreffedieTaucher.CorrectState = "None"
ztaskTreffedieTaucher.Description = WWB_multiplatform_string("Treffe, wie der Kapit\195\164n gesagt hat, die Taucher und \195\188bergebe ihnen die Koordinaten.")
ztaskTreffedieTaucher.Visible = true
ztaskTreffedieTaucher.Active = false
ztaskTreffedieTaucher.Complete = false
ztaskTreffedieTaucher.Media = zmediaAufgabe
ztaskTreffedieTaucher.Icon = zmediaAufgabe_32
ztaskTreibgutabholen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskTreibgutabholen.Id = "176a6de100fee35740251691903e5694"
ztaskTreibgutabholen.Name = "Treibgut abholen"
ztaskTreibgutabholen.CorrectState = "None"
ztaskTreibgutabholen.Description = WWB_multiplatform_string("Hole, wie der Kapit\195\164n gesagt hat, das Treibgut von der Badestelle ab.")
ztaskTreibgutabholen.Visible = true
ztaskTreibgutabholen.Active = false
ztaskTreibgutabholen.Complete = false
ztaskTreibgutabholen.Media = zmediaAufgabe
ztaskTreibgutabholen.Icon = zmediaAufgabe_32
ztaskVorbereitung = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskVorbereitung.Id = "04d38bd11e8b04e0c05807865648af06"
ztaskVorbereitung.Name = "Vorbereitung"
ztaskVorbereitung.CorrectState = "None"
ztaskVorbereitung.Description = WWB_multiplatform_string("Bereite Dich auf die Reise vor. Nutze daf\195\188r unbedingt die Akte Mighla aus dem Internet.<BR>\n~<BR>\ngeomcwood.wixsite.com/mighla<BR>\nPasswort: 1906<BR>\n~<BR>\n")
ztaskVorbereitung.Visible = true
ztaskVorbereitung.Active = false
ztaskVorbereitung.Complete = false
ztaskVorbereitung.Media = zmediaAufgabe
ztaskVorbereitung.Icon = zmediaAufgabe_32
ztaskZechebezahlen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskZechebezahlen.Id = "1581a9bdbb3b2a0c8fd99c7617e4cb6e"
ztaskZechebezahlen.Name = "Zeche bezahlen"
ztaskZechebezahlen.CorrectState = "None"
ztaskZechebezahlen.Description = ""
ztaskZechebezahlen.Visible = false
ztaskZechebezahlen.Active = false
ztaskZechebezahlen.Complete = true
ztaskZechebezahlen.Media = zmediaAufgabe
ztaskZurStartzonegehen = Wherigo.ZTask(cartMighlaTeil1v3)
ztaskZurStartzonegehen.Id = "caf25c7471047cf283454b9cbedd9f59"
ztaskZurStartzonegehen.Name = "Zur Startzone gehen"
ztaskZurStartzonegehen.CorrectState = "None"
ztaskZurStartzonegehen.Description = "Wenn Du Dich vorbereitet hast gehe zur zugewiesenen Startzone. Alle Informationen zur Vorbereitung stehen im Brief der Reiseagentur."
ztaskZurStartzonegehen.Visible = true
ztaskZurStartzonegehen.Active = false
ztaskZurStartzonegehen.Complete = false
ztaskZurStartzonegehen.Media = zmediaAufgabe
ztaskZurStartzonegehen.Icon = zmediaAufgabe_32
WWB_device = nil
var_Anzahl_Hilfen_1_11_1906 = "0"
var_Anzahl_Hilfen_1_11_1906Lsung = "0"
var_Anzahl_Hilfen_26_05_1927 = "0"
var_Anzahl_Hilfen_26_05_1927Lsung = 0
var_Anzahl_Hilfen_2_11_1906 = "0"
var_Anzahl_Hilfen_2_11_1906Lsung = 0
var_Anzahl_Hilfen_Gegenwart = "0"
var_Anzahl_Hilfen_GegenwartLsung = 0
var_Anzahl_Hilfen_Kettenschloss = "0"
var_Anzahl_Hilfen_KettenschlossLsung = 0
var_Anzahl_Hilfen_Kofferschoss = "0"
var_Anzahl_Hilfen_KofferschossLsung = 0
var_Anzahl_Hilfen_Navigation = "0"
var_Anzahl_Hilfen_NavigationLsung = 0
var_Anzahl_Hilfen_Pelle = "0"
var_Anzahl_Hilfen_PelleLsung = 0
var_Anzahl_Hilfen_Schliessfach = "0"
var_Anzahl_Hilfen_SchliessfachLsung = 0
var_Anzahl_Hilfen_Schutzhtte = "0"
var_Anzahl_Hilfen_SchutzhtteLsung = 0
var_Anzahl_Hilfen_Treibgut = "0"
var_Anzahl_Hilfen_TreibgutLsung = 0
var_Anzahl_Hilfen_Truhe = "0"
var_Anzahl_Hilfen_TruheLsung = 0
var_Anzahl_Hilfen_WfW = "0"
var_Anzahl_Hilfen_WfWLsung = 0
var_Blumenfrau_bezahlt = ""
var_Blumenfrau_nicht_bezahlt = "nein"
var_Cachegefunden = "nein"
var_Hilfe = 0
var_Inventar_Spieler = 3
var_Kellnerinbezahlt = "ja"
var_Kellnerinnichtbezahlt = "nein"
var_Koffer_Code = 0
var_Koordinaten = "97 Grad 197 Meter"
var_ParoleAntworten = 0
var_ParoleKapitn = "Von Malzahn Hauptmann im 1. Garde Regiment"
var_ParoleTaucher = "Seepferdchen"
var_Pelle = 0
var_SchliessfachGbS = 0
var_Schliessfach_Code = 0
var_SchlossInformation = 764
var_Schutzhtte = 0
var_Taucherwiederholtansprechen = 0
var_TimerTeppich = 300
var_TimerTeppichInfoEnde = false
var_Treibgut_Code = 0
var_ZeitreiseDaten1_11_1906 = 0
var_ZeitreiseDaten26_05_1927 = 0
var_ZeitreiseDaten2_11_1906 = 0
var_ZeitreiseDatenGegenwart = 0
var_zuerstamTeppich = 1
cartMighlaTeil1v3.ZVariables = {
  WWB_device = nil,
  var_Anzahl_Hilfen_1_11_1906 = "0",
  var_Anzahl_Hilfen_1_11_1906Lsung = "0",
  var_Anzahl_Hilfen_26_05_1927 = "0",
  var_Anzahl_Hilfen_26_05_1927Lsung = 0,
  var_Anzahl_Hilfen_2_11_1906 = "0",
  var_Anzahl_Hilfen_2_11_1906Lsung = 0,
  var_Anzahl_Hilfen_Gegenwart = "0",
  var_Anzahl_Hilfen_GegenwartLsung = 0,
  var_Anzahl_Hilfen_Kettenschloss = "0",
  var_Anzahl_Hilfen_KettenschlossLsung = 0,
  var_Anzahl_Hilfen_Kofferschoss = "0",
  var_Anzahl_Hilfen_KofferschossLsung = 0,
  var_Anzahl_Hilfen_Navigation = "0",
  var_Anzahl_Hilfen_NavigationLsung = 0,
  var_Anzahl_Hilfen_Pelle = "0",
  var_Anzahl_Hilfen_PelleLsung = 0,
  var_Anzahl_Hilfen_Schliessfach = "0",
  var_Anzahl_Hilfen_SchliessfachLsung = 0,
  var_Anzahl_Hilfen_Schutzhtte = "0",
  var_Anzahl_Hilfen_SchutzhtteLsung = 0,
  var_Anzahl_Hilfen_Treibgut = "0",
  var_Anzahl_Hilfen_TreibgutLsung = 0,
  var_Anzahl_Hilfen_Truhe = "0",
  var_Anzahl_Hilfen_TruheLsung = 0,
  var_Anzahl_Hilfen_WfW = "0",
  var_Anzahl_Hilfen_WfWLsung = 0,
  var_Blumenfrau_bezahlt = "",
  var_Blumenfrau_nicht_bezahlt = "nein",
  var_Cachegefunden = "nein",
  var_Hilfe = 0,
  var_Inventar_Spieler = 3,
  var_Kellnerinbezahlt = "ja",
  var_Kellnerinnichtbezahlt = "nein",
  var_Koffer_Code = 0,
  var_Koordinaten = "97 Grad 197 Meter",
  var_ParoleAntworten = 0,
  var_ParoleKapitn = "Von Malzahn Hauptmann im 1. Garde Regiment",
  var_ParoleTaucher = "Seepferdchen",
  var_Pelle = 0,
  var_SchliessfachGbS = 0,
  var_Schliessfach_Code = 0,
  var_SchlossInformation = 764,
  var_Schutzhtte = 0,
  var_Taucherwiederholtansprechen = 0,
  var_TimerTeppich = 300,
  var_TimerTeppichInfoEnde = false,
  var_Treibgut_Code = 0,
  var_ZeitreiseDaten1_11_1906 = 0,
  var_ZeitreiseDaten26_05_1927 = 0,
  var_ZeitreiseDaten2_11_1906 = 0,
  var_ZeitreiseDatenGegenwart = 0,
  var_zuerstamTeppich = 1
}
buildervar = {}
buildervar.var_Anzahl_Hilfen_1_11_1906 = {}
buildervar.var_Anzahl_Hilfen_1_11_1906.Id = "741805899ea1d88843ad00330fa5289c"
buildervar.var_Anzahl_Hilfen_1_11_1906.Name = "Anzahl_Hilfen_1_11_1906"
buildervar.var_Anzahl_Hilfen_1_11_1906.Type = "String"
buildervar.var_Anzahl_Hilfen_1_11_1906.Data = "0"
buildervar.var_Anzahl_Hilfen_1_11_1906Lsung = {}
buildervar.var_Anzahl_Hilfen_1_11_1906Lsung.Id = "e9677a0637eae0090e35a6012046d4cd"
buildervar.var_Anzahl_Hilfen_1_11_1906Lsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_1_11_1906 L\195\182sung")
buildervar.var_Anzahl_Hilfen_1_11_1906Lsung.Type = "String"
buildervar.var_Anzahl_Hilfen_1_11_1906Lsung.Data = "0"
buildervar.var_Anzahl_Hilfen_26_05_1927 = {}
buildervar.var_Anzahl_Hilfen_26_05_1927.Id = "e2bb678c1dab8def36a82537422b0d35"
buildervar.var_Anzahl_Hilfen_26_05_1927.Name = "Anzahl_Hilfen_26_05_1927"
buildervar.var_Anzahl_Hilfen_26_05_1927.Type = "String"
buildervar.var_Anzahl_Hilfen_26_05_1927.Data = "0"
buildervar.var_Anzahl_Hilfen_26_05_1927Lsung = {}
buildervar.var_Anzahl_Hilfen_26_05_1927Lsung.Id = "1a8a51ac666fd989aaa9140d05eda28f"
buildervar.var_Anzahl_Hilfen_26_05_1927Lsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_26_05_1927 L\195\182sung")
buildervar.var_Anzahl_Hilfen_26_05_1927Lsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_26_05_1927Lsung.Data = "0"
buildervar.var_Anzahl_Hilfen_2_11_1906 = {}
buildervar.var_Anzahl_Hilfen_2_11_1906.Id = "50ceb43b8c6952081f3ee04e4f2c76f3"
buildervar.var_Anzahl_Hilfen_2_11_1906.Name = "Anzahl_Hilfen_2_11_1906"
buildervar.var_Anzahl_Hilfen_2_11_1906.Type = "String"
buildervar.var_Anzahl_Hilfen_2_11_1906.Data = "0"
buildervar.var_Anzahl_Hilfen_2_11_1906Lsung = {}
buildervar.var_Anzahl_Hilfen_2_11_1906Lsung.Id = "1eb661d57d5b0b055ecd4ef14f27e28d"
buildervar.var_Anzahl_Hilfen_2_11_1906Lsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_2_11_1906 L\195\182sung")
buildervar.var_Anzahl_Hilfen_2_11_1906Lsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_2_11_1906Lsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Gegenwart = {}
buildervar.var_Anzahl_Hilfen_Gegenwart.Id = "e76d344fd155a5fc1623611bb7105b30"
buildervar.var_Anzahl_Hilfen_Gegenwart.Name = "Anzahl_Hilfen_Gegenwart"
buildervar.var_Anzahl_Hilfen_Gegenwart.Type = "String"
buildervar.var_Anzahl_Hilfen_Gegenwart.Data = "0"
buildervar.var_Anzahl_Hilfen_GegenwartLsung = {}
buildervar.var_Anzahl_Hilfen_GegenwartLsung.Id = "e5db255300dafe04a1af20197d4ba5d7"
buildervar.var_Anzahl_Hilfen_GegenwartLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Gegenwart L\195\182sung")
buildervar.var_Anzahl_Hilfen_GegenwartLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_GegenwartLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Kettenschloss = {}
buildervar.var_Anzahl_Hilfen_Kettenschloss.Id = "53f28753ca345c2fe7e0449a7e534d7e"
buildervar.var_Anzahl_Hilfen_Kettenschloss.Name = "Anzahl_Hilfen_Kettenschloss"
buildervar.var_Anzahl_Hilfen_Kettenschloss.Type = "String"
buildervar.var_Anzahl_Hilfen_Kettenschloss.Data = "0"
buildervar.var_Anzahl_Hilfen_KettenschlossLsung = {}
buildervar.var_Anzahl_Hilfen_KettenschlossLsung.Id = "2fb6fac1a6cca7e3434ed39f00042dab"
buildervar.var_Anzahl_Hilfen_KettenschlossLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Kettenschloss L\195\182sung")
buildervar.var_Anzahl_Hilfen_KettenschlossLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_KettenschlossLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Kofferschoss = {}
buildervar.var_Anzahl_Hilfen_Kofferschoss.Id = "1601f891e1be4dfc084f169ef536e294"
buildervar.var_Anzahl_Hilfen_Kofferschoss.Name = "Anzahl_Hilfen_Kofferschoss"
buildervar.var_Anzahl_Hilfen_Kofferschoss.Type = "String"
buildervar.var_Anzahl_Hilfen_Kofferschoss.Data = "0"
buildervar.var_Anzahl_Hilfen_KofferschossLsung = {}
buildervar.var_Anzahl_Hilfen_KofferschossLsung.Id = "77ca22e76ee15b9963bf18c84004bb71"
buildervar.var_Anzahl_Hilfen_KofferschossLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Kofferschoss L\195\182sung")
buildervar.var_Anzahl_Hilfen_KofferschossLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_KofferschossLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Navigation = {}
buildervar.var_Anzahl_Hilfen_Navigation.Id = "6c7dbc1116394200093a96bd31599c40"
buildervar.var_Anzahl_Hilfen_Navigation.Name = "Anzahl_Hilfen_Navigation"
buildervar.var_Anzahl_Hilfen_Navigation.Type = "String"
buildervar.var_Anzahl_Hilfen_Navigation.Data = "0"
buildervar.var_Anzahl_Hilfen_NavigationLsung = {}
buildervar.var_Anzahl_Hilfen_NavigationLsung.Id = "101c6cfc9c34c4e4d9a3237813c32c5d"
buildervar.var_Anzahl_Hilfen_NavigationLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Navigation L\195\182sung")
buildervar.var_Anzahl_Hilfen_NavigationLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_NavigationLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Pelle = {}
buildervar.var_Anzahl_Hilfen_Pelle.Id = "8d22cee14ff0b67d61fefa31f226dbdf"
buildervar.var_Anzahl_Hilfen_Pelle.Name = "Anzahl_Hilfen_Pelle"
buildervar.var_Anzahl_Hilfen_Pelle.Type = "String"
buildervar.var_Anzahl_Hilfen_Pelle.Data = "0"
buildervar.var_Anzahl_Hilfen_PelleLsung = {}
buildervar.var_Anzahl_Hilfen_PelleLsung.Id = "fb667f9fcb923810297e741c05aa13f9"
buildervar.var_Anzahl_Hilfen_PelleLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Pelle L\195\182sung")
buildervar.var_Anzahl_Hilfen_PelleLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_PelleLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Schliessfach = {}
buildervar.var_Anzahl_Hilfen_Schliessfach.Id = "9ec8159a4cc5533427439d10cb5983e5"
buildervar.var_Anzahl_Hilfen_Schliessfach.Name = "Anzahl_Hilfen_Schliessfach"
buildervar.var_Anzahl_Hilfen_Schliessfach.Type = "String"
buildervar.var_Anzahl_Hilfen_Schliessfach.Data = "0"
buildervar.var_Anzahl_Hilfen_SchliessfachLsung = {}
buildervar.var_Anzahl_Hilfen_SchliessfachLsung.Id = "da6872a2cda4ef6b4fa6a353125feb9b"
buildervar.var_Anzahl_Hilfen_SchliessfachLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Schliessfach L\195\182sung")
buildervar.var_Anzahl_Hilfen_SchliessfachLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_SchliessfachLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Schutzhtte = {}
buildervar.var_Anzahl_Hilfen_Schutzhtte.Id = "fb27f28f6f73c50dda4be2b0d1c61573"
buildervar.var_Anzahl_Hilfen_Schutzhtte.Name = WWB_multiplatform_string("Anzahl_Hilfen_Schutzh\195\188tte")
buildervar.var_Anzahl_Hilfen_Schutzhtte.Type = "String"
buildervar.var_Anzahl_Hilfen_Schutzhtte.Data = "0"
buildervar.var_Anzahl_Hilfen_SchutzhtteLsung = {}
buildervar.var_Anzahl_Hilfen_SchutzhtteLsung.Id = "4c20e2dcba138f7814c1adec4a1fc662"
buildervar.var_Anzahl_Hilfen_SchutzhtteLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Schutzh\195\188tte L\195\182sung")
buildervar.var_Anzahl_Hilfen_SchutzhtteLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_SchutzhtteLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Treibgut = {}
buildervar.var_Anzahl_Hilfen_Treibgut.Id = "3fda45d04b95341cc116eb5bbf246140"
buildervar.var_Anzahl_Hilfen_Treibgut.Name = "Anzahl_Hilfen_Treibgut"
buildervar.var_Anzahl_Hilfen_Treibgut.Type = "String"
buildervar.var_Anzahl_Hilfen_Treibgut.Data = "0"
buildervar.var_Anzahl_Hilfen_TreibgutLsung = {}
buildervar.var_Anzahl_Hilfen_TreibgutLsung.Id = "095e91fd026bfdc9cfa6e0d75a629e5b"
buildervar.var_Anzahl_Hilfen_TreibgutLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Treibgut L\195\182sung")
buildervar.var_Anzahl_Hilfen_TreibgutLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_TreibgutLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_Truhe = {}
buildervar.var_Anzahl_Hilfen_Truhe.Id = "994bdf4dca20b130d169137190b2327a"
buildervar.var_Anzahl_Hilfen_Truhe.Name = "Anzahl_Hilfen_Truhe"
buildervar.var_Anzahl_Hilfen_Truhe.Type = "String"
buildervar.var_Anzahl_Hilfen_Truhe.Data = "0"
buildervar.var_Anzahl_Hilfen_TruheLsung = {}
buildervar.var_Anzahl_Hilfen_TruheLsung.Id = "77bd491dadf59bcda0df039a099b40c7"
buildervar.var_Anzahl_Hilfen_TruheLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_Truhe L\195\182sung")
buildervar.var_Anzahl_Hilfen_TruheLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_TruheLsung.Data = "0"
buildervar.var_Anzahl_Hilfen_WfW = {}
buildervar.var_Anzahl_Hilfen_WfW.Id = "ca48a81612b6f58f1a5d15408cc63624"
buildervar.var_Anzahl_Hilfen_WfW.Name = "Anzahl_Hilfen_WfW"
buildervar.var_Anzahl_Hilfen_WfW.Type = "String"
buildervar.var_Anzahl_Hilfen_WfW.Data = "0"
buildervar.var_Anzahl_Hilfen_WfWLsung = {}
buildervar.var_Anzahl_Hilfen_WfWLsung.Id = "7cbe881108f5d97e4c28ba77aefe134c"
buildervar.var_Anzahl_Hilfen_WfWLsung.Name = WWB_multiplatform_string("Anzahl_Hilfen_WfW L\195\182sung")
buildervar.var_Anzahl_Hilfen_WfWLsung.Type = "Number"
buildervar.var_Anzahl_Hilfen_WfWLsung.Data = "0"
buildervar.var_Blumenfrau_bezahlt = {}
buildervar.var_Blumenfrau_bezahlt.Id = "0566f1fe8ad8fa8d207931f4c5481a5f"
buildervar.var_Blumenfrau_bezahlt.Name = "Blumenfrau_bezahlt"
buildervar.var_Blumenfrau_bezahlt.Type = "String"
buildervar.var_Blumenfrau_bezahlt.Data = ""
buildervar.var_Blumenfrau_nicht_bezahlt = {}
buildervar.var_Blumenfrau_nicht_bezahlt.Id = "9b628dba1622824c451e92acae193905"
buildervar.var_Blumenfrau_nicht_bezahlt.Name = "Blumenfrau_nicht _bezahlt"
buildervar.var_Blumenfrau_nicht_bezahlt.Type = "String"
buildervar.var_Blumenfrau_nicht_bezahlt.Data = "nein"
buildervar.var_Cachegefunden = {}
buildervar.var_Cachegefunden.Id = "50fa3700574ba9da195259808a51d313"
buildervar.var_Cachegefunden.Name = "Cache gefunden"
buildervar.var_Cachegefunden.Type = "String"
buildervar.var_Cachegefunden.Data = "nein"
buildervar.var_Hilfe = {}
buildervar.var_Hilfe.Id = "c165efa39fe38f0bae3cd765d0342ffd"
buildervar.var_Hilfe.Name = "Hilfe"
buildervar.var_Hilfe.Type = "Number"
buildervar.var_Hilfe.Data = "0"
buildervar.var_Inventar_Spieler = {}
buildervar.var_Inventar_Spieler.Id = "f3934e9c9f8f5ca649a6012f63488172"
buildervar.var_Inventar_Spieler.Name = "Inventar_Spieler"
buildervar.var_Inventar_Spieler.Type = "Number"
buildervar.var_Inventar_Spieler.Data = "3"
buildervar.var_Kellnerinbezahlt = {}
buildervar.var_Kellnerinbezahlt.Id = "bf52f6e31460fce3af7e5162543f298a"
buildervar.var_Kellnerinbezahlt.Name = "Kellnerin bezahlt"
buildervar.var_Kellnerinbezahlt.Type = "String"
buildervar.var_Kellnerinbezahlt.Data = "ja"
buildervar.var_Kellnerinnichtbezahlt = {}
buildervar.var_Kellnerinnichtbezahlt.Id = "c21068928b7c2fba27acb9a9140f6314"
buildervar.var_Kellnerinnichtbezahlt.Name = "Kellnerin nicht bezahlt"
buildervar.var_Kellnerinnichtbezahlt.Type = "String"
buildervar.var_Kellnerinnichtbezahlt.Data = "nein"
buildervar.var_Koffer_Code = {}
buildervar.var_Koffer_Code.Id = "c0ead5b31ad10b4fc0469d2df75d7919"
buildervar.var_Koffer_Code.Name = "Koffer_Code"
buildervar.var_Koffer_Code.Type = "Number"
buildervar.var_Koffer_Code.Data = "0"
buildervar.var_Koordinaten = {}
buildervar.var_Koordinaten.Id = "d03f98e8b3212a99cc0213ced30af316"
buildervar.var_Koordinaten.Name = "Koordinaten"
buildervar.var_Koordinaten.Type = "String"
buildervar.var_Koordinaten.Data = "97 Grad 197 Meter"
buildervar.var_ParoleAntworten = {}
buildervar.var_ParoleAntworten.Id = "36ff8eec1fb364e6a10573d1d0619d24"
buildervar.var_ParoleAntworten.Name = "Parole Antworten"
buildervar.var_ParoleAntworten.Type = "Number"
buildervar.var_ParoleAntworten.Data = "0"
buildervar.var_ParoleKapitn = {}
buildervar.var_ParoleKapitn.Id = "6dfd90b15b01146953e7189173403593"
buildervar.var_ParoleKapitn.Name = WWB_multiplatform_string("Parole Kapit\195\164n")
buildervar.var_ParoleKapitn.Type = "String"
buildervar.var_ParoleKapitn.Data = "Von Malzahn Hauptmann im 1. Garde Regiment"
buildervar.var_ParoleTaucher = {}
buildervar.var_ParoleTaucher.Id = "b9fe0d7cefd6159b142b4ee9a90e4057"
buildervar.var_ParoleTaucher.Name = "Parole Taucher"
buildervar.var_ParoleTaucher.Type = "String"
buildervar.var_ParoleTaucher.Data = "Seepferdchen"
buildervar.var_Pelle = {}
buildervar.var_Pelle.Id = "e161826132296e6a6ebb61f3224ea80d"
buildervar.var_Pelle.Name = "Pelle"
buildervar.var_Pelle.Type = "Number"
buildervar.var_Pelle.Data = "0"
buildervar.var_SchliessfachGbS = {}
buildervar.var_SchliessfachGbS.Id = "ecb645c60318b4eb17e135b991e68807"
buildervar.var_SchliessfachGbS.Name = "Schliessfach GbS"
buildervar.var_SchliessfachGbS.Type = "Number"
buildervar.var_SchliessfachGbS.Data = "0"
buildervar.var_Schliessfach_Code = {}
buildervar.var_Schliessfach_Code.Id = "4f725a84eea475fa39481765262f74b9"
buildervar.var_Schliessfach_Code.Name = "Schliessfach_Code"
buildervar.var_Schliessfach_Code.Type = "Number"
buildervar.var_Schliessfach_Code.Data = "0"
buildervar.var_SchlossInformation = {}
buildervar.var_SchlossInformation.Id = "7829bfe4cb9b325b1c28213362de430c"
buildervar.var_SchlossInformation.Name = "Schloss Information"
buildervar.var_SchlossInformation.Type = "Number"
buildervar.var_SchlossInformation.Data = "764"
buildervar.var_Schutzhtte = {}
buildervar.var_Schutzhtte.Id = "b696aea8e35a72168cbea567adc2c18f"
buildervar.var_Schutzhtte.Name = WWB_multiplatform_string("Schutzh\195\188tte")
buildervar.var_Schutzhtte.Type = "Number"
buildervar.var_Schutzhtte.Data = "0"
buildervar.var_Taucherwiederholtansprechen = {}
buildervar.var_Taucherwiederholtansprechen.Id = "0a869602d76b6ae5dfee6a3cf9f81767"
buildervar.var_Taucherwiederholtansprechen.Name = "Taucher wiederholt ansprechen"
buildervar.var_Taucherwiederholtansprechen.Type = "Number"
buildervar.var_Taucherwiederholtansprechen.Data = "0"
buildervar.var_TimerTeppich = {}
buildervar.var_TimerTeppich.Id = "3bd03980a1a2517761ee0b169602f94f"
buildervar.var_TimerTeppich.Name = "Timer Teppich"
buildervar.var_TimerTeppich.Type = "Number"
buildervar.var_TimerTeppich.Data = "300"
buildervar.var_TimerTeppichInfoEnde = {}
buildervar.var_TimerTeppichInfoEnde.Id = "83795841008b9d2a17060de81d8cd402"
buildervar.var_TimerTeppichInfoEnde.Name = "Timer Teppich Info Ende"
buildervar.var_TimerTeppichInfoEnde.Type = "Flag"
buildervar.var_TimerTeppichInfoEnde.Data = "False"
buildervar.var_Treibgut_Code = {}
buildervar.var_Treibgut_Code.Id = "0a0fa44b980c9796fc1edd89b246ae4d"
buildervar.var_Treibgut_Code.Name = "Treibgut_Code"
buildervar.var_Treibgut_Code.Type = "Number"
buildervar.var_Treibgut_Code.Data = "0"
buildervar.var_ZeitreiseDaten1_11_1906 = {}
buildervar.var_ZeitreiseDaten1_11_1906.Id = "0ec3002c44e61d4c29472074e5828694"
buildervar.var_ZeitreiseDaten1_11_1906.Name = "ZeitreiseDaten 1_11_1906"
buildervar.var_ZeitreiseDaten1_11_1906.Type = "Number"
buildervar.var_ZeitreiseDaten1_11_1906.Data = "0"
buildervar.var_ZeitreiseDaten26_05_1927 = {}
buildervar.var_ZeitreiseDaten26_05_1927.Id = "9c56fc58ceef0d2ec4c7a0e41f363f20"
buildervar.var_ZeitreiseDaten26_05_1927.Name = "ZeitreiseDaten 26_05_1927"
buildervar.var_ZeitreiseDaten26_05_1927.Type = "Number"
buildervar.var_ZeitreiseDaten26_05_1927.Data = "0"
buildervar.var_ZeitreiseDaten2_11_1906 = {}
buildervar.var_ZeitreiseDaten2_11_1906.Id = "2d28627b82d3da5a703b805937cac713"
buildervar.var_ZeitreiseDaten2_11_1906.Name = "ZeitreiseDaten 2_11_1906"
buildervar.var_ZeitreiseDaten2_11_1906.Type = "Number"
buildervar.var_ZeitreiseDaten2_11_1906.Data = "0"
buildervar.var_ZeitreiseDatenGegenwart = {}
buildervar.var_ZeitreiseDatenGegenwart.Id = "f7c5b163b28dd0054d1ba18c51cb4d91"
buildervar.var_ZeitreiseDatenGegenwart.Name = "ZeitreiseDaten Gegenwart"
buildervar.var_ZeitreiseDatenGegenwart.Type = "Number"
buildervar.var_ZeitreiseDatenGegenwart.Data = "0"
buildervar.var_zuerstamTeppich = {}
buildervar.var_zuerstamTeppich.Id = "d1c2d6e4e2c9e1da2b6aca5c762c2cc7"
buildervar.var_zuerstamTeppich.Name = "zuerst am Teppich"
buildervar.var_zuerstamTeppich.Type = "Number"
buildervar.var_zuerstamTeppich.Data = "1"
ztimerBrief_Ankunft = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerBrief_Ankunft.Id = "80feac31b1017a7e06b4980a8a4d9218"
ztimerBrief_Ankunft.Name = "Brief_Ankunft"
ztimerBrief_Ankunft.Type = "Countdown"
ztimerBrief_Ankunft.Visible = false
ztimerBrief_Ankunft.Duration = 7
ztimerKapitn = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerKapitn.Id = "e72d841fabfec2f4a10a4b68e0d25954"
ztimerKapitn.Name = WWB_multiplatform_string("Kapit\195\164n")
ztimerKapitn.Type = "Countdown"
ztimerKapitn.Visible = false
ztimerKapitn.Duration = 10
ztimerMighlaSchutzhttesichtbar = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerMighlaSchutzhttesichtbar.Id = "388c911ae6150d586b998499709269ac"
ztimerMighlaSchutzhttesichtbar.Name = WWB_multiplatform_string("Mighla Schutzh\195\188tte sichtbar")
ztimerMighlaSchutzhttesichtbar.Type = "Countdown"
ztimerMighlaSchutzhttesichtbar.Visible = false
ztimerMighlaSchutzhttesichtbar.Duration = 120
ztimerMighlaSchutzhttesichtbar.Media = zmediaNebel_Schutzhtte
ztimerMighlaSchutzhtteunsichtbar = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerMighlaSchutzhtteunsichtbar.Id = "f1aa4449eeccd3f93cec2da4e38ae2c2"
ztimerMighlaSchutzhtteunsichtbar.Name = WWB_multiplatform_string("Mighla Schutzh\195\188tte unsichtbar")
ztimerMighlaSchutzhtteunsichtbar.Type = "Countdown"
ztimerMighlaSchutzhtteunsichtbar.Visible = false
ztimerMighlaSchutzhtteunsichtbar.Duration = 120
ztimerMighlaSchutzhtteunsichtbar.Media = zmediaNebel_01
ztimerNiesen = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerNiesen.Id = "3a1b5a985d6b1d16ce038712ae81f41c"
ztimerNiesen.Name = "Niesen"
ztimerNiesen.Type = "Countdown"
ztimerNiesen.Visible = false
ztimerNiesen.Duration = 10
ztimerPolizeiTeppich = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerPolizeiTeppich.Id = "7f8dc4946d551fc00efddba00ed5867b"
ztimerPolizeiTeppich.Name = "Polizei Teppich"
ztimerPolizeiTeppich.Type = "Interval"
ztimerPolizeiTeppich.Visible = false
ztimerPolizeiTeppich.Duration = 1
ztimerPortal1906anzeigenMggelwald = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerPortal1906anzeigenMggelwald.Id = "e5b691f5814742e12f4aa00f1ab81e96"
ztimerPortal1906anzeigenMggelwald.Name = WWB_multiplatform_string("Portal 1906 anzeigen M\195\188ggelwald")
ztimerPortal1906anzeigenMggelwald.Type = "Countdown"
ztimerPortal1906anzeigenMggelwald.Visible = false
ztimerPortal1906anzeigenMggelwald.Duration = 5
ztimerPortalGegenwartanzeigen = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerPortalGegenwartanzeigen.Id = "0c58bcfa072150980fa41531052248fa"
ztimerPortalGegenwartanzeigen.Name = "Portal Gegenwart anzeigen"
ztimerPortalGegenwartanzeigen.Type = "Countdown"
ztimerPortalGegenwartanzeigen.Visible = false
ztimerPortalGegenwartanzeigen.Duration = 5
ztimerPortal_1906_anzeigen = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerPortal_1906_anzeigen.Id = "5e20c7998bb2dcd762d757d5d0387f00"
ztimerPortal_1906_anzeigen.Name = "Portal_1906_anzeigen"
ztimerPortal_1906_anzeigen.Type = "Countdown"
ztimerPortal_1906_anzeigen.Visible = false
ztimerPortal_1906_anzeigen.Duration = 5
ztimerPortal_1927_sichtbar = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerPortal_1927_sichtbar.Id = "abfa9b7133e066c1c401d04b16b8a38d"
ztimerPortal_1927_sichtbar.Name = "Portal_1927_sichtbar"
ztimerPortal_1927_sichtbar.Type = "Countdown"
ztimerPortal_1927_sichtbar.Visible = false
ztimerPortal_1927_sichtbar.Duration = 25
ztimerPortal_1927_unsichtbar = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerPortal_1927_unsichtbar.Id = "73267cc338a10b64060cdfec97cf56d8"
ztimerPortal_1927_unsichtbar.Name = "Portal_1927_unsichtbar"
ztimerPortal_1927_unsichtbar.Type = "Countdown"
ztimerPortal_1927_unsichtbar.Visible = false
ztimerPortal_1927_unsichtbar.Duration = 15
ztimerTaucherBadebucht1 = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerTaucherBadebucht1.Id = "c5d94ac6a0b8c6dd7faaa2cc7ea5a27f"
ztimerTaucherBadebucht1.Name = "Taucher Badebucht 1"
ztimerTaucherBadebucht1.Type = "Countdown"
ztimerTaucherBadebucht1.Visible = false
ztimerTaucherBadebucht1.Duration = 10
ztimerTaucherBadebucht2 = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerTaucherBadebucht2.Id = "d9850c2e244fc4d779ab24209b774718"
ztimerTaucherBadebucht2.Name = "Taucher Badebucht 2"
ztimerTaucherBadebucht2.Type = "Countdown"
ztimerTaucherBadebucht2.Visible = false
ztimerTaucherBadebucht2.Duration = 5
ztimerTaucherBadebucht2a = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerTaucherBadebucht2a.Id = "0b6f56cc7c41477ca2562202d74f4753"
ztimerTaucherBadebucht2a.Name = "Taucher Badebucht 2a"
ztimerTaucherBadebucht2a.Type = "Countdown"
ztimerTaucherBadebucht2a.Visible = false
ztimerTaucherBadebucht2a.Duration = 5
ztimerbergabeKallesichtbar = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerbergabeKallesichtbar.Id = "201261f748dcb61b3c8fbe089b18e6bf"
ztimerbergabeKallesichtbar.Name = WWB_multiplatform_string("\195\156bergabe Kalle sichtbar")
ztimerbergabeKallesichtbar.Type = "Countdown"
ztimerbergabeKallesichtbar.Visible = false
ztimerbergabeKallesichtbar.Duration = 15
ztimerbergabeKalleunsichtbar = Wherigo.ZTimer(cartMighlaTeil1v3)
ztimerbergabeKalleunsichtbar.Id = "4d58e3789d4aef23661c258a9f54cb4d"
ztimerbergabeKalleunsichtbar.Name = WWB_multiplatform_string("\195\156bergabe Kalle unsichtbar")
ztimerbergabeKalleunsichtbar.Type = "Countdown"
ztimerbergabeKalleunsichtbar.Visible = false
ztimerbergabeKalleunsichtbar.Duration = 15
zinputHilfeKettenschlossAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeKettenschlossAuflsung.Id = "1f98e984025e2d0cb1b74b33ba25ab69"
zinputHilfeKettenschlossAuflsung.Name = WWB_multiplatform_string("Hilfe Kettenschloss Aufl\195\182sung")
zinputHilfeKettenschlossAuflsung.InputType = "Text"
zinputHilfeKettenschlossAuflsung.Text = WWB_multiplatform_string("Gib bitte den Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeKettenschlossAuflsung.Visible = false
zinputHilfeKettenschlossAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeKettenschlossAuflsung.Media = zmediaHilfe_Code
zinputHilfeKofferschlossAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeKofferschlossAuflsung.Id = "a42c0c8af282cdd6b135d06e4b0741a2"
zinputHilfeKofferschlossAuflsung.Name = WWB_multiplatform_string("Hilfe Kofferschloss Aufl\195\182sung")
zinputHilfeKofferschlossAuflsung.InputType = "Text"
zinputHilfeKofferschlossAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeKofferschlossAuflsung.Visible = false
zinputHilfeKofferschlossAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeKofferschlossAuflsung.Media = zmediaHilfe_Code
zinputHilfeNavigationAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeNavigationAuflsung.Id = "0490e041a0864ae1958c8cf7a287af21"
zinputHilfeNavigationAuflsung.Name = WWB_multiplatform_string("Hilfe Navigation Aufl\195\182sung")
zinputHilfeNavigationAuflsung.InputType = "Text"
zinputHilfeNavigationAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeNavigationAuflsung.Visible = false
zinputHilfeNavigationAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeNavigationAuflsung.Media = zmediaHilfe_Code
zinputHilfePelleAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfePelleAuflsung.Id = "99a15adc86b065c10bc11b1388010e41"
zinputHilfePelleAuflsung.Name = WWB_multiplatform_string("Hilfe Pelle Aufl\195\182sung")
zinputHilfePelleAuflsung.InputType = "Text"
zinputHilfePelleAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfePelleAuflsung.Visible = false
zinputHilfePelleAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfePelleAuflsung.Media = zmediaHilfe_Code
zinputHilfeSchliefachAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeSchliefachAuflsung.Id = "f27ee9287117d6efea1e3292b14375c2"
zinputHilfeSchliefachAuflsung.Name = WWB_multiplatform_string("Hilfe Schlie\195\159fach Aufl\195\182sung")
zinputHilfeSchliefachAuflsung.InputType = "Text"
zinputHilfeSchliefachAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeSchliefachAuflsung.Visible = false
zinputHilfeSchliefachAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeSchliefachAuflsung.Media = zmediaHilfe_Code
zinputHilfeSchutzhtteAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeSchutzhtteAuflsung.Id = "60768d964586e919c1c00d25fad1d4b1"
zinputHilfeSchutzhtteAuflsung.Name = WWB_multiplatform_string("Hilfe Schutzh\195\188tte Aufl\195\182sung")
zinputHilfeSchutzhtteAuflsung.InputType = "Text"
zinputHilfeSchutzhtteAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeSchutzhtteAuflsung.Visible = false
zinputHilfeSchutzhtteAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeTreibgutAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeTreibgutAuflsung.Id = "0e1becb48716469d058a01a670714280"
zinputHilfeTreibgutAuflsung.Name = WWB_multiplatform_string("Hilfe Treibgut Aufl\195\182sung")
zinputHilfeTreibgutAuflsung.InputType = "Text"
zinputHilfeTreibgutAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeTreibgutAuflsung.Visible = false
zinputHilfeTreibgutAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeTreibgutAuflsung.Media = zmediaHilfe_Code
zinputHilfeTruheAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeTruheAuflsung.Id = "6952fc7ec6b840db69438f1309b19701"
zinputHilfeTruheAuflsung.Name = WWB_multiplatform_string("Hilfe Truhe Aufl\195\182sung")
zinputHilfeTruheAuflsung.InputType = "Text"
zinputHilfeTruheAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein. Den Code findest Du auf dem Foto 12.")
zinputHilfeTruheAuflsung.Visible = false
zinputHilfeTruheAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeTruheAuflsung.Media = zmediaHilfe_Code
zinputHilfeWfWAuflsung = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeWfWAuflsung.Id = "96682093961d2e78cfb9ca93ab60673c"
zinputHilfeWfWAuflsung.Name = WWB_multiplatform_string("Hilfe WfW Aufl\195\182sung")
zinputHilfeWfWAuflsung.InputType = "Text"
zinputHilfeWfWAuflsung.Text = WWB_multiplatform_string("Gib bitte den Hilfe Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeWfWAuflsung.Visible = false
zinputHilfeWfWAuflsung.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeWfWAuflsung.Media = zmediaHilfe_Code
zinputHilfeZeitreiseAuflsung1_11_1906 = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeZeitreiseAuflsung1_11_1906.Id = "44611c315be143a5bb3e74aa79dae5a0"
zinputHilfeZeitreiseAuflsung1_11_1906.Name = WWB_multiplatform_string("Hilfe Zeitreise Aufl\195\182sung 1_11_1906")
zinputHilfeZeitreiseAuflsung1_11_1906.InputType = "Text"
zinputHilfeZeitreiseAuflsung1_11_1906.Text = WWB_multiplatform_string("Gib bitte den Code f\195\188r die Aufl\195\182sung ein. ")
zinputHilfeZeitreiseAuflsung1_11_1906.Visible = false
zinputHilfeZeitreiseAuflsung1_11_1906.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeZeitreiseAuflsung1_11_1906.Media = zmediaHilfe_Code
zinputHilfeZeitreiseAuflsung26_05_1927 = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeZeitreiseAuflsung26_05_1927.Id = "4ea6ec243fc0666d730b8540617fece6"
zinputHilfeZeitreiseAuflsung26_05_1927.Name = WWB_multiplatform_string("Hilfe Zeitreise Aufl\195\182sung 26_05_1927")
zinputHilfeZeitreiseAuflsung26_05_1927.InputType = "Text"
zinputHilfeZeitreiseAuflsung26_05_1927.Text = WWB_multiplatform_string("Gib bitte den Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeZeitreiseAuflsung26_05_1927.Visible = false
zinputHilfeZeitreiseAuflsung26_05_1927.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeZeitreiseAuflsung26_05_1927.Media = zmediaHilfe_Code
zinputHilfeZeitreiseAuflsung2_11_1906 = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeZeitreiseAuflsung2_11_1906.Id = "6358d807a23adf6e654edcba452ee607"
zinputHilfeZeitreiseAuflsung2_11_1906.Name = WWB_multiplatform_string("Hilfe Zeitreise Aufl\195\182sung 2_11_1906")
zinputHilfeZeitreiseAuflsung2_11_1906.InputType = "Text"
zinputHilfeZeitreiseAuflsung2_11_1906.Text = WWB_multiplatform_string("Gib bitte den Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeZeitreiseAuflsung2_11_1906.Visible = false
zinputHilfeZeitreiseAuflsung2_11_1906.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeZeitreiseAuflsung2_11_1906.Media = zmediaHilfe_Code
zinputHilfeZeitreiseAuflsungGegenwart = Wherigo.ZInput(cartMighlaTeil1v3)
zinputHilfeZeitreiseAuflsungGegenwart.Id = "6e07eda4d4f827243f448c8bb0f23d2b"
zinputHilfeZeitreiseAuflsungGegenwart.Name = WWB_multiplatform_string("Hilfe Zeitreise Aufl\195\182sung Gegenwart")
zinputHilfeZeitreiseAuflsungGegenwart.InputType = "Text"
zinputHilfeZeitreiseAuflsungGegenwart.Text = WWB_multiplatform_string("Gib bitte den Code f\195\188r die Aufl\195\182sung ein.")
zinputHilfeZeitreiseAuflsungGegenwart.Visible = false
zinputHilfeZeitreiseAuflsungGegenwart.InputVariableId = "c165efa39fe38f0bae3cd765d0342ffd"
zinputHilfeZeitreiseAuflsungGegenwart.Media = zmediaHilfe_Code
zinputKettenschlossCode = Wherigo.ZInput(cartMighlaTeil1v3)
zinputKettenschlossCode.Id = "8cf5ca4d366e4674007d7850630f9560"
zinputKettenschlossCode.Name = "Kettenschloss Code"
zinputKettenschlossCode.InputType = "Text"
zinputKettenschlossCode.Text = "Gib den dreistelligen Schloss Code ein.<BR>\n"
zinputKettenschlossCode.Visible = true
zinputKettenschlossCode.InputVariableId = "7829bfe4cb9b325b1c28213362de430c"
zinputKettenschlossCode.Media = zmediaRadfahrerZeitungS37
zinputKofferschlossCode = Wherigo.ZInput(cartMighlaTeil1v3)
zinputKofferschlossCode.Id = "7a641db82d94f22f0427ad11bfaae3b8"
zinputKofferschlossCode.Name = "Kofferschloss Code"
zinputKofferschlossCode.InputType = "Text"
zinputKofferschlossCode.Text = WWB_multiplatform_string("Achtung!<BR>\nNotiere Dir den Code, Du ben\195\182tigst ihn im n\195\164chsten Teil von Mighla!<BR>\nGib nun den dreistelligen Code f\195\188r das Kofferschloss ein.")
zinputKofferschlossCode.Visible = true
zinputKofferschlossCode.InputVariableId = "c0ead5b31ad10b4fc0469d2df75d7919"
zinputKofferschlossCode.Media = zmediaKofferschlssel_Code
zinputNavigationKoordinate = Wherigo.ZInput(cartMighlaTeil1v3)
zinputNavigationKoordinate.Id = "e321d3c7c03cfcf6a3c196d1d34cbcb4"
zinputNavigationKoordinate.Name = "Navigation Koordinate"
zinputNavigationKoordinate.InputType = "Text"
zinputNavigationKoordinate.Text = [[
Gib die Koordinate wie folgt ein: **,***<BR>
(Grad,Meter)]]
zinputNavigationKoordinate.Visible = true
zinputNavigationKoordinate.InputVariableId = "d03f98e8b3212a99cc0213ced30af316"
zinputNavigationKoordinate.Media = zmediaNavigation
zinputParoleKapitn = Wherigo.ZInput(cartMighlaTeil1v3)
zinputParoleKapitn.Id = "512f2192f736e2b5f6678e9dfb84eae5"
zinputParoleKapitn.Name = WWB_multiplatform_string("Parole Kapit\195\164n")
zinputParoleKapitn.InputType = "MultipleChoice"
zinputParoleKapitn.Choices = {
  "v.Malzahn Hptm 6.Garde Reg.",
  WWB_multiplatform_string("v.Malzehn Hptm v.C\195\182penick", {EmulatorGSP = 1, PocketPC = 1}),
  "v.Malzahn Hptm 1.Garde Reg.",
  "v.Malzehn Hptm 1.Garde Reg."
}
zinputParoleKapitn.Text = WWB_multiplatform_string("Hinweis: beim iPhone auf dem Display die Antwort ausw\195\164hlen und dann \"Done\" antippen.")
zinputParoleKapitn.Visible = true
zinputParoleKapitn.InputVariableId = "6dfd90b15b01146953e7189173403593"
zinputParoleKapitn.Media = zmediaKapitn
zinputParoleTaucher = Wherigo.ZInput(cartMighlaTeil1v3)
zinputParoleTaucher.Id = "7659c7fa8b0c1290f4dd474e61b63ce0"
zinputParoleTaucher.Name = "Parole Taucher"
zinputParoleTaucher.InputType = "MultipleChoice"
zinputParoleTaucher.Choices = {
  WWB_multiplatform_string("Seeh\195\188ndchen", {EmulatorGSP = 1, PocketPC = 1}),
  "Seepferdchen",
  "Heupferdchen",
  WWB_multiplatform_string("Meerk\195\164tzchen", {EmulatorGSP = 1, PocketPC = 1})
}
zinputParoleTaucher.Text = "Ohne Parole geht hier nichts."
zinputParoleTaucher.Visible = true
zinputParoleTaucher.InputVariableId = "b9fe0d7cefd6159b142b4ee9a90e4057"
zinputParoleTaucher.Media = zmediaTaucher
zinputPelleCodeZauberei = Wherigo.ZInput(cartMighlaTeil1v3)
zinputPelleCodeZauberei.Id = "5d22ac68f5088f9018d77ebd621bb716"
zinputPelleCodeZauberei.Name = "Pelle Code Zauberei"
zinputPelleCodeZauberei.InputType = "Text"
zinputPelleCodeZauberei.Text = WWB_multiplatform_string("Gib den vierstelligen Code f\195\188r die Truhe ein.")
zinputPelleCodeZauberei.Visible = true
zinputPelleCodeZauberei.InputVariableId = "e161826132296e6a6ebb61f3224ea80d"
zinputPelleCodeZauberei.Media = zmediaPergament
zinputSchliessfach_Code = Wherigo.ZInput(cartMighlaTeil1v3)
zinputSchliessfach_Code.Id = "0240d1a73ed0fb2b8901d82cecf29ff3"
zinputSchliessfach_Code.Name = "Schliessfach_Code"
zinputSchliessfach_Code.InputType = "Text"
zinputSchliessfach_Code.Text = WWB_multiplatform_string("Gib den dreistelligen Code f\195\188r das Schliessfach ein.")
zinputSchliessfach_Code.Visible = true
zinputSchliessfach_Code.InputVariableId = "4f725a84eea475fa39481765262f74b9"
zinputSchliessfach_Code.Media = zmediaSchliessfach
zinputSchutzhtteCode = Wherigo.ZInput(cartMighlaTeil1v3)
zinputSchutzhtteCode.Id = "c0948d707c5819dd5ba1b034e833c24b"
zinputSchutzhtteCode.Name = WWB_multiplatform_string("Schutzh\195\188tte Code")
zinputSchutzhtteCode.InputType = "Text"
zinputSchutzhtteCode.Text = WWB_multiplatform_string("Gib den in der Schutzh\195\188tte gefundenen dreistelligen Code ein.")
zinputSchutzhtteCode.Visible = true
zinputSchutzhtteCode.InputVariableId = "b696aea8e35a72168cbea567adc2c18f"
zinputSchutzhtteCode.Media = zmediaSchutzhtte
zinputTreibgut_Code = Wherigo.ZInput(cartMighlaTeil1v3)
zinputTreibgut_Code.Id = "fd67b51bb82ffef33ad9e92c827b4657"
zinputTreibgut_Code.Name = "Treibgut_Code"
zinputTreibgut_Code.InputType = "Text"
zinputTreibgut_Code.Text = WWB_multiplatform_string("Gib den dreistelligen Code f\195\188r das Treibgut ein.")
zinputTreibgut_Code.Visible = true
zinputTreibgut_Code.InputVariableId = "0a0fa44b980c9796fc1edd89b246ae4d"
zinputTreibgut_Code.Media = zmediaTreibgutzu
zinputZeitreiseDaten1_11_1906 = Wherigo.ZInput(cartMighlaTeil1v3)
zinputZeitreiseDaten1_11_1906.Id = "c4af1bc12fcd8fe28440795688575f10"
zinputZeitreiseDaten1_11_1906.Name = "ZeitreiseDaten 1_11_1906"
zinputZeitreiseDaten1_11_1906.InputType = "Text"
zinputZeitreiseDaten1_11_1906.Text = WWB_multiplatform_string("Gebe nun den dreistelligen Zeitreise-Code f\195\188r die Reise zum 1.11.1906 ein:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine")
zinputZeitreiseDaten1_11_1906.Visible = true
zinputZeitreiseDaten1_11_1906.InputVariableId = "0ec3002c44e61d4c29472074e5828694"
zinputZeitreiseDaten1_11_1906.Media = zmediaPortalZeitreisemaschiene
zinputZeitreiseDaten26_05_1927 = Wherigo.ZInput(cartMighlaTeil1v3)
zinputZeitreiseDaten26_05_1927.Id = "a9fe2827b171d94fcff622ca7db475f0"
zinputZeitreiseDaten26_05_1927.Name = "ZeitreiseDaten 26_05_1927"
zinputZeitreiseDaten26_05_1927.InputType = "Text"
zinputZeitreiseDaten26_05_1927.Text = WWB_multiplatform_string("Gebe nun den dreistelligen Zeitreise-Code f\195\188r die Reise zum 26.05.1927 ein:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine")
zinputZeitreiseDaten26_05_1927.Visible = true
zinputZeitreiseDaten26_05_1927.InputVariableId = "9c56fc58ceef0d2ec4c7a0e41f363f20"
zinputZeitreiseDaten26_05_1927.Media = zmediaPortalZeitreisemaschiene
zinputZeitreiseDaten2_11_1906 = Wherigo.ZInput(cartMighlaTeil1v3)
zinputZeitreiseDaten2_11_1906.Id = "49b6b90583212f8363a483c9684bb803"
zinputZeitreiseDaten2_11_1906.Name = "ZeitreiseDaten 2_11_1906"
zinputZeitreiseDaten2_11_1906.InputType = "Text"
zinputZeitreiseDaten2_11_1906.Text = WWB_multiplatform_string("Gebe nun den dreistelligen Zeitreise-Code f\195\188r die Reise zum 2.11.1906 ein:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine")
zinputZeitreiseDaten2_11_1906.Visible = true
zinputZeitreiseDaten2_11_1906.InputVariableId = "2d28627b82d3da5a703b805937cac713"
zinputZeitreiseDaten2_11_1906.Media = zmediaPortalZeitreisemaschiene
zinputZeitreiseDatenGegenwart = Wherigo.ZInput(cartMighlaTeil1v3)
zinputZeitreiseDatenGegenwart.Id = "bcd411e25c5305cd5108e59e873a63c0"
zinputZeitreiseDatenGegenwart.Name = "ZeitreiseDaten Gegenwart"
zinputZeitreiseDatenGegenwart.InputType = "Text"
zinputZeitreiseDatenGegenwart.Text = WWB_multiplatform_string("Gebe nun den dreistelligen Zeitreise-Code f\195\188r die Reise in die Gegenwart ein:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine")
zinputZeitreiseDatenGegenwart.Visible = true
zinputZeitreiseDatenGegenwart.InputVariableId = "f7c5b163b28dd0054d1ba18c51cb4d91"
zinputZeitreiseDatenGegenwart.Media = zmediaPortalZeitreisemaschiene
zitemFotoboxvonZille.Commands.ffnen.WorksWithList = {}
function cartMighlaTeil1v3:OnStart()
  WWB_CompletionCode15 = Player.CompletionCode:sub(1, 15)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Guten Tag,<BR>\nwir sind die Reiseagentur Dunnemals.<BR>\nWir m\195\182chten Sie auf unser Gewinnspiel aufmerksam machen.<BR>\nHauptgewinn ist eine Reise in die Vergangenheit.<BR>\nJa, Sie haben richtig geh\195\182rt, eine Zeitreise.<BR>\nWir schicken Sie in das Berlin von 1906.<BR>\nNeugierig geworden?<BR>\n", {PocketPC = 1}),
    Media = zmediaVertreter,
    Buttons = {"Ja", "Nein"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB1
  })
  cartMighlaTeil1v3:RequestSync()
  WWB_noemul(cartMighlaTeil1v3, WWB_multiplatform_string("Der Author dieser Cartridge m\195\182chte nicht, dass diese im Emulator gespielt wird"))
end
function ztaskAufdenBriefwarten:OnSetComplete()
  ztaskAufdenBriefwarten.Visible = false
end
function ztaskBriefgelesen:OnSetComplete()
  zoneSeglerheim.Active = true
end
function ztaskDasSpreeuferwechseln:OnSetComplete()
  ztaskDasSpreeuferwechseln.Visible = false
end
function ztaskDemHinweisfolgen:OnSetComplete()
  ztaskDemHinweisfolgen.Visible = false
end
function ztaskEineNelkekaufen:OnSetComplete()
  ztaskEineNelkekaufen.Visible = false
end
function ztaskFindedasSeglerheim:OnSetComplete()
  ztaskFindedasSeglerheim.Visible = false
end
function ztaskGegenstndemitnehmen:OnSetComplete()
  ztaskGegenstndemitnehmen.Visible = false
end
function ztaskKofferschlsselbenutzt:OnSetComplete()
  if var_Koffer_Code == 746 then
    zitemKoffer.Description = "Das Schloss ist offen"
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemStadtplanMggelpark.Commands.einpacken.Enabled = true
    zitemKofferschlsseluStadtkasse.Commands.zurck.Enabled = false
    zitemKofferschlsseluStadtkasse.Commands.einpacken.Enabled = true
    zitemPortalAktivierungskarten.Commands.zurck.Enabled = false
    zitemPortalAktivierungskarten.Commands.einpacken.Enabled = true
    zitemPortalZeitreisemaschiene.Commands.zurck.Enabled = false
    zitemPortalZeitreisemaschiene.Commands.einpacken.Enabled = true
    cartMighlaTeil1v3:RequestSync()
  end
end
function ztaskMighlafinden:OnSetComplete()
  ztaskMighlafinden.Visible = false
end
function ztaskTreffedieTaucher:OnSetComplete()
  ztaskTreffedieTaucher.Visible = false
end
function ztaskTreibgutabholen:OnSetComplete()
  ztaskTreibgutabholen.Visible = false
end
function ztaskZurStartzonegehen:OnSetComplete()
  ztaskZurStartzonegehen.Active = false
end
function ztimerBrief_Ankunft:OnTick()
  Wherigo.PlayAudio(zmediaS_Klingel)
  zitemBrief:MoveTo(Player)
  ztaskAufdenBriefwarten.Complete = true
end
function ztimerKapitn:OnTick()
  zcharacterKapitn.Commands.Hallo.Enabled = true
  zcharacterKapitn.Commands.Antwort.Enabled = false
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  zcharacterKapitn.Visible = true
end
function ztimerNiesen:OnTick()
  Wherigo.PlayAudio(zmediaS_Niesen)
  zcharacterKellnerin.Description = WWB_multiplatform_string("Hallo meine Herren, ich habe hier zwei mal Herrengedeck f\195\188r Sie. Molle und Korn, ist das Recht so?")
  zcharacterSeebr.Visible = true
  zcharacterKellnerin.Commands.JavielenDank.Enabled = true
  Wherigo.MessageBox({
    Text = "",
    Media = zmediaHatschi,
    Buttons = {"Nanu..."},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB4
  })
end
function ztimerPolizeiTeppich:OnTick()
  if var_TimerTeppich == 0 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    ztimerPolizeiTeppich:Stop()
    Wherigo.MessageBox({
      Text = "Die Zeit ist abgelaufen, die Polizei hat das Treibgut beschlagnahmt. Sprich mit Martha von der Rettungswacht am Teppich.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"weiter"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB5
    })
  else
    var_TimerTeppich = var_TimerTeppich - 1
    if var_TimerTeppich == 120 then
      Wherigo.PlayAudio(zmediaS_Turmglocke)
      Wherigo.MessageBox({
        Text = "Beeile Dich, Du hast nur noch 2 Minuten Zeit.",
        Media = zmediaHilfe_Anzahl,
        Buttons = {"weiter"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB6
      })
    elseif var_TimerTeppich == 240 then
      Wherigo.PlayAudio(zmediaS_Turmglocke)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die Zeit l\195\164uft gegen Dich!<BR>\nDu hast nur noch 4 Minuten Zeit um das Treibgut vor der Polizei abzuholen.", {PocketPC = 1}),
        Media = zmediaHilfe_Anzahl,
        Buttons = {"weiter"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB7
      })
    end
  end
end
function ztimerPortal1906anzeigenMggelwald:OnTick()
  Wherigo.PlayAudio(zmediaS_Portal_Eintritt)
  ztaskAufMighlawarten.Visible = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Pl\195\182tzlich kommt dichter Nebel auf. Nichts ist zu h\195\182ren oder zu sehen. <BR>\nEs ist also soweit! Du stehst mitten im Reiseportal Mighla.<BR>\nBitte aktiviere die Zeitreise-Maschine bevor Mighla verschwindet.", {PocketPC = 1}),
    Media = zmediaNebel,
    Buttons = {
      "Aktivierungsformel"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB8
  })
end
function ztimerPortalGegenwartanzeigen:OnTick()
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  ztaskMighlafinden.Active = true
  zonePortalGegenwart.Active = true
end
function ztimerPortal_1906_anzeigen:OnTick()
  Wherigo.PlayAudio(zmediaS_Portal_Eintritt)
  ztaskAufMighlawarten.Visible = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Pl\195\182tzlich kommt dichter Nebel auf. Nichts ist zu h\195\182ren oder zu sehen. <BR>\nEs ist also soweit! Sie stehen mitten im Reiseportal Mighla.<BR>\nBitte aktivieren Sie die Zeitreise-Maschine bevor Mighla verschwindet.", {PocketPC = 1}),
    Media = zmediaNebel,
    Buttons = {
      "Aktivierungsformel"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB10
  })
end
function ztimerPortal_1927_sichtbar:OnTick()
  zonePortal1927.Active = false
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  ztimerPortal_1927_unsichtbar:Start()
end
function ztimerPortal_1927_sichtbar:OnStart()
  zonePortal1927.Active = true
end
function ztimerPortal_1927_unsichtbar:OnTick()
  ztimerPortal_1927_sichtbar:Start()
  zonePortal1927.Active = true
  Wherigo.PlayAudio(zmediaS_Hinweiston)
end
function ztimerTaucherBadebucht1:OnTick()
  Wherigo.Command("StopSound")
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  zcharacterTaucher.Visible = true
end
function ztimerTaucherBadebucht2:OnTick()
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  Wherigo.MessageBox({
    Text = "Da sind die ersten Luftblasen der Taucher zu sehen, hoffentlich waren sie dieses Mal erfolgreich.",
    Media = zmediaGedankenblase,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB12
  })
end
function ztimerTaucherBadebucht2a:OnTick()
  Wherigo.Command("StopSound")
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ah, da kommen die Taucher. Sieht so aus als wenn ein Taucher eine Truhe tr\195\164gt.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB13
  })
end
function ztimerbergabeKallesichtbar:OnTick()
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  ztimerbergabeKalleunsichtbar:Start()
  zonebergabeKalle.Active = false
end
function ztimerbergabeKalleunsichtbar:OnTick()
  ztimerbergabeKallesichtbar:Start()
  zonebergabeKalle.Active = true
end
function zone02a_Eingang_MP1:OnEnter()
  Wherigo.PlayAudio(zmediaS_Trillerpfeifekurz)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Halt, mein Herr!<BR>\nSchutzmann Hirte mein Name, ich muss Sie kurz aufhalten. <BR>\nWir verfolgen einen \195\188blen Hochstapler und Gauner. <BR>\nW\195\188rden Sie sich bitte das Bild anschauen.", {PocketPC = 1}),
    Media = zmediaSchutzmann,
    Buttons = {
      "Bild ansehen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB14
  })
end
function zone02b_Eingang_MP2:OnEnter()
  Wherigo.PlayAudio(zmediaS_Trillerpfeifekurz)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Halt, mein Herr!<BR>\nSchutzmann Hirte mein Name, ich muss Sie kurz aufhalten. <BR>\nWir verfolgen einen \195\188blen Hochstapler und Gauner. <BR>\nW\195\188rden Sie sich bitte das Bild anschauen.", {PocketPC = 1}),
    Media = zmediaSchutzmann,
    Buttons = {
      "Bild ansehen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB14
  })
end
function zone02c_Eingang_MP3:OnEnter()
  Wherigo.PlayAudio(zmediaS_Trillerpfeifekurz)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Halt, mein Herr!<BR>\nSchutzmann Hirte mein Name, ich muss Sie kurz aufhalten. <BR>\nWir verfolgen einen \195\188blen Hochstapler und Gauner. <BR>\nW\195\188rden Sie sich bitte das Bild anschauen.", {PocketPC = 1}),
    Media = zmediaSchutzmann,
    Buttons = {
      "Bild ansehen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB14
  })
end
function zone04_Spreetunnel_Stop:OnEnter()
  Wherigo.PlayAudio(zmediaS_Alarm)
  zone04_Spreetunnel_Stop_gr.Active = true
  zone04_Spreetunnel_Stop.Active = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Hier geht es nicht weiter, der Spreetunnel den Du kennst wird erst 1927 fertiggestellt. <BR>\nNutze Mighla! <BR>\nGer\195\188chte besagen, dass der Nebel regelm\195\164\195\159ig irgendwo hier im Park auftaucht.", {PocketPC = 1}),
    Buttons = {
      "Mighla suchen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB16
  })
end
function zone04_Spreetunnel_Stop_gr:OnExit()
  zone04_Spreetunnel_Stop.Active = true
  zone04_Spreetunnel_Stop_gr.Active = false
end
function zone07_Spreetunnel_Ausgang:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zone08_Spreetunnel_Ausgang_.Active = true
  zone07_Spreetunnel_Ausgang.Active = false
  ztaskDasSpreeuferwechseln.Complete = true
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Willkommen auf der anderen Seite der Spree.<BR>\nWarte hier, Mighla erscheint in K\195\188rze und bringt Dich wieder ins Jahr 1906, damit ist der Weg zur\195\188ck durch den Spreetunnel nicht mehr m\195\182glich.<BR>\nDie Polizei sucht immer noch nach Zille und seinen Handlangern, Du musst also weiterhin vorsichtig agieren. <BR>\n", {PocketPC = 1}),
    Buttons = {"verstanden"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB17
  })
end
function zone09_Spree_Ecke:OnEnter()
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zone08_Spreetunnel_Ausgang_.Active = false
  zitemHinweis.Visible = true
end
function zoneBadebucht1:OnDistant()
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  zoneBadebucht1.Visible = true
end
function zoneBadebucht1:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneBadebucht1.Active = false
  zoneLufer_.Active = false
  zoneBadebucht1_.Active = true
  ztaskBadebuchtaufsuchen.Active = false
  ztaskBadebuchtaufsuchen.Description = WWB_multiplatform_string("Gehe weiter vom letzten Treffen mit den Tauchern 550 m Richtung S\195\188den, zu einer weiteren Badebucht.")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Da sind die ersten Luftblasen der Taucher zu sehen, dann sind sie hoffentlich erfolgreich auf dem R\195\188ckweg.", {PocketPC = 1}),
    Media = zmediaGedankenblase,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB18
  })
end
function zoneBadebucht2:OnDistant()
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  zoneBadebucht2.Visible = true
end
function zoneBadebucht2:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneBadebucht2.Active = false
  zoneBadebucht1_.Active = false
  zoneBadebucht2_.Active = true
  zcharacterTaucher:MoveTo(zoneBadebucht2_)
  zcharacterTaucher.Commands.Ahoi.Enabled = true
  ztaskBadebuchtaufsuchen.Active = false
  Wherigo.MessageBox({
    Text = "Dieses Mal sind noch keine Anzeichen von den Tauchern zu sehen. ",
    Media = zmediaGedankenblase,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB19
  })
end
function zoneBedrfnisanstallt:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneBedrfnisanstallt_.Active = true
  zoneBedrfnisanstallt.Active = false
  ztaskDemHinweisfolgen.Complete = true
  zitemStadtplanMggelpark.Commands.anschauen.Enabled = false
  Wherigo.MessageBox({
    Text = "Hier ist der auf der Karte markierte Ort.",
    Media = zmediaBedrfnisanstalt,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB20
  })
  cartMighlaTeil1v3:RequestSync()
end
function zoneBedrfnisanstallt_:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
end
function zoneBiergarten:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  if Wherigo.NoCaseEquals(var_Blumenfrau_nicht_bezahlt, "nein") then
  else
    Wherigo.PlayAudio(zmediaS_Zoneneintritt)
    zoneBiergarten_.Active = true
    zoneBiergarten.Active = false
    zoneTreppezumBiergarten_.Active = false
    Wherigo.Command("StopSound")
    ztaskBriefgelesen.Active = true
    Wherigo.PlayAudio(zmediaS_Gasthaus)
    Wherigo.MessageBox({
      Text = [[
Guten Tag mein Herr,<BR>
darf ich Ihnen einen Platz anbieten?]],
      Media = zmediaKellnerin,
      Buttons = {
        "Guten Tag,..."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB23
    })
  end
end
function zoneBiergarten_:OnExit()
  if zitemBrief2vomVoigt.Locked == false then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gehe zur\195\188ck, Du hast etwas vergessen mitzunehmen", {PocketPC = 1}),
      Media = zmediaHilfe_Anzahl,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB28
    })
  elseif Wherigo.NoCaseEquals(var_Kellnerinnichtbezahlt, "nein") then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    var_Kellnerinbezahlt = "nein"
    zcharacterKellnerin.Commands.Kellnerinrufen.Enabled = false
    zitemGeld.Commands.Kellnerinbezahlen.Enabled = false
    zoneSeglerheim.Active = false
    ztaskKellnerinbezahlen.Active = true
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Hallo mein Herr, kommen Sie zur\195\188ck!<BR>\nSie haben Ihre Zeche noch nicht bezahlt!", {PocketPC = 1}),
      Media = zmediaKellnerin,
      Buttons = {
        "Oh, tut mir leid."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB29
    })
  elseif zitemBrief2vomVoigt.Locked == true and zitemFoto08vonKellnerin.Locked == true then
    zoneTreppezumBiergarten_.Active = false
    zoneBiergarten_.Active = false
    zitemBrief2vomVoigt.Commands.einpacken.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    cartMighlaTeil1v3:RequestSync()
  else
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gehe zur\195\188ck, Du hast etwas vergessen mitzunehmen", {PocketPC = 1}),
      Media = zmediaHilfe_Anzahl,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB28
    })
  end
end
function zoneBiergarten_:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
end
function zoneFotobox:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
end
function zoneKoffer:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
end
function zoneLufer:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneLufer_.Active = true
  zoneLufer.Active = false
  zcharacterTaucher.Visible = true
  Wherigo.PlayAudio(zmediaS_Strand)
end
function zoneLufer_:OnExit()
  Wherigo.Command("StopSound")
end
function zonePortal1927:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  ztimerPortal_1927_sichtbar:Stop()
  ztimerPortal_1927_unsichtbar:Stop()
  zonePortal1927_.Active = true
  zonePortal1927.Active = false
  zone04_Spreetunnel_Stop.Active = false
  ztaskMighlafinden.Complete = true
  zone04_Spreetunnel_Stop_gr.Active = false
  ztaskFotoboxffnen.Description = WWB_multiplatform_string("Du hast die Fotobox von Zille bekommen, \195\182ffne sie.")
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Pl\195\182tzlich kommt dichter Nebel auf! Nichts ist zu h\195\182ren oder zu sehen. Du hast Mighla gefunden! Du stehst im Reiseportal, aktiviere die Zeitreise-Maschine bevor Mighla verschwindet.", {PocketPC = 1}),
    Media = zmediaNebel,
    Buttons = {
      "Aktivierungsformel"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB30
  })
  cartMighlaTeil1v3:RequestSync()
end
function zonePortal1927_:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
  Wherigo.Command("StopSound")
  Wherigo.PlayAudio(zmediaS_Portal_Eintritt)
end
function zonePortalGegenwart:OnEnter()
  Wherigo.PlayAudio(zmediaS_Portal_Eintritt)
  zonePortalGegenwart.Active = false
  zonePortalGegenwart_.Active = true
  zitemBrief4vomVoigt.Visible = false
  ztaskMighlafinden.Active = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Pl\195\182tzlich kommt dichter Nebel auf! Nichts ist zu h\195\182ren oder zu sehen. Du hast Mighla gefunden! Du stehst im Reiseportal, aktiviere die Zeitreise-Maschine bevor Mighla verschwindet.", {PocketPC = 1}),
    Media = zmediaNebel,
    Buttons = {
      "Aktivierungsformel"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB32
  })
end
function zonePortalGegenwart_:OnExit()
  zonePortalGegenwart_.Visible = false
end
function zoneSchliessfach:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneSchliessfach_.Active = true
  zoneSchliessfach.Active = false
end
function zoneSchliessfach_:OnEnter()
  zitemSchliessfach.Visible = true
end
function zoneSchliessfach_:OnExit()
  if var_SchliessfachGbS == 5 then
  else
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gehe zur\195\188ck, Du hast etwas vergessen mitzunehmen", {PocketPC = 1}),
      Media = zmediaHilfe_Anzahl,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB28
    })
  end
end
function zoneSchutzhtte:OnProximity()
  Wherigo.PlayAudio(zmediaS_Hinweiston)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Du kannst Dein Ziel schon sehen, als pl\195\182tzlich Nebel vom M\195\188ggelsee aufzieht. Gehe weiter.", {PocketPC = 1}),
    Media = zmediaNebel_02,
    Buttons = {"weiter"}
  })
end
function zoneSchutzhtte:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneSchutzhtte_.Active = true
  zoneSchutzhtte.Active = false
  zitemTruhe.Commands.Codeeingeben.Enabled = true
  zitemTruhe.Commands.ansehen.Enabled = false
  zitemTruhe.Commands._1Hilfe.Enabled = false
  ztaskAufgabe7lsen.Active = false
  ztaskAufgabe8lsen.Active = true
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Du bist in der Schutzh\195\188tte. Der Nebel wird immer dichter!", {PocketPC = 1}),
    Media = zmediaNebel_01,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB35
  })
  cartMighlaTeil1v3:RequestSync()
end
function zoneSchutzhtte_:OnExit()
  zoneSchutzhtte_.Active = false
end
function zoneSeglerheim:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneSeglerheim.Active = false
  zoneSeglerheim_.Active = true
  ztaskFindedasSeglerheim.Complete = true
end
function zoneSeglerheim_:OnExit()
  if Player:Contains(zitemBrief3vomVoigt) and zoneFotobox:Contains(zitemFoto09vonKapitn) then
  else
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gehe zur\195\188ck, Du hast etwas vergessen mitzunehmen", {PocketPC = 1}),
      Media = zmediaHilfe_Anzahl,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB28
    })
  end
end
function zoneSpreetunnelEingang:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneSpreetunnelEingang_.Active = true
  zoneSpreetunnelEingang.Active = false
  zcharacterZeitungsjunge.Visible = true
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Extra-Blatt, kostenlose Ausgabe der M\195\164rkischen Radfahrer Zeitung!<BR>\n<BR>\n", {PocketPC = 1}),
    Media = zmediaZeitungsjunge,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB36
  })
end
function zoneSpreetunnelEingang_:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
end
function zoneStartzone:OnEnter()
  ztaskZurStartzonegehen.Complete = true
  zoneStartzone_.Active = true
  zoneStartzone.Active = false
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  ztaskAufMighlawarten.Visible = true
  zitemSpeichern:MoveTo(Player)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Willkommen in Ihrer Startzone.<BR>\nBitte warten Sie hier! Die Zeitreise in das Jahr 1906 beginnt in K\195\188rze. Halten Sie die ausgedruckten Reiseunterlagen \"Portal Aktivierungskarten\"<BR>\nund die \"Portal Zeitreise-Maschine\" bereit. <BR>\nWichtig! Falls Sie etwas vergessen haben, gehen sie nicht weiter!<BR>\nKlicken Sie auf \"zur\195\188ck\" und verlassen Sie die Zone, ansonsten sind Sie unweigerlich in Mighla gefangen und k\195\182nnen nicht von uns zur\195\188ckgeholt werden.", {PocketPC = 1}),
    Media = zmediaLogo,
    Buttons = {
      "weiter",
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB38
  })
end
function zoneStartzone_:OnExit()
  if Player:Contains(zitemFoto01vonVoigt) and Player:Contains(zitemStadtplanMggelpark) then
    cartMighlaTeil1v3:RequestSync()
  elseif ztaskGegenstndeaufheben.Active == true then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gehe zur\195\188ck, Du hast etwas vergessen mitzunehmen", {PocketPC = 1}),
      Media = zmediaHilfe_Anzahl,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB28
    })
  end
end
function zoneTeppich:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneTeppich_.Active = true
  zoneTeppich.Active = false
  ztimerPolizeiTeppich:Stop()
  Wherigo.PlayAudio(zmediaS_Strand)
end
function zoneTeppich_:OnExit()
  Wherigo.Command("StopSound")
  zoneTeppich_.Active = false
end
function zoneTeppich_:OnSetActive()
  cartMighlaTeil1v3:RequestSync()
end
function zoneTreppezumBiergarten:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zoneTreppezumBiergarten_.Active = true
  zoneTreppezumBiergarten.Active = false
  zcharacterBlumenfrau.Visible = true
end
function zoneTreppezumBiergarten_:OnExit()
  if Player:Contains(zitemNelke) then
    if Wherigo.NoCaseEquals(var_Blumenfrau_nicht_bezahlt, "nein") then
      Wherigo.PlayAudio(zmediaS_HinweisFehler)
      var_Blumenfrau_bezahlt = "nein"
      zitemGeld.Commands.Blumenfraubezahlen.Enabled = true
      zcharacterBlumenfrau.Commands.Schuldbegleichen.Enabled = true
      cartMighlaTeil1v3:RequestSync()
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Hallo mein Herr, kommen Sie zur\195\188ck!<BR>\nSie m\195\188ssen noch die Nelke bezahlen!", {PocketPC = 1}),
        Media = zmediaBlumenfrau,
        Buttons = {"Oh..."},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB39
      })
    else
      zitemGeld.Commands.Blumenfraubezahlen.Enabled = false
    end
  end
end
function zonebergabeKalle:OnEnter()
  if zitemKoffer.Locked == true then
  else
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
  end
  Wherigo.PlayAudio(zmediaS_Zoneneintritt)
  zonebergabeKalle.Active = false
  zonebergabeKalle_.Active = true
  ztimerbergabeKallesichtbar:Stop()
  ztimerbergabeKalleunsichtbar:Stop()
  zcharacterSeebr:MoveTo(zonebergabeKalle_)
  zcharacterSeebr.Visible = true
  zcharacterSeebr.Commands.Gesundheit.Enabled = false
  zcharacterSeebr.Commands.HalloKalle.Enabled = true
  cartMighlaTeil1v3:RequestSync()
end
function zcharacterBlumenfrau:Onansprechen()
  var_Blumenfrau_bezahlt = "ja"
  zcharacterBlumenfrau.Commands.ansprechen.Enabled = false
  zcharacterBlumenfrau.Commands.Nelkenehmen.Enabled = true
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Guten Tag,<BR>\nich w\195\188rde gerne eine Nelke bei Ihnen kaufen."),
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Guten Tag, das macht einen Groschen oder Sie nehmen zehn Nelken f\195\188rn fuffziger."),
      Media = zmediaBlumenfrau
    },
    {
      Text = WWB_multiplatform_string("Vielen Dank f\195\188r Ihr Angebot, mir reicht wirklich eine Nelke."),
      Media = zmediaSpieler
    },
    {
      Text = [[
Na dann gibt es auch nur eine, damit machen Sie sich aber nicht allerliebst bei Ihrem Schatz. Hihi<BR>
Hier bitte, eine Nelke....<BR>
]],
      Media = zmediaBlumenfrau
    }
  })
end
function zcharacterBlumenfrau:OnNelkenehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Einen Moment bitte, ich muss erst etwas in meinen Koffer packen damit ich die Nelke nehmen kann.",
      Media = zmediaSpieler,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB41
    })
  else
    zitemNelke:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zcharacterBlumenfrau.Commands.Nelkenehmen.Enabled = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Vielen Dank, die Nelke sieht sehr sch\195\182n aus.<BR>\n", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        WWB_multiplatform_string("Bittesch\195\182n", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB42
    })
  end
end
function zcharacterBlumenfrau:Onnochmalsansprechen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Hallo,<BR>\nhaben Sie es sich doch anders \195\188berlegt?<BR>\nOder war Ihr Schatz mit der einen Nelke nicht zufrieden?<BR>\nIch h\195\164tte da noch so einige Tipps auf Lager und die ganz umsonst.....", {PocketPC = 1}),
    Media = zmediaBlumenfrau,
    Buttons = {
      "Ja, her mit den Tips.",
      "Nein, danke."
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB43
  })
end
function zcharacterBlumenfrau:OnSchuldbegleichen()
  Wherigo.MessageBox({
    Text = "Hier bitte der Groschen den ich Ihnen schulde.",
    Media = zmediaSpieler,
    Buttons = {
      WWB_multiplatform_string("Dankesch\195\182n...", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB45
  })
end
function zcharacterKapitn:Onansprechen()
  zcharacterKapitn.Commands.ansprechen.Enabled = false
  zcharacterKapitn.Commands.Antwort.Enabled = true
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Guten Tag, sind Sie Kapit\195\164n Wolle?"),
      Media = zmediaSpieler
    },
    {
      Text = "Ahoi, wer will das wissen?",
      Media = zmediaKapitn
    },
    {
      Text = "Entschuldigung, Beck mein Name. Ein gemeinsamer Bekannter schickt mich zu Ihnen.<BR>\n",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Ah, Beck. Na und! Da k\195\182nnte ja jeder hier seine Seemannswolle spinnen."),
      Media = zmediaKapitn
    },
    {
      Text = WWB_multiplatform_string("Seemannswolle spinnen? Was meint der Kapit\195\164n?"),
      Media = zmediaGedankenblase
    }
  })
end
function zcharacterKapitn:OnAntwort()
  Wherigo.GetInput(zinputParoleKapitn)
end
function zcharacterKapitn:OnBriefFotonehemn()
  if var_Inventar_Spieler >= 5 then
    zitemFoto09vonKapitn:MoveTo(zoneFotobox)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment, meine H\195\164nde sind voll. Packen Sie das Foto in die Fotobox und ich packe etwas aus meiner Hand in den Koffer. Dann kann ich den Brief nehmen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {"Ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB47
    })
  else
    zitemFoto09vonKapitn:MoveTo(zoneFotobox)
    zitemBrief3vomVoigt:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zcharacterKapitn.Commands.BriefFotonehemn.Enabled = false
    ztaskGegenstndemitnehmen.Visible = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bittesch\195\182n. Machen Sie sich nun auf den Weg.<BR>\nAhoi und viel Erfolg bei der Bergung!", {PocketPC = 1}),
      Media = zmediaKapitn,
      Buttons = {
        "Aufwiedersehen"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB48
    })
  end
end
function zcharacterKapitn:OnHallo()
  zcharacterKapitn.Commands.Hallo.Enabled = false
  zcharacterKapitn.Commands.Antwort.Enabled = true
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("...Herr Kapit\195\164n Wolle."),
      Media = zmediaSpieler
    },
    {
      Text = "Ahoi, wer sind Sie?",
      Media = zmediaKapitn
    },
    {
      Text = "Entschuldigung, Beck mein Name. Ein gemeinsamer Bekannter schickt mich zu Ihnen.<BR>\n",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Ah, Beck. Na und! Da k\195\182nnte ja jeder hier seine Seemannswolle spinnen."),
      Media = zmediaKapitn
    },
    {
      Text = WWB_multiplatform_string("Nun wei\195\159 ich ja Bescheid."),
      Media = zmediaGedankenblase
    }
  })
end
function zcharacterKellnerin:Onansprechen()
  zoneSeglerheim.Active = true
  ztaskKellnerinbezahlen.Active = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Tut mir leid! Das war keine Absicht!<BR>\nDann m\195\182chte ich jetzt gerne bezahlen.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB49
  })
end
function zcharacterKellnerin:OnFotonehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Moment, ich muss erst etwas in den Koffer packen dann kann ich das Foto nehmen.",
      Media = zmediaSpieler,
      Buttons = {
        "Ok,ich warte"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB51
    })
  else
    zitemFoto08vonKellnerin:MoveTo(Player)
    ztaskGegenstndemitnehmen.Visible = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemFoto08vonKellnerin.Locked = true
    zcharacterKellnerin.Visible = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Auf Wiedersehen und beehren Sie uns bald wieder.",
      Media = zmediaKellnerin,
      Buttons = {
        "Auf Wiedersehen"
      }
    })
  end
end
function zcharacterKellnerin:OnJavielenDank()
  zcharacterKellnerin.Visible = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Bittesch\195\182n!<BR>\nLassen Sie es sich schmecken.", {PocketPC = 1}),
    Media = zmediaKellnerin,
    Buttons = {
      WWB_multiplatform_string("Dankesch\195\182n", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB53
  })
end
function zcharacterKellnerin:OnKellnerinrufen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ja, was kann ich f\195\188r Sie tun?", {PocketPC = 1}),
    Media = zmediaKellnerin,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB55
  })
end
function zcharacterMaler:Onannehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Moment, ich muss erst etwas in den Koffer packen dann kann ich die Zeichnung und die Fotobox nehmen.",
      Media = zmediaSpieler,
      Buttons = {
        "Ok,ich warte"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB56
    })
  else
    zitemZeichnungvonZille:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemFotoboxvonZille:MoveTo(Player)
    zitemFoto02ausFotobox:MoveTo(zoneFotobox)
    zitemFoto01vonVoigt.Commands.indieFotoboxpacken.Enabled = true
    zitemFoto07ausdemKoffer.Commands.indieFotoboxpacken.Enabled = true
    ztaskFotoboxffnen.Visible = true
    Wherigo.MessageBox({
      Text = [[
... eine gute Entscheidung. <BR>
Wir sollten jetzt schnellstens von hier verschwinden.<BR>
Versuchen Sie die andere Seite der Spree zu erreichen.<BR>
Gutes Gelingen, ick hoffe Wilhelm hat den Richtigen ausgesucht!]],
      Media = zmediaZille,
      Buttons = {
        "Aufwiedersehen"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB57
    })
  end
end
function zcharacterMaler:Onansprechen()
  zcharacterMaler.Commands.ansprechen.Enabled = false
  zcharacterMaler.Commands.annehmen.Enabled = true
  ztaskDemHinweisfolgen.Complete = true
  zcharacterMaler.Name = "Zille"
  Wherigo.Dialog({
    {
      Text = "Guten Tag, Beck mein Name. Kann ich Ihnen helfen?",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Guten Tag auch, Zille mein Name. Da sind Sie ja endlich. Ick soll Ihnen eine Fotobox und eine meiner Zeichnungen \195\188bergeben. Die Sachen brennen mir schon den ganzen Tag in der Tasche, wo hier doch so viele weisse M\195\164use rum rennen."),
      Media = zmediaZille
    },
    {
      Text = WWB_multiplatform_string("Das verstehe ich nicht. Ich h\195\164tte eher gedacht Sie wollten sich mit Herrn Voigt treffen?"),
      Media = zmediaSpieler
    },
    {
      Text = "Ne, ne. Der hat gesagt Sie kommen vorbei.",
      Media = zmediaZille
    },
    {
      Text = "Herr Voigt hat seinen Koffer und ein Bild vergessen mitzunehmen, kann ich die Sachen bei Ihnen abgeben?",
      Media = zmediaSpieler
    },
    {
      Text = "Um Gottes Willen, nein! Voigt sagte Sie brauchen die Sachen. Es geht wohl um Ihren geheimen Auftrag.",
      Media = zmediaZille
    },
    {
      Text = WWB_multiplatform_string("Was f\195\188r ein Auftrag? Ich mache hier Urlaub."),
      Media = zmediaSpieler
    },
    {
      Text = [[
Keine Ahnung, wir reden schon viel zu lange miteinander.<BR>
Nehmen Sie jetzt die Fotobox und die Zeichnung?]],
      Media = zmediaZille
    }
  })
end
function zcharacterMann:Onansprechen()
  zcharacterMann.Commands.ansprechen.Enabled = false
  zcharacterMann.Name = "Voigt"
  Wherigo.MessageBox({
    Text = "Guten Tag, kann ich Ihnen helfen?",
    Media = zmediaSpieler,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB58
  })
end
function zcharacterMann:OnKoffernehmen()
  zcharacterMann.Commands.Koffernehmen.Enabled = false
  zitemKoffer:MoveTo(Player)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Sehr nett, vielen Dank. Dann schaue ich mal auf meinen Stadtplan.<BR>\nAh, schon gefunden. Der Park ist ja hier gleich um die Ecke am M\195\188ggelsee.", {PocketPC = 1}),
    Media = zmediaVoigt,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB59
  })
end
function zcharacterRettungsschwimmer:Onansprechen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Guten Tag, Beck mein Name.<BR>\nIch suche die Rettungsschwimmerin Martha, k\195\182nnen Sie mir weiterhelfen?", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {
      "Guten Tag..."
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB60
  })
end
function zcharacterRettungsschwimmerinMartha:OnHalloHerrBeck()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Guten Tag, ich soll Sie vom Kapit\195\164n Wolle gr\195\188\195\159en.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {"Danke"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB63
  })
end
function zcharacterSeebr:OnBriefnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment, meine H\195\164nde sind voll. Packen Sie das Foto in die Fotobox und ich packe etwas aus meiner Hand in den Koffer. Dann kann ich den Brief nehmen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {"Ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB47
    })
  else
    zcharacterKellnerin.Visible = true
    zitemBrief2vomVoigt:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemBrief2vomVoigt.Locked = true
    ztaskBrieflesen.Active = true
    ztaskGegenstndemitnehmen.Visible = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gut, das Foto soll ich Ihnen auch geben. Das packen wir am Besten gleich in die Fotobox. <BR>\nIm Biergarten ist es sicher, nehmen Sie sich etwas Zeit um den Brief vom Voigt zu lesen. <BR>\nIch muss dann mal weiter, danke f\195\188r die Molle!<BR>\nViel Erfolg und Beck,<BR>\npassen Sie auf sich auf!<BR>\nAhoi", {PocketPC = 1}),
      Media = zmediaSeebr,
      Buttons = {"Ahoi"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB67
    })
  end
end
function zcharacterSeebr:OnGesundheit()
  zcharacterKellnerin.Visible = true
  zcharacterSeebr.Commands.Gesundheit.Enabled = false
  zcharacterSeebr.Visible = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("... Dankesch\195\182n."),
      Media = zmediaSeebr
    },
    {
      Text = WWB_multiplatform_string("Sie haben mich m\195\164chtig erschreckt."),
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Tut mir leid, ich nehme an, es lag an der Nelke. Ich habe Sie vorsichtshalber beseitigt, Sie hat ja ihren Zweck erf\195\188llt.<BR>\n\195\156brigens, Kalle mein Name."),
      Media = zmediaSeebr
    },
    {
      Text = "Tag Kalle, Beck mein Name.<BR>\n",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("We\195\159 ick doch. Der Voigt sagte, Sie geben sich mir mit einer Nelke zu erkennen, und dass Sie mir ein Herrengedeck ausgeben werden.<BR>\nAls Gegenleistung soll ich Sie auf den neuesten Stand bringen was die Bergung angeht. <BR>\nMolle und Korn hab ich schon f\195\188r uns bestellt.<BR>\n"),
      Media = zmediaSeebr
    },
    {
      Text = "Da wissen Sie aber viel mehr als ich. Um was geht es hier eigentlich?<BR>\n",
      Media = zmediaSpieler
    },
    {
      Text = "Immer ruhig mit die jungen Seepferde! Ah, da kommt ja die Kellnerin.",
      Media = zmediaSeebr
    }
  })
end
function zcharacterSeebr:OnHalloKalle()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Hallo Beck, <BR>\nich konnte die Sache in unserem Sinne regeln. Beim Wachtmeister Erich hatte ich noch ne Runde offen, er schl\195\164ft nun seinen Rausch aus.<BR>\nHier das Treibgut, bis bald Beck.", {PocketPC = 1}),
    Media = zmediaSeebr,
    Buttons = {
      "Vielen Dank Kalle"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB68
  })
end
function zcharacterSeebr:OnTreibgutnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment bitte, meine H\195\164nde sind voll. Ich muss erst etwas in den Koffer packen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Ok, ich warte."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB69
    })
  else
    zitemTreibgut:MoveTo(Player)
    zitemTreibgut.Commands.auspacken.Enabled = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    ztaskTreibgutabholen.Complete = true
    zitemTreibgut.Visible = true
    zonebergabeKalle_.Active = false
    zcharacterSeebr.Visible = false
    zcharacterTaucher.Commands.Binwiederzurck.Enabled = true
    zcharacterTaucher.Commands.ansprechen.Enabled = false
    zoneLufer.Active = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
    })
  end
end
function zcharacterTaucher:OnAhoi()
  Wherigo.MessageBox({
    Text = "...ich sehe Sie waren erfolgreich.",
    Media = zmediaSpieler,
    Buttons = {"Ahoi..."},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB71
  })
end
function zcharacterTaucher:Onansprechen()
  if var_Taucherwiederholtansprechen > 0 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Haben Sie nicht verstanden?<BR>\nSie m\195\188ssen das Treibgut vor der Polizei am Teppich abholen.", {PocketPC = 1}),
      Buttons = {"ok"}
    })
  elseif ztaskTreibgutabholen.Complete == false then
    ztaskTreffedieTaucher.Complete = true
    var_Taucherwiederholtansprechen = var_Taucherwiederholtansprechen + 1
    var_zuerstamTeppich = var_zuerstamTeppich - 1
    zoneLufer_.Active = false
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Guten Tag, Beck mein Name. <BR>\nSch\195\182ne Ecke hier, hab hier mein Seepferdchen vor Jahren gemacht.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB74
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Guten Tag, Beck mein Name. Sch\195\182ne Ecke hier, der Kapit\195\164n Wolle sagte mir, dass ich Sie hier treffen werde.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {"Ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB79
    })
  end
end
function zcharacterTaucher:OnBinwiederzurck()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Gut, dann k\195\182nnen Sie uns nun die Koordinaten geben.", {PocketPC = 1}),
    Media = zmediaTaucher,
    Buttons = {"Ja", "Nein"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB82
  })
  zcharacterTaucher.Commands.Binwiederzurck.Enabled = false
end
function zcharacterTaucher:OnInformationnehmen()
  zitemStadtkasse3von3:MoveTo(Player)
  zcharacterTaucher.Visible = false
  zcharacterTaucher.Commands.ansprechen.Enabled = false
  zcharacterTaucher.Commands.Binwiederzurck.Enabled = false
  zcharacterTaucher.Commands.Informationnehmen.Enabled = false
  zcharacterTaucher.Commands.WarenSieerfolgreich.Enabled = true
  zoneBadebucht1.Active = true
  var_Inventar_Spieler = var_Inventar_Spieler + 1
  zitemTreibgut.Commands.Codeeingeben.Enabled = true
  zitemTreibgut.Commands.ffnen.Enabled = false
  zcharacterTaucher:MoveTo(zoneBadebucht1_)
  ztaskAufgabe5lsen.Active = true
  ztaskBadebuchtaufsuchen.Active = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zcharacterTaucher:OnKoordinatenansagen()
  Wherigo.GetInput(zinputNavigationKoordinate)
end
function zcharacterTaucher:OnSchlossInformationen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Leider ist die Pause zu Ende. Ich kann Ihnen den Code f\195\188r das Schloss nennen.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {
      "Code eingeben"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB85
  })
end
function zcharacterTaucher:OnTruhenehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment bitte, meine H\195\164nde sind voll. Ich muss erst etwas in den Koffer packen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Ok, ich warte."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB69
    })
  else
    zcharacterTaucher.Commands.Truhenehmen.Enabled = false
    zitemTruhe:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Vielen Dank, f\195\188r Ihre Unterst\195\188tzung.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Gern geschehen..."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB86
    })
  end
end
function zcharacterTaucher:OnWarenSieerfolgreich()
  zcharacterTaucher.Commands.WarenSieerfolgreich.Enabled = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Nur zum Teil.<BR>\nWir haben eine Truhe am Grund des Sees gefunden, sie ist mit Ketten und einem Schloss gesichert. Das Schloss ist mit einer Zahlenkombination zu \195\182ffnen. Au\195\159erdem konnten wir eine in \195\150lpapier eingepackte Zeitungsseite von der Kette l\195\182sen.<BR>\nK\195\182nnen Sie damit etwas anfangen?", {PocketPC = 1}),
    Media = zmediaTaucher,
    Buttons = {
      "Zeitung annehmen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB88
  })
end
function zcharacterTaucher:OnZeitungnehmen()
  zcharacterTaucher.Commands.Zeitungnehmen.Enabled = false
  zitemRadfahrerZeitungS37:MoveTo(Player)
  var_Inventar_Spieler = var_Inventar_Spieler + 1
  ztaskAufgabe6lsen.Active = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Vom Schloss wusste ich nichts! Aber danke f\195\188r den ersten Versuch. Machen Sie erstmal eine Pause und ich schaue ob ich mit der Zeitungsseite etwas anfangen kann.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {"Bis gleich"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB89
  })
end
function zcharacterZeitungsjunge:Onannehmen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Vielen Dank f\195\188r die Zeitung und Deine Information.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {
      "Auf Wiedersehen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB90
  })
  cartMighlaTeil1v3:RequestSync()
  zitemRadfahrerZeitungS1:MoveTo(zoneKoffer)
  var_Anzahl_Hilfen_WfW = "0 Punkte WfW"
  zitemRadfahrerZeitungS41:MoveTo(zoneKoffer)
  zitemFoto01vonVoigt.Commands.Hilfe1RtselWfW.Enabled = true
  zitemFoto03vonZeitungsjunge:MoveTo(zoneKoffer)
  ztaskAufgabe2lsen.Active = true
  zcharacterZeitungsjunge.Visible = false
  zoneSpreetunnelEingang_.Active = false
end
function zcharacterZeitungsjunge:Onansprechen()
  zcharacterZeitungsjunge.Commands.ansprechen.Enabled = false
  zcharacterZeitungsjunge.Commands.annehmen.Enabled = true
  Wherigo.Dialog({
    {Text = "Guten Tag.", Media = zmediaSpieler},
    {
      Text = WWB_multiplatform_string("Guten Tag,<BR>\nich habe f\195\188r Sie die letzte historische Ausgabe der M\195\164rkischen Radfahrer Zeitung vom 18. Januar 1906!"),
      Media = zmediaZeitungsjunge
    },
    {
      Text = [[
Das ist nett von Dir,<BR>
ich habe nur kein Rad und noch weniger Zeit zum Lesen!]],
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Herr Voigt war sich sicher, dass Sie heute vorbeikommen und in diesem Fall soll ich Ihnen unbedingt diese Seiten aus der Zeitung und ein Foto \195\188bergeben."),
      Media = zmediaZeitungsjunge
    },
    {
      Text = WWB_multiplatform_string("Na gut, wenn dem so ist werde ich Dir die Zeitungsseiten und das Foto nat\195\188rlich abnehmen."),
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Herr Beck, ich soll Ihnen noch mitteilen, dass Sie sich etwas Zeit nehmen sollen bevor Sie den Spreetunnel durchqueren.<BR>\nSie sollen sich vorher unbedingt mit den Hinweisen \"WfW\" vertraut machen. <BR>\nPacken Sie das Bild und die Zeitungsseiten in Ihren Koffer.<BR>\nIch w\195\188nsche Ihnen einen sch\195\182nen Tag und viel Erfolg."),
      Media = zmediaZeitungsjunge
    }
  })
end
function zitemBrief2vomVoigt:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemBrief2vomVoigt:MoveTo(Player)
    zitemBrief2vomVoigt.Commands.lesen.Enabled = true
    zitemBrief2vomVoigt.Commands.auspacken.Enabled = false
    zitemBrief2vomVoigt.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemBrief2vomVoigt:OnBriefffnen()
  zitemBrief2vomVoigt.Commands.Briefffnen.Enabled = false
  zitemBrief2vomVoigt.Commands.lesen.Enabled = true
  zitemBrief2vomVoigt.Commands.Stadtkasseherausnehmen.Enabled = true
  zitemBrief2vomVoigt.Media = zmediaBriefumschlagoffen
  zitemBrief2vomVoigt.Name = "Brief 2 vom Voigt offen"
end
function zitemBrief2vomVoigt:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemBrief2vomVoigt:MoveTo(zoneKoffer)
  zitemBrief2vomVoigt.Commands.lesen.Enabled = false
  zitemBrief2vomVoigt.Commands.einpacken.Enabled = false
  zitemBrief2vomVoigt.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemBrief2vomVoigt:Onlesen()
  ztaskBrieflesen.Active = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Guten Tag Beck, <BR>\nleider hatte ich bei unserem nicht ganz zuf\195\164lligen Treffen an der Brauerei keine Zeit Sie einzuweihen. <BR>\nNun will ich Sie aber in Kenntnis setzten, soweit es in dieser Phase der Bergung m\195\182glich ist.<BR>\nBei meiner kleinen Tour durch das Rathaus von C\195\182penick ist mir ein Dokument vom Kaiser an meinen klebrigen Finger h\195\164ngen geblieben. Aktien oder Schuldverschreibungen dachte ich damals.<BR>\n\t", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      "weiterlesen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB96
  })
end
function zitemBrief2vomVoigt:OnStadtkasseherausnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemStadtkasse2von3:MoveTo(Player)
    zitemBrief2vomVoigt.Commands.Stadtkasseherausnehmen.Enabled = false
    zitemBrief2vomVoigt.Commands.einpacken.Enabled = true
    zitemStadtkasse2von3.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
    })
  end
end
function zitemBrief3vomVoigt:Onentsorgen()
  zitemBrief3vomVoigt.Visible = false
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Der Brief wurde entsorgt",
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB99
  })
end
function zitemBrief3vomVoigt:Onffnen()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemBrief3vomVoigt.Commands.ffnen.Enabled = false
  zitemBrief3vomVoigt.Commands.FotoindieBox.Enabled = true
  zitemBrief3vomVoigt.Commands.Navigationherausnehmen.Enabled = true
  zitemBrief3vomVoigt.Name = "Brief 3 vom Voigt offen"
  zitemBrief3vomVoigt.Description = WWB_multiplatform_string("Inhalt: ein Foto und das R\195\164tsel Navigation")
  zitemBrief3vomVoigt.Media = zmediaBriefumschlagoffen
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Der Brief ist offen.",
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB100
  })
end
function zitemBrief3vomVoigt:OnFotoindieBox()
  zitemBrief3vomVoigt.Commands.FotoindieBox.Enabled = false
  zitemFoto12ausBrief3:MoveTo(zoneFotobox)
  zitemFoto12ausBrief3.Locked = true
  if zitemFoto12ausBrief3.Locked == true and zitemNavigationausBrief3.Locked == true then
    zitemBrief3vomVoigt.Visible = false
    var_Inventar_Spieler = var_Inventar_Spieler - 1
  end
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Der Gegenstand ist nun in Deinem Inventar.",
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
  })
end
function zitemBrief3vomVoigt:OnNavigationherausnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemNavigationausBrief3.Locked = true
    if zitemFoto12ausBrief3.Locked == true and zitemNavigationausBrief3.Locked == true then
      zitemBrief3vomVoigt.Visible = false
      var_Inventar_Spieler = var_Inventar_Spieler - 1
    end
    zitemBrief3vomVoigt.Commands.Navigationherausnehmen.Enabled = false
    zitemNavigationausBrief3:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
end
function zitemBrief4vomVoigt:Onlesen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch Beck, <BR>\nSie haben meine Erwartungen vollstens erf\195\188llt! <BR>\nDas war die letzte Sicherheitsvorkehrung um das Dokument zu sch\195\188tzen. Dadurch wird Mighla erneut aktiviert, das Portal wird Ihnen die Reise in Ihre Zeit zur\195\188ck erm\195\182glichen. <BR>\nDort angekommen wird Ihnen mittgeteilt, wo sich das Dokument befindet. Achten Sie auf die Zeichen im Nebel!<BR>\n", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB102
  })
end
function zitemBrief:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemBrief.Commands.auspacken.Enabled = false
    zitemBrief.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemBrief:MoveTo(Player)
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemBrief:Oneinpacken()
  zitemBrief.Commands.einpacken.Enabled = false
  zitemBrief.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  zitemBrief:MoveTo(zoneKoffer)
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemBrief:Onlesen()
  zitemBrief.Description = ""
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch! <BR>\nSie haben die Reise ins Jahr 1906 gewonnen.<BR>\n~<BR>\nDie erforderlichen Unterlagen und das Zeitreiseportal haben wir f\195\188r Sie vorbereitet. Sicher haben Sie Verst\195\164ndnis, dass wir keine Risiken \195\188bernehmen, schlie\195\159lich reisen Sie freiwillig und kostenlos. Mit dem Lesen dieser Zeilen erkl\195\164ren Sie sich bereit alle Konsequenzen zu \195\188bernehmen. <BR>\n~<BR>\nVielen Dank!<BR>\n~<BR>\nBeachten sie bitte die folgenden Hinweise.", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {"Hinweise"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB104
  })
end
function zitemBriefvomVoigt:Onffnen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Der Briefumschlag enth\195\164lt eine Karte.", {PocketPC = 1}),
    Media = zmediaGedankenblase,
    Buttons = {
      "Karte ansehen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB111
  })
end
function zitemDokumentenSchlssel:OnQRCode()
  Wherigo.MessageBox({
    Text = "https://geomcwood.wixsite.com/mighla/dokument",
    Media = zmediaQR_Code,
    Buttons = {"ok"}
  })
end
function zitemEingabeNavigation:OnDateneingeben()
  Wherigo.GetInput(zinputNavigationKoordinate)
end
function zitemEingabeZeitreise1111906:OnDateneingeben()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise 1.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 180 Grad und drehe die Karte rechts von Dir um.<BR>\nDrehe Dich um 90 Grad linksherum und tausche die Karten rechts und links von Dir.<BR>\nTausche die Karten von Zeit und von Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der Bildung.<BR>\nDrehe Dich um 90 Grad nach rechts.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine ", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB11
  })
end
function zitemEingabeZeitreise1927:OnDateneingeben()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise 26.5.1927<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. <BR>\nStelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte hinter Dir um.<BR>\nTausche die Karten von Zeit und Ort.<BR>\nDrehe Dich um 90 Grad linksherum und drehe die Karten links von Dir und vor Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 180 Grad.<BR>\nDrehe Dich um 90 Grad nach links.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB31
  })
end
function zitemEingabeZeitreise2111906:OnDateneingeben()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise 2.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nTausche die Karten von Zeit und Reise.<BR>\nDrehe die Karten links und rechts von Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 90 Grad nach rechts und tausche die Karte hinter Dir mit der vor Dir.<BR>\nDrehe die Karte Reise um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB9
  })
end
function zitemEingabeZeitreiseGegenwart:OnDateneingeben()
  Wherigo.GetInput(zinputZeitreiseDatenGegenwart)
end
function zitemEndeTeil1:Onweiter()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im 2. Teil der Reise bleiben Dir alle Gegenst\195\164nde erhalten. Diese findest Du dann im verschlossenen Koffer und in der Fotobox. Denke an den Kofferschl\195\188ssel!<BR>\n~<BR>\nDu kannst nun mit dem UnlockCode, der sich im Inventar befindet, diesen Teil bei Wherigo.com loggen. <BR>\nErst am Ende der Reise wartet der Cache auf Dich.<BR>\n~<BR>\nEs Gr\195\188\195\159t Voigt und McWood!<BR>\nBis hoffentlich bald!", {PocketPC = 1}),
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB93
  })
end
function zitemFoto01vonVoigt:Onaufheben()
  zitemFoto01vonVoigt:MoveTo(Player)
  zitemFoto01vonVoigt.Commands.aufheben.Enabled = false
  var_Inventar_Spieler = var_Inventar_Spieler + 1
  if Player:Contains(zitemFoto01vonVoigt) and Player:Contains(zitemStadtplanMggelpark) then
    zoneStartzone_.Active = false
    zone02a_Eingang_MP1.Active = true
    zone02b_Eingang_MP2.Active = true
    zone02c_Eingang_MP3.Active = true
    ztaskGegenstndemitnehmen.Complete = true
    ztaskGegenstndeaufheben.Active = false
    ztaskGegenstndemitnehmen.Visible = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  else
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
end
function zitemFoto01vonVoigt:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemFoto01vonVoigt.Commands.auspacken.Enabled = false
    zitemFoto01vonVoigt.Commands.indieFotoboxpacken.Enabled = true
    zitemFoto01vonVoigt:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
    cartMighlaTeil1v3:RequestSync()
  end
end
function zitemFoto01vonVoigt:OnHilfe1RtselWfW()
  var_Anzahl_Hilfen_WfW = "1 Punkt WfW"
  var_Anzahl_Hilfen_WfWLsung = 1
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Du ben\195\182tigst den Stadtplan M\195\188ggelpark vom Voigt, die Zeichnung vom Zille, die Radfahrerzeitung S.1 + S.41 vom Zeitungsjungen.", {PocketPC = 1}),
    Media = zmediaHilfe,
    Buttons = {
      "neuer Versuch",
      "2.Hilfe"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB113
  })
end
function zitemFoto01vonVoigt:OnindieFotoboxpacken()
  zitemFoto01vonVoigt:MoveTo(zoneFotobox)
  zitemFoto01vonVoigt.Commands.indieFotoboxpacken.Enabled = false
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  zitemFoto01vonVoigt.Commands.auspacken.Enabled = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto02ausFotobox:Onverstanden()
  zitemFoto02ausFotobox.Commands.verstanden.Enabled = false
  ztaskMighlafinden.Active = true
  ztimerPortal_1927_unsichtbar:Start()
  cartMighlaTeil1v3:RequestSync()
end
function zitemFoto03vonZeitungsjunge:OnindieFotoboxpacken()
  zitemFoto03vonZeitungsjunge:MoveTo(zoneFotobox)
  zitemFoto03vonZeitungsjunge.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto04ausSchliessfach:OnindieFotoboxpacken()
  zitemFoto04ausSchliessfach:MoveTo(zoneFotobox)
  zitemFoto04ausSchliessfach.Commands.indieFotoboxpacken.Enabled = false
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto04ausSchliessfach:Onnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_Hinweiston)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemFoto04ausSchliessfach.Commands.nehmen.Enabled = false
    zitemFoto04ausSchliessfach.Commands.indieFotoboxpacken.Enabled = true
    zitemFoto04ausSchliessfach:MoveTo(Player)
    var_SchliessfachGbS = var_SchliessfachGbS + 1
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
  if var_SchliessfachGbS == 5 then
    zoneTreppezumBiergarten.Active = true
    zoneBiergarten.Active = true
    zoneSchliessfach_.Active = false
    cartMighlaTeil1v3:RequestSync()
  end
end
function zitemFoto05vonBlumenfrau:OnindieFotoboxpacken()
  zitemFoto05vonBlumenfrau:MoveTo(zoneFotobox)
  zitemFoto05vonBlumenfrau.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto06vonKalle:OnindieFotoboxpacken()
  zitemFoto06vonKalle:MoveTo(zoneFotobox)
  zitemFoto06vonKalle.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto07ausdemKoffer:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemFoto07ausdemKoffer:MoveTo(Player)
    zitemFoto07ausdemKoffer.Commands.auspacken.Enabled = false
    zitemFoto07ausdemKoffer.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemFoto07ausdemKoffer:OnindieFotoboxpacken()
  zitemFoto07ausdemKoffer:MoveTo(zoneFotobox)
  if zitemFoto07ausdemKoffer.Locked == true then
  else
    var_Inventar_Spieler = var_Inventar_Spieler - 1
  end
  zitemFoto07ausdemKoffer.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto08vonKellnerin:OnindieFotoboxpacken()
  zitemFoto08vonKellnerin:MoveTo(zoneFotobox)
  zitemFoto08vonKellnerin.Commands.indieFotoboxpacken.Enabled = false
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto09vonKapitn:OnindieFotoboxpacken()
  zitemFoto09vonKapitn:MoveTo(zoneFotobox)
  zitemFoto09vonKapitn.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto10vonMarta:OnindieFotoboxpacken()
  zitemFoto10vonMarta:MoveTo(zoneFotobox)
  zitemFoto10vonMarta.Commands.indieFotoboxpacken.Enabled = false
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto11ausTreibgut:OnindieFotoboxpacken()
  zitemFoto11ausTreibgut:MoveTo(zoneFotobox)
  zitemFoto11ausTreibgut.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto12ausBrief3:OnindieFotoboxpacken()
  zitemFoto12ausBrief3:MoveTo(zoneFotobox)
  zitemFoto12ausBrief3.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Foto ist nun in der Fotobox.",
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116
  })
end
function zitemFoto12ausBrief3:OnLsungscodeeingeben()
  zitemFoto12ausBrief3.Commands.Lsungscodeeingeben.Enabled = false
  Wherigo.GetInput(zinputHilfeTruheAuflsung)
end
function zitemFotoboxvonZille:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemFotoboxvonZille:MoveTo(Player)
    zitemFotoboxvonZille.Commands.auspacken.Enabled = false
    zitemFotoboxvonZille.Commands.einpacken.Enabled = true
    zitemFotoboxvonZille.Commands.ffnen.Enabled = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemFotoboxvonZille:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemFotoboxvonZille:MoveTo(zoneKoffer)
  zitemFotoboxvonZille.Commands.einpacken.Enabled = false
  zitemFotoboxvonZille.Commands.auspacken.Enabled = true
  zitemFotoboxvonZille.Commands.ffnen.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemFotoboxvonZille:Onffnen()
  if zitemFotoboxvonZille.Locked == true then
    zitemFotoboxvonZille.Locked = false
    zitemFotoboxvonZille.Commands.ffnen.Enabled = false
    zitemFotoboxvonZille.Commands.schliessen.Enabled = true
    ztaskFotoboxschlieen.Visible = true
    ztaskFotoboxffnen.Active = false
    zitemFotoboxvonZille.Commands.einpacken.Enabled = false
    Wherigo.MessageBox({
      Text = "Die Fotobox ist offen. Du kannst Dir jetzt die Fotos ansehen.",
      Buttons = {
        "Fotos ansehen"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB117
    })
  end
end
function zitemFotoboxvonZille:Onschliessen()
  if zitemFotoboxvonZille.Locked == true then
  else
    zitemFotoboxvonZille.Commands.schliessen.Enabled = false
    zitemFotoboxvonZille.Commands.ffnen.Enabled = true
    zitemFotoboxvonZille.Locked = true
    zitemFotoboxvonZille.Description = "Sammle in der Box Deine Fotos, das entlastet Dein Inventar. Dies funktioniert auch bei geschlossener Fotobox."
    zitemFotoboxvonZille.Name = "Fotobox geschlossen"
    zoneFotobox.Active = false
    zitemFotoboxvonZille:MoveTo(Player)
    ztaskFotoboxschlieen.Visible = false
    zitemFotoboxvonZille.Commands.einpacken.Enabled = true
    Wherigo.MessageBox({
      Text = "Die Fotobox ist zu.",
      Buttons = {"ok"}
    })
  end
end
function zitemGeld:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemGeld:MoveTo(Player)
    zitemGeld.Commands.auspacken.Enabled = false
    zitemGeld.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemGeld:OnBlumenfraubezahlen()
  if Wherigo.NoCaseEquals(var_Blumenfrau_bezahlt, "ja") then
    zitemGeld.Commands.Blumenfraubezahlen.Enabled = false
    zcharacterBlumenfrau.Commands.nochmalsansprechen.Enabled = true
    var_Blumenfrau_nicht_bezahlt = "ja"
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Danke! Weil Sie so nett sind gibts noch ein kleines Pr\195\164sent von mir in die Fotobox.<BR>\nViel Erfolg mit der Nelke!<BR>\n", {PocketPC = 1}),
      Media = zmediaBlumenfrau,
      Buttons = {
        WWB_multiplatform_string("Tsch\195\188ss und Danke!", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB119
    })
  else
    ztaskEineNelkekaufen.Complete = true
    var_Blumenfrau_nicht_bezahlt = "ja"
    zitemGeld.Commands.Blumenfraubezahlen.Enabled = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Hier bitte der Groschen den ich Ihnen schulde.",
      Media = zmediaSpieler,
      Buttons = {
        WWB_multiplatform_string("Dankesch\195\182n...", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB45
    })
  end
end
function zitemGeld:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemGeld:MoveTo(zoneKoffer)
  zitemGeld.Commands.nehmen.Enabled = false
  zitemGeld.Commands.einpacken.Enabled = false
  zitemGeld.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemGeld:OnKellnerinbezahlen()
  if Wherigo.NoCaseEquals(var_Kellnerinbezahlt, "ja") then
    zitemGeld.Commands.Kellnerinbezahlen.Enabled = false
    var_Kellnerinnichtbezahlt = "ja"
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Dann bekommen Sie eine Mark und f\195\188nf Pfennige.<BR>\nDer Rest ist f\195\188r Sie.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        WWB_multiplatform_string("Bittesch\195\182n", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB120
    })
  else
    zitemGeld.Commands.Kellnerinbezahlen.Enabled = false
    var_Kellnerinnichtbezahlt = "ja"
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Dann bekommen Sie eine Mark und f\195\188nf Pfennige.<BR>\nDer Rest ist f\195\188r Sie.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        WWB_multiplatform_string("Bittesch\195\182n", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB120
    })
  end
end
function zitemGeld:Onnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_Hinweiston)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemGeld:MoveTo(Player)
    zitemGeld.Commands.nehmen.Enabled = false
    zitemGeld.Commands.einpacken.Enabled = true
    var_SchliessfachGbS = var_SchliessfachGbS + 1
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
  if var_SchliessfachGbS == 5 then
    zoneTreppezumBiergarten.Active = true
    zoneBiergarten.Active = true
    zoneSchliessfach_.Active = false
  end
end
function zitemHilfeInventarzhler:OnInventaranzeigen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Du hast momentan: " .. var_Inventar_Spieler .. " Gegenst\195\164nde in der Hand.<BR>\nHilfez\195\164hler, Koffer und Speichern z\195\164hlen nicht als Gegenst\195\164nde des Inventars.<BR>\n<BR>\n", {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
end
function zitemHilfeInventarzhler:OnPunkteanzeigen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Dir wurden folgende Punkte f\195\188r Hilfen beim L\195\182sen der R\195\164tsel 1-4 angerechnet:<BR>\n~<BR>\n" .. var_Anzahl_Hilfen_1_11_1906 .. " angerechnet.<BR>\n" .. var_Anzahl_Hilfen_Kofferschoss .. " angerechnet.<BR>\n" .. var_Anzahl_Hilfen_26_05_1927 .. " angerechnet.<BR>\n" .. var_Anzahl_Hilfen_WfW .. " angerechnet.<BR>\n", {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
end
function zitemHilfePunkteTeil1:OnPunkteanzeigen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("F\195\188r Deinen Log oder den Vergleich untereinander sind hier die Punkte f\195\188r Deine ben\195\182tigten Hilfen zum L\195\182sen der R\195\164tsel aufgelistet.<BR>\n~<BR>\n" .. var_Anzahl_Hilfen_1_11_1906Lsung .. " Punkte Zeitreise 1.11.1906<BR>\n" .. var_Anzahl_Hilfen_KofferschossLsung .. " Punkte Kofferschloss<BR>\n" .. var_Anzahl_Hilfen_26_05_1927Lsung .. " Punkte Zeitreise 26.5.1927<BR>\n" .. var_Anzahl_Hilfen_WfWLsung .. [[
 Punkte WfW<BR>
~<BR>
Zusammenrechnen musst Du ggf. selber ;-)]], {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {"Ok"}
  })
end
function zitemHilfePunkteTeil2:OnPunkteanzeigen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("F\195\188r Deinen Log oder den Vergleich untereinander sind hier die Punkte f\195\188r Deine ben\195\182tigten Hilfen zum L\195\182sen der R\195\164tsel aufgelistet.<BR>\n~<BR>\n" .. var_Anzahl_Hilfen_1_11_1906Lsung .. " Punkte Zeitreise 1.11.1906<BR>\n" .. var_Anzahl_Hilfen_KofferschossLsung .. " Punkte Kofferschloss<BR>\n" .. var_Anzahl_Hilfen_26_05_1927Lsung .. " Punkte Zeitreise 26.5.1927<BR>\n" .. var_Anzahl_Hilfen_WfWLsung .. " Punkte WfW<BR>\n" .. var_Anzahl_Hilfen_2_11_1906Lsung .. " Punkte Zeitreise 2.11.1906<BR>\n" .. var_Anzahl_Hilfen_SchliessfachLsung .. " Punkte Scliessfach<BR>\n" .. var_Anzahl_Hilfen_NavigationLsung .. " Punkte Navigation<BR>\n" .. var_Anzahl_Hilfen_TreibgutLsung .. " Punkte Treibgut<BR>\n" .. var_Anzahl_Hilfen_KettenschlossLsung .. " Punkte Kettenschloss<BR>\n" .. var_Anzahl_Hilfen_TruheLsung .. " Punkte Truhe<BR>\n" .. var_Anzahl_Hilfen_SchutzhtteLsung .. " Punkte Schutzh\195\188tte<BR>\n" .. var_Anzahl_Hilfen_PelleLsung .. " Punkte Pelle<BR>\n" .. var_Anzahl_Hilfen_GegenwartLsung .. [[
 Punkte Zeitreise Gegenwart<BR>
~<BR>
Zusammenrechnen musst Du ggf. selber ;-)]], {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {"Ok"}
  })
end
function zitemHinweis:Onnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemHinweis:MoveTo(Player)
    zone09_Spree_Ecke.Active = false
    zoneSchliessfach.Active = true
    zitemHinweis.Commands.nehmen.Enabled = false
    ztaskAufgabe2lsen.Active = false
    ztaskAufgabe3lsen.Active = true
    ztaskFindedenHinweis.Active = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemHinweis.Opened = true
    zitemFoto01vonVoigt.Commands.Hilfe1RtselWfW.Enabled = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
    })
  end
end
function zitemKarte:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Auf der Karte steht:<BR>\n\"Zellen schw\195\164rzen!\"<BR>\n\"aber nur diese 6\"<BR>\n\"f\195\188r den Kofferschl\195\188ssel\"<BR>\nund es sind 6 Symbole zu erkennen.", {PocketPC = 1}),
    Buttons = {"Ok"}
  })
end
function zitemKoffer:OnKofferffnen()
  if zitemKoffer.Locked == true then
    if ztaskKofferschlsselbenutzt.Complete == true then
      Wherigo.PlayAudio(zmediaS_auf_zuschlieen)
      zitemKoffer.Locked = false
      zitemKoffer.Commands.Kofferffnen.Enabled = false
      zitemKoffer.Commands.schliessen.Enabled = true
      zitemKoffer.Media = zmediaKofferauf
      zitemKoffer.Name = WWB_multiplatform_string("Koffer schlie\195\159en")
      zitemKoffer.Description = WWB_multiplatform_string("Schlie\195\159e den Koffer um den \195\156berblick \195\188ber die sichtbaren Gegenst\195\164nde zu behalten.")
      ztaskKofferschlieen.Visible = true
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Koffer ist nun offen, schaue Dir den Kofferinhalt an. Bei Bedarf kannst Du Gegenst\195\164nde auspacken, sie landen dann in Deinem Inventar. Ebenso kannst Du jederzeit Gegenst\195\164nde aus Deinem Inventar in den Koffer packen (auch wenn der Koffer zu ist).", {PocketPC = 1}),
        Media = zmediaKofferauf,
        Buttons = {
          "Inhalt ansehen",
          WWB_multiplatform_string("Koffer schlie\195\159en", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB127
      })
    else
      Wherigo.MessageBox({
        Text = "Der Koffer ist verschlossen",
        Media = zmediaKoffer,
        Buttons = {"ok"}
      })
      zitemKoffer.Commands.Kofferffnen.Enabled = false
      zitemKoffer.Description = "Der Koffer ist verschlossen"
    end
  end
end
function zitemKoffer:Onschliessen()
  if zitemKoffer.Locked == true then
  else
    Wherigo.PlayAudio(zmediaS_auf_zuschlieen)
    zoneKoffer.Active = false
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Wenn Du Dir den Inhalt vom Koffer ansehen m\195\182chtest oder Gegenst\195\164nde auspacken m\195\182chtest, \195\182ffne den Koffer.")
    ztaskKofferschlieen.Visible = false
    zitemKoffer:MoveTo(Player)
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Koffer ist geschlossen",
      Media = zmediaKoffer,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB128
    })
  end
end
function zitemKoffer:OnSchlossffnen()
  Wherigo.GetInput(zinputKofferschlossCode)
end
function zitemKofferschlsseluStadtkasse:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemKofferschlsseluStadtkasse:MoveTo(Player)
    zitemKofferschlsseluStadtkasse.Commands.auspacken.Enabled = false
    zitemKofferschlsseluStadtkasse.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemKofferschlsseluStadtkasse:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemKofferschlsseluStadtkasse:MoveTo(zoneKoffer)
  zitemKofferschlsseluStadtkasse.Commands.einpacken.Enabled = false
  zitemKofferschlsseluStadtkasse.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemKofferschlsseluStadtkasse:Onzurck()
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function zitemMighla:OnHilfe()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Zahlen im Nebel sehen wie eine Telefonnummer aus,<BR>\nda Du Dich in der Gegenwart befindest ist ein Anruf m\195\182glich.<BR>\n~<BR>\nKlicke auf lesen wenn Du nicht anrufen m\195\182chtest.", {PocketPC = 1}),
    Media = zmediaMighlaFinaleTelefonnummer,
    Buttons = {"ok", "lesen"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB130
  })
end
function zitemMighla:Onweiter()
  Wherigo.MessageBox({
    Text = [[
War Dein Anruf erfolgreich?<BR>
Falls nicht, klicke auf Hilfe.]],
    Media = zmediaMighlaFinaleTelefonnummer,
    Buttons = {"Ja", "Hilfe"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB131
  })
end
function zitemMighlaAB:OnABabhren()
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Hier ist der Anschluss der Reiseagentur Dunnemals. Da Mighla Ihnen diese Telefonnummer mitgeteilt hat, sind Sie gem\195\164\195\159 Anweisung von Herrn Voigt autorisiert, das Dokument zu bergen und dessen Inhalt zu verbreiten. <BR>\n~<BR>\nSie finden das Dokument an folgenden Koordinaten. Denken Sie an den letzten Hinweis von McWood und Dunnemals<BR>\n~<BR>\nBitte notieren Sie: <BR>\nNord 52 Grad 25 Punkt 554 Minuten, <BR>\nOst 013 Grad 37 Punkt 954 Minuten.")
    }
  })
end
function zitemNavigationausBrief3:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemNavigationausBrief3:MoveTo(Player)
    zitemNavigationausBrief3.Commands.auspacken.Enabled = false
    zitemNavigationausBrief3.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemNavigationausBrief3:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Navigation Tauchziel<BR>\n-<BR>\nEs scheint es muss etwas auf Karopapier entschl\195\188sselt werden.<BR>\n-<BR>\n(gelb)W-W-N-N-O-W-N-N-O-O-O-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-N-N-O-O-S-S-N-N-N-N-O-S-S-S-S-O-O-N-N-N-N-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-O-NO-N-N-NW-W-O-O-O-O-O-W-W-S-S-O-W-S-S-O-O-O-N-N-N-N-O-SO-SW-W-SO-SO-O-N-N-N-N-W-O-O-O-<BR>\n", {PocketPC = 1}),
    Media = zmediaNavigation,
    Buttons = {"Detail 2"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB136
  })
end
function zitemNavigationausBrief3:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemNavigationausBrief3:MoveTo(zoneKoffer)
  zitemNavigationausBrief3.Commands.einpacken.Enabled = false
  zitemNavigationausBrief3.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemNotiz:Onlesen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Gut gemacht bis hierher!<BR>\nIch habe mich scheinbar nicht in Ihnen get\195\164uscht.<BR>\nNehmen Sie den Inhalt aus dem Schlie\195\159fach an sich, gehen Sie dann ins Wirtshaus M\195\188ggelschl\195\182sschen und machen Sie es sich dort bequem. Ein treuer Freund von mir wird Sie im Wirtshaus kontaktieren und Ihnen weitere Einzelheiten mitteilen.<BR>\nKaufen Sie als Erkennungszeichen vor dem Gasthaus eine Nelke.<BR>\nViel Erfolg weiterhin!<BR>\nVoigt<BR>\nVernichten Sie diese Notiz!", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      "Notiz vernichten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB139
  })
end
function zitemPergament:Onlesen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Hallo Beck,<BR>\num die Truhe zu \195\182ffnen, m\195\188ssen Sie einen letzten Code eingeben.<BR>\nOnkel Pelle, ein Freund von Zille, hat uns bei dieser Verschl\195\188sselung unterst\195\188tzt. Schauen Sie sich das komplette Pergament an.<BR>\nLegen Sie die Portalaktivierungskarten wie folgt nebeneinander aus:<BR>\n1 9 7 3", {PocketPC = 1}),
    Media = zmediaPergament,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB140
  })
end
function zitemPortalAktivierungskarten:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemPortalAktivierungskarten:MoveTo(Player)
    zitemPortalAktivierungskarten.Commands.auspacken.Enabled = false
    zitemPortalAktivierungskarten.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemPortalAktivierungskarten:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemPortalAktivierungskarten:MoveTo(zoneKoffer)
  zitemPortalAktivierungskarten.Commands.einpacken.Enabled = false
  zitemPortalAktivierungskarten.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemPortalAktivierungskarten:Onzurck()
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function zitemPortalZeitreisemaschiene:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemPortalZeitreisemaschiene:MoveTo(Player)
    zitemPortalZeitreisemaschiene.Commands.auspacken.Enabled = false
    zitemPortalZeitreisemaschiene.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemPortalZeitreisemaschiene:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemPortalZeitreisemaschiene:MoveTo(zoneKoffer)
  zitemPortalZeitreisemaschiene.Commands.einpacken.Enabled = false
  zitemPortalZeitreisemaschiene.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemPortalZeitreisemaschiene:Onzurck()
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function zitemRadfahrerZeitungS1:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemRadfahrerZeitungS1:MoveTo(Player)
    zitemRadfahrerZeitungS1.Commands.auspacken.Enabled = false
    zitemRadfahrerZeitungS1.Commands.einpacken.Enabled = true
    zitemRadfahrerZeitungS1.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemRadfahrerZeitungS1:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("M\195\164rkische Radfahrer Zeitung S.1<BR>\n~<BR>\n-WfW-<BR>\ndas vom \195\182ffnen zuerst welcher der vom neunzehn war, die Ausgabe welchem die Du Spreetunnel zur der die Dort einen die den<BR>\n~<BR>\nJahrgang 1, Nummer 3, Berlin 1.11.1906<BR>\nerscheint Donnerstags, Redaktionsschluss: Montag Abend 6 Uhr<BR>\n~<BR>\nReklame 1 Mark, Anzeige pro Zeile 40 Pfennige", {PocketPC = 1}),
    Media = zmediaRadfahrerZeitungS1,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
end
function zitemRadfahrerZeitungS1:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemRadfahrerZeitungS1:MoveTo(zoneKoffer)
  zitemRadfahrerZeitungS1.Commands.einpacken.Enabled = false
  zitemRadfahrerZeitungS1.Commands.auspacken.Enabled = true
  zitemRadfahrerZeitungS1.Locked = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemRadfahrerZeitungS37:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemRadfahrerZeitungS37:MoveTo(Player)
    zitemRadfahrerZeitungS37.Commands.auspacken.Enabled = false
    zitemRadfahrerZeitungS37.Commands.einpacken.Enabled = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemRadfahrerZeitungS37:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("M\195\164rkische Radfahrer Zeitung<BR>\nR-A-D<BR>\n~<BR>\nDas R-A-D kannst Du nur l\195\182sen wenn Du hinten anf\195\164ngst!<BR>\nImmer nur ein Wort!<BR>\nVon oben nach unten!<BR>\nDas gel\195\182ste R-A-D \195\182ffnet Dir das Schloss im See!<BR>\n", {PocketPC = 1}),
    Media = zmediaRadfahrerZeitungS37,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
  zitemRadfahrerZeitungS37.Name = "Radfahrer Zeitung S.37"
end
function zitemRadfahrerZeitungS37:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemRadfahrerZeitungS37:MoveTo(zoneKoffer)
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  zitemRadfahrerZeitungS37.Commands.einpacken.Enabled = false
  zitemRadfahrerZeitungS37.Commands.auspacken.Enabled = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemRadfahrerZeitungS41:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemRadfahrerZeitungS41:MoveTo(Player)
    zitemRadfahrerZeitungS41.Commands.auspacken.Enabled = false
    zitemRadfahrerZeitungS41.Commands.einpacken.Enabled = true
    zitemRadfahrerZeitungS41.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemRadfahrerZeitungS41:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Radfahrerzeitung S.41<BR>\n-WfW-<BR>\ngehe in den Spreetunnel und l\195\182se WfW wie es weiter geht<BR>\n~<BR>\n1-Staffellei - 2-Zeitung - 3-Plan<BR>\n~<BR>\nWir versichern:<BR>\nWort f\195\188r Wort \195\182ffnet jedes Schliessfach", {PocketPC = 1}),
    Media = zmediaRadfahrerZeitungS41,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
end
function zitemRadfahrerZeitungS41:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemRadfahrerZeitungS41:MoveTo(zoneKoffer)
  zitemRadfahrerZeitungS41.Commands.einpacken.Enabled = false
  zitemRadfahrerZeitungS41.Commands.auspacken.Enabled = true
  zitemRadfahrerZeitungS41.Locked = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemRadfahrerZeitungS45:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemRadfahrerZeitungS45:MoveTo(Player)
    zitemRadfahrerZeitungS45.Commands.Details.Enabled = false
    zitemRadfahrerZeitungS45.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemRadfahrerZeitungS45:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("M\195\164rkische Radfahrer Zeitung<BR>\nR-A-D<BR>\n~<BR>\n-Wer das &nbsp;R - A - D &nbsp;sucht z\195\164hle-<BR>\n-die KETTENR\195\132DER mit KURBELKEIL vom-<BR>\n-DOPPEL-GLOCKENLAGER. Ein Zubeh\195\182r-<BR>\n-das ebenfalls Verbindung schafft ist die-<BR>\n-SATTELST\195\156TZE, mit SATTEL und der richtigen-<BR>\n-Montage st\195\188tzt sie Deine vier Buchstaben.-<BR>\n-An schnell drehenden GLOCKENRIEMEN die-<BR>\n-zu laut t\195\182nen muss die Reihenfolge-<BR>\n-der DREIRADACHSE angepasst werden. Es bleibt-<BR>\n-jedoch zur Steuerung die LENKSTANGE bestehen.-<BR>\n~<BR>\nHilfe:<BR>\nText innerhalb -...- entspricht einer Zeile.", {PocketPC = 1}),
    Media = zmediaRadfahrerZeitungS45,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
end
function zitemRadfahrerZeitungS45:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemRadfahrerZeitungS45:MoveTo(zoneKoffer)
  zitemRadfahrerZeitungS45.Commands.einpacken.Enabled = false
  zitemRadfahrerZeitungS45.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemSchliessfach:OnCodeeingeben()
  Wherigo.GetInput(zinputSchliessfach_Code)
end
function zitemSchliessfach:OnInhaltansehen()
  zitemFoto04ausSchliessfach.Visible = true
  zitemGeld.Visible = true
  zitemStadtplanMggelwald.Visible = true
  zitemNotiz.Visible = true
  zitemStadtkasse1von3.Visible = true
  zitemSchliessfach.Commands.Inhaltansehen.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zitemSchliessfach:Onschliessen()
  if var_SchliessfachGbS == 5 then
    zitemSchliessfach.Commands.schliessen.Enabled = false
    zoneTreppezumBiergarten.Active = true
    zoneBiergarten.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    zoneSchliessfach_.Active = false
    cartMighlaTeil1v3:RequestSync()
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du hast etwas im Schlie\195\159fach vergessen", {PocketPC = 1}),
      Media = zmediaHilfe_Anzahl,
      Buttons = {"Danke"}
    })
  end
end
function zitemSchutzhtteInnen:OnEingangsSeite()
  if zitemSchwarzlicht.Opened == true then
    zitemSchutzhtteInnen.Media = zmediaNebelSHTr
    zitemSchutzhtteInnen.Description = WWB_multiplatform_string("Durch das Schwarzlicht ist auf den Brettern \195\188ber dem Eingang der Code GeHeIMnIS zu erkennen.")
  else
    zitemSchutzhtteInnen.Media = zmediaNebelSHFront
  end
  zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte Eingangsseite")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Klicke weiter, Du siehst dann die Eingangsseite in der Schutzh\195\188tte.", {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {"weiter"}
  })
end
function zitemSchutzhtteInnen:OnFensterSeite()
  if zitemSchwarzlicht.Opened == true then
    zitemSchutzhtteInnen.Media = zmediaNebelSHFenster
    zitemSchutzhtteInnen.Description = WWB_multiplatform_string("Durch das Schwarzlicht ist auf den Brettern \195\188ber dem Fenster das Wort Summe zu erkennen.")
  else
    zitemSchutzhtteInnen.Media = zmediaNebelSHFront
  end
  zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte Fensterseite")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Klicke weiter, Du siehst dann die Fenster Seite in der Schutzh\195\188tte.", {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {"weiter"}
  })
end
function zitemSchutzhtteInnen:OnlinkeSeite()
  if zitemSchwarzlicht.Opened == true then
    zitemSchutzhtteInnen.Media = zmediaNebelSHlinks
    zitemSchutzhtteInnen.Description = WWB_multiplatform_string("Durch das Schwarzlicht ist auf den Brettern auf der linken Seite der H\195\188tte das Wort Elemente zu erkennen.")
  else
    zitemSchutzhtteInnen.Media = zmediaNebelSHSeite
  end
  zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte linke Seite")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Klicke weiter, Du siehst dann die linke Seite in der Schutzh\195\188tte.", {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {"weiter"}
  })
end
function zitemSchutzhtteInnen:OnrechteSeite()
  if zitemSchwarzlicht.Opened == true then
    zitemSchutzhtteInnen.Media = zmediaNebelSHrechts
    zitemSchutzhtteInnen.Description = WWB_multiplatform_string("Durch das Schwarzlicht ist auf den Brettern auf der rechten Seite der H\195\188tte das Wort Ordnungszahl zu erkennen.")
  else
    zitemSchutzhtteInnen.Media = zmediaNebelSHSeite
  end
  zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte rechte Seite")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Klicke weiter, Du siehst dann die rechte Seite in der Schutzh\195\188tte.", {PocketPC = 1}),
    Media = zmediaHilfe_Anzahl,
    Buttons = {"weiter"}
  })
end
function zitemSchwarzlicht:Onaus()
  zitemSchwarzlicht.Commands.aus.Enabled = false
  zitemSchwarzlicht.Commands.ein.Enabled = true
  zitemSchwarzlicht.Media = zmediaLampeaus
  zitemSchwarzlicht.Icon = zmediaLampeaus_32
  zitemSchwarzlicht.Opened = false
  zitemSchwarzlicht.Name = "Schwarzlicht aus"
  zitemSchutzhtteInnen.Media = zmediaNebelSHFront
  zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte Innen")
  zitemSchutzhtteInnen.Description = ""
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Schwarzlicht ist aus.",
    Buttons = {"Ok"}
  })
end
function zitemSchwarzlicht:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemSchwarzlicht:MoveTo(Player)
    zitemSchwarzlicht.Commands.auspacken.Enabled = false
    zitemSchwarzlicht.Commands.einpacken.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemSchwarzlicht.Commands.ein.Enabled = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemSchwarzlicht:Onein()
  zitemSchwarzlicht.Commands.ein.Enabled = false
  zitemSchwarzlicht.Commands.aus.Enabled = true
  zitemSchwarzlicht.Media = zmediaLampean
  zitemSchwarzlicht.Icon = zmediaLampean_32
  zitemSchwarzlicht.Opened = true
  zitemSchwarzlicht.Name = "Schwarzlicht an"
  zitemSchutzhtteInnen.Name = WWB_multiplatform_string("Schutzh\195\188tte Innen")
  zitemSchutzhtteInnen.Media = zmediaNebelSHFront
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Schwarzlicht ist an.",
    Buttons = {"Ok"}
  })
end
function zitemSchwarzlicht:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemSchwarzlicht:MoveTo(zoneKoffer)
  zitemSchwarzlicht.Commands.einpacken.Enabled = false
  zitemSchwarzlicht.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  zitemSchwarzlicht.Commands.aus.Enabled = false
  zitemSchwarzlicht.Commands.ein.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemSpeichern:Onspeichern()
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Spiel wurde gespeichert.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"weiter"}
  })
end
function zitemStadtkasse1von3:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemStadtkasse1von3:MoveTo(Player)
    zitemStadtkasse1von3.Commands.auspacken.Enabled = false
    zitemStadtkasse1von3.Commands.einpacken.Enabled = true
    zitemStadtkasse1von3.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemStadtkasse1von3:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemStadtkasse1von3:MoveTo(zoneKoffer)
  zitemStadtkasse1von3.Commands.einpacken.Enabled = false
  zitemStadtkasse1von3.Commands.auspacken.Enabled = true
  zitemStadtkasse1von3.Locked = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemStadtkasse1von3:Onnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_Hinweiston)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemStadtkasse1von3:MoveTo(Player)
    zitemStadtkasse1von3.Commands.nehmen.Enabled = false
    zitemStadtkasse1von3.Commands.einpacken.Enabled = true
    zitemStadtkasse1von3.Locked = false
    var_SchliessfachGbS = var_SchliessfachGbS + 1
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
  if var_SchliessfachGbS == 5 then
    zoneSchliessfach_.Active = false
    zoneTreppezumBiergarten.Active = true
    zoneBiergarten.Active = true
    cartMighlaTeil1v3:RequestSync()
  end
end
function zitemStadtkasse2von3:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemStadtkasse2von3:MoveTo(Player)
    zitemStadtkasse2von3.Commands.auspacken.Enabled = false
    zitemStadtkasse2von3.Commands.einpacken.Enabled = true
    zitemStadtkasse2von3.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler - 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemStadtkasse2von3:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemStadtkasse2von3:MoveTo(zoneKoffer)
  zitemStadtkasse2von3.Commands.einpacken.Enabled = false
  zitemStadtkasse2von3.Commands.auspacken.Enabled = true
  zitemStadtkasse2von3.Locked = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemStadtkasse3von3:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemStadtkasse3von3:MoveTo(Player)
    zitemStadtkasse3von3.Commands.auspacken.Enabled = false
    zitemStadtkasse3von3.Commands.einpacken.Enabled = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemStadtkasse3von3:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemStadtkasse3von3:MoveTo(zoneKoffer)
  zitemStadtkasse3von3.Commands.einpacken.Enabled = false
  zitemStadtkasse3von3.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemStadtplanMggelpark:Onanschauen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Hier ist auf der Karte im Park ein Kreuz mit der Notiz \"Bed\195\188rfnisanstalt\" eingezeichnet. Vielleicht kann ich hier die Sachen von Herrn Voigt abgeben.<BR>\nDie anderen Details schaue ich mir sp\195\164ter an.", {PocketPC = 1}),
    Media = zmediaBedrfnisanstalt,
    Buttons = {
      WWB_multiplatform_string("schlie\195\159en", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB156
  })
end
function zitemStadtplanMggelpark:Onaufheben()
  zitemStadtplanMggelpark:MoveTo(Player)
  zitemStadtplanMggelpark.Commands.aufheben.Enabled = false
  zitemStadtplanMggelpark.Locked = false
  var_Inventar_Spieler = var_Inventar_Spieler + 1
  if Player:Contains(zitemFoto01vonVoigt) and Player:Contains(zitemStadtplanMggelpark) then
    zoneStartzone_.Active = false
    zone02a_Eingang_MP1.Active = true
    zone02b_Eingang_MP2.Active = true
    zone02c_Eingang_MP3.Active = true
    ztaskGegenstndemitnehmen.Complete = true
    ztaskGegenstndeaufheben.Active = false
    ztaskGegenstndemitnehmen.Visible = false
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  else
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
end
function zitemStadtplanMggelpark:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemStadtplanMggelpark:MoveTo(Player)
    zitemStadtplanMggelpark.Commands.auspacken.Enabled = false
    zitemStadtplanMggelpark.Commands.einpacken.Enabled = true
    zitemStadtplanMggelpark.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemStadtplanMggelpark:OnBriefnehmen()
  zitemBriefvomVoigt:MoveTo(Player)
  zitemStadtplanMggelpark.Commands.Briefnehmen.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Der Gegenstand ist nun in Deinem Inventar.",
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
  })
end
function zitemStadtplanMggelpark:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Stadtplan M\195\188ggelpark<BR>\n~<BR>\n-WfW-<BR>\nalte Schlie\195\159fach musst ermitteln Zeit Radfahrer ersten null wie Nummer und Jahrgang Zeitung. aus kommst Ecke M\195\188ggelsee Spree findest Hinweis Reihenfolge Zahlencode.<BR>\n", {PocketPC = 1}),
    Media = zmediaStadtplanMueggelpark,
    Buttons = {
      WWB_multiplatform_string("schlie\195\159en", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB157
  })
end
function zitemStadtplanMggelpark:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemStadtplanMggelpark:MoveTo(zoneKoffer)
  zitemStadtplanMggelpark.Commands.einpacken.Enabled = false
  zitemStadtplanMggelpark.Commands.auspacken.Enabled = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  zitemStadtplanMggelpark.Locked = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemStadtplanMggelwald:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemStadtplanMggelwald:MoveTo(Player)
    zitemStadtplanMggelwald.Commands.auspacken.Enabled = false
    zitemStadtplanMggelwald.Commands.einpacken.Enabled = true
    zitemStadtplanMggelwald.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemStadtplanMggelwald:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Auf der Karte sind einige Orte zu erkennen:<BR>\n- unweit vom Spreetunnel ist das Wirtshaus M\195\188ggelschl\195\182sschen zu sehen,<BR>\n- am M\195\188ggelseeufer sind das Seglerheim und der L\195\164ufer zu erkennen,<BR>\n- am Spreeufer liegt der Teppich.", {PocketPC = 1}),
    Buttons = {"Ok"}
  })
end
function zitemStadtplanMggelwald:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemStadtplanMggelwald:MoveTo(zoneKoffer)
  zitemStadtplanMggelwald.Commands.einpacken.Enabled = false
  zitemStadtplanMggelwald.Commands.auspacken.Enabled = true
  zitemStadtplanMggelwald.Locked = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zitemStadtplanMggelwald:Onnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_Hinweiston)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemStadtplanMggelwald:MoveTo(Player)
    zitemStadtplanMggelwald.Commands.nehmen.Enabled = false
    zitemStadtplanMggelwald.Commands.Details.Enabled = true
    zitemStadtplanMggelwald.Commands.einpacken.Enabled = true
    zitemStadtplanMggelwald.Locked = false
    var_SchliessfachGbS = var_SchliessfachGbS + 1
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101
    })
  end
  if var_SchliessfachGbS == 5 then
    zoneTreppezumBiergarten.Active = true
    zoneBiergarten.Active = true
    zoneSchliessfach_.Active = false
    cartMighlaTeil1v3:RequestSync()
  end
end
function zitemTreibgut:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemTreibgut.Commands.ffnen.Enabled = true
    zitemTreibgut.Commands.auspacken.Enabled = false
    zitemTreibgut:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
  end
end
function zitemTreibgut:OnCodeeingeben()
  Wherigo.GetInput(zinputTreibgut_Code)
end
function zitemTreibgut:Onffnen()
  if var_Treibgut_Code == 372 then
    zitemTreibgut.Commands.ffnen.Enabled = false
    zitemTreibgut.Commands.schlieen.Enabled = true
    zitemTreibgut.Commands.Inhaltentnehmen.Enabled = true
    zitemTreibgut.Description = "In der Truhe befinden sich ein Foto und die Seite 45 aus der Radfahrerzeitung."
    zitemTreibgut.Media = zmediaTreibgutoffen
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Treibgut ist offen",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"}
    })
  else
    zitemTreibgut.Description = "Der Code ist in der \"Stadtkasse\" zu finden"
    Wherigo.MessageBox({
      Text = [[
Das Treibgut ist mit einem Code verschlossen.<BR>
Du besitzt noch nicht alle Informationen.]],
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"}
    })
  end
end
function zitemTreibgut:OnInhaltentnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemFoto11ausTreibgut:MoveTo(zoneFotobox)
    zitemRadfahrerZeitungS45:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemTreibgut.Visible = false
    var_Inventar_Spieler = var_Inventar_Spieler - 1
    Wherigo.MessageBox({
      Text = "Es wurde ein weiteres Bild in die Fotobox gepackt und die Radfahrer Zeitung S.45 in Dein Inventar gepackt.",
      Media = zmediaFotobox,
      Buttons = {"Ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB161
    })
  end
end
function zitemTreibgut:Onschlieen()
  zitemTreibgut.Commands.schlieen.Enabled = false
  zitemTreibgut.Commands.Inhaltentnehmen.Enabled = false
  zitemTreibgut.Commands.ffnen.Enabled = true
  zitemTreibgut.Media = zmediaTreibgutzu
  zitemTreibgut.Description = "geschlossen"
end
function zitemTruhe:On_1Hilfe()
  var_Anzahl_Hilfen_Truhe = "1 Punkt Truhe"
  var_Anzahl_Hilfen_TruheLsung = 1
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Du ben\195\182tigst die Fotos 1 bis 11 und die Truhe.<BR>\nDas Foto auf der Unterseite der Truhe gleicht dem der Fotos die Du unterwegs \195\188bergeben bekommen hast.", {PocketPC = 1}),
    Media = zmediaHilfe,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1}),
      "2.Hilfe"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB162
  })
end
function zitemTruhe:Onansehen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Truhe sieht sehr alt aus! <BR>\nEs ist kein Schloss zu erkennen.<BR>\nAn den Ecken und Seiten sind kleine Quadrate mit Zahlen von 0 bis 9 zu sehen.<BR>\nDie Quadrate sehen beweglich aus, als ob man sie eindr\195\188cken k\195\182nnte. <BR>\nWahlloses Rumprobieren hilft hier sicher nicht! Es muss eine Reihenfolge geben.<BR>\n", {PocketPC = 1}),
    Media = zmediaTruhezu,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB165
  })
end
function zitemTruhe:OnBriefnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemTruhe.Commands.Briefnehmen.Enabled = false
    zitemBrief4vomVoigt:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemTruhe.Commands.einpacken.Enabled = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
    })
  end
end
function zitemTruhe:OnCodeeingeben()
  Wherigo.GetInput(zinputSchutzhtteCode)
end
function zitemTruhe:Oneinpacken()
  zitemTruhe.Commands.einpacken.Enabled = false
  zitemTruhe:MoveTo(zoneKoffer)
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zitemTruhe:OnPergamentnehmen()
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zitemTruhe.Media = zmediaTruhezu
    zitemTruhe.Commands.Pergamentnehmen.Enabled = false
    zitemPergament:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemPergament.Visible = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
    })
  end
end
function zitemTruhe:OnZauberCodeeingeben()
  Wherigo.GetInput(zinputPelleCodeZauberei)
end
function zitemUnlockCodeT2:OnCodeansehen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Dein Unlock Code: <BR>
~<BR>
]] .. Player.CompletionCode .. [[
<BR>
~<BR>
Falls der Code nicht funktioniert, verwende nur die ersten 15 Zeichen von diesem Code und versuche es noch einmal.]], {PocketPC = 1}),
    Media = zmediaAufgabe,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB168
  })
end
function zitemUnlockCodeTeil1:OnCodeansehen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Dein Unlock Code Mighla Teil 1: <BR>
~<BR>
]] .. Player.CompletionCode .. [[
<BR>
~<BR>
Falls der Code nicht funktioniert, verwende nur die ersten 15 Zeichen von diesem Code und versuche es noch einmal.]], {PocketPC = 1}),
    Media = zmediaAufgabe,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB169
  })
end
function zitemZeichnungvonZille:Onauspacken()
  if var_Inventar_Spieler >= 5 then
    Wherigo.PlayAudio(zmediaS_HinweisFehler)
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    Wherigo.PlayAudio(zmediaS_ein_auspacken)
    zitemZeichnungvonZille:MoveTo(Player)
    zitemZeichnungvonZille.Commands.auspacken.Enabled = false
    zitemZeichnungvonZille.Commands.einpacken.Enabled = true
    zitemZeichnungvonZille.Locked = false
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Das Inventar wurde aus dem Koffer ausgepackt.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94
    })
  end
end
function zitemZeichnungvonZille:OnDetails()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Zeichnung von Zille<BR>\n~<BR>\n-WfW-<BR>\nUm Schloss zu Du zu Redaktionsschluss Zeitung elften sechs lautet der zu geh\195\182rt Wenn dem gehe wo in \195\188bergeht. Du auf f\195\188r", {PocketPC = 1}),
    Media = zmediaZille_Zeichnung,
    Buttons = {
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    }
  })
end
function zitemZeichnungvonZille:Oneinpacken()
  Wherigo.PlayAudio(zmediaS_ein_auspacken)
  zitemZeichnungvonZille:MoveTo(zoneKoffer)
  zitemZeichnungvonZille.Commands.einpacken.Enabled = false
  zitemZeichnungvonZille.Commands.auspacken.Enabled = true
  zitemZeichnungvonZille.Locked = true
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = "Das Inventar wurde in den Koffer eingepackt.",
    Media = zmediaHilfe_Anzahl,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95
  })
end
function zinputHilfeKettenschlossAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 310 then
      var_Anzahl_Hilfen_Kettenschloss = "6 Punkte Kettenschloss"
      var_Anzahl_Hilfen_KettenschlossLsung = 6
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die Ersatzteile sind:<BR>\nDoppel-Glockenlager <BR>\nKurbelkeil<BR>\nLenkstange<BR>\nSattelst\195\188tze<BR>\nGlockenriemen <BR>\nKettenr\195\164der <BR>\nDreiradachse<BR>\nSattel<BR>\nDie Anzahl der gesuchten Buchstaben in den Ersatzteilen sind:<BR>\nR=7<BR>\nA=6<BR>\nD=4<BR>\nDer Code f\195\188r das Kettenschloss lautet: 764", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Code eingeben",
          WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB171
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Auf Seite 45 musst Du die letzten Worte jeder Zeile von oben nach unten lesen. In der App sind die Zeilen mit einem Strich \"-\" am Anfang und Ende gekennzeichnet.<BR>\nDie richtigen Buchstaben sind durch \"R-A-D\" vorgegeben. R,A,D gro\195\159 oder klein ist egal. Die Ersatzteile sind umrandet oder in der App gro\195\159geschrieben.<BR>\n~<BR>\nMit dem Code 310 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB172
      })
    end
  end
end
function zinputHilfeKofferschlossAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 422 then
      var_Anzahl_Hilfen_Kofferschoss = "6 Punkte Kofferschloss"
      var_Anzahl_Hilfen_KofferschossLsung = 6
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Code f\195\188r das Kofferschloss lautet: 746", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Code eingeben",
          WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB173
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nun schw\195\164rze mit Deinem Bleistift genau die Zellen Deiner Reiseunterlage \"Kofferschl\195\188ssel\" welche den Symbolen auf dem \"Kofferschl\195\188ssel Code\" entsprechen. Die nicht geschw\195\164rzten Zellen ergeben drei Zahlen.<BR>\n~<BR>\nMit dem Code 422 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB174
      })
    end
  end
end
function zinputHilfeNavigationAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 634 then
      var_Anzahl_Hilfen_Navigation = "6 Punkte Navigation"
      var_Anzahl_Hilfen_NavigationLsung = 6
      Wherigo.MessageBox({
        Text = "Die Koordinate lautet wie folgt: 97,197",
        Media = zmediaLsung,
        Buttons = {
          "zur Eingabe",
          WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB175
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Zeichne jede Himmelsrichtung in jeweils einem Karo auf Deinem Karopapier als Strich ein. z.B. N=Nord, also ein Strich senkrecht nach oben an der Karoseite oder NO=Nordost, also ein Strich von unten links nach oben rechts im Karo.<BR>\nAlle Himmelsrichtungen aneinander gezeichnet ergeben eine ausgeschriebene Zahl. <BR>\nDie drei farblich hinterlegten Himmelsrichtungen (in der App Farben in Klammern) markieren jeweils den Beginn einer neuen Zahl.<BR>\nDie farblichen Platzhalter in der Koordinate werden mit den entsprechenden Zahlen ersetzt.<BR>\n~<BR>\nMit dem Code 634 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB176
      })
    end
  end
end
function zinputHilfePelleAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 173 then
      var_Anzahl_Hilfen_Pelle = "6 Punkte Pelle"
      var_Anzahl_Hilfen_PelleLsung = 6
      Wherigo.MessageBox({
        Text = [[
Die Karten liegen nun wie folgt nebeneinander 2709<BR>
~<BR>
Der Code lautet: 2709]],
        Media = zmediaLsung,
        Buttons = {
          "Code eingeben"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB177
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nachdem Du die Karten getauscht und gedreht hast, wende nun die zweite Zauberregel an: \"...die vorletzte, erste, letzte und dann die vorvorletzte...) Sortiere die Karten dementsprechend. Die neue Reihenfolge ergibt den Code, den Du in die Truhe eingibst. <BR>\n~<BR>\nMit dem Code 173 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB178
      })
    end
  end
end
function zinputHilfeSchliefachAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 894 then
      var_Anzahl_Hilfen_Schliessfach = WWB_multiplatform_string("6 Punkte Schlie\195\159fach")
      var_Anzahl_Hilfen_SchliessfachLsung = 6
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Code f\195\188r das Schlie\195\159fach lautet: 361", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Code eingeben",
          WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB179
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Hinweis von der Ecke Spree und M\195\188ggelsee gibt die Reihenfolge der Zahlen f\195\188r das Schloss am Schlie\195\159fach vor: 1. Nummer der Ausgabe, 2. Redaktionsschluss, 3. Jahrgang <BR>\n~<BR>\nMit dem Code 894 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB180
      })
    end
  end
end
function zinputHilfeSchutzhtteAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 767 then
      var_Anzahl_Hilfen_Schutzhtte = WWB_multiplatform_string("8 Punkte Schutzh\195\188tte")
      var_Anzahl_Hilfen_SchutzhtteLsung = 8
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die Ordnungszahl der Elemente im Periodensystem sind:<BR>\nGe=32;He=2;I=53;Mn=25;I=53;S=16<BR>\nDeren Summe = 181<BR>\n~<BR>\nDie L\195\182sung lautet: 181", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Code eingeben"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB181
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die Summe der Ordnungszahlen der Elemente Ge+He+I+Mn+I+S ergibt den Code f\195\188r die Truhe.<BR>\n~<BR>\nMit dem Code 767 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB182
      })
    end
  end
end
function zinputHilfeTreibgutAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 788 then
      var_Anzahl_Hilfen_Treibgut = "6 Punkte Treibgut"
      var_Anzahl_Hilfen_TreibgutLsung = 6
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("In der \195\156berschrift sind die Buchstaben B R A U N kleiner als der Rest geschrieben. Alle braunen M\195\188nzen der Stadtkassen 1-3, in der Reiseunterlage eingetragen, ergeben die Zahlen: 273. Entsprechend dem Hinweis der Taucher \"Reihenfolge von rechts nach links\" ergibt sich der Code f\195\188r das Treibgut: 372", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Code eingeben",
          WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB183
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Schaue Dir die Reiseunterlage \"Stadtkasse\" genauer an!<BR>\nDer Hinweis zu den falschen M\195\188nzen ist hier versteckt.<BR>\n~<BR>\nDen Hinweis der Taucher: \"Reihenfolge von rechts nach links\" beachten.<BR>\n~<BR>\nMit dem Code 788 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB184
      })
    end
  end
end
function zinputHilfeTruheAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 101 then
      var_Anzahl_Hilfen_Truhe = "8 Punkte Truhe"
      var_Anzahl_Hilfen_TruheLsung = 8
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die L\195\182sung lautet:<BR>\n~<BR>\n15 G<BR>\n87 EHE<BR>\n25 W<BR>\n21 EI<BR>\n22 T<BR>\n55 E<BR>\n45 R<BR>\nu.s.w.<BR>\n~<BR>\nGehe_ weiter_ zur_ Schutzh\195\188tte_ nutze_ dort_ ein_ Licht_ jenseits_ von_ Violett", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {"weiter"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB185
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Ersetze die Zahlen von der Truhe mit den zugeh\195\182rigen Buchstaben die auf den Fotos zu finden sind. Es ergibt sich eine Wegbeschreibung.<BR>\n~<BR>\nMit dem Code auf dem Bild 12 kannst Du Dir die L\195\182sung anzeigen lassen.", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB164
      })
    end
  end
end
function zinputHilfeWfWAuflsung:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 545 then
      var_Anzahl_Hilfen_WfW = "8 Punkte WfW"
      var_Anzahl_Hilfen_WfWLsung = 8
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Text lautet:<BR>\nUm das alte Schloss vom Schlie\195\159fach zu \195\182ffnen musst Du zuerst ermitteln zu welcher Zeit Redaktionsschluss der Radfahrer Zeitung vom ersten elften neunzehn null sechs war, wie lautet die Nummer der Ausgabe und zu welchem Jahrgang geh\195\182rt die Zeitung. Wenn Du aus dem Spreetunnel kommst gehe zur Ecke wo der M\195\188ggelsee in die Spree \195\188bergeht. Dort findest Du einen Hinweis auf die Reihenfolge f\195\188r den Zahlencode.", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {"Ok"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB186
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Ein weiterer Hinweis auf S.41 lautet Wort f\195\188r Wort, schreibe die Worte in der vorgegebenen Reihenfolge Wort f\195\188r Wort auf (1. Staffelei 2. Zeitung 3. Plan), erst das jeweils erste Wort danach das jeweils zweite Wort u.s.w.<BR>\nDer fertige Text enth\195\164lt Anweisungen und Hinweise.<BR>\n~<BR>\nMit dem Code 545 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaLsungFrage,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB115
      })
    end
  end
end
function zinputHilfeZeitreiseAuflsung1_11_1906:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 245 then
      var_Anzahl_Hilfen_1_11_1906 = "6 Punkte Portal 1.11.1906"
      var_Anzahl_Hilfen_1_11_1906Lsung = "6"
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die L\195\182sung lautet: 413", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Eingabe Zeitreise-Daten"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB187
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nz.B. Drehe Dich um 180 Grad (vor Dir ist nun die Reise) und drehe die Karte rechts von Dir um (aus der 2 wird eine 3)<BR>\n~<BR>\nMit dem Code 245 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaHilfe,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB188
      })
    end
  end
end
function zinputHilfeZeitreiseAuflsung26_05_1927:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 469 then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die L\195\182sung lautet: 990", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Eingabe Zeitreise-Daten"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB189
      })
      var_Anzahl_Hilfen_26_05_1927 = "6 Punkte Portal 26.05.1927"
      var_Anzahl_Hilfen_26_05_1927Lsung = 6
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nMit dem Code 469 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaHilfe,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB190
      })
    end
  end
end
function zinputHilfeZeitreiseAuflsung2_11_1906:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 559 then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die L\195\182sung lautet: 709", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Eingabe Zeitreise-Daten"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB191
      })
      var_Anzahl_Hilfen_2_11_1906Lsung = 6
      var_Anzahl_Hilfen_2_11_1906 = "6 Punkte Portal 2.11.1906"
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nMit dem Code 559 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
        Media = zmediaHilfe,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB192
      })
    end
  end
end
function zinputHilfeZeitreiseAuflsungGegenwart:OnGetInput(input)
  var_Hilfe = tonumber(input)
  if var_Hilfe ~= nil then
    if var_Hilfe == 912 then
      var_Anzahl_Hilfen_Gegenwart = "6 Punkte Portal Gegenwart"
      var_Anzahl_Hilfen_GegenwartLsung = 6
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die L\195\182sung lautet: 197", {PocketPC = 1}),
        Media = zmediaLsung,
        Buttons = {
          "Eingabe Zeitreise-Daten"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB193
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nMit dem Code 912 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n<BR>\n", {PocketPC = 1}),
        Media = zmediaHilfe,
        Buttons = {
          "Ja",
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB194
      })
    end
  end
end
function zinputKettenschlossCode:OnGetInput(input)
  var_SchlossInformation = tonumber(input)
  if var_SchlossInformation ~= nil then
    if var_SchlossInformation == 764 then
      zcharacterTaucher.Commands.SchlossInformationen.Enabled = false
      ztaskAufgabe6lsen.Active = false
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("...wir machen uns auf den Weg.<BR>\nSicherheitshalber treffen wir uns ca. 550 Meter Richtung S\195\188den, neben dem Weg ist eine weitere Badebucht. Bis gleich.", {PocketPC = 1}),
        Media = zmediaTaucher,
        Buttons = {
          "Viel Erfolg"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB195
      })
    else
      Wherigo.MessageBox({
        Text = "Der Code ist falsch.",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB196
      })
    end
  end
end
function zinputKofferschlossCode:OnGetInput(input)
  var_Koffer_Code = tonumber(input)
  if var_Koffer_Code ~= nil then
    if var_Koffer_Code == 746 then
      zitemKoffer.Commands.Schlossffnen.Enabled = false
      zitemKoffer.Commands.Kofferffnen.Enabled = true
      zitemKarte.Visible = false
      ztaskKofferschlsselbenutzt.Complete = true
      zitemFotoboxvonZille.Commands.einpacken.Enabled = true
      zitemBrief.Commands.einpacken.Enabled = true
      ztaskAufgabe1lsen.Active = false
      cartMighlaTeil1v3:RequestSync()
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Das Schloss ist offen und der Koffer kann nun ge\195\182ffnet werden.<BR>\nPacke Gegenst\195\164nde in den Koffer damit Du nicht mehr als 5 Gegenst\195\164nde in Deiner Hand h\195\164ltst, so werden die Schutzm\195\164nner nicht auf Dich aufmerksam . <BR>\n~<BR>\nHilfez\195\164hler, Koffer und Speichern z\195\164hlen nicht mit zu den Gegenst\195\164nden des Inventars.", {PocketPC = 1}),
        Media = zmediaHilfe_Anzahl,
        Buttons = {"ok"}
      })
    else
      Wherigo.MessageBox({
        Text = "Der Code ist falsch",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB199
      })
    end
  end
end
function zinputNavigationKoordinate:OnGetInput(input)
  var_Koordinaten = input
  if var_Koordinaten ~= nil then
    if Wherigo.NoCaseEquals(var_Koordinaten, "97,197") then
      zcharacterTaucher.Commands.Koordinatenansagen.Enabled = false
      zitemEingabeNavigation.Visible = false
      ztaskAufgabe4lsen.Active = false
      cartMighlaTeil1v3:RequestSync()
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("97 Grad und 197 Meter, mit der Koordinate k\195\182nnen wir etwas anfangen. Wir tauchen sofort ab und suchen die versenkten Sachen.<BR>\nTreffen werden wir uns allerdings an einem anderen Ort. Hier haben wir schon zu viele Beobachter, die sich f\195\188r uns interessieren. Gehen Sie ca. 800 Meter auf dem Weg weiter Richtung S\195\188den, dort ist etwas abseits vom Weg eine ruhige Badebucht. Erwarten Sie uns dort.<BR>\nFast vergessen, diese Information von der Stadtkasse soll ich Ihnen mit folgendem Hinweis \"Reihenfolge von rechts nach links\" \195\188bergeben.<BR>\n<BR>\n", {PocketPC = 1}),
        Media = zmediaTaucher,
        Buttons = {
          "Danke, bis bald"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB201
      })
    else
      Wherigo.MessageBox({
        Text = "Das waren die falschen Koordinaten!",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB202
      })
    end
  end
end
function zinputParoleKapitn:OnGetInput(input)
  var_ParoleKapitn = input
  if var_ParoleKapitn ~= nil then
    if Wherigo.NoCaseEquals(var_ParoleKapitn, "v.Malzahn Hptm 1.Garde Reg.") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Die Parole passt! <BR>\nWillkommen Herr Beck. Kapit\195\164n Wolle mein Name, der alte Hauptmann auf Zeit hat Sie angek\195\188ndigt. Ich soll Ihnen in der Sache etwas weiterhelfen.<BR>\nKalle und ich haben Voigt im Oktober 1906 auf den M\195\188ggelsee rausgefahren. Dort hat er seine geheimnisvollen Dinge versenkt. Mighla machte seinem Namen alle Ehre und versteckte uns gl\195\188cklicherweise im dicken Nebel. <BR>\nVoigt hat die Koordinaten verschl\195\188sselt und mir in einem Brief \195\188bergeben. Diesen bewahre ich seitdem auf. <BR>\n", {PocketPC = 1}),
        Media = zmediaKapitn,
        Buttons = {"weiter"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB204
      })
    elseif var_ParoleAntworten == 2 then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Kapit\195\164n ist weg, am besten Du versuchst es sp\195\164ter noch einmal neu. Der Kapit\195\164n ist nicht nachtragend - eher vergesslich. Er wird sich bald wieder zeigen.", {PocketPC = 1}),
        Buttons = {"ok"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB207
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Noch nie geh\195\182rt, beim Klabautermann was soll das bedeuten?<BR>\nVersuche es noch mal Matrose.<BR>\nIst aber der letzte Versuch sag ich Dir, noch so ein Quatsch und ich bin weg.", {PocketPC = 1}),
        Media = zmediaKapitn,
        Buttons = {
          "neuer Versuch"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB208
      })
    end
  end
end
function zinputParoleTaucher:OnGetInput(input)
  var_ParoleTaucher = input
  if var_ParoleTaucher ~= nil then
    if Wherigo.NoCaseEquals(var_ParoleTaucher, "Seepferdchen") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Freischwimmer.<BR>\nDass passt schon mal, haben Sie auch die Koordinaten f\195\188r uns?", {PocketPC = 1}),
        Media = zmediaTaucher,
        Buttons = {"Ja", "Nein"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB209
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Das ist die falsche Parole, ich gebe Ihnen noch eine weitere M\195\182glichkeit richtig zu antworten.", {PocketPC = 1}),
        Buttons = {
          "Wiederholen"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB210
      })
    end
  end
end
function zinputPelleCodeZauberei:OnGetInput(input)
  var_Pelle = tonumber(input)
  if var_Pelle ~= nil then
    if var_Pelle == 2709 then
      Wherigo.PlayAudio(zmediaS_auf_zuschlieen)
      zitemTruhe.Commands.Briefnehmen.Enabled = true
      zitemTruhe.Commands.ZauberCodeeingeben.Enabled = false
      ztaskAufgabe9lsen.Active = false
      zitemPergament.Visible = false
      var_Inventar_Spieler = var_Inventar_Spieler - 1
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Als Du die richtigen vier Quadrate auf der Truhe dr\195\188ckst h\195\182rst Du das vertraute Klicken erneut. Doch dieses Mal \195\182ffnet sich die Truhe. <BR>\nUnter den geheimnisvollen W\195\188rfeln liegt auf dem Boden der Truhe ein Brief.", {PocketPC = 1}),
        Media = zmediaTruheoffen,
        Buttons = {"ok"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB211
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Das war die falsche L\195\182sung.", {PocketPC = 1}),
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB212
      })
    end
  end
end
function zinputSchliessfach_Code:OnGetInput(input)
  var_Schliessfach_Code = tonumber(input)
  if var_Schliessfach_Code ~= nil then
    if var_Schliessfach_Code == 361 then
      zitemHinweis.Visible = false
      var_Inventar_Spieler = var_Inventar_Spieler - 1
      zitemRadfahrerZeitungS1.Visible = false
      if zitemRadfahrerZeitungS1.Locked == true then
      else
        var_Inventar_Spieler = var_Inventar_Spieler - 1
      end
      zitemRadfahrerZeitungS41.Visible = false
      if zitemRadfahrerZeitungS41.Locked == true then
      else
        var_Inventar_Spieler = var_Inventar_Spieler - 1
      end
      zitemZeichnungvonZille.Visible = false
      if zitemZeichnungvonZille.Locked == true then
      else
        var_Inventar_Spieler = var_Inventar_Spieler - 1
      end
      zitemStadtplanMggelpark.Visible = false
      if zitemStadtplanMggelpark.Locked == true then
      else
        var_Inventar_Spieler = var_Inventar_Spieler - 1
      end
      zitemSchliessfach.Commands.Inhaltansehen.Enabled = true
      zitemSchliessfach.Commands.schliessen.Enabled = true
      zitemSchliessfach.Commands.Codeeingeben.Enabled = false
      ztaskAufgabe3lsen.Active = false
      cartMighlaTeil1v3:RequestSync()
      Wherigo.MessageBox({
        Text = "Das Schliessfach ist offen",
        Buttons = {"weiter"}
      })
    else
      Wherigo.MessageBox({
        Text = "Der Code ist falsch.",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB215
      })
    end
  end
end
function zinputSchutzhtteCode:OnGetInput(input)
  var_Schutzhtte = tonumber(input)
  if var_Schutzhtte ~= nil then
    if var_Schutzhtte == 181 then
      Wherigo.PlayAudio(zmediaS_auf_zuschlieen)
      zitemTruhe.Commands.Codeeingeben.Enabled = false
      ztaskAufgabe8lsen.Active = false
      zitemSchutzhtteInnen.Visible = false
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Als Du die richtigen vier Quadrate auf der Truhe dr\195\188ckst, erscheint ein Pergament in der linken Ecke.", {PocketPC = 1}),
        Media = zmediaTruhePergament,
        Buttons = {"weiter"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB217
      })
    else
      Wherigo.MessageBox({
        Text = "Der Code ist falsch.",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB218
      })
    end
  end
end
function zinputTreibgut_Code:OnGetInput(input)
  var_Treibgut_Code = tonumber(input)
  if var_Treibgut_Code ~= nil then
    if var_Treibgut_Code == 372 then
      zitemTreibgut.Commands.Codeeingeben.Enabled = false
      zitemTreibgut.Commands.ffnen.Enabled = true
      zitemTreibgut.Description = WWB_multiplatform_string("Der Code war richtig Du kannst das Treibgut jetzt \195\182ffnen")
      ztaskAufgabe5lsen.Active = false
      cartMighlaTeil1v3:RequestSync()
    else
      Wherigo.MessageBox({
        Text = "Der Code ist falsch!",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB221
      })
    end
  end
end
function zinputZeitreiseDaten1_11_1906:OnGetInput(input)
  var_ZeitreiseDaten1_11_1906 = tonumber(input)
  if var_ZeitreiseDaten1_11_1906 ~= nil then
    if var_ZeitreiseDaten1_11_1906 == 413 then
      Wherigo.Command("StopSound")
      Wherigo.PlayAudio(zmediaS_Pferdefuhrwerk)
      zitemBrief.Visible = false
      zitemEingabeZeitreise1111906.Visible = false
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Nebel ist verschwunden! Eine ganz neue Szene offenbart sich. Pferdefuhrwerke mit Bierf\195\164ssern beladen und eigenartig gekleidete Menschen bev\195\182lkern die Strasse.<BR>\n~<BR>\nEs kommt ein Mann auf mich zu und bleibt vor mir stehen, er sieht sehr nerv\195\182s aus.", {PocketPC = 1}),
        Media = zmediaFuhrwerk,
        Buttons = {"ansprechen"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB223
      })
    else
      Wherigo.MessageBox({
        Text = "Dies sind falsche Zeitreise-Daten!",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB224
      })
    end
  end
end
function zinputZeitreiseDaten26_05_1927:OnGetInput(input)
  var_ZeitreiseDaten26_05_1927 = tonumber(input)
  if var_ZeitreiseDaten26_05_1927 ~= nil then
    if var_ZeitreiseDaten26_05_1927 == 990 then
      zonePortal1927_.Active = false
      zoneSpreetunnelEingang.Active = true
      zitemEingabeZeitreise1927.Visible = false
      Wherigo.MessageBox({
        Text = "Der Nebel ist verschwunden! Du bist im Jahr 1927 angekommen. Im Mai wurde der Spreetunnel nach einem Jahr Bauzeit fertiggestellt. Nutze den Spreetunnel um auf die andere Seite der Spree zu gelangen.",
        Media = zmediaSpreetunnel_Zeichnung,
        Buttons = {"verstanden"}
      })
    else
      Wherigo.MessageBox({
        Text = "Dies sind falsche Zeitreise-Daten!",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB227
      })
    end
  end
end
function zinputZeitreiseDaten2_11_1906:OnGetInput(input)
  var_ZeitreiseDaten2_11_1906 = tonumber(input)
  if var_ZeitreiseDaten2_11_1906 ~= nil then
    if var_ZeitreiseDaten2_11_1906 == 709 then
      Wherigo.Command("StopSound")
      zone08_Spreetunnel_Ausgang_.Active = false
      zitemEingabeZeitreise2111906.Visible = false
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der Nebel ist verschwunden! <BR>\nDie Ecke aus dem R\195\164tsel \"WfW\" ist nun erreichbar, finde den Hinweis.", {PocketPC = 1}),
        Buttons = {"verstanden"},
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB229
      })
    else
      Wherigo.MessageBox({
        Text = "Dies sind falsche Zeitreise-Daten!",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB230
      })
    end
  end
end
function zinputZeitreiseDatenGegenwart:OnGetInput(input)
  var_ZeitreiseDatenGegenwart = tonumber(input)
  if var_ZeitreiseDatenGegenwart ~= nil then
    if var_ZeitreiseDatenGegenwart == 197 then
      zitemMighla.Visible = true
      Wherigo.PlayAudio(zmediaS_Hinweiston)
      zitemEingabeZeitreiseGegenwart.Visible = false
      zitemHilfeInventarzhler.Commands.Inventaranzeigen.Enabled = false
      zitemFotoboxvonZille.Visible = false
      zitemKoffer.Visible = false
      zitemBrief.Visible = false
      zitemBrief2vomVoigt.Visible = false
      zitemBrief3vomVoigt.Visible = false
      zitemBrief4vomVoigt.Visible = false
      zitemBriefvomVoigt.Visible = false
      zitemSchwarzlicht.Visible = false
      zitemGeld.Visible = false
      zitemHinweis.Visible = false
      zitemNavigationausBrief3.Visible = false
      zitemKarte.Visible = false
      zitemKofferschlsseluStadtkasse.Visible = false
      zitemNotiz.Visible = false
      zitemPergament.Visible = false
      zitemPortalAktivierungskarten.Visible = false
      zitemPortalZeitreisemaschiene.Visible = false
      zitemRadfahrerZeitungS1.Visible = false
      zitemRadfahrerZeitungS37.Visible = false
      zitemRadfahrerZeitungS41.Visible = false
      zitemRadfahrerZeitungS45.Visible = false
      zitemStadtkasse1von3.Visible = false
      zitemStadtplanMggelpark.Visible = false
      zitemStadtplanMggelwald.Visible = false
      zitemTreibgut.Visible = false
      zitemTruhe.Visible = false
      zitemZeichnungvonZille.Visible = false
      cartMighlaTeil1v3:RequestSync()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    else
      Wherigo.MessageBox({
        Text = "Dies sind falsche Zeitreise-Daten!",
        Media = zmediaFalscheEingabe,
        Buttons = {
          "neuer Versuch",
          "1.Hilfe"
        },
        Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB232
      })
    end
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB1(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das freut mich.<BR>\nHiermit nehmen Sie an dieser Verlosung teil und bekommen im Falle eines Gewinnes eine Benachrichtigung von uns.<BR>\nViel Gl\195\188ck!<BR>\n", {PocketPC = 1}),
      Media = zmediaVertreter,
      Buttons = {
        "Vielen Dank!"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB2
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Dann w\195\188nsche ich Ihnen einen sch\195\182nen Tag.<BR>\nAuf Wiedersehen!<BR>\n", {PocketPC = 1}),
      Media = zmediaVertreter,
      Buttons = {
        "Auf wiedersehen!"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB3
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB2(action)
  ztimerBrief_Ankunft:Start()
  ztaskAufdenBriefwarten.Active = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB3(action)
  Wherigo.Command("SaveClose")
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB4(action)
  ztaskImBiergartenaufKontaktwarten.Active = false
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB5(action)
  var_TimerTeppich = var_TimerTeppich + 1000
  var_TimerTeppichInfoEnde = true
  ztaskTreibgutabholen.Visible = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB6(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB7(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB8(action)
  var_Anzahl_Hilfen_2_11_1906 = "0 Punkte Portal 2.11.1906"
  zitemEingabeZeitreise2111906:MoveTo(zone08_Spreetunnel_Ausgang_)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise 2.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nTausche die Karten von Zeit und Reise.<BR>\nDrehe die Karten links und rechts von Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 90 Grad nach rechts und tausche die Karte hinter Dir mit der vor Dir.<BR>\nDrehe die Karte Reise um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB9
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB9(action)
  Wherigo.PlayAudio(zmediaS_Antworteingabe_Portal)
  Wherigo.GetInput(zinputZeitreiseDaten2_11_1906)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB10(action)
  var_Anzahl_Hilfen_1_11_1906 = "0 Punkte Portal 1.11.1906"
  zitemEingabeZeitreise1111906:MoveTo(zoneStartzone_)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise 1.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 180 Grad und drehe die Karte rechts von Dir um.<BR>\nDrehe Dich um 90 Grad linksherum und tausche die Karten rechts und links von Dir.<BR>\nTausche die Karten von Zeit und von Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der Bildung.<BR>\nDrehe Dich um 90 Grad nach rechts.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine ", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB11
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB11(action)
  Wherigo.PlayAudio(zmediaS_Antworteingabe_Portal)
  Wherigo.GetInput(zinputZeitreiseDaten1_11_1906)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB12(action)
  Wherigo.PlayAudio(zmediaS_Taucherblasen)
  ztimerTaucherBadebucht2a:Start()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB13(action)
  zcharacterTaucher.Visible = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB14(action)
  zone02a_Eingang_MP1.Active = false
  zone02b_Eingang_MP2.Active = false
  zone02c_Eingang_MP3.Active = false
  zitemStadtplanMggelpark.Commands.Briefnehmen.Enabled = true
  var_Anzahl_Hilfen_Kofferschoss = "0 Punkte Kofferschloss"
  Wherigo.MessageBox({
    Text = "Ist Ihnen dieser Herr auf Ihrem Weg aufgefallen?",
    Media = zmediaVoigt_Akte,
    Buttons = {
      WWB_multiplatform_string("\195\188berlegen", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB15
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB15(action)
  zoneBedrfnisanstallt.Active = true
  ztaskAufgabe1lsen.Active = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.Dialog({
    {
      Text = "Oh nein! Das ist doch der Voigt von vorhin. Was mach ich nun?",
      Media = zmediaGedankenblase
    },
    {
      Text = "Was hat er angestellt?",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Der Hochstapler hat die Stadtkasse von C\195\182penick und ein kaiserliches Dokument geklaut. Nach 10 Tagen haben wir den Hochstapler mit der Stadtkasse festnehmen k\195\182nnen. Leider ist er heute auf dem Weg zum Friedrichshagener Gericht bei einem Unfall mit einem Radfahrer aus der gr\195\188nen Minna geflohen. Nun ist er hier in der Gegend auf der Flucht. <BR>\nDarf ich Ihren Namen erfahren?"),
      Media = zmediaSchutzmann
    },
    {
      Text = [[
Mein Name ist Beck. <BR>
Was ist mit dem Dokument?]],
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Es ist weiterhin verschwunden. Kaiser Wilhelm II. ist deshalb sehr ungehalten und fordert dieses private Dokument umgehend in seinen Besitz zur\195\188ck. Daher ist die Ergreifung von Voigt so wichtig."),
      Media = zmediaSchutzmann
    },
    {
      Text = WWB_multiplatform_string("Da ging es dem Voigt gar nicht um die Kasse, sondern um das Dokument vom Kaiser. Was soll ich nun machen? Die Staatsmacht unterst\195\188tzen? Oder den Hauptmann von C\195\182penick?"),
      Media = zmediaGedankenblase
    },
    {
      Text = WWB_multiplatform_string("K\195\182nnen Sie uns in der Angelegenheit helfen Herr Beck?"),
      Media = zmediaSchutzmann
    },
    {
      Text = "Nein, den Gauner habe ich nicht gesehen Herr Schutzmann.",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Nun, dann halten Sie die Augen auf. Falls Sie ihn sehen, sprechen Sie ihn auf keinen Fall an, sondern melden Sie sich umgehend bei einem Schutzmann. Einen sch\195\182nen Tag noch Herr Beck."),
      Media = zmediaSchutzmann
    },
    {
      Text = WWB_multiplatform_string("Danke, ich w\195\188nsche Ihnen einen erfolgreichen Tag. Ich hoffe der Hochstapler landet wieder hinter Gittern."),
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Danke, davon k\195\182nnen Sie ausgehen. Ach, Herr Beck!"),
      Media = zmediaSchutzmann
    },
    {Text = "Ja?", Media = zmediaSpieler},
    {
      Text = WWB_multiplatform_string("Ihnen f\195\164llt da gleich ein Brief aus Ihrem Stadtplan."),
      Media = zmediaSchutzmann
    },
    {
      Text = "Oh, vielen Dank!",
      Media = zmediaSpieler
    },
    {
      Text = "Der Schutzmann geht Richtung Brauerei weiter, der Weg zum markierten Ort auf dem Stadtplan ist nun frei."
    },
    {
      Text = "Ein Brief im Stadtplan? Vielleicht hilft mir der Brief die Sachen vom Voigt los zu werden. <BR>\n",
      Media = zmediaGedankenblase
    }
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB16(action)
  ztimerPortal_1927_unsichtbar:Start()
  ztaskMighlafinden.Active = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB17(action)
  ztimerPortal1906anzeigenMggelwald:Start()
  ztaskAufMighlawarten.Visible = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB18(action)
  Wherigo.PlayAudio(zmediaS_Taucherblasen)
  ztimerTaucherBadebucht1:Start()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB19(action)
  ztimerTaucherBadebucht2:Start()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB20(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Vor dem Geb\195\164ude sitzt ein Maler mit seiner Staffelei und schaut immer wieder verstohlen zu mir.", {PocketPC = 1}),
    Media = zmediaZillebeiderArbeit,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB21
  })
  zcharacterMaler.Visible = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB21(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Jetzt winkt er mir zu.<BR>\nIch werde ihn mal h\195\182flich ansprechen.", {PocketPC = 1}),
    Media = zmediaGedankenblase,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB22
  })
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB22(action)
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB23(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("...ja gerne. Aber bitte einen Tisch f\195\188r zwei Personen in einer Ecke mit mehr Ruhe.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB24
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB24(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Da haben Sie Gl\195\188ck, es ist gerade ein Tisch dort hinten rechts frei geworden.<BR>\nSetzen Sie sich schon mal, ich komme gleich bei Ihnen vorbei.<BR>\nIhre Nelke k\195\182nnen Sie ruhig zu den anderen Blumen auf den Tisch stellen.", {PocketPC = 1}),
    Media = zmediaKellnerin,
    Buttons = {"Bis gleich"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB25
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB25(action)
  zcharacterKellnerin.Visible = false
  Wherigo.Command("StopSound")
  Wherigo.MessageBox({
    Text = "Ok, hier ist es wirklich ruhiger.",
    Media = zmediaGedankenblase,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB26
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB26(action)
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Endlich kann ich mich mal setzen. Die Nelke schnell noch zu den anderen Blumen gesteckt, so dass sie von weitem zu erkennen ist und nun hei\195\159t es warten und entspannen. ", {PocketPC = 1}),
    Media = zmediaGedankenblase,
    Buttons = {"entspannen"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB27
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB27(action)
  zitemNelke.Visible = false
  var_Inventar_Spieler = var_Inventar_Spieler - 1
  ztimerNiesen:Start()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB28(action)
  ztaskGegenstndemitnehmen.Visible = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB29(action)
  zcharacterKellnerin.Visible = true
  zcharacterKellnerin.Commands.ansprechen.Enabled = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB30(action)
  zitemFoto02ausFotobox.Description = "Bitte notiere 43 SCH &nbsp;und 35 U"
  var_Anzahl_Hilfen_26_05_1927 = "0 Punkte Portal 26.05.1927"
  zitemFoto02ausFotobox.Commands.verstanden.Enabled = false
  zitemEingabeZeitreise1927:MoveTo(zonePortal1927_)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise 26.5.1927<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. <BR>\nStelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte hinter Dir um.<BR>\nTausche die Karten von Zeit und Ort.<BR>\nDrehe Dich um 90 Grad linksherum und drehe die Karten links von Dir und vor Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 180 Grad.<BR>\nDrehe Dich um 90 Grad nach links.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB31
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB31(action)
  Wherigo.PlayAudio(zmediaS_Antworteingabe_Portal)
  Wherigo.GetInput(zinputZeitreiseDaten26_05_1927)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB32(action)
  var_Anzahl_Hilfen_Gegenwart = "0 Punkte Portal Gegenwart"
  zitemEingabeZeitreiseGegenwart:MoveTo(zonePortalGegenwart_)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Aktivierung der Zeitreise in die Gegenwart<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. Stelle Dich auf Deinen Platz in die Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte rechts von Dir um.<BR>\nTausche die Karten von Reise und Bildung. <BR>\nDrehe Dich um 180 Grad und drehe die Karte hinter Dir um.<BR>\nDrehe Dich um 90 Grad rechtsherum.<BR>\nTausche die Karten Zeit und Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der von der Zeit.<BR>\nDrehe die Karten vor Dir und links von Dir um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
    Buttons = {
      "Eingabe Zeitreise-Daten"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB33
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB33(action)
  Wherigo.PlayAudio(zmediaS_Antworteingabe_Portal)
  Wherigo.GetInput(zinputZeitreiseDatenGegenwart)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB35(action)
  var_Anzahl_Hilfen_Schutzhtte = WWB_multiplatform_string("0 Punkte Schutzh\195\188tte")
  zitemSchutzhtteInnen.Visible = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB36(action)
  Wherigo.MessageBox({
    Text = "Der Zeitungsjunge winkt mich zu sich....",
    Buttons = {"ansprechen"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB37
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB37(action)
  zcharacterZeitungsjunge.Visible = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB38(action)
  if action == "Button1" then
    ztaskVorbereitung.Visible = false
    ztimerPortal_1906_anzeigen:Start()
  else
    Wherigo.Command("SaveClose")
    zoneStartzone_.Active = false
    zoneStartzone.Active = true
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB39(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("... Entschuldigung, ich war in Gedanken. Ich komme sofort zur\195\188ck und bezahle nat\195\188rlich die Nelke.", {PocketPC = 1}),
    Media = zmediaSpieler,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB40
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB40(action)
  zcharacterBlumenfrau.Commands.Schuldbegleichen.Enabled = false
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB41(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB42(action)
  ztaskEineNelkekaufen.Complete = true
  zitemGeld.Commands.Blumenfraubezahlen.Enabled = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB43(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Na soweit kommt es noch,<BR>\nauch mit ener Nelke l\195\164sst sich das Herz erweichen.<BR>\nGeben Sie sich mal\194\180n bisschen M\195\188he....", {PocketPC = 1}),
      Media = zmediaBlumenfrau,
      Buttons = {
        WWB_multiplatform_string("Tsch\195\188ss", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB44
    })
  else
    zcharacterKellnerin.Visible = false
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB44(action)
  zcharacterBlumenfrau.Visible = false
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB45(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("... und weil Sie gleich zur\195\188ck gekommen sind gibts noch ein kleines Pr\195\164sent von mir in die Fotobox.<BR>\nViel Erfolg mit der Nelke!", {PocketPC = 1}),
    Media = zmediaBlumenfrau,
    Buttons = {
      WWB_multiplatform_string("Tsch\195\188ss", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB46
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB46(action)
  zitemFoto05vonBlumenfrau:MoveTo(zoneFotobox)
  zitemFoto05vonBlumenfrau.Commands.indieFotoboxpacken.Enabled = false
  zcharacterBlumenfrau.Commands.nochmalsansprechen.Enabled = true
  zcharacterBlumenfrau.Commands.Schuldbegleichen.Enabled = false
  var_Blumenfrau_nicht_bezahlt = "ja"
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB47(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB48(action)
  zoneSeglerheim.Active = false
  zoneSeglerheim_.Active = false
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB49(action)
  zcharacterKellnerin.Commands.ansprechen.Enabled = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das kann ja mal passieren. <BR>\nDas waren 2 Molle f\195\188r je 24 Pfennige und 2 doppelte Korn f\195\188r je 25 Pfennige. Das macht 98 Pfennige wenns recht ist. ", {PocketPC = 1}),
    Media = zmediaKellnerin,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB50
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB50(action)
  zitemGeld.Commands.Kellnerinbezahlen.Enabled = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB51(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB53(action)
  zcharacterKellnerin.Commands.JavielenDank.Enabled = false
  zcharacterKellnerin.Commands.Kellnerinrufen.Enabled = true
  zcharacterKellnerin.Description = ""
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Prost\226\128\166 <BR>\nNun ist die Zunge viel geschmeidiger, wenn Sie wissen was ich meine. <BR>\nAlso nun zu Ihrer Frage. <BR>\nSagen kann ich nur so viel:<BR>\nDer Wilhelm hat sich viel M\195\188he gegeben, dass die da oben nicht an das Dokument kommen, nun ist er ja selber unp\195\164sslich, hihi. <BR>\nDamals haben wir im M\195\188ggelsee bei Nacht und Nebel etwas versenkt. Keine Ahnung wo das war. <BR>\nDa Sie nun hier sind wird es wohl Zeit diese Sache wieder vom Grund zu bergen. Weiterhelfen sollte der Brief vom Voigt. <BR>\nNehmen Sie ihn an sich.", {PocketPC = 1}),
    Media = zmediaSeebr,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB54(action)
  zcharacterSeebr.Visible = true
  zcharacterSeebr.Commands.Briefnehmen.Enabled = true
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB55(action)
  zitemGeld.Commands.Kellnerinbezahlen.Enabled = true
  zcharacterKellnerin.Commands.Kellnerinrufen.Enabled = false
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Ich m\195\182chte gerne bezahlen. "),
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Gerne, das waren 2 Molle f\195\188r je 24 Pfennige und 2 doppelte Korn f\195\188r je 25 Pfennige. Das macht 98 Pfennige wenns recht ist. "),
      Media = zmediaKellnerin
    }
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB56(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB57(action)
  zcharacterMaler.Visible = false
  zoneBedrfnisanstallt_.Active = false
  ztaskDasSpreeuferwechseln.Active = true
  zone04_Spreetunnel_Stop.Active = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB58(action)
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Guten Tag, Voigt mein Name. Ich bin sehr in Eile, kennen Sie den Weg zum M\195\188ggelpark?"),
      Media = zmediaVoigt
    },
    {
      Text = "Guten Tag, Beck mein Name. Leider nein.",
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("Dann muss ich wohl doch auf meinen Stadtplan schauen. K\195\182nnten Sie so lange meinen Koffer halten?"),
      Media = zmediaVoigt
    },
    {
      Text = WWB_multiplatform_string("Ja, nat\195\188rlich."),
      Media = zmediaSpieler
    }
  })
  zcharacterMann.Commands.Koffernehmen.Enabled = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB59(action)
  Wherigo.PlayAudio(zmediaS_Trillerpfeifelang)
  zcharacterMann.Visible = false
  zitemStadtplanMggelpark.Visible = true
  zitemFoto01vonVoigt.Visible = true
  zitemFoto01vonVoigt.Commands.aufheben.Enabled = true
  ztaskDemHinweisfolgen.Active = true
  ztaskGegenstndeaufheben.Active = true
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Als pl\195\182tzlich eine Polizeipfeife ert\195\182nt, zuckt Herr Voigt zusammen, l\195\164sst seinen Stadtplan fallen und fl\195\188chtet Richtung B\195\182lschestra\195\159e.")
    },
    {
      Text = WWB_multiplatform_string("Hallo, Herr Voigt, Ihr Koffer und Ihr Stadtplan\226\128\166"),
      Media = zmediaSpieler
    },
    {
      Text = WWB_multiplatform_string("W\195\164hrend sich Voigt schnell entfernt, ruft er \195\188ber die Schulter zur\195\188ck: ... schauen Sie auf den Stadtplan und gehen Sie zum markierten Ort. Seien Sie vorsichtig, wir sind uns nie begegnet! Viel Erfolg Beck!"),
      Media = zmediaVoigt
    },
    {
      Text = "... und schon ist er weg."
    },
    {
      Text = WWB_multiplatform_string("Der kann doch nicht einfach abhauen und mir seinen Koffer \195\188berlassen. Zudem liegt auf der Stra\195\159e noch sein Stadtplan und daneben ein Foto. <BR>\nDas Beste wird sein ich mache was Voigt gesagt hat und schaue auf den Plan wo der markierte Ort im M\195\188ggelpark ist. Dort werde ich die Sachen vielleicht los."),
      Media = zmediaGedankenblase
    }
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB60(action)
  if var_TimerTeppichInfoEnde == true then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("...Martha ist im Geb\195\164ude. Sie ist noch ganz mitgenommen von dem Polizeieinsatz. Ich sage ihr Bescheid, dass Sie da sind.", {PocketPC = 1}),
      Media = zmediaRettungsschwimmer,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB61
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("... Ernst mein Name, Martha ist im Geb\195\164ude. Ich sage ihr Bescheid, dass Sie da sind.", {PocketPC = 1}),
      Media = zmediaRettungsschwimmer,
      Buttons = {"Danke"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB62
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB61(action)
  zcharacterRettungsschwimmer.Visible = false
  zcharacterRettungsschwimmerinMartha.Visible = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB62(action)
  zcharacterRettungsschwimmer.Visible = false
  zcharacterRettungsschwimmerinMartha.Visible = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB63(action)
  if var_TimerTeppichInfoEnde == true then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Leider sind Sie zu sp\195\164t gekommen. Die Polizei hat das Treibgut mitgenommen. Irgendwer hat uns verraten. <BR>\nIch habe dem Kapit\195\164n Meldung gemacht, er hat umgehend Kalle beauftragt das Treibgut vor dem Revier abzufangen, um es Ihnen dann irgendwo zwischen Teppich und L\195\164ufer zu \195\188bergeben.<BR>\nIch hoffe die \195\156bergabe klappt, seien Sie vorsichtig.<BR>\nAch ja, das Foto soll ich Ihnen geben.<BR>\nTsch\195\188ss! ", {PocketPC = 1}),
      Media = zmediaRettungsschwimmerin,
      Buttons = {
        WWB_multiplatform_string("Danke und Tsch\195\188\195\159", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB64
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der K\195\164pt'n hat sie angek\195\188ndigt, gut das Sie gleich hierhergekommen sind. Die Beamten sind auf dem Weg hierher, etwas sp\195\164ter und die Sache w\195\164re nicht mehr in meiner Hand gewesen. Hier bitte, packen Sie das Treibgut in den Koffer und stecken sie das Foto in die Fotobox. Sie m\195\188ssen schnellstens weg von hier!<BR>\nTsch\195\188ss!<BR>\n<BR>\n", {PocketPC = 1}),
      Media = zmediaRettungsschwimmerin,
      Buttons = {
        WWB_multiplatform_string("Danke und Tsch\195\188ss", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB66
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB64(action)
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = "Das kannst Du nicht mehr in die Hand nehmen, packe etwas in den Koffer.",
      Media = zmediaHilfe_Anzahl,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65
    })
  else
    zcharacterRettungsschwimmerinMartha.Visible = false
    zoneTeppich_.Active = false
    zitemFoto10vonMarta:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    ztaskTreibgutabholen.Description = WWB_multiplatform_string("Finde Kalle und \195\188bernehme das Treibgut.")
    ztaskTreibgutabholen.Name = WWB_multiplatform_string("Treibgut \195\188bernehmen")
    ztaskTreibgutabholen.Visible = true
    cartMighlaTeil1v3:RequestSync()
    ztimerbergabeKalleunsichtbar:Start()
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB65(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB66(action)
  if var_zuerstamTeppich == 1 then
    var_Anzahl_Hilfen_Treibgut = "0 Punkte Treibgut"
    zcharacterRettungsschwimmerinMartha.Visible = false
    zoneTeppich_.Active = false
    zitemTreibgut:MoveTo(zoneKoffer)
    ztaskTreibgutabholen.Complete = true
    ztaskTreibgutabholen.Visible = false
    zitemFoto10vonMarta:MoveTo(zoneFotobox)
    zitemFoto10vonMarta.Commands.indieFotoboxpacken.Enabled = false
    cartMighlaTeil1v3:RequestSync()
  else
    var_Anzahl_Hilfen_Treibgut = "0 Punkte Treibgut"
    zcharacterTaucher.Commands.Binwiederzurck.Enabled = true
    zcharacterTaucher.Commands.ansprechen.Enabled = false
    zcharacterRettungsschwimmerinMartha.Visible = false
    zoneTeppich_.Active = false
    zoneLufer.Active = true
    zitemTreibgut:MoveTo(zoneKoffer)
    zitemTreibgut.Visible = true
    ztaskTreibgutabholen.Complete = true
    zitemFoto10vonMarta:MoveTo(zoneFotobox)
    zitemFoto10vonMarta.Commands.indieFotoboxpacken.Enabled = false
    cartMighlaTeil1v3:RequestSync()
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB67(action)
  zitemFoto06vonKalle:MoveTo(zoneFotobox)
  zcharacterSeebr.Commands.Briefnehmen.Enabled = false
  zcharacterSeebr.Visible = false
  zcharacterSeebr.Name = "Kalle"
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB68(action)
  if var_Inventar_Spieler >= 5 then
    zcharacterSeebr.Commands.HalloKalle.Enabled = false
    zcharacterSeebr.Commands.Treibgutnehmen.Enabled = true
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment bitte, meine H\195\164nde sind voll. Ich muss erst etwas in den Koffer packen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Ok, ich warte."
      }
    })
  else
    zitemTreibgut:MoveTo(Player)
    zitemTreibgut.Commands.auspacken.Enabled = false
    zitemTreibgut.Commands.ffnen.Enabled = true
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    ztaskTreibgutabholen.Complete = true
    zitemTreibgut.Visible = true
    zonebergabeKalle_.Active = false
    zcharacterSeebr.Visible = false
    zcharacterTaucher.Commands.Binwiederzurck.Enabled = true
    zcharacterTaucher.Commands.ansprechen.Enabled = false
    zoneLufer.Active = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Gegenstand ist nun in Deinem Inventar.",
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB70(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB71(action)
  zcharacterTaucher.Commands.Ahoi.Enabled = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("...ja, in der Tat. Es war nicht einfach Schloss und Kette von der Truhe zu l\195\182sen, aber bitte, hier ist sie. <BR>\n", {PocketPC = 1}),
    Media = zmediaTaucher,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB72
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB72(action)
  zcharacterTaucher.Commands.Truhenehmen.Enabled = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB74(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Guten Tag, ja sch\195\182n ist es hier. So ein Zufall, ich habe hier meinen Freischwimmer erschwommen.<BR>\nGuten Tag Beck, Sie sollten doch zum Teppich das Treibgut abholen.", {PocketPC = 1}),
    Media = zmediaTaucher,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB75
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB75(action)
  Wherigo.MessageBox({
    Text = "Ich dachte das hat Zeit.",
    Media = zmediaSpieler,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB76
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB76(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Keinesfalls, die Polizei ist unterwegs zu den Rettungsschwimmern am Teppich. Die haben wohl Wind von dem ungew\195\182hnlichen Fund bekommen. <BR>\nSie m\195\188ssen sich beeilen, mein Informant hat vor 5 Minuten gesagt, dass die Polizei in 10 Minuten vor Ort sein wird.", {PocketPC = 1}),
    Media = zmediaTaucher,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB77
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB77(action)
  Wherigo.MessageBox({
    Text = "Oh, dann muss ich mich beeilen.",
    Media = zmediaSpieler,
    Buttons = {
      WWB_multiplatform_string("Bis sp\195\164ter", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB78
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB78(action)
  ztimerPolizeiTeppich:Start()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB79(action)
  ztaskTreffedieTaucher.Complete = true
  Wherigo.MessageBox({
    Text = "Guten Tag, dann kennen sie ja sicher die Parole",
    Media = zmediaTaucher,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB80
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB80(action)
  Wherigo.MessageBox({
    Text = "Na klar kenne ich die Parole.",
    Media = zmediaSpieler,
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB81
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB81(action)
  Wherigo.GetInput(zinputParoleTaucher)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB82(action)
  if action == "Button1" then
    zitemEingabeNavigation:MoveTo(zoneLufer_)
    Wherigo.GetInput(zinputNavigationKoordinate)
  else
    Wherigo.MessageBox({
      Text = "Oh, die Koordinaten. Da war doch was in dem 2. Brief vom Voigt.",
      Media = zmediaGedankenblase,
      Buttons = {
        "Moment bitte"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB83
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB83(action)
  Wherigo.MessageBox({
    Text = "Dann melden Sie sich und geben uns die Koordinaten.",
    Media = zmediaTaucher,
    Buttons = {"Ja"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB84
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB84(action)
  zcharacterTaucher.Commands.ansprechen.Enabled = false
  zcharacterTaucher.Commands.Koordinatenansagen.Enabled = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB85(action)
  Wherigo.GetInput(zinputKettenschlossCode)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB86(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("... Unser Auftrag ist damit erf\195\188llt, wir tauchen gleich wieder ab, um nicht weiter aufzufallen. Nun liegt es an Ihnen Beck die Mission zu beenden.<BR>\nAhoi und viel Erfolg!", {PocketPC = 1}),
    Media = zmediaTaucher,
    Buttons = {"Ahoi"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB87
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB87(action)
  zcharacterTaucher.Visible = false
  zoneBadebucht2_.Active = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB88(action)
  var_Anzahl_Hilfen_Kettenschloss = "0 Punkte Kettenschloss"
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment bitte, meine H\195\164nde sind voll. Ich muss erst etwas in den Koffer packen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Ok, ich warte."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB69
    })
    zcharacterTaucher.Commands.Zeitungnehmen.Enabled = true
  else
    zitemRadfahrerZeitungS37:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    ztaskAufgabe6lsen.Active = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Vom Schloss wusste ich nichts! Aber danke f\195\188r den ersten Versuch. Machen Sie erstmal eine Pause und ich schaue ob ich mit der Zeitungsseite etwas anfangen kann.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {"Bis gleich"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB89
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB89(action)
  zcharacterTaucher.Commands.WarenSieerfolgreich.Enabled = false
  zcharacterTaucher.Commands.SchlossInformationen.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB90(action)
  Wherigo.MessageBox({
    Text = "",
    Media = zmediaEndeT1,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB91
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB91(action)
  Wherigo.PlayAudio(zmediaS_Beifall)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Dies ist das Ende von Mighla Teil 1<BR>\n~<BR>\nIch hoffe der Beginn Deiner Reise in die Vergangenheit hat Dir gefallen. <BR>\nBevor Du Mighla Teil 2 beginnen kannst, musst Du das R\195\164tsel WfW aus aus diesem Teil noch l\195\182sen.<BR>\nAchtung!<BR>\nDer Inhalt aus dem Koffer und der Fotobox ist nur hier in der Spielzone Sichtbar. Falls Du das R\195\164tsel zu Hause l\195\182sen m\195\182chtest kontrolliere ob die 4 notwendigen Gegenst\195\164nde und das Foto von Voigt in Deinem Inventar sind.<BR>\n", {PocketPC = 1}),
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB92
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB92(action)
  Wherigo.Command("StopSound")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im 2. Teil der Reise bleiben Dir alle Gegenst\195\164nde erhalten. Diese findest Du dann im verschlossenen Koffer und in der Fotobox. Denke an den Kofferschl\195\188ssel!<BR>\n~<BR>\nDu kannst nun mit dem UnlockCode, der sich im Inventar befindet, diesen Teil bei Wherigo.com loggen. <BR>\nErst am Ende der Reise wartet der Cache auf Dich.<BR>\n~<BR>\nEs Gr\195\188\195\159t Voigt und McWood!<BR>\nBis hoffentlich bald!", {PocketPC = 1}),
    Buttons = {"ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB93
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB93(action)
  zitemUnlockCodeTeil1:MoveTo(Player)
  zitemEndeTeil1:MoveTo(Player)
  zitemEndeTeil1.Visible = true
  zitemHilfeInventarzhler.Visible = false
  zitemHilfePunkteTeil1:MoveTo(Player)
  zitemHilfePunkteTeil1.Visible = true
  ztaskDasSpreeuferwechseln.Visible = false
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB94(action)
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB95(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB96(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Meine kurze Zeit in Freiheit nach dem Coup habe ich dem Studium der Unterlage gewidmet. Deren Inhalt hat mich dann dazu bewegt, dieses Dokument an einem sicheren Ort zu verstecken. Verschl\195\188sselte Hinweise, unzug\195\164ngliche Orte und verschiedene Personen meines Vertrauens sollen daf\195\188r sorgen, dass der Kaiser und seine Schergen nicht an das Dokument kommen.", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      "weiterlesen"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB97
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB97(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Sie, Beck, sollen das Dokument in Ihre Zeit retten. Die Agentur Dunnemals unterst\195\188tzt Sie bei der R\195\188ckreise.<BR>\nGehen Sie nun zum Seglerheim, dort treffen Sie Kapit\195\164n Wolle, er kann Ihnen bei der Suche weiterhelfen. <BR>\nParole: Seemannswolle<BR>\nAntwort: v.Malzahn Hptm 1.Garde Reg.<BR>\nDas war mein Deckname bei meinem kleinen Coup in C\195\182penick.<BR>\nViel Erfolg!<BR>\n<BR>\nWilhelm Voigt ", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      WWB_multiplatform_string("Brief schlei\195\159en", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB98
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB98(action)
  ztaskBriefgelesen.Complete = true
  ztaskFindedasSeglerheim.Active = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB99(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB100(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB101(action)
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB102(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Retten Sie das Dokument in Ihre Zeit, nutzen und verteilen Sie dessen Inhalt wenn Sie wollen. So kommt, was eigentlich dem Kaiserlichen Hof vorbehalten war, Ihnen zu Gute.<BR>\nWie es f\195\188r mich weitergeht wissen Sie sicher. Schwedische Gardinen, Begnadigung u.s.w. <BR>\nIch denke jedoch, dass sich der Aufwand gelohnt hat.<BR>\n~<BR>\nMighla wird nun in K\195\188rze im M\195\188ggelwald erscheinen. <BR>\nKommen Sie gesund zur\195\188ck und vielen Dank f\195\188r Ihren Einsatz Beck!<BR>\nIhr Wilhelm Voigt", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      WWB_multiplatform_string("schlie\195\159en", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB103
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB103(action)
  ztimerPortalGegenwartanzeigen:Start()
  ztaskMighlafinden.Active = true
  ztaskMighlafinden.Visible = true
  ztaskMighlafinden.Description = "Finde das Portal in die Gegenwart."
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB104(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Im Jahr 1906 treten Sie als Beck auf, in dieser Zeit spricht man sich meist mit dem Nachnamen an. <BR>\nDie passende Kleidung erhalten Sie automatisch beim \195\156bergang in die Vergangenheit. So sollten Sie nicht auffallen. Weiterhin wird ein Chip, der sich durch Kontakt mit diesem Brief in Ihre Haut einpflanzt, den Berliner Slang f\195\188r Sie verst\195\164ndlich machen. <BR>\n", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      "weiter",
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB105
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB105(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bereiten Sie sich nun auf Ihre Reise vor, nutzen Sie daf\195\188r unbedingt die Reiseakte, welche wir f\195\188r Sie im Internet bereit gestellt haben.<BR>\n~<BR>\nDie Akte ist f\195\188r Ihre Vorbereitungen notwendig, lesen Sie sich diese bitte sehr aufmerksam durch!<BR>\n~<BR>\nIn der Akte befinden sich:<BR>\nInformationen zum Spiel,<BR>\nIhre Reiseunterlagen<BR>\nund einiges mehr.<BR>\n", {PocketPC = 1}),
      Media = zmediaNotiz,
      Buttons = {
        "weiter",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB106
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch! <BR>\nSie haben die Reise ins Jahr 1906 gewonnen.<BR>\n~<BR>\nDie erforderlichen Unterlagen und das Zeitreiseportal haben wir f\195\188r Sie vorbereitet. Sicher haben Sie Verst\195\164ndnis, dass wir keine Risiken \195\188bernehmen, schlie\195\159lich reisen Sie freiwillig und kostenlos. Mit dem Lesen dieser Zeilen erkl\195\164ren Sie sich bereit alle Konsequenzen zu \195\188bernehmen. <BR>\n~<BR>\nVielen Dank!<BR>\n~<BR>\nBeachten sie bitte die folgenden Hinweise.", {PocketPC = 1}),
      Media = zmediaNotiz,
      Buttons = {"Hinweise"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB104
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB106(action)
  if action == "Button1" then
    zitemPortalAktivierungskarten:MoveTo(Player)
    zitemPortalZeitreisemaschiene:MoveTo(Player)
    zitemKofferschlsseluStadtkasse:MoveTo(Player)
    zitemHilfeInventarzhler:MoveTo(Player)
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ein unvergessliches Erlebnis w\195\188nscht Ihnen Ihre Agentur Dunnemals.<BR>\n~<BR>\nAkte Mighla<BR>\ngeomcwood.wixsite.com/mighla<BR>\nPasswort: 1906<BR>\n~<BR>\nP.S. Sie sollten sich mit den Wiki Erkl\195\164rungen \195\188ber \"Mighla\" vertraut machen!<BR>\n", {PocketPC = 1}),
      Media = zmediaNotiz,
      Buttons = {
        WWB_multiplatform_string("Wiki Erkl\195\164rungen", {PocketPC = 1}),
        "kein Interesse"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB107
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Im Jahr 1906 treten Sie als Beck auf, in dieser Zeit spricht man sich meist mit dem Nachnamen an. <BR>\nDie passende Kleidung erhalten Sie automatisch beim \195\156bergang in die Vergangenheit. So sollten Sie nicht auffallen. Weiterhin wird ein Chip, der sich durch Kontakt mit diesem Brief in Ihre Haut einpflanzt, den Berliner Slang f\195\188r Sie verst\195\164ndlich machen. <BR>\n", {PocketPC = 1}),
      Media = zmediaNotiz,
      Buttons = {
        "weiter",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB105
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB107(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("lt. Wikipedia:<BR>\nvorslawische, germanische Herkunft aus der indogermanischen Wurzel migh-, mighla = Nebel, um 1400 Miggel und heute bekannt als M\195\188ggel in M\195\188ggelsee, M\195\188ggelberge, u.s.w.", {PocketPC = 1}),
      Media = zmediaNotiz,
      Buttons = {
        "lt. Wikiwood"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB108
    })
  else
    zoneStartzone.Active = true
    ztaskZurStartzonegehen.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    cartMighlaTeil1v3:RequestSync()
  end
  ztaskVorbereitung.Active = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB108(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Lt. Wikiwood:<BR>\ndie Gegend bekam den Beinamen Mighla wegen der pl\195\182tzlich \195\182rtlich sehr begrenzt auftauchenden Nebelb\195\164nke.<BR>\nRecherchen von Dr. Kraut belegen, dass im Nebel (Mighla) eingeschlossene Personen oft nach Aufl\195\182sung des Nebels vermisst wurden. Und der seri\195\182se Professor R\195\188be konnte nun belegen, dass einige vermisste Personen in einer anderen Zeit am selben Ort aus dem Nebel auftauchten. <BR>\n", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB109
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB109(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Agentur Dunnemals arbeitet seit Generationen daran Mighla zu kontrollieren. Dies ist mit der Portal-Zeitreise-Maschine nun gelungen. Innerhalb von Mighla sind Zeitreisen mit dieser Maschine - unter Eingabe einer Aktivierungsformel - &nbsp;in vorbestimmte Zeiten m\195\182glich. Die Aktivierungsformel wird erst im Nebel sichtbar.", {PocketPC = 1}),
    Media = zmediaNotiz,
    Buttons = {
      WWB_multiplatform_string("Brief schlie\195\159en", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB110
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB110(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  zoneStartzone.Active = true
  ztaskZurStartzonegehen.Active = true
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB111(action)
  zitemKarte:MoveTo(Player)
  zitemKoffer.Commands.Schlossffnen.Enabled = true
  zitemBriefvomVoigt.Visible = false
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB113(action)
  if action == "Button1" then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    var_Anzahl_Hilfen_WfW = "3 Punkte WfW"
    var_Anzahl_Hilfen_WfWLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ein Hinweis in der Zeitung auf S.41 gibt eine Reihenfolge vor: 1. Staffelei = Zeichnung v. Zille, 2. Zeitung = Radfahrerzeitung S.1, 3. Plan = Stadtplan M\195\188ggelpark<BR>\n<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "neuer Versuch",
        "3.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB114
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB114(action)
  if action == "Button1" then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    var_Anzahl_Hilfen_WfW = "5 Punkte WfW"
    var_Anzahl_Hilfen_WfWLsung = 5
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ein weiterer Hinweis auf S.41 lautet Wort f\195\188r Wort, schreibe die Worte in der vorgegebenen Reihenfolge Wort f\195\188r Wort auf (1. Staffelei 2. Zeitung 3. Plan), erst das jeweils erste Wort danach das jeweils zweite Wort u.s.w.<BR>\nDer fertige Text enth\195\164lt Anweisungen und Hinweise.<BR>\n~<BR>\nMit dem Code 545 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB115
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB115(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeWfWAuflsung)
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB116(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB117(action)
  zoneFotobox.Active = true
  zitemFotoboxvonZille:MoveTo(zoneFotobox)
  zitemFotoboxvonZille.Description = WWB_multiplatform_string("Schlie\195\159e die Box um den \195\156berblick \195\188ber die anderen Gegenst\195\164nde zu behalten.")
  zitemFotoboxvonZille.Name = WWB_multiplatform_string("Fotobox schlie\195\159en")
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB119(action)
  zitemFoto05vonBlumenfrau:MoveTo(zoneFotobox)
  zitemFoto05vonBlumenfrau.Commands.indieFotoboxpacken.Enabled = false
  cartMighlaTeil1v3:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB120(action)
  zcharacterKellnerin.Commands.Kellnerinrufen.Enabled = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Vielen Dank f\195\188r das Trinkgeld mein Herr!<BR>\nBitte nehmen Sie das Foto mit, das hat jemand f\195\188r Sie hinterlegt.", {PocketPC = 1}),
    Media = zmediaKellnerin,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB121
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB121(action)
  zcharacterKellnerin.Commands.Fotonehmen.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB127(action)
  if action == "Button1" then
    zoneKoffer.Active = true
    zitemKoffer:MoveTo(zoneKoffer)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    cartMighlaTeil1v3:RequestSync()
  else
    Wherigo.PlayAudio(zmediaS_auf_zuschlieen)
    zitemKoffer.Commands.schliessen.Enabled = false
    zitemKoffer.Commands.Kofferffnen.Enabled = true
    zitemKoffer.Locked = true
    zitemKoffer.Media = zmediaKoffer
    zitemKoffer.Name = "Koffer geschlossen"
    zitemKoffer.Description = WWB_multiplatform_string("Der Koffer ist geschlossen, \195\182ffne ihn wenn Du Gegenst\195\164nde auspacken m\195\182chtest.")
    zitemKoffer:MoveTo(Player)
    cartMighlaTeil1v3:RequestSync()
    Wherigo.MessageBox({
      Text = "Der Koffer ist geschlossen",
      Media = zmediaKoffer,
      Buttons = {"ok"}
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB130(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = [[
War Dein Anruf erfolgreich?<BR>
Falls nicht, klicke auf Hilfe.]],
      Media = zmediaMighlaFinaleTelefonnummer,
      Buttons = {"Ja", "Hilfe"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB131
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Hier ist der Anschluss der Reiseagentur Dunnemals. Da Mighla Ihnen diese Telefonnummer mitgeteilt hat, sind Sie gem\195\164\195\159 Anweisung von Herrn Voigt autorisiert, das Dokument zu bergen und dessen Inhalt zu verbreiten. <BR>\n~<BR>\nSie finden das Dokument an folgenden Koordinaten. Denken Sie an den letzten Hinweis von McWood und Dunnemals<BR>\n~<BR>\nBitte notieren Sie: <BR>\nNord 52 Grad 25 Komma 554 Minuten, <BR>\nOst 013 Grad 37 Komma 954 Minuten.<BR>\n<BR>\n<BR>\n", {PocketPC = 1}),
      Media = zmediaLogo,
      Buttons = {"verstanden"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB135
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB131(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Mighla ist verschwunden, die Reise, der Wherigo, ist nun beendet, Dein Auftrag allerdings noch nicht. <BR>\n~<BR>\nWeiter geht es mit dem Cache GC8XJ30. Die Koordinaten hast Du vom Anrufbeantworter erhalten. <BR>\n~<BR>\nUm vor Ort an den Cache Inhalt zu gelangen, kommt der Inbusschl\195\188ssel zum Einsatz. An den Seiten rechts und links die Schraube bis zum Anschlag raus gedreht und das Dach angehoben. Keine Angst, es ist unbewohnt.<BR>\n~<BR>\nBitte verriegle das Dach wieder fest bevor Du gehst.", {PocketPC = 1}),
      Media = zmediaLogo,
      Buttons = {"weiter"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB132
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Zahlen im Nebel sehen wie eine Telefonnummer aus,<BR>\nda Du Dich in der Gegenwart befindest ist ein Anruf m\195\182glich.<BR>\n~<BR>\nKlicke auf lesen wenn Du nicht anrufen m\195\182chtest.", {PocketPC = 1}),
      Media = zmediaMighlaFinaleTelefonnummer,
      Buttons = {"ok", "lesen"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB130
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB132(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ein letzter Hinweis: <BR>\nUm kaiserliche Telefonmuggel fernzuhalten wurden die Nord und S\195\188d Koordinaten auf dem Anrufbeantworter jeweils um 10 Minuten gek\195\188rzt. (DM Koordinaten)<BR>\nZ\195\164hle also 10 Minuten hinzu um den Cache zu finden!<BR>\n~<BR>\nz.B. 52 25,123' +10' = 52 25,133'", {PocketPC = 1}),
    Media = zmediaLogo,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB133
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB133(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ich hoffe der Ausflug in die Berliner Vergangenheit hat Dir gefallen. <BR>\n~<BR>\nVielen Dank, dass Du Dich f\195\188r die Reise entschieden hast!<BR>\n~<BR>\nEs gr\195\188\195\159en die Reiseagentur Dunnemals, Voigt, Zille, Kalle, ....<BR>\n~<BR>\nMeinen besonderen Dank an dieser Stelle gilt meiner Frau, den Freunden und Bekannten die den Wherigo etliche Male getestet haben.<BR>\nHerzlichen Dank daf\195\188r!<BR>\n<BR>\nMcWood", {PocketPC = 1}),
    Media = zmediaLogo,
    Buttons = {
      WWB_multiplatform_string("Danke und Tsch\195\188\195\159", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB134
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB134(action)
  zitemMighlaAB.Visible = true
  zitemMighlaAB:MoveTo(Player)
  zitemHilfeInventarzhler.Visible = false
  zitemHilfePunkteTeil2.Visible = true
  zitemHilfePunkteTeil2:MoveTo(Player)
  zitemDokumentenSchlssel.Visible = true
  zitemDokumentenSchlssel:MoveTo(Player)
  cartMighlaTeil1v3.Complete = true
  zitemUnlockCodeT2:MoveTo(Player)
  zonePortalGegenwart_.Active = false
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB135(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Mighla ist verschwunden, die Reise, der Wherigo, ist nun beendet, Dein Auftrag allerdings noch nicht. <BR>\n~<BR>\nWeiter geht es mit dem Cache GC8XJ30. Die Koordinaten hast Du vom Anrufbeantworter erhalten. <BR>\n~<BR>\nUm vor Ort an den Cache Inhalt zu gelangen, kommt der Inbusschl\195\188ssel zum Einsatz. An den Seiten rechts und links die Schraube bis zum Anschlag raus gedreht und das Dach angehoben. Keine Angst, es ist unbewohnt.<BR>\n~<BR>\nBitte verriegle das Dach wieder fest bevor Du gehst.", {PocketPC = 1}),
    Media = zmediaLogo,
    Buttons = {"weiter"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB132
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB136(action)
  Wherigo.MessageBox({
    Text = "(rot)O-O-S-N-W-W-S-S-O-O-S-S-W-W-N-S-O-O-O-N-N-N-N-S-S-S-S-O-O-O-W-W-N-N-O-W-N-N-O-O-O-O-SO-SW-SO-SW-W-N-N-O-W-N-N-O-O-O-O-O-W-W-S-S-O-W-S-S-O-O-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-O-O-N-N-N-N-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-O-NO-N-N-NW-W-S-S-S-S-O-O-O-",
    Media = zmediaNavigation,
    Buttons = {
      "Detail 3",
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB137
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB137(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("(gr\195\188n)NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-O-O-W-W-S-S-O-W-S-S-O-O-O-N-N-N-N-S-S-S-S-O-O-N-N-N-N-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-O-O-O-O-SW-SW-W-O-O-W-SW-SW-O-O-O-O-O-N-N-N-N-S-S-S-S-O-O-O-N-N-W-O-S-S-W-W-N-N-N-N-O-O-S<BR>\n<BR>\nDas sollten die Koordinaten f\195\188r das Tauchziel werden:<BR>\n(gr\195\188n)(rot)Grad,(gelb)(rot)(gr\195\188n)Meter<BR>\n", {PocketPC = 1}),
      Media = zmediaNavigation,
      Buttons = {
        "ok",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB138
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Navigation Tauchziel<BR>\n-<BR>\nEs scheint es muss etwas auf Karopapier entschl\195\188sselt werden.<BR>\n-<BR>\n(gelb)W-W-N-N-O-W-N-N-O-O-O-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-N-N-O-O-S-S-N-N-N-N-O-S-S-S-S-O-O-N-N-N-N-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-O-NO-N-N-NW-W-O-O-O-O-O-W-W-S-S-O-W-S-S-O-O-O-N-N-N-N-O-SO-SW-W-SO-SO-O-N-N-N-N-W-O-O-O-<BR>\n", {PocketPC = 1}),
      Media = zmediaNavigation,
      Buttons = {"Detail 2"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB136
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB138(action)
  if action == "Button1" then
  else
    Wherigo.MessageBox({
      Text = "(rot)O-O-S-N-W-W-S-S-O-O-S-S-W-W-N-S-O-O-O-N-N-N-N-S-S-S-S-O-O-O-W-W-N-N-O-W-N-N-O-O-O-O-SO-SW-SO-SW-W-N-N-O-W-N-N-O-O-O-O-O-W-W-S-S-O-W-S-S-O-O-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-O-O-N-N-N-N-S-S-S-S-O-NO-NO-NO-NO-S-S-S-S-NO-NO-NO-NO-O-S-S-S-S-O-NO-N-N-NW-W-S-S-S-S-O-O-O-",
      Media = zmediaNavigation,
      Buttons = {
        "Detail 3",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB137
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB139(action)
  zitemNotiz:MoveTo(Player)
  zitemNotiz.Visible = false
  ztaskEineNelkekaufen.Active = true
  ztaskImBiergartenaufKontaktwarten.Active = true
  var_SchliessfachGbS = var_SchliessfachGbS + 1
  cartMighlaTeil1v3:RequestSync()
  if var_SchliessfachGbS == 5 then
    zoneTreppezumBiergarten.Active = true
    zoneBiergarten.Active = true
    zoneSchliessfach_.Active = false
    cartMighlaTeil1v3:RequestSync()
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB140(action)
  Wherigo.MessageBox({
    Text = [[
Pelles Zauberei<BR>
~<BR>
7 vor 9<BR>
3 umgedreht<BR>
0 hinter 7<BR>
1 umgedreht<BR>
7 tauscht mit 3<BR>
9 vor 1]],
    Media = zmediaPergament1,
    Buttons = {
      "weiter",
      WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB141
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB141(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = [[
Wenn Onkel Pelle zauberte,<BR>
er immer von unten<BR>
nach oben legte.]],
      Media = zmediaPergament2,
      Buttons = {
        "weiter",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB142
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Hallo Beck,<BR>\num die Truhe zu \195\182ffnen, m\195\188ssen Sie einen letzten Code eingeben.<BR>\nOnkel Pelle, ein Freund von Zille, hat uns bei dieser Verschl\195\188sselung unterst\195\188tzt. Schauen Sie sich das komplette Pergament an.<BR>\nLegen Sie die Portalaktivierungskarten wie folgt nebeneinander aus:<BR>\n1 9 7 3", {PocketPC = 1}),
      Media = zmediaPergament,
      Buttons = {"weiter"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB140
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB142(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Wenn Onkel Pelle zauberte,<BR>\ndie vorletzte, erste, letzte und dann die vorvorletzte<BR>\nKarte die L\195\182sung zeigt.<BR>\n~<BR>\nGib den Code in die Truhe ein.", {PocketPC = 1}),
      Media = zmediaPergament3,
      Buttons = {
        "zur Truhe",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB143
    })
  else
    Wherigo.MessageBox({
      Text = [[
Pelles Zauberei<BR>
~<BR>
7 vor 9<BR>
3 umgedreht<BR>
0 hinter 7<BR>
1 umgedreht<BR>
7 tauscht mit 3<BR>
9 vor 1]],
      Media = zmediaPergament1,
      Buttons = {
        "weiter",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB141
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB143(action)
  if action == "Button1" then
    ztaskAufgabe9lsen.Active = true
    zitemTruhe.Commands.ZauberCodeeingeben.Enabled = true
    cartMighlaTeil1v3:RequestSync()
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    Wherigo.MessageBox({
      Text = [[
Wenn Onkel Pelle zauberte,<BR>
er immer von unten<BR>
nach oben legte.]],
      Media = zmediaPergament2,
      Buttons = {
        "weiter",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB142
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB156(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB157(action)
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB161(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB162(action)
  if action == "Button1" then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    var_Anzahl_Hilfen_Truhe = "3 Punkte Truhe"
    var_Anzahl_Hilfen_TruheLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Zahlen auf dem Bild der Truhe sind auch auf den Fotos die Du bekommen hast zu finden. Sie stehen dort mit je ein oder mehreren Buchstaben zusammen. <BR>\nDer Unterstrich k\195\188ndigt ein Wortende an.<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1}),
        "3.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB163
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB163(action)
  if action == "Button1" then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    var_Anzahl_Hilfen_Truhe = "5 Punkte Truhe"
    var_Anzahl_Hilfen_TruheLsung = 5
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ersetze die Zahlen von der Truhe mit den zugeh\195\182rigen Buchstaben die auf den Fotos zu finden sind. Es ergibt sich eine Wegbeschreibung.<BR>\n~<BR>\nMit dem Code auf dem Bild 12 kannst Du Dir die L\195\182sung anzeigen lassen.", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB164
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB164(action)
  zitemFoto12ausBrief3.Description = WWB_multiplatform_string("Der Code f\195\188r die Aufl\195\182sung: 101")
  zitemFoto12ausBrief3.Commands.Lsungscodeeingeben.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB165(action)
  zoneSchutzhtte.Active = true
  zitemTruhe.Commands._1Hilfe.Enabled = true
  var_Anzahl_Hilfen_Truhe = "0 Punkte Truhe"
  ztaskAufgabe7lsen.Active = true
  cartMighlaTeil1v3:RequestSync()
  Wherigo.MessageBox({
    Text = [[
Auf der Unterseite ist ein Foto mit Zahlen eingraviert.<BR>
<BR>
Den Truhenboden findest Du auch in Deiner Akte:<BR>
~<BR>
https://geomcwood.wixsite.com/mighla/truhenboden<BR>
Inventar Name: Truhenboden<BR>
Passwort: pop]],
    Media = zmediaTruheUnterseite,
    Buttons = {"ok", "Details"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB166
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB166(action)
  if action == "Button1" then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    cartMighlaTeil1v3:RequestSync()
  else
    Wherigo.MessageBox({
      Text = [[
Auf dem Foto sind Zahlen zu erkennen:<BR>
~<BR>
15 87_ 25 21 22 55 45_<BR>
44 45_ 43 35 65 9 77 55_ <BR>
99 35 65 55_ 56 45 22_ <BR>
21 99_ 66 33 22_ 88 21 12_ <BR>
34 99_ 78 11 66 55 77<BR>
]],
      Media = zmediaTruheUnterseite,
      Buttons = {"ok"},
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB167
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB167(action)
  var_Anzahl_Hilfen_Schutzhtte = WWB_multiplatform_string("0 Punkte Schutzh\195\188tte")
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB168(action)
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB169(action)
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB171(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputKettenschlossCode)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Leider ist die Pause zu Ende. Ich kann Ihnen den Code f\195\188r das Schloss nennen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Code eingeben"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB85
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB172(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeKettenschlossAuflsung)
  else
    Wherigo.GetInput(zinputKettenschlossCode)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB173(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputKofferschlossCode)
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB174(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeKofferschlossAuflsung)
  else
    Wherigo.GetInput(zinputKofferschlossCode)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB175(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputNavigationKoordinate)
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB176(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeNavigationAuflsung)
  else
    Wherigo.GetInput(zinputNavigationKoordinate)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB177(action)
  Wherigo.GetInput(zinputPelleCodeZauberei)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB178(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfePelleAuflsung)
  else
    Wherigo.GetInput(zinputPelleCodeZauberei)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB179(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputSchliessfach_Code)
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB180(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeSchliefachAuflsung)
  else
    Wherigo.GetInput(zinputSchliessfach_Code)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB181(action)
  Wherigo.GetInput(zinputSchutzhtteCode)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB182(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeSchutzhtteAuflsung)
  else
    Wherigo.GetInput(zinputSchutzhtteCode)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB183(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputTreibgut_Code)
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB184(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeTreibgutAuflsung)
  else
    Wherigo.GetInput(zinputTreibgut_Code)
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB185(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB186(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB187(action)
  Wherigo.GetInput(zinputZeitreiseDaten1_11_1906)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB188(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeZeitreiseAuflsung1_11_1906)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 1.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 180 Grad und drehe die Karte rechts von Dir um.<BR>\nDrehe Dich um 90 Grad linksherum und tausche die Karten rechts und links von Dir.<BR>\nTausche die Karten von Zeit und von Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der Bildung.<BR>\nDrehe Dich um 90 Grad nach rechts.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine ", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB11
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB189(action)
  Wherigo.GetInput(zinputZeitreiseDaten26_05_1927)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB190(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeZeitreiseAuflsung26_05_1927)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 26.5.1927<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. <BR>\nStelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte hinter Dir um.<BR>\nTausche die Karten von Zeit und Ort.<BR>\nDrehe Dich um 90 Grad linksherum und drehe die Karten links von Dir und vor Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 180 Grad.<BR>\nDrehe Dich um 90 Grad nach links.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB31
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB191(action)
  Wherigo.GetInput(zinputZeitreiseDaten2_11_1906)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB192(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeZeitreiseAuflsung2_11_1906)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 2.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nTausche die Karten von Zeit und Reise.<BR>\nDrehe die Karten links und rechts von Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 90 Grad nach rechts und tausche die Karte hinter Dir mit der vor Dir.<BR>\nDrehe die Karte Reise um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB9
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB193(action)
  Wherigo.GetInput(zinputZeitreiseDatenGegenwart)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB194(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputHilfeZeitreiseAuflsungGegenwart)
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise in die Gegenwart<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. Stelle Dich auf Deinen Platz in die Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte rechts von Dir um.<BR>\nTausche die Karten von Reise und Bildung. <BR>\nDrehe Dich um 180 Grad und drehe die Karte hinter Dir um.<BR>\nDrehe Dich um 90 Grad rechtsherum.<BR>\nTausche die Karten Zeit und Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der von der Zeit.<BR>\nDrehe die Karten vor Dir und links von Dir um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB33
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB195(action)
  zcharacterTaucher.Visible = false
  zcharacterTaucher:MoveTo(zoneBadebucht2_)
  zoneBadebucht2.Active = true
  ztaskBadebuchtaufsuchen.Active = true
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB196(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputKettenschlossCode)
  else
    var_Anzahl_Hilfen_Kettenschloss = "1 Punkt Kettenschloss"
    var_Anzahl_Hilfen_KettenschlossLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Radfahrerzeitung Seite 37 und 45.<BR>\nSeite 37 erkl\195\164rt Dir, wie Du mit dem Text auf Seite 45 umgehen musst um R-A-D zu l\195\182sen.<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB197
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB197(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputKettenschlossCode)
  else
    var_Anzahl_Hilfen_Kettenschloss = "3 Punkte Kettenschloss"
    var_Anzahl_Hilfen_KettenschlossLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Auf Seite 45 musst Du die letzten Worte jeder Zeile von oben nach unten lesen. In der App sind die Zeilen mit einem Strich \"-\" am Anfang und Ende gekennzeichnet.<BR>\nDie richtigen Buchstaben sind durch \"R-A-D\" vorgegeben. R,A,D gro\195\159 oder klein ist egal. Die Ersatzteile sind umrandet oder in der App gro\195\159geschrieben.<BR>\n~<BR>\nMit dem Code 310 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB172
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB199(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputKofferschlossCode)
  else
    var_Anzahl_Hilfen_Kofferschoss = "1 Punkt Kofferschloss"
    var_Anzahl_Hilfen_KofferschossLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst Deine Reiseunterlage \"Kofferschl\195\188ssel\", die Karte \"Kofferschl\195\188ssel Code\" aus dem Brief auf dem Dich der Schutzmann hingewiesen hat und einen Bleistift.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB200
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB200(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputKofferschlossCode)
  else
    var_Anzahl_Hilfen_Kofferschoss = "3 Punkte Kofferschloss"
    var_Anzahl_Hilfen_KofferschossLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nun schw\195\164rze mit Deinem Bleistift genau die Zellen Deiner Reiseunterlage \"Kofferschl\195\188ssel\" welche den Symbolen auf dem \"Kofferschl\195\188ssel Code\" entsprechen. Die nicht geschw\195\164rzten Zellen ergeben drei Zahlen.<BR>\n~<BR>\nMit dem Code 422 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB174
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB201(action)
  if var_Inventar_Spieler >= 5 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Moment bitte, meine H\195\164nde sind voll. Ich muss erst etwas in den Koffer packen.", {PocketPC = 1}),
      Media = zmediaSpieler,
      Buttons = {
        "Ok, ich warte."
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB69
    })
    zcharacterTaucher.Commands.Informationnehmen.Enabled = true
  else
    zcharacterTaucher.Visible = false
    zcharacterTaucher.Commands.ansprechen.Enabled = false
    zcharacterTaucher.Commands.Binwiederzurck.Enabled = false
    zcharacterTaucher.Commands.WarenSieerfolgreich.Enabled = true
    Wherigo.Command("StopSound")
    zoneBadebucht1.Active = true
    zitemStadtkasse3von3:MoveTo(Player)
    var_Inventar_Spieler = var_Inventar_Spieler + 1
    zitemTreibgut.Commands.Codeeingeben.Enabled = true
    zitemTreibgut.Commands.ffnen.Enabled = false
    zcharacterTaucher:MoveTo(zoneBadebucht1_)
    ztaskAufgabe5lsen.Active = true
    ztaskBadebuchtaufsuchen.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    cartMighlaTeil1v3:RequestSync()
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB202(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputNavigationKoordinate)
  else
    var_Anzahl_Hilfen_Navigation = "1 Punkt Navigation"
    var_Anzahl_Hilfen_NavigationLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst den vom Kapit\195\164n \195\188bergebenen Brief von Voigt. In dem Briefumschlag befindet sich die Information \"Navigation\" mit den verschl\195\188sselten Koordinaten f\195\188r die Taucher.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB203
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB203(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputNavigationKoordinate)
  else
    var_Anzahl_Hilfen_Navigation = "3 Punkte Navigation"
    var_Anzahl_Hilfen_NavigationLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Zeichne jede Himmelsrichtung in jeweils einem Karo auf Deinem Karopapier als Strich ein. z.B. N=Nord, also ein Strich senkrecht nach oben an der Karoseite oder NO=Nordost, also ein Strich von unten links nach oben rechts im Karo.<BR>\nAlle Himmelsrichtungen aneinander gezeichnet ergeben eine ausgeschriebene Zahl. <BR>\nDie drei farblich hinterlegten Himmelsrichtungen (in der App Farben in Klammern) markieren jeweils den Beginn einer neuen Zahl.<BR>\nDie farblichen Platzhalter in der Koordinate werden mit den entsprechenden Zahlen ersetzt.<BR>\n~<BR>\nMit dem Code 634 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB176
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB204(action)
  zcharacterKapitn.Commands.Antwort.Enabled = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Das versenkte Geheimnis soll nun in Ihre H\195\164nde gelangen.<BR>\nF\195\188r die Bergung habe ich Taucher zum L\195\164ufer bestellt, sie warten auf Ihre Ankunft und auf die Koordinaten. Weisen Sie sich mit der Parole \"Seepferdchen\" aus, die Antwort lautet \"Freischwimmer\". <BR>\nUnd noch etwas Unangenehmes muss ich Ihnen leider mitteilen....", {PocketPC = 1}),
    Media = zmediaKapitn,
    Buttons = {
      "Ja, und was?"
    },
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB205
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB205(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Es gab gestern einen starken Sturm, der hat wohl etwas von seinem Platz am Grund des Sees weggerissen. Jedenfalls hat die Rettungswacht am Teppich vorhin gemeldet, sie habe etwas Eigenartiges aus dem Wasser gefischt. Bevor es in falsche H\195\164nde ger\195\164t, sammeln Sie das Treibgut zuerst von dort ein. Melden Sie sich bei Martha mit einem Gru\195\159 von mir.<BR>\nJetzt wird es aber Zeit f\195\188r Sie Beck, packen Sie dieses Foto in die Fotobox und nehmen Sie den Brief an sich.<BR>\n", {PocketPC = 1}),
    Media = zmediaKapitn,
    Buttons = {"Ok"},
    Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB206
  })
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB206(action)
  var_Anzahl_Hilfen_Navigation = "0 Punkte Navigation"
  zcharacterKapitn.Commands.BriefFotonehemn.Enabled = true
  zoneTeppich.Active = true
  zoneLufer.Active = true
  ztaskTreibgutabholen.Active = true
  ztaskTreffedieTaucher.Active = true
  ztaskAufgabe4lsen.Active = true
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB207(action)
  zcharacterKapitn.Visible = false
  ztimerKapitn:Start()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB208(action)
  var_ParoleAntworten = var_ParoleAntworten + 2
  Wherigo.GetInput(zinputParoleKapitn)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB209(action)
  if action == "Button1" then
    zitemEingabeNavigation:MoveTo(zoneLufer_)
    Wherigo.GetInput(zinputNavigationKoordinate)
  else
    Wherigo.MessageBox({
      Text = "Oh, die Koordinaten. Da war doch was in dem 2. Brief vom Voigt.",
      Media = zmediaGedankenblase,
      Buttons = {
        "Moment bitte"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB83
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB210(action)
  Wherigo.GetInput(zinputParoleTaucher)
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB211(action)
  zitemTruhe.Commands.Codeeingeben.Enabled = false
  zitemTruhe.Commands.Briefnehmen.Enabled = true
  zitemTruhe.Media = zmediaTruheoffen
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB212(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = [[
Pelles Zauberei<BR>
~<BR>
7 vor 9<BR>
3 umgedreht<BR>
0 hinter 7<BR>
1 umgedreht<BR>
7 tauscht mit 3<BR>
9 vor 1]],
      Media = zmediaPergament1,
      Buttons = {
        "weiter",
        WWB_multiplatform_string("zur\195\188ck", {PocketPC = 1})
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB141
    })
  else
    var_Anzahl_Hilfen_Pelle = "1 Punkt Pelle"
    var_Anzahl_Hilfen_PelleLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Reiseunterlage \"Aktivierungskarten\" und das Pergament.<BR>\nDie Aktivierungskarten: 1 9 7 3 legst Du nebeneinander. Erinnere Dich an die zweite Seite vom Pergament und wende nun die erste Zauberregel an: \"Wenn Onkel Pelle zauberte, er immer von unten nach oben legte.\" <BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB213
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB213(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputPelleCodeZauberei)
  else
    var_Anzahl_Hilfen_Pelle = "3 Punkte Pelle"
    var_Anzahl_Hilfen_PelleLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nachdem Du die Karten getauscht und gedreht hast, wende nun die zweite Zauberregel an: \"...die vorletzte, erste, letzte und dann die vorvorletzte...) Sortiere die Karten dementsprechend. Die neue Reihenfolge ergibt den Code, den Du in die Truhe eingibst. <BR>\n~<BR>\nMit dem Code 173 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB178
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB215(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputSchliessfach_Code)
  else
    var_Anzahl_Hilfen_Schliessfach = WWB_multiplatform_string("1 Punkt Schlie\195\159fach")
    var_Anzahl_Hilfen_SchliessfachLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst den Stadtplan M\195\188ggelpark von Voigt, die Zeichnung von Zille, die Radfahrerzeitung S.1 + S.41 vom Zeitungsjungen sowie den Hinweis von der Ecke Spree und M\195\188ggelsee.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB216
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB216(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputSchliessfach_Code)
  else
    var_Anzahl_Hilfen_Schliessfach = WWB_multiplatform_string("3 Punkte Schlie\195\159fach")
    var_Anzahl_Hilfen_SchliessfachLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Der Hinweis von der Ecke Spree und M\195\188ggelsee gibt die Reihenfolge der Zahlen f\195\188r das Schloss am Schlie\195\159fach vor: 1. Nummer der Ausgabe, 2. Redaktionsschluss, 3. Jahrgang <BR>\n~<BR>\nMit dem Code 894 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB180
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB217(action)
  var_Anzahl_Hilfen_Pelle = "0 Punkte Pelle"
  zitemTruhe.Media = zmediaTruhePergament
  zitemTruhe.Commands.Pergamentnehmen.Enabled = true
  zitemTruhe.Commands.Codeeingeben.Enabled = false
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB218(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputSchutzhtteCode)
  else
    var_Anzahl_Hilfen_Schutzhtte = WWB_multiplatform_string("1 Punkt Schutzh\195\188tte")
    var_Anzahl_Hilfen_SchutzhtteLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst ultraviolettes Licht und musst Dich in der Schutzh\195\188tte befinden.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB219
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB219(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputSchutzhtteCode)
  else
    var_Anzahl_Hilfen_Schutzhtte = WWB_multiplatform_string("3 Punkte Schutzh\195\188tte")
    var_Anzahl_Hilfen_SchutzhtteLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das Licht l\195\164sst folgende Worte erscheinen:<BR>\n\"Ordnungszahl\", \"Elemente\", \"Summe\" sowie den Code \"GeHeIMnIS\"<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "3.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB220
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB220(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputSchutzhtteCode)
  else
    var_Anzahl_Hilfen_Schutzhtte = WWB_multiplatform_string("5 Punkte Schutzh\195\188tte")
    var_Anzahl_Hilfen_SchutzhtteLsung = 5
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Summe der Ordnungszahlen der Elemente Ge+He+I+Mn+I+S ergibt den Code f\195\188r die Truhe.<BR>\n~<BR>\nMit dem Code 767 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB182
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB221(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputTreibgut_Code)
  else
    var_Anzahl_Hilfen_Treibgut = "1 Punkt Treibgut"
    var_Anzahl_Hilfen_TreibgutLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Reiseunterlage \"Stadtkasse\" sowie die Teile 1 bis 3 der Stadtkasse.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB222
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB222(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputTreibgut_Code)
  else
    var_Anzahl_Hilfen_Treibgut = "3 Punkte Treibgut"
    var_Anzahl_Hilfen_TreibgutLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Schaue Dir die Reiseunterlage \"Stadtkasse\" genauer an!<BR>\nDer Hinweis zu den falschen M\195\188nzen ist hier versteckt.<BR>\n~<BR>\nDen Hinweis der Taucher: \"Reihenfolge von rechts nach links\" beachten.<BR>\n~<BR>\nMit dem Code 788 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaLsungFrage,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB184
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB223(action)
  zcharacterMann.Visible = true
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB224(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 1.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 180 Grad und drehe die Karte rechts von Dir um.<BR>\nDrehe Dich um 90 Grad linksherum und tausche die Karten rechts und links von Dir.<BR>\nTausche die Karten von Zeit und von Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der Bildung.<BR>\nDrehe Dich um 90 Grad nach rechts.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine ", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB11
    })
  else
    var_Anzahl_Hilfen_1_11_1906 = "1 Punkt Portal 1.11.1906"
    var_Anzahl_Hilfen_1_11_1906Lsung = "1"
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Reiseunterlagen \"Zeitmaschine\" und \"Aktivierungskarten\".<BR>\n~<BR>\nHefte mit den B\195\188roklammern die ausgeschnittenen \"Aktivierungskarten\" auf den entsprechenden Bildern auf der \"Zeitmaschine\" fest. Stelle Dich in Gedanken so auf das Blatt \"Zeitmaschine\" wie es die Schuhabdr\195\188cke vorgeben.<BR>\n~<BR>\nDu siehst vor Dir den Ort mit der Karte 1<BR>\nund rechts von Dir die Zeit mit der Karte 7 u.s.w.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB225
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB225(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 1.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 180 Grad und drehe die Karte rechts von Dir um.<BR>\nDrehe Dich um 90 Grad linksherum und tausche die Karten rechts und links von Dir.<BR>\nTausche die Karten von Zeit und von Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der Bildung.<BR>\nDrehe Dich um 90 Grad nach rechts.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort <BR>\n2. schaue nach rechts <BR>\n3. schaue durch die Beine ", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB11
    })
  else
    var_Anzahl_Hilfen_1_11_1906 = "3 Punkte Portal 1.11.1906"
    var_Anzahl_Hilfen_1_11_1906Lsung = "3"
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nz.B. Drehe Dich um 180 Grad (vor Dir ist nun die Reise) und drehe die Karte rechts von Dir um (aus der 2 wird eine 3)<BR>\n~<BR>\nMit dem Code 245 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB188
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB227(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 26.5.1927<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. <BR>\nStelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte hinter Dir um.<BR>\nTausche die Karten von Zeit und Ort.<BR>\nDrehe Dich um 90 Grad linksherum und drehe die Karten links von Dir und vor Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 180 Grad.<BR>\nDrehe Dich um 90 Grad nach links.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB31
    })
  else
    var_Anzahl_Hilfen_26_05_1927 = "1 Punkt Portal 26.05.1927"
    var_Anzahl_Hilfen_26_05_1927Lsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Reiseunterlagen \"Zeitmaschine\" und \"Aktivierungskarten\".<BR>\n~<BR>\nHefte mit den B\195\188roklammern die ausgeschnittenen \"Aktivierungskarten\" auf den entsprechenden Bildern auf der \"Zeitmaschine\" fest. Stelle Dich in Gedanken so auf das Blatt \"Zeitmaschine\" wie es die Schuhabdr\195\188cke vorgeben.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB228
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB228(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 26.5.1927<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. <BR>\nStelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte hinter Dir um.<BR>\nTausche die Karten von Zeit und Ort.<BR>\nDrehe Dich um 90 Grad linksherum und drehe die Karten links von Dir und vor Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 180 Grad.<BR>\nDrehe Dich um 90 Grad nach links.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB31
    })
  else
    var_Anzahl_Hilfen_26_05_1927 = "3 Punkte Portal 26.05.1927"
    var_Anzahl_Hilfen_26_05_1927Lsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nMit dem Code 469 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB190
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB229(action)
  var_Anzahl_Hilfen_Schliessfach = WWB_multiplatform_string("0 Punkte Schlie\195\159fach")
  zone09_Spree_Ecke.Active = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  ztaskFindedenHinweis.Active = true
  cartMighlaTeil1v3:RequestSync()
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB230(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 2.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nTausche die Karten von Zeit und Reise.<BR>\nDrehe die Karten links und rechts von Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 90 Grad nach rechts und tausche die Karte hinter Dir mit der vor Dir.<BR>\nDrehe die Karte Reise um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB9
    })
  else
    var_Anzahl_Hilfen_2_11_1906 = "1 Punkt Portal 2.11.1906"
    var_Anzahl_Hilfen_2_11_1906Lsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Reiseunterlagen \"Zeitmaschine\" und \"Aktivierungskarten\".<BR>\n~<BR>\nHefte mit den B\195\188roklammern die ausgeschnittenen \"Aktivierungskarten\" auf den entsprechenden Bildern auf der Zeitmaschine fest. Stelle Dich in Gedanken so auf das Blatt \"Zeitmaschine\" wie es die Schuhabdr\195\188cke vorgeben.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB231
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB231(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise 2.11.1906<BR>\nLege die Portal Aktivierungskarten,\194\160wie auf der Portal Zeitreisemaschine abgebildet, aus. Stelle Dich auf Deinen Platz in der Mitte.<BR>\n~<BR>\nTausche die Karten von Zeit und Reise.<BR>\nDrehe die Karten links und rechts von Dir um.<BR>\nTausche die Karten von Reise und Ort.<BR>\nDrehe Dich um 90 Grad nach rechts und tausche die Karte hinter Dir mit der vor Dir.<BR>\nDrehe die Karte Reise um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB9
    })
  else
    var_Anzahl_Hilfen_2_11_1906 = "3 Punkte Portal 2.11.1906"
    var_Anzahl_Hilfen_2_11_1906Lsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nMit dem Code 559 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB192
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB232(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise in die Gegenwart<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. Stelle Dich auf Deinen Platz in die Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte rechts von Dir um.<BR>\nTausche die Karten von Reise und Bildung. <BR>\nDrehe Dich um 180 Grad und drehe die Karte hinter Dir um.<BR>\nDrehe Dich um 90 Grad rechtsherum.<BR>\nTausche die Karten Zeit und Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der von der Zeit.<BR>\nDrehe die Karten vor Dir und links von Dir um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB33
    })
  else
    var_Anzahl_Hilfen_Gegenwart = "1 Punkt Portal Gegenwart"
    var_Anzahl_Hilfen_GegenwartLsung = 1
    zitemHilfeInventarzhler:MoveTo(Player)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du ben\195\182tigst die Reiseunterlagen \"Zeitmaschine\" und \"Aktivierungskarten\".<BR>\n~<BR>\nHefte mit den B\195\188roklammern die ausgeschnittenen \"Aktivierungskarten\" auf den entsprechenden Bildern auf der \"Zeitmaschine\" fest. Stelle Dich in Gedanken so auf das Blatt \"Zeitmaschine\" wie es die Schuhabdr\195\188cke vorgeben.", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "neuer Versuch",
        "2.Hilfe"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB233
    })
  end
end
function cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB233(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Aktivierung der Zeitreise in die Gegenwart<BR>\nLege die Aktivierungskarten,\194\160wie auf der Reiseunterlage abgebildet, aus. Stelle Dich auf Deinen Platz in die Mitte.<BR>\n~<BR>\nDrehe Dich um 90 Grad nach links und drehe die Karte rechts von Dir um.<BR>\nTausche die Karten von Reise und Bildung. <BR>\nDrehe Dich um 180 Grad und drehe die Karte hinter Dir um.<BR>\nDrehe Dich um 90 Grad rechtsherum.<BR>\nTausche die Karten Zeit und Reise.<BR>\nDrehe Dich um 180 Grad und tausche die Karte links von Dir mit der von der Zeit.<BR>\nDrehe die Karten vor Dir und links von Dir um.<BR>\n~<BR>\nDen Zeitreise-Code in dieser Reihenfolge eingeben:<BR>\n1. Ort<BR>\n2. schaue nach rechts<BR>\n3. schaue durch die Beine", {PocketPC = 1}),
      Buttons = {
        "Eingabe Zeitreise-Daten"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB33
    })
  else
    var_Anzahl_Hilfen_Gegenwart = "3 Punkte Gegenwart"
    var_Anzahl_Hilfen_GegenwartLsung = 3
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Nun folge den Anweisungen der Formel. Bei richtiger Umsetzung ergibt die letzte Anweisung Zahlen und Reihenfolge f\195\188r den Zahlencode.<BR>\n~<BR>\nMit dem Code 912 kannst Du Dir die L\195\182sung anzeigen lassen. M\195\182chtest Du das wirklich?<BR>\n<BR>\n", {PocketPC = 1}),
      Media = zmediaHilfe,
      Buttons = {
        "Ja",
        "neuer Versuch"
      },
      Callback = cartMighlaTeil1v3.MsgBoxCBFuncs.MsgBoxCB194
    })
  end
end
return cartMighlaTeil1v3
