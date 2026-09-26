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
function WWB_deobf(str)
  local result = ""
  local rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~"
  local plen = string.len(rot_palette)
  local magic = {
    ["\001"] = "B",
    ["\002"] = "R",
    ["\003"] = ""
  }
  local d = 0
  local x
  if WWB_strings_unicode == nil then
    x = WWB_multiplatform_string("")
  end
  str = string.gsub(str, "&nbsp;", " ")
  str = string.gsub(str, "&lt;", "\004")
  str = string.gsub(str, "&gt;", "\005")
  str = string.gsub(str, "&amp;", "\006")
  for i = 1, string.len(str) do
    local c = string.sub(str, i, i)
    local p = string.find(rot_palette, c, 1, true)
    if p then
      local jump = d % 8 + 9
      p = p - jump
      if p < 1 then
        p = p + plen
      end
      c = string.sub(rot_palette, p, p)
    else
      x = magic[c]
      if x then
        c = x
      else
      end
    end
    d = d + 1
    if WWB_strings_unicode then
      x = string.byte(c)
      if x and x >= 128 then
        d = d + 1
      end
    end
    result = result .. c
  end
  result = string.gsub(result, "\004", "&lt;")
  result = string.gsub(result, "\005", "&gt;")
  result = string.gsub(result, "\006", "&amp;")
  return result
