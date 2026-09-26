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
cartGhostbusters = Wherigo.ZCartridge()
WWB_current_cartridge = cartGhostbusters
cartGhostbusters.MsgBoxCBFuncs = {}
zmediaAlterEgo = Wherigo.ZMedia(cartGhostbusters)
zmediaAlterEgo.Id = "ff97c596e17e891fd5d0cb6982bee2c2"
zmediaAlterEgo.Name = "AlterEgo"
zmediaAlterEgo.AltText = ""
zmediaAlterEgo.Resources = {
  {
    Type = "jpg",
    Filename = "chars_youWinston.jpg",
    Directives = {}
  }
}
zmediaAngel = Wherigo.ZMedia(cartGhostbusters)
zmediaAngel.Id = "3b824be9aee06829b9d0c0b192937db7"
zmediaAngel.Name = "Angel"
zmediaAngel.AltText = ""
zmediaAngel.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Angel_covered.jpg",
    Directives = {}
  }
}
zmediaAngelCap = Wherigo.ZMedia(cartGhostbusters)
zmediaAngelCap.Id = "3b87b8510b10102888fe6afd009bc3f2"
zmediaAngelCap.Name = "AngelCap"
zmediaAngelCap.AltText = ""
zmediaAngelCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Angel_cap.jpg",
    Directives = {}
  }
}
zmediaAngel_evil = Wherigo.ZMedia(cartGhostbusters)
zmediaAngel_evil.Id = "6467c126688170cff0b13b115f15171d"
zmediaAngel_evil.Name = "Angel_evil"
zmediaAngel_evil.AltText = ""
zmediaAngel_evil.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Angel_evil.jpg",
    Directives = {}
  }
}
zmediaAngel_open = Wherigo.ZMedia(cartGhostbusters)
zmediaAngel_open.Id = "2edbbae76123d00e3c404d4faf90b34f"
zmediaAngel_open.Name = "Angel_open"
zmediaAngel_open.AltText = ""
zmediaAngel_open.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Angel_open.jpg",
    Directives = {}
  }
}
zmediaCaptain = Wherigo.ZMedia(cartGhostbusters)
zmediaCaptain.Id = "8f881f67a38b793f96f04fc74495b55c"
zmediaCaptain.Name = "Captain"
zmediaCaptain.AltText = ""
zmediaCaptain.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Captain.jpg",
    Directives = {}
  }
}
zmediaCaptainCap = Wherigo.ZMedia(cartGhostbusters)
zmediaCaptainCap.Id = "72e62b1f3808f746f434664ce0e95dad"
zmediaCaptainCap.Name = "CaptainCap"
zmediaCaptainCap.AltText = ""
zmediaCaptainCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Captain_cap.jpg",
    Directives = {}
  }
}
zmediaDana = Wherigo.ZMedia(cartGhostbusters)
zmediaDana.Id = "80deebd923e459c898ff91e050ac75ac"
zmediaDana.Name = "Dana"
zmediaDana.AltText = ""
zmediaDana.Resources = {
  {
    Type = "jpg",
    Filename = "char_Dana_dialog.jpg",
    Directives = {}
  }
}
zmediaDanaPossesed = Wherigo.ZMedia(cartGhostbusters)
zmediaDanaPossesed.Id = "b37013e69d63b55a0ac5046729f30246"
zmediaDanaPossesed.Name = "DanaPossesed"
zmediaDanaPossesed.AltText = ""
zmediaDanaPossesed.Resources = {
  {
    Type = "jpg",
    Filename = "char_Dana_pos_dialog.jpg",
    Directives = {}
  }
}
zmediaEcto1 = Wherigo.ZMedia(cartGhostbusters)
zmediaEcto1.Id = "b1a7fac67895cdb59e335d02dc4bf772"
zmediaEcto1.Name = "Ecto-1"
zmediaEcto1.AltText = ""
zmediaEcto1.Resources = {
  {
    Type = "jpg",
    Filename = "item_ecto.jpg",
    Directives = {}
  }
}
zmediaEdward = Wherigo.ZMedia(cartGhostbusters)
zmediaEdward.Id = "038decfc1d72ed3ffc2ea8a8d857e760"
zmediaEdward.Name = "Edward"
zmediaEdward.AltText = ""
zmediaEdward.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Edward.jpg",
    Directives = {}
  }
}
zmediaEdwardCap = Wherigo.ZMedia(cartGhostbusters)
zmediaEdwardCap.Id = "5932a5241e2d660b3a7843f6e00227da"
zmediaEdwardCap.Name = "EdwardCap"
zmediaEdwardCap.AltText = ""
zmediaEdwardCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Edward_cap.jpg",
    Directives = {}
  }
}
zmediaEgonAction = Wherigo.ZMedia(cartGhostbusters)
zmediaEgonAction.Id = "674425bbae66c933016fe9585a8fba44"
zmediaEgonAction.Name = "Egon Action"
zmediaEgonAction.AltText = ""
zmediaEgonAction.Resources = {
  {
    Type = "jpg",
    Filename = "char_Egon_action.jpg",
    Directives = {}
  }
}
zmediaEgonDialog = Wherigo.ZMedia(cartGhostbusters)
zmediaEgonDialog.Id = "ef88a2772fe32115cee6276d5583120d"
zmediaEgonDialog.Name = "Egon Dialog"
zmediaEgonDialog.AltText = ""
zmediaEgonDialog.Resources = {
  {
    Type = "jpg",
    Filename = "char_Egon_dialog.jpg",
    Directives = {}
  }
}
zmediaEnde = Wherigo.ZMedia(cartGhostbusters)
zmediaEnde.Id = "055901f3fb79bc58d9724fe16c2c5922"
zmediaEnde.Name = "Ende"
zmediaEnde.AltText = ""
zmediaEnde.Resources = {
  {
    Type = "jpg",
    Filename = "ende.jpg",
    Directives = {}
  }
}
zmediaFlame = Wherigo.ZMedia(cartGhostbusters)
zmediaFlame.Id = "cdb32f3262635a9211b409d4fcac0e7a"
zmediaFlame.Name = "Flame"
zmediaFlame.AltText = ""
zmediaFlame.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_flame.jpg",
    Directives = {}
  }
}
zmediaFlameCap = Wherigo.ZMedia(cartGhostbusters)
zmediaFlameCap.Id = "92f32a9039733e9259dfd176b6a06d60"
zmediaFlameCap.Name = "FlameCap"
zmediaFlameCap.AltText = ""
zmediaFlameCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_flame_cap.jpg",
    Directives = {}
  }
}
zmediaFrank = Wherigo.ZMedia(cartGhostbusters)
zmediaFrank.Id = "2b21c060d03037ea511333dad60c486f"
zmediaFrank.Name = "Frank"
zmediaFrank.AltText = ""
zmediaFrank.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Frank.jpg",
    Directives = {}
  }
}
zmediaFrankCap = Wherigo.ZMedia(cartGhostbusters)
zmediaFrankCap.Id = "cadb43fa416e90b3736527febe5927b5"
zmediaFrankCap.Name = "FrankCap"
zmediaFrankCap.AltText = ""
zmediaFrankCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Frank_cap.jpg",
    Directives = {}
  }
}
zmediaGeisterzug = Wherigo.ZMedia(cartGhostbusters)
zmediaGeisterzug.Id = "e100fbcb2003c27b3f7aff718f44399f"
zmediaGeisterzug.Name = "Geisterzug"
zmediaGeisterzug.AltText = ""
zmediaGeisterzug.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Train.jpg",
    Directives = {}
  }
}
zmediaGeisterzugCap = Wherigo.ZMedia(cartGhostbusters)
zmediaGeisterzugCap.Id = "0645db6736141782c63375315d2d859c"
zmediaGeisterzugCap.Name = "GeisterzugCap"
zmediaGeisterzugCap.AltText = ""
zmediaGeisterzugCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Train_cap.jpg",
    Directives = {}
  }
}
zmediaGozer = Wherigo.ZMedia(cartGhostbusters)
zmediaGozer.Id = "690eb7855abd6b95b6a2ec9bc4830028"
zmediaGozer.Name = "Gozer"
zmediaGozer.AltText = ""
zmediaGozer.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Gozer.jpg",
    Directives = {}
  }
}
zmediaGozerCap = Wherigo.ZMedia(cartGhostbusters)
zmediaGozerCap.Id = "3c2d90c1ff6ddbaa0dcd8195f3db9ebb"
zmediaGozerCap.Name = "GozerCap"
zmediaGozerCap.AltText = ""
zmediaGozerCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Gozer_cap.jpg",
    Directives = {}
  }
}
zmediaGozerInv = Wherigo.ZMedia(cartGhostbusters)
zmediaGozerInv.Id = "eba67f1d3fc92053e21c56b67c9a42c4"
zmediaGozerInv.Name = "GozerInv"
zmediaGozerInv.AltText = ""
zmediaGozerInv.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Gozer_inv.jpg",
    Directives = {}
  }
}
zmediaGozer_attak = Wherigo.ZMedia(cartGhostbusters)
zmediaGozer_attak.Id = "80f9b9e00a02f1481b60aa76bbf8ca25"
zmediaGozer_attak.Name = "Gozer_attak"
zmediaGozer_attak.AltText = ""
zmediaGozer_attak.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Gozer_attak.jpg",
    Directives = {}
  }
}
zmediaJanine = Wherigo.ZMedia(cartGhostbusters)
zmediaJanine.Id = "a03ec137474a6e3e12a6465343bfd47c"
zmediaJanine.Name = "Janine"
zmediaJanine.AltText = ""
zmediaJanine.Resources = {
  {
    Type = "jpg",
    Filename = "char_Janine_dialog.jpg",
    Directives = {}
  }
}
zmediaJanineTask = Wherigo.ZMedia(cartGhostbusters)
zmediaJanineTask.Id = "f07d8703980097a07667f6ee28fc7e75"
zmediaJanineTask.Name = "JanineTask"
zmediaJanineTask.AltText = ""
zmediaJanineTask.Resources = {
  {
    Type = "jpg",
    Filename = "char_Janine_tasks.jpg",
    Directives = {}
  }
}
zmediaKang = Wherigo.ZMedia(cartGhostbusters)
zmediaKang.Id = "01876bd10ce5b3181071c4ba18303a73"
zmediaKang.Name = "Kang"
zmediaKang.AltText = ""
zmediaKang.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Kang.jpg",
    Directives = {}
  }
}
zmediaKey = Wherigo.ZMedia(cartGhostbusters)
zmediaKey.Id = "ef726d3335e77bbd7c3f8f633dcd28d5"
zmediaKey.Name = "Key"
zmediaKey.AltText = ""
zmediaKey.Resources = {
  {
    Type = "jpg",
    Filename = "item_key.jpg",
    Directives = {}
  }
}
zmediaLouis = Wherigo.ZMedia(cartGhostbusters)
zmediaLouis.Id = "21fd8e2d4c643cd2b027bb9ddbc994d1"
zmediaLouis.Name = "Louis"
zmediaLouis.AltText = ""
zmediaLouis.Resources = {
  {
    Type = "jpg",
    Filename = "char_Lewis_dialog.jpg",
    Directives = {}
  }
}
zmediaLouisPossesed = Wherigo.ZMedia(cartGhostbusters)
zmediaLouisPossesed.Id = "53066353f89fadd27eda0e346eaf73ac"
zmediaLouisPossesed.Name = "LouisPossesed"
zmediaLouisPossesed.AltText = ""
zmediaLouisPossesed.Resources = {
  {
    Type = "jpg",
    Filename = "char_Lewis_pos_dialog.jpg",
    Directives = {}
  }
}
zmediaOfficer = Wherigo.ZMedia(cartGhostbusters)
zmediaOfficer.Id = "fc84cb21affb98496c3a353d8c199d06"
zmediaOfficer.Name = "Officer"
zmediaOfficer.AltText = ""
zmediaOfficer.Resources = {
  {
    Type = "jpg",
    Filename = "char_Officer.jpg",
    Directives = {}
  }
}
zmediaPeterAction = Wherigo.ZMedia(cartGhostbusters)
zmediaPeterAction.Id = "76df7e204cbdb47ae0876033b2579366"
zmediaPeterAction.Name = "Peter Action"
zmediaPeterAction.AltText = ""
zmediaPeterAction.Resources = {
  {
    Type = "jpg",
    Filename = "char_Vankman_action.jpg",
    Directives = {}
  }
}
zmediaPeterDialog = Wherigo.ZMedia(cartGhostbusters)
zmediaPeterDialog.Id = "77bcb1b0dd728d7bd92956ad9f84c91f"
zmediaPeterDialog.Name = "Peter Dialog"
zmediaPeterDialog.AltText = ""
zmediaPeterDialog.Resources = {
  {
    Type = "jpg",
    Filename = "char_Vankman_dialog.jpg",
    Directives = {}
  }
}
zmediaProtoPack = Wherigo.ZMedia(cartGhostbusters)
zmediaProtoPack.Id = "3b9794cd9effa75c7cf7d3811dca5fc6"
zmediaProtoPack.Name = "ProtoPack"
zmediaProtoPack.AltText = ""
zmediaProtoPack.Resources = {
  {
    Type = "jpg",
    Filename = "item_protopack_off.jpg",
    Directives = {}
  }
}
zmediaProtoPackActive = Wherigo.ZMedia(cartGhostbusters)
zmediaProtoPackActive.Id = "5919c70e1bbd8d3d24c0b1ba2fd7d9d4"
zmediaProtoPackActive.Name = "ProtoPackActive"
zmediaProtoPackActive.AltText = ""
zmediaProtoPackActive.Resources = {
  {
    Type = "jpg",
    Filename = "item_protopack_on.jpg",
    Directives = {}
  }
}
zmediaPuffy = Wherigo.ZMedia(cartGhostbusters)
zmediaPuffy.Id = "f5624ed8179968714065de08aeb967f9"
zmediaPuffy.Name = "Puffy"
zmediaPuffy.AltText = ""
zmediaPuffy.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Puffy.jpg",
    Directives = {}
  }
}
zmediaPuffyCap = Wherigo.ZMedia(cartGhostbusters)
zmediaPuffyCap.Id = "cd367faf24a8e35ed4be86344118011e"
zmediaPuffyCap.Name = "PuffyCap"
zmediaPuffyCap.AltText = ""
zmediaPuffyCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Puffy_cap.jpg",
    Directives = {}
  }
}
zmediaPuffyFire = Wherigo.ZMedia(cartGhostbusters)
zmediaPuffyFire.Id = "3c3091c1bf4387822e317ad0e8036d33"
zmediaPuffyFire.Name = "PuffyFire"
zmediaPuffyFire.AltText = ""
zmediaPuffyFire.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Puffy_fire.jpg",
    Directives = {}
  }
}
zmediaRayAction = Wherigo.ZMedia(cartGhostbusters)
zmediaRayAction.Id = "e2bca651aa236586484d3ab22ff310f3"
zmediaRayAction.Name = "Ray Action"
zmediaRayAction.AltText = ""
zmediaRayAction.Resources = {
  {
    Type = "jpg",
    Filename = "char_Ray_action.jpg",
    Directives = {}
  }
}
zmediaRayActionTrap = Wherigo.ZMedia(cartGhostbusters)
zmediaRayActionTrap.Id = "e0fba4c9e182a3c9ba50570b244137ba"
zmediaRayActionTrap.Name = "Ray Action Trap"
zmediaRayActionTrap.AltText = ""
zmediaRayActionTrap.Resources = {
  {
    Type = "jpg",
    Filename = "char_Ray_action_trap.jpg",
    Directives = {}
  }
}
zmediaRayDialog = Wherigo.ZMedia(cartGhostbusters)
zmediaRayDialog.Id = "b315c6d10abd0befd1361e72833010ae"
zmediaRayDialog.Name = "Ray Dialog"
zmediaRayDialog.AltText = ""
zmediaRayDialog.Resources = {
  {
    Type = "jpg",
    Filename = "char_Ray_dialog.jpg",
    Directives = {}
  }
}
zmediaRitter = Wherigo.ZMedia(cartGhostbusters)
zmediaRitter.Id = "b2f73564749ad38a2f59a275579205a3"
zmediaRitter.Name = "Ritter"
zmediaRitter.AltText = ""
zmediaRitter.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Knight.jpg",
    Directives = {}
  }
}
zmediaRitterCap = Wherigo.ZMedia(cartGhostbusters)
zmediaRitterCap.Id = "78500af3691b187e6aaa91c0b4570026"
zmediaRitterCap.Name = "RitterCap"
zmediaRitterCap.AltText = ""
zmediaRitterCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Knight_cap.jpg",
    Directives = {}
  }
}
zmediaSchatten = Wherigo.ZMedia(cartGhostbusters)
zmediaSchatten.Id = "8097933a988241980ca7e539eacb4d6c"
zmediaSchatten.Name = "Schatten"
zmediaSchatten.AltText = ""
zmediaSchatten.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Shadow.jpg",
    Directives = {}
  }
}
zmediaSchattenCap = Wherigo.ZMedia(cartGhostbusters)
zmediaSchattenCap.Id = "4dd168c729b2eae5b5c249ae082153b1"
zmediaSchattenCap.Name = "SchattenCap"
zmediaSchattenCap.AltText = ""
zmediaSchattenCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Shadow_cap.jpg",
    Directives = {}
  }
}
zmediaSlimer = Wherigo.ZMedia(cartGhostbusters)
zmediaSlimer.Id = "f1dcdfc228e0e7874227a2f6318899fb"
zmediaSlimer.Name = "Slimer"
zmediaSlimer.AltText = ""
zmediaSlimer.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Slimer.jpg",
    Directives = {}
  }
}
zmediaSlimerCap = Wherigo.ZMedia(cartGhostbusters)
zmediaSlimerCap.Id = "e29f72f980de77db6a9998438d4d5b98"
zmediaSlimerCap.Name = "SlimerCap"
zmediaSlimerCap.AltText = ""
zmediaSlimerCap.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Slimer_cap.jpg",
    Directives = {}
  }
}
zmediaSoundAlert = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundAlert.Id = "3c913835528fc6a4105e7fe2f6230ba5"
zmediaSoundAlert.Name = "SoundAlert"
zmediaSoundAlert.AltText = ""
zmediaSoundAlert.Resources = {
  {
    Type = "fdl",
    Filename = "SoundAlert.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "SoundAlert.mp3",
    Directives = {}
  }
}
zmediaSoundCrowd = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundCrowd.Id = "982daeeb8e856601ed04cc4604c13322"
zmediaSoundCrowd.Name = "SoundCrowd"
zmediaSoundCrowd.AltText = ""
zmediaSoundCrowd.Resources = {
  {
    Type = "fdl",
    Filename = "crowd.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "crowd_ghostbusters.mp3",
    Directives = {}
  }
}
zmediaSoundEcto = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundEcto.Id = "01b6b271e67cc09f15ab3cfc9c156272"
zmediaSoundEcto.Name = "SoundEcto"
zmediaSoundEcto.AltText = ""
zmediaSoundEcto.Resources = {
  {
    Type = "fdl",
    Filename = "SoundEcto.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "SoundEcto.mp3",
    Directives = {}
  }
}
zmediaSoundEnterZone = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundEnterZone.Id = "a4ef050cc29f0b0ce46e873468f395d1"
zmediaSoundEnterZone.Name = "SoundEnterZone"
zmediaSoundEnterZone.AltText = ""
zmediaSoundEnterZone.Resources = {
  {
    Type = "fdl",
    Filename = "EnterZone.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "EnterZone.mp3",
    Directives = {}
  }
}
zmediaSoundExplosion = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundExplosion.Id = "85e83bd709f8047eab0285a80e8d8f74"
zmediaSoundExplosion.Name = "SoundExplosion"
zmediaSoundExplosion.AltText = ""
zmediaSoundExplosion.Resources = {
  {
    Type = "mp3",
    Filename = "explosion.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "explosion.fdl",
    Directives = {}
  }
}
zmediaSoundGhost = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundGhost.Id = "32b39552f7afd4815424ade76dfce54c"
zmediaSoundGhost.Name = "SoundGhost"
zmediaSoundGhost.AltText = ""
zmediaSoundGhost.Resources = {
  {
    Type = "fdl",
    Filename = "SoundGhosts.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "SoundGhosts.mp3",
    Directives = {}
  }
}
zmediaSoundGhost2 = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundGhost2.Id = "ab1afc1c59b9bbe2c68ccd1443320e69"
zmediaSoundGhost2.Name = "SoundGhost2"
zmediaSoundGhost2.AltText = ""
zmediaSoundGhost2.Resources = {
  {
    Type = "fdl",
    Filename = "SoundGhosts2.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "SoundGhosts2.mp3",
    Directives = {}
  }
}
zmediaSoundProtoFIRE = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundProtoFIRE.Id = "e54c9752cd6c30221196985208fb877a"
zmediaSoundProtoFIRE.Name = "SoundProtoFIRE"
zmediaSoundProtoFIRE.AltText = ""
zmediaSoundProtoFIRE.Resources = {
  {
    Type = "fdl",
    Filename = "ProtoPackFire.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "ProtoPackFire.mp3",
    Directives = {}
  }
}
zmediaSoundProtoOFF = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundProtoOFF.Id = "e9caeb01ec62fdc840da970c38ad1e8b"
zmediaSoundProtoOFF.Name = "SoundProtoOFF"
zmediaSoundProtoOFF.AltText = ""
zmediaSoundProtoOFF.Resources = {
  {
    Type = "fdl",
    Filename = "ProtoPackDeactive.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "ProtoPackDeactive.mp3",
    Directives = {}
  }
}
zmediaSoundProtoON = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundProtoON.Id = "ddf96495861b16ef439a7a4e5a8319b9"
zmediaSoundProtoON.Name = "SoundProtoON"
zmediaSoundProtoON.AltText = ""
zmediaSoundProtoON.Resources = {
  {
    Type = "fdl",
    Filename = "ProtoPackActive.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "ProtoPackActive.mp3",
    Directives = {}
  }
}
zmediaSoundSpark = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundSpark.Id = "e0d6971b016321627ef1ccd5ab7acffa"
zmediaSoundSpark.Name = "SoundSpark"
zmediaSoundSpark.AltText = ""
zmediaSoundSpark.Resources = {
  {
    Type = "fdl",
    Filename = "spark.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "spark.mp3",
    Directives = {}
  }
}
zmediaSoundThunder = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundThunder.Id = "b01989e39f391ea9bc81bf6c89f82b1b"
zmediaSoundThunder.Name = "SoundThunder"
zmediaSoundThunder.AltText = ""
zmediaSoundThunder.Resources = {
  {
    Type = "mp3",
    Filename = "thunder.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "thunder.fdl",
    Directives = {}
  }
}
zmediaSoundTitle = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundTitle.Id = "bb848174e39ceb82eeb6ece74eebffa9"
zmediaSoundTitle.Name = "SoundTitle"
zmediaSoundTitle.AltText = ""
zmediaSoundTitle.Resources = {
  {
    Type = "fdl",
    Filename = "title.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "title.mp3",
    Directives = {}
  }
}
zmediaSoundTrapON = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundTrapON.Id = "792cb0f4802bbcb92055e73cd67f5540"
zmediaSoundTrapON.Name = "SoundTrapON"
zmediaSoundTrapON.AltText = ""
zmediaSoundTrapON.Resources = {
  {
    Type = "fdl",
    Filename = "TrapActive.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "TrapActive.mp3",
    Directives = {}
  }
}
zmediaSoundTrapUNLOAD = Wherigo.ZMedia(cartGhostbusters)
zmediaSoundTrapUNLOAD.Id = "a23a98f50b97e4166d85e61767243727"
zmediaSoundTrapUNLOAD.Name = "SoundTrapUNLOAD"
zmediaSoundTrapUNLOAD.AltText = ""
zmediaSoundTrapUNLOAD.Resources = {
  {
    Type = "fdl",
    Filename = "TrapUnload.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "TrapUnload.mp3",
    Directives = {}
  }
}
zmediaTempel = Wherigo.ZMedia(cartGhostbusters)
zmediaTempel.Id = "f799a722732161f70b0b7204f049bd99"
zmediaTempel.Name = "Tempel"
zmediaTempel.AltText = ""
zmediaTempel.Resources = {
  {
    Type = "jpg",
    Filename = "tempel.jpg",
    Directives = {}
  }
}
zmediatempel001 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel001.Id = "353f3a57b9a90da5f7bef3b385815f4f"
zmediatempel001.Name = "tempel001"
zmediatempel001.AltText = ""
zmediatempel001.Resources = {
  {
    Type = "jpg",
    Filename = "tempel001.jpg",
    Directives = {}
  }
}
zmediatempel002 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel002.Id = "2b4de94a2fea632f903f54d87697783b"
zmediatempel002.Name = "tempel002"
zmediatempel002.AltText = ""
zmediatempel002.Resources = {
  {
    Type = "jpg",
    Filename = "tempel002.jpg",
    Directives = {}
  }
}
zmediatempel003 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel003.Id = "3ac8a826e03696ceffc1b02ee898a8ee"
zmediatempel003.Name = "tempel003"
zmediatempel003.AltText = ""
zmediatempel003.Resources = {
  {
    Type = "jpg",
    Filename = "tempel003.jpg",
    Directives = {}
  }
}
zmediatempel004 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel004.Id = "2a34233b5b829e61a921d57f16077524"
zmediatempel004.Name = "tempel004"
zmediatempel004.AltText = ""
zmediatempel004.Resources = {
  {
    Type = "jpg",
    Filename = "tempel004.jpg",
    Directives = {}
  }
}
zmediatempel005 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel005.Id = "6eceb1fa86b8488c33e2378ac47c2ffe"
zmediatempel005.Name = "tempel005"
zmediatempel005.AltText = ""
zmediatempel005.Resources = {
  {
    Type = "jpg",
    Filename = "tempel005.jpg",
    Directives = {}
  }
}
zmediatempel006 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel006.Id = "8eca1e3af1d3d986535dfcb6b82f7388"
zmediatempel006.Name = "tempel006"
zmediatempel006.AltText = ""
zmediatempel006.Resources = {
  {
    Type = "jpg",
    Filename = "tempel006.jpg",
    Directives = {}
  }
}
zmediatempel007 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel007.Id = "9326c1f82f736eb3dcf751b8402362f6"
zmediatempel007.Name = "tempel007"
zmediatempel007.AltText = ""
zmediatempel007.Resources = {
  {
    Type = "jpg",
    Filename = "tempel007.jpg",
    Directives = {}
  }
}
zmediatempel008 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel008.Id = "c7bf8ba28a496d4045829e28cbd8cd9a"
zmediatempel008.Name = "tempel008"
zmediatempel008.AltText = ""
zmediatempel008.Resources = {
  {
    Type = "jpg",
    Filename = "tempel008.jpg",
    Directives = {}
  }
}
zmediatempel009 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel009.Id = "bb654fde81409ea8c811e18c91aa3fba"
zmediatempel009.Name = "tempel009"
zmediatempel009.AltText = ""
zmediatempel009.Resources = {
  {
    Type = "jpg",
    Filename = "tempel009.jpg",
    Directives = {}
  }
}
zmediatempel010 = Wherigo.ZMedia(cartGhostbusters)
zmediatempel010.Id = "8a71f414fe371b54064941cf5498d616"
zmediatempel010.Name = "tempel010"
zmediatempel010.AltText = ""
zmediatempel010.Resources = {
  {
    Type = "jpg",
    Filename = "tempel010.jpg",
    Directives = {}
  }
}
zmediaTempelCap1 = Wherigo.ZMedia(cartGhostbusters)
zmediaTempelCap1.Id = "8a55bcdea21c7691e59282530c3e8c1b"
zmediaTempelCap1.Name = "TempelCap1"
zmediaTempelCap1.AltText = ""
zmediaTempelCap1.Resources = {
  {
    Type = "jpg",
    Filename = "tempel_cap1.jpg",
    Directives = {}
  }
}
zmediaTempelCap2 = Wherigo.ZMedia(cartGhostbusters)
zmediaTempelCap2.Id = "9d9ccd20f7d101a1b08a18cfb184edd0"
zmediaTempelCap2.Name = "TempelCap2"
zmediaTempelCap2.AltText = ""
zmediaTempelCap2.Resources = {
  {
    Type = "jpg",
    Filename = "tempel_cap2.jpg",
    Directives = {}
  }
}
zmediaTempelFire = Wherigo.ZMedia(cartGhostbusters)
zmediaTempelFire.Id = "afb3d51721aeff5becaca13629d3724b"
zmediaTempelFire.Name = "TempelFire"
zmediaTempelFire.AltText = ""
zmediaTempelFire.Resources = {
  {
    Type = "jpg",
    Filename = "tempel_fire.jpg",
    Directives = {}
  }
}
zmediathavorianer = Wherigo.ZMedia(cartGhostbusters)
zmediathavorianer.Id = "cd588e671cc0f0e93b6c6bb4a21237a9"
zmediathavorianer.Name = "thavorianer"
zmediathavorianer.AltText = ""
zmediathavorianer.Resources = {
  {
    Type = "jpg",
    Filename = "thavorianer.jpg",
    Directives = {}
  }
}
zmediatimer10 = Wherigo.ZMedia(cartGhostbusters)
zmediatimer10.Id = "dbcb96121c6a31e7c92ad26366ca404a"
zmediatimer10.Name = "timer10"
zmediatimer10.AltText = ""
zmediatimer10.Resources = {
  {
    Type = "jpg",
    Filename = "10.jpg",
    Directives = {}
  }
}
zmediatimer20 = Wherigo.ZMedia(cartGhostbusters)
zmediatimer20.Id = "05141f4aa590bef325445af8080cb4a7"
zmediatimer20.Name = "timer20"
zmediatimer20.AltText = ""
zmediatimer20.Resources = {
  {
    Type = "jpg",
    Filename = "20.jpg",
    Directives = {}
  }
}
zmediatimer30 = Wherigo.ZMedia(cartGhostbusters)
zmediatimer30.Id = "f5d3c808c26195f703124ea5b2373cc9"
zmediatimer30.Name = "timer30"
zmediatimer30.AltText = ""
zmediatimer30.Resources = {
  {
    Type = "jpg",
    Filename = "30.jpg",
    Directives = {}
  }
}
zmediatimer60 = Wherigo.ZMedia(cartGhostbusters)
zmediatimer60.Id = "9fb283f373edf4292e71608f62d74ff1"
zmediatimer60.Name = "timer60"
zmediatimer60.AltText = ""
zmediatimer60.Resources = {
  {
    Type = "jpg",
    Filename = "60.jpg",
    Directives = {}
  }
}
zmediaTitle = Wherigo.ZMedia(cartGhostbusters)
zmediaTitle.Id = "5b5249f48a1f98504a5d1b42de2355d8"
zmediaTitle.Name = "Title"
zmediaTitle.AltText = ""
zmediaTitle.Resources = {
  {
    Type = "jpg",
    Filename = "titlescreen.jpg",
    Directives = {}
  }
}
zmediaTrapEmpty = Wherigo.ZMedia(cartGhostbusters)
zmediaTrapEmpty.Id = "4a798a7494148190522143970cea9c28"
zmediaTrapEmpty.Name = "Trap Empty"
zmediaTrapEmpty.AltText = ""
zmediaTrapEmpty.Resources = {
  {
    Type = "jpg",
    Filename = "item_trap_empty.jpg",
    Directives = {}
  }
}
zmediaTrapMalfunction = Wherigo.ZMedia(cartGhostbusters)
zmediaTrapMalfunction.Id = "48db5f578a622b73c711773866e9f2c6"
zmediaTrapMalfunction.Name = "Trap Malfunction"
zmediaTrapMalfunction.AltText = ""
zmediaTrapMalfunction.Resources = {
  {
    Type = "jpg",
    Filename = "item_trap_malf.jpg",
    Directives = {}
  }
}
zmediaTrapUsed = Wherigo.ZMedia(cartGhostbusters)
zmediaTrapUsed.Id = "48804348e28df448c29f509d98b454d6"
zmediaTrapUsed.Name = "Trap Used"
zmediaTrapUsed.AltText = ""
zmediaTrapUsed.Resources = {
  {
    Type = "jpg",
    Filename = "item_trap_used.jpg",
    Directives = {}
  }
}
zmediaYouChoice = Wherigo.ZMedia(cartGhostbusters)
zmediaYouChoice.Id = "998ec08bac9092b2ef68f2d18d2f1419"
zmediaYouChoice.Name = "YouChoice"
zmediaYouChoice.AltText = ""
zmediaYouChoice.Resources = {
  {
    Type = "jpg",
    Filename = "chars_youChoice.jpg",
    Directives = {}
  }
}
zmediaYouFemale = Wherigo.ZMedia(cartGhostbusters)
zmediaYouFemale.Id = "3ad218174bfa19fe1cd73702d69f96f5"
zmediaYouFemale.Name = "YouFemale"
zmediaYouFemale.AltText = ""
zmediaYouFemale.Resources = {
  {
    Type = "jpg",
    Filename = "chars_youFemale.jpg",
    Directives = {}
  }
}
zmediaYouMale = Wherigo.ZMedia(cartGhostbusters)
zmediaYouMale.Id = "da2ee5313bea8cc301f56c0cdf557be0"
zmediaYouMale.Name = "YouMale"
zmediaYouMale.AltText = ""
zmediaYouMale.Resources = {
  {
    Type = "jpg",
    Filename = "chars_youMale.jpg",
    Directives = {}
  }
}
zmediaZoneBahnhof = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneBahnhof.Id = "82045d0dc22d2145ab516f8be6814b36"
zmediaZoneBahnhof.Name = "ZoneBahnhof"
zmediaZoneBahnhof.AltText = ""
zmediaZoneBahnhof.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Bahnhof.jpg",
    Directives = {}
  }
}
zmediaZoneBruecke = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneBruecke.Id = "77f3e01e100af57d1d7c45c9701d1b89"
zmediaZoneBruecke.Name = "ZoneBruecke"
zmediaZoneBruecke.AltText = ""
zmediaZoneBruecke.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Brucke.jpg",
    Directives = {}
  }
}
zmediaZoneFeuerwehr = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneFeuerwehr.Id = "85140bf06f7c3e5c60b3f996f3f4ff9f"
zmediaZoneFeuerwehr.Name = "ZoneFeuerwehr"
zmediaZoneFeuerwehr.AltText = ""
zmediaZoneFeuerwehr.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Feuerwehr.jpg",
    Directives = {}
  }
}
zmediaZoneFinal = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneFinal.Id = "1573a8010383e90aa62fca1c2d54ef50"
zmediaZoneFinal.Name = "ZoneFinal"
zmediaZoneFinal.AltText = ""
zmediaZoneFinal.Resources = {
  {
    Type = "jpg",
    Filename = "zoneFinal.jpg",
    Directives = {}
  }
}
zmediaZoneFriedhof = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneFriedhof.Id = "42557f89636dd5c2796a0bb06b70c650"
zmediaZoneFriedhof.Name = "ZoneFriedhof"
zmediaZoneFriedhof.AltText = ""
zmediaZoneFriedhof.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Friedhof.jpg",
    Directives = {}
  }
}
zmediaZoneFriseur = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneFriseur.Id = "2653663ff8af9adc5f66cfc37ab36c92"
zmediaZoneFriseur.Name = "ZoneFriseur"
zmediaZoneFriseur.AltText = ""
zmediaZoneFriseur.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Friseur.jpg",
    Directives = {}
  }
}
zmediaZoneHochhaus = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneHochhaus.Id = "ac0a92f648be4dd95597bdb35a2a8490"
zmediaZoneHochhaus.Name = "ZoneHochhaus"
zmediaZoneHochhaus.AltText = ""
zmediaZoneHochhaus.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Hochhaus.jpg",
    Directives = {}
  }
}
zmediaZoneHotel = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneHotel.Id = "48c746b74883f5044f372839f7d5f553"
zmediaZoneHotel.Name = "ZoneHotel"
zmediaZoneHotel.AltText = ""
zmediaZoneHotel.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Hotel.jpg",
    Directives = {}
  }
}
zmediaZonePark = Wherigo.ZMedia(cartGhostbusters)
zmediaZonePark.Id = "0e89be0b322cf535ec2eac22d7a1050a"
zmediaZonePark.Name = "ZonePark"
zmediaZonePark.AltText = ""
zmediaZonePark.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Park.jpg",
    Directives = {}
  }
}
zmediaZoneParkdeck = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneParkdeck.Id = "e63237c6252fe00aa57230c4d03961ae"
zmediaZoneParkdeck.Name = "ZoneParkdeck"
zmediaZoneParkdeck.AltText = ""
zmediaZoneParkdeck.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Parkdeck.jpg",
    Directives = {}
  }
}
zmediaZoneStart = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneStart.Id = "14afa04624a9023b7e601cb9bd46583d"
zmediaZoneStart.Name = "ZoneStart"
zmediaZoneStart.AltText = ""
zmediaZoneStart.Resources = {
  {
    Type = "jpg",
    Filename = "zone_start.jpg",
    Directives = {}
  }
}
zmediaZoneTempel = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneTempel.Id = "a73c2ad2aaa8a97dab370d4fbf8199ae"
zmediaZoneTempel.Name = "ZoneTempel"
zmediaZoneTempel.AltText = ""
zmediaZoneTempel.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Tempel.jpg",
    Directives = {}
  }
}
zmediaZoneUFO = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneUFO.Id = "d48dd4d40399c691b52aaec49a5bb69b"
zmediaZoneUFO.Name = "ZoneUFO"
zmediaZoneUFO.AltText = ""
zmediaZoneUFO.Resources = {
  {
    Type = "jpg",
    Filename = "zone_UFO.jpg",
    Directives = {}
  }
}
zmediaZoneVideothek = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneVideothek.Id = "7377975f80dc3ec1f1774e1927c618f6"
zmediaZoneVideothek.Name = "ZoneVideothek"
zmediaZoneVideothek.AltText = ""
zmediaZoneVideothek.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Videothek.jpg",
    Directives = {}
  }
}
zmediaZoneWasser = Wherigo.ZMedia(cartGhostbusters)
zmediaZoneWasser.Id = "987ee37356ff6a0abab918f2c6a8b8aa"
zmediaZoneWasser.Name = "ZoneWasser"
zmediaZoneWasser.AltText = ""
zmediaZoneWasser.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Wasser.jpg",
    Directives = {}
  }
}
cartGhostbusters.Id = "e5177f9d-265e-4b6a-9e9c-4cd78f81c549"
cartGhostbusters.Name = "Ghostbusters"
cartGhostbusters.Activity = "Geocache"
cartGhostbusters.Version = "3.2"
cartGhostbusters.Company = ""
cartGhostbusters.Author = "thavorianer"
cartGhostbusters.TargetDevice = "SmartPhone"
cartGhostbusters.TargetDeviceVersion = "0"
cartGhostbusters.BuilderVersion = "WWB 0000.3.2019.01.25.121250"
cartGhostbusters.StateId = "1"
cartGhostbusters.CountryId = "2"
cartGhostbusters.Description = "<BR>\n<BR>\nZeit etwa 4 - 6h.<BR>\nMan sollte gut zu Fu\195\159 sein oder besser mit Fahrrad!<BR>\nGruppe von 2 - 4 Leuten &amp; 4h vor der D\195\164mmerung.<BR>\nStilecht w\195\164re mit Overall und Staubsauger auf dem R\195\188cken. ;)<BR>\n<BR>\nDie Gebote:<BR>\n<BR>\n- Batteriesparmodus aus beim Garmin<BR>\n<BR>\n- Seid mit dem Garmin geduldig!!!<BR>\nSiehe auch Anweisungen beim Start<BR>\n<BR>\n- Geht z\195\188gig in die Zone!<BR>\nDie Entfernung zur Zone ist der Rand der Zone!<BR>\n<BR>\n- Bei einem Neustart sollte man au\195\159erhalb einer Zone sein!<BR>\n<BR>\n- Bei den Suchstationen gibt es auch Hints - guckt euch im Spiel um!<BR>\n<BR>\n- Abgebrochene Abfrage, kann man auch wieder Aufrufen!<BR>\n<BR>\n- Bei den Stationen gro\195\159e Vorsicht vor Muggels! <BR>\nPAL-Feld! Es ist eben ein Stadtcache!<BR>\n<BR>\n- F\195\188r das Final: <BR>\nSpecial-tools liegen vor Ort!<BR>\nEs muss nichts demontiert werden!<BR>\nMan braucht keine Gewalt!<BR>\nSeid sicher das keine Muggels in der N\195\164he sind!!!<BR>\n!!! Ein Punkt in der Statistik ist kein gemuggelter Cache wert !!!<BR>\nHabt Respekt und behandelt es wie euren Cache!<BR>\n<BR>\n- Bitte keine Spoiler im Log in jeglicher Fo"
cartGhostbusters.StartingLocationDescription = [[
<BR>
<BR>
ZOB / Luebeck]]
cartGhostbusters.Visible = true
cartGhostbusters.Complete = false
cartGhostbusters.UseLogging = true
cartGhostbusters.CreateDate = "6/21/2010 06:31:24 PM"
cartGhostbusters.PublishDate = "1/1/1970 01:00:00 AM"
cartGhostbusters.UpdateDate = "8/16/2019 01:30:34 PM"
cartGhostbusters.LastPlayedDate = "1/1/1970 01:00:00 AM"
cartGhostbusters.Media = zmediaTitle
cartGhostbusters.Icon = zmediaTitle
cartGhostbusters.StartingLocation = ZonePoint(53.86615, 10.671617, 0)
zoneAmWasser = Wherigo.Zone(cartGhostbusters)
zoneAmWasser.Id = "4378764163ab34f0d6de5586d72c5937"
zoneAmWasser.Name = "Am Wasser"
zoneAmWasser.DistanceRangeUOM = "Meters"
zoneAmWasser.ProximityRangeUOM = "Meters"
zoneAmWasser.ShowObjects = "OnEnter"
zoneAmWasser.OutOfRangeName = ""
zoneAmWasser.InRangeName = ""
zoneAmWasser.Description = "Nahe am Wasser."
zoneAmWasser.Visible = true
zoneAmWasser.AllowSetPositionTo = false
zoneAmWasser.Active = false
zoneAmWasser.DistanceRange = Distance(-1, "meters")
zoneAmWasser.ProximityRange = Distance(0, "meters")
zoneAmWasser.Points = {
  ZonePoint(53.8656689797665, 10.6763887316208, 0),
  ZonePoint(53.8657385641136, 10.6763398524036, 0),
  ZonePoint(53.8657673868939, 10.6762218475342, 0),
  ZonePoint(53.8657385641136, 10.6761038426648, 0),
  ZonePoint(53.8656689797665, 10.6760549634476, 0),
  ZonePoint(53.8655993954194, 10.6761038426648, 0),
  ZonePoint(53.8655705726391, 10.6762218475342, 0),
  ZonePoint(53.8655993954194, 10.6763398524036, 0)
}
zoneAmWasser.OriginalPoint = ZonePoint(53.8656689797665, 10.6762218475342, 0)
zoneAmWasser.Media = zmediaZoneWasser
zoneBahnhof = Wherigo.Zone(cartGhostbusters)
zoneBahnhof.Id = "50e33f71cee4f9cf3388e757d8cba532"
zoneBahnhof.Name = "Bahnhof"
zoneBahnhof.DistanceRangeUOM = "Meters"
zoneBahnhof.ProximityRangeUOM = "Meters"
zoneBahnhof.ShowObjects = "OnEnter"
zoneBahnhof.OutOfRangeName = ""
zoneBahnhof.InRangeName = ""
zoneBahnhof.Description = "Der Hauptbahnhof."
zoneBahnhof.Visible = true
zoneBahnhof.AllowSetPositionTo = false
zoneBahnhof.Active = false
zoneBahnhof.DistanceRange = Distance(-1, "meters")
zoneBahnhof.ProximityRange = Distance(0, "meters")
zoneBahnhof.Points = {
  ZonePoint(53.8670299640611, 10.6707281831141, 0),
  ZonePoint(53.8671158706626, 10.6706678384014, 0),
  ZonePoint(53.8671514543419, 10.6705221533775, 0),
  ZonePoint(53.8671158706626, 10.6703764683537, 0),
  ZonePoint(53.8670299640611, 10.6703161236409, 0),
  ZonePoint(53.8669440574597, 10.6703764683537, 0),
  ZonePoint(53.8669084737804, 10.6705221533775, 0),
  ZonePoint(53.8669440574597, 10.6706678384014, 0)
}
zoneBahnhof.OriginalPoint = ZonePoint(53.8670299640611, 10.6705221533775, 0)
zoneBahnhof.Media = zmediaZoneBahnhof
zoneBahnsteig = Wherigo.Zone(cartGhostbusters)
zoneBahnsteig.Id = "b4ff5b502adfb742a7096049d804c898"
zoneBahnsteig.Name = "Bahnsteig"
zoneBahnsteig.DistanceRangeUOM = "Meters"
zoneBahnsteig.ProximityRangeUOM = "Meters"
zoneBahnsteig.ShowObjects = "OnEnter"
zoneBahnsteig.OutOfRangeName = ""
zoneBahnsteig.InRangeName = ""
zoneBahnsteig.Description = "Auf dem Bahnsteig."
zoneBahnsteig.Visible = false
zoneBahnsteig.AllowSetPositionTo = false
zoneBahnsteig.Active = false
zoneBahnsteig.DistanceRange = Distance(-1, "meters")
zoneBahnsteig.ProximityRange = Distance(0, "meters")
zoneBahnsteig.Points = {
  ZonePoint(53.8668805040435, 10.6681805849076, 0),
  ZonePoint(53.8668156580052, 10.6680008769036, 0),
  ZonePoint(53.8665625993336, 10.6682717800141, 0),
  ZonePoint(53.866629027383, 10.6684514880181, 0)
}
zoneBahnsteig.OriginalPoint = ZonePoint(53.8667191795672, 10.6682127714157, 0)
zoneBahnsteig.Media = zmediaZoneBahnhof
zoneBruecke = Wherigo.Zone(cartGhostbusters)
zoneBruecke.Id = "8bb66b6b597559cf9270b1af2b7f9f8c"
zoneBruecke.Name = "Bruecke"
zoneBruecke.DistanceRangeUOM = "Meters"
zoneBruecke.ProximityRangeUOM = "Meters"
zoneBruecke.ShowObjects = "OnEnter"
zoneBruecke.OutOfRangeName = ""
zoneBruecke.InRangeName = ""
zoneBruecke.Description = WWB_multiplatform_string("Auf einer Br\195\188cke.")
zoneBruecke.Visible = true
zoneBruecke.AllowSetPositionTo = false
zoneBruecke.Active = false
zoneBruecke.DistanceRange = Distance(-1, "meters")
zoneBruecke.ProximityRange = Distance(0, "meters")
zoneBruecke.Points = {
  ZonePoint(53.8654301505298, 10.66602895292, 0),
  ZonePoint(53.8655160571312, 10.6659686082073, 0),
  ZonePoint(53.8655516408105, 10.6658229231834, 0),
  ZonePoint(53.8655160571312, 10.6656772381595, 0),
  ZonePoint(53.8654301505298, 10.6656168934468, 0),
  ZonePoint(53.8653442439283, 10.6656772381595, 0),
  ZonePoint(53.865308660249, 10.6658229231834, 0),
  ZonePoint(53.8653442439283, 10.6659686082073, 0)
}
zoneBruecke.OriginalPoint = ZonePoint(53.8654301505298, 10.6658229231834, 0)
zoneBruecke.Media = zmediaZoneBruecke
zoneFeuerwehr = Wherigo.Zone(cartGhostbusters)
zoneFeuerwehr.Id = "c7be8eb40233f2c1b80c31d1dc090b50"
zoneFeuerwehr.Name = "Feuerwehr"
zoneFeuerwehr.DistanceRangeUOM = "Meters"
zoneFeuerwehr.ProximityRangeUOM = "Meters"
zoneFeuerwehr.ShowObjects = "OnEnter"
zoneFeuerwehr.OutOfRangeName = ""
zoneFeuerwehr.InRangeName = ""
zoneFeuerwehr.Description = WWB_multiplatform_string("Die ehemalige Feuerwehrwache, jetzt Hauptquartier der Geisterj\195\164ger.")
zoneFeuerwehr.Visible = false
zoneFeuerwehr.AllowSetPositionTo = false
zoneFeuerwehr.Active = true
zoneFeuerwehr.DistanceRange = Distance(-1, "meters")
zoneFeuerwehr.ProximityRange = Distance(5, "meters")
zoneFeuerwehr.Points = {
  ZonePoint(53.8648500744786, 10.6687384843827, 0),
  ZonePoint(53.8645796068619, 10.6681671738625, 0),
  ZonePoint(53.8643771504256, 10.6684595346452, 0),
  ZonePoint(53.8645321562226, 10.6687733530999, 0),
  ZonePoint(53.8645021041231, 10.6688135862351, 0),
  ZonePoint(53.8646001687889, 10.6690174341202, 0),
  ZonePoint(53.864644455982, 10.6690201163293, 0)
}
zoneFeuerwehr.OriginalPoint = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zoneFeuerwehr.Media = zmediaZoneFeuerwehr
zoneFinal = Wherigo.Zone(cartGhostbusters)
zoneFinal.Id = "12d3bd703a7d8faeb2a712611f960934"
zoneFinal.Name = "Final"
zoneFinal.DistanceRangeUOM = "Meters"
zoneFinal.ProximityRangeUOM = "Meters"
zoneFinal.ShowObjects = "OnEnter"
zoneFinal.OutOfRangeName = ""
zoneFinal.InRangeName = ""
zoneFinal.Description = "Suche von hier das Final."
zoneFinal.Visible = true
zoneFinal.AllowSetPositionTo = false
zoneFinal.Active = false
zoneFinal.DistanceRange = Distance(-1, "meters")
zoneFinal.ProximityRange = Distance(0, "meters")
zoneFinal.Points = {
  ZonePoint(53.8656968961087, 10.6677701399584, 0),
  ZonePoint(53.8657664804565, 10.6677212606673, 0),
  ZonePoint(53.8657953032365, 10.6676032556218, 0),
  ZonePoint(53.8657664804565, 10.6674852505757, 0),
  ZonePoint(53.8656968961087, 10.6674363712852, 0),
  ZonePoint(53.8656273117621, 10.6674852505754, 0),
  ZonePoint(53.8655984889818, 10.6676032556218, 0),
  ZonePoint(53.8656273117621, 10.6677212606681, 0)
}
zoneFinal.OriginalPoint = ZonePoint(53.8656968961088, 10.6676032556217, 0)
zoneFinal.Media = zmediaZoneFinal
zoneFriedhof = Wherigo.Zone(cartGhostbusters)
zoneFriedhof.Id = "dd6581b10dcdfe07419811ca60e19a68"
zoneFriedhof.Name = "Friedhof"
zoneFriedhof.DistanceRangeUOM = "Meters"
zoneFriedhof.ProximityRangeUOM = "Meters"
zoneFriedhof.ShowObjects = "OnEnter"
zoneFriedhof.OutOfRangeName = ""
zoneFriedhof.InRangeName = ""
zoneFriedhof.Description = "Ein Friedhof mit Kapelle &amp;&amp; Kirche."
zoneFriedhof.Visible = true
zoneFriedhof.AllowSetPositionTo = false
zoneFriedhof.Active = false
zoneFriedhof.DistanceRange = Distance(-1, "meters")
zoneFriedhof.ProximityRange = Distance(0, "meters")
zoneFriedhof.Points = {
  ZonePoint(53.8686882331323, 10.6700576308604, 0),
  ZonePoint(53.8687741397337, 10.6699972861477, 0),
  ZonePoint(53.868809723413, 10.6698516011238, 0),
  ZonePoint(53.8687741397337, 10.6697059160999, 0),
  ZonePoint(53.8686882331323, 10.6696455713872, 0),
  ZonePoint(53.8686023265308, 10.6697059160999, 0),
  ZonePoint(53.8685667428515, 10.6698516011238, 0),
  ZonePoint(53.8686023265308, 10.6699972861477, 0)
}
zoneFriedhof.OriginalPoint = ZonePoint(53.8686882331323, 10.6698516011238, 0)
zoneFriedhof.Media = zmediaZoneFriedhof
zoneFriseur = Wherigo.Zone(cartGhostbusters)
zoneFriseur.Id = "c12743b1c6ff2cbca1d8e4c6665a0075"
zoneFriseur.Name = "Friseur"
zoneFriseur.DistanceRangeUOM = "Meters"
zoneFriseur.ProximityRangeUOM = "Meters"
zoneFriseur.ShowObjects = "OnEnter"
zoneFriseur.OutOfRangeName = ""
zoneFriseur.InRangeName = ""
zoneFriseur.Description = WWB_multiplatform_string("Vor einem Friseur. Schneiden, waschen, f\195\182hnen in 15min.")
zoneFriseur.Visible = true
zoneFriseur.AllowSetPositionTo = false
zoneFriseur.Active = false
zoneFriseur.DistanceRange = Distance(-1, "meters")
zoneFriseur.ProximityRange = Distance(0, "meters")
zoneFriseur.Points = {
  ZonePoint(53.8638943352476, 10.6699726548704, 0),
  ZonePoint(53.8639716511889, 10.6699183446289, 0),
  ZonePoint(53.8640036765003, 10.6697872281075, 0),
  ZonePoint(53.8639716511889, 10.669656111586, 0),
  ZonePoint(53.8638943352476, 10.6696018013446, 0),
  ZonePoint(53.8638170193063, 10.669656111586, 0),
  ZonePoint(53.863784993995, 10.6697872281075, 0),
  ZonePoint(53.8638170193063, 10.6699183446289, 0)
}
zoneFriseur.OriginalPoint = ZonePoint(53.8638943352476, 10.6697872281075, 0)
zoneFriseur.Media = zmediaZoneFriseur
zoneHochhaus = Wherigo.Zone(cartGhostbusters)
zoneHochhaus.Id = "c8c0285a21d0b268797204fa546b02b3"
zoneHochhaus.Name = "Hochhaus"
zoneHochhaus.DistanceRangeUOM = "Meters"
zoneHochhaus.ProximityRangeUOM = "Meters"
zoneHochhaus.ShowObjects = "OnEnter"
zoneHochhaus.OutOfRangeName = ""
zoneHochhaus.InRangeName = ""
zoneHochhaus.Description = "Errichtet im Stil des Expressionismus mit Elementen der Neugotik mit Klinker verkleidet."
zoneHochhaus.Visible = true
zoneHochhaus.AllowSetPositionTo = false
zoneHochhaus.Active = false
zoneHochhaus.DistanceRange = Distance(-1, "meters")
zoneHochhaus.ProximityRange = Distance(80, "meters")
zoneHochhaus.Points = {
  ZonePoint(53.8665404576677, 10.6702480677234, 0),
  ZonePoint(53.8666263642689, 10.6701877230035, 0),
  ZonePoint(53.8666619479483, 10.6700420379632, 0),
  ZonePoint(53.8666263642689, 10.6698963529228, 0),
  ZonePoint(53.8665404576677, 10.6698360082031, 0),
  ZonePoint(53.866454551066, 10.6698963529228, 0),
  ZonePoint(53.8664189673868, 10.6700420379632, 0),
  ZonePoint(53.866454551066, 10.6701877230035, 0)
}
zoneHochhaus.OriginalPoint = ZonePoint(53.8665404576676, 10.6700420379639, 0)
zoneHochhaus.Media = zmediaZoneHochhaus
zoneHotel = Wherigo.Zone(cartGhostbusters)
zoneHotel.Id = "3391302e2b952430ffeb0f3a2e72e455"
zoneHotel.Name = "Hotel"
zoneHotel.DistanceRangeUOM = "Meters"
zoneHotel.ProximityRangeUOM = "Meters"
zoneHotel.ShowObjects = "OnEnter"
zoneHotel.OutOfRangeName = ""
zoneHotel.InRangeName = ""
zoneHotel.Description = "Ein nettes diskretes Hotel"
zoneHotel.Visible = true
zoneHotel.AllowSetPositionTo = false
zoneHotel.Active = false
zoneHotel.DistanceRange = Distance(-1, "meters")
zoneHotel.ProximityRange = Distance(0, "meters")
zoneHotel.Points = {
  ZonePoint(53.8660659710436, 10.6733003983326, 0),
  ZonePoint(53.866151877645, 10.6732400604229, 0),
  ZonePoint(53.8661874613243, 10.6730943918228, 0),
  ZonePoint(53.866151877645, 10.6729487232227, 0),
  ZonePoint(53.8660659710436, 10.6728883853129, 0),
  ZonePoint(53.8659800644422, 10.6729487232227, 0),
  ZonePoint(53.8659444807629, 10.6730943918228, 0),
  ZonePoint(53.8659800644422, 10.6732400604229, 0)
}
zoneHotel.OriginalPoint = ZonePoint(53.8660659710436, 10.6730943918228, 0)
zoneHotel.Media = zmediaZoneHotel
zonePark = Wherigo.Zone(cartGhostbusters)
zonePark.Id = "315a0cffc4c11cf589b54fa0813c12ae"
zonePark.Name = "Park"
zonePark.DistanceRangeUOM = "Meters"
zonePark.ProximityRangeUOM = "Meters"
zonePark.ShowObjects = "OnEnter"
zonePark.OutOfRangeName = ""
zonePark.InRangeName = ""
zonePark.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark.Visible = true
zonePark.AllowSetPositionTo = false
zonePark.Active = false
zonePark.DistanceRange = Distance(-1, "meters")
zonePark.ProximityRange = Distance(0, "meters")
zonePark.Points = {
  ZonePoint(53.8666242830785, 10.6732659405136, 0),
  ZonePoint(53.8666991675278, 10.673213338263, 0),
  ZonePoint(53.8667301856823, 10.6730863451958, 0),
  ZonePoint(53.8666991675278, 10.6729593521286, 0),
  ZonePoint(53.8666242830785, 10.6729067498778, 0),
  ZonePoint(53.8665493986291, 10.6729593521286, 0),
  ZonePoint(53.8665183804744, 10.6730863451958, 0),
  ZonePoint(53.8665493986291, 10.673213338263, 0)
}
zonePark.OriginalPoint = ZonePoint(53.8666242830785, 10.6730863451958, 0)
zonePark.Media = zmediaZonePark
zonePark1 = Wherigo.Zone(cartGhostbusters)
zonePark1.Id = "bdea9489131d6d101cf372dbd09dbb8f"
zonePark1.Name = "Park-1"
zonePark1.DistanceRangeUOM = "Meters"
zonePark1.ProximityRangeUOM = "Meters"
zonePark1.ShowObjects = "Always"
zonePark1.OutOfRangeName = ""
zonePark1.InRangeName = ""
zonePark1.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark1.Visible = false
zonePark1.AllowSetPositionTo = false
zonePark1.Active = false
zonePark1.DistanceRange = Distance(-1, "meters")
zonePark1.ProximityRange = Distance(0, "meters")
zonePark1.Points = {
  ZonePoint(53.8668251470587, 10.6734048819394, 0),
  ZonePoint(53.8668584290362, 10.6733815031613, 0),
  ZonePoint(53.8668722148827, 10.6733250617981, 0),
  ZonePoint(53.8668584290362, 10.6732686204349, 0),
  ZonePoint(53.8668251470587, 10.6732452416568, 0),
  ZonePoint(53.8667918650812, 10.6732686204349, 0),
  ZonePoint(53.8667780792347, 10.6733250617981, 0),
  ZonePoint(53.8667918650812, 10.6733815031613, 0)
}
zonePark1.OriginalPoint = ZonePoint(53.8668251470587, 10.6733250617981, 0)
zonePark1.Media = zmediaZonePark
zonePark2 = Wherigo.Zone(cartGhostbusters)
zonePark2.Id = "a82f87208e44f56c1ee0238d4108f7d8"
zonePark2.Name = "Park-2"
zonePark2.DistanceRangeUOM = "Meters"
zonePark2.ProximityRangeUOM = "Meters"
zonePark2.ShowObjects = "Always"
zonePark2.OutOfRangeName = ""
zonePark2.InRangeName = ""
zonePark2.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark2.Visible = false
zonePark2.AllowSetPositionTo = false
zonePark2.Active = false
zonePark2.DistanceRange = Distance(-1, "meters")
zonePark2.ProximityRange = Distance(0, "meters")
zonePark2.Points = {
  ZonePoint(53.8668235654563, 10.6738528108449, 0),
  ZonePoint(53.8668568474338, 10.6738294320668, 0),
  ZonePoint(53.8668706332803, 10.6737729907036, 0),
  ZonePoint(53.8668568474338, 10.6737165493404, 0),
  ZonePoint(53.8668235654563, 10.6736931705623, 0),
  ZonePoint(53.8667902834788, 10.6737165493404, 0),
  ZonePoint(53.8667764976323, 10.6737729907036, 0),
  ZonePoint(53.8667902834788, 10.6738294320668, 0)
}
zonePark2.OriginalPoint = ZonePoint(53.8668235654563, 10.6737729907036, 0)
zonePark2.Media = zmediaZonePark
zonePark3 = Wherigo.Zone(cartGhostbusters)
zonePark3.Id = "772afc9f30b2b0346add5d44f13251d0"
zonePark3.Name = "Park-3"
zonePark3.DistanceRangeUOM = "Meters"
zonePark3.ProximityRangeUOM = "Meters"
zonePark3.ShowObjects = "Always"
zonePark3.OutOfRangeName = ""
zonePark3.InRangeName = ""
zonePark3.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark3.Visible = false
zonePark3.AllowSetPositionTo = false
zonePark3.Active = false
zonePark3.DistanceRange = Distance(-1, "meters")
zonePark3.ProximityRange = Distance(0, "meters")
zonePark3.Points = {
  ZonePoint(53.8663712247225, 10.6734907126279, 0),
  ZonePoint(53.8664045067, 10.6734673338498, 0),
  ZonePoint(53.8664182925465, 10.6734108924866, 0),
  ZonePoint(53.8664045067, 10.6733544511234, 0),
  ZonePoint(53.8663712247225, 10.6733310723453, 0),
  ZonePoint(53.866337942745, 10.6733544511234, 0),
  ZonePoint(53.8663241568985, 10.6734108924866, 0),
  ZonePoint(53.866337942745, 10.6734673338498, 0)
}
zonePark3.OriginalPoint = ZonePoint(53.8663712247225, 10.6734108924866, 0)
zonePark3.Media = zmediaZonePark
zonePark4 = Wherigo.Zone(cartGhostbusters)
zonePark4.Id = "5dec38d0bc47ec3ffcf4c5fead32e359"
zonePark4.Name = "Park-4"
zonePark4.DistanceRangeUOM = "Meters"
zonePark4.ProximityRangeUOM = "Meters"
zonePark4.ShowObjects = "Always"
zonePark4.OutOfRangeName = ""
zonePark4.InRangeName = ""
zonePark4.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark4.Visible = false
zonePark4.AllowSetPositionTo = false
zonePark4.Active = false
zonePark4.DistanceRange = Distance(-1, "meters")
zonePark4.ProximityRange = Distance(0, "meters")
zonePark4.Points = {
  ZonePoint(53.8663870409146, 10.6731017923207, 0),
  ZonePoint(53.8664203228921, 10.6730784135426, 0),
  ZonePoint(53.8664341087386, 10.6730219721794, 0),
  ZonePoint(53.8664203228921, 10.6729655308162, 0),
  ZonePoint(53.8663870409146, 10.6729421520381, 0),
  ZonePoint(53.8663537589371, 10.6729655308162, 0),
  ZonePoint(53.8663399730906, 10.6730219721794, 0),
  ZonePoint(53.8663537589371, 10.6730784135426, 0)
}
zonePark4.OriginalPoint = ZonePoint(53.8663870409146, 10.6730219721794, 0)
zonePark4.Media = zmediaZonePark
zonePark5 = Wherigo.Zone(cartGhostbusters)
zonePark5.Id = "b213b7d20f324814bbbc201e1ed3185f"
zonePark5.Name = "Park-5"
zonePark5.DistanceRangeUOM = "Meters"
zonePark5.ProximityRangeUOM = "Meters"
zonePark5.ShowObjects = "Always"
zonePark5.OutOfRangeName = ""
zonePark5.InRangeName = ""
zonePark5.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark5.Visible = false
zonePark5.AllowSetPositionTo = false
zonePark5.Active = false
zonePark5.DistanceRange = Distance(-1, "meters")
zonePark5.ProximityRange = Distance(0, "meters")
zonePark5.Points = {
  ZonePoint(53.8667666277309, 10.6731098389478, 0),
  ZonePoint(53.8667999097084, 10.6730864601697, 0),
  ZonePoint(53.8668136955549, 10.6730300188065, 0),
  ZonePoint(53.8667999097084, 10.6729735774432, 0),
  ZonePoint(53.8667666277309, 10.6729501986651, 0),
  ZonePoint(53.8667333457534, 10.6729735774432, 0),
  ZonePoint(53.8667195599069, 10.6730300188065, 0),
  ZonePoint(53.8667333457534, 10.6730864601697, 0)
}
zonePark5.OriginalPoint = ZonePoint(53.8667666277309, 10.6730300188065, 0)
zonePark5.Media = zmediaZonePark
zonePark6 = Wherigo.Zone(cartGhostbusters)
zonePark6.Id = "cce64778462229279e06d6b5e77392ab"
zonePark6.Name = "Park-6"
zonePark6.DistanceRangeUOM = "Meters"
zonePark6.ProximityRangeUOM = "Meters"
zonePark6.ShowObjects = "Always"
zonePark6.OutOfRangeName = ""
zonePark6.InRangeName = ""
zonePark6.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark6.Visible = false
zonePark6.AllowSetPositionTo = false
zonePark6.Active = false
zonePark6.DistanceRange = Distance(-1, "meters")
zonePark6.ProximityRange = Distance(0, "meters")
zonePark6.Points = {
  ZonePoint(53.8666432623934, 10.6737508869023, 0),
  ZonePoint(53.8666765443709, 10.6737275081242, 0),
  ZonePoint(53.8666903302174, 10.673671066761, 0),
  ZonePoint(53.8666765443709, 10.6736146253978, 0),
  ZonePoint(53.8666432623934, 10.6735912466197, 0),
  ZonePoint(53.8666099804159, 10.6736146253978, 0),
  ZonePoint(53.8665961945694, 10.673671066761, 0),
  ZonePoint(53.8666099804159, 10.6737275081242, 0)
}
zonePark6.OriginalPoint = ZonePoint(53.8666432623934, 10.673671066761, 0)
zonePark6.Media = zmediaZonePark
zonePark7 = Wherigo.Zone(cartGhostbusters)
zonePark7.Id = "655b8ee0d36abaf3b21e12381af0b008"
zonePark7.Name = "Park-7"
zonePark7.DistanceRangeUOM = "Meters"
zonePark7.ProximityRangeUOM = "Meters"
zonePark7.ShowObjects = "Always"
zonePark7.OutOfRangeName = ""
zonePark7.InRangeName = ""
zonePark7.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark7.Visible = false
zonePark7.AllowSetPositionTo = false
zonePark7.Active = false
zonePark7.DistanceRange = Distance(-1, "meters")
zonePark7.ProximityRange = Distance(0, "meters")
zonePark7.Points = {
  ZonePoint(53.8668678503002, 10.6735416745992, 0),
  ZonePoint(53.8669011322777, 10.6735182958211, 0),
  ZonePoint(53.8669149181242, 10.6734618544579, 0),
  ZonePoint(53.8669011322777, 10.6734054130946, 0),
  ZonePoint(53.8668678503002, 10.6733820343165, 0),
  ZonePoint(53.8668345683227, 10.6734054130946, 0),
  ZonePoint(53.8668207824762, 10.6734618544579, 0),
  ZonePoint(53.8668345683227, 10.6735182958211, 0)
}
zonePark7.OriginalPoint = ZonePoint(53.8668678503002, 10.6734618544579, 0)
zonePark7.Media = zmediaZonePark
zonePark8 = Wherigo.Zone(cartGhostbusters)
zonePark8.Id = "afc465a56ff4ddbda961ab1f099ff3e0"
zonePark8.Name = "Park-8"
zonePark8.DistanceRangeUOM = "Meters"
zonePark8.ProximityRangeUOM = "Meters"
zonePark8.ShowObjects = "Always"
zonePark8.OutOfRangeName = ""
zonePark8.InRangeName = ""
zonePark8.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark8.Visible = false
zonePark8.AllowSetPositionTo = false
zonePark8.Active = false
zonePark8.DistanceRange = Distance(-1, "meters")
zonePark8.ProximityRange = Distance(0, "meters")
zonePark8.Points = {
  ZonePoint(53.866458213705, 10.6732868647428, 0),
  ZonePoint(53.8664914956826, 10.6732634859646, 0),
  ZonePoint(53.866505281529, 10.6732070446014, 0),
  ZonePoint(53.8664914956826, 10.6731506032382, 0),
  ZonePoint(53.866458213705, 10.6731272244601, 0),
  ZonePoint(53.8664249317275, 10.6731506032382, 0),
  ZonePoint(53.866411145881, 10.6732070446014, 0),
  ZonePoint(53.8664249317275, 10.6732634859646, 0)
}
zonePark8.OriginalPoint = ZonePoint(53.866458213705, 10.6732070446014, 0)
zonePark8.Media = zmediaZonePark
zonePark9 = Wherigo.Zone(cartGhostbusters)
zonePark9.Id = "95f7cdba1e4fdb08b3bdc9c51148ae04"
zonePark9.Name = "Park-9"
zonePark9.DistanceRangeUOM = "Meters"
zonePark9.ProximityRangeUOM = "Meters"
zonePark9.ShowObjects = "Always"
zonePark9.OutOfRangeName = ""
zonePark9.InRangeName = ""
zonePark9.Description = WWB_multiplatform_string("Eine Parkanlage mit Denkm\195\164lern.")
zonePark9.Visible = false
zonePark9.AllowSetPositionTo = false
zonePark9.Active = false
zonePark9.DistanceRange = Distance(-1, "meters")
zonePark9.ProximityRange = Distance(0, "meters")
zonePark9.Points = {
  ZonePoint(53.8667255059922, 10.6734612083287, 0),
  ZonePoint(53.8667587879697, 10.6734378295506, 0),
  ZonePoint(53.8667725738162, 10.6733813881874, 0),
  ZonePoint(53.8667587879697, 10.6733249468242, 0),
  ZonePoint(53.8667255059922, 10.6733015680461, 0),
  ZonePoint(53.8666922240147, 10.6733249468242, 0),
  ZonePoint(53.8666784381682, 10.6733813881874, 0),
  ZonePoint(53.8666922240147, 10.6734378295506, 0)
}
zonePark9.OriginalPoint = ZonePoint(53.8667255059922, 10.6733813881874, 0)
zonePark9.Media = zmediaZonePark
zoneParkdeck = Wherigo.Zone(cartGhostbusters)
zoneParkdeck.Id = "e1103780a2afb0ea11955a37eb6e92c2"
zoneParkdeck.Name = "Parkdeck"
zoneParkdeck.DistanceRangeUOM = "Meters"
zoneParkdeck.ProximityRangeUOM = "Meters"
zoneParkdeck.ShowObjects = "OnEnter"
zoneParkdeck.OutOfRangeName = ""
zoneParkdeck.InRangeName = ""
zoneParkdeck.Description = WWB_multiplatform_string("Parkdeck f\195\188r die Anwohner.")
zoneParkdeck.Visible = true
zoneParkdeck.AllowSetPositionTo = false
zoneParkdeck.Active = false
zoneParkdeck.DistanceRange = Distance(-1, "meters")
zoneParkdeck.ProximityRange = Distance(0, "meters")
zoneParkdeck.Points = {
  ZonePoint(53.8602799645726, 10.6675324134903, 0),
  ZonePoint(53.8603709491777, 10.6674685094346, 0),
  ZonePoint(53.8604086362357, 10.6673142313957, 0),
  ZonePoint(53.8603709491777, 10.6671599533577, 0),
  ZonePoint(53.8602799645726, 10.6670960493009, 0),
  ZonePoint(53.8601889799657, 10.6671599533589, 0),
  ZonePoint(53.8601512929079, 10.6673142313957, 0),
  ZonePoint(53.8601889799657, 10.6674685094347, 0)
}
zoneParkdeck.OriginalPoint = ZonePoint(53.8602799645716, 10.6673142313957, 0)
zoneParkdeck.Media = zmediaZoneParkdeck
zoneStart = Wherigo.Zone(cartGhostbusters)
zoneStart.Id = "5922e0770ba36f7f957ad6196175b7c7"
zoneStart.Name = "Start"
zoneStart.DistanceRangeUOM = "Meters"
zoneStart.ProximityRangeUOM = "Meters"
zoneStart.ShowObjects = "OnEnter"
zoneStart.OutOfRangeName = ""
zoneStart.InRangeName = ""
zoneStart.Description = ""
zoneStart.Visible = true
zoneStart.AllowSetPositionTo = false
zoneStart.Active = true
zoneStart.DistanceRange = Distance(-1, "meters")
zoneStart.ProximityRange = Distance(0, "meters")
zoneStart.Points = {
  ZonePoint(53.8662193889741, 10.671192182047, 0),
  ZonePoint(53.8663052955755, 10.6711318441372, 0),
  ZonePoint(53.8663408792549, 10.6709861755371, 0),
  ZonePoint(53.8663052955755, 10.670840506937, 0),
  ZonePoint(53.8662193889741, 10.6707801690273, 0),
  ZonePoint(53.8661334823727, 10.670840506937, 0),
  ZonePoint(53.8660978986934, 10.6709861755371, 0),
  ZonePoint(53.8661334823727, 10.6711318441372, 0)
}
zoneStart.OriginalPoint = ZonePoint(53.8662193889741, 10.6709861755371, 0)
zoneStart.Media = zmediaZoneStart
zoneTempel = Wherigo.Zone(cartGhostbusters)
zoneTempel.Id = "f5a24960b2729a0bf5512dd4efd310fb"
zoneTempel.Name = "Tempel"
zoneTempel.DistanceRangeUOM = "Meters"
zoneTempel.ProximityRangeUOM = "Meters"
zoneTempel.ShowObjects = "OnEnter"
zoneTempel.OutOfRangeName = ""
zoneTempel.InRangeName = ""
zoneTempel.Description = WWB_multiplatform_string("Ein Tempel mit Altarstein auf dem Dach des Apartmenthauses, wo die Gozer-Anbeter bizarre Rituale durchf\195\188hrten.")
zoneTempel.Visible = true
zoneTempel.AllowSetPositionTo = false
zoneTempel.Active = false
zoneTempel.DistanceRange = Distance(-1, "meters")
zoneTempel.ProximityRange = Distance(0, "meters")
zoneTempel.Points = {
  ZonePoint(53.8661671953083, 10.6700469019618, 0),
  ZonePoint(53.8662531019097, 10.6699865572677, 0),
  ZonePoint(53.8662886855889, 10.6698408722879, 0),
  ZonePoint(53.8662531019097, 10.6696951873079, 0),
  ZonePoint(53.8661671953083, 10.6696348426137, 0),
  ZonePoint(53.8660812887069, 10.6696951873079, 0),
  ZonePoint(53.8660457050274, 10.6698408722879, 0),
  ZonePoint(53.8660812887069, 10.6699865572677, 0)
}
zoneTempel.OriginalPoint = ZonePoint(53.8661671953083, 10.6698408722878, 0)
zoneTempel.Media = zmediaZoneTempel
zoneUFO = Wherigo.Zone(cartGhostbusters)
zoneUFO.Id = "b0de5090479cdef68a39fa3e0f1f21ac"
zoneUFO.Name = "UFO"
zoneUFO.DistanceRangeUOM = "Meters"
zoneUFO.ProximityRangeUOM = "Meters"
zoneUFO.ShowObjects = "OnEnter"
zoneUFO.OutOfRangeName = ""
zoneUFO.InRangeName = ""
zoneUFO.Description = WWB_multiplatform_string("K\195\182nnte die Stahl-Glas-Konstruktion eventuell nur Tarnung f\195\188r etwas v\195\182llig anderes sein?")
zoneUFO.Visible = true
zoneUFO.AllowSetPositionTo = false
zoneUFO.Active = false
zoneUFO.DistanceRange = Distance(-1, "meters")
zoneUFO.ProximityRange = Distance(0, "meters")
zoneUFO.Points = {
  ZonePoint(53.8655203047727, 10.6705731153488, 0),
  ZonePoint(53.8658745932489, 10.6712758541107, 0),
  ZonePoint(53.8660327567784, 10.6710344552994, 0),
  ZonePoint(53.8656811533482, 10.6703048944473, 0),
  ZonePoint(53.8656331153811, 10.670108219665, 0),
  ZonePoint(53.8655171414692, 10.6700267543028, 0),
  ZonePoint(53.8654011675573, 10.670108219665, 0),
  ZonePoint(53.8653531295901, 10.6703048944473, 0),
  ZonePoint(53.8654011675573, 10.6705015692295, 0)
}
zoneUFO.OriginalPoint = ZonePoint(53.8655171414692, 10.6703048944473, 0)
zoneUFO.Media = zmediaZoneUFO
zoneVideothek = Wherigo.Zone(cartGhostbusters)
zoneVideothek.Id = "3c6985b179caa0446ba977e6ec47dacb"
zoneVideothek.Name = "Videothek"
zoneVideothek.DistanceRangeUOM = "Meters"
zoneVideothek.ProximityRangeUOM = "Meters"
zoneVideothek.ShowObjects = "OnEnter"
zoneVideothek.OutOfRangeName = ""
zoneVideothek.InRangeName = ""
zoneVideothek.Description = WWB_multiplatform_string("Ein Eck-Kiosk, der fr\195\188her einmal eine Videothek war.")
zoneVideothek.Visible = true
zoneVideothek.AllowSetPositionTo = false
zoneVideothek.Active = false
zoneVideothek.DistanceRange = Distance(-1, "meters")
zoneVideothek.ProximityRange = Distance(0, "meters")
zoneVideothek.Points = {
  ZonePoint(53.8631730678318, 10.6685847888757, 0),
  ZonePoint(53.8632890417436, 10.6685033235135, 0),
  ZonePoint(53.8633370797108, 10.6683066487312, 0),
  ZonePoint(53.8632890417436, 10.668109973949, 0),
  ZonePoint(53.8631730678318, 10.6680285085869, 0),
  ZonePoint(53.8630570939199, 10.668109973949, 0),
  ZonePoint(53.8630090559527, 10.6683066487312, 0),
  ZonePoint(53.8630570939199, 10.6685033235135, 0)
}
zoneVideothek.OriginalPoint = ZonePoint(53.8631730678318, 10.6683066487312, 0)
zoneVideothek.Media = zmediaZoneVideothek
zoneZOB = Wherigo.Zone(cartGhostbusters)
zoneZOB.Id = "6799073a752e4738bec4ad05f1744f3d"
zoneZOB.Name = "ZOB"
zoneZOB.DistanceRangeUOM = "Meters"
zoneZOB.ProximityRangeUOM = "Meters"
zoneZOB.ShowObjects = "OnEnter"
zoneZOB.OutOfRangeName = ""
zoneZOB.InRangeName = ""
zoneZOB.Description = ""
zoneZOB.Visible = false
zoneZOB.AllowSetPositionTo = false
zoneZOB.Active = false
zoneZOB.DistanceRange = Distance(-1, "meters")
zoneZOB.ProximityRange = Distance(5, "meters")
zoneZOB.Points = {
  ZonePoint(53.8655582643958, 10.6711579722301, 0),
  ZonePoint(53.8661592871715, 10.6707715988159, 0),
  ZonePoint(53.8661719401898, 10.670245885849, 0),
  ZonePoint(53.8660295935137, 10.6698113679886, 0),
  ZonePoint(53.8654190789427, 10.6697845458984, 0),
  ZonePoint(53.8651897382655, 10.6700232625008, 0),
  ZonePoint(53.8649746313842, 10.6701466441154, 0),
  ZonePoint(53.8652814746872, 10.6708413362503, 0)
}
zoneZOB.OriginalPoint = ZonePoint(53.8655582643958, 10.6703853607178, 0)
zcharacterDana = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zcharacterDana.Id = "803e6adbcc82a35fb8ca4b2f2b708373"
zcharacterDana.Name = "Dana"
zcharacterDana.Gender = "Female"
zcharacterDana.Type = "NPC"
zcharacterDana.Description = WWB_multiplatform_string("Die h\195\188bsche Musikerin Dana Barrett")
zcharacterDana.Visible = false
zcharacterDana.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zcharacterDana.Media = zmediaDana
zcharacterDana.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterDana.Commands.Reden.Id = "9b93da1dfaf613da62210583d60de86b"
zcharacterDana.Commands.Reden.Custom = true
zcharacterDana.Commands.Reden.WorksWithAll = true
zcharacterDimensionstor = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneTempel})
zcharacterDimensionstor.Id = "2b1a2f1541bdfe2543b883f21b007673"
zcharacterDimensionstor.Name = "Dimensionstor"
zcharacterDimensionstor.Gender = "It"
zcharacterDimensionstor.Type = "NPC"
zcharacterDimensionstor.Description = WWB_multiplatform_string("Das ge\195\182ffnete Tor in der Pyramide, aus der Gozer in unsere Dimension \195\188bergetreten ist.")
zcharacterDimensionstor.Visible = true
zcharacterDimensionstor.ObjectLocation = ZonePoint(53.8661671953083, 10.6698408722878, 0)
zcharacterDimensionstor.Media = zmediaTempel
zcharacterDimensionstor.Commands = {
  Angucken = Wherigo.ZCommand({
    Text = "Angucken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterDimensionstor.Commands.Angucken.Id = "91bf9658b4644f85c1246568fe8af1f2"
zcharacterDimensionstor.Commands.Angucken.Custom = true
zcharacterDimensionstor.Commands.Angucken.WorksWithAll = true
zcharacterDimensionstor.Commands.Schiessen.Id = "259de43bd705841992644d1b78188f29"
zcharacterDimensionstor.Commands.Schiessen.Custom = true
zcharacterDimensionstor.Commands.Schiessen.WorksWithAll = true
zcharacterEgon = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zcharacterEgon.Id = "281151cb4c28c3b338766aa7f49fec17"
zcharacterEgon.Name = "Egon"
zcharacterEgon.Gender = "Male"
zcharacterEgon.Type = "NPC"
zcharacterEgon.Description = "Parapsychologe Dr. Egon Spengler"
zcharacterEgon.Visible = false
zcharacterEgon.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zcharacterEgon.Media = zmediaEgonDialog
zcharacterEgon.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterEgon.Commands.Reden.Id = "fd49dab470fb6ae9601eea5ed27cb9a3"
zcharacterEgon.Commands.Reden.Custom = true
zcharacterEgon.Commands.Reden.WorksWithAll = false
zcharacterEgon.Commands.Reden.WorksWithListIds = {}
zcharacterEngel = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFriedhof})
zcharacterEngel.Id = "902414bf12e3dfb38f3687466f88727c"
zcharacterEngel.Name = "Engel"
zcharacterEngel.Gender = "It"
zcharacterEngel.Type = "NPC"
zcharacterEngel.Description = "Die Mamorstatue eines Engels. Sie scheint sich irgendwie zu bewegen!"
zcharacterEngel.Visible = true
zcharacterEngel.ObjectLocation = ZonePoint(53.8686882331323, 10.6698516011238, 0)
zcharacterEngel.Media = zmediaAngel
zcharacterEngel.Commands = {
  Angucken = Wherigo.ZCommand({
    Text = "Angucken",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterEngel.Commands.Angucken.Id = "8b4e345a87163f2a1c6955934aaab117"
zcharacterEngel.Commands.Angucken.Custom = true
zcharacterEngel.Commands.Angucken.WorksWithAll = true
zcharacterEngel.Commands.Anpirschen.Id = "f177364eaebd6e3d55139c9c2c24dfac"
zcharacterEngel.Commands.Anpirschen.Custom = true
zcharacterEngel.Commands.Anpirschen.WorksWithAll = true
zcharacterEngel.Commands.Ansprechen.Id = "b4fde3a378fb94dc184f2e73084ff199"
zcharacterEngel.Commands.Ansprechen.Custom = true
zcharacterEngel.Commands.Ansprechen.WorksWithAll = true
zcharacterEngel.Commands.Schiessen.Id = "30829a1a42a3381538c851b36800a924"
zcharacterEngel.Commands.Schiessen.Custom = true
zcharacterEngel.Commands.Schiessen.WorksWithAll = true
zcharacterExot = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneUFO})
zcharacterExot.Id = "934a7bd0956d1b89cdbecec0eaffc46a"
zcharacterExot.Name = "Exot"
zcharacterExot.Gender = "Male"
zcharacterExot.Type = "NPC"
zcharacterExot.Description = WWB_multiplatform_string("Sieht eindeutig nicht irdisch aus, ergo mu\195\159 er... oder besser es au\195\159erirdisch sein.")
zcharacterExot.Visible = true
zcharacterExot.ObjectLocation = ZonePoint(53.8657389092311, 10.6703048944473, 0)
zcharacterExot.Media = zmediaKang
zcharacterExot.Commands = {
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterExot.Commands.Ansprechen.Id = "4e4eadcce6b56d012ebd3d998353ad3b"
zcharacterExot.Commands.Ansprechen.Custom = true
zcharacterExot.Commands.Ansprechen.WorksWithAll = true
zcharacterFlammenteufel = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneParkdeck})
zcharacterFlammenteufel.Id = "5b2cfa95426baa5a1200a627ef98ddfd"
zcharacterFlammenteufel.Name = "Flammenteufel"
zcharacterFlammenteufel.Gender = "Male"
zcharacterFlammenteufel.Type = "NPC"
zcharacterFlammenteufel.Description = "Eine Gestalt aus Feuer &amp;&amp; Glut, die in der hitze-wabernden Luft schwebt."
zcharacterFlammenteufel.Visible = true
zcharacterFlammenteufel.ObjectLocation = ZonePoint(53.8602799645716, 10.6673142313957, 0)
zcharacterFlammenteufel.Media = zmediaFlame
zcharacterFlammenteufel.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterFlammenteufel.Commands.Anpirschen.Id = "af551c7220a2f623518c54cf1669d05e"
zcharacterFlammenteufel.Commands.Anpirschen.Custom = true
zcharacterFlammenteufel.Commands.Anpirschen.WorksWithAll = true
zcharacterFlammenteufel.Commands.Schiessen.Id = "15d76da655e948d33ef0c90aea017a94"
zcharacterFlammenteufel.Commands.Schiessen.Custom = true
zcharacterFlammenteufel.Commands.Schiessen.WorksWithAll = true
zcharacterGeisterzug = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneBahnsteig})
zcharacterGeisterzug.Id = "0b37a06ff669b158818d0bcaeda5d733"
zcharacterGeisterzug.Name = "Geisterzug"
zcharacterGeisterzug.Gender = "It"
zcharacterGeisterzug.Type = "NPC"
zcharacterGeisterzug.Description = "tuuuuuut ... &nbsp;&nbsp;tuuuUUUUUTTTT ... &nbsp;&nbsp;TTTUUUUUUTTTTT"
zcharacterGeisterzug.Visible = false
zcharacterGeisterzug.ObjectLocation = ZonePoint(53.8667191795672, 10.6682127714157, 0)
zcharacterGeisterzug.Media = zmediaGeisterzug
zcharacterGeisterzug.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterGeisterzug.Commands.Anpirschen.Id = "d53a31c748564a39f4c86b6f87c8f2d6"
zcharacterGeisterzug.Commands.Anpirschen.Custom = true
zcharacterGeisterzug.Commands.Anpirschen.WorksWithAll = true
zcharacterGeisterzug.Commands.Schiessen.Id = "0eaee62156eff0f930e753c5f31cd2e8"
zcharacterGeisterzug.Commands.Schiessen.Custom = true
zcharacterGeisterzug.Commands.Schiessen.WorksWithAll = true
zcharacterGozer = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneTempel})
zcharacterGozer.Id = "73f7e66721662625d36f042b0c0e9dd1"
zcharacterGozer.Name = "Gozer"
zcharacterGozer.Gender = "It"
zcharacterGozer.Type = "NPC"
zcharacterGozer.Description = "Gozer, der Vernichter - ein Gott, der im antiken Mesopotamien &nbsp;von den Sumerern und Hethitern &nbsp;verehrt wurde."
zcharacterGozer.Visible = false
zcharacterGozer.ObjectLocation = ZonePoint(53.8661671953083, 10.6698408722878, 0)
zcharacterGozer.Media = zmediaGozer
zcharacterGozer.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterGozer.Commands.Anpirschen.Id = "740d1849a6efc2002aeffb5be64b6e89"
zcharacterGozer.Commands.Anpirschen.Custom = true
zcharacterGozer.Commands.Anpirschen.WorksWithAll = true
zcharacterGozer.Commands.Reden.Id = "f997b8b91e7b0b07fd4ae6dabf4fad0e"
zcharacterGozer.Commands.Reden.Custom = true
zcharacterGozer.Commands.Reden.WorksWithAll = true
zcharacterGozer.Commands.Schiessen.Id = "c66512dcb02b25300ae929ce85967f28"
zcharacterGozer.Commands.Schiessen.Custom = true
zcharacterGozer.Commands.Schiessen.WorksWithAll = true
zcharacterHomunculus = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFriseur})
zcharacterHomunculus.Id = "850fd269983a8f2c329545c3b5879b19"
zcharacterHomunculus.Name = "Homunculus"
zcharacterHomunculus.Gender = "Male"
zcharacterHomunculus.Type = "NPC"
zcharacterHomunculus.Description = WWB_multiplatform_string("Ein k\195\188nstlich erschaffener Mensch mit Scherenh\195\164nden - etwas sch\195\188chtern vielleicht.")
zcharacterHomunculus.Visible = true
zcharacterHomunculus.ObjectLocation = ZonePoint(53.8638943352476, 10.6697872281075, 0)
zcharacterHomunculus.Media = zmediaEdward
zcharacterHomunculus.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterHomunculus.Commands.Anpirschen.Id = "42de0df7218b68fa3bc7986e0e8083a0"
zcharacterHomunculus.Commands.Anpirschen.Custom = true
zcharacterHomunculus.Commands.Anpirschen.WorksWithAll = true
zcharacterHomunculus.Commands.Ansprechen.Id = "e93d4cc730264db7f17e5c41fbd5c149"
zcharacterHomunculus.Commands.Ansprechen.Custom = true
zcharacterHomunculus.Commands.Ansprechen.WorksWithAll = true
zcharacterHomunculus.Commands.Schiessen.Id = "37d0d0d5db0ef04e396d4d6b3c87f797"
zcharacterHomunculus.Commands.Schiessen.Custom = true
zcharacterHomunculus.Commands.Schiessen.WorksWithAll = true
zcharacterJanine = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zcharacterJanine.Id = "aeab5654c2870a0678c15c2e681f1543"
zcharacterJanine.Name = "Janine"
zcharacterJanine.Gender = "Female"
zcharacterJanine.Type = "NPC"
zcharacterJanine.Description = WWB_multiplatform_string("Die gelangweilte Sekret\195\164rin Janine")
zcharacterJanine.Visible = true
zcharacterJanine.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zcharacterJanine.Media = zmediaJanine
zcharacterJanine.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterJanine.Commands.Reden.Id = "af5c30fd786787b798646dfc63fb254c"
zcharacterJanine.Commands.Reden.Custom = true
zcharacterJanine.Commands.Reden.WorksWithAll = true
zcharacterLepusUmbra = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zonePark1})
zcharacterLepusUmbra.Id = "b5e9a859519a1ee321217c30b92967fc"
zcharacterLepusUmbra.Name = "Lepus Umbra"
zcharacterLepusUmbra.Gender = "Male"
zcharacterLepusUmbra.Type = "NPC"
zcharacterLepusUmbra.Description = "Happy Bunny Halloween - wenn er einen Namen hat, dann bestimmt Frank."
zcharacterLepusUmbra.Visible = true
zcharacterLepusUmbra.ObjectLocation = ZonePoint(53.8668251470587, 10.6733250617981, 0)
zcharacterLepusUmbra.Media = zmediaFrank
zcharacterLepusUmbra.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterLepusUmbra.Commands.Anpirschen.Id = "e2404d0aec99248f7773acd9cc35eab1"
zcharacterLepusUmbra.Commands.Anpirschen.Custom = true
zcharacterLepusUmbra.Commands.Anpirschen.WorksWithAll = true
zcharacterLepusUmbra.Commands.Schiessen.Id = "4d51d4cf3976114d76a13e9126fd24bb"
zcharacterLepusUmbra.Commands.Schiessen.Custom = true
zcharacterLepusUmbra.Commands.Schiessen.WorksWithAll = true
zcharacterLouis = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneHochhaus})
zcharacterLouis.Id = "11b3c8ca5ce6ab24f2ecd44be5e7f0a1"
zcharacterLouis.Name = "Louis"
zcharacterLouis.Gender = "Male"
zcharacterLouis.Type = "NPC"
zcharacterLouis.Description = "Der etwas verschrobene Steuerberater Louis Tully"
zcharacterLouis.Visible = true
zcharacterLouis.ObjectLocation = ZonePoint(53.8665404576676, 10.6700420379639, 0)
zcharacterLouis.Media = zmediaLouis
zcharacterLouis.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterLouis.Commands.Reden.Id = "1aad662076ba0c5660b47d88557d38ff"
zcharacterLouis.Commands.Reden.Custom = true
zcharacterLouis.Commands.Reden.WorksWithAll = true
zcharacterMarshmallowMann = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneTempel})
zcharacterMarshmallowMann.Id = "03ef798350d026391cdb001534d4921c"
zcharacterMarshmallowMann.Name = "Marshmallow-Mann"
zcharacterMarshmallowMann.Gender = "It"
zcharacterMarshmallowMann.Type = "NPC"
zcharacterMarshmallowMann.Description = "Deine Nemesis - der allseits beliebte Marshmallow-Mann"
zcharacterMarshmallowMann.Visible = false
zcharacterMarshmallowMann.ObjectLocation = ZonePoint(53.8661671953083, 10.6698408722878, 0)
zcharacterMarshmallowMann.Media = zmediaPuffy
zcharacterMarshmallowMann.Commands = {
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterMarshmallowMann.Commands.Schiessen.Id = "16cb4a8ea0a39662aeb79aa9ca0d1a5c"
zcharacterMarshmallowMann.Commands.Schiessen.Custom = true
zcharacterMarshmallowMann.Commands.Schiessen.WorksWithAll = true
zcharacterOfficerWalker = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zcharacterOfficerWalker.Id = "b66cf35c5e4ddfe5ab80ea8a83d8db32"
zcharacterOfficerWalker.Name = "Officer Walker"
zcharacterOfficerWalker.Gender = "Male"
zcharacterOfficerWalker.Type = "NPC"
zcharacterOfficerWalker.Description = WWB_multiplatform_string("Ein knallharter Cop, der wohl ein bisschen mehr Karate kann. Aber mach besser keine Witze \195\188ber ihn, der versteht keinen Spa\195\159!")
zcharacterOfficerWalker.Visible = false
zcharacterOfficerWalker.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zcharacterOfficerWalker.Media = zmediaOfficer
zcharacterOfficerWalker.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterOfficerWalker.Commands.Reden.Id = "fca3d0832650efdf2ca75456c1fe61a7"
zcharacterOfficerWalker.Commands.Reden.Custom = true
zcharacterOfficerWalker.Commands.Reden.WorksWithAll = true
zcharacterPeter = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zcharacterPeter.Id = "7dad91754f1aa8a91a361677b9bf427d"
zcharacterPeter.Name = "Peter"
zcharacterPeter.Gender = "Male"
zcharacterPeter.Type = "NPC"
zcharacterPeter.Description = "Parapsychologe Dr. Peter Venkman"
zcharacterPeter.Visible = false
zcharacterPeter.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zcharacterPeter.Media = zmediaPeterDialog
zcharacterPeter.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterPeter.Commands.Reden.Id = "7be058f60f412fbd7fde9e823f6f74f1"
zcharacterPeter.Commands.Reden.Custom = true
zcharacterPeter.Commands.Reden.WorksWithAll = false
zcharacterPeter.Commands.Reden.WorksWithListIds = {}
zcharacterPirat = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneAmWasser})
zcharacterPirat.Id = "12894ca853ebcdda7b9fff9688183d2c"
zcharacterPirat.Name = "Pirat"
zcharacterPirat.Gender = "Male"
zcharacterPirat.Type = "NPC"
zcharacterPirat.Description = WWB_multiplatform_string("Ein b\195\164rbeissiger Pirat mit lodernden Haaren und Bart.")
zcharacterPirat.Visible = true
zcharacterPirat.ObjectLocation = ZonePoint(53.8656689797665, 10.6762218475342, 0)
zcharacterPirat.Media = zmediaCaptain
zcharacterPirat.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterPirat.Commands.Anpirschen.Id = "452b81794ce77868bc2768eed440db10"
zcharacterPirat.Commands.Anpirschen.Custom = true
zcharacterPirat.Commands.Anpirschen.WorksWithAll = true
zcharacterPirat.Commands.Ansprechen.Id = "e95774ec8758652c0e942a8dbc9cba0c"
zcharacterPirat.Commands.Ansprechen.Custom = true
zcharacterPirat.Commands.Ansprechen.WorksWithAll = true
zcharacterPirat.Commands.Schiessen.Id = "6016a70ac27af7c974f9c95927d89c08"
zcharacterPirat.Commands.Schiessen.Custom = true
zcharacterPirat.Commands.Schiessen.WorksWithAll = true
zcharacterRay = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zcharacterRay.Id = "7071635dcee2a341f81b8c0a7dffaa2d"
zcharacterRay.Name = "Ray"
zcharacterRay.Gender = "Male"
zcharacterRay.Type = "NPC"
zcharacterRay.Description = "Parapsychologe Dr. Raymond \"Ray\" Stantz"
zcharacterRay.Visible = false
zcharacterRay.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zcharacterRay.Media = zmediaRayDialog
zcharacterRay.Commands = {
  Reden = Wherigo.ZCommand({
    Text = "Reden",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterRay.Commands.Reden.Id = "a618a4bd70e3034bdfa37ad03eafce39"
zcharacterRay.Commands.Reden.Custom = true
zcharacterRay.Commands.Reden.WorksWithAll = true
zcharacterRitter = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneBruecke})
zcharacterRitter.Id = "0bf8216c7dee1e92fa8a41d0b993ccee"
zcharacterRitter.Name = "Ritter"
zcharacterRitter.Gender = "Male"
zcharacterRitter.Type = "NPC"
zcharacterRitter.Description = WWB_multiplatform_string("Ein schwarzer Ritter, der breitbeinig auf der Br\195\188cke steht &amp;&amp; niemanden passieren l\195\164\195\159t.")
zcharacterRitter.Visible = true
zcharacterRitter.ObjectLocation = ZonePoint(53.8654301505298, 10.6658229231834, 0)
zcharacterRitter.Media = zmediaRitter
zcharacterRitter.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Ansprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterRitter.Commands.Anpirschen.Id = "f5d41328a9496a70cbc5f7b93991abe8"
zcharacterRitter.Commands.Anpirschen.Custom = true
zcharacterRitter.Commands.Anpirschen.WorksWithAll = true
zcharacterRitter.Commands.Ansprechen.Id = "dd023c4168f56fd2b68de3c1a0eafb38"
zcharacterRitter.Commands.Ansprechen.Custom = true
zcharacterRitter.Commands.Ansprechen.WorksWithAll = true
zcharacterRitter.Commands.Schiessen.Id = "0a885e994f442246b6d6d2840b1042e1"
zcharacterRitter.Commands.Schiessen.Custom = true
zcharacterRitter.Commands.Schiessen.WorksWithAll = true
zcharacterSchatten = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneVideothek})
zcharacterSchatten.Id = "17f076bef95efe37980b39e1322afddd"
zcharacterSchatten.Name = "Schatten"
zcharacterSchatten.Gender = "Male"
zcharacterSchatten.Type = "NPC"
zcharacterSchatten.Description = WWB_multiplatform_string("Ein unheimlicher schwarzer Schatten, der pure Bosheit &amp;&amp; Gift verk\195\182rpert. In Blau und Rot w\195\164re es die freundliche Spinne von neben an.")
zcharacterSchatten.Visible = false
zcharacterSchatten.ObjectLocation = ZonePoint(53.8631730678318, 10.6683066487312, 0)
zcharacterSchatten.Media = zmediaSchatten
zcharacterSchatten.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterSchatten.Commands.Anpirschen.Id = "78f9922cfc85363916a85531280338b0"
zcharacterSchatten.Commands.Anpirschen.Custom = true
zcharacterSchatten.Commands.Anpirschen.WorksWithAll = true
zcharacterSchatten.Commands.Schiessen.Id = "60b0a5690d9ee51096fd7c4185163c34"
zcharacterSchatten.Commands.Schiessen.Custom = true
zcharacterSchatten.Commands.Schiessen.WorksWithAll = true
zcharacterSlimer = Wherigo.ZCharacter({Cartridge = cartGhostbusters, Container = zoneHotel})
zcharacterSlimer.Id = "4c68d365c64990d222c1753107ce51d3"
zcharacterSlimer.Name = "Slimer"
zcharacterSlimer.Gender = "It"
zcharacterSlimer.Type = "NPC"
zcharacterSlimer.Description = "Eine widerliche kleine Kartoffel - Pass auf, das er dich nicht anschleimt!"
zcharacterSlimer.Visible = false
zcharacterSlimer.ObjectLocation = ZonePoint(53.8660659710436, 10.6730943918228, 0)
zcharacterSlimer.Media = zmediaSlimer
zcharacterSlimer.Commands = {
  Anpirschen = Wherigo.ZCommand({
    Text = "Anpirschen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Schiessen = Wherigo.ZCommand({
    Text = "Schiessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zcharacterSlimer.Commands.Anpirschen.Id = "918d67a256ecbfd3f05fadaaf9c3a184"
zcharacterSlimer.Commands.Anpirschen.Custom = true
zcharacterSlimer.Commands.Anpirschen.WorksWithAll = true
zcharacterSlimer.Commands.Schiessen.Id = "4b3702adc2bd2b894ec44d658c76f8b7"
zcharacterSlimer.Commands.Schiessen.Custom = true
zcharacterSlimer.Commands.Schiessen.WorksWithAll = true
zitemDefekteFalle = Wherigo.ZItem(cartGhostbusters)
zitemDefekteFalle.Id = "e3aba8ac6d6de24ab057cdbb65bb0f96"
zitemDefekteFalle.Name = "Defekte Falle"
zitemDefekteFalle.Description = WWB_multiplatform_string("Tja, die ist hin\195\188ber. Da hilft nur noch die Entsorgung.")
zitemDefekteFalle.Visible = false
zitemDefekteFalle.Locked = false
zitemDefekteFalle.Opened = false
zitemDefekteFalle.ObjectLocation = ZonePoint(53.8646076817986, 10.6689396500587, 0)
zitemDefekteFalle.Media = zmediaTrapMalfunction
zitemDefekteFalle.Commands = {
  Ersetzten = Wherigo.ZCommand({
    Text = "Ersetzten",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemDefekteFalle.Commands.Ersetzten.Id = "1f722e8c77296d73cd23ac85c299a128"
zitemDefekteFalle.Commands.Ersetzten.Custom = true
zitemDefekteFalle.Commands.Ersetzten.WorksWithAll = true
zitemFalle = Wherigo.ZItem({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zitemFalle.Id = "2dcef2d7fe26e38e377de0c54ad8129e"
zitemFalle.Name = "Falle"
zitemFalle.Description = WWB_multiplatform_string("beschreibung mit var xFalle \195\188ber OnStart.cartridge")
zitemFalle.Visible = false
zitemFalle.Locked = false
zitemFalle.Opened = false
zitemFalle.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zitemFalle.Media = zmediaTrapEmpty
zitemFalle.Commands = {
  Nehmen = Wherigo.ZCommand({
    Text = "Nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemFalle.Commands.Nehmen.Id = "5caf833e3a4d6a902fab1548722d5c5d"
zitemFalle.Commands.Nehmen.Custom = true
zitemFalle.Commands.Nehmen.WorksWithAll = true
zitemProtonPack = Wherigo.ZItem({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zitemProtonPack.Id = "13e80c038da3757d3eb3fdf0b41ba0ca"
zitemProtonPack.Name = "Proton-Pack"
zitemProtonPack.Description = WWB_multiplatform_string("Das Proton-Pack um Geister \195\188ber der Falle in Schach zu halten.")
zitemProtonPack.Visible = false
zitemProtonPack.Locked = false
zitemProtonPack.Opened = false
zitemProtonPack.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zitemProtonPack.Media = zmediaProtoPack
zitemProtonPack.Commands = {
  Aktivieren = Wherigo.ZCommand({
    Text = "Aktivieren",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Deaktivieren = Wherigo.ZCommand({
    Text = "Deaktivieren",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Nehmen = Wherigo.ZCommand({
    Text = "Nehmen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  }),
  Reparieren = Wherigo.ZCommand({
    Text = "Reparieren",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Tragen = Wherigo.ZCommand({
    Text = "Tragen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemProtonPack.Commands.Aktivieren.Id = "e8085593c27d81d294b7e87d3ab31c5e"
zitemProtonPack.Commands.Aktivieren.Custom = true
zitemProtonPack.Commands.Aktivieren.WorksWithAll = true
zitemProtonPack.Commands.Deaktivieren.Id = "c20b924578082998c8cfdd58efe33e09"
zitemProtonPack.Commands.Deaktivieren.Custom = true
zitemProtonPack.Commands.Deaktivieren.WorksWithAll = true
zitemProtonPack.Commands.Nehmen.Id = "80bf3da2035b418913d173fe39881bd1"
zitemProtonPack.Commands.Nehmen.Custom = true
zitemProtonPack.Commands.Nehmen.WorksWithAll = true
zitemProtonPack.Commands.Reparieren.Id = "80e5ea0819b8051fd52151a71852f94c"
zitemProtonPack.Commands.Reparieren.Custom = true
zitemProtonPack.Commands.Reparieren.WorksWithAll = true
zitemProtonPack.Commands.Tragen.Id = "1de1320a64696ffb50782984e7109924"
zitemProtonPack.Commands.Tragen.Custom = true
zitemProtonPack.Commands.Tragen.WorksWithAll = true
zitemstory = Wherigo.ZItem({Cartridge = cartGhostbusters, Container = zoneStart})
zitemstory.Id = "792b43e87ec4baecbed8ccef32e5fad6"
zitemstory.Name = "story"
zitemstory.Description = ""
zitemstory.Visible = false
zitemstory.Locked = false
zitemstory.Opened = false
zitemstory.ObjectLocation = ZonePoint(53.8662193889741, 10.6709861755371, 0)
zitemstory.Commands = {
  story = Wherigo.ZCommand({
    Text = "story",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemstory.Commands.story.Id = "8478b642e7767eee58625b5fdd8d4e93"
zitemstory.Commands.story.Custom = true
zitemstory.Commands.story.WorksWithAll = true
zitemUnlockKey = Wherigo.ZItem({Cartridge = cartGhostbusters, Container = zoneFinal})
zitemUnlockKey.Id = "317bb5d687c4d8bd21a746c8baf80283"
zitemUnlockKey.Name = "Unlock-Key"
zitemUnlockKey.Description = ""
zitemUnlockKey.Visible = false
zitemUnlockKey.Locked = false
zitemUnlockKey.Opened = false
zitemUnlockKey.ObjectLocation = ZonePoint(53.8656144129808, 10.6682181358338, 0)
zitemUnlockKey.Media = zmediaKey
zitemUnlockKey.Commands = {
  Aufschliessen = Wherigo.ZCommand({
    Text = "Aufschliessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemUnlockKey.Commands.Aufschliessen.Id = "45565fc802bc1794e0c345fd287a655b"
zitemUnlockKey.Commands.Aufschliessen.Custom = true
zitemUnlockKey.Commands.Aufschliessen.WorksWithAll = true
zitemVolleFalle = Wherigo.ZItem({Cartridge = cartGhostbusters, Container = zoneFeuerwehr})
zitemVolleFalle.Id = "04f0ce613050d84c9f3033cbfe515645"
zitemVolleFalle.Name = "Volle Falle"
zitemVolleFalle.Description = "beschreibung mit var xFalle"
zitemVolleFalle.Visible = false
zitemVolleFalle.Locked = false
zitemVolleFalle.Opened = false
zitemVolleFalle.ObjectLocation = ZonePoint(53.8646033321614, 10.6689450144768, 0)
zitemVolleFalle.Media = zmediaTrapUsed
zitemVolleFalle.Commands = {
  Entladen = Wherigo.ZCommand({
    Text = "Entladen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  })
}
zitemVolleFalle.Commands.Entladen.Id = "a0dc1b29fe40ba451f1daaf03b1f91da"
zitemVolleFalle.Commands.Entladen.Custom = true
zitemVolleFalle.Commands.Entladen.WorksWithAll = true
ztaskAmWasser = Wherigo.ZTask(cartGhostbusters)
ztaskAmWasser.Id = "73879005c195c7114726cfc45776c4df"
ztaskAmWasser.Name = "Am Wasser"
ztaskAmWasser.CorrectState = "None"
ztaskAmWasser.Description = "Nahe am Wasser krakeelt jemand etwas rum."
ztaskAmWasser.Visible = true
ztaskAmWasser.Active = false
ztaskAmWasser.Complete = false
ztaskAmWasser.Media = zmediaZoneWasser
ztaskAngebotvonLouis = Wherigo.ZTask(cartGhostbusters)
ztaskAngebotvonLouis.Id = "a32cec4da6b7085536e53d5e3839c805"
ztaskAngebotvonLouis.Name = "Angebot von Louis"
ztaskAngebotvonLouis.CorrectState = "None"
ztaskAngebotvonLouis.Description = WWB_multiplatform_string("Louis macht euch ein echt gutes Angebot... wenn ihr wirklich Kammerj\195\164ger sein w\195\188rdet!")
ztaskAngebotvonLouis.Visible = true
ztaskAngebotvonLouis.Active = false
ztaskAngebotvonLouis.Complete = false
ztaskAngebotvonLouis.Media = zmediaLouis
ztaskAufderBruecke = Wherigo.ZTask(cartGhostbusters)
ztaskAufderBruecke.Id = "648da431e40ebb0e60f6bd940f68da3f"
ztaskAufderBruecke.Name = "Auf der Bruecke"
ztaskAufderBruecke.CorrectState = "None"
ztaskAufderBruecke.Description = WWB_multiplatform_string("Die Br\195\188cke wird blockiert von einer dunklen Gestalt.")
ztaskAufderBruecke.Visible = true
ztaskAufderBruecke.Active = false
ztaskAufderBruecke.Complete = false
ztaskAufderBruecke.Media = zmediaZoneBruecke
ztaskBefrageLouis = Wherigo.ZTask(cartGhostbusters)
ztaskBefrageLouis.Id = "7f062a6b942d85bab75d27c044c71176"
ztaskBefrageLouis.Name = "Befrage Louis"
ztaskBefrageLouis.CorrectState = "None"
ztaskBefrageLouis.Description = "Der Cop hat den sehr verwirrt wirkenden Louis gebracht. Was ist mit ihm los?"
ztaskBefrageLouis.Visible = true
ztaskBefrageLouis.Active = false
ztaskBefrageLouis.Complete = false
ztaskBefrageLouis.Media = zmediaLouisPossesed
ztaskDasHochhaus = Wherigo.ZTask(cartGhostbusters)
ztaskDasHochhaus.Id = "64e388823acc85f5682ac34904352e7a"
ztaskDasHochhaus.Name = "Das Hochhaus"
ztaskDasHochhaus.CorrectState = "None"
ztaskDasHochhaus.Description = "Gehe mit Dana zu ihrem Apartment."
ztaskDasHochhaus.Visible = true
ztaskDasHochhaus.Active = false
ztaskDasHochhaus.Complete = false
ztaskDasHochhaus.Media = zmediaZoneHochhaus
ztaskDasHotel = Wherigo.ZTask(cartGhostbusters)
ztaskDasHotel.Id = "f895d196bb257c118d5c0b72dc699b3c"
ztaskDasHotel.Name = "Das Hotel"
ztaskDasHotel.CorrectState = "None"
ztaskDasHotel.Description = WWB_multiplatform_string("Ein Hotel hat gewisse Schwierigkeiten. L\195\182st dieses Problem dezent!")
ztaskDasHotel.Visible = true
ztaskDasHotel.Active = false
ztaskDasHotel.Complete = false
ztaskDasHotel.Media = zmediaZoneHotel
ztaskDasParkdeck = Wherigo.ZTask(cartGhostbusters)
ztaskDasParkdeck.Id = "4cf0da008daeaf5f1e52dd51eedeaeea"
ztaskDasParkdeck.Name = "Das Parkdeck"
ztaskDasParkdeck.CorrectState = "None"
ztaskDasParkdeck.Description = WWB_multiplatform_string("Anwohner berichten von Flammen, die immer wieder unter Autos rausz\195\188ngeln.")
ztaskDasParkdeck.Visible = true
ztaskDasParkdeck.Active = false
ztaskDasParkdeck.Complete = false
ztaskDasParkdeck.Media = zmediaZoneParkdeck
ztaskDerBahnhof = Wherigo.ZTask(cartGhostbusters)
ztaskDerBahnhof.Id = "2d4ba428e9a9ba122f99ea605c6c36a7"
ztaskDerBahnhof.Name = "Der Bahnhof"
ztaskDerBahnhof.CorrectState = "None"
ztaskDerBahnhof.Description = "Verschreckte Passagiere beschweren sich bei der Bahn."
ztaskDerBahnhof.Visible = true
ztaskDerBahnhof.Active = false
ztaskDerBahnhof.Complete = false
ztaskDerBahnhof.Media = zmediaZoneBahnhof
ztaskDerFriedhof = Wherigo.ZTask(cartGhostbusters)
ztaskDerFriedhof.Id = "ab934a947f1c0fc772a0e8d4fbc98abb"
ztaskDerFriedhof.Name = "Der Friedhof"
ztaskDerFriedhof.CorrectState = "None"
ztaskDerFriedhof.Description = "Auf dem Friedhof gehen seltsame Dinge vor sich."
ztaskDerFriedhof.Visible = true
ztaskDerFriedhof.Active = false
ztaskDerFriedhof.Complete = false
ztaskDerFriedhof.Media = zmediaZoneFriedhof
ztaskDerFriseur = Wherigo.ZTask(cartGhostbusters)
ztaskDerFriseur.Id = "d4ee422f06f0a55c62e020bd5bd34a63"
ztaskDerFriseur.Name = "Der Friseur"
ztaskDerFriseur.CorrectState = "None"
ztaskDerFriseur.Description = "Einem Friseur bleibt die Kundschaft weg."
ztaskDerFriseur.Visible = true
ztaskDerFriseur.Active = false
ztaskDerFriseur.Complete = false
ztaskDerFriseur.Media = zmediaZoneFriseur
ztaskDerPark = Wherigo.ZTask(cartGhostbusters)
ztaskDerPark.Id = "9363d2d4070df25e91209e6ba282a65f"
ztaskDerPark.Name = "Der Park"
ztaskDerPark.CorrectState = "None"
ztaskDerPark.Description = "Auf der Parkwiese des Parks treibt sich ein Nager rum. Fang ihn ein!"
ztaskDerPark.Visible = true
ztaskDerPark.Active = false
ztaskDerPark.Complete = false
ztaskDerPark.Media = zmediaZonePark
ztaskDieVideothek = Wherigo.ZTask(cartGhostbusters)
ztaskDieVideothek.Id = "bd4df3ab4e33d149bf35bae98b53cb8d"
ztaskDieVideothek.Name = "Die Videothek"
ztaskDieVideothek.CorrectState = "None"
ztaskDieVideothek.Description = "Ein Ladenbesitzer bekommt Panik, wenn er in seinem Eck-Kiosk ist."
ztaskDieVideothek.Visible = true
ztaskDieVideothek.Active = false
ztaskDieVideothek.Complete = false
ztaskDieVideothek.Media = zmediaZoneVideothek
ztaskEinanderesWortfuerFriseur = Wherigo.ZTask(cartGhostbusters)
ztaskEinanderesWortfuerFriseur.Id = "e32c97a5a15c4832410229a8417dee30"
ztaskEinanderesWortfuerFriseur.Name = "Ein anderes Wort fuer Friseur"
ztaskEinanderesWortfuerFriseur.CorrectState = "None"
ztaskEinanderesWortfuerFriseur.Description = WWB_multiplatform_string("Der Gothic-Frankenstein sucht scherenringend eine andere Bezeichnung f\195\188r Friseur... warum auch immer...")
ztaskEinanderesWortfuerFriseur.Visible = true
ztaskEinanderesWortfuerFriseur.Active = false
ztaskEinanderesWortfuerFriseur.Complete = false
ztaskEinanderesWortfuerFriseur.Media = zmediaEdward
ztaskEinOfficerwilleuchsprechen = Wherigo.ZTask(cartGhostbusters)
ztaskEinOfficerwilleuchsprechen.Id = "1eec6f9ca208778a11aff497bbe08518"
ztaskEinOfficerwilleuchsprechen.Name = "Ein Officer will euch sprechen"
ztaskEinOfficerwilleuchsprechen.CorrectState = "None"
ztaskEinOfficerwilleuchsprechen.Description = WWB_multiplatform_string("Bei der Station hat ein Officer angeklopft und w\195\188nscht euch zu sprechen.")
ztaskEinOfficerwilleuchsprechen.Visible = true
ztaskEinOfficerwilleuchsprechen.Active = false
ztaskEinOfficerwilleuchsprechen.Complete = false
ztaskEinOfficerwilleuchsprechen.Media = zmediaOfficer
ztaskFalledefekt = Wherigo.ZTask(cartGhostbusters)
ztaskFalledefekt.Id = "17137c290c3f7715a2585705f807266b"
ztaskFalledefekt.Name = "Falle defekt"
ztaskFalledefekt.CorrectState = "None"
ztaskFalledefekt.Description = "Durch den Schatten ist die Falle unbrauchbar geworden. Tausche sie gegen eine Neue in der Station aus."
ztaskFalledefekt.Visible = true
ztaskFalledefekt.Active = false
ztaskFalledefekt.Complete = false
ztaskFalledefekt.Media = zmediaTrapMalfunction
ztaskFalleueberlastet = Wherigo.ZTask(cartGhostbusters)
ztaskFalleueberlastet.Id = "ef2002796ccbc4cad2b0723d8d1b5128"
ztaskFalleueberlastet.Name = "Falle ueberlastet"
ztaskFalleueberlastet.CorrectState = "None"
ztaskFalleueberlastet.Description = WWB_multiplatform_string("Die Falle ist \195\188berlastet! Schnell! Du hast nur wenige Sekunden Zeit sie in dem Hauptspeicher zu entladen!!!")
ztaskFalleueberlastet.Visible = true
ztaskFalleueberlastet.Active = false
ztaskFalleueberlastet.Complete = false
ztaskFalleueberlastet.Media = zmediaTrapMalfunction
ztaskFindedasNummernschild = Wherigo.ZTask(cartGhostbusters)
ztaskFindedasNummernschild.Id = "1985b5645b5d33f0e509da197873c53f"
ztaskFindedasNummernschild.Name = "Finde das Nummernschild"
ztaskFindedasNummernschild.CorrectState = "None"
ztaskFindedasNummernschild.Description = [[
Finde das Nummernschild des Einsatzwagens. Es muss irgendwo bei der Auffahrt zum Hauptquartier abgefallen sein.<BR>
<BR>
HINT: Zrgnyyfgryr]]
ztaskFindedasNummernschild.Visible = true
ztaskFindedasNummernschild.Active = false
ztaskFindedasNummernschild.Complete = false
ztaskFindedasNummernschild.Media = zmediaEcto1
ztaskFindedasSiegeldesRitters = Wherigo.ZTask(cartGhostbusters)
ztaskFindedasSiegeldesRitters.Id = "f5f8b74de5153433c92012131c49de8b"
ztaskFindedasSiegeldesRitters.Name = "Finde das Siegel des Ritters"
ztaskFindedasSiegeldesRitters.CorrectState = "None"
ztaskFindedasSiegeldesRitters.Description = [[
Der Ritter scheint ein Siegel zu suchen.<BR>
<BR>
HINT: Rvaohpughat]]
ztaskFindedasSiegeldesRitters.Visible = true
ztaskFindedasSiegeldesRitters.Active = false
ztaskFindedasSiegeldesRitters.Complete = false
ztaskFindedasSiegeldesRitters.Media = zmediaRitter
ztaskFindediealteFeuerwehr = Wherigo.ZTask(cartGhostbusters)
ztaskFindediealteFeuerwehr.Id = "1ee924d6388dc88c772056604a1f03c1"
ztaskFindediealteFeuerwehr.Name = "Finde die alte Feuerwehr"
ztaskFindediealteFeuerwehr.CorrectState = "None"
ztaskFindediealteFeuerwehr.Description = WWB_multiplatform_string("Die Geisterj\195\164ger haben in einer alten Feuerwehrwache Quartier bezogen. <BR>\nGehe etwa 250m Richtung S\195\188d-Westen, wenn du den alte Schlauchturm siehst, weisst du wo dein Ziel ist.<BR>\nGehe zur Front mit dem rotem Tor.")
ztaskFindediealteFeuerwehr.Visible = true
ztaskFindediealteFeuerwehr.Active = false
ztaskFindediealteFeuerwehr.Complete = false
ztaskFindediealteFeuerwehr.Media = zmediaZoneFeuerwehr
ztaskGehehochzumTempel = Wherigo.ZTask(cartGhostbusters)
ztaskGehehochzumTempel.Id = "0102ac6aa999c8a0f47611ed8d040104"
ztaskGehehochzumTempel.Name = "Gehe hoch zum Tempel"
ztaskGehehochzumTempel.CorrectState = "None"
ztaskGehehochzumTempel.Description = WWB_multiplatform_string("Ray hat eine Treppe entdeckt, die laut den Baupl\195\164nen hoch zum Dach f\195\188hrt, wo die Gozer-Anbeter bizarre Rituale durch f\195\188hrten.")
ztaskGehehochzumTempel.Visible = true
ztaskGehehochzumTempel.Active = false
ztaskGehehochzumTempel.Complete = false
ztaskGehehochzumTempel.Media = zmediaZoneTempel
ztaskGehezurFinalZoneundfindedenCache = Wherigo.ZTask(cartGhostbusters)
ztaskGehezurFinalZoneundfindedenCache.Id = "75cf092f513c3c1f318159faa284aea7"
ztaskGehezurFinalZoneundfindedenCache.Name = "Gehe zur Final-Zone und finde den Cache"
ztaskGehezurFinalZoneundfindedenCache.CorrectState = "None"
ztaskGehezurFinalZoneundfindedenCache.Description = WWB_multiplatform_string("Suche von hier das Final.<BR>\nDas Gedicht gibt dir die n\195\182tigen Hinweise!")
ztaskGehezurFinalZoneundfindedenCache.Visible = true
ztaskGehezurFinalZoneundfindedenCache.Active = false
ztaskGehezurFinalZoneundfindedenCache.Complete = false
ztaskGehezurFinalZoneundfindedenCache.Media = zmediaZoneFinal
ztaskHaltedensumerischenGottGozerauf = Wherigo.ZTask(cartGhostbusters)
ztaskHaltedensumerischenGottGozerauf.Id = "78eec6e9c8553ecc25222ab4d870e7d5"
ztaskHaltedensumerischenGottGozerauf.Name = "Halte den sumerischen Gott Gozer auf"
ztaskHaltedensumerischenGottGozerauf.CorrectState = "None"
ztaskHaltedensumerischenGottGozerauf.Description = WWB_multiplatform_string("Gozer der Vernichter ist in unsere Welt gestiegen. Halte ihn auf die Welt zu unterjochen &amp;&amp; schick ihn zur\195\188ck in seine Dimension.")
ztaskHaltedensumerischenGottGozerauf.Visible = true
ztaskHaltedensumerischenGottGozerauf.Active = false
ztaskHaltedensumerischenGottGozerauf.Complete = false
ztaskHaltedensumerischenGottGozerauf.Media = zmediaGozer
ztaskProtonPackreparieren = Wherigo.ZTask(cartGhostbusters)
ztaskProtonPackreparieren.Id = "dad94d083dbfbbca76c8bef700c54f63"
ztaskProtonPackreparieren.Name = "Proton-Pack reparieren"
ztaskProtonPackreparieren.CorrectState = "None"
ztaskProtonPackreparieren.Description = WWB_multiplatform_string("Beim Kampf mit dem Flammenteufel wurde der Controller abgerissen. Such ihn! Die Kabel m\195\188ssen wieder richtig rein! Mach bloss keinen Fehler, sonst wird alles im Umkreis von 100m annihiliert!<BR>\n<BR>\nHINT: Fchaqjnaq")
ztaskProtonPackreparieren.Visible = true
ztaskProtonPackreparieren.Active = false
ztaskProtonPackreparieren.Complete = false
ztaskProtonPackreparieren.Media = zmediaProtoPack
ztaskRedemitDana = Wherigo.ZTask(cartGhostbusters)
ztaskRedemitDana.Id = "d16e78ed7b77d4b352e64a81483abb9d"
ztaskRedemitDana.Name = "Rede mit Dana"
ztaskRedemitDana.CorrectState = "None"
ztaskRedemitDana.Description = "Dana wartet in der Feuerwehr. Rede mit ihr."
ztaskRedemitDana.Visible = true
ztaskRedemitDana.Active = false
ztaskRedemitDana.Complete = false
ztaskRedemitDana.Media = zmediaDana
ztaskVerhinderedasZuulundVinzsichtreffen = Wherigo.ZTask(cartGhostbusters)
ztaskVerhinderedasZuulundVinzsichtreffen.Id = "ef86df7c41a05b8d6b49226d36d967b7"
ztaskVerhinderedasZuulundVinzsichtreffen.Name = "Verhindere das Zuul und Vinz sich treffen"
ztaskVerhinderedasZuulundVinzsichtreffen.CorrectState = "None"
ztaskVerhinderedasZuulundVinzsichtreffen.Description = WWB_multiplatform_string("Der Halbgott Zuul, der \"Torw\195\164chter\", und der D\195\164mon Vinz Clortho, der \"Schl\195\188sselmeister\", sollten sich besser nicht treffen. Schnell zu Dana Barrett's Wohnung.")
ztaskVerhinderedasZuulundVinzsichtreffen.Visible = true
ztaskVerhinderedasZuulundVinzsichtreffen.Active = false
ztaskVerhinderedasZuulundVinzsichtreffen.Complete = false
ztaskVerhinderedasZuulundVinzsichtreffen.Media = zmediaDanaPossesed
ztaskVolleFalle = Wherigo.ZTask(cartGhostbusters)
ztaskVolleFalle.Id = "9cbe7c1358ed6a4d90b75739af54c5f2"
ztaskVolleFalle.Name = "Volle Falle"
ztaskVolleFalle.CorrectState = "None"
ztaskVolleFalle.Description = "Du musst volle Fallen beizeiten in den Hauptspeicher des Hauptquartiers entleeren."
ztaskVolleFalle.Visible = true
ztaskVolleFalle.Active = false
ztaskVolleFalle.Complete = false
ztaskVolleFalle.Media = zmediaTrapUsed
ztaskWannkamderSchwarzeTod = Wherigo.ZTask(cartGhostbusters)
ztaskWannkamderSchwarzeTod.Id = "e523328b475fcb00a91ec208a5551412"
ztaskWannkamderSchwarzeTod.Name = "Wann kam der Schwarze Tod?"
ztaskWannkamderSchwarzeTod.CorrectState = "None"
ztaskWannkamderSchwarzeTod.Description = WWB_multiplatform_string("Der Mamorengel fragt, wann der Schwarze Tod von T\195\188r zu T\195\188r ging.")
ztaskWannkamderSchwarzeTod.Visible = true
ztaskWannkamderSchwarzeTod.Active = false
ztaskWannkamderSchwarzeTod.Complete = false
ztaskWannkamderSchwarzeTod.Media = zmediaAngel
ztaskWashatRayrausgefunden = Wherigo.ZTask(cartGhostbusters)
ztaskWashatRayrausgefunden.Id = "9604f147c680eaac88ea805867255a48"
ztaskWashatRayrausgefunden.Name = "Was hat Ray rausgefunden?"
ztaskWashatRayrausgefunden.CorrectState = "None"
ztaskWashatRayrausgefunden.Description = WWB_multiplatform_string("Ray war beim Grundbuchamt und hat sich die Pl\195\164ne von Dana's Apartmenthaus kopiert. Er scheint interessante Sachen rausgefunden zu haben.")
ztaskWashatRayrausgefunden.Visible = true
ztaskWashatRayrausgefunden.Active = false
ztaskWashatRayrausgefunden.Complete = false
ztaskWashatRayrausgefunden.Media = zmediaRayDialog
ztaskWerbautedasApartmenthaus = Wherigo.ZTask(cartGhostbusters)
ztaskWerbautedasApartmenthaus.Id = "c04c2299f3ccb99287e8332dd79bd9c7"
ztaskWerbautedasApartmenthaus.Name = "Wer baute das Apartmenthaus?"
ztaskWerbautedasApartmenthaus.CorrectState = "None"
ztaskWerbautedasApartmenthaus.Description = WWB_multiplatform_string("Wie sind die Namen der Architekten des Geb\195\164udes wo Dana Barrett wohnt? Rede mit Ihr.")
ztaskWerbautedasApartmenthaus.Visible = true
ztaskWerbautedasApartmenthaus.Active = false
ztaskWerbautedasApartmenthaus.Complete = false
ztaskWerbautedasApartmenthaus.Media = zmediaZoneHochhaus
ztaskWoistKangsKochbuch = Wherigo.ZTask(cartGhostbusters)
ztaskWoistKangsKochbuch.Id = "3ebd4e3dd702f92f4cbb519516f455b2"
ztaskWoistKangsKochbuch.Name = "Wo ist Kang's Kochbuch?"
ztaskWoistKangsKochbuch.CorrectState = "None"
ztaskWoistKangsKochbuch.Description = [[
Der Exot hatte das Kochbuch noch, als er vom ZOB/UFO nach Hause telefoniert hat.<BR>
<BR>
HINT: Fpuhur ovaqra anur Frpuf]]
ztaskWoistKangsKochbuch.Visible = true
ztaskWoistKangsKochbuch.Active = false
ztaskWoistKangsKochbuch.Complete = false
ztaskWoistKangsKochbuch.Media = zmediaKang
ztaskZurueckzurFeuerwehr = Wherigo.ZTask(cartGhostbusters)
ztaskZurueckzurFeuerwehr.Id = "e5b438c04227c88b1e56933b0bf3d787"
ztaskZurueckzurFeuerwehr.Name = "Zurueck zur Feuerwehr"
ztaskZurueckzurFeuerwehr.CorrectState = "None"
ztaskZurueckzurFeuerwehr.Description = WWB_multiplatform_string("Geht erstmal zur\195\188ck zur Feuerwehr")
ztaskZurueckzurFeuerwehr.Visible = true
ztaskZurueckzurFeuerwehr.Active = false
ztaskZurueckzurFeuerwehr.Complete = false
ztaskZurueckzurFeuerwehr.Media = zmediaZoneFeuerwehr
WWB_device = nil
var_AlterEgo = ""
var_Architekten = ""
var_bahnhof = 0
var_bahnsteig = ""
var_Barbier = ""
var_defekteFalle = 0
var_Ecto = "0"
var_EctoVar = 0
var_Final = ""
var_Friedhof = 0
var_Friseur = 0
var_Gozer = ""
var_iphone = 0
var_KangBuch = "Nein"
var_Louis = 0
var_Parkdeck = 0
var_Pestjahr = 0
var_Pirat = 0
var_PiratAntwort = ""
var_ProtoDefekt = ""
var_Rittermotto = ""
var_RitterSiegelTeil = 0
var_Schatten = 0
var_Slimer = 0
var_story = 0
var_storymain = 0
var_Tempel = 0
var_timerSchatten = 90
var_timerSchattenBasis = 90
var_UFO = 0
var_volleFalle = 0
var_xFalle = 3
var_youName = "Winston"
cartGhostbusters.ZVariables = {
  WWB_device = nil,
  var_AlterEgo = "",
  var_Architekten = "",
  var_bahnhof = 0,
  var_bahnsteig = "",
  var_Barbier = "",
  var_defekteFalle = 0,
  var_Ecto = "0",
  var_EctoVar = 0,
  var_Final = "",
  var_Friedhof = 0,
  var_Friseur = 0,
  var_Gozer = "",
  var_iphone = 0,
  var_KangBuch = "Nein",
  var_Louis = 0,
  var_Parkdeck = 0,
  var_Pestjahr = 0,
  var_Pirat = 0,
  var_PiratAntwort = "",
  var_ProtoDefekt = "",
  var_Rittermotto = "",
  var_RitterSiegelTeil = 0,
  var_Schatten = 0,
  var_Slimer = 0,
  var_story = 0,
  var_storymain = 0,
  var_Tempel = 0,
  var_timerSchatten = 90,
  var_timerSchattenBasis = 90,
  var_UFO = 0,
  var_volleFalle = 0,
  var_xFalle = 3,
  var_youName = "Winston"
}
buildervar = {}
buildervar.var_AlterEgo = {}
buildervar.var_AlterEgo.Id = "32a609ab6c7cd2a6c2ecd65315d7e371"
buildervar.var_AlterEgo.Name = "AlterEgo"
buildervar.var_AlterEgo.Type = "String"
buildervar.var_AlterEgo.Data = ""
buildervar.var_Architekten = {}
buildervar.var_Architekten.Id = "ecc7dbf9a40fd7e0f34c682c8fb49408"
buildervar.var_Architekten.Name = "Architekten"
buildervar.var_Architekten.Type = "String"
buildervar.var_Architekten.Data = ""
buildervar.var_bahnhof = {}
buildervar.var_bahnhof.Id = "244ac99d248fb03f4277d0c76031c8f4"
buildervar.var_bahnhof.Name = "bahnhof"
buildervar.var_bahnhof.Type = "Number"
buildervar.var_bahnhof.Data = "0"
buildervar.var_bahnsteig = {}
buildervar.var_bahnsteig.Id = "d4230cd1769c9daa17af4400e1609da2"
buildervar.var_bahnsteig.Name = "bahnsteig"
buildervar.var_bahnsteig.Type = "String"
buildervar.var_bahnsteig.Data = ""
buildervar.var_Barbier = {}
buildervar.var_Barbier.Id = "7653fafe2dbaff6164f1c8d56c73ced6"
buildervar.var_Barbier.Name = "Barbier"
buildervar.var_Barbier.Type = "String"
buildervar.var_Barbier.Data = ""
buildervar.var_defekteFalle = {}
buildervar.var_defekteFalle.Id = "527ee8dd6b89898f1aa889a08f7c97ea"
buildervar.var_defekteFalle.Name = "defekteFalle"
buildervar.var_defekteFalle.Type = "Number"
buildervar.var_defekteFalle.Data = "0"
buildervar.var_Ecto = {}
buildervar.var_Ecto.Id = "714bccc3a28640865e43d6b8657c64bc"
buildervar.var_Ecto.Name = "Ecto"
buildervar.var_Ecto.Type = "String"
buildervar.var_Ecto.Data = "0"
buildervar.var_EctoVar = {}
buildervar.var_EctoVar.Id = "367143043854b5273921226bbd8b7ee4"
buildervar.var_EctoVar.Name = "EctoVar"
buildervar.var_EctoVar.Type = "Number"
buildervar.var_EctoVar.Data = "0"
buildervar.var_Final = {}
buildervar.var_Final.Id = "a55bbf5a0be2a293697ffb489189b1a4"
buildervar.var_Final.Name = "Final"
buildervar.var_Final.Type = "String"
buildervar.var_Final.Data = ""
buildervar.var_Friedhof = {}
buildervar.var_Friedhof.Id = "39fb98f3e7503aa904d38004c4a4e87d"
buildervar.var_Friedhof.Name = "Friedhof"
buildervar.var_Friedhof.Type = "Number"
buildervar.var_Friedhof.Data = "0"
buildervar.var_Friseur = {}
buildervar.var_Friseur.Id = "8299955c726f834203128f7219f03347"
buildervar.var_Friseur.Name = "Friseur"
buildervar.var_Friseur.Type = "Number"
buildervar.var_Friseur.Data = "0"
buildervar.var_Gozer = {}
buildervar.var_Gozer.Id = "86e24ad06e66a24f32193c23c3622c7c"
buildervar.var_Gozer.Name = "Gozer"
buildervar.var_Gozer.Type = "String"
buildervar.var_Gozer.Data = ""
buildervar.var_iphone = {}
buildervar.var_iphone.Id = "af90a7f4661b754b52efbbd37330c366"
buildervar.var_iphone.Name = "iphone"
buildervar.var_iphone.Type = "Number"
buildervar.var_iphone.Data = "0"
buildervar.var_KangBuch = {}
buildervar.var_KangBuch.Id = "5bc747dbe0f38cd1dbf24032ce729344"
buildervar.var_KangBuch.Name = "KangBuch"
buildervar.var_KangBuch.Type = "String"
buildervar.var_KangBuch.Data = "Nein"
buildervar.var_Louis = {}
buildervar.var_Louis.Id = "aaeed9d2e8db15b87ddeb2b664c4f249"
buildervar.var_Louis.Name = "Louis"
buildervar.var_Louis.Type = "Number"
buildervar.var_Louis.Data = "0"
buildervar.var_Parkdeck = {}
buildervar.var_Parkdeck.Id = "6e343e28259fd0149d3829ff3c7c2641"
buildervar.var_Parkdeck.Name = "Parkdeck"
buildervar.var_Parkdeck.Type = "Number"
buildervar.var_Parkdeck.Data = "0"
buildervar.var_Pestjahr = {}
buildervar.var_Pestjahr.Id = "961f758787d57e7d7e5185107283ed7b"
buildervar.var_Pestjahr.Name = "Pestjahr"
buildervar.var_Pestjahr.Type = "Number"
buildervar.var_Pestjahr.Data = "0"
buildervar.var_Pirat = {}
buildervar.var_Pirat.Id = "2fc190a97fb2457a7f840cb3b47513ef"
buildervar.var_Pirat.Name = "Pirat"
buildervar.var_Pirat.Type = "Number"
buildervar.var_Pirat.Data = "0"
buildervar.var_PiratAntwort = {}
buildervar.var_PiratAntwort.Id = "1cbc0c0c0911d5f2b680b7a57f751863"
buildervar.var_PiratAntwort.Name = "PiratAntwort"
buildervar.var_PiratAntwort.Type = "String"
buildervar.var_PiratAntwort.Data = ""
buildervar.var_ProtoDefekt = {}
buildervar.var_ProtoDefekt.Id = "439c924ca4eabae43aa9df1cfda48fc9"
buildervar.var_ProtoDefekt.Name = "ProtoDefekt"
buildervar.var_ProtoDefekt.Type = "String"
buildervar.var_ProtoDefekt.Data = ""
buildervar.var_Rittermotto = {}
buildervar.var_Rittermotto.Id = "4d459d913daccdff65b9e5e1d112c397"
buildervar.var_Rittermotto.Name = "Rittermotto"
buildervar.var_Rittermotto.Type = "String"
buildervar.var_Rittermotto.Data = ""
buildervar.var_RitterSiegelTeil = {}
buildervar.var_RitterSiegelTeil.Id = "a3205eb50c2cf75e01e01d6d84a10d08"
buildervar.var_RitterSiegelTeil.Name = "RitterSiegelTeil"
buildervar.var_RitterSiegelTeil.Type = "Number"
buildervar.var_RitterSiegelTeil.Data = "0"
buildervar.var_Schatten = {}
buildervar.var_Schatten.Id = "ac99163fbfd947113903e4e740bea057"
buildervar.var_Schatten.Name = "Schatten"
buildervar.var_Schatten.Type = "Number"
buildervar.var_Schatten.Data = "0"
buildervar.var_Slimer = {}
buildervar.var_Slimer.Id = "24741e18da378e12dc4cf1734d3d0f69"
buildervar.var_Slimer.Name = "Slimer"
buildervar.var_Slimer.Type = "Number"
buildervar.var_Slimer.Data = "0"
buildervar.var_story = {}
buildervar.var_story.Id = "7d36d78dc784f5f80fcfe11bb7fca41f"
buildervar.var_story.Name = "story"
buildervar.var_story.Type = "Number"
buildervar.var_story.Data = "0"
buildervar.var_storymain = {}
buildervar.var_storymain.Id = "765cad30b34495c389a80b238274cca1"
buildervar.var_storymain.Name = "storymain"
buildervar.var_storymain.Type = "Number"
buildervar.var_storymain.Data = "0"
buildervar.var_Tempel = {}
buildervar.var_Tempel.Id = "82695a90657f08e5ecb4ea52d72e7d9f"
buildervar.var_Tempel.Name = "Tempel"
buildervar.var_Tempel.Type = "Number"
buildervar.var_Tempel.Data = "0"
buildervar.var_timerSchatten = {}
buildervar.var_timerSchatten.Id = "7c8bae1993d093767d37e1b85d692f13"
buildervar.var_timerSchatten.Name = "timerSchatten"
buildervar.var_timerSchatten.Type = "Number"
buildervar.var_timerSchatten.Data = "90"
buildervar.var_timerSchattenBasis = {}
buildervar.var_timerSchattenBasis.Id = "6d54dfba473dc1165265e7f43e6ec265"
buildervar.var_timerSchattenBasis.Name = "timerSchattenBasis"
buildervar.var_timerSchattenBasis.Type = "Number"
buildervar.var_timerSchattenBasis.Data = "90"
buildervar.var_UFO = {}
buildervar.var_UFO.Id = "a2193158efac60d81636f3382e3c2a22"
buildervar.var_UFO.Name = "UFO"
buildervar.var_UFO.Type = "Number"
buildervar.var_UFO.Data = "0"
buildervar.var_volleFalle = {}
buildervar.var_volleFalle.Id = "0aa9a0b832fa75d197635215c7f552a9"
buildervar.var_volleFalle.Name = "volleFalle"
buildervar.var_volleFalle.Type = "Number"
buildervar.var_volleFalle.Data = "0"
buildervar.var_xFalle = {}
buildervar.var_xFalle.Id = "3b41171065aaffebc76db2708c508646"
buildervar.var_xFalle.Name = "xFalle"
buildervar.var_xFalle.Type = "Number"
buildervar.var_xFalle.Data = "3"
buildervar.var_youName = {}
buildervar.var_youName.Id = "b6c9e3664c957feb05e3c73b2c89618e"
buildervar.var_youName.Name = "youName"
buildervar.var_youName.Type = "String"
buildervar.var_youName.Data = "Winston"
ztimerbahnhof = Wherigo.ZTimer(cartGhostbusters)
ztimerbahnhof.Id = "b910623ddd46cebb1e6ba2ad8f98e93c"
ztimerbahnhof.Name = "bahnhof"
ztimerbahnhof.Type = "Countdown"
ztimerbahnhof.Visible = false
ztimerbahnhof.Duration = 25
ztimerSchatten = Wherigo.ZTimer(cartGhostbusters)
ztimerSchatten.Id = "13a57011d2cd30cfe8cfa88f1421a487"
ztimerSchatten.Name = "Schatten"
ztimerSchatten.Type = "Countdown"
ztimerSchatten.Visible = false
ztimerSchatten.Duration = 90
ztimerSchatten.Media = zmediaTrapMalfunction
ztimerSchattenWarn1 = Wherigo.ZTimer(cartGhostbusters)
ztimerSchattenWarn1.Id = "5f3c66203179b6e622839a105d922990"
ztimerSchattenWarn1.Name = "SchattenWarn1"
ztimerSchattenWarn1.Type = "Interval"
ztimerSchattenWarn1.Visible = false
ztimerSchattenWarn1.Duration = 1
ztimerSchattenWarn1.Media = zmediaTrapMalfunction
ztimerSchattenWarn3 = Wherigo.ZTimer(cartGhostbusters)
ztimerSchattenWarn3.Id = "f8a26212d393553549c3a6832fb1a1a8"
ztimerSchattenWarn3.Name = "SchattenWarn3"
ztimerSchattenWarn3.Type = "Interval"
ztimerSchattenWarn3.Visible = false
ztimerSchattenWarn3.Duration = 3
ztimerSchattenWarn3.Media = zmediaTrapMalfunction
ztimerSchattenWarn5 = Wherigo.ZTimer(cartGhostbusters)
ztimerSchattenWarn5.Id = "102bb72408dc3dabeaa4353a37398317"
ztimerSchattenWarn5.Name = "SchattenWarn5"
ztimerSchattenWarn5.Type = "Interval"
ztimerSchattenWarn5.Visible = false
ztimerSchattenWarn5.Duration = 5
ztimerSchattenWarn5.Media = zmediaTrapMalfunction
ztimerSchattenWarnBack = Wherigo.ZTimer(cartGhostbusters)
ztimerSchattenWarnBack.Id = "104d2dcc9fe2d89278bad68bdfe3be9d"
ztimerSchattenWarnBack.Name = "SchattenWarnBack"
ztimerSchattenWarnBack.Type = "Interval"
ztimerSchattenWarnBack.Visible = false
ztimerSchattenWarnBack.Duration = 1
ztimerTempel = Wherigo.ZTimer(cartGhostbusters)
ztimerTempel.Id = "b1866ec886da34acea6c43ae93b80091"
ztimerTempel.Name = "Tempel"
ztimerTempel.Type = "Interval"
ztimerTempel.Visible = false
ztimerTempel.Duration = 1
ztimerZOB = Wherigo.ZTimer(cartGhostbusters)
ztimerZOB.Id = "649ec295f4035903892909262c16d471"
ztimerZOB.Name = "ZOB"
ztimerZOB.Type = "Interval"
ztimerZOB.Visible = false
ztimerZOB.Duration = 60
zinputAlterEgo = Wherigo.ZInput(cartGhostbusters)
zinputAlterEgo.Id = "2513e32a22f14a1963c2d5200a3e41c7"
zinputAlterEgo.Name = "AlterEgo"
zinputAlterEgo.InputType = "MultipleChoice"
zinputAlterEgo.Choices = {
  "Winston",
  "Frau",
  "Mann"
}
zinputAlterEgo.Text = WWB_multiplatform_string("W\195\164hle deine Spielfigur")
zinputAlterEgo.Visible = true
zinputAlterEgo.InputVariableId = "32a609ab6c7cd2a6c2ecd65315d7e371"
zinputAlterEgo.Media = zmediaYouChoice
zinputArchitekten = Wherigo.ZInput(cartGhostbusters)
zinputArchitekten.Id = "4bf2c1b2955747a850d92b9c9c05f98d"
zinputArchitekten.Name = "Architekten"
zinputArchitekten.InputType = "Text"
zinputArchitekten.Text = "Architekten? Ich glaube im Bereich des Entree war da was!"
zinputArchitekten.Visible = false
zinputArchitekten.InputVariableId = "ecc7dbf9a40fd7e0f34c682c8fb49408"
zinputArchitekten.Media = zmediaDana
zinputBahnhof = Wherigo.ZInput(cartGhostbusters)
zinputBahnhof.Id = "6726aede823d2ad4c5dbd6f0d6ee0eb7"
zinputBahnhof.Name = "Bahnhof"
zinputBahnhof.InputType = "Text"
zinputBahnhof.Text = [[
HA! Ich bin mir sicher was hier nicht stimmt!<BR>
Das erinnert mich glatt an diesen Zaubererjungen mit Brille und Narbe auf der Stirn, wie der zu seiner Schule wollte.<BR>
Auch hier fehlt was! Seht ihr es auch?]]
zinputBahnhof.Visible = false
zinputBahnhof.InputVariableId = "d4230cd1769c9daa17af4400e1609da2"
zinputBahnhof.Media = zmediaRayDialog
zinputBarbier = Wherigo.ZInput(cartGhostbusters)
zinputBarbier.Id = "59c413798fb91d3b53197a3f3f139edf"
zinputBarbier.Name = "Barbier"
zinputBarbier.InputType = "Text"
zinputBarbier.Text = "Ich komme nicht darauf... Wie nennt man einen Friseur noch? Es liegt mir auf der Zunge!"
zinputBarbier.Visible = false
zinputBarbier.InputVariableId = "7653fafe2dbaff6164f1c8d56c73ced6"
zinputBarbier.Media = zmediaEdward
zinputEctoSchild = Wherigo.ZInput(cartGhostbusters)
zinputEctoSchild.Id = "e7f5459aae6869ff4ee11fd490ce7a23"
zinputEctoSchild.Name = "EctoSchild"
zinputEctoSchild.InputType = "Text"
zinputEctoSchild.Text = WWB_multiplatform_string("Wo ist das Nummerschild nur hingefallen? Vorher k\195\182nnen wir nicht weiter!<BR>\nUnd was steht da eigentlich drauf?")
zinputEctoSchild.Visible = false
zinputEctoSchild.InputVariableId = "714bccc3a28640865e43d6b8657c64bc"
zinputEctoSchild.Media = zmediaEcto1
zinputFinal = Wherigo.ZInput(cartGhostbusters)
zinputFinal.Id = "a28d962f77a975c1030b44be897c729e"
zinputFinal.Name = "Final"
zinputFinal.InputType = "Text"
zinputFinal.Text = "Gebe den Finalcode ein (auf dem Logbuch)"
zinputFinal.Visible = false
zinputFinal.InputVariableId = "a55bbf5a0be2a293697ffb489189b1a4"
zinputFinal.Media = zmediaKey
zinputGozer = Wherigo.ZInput(cartGhostbusters)
zinputGozer.Id = "d96757640a99f5590d7012f8ed3a7af4"
zinputGozer.Name = "Gozer"
zinputGozer.InputType = "MultipleChoice"
zinputGozer.Choices = {"Ja", "Nein"}
zinputGozer.Text = "BIST DU EIN GOTT?"
zinputGozer.Visible = false
zinputGozer.InputVariableId = "86e24ad06e66a24f32193c23c3622c7c"
zinputGozer.Media = zmediaGozer
zinputKang = Wherigo.ZInput(cartGhostbusters)
zinputKang.Id = "3070b8dbb0b694207b5d075c4fe8ed61"
zinputKang.Name = "Kang"
zinputKang.InputType = "MultipleChoice"
zinputKang.Choices = {"Ja", "Nein"}
zinputKang.Text = "Habt ihr mein geliebtes Kochbuch gefunden? Die notierten Rezepte sind unersetzlich!"
zinputKang.Visible = false
zinputKang.InputVariableId = "5bc747dbe0f38cd1dbf24032ce729344"
zinputKang.Media = zmediaKang
zinputLouis = Wherigo.ZInput(cartGhostbusters)
zinputLouis.Id = "68be849d5c913c4cb1c161a4c29995b7"
zinputLouis.Name = "Louis"
zinputLouis.InputType = "Text"
zinputLouis.Text = WWB_multiplatform_string("Normal kosten f\195\188nf Liter KRABBEL-EX netto 180, aber ich kann euch den Liter f\195\188r 27 netto geben! Prozentual sind das... na? Wieviel Pozent Ersparnis?")
zinputLouis.Visible = false
zinputLouis.InputVariableId = "aaeed9d2e8db15b87ddeb2b664c4f249"
zinputLouis.Media = zmediaLouis
zinputPestjahr = Wherigo.ZInput(cartGhostbusters)
zinputPestjahr.Id = "bbcf50d475b300d9b6e465f489305e45"
zinputPestjahr.Name = "Pestjahr"
zinputPestjahr.InputType = "Text"
zinputPestjahr.Text = "Wann? Wann kam der Schwarze Tod?"
zinputPestjahr.Visible = false
zinputPestjahr.InputVariableId = "961f758787d57e7d7e5185107283ed7b"
zinputPestjahr.Media = zmediaAngel_open
zinputPirat1 = Wherigo.ZInput(cartGhostbusters)
zinputPirat1.Id = "893d6068ea9d1cce8be0e8cfe6d92340"
zinputPirat1.Name = "Pirat1"
zinputPirat1.InputType = "MultipleChoice"
zinputPirat1.Choices = {
  "Antwort-A",
  "Antwort-B",
  "Antwort-C"
}
zinputPirat1.Text = WWB_multiplatform_string("Arrr, jemals auf hoher See gewesen und Kaventsm\195\164nner \195\188berstanden, du S\195\188sswassermatrose?<BR>\n-<BR>\nAntwort A<BR>\nHaushohe Brecher sind mein Zuhause und saufen tu ich Meerwasser!<BR>\n-<BR>\nAntwort B<BR>\nAuch auf Seen gibt es Wellen und ich hab den Schein \"SBF Binnen\".<BR>\n-<BR>\nAntwort C<BR>\nBei der Neptunstaufe war ich voller Tran und kurz darauf umsegelten wir das Kap, du Deckschrubber!")
zinputPirat1.Visible = false
zinputPirat1.InputVariableId = "1cbc0c0c0911d5f2b680b7a57f751863"
zinputPirat1.Media = zmediaCaptain
zinputPirat2 = Wherigo.ZInput(cartGhostbusters)
zinputPirat2.Id = "39f2e07f597e0cdb7039128f5f82b23c"
zinputPirat2.Name = "Pirat2"
zinputPirat2.InputType = "MultipleChoice"
zinputPirat2.Choices = {
  "Antwort-A",
  "Antwort-B",
  "Antwort-C"
}
zinputPirat2.Text = WWB_multiplatform_string("Arrr, der Seegang liegt mir so im Blut, dass ich auf See gerade geh und an Land torkel!<BR>\n-<BR>\nAntwort A<BR>\nDir liegt h\195\182chstens Rum im Blut und das Torkeln kommt vom Suff!<BR>\n-<BR>\nAntwort B<BR>\nIm Tsunami \195\188berschlug sich unser Schiff, doch meine Beine standen fest an Deck.<BR>\n-<BR>\nAntwort C<BR>\nIch \195\188be t\195\164glich in der Schiffschaukel, aber mir wird immer noch \195\188bel.")
zinputPirat2.Visible = false
zinputPirat2.InputVariableId = "1cbc0c0c0911d5f2b680b7a57f751863"
zinputPirat2.Media = zmediaCaptain
zinputPirat3 = Wherigo.ZInput(cartGhostbusters)
zinputPirat3.Id = "7aa8003b4ed9ca6af84285fce5884f04"
zinputPirat3.Name = "Pirat3"
zinputPirat3.InputType = "MultipleChoice"
zinputPirat3.Choices = {
  "Antwort-A",
  "Antwort-B",
  "Antwort-C"
}
zinputPirat3.Text = WWB_multiplatform_string("Arrr, ein echter Seemann hat in jedem Hafen eine Braut und Seeungeheuer nennen ihn beim Namen.<BR>\n-<BR>\nAntwort A<BR>\nDas einzige Meermonster bist du und Frauen m\195\182gen keinen toten Fisch.<BR>\n-<BR>\nAntwort B<BR>\nSeeungeheuer gibt es doch gar nicht... oder etwa doch?<BR>\n-<BR>\nAntwort C<BR>\nAus Riesenkraken mach ich Calamares und Weiber liegen mir zu F\195\188ssen.")
zinputPirat3.Visible = false
zinputPirat3.InputVariableId = "1cbc0c0c0911d5f2b680b7a57f751863"
zinputPirat3.Media = zmediaCaptain
zinputPiratIphone1 = Wherigo.ZInput(cartGhostbusters)
zinputPiratIphone1.Id = "42e142f0e72849fd082f161c786f9f75"
zinputPiratIphone1.Name = "PiratIphone1"
zinputPiratIphone1.InputType = "MultipleChoice"
zinputPiratIphone1.Choices = {
  "Antwort-A",
  "Antwort-B",
  "Antwort-C"
}
zinputPiratIphone1.Text = ""
zinputPiratIphone1.Visible = false
zinputPiratIphone1.InputVariableId = "1cbc0c0c0911d5f2b680b7a57f751863"
zinputPiratIphone1.Media = zmediaAlterEgo
zinputPiratIphone2 = Wherigo.ZInput(cartGhostbusters)
zinputPiratIphone2.Id = "4befa20b8d613fe84667d57aeba806f4"
zinputPiratIphone2.Name = "PiratIphone2"
zinputPiratIphone2.InputType = "MultipleChoice"
zinputPiratIphone2.Choices = {
  "Antwort-A",
  "Antwort-B",
  "Antwort-C"
}
zinputPiratIphone2.Text = ""
zinputPiratIphone2.Visible = false
zinputPiratIphone2.InputVariableId = "1cbc0c0c0911d5f2b680b7a57f751863"
zinputPiratIphone2.Media = zmediaAlterEgo
zinputPiratIphone3 = Wherigo.ZInput(cartGhostbusters)
zinputPiratIphone3.Id = "741952bdf2c6decd8a07eec8b91670d1"
zinputPiratIphone3.Name = "PiratIphone3"
zinputPiratIphone3.InputType = "MultipleChoice"
zinputPiratIphone3.Choices = {
  "Antwort-A",
  "Antwort-B",
  "Antwort-C"
}
zinputPiratIphone3.Text = ""
zinputPiratIphone3.Visible = false
zinputPiratIphone3.InputVariableId = "1cbc0c0c0911d5f2b680b7a57f751863"
zinputPiratIphone3.Media = zmediaAlterEgo
zinputProtoRep = Wherigo.ZInput(cartGhostbusters)
zinputProtoRep.Id = "e43d1acd2d2f1f57eef0300e053c74d6"
zinputProtoRep.Name = "ProtoRep"
zinputProtoRep.InputType = "Text"
zinputProtoRep.Text = WWB_multiplatform_string("Gelb kommt an eine ungrade Zahl und kreuzt sich mit Rot. Nur Weiss &amp;&amp; Gr\195\188n verlaufen parallel. Blau hat die k\195\188rzeste Verbindung.<BR>\nZur Kontrolle sag mir die Reihenfolge der Buchstaben an, abgehend vom 1.-6. Kabel.")
zinputProtoRep.Visible = false
zinputProtoRep.InputVariableId = "439c924ca4eabae43aa9df1cfda48fc9"
zinputProtoRep.Media = zmediaProtoPack
zinputRittermotto = Wherigo.ZInput(cartGhostbusters)
zinputRittermotto.Id = "4a5d265ec774bb62cb132b6c34ed2f22"
zinputRittermotto.Name = "Rittermotto"
zinputRittermotto.InputType = "Text"
zinputRittermotto.Text = WWB_multiplatform_string("Nun denn, edle Recken, habt ihr mein Siegel auffinden k\195\182nnen? Zeigt her, welcher Leitspruch ist darauf notiert?")
zinputRittermotto.Visible = false
zinputRittermotto.InputVariableId = "4d459d913daccdff65b9e5e1d112c397"
zinputRittermotto.Media = zmediaRitter
zinputyouName = Wherigo.ZInput(cartGhostbusters)
zinputyouName.Id = "90b0bdb91a300a08a73835379bd407b1"
zinputyouName.Name = "youName"
zinputyouName.InputType = "Text"
zinputyouName.Text = "Wie ist dein Name?"
zinputyouName.Visible = true
zinputyouName.InputVariableId = "b6c9e3664c957feb05e3c73b2c89618e"
zinputyouName.Media = zmediaYouChoice
zcharacterEgon.Commands.Reden.WorksWithList = {}
zcharacterPeter.Commands.Reden.WorksWithList = {}
function cartGhostbusters:OnStart()
  Player.CompletionCode15 = Player.CompletionCode:sub(1, 15)
  Wherigo.PlayAudio(zmediaSoundTitle)
  zitemFalle.Description = WWB_multiplatform_string("Da sind " .. var_xFalle .. " ungebrauchte Fallen.")
  if string.sub(Env.Platform, 1, 6) == "iPhone" then
    var_iphone = 1
  end
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("BITTE:<BR>\nSeid sehr vorsichtig bei den Stationen, die Gegend ist extrem belebt &amp;&amp; muggelig!<BR>\nPAL-Feld!!!<BR>\nGeht sicher, das die Stationen wieder gut versteckt sind!<BR>\n<BR>\nBehaltet das Ger\195\164t immer im Auge, wer weiss, was so passiert! ;)<BR>\n<BR>\nBeim Spielen viel Geduld aufbringen, gerade der Gamin Beta-Player ist nicht der Schnellste - also ein paar Sekunden warten nach Eingabe!<BR>\nUnn\195\182tiges Rumgedr\195\188cke bringt den Player schnell zum Absturz!<BR>\n<BR>\nEin besonderer Dank geht an Dean von SpringfieldPunx.blogspot.com f\195\188r einen gro\195\159en Teil der Grafiken.", {PocketPC = 1}),
    Media = zmediaTitle,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB1
  })
  WWB_noemul(cartGhostbusters, WWB_multiplatform_string("Der Author dieser Cartridge m\195\182chte nicht, dass diese im Emulator gespielt wird"))
end
function cartGhostbusters:OnRestore()
  Wherigo.PlayAudio(zmediaSoundTitle)
  if Wherigo.NoCaseEquals(var_AlterEgo, "Frau") then
    zmediaAlterEgo = zmediaYouFemale
  end
  if Wherigo.NoCaseEquals(var_AlterEgo, "Mann") then
    zmediaAlterEgo = zmediaYouMale
  end
end
function ztaskFindediealteFeuerwehr:OnSetCorrectState()
  ztaskFindediealteFeuerwehr.Visible = false
end
function ztimerbahnhof:OnTick()
  Wherigo.GetInput(zinputBahnhof)
  cartGhostbusters:RequestSync()
end
function ztimerSchatten:OnTick()
  ztimerSchattenWarn5:Stop()
  ztimerSchattenWarn3:Stop()
  ztimerSchattenWarn1:Stop()
  ztimerSchattenWarnBack:Stop()
  if ztimerSchatten.Duration <= 90 then
    Wherigo.Dialog({
      {
        Text = "AAAHH! DER SCHATTEN BRICHT AUS DER FALLE AUS!",
        Media = zmediaSchatten
      },
      {
        Text = "Flupp, weg ist er... &nbsp;wo ist er hin?",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Ich nehm an zur\195\188ck zur Videothek."),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Bedeutet wir m\195\188ssen wieder hin und den Schatten erneut fangen?"),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Ja! Ich bef\195\188rchte allerdings, das seine psychokinetische Energie irgendwie die Falle sprengt. Wir m\195\188ssen uns also beeilen, auch wenn seine Kraft wohl nachl\195\164sst und wir ein paar Sekunden mehr haben."),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Egon, wir sollten hiernach mal die Fallen \195\188berarbeiten. Wir brauchen \"Mehr Power\"!"),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Du meinst, ICH soll die Fallen \195\188berarbeiten!"),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Egon, du bist eben der Heimwerkerk\195\182nig. Die Technik ist deine Disziplin, meine ist mehr die Promotion. Wichtigen Leuten die H\195\164nde sch\195\188tteln und so..."),
        Media = zmediaPeterDialog
      },
      {
        Text = "Dann sollte ich eventuell auch eine eigene Fernsehsendung bekommen und du bist dann mein HiWi Peter...",
        Media = zmediaEgonDialog
      },
      {
        Text = "Legen wir uns dann Pseudonyme zu? Ich bin dann Al und du bist Tim?",
        Media = zmediaPeterDialog
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Wieder nicht! Aber er wird jedesmal schw\195\164cher!"),
        Media = zmediaEgonDialog
      },
      {
        Text = "Na, wenn du es meinst...",
        Media = zmediaAlterEgo
      }
    })
  end
  var_timerSchattenBasis = var_timerSchattenBasis + 15
  ztimerSchatten.Duration = var_timerSchattenBasis
  var_timerSchatten = var_timerSchattenBasis
  Fallekaputt("1")
  ztaskFalleueberlastet.Active = false
  ztaskDieVideothek.Active = true
  ztaskDieVideothek.Complete = false
  ztaskDieVideothek.Visible = true
  zoneVideothek.Visible = true
  zcharacterSchatten.Visible = true
end
function ztimerSchatten:OnStop()
  ztimerSchattenWarnBack:Stop()
  ztimerSchattenWarn1:Stop()
  ztimerSchattenWarn3:Stop()
  ztimerSchattenWarn5:Stop()
end
function ztimerSchattenWarn1:OnTick()
  Wherigo.PlayAudio(zmediaSoundAlert)
end
function ztimerSchattenWarn3:OnTick()
  Wherigo.PlayAudio(zmediaSoundAlert)
end
function ztimerSchattenWarn5:OnTick()
  Wherigo.PlayAudio(zmediaSoundAlert)
end
function ztimerSchattenWarnBack:OnTick()
  var_timerSchatten = var_timerSchatten - 1
  if var_timerSchatten == 60 then
    Wherigo.MessageBox({Text = "", Media = zmediatimer60})
  end
  if var_timerSchatten == 30 then
    Wherigo.MessageBox({Text = "", Media = zmediatimer30})
  end
  if var_timerSchatten == 20 then
    Wherigo.MessageBox({Text = "", Media = zmediatimer20})
    ztimerSchattenWarn5:Stop()
    ztimerSchattenWarn3:Start()
  end
  if var_timerSchatten == 10 then
    Wherigo.MessageBox({Text = "", Media = zmediatimer10})
    ztimerSchattenWarn3:Stop()
    ztimerSchattenWarn1:Start()
  end
end
function ztimerTempel:OnTick()
  var_Tempel = var_Tempel + 1
  if var_Tempel == 1 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel001})
  end
  if var_Tempel == 2 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel002})
    Wherigo.PlayAudio(zmediaSoundThunder)
  end
  if var_Tempel == 3 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel003})
  end
  if var_Tempel == 4 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel004})
  end
  if var_Tempel == 5 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel005})
  end
  if var_Tempel == 6 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel006})
  end
  if var_Tempel == 7 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel007})
  end
  if var_Tempel == 8 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel008})
    zcharacterDimensionstor.Visible = true
    zcharacterGozer.Visible = true
  end
  if var_Tempel == 9 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel009})
  end
  if var_Tempel == 10 then
    Wherigo.MessageBox({Text = "", Media = zmediatempel010})
    ztaskHaltedensumerischenGottGozerauf.Active = true
  end
  if var_Tempel == 12 then
    ztimerTempel:Stop()
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Es ist ein M\195\164dchen."),
        Media = zmediaRayDialog
      },
      {
        Text = "Es ist Gozer.",
        Media = zmediaEgonDialog
      },
      {
        Text = "Ich dachte Gozer sei ein Mann.",
        Media = zmediaAlterEgo
      },
      {
        Text = "Es war was immer es sein wollte.",
        Media = zmediaEgonDialog
      },
      {
        Text = "Was immer es ist, es muss uns besiegen Jungs!",
        Media = zmediaPeterDialog
      },
      {Text = "Richtig!", Media = zmediaRayDialog},
      {
        Text = "Los! Hol sie dir Ray!",
        Media = zmediaPeterDialog
      }
    })
  end
end
function ztimerZOB:OnTick()
  if zoneZOB.Active == true then
    zoneZOB.Active = false
  else
    zoneZOB.Active = true
  end
end
function ztimerZOB:OnStop()
  zoneZOB.Active = false
end
function zoneAmWasser:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneAmWasser)
  zcharacterPeter:MoveTo(zoneAmWasser)
  zcharacterRay:MoveTo(zoneAmWasser)
  if var_Pirat == 0 then
    Wherigo.Dialog({
      {Text = "Arrrr", Media = zmediaCaptain},
      {
        Text = "Ah, hallo, wie geht's?",
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Mmh, das sind Peter... Egon... " .. var_youName .. "... und ich bin Ray."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Arrr, ich bin Kapit\195\164n McAllister, was wollt ihr Komb\195\188senjungen? Wollt ihr anheuern?"),
        Media = zmediaCaptain
      },
      {
        Text = WWB_multiplatform_string("Oh, wir t\195\164ten nichts lieber als das..."),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Dann m\195\188\195\159t ihr erst beweisen, dass euch Haare auf der Brust wachsen und sprechen k\195\182nnt, wie ein echter Seeman. Arrr!"),
        Media = zmediaCaptain
      }
    })
    var_Pirat = var_Pirat + 1
  end
end
function zoneBahnhof:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneBahnhof)
  zcharacterRay:MoveTo(zoneBahnhof)
  zcharacterPeter:MoveTo(zoneBahnhof)
  if var_bahnhof == 0 then
    Wherigo.MessageBox({
      Text = "Ich seh nichts... Und jetzt?",
      Media = zmediaPeterDialog,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB16
    })
  else
    Wherigo.GetInput(zinputBahnhof)
  end
end
function zoneBahnsteig:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneBahnsteig)
  zcharacterPeter:MoveTo(zoneBahnsteig)
  zcharacterRay:MoveTo(zoneBahnsteig)
  if var_bahnhof == 1 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("H\195\182rt nur! Ich glaube, ich rieche was."),
        Media = zmediaRayDialog
      },
      {
        Text = "tuuuuuut ... tuuuUUUUUTTTT ... TTTUUUUUUTTTTT",
        Media = zmediaGeisterzug
      },
      {
        Text = "Ich... &nbsp;ich glaub es einfach nicht...",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Geisterz\195\188ge sind nicht selten in der einschl\195\164gigen Literatur."),
        Media = zmediaEgonDialog
      },
      {
        Text = "Egon... Danke!",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Pa\195\159t der \195\188berhaupt in die Falle?"),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Die optische Gr\195\182sse spielt nicht die ausschlaggebende Rolle."),
        Media = zmediaEgonDialog
      },
      {
        Text = "Okay, Alle austeigen! Der Zug endet hier!",
        Media = zmediaPeterDialog
      }
    })
    zcharacterGeisterzug.Visible = true
    zoneBahnsteig.Visible = true
    var_bahnhof = var_bahnhof + 1
  end
