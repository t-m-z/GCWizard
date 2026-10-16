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
        [50579] = string.char(156),
        [50593] = string.char(154),
        [50622] = string.char(158),
        [50578] = string.char(140),
        [50592] = string.char(138),
        [50616] = string.char(159),
        [50621] = string.char(142),
        [14844588] = string.char(128)
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
    elseif c == 196 or c == 197 then
      i = i + 1
      if l >= i then
        local index = c * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    elseif c >= 198 and c <= 223 then
      i = i + 1
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
  elseif WWB_device == "WhereYouGo" or WWB_device == "OpenWIG" then
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
cartDieOlsenBande = Wherigo.ZCartridge()
cartDieOlsenBande.MsgBoxCBFuncs = {}
zmediaanrufer_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaanrufer_64.Id = "608b4fe1c8984d923f7705e4ada00a90"
zmediaanrufer_64.Name = "anrufer_64"
zmediaanrufer_64.AltText = ""
zmediaanrufer_64.Resources = {
  {
    Type = "jpg",
    Filename = "anrufer_64.jpg",
    Directives = {}
  }
}
zmediaApotheker_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaApotheker_64.Id = "1fbebd3c631116247d44d54959476d3a"
zmediaApotheker_64.Name = "Apotheker_64"
zmediaApotheker_64.AltText = ""
zmediaApotheker_64.Resources = {
  {
    Type = "jpg",
    Filename = "Apotheker_64.jpg",
    Directives = {}
  }
}
zmediaApotheke_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaApotheke_64.Id = "df5d81a1d0a74268e988c1e70d26221c"
zmediaApotheke_64.Name = "Apotheke_64"
zmediaApotheke_64.AltText = ""
zmediaApotheke_64.Resources = {
  {
    Type = "jpg",
    Filename = "apotheke_64.jpg",
    Directives = {}
  }
}
zmediaAuto_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaAuto_32.Id = "4024f2ee631f48eeef60f3a4ddfabe60"
zmediaAuto_32.Name = "Auto_32"
zmediaAuto_32.AltText = ""
zmediaAuto_32.Resources = {
  {
    Type = "jpg",
    Filename = "Auto_32.jpg",
    Directives = {}
  }
}
zmediaAuto_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaAuto_64.Id = "bfa51d5bf45c09f211d756bb830f03e6"
zmediaAuto_64.Name = "Auto_64"
zmediaAuto_64.AltText = ""
zmediaAuto_64.Resources = {
  {
    Type = "jpg",
    Filename = "Auto_64_smart.jpg",
    Directives = {}
  }
}
zmediaBahnhof_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBahnhof_64.Id = "6a5ce6a902d1960e554cfe3d3822b1e8"
zmediaBahnhof_64.Name = "Bahnhof_64"
zmediaBahnhof_64.AltText = ""
zmediaBahnhof_64.Resources = {
  {
    Type = "jpg",
    Filename = "bahnhof_64.jpg",
    Directives = {}
  }
}
zmediabatterie_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediabatterie_64.Id = "7803f0d3c5ab6c9c07315b40f1a999a4"
zmediabatterie_64.Name = "batterie_64"
zmediabatterie_64.AltText = ""
zmediabatterie_64.Resources = {
  {
    Type = "jpg",
    Filename = "Batterie_64.jpg",
    Directives = {}
  }
}
zmediaBenny_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBenny_32.Id = "20c6109e4f78d816699bb73d9c6458e2"
zmediaBenny_32.Name = "Benny_32"
zmediaBenny_32.AltText = ""
zmediaBenny_32.Resources = {
  {
    Type = "jpg",
    Filename = "Benny_32.jpg",
    Directives = {}
  }
}
zmediaBenny_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBenny_64.Id = "413913112165179a9c8c4f0831afba18"
zmediaBenny_64.Name = "Benny_64"
zmediaBenny_64.AltText = ""
zmediaBenny_64.Resources = {
  {
    Type = "jpg",
    Filename = "Benny_64_smart.jpg",
    Directives = {}
  }
}
zmediaBildzeitung_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBildzeitung_64.Id = "2f381a8f65317a6710e7316a8eb3ca01"
zmediaBildzeitung_64.Name = "Bildzeitung_64"
zmediaBildzeitung_64.AltText = ""
zmediaBildzeitung_64.Resources = {
  {
    Type = "jpg",
    Filename = "Bild_64_Smart.jpg",
    Directives = {}
  }
}
zmediablumendraht_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediablumendraht_64.Id = "1c7cb2a4e1bda95af2cfac1fbb3cd5f0"
zmediablumendraht_64.Name = "blumendraht_64"
zmediablumendraht_64.AltText = ""
zmediablumendraht_64.Resources = {
  {
    Type = "jpg",
    Filename = "Wickeldraht_64.jpg",
    Directives = {}
  }
}
zmediaBrief_Baron = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBrief_Baron.Id = "9e4d8138238aa14e9bac7a0c9cdaa3ff"
zmediaBrief_Baron.Name = "Brief_Baron"
zmediaBrief_Baron.AltText = ""
zmediaBrief_Baron.Resources = {
  {
    Type = "jpg",
    Filename = "Brief_Baron.jpg",
    Directives = {}
  }
}
zmediaBrief_Egon = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBrief_Egon.Id = "8ebfb833e778f883c792089b10521474"
zmediaBrief_Egon.Name = "Brief_Egon"
zmediaBrief_Egon.AltText = ""
zmediaBrief_Egon.Resources = {
  {
    Type = "jpg",
    Filename = "Brief_egon.jpg",
    Directives = {}
  }
}
zmediaBrot_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaBrot_64.Id = "595084e3c2f9b7b1fc1cecd04aae9b8c"
zmediaBrot_64.Name = "Brot_64"
zmediaBrot_64.AltText = ""
zmediaBrot_64.Resources = {
  {
    Type = "jpg",
    Filename = "baguette_64_smart.jpg",
    Directives = {}
  }
}
zmediabuegeleisen_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediabuegeleisen_64.Id = "282b6315a7886d044a9c0135e35dbacd"
zmediabuegeleisen_64.Name = "buegeleisen_64"
zmediabuegeleisen_64.AltText = ""
zmediabuegeleisen_64.Resources = {
  {
    Type = "jpg",
    Filename = "buegeleisen_64.jpg",
    Directives = {}
  }
}
zmediaDunkleGestalt_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaDunkleGestalt_64.Id = "b78035e595f26dfc4b1582bd40d9d306"
zmediaDunkleGestalt_64.Name = "DunkleGestalt_64"
zmediaDunkleGestalt_64.AltText = ""
zmediaDunkleGestalt_64.Resources = {
  {
    Type = "jpg",
    Filename = "dunkle-gestalt_64.jpg",
    Directives = {}
  }
}
zmediaEdding_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaEdding_64.Id = "a04b3bd795fea3affcc679ebfab69aad"
zmediaEdding_64.Name = "Edding_64"
zmediaEdding_64.AltText = ""
zmediaEdding_64.Resources = {
  {
    Type = "jpg",
    Filename = "Edding_64.jpg",
    Directives = {}
  }
}
zmediaEgon_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaEgon_32.Id = "114b93cc3ce85d58984509edec07d0c1"
zmediaEgon_32.Name = "Egon_32"
zmediaEgon_32.AltText = ""
zmediaEgon_32.Resources = {
  {
    Type = "jpg",
    Filename = "Egon_32.jpg",
    Directives = {}
  }
}
zmediaEgon_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaEgon_64.Id = "95aa07b5cd720b1818d70c5d0b59e518"
zmediaEgon_64.Name = "Egon_64"
zmediaEgon_64.AltText = ""
zmediaEgon_64.Resources = {
  {
    Type = "jpg",
    Filename = "Egon_64_smart.jpg",
    Directives = {}
  }
}
zmediaEinkaufsliste = Wherigo.ZMedia(cartDieOlsenBande)
zmediaEinkaufsliste.Id = "774c1cfa8865c02a4f1018c425941ac9"
zmediaEinkaufsliste.Name = "Einkaufsliste"
zmediaEinkaufsliste.AltText = ""
zmediaEinkaufsliste.Resources = {
  {
    Type = "jpg",
    Filename = "Einkaufsliste.jpg",
    Directives = {}
  }
}
zmediaEinkaufsliste_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaEinkaufsliste_32.Id = "28a889a999c18c26a27a8f74fc8d24fe"
zmediaEinkaufsliste_32.Name = "Einkaufsliste_32"
zmediaEinkaufsliste_32.AltText = ""
zmediaEinkaufsliste_32.Resources = {
  {
    Type = "jpg",
    Filename = "TestKlein.jpg",
    Directives = {}
  }
}
zmediaErpresser = Wherigo.ZMedia(cartDieOlsenBande)
zmediaErpresser.Id = "1b466f91c152a0348689dde9f3332b28"
zmediaErpresser.Name = "Erpresser"
zmediaErpresser.AltText = ""
zmediaErpresser.Resources = {
  {
    Type = "jpg",
    Filename = "Erpresser.jpg",
    Directives = {}
  }
}
zmediaFotobox_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaFotobox_32.Id = "30d9b729ad55840fed2de57c6c2b3ec1"
zmediaFotobox_32.Name = "Fotobox_32"
zmediaFotobox_32.AltText = ""
zmediaFotobox_32.Resources = {
  {
    Type = "jpg",
    Filename = "fotoautomat_32.jpg",
    Directives = {}
  }
}
zmediaFotobox_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaFotobox_64.Id = "93bd612bb778224ed3197fbaac619bfa"
zmediaFotobox_64.Name = "Fotobox_64"
zmediaFotobox_64.AltText = ""
zmediaFotobox_64.Resources = {
  {
    Type = "jpg",
    Filename = "fotoautomat_64_smart.jpg",
    Directives = {}
  }
}
zmediaGefaengnis_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaGefaengnis_32.Id = "1b5d9ec7fcaf73a2e859e60af9d8a1c7"
zmediaGefaengnis_32.Name = "Gefaengnis_32"
zmediaGefaengnis_32.AltText = ""
zmediaGefaengnis_32.Resources = {
  {
    Type = "jpg",
    Filename = "Staatgefaengnis_leipzig_32.jpg",
    Directives = {}
  }
}
zmediaGefaengnis_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaGefaengnis_64.Id = "b12a86e7005c062f499f7892a26df6f0"
zmediaGefaengnis_64.Name = "Gefaengnis_64"
zmediaGefaengnis_64.AltText = ""
zmediaGefaengnis_64.Resources = {
  {
    Type = "jpg",
    Filename = "Staatgefaengnis_leipzig_64.jpg",
    Directives = {}
  }
}
zmediaHackfleisch_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaHackfleisch_32.Id = "c3eb8d8ba68aac4c00221d49b1273df9"
zmediaHackfleisch_32.Name = "Hackfleisch_32"
zmediaHackfleisch_32.AltText = ""
zmediaHackfleisch_32.Resources = {
  {
    Type = "jpg",
    Filename = "hackfleisch_32.jpg",
    Directives = {}
  }
}
zmediaHackfleisch_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaHackfleisch_64.Id = "218f494af7c3696f4663fcd867ef6ec9"
zmediaHackfleisch_64.Name = "Hackfleisch_64"
zmediaHackfleisch_64.AltText = ""
zmediaHackfleisch_64.Resources = {
  {
    Type = "jpg",
    Filename = "hackfleisch_64_smart.jpg",
    Directives = {}
  }
}
zmediaHome_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaHome_32.Id = "f81f69dab26cfcdbbfa4f1ab55188a74"
zmediaHome_32.Name = "Home_32"
zmediaHome_32.AltText = ""
zmediaHome_32.Resources = {
  {
    Type = "jpg",
    Filename = "Home_32.jpg",
    Directives = {}
  }
}
zmediaHome_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaHome_64.Id = "b39612ea8d56c72be2239fcf6ff541db"
zmediaHome_64.Name = "Home_64"
zmediaHome_64.AltText = ""
zmediaHome_64.Resources = {
  {
    Type = "jpg",
    Filename = "Home_64_smart.jpg",
    Directives = {}
  }
}
zmediaHund = Wherigo.ZMedia(cartDieOlsenBande)
zmediaHund.Id = "d1bd50562ddd7b1fa3b6663c2f80d646"
zmediaHund.Name = "Hund"
zmediaHund.AltText = ""
zmediaHund.Resources = {
  {
    Type = "jpg",
    Filename = "dobermann.jpg",
    Directives = {}
  }
}
zmediaKarte = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKarte.Id = "6cca9ce5cf5e2731ff01428d651a6523"
zmediaKarte.Name = "Karte"
zmediaKarte.AltText = ""
zmediaKarte.Resources = {
  {
    Type = "jpg",
    Filename = "Karte.jpg",
    Directives = {}
  }
}
zmediaKarte1 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKarte1.Id = "96dff4658e12b3518b2d558a59ac65b0"
zmediaKarte1.Name = "Karte1"
zmediaKarte1.AltText = ""
zmediaKarte1.Resources = {
  {
    Type = "jpg",
    Filename = "Karte1.jpg",
    Directives = {}
  }
}
zmediaKjeld_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKjeld_32.Id = "ea0ae19cfbe4aec2c31ff84593a318cd"
zmediaKjeld_32.Name = "Kjeld_32"
zmediaKjeld_32.AltText = ""
zmediaKjeld_32.Resources = {
  {
    Type = "jpg",
    Filename = "Kjeld_32.jpg",
    Directives = {}
  }
}
zmediaKjeld_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKjeld_64.Id = "e1dd00a2349719b55a6ab652cf98739d"
zmediaKjeld_64.Name = "Kjeld_64"
zmediaKjeld_64.AltText = ""
zmediaKjeld_64.Resources = {
  {
    Type = "jpg",
    Filename = "Kjeld_64_smart.jpg",
    Directives = {}
  }
}
zmediaKoenigskette = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKoenigskette.Id = "560d683ca0904ae352fc8d8d23954f95"
zmediaKoenigskette.Name = "Koenigskette"
zmediaKoenigskette.AltText = ""
zmediaKoenigskette.Resources = {
  {
    Type = "jpg",
    Filename = "Koenigskette_2301.jpg",
    Directives = {}
  }
}
zmediakraemerladen_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediakraemerladen_64.Id = "9ea35e313f764676bd6e57f9778cde7d"
zmediakraemerladen_64.Name = "kraemerladen_64"
zmediakraemerladen_64.AltText = ""
zmediakraemerladen_64.Resources = {
  {
    Type = "jpg",
    Filename = "einkaufskorb_64.jpg",
    Directives = {}
  }
}
zmediaKreamer_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKreamer_32.Id = "6da883cc96819e4601154be49746e81c"
zmediaKreamer_32.Name = "Kreamer_32"
zmediaKreamer_32.AltText = ""
zmediaKreamer_32.Resources = {
  {
    Type = "jpg",
    Filename = "Kraemer_32.jpg",
    Directives = {}
  }
}
zmediaKreamer_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaKreamer_64.Id = "cb2fb87f53f583b0454ab57e921243b9"
zmediaKreamer_64.Name = "Kreamer_64"
zmediaKreamer_64.AltText = ""
zmediaKreamer_64.Resources = {
  {
    Type = "jpg",
    Filename = "Kraemer_64_smart.jpg",
    Directives = {}
  }
}
zmediaLampe_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaLampe_64.Id = "67adade6a960a9d88c84c319f322734a"
zmediaLampe_64.Name = "Lampe_64"
zmediaLampe_64.AltText = ""
zmediaLampe_64.Resources = {
  {
    Type = "jpg",
    Filename = "lampe_64.jpg",
    Directives = {}
  }
}
zmediaLogo_230 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaLogo_230.Id = "f9049999256b643b77aa7e96d93b48b0"
zmediaLogo_230.Name = "Logo_230"
zmediaLogo_230.AltText = ""
zmediaLogo_230.Resources = {
  {
    Type = "jpg",
    Filename = "olsenbande_230.jpg",
    Directives = {}
  }
}
zmediaLogo_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaLogo_32.Id = "cae29b56c5bb8cd68ae464ce4ec07379"
zmediaLogo_32.Name = "Logo_32"
zmediaLogo_32.AltText = ""
zmediaLogo_32.Resources = {
  {
    Type = "jpg",
    Filename = "olsenbande_32.jpg",
    Directives = {}
  }
}
zmediaLogo_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaLogo_64.Id = "562d279ba46d3012e2c10241aa038e5d"
zmediaLogo_64.Name = "Logo_64"
zmediaLogo_64.AltText = ""
zmediaLogo_64.Resources = {
  {
    Type = "jpg",
    Filename = "olsenbande_64_smart.jpg",
    Directives = {}
  }
}
zmediaLupe_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaLupe_32.Id = "494b4ef98f32cb5c7116a0dda96b73ff"
zmediaLupe_32.Name = "Lupe_32"
zmediaLupe_32.AltText = ""
zmediaLupe_32.Resources = {
  {
    Type = "jpg",
    Filename = "Lupe_32.jpg",
    Directives = {}
  }
}
zmediaLupe_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaLupe_64.Id = "7948f5dfccdcbd581de1c4237f53fb20"
zmediaLupe_64.Name = "Lupe_64"
zmediaLupe_64.AltText = ""
zmediaLupe_64.Resources = {
  {
    Type = "jpg",
    Filename = "Lupe_64.jpg",
    Directives = {}
  }
}
zmediaMetzgerei_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaMetzgerei_64.Id = "256f02bef3e1ddab85cd17644a7f3aa6"
zmediaMetzgerei_64.Name = "Metzgerei_64"
zmediaMetzgerei_64.AltText = ""
zmediaMetzgerei_64.Resources = {
  {
    Type = "jpg",
    Filename = "Metzgerei_64.jpg",
    Directives = {}
  }
}
zmediaMetzger_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaMetzger_64.Id = "267560933207098933141d7dc6fe716e"
zmediaMetzger_64.Name = "Metzger_64"
zmediaMetzger_64.AltText = ""
zmediaMetzger_64.Resources = {
  {
    Type = "jpg",
    Filename = "Metzger_64.jpg",
    Directives = {}
  }
}
zmediaNotizbuch = Wherigo.ZMedia(cartDieOlsenBande)
zmediaNotizbuch.Id = "24c8adecf8f7ab97fb6889701ecd3272"
zmediaNotizbuch.Name = "Notizbuch"
zmediaNotizbuch.AltText = ""
zmediaNotizbuch.Resources = {
  {
    Type = "jpg",
    Filename = "Notizbuch_64.jpg",
    Directives = {}
  }
}
zmediaNotizbuch_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaNotizbuch_32.Id = "907b917f25a7f0d284dd034ea2a78a1e"
zmediaNotizbuch_32.Name = "Notizbuch_32"
zmediaNotizbuch_32.AltText = ""
zmediaNotizbuch_32.Resources = {
  {
    Type = "jpg",
    Filename = "Notizbuch_32.jpg",
    Directives = {}
  }
}
zmediaOptiker_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaOptiker_64.Id = "ef1ceee2bb98ab0baea1dcacbaaca529"
zmediaOptiker_64.Name = "Optiker_64"
zmediaOptiker_64.AltText = ""
zmediaOptiker_64.Resources = {
  {
    Type = "jpg",
    Filename = "Optiker1_64.jpg",
    Directives = {}
  }
}
zmediaoptik_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaoptik_64.Id = "c92e0b832c1ac4b20229732d4a053ea7"
zmediaoptik_64.Name = "optik_64"
zmediaoptik_64.AltText = ""
zmediaoptik_64.Resources = {
  {
    Type = "jpg",
    Filename = "optiker_64.jpg",
    Directives = {}
  }
}
zmediaPapier_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPapier_64.Id = "e3ac7c2101969c2abe355d8553c2b9e7"
zmediaPapier_64.Name = "Papier_64"
zmediaPapier_64.AltText = ""
zmediaPapier_64.Resources = {
  {
    Type = "jpg",
    Filename = "Papier_64.jpg",
    Directives = {}
  }
}
zmediaParkplatz_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaParkplatz_32.Id = "b35c9aa838d48d084f84e6f45d24868b"
zmediaParkplatz_32.Name = "Parkplatz_32"
zmediaParkplatz_32.AltText = ""
zmediaParkplatz_32.Resources = {
  {
    Type = "jpg",
    Filename = "parkplatz_32.jpg",
    Directives = {}
  }
}
zmediaParkplatz_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaParkplatz_64.Id = "2db2db25688f18a2985a29802e018831"
zmediaParkplatz_64.Name = "Parkplatz_64"
zmediaParkplatz_64.AltText = ""
zmediaParkplatz_64.Resources = {
  {
    Type = "jpg",
    Filename = "parkplatz_64_smart.jpg",
    Directives = {}
  }
}
zmediaPassbilder = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPassbilder.Id = "d8429d5aad5cbfcc49f094b56a73b7f1"
zmediaPassbilder.Name = "Passbilder"
zmediaPassbilder.AltText = ""
zmediaPassbilder.Resources = {
  {
    Type = "jpg",
    Filename = "KjeldPassbild_gross.jpg",
    Directives = {}
  }
}
zmediaPassbilder_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPassbilder_32.Id = "9b2f2c25ca54b3e747805cf89c69f35c"
zmediaPassbilder_32.Name = "Passbilder_32"
zmediaPassbilder_32.AltText = ""
zmediaPassbilder_32.Resources = {
  {
    Type = "jpg",
    Filename = "KjeldPassbild_32.jpg",
    Directives = {}
  }
}
zmediaPassbilder_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPassbilder_64.Id = "d4a569aadfb2d5663a97be16e79cb625"
zmediaPassbilder_64.Name = "Passbilder_64"
zmediaPassbilder_64.AltText = ""
zmediaPassbilder_64.Resources = {
  {
    Type = "jpg",
    Filename = "KjeldPassbild_64_smart.jpg",
    Directives = {}
  }
}
zmediaPassbilder_bild = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPassbilder_bild.Id = "d6eb38eaa364ab105b9da234b4cbd7c6"
zmediaPassbilder_bild.Name = "Passbilder_bild"
zmediaPassbilder_bild.AltText = ""
zmediaPassbilder_bild.Resources = {
  {
    Type = "jpg",
    Filename = "Passbild_bild.jpg",
    Directives = {}
  }
}
zmediaPinzette_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPinzette_64.Id = "66240bfdae7612f9e79946041905790d"
zmediaPinzette_64.Name = "Pinzette_64"
zmediaPinzette_64.AltText = ""
zmediaPinzette_64.Resources = {
  {
    Type = "jpg",
    Filename = "Pinzette_64.jpg",
    Directives = {}
  }
}
zmediaPlan_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPlan_32.Id = "b325bce1c2efdbd10f8a3ce56b48fe6f"
zmediaPlan_32.Name = "Plan_32"
zmediaPlan_32.AltText = ""
zmediaPlan_32.Resources = {
  {
    Type = "jpg",
    Filename = "plan_32.jpg",
    Directives = {}
  }
}
zmediaPlan_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPlan_64.Id = "ad0715afa4db0517c7213e1a9ff12814"
zmediaPlan_64.Name = "Plan_64"
zmediaPlan_64.AltText = ""
zmediaPlan_64.Resources = {
  {
    Type = "jpg",
    Filename = "plan_64_smart.jpg",
    Directives = {}
  }
}
zmediaPlan_schmieden = Wherigo.ZMedia(cartDieOlsenBande)
zmediaPlan_schmieden.Id = "5575ae85ad863fcb8c1f6823b597a7f7"
zmediaPlan_schmieden.Name = "Plan_schmieden"
zmediaPlan_schmieden.AltText = ""
zmediaPlan_schmieden.Resources = {
  {
    Type = "jpg",
    Filename = "AmTisch.jpg",
    Directives = {}
  }
}
zmediaSafe_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSafe_32.Id = "7b221757748408ffc93e0db68c3613c2"
zmediaSafe_32.Name = "Safe_32"
zmediaSafe_32.AltText = ""
zmediaSafe_32.Resources = {
  {
    Type = "jpg",
    Filename = "Safe_32.jpg",
    Directives = {}
  }
}
zmediaSafe_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSafe_64.Id = "3ef04aa7f92f5358a487678c599b6e1a"
zmediaSafe_64.Name = "Safe_64"
zmediaSafe_64.AltText = ""
zmediaSafe_64.Resources = {
  {
    Type = "jpg",
    Filename = "Safe_64_smart.jpg",
    Directives = {}
  }
}
zmediaSchere_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSchere_64.Id = "4ab77b8a3b1c9aa1b11f3a835cda2ab1"
zmediaSchere_64.Name = "Schere_64"
zmediaSchere_64.AltText = ""
zmediaSchere_64.Resources = {
  {
    Type = "jpg",
    Filename = "Schere_64.jpg",
    Directives = {}
  }
}
zmediaSchlaftabletten_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSchlaftabletten_32.Id = "2c094e0840da066d416e37e8d1226453"
zmediaSchlaftabletten_32.Name = "Schlaftabletten_32"
zmediaSchlaftabletten_32.AltText = ""
zmediaSchlaftabletten_32.Resources = {
  {
    Type = "jpg",
    Filename = "tabletten_32.jpg",
    Directives = {}
  }
}
zmediaSchlaftabletten_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSchlaftabletten_64.Id = "d468542456e67dc22e74ba8e379829c3"
zmediaSchlaftabletten_64.Name = "Schlaftabletten_64"
zmediaSchlaftabletten_64.AltText = ""
zmediaSchlaftabletten_64.Resources = {
  {
    Type = "jpg",
    Filename = "tabletten64_smart.jpg",
    Directives = {}
  }
}
zmediaSchwarzerWagen1_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSchwarzerWagen1_64.Id = "320d8779567574c9f8ac1660e0d8aabd"
zmediaSchwarzerWagen1_64.Name = "SchwarzerWagen1_64"
zmediaSchwarzerWagen1_64.AltText = ""
zmediaSchwarzerWagen1_64.Resources = {
  {
    Type = "jpg",
    Filename = "Wagen1_64.jpg",
    Directives = {}
  }
}
zmediaSchwarzerWagen_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaSchwarzerWagen_64.Id = "b102bf177618210cf20da798259c4c77"
zmediaSchwarzerWagen_64.Name = "SchwarzerWagen_64"
zmediaSchwarzerWagen_64.AltText = ""
zmediaSchwarzerWagen_64.Resources = {
  {
    Type = "jpg",
    Filename = "Wagen_64.jpg",
    Directives = {}
  }
}
zmediaStage_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaStage_32.Id = "ba5d0ee44d078f2dd295e2547e6e4329"
zmediaStage_32.Name = "Stage_32"
zmediaStage_32.AltText = ""
zmediaStage_32.Resources = {
  {
    Type = "jpg",
    Filename = "Stage_32.jpg",
    Directives = {}
  }
}
zmediaStage_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaStage_64.Id = "729f286b08dd4bc9d5ded64e35918536"
zmediaStage_64.Name = "Stage_64"
zmediaStage_64.AltText = ""
zmediaStage_64.Resources = {
  {
    Type = "jpg",
    Filename = "Stage_64_smart.jpg",
    Directives = {}
  }
}
zmediaStehtoskop_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaStehtoskop_32.Id = "4a4bd8dd21f608fb3b1ad3ab422636d9"
zmediaStehtoskop_32.Name = "Stehtoskop_32"
zmediaStehtoskop_32.AltText = ""
zmediaStehtoskop_32.Resources = {
  {
    Type = "jpg",
    Filename = "stethoskop_32.jpg",
    Directives = {}
  }
}
zmediaStethoskop_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaStethoskop_64.Id = "d84a5dda1d7f0e733e6f53efffb50c9c"
zmediaStethoskop_64.Name = "Stethoskop_64"
zmediaStethoskop_64.AltText = ""
zmediaStethoskop_64.Resources = {
  {
    Type = "jpg",
    Filename = "stethoskop_64.jpg",
    Directives = {}
  }
}
zmediaTelefon_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaTelefon_32.Id = "a2e03394b48dcff5d187f4359cf0f14e"
zmediaTelefon_32.Name = "Telefon_32"
zmediaTelefon_32.AltText = ""
zmediaTelefon_32.Resources = {
  {
    Type = "jpg",
    Filename = "telefon_32.jpg",
    Directives = {}
  }
}
zmediaTelefon_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaTelefon_64.Id = "522c2a92ea4e544ca40debc89da64ee6"
zmediaTelefon_64.Name = "Telefon_64"
zmediaTelefon_64.AltText = ""
zmediaTelefon_64.Resources = {
  {
    Type = "jpg",
    Filename = "telefon_64_smart.jpg",
    Directives = {}
  }
}
zmediatreppe_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediatreppe_64.Id = "c2a4a22d9118fc4c5d3db4204c138418"
zmediatreppe_64.Name = "treppe_64"
zmediatreppe_64.AltText = ""
zmediatreppe_64.Resources = {
  {
    Type = "jpg",
    Filename = "treppe_64.jpg",
    Directives = {}
  }
}
zmediaTresor_Aufgebrochen = Wherigo.ZMedia(cartDieOlsenBande)
zmediaTresor_Aufgebrochen.Id = "be4378c4d60fe880b991e51a29a4341b"
zmediaTresor_Aufgebrochen.Name = "Tresor_Aufgebrochen"
zmediaTresor_Aufgebrochen.AltText = ""
zmediaTresor_Aufgebrochen.Resources = {
  {
    Type = "jpg",
    Filename = "tresor-aufgebrochen_64.jpg",
    Directives = {}
  }
}
zmediaWerkzeugtasche_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaWerkzeugtasche_32.Id = "6dc60ea453d963570e341c69ce10334f"
zmediaWerkzeugtasche_32.Name = "Werkzeugtasche_32"
zmediaWerkzeugtasche_32.AltText = ""
zmediaWerkzeugtasche_32.Resources = {
  {
    Type = "jpg",
    Filename = "werkzeugtasche_32.jpg",
    Directives = {}
  }
}
zmediaWerkzeugtasche_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaWerkzeugtasche_64.Id = "1d2225a7c73c0820fe40730964dd289a"
zmediaWerkzeugtasche_64.Name = "Werkzeugtasche_64"
zmediaWerkzeugtasche_64.AltText = ""
zmediaWerkzeugtasche_64.Resources = {
  {
    Type = "jpg",
    Filename = "werkzeugtasche_64_smart.jpg",
    Directives = {}
  }
}
zmediaYvonne_32 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaYvonne_32.Id = "a7768fa1457ea12cf04d23a249edfd48"
zmediaYvonne_32.Name = "Yvonne_32"
zmediaYvonne_32.AltText = ""
zmediaYvonne_32.Resources = {
  {
    Type = "jpg",
    Filename = "Yvonne_32.jpg",
    Directives = {}
  }
}
zmediaYvonne_64 = Wherigo.ZMedia(cartDieOlsenBande)
zmediaYvonne_64.Id = "b9f81a7bc9e0205b6d1bb62b1d384c00"
zmediaYvonne_64.Name = "Yvonne_64"
zmediaYvonne_64.AltText = ""
zmediaYvonne_64.Resources = {
  {
    Type = "jpg",
    Filename = "Yvonne_64_smart.jpg",
    Directives = {}
  }
}
zmediaZeitungsartikel = Wherigo.ZMedia(cartDieOlsenBande)
zmediaZeitungsartikel.Id = "8b354d5f30d0da6b6087224ece2de960"
zmediaZeitungsartikel.Name = "Zeitungsartikel"
zmediaZeitungsartikel.AltText = ""
zmediaZeitungsartikel.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitungsartikel.jpg",
    Directives = {}
  }
}
cartDieOlsenBande.Id = "6c373957-1ca3-4d09-8249-ef8a5e5c3135"
cartDieOlsenBande.Name = "Die Olsen Bande"
cartDieOlsenBande.Activity = "Geocache"
cartDieOlsenBande.Version = "1.3"
cartDieOlsenBande.Company = ""
cartDieOlsenBande.Author = "lindolf und Bachgassenbande"
cartDieOlsenBande.TargetDevice = "PocketPC"
cartDieOlsenBande.TargetDeviceVersion = "0"
cartDieOlsenBande.BuilderVersion = "WWB v0.3.2012.01.17.100333"
cartDieOlsenBande.StateId = "1"
cartDieOlsenBande.CountryId = "2"
cartDieOlsenBande.Description = "Die Olsenbande und der Stasischatz"
cartDieOlsenBande.StartingLocationDescription = ""
cartDieOlsenBande.Visible = true
cartDieOlsenBande.Complete = false
cartDieOlsenBande.UseLogging = true
cartDieOlsenBande.CreateDate = "11/6/2010 05:06:53 PM"
cartDieOlsenBande.PublishDate = "1/1/2001 12:00:00 AM"
cartDieOlsenBande.UpdateDate = "2/20/2012 05:32:51 PM"
cartDieOlsenBande.LastPlayedDate = "1/1/2001 12:00:00 AM"
cartDieOlsenBande.Media = zmediaLogo_64
cartDieOlsenBande.Icon = zmediaLogo_32
cartDieOlsenBande.StartingLocation = ZonePoint(51.339667, 12.371667, 0)
zoneApotheke = Wherigo.Zone(cartDieOlsenBande)
zoneApotheke.Id = "af7b32021aad2f2019c6294dce9a68da"
zoneApotheke.Name = "Apotheke"
zoneApotheke.DistanceRangeUOM = "Meters"
zoneApotheke.ProximityRangeUOM = "Meters"
zoneApotheke.ShowObjects = "OnEnter"
zoneApotheke.OutOfRangeName = ""
zoneApotheke.InRangeName = ""
zoneApotheke.Description = "Apotheke"
zoneApotheke.Visible = false
zoneApotheke.AllowSetPositionTo = false
zoneApotheke.Active = false
zoneApotheke.DistanceRange = Distance(-1, "meters")
zoneApotheke.ProximityRange = Distance(0, "meters")
zoneApotheke.Points = {
  ZonePoint(51.339720995018, 12.37926363945, 0),
  ZonePoint(51.339844987762, 12.37850189209, 0),
  ZonePoint(51.339563490237, 12.378367781639, 0),
  ZonePoint(51.339442847911, 12.37915635109, 0)
}
zoneApotheke.OriginalPoint = ZonePoint(51.339716666667, 12.378833333333, 0)
zoneApotheke.Media = zmediaApotheke_64
zoneBahnhof = Wherigo.Zone(cartDieOlsenBande)
zoneBahnhof.Id = "dcde1be396c10e06dfe0ba39c8425507"
zoneBahnhof.Name = "Bahnhof"
zoneBahnhof.DistanceRangeUOM = "Meters"
zoneBahnhof.ProximityRangeUOM = "Meters"
zoneBahnhof.ShowObjects = "OnEnter"
zoneBahnhof.OutOfRangeName = ""
zoneBahnhof.InRangeName = ""
zoneBahnhof.Description = "Bahnhof"
zoneBahnhof.Visible = false
zoneBahnhof.AllowSetPositionTo = false
zoneBahnhof.Active = false
zoneBahnhof.DistanceRange = Distance(-1, "meters")
zoneBahnhof.ProximityRange = Distance(0, "meters")
zoneBahnhof.Points = {
  ZonePoint(51.346067652232, 12.379360198975, 0),
  ZonePoint(51.344794370151, 12.378630638123, 0),
  ZonePoint(51.343440631455, 12.38184928894, 0),
  ZonePoint(51.34372210517, 12.383072376251, 0)
}
zoneBahnhof.OriginalPoint = ZonePoint(51.344526306257, 12.380454540253, 0)
zoneBahnhof.Media = zmediaBahnhof_64
zoneEinstieg = Wherigo.Zone(cartDieOlsenBande)
zoneEinstieg.Id = "c0443f3d4eee85ed9fe9c3c591bce7b3"
zoneEinstieg.Name = "Einstieg"
zoneEinstieg.DistanceRangeUOM = "Meters"
zoneEinstieg.ProximityRangeUOM = "Meters"
zoneEinstieg.ShowObjects = "OnEnter"
zoneEinstieg.OutOfRangeName = ""
zoneEinstieg.InRangeName = ""
zoneEinstieg.Description = ""
zoneEinstieg.Visible = false
zoneEinstieg.AllowSetPositionTo = false
zoneEinstieg.Active = false
zoneEinstieg.DistanceRange = Distance(-1, "meters")
zoneEinstieg.ProximityRange = Distance(0, "meters")
zoneEinstieg.Points = {
  ZonePoint(51.304416666667, 12.585564925311, 0),
  ZonePoint(51.304509310265, 12.585416666667, 0),
  ZonePoint(51.304416666667, 12.585268408023, 0),
  ZonePoint(51.304324023069, 12.585416666667, 0)
}
zoneEinstieg.OriginalPoint = ZonePoint(51.304416666667, 12.585416666667, 0)
zoneEinstieg2 = Wherigo.Zone(cartDieOlsenBande)
zoneEinstieg2.Id = "92fa70062c20998d1215577c12b53f73"
zoneEinstieg2.Name = "Einstieg2"
zoneEinstieg2.DistanceRangeUOM = "Meters"
zoneEinstieg2.ProximityRangeUOM = "Meters"
zoneEinstieg2.ShowObjects = "OnEnter"
zoneEinstieg2.OutOfRangeName = ""
zoneEinstieg2.InRangeName = ""
zoneEinstieg2.Description = ""
zoneEinstieg2.Visible = false
zoneEinstieg2.AllowSetPositionTo = false
zoneEinstieg2.Active = false
zoneEinstieg2.DistanceRange = Distance(-1, "meters")
zoneEinstieg2.ProximityRange = Distance(0, "meters")
zoneEinstieg2.Points = {
  ZonePoint(51.305601480791, 12.585272380121, 0),
  ZonePoint(51.305601480791, 12.585160953213, 0),
  ZonePoint(51.305531852543, 12.585160953213, 0),
  ZonePoint(51.305531852543, 12.585272380121, 0)
}
zoneEinstieg2.OriginalPoint = ZonePoint(51.305566666667, 12.585216666667, 0)
zoneEinstieg3 = Wherigo.Zone(cartDieOlsenBande)
zoneEinstieg3.Id = "cc7d43e6cb0d7e53d699fe50a7b3609d"
zoneEinstieg3.Name = "Einstieg3"
zoneEinstieg3.DistanceRangeUOM = "Meters"
zoneEinstieg3.ProximityRangeUOM = "Meters"
zoneEinstieg3.ShowObjects = "OnEnter"
zoneEinstieg3.OutOfRangeName = ""
zoneEinstieg3.InRangeName = ""
zoneEinstieg3.Description = ""
zoneEinstieg3.Visible = false
zoneEinstieg3.AllowSetPositionTo = false
zoneEinstieg3.Active = false
zoneEinstieg3.DistanceRange = Distance(-1, "meters")
zoneEinstieg3.ProximityRange = Distance(0, "meters")
zoneEinstieg3.Points = {
  ZonePoint(51.30375, 12.58907087858, 0),
  ZonePoint(51.30378868236, 12.589045237171, 0),
  ZonePoint(51.303804705118, 12.588983333333, 0),
  ZonePoint(51.30378868236, 12.588921429496, 0),
  ZonePoint(51.30375, 12.588895788087, 0),
  ZonePoint(51.30371131764, 12.588921429496, 0),
  ZonePoint(51.303695294882, 12.588983333333, 0),
  ZonePoint(51.30371131764, 12.589045237171, 0)
}
zoneEinstieg3.OriginalPoint = ZonePoint(51.30375, 12.588983333333, 0)
zoneEinstieg4 = Wherigo.Zone(cartDieOlsenBande)
zoneEinstieg4.Id = "fe3dea4ae5411208fafd5a979a8dd6e2"
zoneEinstieg4.Name = "Einstieg4"
zoneEinstieg4.DistanceRangeUOM = "Meters"
zoneEinstieg4.ProximityRangeUOM = "Meters"
zoneEinstieg4.ShowObjects = "OnEnter"
zoneEinstieg4.OutOfRangeName = ""
zoneEinstieg4.InRangeName = ""
zoneEinstieg4.Description = ""
zoneEinstieg4.Visible = false
zoneEinstieg4.AllowSetPositionTo = false
zoneEinstieg4.Active = false
zoneEinstieg4.DistanceRange = Distance(-1, "meters")
zoneEinstieg4.ProximityRange = Distance(0, "meters")
zoneEinstieg4.Points = {
  ZonePoint(51.304376313733, 12.593602115375, 0),
  ZonePoint(51.304376313733, 12.593464551292, 0),
  ZonePoint(51.304290352933, 12.593464551292, 0),
  ZonePoint(51.304290352933, 12.593602115375, 0)
}
zoneEinstieg4.OriginalPoint = ZonePoint(51.304333333333, 12.593533333333, 0)
zoneEinstieg5 = Wherigo.Zone(cartDieOlsenBande)
zoneEinstieg5.Id = "92bc11b64b1fd2f4cb813a69a168c039"
zoneEinstieg5.Name = "Einstieg5"
zoneEinstieg5.DistanceRangeUOM = "Meters"
zoneEinstieg5.ProximityRangeUOM = "Meters"
zoneEinstieg5.ShowObjects = "OnEnter"
zoneEinstieg5.OutOfRangeName = ""
zoneEinstieg5.InRangeName = ""
zoneEinstieg5.Description = ""
zoneEinstieg5.Visible = false
zoneEinstieg5.AllowSetPositionTo = false
zoneEinstieg5.Active = false
zoneEinstieg5.DistanceRange = Distance(-1, "meters")
zoneEinstieg5.ProximityRange = Distance(0, "meters")
zoneEinstieg5.Points = {
  ZonePoint(51.300783179266, 12.592509784625, 0),
  ZonePoint(51.300783179266, 12.592190215375, 0),
  ZonePoint(51.300583487401, 12.592190215375, 0),
  ZonePoint(51.300583487401, 12.592509784625, 0)
}
zoneEinstieg5.OriginalPoint = ZonePoint(51.300683333333, 12.59235, 0)
zoneFinal_Tresor = Wherigo.Zone(cartDieOlsenBande)
zoneFinal_Tresor.Id = "9ec2c0419ed41fdfef2d1faba0cbd725"
zoneFinal_Tresor.Name = "Final_Tresor"
zoneFinal_Tresor.DistanceRangeUOM = "Meters"
zoneFinal_Tresor.ProximityRangeUOM = "Meters"
zoneFinal_Tresor.ShowObjects = "OnEnter"
zoneFinal_Tresor.OutOfRangeName = ""
zoneFinal_Tresor.InRangeName = ""
zoneFinal_Tresor.Description = ""
zoneFinal_Tresor.Visible = false
zoneFinal_Tresor.AllowSetPositionTo = false
zoneFinal_Tresor.Active = false
zoneFinal_Tresor.DistanceRange = Distance(-1, "meters")
zoneFinal_Tresor.ProximityRange = Distance(0, "meters")
zoneFinal_Tresor.Points = {
  ZonePoint(51.300333333333, 12.587108273628, 0),
  ZonePoint(51.300565281157, 12.586954522176, 0),
  ZonePoint(51.300661357091, 12.586583333333, 0),
  ZonePoint(51.300565281157, 12.586212144491, 0),
  ZonePoint(51.300333333333, 12.586058393039, 0),
  ZonePoint(51.30010138551, 12.586212144491, 0),
  ZonePoint(51.300005309575, 12.586583333333, 0),
  ZonePoint(51.30010138551, 12.586954522176, 0)
}
zoneFinal_Tresor.OriginalPoint = ZonePoint(51.300333333333, 12.586583333333, 0)
zoneFleischer = Wherigo.Zone(cartDieOlsenBande)
zoneFleischer.Id = "1d1b2461c7aafc56883048547d9c362c"
zoneFleischer.Name = "Fleischer"
zoneFleischer.DistanceRangeUOM = "Meters"
zoneFleischer.ProximityRangeUOM = "Meters"
zoneFleischer.ShowObjects = "OnEnter"
zoneFleischer.OutOfRangeName = ""
zoneFleischer.InRangeName = ""
zoneFleischer.Description = "Fleischer"
zoneFleischer.Visible = false
zoneFleischer.AllowSetPositionTo = false
zoneFleischer.Active = false
zoneFleischer.DistanceRange = Distance(-1, "meters")
zoneFleischer.ProximityRange = Distance(0, "meters")
zoneFleischer.Points = {
  ZonePoint(51.341959515096, 12.378287315369, 0),
  ZonePoint(51.342001505931, 12.377607018117, 0),
  ZonePoint(51.341627765279, 12.377606034279, 0),
  ZonePoint(51.341651222415, 12.377943992615, 0),
  ZonePoint(51.341671328523, 12.37809419632, 0),
  ZonePoint(51.341755103877, 12.378196120262, 0)
}
zoneFleischer.OriginalPoint = ZonePoint(51.341731646793, 12.378035187721, 0)
zoneFleischer.Media = zmediaMetzgerei_64
zoneGeheimversteckt = Wherigo.Zone(cartDieOlsenBande)
zoneGeheimversteckt.Id = "82c3d298a4c5d08f2ab05e7e9f8b5903"
zoneGeheimversteckt.Name = "Geheimversteckt"
zoneGeheimversteckt.DistanceRangeUOM = "Meters"
zoneGeheimversteckt.ProximityRangeUOM = "Meters"
zoneGeheimversteckt.ShowObjects = "OnEnter"
zoneGeheimversteckt.OutOfRangeName = ""
zoneGeheimversteckt.InRangeName = ""
zoneGeheimversteckt.Description = ""
zoneGeheimversteckt.Visible = false
zoneGeheimversteckt.AllowSetPositionTo = false
zoneGeheimversteckt.Active = false
zoneGeheimversteckt.DistanceRange = Distance(-1, "meters")
zoneGeheimversteckt.ProximityRange = Distance(0, "meters")
zoneGeheimversteckt.Points = {
  ZonePoint(51.334853176967, 12.370648384094, 0),
  ZonePoint(51.334864907271, 12.370482087135, 0),
  ZonePoint(51.334602650487, 12.370519638062, 0),
  ZonePoint(51.334598461069, 12.370710074902, 0)
}
zoneGeheimversteckt.OriginalPoint = ZonePoint(51.334733333333, 12.370633333333, 0)
zoneGeheimversteckt.Media = zmediaLogo_64
zoneHunde = Wherigo.Zone(cartDieOlsenBande)
zoneHunde.Id = "696d31c06c70452c13e300ea05834300"
zoneHunde.Name = "Hunde"
zoneHunde.DistanceRangeUOM = "Meters"
zoneHunde.ProximityRangeUOM = "Meters"
zoneHunde.ShowObjects = "OnEnter"
zoneHunde.OutOfRangeName = ""
zoneHunde.InRangeName = ""
zoneHunde.Description = ""
zoneHunde.Visible = false
zoneHunde.AllowSetPositionTo = false
zoneHunde.Active = false
zoneHunde.DistanceRange = Distance(-1, "meters")
zoneHunde.ProximityRange = Distance(0, "meters")
zoneHunde.Points = {
  ZonePoint(51.303655039007, 12.593550682068, 0),
  ZonePoint(51.303225751124, 12.592821121216, 0),
  ZonePoint(51.299898633887, 12.597885131836, 0),
  ZonePoint(51.300676771621, 12.598056793213, 0)
}
zoneHunde.OriginalPoint = ZonePoint(51.301803706332, 12.59539604187, 0)
zoneKraemerladen = Wherigo.Zone(cartDieOlsenBande)
zoneKraemerladen.Id = "8f9392e3c9286940134c1da9bd5d4a38"
zoneKraemerladen.Name = "Kraemerladen"
zoneKraemerladen.DistanceRangeUOM = "Meters"
zoneKraemerladen.ProximityRangeUOM = "Meters"
zoneKraemerladen.ShowObjects = "OnEnter"
zoneKraemerladen.OutOfRangeName = ""
zoneKraemerladen.InRangeName = ""
zoneKraemerladen.Description = "Kraemerladen"
zoneKraemerladen.Visible = false
zoneKraemerladen.AllowSetPositionTo = false
zoneKraemerladen.Active = false
zoneKraemerladen.DistanceRange = Distance(-1, "meters")
zoneKraemerladen.ProximityRange = Distance(0, "meters")
zoneKraemerladen.Points = {
  ZonePoint(51.341584201993, 12.37858235836, 0),
  ZonePoint(51.341611010174, 12.378335595131, 0),
  ZonePoint(51.341513830444, 12.378040552139, 0),
  ZonePoint(51.341202183714, 12.378003001213, 0),
  ZonePoint(51.341192130558, 12.378603816032, 0)
}
zoneKraemerladen.OriginalPoint = ZonePoint(51.341403246363, 12.378158569336, 0)
zoneKraemerladen.Media = zmediakraemerladen_64
zoneN1 = Wherigo.Zone(cartDieOlsenBande)
zoneN1.Id = "46206491f56743b5863f872d03c8c6f0"
zoneN1.Name = "N1"
zoneN1.DistanceRangeUOM = "Meters"
zoneN1.ProximityRangeUOM = "Meters"
zoneN1.ShowObjects = "OnEnter"
zoneN1.OutOfRangeName = ""
zoneN1.InRangeName = ""
zoneN1.Description = ""
zoneN1.Visible = false
zoneN1.AllowSetPositionTo = false
zoneN1.Active = false
zoneN1.DistanceRange = Distance(-1, "meters")
zoneN1.ProximityRange = Distance(0, "meters")
zoneN1.Points = {
  ZonePoint(51.304996537762, 12.586947083473, 0),
  ZonePoint(51.305070319056, 12.58671104908, 0),
  ZonePoint(51.304996537762, 12.586458921433, 0),
  ZonePoint(51.304758424595, 12.586566209793, 0),
  ZonePoint(51.304698057681, 12.586963176727, 0),
  ZonePoint(51.304852328527, 12.587113380432, 0)
}
zoneN1.OriginalPoint = ZonePoint(51.304833333333, 12.5867, 0)
zoneN2 = Wherigo.Zone(cartDieOlsenBande)
zoneN2.Id = "c7b9b561fa75d9a25320bf07ec81afdc"
zoneN2.Name = "N2"
zoneN2.DistanceRangeUOM = "Meters"
zoneN2.ProximityRangeUOM = "Meters"
zoneN2.ShowObjects = "OnEnter"
zoneN2.OutOfRangeName = ""
zoneN2.InRangeName = ""
zoneN2.Description = ""
zoneN2.Visible = false
zoneN2.AllowSetPositionTo = false
zoneN2.Active = false
zoneN2.DistanceRange = Distance(-1, "meters")
zoneN2.ProximityRange = Distance(0, "meters")
zoneN2.Points = {
  ZonePoint(51.3057, 12.584972446265, 0),
  ZonePoint(51.305908753041, 12.584834069958, 0),
  ZonePoint(51.305995221382, 12.5845, 0),
  ZonePoint(51.305908753041, 12.584165930042, 0),
  ZonePoint(51.3057, 12.584027553735, 0),
  ZonePoint(51.305491246959, 12.584165930042, 0)
}
zoneN2.OriginalPoint = ZonePoint(51.3057, 12.5845, 0)
zoneN3 = Wherigo.Zone(cartDieOlsenBande)
zoneN3.Id = "de48828bc2d65724012ab4354e51233e"
zoneN3.Name = "N3"
zoneN3.DistanceRangeUOM = "Meters"
zoneN3.ProximityRangeUOM = "Meters"
zoneN3.ShowObjects = "OnEnter"
zoneN3.OutOfRangeName = ""
zoneN3.InRangeName = ""
zoneN3.Description = ""
zoneN3.Visible = false
zoneN3.AllowSetPositionTo = false
zoneN3.Active = false
zoneN3.DistanceRange = Distance(-1, "meters")
zoneN3.ProximityRange = Distance(0, "meters")
zoneN3.Points = {
  ZonePoint(51.304816666667, 12.592008273628, 0),
  ZonePoint(51.30504861449, 12.591854522176, 0),
  ZonePoint(51.305144690425, 12.591483333333, 0),
  ZonePoint(51.30504861449, 12.591112144491, 0),
  ZonePoint(51.304816666667, 12.590958393039, 0),
  ZonePoint(51.304584718843, 12.591112144491, 0),
  ZonePoint(51.304488642909, 12.591483333333, 0),
  ZonePoint(51.304584718843, 12.591854522176, 0)
}
zoneN3.OriginalPoint = ZonePoint(51.304816666667, 12.591483333333, 0)
zoneN4 = Wherigo.Zone(cartDieOlsenBande)
zoneN4.Id = "35e507a0470d0b8a891b8aecef3f8d0d"
zoneN4.Name = "N4"
zoneN4.DistanceRangeUOM = "Meters"
zoneN4.ProximityRangeUOM = "Meters"
zoneN4.ShowObjects = "OnEnter"
zoneN4.OutOfRangeName = ""
zoneN4.InRangeName = ""
zoneN4.Description = ""
zoneN4.Visible = false
zoneN4.AllowSetPositionTo = false
zoneN4.Active = false
zoneN4.DistanceRange = Distance(-1, "meters")
zoneN4.ProximityRange = Distance(0, "meters")
zoneN4.Points = {
  ZonePoint(51.302433333333, 12.597291606961, 0),
  ZonePoint(51.302665281157, 12.597137855509, 0),
  ZonePoint(51.302761357091, 12.596766666667, 0),
  ZonePoint(51.302665281157, 12.596395477824, 0),
  ZonePoint(51.302433333333, 12.596241726372, 0),
  ZonePoint(51.30220138551, 12.596395477824, 0),
  ZonePoint(51.302105309575, 12.596766666667, 0),
  ZonePoint(51.30220138551, 12.597137855509, 0)
}
zoneN4.OriginalPoint = ZonePoint(51.302433333333, 12.596766666667, 0)
zoneN5 = Wherigo.Zone(cartDieOlsenBande)
zoneN5.Id = "0f6a295c5728870ad2b9654aab5bac3c"
zoneN5.Name = "N5"
zoneN5.DistanceRangeUOM = "Meters"
zoneN5.ProximityRangeUOM = "Meters"
zoneN5.ShowObjects = "OnEnter"
zoneN5.OutOfRangeName = ""
zoneN5.InRangeName = ""
zoneN5.Description = ""
zoneN5.Visible = false
zoneN5.AllowSetPositionTo = false
zoneN5.Active = false
zoneN5.DistanceRange = Distance(-1, "meters")
zoneN5.ProximityRange = Distance(0, "meters")
zoneN5.Points = {
  ZonePoint(51.299, 12.591324940295, 0),
  ZonePoint(51.299231947824, 12.591171188842, 0),
  ZonePoint(51.299328023758, 12.5908, 0),
  ZonePoint(51.299231947824, 12.590428811158, 0),
  ZonePoint(51.299, 12.590275059705, 0),
  ZonePoint(51.298768052176, 12.590428811158, 0),
  ZonePoint(51.298671976242, 12.5908, 0),
  ZonePoint(51.298768052176, 12.591171188842, 0)
}
zoneN5.OriginalPoint = ZonePoint(51.299, 12.5908, 0)
zoneOptiker = Wherigo.Zone(cartDieOlsenBande)
zoneOptiker.Id = "1d1cdfa0b1ad3211c4ff57c449fa95a3"
zoneOptiker.Name = "Optiker"
zoneOptiker.DistanceRangeUOM = "Meters"
zoneOptiker.ProximityRangeUOM = "Meters"
zoneOptiker.ShowObjects = "OnEnter"
zoneOptiker.OutOfRangeName = ""
zoneOptiker.InRangeName = ""
zoneOptiker.Description = "Optiker"
zoneOptiker.Visible = false
zoneOptiker.AllowSetPositionTo = false
zoneOptiker.Active = false
zoneOptiker.DistanceRange = Distance(-1, "meters")
zoneOptiker.ProximityRange = Distance(0, "meters")
zoneOptiker.Points = {
  ZonePoint(51.341816666667, 12.374513848332, 0),
  ZonePoint(51.342266630669, 12.373816666667, 0),
  ZonePoint(51.341816666667, 12.373119485001, 0),
  ZonePoint(51.341366702664, 12.373816666667, 0)
}
zoneOptiker.OriginalPoint = ZonePoint(51.341816666667, 12.373816666667, 0)
zoneOptiker.Media = zmediaoptik_64
zoneParkplatz = Wherigo.Zone(cartDieOlsenBande)
zoneParkplatz.Id = "f127ede966381ea2d46b04f4c235bd93"
zoneParkplatz.Name = "Parkplatz"
zoneParkplatz.DistanceRangeUOM = "Meters"
zoneParkplatz.ProximityRangeUOM = "Meters"
zoneParkplatz.ShowObjects = "OnEnter"
zoneParkplatz.OutOfRangeName = ""
zoneParkplatz.InRangeName = ""
zoneParkplatz.Description = WWB_multiplatform_string("Parken gegen Gebuehr m\195\182glich.")
zoneParkplatz.Visible = false
zoneParkplatz.AllowSetPositionTo = false
zoneParkplatz.Active = false
zoneParkplatz.DistanceRange = Distance(-1, "meters")
zoneParkplatz.ProximityRange = Distance(0, "meters")
zoneParkplatz.Points = {
  ZonePoint(51.339868445811, 12.373142838478, 0),
  ZonePoint(51.339814827396, 12.372112870216, 0),
  ZonePoint(51.339456252629, 12.372225522995, 0),
  ZonePoint(51.339503169113, 12.373260855675, 0)
}
zoneParkplatz.OriginalPoint = ZonePoint(51.339647269443, 12.372751235962, 0)
zoneParkplatz.Media = zmediaParkplatz_64
zoneSammelpunkt = Wherigo.Zone(cartDieOlsenBande)
zoneSammelpunkt.Id = "7479b1dc611d32599a29e00887205413"
zoneSammelpunkt.Name = "Sammelpunkt"
zoneSammelpunkt.DistanceRangeUOM = "Meters"
zoneSammelpunkt.ProximityRangeUOM = "Meters"
zoneSammelpunkt.ShowObjects = "OnEnter"
zoneSammelpunkt.OutOfRangeName = ""
zoneSammelpunkt.InRangeName = ""
zoneSammelpunkt.Description = ""
zoneSammelpunkt.Visible = false
zoneSammelpunkt.AllowSetPositionTo = false
zoneSammelpunkt.Active = false
zoneSammelpunkt.DistanceRange = Distance(-1, "meters")
zoneSammelpunkt.ProximityRange = Distance(0, "meters")
zoneSammelpunkt.Points = {
  ZonePoint(51.304741656016, 12.581142783165, 0),
  ZonePoint(51.304993184064, 12.580504417419, 0),
  ZonePoint(51.304057492751, 12.579689025879, 0),
  ZonePoint(51.303970294739, 12.581464648247, 0)
}
zoneSammelpunkt.OriginalPoint = ZonePoint(51.30475507088, 12.580697536469, 0)
zoneSammelpunkt.Media = zmediaLogo_64
zoneSchuhladen = Wherigo.Zone(cartDieOlsenBande)
zoneSchuhladen.Id = "127b1166eb6c5e1f920700e08de9f54e"
zoneSchuhladen.Name = "Schuhladen"
zoneSchuhladen.DistanceRangeUOM = "Meters"
zoneSchuhladen.ProximityRangeUOM = "Meters"
zoneSchuhladen.ShowObjects = "OnEnter"
zoneSchuhladen.OutOfRangeName = ""
zoneSchuhladen.InRangeName = ""
zoneSchuhladen.Description = "Schuhladen"
zoneSchuhladen.Visible = false
zoneSchuhladen.AllowSetPositionTo = false
zoneSchuhladen.Active = false
zoneSchuhladen.DistanceRange = Distance(-1, "meters")
zoneSchuhladen.ProximityRange = Distance(0, "meters")
zoneSchuhladen.Points = {
  ZonePoint(51.341933333333, 12.374313848332, 0),
  ZonePoint(51.342383297336, 12.373616666667, 0),
  ZonePoint(51.341933333333, 12.372919485001, 0),
  ZonePoint(51.34148336933, 12.373616666667, 0)
}
zoneSchuhladen.OriginalPoint = ZonePoint(51.341933333333, 12.373616666667, 0)
zoneSchuhladen.Media = zmediaStage_32
zoneStaatgefaengnis = Wherigo.Zone(cartDieOlsenBande)
zoneStaatgefaengnis.Id = "d14b5dfeaf670ab4bf1ea373d652825c"
zoneStaatgefaengnis.Name = "Staatgefaengnis"
zoneStaatgefaengnis.DistanceRangeUOM = "Meters"
zoneStaatgefaengnis.ProximityRangeUOM = "Meters"
zoneStaatgefaengnis.ShowObjects = "OnEnter"
zoneStaatgefaengnis.OutOfRangeName = ""
zoneStaatgefaengnis.InRangeName = ""
zoneStaatgefaengnis.Description = ""
zoneStaatgefaengnis.Visible = true
zoneStaatgefaengnis.AllowSetPositionTo = false
zoneStaatgefaengnis.Active = true
zoneStaatgefaengnis.DistanceRange = Distance(-1, "meters")
zoneStaatgefaengnis.ProximityRange = Distance(0, "meters")
zoneStaatgefaengnis.Points = {
  ZonePoint(51.334271685312, 12.372558116913, 0),
  ZonePoint(51.334144325924, 12.370530366898, 0),
  ZonePoint(51.332910932499, 12.370852231979, 0),
  ZonePoint(51.333018185419, 12.372697591782, 0)
}
zoneStaatgefaengnis.OriginalPoint = ZonePoint(51.333628181626, 12.371753454208, 0)
zoneStaatgefaengnis.Media = zmediaGefaengnis_64
zoneTresor = Wherigo.Zone(cartDieOlsenBande)
zoneTresor.Id = "c60082bf9a0857e6c030ffb68a09686e"
zoneTresor.Name = "Tresor"
zoneTresor.DistanceRangeUOM = "Meters"
zoneTresor.ProximityRangeUOM = "Meters"
zoneTresor.ShowObjects = "OnEnter"
zoneTresor.OutOfRangeName = ""
zoneTresor.InRangeName = ""
zoneTresor.Description = ""
zoneTresor.Visible = false
zoneTresor.AllowSetPositionTo = false
zoneTresor.Active = false
zoneTresor.DistanceRange = Distance(-1, "meters")
zoneTresor.ProximityRange = Distance(0, "meters")
zoneTresor.Points = {
  ZonePoint(51.307194404205, 12.583509416008, 0),
  ZonePoint(51.307281595953, 12.582854957008, 0),
  ZonePoint(51.306939535068, 12.582876414681, 0),
  ZonePoint(51.30686240334, 12.583498687172, 0)
}
zoneTresor.OriginalPoint = ZonePoint(51.307016666667, 12.58315, 0)
zoneWegpunkt = Wherigo.Zone(cartDieOlsenBande)
zoneWegpunkt.Id = "bea53bd89edc408efa48e6e304a494c5"
zoneWegpunkt.Name = "Wegpunkt"
zoneWegpunkt.DistanceRangeUOM = "Meters"
zoneWegpunkt.ProximityRangeUOM = "Meters"
zoneWegpunkt.ShowObjects = "OnEnter"
zoneWegpunkt.OutOfRangeName = ""
zoneWegpunkt.InRangeName = ""
zoneWegpunkt.Description = ""
zoneWegpunkt.Visible = false
zoneWegpunkt.AllowSetPositionTo = false
zoneWegpunkt.Active = false
zoneWegpunkt.DistanceRange = Distance(-1, "meters")
zoneWegpunkt.ProximityRange = Distance(0, "meters")
zoneWegpunkt.Points = {
  ZonePoint(51.305422110972, 12.582462108283, 0),
  ZonePoint(51.305422110972, 12.581804558384, 0),
  ZonePoint(51.305011222361, 12.581804558384, 0),
  ZonePoint(51.305011222361, 12.582462108283, 0)
}
zoneWegpunkt.OriginalPoint = ZonePoint(51.305216666667, 12.582133333333, 0)
zoneWohnung = Wherigo.Zone(cartDieOlsenBande)
zoneWohnung.Id = "471b6fe35c439e120f23b35b7134405e"
zoneWohnung.Name = "Wohnung"
zoneWohnung.DistanceRangeUOM = "Meters"
zoneWohnung.ProximityRangeUOM = "Meters"
zoneWohnung.ShowObjects = "OnEnter"
zoneWohnung.OutOfRangeName = ""
zoneWohnung.InRangeName = ""
zoneWohnung.Description = "Wohnung"
zoneWohnung.Visible = false
zoneWohnung.AllowSetPositionTo = false
zoneWohnung.Active = false
zoneWohnung.DistanceRange = Distance(-1, "meters")
zoneWohnung.ProximityRange = Distance(0, "meters")
zoneWohnung.Points = {
  ZonePoint(51.340934100874, 12.372370362282, 0),
  ZonePoint(51.34093999963, 12.371617096032, 0),
  ZonePoint(51.340303654435, 12.371617096032, 0),
  ZonePoint(51.340310792945, 12.372284531593, 0)
}
zoneWohnung.OriginalPoint = ZonePoint(51.340645905789, 12.372123599052, 0)
zoneWohnung.Media = zmediaHome_32
zcharacterKraemer = Wherigo.ZCharacter({Cartridge = cartDieOlsenBande, Container = zoneKraemerladen})
zcharacterKraemer.Id = "1c848fbe8a15cc21eedbcfc0c09da872"
zcharacterKraemer.Name = "Kraemer"
zcharacterKraemer.Gender = "Male"
zcharacterKraemer.Type = "NPC"
zcharacterKraemer.Description = ""
zcharacterKraemer.Visible = false
zcharacterKraemer.ObjectLocation = ZonePoint(51.341403246363, 12.378158569336, 0)
zcharacterKraemer.Media = zmediaKreamer_64
zcharacterKraemer.Icon = zmediaKreamer_32
zcharacterKraemer.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Batterie9V = Wherigo.ZCommand({
    Text = "Batterie 9V",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  BlattPapier = Wherigo.ZCommand({
    Text = "Blatt Papier",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Blumendraht = Wherigo.ZCommand({
    Text = "Blumendraht",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  DickerschwarzerEdding = Wherigo.ZCommand({
    Text = "Dicker schwarzer Edding",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  HackfleischMett = Wherigo.ZCommand({
    Text = "Hackfleisch/Mett",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Lampe = Wherigo.ZCommand({
    Text = "Lampe",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Lupe = Wherigo.ZCommand({
    Text = "Lupe",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Pinzette = Wherigo.ZCommand({
    Text = "Pinzette",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schere = Wherigo.ZCommand({
    Text = "Schere",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schlaftabletten = Wherigo.ZCommand({
    Text = "Schlaftabletten",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Stehtoskop = Wherigo.ZCommand({
    Text = "Stehtoskop",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterKraemer.Commands.Ansprechen.Id = "1b30929e903bcde353eb9758c9b6bad9"
zcharacterKraemer.Commands.Ansprechen.Custom = true
zcharacterKraemer.Commands.Ansprechen.WorksWithAll = true
zcharacterKraemer.Commands.Batterie9V.Id = "90e55c506a4e00b050e84c50a3c30265"
zcharacterKraemer.Commands.Batterie9V.Custom = true
zcharacterKraemer.Commands.Batterie9V.WorksWithAll = true
zcharacterKraemer.Commands.BlattPapier.Id = "a9692334e08491ce02d1e1bcf3dcf811"
zcharacterKraemer.Commands.BlattPapier.Custom = true
zcharacterKraemer.Commands.BlattPapier.WorksWithAll = true
zcharacterKraemer.Commands.Blumendraht.Id = "e9e620515127b85f27773551da4e8028"
zcharacterKraemer.Commands.Blumendraht.Custom = true
zcharacterKraemer.Commands.Blumendraht.WorksWithAll = true
zcharacterKraemer.Commands.DickerschwarzerEdding.Id = "ccb8624c612eb58d562897c97350bafb"
zcharacterKraemer.Commands.DickerschwarzerEdding.Custom = true
zcharacterKraemer.Commands.DickerschwarzerEdding.WorksWithAll = true
zcharacterKraemer.Commands.HackfleischMett.Id = "761617f518bad4925e81a8c4a40694f3"
zcharacterKraemer.Commands.HackfleischMett.Custom = true
zcharacterKraemer.Commands.HackfleischMett.WorksWithAll = true
zcharacterKraemer.Commands.Lampe.Id = "04acf662696c91bead8a87ee2648275a"
zcharacterKraemer.Commands.Lampe.Custom = true
zcharacterKraemer.Commands.Lampe.WorksWithAll = true
zcharacterKraemer.Commands.Lupe.Id = "02768f44760ea034a0465479f491074f"
zcharacterKraemer.Commands.Lupe.Custom = true
zcharacterKraemer.Commands.Lupe.WorksWithAll = true
zcharacterKraemer.Commands.Pinzette.Id = "dd21f7f7e4de1f260f84a04b441cb981"
zcharacterKraemer.Commands.Pinzette.Custom = true
zcharacterKraemer.Commands.Pinzette.WorksWithAll = true
zcharacterKraemer.Commands.Schere.Id = "f7386ea002609190625b4e3304b21ccb"
zcharacterKraemer.Commands.Schere.Custom = true
zcharacterKraemer.Commands.Schere.WorksWithAll = true
zcharacterKraemer.Commands.Schlaftabletten.Id = "01f12283dbe5282402e6164d4ec600e5"
zcharacterKraemer.Commands.Schlaftabletten.Custom = true
zcharacterKraemer.Commands.Schlaftabletten.WorksWithAll = true
zcharacterKraemer.Commands.Stehtoskop.Id = "ad0b5c13f5b5b7e9612cdc7438a62e71"
zcharacterKraemer.Commands.Stehtoskop.Custom = true
zcharacterKraemer.Commands.Stehtoskop.WorksWithAll = true
zitemCodekartenschablone = Wherigo.ZItem(cartDieOlsenBande)
zitemCodekartenschablone.Id = "c18895383dfbfeb937a1e3a31a77f11e"
zitemCodekartenschablone.Name = "Codekartenschablone"
zitemCodekartenschablone.Description = ""
zitemCodekartenschablone.Visible = false
zitemCodekartenschablone.Locked = false
zitemCodekartenschablone.Opened = false
zitemCodekartenschablone.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemCodekartenschablone.Media = zmediaKarte1
zitemEgonsEinkaufsliste = Wherigo.ZItem({Cartridge = cartDieOlsenBande, Container = zoneKraemerladen})
zitemEgonsEinkaufsliste.Id = "0697ad5c36322ceff164d757834b0397"
zitemEgonsEinkaufsliste.Name = "Egons Einkaufsliste"
zitemEgonsEinkaufsliste.Description = "Die Liste hat Egon per Telefon durchgegeben, einige Dinge sind noch zu organisieren."
zitemEgonsEinkaufsliste.Visible = false
zitemEgonsEinkaufsliste.Locked = false
zitemEgonsEinkaufsliste.Opened = false
zitemEgonsEinkaufsliste.ObjectLocation = ZonePoint(51.341403246363, 12.378158569336, 0)
zitemEgonsEinkaufsliste.Media = zmediaEinkaufsliste
zitemEgonsEinkaufsliste.Icon = zmediaEinkaufsliste_32
zitemHackfleischMett = Wherigo.ZItem(cartDieOlsenBande)
zitemHackfleischMett.Id = "e9529e7de9a1ab055cfb8faf5774b7f6"
zitemHackfleischMett.Name = "Hackfleisch/Mett"
zitemHackfleischMett.Description = ""
zitemHackfleischMett.Visible = true
zitemHackfleischMett.Locked = false
zitemHackfleischMett.Opened = false
zitemHackfleischMett.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemHackfleischMett.Media = zmediaHackfleisch_64
zitemHackfleischMett.Icon = zmediaHackfleisch_32
zitemHackfleischMett.Commands = {
  Benutzen = Wherigo.ZCommand({
    Text = "Benutzen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemHackfleischMett.Commands.Benutzen.Id = "b7ce5e3c44d2870d5a8cc540e245ce66"
zitemHackfleischMett.Commands.Benutzen.Custom = true
zitemHackfleischMett.Commands.Benutzen.WorksWithAll = true
zitemKoenigskette = Wherigo.ZItem(cartDieOlsenBande)
zitemKoenigskette.Id = "bc3ea8e9d9fac8be7c0c534d633ef390"
zitemKoenigskette.Name = "Koenigskette"
zitemKoenigskette.Description = ""
zitemKoenigskette.Visible = false
zitemKoenigskette.Locked = false
zitemKoenigskette.Opened = false
zitemKoenigskette.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemKoenigskette.Media = zmediaKoenigskette
zitemLupe = Wherigo.ZItem(cartDieOlsenBande)
zitemLupe.Id = "8a30028ba67d117c2d2ae8744ffdf773"
zitemLupe.Name = "Lupe"
zitemLupe.Description = ""
zitemLupe.Visible = true
zitemLupe.Locked = false
zitemLupe.Opened = false
zitemLupe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemLupe.Media = zmediaLupe_64
zitemLupe.Icon = zmediaLupe_32
zitemNotizbuch = Wherigo.ZItem({Cartridge = cartDieOlsenBande, Container = zoneSammelpunkt})
zitemNotizbuch.Id = "5a08999f0ee5cfc893b49552402cd139"
zitemNotizbuch.Name = "Notizbuch"
zitemNotizbuch.Description = ""
zitemNotizbuch.Visible = false
zitemNotizbuch.Locked = false
zitemNotizbuch.Opened = false
zitemNotizbuch.ObjectLocation = ZonePoint(51.30475507088, 12.580697536469, 0)
zitemNotizbuch.Media = zmediaNotizbuch
zitemNotizbuch.Icon = zmediaNotizbuch_32
zitemNotizbuch.Commands = {
  Lesen = Wherigo.ZCommand({
    Text = "Lesen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemNotizbuch.Commands.Lesen.Id = "fb555ce4f8c2dbe7d51b5a2d1cf210ba"
zitemNotizbuch.Commands.Lesen.Custom = true
zitemNotizbuch.Commands.Lesen.WorksWithAll = true
zitemPassbildautomat = Wherigo.ZItem({Cartridge = cartDieOlsenBande, Container = zoneBahnhof})
zitemPassbildautomat.Id = "1902d4fba4ca267db1f532cf88d7589e"
zitemPassbildautomat.Name = "Passbildautomat"
zitemPassbildautomat.Description = ""
zitemPassbildautomat.Visible = true
zitemPassbildautomat.Locked = false
zitemPassbildautomat.Opened = false
zitemPassbildautomat.ObjectLocation = ZonePoint(51.344526306257, 12.380454540253, 0)
zitemPassbildautomat.Media = zmediaFotobox_64
zitemPassbildautomat.Icon = zmediaFotobox_32
zitemPassbildautomat.Commands = {
  Benutzen = Wherigo.ZCommand({
    Text = "Benutzen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemPassbildautomat.Commands.Benutzen.Id = "868513e8d53d9d2c1fc06805a9b7182d"
zitemPassbildautomat.Commands.Benutzen.Custom = true
zitemPassbildautomat.Commands.Benutzen.WorksWithAll = true
zitemPassbilder = Wherigo.ZItem({Cartridge = cartDieOlsenBande, Container = zoneBahnhof})
zitemPassbilder.Id = "707ec7ff60acfd883b3c741df30a7926"
zitemPassbilder.Name = "Passbilder"
zitemPassbilder.Description = ""
zitemPassbilder.Visible = false
zitemPassbilder.Locked = false
zitemPassbilder.Opened = false
zitemPassbilder.ObjectLocation = ZonePoint(51.344526306257, 12.380454540253, 0)
zitemPassbilder.Media = zmediaPassbilder
zitemPassbilder.Icon = zmediaPassbilder_32
zitemSchlaftabletten = Wherigo.ZItem(cartDieOlsenBande)
zitemSchlaftabletten.Id = "d05daa598218323944219e9d2ef09f3e"
zitemSchlaftabletten.Name = "Schlaftabletten"
zitemSchlaftabletten.Description = ""
zitemSchlaftabletten.Visible = true
zitemSchlaftabletten.Locked = false
zitemSchlaftabletten.Opened = false
zitemSchlaftabletten.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemSchlaftabletten.Media = zmediaSchlaftabletten_64
zitemSchlaftabletten.Icon = zmediaSchlaftabletten_32
zitemSchlaftabletten.Commands = {
  Benutzen = Wherigo.ZCommand({
    Text = "Benutzen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemSchlaftabletten.Commands.Benutzen.Id = "f62c45439a67fab8a9cb3ceb0595ba2c"
zitemSchlaftabletten.Commands.Benutzen.Custom = true
zitemSchlaftabletten.Commands.Benutzen.WorksWithAll = true
zitemStethoskop = Wherigo.ZItem(cartDieOlsenBande)
zitemStethoskop.Id = "380de006be78d2b7c848b7695bb3f869"
zitemStethoskop.Name = "Stethoskop"
zitemStethoskop.Description = "Das Standartmodell"
zitemStethoskop.Visible = true
zitemStethoskop.Locked = false
zitemStethoskop.Opened = false
zitemStethoskop.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemStethoskop.Media = zmediaStethoskop_64
zitemStethoskop.Icon = zmediaStehtoskop_32
zitemWerkzeugtasche = Wherigo.ZItem({Cartridge = cartDieOlsenBande, Container = zoneKraemerladen})
zitemWerkzeugtasche.Id = "5399f0a55e8fc2ac164ec4d998f31ac1"
zitemWerkzeugtasche.Name = "Werkzeugtasche"
zitemWerkzeugtasche.Description = "Die Werkzeugtasche ist bereits gut gefuellt, fast alles was warscheinlich fuer den Bruch benoetigt wird ist bereits vorhanden."
zitemWerkzeugtasche.Visible = false
zitemWerkzeugtasche.Locked = false
zitemWerkzeugtasche.Opened = false
zitemWerkzeugtasche.ObjectLocation = ZonePoint(51.341403246363, 12.378158569336, 0)
zitemWerkzeugtasche.Media = zmediaWerkzeugtasche_64
zitemWerkzeugtasche.Icon = zmediaWerkzeugtasche_32
ztaskBesorgedieKette = Wherigo.ZTask(cartDieOlsenBande)
ztaskBesorgedieKette.Id = "9fddb8bda59403fe5e87c55b22d38899"
ztaskBesorgedieKette.Name = "Besorge die Kette"
ztaskBesorgedieKette.CorrectState = "NotCorrect"
ztaskBesorgedieKette.Description = ""
ztaskBesorgedieKette.Visible = false
ztaskBesorgedieKette.Active = false
ztaskBesorgedieKette.Complete = false
ztaskBesorgedieKette.Media = zmediaEinkaufsliste_32
ztaskBildZeitung = Wherigo.ZTask(cartDieOlsenBande)
ztaskBildZeitung.Id = "09d1e985e109884776ea38831a0d37d4"
ztaskBildZeitung.Name = "Bild Zeitung"
ztaskBildZeitung.CorrectState = "NotCorrect"
ztaskBildZeitung.Description = [[
Kaufe dir eine Bildzeitung.Kaufe auf keinen Fall<BR>
dieses dicke Ding vom Sonntag, das koennen wir nicht gebrauchen]]
ztaskBildZeitung.Visible = false
ztaskBildZeitung.Active = false
ztaskBildZeitung.Complete = false
ztaskBildZeitung.Media = zmediaEinkaufsliste_32
ztaskBiometrischesPassbild = Wherigo.ZTask(cartDieOlsenBande)
ztaskBiometrischesPassbild.Id = "a2eb234064e09065d5b503a7b429c591"
ztaskBiometrischesPassbild.Name = "Biometrisches Passbild"
ztaskBiometrischesPassbild.CorrectState = "NotCorrect"
ztaskBiometrischesPassbild.Description = [[
Mache ein biometrisches Passbild von dir (Virtuell).<BR>
Am Automat westlicher Eingang]]
ztaskBiometrischesPassbild.Visible = false
ztaskBiometrischesPassbild.Active = false
ztaskBiometrischesPassbild.Complete = false
ztaskBiometrischesPassbild.Media = zmediaEinkaufsliste_32
ztaskEgonabholen = Wherigo.ZTask(cartDieOlsenBande)
ztaskEgonabholen.Id = "909d4e0165ec456a030c8653f06bf3e8"
ztaskEgonabholen.Name = "Egon abholen"
ztaskEgonabholen.CorrectState = "NotCorrect"
ztaskEgonabholen.Description = "Beeile dich und hole Egon vom Gefaengnis ab."
ztaskEgonabholen.Visible = false
ztaskEgonabholen.Active = false
ztaskEgonabholen.Complete = false
ztaskEgonabholen.Media = zmediaEinkaufsliste_32
ztaskEsgehtweiter = Wherigo.ZTask(cartDieOlsenBande)
ztaskEsgehtweiter.Id = "9b7c1eb1def251c5f8219ab6902155a2"
ztaskEsgehtweiter.Name = "Es geht weiter"
ztaskEsgehtweiter.CorrectState = "None"
ztaskEsgehtweiter.Description = ""
ztaskEsgehtweiter.Visible = false
ztaskEsgehtweiter.Active = false
ztaskEsgehtweiter.Complete = false
ztaskEsgehtweiter.Media = zmediaEinkaufsliste_32
ztaskFindedenHinweis = Wherigo.ZTask(cartDieOlsenBande)
ztaskFindedenHinweis.Id = "1b7dbc1d27e8cb11a26746b5390916cf"
ztaskFindedenHinweis.Name = "Finde den Hinweis"
ztaskFindedenHinweis.CorrectState = "None"
ztaskFindedenHinweis.Description = ""
ztaskFindedenHinweis.Visible = false
ztaskFindedenHinweis.Active = false
ztaskFindedenHinweis.Complete = false
ztaskFindedenHinweis.Media = zmediaEinkaufsliste_32
ztaskGehezumBahnhof = Wherigo.ZTask(cartDieOlsenBande)
ztaskGehezumBahnhof.Id = "61a48e0fa5ef4708cd1f613210627524"
ztaskGehezumBahnhof.Name = "Gehe zum Bahnhof"
ztaskGehezumBahnhof.CorrectState = "NotCorrect"
ztaskGehezumBahnhof.Description = "Gehe zum Bahnhof und folge dann den Anweisungen."
ztaskGehezumBahnhof.Visible = false
ztaskGehezumBahnhof.Active = false
ztaskGehezumBahnhof.Complete = false
ztaskGehezumBahnhof.Media = zmediaEinkaufsliste_32
ztaskGehezumKraemerladen = Wherigo.ZTask(cartDieOlsenBande)
ztaskGehezumKraemerladen.Id = "868793c52cd885ab868245b4f552b147"
ztaskGehezumKraemerladen.Name = "Gehe zum Kraemerladen"
ztaskGehezumKraemerladen.CorrectState = "NotCorrect"
ztaskGehezumKraemerladen.Description = "Dort hat Egon Werkzeug und eine Notiz fuer dich hinterlegt."
ztaskGehezumKraemerladen.Visible = false
ztaskGehezumKraemerladen.Active = false
ztaskGehezumKraemerladen.Complete = false
ztaskGehezumKraemerladen.Media = zmediaEinkaufsliste_32
ztaskGehezumTreffpunkt = Wherigo.ZTask(cartDieOlsenBande)
ztaskGehezumTreffpunkt.Id = "f0977a9b739c4f0c181486e15c5297ee"
ztaskGehezumTreffpunkt.Name = "Gehe zum Treffpunkt"
ztaskGehezumTreffpunkt.CorrectState = "NotCorrect"
ztaskGehezumTreffpunkt.Description = "Du triffst dich mit Egon und Benny in der Wohnung."
ztaskGehezumTreffpunkt.Visible = false
ztaskGehezumTreffpunkt.Active = false
ztaskGehezumTreffpunkt.Complete = false
ztaskGehezumTreffpunkt.Media = zmediaEinkaufsliste_32
ztaskHackfleischMett = Wherigo.ZTask(cartDieOlsenBande)
ztaskHackfleischMett.Id = "7416246500e7f27eee4b341f07cff6df"
ztaskHackfleischMett.Name = "Hackfleisch/Mett"
ztaskHackfleischMett.CorrectState = "NotCorrect"
ztaskHackfleischMett.Description = "Kaufe beim Fleischer 500g Hackfleisch/Mett (Virtuell)."
ztaskHackfleischMett.Visible = false
ztaskHackfleischMett.Active = false
ztaskHackfleischMett.Complete = false
ztaskHackfleischMett.Media = zmediaEinkaufsliste_32
ztaskIndieWohnung = Wherigo.ZTask(cartDieOlsenBande)
ztaskIndieWohnung.Id = "2086dde69cf22a0a0ea7ad5313351465"
ztaskIndieWohnung.Name = "In die Wohnung"
ztaskIndieWohnung.CorrectState = "NotCorrect"
ztaskIndieWohnung.Description = "Egon hat einen Plan ausgearbeitet und will dir davon in der Wohnung erzaehlen."
ztaskIndieWohnung.Visible = false
ztaskIndieWohnung.Active = false
ztaskIndieWohnung.Complete = false
ztaskIndieWohnung.Media = zmediaEinkaufsliste_32
ztaskKompletieredieListe = Wherigo.ZTask(cartDieOlsenBande)
ztaskKompletieredieListe.Id = "e1946f3872b45f022c2c105c589d84ad"
ztaskKompletieredieListe.Name = "Kompletiere die Liste"
ztaskKompletieredieListe.CorrectState = "None"
ztaskKompletieredieListe.Description = "Versuche die fehlenden Teile von Egons Einkaufsliste zu besorgen."
ztaskKompletieredieListe.Visible = false
ztaskKompletieredieListe.Active = false
ztaskKompletieredieListe.Complete = false
ztaskKompletieredieListe.Media = zmediaEinkaufsliste_32
ztaskLoslos = Wherigo.ZTask(cartDieOlsenBande)
ztaskLoslos.Id = "1ed9acfc44d60d04d96e1fef60eec73d"
ztaskLoslos.Name = "Los los"
ztaskLoslos.CorrectState = "None"
ztaskLoslos.Description = ""
ztaskLoslos.Visible = false
ztaskLoslos.Active = false
ztaskLoslos.Complete = false
ztaskLoslos.Media = zmediaEinkaufsliste_32
ztaskLosschneller = Wherigo.ZTask(cartDieOlsenBande)
ztaskLosschneller.Id = "3ed27e967bd3d3185823aab0a2d08fd1"
ztaskLosschneller.Name = "Los schneller"
ztaskLosschneller.CorrectState = "None"
ztaskLosschneller.Description = ""
ztaskLosschneller.Visible = false
ztaskLosschneller.Active = false
ztaskLosschneller.Complete = false
ztaskLosschneller.Media = zmediaEinkaufsliste_32
ztaskLupe = Wherigo.ZTask(cartDieOlsenBande)
ztaskLupe.Id = "170a1b7ab4ace13d689a8bf68b338410"
ztaskLupe.Name = "Lupe"
ztaskLupe.CorrectState = "NotCorrect"
ztaskLupe.Description = "Gehe zum Optiker und besorge eine Lupe."
ztaskLupe.Visible = false
ztaskLupe.Active = false
ztaskLupe.Complete = false
ztaskLupe.Media = zmediaEinkaufsliste_32
ztaskNotizinFotobox = Wherigo.ZTask(cartDieOlsenBande)
ztaskNotizinFotobox.Id = "042de0720ade6a91ea4ab1a096d8afd3"
ztaskNotizinFotobox.Name = "Notiz in Fotobox"
ztaskNotizinFotobox.CorrectState = "NotCorrect"
ztaskNotizinFotobox.Description = "Notiere die die Notiz, die Egon in der Fotobox fuer dich hinterlassen hat. Die Nachricht befindet sich in der Fotobox am westlichen Eingang"
ztaskNotizinFotobox.Visible = false
ztaskNotizinFotobox.Active = false
ztaskNotizinFotobox.Complete = false
ztaskNotizinFotobox.Media = zmediaEinkaufsliste_32
ztaskPassnummer = Wherigo.ZTask(cartDieOlsenBande)
ztaskPassnummer.Id = "7edddbaa5b672798e4377876b50b0772"
ztaskPassnummer.Name = "Passnummer"
ztaskPassnummer.CorrectState = "NotCorrect"
ztaskPassnummer.Description = "Die Passnummer steht in der Fotobox. Im Automaten westlicher Eingang"
ztaskPassnummer.Visible = false
ztaskPassnummer.Active = false
ztaskPassnummer.Complete = false
ztaskPassnummer.Media = zmediaEinkaufsliste_32
ztaskSchlaftabletten = Wherigo.ZTask(cartDieOlsenBande)
ztaskSchlaftabletten.Id = "7c1a2c06134c87ba395ce0a7afd39217"
ztaskSchlaftabletten.Name = "Schlaftabletten"
ztaskSchlaftabletten.CorrectState = "NotCorrect"
ztaskSchlaftabletten.Description = "Gehe zur Apotheke und besorge starke Schlafttabletten."
ztaskSchlaftabletten.Visible = false
ztaskSchlaftabletten.Active = false
ztaskSchlaftabletten.Complete = false
ztaskSchlaftabletten.Media = zmediaEinkaufsliste_32
ztaskSchnellzurueck = Wherigo.ZTask(cartDieOlsenBande)
ztaskSchnellzurueck.Id = "59e84bdf20b3d2e179371fbd479da42e"
ztaskSchnellzurueck.Name = "Schnell zurueck"
ztaskSchnellzurueck.CorrectState = "None"
ztaskSchnellzurueck.Description = ""
ztaskSchnellzurueck.Visible = false
ztaskSchnellzurueck.Active = false
ztaskSchnellzurueck.Complete = false
ztaskSchnellzurueck.Media = zmediaEinkaufsliste_32
ztaskZumGeheimversteck = Wherigo.ZTask(cartDieOlsenBande)
ztaskZumGeheimversteck.Id = "a66475fb0d8bb27bfc7c952f308e0912"
ztaskZumGeheimversteck.Name = "Zum Geheimversteck"
ztaskZumGeheimversteck.CorrectState = "NotCorrect"
ztaskZumGeheimversteck.Description = "Gehe zum Geheimversteck (Final 1. Teil)"
ztaskZumGeheimversteck.Visible = false
ztaskZumGeheimversteck.Active = false
ztaskZumGeheimversteck.Complete = false
ztaskZumGeheimversteck.Media = zmediaEinkaufsliste_32
ztaskZumtotenBriefkasten = Wherigo.ZTask(cartDieOlsenBande)
ztaskZumtotenBriefkasten.Id = "2fb3739cb1c2f78c45bd4d9a3db8a669"
ztaskZumtotenBriefkasten.Name = "Zum toten Briefkasten"
ztaskZumtotenBriefkasten.CorrectState = "None"
ztaskZumtotenBriefkasten.Description = "Gehe zum Einstieg und folge dann den Reflektoren zum toten Briefkasten"
ztaskZumtotenBriefkasten.Visible = false
ztaskZumtotenBriefkasten.Active = false
ztaskZumtotenBriefkasten.Complete = false
ztaskZumtotenBriefkasten.Media = zmediaEinkaufsliste_32
ztaskZumTresor = Wherigo.ZTask(cartDieOlsenBande)
ztaskZumTresor.Id = "539d5d7e4c9fbddbfa26e2c571eb28dc"
ztaskZumTresor.Name = "Zum Tresor"
ztaskZumTresor.CorrectState = "None"
ztaskZumTresor.Description = ""
ztaskZumTresor.Visible = false
ztaskZumTresor.Active = false
ztaskZumTresor.Complete = false
ztaskZumTresor.Media = zmediaEinkaufsliste_32
ztaskZurueckindieWohnung = Wherigo.ZTask(cartDieOlsenBande)
ztaskZurueckindieWohnung.Id = "6554b72f9538ef9a004e42316a8766fc"
ztaskZurueckindieWohnung.Name = "Zurueck in die Wohnung"
ztaskZurueckindieWohnung.CorrectState = "NotCorrect"
ztaskZurueckindieWohnung.Description = ""
ztaskZurueckindieWohnung.Visible = false
ztaskZurueckindieWohnung.Active = false
ztaskZurueckindieWohnung.Complete = false
ztaskZurueckindieWohnung.Media = zmediaEinkaufsliste_32
var_Batterie = false
var_Benny_Kraemerladen = false
var_Blumendraht = false
var_Edding = false
var_Eingabe_Brief = ""
var_Eingabe_Kreamer = ""
var_Final = false
var_HackfleischMett = false
var_Kette_gefunden = false
var_Lampe = false
var_Lupe = false
var_papier = false
var_pinzette = false
var_Richtige_Kette = false
var_Schere = false
var_Schlaftabletten = false
var_Stehtoskop = false
var_Werkzeug_Kraemerladen = false
WWB_device = ""
cartDieOlsenBande.ZVariables = {
  var_Batterie = false,
  var_Benny_Kraemerladen = false,
  var_Blumendraht = false,
  var_Edding = false,
  var_Eingabe_Brief = "",
  var_Eingabe_Kreamer = "",
  var_Final = false,
  var_HackfleischMett = false,
  var_Kette_gefunden = false,
  var_Lampe = false,
  var_Lupe = false,
  var_papier = false,
  var_pinzette = false,
  var_Richtige_Kette = false,
  var_Schere = false,
  var_Schlaftabletten = false,
  var_Stehtoskop = false,
  var_Werkzeug_Kraemerladen = false,
  WWB_device = ""
}
buildervar = {}
buildervar.var_Batterie = {}
buildervar.var_Batterie.Id = "6f82cab3ec81720dedaf3bdaeb190e36"
buildervar.var_Batterie.Name = "Batterie"
buildervar.var_Batterie.Type = "Flag"
buildervar.var_Batterie.Data = "False"
buildervar.var_Benny_Kraemerladen = {}
buildervar.var_Benny_Kraemerladen.Id = "8a58b242892018a6bf520a7bf13b2c4a"
buildervar.var_Benny_Kraemerladen.Name = "Benny_Kraemerladen"
buildervar.var_Benny_Kraemerladen.Type = "Flag"
buildervar.var_Benny_Kraemerladen.Data = "False"
buildervar.var_Blumendraht = {}
buildervar.var_Blumendraht.Id = "1f9db97ea25a2346bcba74268d303bcf"
buildervar.var_Blumendraht.Name = "Blumendraht"
buildervar.var_Blumendraht.Type = "Flag"
buildervar.var_Blumendraht.Data = "False"
buildervar.var_Edding = {}
buildervar.var_Edding.Id = "fac9fc224ca2bdb50619067d3ec10ae9"
buildervar.var_Edding.Name = "Edding"
buildervar.var_Edding.Type = "Flag"
buildervar.var_Edding.Data = "False"
buildervar.var_Eingabe_Brief = {}
buildervar.var_Eingabe_Brief.Id = "bf76002557392abf434d128fd7114eb5"
buildervar.var_Eingabe_Brief.Name = "Eingabe_Brief"
buildervar.var_Eingabe_Brief.Type = "String"
buildervar.var_Eingabe_Brief.Data = ""
buildervar.var_Eingabe_Kreamer = {}
buildervar.var_Eingabe_Kreamer.Id = "f8712262fe9b7b3abe95cf96f173ce6e"
buildervar.var_Eingabe_Kreamer.Name = "Eingabe_Kreamer"
buildervar.var_Eingabe_Kreamer.Type = "String"
buildervar.var_Eingabe_Kreamer.Data = ""
buildervar.var_Final = {}
buildervar.var_Final.Id = "fe6fbea577ac16f2c1405b786b744db0"
buildervar.var_Final.Name = "Final"
buildervar.var_Final.Type = "Flag"
buildervar.var_Final.Data = "False"
buildervar.var_HackfleischMett = {}
buildervar.var_HackfleischMett.Id = "b5b23e4a56ef607b58394fb34d895bc2"
buildervar.var_HackfleischMett.Name = "Hackfleisch/Mett"
buildervar.var_HackfleischMett.Type = "Flag"
buildervar.var_HackfleischMett.Data = "False"
buildervar.var_Kette_gefunden = {}
buildervar.var_Kette_gefunden.Id = "abc93a19553eef27de6b2b258e22ba9c"
buildervar.var_Kette_gefunden.Name = "Kette_gefunden"
buildervar.var_Kette_gefunden.Type = "Flag"
buildervar.var_Kette_gefunden.Data = "False"
buildervar.var_Lampe = {}
buildervar.var_Lampe.Id = "be63b575006ab2cb5b2ff51f184ffe1c"
buildervar.var_Lampe.Name = "Lampe"
buildervar.var_Lampe.Type = "Flag"
buildervar.var_Lampe.Data = "False"
buildervar.var_Lupe = {}
buildervar.var_Lupe.Id = "dbf9aaf5726b16a78d99125312001ec2"
buildervar.var_Lupe.Name = "Lupe"
buildervar.var_Lupe.Type = "Flag"
buildervar.var_Lupe.Data = "False"
buildervar.var_papier = {}
buildervar.var_papier.Id = "e211aa5772df387f0edaa14ed63ea79d"
buildervar.var_papier.Name = "papier"
buildervar.var_papier.Type = "Flag"
buildervar.var_papier.Data = "False"
buildervar.var_pinzette = {}
buildervar.var_pinzette.Id = "38af42ef17ebf88fe61ae1d3df9b6313"
buildervar.var_pinzette.Name = "pinzette"
buildervar.var_pinzette.Type = "Flag"
buildervar.var_pinzette.Data = "False"
buildervar.var_Richtige_Kette = {}
buildervar.var_Richtige_Kette.Id = "8249eb366eeef2170f981613e74b0d95"
buildervar.var_Richtige_Kette.Name = "Richtige_Kette"
buildervar.var_Richtige_Kette.Type = "Flag"
buildervar.var_Richtige_Kette.Data = "False"
buildervar.var_Schere = {}
buildervar.var_Schere.Id = "cb0cb4a2f3fd7ca4d38214b558f03137"
buildervar.var_Schere.Name = "Schere"
buildervar.var_Schere.Type = "Flag"
buildervar.var_Schere.Data = "False"
buildervar.var_Schlaftabletten = {}
buildervar.var_Schlaftabletten.Id = "62eecfa7822f81c7c579f6ec945edde6"
buildervar.var_Schlaftabletten.Name = "Schlaftabletten"
buildervar.var_Schlaftabletten.Type = "Flag"
buildervar.var_Schlaftabletten.Data = "False"
buildervar.var_Stehtoskop = {}
buildervar.var_Stehtoskop.Id = "29dabee0e2ec2b4c05fea6bf7a4be9a1"
buildervar.var_Stehtoskop.Name = "Stehtoskop"
buildervar.var_Stehtoskop.Type = "Flag"
buildervar.var_Stehtoskop.Data = "False"
buildervar.var_Werkzeug_Kraemerladen = {}
buildervar.var_Werkzeug_Kraemerladen.Id = "970b7ac84e403cf59646ed6c1246395f"
buildervar.var_Werkzeug_Kraemerladen.Name = "Werkzeug_Kraemerladen"
buildervar.var_Werkzeug_Kraemerladen.Type = "Flag"
buildervar.var_Werkzeug_Kraemerladen.Data = "False"
ztimerFalsche_Eingabe = Wherigo.ZTimer(cartDieOlsenBande)
ztimerFalsche_Eingabe.Id = "e04dc455b75280e3f5981352fd4d0f5b"
ztimerFalsche_Eingabe.Name = "Falsche_Eingabe"
ztimerFalsche_Eingabe.Type = "Interval"
ztimerFalsche_Eingabe.Visible = false
ztimerFalsche_Eingabe.Duration = 1
ztimerFotobox_3m = Wherigo.ZTimer(cartDieOlsenBande)
ztimerFotobox_3m.Id = "c3f945ee67f3a9c55862ba1939e5318c"
ztimerFotobox_3m.Name = "Fotobox_3m"
ztimerFotobox_3m.Type = "Countdown"
ztimerFotobox_3m.Visible = false
ztimerFotobox_3m.Duration = 180
zinputBriefeingabe = Wherigo.ZInput(cartDieOlsenBande)
zinputBriefeingabe.Id = "f3d8f564c8c1f3404a78caf3540d58ba"
zinputBriefeingabe.Name = "Briefeingabe"
zinputBriefeingabe.InputType = "Text"
zinputBriefeingabe.Text = [[
Egon hat mehrere Seiten angefuegt, die alle voll beschrieben sind.<BR>
Vor jeder Zeile befindet sich ein Code]]
zinputBriefeingabe.Visible = true
zinputBriefeingabe.InputVariableId = "bf76002557392abf434d128fd7114eb5"
zinputPasswort_Kraemer = Wherigo.ZInput(cartDieOlsenBande)
zinputPasswort_Kraemer.Id = "573280954be8981c12dbec65b97d3f8b"
zinputPasswort_Kraemer.Name = "Passwort_Kraemer"
zinputPasswort_Kraemer.InputType = "Text"
zinputPasswort_Kraemer.Text = "Ich komme wegen..."
zinputPasswort_Kraemer.Visible = true
zinputPasswort_Kraemer.InputVariableId = "f8712262fe9b7b3abe95cf96f173ce6e"
function cartDieOlsenBande:OnStart()
  Wherigo.Dialog({
    {
      Text = [[
Die Olsenbande und der Stasischatz <BR>
Ein Cache von Lindolf und BachgassenBande]],
      Media = zmediaLogo_230
    },
    {
      Text = "Teil 1 - Prolog",
      Media = zmediaLogo_64
    },
    {
      Text = "Ein Fahrzeug faehrt mit quietschenden Reifen um die Kurve.",
      Media = zmediaAuto_64
    },
    {
      Text = "Benny fahr schneller, nicht dass wir zu spaet kommen!",
      Media = zmediaKjeld_64
    },
    {
      Text = [[
Ja ja, noch schneller und der Motor explodiert.<BR>
Wenn Yvonne nur nicht so getroedelt haette.]],
      Media = zmediaBenny_64
    },
    {
      Text = "Immer sind wir Frauen schuld, was kann ich denn dafuer, dass ihr keine Reservezeit eingeplant hattet.",
      Media = zmediaYvonne_64
    },
    {
      Text = "Das Staatsgefaengnis",
      Media = zmediaGefaengnis_64
    },
    {
      Text = "Mann noch einmal wo bleiben die Pappnasen denn?",
      Media = zmediaEgon_64
    },
    {
      Text = [[
Neue Aufgabe:<BR>
Lass Egon bloss nicht zu lange vor dem Gefaengnis warten.]],
      Media = zmediaLogo_64
    }
  })
  ztaskEgonabholen.Visible = true
  ztaskEgonabholen.Active = true
  WWB_noemul(cartDieOlsenBande, WWB_multiplatform_string("Der Author dieser Cartridge m\195\182chte nicht, dass diese im Emulator gespielt wird"))
end
function cartDieOlsenBande:OnSave()
  cartDieOlsenBande:RequestSync()
end
function ztimerFotobox_3m:OnTick()
  zitemPassbilder:MoveTo(Player)
  ztaskBiometrischesPassbild.Complete = true
  Wherigo.MessageBox({
    Text = [[
Die Passbilder sind fertig und du hast sie in dein Inventar gesteckt!<BR>
Gehe jetzt zum Zeitungsladen und kaufe dir eine Bild Zeitung.Kaufe auf keinen Fall<BR>
dieses dicke Ding vom Sonntag, das koennen wir nicht gebrauchen<BR>
Erst wenn du die Zeitung gekauft hast, druecke weiter.]],
    Media = zmediaPassbilder_bild,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB1
  })
  zitemPassbildautomat.Visible = false
  ztaskBildZeitung.Visible = true
  ztaskBildZeitung.Active = true
  ztaskNotizinFotobox.Complete = true
end
function ztimerFotobox_3m:OnStart()
  Wherigo.MessageBox({
    Text = [[
Du setzt dich in die Box, schliesst den Vorhang und laesst die Maschine Passbilder von dir machen.<BR>
Jetzt musst du drei Minuten warten bis die Bilder entwickelt sind.]],
    Media = zmediaFotobox_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB3
  })
  ztaskNotizinFotobox.Visible = true
  ztaskNotizinFotobox.Active = true
end
function zoneApotheke:OnEnter()
  ztaskSchlaftabletten.Complete = true
  ztaskSchlaftabletten.Active = false
  Wherigo.Dialog({
    {
      Text = "Hallo Kjeld, dich habe ich ja lange nicht mehr gesehen!",
      Media = zmediaApotheker_64
    },
    {
      Text = "Ich brauche starke Schlaftabletten!",
      Media = zmediaKjeld_64
    },
    {
      Text = "Bist du krank? Hast du ein Rezept?",
      Media = zmediaApotheker_64
    },
    {
      Text = "Nein, ich bin nicht krank und Rezept habe ich auch keines.",
      Media = zmediaKjeld_64
    },
    {
      Text = [[
Also sind die Tabletten fuer Yvonne?<BR>
Ohne Rezept kann ich dir nur mittelstarke Tabletten geben.<BR>
Wenn du staerkere benoetigst, dann muss sie zum Arzt.]],
      Media = zmediaApotheker_64
    },
    {
      Text = "Nein, ich glaube die mittelstarken sind in Ordnung.",
      Media = zmediaKjeld_64
    },
    {
      Text = "Hier bitte.",
      Media = zmediaApotheker_64
    },
    {
      Text = [[
Neuer Gegenstand im Inventar:<BR>
Schlaftabletten]],
      Media = zmediaLogo_64
    }
  })
  zitemSchlaftabletten:MoveTo(Player)
  zoneApotheke.Visible = false
end
function zoneApotheke:OnExit()
  if var_Batterie == true and var_Blumendraht == true and var_Edding == true and var_HackfleischMett == true and var_Lampe == true and var_Lupe == true and var_papier == true and var_pinzette == true and var_Schere == true and var_Schlaftabletten == true and var_Stehtoskop == true and ztaskSchlaftabletten.Complete == true and ztaskLupe.Complete == true and ztaskHackfleischMett.Complete == true then
    ztaskKompletieredieListe.Complete = true
    zoneKraemerladen.Visible = false
    zoneKraemerladen.Active = false
    Wherigo.MessageBox({
      Text = "Du hast die Aufgaben die Egon dir aufgetragen hat erledigt, gehe zurueck zur Wohnung um dich dort mit Egon zu treffen.",
      Media = zmediaLogo_64,
      Buttons = {"Weiter"},
      Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB5
    })
    zoneApotheke.Active = false
  end
end
function zoneBahnhof:OnEnter()
  ztaskGehezumBahnhof.Complete = true
  ztaskGehezumBahnhof.Active = false
  ztaskBiometrischesPassbild.Visible = true
  ztaskBiometrischesPassbild.Active = true
  Wherigo.MessageBox({
    Text = "Suche den Passbildautomat und setzte dich hinein, dann benutze ihn (virtuell). Der Automat steh beim westlichen Eingang",
    Media = zmediaFotobox_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB6
  })
end
function zoneFinal_Tresor:OnEnter()
  Wherigo.Dialog({
    {
      Text = "Sucht den Tresor!",
      Media = zmediaSafe_64
    },
    {
      Text = [[
Hilf Kjeld beim Oeffnen des Tresors!<BR>
Hoere genau zu und folge den Anweisungen! (Real)<BR>
Hint: Magnetismus hilft]],
      Media = zmediaLogo_64
    },
    {
      Text = [[
Trage dich dann ins Logbuch ein!<BR>
Herzlichen Glueckwunsch, du hast die Kette gefunden!<BR>
Jetzt kannst du die Kette gegen Egon tauschen.<BR>
Schnell zurueck zum Auto.]],
      Media = zmediaLogo_64
    }
  })
  ztaskZumTresor.Complete = true
  ztaskZumTresor.Active = false
  var_Kette_gefunden = true
  ztaskSchnellzurueck.Active = true
  ztaskSchnellzurueck.Visible = true
  zoneSammelpunkt.Visible = true
  zoneSammelpunkt.Active = true
  zitemKoenigskette.Visible = true
  zitemKoenigskette:MoveTo(Player)
  ztaskBesorgedieKette.Complete = true
  ztaskBesorgedieKette.Active = false
end
function zoneFleischer:OnEnter()
  zoneFleischer.Visible = false
  Wherigo.Dialog({
    {
      Text = [[
Hallo Kjeld, Yvonne war heute schon hier!<BR>
Hat sie etwas vergessen zu kaufen?]],
      Media = zmediaMetzger_64
    },
    {
      Text = [[
Nein...<BR>
nicht direkt...<BR>
....]],
      Media = zmediaKjeld_64
    },
    {
      Text = [[
(Lacht)<BR>
Also es ist fuer dich?<BR>
Kein Grund zur Panik ich werde Yvonne nichts verraten!]],
      Media = zmediaMetzger_64
    },
    {Text = "Aber...", Media = zmediaKjeld_64},
    {
      Text = [[
Kein Aber!<BR>
Was soll es denn sein Kjeld?]],
      Media = zmediaMetzger_64
    },
    {
      Text = "500g Hackfleisch/Mett bitte!",
      Media = zmediaKjeld_64
    },
    {
      Text = "Hier bitte! ",
      Media = zmediaMetzger_64
    },
    {
      Text = [[
Neuer Gegenstand im Inventar:<BR>
500g Hackfleisch/Mett]],
      Media = zmediaHackfleisch_64
    }
  })
  zitemHackfleischMett:MoveTo(Player)
  ztaskHackfleischMett.Complete = true
  ztaskHackfleischMett.Active = false
end
function zoneFleischer:OnExit()
  if var_Batterie == true and var_Blumendraht == true and var_Edding == true and var_HackfleischMett == true and var_Lampe == true and var_Lupe == true and var_papier == true and var_pinzette == true and var_Schere == true and var_Schlaftabletten == true and var_Stehtoskop == true and ztaskSchlaftabletten.Complete == true and ztaskLupe.Complete == true and ztaskHackfleischMett.Complete == true then
    ztaskKompletieredieListe.Complete = true
    zoneKraemerladen.Visible = false
    zoneKraemerladen.Active = false
    Wherigo.MessageBox({
      Text = "Du hast die Aufgaben die Egon dir aufgetragen hat erledigt, gehe zurueck zur Wohnung um dich dort mit Egon zu treffen.",
      Media = zmediaLogo_64,
      Buttons = {"Weiter"},
      Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB5
    })
    zoneFleischer.Active = false
    Wherigo.Dialog({
      {
        Text = "Du verlaesst den Laden, und laefst in die Arme von Yvonne.",
        Media = zmediaMetzgerei_64
      },
      {
        Text = [[
Ha, hab ich dich erwischt!<BR>
Kein Wunder dass du nicht abnimmst!<BR>
Komm du mir mal nach Hause....]],
        Media = zmediaYvonne_64
      },
      {
        Text = "Aber Yvonne....",
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Kein aber Kjeld, <BR>
du weist genau, dass du auf Diat bist!]],
        Media = zmediaYvonne_64
      },
      {
        Text = [[
Yvonne, das Fleisch ist nicht fuer mich!<BR>
Ich soll es fuer Egon besorgen.]],
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Na, dann wird er es sicher bestaetigen koennen.<BR>
(Yvonne dreht sich um und geht in den Laden)]],
        Media = zmediaYvonne_64
      },
      {
        Text = "Du schuettelst den Kopf und willst ihr nach, laesst es aber und hoffst es spaeter klaeren zu koennen.",
        Media = zmediaKjeld_64
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = "Du verlaesst den Laden, und laefst in die Arme von Yvonne.",
        Media = zmediaMetzgerei_64
      },
      {
        Text = [[
Ha, hab ich dich erwischt!<BR>
Kein Wunder dass du nicht abnimmst!<BR>
Komm du mir mal nach Hause....]],
        Media = zmediaYvonne_64
      },
      {
        Text = "Aber Yvonne....",
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Kein aber Kjeld, <BR>
du weist genau, dass du auf Diat bist!]],
        Media = zmediaYvonne_64
      },
      {
        Text = [[
Yvonne, das Fleisch ist nicht fuer mich!<BR>
Ich soll es fuer Egon besorgen.]],
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Na, dann wird er es sicher bestaetigen koennen.<BR>
(Yvonne dreht sich um und geht in den Laden)]],
        Media = zmediaYvonne_64
      },
      {
        Text = "Du schuettelst den Kopf und willst ihr nach, laesst es aber und hoffst es spaeter klaeren zu koennen.",
        Media = zmediaKjeld_64
      }
    })
  end
end
function zoneGeheimversteckt:OnEnter()
  cartDieOlsenBande.Complete = true
  Wherigo.MessageBox({
    Text = [[
Codekartenschablobene gefunden und ins Inventar gelegt.<BR>
Suche das Final und trage dich ins Logbuch ein<BR>
Hint: Die Treppe runter<BR>
]],
    Media = zmediaLogo_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB7
  })
  zitemCodekartenschablone:MoveTo(Player)
  cartDieOlsenBande:RequestSync()
end
function zoneHunde:OnEnter()
  Wherigo.MessageBox({
    Text = [[
Ploetzlich stehen drei Hunde vor dir.<BR>
Noch knurren sie nur, aber an ein weitergehen ist nicht zu denken!<BR>
Lass dir etwas einfallen!]],
    Media = zmediaHund,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB8
  })
end
function zoneKraemerladen:OnEnter()
  if var_Benny_Kraemerladen == true then
    if var_Werkzeug_Kraemerladen == true then
      Wherigo.MessageBox({
        Text = "Brauchst du noch etwas?",
        Media = zmediaKreamer_64,
        Buttons = {"Fragen"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.MessageBox({
        Text = "Hast du Passbilder machen lassen? Und...?",
        Media = zmediaKreamer_64,
        Buttons = {"Antworten"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB10
      })
    end
  else
    ztaskGehezumKraemerladen.Complete = true
    ztaskGehezumKraemerladen.Active = false
    ztaskGehezumBahnhof.Active = true
    ztaskGehezumBahnhof.Visible = true
    Wherigo.Dialog({
      {
        Text = "Du willst gerade in den Kraemerladen gehen, als Benny dir entgegen kommt.",
        Media = zmediaLogo_64
      },
      {
        Text = [[
Kjeld, gut dass ich dich treffe, Egon hat dir vergessen etwas zu sagen.<BR>
Damit der Kraemer dir das Werkzeug gibt, musst du ihm ein Passwort sagen.]],
        Media = zmediaBenny_64
      },
      {
        Text = "Und wie lautet es?",
        Media = zmediaKjeld_64
      },
      {
        Text = "Keine Ahnung! Egon hat aber gesagt, dass du zum Bahnhof gehen sollst.",
        Media = zmediaBenny_64
      },
      {
        Text = "Zum Bahnhof? Warum?",
        Media = zmediaKjeld_64
      },
      {
        Text = "Du sollst dort drei Aufgaben erledigen:",
        Media = zmediaBenny_64
      },
      {
        Text = [[
1. Biometrisches Passbild<BR>
Egon benoetigt ein biometrisches Passbild von dir.<BR>
Im Bahnhof steht ein Passbildautomat, da kannst du eines machen.]],
        Media = zmediaPassbilder_64
      },
      {
        Text = WWB_multiplatform_string("2. Hinweis<BR>\nEgon hat einen Hinweis in der Box des Passbildautomats f\195\188r dich hinterlegt.<BR>\nNotiere ihn, es ist das Passwort fuer den Kraemer!"),
        Media = zmediaFotobox_64
      },
      {
        Text = [[
3. Bildzeitung<BR>
Kaufe dir die heutige Bildzeitung!<BR>
Kaufe auf keinen Fall dieses dicke Ding vom Sonntag, das koennen wir nicht gebrauchen!]],
        Media = zmediaBildzeitung_64
      },
      {
        Text = [[
Ok,<BR>
ich soll zum Bahnhof, dann dort ein Passbild machen, den Hinweis im Passbildautomat notieren und eine Bildzeitung kaufen.<BR>
(Aufgaben wurden hinzugefuegt)<BR>
(Zone Bahnhof freigeschalten)]],
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Ja, genau! Dann kommst du zum Kraemer zurueck und erledigst deinen Auftrag hier.<BR>
Ich muss los, Egon wartet auf mich!]],
        Media = zmediaBenny_64
      }
    })
    var_Benny_Kraemerladen = true
    zoneBahnhof.Active = true
    zoneBahnhof.Visible = true
    zoneWohnung.Active = false
  end
end
function zoneKraemerladen:OnExit()
  if var_Batterie == true and var_Blumendraht == true and var_Edding == true and var_HackfleischMett == true and var_Lampe == true and var_Lupe == true and var_papier == true and var_pinzette == true and var_Schere == true and var_Schlaftabletten == true and var_Stehtoskop == true and ztaskSchlaftabletten.Complete == true and ztaskLupe.Complete == true and ztaskHackfleischMett.Complete == true then
    ztaskKompletieredieListe.Complete = true
    zoneKraemerladen.Visible = false
    zoneKraemerladen.Active = false
    Wherigo.MessageBox({
      Text = "Du hast die Aufgaben die Egon dir aufgetragen hat erledigt, gehe zurueck zur Wohnung um dich dort mit Egon zu treffen.",
      Media = zmediaLogo_64,
      Buttons = {"Weiter"},
      Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB5
    })
  end
end
function zoneN1:OnEnter()
  zoneEinstieg.Visible = false
  zoneEinstieg.Active = false
  zoneEinstieg2.Visible = true
  zoneEinstieg2.Active = true
  Wherigo.MessageBox({
    Text = [[
Hier muss irgendwo der Tote Briefkasten sein!<BR>
Finde ihn und die versteckte Information!<BR>
Danach geht es weiter in Richtung Einstieg2]],
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB11
  })
end
function zoneN2:OnEnter()
  Wherigo.Dialog({
    {
      Text = [[
Hier ist die erste Alarmanlage die ihr ausschalten muesst.<BR>
Egon hat hierfuer noch unverschluesselte Anweisungen hinterlegt.]],
      Media = zmediaLogo_64
    },
    {
      Text = [[
Eintag aus dem Notizbuch:<BR>
Die Codekarte mit dem scharzen Edding ausmalen. Und entsprechend zuschneiden.<BR>
Die Felder die bearbeitet werden muessen stehen in der Nachricht aus dem toten Briefkasten!]],
      Media = zmediaEgon_64
    },
    {
      Text = [[
Wenn du dass gemacht hast, wird die Alarmanlage abgeschalten.<BR>
Du erhaelts einen Code, siehe im Notizbuch nach um zur naechsten Station zu gelangen.]],
      Media = zmediaLogo_64
    }
  })
  zoneEinstieg2.Visible = false
  zoneEinstieg2.Active = false
  zitemNotizbuch.Commands.Lesen.Enabled = true
end
function zoneN3:OnEnter()
  zitemNotizbuch.Commands.Lesen.Enabled = true
  zoneEinstieg3.Visible = false
  zoneEinstieg3.Active = false
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Eintag aus dem Notizbuch:<BR>\nNimm die Bildzeitung zur Hand, schau auf die Titelseite und \195\188bersetze mit ihrer Hilfe den hier versteckten Text <BR>\nHint: Der benoetigte Code ist 13 Stellig"),
      Media = zmediaEgon_64
    },
    {
      Text = "Suche im Notizbuch mit dem entschluesselten Codewort",
      Media = zmediaLogo_64
    }
  })
end
function zoneN4:OnEnter()
  zitemNotizbuch.Commands.Lesen.Enabled = true
  zoneEinstieg4.Visible = false
  zoneEinstieg4.Active = false
  Wherigo.Dialog({
    {
      Text = [[
Anweisung aus dem Notizbuch:<BR>
Diese Alarmanlage kann mit der richtigen Stellung der Wippschalter deaktiviert werden.]],
      Media = zmediaEgon_64
    },
    {
      Text = [[
Stelle zuerst alle Wippschalter nach unten, dann versuche die richtigen Positionen der Schalter zu finden.<BR>
Wenn die Anordnung richtig ist, suche im Notizbuch mit der Loesung.<BR>
Hint: Schalterstellung von binaer in dezimal umrechnen]],
      Media = zmediaLogo_64
    }
  })
  zoneHunde.Active = true
end
function zoneN5:OnEnter()
  zitemNotizbuch.Commands.Lesen.Enabled = true
  zoneEinstieg5.Visible = false
  zoneEinstieg5.Active = false
  Wherigo.Dialog({
    {
      Text = [[
Anweisung aus dem Notizbuch:<BR>
Mit dem Buegeleisen laesst sich die Alarmanlage ueberlasten.]],
      Media = zmediaEgon_64
    },
    {
      Text = "Suche nach den erhaltenen Code im Notizbuch!",
      Media = zmediaLogo_64
    }
  })
end
function zoneOptiker:OnEnter()
  Wherigo.Dialog({
    {
      Text = "Hallo Kjeld, wie kann ich dir helfen?",
      Media = zmediaOptiker_64
    },
    {
      Text = "Ich brauche eine Lupe!",
      Media = zmediaKjeld_64
    },
    {
      Text = [[
Hier such dir eine aus, die schenke ich dir!<BR>
Bist ja seid Jahren ein guter Kunde bei mir.]],
      Media = zmediaOptiker_64
    },
    {
      Text = "Die nehme ich!",
      Media = zmediaKjeld_64
    },
    {
      Text = [[
Neuer Gegenstand im Inventar:<BR>
Lupe]],
      Media = zmediaLogo_64
    }
  })
  zitemLupe:MoveTo(Player)
  ztaskLupe.Complete = true
  ztaskLupe.Active = false
  zoneOptiker.Visible = false
end
function zoneOptiker:OnExit()
  if var_Batterie == true and var_Blumendraht == true and var_Edding == true and var_HackfleischMett == true and var_Lampe == true and var_Lupe == true and var_papier == true and var_pinzette == true and var_Schere == true and var_Schlaftabletten == true and var_Stehtoskop == true and ztaskSchlaftabletten.Complete == true and ztaskLupe.Complete == true and ztaskHackfleischMett.Complete == true then
    ztaskKompletieredieListe.Complete = true
    zoneKraemerladen.Active = false
    zoneKraemerladen.Visible = false
    Wherigo.MessageBox({
      Text = "Du hast die Aufgaben die Egon dir aufgetragen hat erledigt, gehe zurueck zur Wohnung um dich dort mit Egon zu treffen.",
      Media = zmediaLogo_64,
      Buttons = {"Weiter"},
      Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB5
    })
    zoneOptiker.Active = false
  end
end
function zoneSammelpunkt:OnEnter()
  if var_Richtige_Kette == true then
  elseif var_Kette_gefunden == true then
    ztaskSchnellzurueck.Complete = true
    ztaskSchnellzurueck.Active = false
    Wherigo.Dialog({
      {
        Text = "Ihr steht beim Auto und wollt gerade einsteigen.",
        Media = zmediaAuto_64
      },
      {
        Text = "Als hinter ploetzlich das der schwarze Wagen um die Ecke biegt.",
        Media = zmediaSchwarzerWagen1_64
      },
      {
        Text = "Eine dunkle Gestalt steigt aus.",
        Media = zmediaLogo_64
      },
      {
        Text = "Habt ihr die Kette?",
        Media = zmediaDunkleGestalt_64
      },
      {
        Text = "Habt ihr Egon?",
        Media = zmediaBenny_64
      },
      {
        Text = "Die dunkle Gestalt oeffnet eine der Wagentueren und zieht Egon heraus.",
        Media = zmediaLogo_64
      },
      {
        Text = "Egon, geht es dir gut?",
        Media = zmediaKjeld_64
      },
      {
        Text = "Ihr pieseligen schwachkoepfe, haettet ihr nur...",
        Media = zmediaEgon_64
      },
      {
        Text = "Still, legt die Kette 10m vor euch auf den Boden, dann lasse ich Egon frei.",
        Media = zmediaDunkleGestalt_64
      },
      {
        Text = "Kjeld legt die Kette auf den Boden.",
        Media = zmediaKoenigskette
      },
      {
        Text = "Egon wird in eure Richtung geschoben.",
        Media = zmediaEgon_64
      },
      {
        Text = [[
Als Egon bei euch ankommt, hat die dunkle Gestalt bereits die Kette an sich genommen und ist in den Wagen eingestiegen.<BR>
Dann faehrt sie mit quietschenden Reifen los.]],
        Media = zmediaLogo_64
      },
      {
        Text = [[
Egon ist gerettet,<BR>
dennoch er ist nahe am explodieren vor Wut!]],
        Media = zmediaLogo_64
      },
      {
        Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch du hast den<BR>\n2.Teil von Egon und der Stasischatz abgeschlossen."),
        Media = zmediaLogo_64
      },
      {
        Text = "Egon geht zum Auto und zuendet sich eine Zigarre an",
        Media = zmediaEgon_64
      },
      {
        Text = [[
Ihr einfaeltigen Toelpel.<BR>
Habt doch tatsaechlich das Imitat gefunden.]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Start 3.Teil von Egon und der Stasischatz<BR>
Bonus - Die Koenigskette -]],
        Media = zmediaLogo_64
      },
      {
        Text = "Kommt mit ihr zwei Einfaltspinsel, dann erklaere ich es euch.",
        Media = zmediaEgon_64
      },
      {
        Text = "Gehe Richtung Wegpunkt",
        Media = zmediaLogo_64
      }
    })
    zoneFinal_Tresor.Active = false
    zoneFinal_Tresor.Visible = false
    zitemKoenigskette.Visible = false
    zoneWegpunkt.Visible = true
    zoneWegpunkt.Active = true
    var_Richtige_Kette = true
  else
    zoneParkplatz.Visible = false
    zoneParkplatz.Active = false
    zoneN1.Active = true
    Wherigo.Dialog({
      {
        Text = [[
2.Teil von Egon und der Stasischatz<BR>
Der Tresor (Nachtcacheteil)]],
        Media = zmediaLogo_64
      },
      {
        Text = "Nach einer langen Autofahrt mit Benny erreicht ihr den Sammelpunkt.",
        Media = zmediaAuto_64
      },
      {
        Text = "An einem Baum findet ihr einen Brief.",
        Media = zmediaLogo_64
      },
      {Text = "", Media = zmediaBrief_Egon},
      {
        Text = [[
Du findest das Notizbuch im Handschuhfach.<BR>
Benutze es um weitere Informationen zu erhalten.]],
        Media = zmediaLogo_64
      },
      {
        Text = [[
Auf der ersten Seite des Notizbuchs findet ihr einen Hinweis von Egon.<BR>
Gehe zum Einstieg und folge von dort den Reflektoren zum toten Briefkasten]],
        Media = zmediaLogo_64
      }
    })
    zoneEinstieg.Visible = true
    zoneEinstieg.Active = true
    zitemNotizbuch.Visible = true
    zitemNotizbuch:MoveTo(Player)
    ztaskZumtotenBriefkasten.Visible = true
    ztaskZumtotenBriefkasten.Active = true
    ztaskGehezumTreffpunkt.Complete = true
    ztaskGehezumTreffpunkt.Active = false
    cartDieOlsenBande:RequestSync()
  end
end
function zoneStaatgefaengnis:OnEnter()
  Wherigo.Dialog({
    {
      Text = "Fahrzeug faehrt mit Hochgeschwindigkeit auf Egon zu und kommt einen Meter vor Egon mit rauchenden Reifen zum Stillstand.",
      Media = zmediaAuto_64
    },
    {
      Text = [[
Ihr strohdummen Holzkoepfe, habe ich euch nicht gesagt, dass ich heute entlassen werde!?<BR>
Ihr lausigen Amateure laesst mich einfach so warten?!]],
      Media = zmediaEgon_64
    },
    {
      Text = "Aber Egon...",
      Media = zmediaKjeld_64
    },
    {
      Text = [[
Egon lass es mich erklaeren, ich muss heute noch zum Geburtstag von meinem Grossonkel Brond und da mussten wir noch schnell Blumen pfluecken.<BR>
Ohne Blumen kann ich ja nicht hingehen!]],
      Media = zmediaYvonne_64
    },
    {
      Text = [[
(Egon steigt zornig ins Auto ein)<BR>
Schwachkoepfe und Mollusken, bin ich denn nur von strohdummen Holzkoepfen umgeben.]],
      Media = zmediaEgon_64
    },
    {
      Text = [[
Neue Aufgabe:<BR>
Egon hat einen Plan ausgearbeitet und will mit dir in der Wohnung von Yvonne und Kjeld darueber sprechen.]],
      Media = zmediaLogo_64
    },
    {
      Text = "Falls ihr mit dem Auto unterwegs seid, koennt ihr es in der Zone Parkplatz gegen eine Gebuehr abstellen.",
      Media = zmediaParkplatz_64
    }
  })
  zoneWohnung.Visible = true
  zoneWohnung.Active = true
  zoneStaatgefaengnis.Visible = false
  zoneStaatgefaengnis.Active = false
  zoneParkplatz.Visible = true
  zoneParkplatz.Active = true
  ztaskIndieWohnung.Visible = true
  ztaskIndieWohnung.Active = true
  ztaskEgonabholen.Complete = true
  ztaskEgonabholen.Active = false
end
function zoneTresor:OnEnter()
  Wherigo.Dialog({
    {
      Text = [[
Nein!<BR>
Dass kann nicht sein!<BR>
Wie ist dass moeglich?]],
      Media = zmediaEgon_64
    },
    {
      Text = "Der Tresor ist aufgebrochen!",
      Media = zmediaTresor_Aufgebrochen
    },
    {
      Text = "Schau Egon, dass habe ich im Tresor gefunden.",
      Media = zmediaKjeld_64
    },
    {Text = "", Media = zmediaBrief_Baron},
    {
      Text = "(Egon beisst vor Wut so fest auf seine Zigarre dass sie abbricht)",
      Media = zmediaEgon_64
    },
    {
      Text = [[
Suche den Final des 3.Teil (Bonus) und trage dich ins Logbuch ein.<BR>
Hint: magnetisch]],
      Media = zmediaLogo_64
    },
    {
      Text = [[
Wir hoffen dass das Wherigo dir gefallen hat und wuenschen eine sichere Heimfahrt.<BR>
<BR>
Lindolf und BachgassenBande]],
      Media = zmediaLogo_64
    }
  })
  zoneTresor.Visible = false
  zoneTresor.Active = false
end
function zoneWegpunkt:OnEnter()
  Wherigo.Dialog({
    {
      Text = [[
Start 3.Teil von Egon und der Stasischatz<BR>
Bonus]],
      Media = zmediaLogo_64
    },
    {
      Text = [[
(Egon lacht)<BR>
Dem haben wirs gegeben, was wuerde ich geben nur um sein Gesicht zu sehen wenn er merkt dass die Kette nicht echt ist.]],
      Media = zmediaEgon_64
    },
    {Text = "???", Media = zmediaKjeld_64},
    {Text = "???", Media = zmediaBenny_64},
    {
      Text = "Was habt ihr kleinhirnigen Mueckenschisser geglaubt was ich gemacht hatte als ihr unterwegs wart?",
      Media = zmediaEgon_64
    },
    {Text = "???", Media = zmediaKjeld_64},
    {Text = "???", Media = zmediaBenny_64},
    {
      Text = [[
Ich habe von Anfang an gewusst, dass wir beobachtet werden.<BR>
Desshalb habe ich ein Imitat der Kette versteckt, das ihr dann ja gefunden habt.]],
      Media = zmediaEgon_64
    },
    {
      Text = [[
Wie gesagt, mein Plan ist totsicher!<BR>
Alle Eventualitaeten sind eingeplant.]],
      Media = zmediaEgon_64
    },
    {
      Text = [[
Mann Egon, einfach genial!<BR>
Und wo ist die echte Kette jetzt?]],
      Media = zmediaKjeld_64
    },
    {
      Text = [[
Nicht weit von hier!<BR>
Kommt mit zum richtigen Tresor!]],
      Media = zmediaEgon_64
    },
    {
      Text = [[
Geht zum Tresor,<BR>
findet die Kette!]],
      Media = zmediaLogo_64
    }
  })
  zoneWegpunkt.Visible = false
  zoneWegpunkt.Active = false
  zoneTresor.Active = true
  zoneTresor.Visible = true
end
function zoneWohnung:OnEnter()
  if var_Final == true then
    Wherigo.Dialog({
      {
        Text = [[
Vor dem Haus steht ein scharzer Wagen mit laufenden Motor.<BR>
Du kannst nicht erkennen wieviele Personen im Fahrzeug sitzen, da die Fenster vom Wagen verdunkelt sind.]],
        Media = zmediaSchwarzerWagen_64
      },
      {
        Text = "Kjeld zuckt kurz mit den Schultern, oeffnet die die Haustuere und steigt die Treppe zur Wohnung hoch.",
        Media = zmediatreppe_64
      },
      {
        Text = "Egon und Benny sitzen in der Kueche und bereiten den Bruch vor.",
        Media = zmediaPlan_schmieden
      },
      {
        Text = [[
Da bist du ja,...<BR>
wird auch Zeit!<BR>
Komm setzt dich zu uns, wir muessen noch einiges Vorbereiten.]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Benny, du kuemmerst dich um den Wagen.<BR>
Kontrolliere nocheinmal das Licht und ob genuegend Benzin im Tank ist.]],
        Media = zmediaAuto_64
      },
      {
        Text = [[
Ok Egon, ich kuemmere mich darum.<BR>
(Benny steht auf und verlaesst die Wohnung)]],
        Media = zmediaBenny_64
      },
      {
        Text = WWB_multiplatform_string("Zu den Dingen die du besorgt hast Kjeld musst du noch ein paar einpacken. (REAL diese Dinge werden f\195\188r den Nachtcache benoetigt)"),
        Media = zmediaEgon_64
      },
      {
        Text = "Sehr gut, vieles von meiner Liste haben wir bereits hier.",
        Media = zmediaEinkaufsliste_32
      },
      {
        Text = "Hmm, das Blatt Papier muss noch vorbereitet werden.",
        Media = zmediaEgon_64
      },
      {
        Text = [[
Schneide aus dem Papier (maximal 1mm dick) entsprechend der Codekartenschablone ein entsprechend grosses Stueck heraus. (85mm x 53mm)<BR>
Dann zeichne darauf Unterteilungen in 1cm Abstand ein und eine weitere Unterteilung in der Mitte. (siehe Codekartenschablone)]],
        Media = zmediaKarte
      },
      {
        Text = [[
Edding, ein scharzer Stift!<BR>
Pack einen ein!<BR>
]],
        Media = zmediaEdding_64
      },
      {
        Text = "9 Volt Batterieblock! Pack einen oder vielleicht zwei ein!",
        Media = zmediabatterie_64
      },
      {
        Text = "Blumendraht! Pack einen ein!",
        Media = zmediablumendraht_64
      },
      {
        Text = "Bildzeitung! Pack eine ein!",
        Media = zmediaBildzeitung_64
      },
      {
        Text = "Lampe! Pack eine ein!",
        Media = zmediaLampe_64
      },
      {
        Text = "Buegeleisen! Pack eines ein!",
        Media = zmediabuegeleisen_64
      },
      {
        Text = "Schere! Pack eine ein!",
        Media = zmediaSchere_64
      },
      {
        Text = "Ausgeschnittenes stueck Papier mit Markierungen! Pack es ein!",
        Media = zmediaKarte
      },
      {
        Text = [[
Sehr gut wie haben alles!<BR>
Wir treffen uns nach Sonnenuntergang am Sammelpunkt!<BR>
Benutzte den Code vom Passbildautomaten (ABCDEFGH) um die Stelle zu finden!<BR>
Von dort aus geht es zum toten Briefkasten!<BR>
Benny faehrt dich, seid puenktlich!]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Kommt mir ja nicht zu spaet!<BR>
(Egon schnappt sich seinen Hut und danach auch schon durch die Tuer)]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Kurz nachdem Egon gegangen war, ist von der Strasse ein kurzer Tumult zu hoeren.<BR>
Du oeffnest das Fenster und...]],
        Media = zmediaKjeld_64
      },
      {
        Text = [[
siehst eine dunkle Gestalt...<BR>
... die Egon in den Wagen zerrt.]],
        Media = zmediaDunkleGestalt_64
      },
      {
        Text = "Der Wagen faehrt darauf mit Hochgeschwindigkeit los.",
        Media = zmediaSchwarzerWagen1_64
      },
      {
        Text = "Du laeufst hinunter und findest an der Eingangstuer einen Zettel.",
        Media = zmediaKjeld_64
      },
      {Text = "", Media = zmediaErpresser},
      {
        Text = "Ende Teil1 - Prolog",
        Media = zmediaLogo_64
      },
      {
        Text = [[
Lade dir das Cartridge fuer den 2. Teil<BR>
<BR>
Achtung! Nachtcache!<BR>
Alle von Egon aufgezaehlten Dinge musst du mitnehmen!<BR>
<BR>
Der Code von der Fotobox = ABCDEFGH und wird fuer die Berechnung der Koordinaten benoetigt. <BR>
(Cachebeschreibung Teil2)]]
      }
    })
    zitemCodekartenschablone.Visible = true
    zitemEgonsEinkaufsliste.Visible = false
    zoneSammelpunkt.Visible = false
    zoneSammelpunkt.Active = false
    zoneWohnung.Active = false
    zoneWohnung.Visible = false
    ztaskBesorgedieKette.Visible = true
    ztaskBesorgedieKette.Active = true
    zoneGeheimversteckt.Active = false
    zoneGeheimversteckt.Visible = false
    cartDieOlsenBande:RequestSync()
  elseif var_Batterie == true and var_Blumendraht == true and var_Edding == true and var_HackfleischMett == true and var_Lampe == true and var_Lupe == true and var_papier == true and var_pinzette == true and var_Schere == true and var_Schlaftabletten == true and var_Stehtoskop == true and ztaskSchlaftabletten.Complete == true and ztaskLupe.Complete == true and ztaskHackfleischMett.Complete == true then
    Wherigo.Dialog({
      {
        Text = [[
Kjeld! Wo warst du denn so lange?<BR>
Egon wartet auf dich und hat eine miese Laune!<BR>
Du gehst besser schnell hinein.]],
        Media = zmediaYvonne_64
      },
      {
        Text = "Kjeld du fettwaemstiger Sandhocker, wo warst du denn?",
        Media = zmediaEgon_64
      },
      {
        Text = "Egon, ich....",
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Keine lausigen Ausreden!<BR>
Hast du besorgt was ich dir aufgetragen habe?]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Natuerlich Egon!<BR>
Hier sieh mal!]],
        Media = zmediaKjeld_64
      },
      {Text = "Yvonne!", Media = zmediaEgon_64},
      {Text = "Ja Egon!", Media = zmediaYvonne_64},
      {
        Text = "Bring mir euer Buegeleisen, das benoetigen wir!(real)",
        Media = zmediaEgon_64
      },
      {
        Text = "Hier Egon, aber versprich mir, dass ich es wieder bekomme!",
        Media = zmediaYvonne_64
      },
      {
        Text = [[
Kjeld, wir haben fast alles zusammen was wir brauchen.<BR>
Es feht nur noch eine Information.]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Die Information findest du in einem kleinen Safe, den ich am Geheimversteck hinterlegt habe.<BR>
Die letzten 4 Ziffern des Codes von der Fotobox verschaffen dir Zugang.]],
        Media = zmediaEgon_64
      },
      {
        Text = [[
Neue Aufgabe:<BR>
Gehe zum Geheimversteck und besorge dir die Informationen]],
        Media = zmediaLogo_64
      }
    })
    zoneGeheimversteckt.Visible = true
    zoneGeheimversteckt.Active = true
    ztaskZurueckindieWohnung.Complete = true
    ztaskZurueckindieWohnung.Active = false
    ztaskZumGeheimversteck.Visible = true
    ztaskZumGeheimversteck.Active = true
  else
    Wherigo.Dialog({
      {
        Text = "Nach einer langen Autofahrt bei der sich Kjeld und Benny mehrmals bei Egon entschuldigt hatten, ist die Wohnung von Yvonne und Kjeld erreicht.",
        Media = zmediaLogo_64
      },
      {
        Text = "Egon, Kjeld und Benny haben es sich am Kuechentisch gemuetlich gemacht.",
        Media = zmediaPlan_schmieden
      },
      {
        Text = [[
So ihr Pappnasen,<BR>
wenn so etwas einfaches wie mich abholen am Gefaengnis schon nicht klappt, bin ich mir nicht sicher, ob ihr die richtigen fuer meine todsicheren Plan seid.]],
        Media = zmediaEgon_64
      },
      {
        Text = "Aber Egon wir haben uns doch schon entschuldigt..",
        Media = zmediaBenny_64
      },
      {
        Text = "Ist doch sicher gefaehrlich?!",
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Klappe zu, alle beide!<BR>
Mein Zellenkumpane hat die schlechte Angewohnheit im Schlaf zu sprechen, das konnte ich ausnutzen um an interessante Informationen zu kommen.<BR>
Hierum geht es, lest!]],
        Media = zmediaEgon_64
      },
      {Text = " ", Media = zmediaZeitungsartikel},
      {
        Text = WWB_multiplatform_string("Wenn die Informationen stimmen, dann ist der Schatz eingeschmolzen worden. Ein sehr wertvolles St\195\188ck wurde aber nicht eingeschmolzen, das werden wir stehlen."),
        Media = zmediaEgon_64
      },
      {
        Text = "Die Koenigskette 1,3 Killogramm pures Gold",
        Media = zmediaKoenigskette
      },
      {
        Text = "Das klingt gefaehrlich Egon!",
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Du treibst mich noch zur Weissglut Kjeld! Ich habe alles genauestens ausgearbeitet, der Plan ist Bombensicher.<BR>
Damit alles klappt, muessen wir noch einige Dinge besorgen.]],
        Media = zmediaEgon_64
      },
      {
        Text = "Kjeld, ich habe vom Gefaengnis aus bereits einiges organisiert. Eine Aufgabenliste mit den Dingen die du besorgen musst, sowie eine Werkzeugtasche liegen beim Kraemer fuer dich bereit.",
        Media = zmediaEgon_64
      },
      {
        Text = "Benny und ich sind anderweitig unterwegs, wenn du fertig bist triffst du dich mit uns hier wieder.",
        Media = zmediaEgon_64
      },
      {
        Text = "Alles klar Egon!",
        Media = zmediaKjeld_64
      },
      {
        Text = [[
Neue Aufgabe:<BR>
Gehe zum Kraemerladen]],
        Media = zmediaLogo_64
      }
    })
    ztaskGehezumKraemerladen.Visible = true
    ztaskGehezumKraemerladen.Active = true
    zoneKraemerladen.Visible = true
    zoneKraemerladen.Active = true
    ztaskIndieWohnung.Visible = false
    ztaskIndieWohnung.Complete = true
  end
end
function zoneWohnung:OnExit()
  cartDieOlsenBande:RequestSync()
end
function zcharacterKraemer:OnAnsprechen()
  Wherigo.MessageBox({
    Text = "Hast du Passbilder machen lassen? Und...?",
    Media = zmediaKreamer_64,
    Buttons = {"Antworten"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB10
  })
end
function zcharacterKraemer:OnBatterie9V()
  Wherigo.MessageBox({
    Text = [[
9V Batterien?<BR>
Wenn du keine daheim hast, dann kannst du bei mir welche kaufen (real).]],
    Media = zmediabatterie_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB12
  })
end
function zcharacterKraemer:OnBlattPapier()
  Wherigo.MessageBox({
    Text = "Ein Blatt weisses Papier, nein damit kann ich nicht dienen! Sieh mal bei dir daheim nach. (Real)",
    Media = zmediaPapier_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB13
  })
end
function zcharacterKraemer:OnBlumendraht()
  Wherigo.MessageBox({
    Text = [[
Hmm Blumendraht?<BR>
Ha, ja habe ich hier, fallst du nichts aehnliches bei dir zu Hause hast kannst du ihn hier bei mir kaufen (real).]],
    Media = zmediablumendraht_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB14
  })
end
function zcharacterKraemer:OnDickerschwarzerEdding()
  Wherigo.MessageBox({
    Text = "Ja, so einen Stift sollte ich hier haben, wenn du keinen daheim hast, kannst du bei mir einen Kaufen (real).",
    Media = zmediaEdding_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB15
  })
end
function zcharacterKraemer:OnHackfleischMett()
  Wherigo.MessageBox({
    Text = "Nein Hackffleisch/Mett habe ich nicht, aber ich kann dir die Adresse eines Fleischers geben.",
    Media = zmediaHackfleisch_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB16
  })
end
function zcharacterKraemer:OnLampe()
  Wherigo.MessageBox({
    Text = "Eine gute Lampe mit einer Reichweite von 50m hast du doch sicher daheim?! (Real)",
    Media = zmediaLampe_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB17
  })
end
function zcharacterKraemer:OnLupe()
  Wherigo.MessageBox({
    Text = "Nein Lupen habe ich nicht, aber ein Optiker sollte welche haben. Hier die Adresse.",
    Media = zmediaLupe_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB18
  })
end
function zcharacterKraemer:OnPinzette()
  Wherigo.MessageBox({
    Text = [[
Pinzetten habe ich keine da, aber daheim in meinen Manikuer-Set ist eine.<BR>
Sieh mal bei dir daheim nach. (Real)]],
    Media = zmediaPinzette_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB19
  })
end
function zcharacterKraemer:OnSchere()
  Wherigo.MessageBox({
    Text = [[
Ja, Scheren habe ich hier!<BR>
Bist du sicher dass du keine daheim hast? Ansonsten kannst du bei mir einen Kaufen (real).]],
    Media = zmediaSchere_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB20
  })
end
function zcharacterKraemer:OnSchlaftabletten()
  Wherigo.MessageBox({
    Text = "Nein, die habe ich bestimmt nicht. Die Apotheke um die Ecke hat sicher welche. Moment, hier ist die Adresse.",
    Media = zmediaSchlaftabletten_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB21
  })
end
function zcharacterKraemer:OnStehtoskop()
  Wherigo.MessageBox({
    Text = [[
Nein Stethoskop habe ich keines hier, oder doch?!<BR>
Was fuer ein Zufall! Hier bitte!]],
    Media = zmediaStethoskop_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB22
  })
end
function zitemHackfleischMett:OnBenutzen()
  Wherigo.MessageBox({
    Text = [[
Du brichst ein kleines Stueck vom Fleisch ab und wirfst es einen der Hunde zu.<BR>
Der Hund frisst es, knurrt dich aber trotzdem weiter an.<BR>
Ueberlege dir etwas anderes!]],
    Media = zmediaHackfleisch_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB23
  })
end
function zitemNotizbuch:OnLesen()
  Wherigo.GetInput(zinputBriefeingabe)
end
function zitemPassbildautomat:OnBenutzen()
  ztimerFotobox_3m:Start()
  zitemPassbildautomat.Commands.Benutzen.Enabled = false
end
function zitemSchlaftabletten:OnBenutzen()
  Wherigo.MessageBox({
    Text = [[
Du formst drei Hackfleischbaellchen und steckst in jedes zwei Schlaftabletten, dann wirfst du es den Hunden einzeln zu.<BR>
Die Hunde fressen sie und schlafen ein.<BR>
Der Weg ist frei!]],
    Media = zmediaSchlaftabletten_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB24
  })
end
function zinputBriefeingabe:OnGetInput(input)
  var_Eingabe_Brief = input
  if var_Eingabe_Brief ~= nil then
    if Wherigo.NoCaseEquals(var_Eingabe_Brief, "3721") and ztaskEsgehtweiter.Active == true then
      zitemNotizbuch.Commands.Lesen.Enabled = false
      ztaskEsgehtweiter.Complete = true
      ztaskEsgehtweiter.Active = false
      Wherigo.MessageBox({
        Text = [[
Ja, hier steht der Code, es geht weiter in Richtung Einstieg 3!<BR>
Suche dort nach Reflektoren!]],
        Buttons = {"Weiter"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB25
      })
    end
    if Wherigo.NoCaseEquals(var_Eingabe_Brief, "tuetenkleber") and ztaskFindedenHinweis.Active == true then
      zitemNotizbuch.Commands.Lesen.Enabled = false
      ztaskFindedenHinweis.Complete = true
      ztaskFindedenHinweis.Active = false
      Wherigo.MessageBox({
        Text = [[
Ja, hier steht der Code, es geht weiter in Richtung Einstieg 4!<BR>
Suche dort nach Reflektoren!]],
        Buttons = {"Weiter"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB26
      })
    end
    if Wherigo.NoCaseEquals(var_Eingabe_Brief, "20") and ztaskLosschneller.Active == true then
      zitemNotizbuch.Commands.Lesen.Enabled = false
      ztaskLosschneller.Complete = true
      ztaskLosschneller.Active = false
      Wherigo.MessageBox({
        Text = [[
Ja, hier steht der Code, es geht weiter in Richtung Einstieg 5!<BR>
Suche dort nach Reflektoren!]],
        Buttons = {"Weiter"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB27
      })
    end
    if Wherigo.NoCaseEquals(var_Eingabe_Brief, "251119") and ztaskLoslos.Active == true then
      zitemNotizbuch.Commands.Lesen.Enabled = false
      ztaskLoslos.Active = false
      ztaskLoslos.Complete = true
      Wherigo.MessageBox({
        Text = [[
Ja, hier steht der Code, der Weg zum Tresor ist frei.<BR>
Suche und oeffne ihn!]],
        Media = zmediaSafe_64,
        Buttons = {"Weiter"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB28
      })
    end
  end
end
function zinputPasswort_Kraemer:OnGetInput(input)
  var_Eingabe_Kreamer = input
  if var_Eingabe_Kreamer ~= nil then
    if Wherigo.NoCaseEquals(var_Eingabe_Kreamer, "27048419") then
      zcharacterKraemer.Visible = true
      zitemWerkzeugtasche:MoveTo(Player)
      zitemWerkzeugtasche.Visible = true
      zitemEgonsEinkaufsliste:MoveTo(Player)
      zitemEgonsEinkaufsliste.Visible = true
      Wherigo.Dialog({
        {
          Text = [[
Ach ja, Egon hat eine Liste per Telefon durchgegeben, die ich fuer ihn besorgen sollte.<BR>
Die Dinge die ich zu dem Zeitpunkt lagernd hatte, hab ich bereits von der Liste gestrichen und in die Tasche gepackt.]],
          Media = zmediaKreamer_64
        },
        {
          Text = [[
Gefuellte Werkzeugtasche erhalten<BR>
Egons Einkaufsliste erhalten<BR>
Neue Aufgabe: kompletiere Egons Einkaufsliste]],
          Media = zmediaLogo_64
        },
        {
          Text = "Danke fuer deine Muehe!",
          Media = zmediaKjeld_64
        },
        {
          Text = [[
Das habe ich doch gerne gemacht!<BR>
Leider konnte ich damals nicht allzuviel von der Liste streichen. Es koennte aber sein, dass ich zur Zeit mehr auf Lager habe. Sprich mich einfach an, ich helfe so gut wie es mir moeglich ist.]],
          Media = zmediaKreamer_64
        }
      })
      Kraemerauswahl("1")
      ztaskKompletieredieListe.Visible = true
      ztaskKompletieredieListe.Active = true
      var_Werkzeug_Kraemerladen = true
      ztaskGehezumKraemerladen.Complete = true
    else
      Wherigo.MessageBox({
        Text = [[
Entschuldigung, ich habe dich nicht verstanden.<BR>
Du kannst mich jederzeit ansprechen, wenn du etwas benoetigst.]],
        Media = zmediaKreamer_64,
        Buttons = {"Weiter"},
        Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB29
      })
    end
  end
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB1(action)
  Wherigo.MessageBox({
    Text = "Du hast jetzt hier alles erledigt, gehe zurueck zum Kraemerladen.",
    Media = zmediakraemerladen_64,
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB2
  })
  ztaskBildZeitung.Complete = true
  ztaskNotizinFotobox.Complete = true
  zitemPassbilder:MoveTo(Player)
  zitemPassbilder.Visible = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB2(action)
  ztaskGehezumKraemerladen.Active = true
  ztaskGehezumKraemerladen.Complete = false
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB3(action)
  Wherigo.MessageBox({
    Text = [[
Die Zeit kannst du nutzen um nach den Hinweis von Egon in der Fotobox zu suchen.(Real)<BR>
Schreibe ihn dir unbedingt auf!<BR>
Fotobox steht im westlichen Eingang]],
    Buttons = {"Weiter"},
    Callback = cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB4
  })
  ztaskNotizinFotobox.Visible = true
  ztaskNotizinFotobox.Active = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB4(action)
  ztaskNotizinFotobox.Complete = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB5(action)
  zoneWohnung.Visible = true
  zoneWohnung.Active = true
  ztaskZurueckindieWohnung.Visible = true
  ztaskZurueckindieWohnung.Active = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB6(action)
  zitemPassbildautomat:MoveTo(Player)
  zoneBahnhof.Active = false
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB7(action)
  zoneWohnung.Visible = true
  zoneWohnung.Active = true
  ztaskZumGeheimversteck.Complete = true
  ztaskZumGeheimversteck.Active = false
  var_Final = true
  zitemCodekartenschablone:MoveTo(Player)
  zitemCodekartenschablone.Visible = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB8(action)
  zitemHackfleischMett.Commands.Benutzen.Enabled = true
  zoneFinal_Tresor.Active = false
  zoneEinstieg5.Visible = false
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB9(action)
  zcharacterKraemer.Visible = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB10(action)
  Wherigo.GetInput(zinputPasswort_Kraemer)
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB11(action)
  zoneN1.Active = false
  zoneN2.Active = true
  ztaskZumtotenBriefkasten.Complete = true
  ztaskZumtotenBriefkasten.Active = false
  ztaskEsgehtweiter.Visible = true
  ztaskEsgehtweiter.Active = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB12(action)
  zcharacterKraemer.Commands.Batterie9V.Enabled = false
  var_Batterie = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB13(action)
  zcharacterKraemer.Commands.BlattPapier.Enabled = false
  var_papier = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB14(action)
  zcharacterKraemer.Commands.Blumendraht.Enabled = false
  var_Blumendraht = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB15(action)
  zcharacterKraemer.Commands.DickerschwarzerEdding.Enabled = false
  var_Edding = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB16(action)
  zcharacterKraemer.Commands.HackfleischMett.Enabled = false
  zoneFleischer.Visible = true
  zoneFleischer.Active = true
  ztaskHackfleischMett.Visible = true
  ztaskHackfleischMett.Active = true
  var_HackfleischMett = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB17(action)
  zcharacterKraemer.Commands.Lampe.Enabled = false
  var_Lampe = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB18(action)
  zcharacterKraemer.Commands.Lupe.Enabled = false
  zoneOptiker.Visible = true
  zoneOptiker.Active = true
  ztaskLupe.Visible = true
  ztaskLupe.Active = true
  var_Lupe = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB19(action)
  zcharacterKraemer.Commands.Pinzette.Enabled = false
  var_pinzette = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB20(action)
  zcharacterKraemer.Commands.Schere.Enabled = false
  var_Schere = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB21(action)
  zcharacterKraemer.Commands.Schlaftabletten.Enabled = false
  zoneApotheke.Visible = true
  zoneApotheke.Active = true
  ztaskSchlaftabletten.Visible = true
  ztaskSchlaftabletten.Active = true
  var_Schlaftabletten = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB22(action)
  zcharacterKraemer.Commands.Stehtoskop.Enabled = false
  zitemStethoskop:MoveTo(Player)
  var_Stehtoskop = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB23(action)
  zitemHackfleischMett.Commands.Benutzen.Enabled = false
  zitemSchlaftabletten.Commands.Benutzen.Enabled = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB24(action)
  zitemHackfleischMett.Visible = false
  zitemSchlaftabletten.Visible = false
  zoneEinstieg5.Visible = true
  zoneHunde.Visible = false
  zoneHunde.Active = false
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB25(action)
  zoneN3.Active = true
  zoneN2.Active = false
  zoneEinstieg3.Visible = true
  zoneEinstieg3.Active = true
  ztaskFindedenHinweis.Active = true
  ztaskFindedenHinweis.Visible = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB26(action)
  zoneEinstieg4.Visible = true
  zoneEinstieg4.Active = true
  zoneN4.Active = true
  zoneN3.Active = false
  ztaskLosschneller.Visible = true
  ztaskLosschneller.Active = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB27(action)
  zoneEinstieg5.Visible = true
  zoneEinstieg5.Active = true
  zoneN4.Active = false
  zoneN5.Active = true
  ztaskLoslos.Visible = true
  ztaskLoslos.Active = true
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB28(action)
  zoneFinal_Tresor.Visible = true
  zoneFinal_Tresor.Active = true
  zoneN5.Active = false
  zoneHunde.Active = false
end
function cartDieOlsenBande.MsgBoxCBFuncs.MsgBoxCB29(action)
  zcharacterKraemer.Visible = true
end
function Kraemerauswahl(x)
  zcharacterKraemer.Commands.Batterie9V.Enabled = true
  zcharacterKraemer.Commands.Blumendraht.Enabled = true
  zcharacterKraemer.Commands.DickerschwarzerEdding.Enabled = true
  zcharacterKraemer.Commands.HackfleischMett.Enabled = true
  zcharacterKraemer.Commands.Lampe.Enabled = true
  zcharacterKraemer.Commands.Lupe.Enabled = true
  zcharacterKraemer.Commands.Pinzette.Enabled = true
  zcharacterKraemer.Commands.Schlaftabletten.Enabled = true
  zcharacterKraemer.Commands.Stehtoskop.Enabled = true
  zcharacterKraemer.Commands.Schere.Enabled = true
  zcharacterKraemer.Commands.BlattPapier.Enabled = true
  zcharacterKraemer.Commands.Ansprechen.Enabled = false
end
return cartDieOlsenBande