end
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
cartDasGeheimnisdesKlosters = Wherigo.ZCartridge()
cartDasGeheimnisdesKlosters.MsgBoxCBFuncs = {}
zmediaCharAbt = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharAbt.Id = "b969b0e8dadaa9029ec25844ad34363c"
zmediaCharAbt.Name = "CharAbt"
zmediaCharAbt.AltText = ""
zmediaCharAbt.Resources = {
  {
    Type = "jpg",
    Filename = "Moench9.jpg",
    Directives = {}
  }
}
zmediaCharFabulus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharFabulus.Id = "952ec08d7530a8f60856c66d3e8adaf9"
zmediaCharFabulus.Name = "CharFabulus"
zmediaCharFabulus.AltText = ""
zmediaCharFabulus.Resources = {
  {
    Type = "jpg",
    Filename = "Moench12.jpg",
    Directives = {}
  }
}
zmediaCharGast = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharGast.Id = "6b1af9b7c9e53ee496bf2e8e03d8af4d"
zmediaCharGast.Name = "CharGast"
zmediaCharGast.AltText = ""
zmediaCharGast.Resources = {
  {
    Type = "jpg",
    Filename = "Reisender2.jpg",
    Directives = {}
  }
}
zmediaCharMalusvisus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharMalusvisus.Id = "467dd82bb8f03751edd9b91962933270"
zmediaCharMalusvisus.Name = "CharMalusvisus"
zmediaCharMalusvisus.AltText = ""
zmediaCharMalusvisus.Resources = {
  {
    Type = "jpg",
    Filename = "Moench4.jpg",
    Directives = {}
  }
}
zmediaCharMedicus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharMedicus.Id = "5154c48c7f375972f32999ddea797f8b"
zmediaCharMedicus.Name = "CharMedicus"
zmediaCharMedicus.AltText = ""
zmediaCharMedicus.Resources = {
  {
    Type = "jpg",
    Filename = "Moench11.jpg",
    Directives = {}
  }
}
zmediaCharNovize = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharNovize.Id = "693bebc43dbc4e3cbf160ae1426588cc"
zmediaCharNovize.Name = "CharNovize"
zmediaCharNovize.AltText = ""
zmediaCharNovize.Resources = {
  {
    Type = "jpg",
    Filename = "Reisender1.jpg",
    Directives = {}
  }
}
zmediaCharObliviosus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharObliviosus.Id = "0054516e1729820785e5d962d059b6af"
zmediaCharObliviosus.Name = "CharObliviosus"
zmediaCharObliviosus.AltText = ""
zmediaCharObliviosus.Resources = {
  {
    Type = "jpg",
    Filename = "Moench2.jpg",
    Directives = {}
  }
}
zmediaCharOstarius = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharOstarius.Id = "f148c535e038006462dfb72cd818e4b5"
zmediaCharOstarius.Name = "CharOstarius"
zmediaCharOstarius.AltText = ""
zmediaCharOstarius.Resources = {
  {
    Type = "jpg",
    Filename = "Moench10.jpg",
    Directives = {}
  }
}
zmediaCharScribus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharScribus.Id = "1f0f11e66c90d982687835a02443ab1e"
zmediaCharScribus.Name = "CharScribus"
zmediaCharScribus.AltText = ""
zmediaCharScribus.Resources = {
  {
    Type = "jpg",
    Filename = "Moench8.jpg",
    Directives = {}
  }
}
zmediaCharSecurity = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharSecurity.Id = "9d030d336f9084522789f3daf1792b40"
zmediaCharSecurity.Name = "CharSecurity"
zmediaCharSecurity.AltText = ""
zmediaCharSecurity.Resources = {
  {
    Type = "jpg",
    Filename = "Security1.jpg",
    Directives = {}
  }
}
zmediaCharSignum = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharSignum.Id = "4516e90ae877ada8aef742bb5ce60d18"
zmediaCharSignum.Name = "CharSignum"
zmediaCharSignum.AltText = ""
zmediaCharSignum.Resources = {
  {
    Type = "jpg",
    Filename = "Moench7.jpg",
    Directives = {}
  }
}
zmediaCharSilentius = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharSilentius.Id = "42a287ecb96ca35048b0f4d040d35a98"
zmediaCharSilentius.Name = "CharSilentius"
zmediaCharSilentius.AltText = ""
zmediaCharSilentius.Resources = {
  {
    Type = "jpg",
    Filename = "Moench5.jpg",
    Directives = {}
  }
}
zmediaCharWissenschaftler1 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharWissenschaftler1.Id = "a6a407ad605e6a17cc2dd6b6b351c2c8"
zmediaCharWissenschaftler1.Name = "CharWissenschaftler1"
zmediaCharWissenschaftler1.AltText = ""
zmediaCharWissenschaftler1.Resources = {
  {
    Type = "jpg",
    Filename = "Wissenschaftler1.jpg",
    Directives = {}
  }
}
zmediaCharWissenschaftler2 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaCharWissenschaftler2.Id = "b20343b0e150b96e67507abbad2975e9"
zmediaCharWissenschaftler2.Name = "CharWissenschaftler2"
zmediaCharWissenschaftler2.AltText = ""
zmediaCharWissenschaftler2.Resources = {
  {
    Type = "jpg",
    Filename = "Wissenschaftler2.jpg",
    Directives = {}
  }
}
zmediaImageIntro = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageIntro.Id = "8f1b6e2707189e62dc421e540c5e71c8"
zmediaImageIntro.Name = "ImageIntro"
zmediaImageIntro.AltText = ""
zmediaImageIntro.Resources = {
  {
    Type = "jpg",
    Filename = "Intro.jpg",
    Directives = {}
  }
}
zmediaImageSignum1 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum1.Id = "7e732e709f974de3f5d1450766ab90bd"
zmediaImageSignum1.Name = "ImageSignum1"
zmediaImageSignum1.AltText = ""
zmediaImageSignum1.Resources = {
  {
    Type = "jpg",
    Filename = "Signum1.jpg",
    Directives = {}
  }
}
zmediaImageSignum2 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum2.Id = "203ba2c02ece8cb4a25ba234b9edcaf1"
zmediaImageSignum2.Name = "ImageSignum2"
zmediaImageSignum2.AltText = ""
zmediaImageSignum2.Resources = {
  {
    Type = "jpg",
    Filename = "Signum2.jpg",
    Directives = {}
  }
}
zmediaImageSignum3 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum3.Id = "023b225d25a4ae6b0eae7c9d2291a447"
zmediaImageSignum3.Name = "ImageSignum3"
zmediaImageSignum3.AltText = ""
zmediaImageSignum3.Resources = {
  {
    Type = "jpg",
    Filename = "Signum3.jpg",
    Directives = {}
  }
}
zmediaImageSignum4 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum4.Id = "033036fdb3eb253bf7b0d92777eecb2f"
zmediaImageSignum4.Name = "ImageSignum4"
zmediaImageSignum4.AltText = ""
zmediaImageSignum4.Resources = {
  {
    Type = "jpg",
    Filename = "Signum4.jpg",
    Directives = {}
  }
}
zmediaImageSignum5 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum5.Id = "04beb9f8fa00c5763098c5cf7663d223"
zmediaImageSignum5.Name = "ImageSignum5"
zmediaImageSignum5.AltText = ""
zmediaImageSignum5.Resources = {
  {
    Type = "jpg",
    Filename = "Signum5.jpg",
    Directives = {}
  }
}
zmediaImageSignum6 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum6.Id = "ee4e5b0d9b8385ce16c54fa7ee8fd713"
zmediaImageSignum6.Name = "ImageSignum6"
zmediaImageSignum6.AltText = ""
zmediaImageSignum6.Resources = {
  {
    Type = "jpg",
    Filename = "Signum6.jpg",
    Directives = {}
  }
}
zmediaImageSignum7 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaImageSignum7.Id = "0a8e1ec8752a390f0df27823a3c81038"
zmediaImageSignum7.Name = "ImageSignum7"
zmediaImageSignum7.AltText = ""
zmediaImageSignum7.Resources = {
  {
    Type = "jpg",
    Filename = "Signum7.jpg",
    Directives = {}
  }
}
zmediaItemAckerdistel = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemAckerdistel.Id = "d94c6dbc6119850c9799d0bccc2e504b"
zmediaItemAckerdistel.Name = "ItemAckerdistel"
zmediaItemAckerdistel.AltText = ""
zmediaItemAckerdistel.Resources = {
  {
    Type = "jpg",
    Filename = "Ackerdistel.jpg",
    Directives = {}
  }
}
zmediaItemArnika = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemArnika.Id = "2c4b05142ec4ce568dd493eadb697df1"
zmediaItemArnika.Name = "ItemArnika"
zmediaItemArnika.AltText = ""
zmediaItemArnika.Resources = {
  {
    Type = "jpg",
    Filename = "Arnika.jpg",
    Directives = {}
  }
}
zmediaItemBenediktinerkutte = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemBenediktinerkutte.Id = "c592762f6c6177c9d98e16cd11707c39"
zmediaItemBenediktinerkutte.Name = "ItemBenediktinerkutte"
zmediaItemBenediktinerkutte.AltText = ""
zmediaItemBenediktinerkutte.Resources = {}
zmediaItemDomenikanerkutte = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemDomenikanerkutte.Id = "c7143deb53733d0c3bfaeb61c74b694b"
zmediaItemDomenikanerkutte.Name = "ItemDomenikanerkutte"
zmediaItemDomenikanerkutte.AltText = ""
zmediaItemDomenikanerkutte.Resources = {}
zmediaItemEnergieversorgung = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemEnergieversorgung.Id = "f9e59b4d9a4dbbcd7e75349bdf251ca8"
zmediaItemEnergieversorgung.Name = "ItemEnergieversorgung"
zmediaItemEnergieversorgung.AltText = ""
zmediaItemEnergieversorgung.Resources = {
  {
    Type = "jpg",
    Filename = "Energieversorgung.jpg",
    Directives = {}
  }
}
zmediaItemFluxxKompensator = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemFluxxKompensator.Id = "b8631786e19d3e9073a1c1ad75011af7"
zmediaItemFluxxKompensator.Name = "ItemFluxx-Kompensator"
zmediaItemFluxxKompensator.AltText = ""
zmediaItemFluxxKompensator.Resources = {
  {
    Type = "jpg",
    Filename = "Fluxx.jpg",
    Directives = {}
  }
}
zmediaItemHuflattich = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemHuflattich.Id = "8c159a0ba3dea9731accdc5466b55ce8"
zmediaItemHuflattich.Name = "ItemHuflattich"
zmediaItemHuflattich.AltText = ""
zmediaItemHuflattich.Resources = {
  {
    Type = "jpg",
    Filename = "Huflattich.jpg",
    Directives = {}
  }
}
zmediaItemJohanniskraut = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemJohanniskraut.Id = "d14c23a45d1c66f625f33c87a34533ce"
zmediaItemJohanniskraut.Name = "ItemJohanniskraut"
zmediaItemJohanniskraut.AltText = ""
zmediaItemJohanniskraut.Resources = {
  {
    Type = "jpg",
    Filename = "Johanniskraut.jpg",
    Directives = {}
  }
}
zmediaItemKamille = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemKamille.Id = "40e4e4d6cad1be5208bc12663b212950"
zmediaItemKamille.Name = "ItemKamille"
zmediaItemKamille.AltText = ""
zmediaItemKamille.Resources = {
  {
    Type = "jpg",
    Filename = "Kamille.jpg",
    Directives = {}
  }
}
zmediaItemKlatschmohn = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemKlatschmohn.Id = "0bc375f215cb8a25d1364f38344bedd7"
zmediaItemKlatschmohn.Name = "ItemKlatschmohn"
zmediaItemKlatschmohn.AltText = ""
zmediaItemKlatschmohn.Resources = {
  {
    Type = "jpg",
    Filename = "Mohn.jpg",
    Directives = {}
  }
}
zmediaItemKuehlung = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemKuehlung.Id = "8b58aab96f99caee33499e4d34f0289b"
zmediaItemKuehlung.Name = "ItemKuehlung"
zmediaItemKuehlung.AltText = ""
zmediaItemKuehlung.Resources = {
  {
    Type = "jpg",
    Filename = "Kuehlung.jpg",
    Directives = {}
  }
}
zmediaItemMrzveilchen = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemMrzveilchen.Id = "72f16bc14295f56d66feef27a613158d"
zmediaItemMrzveilchen.Name = WWB_multiplatform_string("ItemM\195\164rzveilchen")
zmediaItemMrzveilchen.AltText = ""
zmediaItemMrzveilchen.Resources = {
  {
    Type = "jpg",
    Filename = "Veilchen.jpg",
    Directives = {}
  }
}
zmediaItemMistel = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemMistel.Id = "cea8cb62b520119cca290b10bd9abf0c"
zmediaItemMistel.Name = "ItemMistel"
zmediaItemMistel.AltText = ""
zmediaItemMistel.Resources = {
  {
    Type = "jpg",
    Filename = "Mistel.jpg",
    Directives = {}
  }
}
zmediaItemNotizbuch = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemNotizbuch.Id = "085516c0b9cec91fc67b7c392a7e36b6"
zmediaItemNotizbuch.Name = "ItemNotizbuch"
zmediaItemNotizbuch.AltText = ""
zmediaItemNotizbuch.Resources = {
  {
    Type = "jpg",
    Filename = "Notizbuch.jpg",
    Directives = {}
  }
}
zmediaItemPforte = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemPforte.Id = "58275afe9b065e5f29967e10b7e742cd"
zmediaItemPforte.Name = "ItemPforte"
zmediaItemPforte.AltText = ""
zmediaItemPforte.Resources = {
  {
    Type = "jpg",
    Filename = "Pforte.jpg",
    Directives = {}
  }
}
zmediaItemSchafgarbe = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemSchafgarbe.Id = "b8ba3d87a9708eb9e0eb62f6113a9d6e"
zmediaItemSchafgarbe.Name = "ItemSchafgarbe"
zmediaItemSchafgarbe.AltText = ""
zmediaItemSchafgarbe.Resources = {
  {
    Type = "jpg",
    Filename = "Schafgarbe.jpg",
    Directives = {}
  }
}
zmediaItemSpitzwegerich = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemSpitzwegerich.Id = "f593eaeb421351b2b7f2ed799f0ec618"
zmediaItemSpitzwegerich.Name = "ItemSpitzwegerich"
zmediaItemSpitzwegerich.AltText = ""
zmediaItemSpitzwegerich.Resources = {
  {
    Type = "jpg",
    Filename = "Spitzwegerich.jpg",
    Directives = {}
  }
}
zmediaItemStartknopf = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemStartknopf.Id = "70c6d0b0d7ffcd5c009c8b90318ab63f"
zmediaItemStartknopf.Name = "ItemStartknopf"
zmediaItemStartknopf.AltText = ""
zmediaItemStartknopf.Resources = {
  {
    Type = "jpg",
    Filename = "Schalter.jpg",
    Directives = {}
  }
}
zmediaItemWanduhr = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemWanduhr.Id = "cb2832fa4b655f05089b2d95d3201290"
zmediaItemWanduhr.Name = "ItemWanduhr"
zmediaItemWanduhr.AltText = ""
zmediaItemWanduhr.Resources = {
  {
    Type = "jpg",
    Filename = "Wanduhr.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine1 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine1.Id = "48c7c5d395e33e14c268f9a316747adf"
zmediaItemZeitmaschine1.Name = "ItemZeitmaschine1"
zmediaItemZeitmaschine1.AltText = ""
zmediaItemZeitmaschine1.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine1.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine2 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine2.Id = "3e5d1ed27dcd5b24e12a6918dccc7c1b"
zmediaItemZeitmaschine2.Name = "ItemZeitmaschine2"
zmediaItemZeitmaschine2.AltText = ""
zmediaItemZeitmaschine2.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine2.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine3 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine3.Id = "d3bfe30fc9eee4bfdedefc47d8013c76"
zmediaItemZeitmaschine3.Name = "ItemZeitmaschine3"
zmediaItemZeitmaschine3.AltText = ""
zmediaItemZeitmaschine3.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine3.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine4 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine4.Id = "9467f26af63b30ef79171eeefaafcb5f"
zmediaItemZeitmaschine4.Name = "ItemZeitmaschine4"
zmediaItemZeitmaschine4.AltText = ""
zmediaItemZeitmaschine4.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine4.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine5 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine5.Id = "31907ce6890bc98c7fc9ef39df6dd790"
zmediaItemZeitmaschine5.Name = "ItemZeitmaschine5"
zmediaItemZeitmaschine5.AltText = ""
zmediaItemZeitmaschine5.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine5.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine6 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine6.Id = "320a2b4934a692113794c449cdc9dbce"
zmediaItemZeitmaschine6.Name = "ItemZeitmaschine6"
zmediaItemZeitmaschine6.AltText = ""
zmediaItemZeitmaschine6.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine6.jpg",
    Directives = {}
  }
}
zmediaItemZeitmaschine7 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZeitmaschine7.Id = "19d753e3a15a3112ac1a6755c4d1ffad"
zmediaItemZeitmaschine7.Name = "ItemZeitmaschine7"
zmediaItemZeitmaschine7.AltText = ""
zmediaItemZeitmaschine7.Resources = {
  {
    Type = "jpg",
    Filename = "Zeitmaschine7.jpg",
    Directives = {}
  }
}
zmediaItemZisterzienserkutte = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaItemZisterzienserkutte.Id = "4f68d9f255ccd35410d0b4e25c4a2f56"
zmediaItemZisterzienserkutte.Name = "ItemZisterzienserkutte"
zmediaItemZisterzienserkutte.AltText = ""
zmediaItemZisterzienserkutte.Resources = {}
zmediaWherigo = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaWherigo.Id = "49ee7b776bf7dc7f4ed4250c6f96165c"
zmediaWherigo.Name = "Wherigo"
zmediaWherigo.AltText = ""
zmediaWherigo.Resources = {
  {
    Type = "jpg",
    Filename = "wherigo.jpg",
    Directives = {}
  }
}
zmediaZoneBibliothek = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneBibliothek.Id = "c080fedd5943c186cbe88b08dab56270"
zmediaZoneBibliothek.Name = "ZoneBibliothek"
zmediaZoneBibliothek.AltText = ""
zmediaZoneBibliothek.Resources = {
  {
    Type = "jpg",
    Filename = "Bibliothek.jpg",
    Directives = {}
  }
}
zmediaZoneBrunnen = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneBrunnen.Id = "94be63a5933f7b5b09e59d0bc85fcbdd"
zmediaZoneBrunnen.Name = "ZoneBrunnen"
zmediaZoneBrunnen.AltText = ""
zmediaZoneBrunnen.Resources = {
  {
    Type = "jpg",
    Filename = "Brunnen.jpg",
    Directives = {}
  }
}
zmediaZoneFischteich = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneFischteich.Id = "44061d6cf92636c81680a25fe61f59ec"
zmediaZoneFischteich.Name = "ZoneFischteich"
zmediaZoneFischteich.AltText = ""
zmediaZoneFischteich.Resources = {
  {
    Type = "jpg",
    Filename = "Fischteich.jpg",
    Directives = {}
  }
}
zmediaZoneFriedhof = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneFriedhof.Id = "13c12cdc923f75b0212ac6893b5e745d"
zmediaZoneFriedhof.Name = "ZoneFriedhof"
zmediaZoneFriedhof.AltText = ""
zmediaZoneFriedhof.Resources = {
  {
    Type = "jpg",
    Filename = "Friedhof.jpg",
    Directives = {}
  }
}
zmediaZoneGaestehaus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneGaestehaus.Id = "97ca1ce55f5df6b8cfa0ae516a96ce6c"
zmediaZoneGaestehaus.Name = "ZoneGaestehaus"
zmediaZoneGaestehaus.AltText = ""
zmediaZoneGaestehaus.Resources = {
  {
    Type = "jpg",
    Filename = "Gaestehaus.jpg",
    Directives = {}
  }
}
zmediaZoneGarten = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneGarten.Id = "83aef318700c1f1ce8ebc13697bffb77"
zmediaZoneGarten.Name = "ZoneGarten"
zmediaZoneGarten.AltText = ""
zmediaZoneGarten.Resources = {
  {
    Type = "jpg",
    Filename = "Garten.jpg",
    Directives = {}
  }
}
zmediaZoneGruenerTurm = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneGruenerTurm.Id = "8841d875bd108417a2ed567b56f54782"
zmediaZoneGruenerTurm.Name = "ZoneGruenerTurm"
zmediaZoneGruenerTurm.AltText = ""
zmediaZoneGruenerTurm.Resources = {
  {
    Type = "jpg",
    Filename = "GruenerTurm.jpg",
    Directives = {}
  }
}
zmediaZoneHubertus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneHubertus.Id = "ef7c541b0a2b91cdb5b27ed47117df81"
zmediaZoneHubertus.Name = "ZoneHubertus"
zmediaZoneHubertus.AltText = ""
zmediaZoneHubertus.Resources = {
  {
    Type = "jpg",
    Filename = "Hubertus.jpg",
    Directives = {}
  }
}
zmediaZoneInfirmarie = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneInfirmarie.Id = "7c498b0f55eb447c74088d524502f94f"
zmediaZoneInfirmarie.Name = "ZoneInfirmarie"
zmediaZoneInfirmarie.AltText = ""
zmediaZoneInfirmarie.Resources = {
  {
    Type = "jpg",
    Filename = "Infirmarie.jpg",
    Directives = {}
  }
}
zmediaZoneInformationstafel = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneInformationstafel.Id = "e72759ff45d79a430eaf3c42d0f6b3a4"
zmediaZoneInformationstafel.Name = "ZoneInformationstafel"
zmediaZoneInformationstafel.AltText = ""
zmediaZoneInformationstafel.Resources = {
  {
    Type = "jpg",
    Filename = "Infotafel.jpg",
    Directives = {}
  }
}
zmediaZoneInschrift = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneInschrift.Id = "421449662cb2ff0e48e8204e9656e18d"
zmediaZoneInschrift.Name = "ZoneInschrift"
zmediaZoneInschrift.AltText = ""
zmediaZoneInschrift.Resources = {
  {
    Type = "jpg",
    Filename = "Inschrift.jpg",
    Directives = {}
  }
}
zmediaZoneJohanneskapelle = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneJohanneskapelle.Id = "3d335cc1b42235fe57a1c4f0cbea272b"
zmediaZoneJohanneskapelle.Name = "ZoneJohanneskapelle"
zmediaZoneJohanneskapelle.AltText = ""
zmediaZoneJohanneskapelle.Resources = {
  {
    Type = "jpg",
    Filename = "Johanneskapelle.jpg",
    Directives = {}
  }
}
zmediaZoneKeller = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneKeller.Id = "cb071c9248184e6734b8efe168ce0a08"
zmediaZoneKeller.Name = "ZoneKeller"
zmediaZoneKeller.AltText = ""
zmediaZoneKeller.Resources = {
  {
    Type = "jpg",
    Filename = "Keller.jpg",
    Directives = {}
  }
}
zmediaZoneKlosterkueche = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneKlosterkueche.Id = "48be448e1643f6477671f6850ba140f8"
zmediaZoneKlosterkueche.Name = "ZoneKlosterkueche"
zmediaZoneKlosterkueche.AltText = ""
zmediaZoneKlosterkueche.Resources = {
  {
    Type = "jpg",
    Filename = "Klosterkueche.jpg",
    Directives = {}
  }
}
zmediaZoneKlostermauer = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneKlostermauer.Id = "c7b4b305781e0ed6fbbb7c157ff76e53"
zmediaZoneKlostermauer.Name = "ZoneKlostermauer"
zmediaZoneKlostermauer.AltText = ""
zmediaZoneKlostermauer.Resources = {
  {
    Type = "jpg",
    Filename = "Klostermauer.jpg",
    Directives = {}
  }
}
zmediaZoneKlosterpforte = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneKlosterpforte.Id = "bc9716cd8de7c3626e0f8c9ab93b3046"
zmediaZoneKlosterpforte.Name = "ZoneKlosterpforte"
zmediaZoneKlosterpforte.AltText = ""
zmediaZoneKlosterpforte.Resources = {
  {
    Type = "jpg",
    Filename = "Klosterpforte.jpg",
    Directives = {}
  }
}
zmediaZoneLabor = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneLabor.Id = "a34fcf18a8d55f0f10ad445c6120149a"
zmediaZoneLabor.Name = "ZoneLabor"
zmediaZoneLabor.AltText = ""
zmediaZoneLabor.Resources = {
  {
    Type = "jpg",
    Filename = "Labor.jpg",
    Directives = {}
  }
}
zmediaZoneLagerplatz1 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneLagerplatz1.Id = "e9915992c886f01043ea9350ba43de90"
zmediaZoneLagerplatz1.Name = "ZoneLagerplatz1"
zmediaZoneLagerplatz1.AltText = ""
zmediaZoneLagerplatz1.Resources = {
  {
    Type = "jpg",
    Filename = "Lagerplatz1.jpg",
    Directives = {}
  }
}
zmediaZoneLagerplatz2 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneLagerplatz2.Id = "c470b3634d0e199aaae1a978da4e546a"
zmediaZoneLagerplatz2.Name = "ZoneLagerplatz2"
zmediaZoneLagerplatz2.AltText = ""
zmediaZoneLagerplatz2.Resources = {
  {
    Type = "jpg",
    Filename = "Lagerplatz2.jpg",
    Directives = {}
  }
}
zmediaZoneLagerplatz3 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneLagerplatz3.Id = "9e4766ef53710e74eb2ff3ce9af5d17f"
zmediaZoneLagerplatz3.Name = "ZoneLagerplatz3"
zmediaZoneLagerplatz3.AltText = ""
zmediaZoneLagerplatz3.Resources = {
  {
    Type = "jpg",
    Filename = "Lagerplatz3.jpg",
    Directives = {}
  }
}
zmediaZoneLagerplatz4 = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneLagerplatz4.Id = "1688193219f1c30a2b952069f8aea653"
zmediaZoneLagerplatz4.Name = "ZoneLagerplatz4"
zmediaZoneLagerplatz4.AltText = ""
zmediaZoneLagerplatz4.Resources = {
  {
    Type = "jpg",
    Filename = "Lagerplatz4.jpg",
    Directives = {}
  }
}
zmediaZoneVersuchsgelaende = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneVersuchsgelaende.Id = "d1c96dacb2c6a28146474768dca1a662"
zmediaZoneVersuchsgelaende.Name = "ZoneVersuchsgelaende"
zmediaZoneVersuchsgelaende.AltText = ""
zmediaZoneVersuchsgelaende.Resources = {
  {
    Type = "jpg",
    Filename = "Versuchsgelaende.jpg",
    Directives = {}
  }
}
zmediaZoneWaschhaus = Wherigo.ZMedia(cartDasGeheimnisdesKlosters)
zmediaZoneWaschhaus.Id = "d37be032e7d039efae17a2697bed4579"
zmediaZoneWaschhaus.Name = "ZoneWaschhaus"
zmediaZoneWaschhaus.AltText = ""
zmediaZoneWaschhaus.Resources = {
  {
    Type = "jpg",
    Filename = "Waschhaus.jpg",
    Directives = {}
  }
}
cartDasGeheimnisdesKlosters.Id = "9727862b-2fb4-4867-bf07-92f17aef0229"
cartDasGeheimnisdesKlosters.Name = "Das Geheimnis des Klosters"
cartDasGeheimnisdesKlosters.Activity = "Geocache"
cartDasGeheimnisdesKlosters.Version = "1.7"
cartDasGeheimnisdesKlosters.Company = ""
cartDasGeheimnisdesKlosters.Author = "Charlenni"
cartDasGeheimnisdesKlosters.TargetDevice = "PocketPC"
cartDasGeheimnisdesKlosters.TargetDeviceVersion = "0"
cartDasGeheimnisdesKlosters.BuilderVersion = "WWB v0.3.2012.01.17.100333"
cartDasGeheimnisdesKlosters.StateId = "1"
cartDasGeheimnisdesKlosters.CountryId = "2"
cartDasGeheimnisdesKlosters.Description = [[
Zeitreisen werden in Zukunft vielleicht moeglich sein. Hier koennt ihr feststellen, ob ihr das auch wirklich wollt.<BR>
<BR>
Die Cartridge spielt im schoenen Kloster Bebenhausen. Sie besteht aus zwei Teilen: einem ersten auf dem Parkplatz und einem zweiten im Kloster selbst. Der kostenpflichtige Teil des Klosters muss nicht betreten werden.<BR>
<BR>
Aufwand duerfte bei 3-4 h und ca. 5 km liegen. Bis auf wenige Meter liegt alles auf befestigten Wegen.<BR>
<BR>
Der zugehoerige Geocache ist bei www.geocaching.com mit der Nummer GC2TGWW gelistet.]]
cartDasGeheimnisdesKlosters.StartingLocationDescription = "Hier gibt es, wenn es nicht gerade ein schoener Sonntag ist, genuegend freie Parkplaetze."
cartDasGeheimnisdesKlosters.Visible = true
cartDasGeheimnisdesKlosters.Complete = false
cartDasGeheimnisdesKlosters.UseLogging = true
cartDasGeheimnisdesKlosters.CreateDate = "8/21/2009 09:49:13 PM"
cartDasGeheimnisdesKlosters.PublishDate = "1/1/2001 12:00:00 AM"
cartDasGeheimnisdesKlosters.UpdateDate = "11/18/2011 10:07:10 PM"
cartDasGeheimnisdesKlosters.LastPlayedDate = "1/1/2001 12:00:00 AM"
cartDasGeheimnisdesKlosters.Media = zmediaImageIntro
cartDasGeheimnisdesKlosters.StartingLocation = ZonePoint(48.556717, 9.065883, 0)
zoneBewegung = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneBewegung.Id = "cb97d1561af17c00c4d8d4d1a93f037f"
zoneBewegung.Name = "Bewegung"
zoneBewegung.DistanceRangeUOM = "Meters"
zoneBewegung.ProximityRangeUOM = "Meters"
zoneBewegung.ShowObjects = "OnEnter"
zoneBewegung.OutOfRangeName = ""
zoneBewegung.InRangeName = ""
zoneBewegung.Description = WWB_multiplatform_string(WWB_deobf("Mspz6 2@0 lx5 o4wo r\195\1886 msp Os.up4ys 933 L26qs6 bswq07x@1H"))
zoneBewegung.Visible = false
zoneBewegung.AllowSetPositionTo = false
zoneBewegung.Active = false
zoneBewegung.DistanceRange = Distance(-1, "meters")
zoneBewegung.ProximityRange = Distance(0, "meters")
zoneBewegung.Points = {
  ZonePoint(48.563771610497, 9.0614247322083, 0),
  ZonePoint(48.566810402168, 9.0623259544373, 0),
  ZonePoint(48.567037594209, 9.0598368644714, 0),
  ZonePoint(48.564339622815, 9.0593862533569, 0),
  ZonePoint(48.562592964586, 9.0592360496521, 0),
  ZonePoint(48.561343285911, 9.0583992004394, 0),
  ZonePoint(48.560917252033, 9.0602660179138, 0),
  ZonePoint(48.56218114207, 9.0612101554871, 0)
}
zoneBewegung.OriginalPoint = ZonePoint(48.563785810883, 9.0602445602417, 0)
zoneBibliothek = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneBibliothek.Id = "57599974b329883ff0fb66a5edd23b19"
zoneBibliothek.Name = "Bibliothek"
zoneBibliothek.DistanceRangeUOM = "Meters"
zoneBibliothek.ProximityRangeUOM = "Meters"
zoneBibliothek.ShowObjects = "OnEnter"
zoneBibliothek.OutOfRangeName = ""
zoneBibliothek.InRangeName = ""
zoneBibliothek.Description = WWB_deobf("Ksmxv28xnu 60r il1t1626y3w pr6 auy35r57 Komq0vp@1oyJ")
zoneBibliothek.Visible = true
zoneBibliothek.AllowSetPositionTo = false
zoneBibliothek.Active = false
zoneBibliothek.DistanceRange = Distance(-1, "meters")
zoneBibliothek.ProximityRange = Distance(0, "meters")
zoneBibliothek.Points = {
  ZonePoint(48.560938553812, 9.0593165159225, 0),
  ZonePoint(48.56105216315, 9.0595632791519, 0),
  ZonePoint(48.561219026401, 9.0593835711479, 0),
  ZonePoint(48.561101867154, 9.0591394901276, 0)
}
zoneBibliothek.OriginalPoint = ZonePoint(48.561094766585, 9.0594157576561, 0)
zoneBibliothek.Media = zmediaZoneBibliothek
zoneBrunnen = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneBrunnen.Id = "41bc0b3c7e2b0e8e2026f05b2f509adf"
zoneBrunnen.Name = "Brunnen"
zoneBrunnen.DistanceRangeUOM = "Meters"
zoneBrunnen.ProximityRangeUOM = "Meters"
zoneBrunnen.ShowObjects = "OnEnter"
zoneBrunnen.OutOfRangeName = ""
zoneBrunnen.InRangeName = ""
zoneBrunnen.Description = WWB_deobf("K15z0s2 j43 qs1 mk3 Xz382o2 jo78n1 nr~xuq3I")
zoneBrunnen.Visible = true
zoneBrunnen.AllowSetPositionTo = false
zoneBrunnen.Active = false
zoneBrunnen.DistanceRange = Distance(-1, "meters")
zoneBrunnen.ProximityRange = Distance(0, "meters")
zoneBrunnen.Points = {
  ZonePoint(48.561911325519, 9.0623715519905, 0),
  ZonePoint(48.562040908579, 9.0622964501381, 0),
  ZonePoint(48.561994755746, 9.0620362758636, 0),
  ZonePoint(48.561842096076, 9.062092602253, 0)
}
zoneBrunnen.OriginalPoint = ZonePoint(48.561943277537, 9.0622186660767, 0)
zoneBrunnen.Media = zmediaZoneBrunnen
zoneFriedhof = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneFriedhof.Id = "930a2ab6d3ed21224c984399d7e11e68"
zoneFriedhof.Name = "Friedhof"
zoneFriedhof.DistanceRangeUOM = "Meters"
zoneFriedhof.ProximityRangeUOM = "Meters"
zoneFriedhof.ShowObjects = "OnEnter"
zoneFriedhof.OutOfRangeName = ""
zoneFriedhof.InRangeName = ""
zoneFriedhof.Description = WWB_multiplatform_string(WWB_deobf("O1tqqv3v k5r rt2 ntq 9t713z3os2uw X\195\1821rxn mqvut8n3@5 @t7moyJ"))
zoneFriedhof.Visible = true
zoneFriedhof.AllowSetPositionTo = false
zoneFriedhof.Active = false
zoneFriedhof.DistanceRange = Distance(-1, "meters")
zoneFriedhof.ProximityRange = Distance(0, "meters")
zoneFriedhof.Points = {
  ZonePoint(48.561852746713, 9.0609553456306, 0),
  ZonePoint(48.561957478436, 9.0609446167946, 0),
  ZonePoint(48.561909550386, 9.0606066584587, 0),
  ZonePoint(48.561737364054, 9.0605288743973, 0),
  ZonePoint(48.561732038694, 9.0608614683151, 0)
}
zoneFriedhof.OriginalPoint = ZonePoint(48.561819019501, 9.0607541799545, 0)
zoneFriedhof.Media = zmediaZoneFriedhof
zoneGarten = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneGarten.Id = "075f69e2d9662c56562505e7f495faf3"
zoneGarten.Name = "Garten"
zoneGarten.DistanceRangeUOM = "Meters"
zoneGarten.ProximityRangeUOM = "Meters"
zoneGarten.ShowObjects = "OnEnter"
zoneGarten.OutOfRangeName = ""
zoneGarten.InRangeName = ""
zoneGarten.Description = WWB_multiplatform_string(WWB_deobf("Pk25r1 tn2 Wy279n13, w2 mox uo9522\195\164pv0ylr Trw000\195\16466s6 o\195\1883 rxu Syrv51q0sp (Y6qwupz57p9ryy qs7 Tvz46s68) lztsqq33 8r5suwH"))
zoneGarten.Visible = true
zoneGarten.AllowSetPositionTo = false
zoneGarten.Active = false
zoneGarten.DistanceRange = Distance(-1, "meters")
zoneGarten.ProximityRange = Distance(0, "meters")
zoneGarten.Points = {
  ZonePoint(48.561092103857, 9.060113132, 0),
  ZonePoint(48.561235890236, 9.0601077675819, 0),
  ZonePoint(48.561214588576, 9.0597872436047, 0),
  ZonePoint(48.561096541715, 9.0597671270371, 0),
  ZonePoint(48.561041512257, 9.0600125491619, 0)
}
zoneGarten.OriginalPoint = ZonePoint(48.561140920267, 9.0600433945656, 0)
zoneGarten.Media = zmediaZoneGarten
zoneGstehaus = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneGstehaus.Id = "d6e204f07364da49edba4e6bdc764ff6"
zoneGstehaus.Name = WWB_multiplatform_string("G\195\164stehaus")
zoneGstehaus.DistanceRangeUOM = "Meters"
zoneGstehaus.ProximityRangeUOM = "Meters"
zoneGstehaus.ShowObjects = "OnEnter"
zoneGstehaus.OutOfRangeName = ""
zoneGstehaus.InRangeName = ""
zoneGstehaus.Description = WWB_multiplatform_string(WWB_deobf("P\195\16446swq32 r7s6 V\195\182zpvt jxoq4s6 X1oq0, tro zvqw9 sy qs2 rxyq4s2 Ko2qvqw mo3 Xz382o24 utxnx p\195\1886vnxI"))
zoneGstehaus.Visible = true
zoneGstehaus.AllowSetPositionTo = false
zoneGstehaus.Active = false
zoneGstehaus.DistanceRange = Distance(-1, "meters")
zoneGstehaus.ProximityRange = Distance(0, "meters")
zoneGstehaus.Points = {
  ZonePoint(48.55919710376, 9.0607300400734, 0),
  ZonePoint(48.559587648232, 9.0610063076019, 0),
  ZonePoint(48.559745640367, 9.0605288743973, 0),
  ZonePoint(48.559387050766, 9.0602606534958, 0)
}
zoneGstehaus.OriginalPoint = ZonePoint(48.559488237198, 9.060654938221, 0)
zoneGstehaus.Media = zmediaZoneGaestehaus
zoneGrnerTurm = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneGrnerTurm.Id = "a98ac4aaf41068fdfbd5298b7a6cd5b1"
zoneGrnerTurm.Name = WWB_multiplatform_string("Gr\195\188ner Turm")
zoneGrnerTurm.DistanceRangeUOM = "Meters"
zoneGrnerTurm.ProximityRangeUOM = "Meters"
zoneGrnerTurm.ShowObjects = "OnEnter"
zoneGrnerTurm.OutOfRangeName = ""
zoneGrnerTurm.InRangeName = ""
zoneGrnerTurm.Description = WWB_multiplatform_string(WWB_deobf("P1\195\1880s6 c42y, su0 oqz Pr2 lx5 P7kot55269 ntq07M"))
zoneGrnerTurm.Visible = true
zoneGrnerTurm.AllowSetPositionTo = false
zoneGrnerTurm.Active = false
zoneGrnerTurm.DistanceRange = Distance(-1, "meters")
zoneGrnerTurm.ProximityRange = Distance(0, "meters")
zoneGrnerTurm.Points = {
  ZonePoint(48.560723760462, 9.0613013505936, 0),
  ZonePoint(48.560832044827, 9.0613093972206, 0),
  ZonePoint(48.56083559513, 9.0611028671265, 0),
  ZonePoint(48.560727310773, 9.0610975027084, 0)
}
zoneGrnerTurm.OriginalPoint = ZonePoint(48.560768139328, 9.061191380024, 0)
zoneGrnerTurm.Media = zmediaZoneGruenerTurm
zoneHubertusschrein = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneHubertusschrein.Id = "515c58bf62d981a2646162e3782c4e3c"
zoneHubertusschrein.Name = "Hubertusschrein"
zoneHubertusschrein.DistanceRangeUOM = "Meters"
zoneHubertusschrein.ProximityRangeUOM = "Meters"
zoneHubertusschrein.ShowObjects = "OnEnter"
zoneHubertusschrein.OutOfRangeName = ""
zoneHubertusschrein.InRangeName = ""
zoneHubertusschrein.Description = WWB_deobf("bms3rw2 84 Qu5t3 np4 V0N R5nr58@1H")
zoneHubertusschrein.Visible = true
zoneHubertusschrein.AllowSetPositionTo = false
zoneHubertusschrein.Active = false
zoneHubertusschrein.DistanceRange = Distance(-1, "meters")
zoneHubertusschrein.ProximityRange = Distance(0, "meters")
zoneHubertusschrein.Points = {
  ZonePoint(48.565713477401, 9.0612691640854, 0),
  ZonePoint(48.566253065847, 9.0612906217575, 0),
  ZonePoint(48.566269040417, 9.0606763958931, 0),
  ZonePoint(48.565772051426, 9.0605154633522, 0)
}
zoneHubertusschrein.OriginalPoint = ZonePoint(48.565947773092, 9.0609580278397, 0)
zoneHubertusschrein.Media = zmediaZoneHubertus
zoneInfirmarie = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneInfirmarie.Id = "04298f416158a280708898bb119ba26b"
zoneInfirmarie.Name = "Infirmarie"
zoneInfirmarie.DistanceRangeUOM = "Meters"
zoneInfirmarie.ProximityRangeUOM = "Meters"
zoneInfirmarie.ShowObjects = "OnEnter"
zoneInfirmarie.OutOfRangeName = ""
zoneInfirmarie.InRangeName = ""
zoneInfirmarie.Description = WWB_multiplatform_string(WWB_deobf("T1lzxs282k4u11 tn2 Wy279n13, w2 mo2 qwt K1\195\188qs6 3xo qwt jxoq4s2 Ko70u1t7 np4 Y0413p35 quqkyprz8 5o2pr1M"))
zoneInfirmarie.Visible = true
zoneInfirmarie.AllowSetPositionTo = false
zoneInfirmarie.Active = false
zoneInfirmarie.DistanceRange = Distance(-1, "meters")
zoneInfirmarie.ProximityRange = Distance(0, "meters")
zoneInfirmarie.Points = {
  ZonePoint(48.561082340587, 9.0614649653435, 0),
  ZonePoint(48.561380563705, 9.0614059567451, 0),
  ZonePoint(48.561343285911, 9.0609768033028, 0),
  ZonePoint(48.561036186852, 9.0610653162003, 0)
}
zoneInfirmarie.OriginalPoint = ZonePoint(48.561220801539, 9.0612128376961, 0)
zoneInfirmarie.Media = zmediaZoneInfirmarie
zoneInformationstafel = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneInformationstafel.Id = "11aed1a2030047e395223439e22029fe"
zoneInformationstafel.Name = "Informationstafel"
zoneInformationstafel.DistanceRangeUOM = "Meters"
zoneInformationstafel.ProximityRangeUOM = "Meters"
zoneInformationstafel.ShowObjects = "OnEnter"
zoneInformationstafel.OutOfRangeName = ""
zoneInformationstafel.InRangeName = ""
zoneInformationstafel.Description = WWB_multiplatform_string(WWB_deobf("Rxq040p9ryy46ouuu \195\188os6 mk3 Tsqyn3 371s 3w pn6 auy35r5 Rnlpzuo98nxI"))
zoneInformationstafel.Visible = true
zoneInformationstafel.AllowSetPositionTo = false
zoneInformationstafel.Active = true
zoneInformationstafel.DistanceRange = Distance(-1, "meters")
zoneInformationstafel.ProximityRange = Distance(0, "meters")
zoneInformationstafel.Points = {
  ZonePoint(48.55725676311, 9.0646809339523, 0),
  ZonePoint(48.557436065779, 9.0647560358048, 0),
  ZonePoint(48.55747867226, 9.0645548701286, 0),
  ZonePoint(48.557294043916, 9.0644824504852, 0)
}
zoneInformationstafel.OriginalPoint = ZonePoint(48.557370380717, 9.0646407008171, 0)
zoneInformationstafel.Media = zmediaZoneInformationstafel
zoneInschrift = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneInschrift.Id = "f3535353c360a5b4dc49f873f7710ec6"
zoneInschrift.Name = "Inschrift"
zoneInschrift.DistanceRangeUOM = "Meters"
zoneInschrift.ProximityRangeUOM = "Meters"
zoneInschrift.ShowObjects = "OnEnter"
zoneInschrift.OutOfRangeName = ""
zoneInschrift.InRangeName = ""
zoneInschrift.Description = WWB_multiplatform_string(WWB_deobf("Rx3ou5xv2 lz rt7 Rl65@p3m @6 Sw7nx qv1t8 q20\195\159t3 Wlz0s7N"))
zoneInschrift.Visible = true
zoneInschrift.AllowSetPositionTo = false
zoneInschrift.Active = false
zoneInschrift.DistanceRange = Distance(-1, "meters")
zoneInschrift.ProximityRange = Distance(0, "meters")
zoneInschrift.Points = {
  ZonePoint(48.560913701736, 9.0610317885876, 0),
  ZonePoint(48.561018435404, 9.0610089898109, 0),
  ZonePoint(48.561002459096, 9.0608534216881, 0),
  ZonePoint(48.560902163268, 9.0608775615692, 0)
}
zoneInschrift.OriginalPoint = ZonePoint(48.560952754994, 9.0609580278397, 0)
zoneJohanneskapelle = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneJohanneskapelle.Id = "1b2159d1cbff0462351c527c724da5e4"
zoneJohanneskapelle.Name = "Johanneskapelle"
zoneJohanneskapelle.DistanceRangeUOM = "Meters"
zoneJohanneskapelle.ProximityRangeUOM = "Meters"
zoneJohanneskapelle.ShowObjects = "OnEnter"
zoneJohanneskapelle.OutOfRangeName = ""
zoneJohanneskapelle.InRangeName = ""
zoneJohanneskapelle.Description = WWB_deobf("Sysm01t8tk0qyzt ms2qx7 3nlpz rt2 Ul1v7t11klxK")
zoneJohanneskapelle.Visible = true
zoneJohanneskapelle.AllowSetPositionTo = false
zoneJohanneskapelle.Active = false
zoneJohanneskapelle.DistanceRange = Distance(-1, "meters")
zoneJohanneskapelle.ProximityRange = Distance(0, "meters")
zoneJohanneskapelle.Points = {
  ZonePoint(48.561459557034, 9.0609419345856, 0),
  ZonePoint(48.561633519436, 9.060924500227, 0),
  ZonePoint(48.561624643817, 9.060665667057, 0),
  ZonePoint(48.561450681385, 9.0606804192066, 0)
}
zoneJohanneskapelle.OriginalPoint = ZonePoint(48.561544763183, 9.0607997775078, 0)
zoneKeller = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneKeller.Id = "a38df4bf725801f4eb02d95b6f09f929"
zoneKeller.Name = "Keller"
zoneKeller.DistanceRangeUOM = "Meters"
zoneKeller.ProximityRangeUOM = "Meters"
zoneKeller.ShowObjects = "OnEnter"
zoneKeller.OutOfRangeName = ""
zoneKeller.InRangeName = ""
zoneKeller.Description = WWB_multiplatform_string(WWB_deobf("Qsp3 937 np3 h\195\1880 30yz tn1 epvp98 6q468ulu4 5sx3G"))
zoneKeller.Visible = true
zoneKeller.AllowSetPositionTo = false
zoneKeller.Active = false
zoneKeller.DistanceRange = Distance(-1, "meters")
zoneKeller.ProximityRange = Distance(0, "meters")
zoneKeller.Points = {
  ZonePoint(48.560665180299, 9.061025083065, 0),
  ZonePoint(48.560830269675, 9.0610438585281, 0),
  ZonePoint(48.560846246038, 9.0607434511185, 0),
  ZonePoint(48.560707784061, 9.0606951713562, 0)
}
zoneKeller.OriginalPoint = ZonePoint(48.560736186549, 9.0609043836594, 0)
zoneKeller.Media = zmediaZoneKeller
zoneKlosterkche = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneKlosterkche.Id = "92e445a8e7c9aaeec24a99c9b669fc13"
zoneKlosterkche.Name = WWB_multiplatform_string("Klosterk\195\188che")
zoneKlosterkche.DistanceRangeUOM = "Meters"
zoneKlosterkche.ProximityRangeUOM = "Meters"
zoneKlosterkche.ShowObjects = "OnEnter"
zoneKlosterkche.OutOfRangeName = ""
zoneKlosterkche.InRangeName = ""
zoneKlosterkche.Description = WWB_multiplatform_string(WWB_deobf("Tvz46s60\195\188ntr A@0 gq4637p4ys rt7 6px6zxsqoy Oss\195\1881qzv67u np3 a\195\182wmsqK"))
zoneKlosterkche.Visible = true
zoneKlosterkche.AllowSetPositionTo = false
zoneKlosterkche.Active = false
zoneKlosterkche.DistanceRange = Distance(-1, "meters")
zoneKlosterkche.ProximityRange = Distance(0, "meters")
zoneKlosterkche.Points = {
  ZonePoint(48.560899500544, 9.0603706240654, 0),
  ZonePoint(48.561185298767, 9.0603706240654, 0),
  ZonePoint(48.561163997092, 9.0601292252541, 0),
  ZonePoint(48.560938553812, 9.0601533651352, 0)
}
zoneKlosterkche.OriginalPoint = ZonePoint(48.561013109969, 9.0602579712868, 0)
zoneKlostermauer = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneKlostermauer.Id = "9bb5a6e6675c54c2b87f1414e9f833b2"
zoneKlostermauer.Name = "Klostermauer"
zoneKlostermauer.DistanceRangeUOM = "Meters"
zoneKlostermauer.ProximityRangeUOM = "Meters"
zoneKlostermauer.ShowObjects = "OnEnter"
zoneKlostermauer.OutOfRangeName = ""
zoneKlostermauer.InRangeName = ""
zoneKlostermauer.Description = WWB_multiplatform_string(WWB_deobf("c42y o9\195\159o2tnzq mo2 Xz382o2yn8t7wH"))
zoneKlostermauer.Visible = true
zoneKlostermauer.AllowSetPositionTo = false
zoneKlostermauer.Active = false
zoneKlostermauer.DistanceRange = Distance(-1, "meters")
zoneKlostermauer.ProximityRange = Distance(0, "meters")
zoneKlostermauer.Points = {
  ZonePoint(48.561623756255, 9.061387181282, 0),
  ZonePoint(48.561808368798, 9.0613657236099, 0),
  ZonePoint(48.561808368798, 9.0611189603806, 0),
  ZonePoint(48.561618430884, 9.0610626339912, 0)
}
zoneKlostermauer.OriginalPoint = ZonePoint(48.561687660673, 9.0612182021141, 0)
zoneKlostermauer.Media = zmediaZoneKlostermauer
zoneKlosterpforte = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneKlosterpforte.Id = "d9afeaaa37075428c675e8e7444b12bc"
zoneKlosterpforte.Name = "Klosterpforte"
zoneKlosterpforte.DistanceRangeUOM = "Meters"
zoneKlosterpforte.ProximityRangeUOM = "Meters"
zoneKlosterpforte.ShowObjects = "OnEnter"
zoneKlosterpforte.OutOfRangeName = ""
zoneKlosterpforte.InRangeName = ""
zoneKlosterpforte.Description = WWB_deobf("Nsy.vut Ypz36s t31nt rxu wlz rt3 syzr5t3 Lp3rwrx np4 Y0413p35 qu21p5r1 0jxyJ")
zoneKlosterpforte.Visible = true
zoneKlosterpforte.AllowSetPositionTo = false
zoneKlosterpforte.Active = false
zoneKlosterpforte.DistanceRange = Distance(-1, "meters")
zoneKlosterpforte.ProximityRange = Distance(0, "meters")
zoneKlosterpforte.Points = {
  ZonePoint(48.559891205702, 9.0614005923271, 0),
  ZonePoint(48.560042983768, 9.0616621077061, 0),
  ZonePoint(48.560192098765, 9.0614408254623, 0),
  ZonePoint(48.560066948698, 9.0611954033375, 0)
}
zoneKlosterpforte.OriginalPoint = ZonePoint(48.560027894749, 9.0614220499992, 0)
zoneKlosterpforte.Media = zmediaZoneKlosterpforte
zoneLabor = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneLabor.Id = "ec2a810abebd5911e24a2f2bb01a4ebe"
zoneLabor.Name = "Labor"
zoneLabor.DistanceRangeUOM = "Meters"
zoneLabor.ProximityRangeUOM = "Meters"
zoneLabor.ShowObjects = "OnEnter"
zoneLabor.OutOfRangeName = ""
zoneLabor.InRangeName = ""
zoneLabor.Description = WWB_multiplatform_string(WWB_deobf("Ukm045p@v xu6 su0 smypuu03tsr1 pns4yn6rxrxpJ W1 Nmv 57tx2 pu0 Z1nsoq468\195\164xoq4 1y2 6q46rxrooq0s2 V\195\182zpv70334q0L Qw2zz57t3 rp346rx2 fz15s33xrJ"))
zoneLabor.Visible = true
zoneLabor.AllowSetPositionTo = false
zoneLabor.Active = false
zoneLabor.DistanceRange = Distance(-1, "meters")
zoneLabor.ProximityRange = Distance(0, "meters")
zoneLabor.Points = {
  ZonePoint(48.557038403557, 9.0654990077019, 0),
  ZonePoint(48.557198178933, 9.065343439579, 0),
  ZonePoint(48.557239010336, 9.0651986002922, 0),
  ZonePoint(48.557178650858, 9.0650376677513, 0),
  ZonePoint(48.556963841542, 9.065335392952, 0)
}
zoneLabor.OriginalPoint = ZonePoint(48.55709698792, 9.0652656555176, 0)
zoneLabor.Media = zmediaZoneLabor
zoneLagerplatz1 = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneLagerplatz1.Id = "3cbe487dccb06e3d771e7cd4fc682f01"
zoneLagerplatz1.Name = "Lagerplatz1"
zoneLagerplatz1.DistanceRangeUOM = "Meters"
zoneLagerplatz1.ProximityRangeUOM = "Meters"
zoneLagerplatz1.ShowObjects = "OnEnter"
zoneLagerplatz1.OutOfRangeName = ""
zoneLagerplatz1.InRangeName = ""
zoneLagerplatz1.Description = WWB_multiplatform_string(WWB_deobf("Ukrq430q29 r\195\1886 jvwq4zty Ll66sx1nH"))
zoneLagerplatz1.Visible = true
zoneLagerplatz1.AllowSetPositionTo = false
zoneLagerplatz1.Active = false
zoneLagerplatz1.DistanceRange = Distance(-1, "meters")
zoneLagerplatz1.ProximityRange = Distance(0, "meters")
zoneLagerplatz1.Points = {
  ZonePoint(48.557286055174, 9.0652710199356, 0),
  ZonePoint(48.55747867226, 9.0651033818722, 0),
  ZonePoint(48.557490211509, 9.0650403499603, 0),
  ZonePoint(48.557447605038, 9.0650095045567, 0),
  ZonePoint(48.557290493364, 9.0651006996632, 0),
  ZonePoint(48.557269190049, 9.0652173757553, 0)
}
zoneLagerplatz1.OriginalPoint = ZonePoint(48.55736150435, 9.0651355683804, 0)
zoneLagerplatz1.Media = zmediaZoneLagerplatz1
zoneLagerplatz2 = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneLagerplatz2.Id = "8b3c111677b4e0124b304a19cc57cb32"
zoneLagerplatz2.Name = "Lagerplatz2"
zoneLagerplatz2.DistanceRangeUOM = "Meters"
zoneLagerplatz2.ProximityRangeUOM = "Meters"
zoneLagerplatz2.ShowObjects = "OnEnter"
zoneLagerplatz2.OutOfRangeName = ""
zoneLagerplatz2.InRangeName = ""
zoneLagerplatz2.Description = WWB_multiplatform_string(WWB_deobf("Ukrq430q29 r\195\1886 jvwq4zty Ll66sx1nH"))
zoneLagerplatz2.Visible = true
zoneLagerplatz2.AllowSetPositionTo = false
zoneLagerplatz2.Active = false
zoneLagerplatz2.DistanceRange = Distance(-1, "meters")
zoneLagerplatz2.ProximityRange = Distance(0, "meters")
zoneLagerplatz2.Points = {
  ZonePoint(48.556449005585, 9.0661561489105, 0),
  ZonePoint(48.556463208026, 9.0662553906441, 0),
  ZonePoint(48.556667367683, 9.066064953804, 0),
  ZonePoint(48.556695772439, 9.0659523010254, 0),
  ZonePoint(48.556695772439, 9.0658423304558, 0),
  ZonePoint(48.556617659321, 9.0658369660378, 0)
}
zoneLagerplatz2.OriginalPoint = ZonePoint(48.556576827415, 9.0660354495049, 0)
zoneLagerplatz2.Media = zmediaZoneLagerplatz2
zoneLagerplatz3 = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneLagerplatz3.Id = "0a9249e0e5d02f9cefcf5cd4466847f0"
zoneLagerplatz3.Name = "Lagerplatz3"
zoneLagerplatz3.DistanceRangeUOM = "Meters"
zoneLagerplatz3.ProximityRangeUOM = "Meters"
zoneLagerplatz3.ShowObjects = "OnEnter"
zoneLagerplatz3.OutOfRangeName = ""
zoneLagerplatz3.InRangeName = ""
zoneLagerplatz3.Description = WWB_multiplatform_string(WWB_deobf("Ukrq430q29 r\195\1886 jvwq4zty Ll66sx1nH"))
zoneLagerplatz3.Visible = true
zoneLagerplatz3.AllowSetPositionTo = false
zoneLagerplatz3.Active = false
zoneLagerplatz3.DistanceRange = Distance(-1, "meters")
zoneLagerplatz3.ProximityRange = Distance(0, "meters")
zoneLagerplatz3.Points = {
  ZonePoint(48.557531930311, 9.0649947524071, 0),
  ZonePoint(48.557546132449, 9.0650430321693, 0),
  ZonePoint(48.557796444468, 9.0648177266121, 0),
  ZonePoint(48.557636670982, 9.0647453069687, 0),
  ZonePoint(48.557565660381, 9.064793586731, 0)
}
zoneLagerplatz3.OriginalPoint = ZonePoint(48.557620693605, 9.0648445487022, 0)
zoneLagerplatz3.Media = zmediaZoneLagerplatz3
zoneLagerplatz4 = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneLagerplatz4.Id = "da9c0f7d5ba1a2eb72a83b924d6ccd86"
zoneLagerplatz4.Name = "Lagerplatz4"
zoneLagerplatz4.DistanceRangeUOM = "Meters"
zoneLagerplatz4.ProximityRangeUOM = "Meters"
zoneLagerplatz4.ShowObjects = "OnEnter"
zoneLagerplatz4.OutOfRangeName = ""
zoneLagerplatz4.InRangeName = ""
zoneLagerplatz4.Description = WWB_multiplatform_string(WWB_deobf("Ukrq430q29 r\195\1886 jvwq4zty Ll66sx1nH"))
zoneLagerplatz4.Visible = true
zoneLagerplatz4.AllowSetPositionTo = false
zoneLagerplatz4.Active = false
zoneLagerplatz4.DistanceRange = Distance(-1, "meters")
zoneLagerplatz4.ProximityRange = Distance(0, "meters")
zoneLagerplatz4.Points = {
  ZonePoint(48.5567153007, 9.0656921267509, 0),
  ZonePoint(48.556724177179, 9.0657752752304, 0),
  ZonePoint(48.556976268552, 9.0655553340912, 0),
  ZonePoint(48.556899931157, 9.0654239058495, 0),
  ZonePoint(48.556777436025, 9.0655955672264, 0)
}
zoneLagerplatz4.OriginalPoint = ZonePoint(48.556871526515, 9.0655526518822, 0)
zoneLagerplatz4.Media = zmediaZoneLagerplatz4
zoneTeich = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneTeich.Id = "e5c57b2567bce468092789c78af528df"
zoneTeich.Name = "Teich"
zoneTeich.DistanceRangeUOM = "Meters"
zoneTeich.ProximityRangeUOM = "Meters"
zoneTeich.ShowObjects = "OnEnter"
zoneTeich.OutOfRangeName = ""
zoneTeich.InRangeName = ""
zoneTeich.Description = WWB_deobf("cotou su1 Vx168u02 Nrpt3qk54r1, rx pr0 qw Q3rw8qpoy 71s rx pr5 Vj24q0~ty2 tyzs6 msp Sw7sqo srtp3poy 9s6tnxI")
zoneTeich.Visible = true
zoneTeich.AllowSetPositionTo = false
zoneTeich.Active = false
zoneTeich.DistanceRange = Distance(-1, "meters")
zoneTeich.ProximityRange = Distance(0, "meters")
zoneTeich.Points = {
  ZonePoint(48.562159840835, 9.06245470047, 0),
  ZonePoint(48.56231249946, 9.0623259544373, 0),
  ZonePoint(48.562223744501, 9.0621221065521, 0),
  ZonePoint(48.562067535396, 9.0622454881668, 0)
}
zoneTeich.OriginalPoint = ZonePoint(48.562177591861, 9.0623232722282, 0)
zoneTeich.Media = zmediaZoneFischteich
zoneVersuchsgelnde = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneVersuchsgelnde.Id = "62f22a1c39aeb7972aa0571c1ed60d0a"
zoneVersuchsgelnde.Name = WWB_multiplatform_string("Versuchsgel\195\164nde")
zoneVersuchsgelnde.DistanceRangeUOM = "Meters"
zoneVersuchsgelnde.ProximityRangeUOM = "Meters"
zoneVersuchsgelnde.ShowObjects = "OnEnter"
zoneVersuchsgelnde.OutOfRangeName = ""
zoneVersuchsgelnde.InRangeName = ""
zoneVersuchsgelnde.Description = WWB_multiplatform_string(WWB_deobf("eo247qw8pow\195\1641su np3 i2y4o24v7\195\1642 e\195\188px3poyJ"))
zoneVersuchsgelnde.Visible = true
zoneVersuchsgelnde.AllowSetPositionTo = false
zoneVersuchsgelnde.Active = false
zoneVersuchsgelnde.DistanceRange = Distance(-1, "meters")
zoneVersuchsgelnde.ProximityRange = Distance(0, "meters")
zoneVersuchsgelnde.Points = {
  ZonePoint(48.556436578445, 9.0663090348244, 0),
  ZonePoint(48.557931363907, 9.0649464726448, 0),
  ZonePoint(48.557814197046, 9.0646648406982, 0),
  ZonePoint(48.557540806648, 9.0645575523377, 0),
  ZonePoint(48.557466245373, 9.0649008750915, 0),
  ZonePoint(48.557217706999, 9.0648177266121, 0),
  ZonePoint(48.556399297008, 9.0661266446114, 0)
}
zoneVersuchsgelnde.OriginalPoint = ZonePoint(48.557176875578, 9.0651878714561, 0)
zoneVersuchsgelnde.Media = zmediaZoneVersuchsgelaende
zoneWaschhaus = Wherigo.Zone(cartDasGeheimnisdesKlosters)
zoneWaschhaus.Id = "206c3302374508957e8702f8cca7b52e"
zoneWaschhaus.Name = "Waschhaus"
zoneWaschhaus.DistanceRangeUOM = "Meters"
zoneWaschhaus.ProximityRangeUOM = "Meters"
zoneWaschhaus.ShowObjects = "OnEnter"
zoneWaschhaus.OutOfRangeName = ""
zoneWaschhaus.InRangeName = ""
zoneWaschhaus.Description = WWB_deobf("fk3ouvp@1 oq5 Z1x24q46 Rnlpzuo98nxI")
zoneWaschhaus.Visible = true
zoneWaschhaus.AllowSetPositionTo = false
zoneWaschhaus.Active = false
zoneWaschhaus.DistanceRange = Distance(-1, "meters")
zoneWaschhaus.ProximityRange = Distance(0, "meters")
zoneWaschhaus.Points = {
  ZonePoint(48.561481746207, 9.059671908617, 0),
  ZonePoint(48.561662808928, 9.0597926080227, 0),
  ZonePoint(48.561689435744, 9.0595029294491, 0),
  ZonePoint(48.561519023879, 9.0594358742237, 0)
}
zoneWaschhaus.OriginalPoint = ZonePoint(48.561585591079, 9.0596196055412, 0)
zoneWaschhaus.Media = zmediaZoneWaschhaus
zcharacterAbtJohannes = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGrnerTurm})
zcharacterAbtJohannes.Id = "f9871f1218bd3724cdd3381372b03e6d"
zcharacterAbtJohannes.Name = "Abt Johannes"
zcharacterAbtJohannes.Gender = "Male"
zcharacterAbtJohannes.Type = "NPC"
zcharacterAbtJohannes.Description = WWB_deobf("Jl4 W2wqwxp4, su0 oqz Z1x24q4 Qukoytn87uw 60468uq3")
zcharacterAbtJohannes.Visible = true
zcharacterAbtJohannes.ObjectLocation = ZonePoint(48.560768139328, 9.061191380024, 0)
zcharacterAbtJohannes.Media = zmediaCharAbt
zcharacterAbtJohannes.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterAbtJohannes.Commands.Ansprechen.Id = "519da5eb8e74608206ed054f4900fb13"
zcharacterAbtJohannes.Commands.Ansprechen.Custom = true
zcharacterAbtJohannes.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderFabulus = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneKlostermauer})
zcharacterBruderFabulus.Id = "e5821788b3a0471dfb2d52978ab06050"
zcharacterBruderFabulus.Name = "Bruder Fabulus"
zcharacterBruderFabulus.Gender = "Male"
zcharacterBruderFabulus.Type = "PC"
zcharacterBruderFabulus.Description = WWB_multiplatform_string(WWB_deobf("K15pr5 Vjl5x76, mo2 os79n Rq5qwylr4q0s6B\195\164sxr5 tn2 sn1Auw Vx168u02I"))
zcharacterBruderFabulus.Visible = true
zcharacterBruderFabulus.ObjectLocation = ZonePoint(48.561687660673, 9.0612182021141, 0)
zcharacterBruderFabulus.Media = zmediaCharFabulus
zcharacterBruderFabulus.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderFabulus.Commands.Ansprechen.Id = "cf61eac56d7600905e75fe4ef4f2c8b8"
zcharacterBruderFabulus.Commands.Ansprechen.Custom = true
zcharacterBruderFabulus.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderMalusvisus = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneTeich})
zcharacterBruderMalusvisus.Id = "53374efbb733061638a01955066e3ae6"
zcharacterBruderMalusvisus.Name = "Bruder Malusvisus"
zcharacterBruderMalusvisus.Gender = "Male"
zcharacterBruderMalusvisus.Type = "PC"
zcharacterBruderMalusvisus.Description = WWB_deobf("K15pr5 cjv548w7@1, pr5 rn24q O2wuo2 qs7 Tvz46s68 Lpnr1wq32pzK")
zcharacterBruderMalusvisus.Visible = true
zcharacterBruderMalusvisus.ObjectLocation = ZonePoint(48.562177591861, 9.0623232722282, 0)
zcharacterBruderMalusvisus.Media = zmediaCharMalusvisus
zcharacterBruderMalusvisus.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  }),
  Zeigen = Wherigo.ZCommand({
    Text = "Zeigen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  })
}
zcharacterBruderMalusvisus.Commands.Ansprechen.Id = "9ff9f8eb5ad068bcecda801af6f1ee9c"
zcharacterBruderMalusvisus.Commands.Ansprechen.Custom = true
zcharacterBruderMalusvisus.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderMalusvisus.Commands.Zeigen.Id = "b04b9ccf216f32f17c2eb734a5e746a2"
zcharacterBruderMalusvisus.Commands.Zeigen.Custom = true
zcharacterBruderMalusvisus.Commands.Zeigen.WorksWithAll = true
zcharacterBruderMedicus = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneInfirmarie})
zcharacterBruderMedicus.Id = "fe4c74d37a6754c1022dd1bb5eef0e78"
zcharacterBruderMedicus.Name = "Bruder Medicus"
zcharacterBruderMedicus.Gender = "Male"
zcharacterBruderMedicus.Type = "PC"
zcharacterBruderMedicus.Description = WWB_multiplatform_string(WWB_deobf("K15pr5 cnnto76, mo2 qwt t1lzxs2 V\195\182zpvt 3xo Os.4qxp3 rt8 Uw057t71 304u8N"))
zcharacterBruderMedicus.Visible = true
zcharacterBruderMedicus.ObjectLocation = ZonePoint(48.561220801539, 9.0612128376961, 0)
zcharacterBruderMedicus.Media = zmediaCharMedicus
zcharacterBruderMedicus.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderMedicus.Commands.Ansprechen.Id = "7ab7a1508d9fe1c0eb50d49d0b8a565c"
zcharacterBruderMedicus.Commands.Ansprechen.Custom = true
zcharacterBruderMedicus.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderObliviosus = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneJohanneskapelle})
zcharacterBruderObliviosus.Id = "6799f9388c3af8d729b8772ce4c0f697"
zcharacterBruderObliviosus.Name = "Bruder Obliviosus"
zcharacterBruderObliviosus.Gender = "Male"
zcharacterBruderObliviosus.Type = "PC"
zcharacterBruderObliviosus.Description = WWB_deobf("K15pr5 ekvt7v27@1, pr5 4o3 myzt8 6tou7xwn 6q4ux813I")
zcharacterBruderObliviosus.Visible = true
zcharacterBruderObliviosus.ObjectLocation = ZonePoint(48.561544763183, 9.0607997775078, 0)
zcharacterBruderObliviosus.Media = zmediaCharObliviosus
zcharacterBruderObliviosus.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderObliviosus.Commands.Ansprechen.Id = "3698cfae1b5f29be0076c9dcdd5f3531"
zcharacterBruderObliviosus.Commands.Ansprechen.Custom = true
zcharacterBruderObliviosus.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderOstiarius = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneKlosterpforte})
zcharacterBruderOstiarius.Id = "c1bf0ca391b034425059df747abc0e50"
zcharacterBruderOstiarius.Name = "Bruder Ostiarius"
zcharacterBruderOstiarius.Gender = "Male"
zcharacterBruderOstiarius.Type = "PC"
zcharacterBruderOstiarius.Description = WWB_deobf("K15pr5 e13tm4w98, oq4 sq1 e04 A@v tz0s6uw Mq4sxsq oq5 Z1x24q46 rn6lou7M")
zcharacterBruderOstiarius.Visible = false
zcharacterBruderOstiarius.ObjectLocation = ZonePoint(48.560027894749, 9.0614220499992, 0)
zcharacterBruderOstiarius.Media = zmediaCharOstarius
zcharacterBruderOstiarius.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderOstiarius.Commands.Ansprechen.Id = "88dc17aea48c272e079ba09a74c1c629"
zcharacterBruderOstiarius.Commands.Ansprechen.Custom = true
zcharacterBruderOstiarius.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderScribus = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneBibliothek})
zcharacterBruderScribus.Id = "8d22e624861e768060385f7eadf73173"
zcharacterBruderScribus.Name = "Bruder Scribus"
zcharacterBruderScribus.Gender = "Male"
zcharacterBruderScribus.Type = "PC"
zcharacterBruderScribus.Description = WWB_deobf("K15pr5 il1tn76, mo2 qwt J4q4vqw9 4pnr5 quvp O8tsqo2 qs6 K4pous6ur sm6L")
zcharacterBruderScribus.Visible = true
zcharacterBruderScribus.ObjectLocation = ZonePoint(48.561094766585, 9.0594157576561, 0)
zcharacterBruderScribus.Media = zmediaCharScribus
zcharacterBruderScribus.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderScribus.Commands.Ansprechen.Id = "9465521b7fd7f0cfcb667c61f5bfd29f"
zcharacterBruderScribus.Commands.Ansprechen.Custom = true
zcharacterBruderScribus.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderSignum = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneFriedhof})
zcharacterBruderSignum.Id = "c6b5be22dfeace47d70300c148bb9b4f"
zcharacterBruderSignum.Name = "Bruder Signum"
zcharacterBruderSignum.Gender = "Male"
zcharacterBruderSignum.Type = "PC"
zcharacterBruderSignum.Description = WWB_deobf("K15pr5 irqy6z, tn1 4vqw ko35r17 vs4 qs6 iotous28y1lous q32vq018N")
zcharacterBruderSignum.Visible = true
zcharacterBruderSignum.ObjectLocation = ZonePoint(48.561819019501, 9.0607541799545, 0)
zcharacterBruderSignum.Media = zmediaCharSignum
zcharacterBruderSignum.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderSignum.Commands.Ansprechen.Id = "04aec37ea6568fbaf2315cf83903da92"
zcharacterBruderSignum.Commands.Ansprechen.Custom = true
zcharacterBruderSignum.Commands.Ansprechen.WorksWithAll = true
zcharacterBruderSilentius = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneWaschhaus})
zcharacterBruderSilentius.Id = "74171f62f773614ed3bb707056d4cffb"
zcharacterBruderSilentius.Name = "Bruder Silentius"
zcharacterBruderSilentius.Gender = "Male"
zcharacterBruderSilentius.Type = "PC"
zcharacterBruderSilentius.Description = WWB_multiplatform_string(WWB_deobf("K15pr5 irvpz6w98, oqz u7\195\188sq4 .upoy rw2u1 gq4p6ulrpz5 syn k60ut qo2m76vu1mszv78uw 764rtN"))
zcharacterBruderSilentius.Visible = true
zcharacterBruderSilentius.ObjectLocation = ZonePoint(48.561585591079, 9.0596196055412, 0)
zcharacterBruderSilentius.Media = zmediaCharSilentius
zcharacterBruderSilentius.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterBruderSilentius.Commands.Ansprechen.Id = "6fd7643cd4b8cd2ae641a9d2bf1db5d7"
zcharacterBruderSilentius.Commands.Ansprechen.Custom = true
zcharacterBruderSilentius.Commands.Ansprechen.WorksWithAll = true
zcharacterGast = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGstehaus})
zcharacterGast.Id = "6dede17d20b2c96e0321125e6dc81fd1"
zcharacterGast.Name = "Gast"
zcharacterGast.Gender = "Male"
zcharacterGast.Type = "PC"
zcharacterGast.Description = WWB_multiplatform_string(WWB_deobf("Nsy To79, oq4 p@lr uz V\195\16424quo98 np4 Y0413p35 932o2srp6qlr4 v68N"))
zcharacterGast.Visible = true
zcharacterGast.ObjectLocation = ZonePoint(48.559488237198, 9.060654938221, 0)
zcharacterGast.Media = zmediaCharGast
zcharacterGast.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterGast.Commands.Ansprechen.Id = "640943fbdd178a6a7cf6f2e1e597d788"
zcharacterGast.Commands.Ansprechen.Custom = true
zcharacterGast.Commands.Ansprechen.WorksWithAll = true
zcharacterNovize = Wherigo.ZCharacter({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneKlosterkche})
zcharacterNovize.Id = "dd9f9c3f320b7789e46bc16215760b6c"
zcharacterNovize.Name = "Novize"
zcharacterNovize.Gender = "Male"
zcharacterNovize.Type = "PC"
zcharacterNovize.Description = WWB_multiplatform_string(WWB_deobf("Wy6u-s, mo34r1 X3xrq4 7ylr wn81 13txys2 u\195\164457M"))
zcharacterNovize.Visible = true
zcharacterNovize.ObjectLocation = ZonePoint(48.561013109969, 9.0602579712868, 0)
zcharacterNovize.Media = zmediaCharNovize
zcharacterNovize.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zcharacterNovize.Commands.Ansprechen.Id = "ba224d61056b5b5a21350c857356b2f9"
zcharacterNovize.Commands.Ansprechen.Custom = true
zcharacterNovize.Commands.Ansprechen.WorksWithAll = true
zitemAckerdistel = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemAckerdistel.Id = "42ce8e8fe7028668a671b76bef4ef864"
zitemAckerdistel.Name = "Ackerdistel"
zitemAckerdistel.Description = WWB_multiplatform_string(WWB_deobf("Jmvq4rx82ow 9w602 lz4svuwn m7t bnlp3, cyn1pz 82t Qlxys @wn 54sxr2 Pu0ut-nsoq9\195\1887vo2 n87N"))
zitemAckerdistel.Visible = true
zitemAckerdistel.Locked = false
zitemAckerdistel.Opened = false
zitemAckerdistel.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemAckerdistel.Media = zmediaItemAckerdistel
zitemAckerdistel.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemAckerdistel.Commands.Abstellen.Id = "5319049321564dff4ee205400a46bec4"
zitemAckerdistel.Commands.Abstellen.Custom = true
zitemAckerdistel.Commands.Abstellen.WorksWithAll = true
zitemAckerdistel.Commands.Mitnehmen.Id = "82060ad90eb8276443010c5004f6c7af"
zitemAckerdistel.Commands.Mitnehmen.Custom = true
zitemAckerdistel.Commands.Mitnehmen.WorksWithAll = true
zitemArnika = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemArnika.Id = "0e6078ce9d4638c1e21a7b646e5d4d52"
zitemArnika.Name = "Arnika"
zitemArnika.Description = WWB_multiplatform_string(WWB_deobf("\195\1325\195\159s61rms 9w6t K2zvyp9rxv575 .n17q0rt9, 604 p1uox osx f4ypr1, Kv55r5v\195\18823q0, g3o44pv93poy, jt713l6pv93poy, jt3nxpz6~\195\188wn5zts2 3xo Ts0uwu3ou0t78oyJ<\001\002>\n\003\003\003\003Sx3 dpq o98 K2zvypru\195\1885r1 xrvq5 utwnx Trw7u0upu6, 8x6tq apwnxmx\195\164w@wqpz, Sq0w35\195\1826@wqpz 82t lpu 6rx5kntr1 dn16q0L"))
zitemArnika.Visible = true
zitemArnika.Locked = false
zitemArnika.Opened = false
zitemArnika.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemArnika.Media = zmediaItemArnika
zitemArnika.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemArnika.Commands.Abstellen.Id = "821f916d4cf0c8c647ee2dca707058b0"
zitemArnika.Commands.Abstellen.Custom = true
zitemArnika.Commands.Abstellen.WorksWithAll = true
zitemArnika.Commands.Mitnehmen.Id = "44eaeb831f293d78eb46ed59ef9c6695"
zitemArnika.Commands.Mitnehmen.Custom = true
zitemArnika.Commands.Mitnehmen.WorksWithAll = true
zitemBenediktinerkutte = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLabor})
zitemBenediktinerkutte.Id = "34f7e5b7a7d81239b5e0957f44418c68"
zitemBenediktinerkutte.Name = "Benediktinerkutte"
zitemBenediktinerkutte.Description = WWB_deobf("T445r tywo3 Os2umsv5v1t7vypzpvt8")
zitemBenediktinerkutte.Visible = true
zitemBenediktinerkutte.Locked = false
zitemBenediktinerkutte.Opened = false
zitemBenediktinerkutte.ObjectLocation = ZonePoint(48.55709698792, 9.0652656555176, 0)
zitemBenediktinerkutte.Media = zmediaItemBenediktinerkutte
zitemBenediktinerkutte.Commands = {
  Anziehen = Wherigo.ZCommand({
    Text = "Anziehen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  }),
  Ausziehen = Wherigo.ZCommand({
    Text = "Ausziehen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  })
}
zitemBenediktinerkutte.Commands.Anziehen.Id = "dd09b6e631d3221259bbf0b5c26b1e0c"
zitemBenediktinerkutte.Commands.Anziehen.Custom = true
zitemBenediktinerkutte.Commands.Anziehen.WorksWithAll = true
zitemBenediktinerkutte.Commands.Ausziehen.Id = "45ac34b040846f0fe7d4c3d77c0b4cba"
zitemBenediktinerkutte.Commands.Ausziehen.Custom = true
zitemBenediktinerkutte.Commands.Ausziehen.WorksWithAll = true
zitemDominikanerkutte = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLabor})
zitemDominikanerkutte.Id = "504ad1657915e0087cba26a1f8b1bc74"
zitemDominikanerkutte.Name = "Dominikanerkutte"
zitemDominikanerkutte.Description = WWB_deobf("T445r tywo3 Q21ywsvm0s62xoyous7")
zitemDominikanerkutte.Visible = true
zitemDominikanerkutte.Locked = false
zitemDominikanerkutte.Opened = false
zitemDominikanerkutte.ObjectLocation = ZonePoint(48.55709698792, 9.0652656555176, 0)
zitemDominikanerkutte.Media = zmediaItemDomenikanerkutte
zitemDominikanerkutte.Commands = {
  Anziehen = Wherigo.ZCommand({
    Text = "Anziehen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  }),
  Ausziehen = Wherigo.ZCommand({
    Text = "Ausziehen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  })
}
zitemDominikanerkutte.Commands.Anziehen.Id = "576275329d71f40cfcabe2fafdf4ff01"
zitemDominikanerkutte.Commands.Anziehen.Custom = true
zitemDominikanerkutte.Commands.Anziehen.WorksWithAll = true
zitemDominikanerkutte.Commands.Ausziehen.Id = "965c8236b8b1470c587281a726dec393"
zitemDominikanerkutte.Commands.Ausziehen.Custom = true
zitemDominikanerkutte.Commands.Ausziehen.WorksWithAll = true
zitemEnergieversorgung = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLagerplatz1})
zitemEnergieversorgung.Id = "66f5736fa55d4d6466da130c025d2af6"
zitemEnergieversorgung.Name = "Energieversorgung"
zitemEnergieversorgung.Description = WWB_multiplatform_string(WWB_deobf("Nxp3twt.n1304u93p, srsxwwo4 70 urxp msx9vk3ouw2u wt5 rt7 Oyq4uxu 95 8s68x1rq0, tro nr1\195\1822sr5 @x7m, 6z x3 ntq jt7pkysr1wur3 .7 6ur2pz"))
zitemEnergieversorgung.Visible = true
zitemEnergieversorgung.Locked = false
zitemEnergieversorgung.Opened = false
zitemEnergieversorgung.ObjectLocation = ZonePoint(48.55736150435, 9.0651355683804, 0)
zitemEnergieversorgung.Commands = {
  Anbauen = Wherigo.ZCommand({
    Text = "Anbauen",
    EmptyTargetListText = "Hier kann nichts angebaut werden",
    CmdWith = true,
    Enabled = true
  })
}
zitemEnergieversorgung.Commands.Anbauen.Id = "c6c50dd65b466d1d70af2a77046987a2"
zitemEnergieversorgung.Commands.Anbauen.Custom = true
zitemEnergieversorgung.Commands.Anbauen.WorksWithAll = false
zitemEnergieversorgung.Commands.Anbauen.WorksWithListIds = {
  "9d8de4bdb4f5ff5167bd15e51596dcb8"
}
zitemFluxxKompensator = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLagerplatz2})
zitemFluxxKompensator.Id = "9a7c25b732e62f6295280f780d6d7d30"
zitemFluxxKompensator.Name = "Fluxx-Kompensator"
zitemFluxxKompensator.Description = WWB_deobf("Ov59@MZ4vzpz5o840, srsxwwo4 70 2r3 Tvzuu otzr5 pns4yn6rxrxp qwt iot5 ~9 tyx1r17yn1pz")
zitemFluxxKompensator.Visible = true
zitemFluxxKompensator.Locked = false
zitemFluxxKompensator.Opened = false
zitemFluxxKompensator.ObjectLocation = ZonePoint(48.556576827415, 9.0660354495049, 0)
zitemFluxxKompensator.Commands = {
  Anbauen = Wherigo.ZCommand({
    Text = "Anbauen",
    EmptyTargetListText = "Hier kann nichts angebaut werden",
    CmdWith = false,
    Enabled = true
  })
}
zitemFluxxKompensator.Commands.Anbauen.Id = "89ab78856cecf494797a07118691afe3"
zitemFluxxKompensator.Commands.Anbauen.Custom = true
zitemFluxxKompensator.Commands.Anbauen.WorksWithAll = true
zitemHuflattich = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemHuflattich.Id = "d138e4fe3ae35a272db1b882a4f951e8"
zitemHuflattich.Name = "Huflattich"
zitemHuflattich.Description = WWB_multiplatform_string(WWB_deobf("Msp jw6013zrss tn1 bszp38o 8v5zuw 3ouztyvv\195\1825s2t, our Q1\195\16445r5 uw3smy7t3 ft5n0x3 MI Rw2 cop n87 moy Oz\195\16423p30 3tn1 Ny\195\1889nx 8v5z9 rp38267jqpzq vupoy esxBq435r1, K1zzpvx9r2 60r Q13synL"))
zitemHuflattich.Visible = true
zitemHuflattich.Locked = false
zitemHuflattich.Opened = false
zitemHuflattich.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemHuflattich.Media = zmediaItemHuflattich
zitemHuflattich.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemHuflattich.Commands.Abstellen.Id = "034d3e5b9460b9d2b5915cc5b3abb55a"
zitemHuflattich.Commands.Abstellen.Custom = true
zitemHuflattich.Commands.Abstellen.WorksWithAll = true
zitemHuflattich.Commands.Mitnehmen.Id = "5b759139c819061ec9f26938c2430204"
zitemHuflattich.Commands.Mitnehmen.Custom = true
zitemHuflattich.Commands.Mitnehmen.WorksWithAll = true
zitemInformationstafel = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneInformationstafel})
zitemInformationstafel.Id = "903a7a63c8c697f65c7460383317fd69"
zitemInformationstafel.Name = "Informationstafel"
zitemInformationstafel.Description = WWB_multiplatform_string(WWB_deobf("Rxq040p9ryy46ouuu xu6 u4uqpzqs6 J4q4pv6yo3:\\~GBRa\\.EB\\BD9\\.E~Pg\\9C~\\~BBXro2 x\195\1823w3p n0 Uwnp qsx3 P2qv6rxjv4o1rt 13ptr1M"))
zitemInformationstafel.Visible = true
zitemInformationstafel.Locked = false
zitemInformationstafel.Opened = false
zitemInformationstafel.ObjectLocation = ZonePoint(48.557370380717, 9.0646407008171, 0)
zitemJohanniskraut = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemJohanniskraut.Id = "db5282e503c18573c95a15ebfdc3096e"
zitemJohanniskraut.Name = "Johanniskraut"
zitemJohanniskraut.Description = WWB_multiplatform_string(WWB_deobf("Tkyz ztylr4q px8 wt56s08lr7q4s Tnz2q56x4woy 71s wo27\195\1827u ey37vt 3xo N1v829546\195\1643mo trw0uwH"))
zitemJohanniskraut.Visible = true
zitemJohanniskraut.Locked = false
zitemJohanniskraut.Opened = false
zitemJohanniskraut.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemJohanniskraut.Media = zmediaItemJohanniskraut
zitemJohanniskraut.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemJohanniskraut.Commands.Abstellen.Id = "8f8a57ce5386b4c70867dabb16e4d0c6"
zitemJohanniskraut.Commands.Abstellen.Custom = true
zitemJohanniskraut.Commands.Abstellen.WorksWithAll = true
zitemJohanniskraut.Commands.Mitnehmen.Id = "4024cc8aea91ff300137998ab94799df"
zitemJohanniskraut.Commands.Mitnehmen.Custom = true
zitemJohanniskraut.Commands.Mitnehmen.WorksWithAll = true
zitemKamille = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemKamille.Id = "96490fd4b40d385d8e7bc349ca57ab35"
zitemKamille.Name = "Kamille"
zitemKamille.Description = WWB_deobf("c1lpv7x4wowx @x7m 3ur qur Xmts2O 4yp Rp7vlp4pv.u0npz &nbsp;p3po7m0r8N ctq @x7t3 4pv1u09J 71s t1ly2t79rvwq0r, 1y7ur .@wnsqvzt3mH")
zitemKamille.Visible = true
zitemKamille.Locked = false
zitemKamille.Opened = false
zitemKamille.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemKamille.Media = zmediaItemKamille
zitemKamille.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemKamille.Commands.Abstellen.Id = "ac088352f799461add5901f021cddb4c"
zitemKamille.Commands.Abstellen.Custom = true
zitemKamille.Commands.Abstellen.WorksWithAll = true
zitemKamille.Commands.Mitnehmen.Id = "68d3558ef7185f18ac88d6fdeee9a1bf"
zitemKamille.Commands.Mitnehmen.Custom = true
zitemKamille.Commands.Mitnehmen.WorksWithAll = true
zitemKlatschmohn = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemKlatschmohn.Id = "a87960ceec105a11896f570a91f5815a"
zitemKlatschmohn.Name = "Klatschmohn"
zitemKlatschmohn.Description = WWB_multiplatform_string(WWB_deobf("Msp Oz\195\1882oy 9w60nx nr59xrqpzq 93m 3ou0t7824uyzt3mH Pnvt7 ptzqs2 1sp N1.uwn5zt qur cqv~w@13pz, P82rxm, 2u05\195\1825s6 \195\156mq4oz9r5t5\195\1648, cntyou1x2tsxsx9G"))
zitemKlatschmohn.Visible = true
zitemKlatschmohn.Locked = false
zitemKlatschmohn.Opened = false
zitemKlatschmohn.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemKlatschmohn.Media = zmediaItemKlatschmohn
zitemKlatschmohn.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemKlatschmohn.Commands.Abstellen.Id = "4c843b68e2723373bf0f9a00b26f3656"
zitemKlatschmohn.Commands.Abstellen.Custom = true
zitemKlatschmohn.Commands.Abstellen.WorksWithAll = true
zitemKlatschmohn.Commands.Mitnehmen.Id = "240018da586b9234afe5f91be1311ea2"
zitemKlatschmohn.Commands.Mitnehmen.Custom = true
zitemKlatschmohn.Commands.Mitnehmen.WorksWithAll = true
zitemKuehlung = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLagerplatz3})
zitemKuehlung.Id = "312c4768868023c8e48a345f68b82e49"
zitemKuehlung.Name = "Kuehlung"
zitemKuehlung.Description = WWB_multiplatform_string(WWB_deobf("T\195\188ty82w, rqrwv3n3 6z tywo lrw82j2ntv1t 84 w\195\188w1nx"))
zitemKuehlung.Visible = true
zitemKuehlung.Locked = false
zitemKuehlung.Opened = false
zitemKuehlung.ObjectLocation = ZonePoint(48.557620693605, 9.0648445487022, 0)
zitemKuehlung.Commands = {
  Anbauen = Wherigo.ZCommand({
    Text = "Anbauen",
    EmptyTargetListText = "Hier kann nichts angebaut werden",
    CmdWith = true,
    Enabled = true
  })
}
zitemKuehlung.Commands.Anbauen.Id = "f15d0543beaab190ed46d7f71076ca9f"
zitemKuehlung.Commands.Anbauen.Custom = true
zitemKuehlung.Commands.Anbauen.WorksWithAll = false
zitemKuehlung.Commands.Anbauen.WorksWithListIds = {
  "9d8de4bdb4f5ff5167bd15e51596dcb8"
}
zitemMrzveilchen = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemMrzveilchen.Id = "df31b3e815fbfec0876cbcf8b3879e12"
zitemMrzveilchen.Name = WWB_multiplatform_string("M\195\164rzveilchen")
zitemMrzveilchen.Description = WWB_multiplatform_string(WWB_deobf("fs2w6 q1332qv1xwnxo, vp7wI 60r 8lr7qv\195\15990otnr1s, oy5-\195\1883m4ys5vt2voyp 82t vpupv8 jlq\195\188v6uwnI i26-rorq0r -r1o r6 rns T768uw, N422sqs4u5 93m qurp6ypoy R5z\195\164v460ut3 otzts7u294J"))
zitemMrzveilchen.Visible = true
zitemMrzveilchen.Locked = false
zitemMrzveilchen.Opened = false
zitemMrzveilchen.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemMrzveilchen.Media = zmediaItemMrzveilchen
zitemMrzveilchen.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemMrzveilchen.Commands.Abstellen.Id = "3157e49bfa57dfb0a7784928a2e24540"
zitemMrzveilchen.Commands.Abstellen.Custom = true
zitemMrzveilchen.Commands.Abstellen.WorksWithAll = true
zitemMrzveilchen.Commands.Mitnehmen.Id = "0f50d8d344a1e45bd9a84b5a81e2e51e"
zitemMrzveilchen.Commands.Mitnehmen.Custom = true
zitemMrzveilchen.Commands.Mitnehmen.WorksWithAll = true
zitemMistel = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemMistel.Id = "7906f23a6141dcd1d2df987813cb3e1c"
zitemMistel.Name = "Mistel"
zitemMistel.Description = WWB_multiplatform_string(WWB_deobf("Msp S5\195\188lr4q rt7 Wt46s0 1syp uxv2sr, r3sq lx5 hqulp 8s6-nxoq6 3tn1 my6 R0ot n8uwnvps6, xnswq0 7yn P3s5xu04ysr1M Msp Zw79nvmx\195\16489n1 r\195\1826tn1y qs2 b3zrs@tsq2px 82t rl3z22y1sp3r1 tnx P4\195\1888nxsm76wqu3 pr6 a\195\18221r57N Ntq5s -n1oq0 tywqp4r7A9 lpu n9sto2w4o20qot5 82t ms311x8lrpz g84op7qpv7uuo2w4o203xrq0, Q03p3vs2.n1vmyy93p 5zq hsqvlsn1uquvI &nbsp;grxxx uz P12o2570 -31oq 6xu 5z3 o01nw m7qw porq0 Z7\195\164x1ss, Nztxr37yn 5zq WA13p3vs qwqp8n1s9G"))
zitemMistel.Visible = true
zitemMistel.Locked = false
zitemMistel.Opened = false
zitemMistel.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemMistel.Media = zmediaItemMistel
zitemMistel.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemMistel.Commands.Abstellen.Id = "3b17196aaa716977a67e5382cfaaa762"
zitemMistel.Commands.Abstellen.Custom = true
zitemMistel.Commands.Abstellen.WorksWithAll = true
zitemMistel.Commands.Mitnehmen.Id = "ee6ee05587fc3fc03efdbb9579cd0db6"
zitemMistel.Commands.Mitnehmen.Custom = true
zitemMistel.Commands.Mitnehmen.WorksWithAll = true
zitemNotizbuch = Wherigo.ZItem(cartDasGeheimnisdesKlosters)
zitemNotizbuch.Id = "891fdeff8d6ea4e93f38851a8872ef93"
zitemNotizbuch.Name = "Notizbuch"
zitemNotizbuch.Description = WWB_deobf("Wy4u-p9sq xu6 I bot5r1 B3w M7tAurmsq0 @4w 7upv8ypoy V1u40wl5v22uwH Nv6 zn3@5 w79 upu0s ins4q pt8lr2urpt3G")
zitemNotizbuch.Visible = true
zitemNotizbuch.Locked = false
zitemNotizbuch.Opened = false
zitemNotizbuch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemNotizbuch.Media = zmediaItemNotizbuch
zitemNotizbuch.Commands = {
  Notieren = Wherigo.ZCommand({
    Text = "Notieren",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemNotizbuch.Commands.Notieren.Id = "52d3d94ec3d717122baed7c349395357"
zitemNotizbuch.Commands.Notieren.Custom = true
zitemNotizbuch.Commands.Notieren.WorksWithAll = true
zitemPforte = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneKlosterpforte})
zitemPforte.Id = "ff6c8ceaa632d64529d60fcdb3a28aaa"
zitemPforte.Name = "Pforte"
zitemPforte.Description = WWB_deobf("Ypz36s tn2 Wy279n13 Osquwrl65s2")
zitemPforte.Visible = true
zitemPforte.Locked = false
zitemPforte.Opened = false
zitemPforte.ObjectLocation = ZonePoint(48.560027894749, 9.0614220499992, 0)
zitemPforte.Commands = {
  Anklopfen = Wherigo.ZCommand({
    Text = "Anklopfen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemPforte.Commands.Anklopfen.Id = "01305ad388e768c098c59aa24635290f"
zitemPforte.Commands.Anklopfen.Custom = true
zitemPforte.Commands.Anklopfen.WorksWithAll = true
zitemSchafgarbe = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemSchafgarbe.Id = "285136304d60b784f1d2b8fa29bb7a08"
zitemSchafgarbe.Name = "Schafgarbe"
zitemSchafgarbe.Description = WWB_multiplatform_string(WWB_deobf("Msp jw6013zrss -r1vq0 q1332qv1xwnxo, s298\195\188zq82w1rpyzs2t 4yp vtyu4ys5t\195\1820np30rM Mo2 gst xnp3 t6y1msq4 e7n234nt8 nsrzr7 8rms osx Vkrq0MSq0wJQ4y6qwu5zts2 3xo N34u2s4x16xwtot5K"))
zitemSchafgarbe.Visible = true
zitemSchafgarbe.Locked = false
zitemSchafgarbe.Opened = false
zitemSchafgarbe.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemSchafgarbe.Media = zmediaItemSchafgarbe
zitemSchafgarbe.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemSchafgarbe.Commands.Abstellen.Id = "4f2254748f7da4f7f42cbe9dbd452dd4"
zitemSchafgarbe.Commands.Abstellen.Custom = true
zitemSchafgarbe.Commands.Abstellen.WorksWithAll = true
zitemSchafgarbe.Commands.Mitnehmen.Id = "2873eaec24c478430ed2d7315d7b5b3f"
zitemSchafgarbe.Commands.Mitnehmen.Custom = true
zitemSchafgarbe.Commands.Mitnehmen.WorksWithAll = true
zitemSpitzwegerich = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneGarten})
zitemSpitzwegerich.Id = "6fe397cf16203182177712749c5e0f77"
zitemSpitzwegerich.Name = "Spitzwegerich"
zitemSpitzwegerich.Description = WWB_multiplatform_string(WWB_deobf("Msp jw6013zrss -r1vq0 7sqvpuzz\195\1821oyp 82t 954n01uw9tqus2tG g04 p1uox osx J3py9sv8n1v3n1z@wqpz @xu R546s2 xnp3 Z93poyq07A\195\188xo60uM"))
zitemSpitzwegerich.Visible = true
zitemSpitzwegerich.Locked = false
zitemSpitzwegerich.Opened = false
zitemSpitzwegerich.ObjectLocation = ZonePoint(48.561140920267, 9.0600433945656, 0)
zitemSpitzwegerich.Media = zmediaItemSpitzwegerich
zitemSpitzwegerich.Commands = {
  Abstellen = Wherigo.ZCommand({
    Text = "Abstellen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  }),
  Mitnehmen = Wherigo.ZCommand({
    Text = "Mitnehmen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  })
}
zitemSpitzwegerich.Commands.Abstellen.Id = "350642274f8030c6fc6803c7c865e805"
zitemSpitzwegerich.Commands.Abstellen.Custom = true
zitemSpitzwegerich.Commands.Abstellen.WorksWithAll = true
zitemSpitzwegerich.Commands.Mitnehmen.Id = "b7df30442f34eef998aedf2a45ea3b83"
zitemSpitzwegerich.Commands.Mitnehmen.Custom = true
zitemSpitzwegerich.Commands.Mitnehmen.WorksWithAll = true
zitemStartknopf = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLagerplatz4})
zitemStartknopf.Id = "5d136a61e74d0acacddfffe47b9196dc"
zitemStartknopf.Name = "Startknopf"
zitemStartknopf.Description = WWB_deobf("b3l36y24yp, 428, qpqvu2u2 5y sx3n kqv71q1msu0s B3 35n58uw")
zitemStartknopf.Visible = true
zitemStartknopf.Locked = false
zitemStartknopf.Opened = false
zitemStartknopf.ObjectLocation = ZonePoint(48.556871526515, 9.0655526518822, 0)
zitemStartknopf.Commands = {
  Anbauen = Wherigo.ZCommand({
    Text = "Anbauen",
    EmptyTargetListText = "Hier kann nichts angebaut werden",
    CmdWith = true,
    Enabled = true
  })
}
zitemStartknopf.Commands.Anbauen.Id = "4381c46fe5ad8df35f468e62d4de381e"
zitemStartknopf.Commands.Anbauen.Custom = true
zitemStartknopf.Commands.Anbauen.WorksWithAll = false
zitemStartknopf.Commands.Anbauen.WorksWithListIds = {
  "9d8de4bdb4f5ff5167bd15e51596dcb8"
}
zitemWanduhr = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLabor})
zitemWanduhr.Id = "167bbec649f40153566add5287f24462"
zitemWanduhr.Name = "Wanduhr"
zitemWanduhr.Description = WWB_deobf("fkyp7v6, k5r rt7 xzou zurxp to2Bn Xu088u 2pu6 suv gq46rx5sypr1 tn1 iv67uw2ntnt81n1 7r5vqwqpz w79G")
zitemWanduhr.Visible = true
zitemWanduhr.Locked = false
zitemWanduhr.Opened = false
zitemWanduhr.ObjectLocation = ZonePoint(48.55709698792, 9.0652656555176, 0)
zitemZeitmaschine = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLabor})
zitemZeitmaschine.Id = "9d8de4bdb4f5ff5167bd15e51596dcb8"
zitemZeitmaschine.Name = "Zeitmaschine"
zitemZeitmaschine.Description = WWB_multiplatform_string(WWB_deobf("Qkwnss69rqp msx9vk3ouw2u, lz rt7 xzou p1uo2xrw jnswq o2wnll66 .u0npz 0\195\18812pz"))
zitemZeitmaschine.Visible = true
zitemZeitmaschine.Locked = false
zitemZeitmaschine.Opened = false
zitemZeitmaschine.ObjectLocation = ZonePoint(48.55709698792, 9.0652656555176, 0)
zitemZeitmaschine.Media = zmediaItemZeitmaschine1
zitemZeitmaschine2 = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLabor})
zitemZeitmaschine2.Id = "d5b1173686517e51bd31cfbda3a8d89f"
zitemZeitmaschine2.Name = "Zeitmaschine2"
zitemZeitmaschine2.Description = WWB_deobf("Ko43vsq8ko2qv7t iot5zo7sqsyq")
zitemZeitmaschine2.Visible = false
zitemZeitmaschine2.Locked = false
zitemZeitmaschine2.Opened = false
zitemZeitmaschine2.ObjectLocation = ZonePoint(48.55709698792, 9.0652656555176, 0)
zitemZeitmaschine2.Media = zmediaItemZeitmaschine5
zitemZeitmaschine2.Commands = {
  Einschalten = Wherigo.ZCommand({
    Text = "Einschalten",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  }),
  Eintippen = Wherigo.ZCommand({
    Text = "Eintippen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  })
}
zitemZeitmaschine2.Commands.Einschalten.Id = "a272c91a37cb8281c11f81d362ff5c8c"
zitemZeitmaschine2.Commands.Einschalten.Custom = true
zitemZeitmaschine2.Commands.Einschalten.WorksWithAll = true
zitemZeitmaschine2.Commands.Eintippen.Id = "3471d403f30006fffb1b9672a8da4c41"
zitemZeitmaschine2.Commands.Eintippen.Custom = true
zitemZeitmaschine2.Commands.Eintippen.WorksWithAll = true
zitemZisterzienserkutte = Wherigo.ZItem({Cartridge = cartDasGeheimnisdesKlosters, Container = zoneLabor})
zitemZisterzienserkutte.Id = "56526088416fd72977733e2107c4db92"
zitemZisterzienserkutte.Name = "Zisterzienserkutte"
zitemZisterzienserkutte.Description = WWB_deobf("T445r tywo3 mw79n1@ur17u0wzq0qwu1")
zitemZisterzienserkutte.Visible = true
zitemZisterzienserkutte.Locked = false
zitemZisterzienserkutte.Opened = false
zitemZisterzienserkutte.ObjectLocation = ZonePoint(48.55709698792, 9.0652656555176, 0)
zitemZisterzienserkutte.Media = zmediaItemZisterzienserkutte
zitemZisterzienserkutte.Commands = {
  Anziehen = Wherigo.ZCommand({
    Text = "Anziehen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = true
  }),
  Ausziehen = Wherigo.ZCommand({
    Text = "Ausziehen",
    EmptyTargetListText = "Nothing available",
    CmdWith = false,
    Enabled = false
  })
}
zitemZisterzienserkutte.Commands.Anziehen.Id = "d45221f72de2462635653df87d979eff"
zitemZisterzienserkutte.Commands.Anziehen.Custom = true
zitemZisterzienserkutte.Commands.Anziehen.WorksWithAll = true
zitemZisterzienserkutte.Commands.Ausziehen.Id = "b5a4b98113c4075e2e27c8dda89a82f3"
zitemZisterzienserkutte.Commands.Ausziehen.Custom = true
zitemZisterzienserkutte.Commands.Ausziehen.WorksWithAll = true
varAbt = 0
varBeutel = ""
varBewegungDist = 0
varBewegungMax = 0
varBewegungNum = 0
varBewegungPos = 0
varFabulus = 0
varMalusvisus = 0
varMedicus = 0
varMinuten = 0
varNewLine = "\\060BR\\062\\010"
varNotiz = ""
varNotizAnzahl = 0
varNotizText = ""
varObliviosus = 0
varOstiarius = 0
varPflanzen = 0
varPflanzenAnzahl = 0
varPflanzenText = ""
varScribus = 0
varSecurity = 0
varStartcode = ""
varTimeMachine = 0
varTimeMachineCode = ""
varWissenschaftler = 0
varZeit = 0
WWB_device = ""
cartDasGeheimnisdesKlosters.ZVariables = {
  varAbt = 0,
  varBeutel = "",
  varBewegungDist = 0,
  varBewegungMax = 0,
  varBewegungNum = 0,
  varBewegungPos = 0,
  varFabulus = 0,
  varMalusvisus = 0,
  varMedicus = 0,
  varMinuten = 0,
  varNewLine = "\\060BR\\062\\010",
  varNotiz = "",
  varNotizAnzahl = 0,
  varNotizText = "",
  varObliviosus = 0,
  varOstiarius = 0,
  varPflanzen = 0,
  varPflanzenAnzahl = 0,
  varPflanzenText = "",
  varScribus = 0,
  varSecurity = 0,
  varStartcode = "",
  varTimeMachine = 0,
  varTimeMachineCode = "",
  varWissenschaftler = 0,
  varZeit = 0,
  WWB_device = ""
}
buildervar = {}
buildervar.varAbt = {}
buildervar.varAbt.Id = "fd285e2b688f8e9b250bd0750b321642"
buildervar.varAbt.Name = "Abt"
buildervar.varAbt.Type = "Number"
buildervar.varAbt.Data = "0"
buildervar.varBeutel = {}
buildervar.varBeutel.Id = "faac04f0e0da3d315412e2d7c2f50113"
buildervar.varBeutel.Name = "Beutel"
buildervar.varBeutel.Type = "String"
buildervar.varBeutel.Data = ""
buildervar.varBewegungDist = {}
buildervar.varBewegungDist.Id = "1f7a4e8ad7e10154f33ac03396cfd434"
buildervar.varBewegungDist.Name = "BewegungDist"
buildervar.varBewegungDist.Type = "Number"
buildervar.varBewegungDist.Data = "0"
buildervar.varBewegungMax = {}
buildervar.varBewegungMax.Id = "49f3f2411987091cd8de7c930f028ecd"
buildervar.varBewegungMax.Name = "BewegungMax"
buildervar.varBewegungMax.Type = "Number"
buildervar.varBewegungMax.Data = "0"
buildervar.varBewegungNum = {}
buildervar.varBewegungNum.Id = "a1ea487d656465c2b32da1d64f5573f2"
buildervar.varBewegungNum.Name = "BewegungNum"
buildervar.varBewegungNum.Type = "Number"
buildervar.varBewegungNum.Data = "0"
buildervar.varBewegungPos = {}
buildervar.varBewegungPos.Id = "3cfc27f07d89bf7a93c09e4f6e9195e9"
buildervar.varBewegungPos.Name = "BewegungPos"
buildervar.varBewegungPos.Type = "Number"
buildervar.varBewegungPos.Data = "0"
buildervar.varFabulus = {}
buildervar.varFabulus.Id = "3cbcaacf6ac610f243a4b72bb707a0c0"
buildervar.varFabulus.Name = "Fabulus"
buildervar.varFabulus.Type = "Number"
buildervar.varFabulus.Data = "0"
buildervar.varMalusvisus = {}
buildervar.varMalusvisus.Id = "eb426a4efe336191367a72ba9f694b4f"
buildervar.varMalusvisus.Name = "Malusvisus"
buildervar.varMalusvisus.Type = "Number"
buildervar.varMalusvisus.Data = "0"
buildervar.varMedicus = {}
buildervar.varMedicus.Id = "a3224a6d8cb8965b4bfa48abd604439f"
buildervar.varMedicus.Name = "Medicus"
buildervar.varMedicus.Type = "Number"
buildervar.varMedicus.Data = "0"
buildervar.varMinuten = {}
buildervar.varMinuten.Id = "6ac9d3fe4805ed08f1e8f4c0f89334b8"
buildervar.varMinuten.Name = "Minuten"
buildervar.varMinuten.Type = "Number"
buildervar.varMinuten.Data = "0"
buildervar.varNewLine = {}
buildervar.varNewLine.Id = "02337b26feed96017d9fc440b2fcddb2"
buildervar.varNewLine.Name = "NewLine"
buildervar.varNewLine.Type = "String"
buildervar.varNewLine.Data = "\\060BR\\062\\010"
buildervar.varNotiz = {}
buildervar.varNotiz.Id = "87f0065295d4b0940ee6685311215ac1"
buildervar.varNotiz.Name = "Notiz"
buildervar.varNotiz.Type = "String"
buildervar.varNotiz.Data = ""
buildervar.varNotizAnzahl = {}
buildervar.varNotizAnzahl.Id = "87da5845c260b03c6604838a868880d9"
buildervar.varNotizAnzahl.Name = "NotizAnzahl"
buildervar.varNotizAnzahl.Type = "Number"
buildervar.varNotizAnzahl.Data = "0"
buildervar.varNotizText = {}
buildervar.varNotizText.Id = "f9d74f9c7fbee14860a4e143e95f96a7"
buildervar.varNotizText.Name = "NotizText"
buildervar.varNotizText.Type = "String"
buildervar.varNotizText.Data = ""
buildervar.varObliviosus = {}
buildervar.varObliviosus.Id = "66bb74bedd155b153edbeea87c8a1ebd"
buildervar.varObliviosus.Name = "Obliviosus"
buildervar.varObliviosus.Type = "Number"
buildervar.varObliviosus.Data = "0"
buildervar.varOstiarius = {}
buildervar.varOstiarius.Id = "6b93ed715e3dc4c0e395a6ce2a194dfa"
buildervar.varOstiarius.Name = "Ostiarius"
buildervar.varOstiarius.Type = "Number"
buildervar.varOstiarius.Data = "0"
buildervar.varPflanzen = {}
buildervar.varPflanzen.Id = "4ee841b163a30f46207485e170e65b2c"
buildervar.varPflanzen.Name = "Pflanzen"
buildervar.varPflanzen.Type = "Number"
buildervar.varPflanzen.Data = "0"
buildervar.varPflanzenAnzahl = {}
buildervar.varPflanzenAnzahl.Id = "d706e5b8724e61a5333021882c24976b"
buildervar.varPflanzenAnzahl.Name = "PflanzenAnzahl"
buildervar.varPflanzenAnzahl.Type = "Number"
buildervar.varPflanzenAnzahl.Data = "0"
buildervar.varPflanzenText = {}
buildervar.varPflanzenText.Id = "c02e5e60cdc67ddd431f44a05e319a5e"
buildervar.varPflanzenText.Name = "PflanzenText"
buildervar.varPflanzenText.Type = "String"
buildervar.varPflanzenText.Data = ""
buildervar.varScribus = {}
buildervar.varScribus.Id = "c7b2351ddf88cb798daac51e843aafb6"
buildervar.varScribus.Name = "Scribus"
buildervar.varScribus.Type = "Number"
buildervar.varScribus.Data = "0"
buildervar.varSecurity = {}
buildervar.varSecurity.Id = "3e1ab24c515455320da91b1b03edb24d"
buildervar.varSecurity.Name = "Security"
buildervar.varSecurity.Type = "Number"
buildervar.varSecurity.Data = "0"
buildervar.varStartcode = {}
buildervar.varStartcode.Id = "fd5497a09e0fcd0af9e26de32a1803c1"
buildervar.varStartcode.Name = "Startcode"
buildervar.varStartcode.Type = "String"
buildervar.varStartcode.Data = ""
buildervar.varTimeMachine = {}
buildervar.varTimeMachine.Id = "f6378f4b8843ab2d4e860402e53c0ae6"
buildervar.varTimeMachine.Name = "TimeMachine"
buildervar.varTimeMachine.Type = "Number"
buildervar.varTimeMachine.Data = "0"
buildervar.varTimeMachineCode = {}
buildervar.varTimeMachineCode.Id = "b3e97e53e3c339f2d3cb1fb5c3eb4064"
buildervar.varTimeMachineCode.Name = "TimeMachineCode"
buildervar.varTimeMachineCode.Type = "String"
buildervar.varTimeMachineCode.Data = ""
buildervar.varWissenschaftler = {}
buildervar.varWissenschaftler.Id = "012ce1a9a6e357078c4ea5a3ff870781"
buildervar.varWissenschaftler.Name = "Wissenschaftler"
buildervar.varWissenschaftler.Type = "Number"
buildervar.varWissenschaftler.Data = "0"
buildervar.varZeit = {}
buildervar.varZeit.Id = "b5c3444ecff25c1c7c21134a477897bb"
buildervar.varZeit.Name = "Zeit"
buildervar.varZeit.Type = "Number"
buildervar.varZeit.Data = "0"
ztimerBewegung = Wherigo.ZTimer(cartDasGeheimnisdesKlosters)
ztimerBewegung.Id = "f8abbdd41a21ef9f87fb229da02c4c8b"
ztimerBewegung.Name = "Bewegung"
ztimerBewegung.Type = "Countdown"
ztimerBewegung.Visible = false
ztimerBewegung.Duration = 50
ztimerMittagspause = Wherigo.ZTimer(cartDasGeheimnisdesKlosters)
ztimerMittagspause.Id = "e2e19af42e849baa50ae0dff94aaf0bd"
ztimerMittagspause.Name = "Mittagspause"
ztimerMittagspause.Type = "Interval"
ztimerMittagspause.Visible = false
ztimerMittagspause.Duration = 720
ztimerSecurity = Wherigo.ZTimer(cartDasGeheimnisdesKlosters)
ztimerSecurity.Id = "81f292198026bfc6a0759bbbb9bee4d5"
ztimerSecurity.Name = "Security"
ztimerSecurity.Type = "Interval"
ztimerSecurity.Visible = false
ztimerSecurity.Duration = 30
ztimerWissenschaftler = Wherigo.ZTimer(cartDasGeheimnisdesKlosters)
ztimerWissenschaftler.Id = "7918ab5a8410ebd6ed8ab196f83b4c32"
ztimerWissenschaftler.Name = "Wissenschaftler"
ztimerWissenschaftler.Type = "Countdown"
ztimerWissenschaftler.Visible = false
ztimerWissenschaftler.Duration = 30
ztimerZeit = Wherigo.ZTimer(cartDasGeheimnisdesKlosters)
ztimerZeit.Id = "a832aa151f62c6a847908a1300b8e99f"
ztimerZeit.Name = "Zeit"
ztimerZeit.Type = "Interval"
ztimerZeit.Visible = false
ztimerZeit.Duration = 60
zinputMalusvisus = Wherigo.ZInput(cartDasGeheimnisdesKlosters)
zinputMalusvisus.Id = "16677eb971c1d978baedd0f4a7a51287"
zinputMalusvisus.Name = "Malusvisus"
zinputMalusvisus.InputType = "Text"
zinputMalusvisus.Text = WWB_deobf("J4q/v0 Rn44qy x82 q0yut3mo3 -8 1n2pz:")
zinputMalusvisus.Visible = true
zinputMalusvisus.InputVariableId = "faac04f0e0da3d315412e2d7c2f50113"
zinputNotiz = Wherigo.ZInput(cartDasGeheimnisdesKlosters)
zinputNotiz.Id = "ea2656a6062e91aa3893f1fc9bde8d53"
zinputNotiz.Name = "Notiz"
zinputNotiz.InputType = "Text"
zinputNotiz.Text = WWB_deobf("Qsp3 yp3w our .ylr4uts Ywpz3zo8yxx qv1vu21lsr1 -n1oq0L")
zinputNotiz.Visible = true
zinputNotiz.InputVariableId = "87f0065295d4b0940ee6685311215ac1"
zinputStartcode = Wherigo.ZInput(cartDasGeheimnisdesKlosters)
zinputStartcode.Id = "5b891d1ba40defc5ce8cae98dfd7274f"
zinputStartcode.Name = "Startcode"
zinputStartcode.InputType = "Text"
zinputStartcode.Text = WWB_deobf("Qsp3 yp3w pu0 h9j14o1rt nsysrutrnx 8r5suw, 8r12 msp4r5 rnulz07 y13I js23 xtou7, mkyz sx3oknt ztu0 wm56t3G")
zinputStartcode.Visible = true
zinputStartcode.InputVariableId = "fd5497a09e0fcd0af9e26de32a1803c1"
zinputStartcode.Media = zmediaWherigo
zinputTimeMachineCode = Wherigo.ZInput(cartDasGeheimnisdesKlosters)
zinputTimeMachineCode.Id = "8bb88c4820b5e96e9cf8e6752fc2b734"
zinputTimeMachineCode.Name = "TimeMachineCode"
zinputTimeMachineCode.InputType = "Text"
zinputTimeMachineCode.Text = WWB_deobf("Ks45r eq127047 urxrqos2")
zinputTimeMachineCode.Visible = false
zinputTimeMachineCode.InputVariableId = "b3e97e53e3c339f2d3cb1fb5c3eb4064"
zitemEnergieversorgung.Commands.Anbauen.WorksWithList = {zitemZeitmaschine}
zitemKuehlung.Commands.Anbauen.WorksWithList = {zitemZeitmaschine}
zitemStartknopf.Commands.Anbauen.WorksWithList = {zitemZeitmaschine}
function cartDasGeheimnisdesKlosters:OnStart()
  InitItems(nil)
  InitTables(nil)
  Wherigo.GetInput(zinputStartcode)
  WWB_noemul(cartDasGeheimnisdesKlosters, WWB_deobf("crp n88xx1 0s 8xr2 on587rnrq vp8 20qpwuynn 5uo8 r3 4u291m y06 qu zwm.oq1n tz 7wu ox6yo840"))
end
function cartDasGeheimnisdesKlosters:OnRestore()
  InitItems(nil)
  InitTables(nil)
end
function ztimerBewegung:OnTick()
  ztimerBewegung.Duration = 10
  varBewegungPos = varBewegungPos + 1
  if varBewegungPos >= varBewegungMax then
    ztimerBewegung:Stop()
    zoneHubertusschrein.Active = true
    zoneBewegung.Active = false
    zoneWaschhaus.Active = false
    zcharacterBruderSilentius:MoveTo(zoneHubertusschrein)
  else
    zcharacterBruderSilentius.ObjectLocation = tblBewegung[varBewegungPos]
    ztimerBewegung:Start()
  end
  varBewegungDist = zcharacterBruderSilentius.CurrentDistance:GetValue("m")
  if varBewegungDist > 30 then
    varBewegungNum = varBewegungNum + 1
    if varBewegungNum == 6 then
      ztimerBewegung:Stop()
      varBewegungNum = 0
      varBewegungPos = 0
      zcharacterBruderSilentius:MoveTo(zoneWaschhaus)
      zcharacterBruderSilentius.ObjectLocation = tblBewegung[1]
      zoneBewegung.Active = false
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string(WWB_deobf("R1rq0r.yn smo7 Yq1 N48su0 duys29r43 n87 moy N8vuw 6q4z37nxI V1 tnw Rnz0 qk4 r6 0nsyq0 hywx, 9sx9n1 .7 0q3ppzK Zuq14 -86\195\188mv -81 fk3ouvp@1 5zq 750ont6 xxw p30s99 kyJ")),
          Media = zmediaCharAbt
        }
      })
    end
  end