end
function zoneBruecke:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneBruecke)
  zcharacterPeter:MoveTo(zoneBruecke)
  zcharacterRay:MoveTo(zoneBruecke)
  if ztaskFindedasSiegeldesRitters.Active == true then
  else
    Wherigo.MessageBox({
      Text = "An mir kommt niemand vorbei!",
      Media = zmediaRitter,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB18
    })
  end
end
function zoneFeuerwehr:OnProximity()
  if var_story == 1 then
    zoneFeuerwehr.Visible = true
  end
  if ztaskFalleueberlastet.Active == true then
    ztimerSchattenWarnBack:Stop()
    zitemVolleFalle.Commands.Entladen.Enabled = true
  end
end
function zoneFeuerwehr:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zitemVolleFalle.Commands.Entladen.Enabled = true
  zitemDefekteFalle.Commands.Ersetzten.Enabled = true
  zcharacterRay:MoveTo(zoneFeuerwehr)
  zcharacterPeter:MoveTo(zoneFeuerwehr)
  zcharacterEgon:MoveTo(zoneFeuerwehr)
  cartGhostbusters:RequestSync()
  if ztaskFalleueberlastet.Active == true then
    ztimerSchattenWarnBack:Stop()
  end
  if var_story == 1 then
    zoneFeuerwehr.Visible = true
    ztaskFindediealteFeuerwehr.Complete = true
    ztaskFindediealteFeuerwehr.Visible = false
  end
  if var_story == 4 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ihr m\195\188\195\159t sofort weiter. Zwei neue F\195\164lle.<BR>\nIch funk euch an, sollten sich weitere melden.", {PocketPC = 1}),
      Media = zmediaJanineTask,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB19
    })
  end
  if not (var_story >= 9) or var_storymain ~= 0 or ztaskFalleueberlastet.Active == true then
  else
    Wherigo.Dialog({
      {
        Text = "Hi, da wartet bereits eine Kundin auf euch.",
        Media = zmediaJanine
      },
      {
        Text = WWB_multiplatform_string("Barrett, Dana Barrett.<BR>\nAlso, ich weiss nicht... es ist recht ungew\195\182hnlich..."),
        Media = zmediaDana
      },
      {
        Text = WWB_multiplatform_string("Oh, wir h\195\182ren hier Tag ein, Tag aus ungew\195\182hnliches."),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Ich kam vom Einkaufen... und da war diese Ger\195\164usch. Ich machte den K\195\188hlschrank auf und da war gar nichts! Es war ein weiter Raum und da war ein Geb\195\164ude oder sowas! Es kamen Flammen heraus, Gesch\195\182pfe ringelten sich da und sie knurrten &amp;&amp; zischten!"),
        Media = zmediaDana
      },
      {
        Text = WWB_multiplatform_string("Und diese Stimme sagte ZUUL, dann hab ich die K\195\188hkschrankt\195\188r zugeknallt &amp;&amp; bin weggerannt, das war genau vor zwei Tagen und ich war seitdem nicht mehr in der Wohnung."),
        Media = zmediaDana
      }
    })
    zcharacterDana.Visible = true
    ztaskRedemitDana.Active = true
    var_storymain = var_storymain + 1
  end
  if var_story == 13 and var_storymain == 5 then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Jungs, da jetzt ja gerade etwas Ruhe ist: Ich fahr schnell zum Grundbuchamt und k\195\188mmer mich um die Bauunterlagen von Dana's Apartmenthaus. Bis gleich!"),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Oh, hallo! Habt ihr alle laufenden F\195\164lle erledigt?<BR>\nWas ist denn da los gewesen?"),
        Media = zmediaJanine
      },
      {
        Text = WWB_multiplatform_string("Ich bin mir sicher, da k\195\188ndigt sich etwas Grosses an..."),
        Media = zmediaEgonDialog
      },
      {
        Text = "Wie \"etwas Grosses\"?",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Naja, sagen wir mal dieses Sandt\195\182rtchen hier repr\195\164sentiert die normale psychokinetische Energie im Bereich von L\195\188beck. Laut der letzten Ablesung von heute morgen w\195\188rde das Sandt\195\182rtchen eine L\195\164nge von ungef\195\164hr 10m und sch\195\164tzungsweise ein Gewicht von 600 Pfund haben."),
        Media = zmediaEgonDialog
      },
      {Text = "*hust*", Media = zmediaPeterDialog},
      {
        Text = WWB_multiplatform_string("Das w\195\164r aber ein Sandt\195\182rtchen."),
        Media = zmediaAlterEgo
      },
      {
        Text = "Da ist gerade eben ein Officer gekommen. Am besten spricht einer von euch mal mit dem. Erinnert mich mehr an einen Ranger.",
        Media = zmediaJanine
      }
    })
    ztaskEinOfficerwilleuchsprechen.Active = true
    ztaskZurueckzurFeuerwehr.Active = false
    zcharacterRay.Visible = false
    zcharacterLouis:MoveTo(zoneFeuerwehr)
    zcharacterLouis.Media = zmediaLouisPossesed
    zcharacterLouis.Visible = true
    zcharacterLouis.Commands.Reden.Enabled = false
    zcharacterLouis.Description = WWB_multiplatform_string("Louis Tully, der Nachbar von Dana Barrett. Er wirkt noch komischer als \195\188blich... &nbsp;wenn das \195\188berhaupt m\195\182glich ist.")
    zcharacterOfficerWalker.Visible = true
    var_storymain = var_storymain + 1
  end