end
function ztimerMittagspause:OnTick()
  varZeit = varZeit - 10
  if varZeit <= 0 then
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Ks45r .q03pzKLM")
      }
    })
    varZeit = 0
    zoneLagerplatz1.Active = false
    zoneLagerplatz2.Active = false
    zoneLagerplatz3.Active = false
    zoneLagerplatz4.Active = false
    zoneLabor.Active = false
    zoneVersuchsgelnde.Active = true
    if Player:Contains(zitemKuehlung) then
      zitemKuehlung:MoveTo(zoneLagerplatz3)
      zitemKuehlung.Commands.Mitnehmen.Enabled = true
      zitemKuehlung.Commands.Abstellen.Enabled = false
    end
    if Player:Contains(zitemEnergieversorgung) then
      zitemEnergieversorgung:MoveTo(zoneLagerplatz1)
      zitemEnergieversorgung.Commands.Mitnehmen.Enabled = true
      zitemEnergieversorgung.Commands.Abstellen.Enabled = false
    end
    if Player:Contains(zitemFluxxKompensator) then
      zitemFluxxKompensator:MoveTo(zoneLagerplatz2)
      zitemFluxxKompensator.Commands.Mitnehmen.Enabled = true
      zitemFluxxKompensator.Commands.Abstellen.Enabled = false
    end
    if Player:Contains(zitemStartknopf) then
      zitemStartknopf:MoveTo(zoneLagerplatz4)
      zitemStartknopf.Commands.Mitnehmen.Enabled = true
      zitemStartknopf.Commands.Abstellen.Enabled = false
    end
    ztimerWissenschaftler:Start()
    if zoneVersuchsgelnde:Contains(Player) then
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string(WWB_deobf("Qo, fwt! Rtq4 x82 \195\188os6quv e2s67ko2qvqwN eyp o2wnpl457 -n1oq0 sq0p tvs6 n135 5tsq3 zvqw91H<\001\002>\n\003\003\003\003Xrut3 ctq o01n Rqts282\195\164zqs -rooq4 p3 ss3r1 fuk4. 82t 5p3yo78nx evs tj2 Srz\195\164wnpJ")),
          Media = zmediaCharSecurity
        }
      })
    else
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string(WWB_deobf("Nx44pv91msr60u! Ks45r z4vwpz gxu npy jt714nt5ut1\195\164ypr 2ylr4 -8 3jrpJ"))
        }
      })
    end
  end