end
function zoneFeuerwehr:OnExit()
  if var_story >= 6 and var_EctoVar == 0 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.PlayAudio(zmediaSoundEcto)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Verdammt, wo ist denn das Nummernschild vom Einsatzwagen? Ich meinte doch, das ich was scheppern geh\195\182rt habe, als wir einbogen. Es muss hier irgendwo bei der Auffahrt zur Station abgefallen sein - wir m\195\188ssen es finden!", {PocketPC = 1}),
      Media = zmediaRayDialog,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB20
    })
    zcharacterRay.Commands.Reden.Enabled = true
  end
  if Player:Contains(zitemProtonPack) and Player:Contains(zitemFalle) then
    if var_story == 3 then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Dies ist unser Einsatzfahrzeug, ein umger\195\188steter '59 Cadillac Ambulance - ist der cool oder ist der cool?<BR>\nSpring rein " .. var_youName .. ", heute rauschen wir mal \195\188ber'n paar Rote!", {PocketPC = 1}),
        Media = zmediaEcto1,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB21
      })
    end
  else
    Wherigo.PlayAudio(zmediaSoundAlert)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("STOP! Haben wir nicht was in der Aufregung des ersten Einsatzes vergessen? So f\195\164ngt man aber keine Geister! Zur\195\188ck, Marsch! Proton-Pack &amp;&amp; Fallen mitnehmen!", {PocketPC = 1}),
      Media = zmediaPeterDialog
    })
  end
  if Player:Contains(zitemProtonPack) and not Player:Contains(zitemFalle) then
    Wherigo.PlayAudio(zmediaSoundAlert)
    Wherigo.MessageBox({
      Text = "Mmh... und womit sollen wir das Vieh jetzt fangen? Wir brauchen auch noch die Fallen! Kommando kehrt!",
      Media = zmediaPeterDialog
    })
  end
  if Player:Contains(zitemFalle) and not Player:Contains(zitemProtonPack) then
    Wherigo.PlayAudio(zmediaSoundAlert)
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("He! tststs - mit das Wichtigste in der Zentrale liegen gelassen... Was ist mit dem Proton-Pack? Hopp-Hopp, zur\195\188ck, aber Dalli!", {PocketPC = 1}),
      Media = zmediaPeterDialog
    })
  end
  zitemVolleFalle.Commands.Entladen.Enabled = false
  zitemDefekteFalle.Commands.Ersetzten.Enabled = false