end
function ztimerSecurity:OnTick()
  if zoneVersuchsgelnde:Contains(Player) then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Qo, x\195\1823woy fwt wsnt6 w\195\1821pzK Qy23p 8s61j23q0 7yn 30s269 nl4 Ut1\195\164yprL")),
        Media = zmediaCharSecurity
      }
    })
  else
    ztimerSecurity:Stop()
  end
end
function ztimerWissenschaftler:OnTick()
  Wherigo.Dialog({
    {
      Text = WWB_deobf("Ks45r .q03pzKLM")
    }
  })
  ztimerSecurity:Stop()
  ztimerWissenschaftler:Stop()
  zoneVersuchsgelnde.Active = false
  zoneLabor.Active = true
  zoneLagerplatz1.Active = true
  zoneLagerplatz2.Active = true
  zoneLagerplatz3.Active = true
  zoneLagerplatz4.Active = true
  ztimerMittagspause:Start()
  varZeit = 0
  ztimerZeit:Start()
  if varWissenschaftler == 0 then
    varWissenschaftler = varWissenschaftler + 1
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Qkwx1, -ro srv8 n2 715p3 wt5 rt3 K2nrw8uw lz rt7 jpu60p8lrtzr? inso vv6 1ms00 uu03ts 0x9 npy n98jwxq0pp@ np3 Sx38ow5rw0u?"),
        Media = zmediaCharWissenschaftler2
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Qkwx1L U1 rqu7 w33 715p3G Y0pv urxtsr iurvp -87qvwpzoo9uw 5zq .y0 3u0r vn14utL Tro M4pty2oy 52012oy 5wrx otsr181rms us99n y0pv qk2ntywt\195\159oy yo78nxI Qo23 u\195\18201t3 6t3 037poy zw8 moy gs791 lzso2wnxI")),
        Media = zmediaCharWissenschaftler1
      },
      {
        Text = WWB_deobf("fk3 ssw12 oq01 3xms osx mo2 Zo7sqsyq?")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jv3 r579n2 y767 msp X\195\188xu4ys tt72sr ts79nvw5 @t7moyJ Rp3w v0z08 mk3 R1t7psp7r5740q5zt614m4w n1 tro drwwuG T46 sq0k5r rt7 Pw6@.Naxw0q06p9x1 m0ut8lrw056t3, om01 r0k5ou7 2jx qvut32vtou 2@0 y0pv tnx e6o69txz1sL"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("dxo qo7 r24 nz0u1? Pn12 o4yw6w33ro25 rxu Wl4pvx3n 30s269, 7q01 2jx pr1 i2k25x135o o3\195\188r02?"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Wsnt6 vqw9I Zo2 k1l6pv8 wk4\195\18850ylr m7qw wynt sx3 Zl45@372H e1179 u\195\182018u tl wssu0 Omus6wnvl6ss2u sy qs6 iot5 5ty1oyJ Rp8 6\195\1644s zj @6 utv\195\164s3ywrxG"))
      },
      {
        Text = WWB_deobf("Jms ws, mk3 uoq9 ss3 oqu0 o0pv xxpqq070ylr 4vqwu0 6q4@px03?")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("\195\132s, @xu sxyr5M Rms uoqu wt3 rp8 Zl45@372 l6s tywoy ms89nv sr6rx0spnr1 @wn yv7 hns\195\1590\195\164wnvy 718u0 pu0s2 Qyw.oo00nx uz aqky2 tswuo3p5K Sq uzyz7 8rmsq4 2ynwlzq sqqsy5r5M"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mk3 u\195\18272 3upv 1xqt4pv qwH Mos6 nsrq070ylr m7qw pk2 0wrx2 30 o9v5\195\164zqwvN<\001\002>\n\003\003\003\003gtq @\195\1640o q5, -nxy q8 2r3 pr0 mjmsyn12 3xo zw6 84x R67uw rqus2 5\195\1883qs79G hu4 .u0npz pt82sxy6 x3 .~ Zw2@2oy -86\195\188mv 5sx3G"))
      },
      {
        Text = WWB_deobf("Sk, 9o6@v yupv8N Vl45 931 w05 vuqoyJ")
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Qo! Qwt J1mqv7 0jxy q2rx xtou7 8x o3v1vuwn 4rw2, nl45 .y0 yupv8 wynt y978 pu0s2 Tkqrrs 90sywr1 0\195\182yzr1M Xnp3?")),
        Media = zmediaCharWissenschaftler2
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mk tn68 m4 3rqw9G L6s syn -A ax333pz y32v3 q5 p@lr zvqw9 wpt4 p3G V\195\188v0@wq, R1t7psp7r5740q5zt614m4w 71s Ov59@MZ4vzpz5o840 wm56t3 2tou 7sqxpxy p31msxvs\195\159nx, qs6 b3l36y24yp m7qwN Np3 nt92ow zw8 mox co785y25 zxup3 z1qw 1sntr5 @w3p3 sx3nw T1zArjvvq0 x2 Vln15M<\001\002>\n\003\003\003\003Tyxy6 su0 Xm01 .xw inqwtroy46 .ynnp3 0x9?")),
        Media = zmediaCharWissenschaftler1
      },
      {
        Text = WWB_deobf("Jlp3 y0q0 o0pvM fs2p 6rxxx zvs1qwn w101uw 5zq t95k3 9201nxI")
      }
    })
  end
end
function ztimerZeit:OnTick()
  varMinuten = varMinuten + 1
  zitemWanduhr.Description = WWB_multiplatform_string(WWB_deobf("fkyp7v6, k5r rt7 lp3rw88 ") .. varMinuten .. WWB_deobf(" Wtz77t3 2pu6 suv gq46rx5sypr1 tn1 iv67uw2ntnt81n1 7r5vqwqpz 6x3mH"))
end
function zoneInformationstafel:OnEnter()
  zoneVersuchsgelnde.Active = true
end
function zoneVersuchsgelnde:OnEnter()
  if varSecurity == 0 then
    varSecurity = varSecurity + 1
    ztimerWissenschaftler:Start()
  end
  if varSecurity > 0 then
    ztimerSecurity:Start()
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Nx44pv91msr60u, bsp x\195\1823woy 0wrx2 sur5 ruotnr1M bsp osuywnpz 6xsq sur5 q3p qv1t2 fp358rx1qpx\195\1642tn oq4 j3r5p35w8\195\1643 f\195\188qywqpzK Qy23p 8s61j23q0 hyn oq0 e1j3@J")),
        Media = zmediaCharSecurity
      }
    })
  end
end
function zoneVersuchsgelnde:OnExit()
  ztimerSecurity:Stop()