end
function zoneFinal:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Seid leise und euch sicher,<BR>\ndass kein Uneingeweihter sp\195\164ht,<BR>\nhabt den richtigen Riecher,<BR>\nheimlich Ihr nach hinten geht.<BR>\n<BR>\nDer Titan Prometheus stahl Zeus das Feuer, <BR>\nbracht's den sterblichen Mensch auf Erden. <BR>\nIn eben jenem Schein steht das eiserne Gem\195\164uer <BR>\nund keine H\195\182h' muss erklommen werden. <BR>\n<BR>\nEin kleiner Schl\195\188ssel ist versteckt recht nah,<BR>\nan ihm h\195\164ngt auch ein kleines Helferlein,<BR>\nsucht sie hier und sucht sie da,<BR>\nfinden werdet Ihr sie durch's Fenster rein.<BR>\n<BR>\nKeine Gewalt tut Not !!!<BR>\nSelbst ein Kind schafft's ohne beben.<BR>\nEin genauer Blick ist oberstes Gebot,<BR>\ndenn zuerst das Helferlein muss heben.<BR>\n<BR>\nFrei ist der Weg nun endlich,<BR>\ndreht den Schl\195\188ssel nun rechts herum.<BR>\nH\195\182rt nochmal ob keiner n\195\164hert sich,<BR>\ndann \195\182ffnet das Tor ganz stumm.", {PocketPC = 1}),
    Media = zmediathavorianer,
    Buttons = {"Fund"},
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB25
  })