end
function zcharacterAbtJohannes:OnAnsprechen()
  if varAbt == 0 then
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Ks45r .q03pzKLM")
      }
    })
    zoneGrnerTurm.Active = false
    zoneBibliothek.Active = true
    zoneTeich.Active = true
    zoneWaschhaus.Active = true
    zoneKlostermauer.Active = true
    zoneFriedhof.Active = true
    zoneInfirmarie.Active = true
    zoneJohanneskapelle.Active = true
    zoneKlosterkche.Active = true
    zoneGarten.Active = true
    zitemNotizbuch:MoveTo(Player)
    zitemDominikanerkutte:MoveTo(nil)
    zitemBenediktinerkutte:MoveTo(nil)
    zitemZisterzienserkutte:MoveTo(nil)
    cartDasGeheimnisdesKlosters:RequestSync()
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("P44 -81 P1545s, Rr2 z\195\188813 pr5 Wn2lzq7t mo3 Ow7sqyq4 6tywH Q0r0ylrI h17u0o wysx3n Rqzsx31msms7 xj3 Q7qw 1ms00 7uqxwupv79 o28n58u2H<\001\002>\n\003\003\003\003ivs U3ms qs6 Ks3ou2u 1ms00 1y2qp5rw09 rl5, wqkoy 9w6 nsy Qw0uvwlJ Ww7 upz07 tro Sr6rxrms5r @4v arnzAw0kqq0?"))
      },
      {
        Text = WWB_deobf("botzr5Aur3 tn7 tn1 pn0p1rqp Np8, Qz56 wqko uu1 8nvts, suw douo8B 5z3 rt2 qtq4wvuw arnzAw0kqq0 @u024qpy8N j53 gxsqo2trw8 qkmq0 t7 4yp o01n 3qv1t Wknts20wn1 pvs7 kotnrvp12oyJ")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mkxu6 zurxp3 rt7 W\195\1820qwu 4y4r5t7 Qpyrw28lrlr6 x3 fp358rx3xr x2122, 8rw\195\159 Tppr5 331 .7 tywox xztywoy gsx1, 70 rt7 cntn7A r24J b97 6p3 o01n Tzs262j3t00s2 843mz0t3 rl5, su0 vm01 tnx epvp98 qu0rt3G"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Sooq4 su0 X\195\1821rxn, pvs .xx pr0 Wnrpuz1x8 6t45s2, rl5 sx3 Qpx\195\188qtn lnts0up3, qo78 o2 xsx3nw m0rt7nx N48su0 3qv1t3 dpuy @u01\195\1646L U1 sm0rt12 3upv zn6puy6 @v pu0 l403, qo78 x53 rt7 tp8rw0ypo Y\195\1822sq 7qv\195\159N"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("W4y 9w6t 4y4r5t Poxqv17sqkq5 w12n1 wysx3n1 60r -r1 8v67uw yupv8, 6tq zp3po 8v5 tnx epvp98 y0pv rn6lous2 t\195\182z0s2N K5\195\159s6 vs2 ysquw y64 24lr F a\195\182wmsq w1 Tvz46s6N Np4uo0r rlnr1 -r1 pr1 Rr2nt1t wnlp5r1, mk34 s6 moy fqwq29 u0 Vu5ks35o1 wsxy6L"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("dxo qo 0xwx5 193 Ss3 w28 c0urzM Rr2 52012 lx5 ku032q6s6 mo3 Ow7sqyq4 rxu L2\195\188rt7 4y4r5t8 Uw057t71 mqs5pwnx 60r tro qv1Auuxpz k372o 4n01uuxI Qo1y2 vm01 tjxy qs6 bmsm6~ wnp5zqs2 5o2pr1M"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Sooq4 su0 M3\195\188su0 mq9ow72 om5 Vuqoty0w7 j4q 5sx3n rm0~ urqpzr P72H Upv xjlp qwt K1\195\188qs6 5\195\164t4s2t O53r6 Q3ppz6vp12o3 822 rr2qz hsq6putsvuu\195\188nqs uw3m60rt3G Lxys6trxr4 p0url4 r6 znnpy 6t1k24 \195\188qu0vl45s2, ym r5 2r3 Q7qw 0ooq0 1\195\182ms5rL"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("foyz Ww7 kwxr I fy25r A@1kxyr1 xjl4, rp3w v0z08 5sppr5 xro2 us6N Nlz0 z\195\182xyq0 .y0 rqzsx31kx qo7 Posqv02y1 w\195\188t8uw 5zq t7vs45rz2, 6z qs6 bmsm6~ 1ror5K"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mkxu6 Xx0 vqv1t8 np3 k372o 7r5vu124, vprn tou T@lr tvs6 nsy xztywo3 a28y8l5ou, yw om5 Xx0 our vuo4ypr1t3 gz36s urx43nut3 u\195\182018N"))
      },
      {
        Text = WWB_deobf("foyz wrx o48n6 pns4 uoqu, om01 -n1oq wrx O5ou sqwx 60r -jxy -86 bot5r 79nrpzK kynvwqvqw9 ulz0 xsq P6pv zj sqytt3G")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Rms 9\195\18831msq S9sq 6urz Wu\195\188ox 93m pu0s2 n1q0yu6urmsq0 P@ooy5uo09 sy 717u0oy Zo9u0xI T289 2pu 0x9 O5ouL"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jms, 82t \195\188n4wvuw2, 9s23 o3 zw8 mo2 gsrxwsv 0wrx2 30 y0qyz4 71s m4 nrw urxpy bt@jxqm0u 3jms rw2uv d5n58sxnp tsu7jq4 9w682: pvs7u0 wm77t9 \"MQOScXJedQaBGF~\"I"))
      }
    })
  elseif varAbt == 1 then
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Ks45r .q03pzKLM")
      }
    })
    zoneGrnerTurm.Active = false
    zoneKeller.Active = true
    zoneLabor.Active = true
    zitemZeitmaschine2.Media = zmediaItemZeitmaschine6
    varTimeMachine = 7
    cartDasGeheimnisdesKlosters:RequestSync()
    Wherigo.Dialog({
      {
        Text = WWB_deobf("by, 082 uk346 1ylr qv11qu 3qus2, 6pxpvt fy25r Xx0 tz S9u0 Y06wAr3ms ts7sq1tqos2 qkm5K")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mk 8n58 Rr2 npt7 2pt4 t7oyws4sxsqH Q5 .q0 3upvt7 xtou7 yvwp3 ztylr4, 0tywoy O5\195\188mo2z ww7 Qptrw13r2 .7 t32vzoxs2N"))
      },
      {
        Text = WWB_deobf("W4y t88, vl45 1ylr myzt8 954n01uw 43nut3 HIJ 82t o48n6 7nmszr1 NGH 60r xro2 r7.q1 7qt MNG om s8-j2 pn~9 GHI 71s GHI")
      },
      {
        Text = WWB_deobf("W4y xo23 nl4 6tyw? Xn679 wtou 24lrxmy6 quvp4 1psq1pous2N")
      },
      {
        Text = WWB_deobf("N2 u57 3rms5 ~9 ok34r1, jlp3 s7 1msqv18 84 46w12nxI Qs6 bmsm6~ 1jq myz tro Vnv6u 2z 0owuG")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xpqq06xsq3wupv 8xvw r5 .x1 pr0 Urxrm0u B3 xqv1t2 Upxys6 uspsr1M<\001\002>\n\003\003\003\003by qvz8 w4y q269qsy 71s wosy6 suw douo8B wt5, sqvs4 9w6 msp4r Q\195\1881oq 1xsq3 yrv6 21lsr1 2\195\18834r1M"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Qkm5 9xuuoy Qo20G Tou .\195\188x3ous U3ms rw2u q55r gur2p q269qsy -86\195\188mv, 933 6z Vv6 pov0z0t3 2puqL Tn1 Nv6rxxp t\195\16409 2tous6 nsyq Pt1xry60u v\195\1882 R8rx lp3rw8N"))
      }
    })
  end
end
function zcharacterBruderFabulus:OnAnsprechen()
  if varFabulus == 0 then
    varFabulus = 1
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jr, qs6 Po3m0r8u np4 Px8lrzr5L inso tsv7\195\188\195\1596 Q73np3K<\001\002>\n\003\003\003\003Xx0 3qvr wnuzyzs2, 4x zsx3 gz36 A@ o2rnv6uwH Upv xxpqq, syn2 sr6rxros5 829n1 pr0 irorqy su0 gq46rx5spsr1wur3I"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Rms uoqu x\195\164zzxsq omzo08, lx5 1y0 xqv1 jnsw qs7 Posqv02y12p4 o2.n143n88 542pr, 3jms rw2u0 X\195\182u0ylrvqv7 wn25ou7, vs2 nz0u1 rm0~ wnxl6 ~9 vo2wr1M"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mo3tnzq qkmq wrx wt3 rp2jv3 rw2uw dm6~ aj14q0 qur pu0s1 oks3r1suw S\195\1641s1n1 sryp@o3, n8u moy e\195\188st2pu6s2 msp V1u40wl5v22uw y06wt72 5zq tywo Sr6rxrms5r sq84 q4t93moyJ O28lrwur\195\159uwn tnpt rms qwt Tk25r1 xro2 n0 V3\195\159q rt8 d53zs7 4o246sr02H"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Sk, 58rx2 our S41o z75, rx pr5 8rms qwt Tk25r1 rnptzqs2N Snt px3 O5ou sqkot xsx3n Suytt, nl zsx3 K5sr10ylr4 52.yn2z 0wrx2 xqu5 tj2 Nr68u s35K hyn x656 xro2 v5vuwn70 o2 mo2 Rqzu 97u5qwuw Xm7s6 3xo g862 5p357tst3 4rw2N Xpnr1wu0 vm01 ylr Q7qw sk pvs Wn2ntvqw9n p3-\195\164xuoyJ"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Nsy46 t78\195\164ty7t nsy ao67 2pu0s6 Qo235qwu0sy rw2u Qp4pvxsq3p 822 86pu Zxukoypr1, msp 5wrx rpuzzxsq 43ntt3G Our6t3 20urz8u kmq4 sq1 cmq su1 douwr01kw4 \195\188rnv yv7: mo2 Us671msq4 t7o4s3 933 ntq5s6 Uspnr 93m mq576qo3p qwt Kotpr1M"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Moy W\195\1883pvtzt 74uv4q rt7 dzp s6urvpzK T7 653qs tj1l6svx3 kx 0\195\164sq24q0 iqp lz sx3nw t1vt3 Ll6z t7q\195\164zt7M Msp u20tn Xmvr -31oq t\195\1880 oq0 gu13 uu5t8 Vpnr17 rx qv1t3 rztr1 j31x ts75n125, .4 2tq 6t1k24 822 mo2 f3x98o pvs ixxyq ~9 totzr5 pns4 qs7 ckrq5 7uqoy x2232H"))
      },
      {
        Text = WWB_deobf("dxo, @xu rl5 S9sq our Vu1msupv8u qprnz0uw?")
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Rr2 92012o pvs Wn2ntvqw9n y0pv1qu2 t\195\1826uw? Sr52u o2.\195\164w1n tou 7yn y0pv1qu2I"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Nsy46 t78\195\164ty7t nsy ao67 2pu0s6 Qo235qwu0sy rw2u Qp4pvxsq3p 822 86pu Zxukoypr1, msp 5wrx rpuzzxsq 43ntt3G Our6t3 20urz8u kmq4 sq1 cmq su1 douwr01kw4 \195\188rnv yv7: mo2 Us671msq4 t7o4s3 933 ntq5s6 Uspnr 93m mq576qo3p qwt Kotpr1M"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Moy W\195\1883pvtzt 74uv4q rt7 dzp s6urvpzK T7 653qs tj1l6svx3 kx 0\195\164sq24q0 iqp lz sx3nw t1vt3 Ll6z t7q\195\164zt7M Msp u20tn Xmvr -31oq t\195\1880 oq0 gu13 uu5t8 Vpnr17 rx qv1t3 rztr1 j31x ts75n125, .4 2tq 6t1k24 822 mo2 f3x98o pvs ixxyq ~9 totzr5 pns4 qs7 ckrq5 7uqoy x2232H"))
      },
      {
        Text = WWB_deobf("Rms u2uvn, uu5 vjxoq6 syn Rq5qwylr4q ut3j4 41 75jxyq0r -ro nrw1 n135r1 cjvI")
      }
    })
  end
end
function zcharacterBruderMalusvisus:OnAnsprechen()
  if varMalusvisus == 0 then
    varMalusvisus = varMalusvisus + 1
    zoneBrunnen.Active = true
    zcharacterBruderMalusvisus.Commands.Zeigen.Enabled = true
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xr, 9o7 k1tzt7 U3ms -8 2r1, rw2uv 30 o09nx Yn12N<\001\002>\n\003\003\003\003Knt, su0 Mu5qw4o 3ouwr02 P6pv, 3w 606 tro N\195\1886tn oq5 hsqk4.r6 .xx pr1 ilr5x6s63 95 0sw2nxI Vqw mknt6s 8lrzz, xsq x\195\188679n our6t vs4 v17 P1ln 1txvoyJ"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xl upv 2nsyq0 iurv pr6 Xrx7qv6t8 6pu\195\159? bown57@u024\195\1641s1rmsJ"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jlp3 rp rms v1 1n3@5r5 pns4 v01u0 6q4ut81vtous6 5o2pr, xjlp vqw n2 yv5 qu2 wysx3n2 d\195\16488nv m7tvu1ms3vsquwH Z75 0jxy vqw n2 vr7A9 xtou7 2nr2 ys7uw, pn xsq @6 y0urx sr6rx0spnr1 xjlpJ"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mynt, yq, 7u4 wqkoy 822 msp4r1 bn2p46sx3nx srv\195\18203I jw6 uomq0 wyn1 vn 2ylr4 ss63jl pr5 wnvpt47t3 gpx6L Ylr 4rzq82 mq5w8Bn 30yqw nsyq0 au1o35rw2N"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Po2zr .\195\1881oq wrx ssz S9sq m04ut3, lnr5 u0 mqsw2tn3 4vqw rx yrw2uv Mq77t1, oq0 xsq sur5 yw oq4 c\195\164rp v5vuwn70 9t7uor5 vprnH g0r ylr 4rvt vs45ys6-nswq r3sq 30 6rxuont6, tj23 vqw rry 0wrx2 qu0rtN"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xl Uu5 -xrw 52 v0o5zqzxsq 3qv1 -\195\1882pr7 @wn uu1 v\195\1882 zwrx 25ous2? Nl4 @\195\1640o zr78N"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Rms uoqu ssz s8-j2 8rw8u0 tz fxsq35zt Z1x24q4 @u0vz3r1M foyz wrx wtou 6ulr4 r5x3wo2q, wq2 p4 0t9jvwu5qw po3ous45n14J jxuuvpupv8 5o2pr7 Yq1 p158 jw N4823nx r\195\1882trqI"))
      },
      {
        Text = WWB_deobf("foyz Ww7 ssz utv3xoq0 wqk3, qo23 uzyz7 -rooq4 93m 3mt7 u1 xu4, tjwt5 wrx O5ou 7qpoy xo23, 7ur t8 6pu6s6 pos5K")
      }
    })
  elseif varMalusvisus == 1 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Qkm5 Ww7 npz Pt@2ow 5qw4w? Zrw2, nlz0 7533p5 S9sqH iv5 -r23q0 2yn, 8n12 n2 606t7v dou\195\1825oo2 tsu\195\164vw5, 1ylr .7 7ylr .7 w4uoyJ"))
      },
      {
        Text = WWB_deobf("R1rq0r.4 nz36 qur oqz Q73xyq0 wqko upv yqx 7r5040oyJ i2t 6pz0 Xx0 tt0 vuo4ypr1 xjl4, rp3w @qvu8 rry zw6N")
      }
    })
  elseif varMalusvisus == 4 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("foyz Ww7 npz Pt@2ow 0wrx2 xqu5 r0k5ou7, mkyz p6ywq4 vv2 5sppr5 qw our h9nvwq ~97\195\188nw, p3 np3 Ww7 ssz utv3xoq0 wqk3I Vqw 5ot\195\159 yq tp5-7, 5y pn6 y13I"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("dxo x2122 o0pv rr34q 13sqwlx5 @40lpu, sqvs4 vqw vsnt utr\195\188s3r1s 4yy R8rx 5p3np7sqsppr1 0jxyJ kx7 rlnr1 zj yupv8 xp4 T\195\16482oI"))
      }
    })
  elseif varMalusvisus == 5 then
    zoneTeich.Active = false
    zoneGrnerTurm.Active = true
    cartDasGeheimnisdesKlosters:RequestSync()
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("bms\195\1821, mk34 Ww7 o5q4 ku0203rqwuw, Q7qw 4yy zw6 84 7r5pr1msurrt3, rquo09nx tnp8N Rln6 Xx0 l6pv tnx Nr88uu 7urrt7 ky 5sx3nw byo8B 5p357p@2?"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("bms\195\1821M Mkyz p0url4 zw6 w42, S9sq l6pv -ns4q4vx3 otzr v@2o drw7u 95 9\195\18831msq0, -x l6pv yvwp3 S9sq oq4 Wu01 tv17sqsnwr1 2\195\182rqK"))
      }
    })
  end
end
function zcharacterBruderMalusvisus:OnZeigen()
  Wherigo.MessageBox({
    Text = WWB_deobf("bkr5, .q1 35rv8 j4q qs1 Ko55rz, mkxu6 xsq 3upvt7 ltz, sq12 q5 p@lr yrw2u0 t46L"),
    Buttons = {
      WWB_deobf("Xu")
    },
    Callback = cartDasGeheimnisdesKlosters.MsgBoxCBFuncs.MsgBoxCB1
  })