end
function zoneFriedhof:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneFriedhof)
  zcharacterPeter:MoveTo(zoneFriedhof)
  zcharacterRay:MoveTo(zoneFriedhof)
  if var_Friedhof == 0 then
    Wherigo.Dialog({
      {
        Text = "Da! Hinter dem grossen alten Steinkreuz bewegt sich was!",
        Media = zmediaRayDialog
      },
      {
        Text = "Ein Engel! Aus Mamor! Er bewegt sich... obwohl wir ihn angucken...",
        Media = zmediaEgonDialog
      },
      {
        Text = "Ich kann also blinzeln?",
        Media = zmediaPeterDialog
      },
      {
        Text = "Den Wahrheitsgehalt vom Fernsehen sollte man immer anzweifeln.",
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Gehen wir n\195\164her rann"),
        Media = zmediaAlterEgo
      }
    })
    var_Friedhof = var_Friedhof + 1
  end
end
function zoneFriseur:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneFriseur)
  zcharacterPeter:MoveTo(zoneFriseur)
  zcharacterRay:MoveTo(zoneFriseur)
  if var_Friseur == 0 then
    Wherigo.Dialog({
      {
        Text = "Wie war das noch? Ich komm nicht drauf!",
        Media = zmediaEdward
      },
      {
        Text = "Oh! Der sieht aber... zusammengeflickt aus. Wirkt wie ein laufendes Ersatzteilelager.",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Ein k\195\188nstlich erschaffener Mensch - auch Homunculus.<BR>\nOder wohl eher seine Erscheinung."),
        Media = zmediaEgonDialog
      },
      {Text = "hallo...", Media = zmediaEdward},
      {
        Text = "Scheint eigentlich ganz nett zu sein.",
        Media = zmediaRayDialog
      },
      {
        Text = "Ja, klar Ray, so wie die anderen auch?",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Ich suche ein Wort! Es gibt doch ein anderes Wort f\195\188r Friseur! Wie war das noch gleich?"),
        Media = zmediaEdward
      }
    })
    ztaskEinanderesWortfuerFriseur.Active = true
    var_Friseur = var_Friseur + 1
  end