end
function zcharacterBruderMedicus:OnAnsprechen()
  if varMedicus == 0 then
    varMedicus = varMedicus + 1
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Py45 ~92 Q26\195\159t, L26qs6N Vpuqs6 tkyz wrx xtou7 2r3 Q7qw 0ooq0L Ylr tnpt totzr our3I Qwt Rxqu40p7ro u57 .xvw zw8 T1lzxs2N Snt v3voo, qo78 o3 086 mo2 U879nx u57 @wn zvqw9 ntq dt82H l7 Qupsyz 6x3m our hAvz40zs 8nr2 \195\164w3usntK"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jlp3 @t3w Tt4 vu0koq 63313 zvqw91 @6 793 rln6, tjxy x\195\1823w3 Uu5 U3ms 0\195\18898vtou 1qlrpzK"))
      },
      {
        Text = WWB_deobf("Pos5 w2 moy To69nx 60r xxv4 zw6 so7qvz7 nsyq Vp3m5zxy eqyk6q4 gxxol4, i@12txnu3 Ok2rn5p 3xo czp32kr0 Zp3lozxn73N")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Nsw5 S9sqH Vr 7sqxpxys6 rr2 zw8 moy X5\195\16433p30 .ynnp3 vxu0 3qvr, 3w 41 7sqxpxys6 tkyz wrx O53r U7jqpz ptqw37047t3G"))
      }
    })
  elseif Player:Contains(zitemKlatschmohn) and Player:Contains(zitemHuflattich) and Player:Contains(zitemSpitzwegerich) then
    zoneInfirmarie.Active = false
    zoneGarten.Active = false
    zoneInschrift.Active = true
    zitemKlatschmohn:MoveTo(nil)
    zitemHuflattich:MoveTo(nil)
    zitemSpitzwegerich:MoveTo(nil)
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("by tnpt rms zw6 mk3 826wn24qyz8N Ss3 vpr2 our 6ylr4uts2 T1\195\16477t7 qpn4orx2H Qv1 i3n m76 auk44pv14qx, U8u1j34upv @wn e2w8B5orq4wrx 6t3q suw V3n1zuw s0stt32vtou wuuppzK"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("dxo ws8B2 @6 S97n1 Nrz3xw4ysK Vuq3 .70 Ulu pr5 Ywpt3zo6yn 5zq 7@lr4 qwt Rx3ou5xv2 tz rt7 glzqL Tx14 9w6t otzr6 w0y\195\159r1 cjxyq5 vumknt6L i3ms5 rt3 Xlyr1 tn1 e6os9, l65 su0 p3 yp2, 5zq Xx0 7q4rt9 6tqqs6 nsyq0 hsq1t56 .ur3p3 6tywH"))
      },
      {
        Text = WWB_deobf("Uom5 @3xu, N48su0H g0r Wx34 5sx Jvw.rw8 vs4 R8rxG")
      }
    })
  else
    CreatePflanzenText("")
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("fk3 z878 snt rp 1osq0: Yq1 tnp8 vs2 ") .. varPflanzenText .. WWB_deobf(" 1tou7xw qpn4orx2H Wn1282 o6 rt3w vqv1 bj3pu0? Ylr tnpt N4nt r3sq our 0q2otzv6rxnx Zn0t3 np3 Vtyuu2\195\16488u0 rq5ov9G<\001\002>\n\003\003\003\003dou1t1u, qvz8 N4nt 82t lptrp8 moy Ssw1n1I"))
      },
      {
        Text = WWB_deobf("Msp N8uwjlp yo99n3p: Utx2 tz rt3 Ql36s2 3xo u209 wt3 xt-nsw4 sx3n Sm0r@4uv bn3p.n1 du2tq1, f767yukr0 Tp7ok2m 82t Zwm07pwx Wm0qt4uk40K")
      }
    })
  end
end
function zcharacterBruderObliviosus:OnAnsprechen()
  if varObliviosus == 0 then
    varObliviosus = 1
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xr, O59tn1, Vv6 1otp 6xsqo2 qs6 GHI, rt7 HIJ Orx, psnz, vs2 s\195\1641u3 q5 vu0koq 1xsq3 qv1M"))
      },
      {
        Text = WWB_deobf("asnt6wv, np3 Ut8jxo5r su1 Mu5qw4o2, qs6 msp 9wrx2srq0 X3oy2yn7x4woy -81 Tvz46s68lrl5- 7qvwpx6L")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Wk4\195\18850ylr wn12 rms zwrx xzou p3 wpu0 l403 q45x3wo2zK Sq84 tnpt rms zw6 n743n tyw d@57t2 k54tssqlr4, rp2r3 upv u1 yupv8 4o2sr67uG <\001\002>\n\003\003\003\003Upv xjlp zw6 84 vrrt7 Qpnr77824ypr tywoy O8rx13lnr1 wnwp3x7M"))
      },
      {
        Text = WWB_deobf("Msp c5x2 s35 'c', our iu09 u57 'P', qwt eo31r5 y13 'h', mk3 X215uo4 v68 'W', rxu Vl6qs7 r24 'W', ntq gt~2 t46 'k', pvs cj355v1 y13 'm', msp a22 r24 'Z', o2svp8 rx pr5 7rms5vut3 bpuus2vxvrq rt7 Qpnr77Bns4q0 sq1 h047 'WQfYViob'H<\001\002>\n\003\003\003\003")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("fk3, @xu wpu07 Yq1 pn6, msp esxxnxq0yut mo2 Tsqu22@qv7t3 6\195\1884rt wsnt6 79rwxq0L Ylr 8r5su nzou 2ylr4 5qw4w 7urrt7 o48n6 t31ntrw2qwnp3 utr0knt6 wqkoyJ"))
      },
      {
        Text = WWB_deobf("Msp esxxnxq0yut mo2 Tsqu22@qv7t3 ulz0 s4lr 4pv33 tppr5 3xms 52 0uotzr c44s@qK c@0 tou zqwx q5 2ylr4 oswqu3pzK hsq1poxzxsqH")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("foyz wrx x53 @\195\188124q, .4 2tou syn2p3 828nowuts dx5t.r wu04x54sxr2H hr51@2vtou 79nr4 r5 -rooq4 @40 oq4 Z1x24q4y\195\188lrp 71s ko45rz8 3w Q56t3G Oq4 z\195\182xy5r T@lr pvs 7rms5vut aottr1u4uqp 5wrxn1 4nut3G"))
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Xr N48su0, Uu5 2jms5 0xsq rm0~ @w2tous6N Kmq4 xsq smos 2r1 r1zvuwnp4 ut2n1v5K")
      },
      {
        Text = WWB_deobf("Msp c5x2 s35 'c', our iu09 u57 'P', qwt eo31r5 y13 'h', mk3 X215uo4 v68 'W', rxu Vl6qs7 r24 'W', ntq gt~2 t46 'k', pvs cj355v1 y13 'm', msp a22 r24 'Z', o2svp8 rx pr5 7rms5vut3 bpuus2vxvrq rt7 Qpnr77Bns4q0 sq1 h047 'WQfYViob'H")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("foyz Ww7 wpu07, mk34 rxu bpuus2vxvrq 1xsq3 46w122, pn12 v\195\188457 Yq1 pvs R3ms46oquw 3qyp79 sy qwt 0snt6wvu bpuus2vxvrq rt7 Qpnr77Bns4q0 q7rxrq0L"))
      }
    })
  end
end
function zcharacterBruderOstiarius:OnAnsprechen()
  zcharacterBruderOstiarius.Visible = false
  if Player:Contains(zitemBenediktinerkutte) or Player:Contains(zitemDominikanerkutte) or Player:Contains(zitemZisterzienserkutte) then
    if Player:Contains(zitemZisterzienserkutte) then
      Wherigo.Dialog({
        {
          Text = WWB_deobf("Ks45r .q03pzKLM")
        }
      })
      zoneGrnerTurm.Active = true
      zoneKlosterpforte.Active = false
      zoneGstehaus.Active = false
      zitemZisterzienserkutte:MoveTo(nil)
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string(WWB_deobf("Jr, T289 95y U6@\195\159p, P6@mo2J Ww7 w\195\188568 mo2 Ts7qwn4q 932 Lt4pv3v 2pu0L Tn1 Mo7 u06l36s8 N4nt 6rxxxI<\001\002>\n\003\003\003\003Tsw9 2nt0s01 95y U6\195\188xpz h97v, pr0 ir3@ qs7 Jl4q5L Tx14 v68 n1 6z syn2p msx9 np4 hpwn2 uz0t7 ky.776uoppzK"))
        }
      })
    else
      zoneGstehaus.Active = true
      Wherigo.Dialog({
        {
          Text = WWB_deobf("Jr, O59tn1, qs6 Qo23 6ty wt5 S9sqH<\001\002>\n\003\003\003\003Zrw2, vpuqs6 tkyz wrx O5ou 2ylr4 v1 tnx u01t7nx Nr5tylr pr6 auy35r57 84x Np8 k1tzts2N")
        },
        {
          Text = WWB_multiplatform_string(WWB_deobf("Jlp3 sx3n Ympv8 Pk35s5t@wn3ouou9 sy 717u0ox T\195\16482osm76 0jxy vqw N4nt o2rro4q0L Wnr4 qw6ut3 u06 W\195\16435rvp@1, p158 r24 n8rx 2nt11 urx m0rt7n1 Sn68N"))
        }
      })
    end
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xr myz1\195\164ms5vut7 Qz56, -ro 4rv8 Rr2 qs23 k54? lq1 43nu8 Rr2 s\195\1887 2px66p2n Vxrws@wq? Vv6 v\195\188457 urxp3 933 ntq5s2 b320yqwuw l65 suv qq41t3 Wz3ts21jxo 5sx3G<\001\002>\n\003\003\003\003Xmpv8 N4nt 932 Knwr5, 1yy46 0q12p vqw msp U82tn l6s T@lr tr7A9nxI"))
      }
    })
  end
end
function zcharacterBruderScribus:OnAnsprechen()
  if varScribus == 0 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Wk4\195\18850ylr 425tsqo upv 2r3 Q7qwN Rtq4 vyk3 q5 yq xtou7 wn1lpr @ynvp Ts0upoytrw8uw 3upv B3 5z6s6xjv4q0L Tro m0rt7nx N4\195\188tn1 4v1s sk yrw79nx3 5792v 7ur syn Qu5qwuG fzq 1urxp O\195\188sqo2 536ulrpz o9sq yupv8 5s2wywrxG"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("by, Vv6 1otp o08x oq4 Vu1kyp6s tn2 Nv6rxxp3J Wrx lpzrwsu O5ou 2ylr4 70 U31pz O9v21lsK burxp O5\195\188mo2 x\195\1823woy vv6u Qptrw13r23q 7tyu6pu5s 2nr2 nz7 p44 u\195\1889nxI"))
      },
      {
        Text = WWB_deobf("foyz Ww7 6pu6s6u P2mts2 qkm5, 74 uzyz7 urxqmpv -rooq4L Qko2 082 v434 wrx wtou p3 ntq O6rns4 zorxnxI")
      }
    })
  end
  if varScribus == 1 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jr, qo 8nso Vv6 sk 8vssu0H in6 0jxy vqw o\195\1883 S9sq 460?<\001\002>\n\003\003\003\003Yq1 81z09 2tous6 votzr Q\195\188msq4 tyw2ptr1M Mk3 xo23 snt u99 5p357txnxI"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("fs2 5w2t p\195\1884 931o2q Pxrusz5usz 5ot5 \195\188rn1 pvs W0oy.r1 @w2p3r6 bjxoq5 qutkyz6L Xro2 sw2tn3 yn1 B3 lxys2 crpyr1 urx q07750ontr1su1 M6pvM"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("fs2 uoquw dou5xv2oy -8 .n13ouwttnxpz g47jmsq0 93m l6pv xn1l655pwnxoq Yp72oy8r5zuG<\001\002>\n\003\003\003\003Our Q\195\188msq4 7ywn zn7\195\1880vtou @u0lz3ts2N Npz0 t8 uzyz7 yvwp3 @xumo2 826, nl45 Synlp 5wrx ky qs2 5o258201nx N\195\188rxn1y os6urmsq41 -xvwq0L"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mk3 O8rx, om5 Xx0 36pv8, 6p3qs8 Rr2 qw6ut3 tv18u0 oq4 Zq03p sw2tnxI fsxt 5z35wrx2sr, s7 u\195\164457 8rms 0wrx2 600 su0 d5rz0u lp8rut3G"))
      }
    })
  end
  if varScribus == 2 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jms, 82t wpu0 l403 y\195\182rx2o4 Vv6 j4nt 13sq?"))
      },
      {
        Text = WWB_deobf("Rms uoqu wpu0 l403 pr0 R3ms n1@u032m77M<\001\002>\n\003\003\003\003foyz Ww7 nl4 P9sq mq65psq3p5, sqwx 8v5s N4nt 9xuuvpupv8 mk3 4wrx2srq Zxsq3 m7tvuqoyJ")
      }
    })
  end
  if varScribus >= 3 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("foyz wrx 1tou7xw syr151yn14 ow2, nlz0 wq2 P6pv R04oq4 bqu437v698 otz Vx1o2xu67t1 wt5tsvukoy, 0x9 npy Ww7 nl4 P9sq 5z6s683msq0 z\195\182xy5K Qu21lou7t9 o3 v0 7rms5vut3 Vtou7M"))
      }
    })
  end
  varScribus = varScribus + 1
end
function zcharacterBruderSignum:OnAnsprechen()
  Wherigo.Dialog({
    {Text = "", Media = zmediaImageSignum5},
    {Text = "", Media = zmediaImageSignum6},
    {Text = "", Media = zmediaImageSignum1},
    {Text = "", Media = zmediaImageSignum3},
    {Text = "", Media = zmediaImageSignum7},
    {Text = "", Media = zmediaImageSignum4},
    {Text = "", Media = zmediaImageSignum1},
    {Text = "", Media = zmediaImageSignum2},
    {Text = "", Media = zmediaImageSignum5},
    {Text = "", Media = zmediaImageSignum6},
    {Text = "", Media = zmediaImageSignum1}
  })
end
function zcharacterBruderSilentius:OnAnsprechen()
  if zoneWaschhaus:Contains(zcharacterBruderSilentius) then
    zoneBewegung.Active = true
    zcharacterBruderSilentius:MoveTo(zoneBewegung)
    ztimerBewegung:Start()
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("N2 u57 0uk2, rp81 M37rt7 ctxr18y32 zvqw9 203rqwuw vm01M Mo3tnzq ko43r88 n1 pr1 mjvo 9sx9 k5\195\159s6xjvm qs7 Tvz46s68G<\001\002>\n\003\003\003\003Lxys6trxr4 9t714nt6 t7 2tou 1y2 Rq57t3 95 8s682\195\164zqwvuwH Q4 @u025ou7 B3 @qvut3, om56 2jx uu0 vxvrq0 74uvI")),
        Media = zmediaCharAbt
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mk q4 7uq1 w75A8rms5vu y13, r04vrosx6 t8 2tou, trms5 o2 rrx -8 ruotnr1M R24 r5 -ns4q4 .yn A- 0 .xx Q7qw nx4rr529, om01 tnxv5 s6, Ss3 v\195\16423p5 rp8 Sy5r5t81o 7r5040oy 71s n1 srv8 5sppr5 8nsyq5 lupo3J"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Jv30 9t714nt6 x2vo2, rt3 Km46o2t xtou7 w0\195\182\195\159s6 jv3 CA 2 6p3qs2 84 xn67uwH e1179 w\195\188568 Rr2 uwt7qo2 -86\195\188mvxn8uuw 5zq xxw 7urrt7 ky425tsqoyJ Rp3w rqu7 u1 600 @40xp y27N"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xr, r5 1\195\1645r6 qu0ot55 041H Q5 wur\195\1595 o08x, 4vqw 1z55r1M<\001\002>\n\003\003\003\003dxo qs202 om4o2, o2 v68 nsy n87tj4p30rt7 V\195\1647tt7G Yupv8 54ypr52, 6pz0 t8 o48n6 -ns4q4 vuq3I"))
      }
    })
  elseif zoneBewegung:Contains(zcharacterBruderSilentius) then
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Vs4 O59tn1 evzt32s54 w79 tp5-7 3rms5 u99 1ppr1M botz kx3toy v68 nsypr88yp: qv1uqlr r1zvuwH"),
        Media = zmediaCharAbt
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_deobf("K15pr5 irvpz6w98 rl5 s7 pky. @xsq3tsK T7 np66s8 rwxq4 .ynnp3 o9v npz grx0otz rt8 Rpuywvuw S6os6932I<\001\002>\n\003\003\003\003iwt1uotou7 8xvw5r7 Yq1 Q7qw moy fqw7nsy ts2q3o2 n17sqk5q0L Tro Pn579nvw60u tn2 Trw0ypoy U8qu0354 w79 2pt4 vuu4ysr1M"),
        Media = zmediaCharAbt
      },
      {
        Text = WWB_deobf("dxo 8wt1uotou7 uw3oqpy8 Rr2 qoqur l6pv tj2 i158, nl4 Ww7 25ou7M")
      }
    })
  end
end
function zcharacterGast:OnAnsprechen()
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string(WWB_deobf("botp utw0\195\188\195\1597 @wn tr5A1rms jw01tyxyr1 xro2 v0 W\195\16435rvp@1H Upv tjms5r 7sqyy, wrx 6\195\1884rt qsp3 o01nsyq p0urlpzK Sq1 Vx168u0 Mqos2xj43q0 .y0n 81v0 wsnt6 74 yq5 pt83ms5K"))
    },
    {
      Text = WWB_multiplatform_string(WWB_deobf("Jms, Ww7 6zxy7t9 otsr181rms v1 tnx u01t7nx Nr5tylr pr6 auy35r57? Nlr\195\1886 pos\195\18258 Rr2 npt7 npy tp11msq0 d7moy n1M<\001\002>\n\003\003\003\003Msp mw79n1@ur17u0 3u0r tjp\195\1884 qutkyz6, tj23 5wt w42 O5\195\188mo2 n87 rr2qz d7moy v1 tnx u01t7nx Nr5tylr xn67uwH"))
    },
    {
      Text = WWB_multiplatform_string(WWB_deobf("Sk, qo7 r24 4wrx2srJ kt3w Tt4 syn V667t nsyq5 oy13p3-wt31o24 76qpoy 9\195\1887mo4, v\195\16423p R8rx np3 du\195\18214zr5 urxrqyo78nx 60r tn1 Mo7 8rmsq4 p3 ntq hpvnv pr5 R0\195\188pr5 urxrqyosuwH"))
    }
  })
end
function zcharacterNovize:OnAnsprechen()
  if varObliviosus == 0 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Xr, Us67, 6q4~tyq3 yv5M Rms z\195\182sq3p R8rx xtou7 yv hqt 79nrpzK"))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("asnt6wv, otsr181rms z\195\188813p vqw 3w pvs7u jpu6 qu0ot55 qurw g07t70snt6 7urxI Q2rx np3 V93po2 38\195\164u3 yvqw 1y 46o60, 30 rp81 tou 1ylr zvqw9 uzz-s290sp3r1 0\195\182yz6sM"))
      },
      {
        Text = WWB_deobf("by 8n58u snt vxu0 l6s suw V0pv, mo2 zw6 jl 60r B3 p59o7 84 Q56t3 qtn6L")
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Vot46s6, np3 Y3sq 7m4 24lr uz0t7 xtou7 tj, mos6 rms uoqu nzou 74 R5zts6N<\001\002>\n\003\003\003\003Xl5\195\18861rms xo23 snt S9sq sqytt3, 7q01 u1 yupv8 84 w1041r9tq47 y13I"))
      },
      {
        Text = WWB_deobf("Msp esxxnxq0yut mo2 Tsqu223571suw? Zn, tj2 u57 zj yupv8 1ms8r5M")
      },
      {
        Text = WWB_deobf("Msp Zo8@2sy, pty np3 @x7 lp5r1 @wn b5o02nx 4v1vuw, u57 @v ~ hv6 Wknt66M<\001\002>\n\003\003\003\003Msp Yo9tn2, osx mo2 9w6 mk3 T289n2w0o qu2oy, w79 lpu hpwn2lzo59sqH")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp c5x2, om5 t713p Tsqu2 q\195\1885 @w2, v68 porq0 H dr2J<\001\002>\n\003\003\003\003Rxu dp3-, rns pr5 -r1 T.02@1 5zq e8jvxq0 qu2oy, w79 qpsr1 L es3K"))
      },
      {
        Text = WWB_deobf("Msp fs-9, mqv su0 7u4 .ynnp3 pt9nx, v68 porq0 CE es3K<\001\002>\n\003\003\003\003Syn Y00, rns pr5 -r1 8vssu0 S@z198 4yp d7quwpz pt9nx, v68 porq0 CH es3K")
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp is75n1 nr7t3 6t3 utwnx ~G jx0H M06rxusp\195\159s2t 6t3q A@ Kmq0r wnqp45s2N eyp, 3x 6tq 6rx0onwywrx, 600 huy3pyos6 ks3 b68u0x u57 tro3 qwt nsy.vut Vksx-sx9 np4 hpwn2I Rw2 5ks3r6 cj14@4w92 p\195\1884 1ylrI "))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Mk3 X215uo4 os8uw 7u4 p11 douz9\195\159qpnr7 tn2 fnut8 qpsr1 DD ft4L Tjxlou 0upoy 9w6 3x3 rw2u rlxos i24ypr 2qlr e112uw4y5r5vqwq u0 @4uvp3 Pt0uotp71v 84x fqw1jppz 1xumo2J "))
      },
      {
        Text = WWB_multiplatform_string(WWB_deobf("Totzr j71kntr, cns35r5M foyz Ww7 o3 02rx otzzo0 q\195\1823r1 -xvw5, sqwx w1019 otzsorx 6tqqs6 qo2J cw3n p59o7 84x R67uw rqus ylr tvs6 wsnt6 .up, m7qw 5oyz wrx xlouvt7 nlr\195\1886 j43svsqyp M6\195\159t 24y z878G"))
      }
    })
  end
end
function zitemAckerdistel:OnAbstellen()
  DropPflanze(zitemAckerdistel)
end
function zitemAckerdistel:OnMitnehmen()
  TakePflanze(zitemAckerdistel)
end
function zitemArnika:OnAbstellen()
  DropPflanze(zitemArnika)
end
function zitemArnika:OnMitnehmen()
  TakePflanze(zitemArnika)
end
function zitemBenediktinerkutte:OnAnziehen()
  KutteAn(zitemBenediktinerkutte)
end
function zitemBenediktinerkutte:OnAusziehen()
  KutteAus(zitemBenediktinerkutte)
end
function zitemDominikanerkutte:OnAnziehen()
  KutteAn(zitemDominikanerkutte)
end
function zitemDominikanerkutte:OnAusziehen()
  KutteAus(zitemDominikanerkutte)
end
function zitemEnergieversorgung:OnAnbauen(target)
  if varTimeMachine == 1 then
    varTimeMachine = varTimeMachine + 1
    zitemEnergieversorgung:MoveTo(nil)
    zitemZeitmaschine.Description = WWB_multiplatform_string(WWB_deobf("Qkwnss69rqp msx9vk3ouw2u, lz rt7 lp3rw88 ntq Y\195\188qv5zt 93m our T3n1rur9t71y2s71v jxrqoo99 2tzqL"))
    zitemZeitmaschine.Media = zmediaItemZeitmaschine3
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Tvl45s! W4y uo8 msp msx9vk3ouw2u k5ou 24lr qv1t Nxp3twt.n1304u93p, 0u1t msp rw2u jpu65ty1o zvqw9 w\195\182tzxsq 7\195\1645tN")),
        Media = zmediaItemZeitmaschine3
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp4r6 jnsw xo23 sx Z21uw3 zvqw9 ky qwt iot5zo7sqsyq o2wnll66 .u0npzK T.nx46rz0 v\195\18845s2 84p357 qwnp3r P7kot5r1 t31nttsu\195\188r25 @t7moyJ"))
      }
    })
  end
end
function zitemFluxxKompensator:OnAnbauen()
  if varTimeMachine == 2 then
    varTimeMachine = varTimeMachine + 1
    zitemFluxxKompensator:MoveTo(nil)
    zitemZeitmaschine.Description = WWB_multiplatform_string(WWB_deobf("Qkwnss69rqp msx9vk3ouw2u, lz rt7 lp3rw88 ntq Y\195\188qv5zt, tro Q0s6wro6q4637p4ys 82t np3 T0@67JW104uw2l515 qwqpnn88 1sypK"))
    zitemZeitmaschine.Media = zmediaItemZeitmaschine4
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Oky5n68y1ms! b93 rl5 rxu jpu60p8lrtzr p@lr z1qw nsyq0 U1378KX215nx3m626, yszr suw our ku0ntou793p 5zq T~yky4v22 mo2 msx9 ql3 1xsq3 y\195\182v1rms 9\195\1647nH")),
        Media = zmediaItemZeitmaschine4
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp4r6 jnsw xo23 sx Z21uw3 zvqw9 ky qwt iot5zo7sqsyq o2wnll66 .u0npzK T.nx46rz0 v\195\18845s2 84p357 qwnp3r P7kot5r1 t31nttsu\195\188r25 @t7moyJ"))
      }
    })
  end
end
function zitemHuflattich:OnAbstellen()
  DropPflanze(zitemHuflattich)
end
function zitemHuflattich:OnMitnehmen()
  TakePflanze(zitemHuflattich)
end
function zitemJohanniskraut:OnAbstellen()
  DropPflanze(zitemJohanniskraut)
end
function zitemJohanniskraut:OnMitnehmen()
  TakePflanze(zitemJohanniskraut)
end
function zitemKamille:OnAbstellen()
  DropPflanze(zitemKamille)
end
function zitemKamille:OnMitnehmen()
  TakePflanze(zitemKamille)
end
function zitemKlatschmohn:OnAbstellen()
  DropPflanze(zitemKlatschmohn)
end
function zitemKlatschmohn:OnMitnehmen()
  TakePflanze(zitemKlatschmohn)
end
function zitemKuehlung:OnAnbauen(target)
  if varTimeMachine == 0 then
    varTimeMachine = varTimeMachine + 1
    zitemKuehlung:MoveTo(nil)
    zitemZeitmaschine.Description = WWB_multiplatform_string(WWB_deobf("Qkwnss69rqp msx9vk3ouw2u, lz rt7 lp3rw88 ntq Y\195\188qv5zt p3pomm77 y13I"))
    zitemZeitmaschine.Media = zmediaItemZeitmaschine2
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("bos3 u99! Y60 wq2 our our3xm5qwywo qv1t o4yw6w33ro2q0rt T\195\188ty82w, omzw8 1sp osx iot54sx8nx zvqw9 \195\188nr5wy294J")),
        Media = zmediaItemZeitmaschine2
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp4r6 jnsw xo23 sx Z21uw3 zvqw9 ky qwt iot5zo7sqsyq o2wnll66 .u0npzK T.nx46rz0 v\195\18845s2 84p357 qwnp3r P7kot5r1 t31nttsu\195\188r25 @t7moyJ"))
      }
    })
  end