end
function zoneHochhaus:OnProximity()
  if var_storymain == 8 then
    Wherigo.PlayAudio(zmediaSoundAlert)
    Wherigo.Dialog({
      {
        Text = "Zwischenspiel auf dem Dach des Apartmenthauses",
        Media = zmediaZoneHochhaus
      },
      {
        Text = WWB_multiplatform_string("Ich bin der Schl\195\188sselmeister."),
        Media = zmediaLouisPossesed
      },
      {
        Text = WWB_multiplatform_string("Ich bin der Torw\195\164chter."),
        Media = zmediaDanaPossesed
      }
    })
  end
end
function zoneHochhaus:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  if var_storymain == 2 then
    ztaskDasHochhaus.Active = false
    zcharacterDana:MoveTo(zoneHochhaus)
    zcharacterDana.Commands.Reden.Enabled = false
    zcharacterPeter:MoveTo(zoneHochhaus)
    Wherigo.Dialog({
      {
        Text = "So, da vorne ist mein Eckapartment, die 2206.",
        Media = zmediaDana
      },
      {
        Text = WWB_multiplatform_string("Hey Dana! Oh, du schmeisst 'ne Kost\195\188m-Party?"),
        Media = zmediaLouis
      },
      {
        Text = WWB_multiplatform_string("Nein Louis, das sind nur... die... die Kammerj\195\164ger..."),
        Media = zmediaDana
      },
      {
        Text = "Du hast Probleme mit Kakerlaken? Die Zwei sehen aus wie Kosmonauten... Das muss ja ne tolle Kakerlake sein!",
        Media = zmediaLouis
      },
      {
        Text = WWB_multiplatform_string("...w\195\188rde ihnen den Kopf abbeissen, Mann!"),
        Media = zmediaPeterDialog
      },
      {
        Text = [[
*Seufz*<BR>
Darf ich vorstellen, das ist Louis, mein Nachbar.]],
        Media = zmediaDana
      },
      {
        Text = WWB_multiplatform_string("Hey, ich kann euch g\195\188nstig KRABBEL-EX besorgen, wenn ihr wollt!?"),
        Media = zmediaLouis
      }
    })
    ztaskAngebotvonLouis.Active = true
    var_storymain = var_storymain + 1
  end
  if var_storymain == 8 then
    zcharacterEgon:MoveTo(zoneHochhaus)
    zcharacterPeter:MoveTo(zoneHochhaus)
    zcharacterRay:MoveTo(zoneHochhaus)
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Das sieht nicht gut aus! Guckt mal \195\188ber dem Apartmenthaus. Die schwarzen Wolken sind wie ein riesen Mahlstrom mit Blitzen dazwischen!"),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Wir m\195\188ssen hierbei vielleicht doch ein paar \195\156berstunden investieren, Jungs."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("*Etwas sp\195\164ter in Dana's Apartment*"),
        Media = zmediaZoneHochhaus
      },
      {
        Text = WWB_multiplatform_string("Hey, wo f\195\188hren denn diese Stufen hin?"),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Sie f\195\188hren nach oben!"),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Nach den Pl\195\164nen kommt man dort auf's Dach."),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Es sieht aus wie ein Tempel mit Altarstein. Wir m\195\188ssen da hoch!"),
        Media = zmediaRayDialog
      }
    })
    ztaskVerhinderedasZuulundVinzsichtreffen.Active = false
    ztaskGehehochzumTempel.Active = true
    zoneHochhaus.Active = false
    zoneTempel.Active = true
    var_storymain = var_storymain + 1
  end
end
function zoneHotel:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneHotel)
  zcharacterRay:MoveTo(zoneHotel)
  zcharacterPeter:MoveTo(zoneHotel)
  if var_Slimer == 0 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("DA! Ich sehe es!<BR>\nEine h\195\164ssliche, kleine Kartoffel!", {PocketPC = 1}),
      Media = zmediaPeterDialog,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB26
    })
  end
end
function zonePark:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  Wherigo.Dialog({
    {
      Text = "Seht ihr was?",
      Media = zmediaRayDialog
    },
    {
      Text = "Setzt euer Ectosscope auf und blickt euch um!",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("mmmh, gibt es Riesenkaninchen von etwa 2m Gr\195\182\195\159e in Nordeuropa?"),
      Media = zmediaPeterDialog
    },
    {Text = "Wo?", Media = zmediaAlterEgo},
    {
      Text = "Gleich da hinter der Statue!",
      Media = zmediaPeterDialog
    },
    {Text = "Welche?", Media = zmediaRayDialog},
    {
      Text = "Na, da beim Reiter.",
      Media = zmediaPeterDialog
    },
    {
      Text = "Schleichen wir uns an!",
      Media = zmediaAlterEgo
    }
  })
  if var_iphone == 1 then
    zonePark1.Visible = true
    zonePark1.Name = "Park"
    zonePark2.Visible = true
    zonePark2.Name = "Park"
    zonePark3.Visible = true
    zonePark3.Name = "Park"
    zonePark4.Visible = true
    zonePark4.Name = "Park"
    zonePark5.Visible = true
    zonePark5.Name = "Park"
    zonePark6.Visible = true
    zonePark6.Name = "Park"
    zonePark7.Visible = true
    zonePark7.Name = "Park"
    zonePark8.Visible = true
    zonePark8.Name = "Park"
    zonePark9.Visible = true
    zonePark9.Name = "Park"
  end
  zonePark.Active = false
  zonePark1.Active = true
  zonePark1.Name = "Park"
end
function zonePark1:OnEnter()
  Wherigo.Dialog({
    {
      Text = "Verdammt, wo ist er hin? ",
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Habt ihr das auch gesehen?<BR>\nDa kam so ein R\195\188ssel aus seiner Brust raus!"),
      Media = zmediaRayDialog
    },
    {
      Text = "Sah aus wie ein Tentakel aus Wasser...",
      Media = zmediaAlterEgo
    },
    {
      Text = "Und er zeigte in die Richtung, wo er jetzt steht - Richtung Osten.",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Ihm nach! Den kriegen wir, auch wenn er Haken schl\195\164gt!"),
      Media = zmediaPeterDialog
    }
  })
  zonePark1.Active = false
  zonePark2.Active = true
  zonePark2.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark2)
end
function zonePark2:OnEnter()
  Wherigo.MessageBox({
    Text = "Wieder weg!",
    Media = zmediaRayDialog
  })
  zonePark2.Active = false
  zonePark3.Active = true
  zonePark3.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark3)
end
function zonePark3:OnEnter()
  Wherigo.MessageBox({
    Text = "Wieder weg!",
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB27
  })
  zonePark3.Active = false
  zonePark4.Active = true
  zonePark4.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark4)
end
function zonePark4:OnEnter()
  Wherigo.MessageBox({
    Text = "Wieder weg!",
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB27
  })
  zonePark4.Active = false
  zonePark5.Active = true
  zonePark5.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark5)
end
function zonePark5:OnEnter()
  Wherigo.MessageBox({
    Text = "Wieder weg!",
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB27
  })
  zonePark5.Active = false
  zonePark6.Active = true
  zonePark6.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark6)
end
function zonePark6:OnEnter()
  Wherigo.MessageBox({
    Text = "Wieder weg!",
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB27
  })
  zonePark6.Active = false
  zonePark7.Active = true
  zonePark7.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark7)
end
function zonePark7:OnEnter()
  Wherigo.MessageBox({
    Text = "Wieder weg!",
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB27
  })
  zonePark7.Active = false
  zonePark8.Active = true
  zonePark8.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark8)
end
function zonePark8:OnEnter()
  Wherigo.Dialog({
    {
      Text = "Ich glaube wir sollten uns lieber aufteilen.",
      Media = zmediaEgonDialog
    },
    {
      Text = "Guter Gedanke.",
      Media = zmediaRayDialog
    },
    {
      Text = WWB_multiplatform_string("Ja, auf diese Weise k\195\182nnen wir mehr Schaden anrichten..."),
      Media = zmediaPeterDialog
    }
  })
  zonePark8.Active = false
  zonePark9.Active = true
  zcharacterEgon:MoveTo(zonePark9)
  zcharacterPeter:MoveTo(zonePark9)
  zcharacterRay:MoveTo(zonePark9)
  zonePark9.Name = "Park"
  zcharacterLepusUmbra:MoveTo(zonePark9)
end
function zonePark9:OnEnter()
  zcharacterLepusUmbra.Commands.Anpirschen.Enabled = true
end
function zoneParkdeck:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneParkdeck)
  zcharacterPeter:MoveTo(zoneParkdeck)
  zcharacterRay:MoveTo(zoneParkdeck)
  if var_Parkdeck == 0 then
    Wherigo.Dialog({
      {Text = "*zisch*", Media = zmediaFlame},
      {
        Text = WWB_multiplatform_string("Waoh! Der ist nicht zu \195\188bersehen."),
        Media = zmediaAlterEgo
      },
      {
        Text = "Ein Leuchtfeuer des Paranormalen.",
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Perfekt zum Grillen, hat jemand W\195\188rstchen mit?"),
        Media = zmediaPeterDialog
      },
      {
        Text = "Nicht lang reden! Rann an den Speck!",
        Media = zmediaRayDialog
      }
    })
    var_Parkdeck = var_Parkdeck + 1
  end
end
function zoneStart:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  if var_story == 0 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du hast die Stellenanzeige von den Geisterj\195\164gern gesehen. Du brauchst einen Job! Also finde die alte Feuerwehrwache und mach einen guten Eindruck!", {PocketPC = 1}),
      Media = zmediaAlterEgo
    })
    ztaskFindediealteFeuerwehr.Active = true
    var_story = var_story + 1
    cartGhostbusters:RequestSync()
  end
end
function zoneStart:OnExit()
  if var_story == 1 then
    zoneStart.Active = false
  end
end
function zoneTempel:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneTempel)
  zcharacterRay:MoveTo(zoneTempel)
  zcharacterPeter:MoveTo(zoneTempel)
  if var_storymain == 9 then
    Wherigo.MessageBox({
      Text = "*Auf dem Dach stehen Louis &amp;&amp; Dana neben einem Altarstein*",
      Media = zmediatempel001,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB29
    })
    ztaskGehehochzumTempel.Active = false
    var_storymain = var_storymain + 1
  end
end
function zoneUFO:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneUFO)
  zcharacterPeter:MoveTo(zoneUFO)
  zcharacterRay:MoveTo(zoneUFO)
  if var_UFO == 0 then
    Wherigo.Dialog({
      {
        Text = "Hallo Erdlinge!",
        Media = zmediaKang
      },
      {
        Text = "Sind sie eine paranormale Erscheing oder ein extraterrestrischer Besucher?",
        Media = zmediaRayDialog
      },
      {
        Text = "Kein Ausschlag auf dem PKE",
        Media = zmediaEgonAction
      },
      {
        Text = WWB_multiplatform_string("Oh! Entschuldigt!<BR>\nMein Name ist Kang. Meine Schwester Kodos holt sich gerade etwas Naschi f\195\188r die Weiterreise."),
        Media = zmediaKang
      },
      {
        Text = WWB_multiplatform_string("Wir kommen aus einem Sternensytem, welches ihr Rigel nennt, etwas \195\188ber 700 LJ entfernt."),
        Media = zmediaKang
      },
      {
        Text = "Das liegt im Sternbild Orion.",
        Media = zmediaEgonDialog
      },
      {
        Text = "Wir sind auf einer Mission um instabile Planeten zu sprengen.",
        Media = zmediaKang
      },
      {
        Text = WWB_multiplatform_string("\195\132h! Ihr meint aber nicht die ERDE?!"),
        Media = zmediaPeterDialog
      },
      {
        Text = "MUAHA-HARHARHARHARHARHARHAR",
        Media = zmediaKang
      },
      {
        Text = [[
Nein!<BR>
Wir wollten nur kurz auf eurem Planeten zwischenlanden. <BR>
Bombe 20 zickte rum! Ich war das Diskutieren leid und brauchte 'ne Pause.<BR>
Allerdings hab ich mein geliebtes Kochbuch verloren und nun suchen wir hier schon eine ganze Weile.]],
        Media = zmediaKang
      },
      {
        Text = "Sollen wir eventuell suchen helfen?",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Das w\195\164re sehr freundlich! Ich kann mich erinnern, das ich es noch hatte, als ich nach Hause telefoniert habe... &nbsp;meine Mama brauchte unbedingt eines meiner speziellen Rezepte von mir."),
        Media = zmediaKang
      }
    })
    ztaskWoistKangsKochbuch.Active = true
    var_UFO = var_UFO + 1
  end
end
function zoneVideothek:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundEnterZone)
  zcharacterEgon:MoveTo(zoneVideothek)
  zcharacterRay:MoveTo(zoneVideothek)
  zcharacterPeter:MoveTo(zoneVideothek)
  if var_Schatten == 0 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Ach, die Ecke kenn ich doch! Hier war vor Jahren mal die Videothek HELLo gewesen... <BR>\nSpezialit\195\164t: Horror Filme!", {PocketPC = 1}),
      Media = zmediaPeterDialog,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB34
    })
  end
end
function zoneVideothek:OnExit()
  if ztaskFalleueberlastet.Active == true then
    Wherigo.MessageBox({
      Text = [[
LAUFT!!!<BR>
SCHNELL ZUR STATION!<BR>
PASST AUF DEN VERKEHR AUF!!!]],
      Media = zmediaTrapMalfunction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB35
    })
    ProtoAus("1")
    ztimerSchattenWarnBack:Start()
    ztimerSchatten:Start()
    ztimerSchattenWarn5:Start()
  end
end
function zoneZOB:OnProximity()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Kommt euch da vorne beim ZOB nicht auch was komisch vor?<BR>\nEben hatte ich ganz kurz den Eindruck, dass es ein UFO ist... Last uns das mal n\195\164her angucken...", {PocketPC = 1}),
    Media = zmediaRayDialog
  })
  ztimerZOB:Stop()
  zoneUFO.Active = true
end
function zoneZOB:OnEnter()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Kommt euch da vorne beim ZOB nicht auch was komisch vor?<BR>\nEben hatte ich ganz kurz den Eindruck, dass es ein UFO ist... Last uns das mal n\195\164her angucken...", {PocketPC = 1}),
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB36
  })
  ztimerZOB:Stop()
  zoneUFO.Active = true
end
function zcharacterDana:OnReden()
  if var_storymain == 1 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("K\195\182nnen wir bitte zusammen in mein Apartment gehen?", {PocketPC = 1}),
      Media = zmediaDana,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB37
    })
  end
  if var_storymain == 2 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("K\195\182nnen wir bitte zusammen in mein Apartment gehen?", {PocketPC = 1}),
      Media = zmediaDana,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB37
    })
  end
  if var_storymain == 4 then
    Wherigo.GetInput(zinputArchitekten)
  end
end
function zcharacterDimensionstor:OnAngucken()
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Ich hab' eine radikale Idee. Die T\195\188ren schwingen in beide Richtungen. Wir k\195\182nnten den Partikelstrom umkehren, durch das Tor!"),
      Media = zmediaEgonDialog
    },
    {Text = "Wie?", Media = zmediaAlterEgo},
    {
      Text = WWB_multiplatform_string("Wir kreuzen die Str\195\182me!"),
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Entschuldige bitte Egon, du hast doch gesagt das kreuzen der Str\195\182me w\195\164re schlecht."),
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Da ist ohne Zweifel eine klitzekleine Chance, dass wir \195\188berleben."),
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Dieser Job ist eindeutig unterbezahlt. Danach verlange ich eine Gehaltserh\195\182hung."),
      Media = zmediaAlterEgo
    },
    {Text = "Schnell!", Media = zmediaEgonDialog}
  })
  zcharacterDimensionstor.Commands.Angucken.Enabled = false
  zcharacterDimensionstor.Commands.Schiessen.Enabled = true
end
function zcharacterDimensionstor:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.MessageBox({
    Text = "Ich sehe euch dann auf der anderen Seite!",
    Media = zmediaPeterDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB38
  })
end
function zcharacterEngel:OnAngucken()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Als du dem Engel n\195\164her kommst bemerkst du das er weint", {PocketPC = 1}),
    Media = zmediaAngel,
    Buttons = {"Ansprechen"},
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB49
  })
  zcharacterEngel.Commands.Angucken.Enabled = false
end
function zcharacterEngel:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction
    })
    Wherigo.PlayAudio(zmediaSoundGhost)
    zcharacterEngel.Commands.Anpirschen.Enabled = false
    zcharacterEngel.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction
    })
  end
end
function zcharacterEngel:OnAnsprechen()
  Wherigo.GetInput(zinputPestjahr)
end
function zcharacterEngel:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Die Fl\195\188gel werden wir dir stutzen Freundchen! Aktivier die Falle!", {PocketPC = 1}),
      Media = zmediaAngelCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB53
    })
  end
end
function zcharacterExot:OnAnsprechen()
  Wherigo.GetInput(zinputKang)
end
function zcharacterFlammenteufel:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost2)
    zcharacterFlammenteufel.Commands.Anpirschen.Enabled = false
    zcharacterFlammenteufel.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterFlammenteufel:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Wie bek\195\164mpft man Feuer? Mit Feuer!<BR>\nFalle aktivieren!", {PocketPC = 1}),
      Media = zmediaFlameCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB57
    })
  end
end
function zcharacterGeisterzug:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost)
    zcharacterGeisterzug.Commands.Anpirschen.Enabled = false
    zcharacterGeisterzug.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterGeisterzug:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = "Gleich ist es nur noch Altmetall!",
      Media = zmediaGeisterzugCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB60
    })
  end
end
function zcharacterGozer:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("La\195\159t uns dieser pr\195\164historischen Biene zeigen wie die Dinge in unserer Stadt laufen!<BR>\nZielt auf ihre B\195\188rste!", {PocketPC = 1}),
      Media = zmediaPeterAction
    })
    Wherigo.PlayAudio(zmediaSoundGhost2)
    zcharacterGozer.Commands.Anpirschen.Enabled = false
    zcharacterGozer.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterGozer:OnReden()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Gozer der Gozerianer?<BR>\nGuten Abend... als ordnungsgem\195\164\195\159er Repr\195\164sentant der Stadt ordne ich hiermit die Einstellung aller \195\188bernat\195\188rlicher Aktivit\195\164ten und das sofortige Zur\195\188ckkehren an deinen Ursprungsort oder zur n\195\164chstgelegenen, erreichbaren Paralleldimension an!", {PocketPC = 1}),
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB62
  })
  zcharacterGozer.Commands.Reden.Enabled = false
end
function zcharacterGozer:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  Wherigo.Dialog({
    {
      Text = "*Gozer verschwindet im Protonenstrom*",
      Media = zmediaGozerCap
    },
    {
      Text = "War das nun so schwer?",
      Media = zmediaPeterDialog
    },
    {
      Text = "Wir haben es neutronisiert! Eine komplette Partikelumkehr!",
      Media = zmediaRayDialog
    },
    {
      Text = "Wir hatten das Werkzeug und wir hatten das Talent.",
      Media = zmediaAlterEgo
    },
    {
      Text = "Dann mach mal Pause!",
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Jungs! Das PKE sieht au\195\159erordentlich \195\188bel aus..."),
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Subkreaturen, Gozer der Vernichter, Gozer der Reisende ist gekommen. W\195\164hle und stirrrb!"),
      Media = zmediaGozerInv
    },
    {
      Text = WWB_multiplatform_string("Was meinst du mit \"w\195\164hle\"? Wir verstehen das nicht!"),
      Media = zmediaRayDialog
    },
    {
      Text = WWB_multiplatform_string("W\195\132HLE! W\195\164hle die Form des Vernichters!"),
      Media = zmediaGozerInv
    },
    {
      Text = WWB_multiplatform_string("Oh, ich verstehe! Wirklich s\195\188\195\159.<BR>\nWoran immer wir denken wird auftauchen und uns vernichten, also leert eure K\195\182pfe! Denkt an gar nichts!"),
      Media = zmediaPeterDialog
    },
    {
      Text = "Die Wahl ist getroffen. Der Reisende ist gekommen.",
      Media = zmediaGozerInv
    },
    {
      Text = WWB_multiplatform_string("Moment! Keiner von uns hat irgendetwas gew\195\164hlt!"),
      Media = zmediaPeterDialog
    },
    {
      Text = "Ich... Ich konnt's irgendwie nicht verhindern. Es war \"schwupps\" einfach da...",
      Media = zmediaRayDialog
    },
    {
      Text = "Was? Was war \"schwupps\" einfach da?",
      Media = zmediaPeterDialog
    },
    {
      Text = "Es ist der allseits beliebte Marshmallow-Mann.",
      Media = zmediaRayDialog
    },
    {
      Text = [[
*stampf-stampf-stampf*<BR>
MMMOOOAAAHHHHH]],
      Media = zmediaPuffy
    },
    {
      Text = "Das ist jedenfalls etwas, was man nicht jeden Tag sieht...",
      Media = zmediaAlterEgo
    }
  })
  zcharacterGozer.Visible = false
  zcharacterMarshmallowMann.Visible = true
end
function zcharacterHomunculus:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost)
    zcharacterHomunculus.Commands.Anpirschen.Enabled = false
    zcharacterHomunculus.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterHomunculus:OnAnsprechen()
  Wherigo.GetInput(zinputBarbier)
end
function zcharacterHomunculus:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Schnipp-Schnapp, H\195\164nde ab! Falle!", {PocketPC = 1}),
      Media = zmediaEdwardCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB64
    })
  end
end
function zcharacterJanine:OnReden()
  if var_story == 1 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Herzlich willkommen bei den Geisterj\195\164gern, was kann ich f\195\188r Sie tun?"),
        Media = zmediaJanine
      },
      {
        Text = WWB_multiplatform_string("\195\132h, hallo! Ich wollte mich f\195\188r den Job bewerben... Ich heisse " .. var_youName .. ""),
        Media = zmediaAlterEgo
      },
      {
        Text = "Dann sprechen Sie am besten mit Dr. Stantz. Da ist er auch schon.",
        Media = zmediaJanine
      }
    })
    zcharacterJanine.Commands.Reden.Enabled = false
    zcharacterRay.Visible = true
  end
end
function zcharacterLepusUmbra:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost)
    zcharacterLepusUmbra.Commands.Anpirschen.Enabled = false
    zcharacterLepusUmbra.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterLepusUmbra:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = [[
Aus die Maus, Meister Lampe! <BR>
Ab in den Kanickelstall!]],
      Media = zmediaFrankCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB65
    })
  end
end
function zcharacterLouis:OnReden()
  if var_storymain == 3 then
    Wherigo.GetInput(zinputLouis)
  end
  if var_storymain == 6 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.MessageBox({
      Text = "Wie sagtest du war dein Name noch gleich?",
      Media = zmediaEgonDialog,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB66
    })
    var_storymain = var_storymain + 1
    zcharacterLouis.Commands.Reden.Enabled = false
    ztaskBefrageLouis.Active = false
    zcharacterRay.Visible = true
    zcharacterRay.Commands.Reden.Enabled = true
    ztaskWashatRayrausgefunden.Active = true
  end
end
function zcharacterMarshmallowMann:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.MessageBox({
    Text = "Niemand latscht ungestraft auf eine Kirche in meiner Stadt!",
    Media = zmediaPeterDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB67
  })
end
function zcharacterOfficerWalker:OnReden()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.Dialog({
    {
      Text = "Hallo Officer. Kann ich ihnen helfen?",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Sind sie ein Geisterj\195\164ger?"),
      Media = zmediaOfficer
    },
    {Text = "Ja.", Media = zmediaEgonDialog},
    {
      Text = WWB_multiplatform_string("Wir haben da einen Mann aufgegriffen.<BR>\nDie Klappsm\195\188hle will ihn nicht haben. Ich hab Angst ihn in die Zelle zu stecken und weil ich weiss, dass ihr Jungs mit sowas zu tun habt..."),
      Media = zmediaOfficer
    },
    {
      Text = "Naja, also ich dachte mir wir lassen ihn mal bei euch.",
      Media = zmediaOfficer
    },
    {
      Text = "In Ordnung.",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Bist du der Torw\195\164chter?"),
      Media = zmediaLouisPossesed
    },
    {
      Text = WWB_multiplatform_string("*mit PKE-Messger\195\164t in der Hand*<BR>\nSie bringen ihn besser sofort rein."),
      Media = zmediaEgonDialog
    },
    {
      Text = "Alles klar, danke!",
      Media = zmediaOfficer
    },
    {
      Text = "Ich finde es unheimlich toll. Sie sind ein echter Menschenfreund.",
      Media = zmediaJanine
    },
    {
      Text = "Ich glaube nicht, dass er ein Mensch ist.",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Trotzdem... Ich m\195\182chte wetten, dass Sie auch gern viel lesen."),
      Media = zmediaJanine
    },
    {
      Text = "Gedrucktes ist tot.",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Es gibt Leute die halten mich f\195\188r zu intellektuell, ich selbst lese n\195\164mlich sehr viel. Au\195\159erdem spiele ich noch Volleyball.<BR>\nHaben Sie irgendwelche Hobbys?"),
      Media = zmediaJanine
    },
    {
      Text = WWB_multiplatform_string("Ich sammle Sporen, Gr\195\188nspan und Schimmelpilze."),
      Media = zmediaEgonDialog
    }
  })
  ztaskEinOfficerwilleuchsprechen.Active = false
  zcharacterOfficerWalker.Visible = false
  zcharacterLouis.Commands.Reden.Enabled = true
  ztaskBefrageLouis.Active = true
end
function zcharacterPirat:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost2)
    zcharacterPirat.Commands.Anpirschen.Enabled = false
    zcharacterPirat.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterPirat:OnAnsprechen()
  if var_iphone == 1 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Arrr, jemals auf hoher See gewesen und Kaventsm\195\164nner \195\188berstanden, du S\195\188sswassermatrose?<BR>\n-<BR>\nAntwort A<BR>\nHaushohe Brecher sind mein Zuhause und saufen tu ich Meerwasser!<BR>\n-<BR>\nAntwort B<BR>\nAuch auf Seen gibt es Wellen und ich hab den Schein \"SBF Binnen\".<BR>\n-<BR>\nAntwort C<BR>\nBei der Neptunstaufe war ich voller Tran und kurz darauf umsegelten wir das Kap, du Deckschrubber!", {PocketPC = 1}),
      Media = zmediaCaptain,
      Buttons = {"Antworten"},
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB71
    })
  else
    Wherigo.GetInput(zinputPirat1)
  end
end
function zcharacterPirat:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Das war das letzte Gefecht des alten Seeb\195\164ren! Ab in Einzelhaft, da kann er keinen mehr volllabern!", {PocketPC = 1}),
      Media = zmediaCaptainCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB72
    })
  end
end
function zcharacterRay:OnReden()
  if var_story == 1 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.MessageBox({
      Text = "Hallo, ich bin Dr. Raymond Stantz, Parapsychologe. Du kannst mich Ray nennen.",
      Media = zmediaRayDialog,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB73
    })
    zcharacterRay.Commands.Reden.Enabled = false
    zcharacterEgon.Visible = true
    zcharacterPeter.Visible = true
  end
  if var_story >= 6 and var_EctoVar == 0 then
    Wherigo.GetInput(zinputEctoSchild)
  end
  if var_storymain == 7 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.Dialog({
      {
        Text = "Und? Was hast du rausgefunden Ray?",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("*breitet die Baupl\195\164ne aus*<BR>\nDieses komische Dach ist aus einer Magnesium-Wolfram Legierung."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Das sieht sehr, sehr merkw\195\188rdig aus."),
        Media = zmediaAlterEgo
      },
      {
        Text = "Die Eisenstruktur des Daches ist genauso wie die Telemetrie Spur, welche die NASA benutzt um tote Pulsare in den Tiefen des Raums zu entdecken.",
        Media = zmediaEgonDialog
      },
      {
        Text = "Kaltvernietete Tragbalken mit Kernen aus reinem Selen.",
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Also was? Ich sch\195\164tze sie machen sie nicht mehr wie fr\195\188her mal."),
        Media = zmediaPeterDialog
      },
      {
        Text = "Nein Unsinn, kein Mensch hat jemals sowas so gebaut. Ich meine die Architekten waren entweder amtlich beglaubigte Genies oder total Wahnsinnige.",
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Das gesamte Geb\195\164ude ist eine riesige superleitf\195\164hige Antenne, ausdr\195\188cklich entworfen und gebaut f\195\188r einen einzigen Zweck; zum Anziehen und Konzentrieren von spirituellen Turbulenzen."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Etwas furchtbares ist im Begriff in unsere Welt einzutreten, und dieses Geb\195\164ude ist ganz offensichtlich das Tor."),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("1920 gr\195\188ndeten die beiden Architekten eine Geheimgesellschaft."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("La\195\159 mich raten... Gozer-Anbeter"),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Richtig!<BR>\nNach dem ersten Weltkrieg waren sie der Meinung, dass die menschliche Gemeinschaft zu krank zum \195\156berleben sei.<BR>\nSie f\195\188hrten Rituale durch, oben auf dem Dach."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Bizarre Rituale. <BR>\nRituale, die das Ende der Welt herbeif\195\188hren sollten. Und jetzt, HEUTE, sieht es so aus als w\195\188rde dies tats\195\164chlich passieren."),
        Media = zmediaRayDialog
      },
      {
        Text = "Dana wohnt hier im Eckapartment 2206 des Geistercenters.",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Und unser neuer Freund, der Schl\195\188sselmeister, gleich hier quer gegen\195\188ber... er sucht \195\188brigens den Torw\195\164chter..."),
        Media = zmediaEgonDialog
      },
      {
        Text = "Zuul... Dana!",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Der Verdacht liegt nahe. Ich glaub, wenn die beiden sich treffen k\195\182nnte das au\195\159erordentlich gef\195\164hrlich werden!"),
        Media = zmediaEgonDialog
      },
      {
        Text = "Wo ist Vinz?",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("SCHNELL! WIR M\195\156SSEN ZU DANA!"),
        Media = zmediaRayDialog
      }
    })
    ztaskWashatRayrausgefunden.Active = false
    var_storymain = var_storymain + 1
    zcharacterRay.Commands.Reden.Enabled = false
    zcharacterLouis.Visible = false
    zoneHochhaus.Active = true
    ztaskVerhinderedasZuulundVinzsichtreffen.Active = true
  end
end
function zcharacterRitter:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost2)
    zcharacterRitter.Commands.Anpirschen.Enabled = false
    zcharacterRitter.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterRitter:OnAnsprechen()
  Wherigo.GetInput(zinputRittermotto)
end
function zcharacterRitter:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = "Aktiviere jetzt die Falle um die grosse Blechdose in die kleine Dose zu sperren!",
      Media = zmediaRitterCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB74
    })
  end
end
function zcharacterSchatten:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost)
    zcharacterSchatten.Commands.Anpirschen.Enabled = false
    zcharacterSchatten.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterSchatten:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
      Media = zmediaTrapUsed,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
    })
  else
    Wherigo.MessageBox({
      Text = [[
Wir haben das Ding im Sperrstrahl. <BR>
EGON! Schieb die Falle raus!]],
      Media = zmediaSchattenCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB75
    })
  end
end
function zcharacterSlimer:OnAnpirschen()
  if zitemProtonPack.Opened == true then
    Wherigo.MessageBox({
      Text = "Los, nehmt es in die Zange! FEUER!",
      Media = zmediaPeterAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB50
    })
    Wherigo.PlayAudio(zmediaSoundGhost2)
    zcharacterSlimer.Commands.Anpirschen.Enabled = false
    zcharacterSlimer.Commands.Schiessen.Enabled = true
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Bevor man Geister f\195\164ngt, sollte man noch sein Proton-Pack aktivieren!", {PocketPC = 1}),
      Media = zmediaEgonAction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB51
    })
  end
end
function zcharacterSlimer:OnSchiessen()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    if Player:Contains(zitemFalle) and not Player:Contains(zitemProtonPack) then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Er ist in der Zange! Aber... Hoppala! Z\195\164hlen ist nicht gerade deine St\195\164rke, oder? Wir haben keine leere Fallen mehr, wir m\195\188ssen erstmal zur\195\188ck zur Station.", {PocketPC = 1}),
        Media = zmediaTrapUsed,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB52
      })
    else
      Wherigo.MessageBox({
        Text = "Mmh... und womit sollen wir das Vieh jetzt fangen? Wir brauchen auch noch die Fallen! Kommando kehrt!",
        Media = zmediaPeterDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB23
      })
    end
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Gut so, du hast die gr\195\188nen Knolle mit deinem Protonenstrahl gefesselt! Aktiviere jetzt die Falle um ihn zu fangen, aber seh auf keinen Fall rein!", {PocketPC = 1}),
      Media = zmediaSlimerCap,
      Buttons = {
        "Falle aktivieren"
      },
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB78
    })
  end
end
function zitemDefekteFalle:OnErsetzten()
  zitemDefekteFalle.Visible = false
  zitemFalle.Visible = true
  if var_defekteFalle == 1 then
    var_xFalle = var_xFalle + 1
  end
  if var_defekteFalle == 2 then
    var_xFalle = var_xFalle + 2
  end
  if var_defekteFalle == 3 then
    var_xFalle = var_xFalle + 3
  end
  zitemFalle.Description = WWB_multiplatform_string("Du hast " .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.")
  var_defekteFalle = 0
  zitemDefekteFalle.Commands.Ersetzten.Enabled = false
  Wherigo.MessageBox({
    Text = "Nagelneu &amp;&amp; blitzeblank... &nbsp;noch!",
    Media = zmediaTrapEmpty
  })
  ztaskFalledefekt.Active = false
end
function zitemFalle:OnNehmen()
  zitemFalle:MoveTo(Player)
  zitemVolleFalle:MoveTo(Player)
  zitemDefekteFalle:MoveTo(Player)
  var_story = var_story + 1
  zitemFalle.Commands.Nehmen.Enabled = false
  zitemFalle.Description = WWB_multiplatform_string("Du hast " .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.")
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zitemProtonPack:OnAktivieren()
  Wherigo.PlayAudio(zmediaSoundProtoON)
  zitemProtonPack.Opened = true
  zitemProtonPack.Commands.Aktivieren.Enabled = false
  zitemProtonPack.Media = zmediaProtoPackActive
  zitemProtonPack.Description = WWB_multiplatform_string("Das Proton-Pack summt unheimlich auf deinem R\195\188cken.")
  zitemProtonPack.Commands.Deaktivieren.Enabled = true
end
function zitemProtonPack:OnDeaktivieren()
  if var_storymain == 10 then
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("La\195\159 das Proton-Pack an, wir werden es gleich brauchen!", {PocketPC = 1}),
      Media = zmediaEgonAction
    })
  else
    Wherigo.PlayAudio(zmediaSoundProtoOFF)
    zitemProtonPack.Opened = false
    zitemProtonPack.Commands.Deaktivieren.Enabled = false
    zitemProtonPack.Media = zmediaProtoPack
    zitemProtonPack.Description = WWB_multiplatform_string("Du tr\195\164gst das Proton-Pack auf deinem R\195\188cken.")
    zitemProtonPack.Commands.Aktivieren.Enabled = true
  end
end
function zitemProtonPack:OnNehmen()
  zitemProtonPack:MoveTo(Player)
  var_story = var_story + 1
  zitemProtonPack.Commands.Tragen.Enabled = true
  zitemProtonPack.Commands.Nehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function zitemProtonPack:OnReparieren()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.GetInput(zinputProtoRep)
end
function zitemProtonPack:OnTragen()
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("" .. var_youName .. ", wegen dem Proton-Pack musst du noch eines wissen..."),
      Media = zmediaRayDialog
    },
    {Text = "Was?", Media = zmediaAlterEgo},
    {
      Text = WWB_multiplatform_string("Wir d\195\188rfen auf keinen Fall die Str\195\182me kreuzen! Es ist ein nicht-lizensierter nuklearer Protonen Beschleuniger!"),
      Media = zmediaRayDialog
    },
    {
      Text = "Ja, und? Wieso nicht?",
      Media = zmediaAlterEgo
    },
    {
      Text = WWB_multiplatform_string("Das w\195\164re schlecht."),
      Media = zmediaEgonDialog
    },
    {
      Text = "Was meinst du mit schlecht?",
      Media = zmediaAlterEgo
    },
    {
      Text = "Totale Protonenumkehr!",
      Media = zmediaEgonDialog
    },
    {
      Text = "OHH.. DAS meinst du mit schlecht! Das war ein wichtiger Sicherheitstipp. Danke, Egon!",
      Media = zmediaAlterEgo
    }
  })
  zitemProtonPack.Commands.Aktivieren.Enabled = true
  zitemProtonPack.Commands.Tragen.Enabled = false
  zitemProtonPack.Description = WWB_multiplatform_string("Du tr\195\164gst das Proton-Pack auf deinem R\195\188cken.")
end
function zitemstory:Onstory()
  zitemstory.Description = WWB_multiplatform_string("story: " .. var_story .. " und storymain: " .. var_storymain .. "")
end
function zitemUnlockKey:OnAufschliessen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("" .. Player.CompletionCode .. "<BR>\n<BR>\nZum optionalen Unlocken auf wherigo.com nur die ersten 15 Buchstaben des Codes eingeben!<BR>\n<BR>\nDer Code ist user-bezogen. Wurde der Cache als Gruppe gemacht, mu\195\159 man die 3. Option nehmen und den entsprechenden User nennen!", {PocketPC = 1}),
    Media = zmediaKey
  })
end
function zitemVolleFalle:OnEntladen()
  Wherigo.PlayAudio(zmediaSoundTrapUNLOAD)
  zitemVolleFalle.Visible = false
  zitemFalle.Visible = true
  if var_volleFalle == 1 then
    var_xFalle = var_xFalle + 1
  end
  if var_volleFalle == 2 then
    var_xFalle = var_xFalle + 2
  end
  if var_volleFalle == 3 then
    var_xFalle = var_xFalle + 3
  end
  zitemFalle.Description = WWB_multiplatform_string("Du hast " .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.")
  zitemVolleFalle.Commands.Entladen.Enabled = false
  var_volleFalle = 0
  ztaskVolleFalle.Active = false
  if ztaskFalleueberlastet.Active == true then
    ztimerSchatten:Stop()
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("HURRA! Geschafft! Wir konnten die Falle rechtzeitig entladen! Wir nehmen lieber eine Neue mit und diese kommt auf den M\195\188ll.", {PocketPC = 1}),
      Media = zmediaTrapMalfunction,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB83
    })
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Und ab damit in den Speicher! Geh sch\195\182n mit den Anderen spielen!", {PocketPC = 1}),
      Media = zmediaTrapEmpty
    })
  end
end
function zinputAlterEgo:OnGetInput(input)
  var_AlterEgo = input
  if var_AlterEgo ~= nil then
    if Wherigo.NoCaseEquals(var_AlterEgo, "Frau") then
      zmediaAlterEgo = zmediaYouFemale
      Wherigo.GetInput(zinputyouName)
    end
    if Wherigo.NoCaseEquals(var_AlterEgo, "Mann") then
      zmediaAlterEgo = zmediaYouMale
      Wherigo.GetInput(zinputyouName)
    end
  end
end
function zinputArchitekten:OnGetInput(input)
  var_Architekten = input
  if var_Architekten ~= nil then
    if Wherigo.NoCaseEquals(var_Architekten, "Zauleck und Hormann") or Wherigo.NoCaseEquals(var_Architekten, "Zauleck + Hormann") or Wherigo.NoCaseEquals(var_Architekten, "Zauleck und Horman") or Wherigo.NoCaseEquals(var_Architekten, "Zauleck Hormann") or Wherigo.NoCaseEquals(var_Architekten, "ZauleckundHorman") or Wherigo.NoCaseEquals(var_Architekten, "Christian Zauleck und Franz Hormann") or Wherigo.NoCaseEquals(var_Architekten, "Christian Zauleck + Franz Hormann") or Wherigo.NoCaseEquals(var_Architekten, "Christian Zauleck Franz Hormann") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Gut, ich werde bei Gelegenheit zum Grundbuchamt gehen und die baulichen Details des Geb\195\164udes \195\188berpr\195\188fen. Vielleicht hat ja das Haus selbst eine Vergangenheit parapsychologischer Turbulenzen.<BR>\nWir m\195\188ssen jetzt erstmal weiter! <BR>\nWir melden uns Dana!", {PocketPC = 1}),
        Media = zmediaRayDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB86
      })
    else
      Wherigo.MessageBox({
        Text = "Gib's zu, das hast du dir doch ausgedacht, oder?",
        Media = zmediaEgonDialog
      })
    end
  end
end
function zinputBahnhof:OnGetInput(input)
  var_bahnsteig = input
  if var_bahnsteig ~= nil then
    if Wherigo.NoCaseEquals(var_bahnsteig, "Gleis 3") or Wherigo.NoCaseEquals(var_bahnsteig, "Bahnsteig 3") or Wherigo.NoCaseEquals(var_bahnsteig, "Bahnsteig3") or Wherigo.NoCaseEquals(var_bahnsteig, "Gleis3") then
      Wherigo.Dialog({
        {
          Text = "Exakt! Das ist mir auch aufgefallen!",
          Media = zmediaRayDialog
        },
        {
          Text = WWB_multiplatform_string("M\195\188ssen wir jetzt mit Anlauf durch die Wand laufen?"),
          Media = zmediaPeterDialog
        },
        {
          Text = "Eventuell sollte ich vorher meine Brille absetzten...",
          Media = zmediaEgonDialog
        },
        {
          Text = "Quatsch, da holen wir uns doch nur 'ne blutige Nase!",
          Media = zmediaAlterEgo
        },
        {
          Text = WWB_multiplatform_string("" .. var_youName .. " hat recht, wir sollten mal auf Bahnsteig 2 oder 4 gucken!<BR>\n"),
          Media = zmediaEgonDialog
        }
      })
      zoneBahnhof.Active = false
      zoneBahnsteig.Active = true
      ztaskDerBahnhof.Description = "Verschreckte Passagiere beschweren sich bei der Bahn. Schau dich auf Bahnsteig 2 oder 4 um."
      cartGhostbusters:RequestSync()
    else
      Wherigo.MessageBox({
        Text = [[
Hey, auch nicht schlecht, daran hab ich noch gar nicht gedacht! Aber falsch...<BR>
ein Zauberjunge mit Narbe &amp;&amp; Brille IM Bahnhof! <BR>
Wohin ist er da gegangen? Na, und hier?]],
        Media = zmediaRayDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB88
      })
    end
  end
end
function zinputBarbier:OnGetInput(input)
  var_Barbier = input
  if var_Barbier ~= nil then
    if Wherigo.NoCaseEquals(var_Barbier, "Barbier") then
      Wherigo.Dialog({
        {
          Text = "JA! BARBIER! Wie konnte ich das nur vergessen? HAR-HAR!",
          Media = zmediaEdward
        },
        {
          Text = WWB_multiplatform_string("Ich werde mich r\195\164chen, daf\195\188r das sie mich davongejagt haben, wie einen r\195\164udigen Hund!"),
          Media = zmediaEdward
        },
        {
          Text = WWB_multiplatform_string("Oh man! Ich wu\195\159te es!<BR>\nDer teuflische Barbier aus der Lindenstra\195\159e!<BR>\n"),
          Media = zmediaPeterDialog
        },
        {
          Text = "Okay, macht alles klar!",
          Media = zmediaEgonDialog
        }
      })
      ztaskEinanderesWortfuerFriseur.Active = false
      zcharacterHomunculus.Commands.Ansprechen.Enabled = false
      zcharacterHomunculus.Commands.Anpirschen.Enabled = true
    else
      Wherigo.MessageBox({
        Text = "Nein, das ist es nicht... es war irgendwie anders... Argh!",
        Media = zmediaEdward
      })
    end
  end
end
function zinputEctoSchild:OnGetInput(input)
  var_Ecto = input
  if var_Ecto ~= nil then
    if Wherigo.NoCaseEquals(var_Ecto, "ECTO-HL") or Wherigo.NoCaseEquals(var_Ecto, WWB_multiplatform_string("ECTO-HL L\195\156BECK")) or Wherigo.NoCaseEquals(var_Ecto, "ECTO-HL LUEBECK") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Japp, das ist das richtige. Schraub es mal schnell wieder an, wir m\195\188ssen gleich weiter!", {PocketPC = 1}),
        Media = zmediaRayDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB90
      })
      var_EctoVar = var_EctoVar + 1
      zoneAmWasser.Visible = true
      zoneBahnhof.Visible = true
      zoneBruecke.Visible = true
      zoneFriedhof.Visible = true
      zoneFriseur.Visible = true
      zoneHochhaus.Visible = true
      zonePark.Visible = true
      zoneParkdeck.Visible = true
      zoneVideothek.Visible = true
      ztaskFindedasNummernschild.Complete = true
      ztaskFindedasNummernschild.Visible = false
      zcharacterRay.Commands.Reden.Enabled = false
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Nein, " .. var_youName .. ", das ist es nicht. Sucht weiter, ohne Nummernschild k\195\182nnen wir nicht fahren!", {PocketPC = 1}),
        Media = zmediaRayDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB91
      })
    end
  end
end
function zinputFinal:OnGetInput(input)
  var_Final = input
  if var_Final ~= nil then
    if Wherigo.NoCaseEquals(var_Final, "Who you gonna call") or Wherigo.NoCaseEquals(var_Final, "WHO YOU GONNA CALL") then
      Wherigo.PlayAudio(zmediaSoundTitle)
      ztaskGehezurFinalZoneundfindedenCache.Active = false
      cartGhostbusters.Complete = true
      zitemUnlockKey.Visible = true
      zitemUnlockKey:MoveTo(Player)
      zoneFinal.Visible = false
      cartGhostbusters:RequestSync()
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch - Du hast den wherigo durchgespielt!<BR>\nWir hoffen, dass es dir viel Spa\195\159 gemacht hat!<BR>\n<BR>\nIn deinem Inventar ist nun der Unlock-Key, somit kannst du zu Hause mit dem Code auf wherigo.com loggen - oder du l\195\164dst einfach das Save-File hoch.<BR>\n<BR>\nBitte beim Verschliessen der T\195\188r darauf achten, dass sie oben &amp;&amp; unten richtig einrastet! Splint bitte wieder ins Schloss &amp;&amp; Schl\195\188ssel mit Magnet wieder verstecken!<BR>\n<BR>\nSollte Licht oder Sound nicht funktionieren bitte kurze Info an uns.<BR>\n<BR>\nEndet das Cartridge nach dem Knopfdruck nicht, dann beende es bitte manuell.", {PocketPC = 1}),
        Media = zmediathavorianer,
        Buttons = {
          "Spiel beenden"
        },
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB92
      })
    else
      Wherigo.MessageBox({
        Text = "Nein, da ist dir ein Fehler reingerutscht. Versuch es bitte noch einmal.",
        Media = zmediathavorianer,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB93
      })
    end
  end
end
function zinputGozer:OnGetInput(input)
  var_Gozer = input
  if var_Gozer ~= nil then
    zcharacterGozer.Commands.Anpirschen.Enabled = true
    if Wherigo.NoCaseEquals(var_Gozer, "Ja") then
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string("Unw\195\188rdiger... glaubst du, du kannst mich t\195\164uschen? Ich rieche deine Sterblichkeit!"),
          Media = zmediaGozer
        },
        {
          Text = "...also, wenn ich eine Freundin habe, dann nennt sie mich im Bett manchmal...",
          Media = zmediaRayDialog
        },
        {
          Text = "GENUG! STIRRRB!!!",
          Media = zmediaGozer_attak
        },
        {Text = "AAHHHHHH!", Media = zmediaAlterEgo},
        {
          Text = "Ray, wenn dich irgendwer fragt, ob du ein Gott bist, dann sagst du: NEIN!",
          Media = zmediaAlterEgo
        },
        {
          Text = "In Ordnung, die Braut ist Toast!",
          Media = zmediaPeterDialog
        }
      })
    else
      Wherigo.Dialog({
        {
          Text = "Dann... STIRRRB!!!",
          Media = zmediaGozer_attak
        },
        {Text = "AAHHHHHH!", Media = zmediaAlterEgo},
        {
          Text = "Ray, wenn dich irgendwer fragt, ob du ein Gott bist, dann sagst du: JA!",
          Media = zmediaAlterEgo
        },
        {
          Text = "In Ordnung, die Braut ist Toast!",
          Media = zmediaPeterDialog
        }
      })
    end
  end
end
function zinputKang:OnGetInput(input)
  var_KangBuch = input
  if var_KangBuch ~= nil then
    if Wherigo.NoCaseEquals(var_KangBuch, "Ja") then
      Wherigo.Dialog({
        {
          Text = WWB_multiplatform_string("Ich danke euch! <BR>\nVielleicht kann ich euch... \195\164h, f\195\188r euch mal kochen? <BR>\nMUAHA-HARHARHARHARHARHARHAR"),
          Media = zmediaKang
        },
        {
          Text = WWB_multiplatform_string("\195\132h... es w\195\164r uns ein Vergn\195\188gen!"),
          Media = zmediaAlterEgo
        },
        {
          Text = WWB_multiplatform_string("Schreibt mir eure Namen hinten ins Buch, dann komm ich beim n\195\164chsten Transit vorbei und koch mit euch! <BR>\nMUAHA-HARHARHARHARHARHARHAR"),
          Media = zmediaKang
        },
        {
          Text = "Ja, ich sehe da auf den ersten Seiten bereits ein paar interessante \"Rezepte\".",
          Media = zmediaPeterDialog
        },
        {
          Text = WWB_multiplatform_string("Ja, wir m\195\188ssen dann auch mal los. Unser n\195\164chste Auftrag ist dieser kleine rote Planet eins weiter, glaube ihr nennt ihn Mars! <BR>\nEinen sch\195\182nen Tag noch!<BR>\n"),
          Media = zmediaKang
        },
        {
          Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch! Du hast den Mystery-Bonus gefunden!"),
          Media = zmediathavorianer
        }
      })
      ztaskWoistKangsKochbuch.Active = false
      ztaskWoistKangsKochbuch.Complete = true
      zcharacterExot.Visible = false
      zoneUFO.Active = false
      cartGhostbusters:RequestSync()
    else
      Wherigo.MessageBox({
        Text = "Schade! Ich hoffe wir finden es noch - da sind die besten Rezepte meiner Mutti drinne!",
        Media = zmediaKang,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB94
      })
    end
  end
end
function zinputLouis:OnGetInput(input)
  var_Louis = tonumber(input)
  if var_Louis ~= nil then
    if var_Louis == 25 then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Das ist doch ein super Angebot, oder findet ihr nicht? Vor allem k\195\182nnt ihr trotzdem zu 100% steuerlich absetzten! Aber das habt ihr nicht von mir!", {PocketPC = 1}),
        Media = zmediaLouis,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB95
      })
    else
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Haha, neee! In Mathe nicht so richtig aufgepa\195\159t?", {PocketPC = 1}),
        Media = zmediaLouis,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB96
      })
    end
  end
end
function zinputPestjahr:OnGetInput(input)
  var_Pestjahr = tonumber(input)
  if var_Pestjahr ~= nil then
    if var_Pestjahr == 1597 then
      Wherigo.Dialog({
        {Text = "1597?", Media = zmediaAngel_open},
        {Text = "Ja, 1597!", Media = zmediaAlterEgo},
        {
          Text = "1597?? 1597!!!",
          Media = zmediaAngel
        },
        {
          Text = "Warum? Warum nur? WARUM???",
          Media = zmediaAngel_open
        },
        {
          Text = "Jungs... merkt ihr es auch?",
          Media = zmediaPeterDialog
        },
        {
          Text = WWB_multiplatform_string("Jupp, es wird k\195\164lter..."),
          Media = zmediaRayDialog
        },
        {Text = "Eiskalt!", Media = zmediaAlterEgo},
        {
          Text = "WWAAAAARRRRRUUUMMMM?!?!?!?!?",
          Media = zmediaAngel_evil
        },
        {
          Text = "Wir sollten sie Falle auswerfen und die Proton-Packs anschalten...",
          Media = zmediaEgonDialog
        }
      })
      zcharacterEngel.Commands.Ansprechen.Enabled = false
      zcharacterEngel.Commands.Anpirschen.Enabled = true
      zcharacterEngel.Media = zmediaAngel_evil
      ztaskWannkamderSchwarzeTod.Active = false
      ztaskWannkamderSchwarzeTod.Complete = true
      cartGhostbusters:RequestSync()
    else
      Wherigo.MessageBox({
        Text = "Nein... Nein...",
        Media = zmediaAngel
      })
    end
  end
end
function zinputPirat1:OnGetInput(input)
  var_PiratAntwort = input
  if var_PiratAntwort ~= nil then
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-A") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Du Aufschneider! Seemannsgarn kannst du in der Hafenspelunke dem dreik\195\182pfigen Affen erz\195\164hlen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-B") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, du Landratte! Komm wieder, wenn du nicht mehr so gr\195\188n hinter den Ohren bist!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-C") then
      Wherigo.GetInput(zinputPirat2)
    end
  end
end
function zinputPirat2:OnGetInput(input)
  var_PiratAntwort = input
  if var_PiratAntwort ~= nil then
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-A") then
      Wherigo.GetInput(zinputPirat3)
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-B") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Du Aufschneider! Seemannsgarn kannst du in der Hafenspelunke dem dreik\195\182pfigen Affen erz\195\164hlen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-C") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, du Landratte! Komm wieder, wenn du nicht mehr so gr\195\188n hinter den Ohren bist!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99
      })
    end
  end
end
function zinputPirat3:OnGetInput(input)
  var_PiratAntwort = input
  if var_PiratAntwort ~= nil then
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-A") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Beim Klabautermann, das mit dem toten Fisch wirst du mir b\195\188ssen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB100
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-B") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, du Landratte! Komm wieder, wenn du nicht mehr so gr\195\188n hinter den Ohren bist!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-C") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Du Aufschneider! Seemannsgarn kannst du in der Hafenspelunke dem dreik\195\182pfigen Affen erz\195\164hlen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98
      })
    end
  end
end
function zinputPiratIphone1:OnGetInput(input)
  var_PiratAntwort = input
  if var_PiratAntwort ~= nil then
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-A") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Du Aufschneider! Seemannsgarn kannst du in der Hafenspelunke dem dreik\195\182pfigen Affen erz\195\164hlen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-B") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, du Landratte! Komm wieder, wenn du nicht mehr so gr\195\188n hinter den Ohren bist!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-C") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, der Seegang liegt mir so im Blut, dass ich auf See gerade geh und an Land torkel!<BR>\n-<BR>\nAntwort A<BR>\nDir liegt h\195\182chstens Rum im Blut und das Torkeln kommt vom Suff!<BR>\n-<BR>\nAntwort B<BR>\nIm Tsunami \195\188berschlug sich unser Schiff, doch meine Beine standen fest an Deck.<BR>\n-<BR>\nAntwort C<BR>\nIch \195\188be t\195\164glich in der Schiffschaukel, aber mir wird immer noch \195\188bel.", {PocketPC = 1}),
        Media = zmediaCaptain,
        Buttons = {"Antworten"},
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB101
      })
    end
  end
end
function zinputPiratIphone2:OnGetInput(input)
  var_PiratAntwort = input
  if var_PiratAntwort ~= nil then
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-A") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, ein echter Seemann hat in jedem Hafen eine Braut und Seeungeheuer nennen ihn beim Namen.<BR>\n-<BR>\nAntwort A<BR>\nDas einzige Meermonster bist du und Frauen m\195\182gen keinen toten Fisch.<BR>\n-<BR>\nAntwort B<BR>\nSeeungeheuer gibt es doch gar nicht... oder etwa doch?<BR>\n-<BR>\nAntwort C<BR>\nAus Riesenkraken mach ich Calamares und Weiber liegen mir zu F\195\188ssen.", {PocketPC = 1}),
        Media = zmediaCaptain,
        Buttons = {"Antworten"},
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB102
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-B") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Du Aufschneider! Seemannsgarn kannst du in der Hafenspelunke dem dreik\195\182pfigen Affen erz\195\164hlen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-C") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, du Landratte! Komm wieder, wenn du nicht mehr so gr\195\188n hinter den Ohren bist!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99
      })
    end
  end
end
function zinputPiratIphone3:OnGetInput(input)
  var_PiratAntwort = input
  if var_PiratAntwort ~= nil then
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-A") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Beim Klabautermann, das mit dem toten Fisch wirst du mir b\195\188ssen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB100
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-B") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Arrr, du Landratte! Komm wieder, wenn du nicht mehr so gr\195\188n hinter den Ohren bist!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99
      })
    end
    if Wherigo.NoCaseEquals(var_PiratAntwort, "Antwort-C") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Du Aufschneider! Seemannsgarn kannst du in der Hafenspelunke dem dreik\195\182pfigen Affen erz\195\164hlen! Arrr!", {PocketPC = 1}),
        Media = zmediaCaptain,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98
      })
    end
  end
end
function zinputProtoRep:OnGetInput(input)
  var_ProtoDefekt = input
  if var_ProtoDefekt ~= nil then
    if Wherigo.NoCaseEquals(var_ProtoDefekt, "DABFEC") then
      ztaskProtonPackreparieren.Active = false
      zoneParkdeck.Active = false
      zitemProtonPack.Commands.Reparieren.Enabled = false
      zitemProtonPack.Commands.Aktivieren.Enabled = true
      var_story = var_story + 1
      Wherigo.MessageBox({
        Text = "Das klingt korrekt. Setzten wir den Controller wieder in den Einsatz und dann weiter!",
        Media = zmediaEgonDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB103
      })
    else
      Wherigo.MessageBox({
        Text = [[
Das glaube ich nicht, Tim.<BR>
Das ist definitv falsch, das muss korrigiert werden.]],
        Media = zmediaEgonDialog,
        Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB104
      })
    end
  end