end
function zitemMistel:OnAbstellen()
  DropPflanze(zitemMistel)
end
function zitemMistel:OnMitnehmen()
  TakePflanze(zitemMistel)
end
function zitemMrzveilchen:OnAbstellen()
  DropPflanze(zitemMrzveilchen)
end
function zitemMrzveilchen:OnMitnehmen()
  TakePflanze(zitemMrzveilchen)
end
function zitemNotizbuch:OnNotieren()
  Wherigo.GetInput(zinputNotiz)
end
function zitemPforte:OnAnklopfen()
  zcharacterBruderOstiarius.Visible = true
  Wherigo.Dialog({
    {
      Text = WWB_deobf("Vs4 rw2uv Vzn56uw rqu7 tro bs269n @6z Z1x24q4 Qukoytn87uw l6s 93m oq4 Q73np3, su0 our evx14q pt-jms5, t71msqv18N")
    }
  })
end
function zitemSchafgarbe:OnAbstellen()
  DropPflanze(zitemSchafgarbe)
end
function zitemSchafgarbe:OnMitnehmen()
  TakePflanze(zitemSchafgarbe)
end
function zitemSpitzwegerich:OnAbstellen()
  DropPflanze(zitemSpitzwegerich)
end
function zitemSpitzwegerich:OnMitnehmen()
  TakePflanze(zitemSpitzwegerich)
end
function zitemStartknopf:OnAnbauen(target)
  if varTimeMachine == 3 then
    varTimeMachine = varTimeMachine + 1
    zitemStartknopf:MoveTo(nil)
    zitemZeitmaschine:MoveTo(nil)
    zitemZeitmaschine2.Name = WWB_deobf("iot5zo7sqsyq")
    zitemZeitmaschine2.Visible = true
    zoneLabor.Description = WWB_multiplatform_string(WWB_deobf("Ukm045p@v xu6 su0 mq65xuk2mq4sx9nx lrw82j2ntv1tN Sx Rqz 13pt6 tyw Vxrwsu024\195\1641su0 xu6 @u02ntvssuwoy Z2t3lr3w778uwH M063313pz vt702nt6 j3x1oz71vN"))
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Qo27156qpoyp! c@w sm6 syn kqv71q1msu0s q3ms 02rx otzr1 UrxJ 71s J434pvp12o2, rp2r3 4vs znnp3-sx9 sy Os87rom ts24vwpz @t7moy xo23G"),
        Media = zmediaItemZeitmaschine5
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp4r6 jnsw xo23 sx Z21uw3 zvqw9 ky qwt iot5zo7sqsyq o2wnll66 .u0npzK T.nx46rz0 v\195\18845s2 84p357 qwnp3r P7kot5r1 t31nttsu\195\188r25 @t7moyJ"))
      }
    })
  end
end
function zitemZeitmaschine2:OnEinschalten()
  if varTimeMachine == 4 then
    varTimeMachine = varTimeMachine + 1
    zitemZeitmaschine2.Commands.Einschalten.Enabled = false
    zitemZeitmaschine2.Commands.Eintippen.Enabled = true
    zitemZeitmaschine2.Media = zmediaItemZeitmaschine6
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Msp msx9vk3ouw2u 1l12s0 3xo -o45nv4J gxu 05ur77sq3 60r 5ootr6L Tn1 Nvzs8lrt3z 0u3ms5r7 q3p 60r -r1o 9wttn1 p71zuuH by\195\18298vtou t71msqv18 nsyq ax92otx71v j4q qs1 Kswp5qwy0wI Qwt8n wm77t9 \"Mu67t Yk349269 otztsquw\" 60r urx O75740 mxv1z9G hqv7t7 zl45wt72 yupv88G")),
        Media = zmediaItemZeitmaschine6
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Jms ws, msp msx9vk3ouw2u rl5 xp wynt 1xsq3 qv11qu pu0s2 b3l36y24ypI jwt 1ywx6s 2jx 4vs tj pu06rxjv4q0?")
      }
    })
  end
end
function zitemZeitmaschine2:OnEintippen()
  if varTimeMachine == 5 then
    Wherigo.GetInput(zinputTimeMachineCode)
  end
  if varTimeMachine >= 7 then
    Wherigo.GetInput(zinputTimeMachineCode)
  end
end
function zitemZisterzienserkutte:OnAnziehen()
  KutteAn(zitemZisterzienserkutte)
end
function zitemZisterzienserkutte:OnAusziehen()
  KutteAus(zitemZisterzienserkutte)
end
function zinputMalusvisus:OnGetInput(input)
  varBeutel = input
  if varBeutel ~= nil then
    if Wherigo.NoCaseEquals(varBeutel, WWB_deobf("KeceN")) then
      varMalusvisus = 4
      zoneBrunnen.Active = false
      zcharacterBruderMalusvisus.Commands.Zeigen.Enabled = false
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string(WWB_deobf("Xr, Vv6 qkm5 ww3 qpr71suwH Uu5 8nr4 rw2uw rx\195\188r0usntr1 cjxy 826 n4ntK c@w vm01 ylr q0r0ylr 8vssu0 tz rt7 Ltnrz 1n2pzK"))
        },
        {
          Text = WWB_multiplatform_string(WWB_deobf("W4y x\195\1823w3 Uu5 8rmsq4 p@lr pn6 h\195\16444rz B3 xqv1t2 dpuy su1 Rqusx2ws34r6 1n2pzK Xx0 qu0rt9 ntq5s7 my25 w2 mox zs8quvpzr1 hxr2J S7 5s2p rxu gzt082w otzr6 jro2q5 vu14nt6L"))
        },
        {
          Text = WWB_multiplatform_string(WWB_deobf("foyz Ww7 pp36wv 1otp, sqwx yr5z9 o5ou p1uo3 t88 3xo ysv9 nl4 grx0sq557\195\188lu 8vssu0 lz 6tywoy czp98H"))
        },
        {
          Text = WWB_multiplatform_string(WWB_deobf("Moy Os99nv yv7 8nsyqz X3qkw5 1txv3 Uu5 rn23q4 1y2H ir5 -ns\195\159, .qwx Uu5 yqx z1qw2jv3 o5p@lrpz y\195\182wx4J Oqu0 mq826 Rr2 qo7 Tvz46s6 4o2xn679, x\195\188679 Ss3 ww3 wt3 82rnntzt7 -rooq4 A@0\195\188ox q7rxrq0L"))
        }
      })
    else
      Wherigo.Dialog({
        {
          Text = WWB_deobf("Mk3 v68 uotpr5 3rms5 0tyw Mq77t1G L6s 1urxpy Pt@2ow 57tx2 p59o7 jxoq4s7N c5ou7 urxqmpv -ns4q4L")
        }
      })
    end
  end
end
function zinputNotiz:OnGetInput(input)
  varNotiz = input
  if varNotiz ~= nil then
    if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("XbL Rh bJLZdN")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("XbLQgZPRXbL")) then
      varNotiz = WWB_deobf("XbL Rh bJLZdN")
    end
    if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("ObTPVbcWNX")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("ObTPVbVUW")) then
      varNotiz = WWB_deobf("ObTPVbcWNX")
    end
    if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("OSdOUhTYLR")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("TKcbSScjNSNT")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("OYcQYZTdcOTOU")) then
      varNotiz = WWB_deobf("OSdOUhTYLR")
    end
    if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("ObTPVbcWNX")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("SKPSRf")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("OSdOUhTYLR")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("XbL Rh bJLZdN")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("KOYQQWZj")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("iSYShZjc")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("bMSUPYhQU")) then
      if string.find(varNotizText, string.upper(varNotiz)) == nil then
        varNotizAnzahl = varNotizAnzahl + 1
        varNotizText = varNotizText .. varNewLine .. "- " .. string.upper(varNotiz)
        if varNotizAnzahl == 1 then
          zitemNotizbuch.Description = WWB_multiplatform_string(WWB_deobf("Wy4u-p9sq xu6 I bot5r1 B3w M7tAurmsq0 @4w 7upv8ypoy V1u40wl5v22uwH Nv6 zn3@5 w79 . erw8u lp4pv6ynlpzK U4uqpzqs Ywpz3zo8yxx 46sw9 k5r rt7 cpu6s: ") .. varNotizText .. "")
        else
          zitemNotizbuch.Description = WWB_multiplatform_string(WWB_deobf("Wy4u-p9sq xu6 I bot5r1 B3w M7tAurmsq0 @4w 7upv8ypoy V1u40wl5v22uwH Nv6 zn3@5 6x3m ") .. varNotizAnzahl .. WWB_deobf(" cpu6s2 ko3ou5xukoyJ T31poypr X3oy2yn7x4woy 57txnx m7t tnx erw8uw: ") .. varNotizText .. "")
        end
        AddNotiz("")
        Wherigo.Dialog({
          {
            Text = WWB_multiplatform_string(WWB_deobf("Msp4r6 mx14 986tn l6s su0 y\195\164qw82oy s5tynx erw8u xz5vs69G"))
          }
        })
      else
        Wherigo.Dialog({
          {
            Text = WWB_deobf("Msp4r6 mx14 57tx2 3ou22 rw Z17xBk4ntK")
          }
        })
      end
    else
      Wherigo.Dialog({
        {
          Text = WWB_deobf("Msp4r6 mx14 y2w32 3upv .n1x66zxsq yupv8 j4q.76rx0otnr1M")
        }
      })
    end
    if varNotizAnzahl >= 7 then
      varAbt = 1
      zoneTeich.Active = true
      varMalusvisus = 5
      cartDasGeheimnisdesKlosters:RequestSync()
      Wherigo.Dialog({
        {
          Text = WWB_deobf("Jr, Vv6 qkm5 rp8 Xz5v~q@lr yv7 quvpy kxsq3tsr1 .xvw ts7sq1tqos2N Nl4 w79 q55K"),
          Media = zmediaCharAbt
        },
        {
          Text = WWB_multiplatform_string(WWB_deobf("Pos5 193 95 O59tn1 Ynz984s365 93m m3v1v9 ssy 6tywoy Os99nv 8vssu0H Q4 .y0n uu1 8rmsq4 7sqyy 8s62r23q0L<\001\002>\n\003\003\003\003axwx5 rp3w @6 0x7G Tou qyw ty U6\195\188xpz h97v @6 tx3moyJ"))
        },
        {
          Text = WWB_multiplatform_string(WWB_deobf("Mkyz y\195\182wxpz @x7 xlou6rxj4pz, 3r kwxr l\195\18214q4 6ylr4ut 7ywn 60r Yq1 pr1 auy35r57sqk4. tx3moy x\195\1823w3I"))
        }
      })
    else
      cartDasGeheimnisdesKlosters:RequestSync()
    end
  end
end
function zinputStartcode:OnGetInput(input)
  varStartcode = input
  if varStartcode ~= nil and Wherigo.NoCaseEquals(varStartcode, WWB_deobf("KOMQaVPkbOY~EDF")) then
    zoneGrnerTurm.Active = true
    zoneInformationstafel.Active = false
    zoneVersuchsgelnde.Active = false
    zoneLabor.Active = false
    zitemZeitmaschine:MoveTo(nil)
    zitemWanduhr:MoveTo(nil)
    zitemZeitmaschine2.Name = WWB_deobf("iot5zo7sqsyq")
    zitemZeitmaschine2.Visible = true
    zoneLabor.Description = WWB_deobf("Ukm045p@v xu6 su0 mq65xuk2mq4sx9nx lrw82j2ntv1tN Ky41179nx tr568lr4 h137mx5ztL")
    zitemZeitmaschine2.Commands.Einschalten.Enabled = false
    zitemZeitmaschine2.Commands.Eintippen.Enabled = true
    zitemZeitmaschine2.Media = zmediaItemZeitmaschine7
    varTimeMachine = 6
    cartDasGeheimnisdesKlosters:RequestSync()
  end
end
function zinputTimeMachineCode:OnGetInput(input)
  varTimeMachineCode = input
  if varTimeMachineCode ~= nil then
    if Wherigo.NoCaseEquals(varTimeMachineCode, WWB_deobf("JdeQZdie!")) or Wherigo.NoCaseEquals(varTimeMachineCode, WWB_deobf("JdeQZdie")) then
      if varTimeMachine == 5 then
        ztimerSecurity:Stop()
        ztimerMittagspause:Stop()
        ztimerWissenschaftler:Stop()
        ztimerZeit:Stop()
        zoneLagerplatz1.Active = false
        zoneLagerplatz2.Active = false
        zoneLagerplatz3.Active = false
        zoneLagerplatz4.Active = false
        zoneVersuchsgelnde.Active = false
        zoneInformationstafel.Active = false
        zoneKlosterpforte.Active = true
        zitemWanduhr:MoveTo(nil)
        zitemZeitmaschine2.Media = zmediaItemZeitmaschine6
        cartDasGeheimnisdesKlosters:RequestSync()
        Wherigo.Dialog({
          {
            Text = WWB_deobf("N2 ynqw9 '@vnp7sq' 60r q3p pr0 Tr20xn- tn1 lrw82j2ntv1t n13ousx32 our Yqq1p4-ow1 .CBDL"),
            Media = zmediaItemZeitmaschine7
          }
        })
      end
      if varTimeMachine >= 7 then
        zoneKeller.Active = false
        zoneLabor.Active = false
        zoneInformationstafel.Active = true
        zitemInformationstafel.Description = WWB_multiplatform_string(WWB_deobf("Rxq040p9ryy46ouuu xu6 u4uqpzqs6 J4q4pv6yo3:") .. varNewLine .. "" .. varNewLine .. WWB_deobf("Qo2.ywrxnx Sy\195\188st65z5qw!") .. varNewLine .. WWB_deobf("M4 tn68 n2 sr6rxjpq5K ly0 s0stt3, om56 t3 oqv1t3 c0m\195\159 xj34q57 @wn 8\195\1886tnx 606 \195\188lp3 sx3nx Qv187jq m7t -56I8us6ypyIo10 2r3 pr0 V0ot4pvp12mzpr '") .. Player.CompletionCode .. WWB_deobf("' q3r8t3G d0yz8u o2 y\195\1643po2 9wt @B lrwrxnx 4rw2, nlz0 zqwx q5 v@2 3qv1, mk34 s6 kot qs6 Nsysnpt j4q AF i2owxr1 wnu\195\1884~8 5o2pr1 2323J"))
        zoneInformationstafel.ShowObjects = "Always"
        cartDasGeheimnisdesKlosters:RequestSync()
        Wherigo.Dialog({
          {
            Text = WWB_deobf("N2 ynqw9 '@vnp7sq' 60r q3p pr0 Tr20xn- tn1 lrw82j2ntv1t n13ousx32 7urrt7 nl4 vt@2srq Xpx0H Myzt8 2ntrw29 lpuz P12oy -8 8nsyJ")
          }
        })
      end
    else
      Wherigo.Dialog({
        {
          Text = WWB_deobf("Mk3 co785y25 w79 xtou7 7rms5vu!")
        }
      })
    end
  end
end
function cartDasGeheimnisdesKlosters.MsgBoxCBFuncs.MsgBoxCB1(action)
  Wherigo.GetInput(zinputMalusvisus)
end
function AddNotiz()
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("SKPSRf")) then
    ztimerBewegung:Stop()
    zoneHubertusschrein.Active = false
    zoneWaschhaus.Active = false
    if varScribus < 2 then
      varScribus = 2
    end
  end
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("OSdOUhTYLR")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("TKcbSScjNSNT")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("OYcQYZTdcOTOU")) then
    zoneTeich.Active = false
  end
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("XbL Rh bJLZdN")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("XbLQgZPRXbL")) then
    zoneFriedhof.Active = false
    if string.find(varNotizText, "BENEDIKT") ~= nil and string.find(varNotizText, "ORA ET LABORA") ~= nil then
      zoneBibliothek.Active = false
    end
  end
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("KOYQQWZj")) then
    zoneJohanneskapelle.Active = false
    zoneKlosterkche.Active = false
  end
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("iSYShZjc")) and string.find(varNotizText, "BENEDIKT") ~= nil and string.find(varNotizText, "ORA ET LABORA") ~= nil then
    zoneBibliothek.Active = false
  end
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("bMSUPYhQU")) then
    zoneKlostermauer.Active = false
  end
  if Wherigo.NoCaseEquals(varNotiz, WWB_deobf("ObTPVbcWNX")) or Wherigo.NoCaseEquals(varNotiz, WWB_deobf("ObTPVbVUW")) then
    zoneInschrift.Active = false
    zoneGarten.Active = false
    zoneInfirmarie.Active = false
  end
end
function CreatePflanzenText()
  varPflanzenText = ""
  varPflanzenAnzahl = 0
  if Player:Contains(zitemKlatschmohn) then
    varPflanzenAnzahl = varPflanzenAnzahl + 1
    varPflanzenText = WWB_deobf("Yk0m8s6 arzqn6 (Tvl55qw2xry)")
  end
  if Player:Contains(zitemHuflattich) then
    if varPflanzenAnzahl ~= 0 then
      varPflanzenText = WWB_multiplatform_string("" .. varPflanzenText .. WWB_deobf(" 4yp "))
    end
    varPflanzenText = WWB_multiplatform_string("" .. varPflanzenText .. WWB_deobf("c434vzpwx Qm4tp7j (T7t0q23tou)"))
    varPflanzenAnzahl = varPflanzenAnzahl + 1
  end
  if Player:Contains(zitemSpitzwegerich) then
    if varPflanzenAnzahl ~= 0 then
      varPflanzenText = WWB_multiplatform_string("" .. varPflanzenText .. WWB_deobf(" 4yp "))
    end
    varPflanzenText = WWB_multiplatform_string("" .. varPflanzenText .. WWB_deobf("Yvlz6ov4 Vlzps31j3z (g4y297qts6ylr)"))
    varPflanzenAnzahl = varPflanzenAnzahl + 1
  end
  if varPflanzenAnzahl == 0 then
    varPflanzenText = WWB_deobf("totzr evuky.r")
  end
  if varPflanzenAnzahl == 1 then
    varPflanzenText = WWB_multiplatform_string(WWB_deobf("w42 rw2u Zqxn1Au, y\195\16400ylr ") .. varPflanzenText .. WWB_deobf(","))
  end
  if varPflanzenAnzahl == 2 then
    varPflanzenText = WWB_multiplatform_string(WWB_deobf("w42 -@ty Zqxn1Auw, z\195\16411rms ") .. varPflanzenText .. WWB_deobf(","))
  end
end
function DropPflanze(parPflanze)
  if zoneGarten:Contains(Player) then
    varPflanzen = varPflanzen - 1
    parPflanze:MoveTo(zoneGarten)
    parPflanze.Commands.Mitnehmen.Enabled = true
    parPflanze.Commands.Abstellen.Enabled = false
  else
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Msp ct0qw9p xo23 rtq4 0urnp3 1x7poyp5 prpowqt7 -n1oq0L")
      }
    })
  end
end
function InitItems()
  AddDefaultCommands(cartDasGeheimnisdesKlosters, {
    zitemEnergieversorgung,
    zitemFluxxKompensator,
    zitemKuehlung,
    zitemStartknopf
  })
end
function InitTables()
  tblBewegung = {}
  table.insert(tblBewegung, Wherigo.ZonePoint(48.5616, 9.0595, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56164, 9.05962, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56173, 9.05968, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.5618, 9.05977, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56186, 9.05987, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56193, 9.05995, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56201, 9.06003, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56208, 9.06011, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56215, 9.06019, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56221, 9.06029, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56228, 9.0604, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56234, 9.0605, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.5624, 9.06059, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56249, 9.06057, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56257, 9.06051, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56265, 9.06047, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56274, 9.06043, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56282, 9.0604, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56291, 9.06037, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.563, 9.06033, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56308, 9.0603, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56317, 9.06027, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56326, 9.06025, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56335, 9.06023, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56344, 9.06022, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56353, 9.06022, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56362, 9.06024, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56371, 9.06027, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56379, 9.06031, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56388, 9.06035, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56396, 9.06038, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56406, 9.06039, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56415, 9.06039, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56425, 9.0604, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56434, 9.06041, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56443, 9.06042, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56452, 9.06043, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56461, 9.06043, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.5647, 9.06045, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56479, 9.06047, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56488, 9.06049, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56497, 9.06051, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56506, 9.06052, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56515, 9.06054, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56524, 9.06056, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56533, 9.06058, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56543, 9.0606, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56551, 9.06062, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56561, 9.06064, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56569, 9.06068, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56577, 9.06071, 0))
  table.insert(tblBewegung, Wherigo.ZonePoint(48.56586, 9.06075, 0))
  varBewegungMax = table.getn(tblBewegung)
end
function KutteAn(parKutte)
  if Player:Contains(zitemBenediktinerkutte) or Player:Contains(zitemDominikanerkutte) or Player:Contains(zitemZisterzienserkutte) then
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Vs4 -@ty U556s2 5s2p s7 1sntr50ylr .7 .q0wI")
      }
    })
  else
    parKutte:MoveTo(Player)
    parKutte.Commands.Anziehen.Enabled = false
    parKutte.Commands.Ausziehen.Enabled = true
  end
end
function KutteAus(parKutte)
  if zoneLabor:Contains(Player) then
    parKutte:MoveTo(zoneLabor)
    parKutte.Commands.Anziehen.Enabled = true
    parKutte.Commands.Ausziehen.Enabled = false
  else
    Wherigo.Dialog({
      {
        Text = WWB_deobf("Qsp3 yp3w xm0 7ylr zvqw9 otzsorx k54-wtxnxI")
      }
    })
  end
end
function TakePflanze(parPflanze)
  if varPflanzen < 3 then
    varPflanzen = varPflanzen + 1
    parPflanze:MoveTo(Player)
    parPflanze.Commands.Mitnehmen.Enabled = false
    parPflanze.Commands.Abstellen.Enabled = true
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string(WWB_deobf("Vos3 o08 n2qv evuky.r1 8xvw5r 1qw yupv8 21lsr1, mk 4vs 8xx35 6tx0 wqvqw9 ul1778 posq0 z\195\182xy5r1M"))
      }
    })
  end
end
function AddDefaultCommands(parCartridge, parItems)
  local tabItems = {}
  for k, v in pairs(parCartridge.AllZObjects) do
    if tostring(v) == "a ZItem instance" then
      if parItems == nil then
        table.insert(tabItems, v)
      else
        for j, w in pairs(parItems) do
          if w == v then
            table.insert(tabItems, v)
          end
        end
      end
    end
  end
  for k, v in pairs(tabItems) do
    local tabCommands = {}
    for j, w in pairs(v.Commands) do
      tabCommands[w.Text] = w
    end
    if tabCommands.Mitnehmen == nil then
      tabCommands.Mitnehmen = Wherigo.ZCommand({
        Text = "Mitnehmen",
        CmdWith = false,
        Enabled = true,
        Custom = true,
        WorksWithAll = true
      })
      v.OnMitnehmen = TakeItem
    end
    if tabCommands.Abstellen == nil then
      tabCommands.Abstellen = Wherigo.ZCommand({
        Text = "Abstellen",
        CmdWith = false,
        Enabled = false,
        Custom = true,
        WorksWithAll = true
      })
      v.OnAbstellen = DropItem
    end
    v.Commands = tabCommands
  end
end
function TakeItem(self)
  if CountItems() < 1 then
    self:MoveTo(Player)
    if self.Commands.Mitnehmen ~= nil then
      self.Commands.Mitnehmen.Enabled = false
    end
    if self.Commands.Abstellen ~= nil then
      self.Commands.Abstellen.Enabled = true
    end
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Leider kannst du nur einen Gegenstand mitnehmen. Wenn Du also diesen Gegenstand mitnehmen m\195\182chtest, dann musst du zuvor einen Anderen ablegen."),
      Buttons = {"Ok"}
    })
  end
end
function DropItem(self)
  local varZone = GetActiveZone()
  if varZone ~= nil then
    self:MoveTo(varZone)
    if self.Commands.Mitnehmen ~= nil then
      self.Commands.Mitnehmen.Enabled = true
    end
    if self.Commands.Abstellen ~= nil then
      self.Commands.Abstellen.Enabled = false
    end
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du kannst den Gegenstand nicht abgestellen. Hier ist kein Platz daf\195\188r."),
      Buttons = {"Ok"}
    })
  end
end
function GetActiveZone()
  local varZone
  if #Player.InsideOfZones > 0 then
    varZone = Player.InsideOfZones[1]
  end
  return varZone
end
function CountItems()
  local varNum = 0
  for k, v in pairs(Player.Inventory) do
    if v.Visible == true then
      varNum = varNum + 1
    end
  end
  return varNum
end
return cartDasGeheimnisdesKlosters