end
function zinputRittermotto:OnGetInput(input)
  var_Rittermotto = input
  if var_Rittermotto ~= nil then
    if Wherigo.NoCaseEquals(var_Rittermotto, "CARPE NOCTEM") or Wherigo.NoCaseEquals(var_Rittermotto, "PECCA FORTITER") or Wherigo.NoCaseEquals(var_Rittermotto, "CARPE NOCTEM PECCA FORTITER") then
      if Wherigo.NoCaseEquals(var_Rittermotto, "CARPE NOCTEM") then
        if var_RitterSiegelTeil == 0 then
          Wherigo.MessageBox({
            Text = WWB_multiplatform_string("Gut! Aber dies ist erst ein Teil, des Siegels! Es zerbrach in zwei H\195\164lften.<BR>\nBringt sie mir und ich la\195\159 euch passieren - Ihr habt mein Wort!", {PocketPC = 1}),
            Media = zmediaRitter,
            Buttons = {
              "Weiter suchen"
            }
          })
          var_RitterSiegelTeil = 1
        elseif var_RitterSiegelTeil == 1 then
          Wherigo.MessageBox({
            Text = WWB_multiplatform_string("Versucht ihr mich etwa zu betr\195\188gen? Da m\195\188sst ihr schon weit fr\195\188her als der Hahn aufstehen! Sucht die zweite H\195\164lfte!", {PocketPC = 1}),
            Media = zmediaRitter
          })
        end
        if var_RitterSiegelTeil == 2 then
          var_RitterSiegelTeil = 3
        end
      end
      if Wherigo.NoCaseEquals(var_Rittermotto, "PECCA FORTITER") then
        if var_RitterSiegelTeil == 0 then
          Wherigo.MessageBox({
            Text = WWB_multiplatform_string("Gut! Aber dies ist erst ein Teil, des Siegels! Es zerbrach in zwei H\195\164lften.<BR>\nBringt sie mir und ich la\195\159 euch passieren - Ihr habt mein Wort!", {PocketPC = 1}),
            Media = zmediaRitter,
            Buttons = {
              "Weiter suchen"
            },
            Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB105
          })
          var_RitterSiegelTeil = 2
        elseif var_RitterSiegelTeil == 2 then
          Wherigo.MessageBox({
            Text = WWB_multiplatform_string("Versucht ihr mich etwa zu betr\195\188gen? Da m\195\188sst ihr schon weit fr\195\188her als der Hahn aufstehen! Sucht die zweite H\195\164lfte!", {PocketPC = 1}),
            Media = zmediaRitter,
            Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB106
          })
        end
        if var_RitterSiegelTeil == 1 then
          var_RitterSiegelTeil = 3
        end
      end
      if Wherigo.NoCaseEquals(var_Rittermotto, "CARPE NOCTEM PECCA FORTITER") then
        var_RitterSiegelTeil = 3
      end
    else
      Wherigo.MessageBox({
        Text = [[
Dies deucht mich, ist nicht so ganz richtig!<BR>
Solange ihr das Siegel nicht findet... keine Passage!]],
        Media = zmediaRitter,
        Buttons = {
          "Weiter suchen"
        }
      })
    end
    if var_RitterSiegelTeil == 3 then
      ztaskFindedasSiegeldesRitters.Complete = true
      Wherigo.Dialog({
        {
          Text = [[
Wahrlich vortrefflich!<BR>
CARPE NOCTEM PECCA FORTITER<BR>
Dies ist das Siegel meines Ordens - HAHAHAHA!!!]],
          Media = zmediaRitter
        },
        {
          Text = WWB_multiplatform_string("Warum, frag ich euch, warum beschleicht mich schon wieder so ein mulmiges Gef\195\188hl?"),
          Media = zmediaPeterDialog
        },
        {
          Text = WWB_multiplatform_string("Eventuell h\195\164ttest du die drei Tage alten Hamburger doch nicht mehr essen sollen Peter!"),
          Media = zmediaEgonDialog
        },
        {
          Text = WWB_multiplatform_string("Ihr W\195\188rmer!<BR>\nCARPE NOCTEM PECCA FORTITER - NUTZE DIE NACHT, S\195\156NDIGE TAPFER! Der Leitspruch unseres Raubritterordens!<BR>\nSo lang war ich auf der Suche. Wohlan! Daf\195\188r soll euer Tod schnell &amp;&amp; nicht qualvoll sein!"),
          Media = zmediaRitter
        },
        {
          Text = "Falle raus! FEUER!",
          Media = zmediaRayDialog
        }
      })
      ztaskFindedasSiegeldesRitters.Active = false
      zcharacterRitter.Commands.Ansprechen.Enabled = false
      zcharacterRitter.Commands.Anpirschen.Enabled = true
      cartGhostbusters:RequestSync()
    end
  end
end
function zinputyouName:OnGetInput(input)
  var_youName = input
  if var_youName ~= nil then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB1(action)
  Wherigo.GetInput(zinputAlterEgo)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB16(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("mmh, gucken wir uns drinnen mal n\195\164her um.", {PocketPC = 1}),
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB17
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB17(action)
  var_bahnhof = var_bahnhof + 1
  ztimerbahnhof:Start()
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB18(action)
  if ztaskFindedasSiegeldesRitters.Active == true then
    Wherigo.GetInput(zinputRittermotto)
  else
    Wherigo.Dialog({
      {Text = "Was?", Media = zmediaAlterEgo},
      {
        Text = [[
Ich sagte: An mir kommt niemand vorbei!<BR>
Ich trete vor niemanden zur Seite!]],
        Media = zmediaRitter
      },
      {
        Text = "Und wenn wir dir Arme und Beine abtrennen?",
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Das w\195\164ren nur Fleischwunden! <BR>\nDoch bringt mir mein Siegel und ich gew\195\164hr euch freies Geleit!"),
        Media = zmediaRitter
      },
      {
        Text = "Mmh, er scheint etwas zu suchen.",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Also ich finde wir sollten ihm einfach eins \195\188berbraten und zu den anderen sperren!"),
        Media = zmediaPeterDialog
      },
      {
        Text = "Peter! Er scheint doch harmlos zu sein, tun wir ihm doch den Gefallen und suchen dieses Siegel... Egon?",
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Ich denke, das er das Siegel seines Ritterordens sucht. Wir sollten uns umgucken. Es w\195\164re interessant, wie er darauf reagiert."),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Okay, okay, okay - \195\188berredet! Aber sagt hinterher nicht, ich h\195\164tte euch nicht gewarnt!"),
        Media = zmediaPeterDialog
      }
    })
    ztaskFindedasSiegeldesRitters.Active = true
  end
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB19(action)
  var_story = var_story + 1
  Aufgaben("1")
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB20(action)
  ztaskFindedasNummernschild.Active = true
  Wherigo.GetInput(zinputEctoSchild)
  zoneAmWasser.Visible = false
  zoneBahnhof.Visible = false
  zoneBruecke.Visible = false
  zoneFriedhof.Visible = false
  zoneFriseur.Visible = false
  zoneHochhaus.Visible = false
  zonePark.Visible = false
  zoneParkdeck.Visible = false
  zoneVideothek.Visible = false
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB21(action)
  Wherigo.PlayAudio(zmediaSoundEcto)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB25(action)
  Wherigo.GetInput(zinputFinal)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB26(action)
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("OH! Ich glaub es konnte mich h\195\182ren!"),
      Media = zmediaPeterDialog
    },
    {
      Text = "WAAAARGH!!!!!!!",
      Media = zmediaSlimer
    },
    {
      Text = "AHHHH! Es schleimte mich voll!",
      Media = zmediaPeterDialog
    },
    {
      Text = "Das ist ja toll! Egon? Venkman wurde vollgeschleimt.",
      Media = zmediaRayDialog
    },
    {
      Text = WWB_multiplatform_string("Gro\195\159artig. Hebt etwas f\195\188r mich auf!"),
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("BAH! H\195\182r mal, jemand schneuzt sich die Nase und du m\195\182chtest das behalten?!"),
      Media = zmediaAlterEgo
    },
    {
      Text = "Hier Egon, dein Sputum.",
      Media = zmediaRayDialog
    },
    {
      Text = WWB_multiplatform_string("Kn\195\182pfen wir uns das Ding vor!"),
      Media = zmediaAlterEgo
    }
  })
  zcharacterSlimer.Visible = true
  var_Slimer = var_Slimer + 1
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB29(action)
  if var_iphone == 1 then
    Wherigo.MessageBox({
      Text = "",
      Media = zmediatempel002,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB30
    })
    Wherigo.PlayAudio(zmediaSoundThunder)
  else
    ztimerTempel:Start()
  end
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB30(action)
  Wherigo.MessageBox({
    Text = "",
    Media = zmediatempel006,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB31
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB31(action)
  Wherigo.MessageBox({
    Text = "",
    Media = zmediatempel008,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB32
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB32(action)
  Wherigo.MessageBox({
    Text = "",
    Media = zmediatempel010,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB33
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB33(action)
  ztaskHaltedensumerischenGottGozerauf.Active = true
  zcharacterGozer.Visible = true
  zcharacterDimensionstor.Visible = true
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Es ist ein M\195\164dchen."),
      Media = zmediaRayDialog
    },
    {
      Text = "Es ist Gozer.",
      Media = zmediaEgonDialog
    },
    {
      Text = "Ich dachte Gozer sei ein Mann.",
      Media = zmediaAlterEgo
    },
    {
      Text = "Es war was immer es sein wollte.",
      Media = zmediaEgonDialog
    },
    {
      Text = "Was immer es ist, es muss uns besiegen Jungs!",
      Media = zmediaPeterDialog
    },
    {Text = "Richtig!", Media = zmediaRayDialog},
    {
      Text = "Los! Hol sie dir Ray!",
      Media = zmediaPeterDialog
    }
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB34(action)
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Die Zeit spielt keine Rolle, auch Jahre sp\195\164ter k\195\182nnen sich an solchen Orten Erscheinungen manifestieren... bei entsprechend negativer Energie..."),
      Media = zmediaEgonDialog
    },
    {
      Text = "Gab es hier denn solch... negative Energie?",
      Media = zmediaAlterEgo
    },
    {
      Text = WWB_multiplatform_string("" .. var_youName .. ", wenn du w\195\188sstes..."),
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Der PKE-Messer schl\195\164gt hier voll aus, das k\195\182nnte ungem\195\188tlich werden!"),
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("\195\132h, Jungs? Dreht euch mal gaaanz laaaangsam um."),
      Media = zmediaRayDialog
    },
    {Text = "*geifer*", Media = zmediaSchatten},
    {
      Text = "*Schluck* Die schwarze Haut schein irgendwie zu... leben?!",
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Es k\195\182nnte sich um eine Art Symbiont handeln."),
      Media = zmediaEgonDialog
    },
    {
      Text = "Heizen wir die Protonenpacks an!",
      Media = zmediaAlterEgo
    }
  })
  zcharacterSchatten.Visible = true
  var_Schatten = var_Schatten + 1
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB35(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB37(action)
  if var_storymain == 1 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Peter, " .. var_youName .. ", geht ihr beiden schon mal mit Dana vor.<BR>\nRay und ich recherchieren in der \195\188blichen Literatur wegen dem Wort Zuul."),
        Media = zmediaEgonDialog
      },
      {
        Text = "Im Spade's Katalog",
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Torence's Gespensterf\195\188hrer"),
        Media = zmediaEgonDialog
      },
      {Text = "Ja.", Media = zmediaRayDialog}
    })
    ztimerZOB:Stop()
    zoneUFO.Active = false
    ztaskRedemitDana.Active = false
    ztaskDasHochhaus.Active = true
    zoneHochhaus.Active = true
    var_storymain = var_storymain + 1
  end
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB38(action)
  Wherigo.MessageBox({
    Text = "War nett mit euch zu arbeiten Jungs!",
    Media = zmediaRayDialog,
    Buttons = {"Schiessen"},
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB39
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB39(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Lo\195\159, bringen wir sie \195\188bereinander!", {PocketPC = 1}),
    Media = zmediaTempelCap1,
    Buttons = {
      WWB_multiplatform_string("Str\195\182me kreuzen", {PocketPC = 1})
    },
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB40
  })
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB40(action)
  Wherigo.MessageBox({
    Text = "HALTET DRAUF!",
    Media = zmediaTempelCap2,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB41
  })
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB41(action)
  Wherigo.MessageBox({
    Text = "*KABUUUUMMMMM*",
    Media = zmediaTempelFire,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB42
  })
  Wherigo.PlayAudio(zmediaSoundExplosion)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB42(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Spengler! Venkman! " .. var_youName .. "!", {PocketPC = 1}),
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB43
  })
  ztaskVolleFalle.Active = false
  ztaskHaltedensumerischenGottGozerauf.Active = false
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB43(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ich f\195\188hle mich wie die Fu\195\159matte in einem Taxi.", {PocketPC = 1}),
    Media = zmediaEgonDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB44
  })
  zoneFeuerwehr.Active = false
  zoneTempel.Active = false
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB44(action)
  Wherigo.MessageBox({
    Text = "Ein toller Plan! Wir haben es geschafft!",
    Media = zmediaPeterDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB45
  })
  zitemFalle.Visible = false
  zitemProtonPack.Visible = false
  zitemVolleFalle.Visible = false
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB45(action)
  Wherigo.PlayAudio(zmediaSoundCrowd)
  Wherigo.MessageBox({
    Text = "Ich liebe diesen Job!!",
    Media = zmediaAlterEgo,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB46
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB46(action)
  Wherigo.MessageBox({
    Text = "",
    Media = zmediaEnde,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB47
  })
  Wherigo.PlayAudio(zmediaSoundTitle)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB47(action)
  Wherigo.MessageBox({
    Text = [[
Sehr gut!<BR>
Gehe jetzt zur Final-Zone.]],
    Media = zmediathavorianer,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB48
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB48(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  zoneFinal.Active = true
  ztaskGehezurFinalZoneundfindedenCache.Active = true
  cartGhostbusters:RequestSync()
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB49(action)
  zcharacterEngel.Commands.Angucken.Enabled = false
  zcharacterEngel.Commands.Ansprechen.Enabled = true
  Wherigo.Dialog({
    {
      Text = "Wer bist du?",
      Media = zmediaAlterEgo
    },
    {
      Text = "Der Schwarze Tod... Wann starb meine Familie?",
      Media = zmediaAngel_open
    },
    {
      Text = "Ich... Wir wissen es nicht...",
      Media = zmediaPeterDialog
    },
    {
      Text = "Wann... Wann starb meine Familie?",
      Media = zmediaAngel_open
    },
    {Text = "...", Media = zmediaAlterEgo},
    {
      Text = "Er hat sie geholt... Warum? Wann?",
      Media = zmediaAngel
    },
    {
      Text = WWB_multiplatform_string("Ein eindeutiger Fall von postmortalem Traumata - Wiederkehr aufgrund dr\195\164ngender Kl\195\164rung."),
      Media = zmediaEgonDialog
    },
    {
      Text = "Du meinst... wir sollen die Antwort finden und dann verschindet er?",
      Media = zmediaAlterEgo
    },
    {
      Text = WWB_multiplatform_string("Korrekt, das ist durchaus m\195\182glich! <BR>\nGucken wir, ob wir hier irgendwo die Information finden..."),
      Media = zmediaEgonDialog
    }
  })
  ztaskWannkamderSchwarzeTod.Active = true
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB53(action)
  var_story = var_story + 1
  zcharacterEngel.Visible = false
  zoneFriedhof.Active = false
  ztaskDerFriedhof.Complete = true
  ztaskDerFriedhof.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54(action)
  ProtoAus("1")
  if var_story >= 12 then
  else
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("*Per Funk* <BR>\nJungs, neue Ziele! <BR>\nGuckt in eure Auftr\195\164ge.", {PocketPC = 1}),
      Media = zmediaJanineTask,
      Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB55
    })
  end
  if var_story == 13 then
    ztaskZurueckzurFeuerwehr.Active = true
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Merkw\195\188rdig... die ganze Zeit Geistermeldungen und nun Ruhe... die Ruhe vor dem Sturm?<BR>\nJungs, wir sollten schnell zur\195\188ck zur Station!", {PocketPC = 1}),
      Media = zmediaPeterDialog
    })
  end
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB55(action)
  Aufgaben("1")
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB57(action)
  zcharacterFlammenteufel.Visible = false
  ztaskDasParkdeck.Active = false
  ztaskProtonPackreparieren.Active = true
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Und noch einer f\195\188r den Hauptspeicher!<BR>\nPeter? Guck mal bei Egon auf's Protopack, ich glaub da ist was abgerissen...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB58
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB58(action)
  ProtoAus("1")
  zitemProtonPack.Commands.Aktivieren.Enabled = false
  zitemProtonPack.Commands.Reparieren.Enabled = true
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Egon, irgendwie wurde dein Controller f\195\188r's Synchrotron abgerissen. Das muss ja gerade eben erst passiert sein, es muss hier also irgendwo rumliegen. Sucht mal mit Jungs!", {PocketPC = 1}),
    Media = zmediaPeterDialog,
    Buttons = {
      "Controller gefunden"
    },
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB59
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB59(action)
  Wherigo.GetInput(zinputProtoRep)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB60(action)
  var_story = var_story + 1
  zcharacterGeisterzug.Visible = false
  zoneBahnsteig.Active = false
  ztaskDerBahnhof.Complete = true
  ztaskDerBahnhof.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB62(action)
  Wherigo.MessageBox({
    Text = "Das reicht ja wohl, danke vielmals Ray!",
    Media = zmediaPeterDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB63
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB63(action)
  Wherigo.GetInput(zinputGozer)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB64(action)
  var_story = var_story + 1
  zcharacterHomunculus.Visible = false
  zoneFriseur.Active = false
  ztaskDerFriseur.Active = false
  ztaskDerFriseur.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB65(action)
  var_story = var_story + 1
  zcharacterLepusUmbra.Visible = false
  zonePark9.Active = false
  ztaskDerPark.Active = false
  ztaskDerPark.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB66(action)
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Vinz Clortho - Schl\195\188sselmeister von Gozer"),
      Media = zmediaLouisPossesed
    },
    {
      Text = "Nachdem was in seinem Ausweis steht ist sein Name Louis Tully. Er wohnt im selben Apartmenthaus wie Dana Barrett!",
      Media = zmediaJanine
    },
    {
      Text = WWB_multiplatform_string("Mensch, " .. var_youName .. ", das ist doch der Nachbar von Dana! Jetzt erkenne ich den wieder."),
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Ja, stimmt!<BR>\nDa kommt Ray zur\195\188ck."),
      Media = zmediaAlterEgo
    }
  })
  zcharacterLouis.Name = "Vinz"
  zcharacterLouis.Description = WWB_multiplatform_string("D\195\164mon Vinz Clortho, der \"Schl\195\188sselmeister\" aka Louis Tully")
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB67(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("1.. 2.. 3.. R\195\150STET IHN!", {PocketPC = 1}),
    Media = zmediaRayDialog,
    Buttons = {"Schiessen"},
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB68
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB68(action)
  Wherigo.PlayAudio(zmediaSoundProtoFIRE)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Protonenstr\195\182me setzten den Marshmallow-Mann in brand, ansonsten zeigen sie keine Wirkung. Im Gegenteil, er scheint sauer zu sein und klettert nun das Haus hoch zum Tempel.", {PocketPC = 1}),
    Media = zmediaPuffyCap,
    Buttons = {
      "In Deckung gehen"
    },
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB69
  })
  zcharacterMarshmallowMann.Media = zmediaPuffyFire
  zcharacterMarshmallowMann.Description = WWB_multiplatform_string("Der allseits beliebte Marshmallow-Mann in Flammen. Der leckere Geruch t\195\164uscht allerdings nicht \195\188ber die heran nahende Gefahr hinweg.")
  zcharacterMarshmallowMann.Commands.Schiessen.Enabled = false
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB69(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Komisch, dass wir auf diese Weise dahinscheiden... get\195\182tet von einem 30m Marshmallow-Mann.<BR>\nGuckt euch um, uns muss schnell was einfallen! Sonst...", {PocketPC = 1}),
    Media = zmediaRayDialog,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB70
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB70(action)
  zcharacterDimensionstor.Commands.Angucken.Enabled = true
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB71(action)
  Wherigo.GetInput(zinputPiratIphone1)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB72(action)
  var_story = var_story + 1
  zcharacterPirat.Visible = false
  zoneAmWasser.Active = false
  ztaskAmWasser.Active = false
  ztaskAmWasser.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB73(action)
  if Wherigo.NoCaseEquals(var_AlterEgo, "Frau") then
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Hi, ich bin " .. var_youName .. ". Ich habe die Anzeige gelesen und wollte mich als Geisterj\195\164ger... &nbsp;bewerben... sozusagen..."),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Das ist gut, eine f\195\164hige Frau im Team wirkt ausgleichend!<BR>\nGlauben sie an Geister oder andere paranormale Erscheinungen?"),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Wenn ein regelm\195\164\195\159iges Gehalt drin ist, glaube ich an alles, was Sie sagen."),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Gut! Ah, da sind ja deine zuk\195\188nftigen Kollegen - darf ich vorstellen?<BR>\nDr. Peter Venkman und Dr. Egon Spengler. Jungs, sagt Hallo zu " .. var_youName .. "."),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Hallo!<BR>\n(Ein kurzes L\195\164cheln huscht \195\188ber Egon's Gesicht)"),
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Ah, eine weibliche Verst\195\164rkung. Ich bin Peter."),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Wir sollten uns unbedingt sp\195\164ter zusammen setzten, damit ich dir gewisse Grundlagen beibringen kann..."),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("" .. var_youName .. ", wie w\195\164re es, wenn ich dich um Acht abhole?"),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("\195\164hm, ja..."),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Entschuldigung, ein dringender Anruf. Ein Hotel hat gewisse \"Schwierigkeiten\". Die bitten um sofortige diskrete L\195\182sung des Problems!"),
        Media = zmediaJanineTask
      },
      {
        Text = WWB_multiplatform_string("Da haben wir ja " .. var_youName .. "'s erste Bew\195\164hrungsprobe."),
        Media = zmediaRayDialog
      },
      {
        Text = "Okay, auf zu meinem ersten Einsatz.",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Es wird dir gefallen! Glaub mir!<BR>\nVergi\195\159 nicht deine Ausr\195\188stung mitzunehmen."),
        Media = zmediaRayDialog
      }
    })
  else
    Wherigo.Dialog({
      {
        Text = WWB_multiplatform_string("Hi, ich bin " .. var_youName .. ". Ich habe die Anzeige gelesen und wollte mich als Geisterj\195\164ger... &nbsp;bewerben... sozusagen..."),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Das ist gut, wir k\195\182nnen einen f\195\164higen Mann gebrauchen!<BR>\nGlauben sie an Geister oder andere paranormale Erscheinungen?"),
        Media = zmediaRayDialog
      },
      {
        Text = WWB_multiplatform_string("Wenn ein regelm\195\164\195\159iges Gehalt drin ist, glaube ich an alles, was Sie sagen."),
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Gut! Ah, da sind ja deine zuk\195\188nftigen Kollegen - darf ich vorstellen?<BR>\nDr. Peter Venkman und Dr. Egon Spengler. Jungs, sagt Hallo zu " .. var_youName .. "."),
        Media = zmediaRayDialog
      },
      {
        Text = [[
Hallo!<BR>
(Egon betrachtet dich von oben nach unten)]],
        Media = zmediaEgonDialog
      },
      {
        Text = WWB_multiplatform_string("Sehr sch\195\182n, sehr sch\195\182n - ein vierter Geisterj\195\164ger verringert das Risiko f\195\188r die anderen Drei."),
        Media = zmediaPeterDialog
      },
      {
        Text = WWB_multiplatform_string("Entschuldigung, ein dringender Anruf. Ein Hotel hat gewisse \"Schwierigkeiten\". Die bitten um sofortige diskrete L\195\182sung des Problems!"),
        Media = zmediaJanineTask
      },
      {
        Text = WWB_multiplatform_string("Da haben wir ja " .. var_youName .. "'s erste Bew\195\164hrungsprobe."),
        Media = zmediaRayDialog
      },
      {
        Text = "Okay, auf zu meinem ersten Einsatz.",
        Media = zmediaAlterEgo
      },
      {
        Text = WWB_multiplatform_string("Es wird dir gefallen! Glaub mir!<BR>\nVergi\195\159 nicht deine Ausr\195\188stung mitzunehmen."),
        Media = zmediaRayDialog
      }
    })
  end
  zitemFalle.Visible = true
  zitemProtonPack.Visible = true
  ztaskDasHotel.Active = true
  zoneHotel.Active = true
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB74(action)
  var_story = var_story + 1
  zcharacterRitter.Visible = false
  zoneBruecke.Active = false
  ztaskAufderBruecke.Active = false
  ztaskAufderBruecke.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB75(action)
  zcharacterSchatten.Visible = false
  zoneVideothek.Visible = false
  ztaskDieVideothek.Complete = true
  ztaskDieVideothek.Active = false
  ztaskDieVideothek.Visible = false
  ztaskFalleueberlastet.Active = true
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Boah, das Vieh war heftig! Aber es ist ja nun zum Gl\195\188ck in der Falle gefangen. <BR>\nWir haben noch " .. var_xFalle .. " ungebrauchte Fallen im ... &nbsp;AUTSCH! Die Falle ist tierisch heiss!", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB76
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB76(action)
  Wherigo.PlayAudio(zmediaSoundSpark)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Die Falle scheint \195\188berhitzt zu sein! Schnell! SCHNELL!! WIR M\195\156SSEN SIE SOFORT IN DEN HAUPTSPEICHER ENTLADEN!!!", {PocketPC = 1}),
    Media = zmediaTrapMalfunction,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB77
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB77(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB78(action)
  var_story = var_story + 1
  zcharacterSlimer.Visible = false
  zoneHotel.Active = false
  ztaskDasHotel.Complete = true
  ztaskDasHotel.Visible = false
  Falle("1")
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Du wirst nie wieder einen Mann vollschleimen, der einen Positronen-Kollidierer hat! <BR>
Bringe ihn jetzt schnell zur Station ]] .. var_youName .. " und entlade die Falle in unserem Sicherheitssystem.<BR>\nUnd das Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB79
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB79(action)
  ProtoAus("1")
  cartGhostbusters:RequestSync()
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB83(action)
  var_story = var_story + 1
  zoneVideothek.Active = false
  ztaskFalleueberlastet.Complete = true
  ztaskFalleueberlastet.Active = false
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Ah, ihr seid ja alle hier, ich wollte euch gerade anfunken. Wieder ein neuer Fall, was ist pl\195\182tzlich bloss los hier?", {PocketPC = 1}),
    Media = zmediaJanineTask,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB84
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB84(action)
  Aufgaben("1")
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB86(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  ztaskWerbautedasApartmenthaus.Active = false
  if var_story == 13 then
    ztaskZurueckzurFeuerwehr.Active = true
  end
  zcharacterDana.Visible = false
  zoneHochhaus.Active = false
  var_storymain = var_storymain + 1
  if var_UFO == 0 then
    ztimerZOB:Start()
  elseif Wherigo.NoCaseEquals(var_KangBuch, "Ja") then
  else
    zoneUFO.Active = true
  end
  cartGhostbusters:RequestSync()
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB88(action)
  Wherigo.GetInput(zinputBahnhof)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB90(action)
  cartGhostbusters:RequestSync()
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB91(action)
  Wherigo.GetInput(zinputEctoSchild)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB92(action)
  Wherigo.Command("DriveTo")
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB93(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Seid leise und euch sicher,<BR>\ndass kein Uneingeweihter sp\195\164ht,<BR>\nhabt den richtigen Riecher,<BR>\nheimlich Ihr nach hinten geht.<BR>\n<BR>\nDer Titan Prometheus stahl Zeus das Feuer, <BR>\nbracht's den sterblichen Mensch auf Erden. <BR>\nIn eben jenem Schein steht das eiserne Gem\195\164uer <BR>\nund keine H\195\182h' muss erklommen werden. <BR>\n<BR>\nEin kleiner Schl\195\188ssel ist versteckt recht nah,<BR>\nan ihm h\195\164ngt auch ein kleines Helferlein,<BR>\nsucht sie hier und sucht sie da,<BR>\nfinden werdet Ihr sie durch's Fenster rein.<BR>\n<BR>\nKeine Gewalt tut Not !!!<BR>\nSelbst ein Kind schafft's ohne beben.<BR>\nEin genauer Blick ist oberstes Gebot,<BR>\ndenn zuerst das Helferlein muss heben.<BR>\n<BR>\nFrei ist der Weg nun endlich,<BR>\ndreht den Schl\195\188ssel nun rechts herum.<BR>\nH\195\182rt nochmal ob keiner n\195\164hert sich,<BR>\ndann \195\182ffnet das Tor ganz stumm.", {PocketPC = 1}),
    Media = zmediathavorianer,
    Buttons = {"Fund"},
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB25
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB94(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB95(action)
  Wherigo.Dialog({
    {
      Text = WWB_multiplatform_string("Ja, echt klasse Preis! Wir kommen darauf zur\195\188ck!"),
      Media = zmediaPeterDialog
    },
    {
      Text = WWB_multiplatform_string("Okay, ich mu\195\159 dann auch wieder rein, meine Gesch\195\164ftsparty vorbereiten! Hey, wenn ihr wollt, k\195\182nnt ihr heut Abend auch kommen, hier ist meine Karte, ich notier euch die Uhrzeit."),
      Media = zmediaLouis
    },
    {
      Text = WWB_multiplatform_string("Ja, \195\164hm, danke Louis! Wir gucken, ob unsere Termine das zu lassen, versprochen."),
      Media = zmediaAlterEgo
    },
    {
      Text = "Wir sehen uns dann auf der Party. Du auch Dana!",
      Media = zmediaLouis
    },
    {
      Text = WWB_multiplatform_string("Louis! Tsch\195\188ss!<BR>\nGehen wir jetzt bitte endlich in meine Wohnung?"),
      Media = zmediaDana
    },
    {
      Text = "Hallo, haben wir was verpasst?",
      Media = zmediaRayDialog
    },
    {
      Text = "Bis auf Louis nichts!",
      Media = zmediaAlterEgo
    },
    {
      Text = WWB_multiplatform_string("H\195\164?<BR>\nAlso, der Name Zuul bezieht sich auf einen Halbgott der so etwa 6000 v.Chr. von den... wie hiessen die?"),
      Media = zmediaRayDialog
    },
    {
      Text = "Hethitern verehrt wurde - im antiken Mesopotamien &amp;&amp; Sumer",
      Media = zmediaEgonDialog
    },
    {
      Text = WWB_multiplatform_string("Zuul war der G\195\188nstling von Gozer."),
      Media = zmediaRayDialog
    },
    {
      Text = "Wer ist Gozer?",
      Media = zmediaDana
    },
    {
      Text = "Gozer war der Obermotz in Sumer",
      Media = zmediaRayDialog
    },
    {
      Text = WWB_multiplatform_string("Ja, kann sein, aber was macht der in meinem K\195\188hlschrank?"),
      Media = zmediaDana
    },
    {
      Text = "Daran arbeiten wir noch.",
      Media = zmediaRayDialog
    },
    {
      Text = WWB_multiplatform_string("Wir sollten uns mal n\195\164her mit den Architekten des Geb\195\164udes befassen."),
      Media = zmediaEgonDialog
    }
  })
  ztaskWerbautedasApartmenthaus.Active = true
  var_storymain = var_storymain + 1
  zcharacterLouis.Visible = false
  ztaskAngebotvonLouis.Active = false
  zcharacterDana.Commands.Reden.Enabled = true
  zcharacterEgon:MoveTo(zoneHochhaus)
  zcharacterRay:MoveTo(zoneHochhaus)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB96(action)
  Wherigo.GetInput(zinputLouis)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB98(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB99(action)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB100(action)
  zcharacterPirat.Commands.Ansprechen.Enabled = false
  zcharacterPirat.Commands.Anpirschen.Enabled = true
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB101(action)
  Wherigo.GetInput(zinputPiratIphone2)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB102(action)
  Wherigo.GetInput(zinputPiratIphone3)
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB103(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string([[
Saubere Arbeit! Der Geist ist jetzt in der Falle gefangen. <BR>
Wir haben noch ]] .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.<BR>\nDas Proton-Pack schalten wir f\195\188r die R\195\188ckfahrt besser mal aus...", {PocketPC = 1}),
    Media = zmediaRayActionTrap,
    Callback = cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB54
  })
end
function cartGhostbusters.MsgBoxCBFuncs.MsgBoxCB104(action)
  Wherigo.GetInput(zinputProtoRep)
end
function Aufgaben(x)
  if var_story == 5 then
    zoneFriedhof.Active = true
    ztaskDerFriedhof.Active = true
    zoneFriseur.Active = true
    ztaskDerFriseur.Active = true
    ztimerZOB:Start()
  end
  if var_story == 6 then
    zoneBruecke.Active = true
    ztaskAufderBruecke.Active = true
  end
  if var_story == 7 then
    zoneAmWasser.Active = true
    ztaskAmWasser.Active = true
  end
  if var_story == 8 then
    zoneBahnhof.Active = true
    ztaskDerBahnhof.Active = true
  end
  if var_story == 9 then
    zoneVideothek.Active = true
    ztaskDieVideothek.Active = true
  end
  if var_story == 10 then
    zoneParkdeck.Active = true
    ztaskDasParkdeck.Active = true
  end
  if var_story == 11 then
    zonePark.Active = true
    ztaskDerPark.Active = true
  end
  cartGhostbusters:RequestSync()
end
function Falle(x)
  Wherigo.PlayAudio(zmediaSoundTrapON)
  var_xFalle = var_xFalle - 1
  var_volleFalle = var_volleFalle + 1
  ztaskVolleFalle.Active = true
  if var_xFalle == 1 then
    zitemFalle.Description = WWB_multiplatform_string("Du hast nur noch eine ungebrauchte Fallen im Gep\195\164ck.")
  else
    zitemFalle.Description = WWB_multiplatform_string("Du hast " .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.")
  end
  if var_volleFalle == 1 then
    zitemVolleFalle.Description = "Du hast eine Falle randvoll mit Protoplasma - Igitt! Schnell zum Hauptspeicher bei der Station bringen."
  else
    zitemVolleFalle.Description = WWB_multiplatform_string("Du hast " .. var_volleFalle .. " Fallen randvoll mit Protoplasma - Igitt! Schnell zum Hauptspeicher bei der Station bringen.")
  end
  zitemVolleFalle.Visible = true
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    zitemFalle.Visible = false
  end
end
function Fallekaputt(x)
  Wherigo.PlayAudio(zmediaSoundSpark)
  var_volleFalle = var_volleFalle - 1
  var_defekteFalle = var_defekteFalle + 1
  ztaskFalledefekt.Active = true
  if var_volleFalle == 0 then
    ztaskVolleFalle.Active = false
    zitemVolleFalle.Visible = false
  end
  if var_xFalle == 1 then
    zitemFalle.Description = WWB_multiplatform_string("Du hast nur noch eine ungebrauchte Fallen im Gep\195\164ck.")
  else
    zitemFalle.Description = WWB_multiplatform_string("Du hast " .. var_xFalle .. " ungebrauchte Fallen im Gep\195\164ck.")
  end
  if var_defekteFalle == 1 then
    zitemDefekteFalle.Description = WWB_multiplatform_string("Tja, die ist hin\195\188ber. Da hilft nur noch die Entsorgung.")
  else
    zitemDefekteFalle.Description = WWB_multiplatform_string("Tja, die " .. var_defekteFalle .. " sind hin\195\188ber. Da hilft nur noch die Entsorgung.")
  end
  zitemDefekteFalle.Visible = true
  if var_xFalle == 0 or not Player:Contains(zitemFalle) then
    zitemFalle.Visible = false
  end
end
function ProtoAus(x)
  Wherigo.PlayAudio(zmediaSoundProtoOFF)
  zitemProtonPack.Opened = false
  zitemProtonPack.Commands.Deaktivieren.Enabled = false
  zitemProtonPack.Media = zmediaProtoPack
  zitemProtonPack.Description = WWB_multiplatform_string("Du tr\195\164gst das Proton-Pack auf deinem R\195\188cken.")
  zitemProtonPack.Commands.Aktivieren.Enabled = true
end
return cartGhostbusters
