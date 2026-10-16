require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _Eg9m(str)
  local res = ""
  local dtable = "\014X\0192<B%VPa6wr:1\fO0;@fCvm>.7)*E`$\\^I'c\nJ4 =\000\aS\016t!-s|\023M\0229\027\015\002dT\028FH+5\025q\021\r_3\005\031jp]{\026\boyxu\"h}\004\029\017kn?,\003LDY\020#&QgA[\030N\vWU/\018b\024eGK8iz\006Z~\001lR\t("
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
_Urwigo.InlineModuleFunc = {
  [0] = function()
    function captureZ()
      verfuegbareSperren = gesamtzahlSperren
      for k, v in ipairs(topo[currentZoneAgent]) do
        setGFInZone(v)
      end
    end
  end,
  [2] = function()
    mwc_a = 2
    mwc_b = 524287
    mwc_c = 0
    mwc_x = 0
    init = false
    function initMwc(start)
      mwc_x = start % mwc_b
      mwc_c = (start - mwc_x) / mwc_b
      for i = 0, 100 do
        mwc()
      end
      init = true
    end
    function mwc()
      p = mwc_a * mwc_x + mwc_c
      mwc_x = p % mwc_b
      mwc_c = (p - mwc_x) / mwc_b
      return mwc_x
    end
    function myRandom(top)
      if top > 0 then
        rnd = mwc() % top + 1
        return rnd
      else
        return 0
      end
    end
    function isMwcInit()
      return init
    end
    function setMwcUninitialized()
      init = false
    end
    function saveMwcToCartridge(myCartridge)
      myCartridge.ZVariables.mwc_a = mwc_a
      myCartridge.ZVariables.mwc_b = mwc_b
      myCartridge.ZVariables.mwc_c = mwc_c
      myCartridge.ZVariables.mwc_x = mwc_x
    end
    function testMwc()
      limit = 100000
      numdiff = 2
      initMwc(4294967295)
      c = {}
      b = {}
      abwmin = limit
      for j = 2, 1000 do
        mwc_a = j
        for i = 1, numdiff do
          c[i] = 0
          b[i] = 0
        end
        abwsum = 0
        for i = 1, limit do
          a = myRandom(numdiff)
          c[a] = c[a] + 1
        end
        for i = 1, numdiff do
          b[i] = math.abs(c[i] - limit / numdiff)
          abwsum = abwsum + b[i]
        end
        if abwsum < abwmin then
          abwmin = abwsum
          print((("mwc_a = " .. mwc_a) .. ": abwsum =") .. abwsum)
        end
      end
    end
  end,
  [3] = function()
    function resize_zone(zone, size)
      if zone.last_resize == nil then
        zone.last_resize = 0
      end
      if zone.last_resize == size then
        return
      end
      zone.last_resize = size
      local active = zone.Active
      zone.Active = false
      local median_lat = 0
      local median_long = 0
      if size < 0 then
        if zone.oldPoints ~= nil then
          zone.Points = zone.oldPoints
        end
      else
        for i = 1, #zone.Points do
          median_lat = median_lat + zone.Points[i].latitude
          median_long = median_long + zone.Points[i].longitude
        end
        median_lat = median_lat / #zone.Points
        median_long = median_long / #zone.Points
        local ref_point = ZonePoint(median_lat, median_long, 0)
        zone.oldPoints = zone.Points
        zone.Points = Calc_New_Points(zone, ref_point, size)
      end
      zone.Active = active
    end
    function Calc_New_Points(zone, ref_point, size)
      local points = {}
      for i = 1, #zone.Points do
        local dn, b = calc_dist_bearing(ref_point, zone.Points[i])
        dn = dn + size
        local new_dist = Wherigo.Distance(dn, "m")
        local ZP = Wherigo.TranslatePoint(ref_point, new_dist, b)
        table.insert(points, ZP)
      end
      return points
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
  end,
  [5] = function()
    function PlaySound(sound)
      if Env.DeviceID ~= "Desktop" then
        Wherigo.PlayAudio(sound)
      end
    end
  end,
  [4] = function()
    _Urwigo.InlineRequire(5)
    sperrPositionen = {}
    allowed = {}
    for i = 1, 34 do
      allowed[i] = true
    end
    function initGeofences(myCartridge)
      myCartridge.ZVariables.allowed = allowed
      myCartridge.ZVariables.sperrPositionen = sperrPositionen
    end
    function isGFAllowedInPlayerZone()
      return isGFSetAllowed(currentZonePlayer)
    end
    function isGFSetAllowed(gfZone)
      if gfZone < 1 or gfZone > 34 then
        return false
      end
      return allowed[gfZone]
    end
    function isGFRemoveAllowed(gfZone)
      if gfZone < 1 or gfZone > 34 then
        return false
      end
      return not allowed[gfZone]
    end
    function setBlockedGFChoices()
      removeFreeGF.Choices = {}
      for i = 1, 34 do
        if not allowed[i] then
          table.insert(removeFreeGF.Choices, tostring(i))
        end
      end
    end
    function setFreeGFChoices()
      setFreeGF.Choices = {}
      for i = 1, 34 do
        if allowed[i] then
          table.insert(setFreeGF.Choices, tostring(i))
        end
      end
    end
    function setGFinAnyZone(gfZone)
      PlaySound(beepSetGf)
      setGFInZone(gfZone)
    end
    function setGFInZone(gfZone)
      if verfuegbareSperren > 0 and allowed[gfZone] == true then
        verfuegbareSperren = verfuegbareSperren - 1
        sperrPositionen[gesamtzahlSperren - verfuegbareSperren] = gfZone
        allowed[gfZone] = false
        table.insert(activeZonesOnMap, zones[gfZone])
        jagdLog = (((jagdLog .. CR) .. "+GF:") .. gfZone) .. "; "
        geofences.Name = ("Geofences [" .. verfuegbareSperren) .. "]"
      end
    end
    function removeGFFromZone(gfZone)
      if allowed[gfZone] == false then
        for k, v in ipairs(sperrPositionen) do
          if v == gfZone then
            sperrPositionen[k] = sperrPositionen[gesamtzahlSperren - verfuegbareSperren]
            sperrPositionen[gesamtzahlSperren - verfuegbareSperren] = nil
            verfuegbareSperren = verfuegbareSperren + 1
            allowed[gfZone] = true
            if gfZone == currentZonePlayer then
              zones[gfZone].Name = ("Zone " .. gfZone) .. " [X]"
            else
              zones[gfZone].Name = "Zone " .. gfZone
            end
            jagdLog = (((jagdLog .. CR) .. "-GF:") .. gfZone) .. "; "
          end
        end
      end
    end
    function setThreeRandomGF()
      PlaySound(beepSetGf)
      local gfPos = 0
      for i = 1, 3 do
        repeat
          gfPos = myRandom(34)
        until allowed[gfPos]
        log("Random GF in " .. gfPos)
        setGFInZone(gfPos)
      end
      updateSperren()
    end
    function setGFInPlayerZone()
      PlaySound(beepSetGf)
      setGFInZone(currentZonePlayer)
      showActiveGeofenceInCurrentZonePlayer()
      updateSperren()
    end
    function removeGF()
      PlaySound(beepRemoveGf)
      removeGFFromZone(currentZonePlayer)
      updateSperren()
    end
    function getSperrenMode()
      for i = 1, gesamtzahlSperren - verfuegbareSperren do
        if sperrPositionen[i] == currentZonePlayer then
          return 1
        end
      end
      if verfuegbareSperren > 0 then
        return 2
      else
        return 0
      end
    end
    function getSperrenName()
      table.sort(sperrPositionen)
      if verfuegbareSperren == gesamtzahlSperren then
        return "GF in: keine"
      else
        local sName = "GF in: "
        for i = 1, gesamtzahlSperren - verfuegbareSperren do
          sName = (sName .. sperrPositionen[i]) .. ", "
        end
        sName = string.sub(sName, 1, string.len(sName) - 2)
        return sName
      end
    end
    function updateSperren()
      sperrenMode = getSperrenMode()
      if sperrenMode == 1 then
        geofences.Commands.Aufstellen.Enabled = false
        geofences.Commands.Abbauen.Enabled = true
      elseif sperrenMode == 2 then
        geofences.Commands.Aufstellen.Enabled = true
        geofences.Commands.Abbauen.Enabled = false
      else
        geofences.Commands.Aufstellen.Enabled = false
        geofences.Commands.Abbauen.Enabled = false
      end
      gfTask.Name = tostring(getSperrenName())
      geofences.Name = ("Geofences [" .. verfuegbareSperren) .. "]"
    end
    function getSelectedZoneString(blatt)
      local sName = "Zonen: "
      for i = 1, gesamtzahlSperren - verfuegbareSperren do
        if i == blatt then
          sName = ((sName .. "(") .. sperrPositionen[i]) .. "), "
        else
          sName = (sName .. sperrPositionen[i]) .. ", "
        end
      end
      sName = string.sub(sName, 1, string.len(sName) - 2)
      return sName
    end
    function showActiveGeofenceInCurrentZonePlayer()
      if allowed[currentZonePlayer] == false then
        myGeofence:MoveTo(zones[currentZonePlayer])
        zones[currentZonePlayer].Name = ("Zone " .. currentZonePlayer) .. " [GF, X]"
      end
    end
    function getAllAllowed()
      return allowed
    end
  end,
  [6] = function()
    topo = {}
    topo[1] = {
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      13
    }
    topo[2] = {
      1,
      3,
      9,
      23
    }
    topo[3] = {
      1,
      2,
      4
    }
    topo[4] = {
      1,
      3,
      11,
      12
    }
    topo[5] = {
      1,
      6,
      14,
      16
    }
    topo[6] = {
      1,
      5,
      7,
      16
    }
    topo[7] = {
      1,
      6,
      17,
      19
    }
    topo[8] = {
      1,
      9,
      19,
      21
    }
    topo[9] = {
      2,
      8,
      10,
      22
    }
    topo[10] = {9}
    topo[11] = {
      4,
      23,
      27
    }
    topo[12] = {
      4,
      13,
      28
    }
    topo[13] = {
      1,
      12,
      14,
      29
    }
    topo[14] = {
      5,
      13,
      15,
      30
    }
    topo[15] = {
      14,
      16,
      31
    }
    topo[16] = {
      5,
      6,
      15,
      17,
      32,
      33
    }
    topo[17] = {
      7,
      16,
      34
    }
    topo[18] = {19}
    topo[19] = {
      7,
      8,
      18,
      20
    }
    topo[20] = {
      19,
      21,
      34
    }
    topo[21] = {
      8,
      20,
      22
    }
    topo[22] = {
      9,
      21,
      23
    }
    topo[23] = {
      2,
      11,
      22,
      24
    }
    topo[24] = {
      23,
      25,
      26
    }
    topo[25] = {
      24,
      26,
      27
    }
    topo[26] = {
      24,
      25,
      27
    }
    topo[27] = {
      11,
      25,
      26,
      28
    }
    topo[28] = {
      12,
      27,
      29
    }
    topo[29] = {
      13,
      28,
      30
    }
    topo[30] = {
      14,
      29,
      31
    }
    topo[31] = {
      15,
      30,
      32
    }
    topo[32] = {
      16,
      31,
      33
    }
    topo[33] = {
      16,
      32,
      34
    }
    topo[34] = {
      17,
      20,
      33
    }
    dist = {}
    function numTopoItems(x)
      num = 0
      for k, v in ipairs(topo[x]) do
        num = num + 1
      end
      return num
    end
    function calcDist()
      for myFrom = 1, 34 do
        dist[myFrom] = {}
        for myTo = 1, 34 do
          dist[myFrom][myTo] = 100
          if myFrom == myTo then
            dist[myFrom][myTo] = 0
          end
        end
      end
      for myFrom = 1, 34 do
        for i, v in ipairs(topo[myFrom]) do
          dist[myFrom][v] = 1
          dist[v][myFrom] = 1
        end
      end
      for k = 1, 34 do
        for i = 1, 34 do
          for j = 1, 34 do
            dist[i][j] = math.min(dist[i][j], dist[i][k] + dist[k][j])
          end
        end
      end
    end
    calcDist()
    function saveDistToCartridge(myCartridge)
      myCartridge.ZVariables.dist = dist
      myCartridge.ZVariables.topo = topo
    end
    function showDists()
      for x = 1, 34 do
        for y = 1, 34 do
          print((((("dist[" .. x) .. "][") .. y) .. "] = ") .. dist[x][y])
        end
      end
    end
    function getNextMovePossibilities(myZone, myCurrentZonePlayer, myLastZonePlayer, myAllowed)
      local moves = {}
      numFirstMoves = 0
      for i, firstMove in ipairs(topo[myZone]) do
        if myAllowed[firstMove] and firstMove ~= myCurrentZonePlayer and firstMove ~= myLastZonePlayer then
          secondMoves = {}
          numSecondMoves = 0
          for j, secondMove in ipairs(topo[firstMove]) do
            if myAllowed[secondMove] and secondMove ~= firstMove then
              table.insert(secondMoves, secondMove)
              numSecondMoves = numSecondMoves + 1
            end
            secondMoves.num = numSecondMoves
          end
          table.insert(moves, firstMove, secondMoves)
          numFirstMoves = numFirstMoves + 1
        end
        moves.num = numFirstMoves
      end
      return moves
    end
    function getFarestMoves(myMoves, myCurrentZonePlayer)
      maxFirstDist = 0
      local farestMoves = {}
      for first, v in pairs(myMoves) do
        if first ~= "num" then
          myDist = dist[first][myCurrentZonePlayer]
          if myDist >= maxFirstDist then
            maxFirstDist = myDist
            farestMoves[first] = myDist
          end
        end
      end
      for move, dist in pairs(farestMoves) do
        if dist < maxFirstDist then
          farestMoves[move] = nil
        end
      end
      return farestMoves
    end
    function findBestMove(myMoves, myFarestMoves, myCurrentZonePlayer)
      bestMove = 0
      farestDistSecondMove = 0
      for move, myDist in pairs(myFarestMoves) do
        for i, second in pairs(myMoves[move]) do
          if dist[second][myCurrentZonePlayer] > farestDistSecondMove then
            farestDistSecondMove = dist[second][myCurrentZonePlayer]
            bestMove = move
          elseif dist[second][myCurrentZonePlayer] == farestDistSecondMove and myMoves[move].num > myMoves[bestMove].num then
            bestMove = move
          end
        end
      end
      return bestMove
    end
    function getBestMove(myZone, currentZonePlayer, lastZonePlayer, allowed)
      myMoves = getNextMovePossibilities(myZone, currentZonePlayer, lastZonePlayer, allowed)
      if myMoves.num == 0 then
        return 0
      end
      if myMoves.num == 1 then
        for first, v in pairs(myMoves) do
          return first
        end
      end
      myFarestMoves = getFarestMoves(myMoves, currentZonePlayer)
      myBestMove = findBestMove(myMoves, myFarestMoves, currentZonePlayer)
      return myBestMove
    end
    function getMaxDistZone(myZone)
      local maxDist = 0
      local maxZone = 0
      for test = 1, 34 do
        if maxDist < dist[myZone][test] then
          maxDist = dist[myZone][test]
          maxZone = test
        end
      end
      return maxZone
    end
  end,
  [1] = function()
    _Urwigo.InlineRequire(2)
    _Urwigo.InlineRequire(3)
    _Urwigo.InlineRequire(4)
    _Urwigo.InlineRequire(5)
    _Urwigo.InlineRequire(6)
    zones = {}
    zones[1] = zone1
    zones[2] = zone2
    zones[3] = zone3
    zones[4] = zone4
    zones[5] = zone5
    zones[6] = zone6
    zones[7] = zone7
    zones[8] = zone8
    zones[9] = zone9
    zones[10] = zone10
    zones[11] = zone11
    zones[12] = zone12
    zones[13] = zone13
    zones[14] = zone14
    zones[15] = zone15
    zones[16] = zone16
    zones[17] = zone17
    zones[18] = zone18
    zones[19] = zone19
    zones[20] = zone20
    zones[21] = zone21
    zones[22] = zone22
    zones[23] = zone23
    zones[24] = zone24
    zones[25] = zone25
    zones[26] = zone26
    zones[27] = zone27
    zones[28] = zone28
    zones[29] = zone29
    zones[30] = zone30
    zones[31] = zone31
    zones[32] = zone32
    zones[33] = zone33
    zones[34] = zone34
    zones[35] = zone35
    zones[36] = zone36
    startX = {}
    startX[1] = 20
    startX[2] = 21
    startX[3] = 22
    startX[4] = 23
    startX[5] = 24
    startX[6] = 26
    startX[7] = 27
    startX[8] = 28
    startX[9] = 29
    startX[10] = 30
    startX[11] = 31
    startX[12] = 32
    startX[13] = 34
    activeZonesOnMap = {}
    function log(value)
      print(value)
      Logbuch.Description = (Logbuch.Description .. "") .. value
    end
    function initAll(myCartridge)
      log("call initAll(myCartridge)")
      lastPos = 0
      lastZonePlayer = 0
      enterAllowed = true
      myCartridge.ZVariables.zones = zones
      myCartridge.ZVariables.activeZonesOnMap = activeZonesOnMap
      myCartridge.ZVariables.startX = startX
      initGeofences(myCartridge)
      saveMwcToCartridge(myCartridge)
      calcDist()
      saveDistToCartridge(myCartridge)
      for i = 1, 34 do
        zones[i].OriginalName = zones[i].Name
        zones[i].MyIndex = i
      end
      setLocationerToOutofZoneMode()
      setLoctrainerToOutofZoneMode()
      locationer.Commands.lastZone.Enabled = false
      loctrainer.Commands.lastZone.Enabled = false
      showZoneMap(1)
    end
    function logAllZObjects(myCartridge)
      for k, v in ipairs(myCartridge.AllZObjects) do
        log((("ZVariables[" .. k) .. "]=") .. v.Name)
      end
    end
    function printzones()
      for k, v in ipairs(zones) do
        log(((("zones[" .. k) .. "] = ") .. zones[k].Name) .. " &nbsp;&nbsp;")
      end
    end
    function setLocationerToInZoneMode()
      locationer.Commands.lastZone.Enabled = false
      locationer.Commands.leaveZone.Enabled = true
    end
    function setLoctrainerToInZoneMode()
      loctrainer.Commands.lastZone.Enabled = false
      loctrainer.Commands.leaveZone.Enabled = true
      loctrainer.Commands.enterZone.Enabled = false
      loctrainer.Commands.captureZ.Enabled = true
    end
    function setLocationerToOutofZoneMode()
      locationer.Commands.lastZone.Enabled = true
    end
    function setLoctrainerToOutofZoneMode()
      loctrainer.Commands.lastZone.Enabled = true
      loctrainer.Commands.leaveZone.Enabled = false
      loctrainer.Commands.enterZone.Enabled = true
    end
    function playerEnterZone(newZone)
      log("playerEnterZone()")
      if isZCaptured == false and enterAllowed == true then
        log("playerEnterZone() - In If")
        enterAllowed = false
        PlaySound(beepZoneEnter)
        local oldZonePlayer = currentZonePlayer
        setCurrentZonePlayer(newZone)
        resize_zone(zones[currentZonePlayer], 10)
        deactivateAllZones(true)
        showActiveGeofenceInCurrentZonePlayer()
        if isMwcInit() == false then
          initMwc((currentZoneAgent + 1) * dayOfYear * 32767 + dayOfYear + 1)
        end
        if oldZonePlayer ~= currentZonePlayer then
          moveAgent()
        else
          displayZ()
        end
      end
      setLocationerToInZoneMode()
      setLoctrainerToInZoneMode()
    end
    function setCurrentZonePlayer(newZone)
      if newZone == 0 then
        currentZonePlayer = _G[myCurrentZone].MyIndex
      else
        currentZonePlayer = newZone
      end
    end
    function moveAgent()
      log("moveAgent")
      isZCaptured = false
      updateSperren()
      currentZoneAgent = nextMove()
      numMoves = numMoves + 1
      jagdLog = ((((((jagdLog .. CR) .. numMoves) .. ". X:") .. currentZonePlayer) .. " - Z:") .. currentZoneAgent) .. "; "
      if currentZoneAgent == 0 then
        isZCaptured = true
        myAgentZ.Name = "Agent Z [gefangen]"
        zTask.Name = "Position Z: gefangen"
        deactivateAllZones(false)
      else
        displayZ()
      end
    end
    function displayZ()
      zones[currentZoneAgent].Active = true
      zones[currentZoneAgent].Name = ("Zone " .. currentZoneAgent) .. " [Z]"
      updateSperren()
      zTask.Name = "Position Z: " .. currentZoneAgent
      table.insert(activeZonesOnMap, zones[currentZoneAgent])
    end
    function nextMove()
      if currentZoneAgent == 0 then
        currentZoneAgent = getMaxDistZone(currentZonePlayer)
        if currentZoneAgent == 10 then
          currentZoneAgent = 9
        end
      else
        currentZoneAgent = getBestMove(currentZoneAgent, currentZonePlayer, lastZonePlayer, getAllAllowed())
      end
      return currentZoneAgent
    end
    function activateXStartZones()
      local distTable = {}
      local pos = Player.ObjectLocation
      for k, v in ipairs(startX) do
        local zone = zones[v]
        local points = zone.Points
        local shortestDist = 10000
        for i, p in ipairs(points) do
          local d, b = Wherigo.VectorToPoint(pos, p)
          local dist = d:GetValue("m")
          if shortestDist > dist then
            shortestDist = dist
          end
        end
        zone.DistanceToPlayer = shortestDist
        table.insert(distTable, zone)
      end
      local comparator = function(z1, z2)
        return z1.DistanceToPlayer < z2.DistanceToPlayer
      end
      table.sort(distTable, comparator)
      log("Activating closest Zones:")
      for i = 1, 2 do
        distTable[i].Active = true
        table.insert(activeZonesOnMap, distTable[i])
      end
    end
    function setRandomStartzone()
      initMwc((currentZoneAgent + 1) * dayOfYear * 32767 + dayOfYear + 1)
      setMwcUninitialized()
      local startzone = startX[myRandom(13)]
      zones[startzone].Active = true
      table.insert(activeZonesOnMap, zones[startzone])
    end
    function enableAllStartzones()
      for i = 1, 13 do
        zones[startX[i]].Active = true
        table.insert(activeZonesOnMap, zones[startX[i]])
      end
    end
    function setEnterZoneChoices()
      enterZone.Choices = {}
      for i = 1, 36 do
        if zones[i].Active then
          log("Added Zone to Choice: " .. i)
          table.insert(enterZone.Choices, tostring(i))
        end
      end
    end
    function deactivateAllZones(keepPlayer)
      log("call deactivateAllZones()")
      if keepPlayer then
        log("KeepPlayer=True!")
      else
        log("KeepPlayer=False!")
      end
      log("activeZonesOnMap:" .. #activeZonesOnMap)
      for k, v in ipairs(activeZonesOnMap) do
        if v ~= zones[currentZonePlayer] or keepPlayer == false then
          log("Deaktiviere Zone:" .. v.Name)
          v.Active = false
          if string.len(v.Name) > 6 then
            v.Name = v.OriginalName
          end
        else
          log("Not deactivated: " .. v.Name)
        end
      end
      for k in pairs(activeZonesOnMap) do
        activeZonesOnMap[k] = nil
      end
      if keepPlayer == true then
        zones[currentZonePlayer].Name = ("Zone " .. currentZonePlayer) .. " [X]"
        table.insert(activeZonesOnMap, zones[currentZonePlayer])
      end
      log("end deactivateAllZones()")
    end
    function showMisterZ()
      log("call showMisterZ()")
      myAgentZ.Name = ("Agent Z [In Zone" .. currentZoneAgent) .. "]"
      myAgentZ:MoveTo(zones[currentZonePlayer])
      log("Agent Z moved to Zone " .. currentZoneAgent)
    end
    function showZones()
      s = (("Player: " .. currentZonePlayer) .. "") .. "Aktiv: -"
      for k, v in ipairs(activeZonesOnMap) do
        s = (s .. v.Name) .. "-"
      end
      return s
    end
    function activateNextZones()
      log("call activateNextZones()")
      lastZonePlayer = currentZonePlayer
      log("Activating Next Zones:")
      for i, v in ipairs(topo[lastZonePlayer]) do
        zones[v].Active = true
        table.insert(activeZonesOnMap, zones[v])
      end
      log("End activateNextZones")
    end
    function leaveZone()
      if isZCaptured == false then
        log("leave Zone:" .. currentZonePlayer)
        geofences.Commands.Aufstellen.Enabled = false
        geofences.Commands.Abbauen.Enabled = false
        deactivateAllZones(false)
        PlaySound(beepZoneLeave)
        activateNextZones()
        enterAllowed = true
      end
      setLocationerToOutofZoneMode()
      setLoctrainerToOutofZoneMode()
    end
    function activateLastZonePlayer()
      deactivateAllZones(false)
      PlaySound(beepZoneLeave)
      enterAllowed = true
      zones[lastZonePlayer].Active = true
      zones[lastZonePlayer].Name = "Zone " .. lastZonePlayer
      table.insert(activeZonesOnMap, zones[lastZonePlayer])
      loctrainer.Commands.lastZone.Enabled = false
      locationer.Commands.lastZone.Enabled = false
      log("Activating lastZonePlayer: Zone " .. lastZonePlayer)
    end
    function blaetternKarte()
      kartenblatt = kartenblatt + 1
      if kartenblatt == 0 then
        kartenblatt = 34
      end
      if kartenblatt == 35 then
        kartenblatt = 1
      end
      showZoneMap(kartenblatt)
    end
    function showZoneMap(myZone)
      kartenblatt = myZone
      stadtplan.Media = zones[kartenblatt].Media
      stadtplan.Name = (("Stadtplan " .. "[Zone ") .. kartenblatt) .. "]"
      stadtplan.Description = zones[kartenblatt].Description
    end
    function isActiveZone(testZone)
      if testZone < 1 or testZone > 36 then
        return false
      end
      if zones[testZone].Active then
        return true
      else
        return false
      end
    end
    print("Start")
    calcDist()
  end
}
theCartridge = Wherigo.ZCartridge()
k01 = Wherigo.ZMedia(theCartridge)
k01.Id = "c9591003-384b-4cfb-a96b-fa29c7747004"
k01.Name = _Eg9m("Z\018\015")
k01.Description = ""
k01.AltText = ""
k01.Resources = {
  {
    Type = "jpg",
    Filename = "p01.jpg",
    Directives = {}
  }
}
k02 = Wherigo.ZMedia(theCartridge)
k02.Id = "f9f44d16-78fd-464f-b5fc-bcd60ca8653b"
k02.Name = _Eg9m("Z\018\004")
k02.Description = ""
k02.AltText = ""
k02.Resources = {
  {
    Type = "jpg",
    Filename = "p02.jpg",
    Directives = {}
  }
}
k04 = Wherigo.ZMedia(theCartridge)
k04.Id = "d5aea62f-b65a-43a6-aa35-60d8b28da850"
k04.Name = _Eg9m("Z\018(")
k04.Description = ""
k04.AltText = ""
k04.Resources = {
  {
    Type = "jpg",
    Filename = "p04.jpg",
    Directives = {}
  }
}
k05 = Wherigo.ZMedia(theCartridge)
k05.Id = "e6dcbbf7-76a4-447a-aced-9fc78f27d4de"
k05.Name = _Eg9m("Z\018A")
k05.Description = ""
k05.AltText = ""
k05.Resources = {
  {
    Type = "jpg",
    Filename = "p05.jpg",
    Directives = {}
  }
}
k06 = Wherigo.ZMedia(theCartridge)
k06.Id = "410455bc-70b4-41c9-82c9-ea40cc2ece12"
k06.Name = _Eg9m("Z\018\v")
k06.Description = ""
k06.AltText = ""
k06.Resources = {
  {
    Type = "jpg",
    Filename = "p06.jpg",
    Directives = {}
  }
}
k03 = Wherigo.ZMedia(theCartridge)
k03.Id = "749e68a1-805f-49f6-b372-43c60870bc33"
k03.Name = _Eg9m("Z\018G")
k03.Description = ""
k03.AltText = ""
k03.Resources = {
  {
    Type = "jpg",
    Filename = "p03.jpg",
    Directives = {}
  }
}
k07 = Wherigo.ZMedia(theCartridge)
k07.Id = "5ebc55fd-c7b1-492b-9f40-79f902641c61"
k07.Name = _Eg9m("Z\018\027")
k07.Description = ""
k07.AltText = ""
k07.Resources = {
  {
    Type = "jpg",
    Filename = "p07.jpg",
    Directives = {}
  }
}
k08 = Wherigo.ZMedia(theCartridge)
k08.Id = "a852bfb3-0c67-4095-ac0d-3ba69172a9db"
k08.Name = _Eg9m("Z\018u")
k08.Description = ""
k08.AltText = ""
k08.Resources = {
  {
    Type = "jpg",
    Filename = "p08.jpg",
    Directives = {}
  }
}
k09 = Wherigo.ZMedia(theCartridge)
k09.Id = "3fd97682-a6e2-4f04-8365-a4dc9ddc9e61"
k09.Name = _Eg9m("Z\0187")
k09.Description = ""
k09.AltText = ""
k09.Resources = {
  {
    Type = "jpg",
    Filename = "p09.jpg",
    Directives = {}
  }
}
k10 = Wherigo.ZMedia(theCartridge)
k10.Id = "f82aec29-4167-4718-89d9-720fe48b247e"
k10.Name = _Eg9m("Z\015\018")
k10.Description = ""
k10.AltText = ""
k10.Resources = {
  {
    Type = "jpg",
    Filename = "p10.jpg",
    Directives = {}
  }
}
k11 = Wherigo.ZMedia(theCartridge)
k11.Id = "374fc773-53f3-4f00-a761-3abbb4f596a5"
k11.Name = _Eg9m("Z\015\015")
k11.Description = ""
k11.AltText = ""
k11.Resources = {
  {
    Type = "jpg",
    Filename = "p11.jpg",
    Directives = {}
  }
}
k12 = Wherigo.ZMedia(theCartridge)
k12.Id = "7b4b9245-8747-4020-9106-23c38eafd225"
k12.Name = _Eg9m("Z\015\004")
k12.Description = ""
k12.AltText = ""
k12.Resources = {
  {
    Type = "jpg",
    Filename = "p12.jpg",
    Directives = {}
  }
}
k13 = Wherigo.ZMedia(theCartridge)
k13.Id = "45d35def-aa87-400a-91de-1bf73eca9513"
k13.Name = _Eg9m("Z\015G")
k13.Description = ""
k13.AltText = ""
k13.Resources = {
  {
    Type = "jpg",
    Filename = "p13.jpg",
    Directives = {}
  }
}
k14 = Wherigo.ZMedia(theCartridge)
k14.Id = "52c912c3-3490-4bc0-9644-55273a20fd72"
k14.Name = _Eg9m("Z\015(")
k14.Description = ""
k14.AltText = ""
k14.Resources = {
  {
    Type = "jpg",
    Filename = "p14.jpg",
    Directives = {}
  }
}
k15 = Wherigo.ZMedia(theCartridge)
k15.Id = "4816bc5d-03b9-4a1e-8e63-cc654f4609e3"
k15.Name = _Eg9m("Z\015A")
k15.Description = ""
k15.AltText = ""
k15.Resources = {
  {
    Type = "jpg",
    Filename = "p15.jpg",
    Directives = {}
  }
}
k16 = Wherigo.ZMedia(theCartridge)
k16.Id = "583a0aaf-c8a6-43e5-bf9d-e987a98caa8e"
k16.Name = _Eg9m("Z\015\v")
k16.Description = ""
k16.AltText = ""
k16.Resources = {
  {
    Type = "jpg",
    Filename = "p16.jpg",
    Directives = {}
  }
}
k17 = Wherigo.ZMedia(theCartridge)
k17.Id = "35621280-94aa-49f4-bf7e-498315d6fd9f"
k17.Name = _Eg9m("Z\015\027")
k17.Description = ""
k17.AltText = ""
k17.Resources = {
  {
    Type = "jpg",
    Filename = "p17.jpg",
    Directives = {}
  }
}
k18 = Wherigo.ZMedia(theCartridge)
k18.Id = "3039d190-2023-4de4-8840-73d6fcc9f461"
k18.Name = _Eg9m("Z\015u")
k18.Description = ""
k18.AltText = ""
k18.Resources = {
  {
    Type = "jpg",
    Filename = "p18.jpg",
    Directives = {}
  }
}
k19 = Wherigo.ZMedia(theCartridge)
k19.Id = "1a2dece4-0f5a-4733-aaa6-a07f6b14c05e"
k19.Name = _Eg9m("Z\0157")
k19.Description = ""
k19.AltText = ""
k19.Resources = {
  {
    Type = "jpg",
    Filename = "p19.jpg",
    Directives = {}
  }
}
k20 = Wherigo.ZMedia(theCartridge)
k20.Id = "06f5470b-519b-4fd1-adb3-9d95167669ec"
k20.Name = _Eg9m("Z\004\018")
k20.Description = ""
k20.AltText = ""
k20.Resources = {
  {
    Type = "jpg",
    Filename = "p20.jpg",
    Directives = {}
  }
}
k21 = Wherigo.ZMedia(theCartridge)
k21.Id = "a28c4710-097c-4d3e-8989-7c9f74033861"
k21.Name = _Eg9m("Z\004\015")
k21.Description = ""
k21.AltText = ""
k21.Resources = {
  {
    Type = "jpg",
    Filename = "p21.jpg",
    Directives = {}
  }
}
k22 = Wherigo.ZMedia(theCartridge)
k22.Id = "5c5489da-06f3-4c6c-aad9-dd594edf542c"
k22.Name = _Eg9m("Z\004\004")
k22.Description = ""
k22.AltText = ""
k22.Resources = {
  {
    Type = "jpg",
    Filename = "p22.jpg",
    Directives = {}
  }
}
k23 = Wherigo.ZMedia(theCartridge)
k23.Id = "c4d4809e-05cb-4f8a-9b0f-0eeb66e95798"
k23.Name = _Eg9m("Z\004G")
k23.Description = ""
k23.AltText = ""
k23.Resources = {
  {
    Type = "jpg",
    Filename = "p23.jpg",
    Directives = {}
  }
}
k24 = Wherigo.ZMedia(theCartridge)
k24.Id = "573d3e65-81a9-455c-9043-0da59e8986e4"
k24.Name = _Eg9m("Z\004(")
k24.Description = ""
k24.AltText = ""
k24.Resources = {
  {
    Type = "jpg",
    Filename = "p24.jpg",
    Directives = {}
  }
}
k25 = Wherigo.ZMedia(theCartridge)
k25.Id = "ffa94155-60d1-4f32-b853-d1ea87c3957c"
k25.Name = _Eg9m("Z\004A")
k25.Description = ""
k25.AltText = ""
k25.Resources = {
  {
    Type = "jpg",
    Filename = "p25.jpg",
    Directives = {}
  }
}
k26 = Wherigo.ZMedia(theCartridge)
k26.Id = "1b834387-46ae-4131-b0af-52c1767d8e6e"
k26.Name = _Eg9m("Z\004\v")
k26.Description = ""
k26.AltText = ""
k26.Resources = {
  {
    Type = "jpg",
    Filename = "p26.jpg",
    Directives = {}
  }
}
k27 = Wherigo.ZMedia(theCartridge)
k27.Id = "d6ded2ba-fc9f-415d-8c45-382a73101cdf"
k27.Name = _Eg9m("Z\004\027")
k27.Description = ""
k27.AltText = ""
k27.Resources = {
  {
    Type = "jpg",
    Filename = "p27.jpg",
    Directives = {}
  }
}
k28 = Wherigo.ZMedia(theCartridge)
k28.Id = "4e2c3bbe-7829-4eff-b7ac-fc7e40f61816"
k28.Name = _Eg9m("Z\004u")
k28.Description = ""
k28.AltText = ""
k28.Resources = {
  {
    Type = "jpg",
    Filename = "p28.jpg",
    Directives = {}
  }
}
k29 = Wherigo.ZMedia(theCartridge)
k29.Id = "12c5b5b0-47dc-47ae-ae60-51b55d5395ac"
k29.Name = _Eg9m("Z\0047")
k29.Description = ""
k29.AltText = ""
k29.Resources = {
  {
    Type = "jpg",
    Filename = "p29.jpg",
    Directives = {}
  }
}
k30 = Wherigo.ZMedia(theCartridge)
k30.Id = "36c79f9b-e9a7-4f66-9222-fbb2819e70db"
k30.Name = _Eg9m("ZG\018")
k30.Description = ""
k30.AltText = ""
k30.Resources = {
  {
    Type = "jpg",
    Filename = "p30.jpg",
    Directives = {}
  }
}
k31 = Wherigo.ZMedia(theCartridge)
k31.Id = "7e990e2c-7eef-4c63-a32f-98549bd205c1"
k31.Name = _Eg9m("ZG\015")
k31.Description = ""
k31.AltText = ""
k31.Resources = {
  {
    Type = "jpg",
    Filename = "p31.jpg",
    Directives = {}
  }
}
k32 = Wherigo.ZMedia(theCartridge)
k32.Id = "1aeae47c-e44b-4dda-b500-91a9c9bb152f"
k32.Name = _Eg9m("ZG\004")
k32.Description = ""
k32.AltText = ""
k32.Resources = {
  {
    Type = "jpg",
    Filename = "p32.jpg",
    Directives = {}
  }
}
k33 = Wherigo.ZMedia(theCartridge)
k33.Id = "bfd4906b-2a49-498a-bcff-5be2037903f5"
k33.Name = _Eg9m("ZGG")
k33.Description = ""
k33.AltText = ""
k33.Resources = {
  {
    Type = "jpg",
    Filename = "p33.jpg",
    Directives = {}
  }
}
k34 = Wherigo.ZMedia(theCartridge)
k34.Id = "ebba9270-a8f6-4d54-bc0c-f50374ccecbd"
k34.Name = _Eg9m("ZG(")
k34.Description = ""
k34.AltText = ""
k34.Resources = {
  {
    Type = "jpg",
    Filename = "p34.jpg",
    Directives = {}
  }
}
_iA3V = Wherigo.ZMedia(theCartridge)
_iA3V.Id = "20e0fd81-5201-4010-bf3d-0953562496ee"
_iA3V.Name = _Eg9m("gfr[/)y")
_iA3V.Description = ""
_iA3V.AltText = ""
_iA3V.Resources = {
  {
    Type = "jpg",
    Filename = "AgentZ.jpg",
    Directives = {}
  }
}
_bqSn = Wherigo.ZMedia(theCartridge)
_bqSn.Id = "2953dbeb-f06f-460f-a68b-2ae33e3a8759"
_bqSn.Name = _Eg9m("\022P\023r\r")
_bqSn.Description = ""
_bqSn.AltText = ""
_bqSn.Resources = {
  {
    Type = "jpg",
    Filename = "Intro_neu.jpg",
    Directives = {}
  }
}
_k4e = Wherigo.ZMedia(theCartridge)
_k4e.Id = "472107c6-1b33-461f-bb33-d00caf70e2f1"
_k4e.Name = _Eg9m("%P\023r\rFv%P[")
_k4e.Description = ""
_k4e.AltText = ""
_k4e.Resources = {
  {
    Type = "jpg",
    Filename = "cover_icon.jpg",
    Directives = {}
  }
}
_z08 = Wherigo.ZMedia(theCartridge)
_z08.Id = "1daea137-ebba-4a86-a0ff-744c3e198dea"
_z08.Name = _Eg9m("5v[v\018\027")
_z08.Description = ""
_z08.AltText = ""
_z08.Resources = {
  {
    Type = "jpg",
    Filename = "07.jpg",
    Directives = {}
  }
}
_mBlA = Wherigo.ZMedia(theCartridge)
_mBlA.Id = "880ae6eb-8b52-47ab-8b19-f746fbce1c73"
_mBlA.Name = _Eg9m("gfr[/)\002")
_mBlA.Description = ""
_mBlA.AltText = ""
_mBlA.Resources = {
  {
    Type = "jpg",
    Filename = "AgentX.jpg",
    Directives = {}
  }
}
_BB6N = Wherigo.ZMedia(theCartridge)
_BB6N.Id = "f7a96c7b-bb4d-4a81-965b-07722c49b55f"
_BB6N.Name = _Eg9m("5v[v\018\015")
_BB6N.Description = ""
_BB6N.AltText = ""
_BB6N.Resources = {
  {
    Type = "jpg",
    Filename = "01.jpg",
    Directives = {}
  }
}
_y9dV = Wherigo.ZMedia(theCartridge)
_y9dV.Id = "25470fd2-44dc-40e6-9f35-948ef69da2a8"
_y9dV.Name = _Eg9m("5v[v\018\004")
_y9dV.Description = ""
_y9dV.AltText = ""
_y9dV.Resources = {
  {
    Type = "jpg",
    Filename = "02.jpg",
    Directives = {}
  }
}
_OCNea = Wherigo.ZMedia(theCartridge)
_OCNea.Id = "add53753-3779-47f5-8853-b7a657fa4ce2"
_OCNea.Name = _Eg9m("5v[v\018G")
_OCNea.Description = ""
_OCNea.AltText = ""
_OCNea.Resources = {
  {
    Type = "jpg",
    Filename = "03.jpg",
    Directives = {}
  }
}
_I5T = Wherigo.ZMedia(theCartridge)
_I5T.Id = "4a487653-93f0-4d8f-83c7-54b969a0bbdd"
_I5T.Name = _Eg9m("5v[v\018(")
_I5T.Description = ""
_I5T.AltText = ""
_I5T.Resources = {
  {
    Type = "jpg",
    Filename = "04.jpg",
    Directives = {}
  }
}
_zbD_ = Wherigo.ZMedia(theCartridge)
_zbD_.Id = "17167469-e367-4665-96d2-a047a0e58b5e"
_zbD_.Name = _Eg9m("5v[v\018A")
_zbD_.Description = ""
_zbD_.AltText = ""
_zbD_.Resources = {
  {
    Type = "jpg",
    Filename = "05.jpg",
    Directives = {}
  }
}
_7KIHW = Wherigo.ZMedia(theCartridge)
_7KIHW.Id = "b40d194e-cdd2-4ff0-a3cc-a05c8cc5aba9"
_7KIHW.Name = _Eg9m("5v[v\018\v")
_7KIHW.Description = ""
_7KIHW.AltText = ""
_7KIHW.Resources = {
  {
    Type = "jpg",
    Filename = "06.jpg",
    Directives = {}
  }
}
_rS9At = Wherigo.ZMedia(theCartridge)
_rS9At.Id = "c685cd98-4a3a-48ce-aa90-2f210e71f58d"
_rS9At.Name = _Eg9m("5v[v\018u")
_rS9At.Description = ""
_rS9At.AltText = ""
_rS9At.Resources = {
  {
    Type = "jpg",
    Filename = "08.jpg",
    Directives = {}
  }
}
_zVtp = Wherigo.ZMedia(theCartridge)
_zVtp.Id = "d35eddb6-06c0-4add-8df9-e35e45129030"
_zVtp.Name = _Eg9m("5v[v\015\015")
_zVtp.Description = ""
_zVtp.AltText = ""
_zVtp.Resources = {
  {
    Type = "jpg",
    Filename = "11.jpg",
    Directives = {}
  }
}
_AaB = Wherigo.ZMedia(theCartridge)
_AaB.Id = "e84b4f58-57d3-4f07-9cc2-05ce399fd521"
_AaB.Name = _Eg9m("5v[v\015\018")
_AaB.Description = ""
_AaB.AltText = ""
_AaB.Resources = {
  {
    Type = "jpg",
    Filename = "10.jpg",
    Directives = {}
  }
}
_W58rO = Wherigo.ZMedia(theCartridge)
_W58rO.Id = "21e6c97d-c916-44ab-84db-1d102ab0b250"
_W58rO.Name = _Eg9m("5v[v\0187")
_W58rO.Description = ""
_W58rO.AltText = ""
_W58rO.Resources = {
  {
    Type = "jpg",
    Filename = "09.jpg",
    Directives = {}
  }
}
_D6eA = Wherigo.ZMedia(theCartridge)
_D6eA.Id = "a38efeb1-3115-4612-b009-36ceab4da20a"
_D6eA.Name = _Eg9m("5v[v)y")
_D6eA.Description = ""
_D6eA.AltText = ""
_D6eA.Resources = {
  {
    Type = "jpg",
    Filename = "i-Z.jpg",
    Directives = {}
  }
}
beepZoneEnter = Wherigo.ZMedia(theCartridge)
beepZoneEnter.Id = "0ebcc5b9-6db7-491b-84fb-a3fbc47f1d7e"
beepZoneEnter.Name = _Eg9m("prrKyP[r\030[/r\r")
beepZoneEnter.Description = ""
beepZoneEnter.AltText = ""
beepZoneEnter.Resources = {
  {
    Type = "mp3",
    Filename = "ppZoneIn1.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "ppZonein1.fdl",
    Directives = {}
  }
}
beepZoneLeave = Wherigo.ZMedia(theCartridge)
beepZoneLeave.Id = "b3398054-b13e-4f1f-8a4b-8ed0a82bf039"
beepZoneLeave.Name = _Eg9m("prrKyP[r_r\n\023r")
beepZoneLeave.Description = ""
beepZoneLeave.AltText = ""
beepZoneLeave.Resources = {
  {
    Type = "mp3",
    Filename = "ppZoneOut.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "ppZoneOut.fdl",
    Directives = {}
  }
}
_6YKZA = Wherigo.ZMedia(theCartridge)
_6YKZA.Id = "4b4e1341-7297-410b-8466-1ec8fc2b8977"
_6YKZA.Name = _Eg9m("5v[v\015\004")
_6YKZA.Description = ""
_6YKZA.AltText = ""
_6YKZA.Resources = {
  {
    Type = "jpg",
    Filename = "12.jpg",
    Directives = {}
  }
}
_0gxU = Wherigo.ZMedia(theCartridge)
_0gxU.Id = "9927efcb-6caa-45a8-860e-ecc4a3f184a5"
_0gxU.Name = _Eg9m("5v[v\015G")
_0gxU.Description = ""
_0gxU.AltText = ""
_0gxU.Resources = {
  {
    Type = "jpg",
    Filename = "13.jpg",
    Directives = {}
  }
}
_PRXij = Wherigo.ZMedia(theCartridge)
_PRXij.Id = "2b60f825-959e-4c3c-b55b-867129c881da"
_PRXij.Name = _Eg9m("5v[v\015(")
_PRXij.Description = ""
_PRXij.AltText = ""
_PRXij.Resources = {
  {
    Type = "jpg",
    Filename = "14.jpg",
    Directives = {}
  }
}
_qyMC = Wherigo.ZMedia(theCartridge)
_qyMC.Id = "8b86974d-8ef7-4944-abd9-2416f8735ef0"
_qyMC.Name = _Eg9m("5v[v\015A")
_qyMC.Description = ""
_qyMC.AltText = ""
_qyMC.Resources = {
  {
    Type = "jpg",
    Filename = "15.jpg",
    Directives = {}
  }
}
__jRM = Wherigo.ZMedia(theCartridge)
__jRM.Id = "0036f054-9396-40fa-9eab-00e8f200538f"
__jRM.Name = _Eg9m("5v[v\015\v")
__jRM.Description = ""
__jRM.AltText = ""
__jRM.Resources = {
  {
    Type = "jpg",
    Filename = "16.jpg",
    Directives = {}
  }
}
_ioY = Wherigo.ZMedia(theCartridge)
_ioY.Id = "1554b51c-7420-43b2-ae4b-d94f7b5800c4"
_ioY.Name = _Eg9m("5v[v\015\027")
_ioY.Description = ""
_ioY.AltText = ""
_ioY.Resources = {
  {
    Type = "jpg",
    Filename = "17.jpg",
    Directives = {}
  }
}
_4avKL = Wherigo.ZMedia(theCartridge)
_4avKL.Id = "a6d7b7d0-b0e3-42f7-b9a7-5df27e783678"
_4avKL.Name = _Eg9m("5v[v\015u")
_4avKL.Description = ""
_4avKL.AltText = ""
_4avKL.Resources = {
  {
    Type = "jpg",
    Filename = "18.jpg",
    Directives = {}
  }
}
_FZF = Wherigo.ZMedia(theCartridge)
_FZF.Id = "0076c3f2-f3ec-4f95-81fd-e91b2e0dab49"
_FZF.Name = _Eg9m("5v[v\0157")
_FZF.Description = ""
_FZF.AltText = ""
_FZF.Resources = {
  {
    Type = "jpg",
    Filename = "19.jpg",
    Directives = {}
  }
}
_6efg = Wherigo.ZMedia(theCartridge)
_6efg.Id = "4f718864-2a29-45e7-9592-f52ab4b3a9c1"
_6efg.Name = _Eg9m("5v[v\004\018")
_6efg.Description = ""
_6efg.AltText = ""
_6efg.Resources = {
  {
    Type = "jpg",
    Filename = "20.jpg",
    Directives = {}
  }
}
_pEF = Wherigo.ZMedia(theCartridge)
_pEF.Id = "f4f81b37-fc90-423b-8a4e-97ade4479d74"
_pEF.Name = _Eg9m("5v[v\004\015")
_pEF.Description = ""
_pEF.AltText = ""
_pEF.Resources = {
  {
    Type = "jpg",
    Filename = "21.jpg",
    Directives = {}
  }
}
_ePRY = Wherigo.ZMedia(theCartridge)
_ePRY.Id = "9e258946-87ae-44c4-ba01-af7b79326ff2"
_ePRY.Name = _Eg9m("5v[v\004\004")
_ePRY.Description = ""
_ePRY.AltText = ""
_ePRY.Resources = {
  {
    Type = "jpg",
    Filename = "22.jpg",
    Directives = {}
  }
}
_wZAh = Wherigo.ZMedia(theCartridge)
_wZAh.Id = "0e4e9df1-b8a4-4392-958f-e5185f618ceb"
_wZAh.Name = _Eg9m("5v[v\004G")
_wZAh.Description = ""
_wZAh.AltText = ""
_wZAh.Resources = {
  {
    Type = "jpg",
    Filename = "23.jpg",
    Directives = {}
  }
}
_p14J8 = Wherigo.ZMedia(theCartridge)
_p14J8.Id = "92c2eb81-28aa-4f8f-9947-719ca181a813"
_p14J8.Name = _Eg9m("5v[v\004(")
_p14J8.Description = ""
_p14J8.AltText = ""
_p14J8.Resources = {
  {
    Type = "jpg",
    Filename = "24.jpg",
    Directives = {}
  }
}
_OwnH0 = Wherigo.ZMedia(theCartridge)
_OwnH0.Id = "776fc38c-0e2f-4f72-9bc1-e8f7908dfcab"
_OwnH0.Name = _Eg9m("5v[v\004A")
_OwnH0.Description = ""
_OwnH0.AltText = ""
_OwnH0.Resources = {
  {
    Type = "jpg",
    Filename = "25.jpg",
    Directives = {}
  }
}
_C4kIF = Wherigo.ZMedia(theCartridge)
_C4kIF.Id = "d9e3ca26-1e06-4297-8843-4b1d31f18344"
_C4kIF.Name = _Eg9m("5v[v\004\v")
_C4kIF.Description = ""
_C4kIF.AltText = ""
_C4kIF.Resources = {
  {
    Type = "jpg",
    Filename = "26.jpg",
    Directives = {}
  }
}
_dBwXO = Wherigo.ZMedia(theCartridge)
_dBwXO.Id = "52ca82ff-a4ae-4d56-9911-5079d6004443"
_dBwXO.Name = _Eg9m("5v[v\004\027")
_dBwXO.Description = ""
_dBwXO.AltText = ""
_dBwXO.Resources = {
  {
    Type = "jpg",
    Filename = "27.jpg",
    Directives = {}
  }
}
_Tilm1 = Wherigo.ZMedia(theCartridge)
_Tilm1.Id = "f721877a-7024-4b52-a29f-a0e99cd5e643"
_Tilm1.Name = _Eg9m("5v[v\004u")
_Tilm1.Description = ""
_Tilm1.AltText = ""
_Tilm1.Resources = {
  {
    Type = "jpg",
    Filename = "28.jpg",
    Directives = {}
  }
}
_XUx = Wherigo.ZMedia(theCartridge)
_XUx.Id = "42989f9f-7662-4848-8869-6f54295b9aa5"
_XUx.Name = _Eg9m("5v[v\0047")
_XUx.Description = ""
_XUx.AltText = ""
_XUx.Resources = {
  {
    Type = "jpg",
    Filename = "29.jpg",
    Directives = {}
  }
}
_pMbFi = Wherigo.ZMedia(theCartridge)
_pMbFi.Id = "21c12d22-4870-444a-9215-4e2a9e267c48"
_pMbFi.Name = _Eg9m("5v[vG\018")
_pMbFi.Description = ""
_pMbFi.AltText = ""
_pMbFi.Resources = {
  {
    Type = "jpg",
    Filename = "30.jpg",
    Directives = {}
  }
}
_L5q = Wherigo.ZMedia(theCartridge)
_L5q.Id = "a46fa722-7398-4f2a-acbf-7a913c4e2fff"
_L5q.Name = _Eg9m("5v[vG\015")
_L5q.Description = ""
_L5q.AltText = ""
_L5q.Resources = {
  {
    Type = "jpg",
    Filename = "31.jpg",
    Directives = {}
  }
}
_zkmYO = Wherigo.ZMedia(theCartridge)
_zkmYO.Id = "5d9f5456-41fe-49f3-b118-37f405e09063"
_zkmYO.Name = _Eg9m("5v[vG\004")
_zkmYO.Description = ""
_zkmYO.AltText = ""
_zkmYO.Resources = {
  {
    Type = "jpg",
    Filename = "32.jpg",
    Directives = {}
  }
}
_35xRD = Wherigo.ZMedia(theCartridge)
_35xRD.Id = "408eb8df-3d69-4c49-b8e1-b698a533395d"
_35xRD.Name = _Eg9m("5v[vGG")
_35xRD.Description = ""
_35xRD.AltText = ""
_35xRD.Resources = {
  {
    Type = "jpg",
    Filename = "33.jpg",
    Directives = {}
  }
}
_mc2Y = Wherigo.ZMedia(theCartridge)
_mc2Y.Id = "8d627466-44ad-41c5-aaa3-9d6e606e351f"
_mc2Y.Name = _Eg9m("5v[vG(")
_mc2Y.Description = ""
_mc2Y.AltText = ""
_mc2Y.Resources = {
  {
    Type = "jpg",
    Filename = "34.jpg",
    Directives = {}
  }
}
_CG_V = Wherigo.ZMedia(theCartridge)
_CG_V.Id = "c0763c35-fb4a-48d4-94d0-e79f093f1f63"
_CG_V.Name = _Eg9m("srP\021r[%r")
_CG_V.Description = ""
_CG_V.AltText = ""
_CG_V.Resources = {
  {
    Type = "jpg",
    Filename = "Geofence.jpg",
    Directives = {}
  }
}
_HCO = Wherigo.ZMedia(theCartridge)
_HCO.Id = "a2f4a8c9-aea9-4980-8e64-0881cb22ec79"
_HCO.Name = _Eg9m("vF\024\nK")
_HCO.Description = ""
_HCO.AltText = ""
_HCO.Resources = {
  {
    Type = "jpg",
    Filename = "i-MapKopie.jpg",
    Directives = {}
  }
}
_H_XW = Wherigo.ZMedia(theCartridge)
_H_XW.Id = "e6403df8-e2f8-4095-8feb-14f82414dd57"
_H_XW.Name = _Eg9m("vF\021r[%r")
_H_XW.Description = ""
_H_XW.AltText = ""
_H_XW.Resources = {
  {
    Type = "jpg",
    Filename = "i-fence.jpg",
    Directives = {}
  }
}
_DGQCJ = Wherigo.ZMedia(theCartridge)
_DGQCJ.Id = "c4c97412-f895-49ef-a56d-5c942540755b"
_DGQCJ.Name = _Eg9m("_P%\n/vP[r\r")
_DGQCJ.Description = ""
_DGQCJ.AltText = ""
_DGQCJ.Resources = {
  {
    Type = "jpg",
    Filename = "Locationer.jpg",
    Directives = {}
  }
}
_xJ3w4 = Wherigo.ZMedia(theCartridge)
_xJ3w4.Id = "8ceda753-19af-4bea-bff4-883f1d9e7ba4"
_xJ3w4.Name = _Eg9m("5v[v_P%\n/vP[r\r")
_xJ3w4.Description = ""
_xJ3w4.AltText = ""
_xJ3w4.Resources = {
  {
    Type = "jpg",
    Filename = "i-loc.jpg",
    Directives = {}
  }
}
_RHWz = Wherigo.ZMedia(theCartridge)
_RHWz.Id = "ca9e26ea-614c-413f-829a-d8c9c5e2df6e"
_RHWz.Name = _Eg9m("jrS\r\n|Qwr\r")
_RHWz.Description = ""
_RHWz.AltText = ""
_RHWz.Resources = {
  {
    Type = "jpg",
    Filename = "NeuralizerHandKopie.jpg",
    Directives = {}
  }
}
_PuQjx = Wherigo.ZMedia(theCartridge)
_PuQjx.Id = "4db9e55f-c667-4689-8ff5-ab74132bb564"
_PuQjx.Name = _Eg9m("jrS\r\n|Qwr\r)PKr[")
_PuQjx.Description = ""
_PuQjx.AltText = ""
_PuQjx.Resources = {
  {
    Type = "jpg",
    Filename = "NeuralizerHandKopie2.jpg",
    Directives = {}
  }
}
_njO = Wherigo.ZMedia(theCartridge)
_njO.Id = "76028045-18d1-428e-827b-f8592643f651"
_njO.Name = _Eg9m([[
>|
2U]])
_njO.Description = ""
_njO.AltText = ""
_njO.Resources = {
  {
    Type = "jpg",
    Filename = "Flash.jpg",
    Directives = {}
  }
}
_kfB3h = Wherigo.ZMedia(theCartridge)
_kfB3h.Id = "a4ebbe69-ed43-4b8b-bf5c-1caf6e1c9792"
_kfB3h.Name = _Eg9m("<\r\n[2\024v//r\r")
_kfB3h.Description = ""
_kfB3h.AltText = ""
_kfB3h.Resources = {
  {
    Type = "jpg",
    Filename = "Transmitter1.jpg",
    Directives = {}
  }
}
Klingeln = Wherigo.ZMedia(theCartridge)
Klingeln.Id = "c4f67f23-0493-48e3-8cc1-1bad4f10fc77"
Klingeln.Name = _Eg9m("t|v[fr|[")
Klingeln.Description = ""
Klingeln.AltText = ""
Klingeln.Resources = {
  {
    Type = "fdl",
    Filename = "Nokiasound.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "originalno_jmki1h86_1.mp3",
    Directives = {}
  }
}
_1a9H = Wherigo.ZMedia(theCartridge)
_1a9H.Id = "81d17770-b9d8-4bd9-beaa-623e61a0bffc"
_1a9H.Name = _Eg9m("5v22vP[2wvr|")
_1a9H.Description = ""
_1a9H.AltText = ""
_1a9H.Resources = {
  {
    Type = "jpg",
    Filename = "Missionsziel.jpg",
    Directives = {}
  }
}
beepCapture = Wherigo.ZMedia(theCartridge)
beepCapture.Id = "3fbe84e0-88d6-43ad-bd79-3b9aec0e5c8c"
beepCapture.Name = _Eg9m("prrK\022\nK/S\rr")
beepCapture.Description = ""
beepCapture.AltText = ""
beepCapture.Resources = {
  {
    Type = "mp3",
    Filename = "ppCapture.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "ppCapture.fdl",
    Directives = {}
  }
}
beepSetGf = Wherigo.ZMedia(theCartridge)
beepSetGf.Id = "d20af03c-55b6-4519-bdee-1265a1ffcd79"
beepSetGf.Name = _Eg9m("prrK-r/s\021")
beepSetGf.Description = ""
beepSetGf.AltText = ""
beepSetGf.Resources = {
  {
    Type = "mp3",
    Filename = "ppSetGF.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "ppSetGF.fdl",
    Directives = {}
  }
}
beepRemoveGf = Wherigo.ZMedia(theCartridge)
beepRemoveGf.Id = "4e8e57e3-8a4c-4424-ad0f-c64d8c803ab0"
beepRemoveGf.Name = _Eg9m("prrK}r\024P\023rs\021")
beepRemoveGf.Description = ""
beepRemoveGf.AltText = ""
beepRemoveGf.Resources = {
  {
    Type = "mp3",
    Filename = "ppRemoveGF.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "ppRemoveGF.fdl",
    Directives = {}
  }
}
_r3p5 = Wherigo.ZMedia(theCartridge)
_r3p5.Id = "53ea234e-ef85-45ab-84e8-9381b121d227"
_r3p5.Name = _Eg9m("gfr[/)a")
_r3p5.Description = ""
_r3p5.AltText = ""
_r3p5.Resources = {
  {
    Type = "jpg",
    Filename = "AgentY.jpg",
    Directives = {}
  }
}
_O331 = Wherigo.ZMedia(theCartridge)
_O331.Id = "7841078e-c277-4ac8-a750-b83ab8affcbd"
_O331.Name = _Eg9m("<\r\nv[")
_O331.Description = ""
_O331.AltText = ""
_O331.Resources = {
  {
    Type = "jpg",
    Filename = "Train.jpg",
    Directives = {}
  }
}
_3jHvC = Wherigo.ZMedia(theCartridge)
_3jHvC.Id = "b831d608-72e1-4aef-a297-e83a68902a43"
_3jHvC.Name = _Eg9m("_P%/\r\nv[r\r")
_3jHvC.Description = ""
_3jHvC.AltText = ""
_3jHvC.Resources = {
  {
    Type = "jpg",
    Filename = "Loctrainer.jpg",
    Directives = {}
  }
}
_Sfo = Wherigo.ZMedia(theCartridge)
_Sfo.Id = "19b5273f-ca8d-44c1-83ad-f1b99b320c82"
_Sfo.Name = _Eg9m("-K\rrr2%U\n[wr")
_Sfo.Description = ""
_Sfo.AltText = ""
_Sfo.Resources = {
  {
    Type = "jpg",
    Filename = "Spreeschanze.jpg",
    Directives = {}
  }
}
_s6ln = Wherigo.ZMedia(theCartridge)
_s6ln.Id = "ca127e0e-0779-401b-bd4c-bed7cc98ac63"
_s6ln.Name = _Eg9m([[
'
f;|Pf]])
_s6ln.Description = ""
_s6ln.AltText = ""
_s6ln.Resources = {
  {
    Type = "jpg",
    Filename = "Jagd-Log.jpg",
    Directives = {}
  }
}
_AEVX = Wherigo.ZMedia(theCartridge)
_AEVX.Id = "1f903a7e-a7e7-487a-9f9d-81bb8c4eedc8"
_AEVX.Name = _Eg9m("j\030}`)?e")
_AEVX.Description = ""
_AEVX.AltText = ""
_AEVX.Resources = {
  {
    Type = "jpg",
    Filename = "NerdKopie.jpg",
    Directives = {}
  }
}
PinkPanther = Wherigo.ZMedia(theCartridge)
PinkPanther.Id = "844db63e-16f0-4649-911c-9c153f9ef73c"
PinkPanther.Name = _Eg9m("\tv[Z)\t\n[/Ur\r)ZP\024K|r//")
PinkPanther.Description = ""
PinkPanther.AltText = ""
PinkPanther.Resources = {
  {
    Type = "mp3",
    Filename = "pinkpantherbass.mp3",
    Directives = {}
  }
}
_HZ4zx = Wherigo.ZMedia(theCartridge)
_HZ4zx.Id = "14e260df-1b76-4409-a291-bd587b85e8c4"
_HZ4zx.Name = _Eg9m("v1<\r\n[2\024v//r\r")
_HZ4zx.Description = ""
_HZ4zx.AltText = ""
_HZ4zx.Resources = {
  {
    Type = "jpg",
    Filename = "i-Transmitter.jpg",
    Directives = {}
  }
}
_ApSO = Wherigo.ZMedia(theCartridge)
_ApSO.Id = "c56eed20-098d-4f99-b7a7-91a0d7d57740"
_ApSO.Name = _Eg9m([[
v1'
f;|Pf]])
_ApSO.Description = ""
_ApSO.AltText = ""
_ApSO.Resources = {
  {
    Type = "jpg",
    Filename = "i-Jagd-Log.jpg",
    Directives = {}
  }
}
_sY2s = Wherigo.ZMedia(theCartridge)
_sY2s.Id = "24519390-afa3-4f12-98b4-c0383c85e05e"
_sY2s.Name = _Eg9m("2KPv|r\r")
_sY2s.Description = ""
_sY2s.AltText = ""
_sY2s.Resources = {
  {
    Type = "jpg",
    Filename = "DSC_0004a.jpg",
    Directives = {}
  }
}
_5HPFh = Wherigo.ZMedia(theCartridge)
_5HPFh.Id = "de8d7a24-708b-4451-bc0a-7a38e87044c0"
_5HPFh.Name = _Eg9m("v12KPv|r\r")
_5HPFh.Description = ""
_5HPFh.AltText = ""
_5HPFh.Resources = {
  {
    Type = "jpg",
    Filename = "i-Spoiler.jpg",
    Directives = {}
  }
}
_TeswR = Wherigo.ZMedia(theCartridge)
_TeswR.Id = "7a442b62-1025-4c43-a6a6-2ddd35804e06"
_TeswR.Name = _Eg9m("\030\n\r|u\v")
_TeswR.Description = ""
_TeswR.AltText = ""
_TeswR.Resources = {
  {
    Type = "jpg",
    Filename = "EarlOutro.jpg",
    Directives = {}
  }
}
_Aoj = Wherigo.ZMedia(theCartridge)
_Aoj.Id = "a1625020-85dc-4d77-a58c-b1be9c9ead09"
_Aoj.Name = _Eg9m("Z1wS2r")
_Aoj.Description = ""
_Aoj.AltText = ""
_Aoj.Resources = {
  {
    Type = "jpg",
    Filename = "ZuseOutro.jpg",
    Directives = {}
  }
}
_f0x = Wherigo.ZMedia(theCartridge)
_f0x.Id = "1460d695-d6dc-4f7d-b5ce-ebc1a084ef6d"
_f0x.Name = _Eg9m("\022P\024K|r/vP[)\022P;r")
_f0x.Description = ""
_f0x.AltText = ""
_f0x.Resources = {
  {
    Type = "jpg",
    Filename = "CompletionKopie.jpg",
    Directives = {}
  }
}
_ri0 = Wherigo.ZMedia(theCartridge)
_ri0.Id = "95eb27af-766f-4be4-b338-33f1b65331a5"
_ri0.Name = _Eg9m("\br\r|\n22r[r\r)>\rvrUP\021")
_ri0.Description = ""
_ri0.AltText = ""
_ri0.Resources = {
  {
    Type = "jpg",
    Filename = "VFOutroKopie.jpg",
    Directives = {}
  }
}
_RCx = Wherigo.ZMedia(theCartridge)
_RCx.Id = "66d27f6b-512c-4774-8aa5-5cd17b0cc47b"
_RCx.Name = _Eg9m("jvfU//\r\nv[")
_RCx.Description = ""
_RCx.AltText = ""
_RCx.Resources = {
  {
    Type = "jpg",
    Filename = "NTOutro.jpg",
    Directives = {}
  }
}
_h_hv = Wherigo.ZMedia(theCartridge)
_h_hv.Id = "077bb4a4-e371-4676-8233-3df9c7c916ff"
_h_hv.Name = _Eg9m([[
>v[
|)yP[r]])
_h_hv.Description = ""
_h_hv.AltText = ""
_h_hv.Resources = {
  {
    Type = "jpg",
    Filename = "FinalZoneKopie.jpg",
    Directives = {}
  }
}
_IH9fr = Wherigo.ZMedia(theCartridge)
_IH9fr.Id = "97048036-7420-4842-9015-9b7e65b5af0a"
_IH9fr.Name = _Eg9m("-K\rrr2%U\n[wr\004")
_IH9fr.Description = ""
_IH9fr.AltText = ""
_IH9fr.Resources = {
  {
    Type = "jpg",
    Filename = "FinalZone2Kopie.jpg",
    Directives = {}
  }
}
theCartridge.Id = "08c1300b-d014-4d05-9bf5-5eea4235c30c"
theCartridge.Name = "k-zuses Jagd auf Z"
theCartridge.Description = "Hightech-Jagd auf einen entflohenen Agenten kreuz und quer durch die Spandauer Altstadt!"
theCartridge.Visible = true
theCartridge.Activity = "Geocache"
theCartridge.StartingLocationDescription = "Rand der Spandauer Altstadt (verschiedene dynamische Startpunkte)"
theCartridge.StartingLocation = ZonePoint(52.53725, 13.2043, 0)
theCartridge.Version = "1.7"
theCartridge.Company = ""
theCartridge.Author = "Author: k-zuse - Artwork: Earl86"
theCartridge.BuilderVersion = "URWIGO 1.22.5798.37755"
theCartridge.CreateDate = "08/19/2013 16:44:24"
theCartridge.PublishDate = "1/1/0001 12:00:00 AM"
theCartridge.UpdateDate = "08/06/2021 18:03:40"
theCartridge.LastPlayedDate = "1/1/0001 12:00:00 AM"
theCartridge.TargetDevice = "PocketPC"
theCartridge.TargetDeviceVersion = "0"
theCartridge.StateId = "1"
theCartridge.CountryId = "2"
theCartridge.Complete = false
theCartridge.UseLogging = true
theCartridge.Media = _bqSn
theCartridge.Icon = _k4e
zone31 = Wherigo.Zone(theCartridge)
zone31.Id = "cfddca2e-136e-4935-a463-7af1bc4cdd4d"
zone31.Name = _Eg9m("yP[r)G\015")
zone31.Description = _Eg9m("\bv%/P\rv\nS\021r\r)n)'Sr;r[2/\r\n22r)\127jP\r;\028\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015A]G\018]G\004")
zone31.Visible = true
zone31.Media = k32
zone31.Icon = _L5q
zone31.Commands = {}
zone31.DistanceRange = Distance(-1, "feet")
zone31.ShowObjects = "OnEnter"
zone31.ProximityRange = Distance(60, "meters")
zone31.AllowSetPositionTo = false
zone31.Active = false
zone31.Points = {
  ZonePoint(52.5395607542017, 13.2038900256157, 0),
  ZonePoint(52.5395032488743, 13.2041441649199, 0),
  ZonePoint(52.5393531636936, 13.2040697336197, 0),
  ZonePoint(52.5393662145992, 13.2038766145706, 0)
}
zone31.OriginalPoint = ZonePoint(52.5394458453422, 13.2039951346815, 0)
zone31.DistanceRangeUOM = "Feet"
zone31.ProximityRangeUOM = "Meters"
zone31.OutOfRangeName = ""
zone31.InRangeName = ""
zone32 = Wherigo.Zone(theCartridge)
zone32.Id = "4090dbdb-5ad0-43d5-90e3-f46ef8a12fc4"
zone32.Name = _Eg9m("yP[r)G\004")
zone32.Description = _Eg9m("g\024)'S|vS2/S\r\024)n)\022\n\r|1-%US\rw1-/\r\n22r)\127\030v[f\n[f)wS)m)g|/2/\n;/)-K\n[;\nS)jP\r;\028\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015\v]G\015]GG")
zone32.Visible = true
zone32.Media = k33
zone32.Icon = _zkmYO
zone32.Commands = {}
zone32.DistanceRange = Distance(-1, "feet")
zone32.ShowObjects = "OnEnter"
zone32.ProximityRange = Distance(60, "meters")
zone32.AllowSetPositionTo = false
zone32.Active = false
zone32.Points = {
  ZonePoint(52.5395554522952, 13.2053934037685, 0),
  ZonePoint(52.5393547950569, 13.2060009241104, 0),
  ZonePoint(52.5389909995141, 13.2059901952744, 0),
  ZonePoint(52.5391598466992, 13.2050836086273, 0)
}
zone32.OriginalPoint = ZonePoint(52.5392652733914, 13.2056170329452, 0)
zone32.DistanceRangeUOM = "Feet"
zone32.ProximityRangeUOM = "Meters"
zone32.OutOfRangeName = ""
zone32.InRangeName = ""
zone30 = Wherigo.Zone(theCartridge)
zone30.Id = "de7e80d7-6bc1-49e2-a49b-46f46f2d33bb"
zone30.Name = _Eg9m("yP[r)G\018")
zone30.Description = _Eg9m("}v//r\r2/\r\n22r)n)\bv%/P\rv\nS\021r\r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015(]\0047]G\015")
zone30.Visible = true
zone30.Media = k31
zone30.Icon = _pMbFi
zone30.Commands = {}
zone30.DistanceRange = Distance(-1, "feet")
zone30.ShowObjects = "OnEnter"
zone30.ProximityRange = Distance(60, "meters")
zone30.AllowSetPositionTo = false
zone30.Active = false
zone30.Points = {
  ZonePoint(52.538778920004, 13.2022941112518, 0),
  ZonePoint(52.5387397667516, 13.2026052474976, 0),
  ZonePoint(52.5385048465042, 13.2023799419403, 0),
  ZonePoint(52.5385635766839, 13.2021760940552, 0)
}
zone30.OriginalPoint = ZonePoint(52.5386467774859, 13.2023638486862, 0)
zone30.DistanceRangeUOM = "Feet"
zone30.ProximityRangeUOM = "Meters"
zone30.OutOfRangeName = ""
zone30.InRangeName = ""
zone14 = Wherigo.Zone(theCartridge)
zone14.Id = "001c8f5c-6daa-4806-b0d8-ab4023d90e16"
zone14.Name = _Eg9m("yP[r)\015(")
zone14.Description = _Eg9m("}v//r\r2/\r\n22r)n)'Sr;r[2/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025A]\015G]\015A]G\015")
zone14.Visible = true
zone14.Media = k14
zone14.Icon = _PRXij
zone14.Commands = {}
zone14.DistanceRange = Distance(-1, "feet")
zone14.ShowObjects = "OnEnter"
zone14.ProximityRange = Distance(60, "meters")
zone14.AllowSetPositionTo = false
zone14.Active = false
zone14.Points = {
  ZonePoint(52.5385276860279, 13.2031202316284, 0),
  ZonePoint(52.5385097406889, 13.2032945752144, 0),
  ZonePoint(52.5383563893108, 13.2031470537186, 0),
  ZonePoint(52.5384085940954, 13.2030102610588, 0)
}
zone14.OriginalPoint = ZonePoint(52.5384506025307, 13.203143030405, 0)
zone14.DistanceRangeUOM = "Feet"
zone14.ProximityRangeUOM = "Meters"
zone14.OutOfRangeName = ""
zone14.InRangeName = ""
zone16 = Wherigo.Zone(theCartridge)
zone16.Id = "5c20521b-a387-420a-b620-58f9d6a6187e"
zone16.Name = _Eg9m("yP[r)\015\v")
zone16.Description = _Eg9m("}r\021P\r\024\n/vP[2K|\n/w\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025A]\v]\015A]\015\027]GG]GA")
zone16.Visible = true
zone16.Media = k16
zone16.Icon = __jRM
zone16.Commands = {}
zone16.DistanceRange = Distance(-1, "feet")
zone16.ShowObjects = "OnEnter"
zone16.ProximityRange = Distance(60, "meters")
zone16.AllowSetPositionTo = false
zone16.Active = false
zone16.Points = {
  ZonePoint(52.5389551092075, 13.2049548625946, 0),
  ZonePoint(52.5385603138982, 13.2059794664383, 0),
  ZonePoint(52.53790448905, 13.2053625583649, 0),
  ZonePoint(52.5382405597234, 13.2044720649719, 0)
}
zone16.OriginalPoint = ZonePoint(52.5384151179698, 13.2051922380924, 0)
zone16.DistanceRangeUOM = "Feet"
zone16.ProximityRangeUOM = "Meters"
zone16.OutOfRangeName = ""
zone16.InRangeName = ""
zone33 = Wherigo.Zone(theCartridge)
zone33.Id = "7b593b2e-1e78-49cf-8040-74c2266d430d"
zone33.Name = _Eg9m("yP[r)GG")
zone33.Description = _Eg9m("?\n\023r|2/\r\n22r)n)lrf)wS\024)}r\021P\r\024\n/vP[2K|\n/w\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015\v]G\004]G(")
zone33.Visible = true
zone33.Media = k33
zone33.Icon = _35xRD
zone33.Commands = {}
zone33.DistanceRange = Distance(-1, "feet")
zone33.ShowObjects = "OnEnter"
zone33.ProximityRange = Distance(60, "meters")
zone33.AllowSetPositionTo = false
zone33.Active = false
zone33.Points = {
  ZonePoint(52.538850700876, 13.2058024406433, 0),
  ZonePoint(52.5388963795515, 13.2061564922333, 0),
  ZonePoint(52.5387658689237, 13.2063710689545, 0),
  ZonePoint(52.5385962045276, 13.2061243057251, 0)
}
zone33.OriginalPoint = ZonePoint(52.5387772884697, 13.206113576889, 0)
zone33.DistanceRangeUOM = "Feet"
zone33.ProximityRangeUOM = "Meters"
zone33.OutOfRangeName = ""
zone33.InRangeName = ""
zone34 = Wherigo.Zone(theCartridge)
zone34.Id = "b0ea949a-d814-4b87-a08e-c95d97a9c265"
zone34.Name = _Eg9m("yP[r)G(")
zone34.Description = _Eg9m("?\n\023r|2/\r\n22r)n)\006\rrv/r)-/\r\n22r)\005\006}\025\127\030v[f\n[f)wS)m)g|/2/\n;/)-K\n[;\nS)-Sr;\028\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015\027]\004\018]GG")
zone34.Visible = true
zone34.Media = k34
zone34.Icon = _mc2Y
zone34.Commands = {}
zone34.DistanceRange = Distance(-1, "feet")
zone34.ShowObjects = "OnEnter"
zone34.ProximityRange = Distance(60, "meters")
zone34.AllowSetPositionTo = false
zone34.Active = false
zone34.Points = {
  ZonePoint(52.5385758121282, 13.2069034874439, 0),
  ZonePoint(52.5384510104372, 13.2072468101978, 0),
  ZonePoint(52.5382079316154, 13.2069718837738, 0),
  ZonePoint(52.5383408910034, 13.2066111266613, 0)
}
zone34.OriginalPoint = ZonePoint(52.538393911296, 13.2069333270192, 0)
zone34.DistanceRangeUOM = "Feet"
zone34.ProximityRangeUOM = "Meters"
zone34.OutOfRangeName = ""
zone34.InRangeName = ""
zone29 = Wherigo.Zone(theCartridge)
zone29.Id = "783d6ec0-8e75-4bd6-8393-dddf4399717e"
zone29.Name = _Eg9m("yP[r)\0047")
zone29.Description = _Eg9m("5P\rv/w2/\r\n22r)n)\bv%/P\rv\nS\021r\r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015G]\004u]G\018")
zone29.Visible = true
zone29.Media = k30
zone29.Icon = _XUx
zone29.Commands = {}
zone29.DistanceRange = Distance(-1, "feet")
zone29.ShowObjects = "OnEnter"
zone29.ProximityRange = Distance(60, "meters")
zone29.AllowSetPositionTo = false
zone29.Active = false
zone29.Points = {
  ZonePoint(52.5382862390338, 13.2017254829407, 0),
  ZonePoint(52.5381948803654, 13.2021224498749, 0),
  ZonePoint(52.5380415278876, 13.2020205259323, 0),
  ZonePoint(52.5381426753267, 13.2016235589981, 0)
}
zone29.OriginalPoint = ZonePoint(52.5381663306534, 13.2018730044365, 0)
zone29.DistanceRangeUOM = "Feet"
zone29.ProximityRangeUOM = "Meters"
zone29.OutOfRangeName = ""
zone29.InRangeName = ""
zone13 = Wherigo.Zone(theCartridge)
zone13.Id = "44def9fe-6e4c-49c4-87b1-7d2b063ccd0b"
zone13.Name = _Eg9m("yP[r)\015G")
zone13.Description = _Eg9m("5P\rv/w2/\r\n22r)n)'Sr;r[2/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]\015\004]\015(]G\018")
zone13.Visible = true
zone13.Media = k13
zone13.Icon = _0gxU
zone13.Commands = {}
zone13.DistanceRange = Distance(-1, "feet")
zone13.ShowObjects = "OnEnter"
zone13.ProximityRange = Distance(60, "meters")
zone13.AllowSetPositionTo = false
zone13.Active = false
zone13.Points = {
  ZonePoint(52.5380668147692, 13.2025676965714, 0),
  ZonePoint(52.5379697456927, 13.202873468399, 0),
  ZonePoint(52.5377674497846, 13.2026696205139, 0),
  ZonePoint(52.5378637035991, 13.2023625075817, 0)
}
zone13.OriginalPoint = ZonePoint(52.5379169284614, 13.2026183232665, 0)
zone13.DistanceRangeUOM = "Feet"
zone13.ProximityRangeUOM = "Meters"
zone13.OutOfRangeName = ""
zone13.InRangeName = ""
zone5 = Wherigo.Zone(theCartridge)
zone5.Id = "7da85d53-e137-4a39-941b-0585ae7b146a"
zone5.Name = _Eg9m("yP[r)A")
zone5.Description = _Eg9m("}v//r\r2/\r\n22r)n)\022\n\r|1-%US\rw1-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]\v]\015(]\015\v")
zone5.Visible = true
zone5.Media = k05
zone5.Icon = _zbD_
zone5.Commands = {}
zone5.DistanceRange = Distance(-1, "feet")
zone5.ShowObjects = "OnEnter"
zone5.ProximityRange = Distance(60, "meters")
zone5.AllowSetPositionTo = false
zone5.Active = false
zone5.Points = {
  ZonePoint(52.5382177200504, 13.2043540477753, 0),
  ZonePoint(52.5381198356028, 13.2046973705292, 0),
  ZonePoint(52.537924066053, 13.2045364379883, 0),
  ZonePoint(52.5380023739777, 13.2041823863983, 0)
}
zone5.OriginalPoint = ZonePoint(52.538065998921, 13.2044425606728, 0)
zone5.DistanceRangeUOM = "Feet"
zone5.ProximityRangeUOM = "Meters"
zone5.OutOfRangeName = ""
zone5.InRangeName = ""
zone6 = Wherigo.Zone(theCartridge)
zone6.Id = "05ffee53-c72a-4eae-b2b4-db6a776ac877"
zone6.Name = _Eg9m("yP[r)\v")
zone6.Description = _Eg9m("5Pr[%U2/\r\n22r)n)d[p2K\019lrf)wS\024)}r\021P\r\024\n/vP[2K|\n/w\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]A]\027]\015\v")
zone6.Visible = true
zone6.Media = k06
zone6.Icon = _7KIHW
zone6.Commands = {}
zone6.DistanceRange = Distance(-1, "feet")
zone6.ShowObjects = "OnEnter"
zone6.ProximityRange = Distance(60, "meters")
zone6.AllowSetPositionTo = false
zone6.Active = false
zone6.Points = {
  ZonePoint(52.5379175403863, 13.2051265239716, 0),
  ZonePoint(52.5378196552695, 13.2054591178894, 0),
  ZonePoint(52.5376369358008, 13.2053303718567, 0),
  ZonePoint(52.5377217699344, 13.2049763202667, 0)
}
zone6.OriginalPoint = ZonePoint(52.5377739753477, 13.2052230834961, 0)
zone6.DistanceRangeUOM = "Feet"
zone6.ProximityRangeUOM = "Meters"
zone6.OutOfRangeName = ""
zone6.InRangeName = ""
zone17 = Wherigo.Zone(theCartridge)
zone17.Id = "80ad6926-818f-44fb-8f8e-5154fce2cafc"
zone17.Name = _Eg9m("yP[r)\015\027")
zone17.Description = _Eg9m("tv\r%Uf\n22r)n)\006\rrv/r)-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\027]\015\v]G\v")
zone17.Visible = true
zone17.Media = k17
zone17.Icon = _ioY
zone17.Commands = {}
zone17.DistanceRange = Distance(-1, "feet")
zone17.ShowObjects = "OnEnter"
zone17.ProximityRange = Distance(60, "meters")
zone17.AllowSetPositionTo = false
zone17.Active = false
zone17.Points = {
  ZonePoint(52.5379893226666, 13.2064139842987, 0),
  ZonePoint(52.5378849120382, 13.2067465782166, 0),
  ZonePoint(52.5376695643332, 13.2064998149872, 0),
  ZonePoint(52.5377870268487, 13.2061886787415, 0)
}
zone17.OriginalPoint = ZonePoint(52.5378327064717, 13.206462264061, 0)
zone17.DistanceRangeUOM = "Feet"
zone17.ProximityRangeUOM = "Meters"
zone17.OutOfRangeName = ""
zone17.InRangeName = ""
zone18 = Wherigo.Zone(theCartridge)
zone18.Id = "68988036-75c9-4c4c-8dbc-5eae3d394c68"
zone18.Name = _Eg9m("yP[r)\015u")
zone18.Description = _Eg9m("-\n%Zf\n22r)>v2%Ur\r2/\r\n22r)jP\r;\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\0157")
zone18.Visible = true
zone18.Media = k18
zone18.Icon = _4avKL
zone18.Commands = {}
zone18.DistanceRange = Distance(-1, "feet")
zone18.ShowObjects = "OnEnter"
zone18.ProximityRange = Distance(60, "meters")
zone18.AllowSetPositionTo = false
zone18.Active = false
zone18.Points = {
  ZonePoint(52.5378000782199, 13.2071542739868, 0),
  ZonePoint(52.5376826157393, 13.2074117660522, 0),
  ZonePoint(52.5375064214291, 13.2073259353638, 0),
  ZonePoint(52.5376630386286, 13.2069611549377, 0)
}
zone18.OriginalPoint = ZonePoint(52.5376630385042, 13.2072132825851, 0)
zone18.DistanceRangeUOM = "Feet"
zone18.ProximityRangeUOM = "Meters"
zone18.OutOfRangeName = ""
zone18.InRangeName = ""
zone1 = Wherigo.Zone(theCartridge)
zone1.Id = "77c27e0f-50c8-45d4-b883-d1d3262dcbd8"
zone1.Name = _Eg9m("yP[r)\015")
zone1.Description = _Eg9m("5\n\rZ/\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\004]G](]A]\v]\027]u]\015G")
zone1.Visible = true
zone1.Media = k01
zone1.Icon = _BB6N
zone1.Commands = {}
zone1.DistanceRange = Distance(-1, "feet")
zone1.ShowObjects = "OnEnter"
zone1.ProximityRange = Distance(60, "meters")
zone1.AllowSetPositionTo = false
zone1.Active = false
zone1.Points = {
  ZonePoint(52.5377641869397, 13.2036781311035, 0),
  ZonePoint(52.5371050873052, 13.2057112455368, 0),
  ZonePoint(52.5366058616899, 13.2051157951355, 0),
  ZonePoint(52.5375031585649, 13.2033509016037, 0)
}
zone1.OriginalPoint = ZonePoint(52.5372445736249, 13.2044640183449, 0)
zone1.DistanceRangeUOM = "Feet"
zone1.ProximityRangeUOM = "Meters"
zone1.OutOfRangeName = ""
zone1.InRangeName = ""
zone19 = Wherigo.Zone(theCartridge)
zone19.Id = "d82116af-ff8c-4eef-9638-64688f080719"
zone19.Name = _Eg9m("yP[r)\0157")
zone19.Description = _Eg9m("t\n\024\024r\r2/\r\n22r)n)\006\rrv/r)-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\027]u]\015u]\004\018")
zone19.Visible = true
zone19.Media = k19
zone19.Icon = _FZF
zone19.Commands = {}
zone19.DistanceRange = Distance(-1, "feet")
zone19.ShowObjects = "OnEnter"
zone19.ProximityRange = Distance(60, "meters")
zone19.AllowSetPositionTo = false
zone19.Active = false
zone19.Points = {
  ZonePoint(52.5374215868794, 13.2066982984543, 0),
  ZonePoint(52.5372747574638, 13.2070630788803, 0),
  ZonePoint(52.5370855099371, 13.206821680069, 0),
  ZonePoint(52.537258443054, 13.206472992897, 0)
}
zone19.OriginalPoint = ZonePoint(52.5372600743336, 13.2067640125751, 0)
zone19.DistanceRangeUOM = "Feet"
zone19.ProximityRangeUOM = "Meters"
zone19.OutOfRangeName = ""
zone19.InRangeName = ""
zone12 = Wherigo.Zone(theCartridge)
zone12.Id = "d42f8dec-9337-4791-8bcb-b12b4b083e34"
zone12.Name = _Eg9m("yP[r)\015\004")
zone12.Description = _Eg9m("\022U\n\r|P//r[2/\r\n22r)n)'Sr;r[2/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025(]\015G]\0047")
zone12.Visible = true
zone12.Media = k12
zone12.Icon = _6YKZA
zone12.Commands = {}
zone12.DistanceRange = Distance(-1, "feet")
zone12.ShowObjects = "OnEnter"
zone12.ProximityRange = Distance(60, "meters")
zone12.AllowSetPositionTo = false
zone12.Active = false
zone12.Points = {
  ZonePoint(52.537356329422, 13.2018864154816, 0),
  ZonePoint(52.5372714945823, 13.2021868228912, 0),
  ZonePoint(52.5370757212497, 13.2019937038422, 0),
  ZonePoint(52.5371605564677, 13.2017147541046, 0)
}
zone12.OriginalPoint = ZonePoint(52.5372160254304, 13.2019454240799, 0)
zone12.DistanceRangeUOM = "Feet"
zone12.ProximityRangeUOM = "Meters"
zone12.OutOfRangeName = ""
zone12.InRangeName = ""
zone20 = Wherigo.Zone(theCartridge)
zone20.Id = "11e56a02-6045-4295-8c33-028e39d28452"
zone20.Name = _Eg9m("yP[r)\004\018")
zone20.Description = _Eg9m("t\n\024\024r\r2/\r\n22r)n)_v[;r[S\021r\r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\0157]\004\015]G\v")
zone20.Visible = true
zone20.Media = k20
zone20.Icon = _6efg
zone20.Commands = {}
zone20.DistanceRange = Distance(-1, "feet")
zone20.ShowObjects = "OnEnter"
zone20.ProximityRange = Distance(60, "meters")
zone20.AllowSetPositionTo = false
zone20.Active = false
zone20.Points = {
  ZonePoint(52.5371997111284, 13.2073259353638, 0),
  ZonePoint(52.5371083501991, 13.2077121734619, 0),
  ZonePoint(52.536899524504, 13.2074546813965, 0),
  ZonePoint(52.5369778342561, 13.2071113586426, 0)
}
zone20.OriginalPoint = ZonePoint(52.5370463550219, 13.2074010372162, 0)
zone20.DistanceRangeUOM = "Feet"
zone20.ProximityRangeUOM = "Meters"
zone20.OutOfRangeName = ""
zone20.InRangeName = ""
zone28 = Wherigo.Zone(theCartridge)
zone28.Id = "fa69b013-2b41-4110-a8d8-a81c6a4854ef"
zone28.Name = _Eg9m("yP[r)\004u")
zone28.Description = _Eg9m("'Sr;r[2/\r\n22r)n)\bv%/P\rv\nS\021r\r)n>S22\frf)wS\r)\022\n\r|1-%US\rw1-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015\004]\004\027]\0047")
zone28.Visible = true
zone28.Media = k29
zone28.Icon = _Tilm1
zone28.Commands = {}
zone28.DistanceRange = Distance(-1, "feet")
zone28.ShowObjects = "OnEnter"
zone28.ProximityRange = Distance(60, "meters")
zone28.AllowSetPositionTo = false
zone28.Active = false
zone28.Points = {
  ZonePoint(52.5367168012061, 13.2007545232773, 0),
  ZonePoint(52.5368799470441, 13.2012916356325, 0),
  ZonePoint(52.5367070124365, 13.2014472037554, 0),
  ZonePoint(52.5366205448773, 13.200785368681, 0)
}
zone28.OriginalPoint = ZonePoint(52.536731076391, 13.2010696828366, 0)
zone28.DistanceRangeUOM = "Feet"
zone28.ProximityRangeUOM = "Meters"
zone28.OutOfRangeName = ""
zone28.InRangeName = ""
zone4 = Wherigo.Zone(theCartridge)
zone4.Id = "22e9378d-2926-4745-9069-cb9893d827bc"
zone4.Name = _Eg9m("yP[r)(")
zone4.Description = _Eg9m("\022U\n\r|P//r[2/\r\n22r)n)\022\n\r|1-%US\rw1-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]G]\015\015]\015\004")
zone4.Visible = true
zone4.Media = k04
zone4.Icon = _I5T
zone4.Commands = {}
zone4.DistanceRange = Distance(-1, "feet")
zone4.ShowObjects = "OnEnter"
zone4.ProximityRange = Distance(60, "meters")
zone4.AllowSetPositionTo = false
zone4.Active = false
zone4.Points = {
  ZonePoint(52.5370496180728, 13.202691078186, 0),
  ZonePoint(52.5369386793975, 13.2030344009399, 0),
  ZonePoint(52.5367298528955, 13.2028090953827, 0),
  ZonePoint(52.5368603695756, 13.202497959137, 0)
}
zone4.OriginalPoint = ZonePoint(52.5368946299853, 13.2027581334114, 0)
zone4.DistanceRangeUOM = "Feet"
zone4.ProximityRangeUOM = "Meters"
zone4.OutOfRangeName = ""
zone4.InRangeName = ""
zone3 = Wherigo.Zone(theCartridge)
zone3.Id = "50d9cb43-d144-4059-bce3-a142de0151ae"
zone3.Name = _Eg9m("yP[r)G")
zone3.Description = _Eg9m("\022U\n\r|P//r[2/\r\n22r)n)5\n\rZ/2/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]\004](")
zone3.Visible = true
zone3.Media = k03
zone3.Icon = _OCNea
zone3.Commands = {}
zone3.DistanceRange = Distance(-1, "feet")
zone3.ShowObjects = "OnEnter"
zone3.ProximityRange = Distance(60, "meters")
zone3.AllowSetPositionTo = false
zone3.Active = false
zone3.Points = {
  ZonePoint(52.5367690079403, 13.2033240795135, 0),
  ZonePoint(52.5366776461148, 13.2036244869232, 0),
  ZonePoint(52.5364818701342, 13.2033777236938, 0),
  ZonePoint(52.5366123875516, 13.2031202316284, 0)
}
zone3.OriginalPoint = ZonePoint(52.5366352279352, 13.2033616304397, 0)
zone3.DistanceRangeUOM = "Feet"
zone3.ProximityRangeUOM = "Meters"
zone3.OutOfRangeName = ""
zone3.InRangeName = ""
zone8 = Wherigo.Zone(theCartridge)
zone8.Id = "455628e7-be65-4a8c-ace9-e6cad6cbdb86"
zone8.Name = _Eg9m("yP[r)u")
zone8.Description = _Eg9m("l\n22r\r2/\r\n22r)n)>v2%Ur\r2/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]7]\0157]\004\015")
zone8.Visible = true
zone8.Media = k08
zone8.Icon = _rS9At
zone8.Commands = {}
zone8.DistanceRange = Distance(-1, "feet")
zone8.ShowObjects = "OnEnter"
zone8.ProximityRange = Distance(60, "meters")
zone8.AllowSetPositionTo = false
zone8.Active = false
zone8.Points = {
  ZonePoint(52.5369778342561, 13.2062530517578, 0),
  ZonePoint(52.5368603695756, 13.2065963745117, 0),
  ZonePoint(52.536658068556, 13.2063817977905, 0),
  ZonePoint(52.5367559562625, 13.2060599327087, 0)
}
zone8.OriginalPoint = ZonePoint(52.5368130571626, 13.2063227891922, 0)
zone8.DistanceRangeUOM = "Feet"
zone8.ProximityRangeUOM = "Meters"
zone8.OutOfRangeName = ""
zone8.InRangeName = ""
zone21 = Wherigo.Zone(theCartridge)
zone21.Id = "89610d5b-ab48-4d3d-8bd3-b42fad639370"
zone21.Name = _Eg9m("yP[r)\004\015")
zone21.Description = _Eg9m("l\n22r\r2/\r\n22r)n)_v[;r[S\021r\r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025u]\004\018]\004\004")
zone21.Visible = true
zone21.Media = k21
zone21.Icon = _pEF
zone21.Commands = {}
zone21.DistanceRange = Distance(-1, "feet")
zone21.ShowObjects = "OnEnter"
zone21.ProximityRange = Distance(60, "meters")
zone21.AllowSetPositionTo = false
zone21.Active = false
zone21.Points = {
  ZonePoint(52.5367559562625, 13.2068538665771, 0),
  ZonePoint(52.536658068556, 13.2071757316589, 0),
  ZonePoint(52.5364883960143, 13.2069826126099, 0),
  ZonePoint(52.5365471288914, 13.206650018692, 0)
}
zone21.OriginalPoint = ZonePoint(52.536612387431, 13.2069155573845, 0)
zone21.DistanceRangeUOM = "Feet"
zone21.ProximityRangeUOM = "Meters"
zone21.OutOfRangeName = ""
zone21.InRangeName = ""
zone11 = Wherigo.Zone(theCartridge)
zone11.Id = "19d675c7-3401-4ba6-aac1-c04b2dd4d039"
zone11.Name = _Eg9m("yP[r)\015\015")
zone11.Description = _Eg9m("5\nSr\r2/\r\n22r)n)\022\n\r|1-%US\rw1-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025(]\004G]\004u")
zone11.Visible = true
zone11.Media = k11
zone11.Icon = _zVtp
zone11.Commands = {}
zone11.DistanceRange = Distance(-1, "feet")
zone11.ShowObjects = "OnEnter"
zone11.ProximityRange = Distance(60, "meters")
zone11.AllowSetPositionTo = false
zone11.Active = false
zone11.Points = {
  ZonePoint(52.5361686267496, 13.2016611099243, 0),
  ZonePoint(52.5360511599043, 13.2019400596619, 0),
  ZonePoint(52.5358553811303, 13.2016611099243, 0),
  ZonePoint(52.5360315820662, 13.2014036178589, 0)
}
zone11.OriginalPoint = ZonePoint(52.5360266874626, 13.2016664743424, 0)
zone11.DistanceRangeUOM = "Feet"
zone11.ProximityRangeUOM = "Meters"
zone11.OutOfRangeName = ""
zone11.InRangeName = ""
zone2 = Wherigo.Zone(theCartridge)
zone2.Id = "238088c1-0f4e-45b7-b821-cbd64140ce88"
zone2.Name = _Eg9m("yP[r)\004")
zone2.Description = _Eg9m("\022U\n\r|P//r[2/\r\n22r)n)\006\rrv/r)-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]G]7]\004G")
zone2.Visible = true
zone2.Media = k02
zone2.Icon = _y9dV
zone2.Commands = {}
zone2.DistanceRange = Distance(-1, "feet")
zone2.ShowObjects = "OnEnter"
zone2.ProximityRange = Distance(60, "meters")
zone2.AllowSetPositionTo = false
zone2.Active = false
zone2.Points = {
  ZonePoint(52.536377455921, 13.2043218612671, 0),
  ZonePoint(52.5362730414595, 13.2047939300537, 0),
  ZonePoint(52.5359075888887, 13.2043218612671, 0),
  ZonePoint(52.5361425230334, 13.2039999961853, 0)
}
zone2.OriginalPoint = ZonePoint(52.5361751523256, 13.2043594121933, 0)
zone2.DistanceRangeUOM = "Feet"
zone2.ProximityRangeUOM = "Meters"
zone2.OutOfRangeName = ""
zone2.InRangeName = ""
zone9 = Wherigo.Zone(theCartridge)
zone9.Id = "11942bb2-c339-4f33-9bce-d25704d0b1c0"
zone9.Name = _Eg9m("yP[r)7")
zone9.Description = _Eg9m("\022U\n\r|P//r[2/\r\n22r)n)>v2%Ur\r2/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\004]u]\004\004]\004G")
zone9.Visible = true
zone9.Media = k09
zone9.Icon = _W58rO
zone9.Commands = {}
zone9.DistanceRange = Distance(-1, "feet")
zone9.ShowObjects = "OnEnter"
zone9.ProximityRange = Distance(60, "meters")
zone9.AllowSetPositionTo = false
zone9.Active = false
zone9.Points = {
  ZonePoint(52.5360381080132, 13.2051801681519, 0),
  ZonePoint(52.5359141148541, 13.2055556774139, 0),
  ZonePoint(52.5355812893802, 13.2052230834961, 0),
  ZonePoint(52.5357640174037, 13.2048153877258, 0)
}
zone9.OriginalPoint = ZonePoint(52.5358243824128, 13.2051935791969, 0)
zone9.DistanceRangeUOM = "Feet"
zone9.ProximityRangeUOM = "Meters"
zone9.OutOfRangeName = ""
zone9.InRangeName = ""
zone26 = Wherigo.Zone(theCartridge)
zone26.Id = "48dadac8-792a-48f4-8ddb-28ad804905cb"
zone26.Name = _Eg9m("yP[r)\004\v")
zone26.Description = _Eg9m("g\024)l\n||)n)-/\npUP|wf\n\r/r[)\127\030v[f\n[f)wS)m)}\n/U\nS2)-K\n[;\nS)-Sr;\028\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\004(]\004A]\004\027")
zone26.Visible = true
zone26.Media = k26
zone26.Icon = _C4kIF
zone26.Commands = {}
zone26.DistanceRange = Distance(-1, "feet")
zone26.ShowObjects = "OnEnter"
zone26.ProximityRange = Distance(60, "meters")
zone26.AllowSetPositionTo = false
zone26.Active = false
zone26.Points = {
  ZonePoint(52.5346154286231, 13.2000303268433, 0),
  ZonePoint(52.5343739601141, 13.2008564472198, 0),
  ZonePoint(52.5342042787458, 13.2006150484085, 0),
  ZonePoint(52.534435958912, 13.19979429245, 0)
}
zone26.OriginalPoint = ZonePoint(52.5344074065987, 13.2003240287304, 0)
zone26.DistanceRangeUOM = "Feet"
zone26.ProximityRangeUOM = "Meters"
zone26.OutOfRangeName = ""
zone26.InRangeName = ""
zone25 = Wherigo.Zone(theCartridge)
zone25.Id = "72c0e5a8-fa11-418f-9ee7-c2fa9afb00f2"
zone25.Name = _Eg9m("yP[r)\004A")
zone25.Description = _Eg9m("g\024)l\n||)n)lrf)wS\024)-/\npUP|wf\n\r/r[\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\004(]\004\v]\004u")
zone25.Visible = true
zone25.Media = k25
zone25.Icon = _OwnH0
zone25.Commands = {}
zone25.DistanceRange = Distance(-1, "feet")
zone25.ShowObjects = "OnEnter"
zone25.ProximityRange = Distance(60, "meters")
zone25.AllowSetPositionTo = false
zone25.Active = false
zone25.Points = {
  ZonePoint(52.5353202480274, 13.2015860080719, 0),
  ZonePoint(52.535183200696, 13.2019937038422, 0),
  ZonePoint(52.5350004702553, 13.2016932964325, 0),
  ZonePoint(52.5351244659944, 13.2013607025146, 0)
}
zone25.OriginalPoint = ZonePoint(52.5351570962433, 13.2016584277153, 0)
zone25.DistanceRangeUOM = "Feet"
zone25.ProximityRangeUOM = "Meters"
zone25.OutOfRangeName = ""
zone25.InRangeName = ""
zone23 = Wherigo.Zone(theCartridge)
zone23.Id = "e240fbf8-cb03-4be3-9a7c-a1b6effc7459"
zone23.Name = _Eg9m("yP[r)\004G")
zone23.Description = _Eg9m("5\nSr\r2/\r\n22r)n)\006\rrv/r)-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\004]\015\015]\004\004]\004(")
zone23.Visible = true
zone23.Media = k23
zone23.Icon = _wZAh
zone23.Commands = {}
zone23.DistanceRange = Distance(-1, "feet")
zone23.ShowObjects = "OnEnter"
zone23.ProximityRange = Distance(60, "meters")
zone23.AllowSetPositionTo = false
zone23.Active = false
zone23.Points = {
  ZonePoint(52.5355682373494, 13.2029378414154, 0),
  ZonePoint(52.5353528782814, 13.2033669948578, 0),
  ZonePoint(52.5351114138278, 13.2030022144318, 0),
  ZonePoint(52.5353333001319, 13.2025945186615, 0)
}
zone23.OriginalPoint = ZonePoint(52.5353414573976, 13.2029753923416, 0)
zone23.DistanceRangeUOM = "Feet"
zone23.ProximityRangeUOM = "Meters"
zone23.OutOfRangeName = ""
zone23.InRangeName = ""
zone10 = Wherigo.Zone(theCartridge)
zone10.Id = "7100d072-a502-4afa-90c6-898b0401d9a5"
zone10.Name = _Eg9m("yP[r)\015\018")
zone10.Description = _Eg9m("-\n%Zf\n22r)>v2%Ur\r2/\r\n22r)-Sr;\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\0257")
zone10.Visible = true
zone10.Media = k10
zone10.Icon = _AaB
zone10.Commands = {}
zone10.DistanceRange = Distance(-1, "feet")
zone10.ShowObjects = "OnEnter"
zone10.ProximityRange = Distance(60, "meters")
zone10.AllowSetPositionTo = false
zone10.Active = false
zone10.Points = {
  ZonePoint(52.5353333001319, 13.2038605213165, 0),
  ZonePoint(52.5355878153941, 13.2046222686768, 0),
  ZonePoint(52.5353855085111, 13.2048261165619, 0),
  ZonePoint(52.535144044237, 13.2040321826935, 0)
}
zone10.OriginalPoint = ZonePoint(52.5353626670685, 13.2043352723122, 0)
zone10.DistanceRangeUOM = "Feet"
zone10.ProximityRangeUOM = "Meters"
zone10.OutOfRangeName = ""
zone10.InRangeName = ""
zone22 = Wherigo.Zone(theCartridge)
zone22.Id = "ac3b255a-f62f-46f9-bdc7-68ce84a7d79a"
zone22.Name = _Eg9m("yP[r)\004\004")
zone22.Description = _Eg9m("\022U\n\r|P//r[2/\r\n22r)n)_v[;r[S\021r\r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\0257]\004\015]\004G")
zone22.Visible = true
zone22.Media = k22
zone22.Icon = _ePRY
zone22.Commands = {}
zone22.DistanceRange = Distance(-1, "feet")
zone22.ShowObjects = "OnEnter"
zone22.ProximityRange = Distance(60, "meters")
zone22.AllowSetPositionTo = false
zone22.Active = false
zone22.Points = {
  ZonePoint(52.5356922314852, 13.2058238983154, 0),
  ZonePoint(52.5355356072555, 13.206113576889, 0),
  ZonePoint(52.5353137219737, 13.2056844234467, 0),
  ZonePoint(52.5354768730253, 13.2053411006927, 0)
}
zone22.OriginalPoint = ZonePoint(52.5355046084349, 13.205740749836, 0)
zone22.DistanceRangeUOM = "Feet"
zone22.ProximityRangeUOM = "Meters"
zone22.OutOfRangeName = ""
zone22.InRangeName = ""
zone24 = Wherigo.Zone(theCartridge)
zone24.Id = "c0cc30db-d32b-41b1-9c0c-7bec6dbed376"
zone24.Name = _Eg9m("yP[r)\004(")
zone24.Description = _Eg9m("g\024)l\n||)n)-/\npUP|wf\n\r/r[\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\004G]\004A]\004\v")
zone24.Visible = true
zone24.Media = k24
zone24.Icon = _p14J8
zone24.Commands = {}
zone24.DistanceRange = Distance(-1, "feet")
zone24.ShowObjects = "OnEnter"
zone24.ProximityRange = Distance(60, "meters")
zone24.AllowSetPositionTo = false
zone24.Active = false
zone24.Points = {
  ZonePoint(52.5350983616574, 13.2022297382355, 0),
  ZonePoint(52.5349352091993, 13.2025623321533, 0),
  ZonePoint(52.5347002685948, 13.2021868228912, 0),
  ZonePoint(52.5348568958041, 13.2019186019897, 0)
}
zone24.OriginalPoint = ZonePoint(52.5348976838139, 13.2022243738174, 0)
zone24.DistanceRangeUOM = "Feet"
zone24.ProximityRangeUOM = "Meters"
zone24.OutOfRangeName = ""
zone24.InRangeName = ""
zone15 = Wherigo.Zone(theCartridge)
zone15.Id = "7974fee9-b981-4156-b8a8-1f2a1991b790"
zone15.Name = _Eg9m("yP[r)\015A")
zone15.Description = _Eg9m("'Sr;r[2/\r\n22r)n)>S22\frf)wS\024)}r\021P\r\024\n/vP[2K|\n/w\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015(]\015\v]G\004")
zone15.Visible = true
zone15.Media = k15
zone15.Icon = _qyMC
zone15.Commands = {}
zone15.DistanceRange = Distance(-1, "feet")
zone15.ShowObjects = "OnEnter"
zone15.ProximityRange = Distance(60, "meters")
zone15.AllowSetPositionTo = false
zone15.Active = false
zone15.Points = {
  ZonePoint(52.5390056819038, 13.2034528255463, 0),
  ZonePoint(52.5388433596558, 13.2033307850361, 0),
  ZonePoint(52.5387887083116, 13.2035708427429, 0),
  ZonePoint(52.5389396111114, 13.2036995887756, 0)
}
zone15.OriginalPoint = ZonePoint(52.5388943402456, 13.2035135105252, 0)
zone15.DistanceRangeUOM = "Feet"
zone15.ProximityRangeUOM = "Meters"
zone15.OutOfRangeName = ""
zone15.InRangeName = ""
zone27 = Wherigo.Zone(theCartridge)
zone27.Id = "9324a4e4-67bc-4003-9819-8620b30651f7"
zone27.Name = _Eg9m("yP[r)\004\027")
zone27.Description = _Eg9m("}\n/U\nS2K|\n/w)d[p2K\019\127\030v[f\n[f)wS)m)}\n/U\nS2)-K\n[;\nS)jP\r;\028\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015\015]\004A]\004\v]\004u")
zone27.Visible = true
zone27.Media = k28
zone27.Icon = _dBwXO
zone27.Commands = {}
zone27.DistanceRange = Distance(-1, "feet")
zone27.ShowObjects = "OnEnter"
zone27.ProximityRange = Distance(60, "meters")
zone27.AllowSetPositionTo = false
zone27.Active = false
zone27.Points = {
  ZonePoint(52.5364590295464, 13.2008135318756, 0),
  ZonePoint(52.5357966473278, 13.2014733552933, 0),
  ZonePoint(52.5347883714688, 13.2001161575317, 0),
  ZonePoint(52.534853632743, 13.1998854875565, 0),
  ZonePoint(52.5360544228765, 13.2003951072693, 0)
}
zone27.OriginalPoint = ZonePoint(52.5355904207925, 13.2005367279053, 0)
zone27.DistanceRangeUOM = "Feet"
zone27.ProximityRangeUOM = "Meters"
zone27.OutOfRangeName = ""
zone27.InRangeName = ""
zone7 = Wherigo.Zone(theCartridge)
zone7.Id = "7bb6218a-9936-4e50-a4d2-c4db03bada35"
zone7.Name = _Eg9m("yP[r)\027")
zone7.Description = _Eg9m("t\n\024\024r\r2/\r\n22r)n)\006\rrv/r)-/\r\n22r\005\006}\025\br\rpv[;S[f)wS)yP[r[\014\005\006}\025\015]\v]\015\027]\0157")
zone7.Visible = true
zone7.Media = k07
zone7.Icon = _z08
zone7.Commands = {}
zone7.DistanceRange = Distance(-1, "feet")
zone7.ShowObjects = "OnEnter"
zone7.ProximityRange = Distance(60, "meters")
zone7.AllowSetPositionTo = false
zone7.Active = false
zone7.Points = {
  ZonePoint(52.5376695643332, 13.2060062885284, 0),
  ZonePoint(52.5375814672403, 13.2063978910446, 0),
  ZonePoint(52.5373595922972, 13.2062423229218, 0),
  ZonePoint(52.5374835813742, 13.2057809829712, 0)
}
zone7.OriginalPoint = ZonePoint(52.5375235513112, 13.2061068713665, 0)
zone7.DistanceRangeUOM = "Feet"
zone7.ProximityRangeUOM = "Meters"
zone7.OutOfRangeName = ""
zone7.InRangeName = ""
zone35 = Wherigo.Zone(theCartridge)
zone35.Id = "e8131c43-32cd-49fa-bbab-841215056212"
zone35.Name = _Eg9m("-K\rrr2%U\n[wr")
zone35.Description = _Eg9m("<\rrKKr)wS\r)-K\rrr2%U\n[wr\026)\bP[)Uvr\r)\nS2)frU/)r2)wS\024)\br\r2/r%Z")
zone35.Visible = true
zone35.Media = _IH9fr
zone35.Commands = {}
zone35.DistanceRange = Distance(-1, "feet")
zone35.ShowObjects = "OnEnter"
zone35.ProximityRange = Distance(60, "meters")
zone35.AllowSetPositionTo = false
zone35.Active = false
zone35.Points = {
  ZonePoint(52.5383984575116, 13.2100644339944, 0),
  ZonePoint(52.5383525463437, 13.2109730644007, 0),
  ZonePoint(52.5380980074615, 13.2109675599323, 0),
  ZonePoint(52.5381501570428, 13.2100096934734, 0)
}
zone35.OriginalPoint = ZonePoint(52.5382497920899, 13.2105036879502, 0)
zone35.DistanceRangeUOM = "Feet"
zone35.ProximityRangeUOM = "Meters"
zone35.OutOfRangeName = ""
zone35.InRangeName = ""
zone36 = Wherigo.Zone(theCartridge)
zone36.Id = "8d287420-15e9-46cf-91b3-f5cf2481208f"
zone36.Name = _Eg9m("\br\r2/r%Z")
zone36.Description = _Eg9m("?vr\r)2v[;);vr)\t|\n[r)\023r\r2/r%Z/\026")
zone36.Visible = true
zone36.Media = _h_hv
zone36.Commands = {}
zone36.DistanceRange = Distance(-1, "feet")
zone36.ShowObjects = "OnEnter"
zone36.ProximityRange = Distance(57, "meters")
zone36.AllowSetPositionTo = false
zone36.Active = false
zone36.Points = {
  ZonePoint(52.537002306025, 13.2124797999859, 0),
  ZonePoint(52.5368946301399, 13.2128700613976, 0),
  ZonePoint(52.5367265899734, 13.2127507030964, 0),
  ZonePoint(52.5368465021968, 13.2123376429081, 0)
}
zone36.OriginalPoint = ZonePoint(52.5368675070838, 13.212609551847, 0)
zone36.DistanceRangeUOM = "Feet"
zone36.ProximityRangeUOM = "Meters"
zone36.OutOfRangeName = ""
zone36.InRangeName = ""
_NgZga = Wherigo.Zone(theCartridge)
_NgZga.Id = "88f11957-3800-47b7-a42d-106c6e60b6a1"
_NgZga.Name = _Eg9m("\006\nS2/r||r")
_NgZga.Description = _Eg9m("<r\024KP\r\n\rr)g|/r\r[\n/v\023r)\frfr[);r\r)\006\nS2/r||r")
_NgZga.Visible = true
_NgZga.Media = _CG_V
_NgZga.Commands = {}
_NgZga.DistanceRange = Distance(-1, "feet")
_NgZga.ShowObjects = "OnEnter"
_NgZga.ProximityRange = Distance(60, "meters")
_NgZga.AllowSetPositionTo = false
_NgZga.Active = false
_NgZga.Points = {
  ZonePoint(52.5379875339433, 13.2100647268342, 0),
  ZonePoint(52.537929427643, 13.2106343838233, 0),
  ZonePoint(52.5381396142665, 13.2106556132763, 0),
  ZonePoint(52.5381647218163, 13.2102876360908, 0)
}
_NgZga.OriginalPoint = ZonePoint(52.5380553244173, 13.2104105900062, 0)
_NgZga.DistanceRangeUOM = "Feet"
_NgZga.ProximityRangeUOM = "Meters"
_NgZga.OutOfRangeName = ""
_NgZga.InRangeName = ""
_x1EFp = Wherigo.Zone(theCartridge)
_x1EFp.Id = "0fa4bfa1-f36a-4e44-826d-5dc902d9c221"
_x1EFp.Name = _Eg9m("\bv\r/Sr||r2)\br\r2/r%Z")
_x1EFp.Description = _Eg9m("gS\021f\rS[;);r\r)\006\nS2/r||r)\023r\r\021Srfp\n\rr2)wS2\nr/w|v%Ur2)\023v\r/Sr||r2)\br\r2/r%Z\026")
_x1EFp.Visible = true
_x1EFp.Media = _h_hv
_x1EFp.Commands = {}
_x1EFp.DistanceRange = Distance(-1, "feet")
_x1EFp.ShowObjects = "OnEnter"
_x1EFp.ProximityRange = Distance(60, "meters")
_x1EFp.AllowSetPositionTo = false
_x1EFp.Active = false
_x1EFp.Points = {
  ZonePoint(52.5376877972193, 13.2131741514281, 0),
  ZonePoint(52.5376300472943, 13.2138851422124, 0),
  ZonePoint(52.5372486272772, 13.2136577134833, 0),
  ZonePoint(52.5372808600829, 13.2129113939642, 0)
}
_x1EFp.OriginalPoint = ZonePoint(52.5374618329684, 13.213407100272, 0)
_x1EFp.DistanceRangeUOM = "Feet"
_x1EFp.ProximityRangeUOM = "Meters"
_x1EFp.OutOfRangeName = ""
_x1EFp.InRangeName = ""
myAgentZ = Wherigo.ZCharacter(theCartridge)
myAgentZ.Id = "9aa6853c-00e5-46fe-aa64-3a5889ca373d"
myAgentZ.Name = _Eg9m("gfr[/)y)hS[prZ\n[[/r\r)gS\021r[/U\n|/L")
myAgentZ.Description = _Eg9m("`r\r)\021|Sr%U/vfr)gfr[/]);r[)r2)rv[wS\021\n[fr[)fv|/\026")
myAgentZ.Visible = true
myAgentZ.Media = _iA3V
myAgentZ.Icon = _D6eA
myAgentZ.Commands = {}
myAgentZ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
myAgentZ.Gender = "Male"
myAgentZ.Type = "NPC"
geofences = Wherigo.ZItem({Cartridge = theCartridge, Container = Player})
geofences.Id = "8b9f8319-f90b-4602-a1e1-978cfa0b6ca9"
geofences.Name = _Eg9m("srP\021r[%r2)h\015\018L")
geofences.Description = _Eg9m("srP\021r[%r2)\127s>\028])\n[);r[r[)y)[v%U/)\023P\rprv)Z\n[[\026)")
geofences.Visible = true
geofences.Media = _CG_V
geofences.Icon = _H_XW
geofences.Commands = {
  Aufstellen = Wherigo.ZCommand({
    Text = _Eg9m("gS\0212/r||r["),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  Abbauen = Wherigo.ZCommand({
    Text = _Eg9m([[
gpp
Sr[]]),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
geofences.Commands.Aufstellen.Custom = true
geofences.Commands.Aufstellen.Id = "dc4b510a-5629-4109-a113-10cbb012b216"
geofences.Commands.Aufstellen.WorksWithAll = true
geofences.Commands.Abbauen.Custom = true
geofences.Commands.Abbauen.Id = "1a27ac93-ec52-44d5-ab5e-0293e318781b"
geofences.Commands.Abbauen.WorksWithAll = true
geofences.ObjectLocation = Wherigo.INVALID_ZONEPOINT
geofences.Locked = false
geofences.Opened = false
Logbuch = Wherigo.ZItem(theCartridge)
Logbuch.Id = "08d26712-2488-4121-bfa9-150a36123c2e"
Logbuch.Name = _Eg9m("_PfpS%U")
Logbuch.Description = ""
Logbuch.Visible = false
Logbuch.Commands = {}
Logbuch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Logbuch.Locked = false
Logbuch.Opened = false
stadtplan = Wherigo.ZItem({Cartridge = theCartridge, Container = Player})
stadtplan.Id = "62cfe8f4-30ef-43b2-82da-ecdb1b3fb65a"
stadtplan.Name = _Eg9m("-/\n;/K|\n[)hyP[r)\015L")
stadtplan.Description = ""
stadtplan.Visible = true
stadtplan.Icon = _HCO
stadtplan.Commands = {
  _ZDp = Wherigo.ZCommand({
    Text = _Eg9m("\006|\nr//r\r["),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  _VJPZ = Wherigo.ZCommand({
    Text = _Eg9m("yP[r)2S%Ur["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
stadtplan.Commands._ZDp.Custom = true
stadtplan.Commands._ZDp.Id = "16cbd3ca-2558-4623-aa86-a1704693b54c"
stadtplan.Commands._ZDp.WorksWithAll = true
stadtplan.Commands._VJPZ.Custom = true
stadtplan.Commands._VJPZ.Id = "a2e098b1-b55f-4b30-a060-a746d2e29d1c"
stadtplan.Commands._VJPZ.WorksWithAll = true
stadtplan.ObjectLocation = Wherigo.INVALID_ZONEPOINT
stadtplan.Locked = false
stadtplan.Opened = false
locationer = Wherigo.ZItem({Cartridge = theCartridge, Container = Player})
locationer.Id = "9eb29ee5-b492-4c99-9145-fd2edd1b6b9d"
locationer.Name = _Eg9m("_P%\n/vP[r\r")
locationer.Description = _Eg9m("\bP\rUr\rvfr)yP[r\014)gZ/v\023vr\r/);vr)\023P\rUr\rvfr)yP[r])\021\n||2)2vr)\023r\r2rUr[/|v%U)\023r\r|\n22r[)\fS\r;r\005\006}\025yP[r)\023r\r|\n22r[\014)\br\r|\n22r[);r\r)yP[r])\fr[[)[v%U/2)\024rU\r)wS)/S[)v2/")
locationer.Visible = true
locationer.Media = _DGQCJ
locationer.Icon = _xJ3w4
locationer.Commands = {
  lastZone = Wherigo.ZCommand({
    Text = _Eg9m("\bP\rUr\rvfr)yP[r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  leaveZone = Wherigo.ZCommand({
    Text = _Eg9m("yP[r)\023r\r|\n22r["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
locationer.Commands.lastZone.Custom = true
locationer.Commands.lastZone.Id = "9f0ef214-9f92-41fd-9db4-798cd2f8aa35"
locationer.Commands.lastZone.WorksWithAll = true
locationer.Commands.leaveZone.Custom = true
locationer.Commands.leaveZone.Id = "7de7e877-8445-4a40-ac08-a6937ac62568"
locationer.Commands.leaveZone.WorksWithAll = true
locationer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
locationer.Locked = false
locationer.Opened = false
_Hi9t = Wherigo.ZItem({Cartridge = theCartridge, Container = Player})
_Hi9t.Id = "f66413d0-7895-4e2a-b587-4edf6a689966"
_Hi9t.Name = _Eg9m([[
'
f;|Pf]])
_Hi9t.Description = ""
_Hi9t.Visible = true
_Hi9t.Media = _s6ln
_Hi9t.Icon = _ApSO
_Hi9t.Commands = {
  _wi3 = Wherigo.ZCommand({
    Text = _Eg9m("yrvfr["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
_Hi9t.Commands._wi3.Custom = true
_Hi9t.Commands._wi3.Id = "45c50f4a-b16d-43a3-9b7c-ac5a980495bb"
_Hi9t.Commands._wi3.WorksWithAll = true
_Hi9t.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Hi9t.Locked = false
_Hi9t.Opened = false
myGeofence = Wherigo.ZItem(theCartridge)
myGeofence.Id = "a4a7b466-cd3a-480a-97b6-68e331de5084"
myGeofence.Name = _Eg9m("srP\021r[%r")
myGeofence.Description = ""
myGeofence.Visible = true
myGeofence.Media = _CG_V
myGeofence.Icon = _H_XW
myGeofence.Commands = {
  _maYpV = Wherigo.ZCommand({
    Text = _Eg9m([[
gpp
Sr[]]),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
myGeofence.Commands._maYpV.Custom = true
myGeofence.Commands._maYpV.Id = "e2b7b623-0f4e-4fbb-b9e3-93de38b5fb07"
myGeofence.Commands._maYpV.WorksWithAll = true
myGeofence.ObjectLocation = Wherigo.INVALID_ZONEPOINT
myGeofence.Locked = false
myGeofence.Opened = false
_Dc9pt = Wherigo.ZItem(theCartridge)
_Dc9pt.Id = "eabfe6b7-512b-4f64-8e18-81d5248e9c64"
_Dc9pt.Name = _Eg9m("\022P\024K|r/vP[%P;r")
_Dc9pt.Description = _Eg9m("`S)U\n2/);r[)gS\021/\r\nf)r\r\021Sr||/])`rv[)\022P\024K|r/vP[%P;r)|\nS/r/\014")
_Dc9pt.Visible = true
_Dc9pt.Media = _f0x
_Dc9pt.Commands = {
  _5g3X = Wherigo.ZCommand({
    Text = _Eg9m("\017S/\rP)\np2Kvr|r["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
_Dc9pt.Commands._5g3X.Custom = true
_Dc9pt.Commands._5g3X.Id = "2e459101-1bd8-4501-8710-7b74b2c53324"
_Dc9pt.Commands._5g3X.WorksWithAll = true
_Dc9pt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Dc9pt.Locked = false
_Dc9pt.Opened = false
_3P5 = Wherigo.ZItem({Cartridge = theCartridge, Container = Player})
_3P5.Id = "5d2b8d19-2b95-4442-95f1-89314a7f1ecb"
_3P5.Name = _Eg9m("<\r\n[2\024v//r\r")
_3P5.Description = _Eg9m("5v/);vr2r\024)sr\r\n/)Z\n[[2/)`S)prv)j\030}`)?v|\021r)\n[\021P\r;r\r[\026)g%U/S[f\014)'r;r)>S[Z/vP[)frU/)[S\r)rv[\024\n|0")
_3P5.Visible = true
_3P5.Media = _kfB3h
_3P5.Icon = _HZ4zx
_3P5.Commands = {
  _zBDef = Wherigo.ZCommand({
    Text = _Eg9m("G)yS\021\n||21s>"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  }),
  _2YWzo = Wherigo.ZCommand({
    Text = _Eg9m("-r/wr)s>"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  _XtozK = Wherigo.ZCommand({
    Text = _Eg9m("s>)r[/\021r\r[r["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  _tlTLA = Wherigo.ZCommand({
    Text = _Eg9m("-Kvr|)2Krv%Ur\r["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
_3P5.Commands._zBDef.Custom = true
_3P5.Commands._zBDef.Id = "07a2a38e-d7db-41ce-8108-cfe27fa26f61"
_3P5.Commands._zBDef.WorksWithAll = true
_3P5.Commands._2YWzo.Custom = true
_3P5.Commands._2YWzo.Id = "8e6ce8cb-8a4a-49b7-a344-b13bb38ebeca"
_3P5.Commands._2YWzo.WorksWithAll = true
_3P5.Commands._XtozK.Custom = true
_3P5.Commands._XtozK.Id = "5b65294e-43c3-4505-ac60-45026dc02a3d"
_3P5.Commands._XtozK.WorksWithAll = true
_3P5.Commands._tlTLA.Custom = true
_3P5.Commands._tlTLA.Id = "be512a8d-9c25-41a4-ae9f-1f7dca9fa4d6"
_3P5.Commands._tlTLA.WorksWithAll = true
_3P5.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3P5.Locked = false
_3P5.Opened = true
loctrainer = Wherigo.ZItem({Cartridge = theCartridge, Container = Player})
loctrainer.Id = "1fa0d491-e563-47e6-a238-763338f2387e"
loctrainer.Name = _Eg9m("_P%/\r\nv[r\r")
loctrainer.Description = ""
loctrainer.Visible = true
loctrainer.Media = _3jHvC
loctrainer.Icon = _xJ3w4
loctrainer.Commands = {
  enterZone = Wherigo.ZCommand({
    Text = _Eg9m("yP[r)pr/\rr/r["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  leaveZone = Wherigo.ZCommand({
    Text = _Eg9m("yP[r)\023r\r|\n22r["),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  captureZ = Wherigo.ZCommand({
    Text = _Eg9m("y)\021\n[fr["),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  }),
  lastZone = Wherigo.ZCommand({
    Text = _Eg9m("\bP\rUr\rvfr)yP[r"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _Eg9m("jP/Uv[f)\n\023\nv|\np|r")
  })
}
loctrainer.Commands.enterZone.Custom = true
loctrainer.Commands.enterZone.Id = "049b316c-9212-49f3-adb1-1f89fbae6ba3"
loctrainer.Commands.enterZone.WorksWithAll = true
loctrainer.Commands.leaveZone.Custom = true
loctrainer.Commands.leaveZone.Id = "6c9747ec-b05c-43ec-9f12-73286e996057"
loctrainer.Commands.leaveZone.WorksWithAll = true
loctrainer.Commands.captureZ.Custom = true
loctrainer.Commands.captureZ.Id = "1bfe8f57-bb6c-422f-93f6-fe3ff2305662"
loctrainer.Commands.captureZ.WorksWithAll = true
loctrainer.Commands.lastZone.Custom = true
loctrainer.Commands.lastZone.Id = "f726294e-4064-4d68-b133-e2c2179bfd67"
loctrainer.Commands.lastZone.WorksWithAll = true
loctrainer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
loctrainer.Locked = false
loctrainer.Opened = false
_dObf = Wherigo.ZItem(theCartridge)
_dObf.Id = "ffe91896-509d-49fd-864b-0dd3d7144ac5"
_dObf.Name = _Eg9m("lrf)wS\r)-K\rrr2%U\n[wr")
_dObf.Description = _Eg9m("mrpr\r);vr)?\n\023r|)}v%U/S[f)yv/\n;r||r\026)`\n[[)[\n%U);r\r)\006\rSr%Zr)\rr%U/2);vr)<\rrKKr)\rS[/r\r\026")
_dObf.Visible = true
_dObf.Media = _Sfo
_dObf.Commands = {}
_dObf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_dObf.Locked = false
_dObf.Opened = false
_8EE0 = Wherigo.ZItem(theCartridge)
_8EE0.Id = "75a2f054-9a46-43c5-89a3-4b496207c4e0"
_8EE0.Name = _Eg9m("-KPv|r\rpv|;")
_8EE0.Description = _Eg9m("g[);vr2r\r)-/r||r)\021v[;r2/)`S);vr)gZ/r[")
_8EE0.Visible = true
_8EE0.Media = _sY2s
_8EE0.Icon = _5HPFh
_8EE0.Commands = {}
_8EE0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8EE0.Locked = false
_8EE0.Opened = false
zTask = Wherigo.ZTask(theCartridge)
zTask.Id = "c2ec5c5e-3f35-4fad-97f2-36341ebe575c"
zTask.Name = _Eg9m("\tP2v/vP[)y\014)S[prZ\n[[/")
zTask.Description = _Eg9m("`r\rwrv/vfr\r)gS\021r[/U\n|/2P\r/)\023P[)gfr[/)y\026")
zTask.Visible = true
zTask.Media = _iA3V
zTask.Icon = _D6eA
zTask.Active = true
zTask.Complete = false
zTask.CorrectState = "None"
gfTask = Wherigo.ZTask(theCartridge)
gfTask.Id = "dfaa2194-aa98-4dbb-ae92-52f96aae55f6"
gfTask.Name = _Eg9m("s>)v[\014)Zrv[r")
gfTask.Description = _Eg9m("srP\021r[%r2)\fS\r;r[)v[)\n||r[)Ppr[)\n[frfrpr[r[)yP[r[)\nS\021fr2/r||/\026")
gfTask.Visible = true
gfTask.Media = _CG_V
gfTask.Icon = _H_XW
gfTask.Active = true
gfTask.Complete = false
gfTask.CorrectState = "None"
_XKvkP = Wherigo.ZTask(theCartridge)
_XKvkP.Id = "81cb19da-6a61-4a99-b6dc-0b0f20a12762"
_XKvkP.Name = _Eg9m("5v22vP[2wvr|")
_XKvkP.Description = _Eg9m(">\n[fr)gfr[/)y)S[;)p\rv[fr)vU[)v[2)j\030}`1?e\026")
_XKvkP.Visible = true
_XKvkP.Media = _1a9H
_XKvkP.Active = true
_XKvkP.Complete = false
_XKvkP.CorrectState = "None"
topo = ""
currentZoneAgent = 0
allowed = ""
verfuegbareSperren = 10
currentZonePlayer = 0
sperrPositionen = ""
kartenblatt = 1
enterAllowed = true
testZone = 0
_Mpm1e = ""
gesamtzahlSperren = 10
dayOfYear = 0
lastPos = 0
lastZonePlayer = 0
zoneAnswer = 0
isZCaptured = false
jagdLog = ""
numMoves = 0
gfAnswer = 0
demomode = false
startzone = 0
_hYOy = false
_iwScY = false
CR = ""
_9bC = false
_WrZ6V = false
myCurrentZone = _Eg9m("wP[rG\015")
_2GOdA = _Eg9m("\024Qgfr[/y")
_uKD = _Eg9m("frP\021r[%r2")
_KBzH = _Eg9m([[
w<
2Z]])
_Bhp = _Eg9m("r[/r\ryP[r")
_ir50 = _Eg9m("FRJ\024p")
theCartridge.ZVariables = {
  topo = "",
  currentZoneAgent = 0,
  allowed = "",
  verfuegbareSperren = 10,
  currentZonePlayer = 0,
  sperrPositionen = "",
  kartenblatt = 1,
  enterAllowed = true,
  testZone = 0,
  _Mpm1e = "",
  gesamtzahlSperren = 10,
  dayOfYear = 0,
  lastPos = 0,
  lastZonePlayer = 0,
  zoneAnswer = 0,
  isZCaptured = false,
  jagdLog = "",
  numMoves = 0,
  gfAnswer = 0,
  demomode = false,
  startzone = 0,
  _hYOy = false,
  _iwScY = false,
  CR = "",
  _9bC = false,
  _WrZ6V = false,
  myCurrentZone = _Eg9m("wP[rG\015"),
  _2GOdA = _Eg9m("\024Qgfr[/y"),
  _uKD = _Eg9m("frP\021r[%r2"),
  _KBzH = _Eg9m([[
w<
2Z]]),
  _Bhp = _Eg9m("r[/r\ryP[r"),
  _ir50 = _Eg9m("FRJ\024p")
}
_xjmb = Wherigo.ZTimer(theCartridge)
_xjmb.Id = "e293b863-d287-4f64-b53f-488ffddcb5d5"
_xjmb.Name = _Eg9m("g[\rS\021")
_xjmb.Description = ""
_xjmb.Visible = true
_xjmb.Duration = 10
_xjmb.Type = "Countdown"
_9x6uO = Wherigo.ZTimer(theCartridge)
_9x6uO.Id = "4c974398-e0f6-48ab-a7b3-0551f70b8089"
_9x6uO.Name = _Eg9m("\bv\r/S\n|)\tPKSK")
_9x6uO.Description = ""
_9x6uO.Visible = true
_9x6uO.Duration = 4
_9x6uO.Type = "Countdown"
enterZone = Wherigo.ZInput(theCartridge)
enterZone.Id = "1fd0eaf1-556f-44d8-9658-f7674e0b0eb3"
enterZone.Name = _Eg9m("\030[/r\ryP[r")
enterZone.Description = ""
enterZone.Visible = true
enterZone.Media = _3jHvC
enterZone.Choices = {"1"}
enterZone.InputType = "MultipleChoice"
enterZone.Text = _Eg9m("lr|%Ur)yP[r)pr/\rr/r[\\")
setFreeGF = Wherigo.ZInput(theCartridge)
setFreeGF.Id = "51d722d7-4974-48ba-805a-0560ba0c9098"
setFreeGF.Name = _Eg9m("-r/>\rrrs>")
setFreeGF.Description = ""
setFreeGF.Visible = true
setFreeGF.Media = _CG_V
setFreeGF.Choices = {}
setFreeGF.InputType = "MultipleChoice"
setFreeGF.Text = _Eg9m("#[)\fr|%Ur\r)yP[r)\nS\0212/r||r[\\")
_r_u = Wherigo.ZInput(theCartridge)
_r_u.Id = "b0e02977-3efa-4689-8820-b7d6bab4be0e"
_r_u.Name = _Eg9m("<\r\nv[\017\r_v\023r")
_r_u.Description = ""
_r_u.Visible = true
_r_u.Media = _O331
_r_u.Choices = {"Simulation", "Live-Jagd"}
_r_u.InputType = "MultipleChoice"
_r_u.Text = _Eg9m("?r\rw|v%U)\fv||ZP\024\024r[])\0020)lP||r[)-vr)r\r2/\024\n|);vr)?\n[;U\npS[f)|r\r[r[)P;r\r)f|rv%U)2/\n\r/r[\\")
removeFreeGF = Wherigo.ZInput(theCartridge)
removeFreeGF.Id = "822d66bb-977e-41e9-82fe-8e59d7f731fe"
removeFreeGF.Name = _Eg9m("}r\024P\023r>\rrrs>")
removeFreeGF.Description = ""
removeFreeGF.Visible = true
removeFreeGF.Media = _CG_V
removeFreeGF.Choices = {}
removeFreeGF.InputType = "MultipleChoice"
removeFreeGF.Text = _Eg9m("gS2)\fr|%Ur\r)yP[r)r[/\021r\r[r[\\")
zonensucher = Wherigo.ZInput(theCartridge)
zonensucher.Id = "7919ed03-1be6-4af3-808b-bad13e952bf7"
zonensucher.Name = _Eg9m("yP[r[2S%Ur\r")
zonensucher.Description = ""
zonensucher.Visible = true
zonensucher.InputType = "Text"
zonensucher.Text = _Eg9m("sr2S%U/r)yP[r\\")
_ebh = Wherigo.ZInput(theCartridge)
_ebh.Id = "4445396b-1394-437a-a213-d4b675b79164"
_ebh.Name = _Eg9m("\bv\r/Sr||r\r)_Pfrv[/\r\nf")
_ebh.Description = _Eg9m("<r\024KP\r\n\rr)5Pf|v%UZrv/)rv[r2)\023v\r/Sr||r[)_Pfrv[/\r\nfr2)\frfr[);r\r)\006\nS2/r||r\026")
_ebh.Visible = true
_ebh.Choices = {"Ja", "Nein"}
_ebh.InputType = "MultipleChoice"
_ebh.Text = _Eg9m("lv||2/)`S)\023v\r/Sr||)|Pffr[\\")
_zBHM = Wherigo.ZInput(theCartridge)
_zBHM.Id = "c1004638-d766-4df4-a470-8bd43f6084ba"
_zBHM.Name = _Eg9m("}r\n|r\r)ySf\n[f")
_zBHM.Description = _Eg9m(">\n||2);P%U)rv[)\rr\n|r\r)ySf\n[f)\024Prf|v%U)v2/)Z\n[[);\n2)-Kvr|)Uvr\r)[P%U)\rr\n|)prr[;r/)\fr\r;r[\026")
_zBHM.Visible = true
_zBHM.Choices = {"Ja", "Nein"}
_zBHM.InputType = "MultipleChoice"
_zBHM.Text = _Eg9m("lv||2/)`S)wS\024)\rr\n|r[)\br\r2/r%Z)frUr[\\)\127\006rv)j\030#j)\fv\r;);\n2)-Kvr|)Uvr\r)\023v\r/Sr||)prr[;r/0\028")
function theCartridge:OnStart()
  local _Urwigo_Date = os.date("*t")
  dayOfYear = _Urwigo.Date_DayInYear(_Urwigo_Date)
  initAll(theCartridge)
  verfuegbareSperren = gesamtzahlSperren
  geofences.Name = (_Eg9m("srP\021r[%r2)h") .. verfuegbareSperren) .. _Eg9m("L")
  _SukKK()
end
function theCartridge:OnRestore()
end
function zone31:OnEnter()
  myCurrentZone = _Eg9m("wP[rG\015")
  _Urwigo.GlobalZoneEnter()
end
function zone31:OnExit()
  myCurrentZone = _Eg9m("wP[rG\015")
  _Urwigo.GlobalZoneExit()
end
function zone32:OnEnter()
  myCurrentZone = _Eg9m("wP[rG\004")
  _Urwigo.GlobalZoneEnter()
end
function zone32:OnExit()
  myCurrentZone = _Eg9m("wP[rG\004")
  _Urwigo.GlobalZoneExit()
end
function zone30:OnEnter()
  myCurrentZone = _Eg9m("wP[rG\018")
  _Urwigo.GlobalZoneEnter()
end
function zone30:OnExit()
  myCurrentZone = _Eg9m("wP[rG\018")
  _Urwigo.GlobalZoneExit()
end
function zone14:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015(")
  _Urwigo.GlobalZoneEnter()
end
function zone14:OnExit()
  myCurrentZone = _Eg9m("wP[r\015(")
  _Urwigo.GlobalZoneExit()
end
function zone16:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015\v")
  _Urwigo.GlobalZoneEnter()
end
function zone16:OnExit()
  myCurrentZone = _Eg9m("wP[r\015\v")
  _Urwigo.GlobalZoneExit()
end
function zone33:OnEnter()
  myCurrentZone = _Eg9m("wP[rGG")
  _Urwigo.GlobalZoneEnter()
end
function zone33:OnExit()
  myCurrentZone = _Eg9m("wP[rGG")
  _Urwigo.GlobalZoneExit()
end
function zone34:OnEnter()
  myCurrentZone = _Eg9m("wP[rG(")
  _Urwigo.GlobalZoneEnter()
end
function zone34:OnExit()
  myCurrentZone = _Eg9m("wP[rG(")
  _Urwigo.GlobalZoneExit()
end
function zone29:OnEnter()
  myCurrentZone = _Eg9m("wP[r\0047")
  _Urwigo.GlobalZoneEnter()
end
function zone29:OnExit()
  myCurrentZone = _Eg9m("wP[r\0047")
  _Urwigo.GlobalZoneExit()
end
function zone13:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015G")
  _Urwigo.GlobalZoneEnter()
end
function zone13:OnExit()
  myCurrentZone = _Eg9m("wP[r\015G")
  _Urwigo.GlobalZoneExit()
end
function zone5:OnEnter()
  myCurrentZone = _Eg9m("wP[rA")
  _Urwigo.GlobalZoneEnter()
end
function zone5:OnExit()
  myCurrentZone = _Eg9m("wP[rA")
  _Urwigo.GlobalZoneExit()
end
function zone6:OnEnter()
  myCurrentZone = _Eg9m("wP[r\v")
  _Urwigo.GlobalZoneEnter()
end
function zone6:OnExit()
  myCurrentZone = _Eg9m("wP[r\v")
  _Urwigo.GlobalZoneExit()
end
function zone17:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015\027")
  _Urwigo.GlobalZoneEnter()
end
function zone17:OnExit()
  myCurrentZone = _Eg9m("wP[r\015\027")
  _Urwigo.GlobalZoneExit()
end
function zone18:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015u")
  _Urwigo.GlobalZoneEnter()
end
function zone18:OnExit()
  myCurrentZone = _Eg9m("wP[r\015u")
  _Urwigo.GlobalZoneExit()
end
function zone1:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015")
  _Urwigo.GlobalZoneEnter()
end
function zone1:OnExit()
  myCurrentZone = _Eg9m("wP[r\015")
  _Urwigo.GlobalZoneExit()
end
function zone19:OnEnter()
  myCurrentZone = _Eg9m("wP[r\0157")
  _Urwigo.GlobalZoneEnter()
end
function zone19:OnExit()
  myCurrentZone = _Eg9m("wP[r\0157")
  _Urwigo.GlobalZoneExit()
end
function zone12:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015\004")
  _Urwigo.GlobalZoneEnter()
end
function zone12:OnExit()
  myCurrentZone = _Eg9m("wP[r\015\004")
  _Urwigo.GlobalZoneExit()
end
function zone20:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004\018")
  _Urwigo.GlobalZoneEnter()
end
function zone20:OnExit()
  myCurrentZone = _Eg9m("wP[r\004\018")
  _Urwigo.GlobalZoneExit()
end
function zone28:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004u")
  _Urwigo.GlobalZoneEnter()
end
function zone28:OnExit()
  myCurrentZone = _Eg9m("wP[r\004u")
  _Urwigo.GlobalZoneExit()
end
function zone4:OnEnter()
  myCurrentZone = _Eg9m("wP[r(")
  _Urwigo.GlobalZoneEnter()
end
function zone4:OnExit()
  myCurrentZone = _Eg9m("wP[r(")
  _Urwigo.GlobalZoneExit()
end
function zone3:OnEnter()
  myCurrentZone = _Eg9m("wP[rG")
  _Urwigo.GlobalZoneEnter()
end
function zone3:OnExit()
  myCurrentZone = _Eg9m("wP[rG")
  _Urwigo.GlobalZoneExit()
end
function zone8:OnEnter()
  myCurrentZone = _Eg9m("wP[ru")
  _Urwigo.GlobalZoneEnter()
end
function zone8:OnExit()
  myCurrentZone = _Eg9m("wP[ru")
  _Urwigo.GlobalZoneExit()
end
function zone21:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004\015")
  _Urwigo.GlobalZoneEnter()
end
function zone21:OnExit()
  myCurrentZone = _Eg9m("wP[r\004\015")
  _Urwigo.GlobalZoneExit()
end
function zone11:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015\015")
  _Urwigo.GlobalZoneEnter()
end
function zone11:OnExit()
  myCurrentZone = _Eg9m("wP[r\015\015")
  _Urwigo.GlobalZoneExit()
end
function zone2:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004")
  _Urwigo.GlobalZoneEnter()
end
function zone2:OnExit()
  myCurrentZone = _Eg9m("wP[r\004")
  _Urwigo.GlobalZoneExit()
end
function zone9:OnEnter()
  myCurrentZone = _Eg9m("wP[r7")
  _Urwigo.GlobalZoneEnter()
end
function zone9:OnExit()
  myCurrentZone = _Eg9m("wP[r7")
  _Urwigo.GlobalZoneExit()
end
function zone26:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004\v")
  _Urwigo.GlobalZoneEnter()
end
function zone26:OnExit()
  myCurrentZone = _Eg9m("wP[r\004\v")
  _Urwigo.GlobalZoneExit()
end
function zone25:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004A")
  _Urwigo.GlobalZoneEnter()
end
function zone25:OnExit()
  myCurrentZone = _Eg9m("wP[r\004A")
  _Urwigo.GlobalZoneExit()
end
function zone23:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004G")
  _Urwigo.GlobalZoneEnter()
end
function zone23:OnExit()
  myCurrentZone = _Eg9m("wP[r\004G")
  _Urwigo.GlobalZoneExit()
end
function zone10:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015\018")
  _Urwigo.GlobalZoneEnter()
end
function zone10:OnExit()
  myCurrentZone = _Eg9m("wP[r\015\018")
  _Urwigo.GlobalZoneExit()
end
function zone22:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004\004")
  _Urwigo.GlobalZoneEnter()
end
function zone22:OnExit()
  myCurrentZone = _Eg9m("wP[r\004\004")
  _Urwigo.GlobalZoneExit()
end
function zone24:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004(")
  _Urwigo.GlobalZoneEnter()
end
function zone24:OnExit()
  myCurrentZone = _Eg9m("wP[r\004(")
  _Urwigo.GlobalZoneExit()
end
function zone15:OnEnter()
  myCurrentZone = _Eg9m("wP[r\015A")
  _Urwigo.GlobalZoneEnter()
end
function zone15:OnExit()
  myCurrentZone = _Eg9m("wP[r\015A")
  _Urwigo.GlobalZoneExit()
end
function zone27:OnEnter()
  myCurrentZone = _Eg9m("wP[r\004\027")
  _Urwigo.GlobalZoneEnter()
end
function zone27:OnExit()
  myCurrentZone = _Eg9m("wP[r\004\027")
  _Urwigo.GlobalZoneExit()
end
function zone7:OnEnter()
  myCurrentZone = _Eg9m("wP[r\027")
  _Urwigo.GlobalZoneEnter()
end
function zone7:OnExit()
  myCurrentZone = _Eg9m("wP[r\027")
  _Urwigo.GlobalZoneExit()
end
function zone35:OnEnter()
  myCurrentZone = _Eg9m("wP[rGA")
  _Urwigo.GlobalZoneEnter()
  enterSpreeschanze()
end
function zone35:OnExit()
  myCurrentZone = _Eg9m("wP[rGA")
  _Urwigo.GlobalZoneExit()
end
function zone36:OnEnter()
  myCurrentZone = _Eg9m("wP[rG\v")
  _Urwigo.GlobalZoneEnter()
  enterVersteck()
end
function zone36:OnExit()
  myCurrentZone = _Eg9m("wP[rG\v")
  _Urwigo.GlobalZoneExit()
end
function _NgZga:OnEnter()
  myCurrentZone = _Eg9m("Fjfyf\n")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _Eg9m("?vr\r)v2/);r\rwrv/)rv[r)\006\nS2/r||r\026)`S)Z\n[[2/)\f\nU\r2%Urv[|v%U);S\r%U);r[)\006\nSw\nS[)}v%U/S[f)m\021r\r)frUr[)S[;)`v%U);\n[[)\021\rrv)wS\024)\br\r2/r%Z)pr\frfr[\026"),
      Media = _AEVX
    },
    {
      Text = _Eg9m("lr[[)`S);\n2)[v%U/)\fv||2/)pvr/r[)\fv\r)`v\r)\n|/r\r[\n/v\023)rv[)\023v\r/Sr||r2)\030[;r)\127PU[r)KUQ2v2%Ur[)_Pfrv[/\r\nf\028)\n[\026"),
      Media = _AEVX
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_ebh)
    end)
  end)
end
function _NgZga:OnExit()
  myCurrentZone = _Eg9m("Fjfyf\n")
  _Urwigo.GlobalZoneExit()
end
function _x1EFp:OnEnter()
  myCurrentZone = _Eg9m("FR\015\030>K")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _Eg9m("`S)pv2/)Jr/w/)prv\024)\023v\r/Sr||r[)\br\r2/r%Z\026)lr[[)\023P[)Uvr\r);r\r)ySf\n[f)wS\024)\br\r2/r%Z)v[w\fv2%Ur[)\024Prf|v%U)2rv[)2P||/r)Z\n[[2/)`S);\n2)-Kvr|);P%U)[P%U)\rr\n|)prr[;r[\026)"),
      Media = _AEVX
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_zBHM)
    end)
  end)
end
function _x1EFp:OnExit()
  myCurrentZone = _Eg9m("FR\015\030>K")
  _Urwigo.GlobalZoneExit()
end
function enterZone:OnGetInput(input)
  if input == nil then
    input = ""
  end
  zoneAnswer = tonumber(input)
  if isActiveZone(zoneAnswer) then
    playerEnterZone(zoneAnswer)
    if zoneAnswer == 35 then
      enterSpreeschanze()
    elseif zoneAnswer == 36 then
      enterVersteck()
    else
      _T9Hf()
    end
  else
    _Urwigo.MessageBox({
      Text = _Eg9m("m[fSr|/vfr)yP[r])pv//r)[P%U\024\n|)rv[frpr[0")
    })
  end
end
function setFreeGF:OnGetInput(input)
  if input == nil then
    input = ""
  end
  gfAnswer = tonumber(input)
  if isGFSetAllowed(gfAnswer) then
    setGFinAnyZone(gfAnswer)
    updateSperren()
    _Urwigo.MessageBox({
      Text = _Eg9m("srP\021r[%r)fr2r/w/0"),
      Media = _CG_V
    })
  else
    _Urwigo.MessageBox({
      Text = _Eg9m("yP[r)v2/)2%UP[)fr2Kr\r\r/])pv//r)[P%U\024\n|)rv[frpr[0")
    })
  end
end
function _r_u:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 37345 then
    demomode = true
    loctrainer:MoveTo(Player)
    loctrainer.Commands.captureZ.Enabled = false
    locationer:MoveTo(nil)
    enableAllStartzones()
  else
    demomode = false
    loctrainer:MoveTo(nil)
    loctrainer.Commands.captureZ.Enabled = false
    locationer:MoveTo(Player)
    activateXStartZones()
  end
end
function removeFreeGF:OnGetInput(input)
  if input == nil then
    input = ""
  end
  gfAnswer = tonumber(input)
  if isGFRemoveAllowed(gfAnswer) then
    removeGFFromZone(gfAnswer)
    updateSperren()
    _Urwigo.MessageBox({
      Text = _Eg9m("srP\021r[%r)r[/\021r\r[/0"),
      Media = _CG_V
    })
  else
    _Urwigo.MessageBox({
      Text = _Eg9m("yP[r)v2/)[v%U/)fr2Kr\r\r/])pv//r)[P%U\024\n|)rv[frpr[0")
    })
  end
end
function zonensucher:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  zoneAnswer = input
  if zoneAnswer <= 34 and zoneAnswer >= 1 then
    showZoneMap(zoneAnswer)
  else
    _Urwigo.MessageBox({
      Text = _Eg9m(">\n|2%Ur)\030v[f\npr])pv//r)\0151G()rv[frpr[0")
    })
  end
end
function _ebh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _x1EFp.Active = true
    _Urwigo.OldDialog({
      {
        Text = _Eg9m("srU$;vr)<\rrKKr)\fvr;r\r)UP%U);\n[[)\rr%U/2)pv2)wS\r)[\nr%U2/r[)t\rrSwS[f)S[;);P\r/)\rr%U/2)wS\024)\023v\r/Sr||r[)\br\r2/r%Z\026"),
        Media = _iA3V
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _Eg9m("sS/]);\n[[)\024\n%Ur[)\fv\r)\frv/r\r])\n|2)f\nrpr)r2);r[)\006\nSw\nS[)[v%U/\026)lr[[)`S);P%U)[v%U/)pv2)wS\r)`P2r)ZP\024\0242/);\n\r\0212/)`S)fr\r[r)Uvr\rUr\r)wS\rSr%Z)ZP\024\024r[)S[;);\n2)\023v\r/Sr||r)\br\r2/r%Z)\f\nrU|r[\026"),
      Media = _iA3V
    })
  end
end
function _zBHM:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 9796 then
    _NgZga.Active = false
    _WrZ6V = true
    _Urwigo.MessageBox({
      Text = _Eg9m("\030v[r[)gSfr[p|v%Z])`S)\fv\r2/)v[2)\023v\r/Sr||r)\br\r2/r%Z)/\r\n[2\021r\rvr\r/\026\026\026"),
      Media = _AEVX,
      Callback = function(action)
        if action ~= nil then
          _9x6uO:Start()
        end
      end
    })
  else
    _x1EFp.Active = false
    _Urwigo.MessageBox({
      Text = _Eg9m("\t\rv\024\n0)`\n[[)frU$)Jr/w/)\frv/r\r)wS\024)\br\r2/r%Z0"),
      Media = _mBlA
    })
  end
end
function _xjmb:OnTick()
  PlaySound(Klingeln)
  _Urwigo.Dialog(false, {
    {
      Text = _Eg9m("?\n||P])\002])U\npr[)-vr)y\\"),
      Media = _r3p5
    },
    {
      Text = _Eg9m("\002])y])\fP\023P[)\rr;r[)-vr\\)lr\r)2v[;)-vr)rvfr[/|v%U\\"),
      Media = _mBlA
    },
    {
      Text = _Eg9m("#%U)pv[)a])-vr)U\npr[)rv[r[)Z|\n\rr[)gS\021/\r\nf)\023P[)\024v\r)r\rU\n|/r[0"),
      Media = _r3p5
    },
    {
      Text = _Eg9m("'r/w/)\nS\021)rv[\024\n|)a\\)<\r\nv[vr\rr[)\fv\r)Uvr\r);\n2)g|KU\npr/)P;r\r)\f\n2\\"),
      Media = _mBlA
    },
    {
      Text = _Eg9m("hS[;rS/|v%U])[\n%U)Uv[/r[)v[);r[)}\nS\024)2K\rr%Ur[;L)5v2/])\n[2%Urv[r[;)\fS\r;r)\002)\nS%U)frp|v/w;v[f2/])Jr/w/)v2/)y)2%UP[)\fvr;r\r)r[/\fv2%U/\026"),
      Media = _r3p5
    },
    {
      Text = _Eg9m("h|\nS/)S[;);rS/|v%UL)\030[/2%US|;vfS[f]);\n)U\npr[)-vr)\024v%U)\fPU|)\024v22\023r\r2/\n[;r[\026)#%U)\rS\021r)\n[)\023P[);r\r)>v\r\024\n)\002ay1\022P\024)S[;)\fP||/r)#U[r[)rv[r[)S[2%U|\nfp\n\rr[)?\n[;Q1<\n\rv\021)\n[pvr/r[\026\026\026"),
      Media = _r3p5
    },
    {
      Text = _Eg9m("jrv[)`\n[Zr0)h|rf/)\nS\021L)jv%U/)\024\n|)v[)}SUr)%\n%Ur[)Z\n[[)\024\n[)Uvr\r0"),
      Media = _mBlA
    },
    {
      Text = _Eg9m("l\n2)v%U)[P%U)\023r\rfr22r[)U\n//r\014)?vr\r)U\n2/)`S)rv[)-KPv|r\rpv|;0"),
      Media = _iA3V
    },
    {
      Text = _Eg9m("m[;)Uvr\r)\nS%U)[P%U)v2/);r\r)T\022P\024K|r/vP[)\022P;rT])S\024)\nS\021)\fUr\rvfP\026%P\024)wS)|Pffr[])[v\024\024)vU[)v[)`rv[)#[\023r[/\n\r\026"),
      Media = _iA3V
    }
  }, function(action)
    theCartridge.Complete = true
    _Dc9pt.Description = _Dc9pt.Description .. string.sub(Player.CompletionCode, 1, 15)
    _8EE0:MoveTo(Player)
    _Dc9pt:MoveTo(Player)
    _Urwigo.MessageBox({
      Text = _Eg9m("`vr)\022\n\r/\rv;fr)\fv\r;)Jr/w/)fr2Krv%Ur\r/])rv[r[)5P\024r[/)pv//r0"),
      Callback = function(action)
        if action ~= nil then
          theCartridge:RequestSync()
          if _WrZ6V == true then
            _Urwigo.MessageBox({
              Text = _Eg9m("`S)U\n2/);r[)\022\n%Ur)\np2P|\023vr\r/)S[;)U\n2/)Uvr\r\024v/);vr)\030\r|\nSp[v2);r2)\017\f[r\r2])\nS%U)PU[r)KUQ2v2%Ur[)_Pfrv[/\r\nf)2P\fPU|)P[|v[r)\n|2)\nS%U)\nS\021)\fUr\rvfP\026%P\024)wS)|Pffr[\026)-Pp\n|;);vr)\006\nS2/r||r)\frf)v2/)Z\n[[2/)`S);r[)KUQ2v2%Ur[)_Pfrv[/\r\nf)fr\r[r)[\n%UUP|r[\026"),
              Media = _AEVX,
              Callback = function(action)
                if action ~= nil then
                  _r3sUG()
                end
              end
            })
          else
            _r3sUG()
          end
        end
      end
    })
  end)
end
function _9x6uO:OnTick()
  enterVersteck()
end
function geofences:OnAufstellen(target)
  if isGFAllowedInPlayerZone() == true then
    setGFInPlayerZone()
  else
    _Urwigo.MessageBox({
      Text = _Eg9m("?vr\r)2/rU/)2%UP[)rv[)srP\021r[%r0")
    })
  end
end
function geofences:OnAbbauen(target)
  if isGFAllowedInPlayerZone() == false then
    removeGF()
  else
    _Urwigo.MessageBox({
      Text = _Eg9m("?vr\r)2/rU/)Zrv[)srP\021r[%r0")
    })
  end
end
function stadtplan:On_ZDp(target)
  blaetternKarte()
end
function stadtplan:On_VJPZ(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zonensucher)
  end)
end
function locationer:OnlastZone(target)
  activateLastZonePlayer()
end
function locationer:OnleaveZone(target)
  leaveZone()
end
function _Hi9t:On_wi3(target)
  _Urwigo.MessageBox({
    Text = _Eg9m("'\nf;\023r\r|\nS\021\014\005\006}\025") .. jagdLog
  })
end
function myGeofence:On_maYpV(target)
  removeGF()
end
function _Dc9pt:On_5g3X(target)
  _r3sUG()
end
function _3P5:On_zBDef(target)
  setThreeRandomGF()
  _Urwigo.MessageBox({
    Text = _Eg9m("G)s>)fr2r/w/0"),
    Callback = function(action)
      if action ~= nil then
        _3P5.Commands._zBDef.Enabled = false
      end
    end
  })
end
function _3P5:On_2YWzo(target)
  setFreeGFChoices()
  _PgV()
  _3P5.Commands._2YWzo.Enabled = false
end
function _3P5:On_XtozK(target)
  _8CX()
  _3P5.Commands._XtozK.Enabled = false
end
function _3P5:On_tlTLA(target)
  theCartridge:RequestSync()
  _Urwigo.MessageBox({
    Text = _Eg9m("-Kvr|2/\n[;)fr2Krv%Ur\r/0)yS\024)>P\r/2r/wr[)pv//r)\n[);vr2r\r)\tP2v/vP[)\fvr;r\r)|\n;r[0"),
    Media = _AEVX
  })
end
function loctrainer:OnenterZone(target)
  setEnterZoneChoices()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(enterZone)
  end)
end
function loctrainer:OnleaveZone(target)
  leaveZone()
end
function loctrainer:OncaptureZ(target)
  captureZ()
  updateSperren()
  _Urwigo.MessageBox({
    Text = _Eg9m("y)\fS\r;r)\024v/)srP\021r[%r2)S\024wv[fr|/])prv);r\r)[\nr%U2/r[)\006r\frfS[f)U\n2/)`S)vU[0")
  })
end
function loctrainer:OnlastZone(target)
  activateLastZonePlayer()
end
function _Urwigo.GlobalZoneEnter()
  playerEnterZone(0)
  _T9Hf()
end
function _Urwigo.GlobalZoneExit()
  leaveZone()
end
function _T9Hf()
  if isZCaptured == true and _hYOy == false then
    if demomode == false then
      captureDialog()
    else
      _Urwigo.Dialog(false, {
        {
          Text = _Eg9m("\006\r\n\023P])`S)U\n2/);vr)-v\024S|\n/vP[)r\r\021P|f\rrv%U)fr\024rv2/r\r/)S[;)pv2/)Jr/w/)pr\rrv/])TyT)wS)\021\n[fr[\026"),
          Media = _r3p5
        },
        {
          Text = _Eg9m("\017t])S[;)\fvr)\024\n%Ur)v%U);\n2)Jr/w/\\"),
          Media = _mBlA
        },
        {
          Text = _Eg9m(">\nU\rr)wS\r)g|/2/\n;/)-K\n[;\nS)S[;)2/\n\r/r);P\r/);vr)\022\n\r/\rv;fr)[rS\026)\006r\n[/\fP\r/r);\n[[);vr)>\r\nfr)[\n%U);r\r)-v\024S|\n/vP[)\024v/)Tjrv[T)S[;)2%UP[)frU/)r2)|P20"),
          Media = _r3p5
        },
        {
          Text = _Eg9m("\017t]);\n2)K\rPpvr\rr)v%U)\nS2]);\n[Zr)r\r2/\024\n|0"),
          Media = _mBlA
        }
      }, function(action)
        loctrainer:MoveTo(nil)
      end)
    end
  end
end
function enterSpreeschanze()
  _Urwigo.Dialog(false, {
    {
      Text = _Eg9m("-P])Jr/w/)2v[;)\fv\r)f|rv%U);\n0"),
      Media = _iA3V
    },
    {
      Text = _Eg9m("lPUv[)Jr/w/\\"),
      Media = _mBlA
    },
    {
      Text = _Eg9m("'r/w/)frU/$2)wS)>S22)\n[2)-K\rrrS\021r\r\026)srU)\024\n|);\n)\023P\r[r)\rr%U/2);vr)<\rrKKr)\rS[/r\r)S[;)U\n|/r)`v%U)\frv/r\r)\rr%U/2)}v%U/S[f)m\021r\r\026)srU$);\n[[)r\r2/\024\n|)K\n\r\n||r|)wS\024)m\021r\r)}v%U/S[f)-Sr;r[)pv2)r2)[v%U/)\024rU\r)\frv/r\r)frU/]);\n[[)[\n%U)\0172/r[]);\n[[)wrvfr)v%U)`v\r);r[)lrf\026"),
      Media = _iA3V
    },
    {
      Text = _Eg9m("\017t]);\n[[)Z\n[[)v%U);vr)lrfpr2%U\rrvpS[f)J\n)\nS%U)\frf2/r%Zr[\026"),
      Media = _mBlA
    }
  }, function(action)
    _dObf:MoveTo(nil)
    zone35.Active = false
    _NgZga.Active = true
    zone36.Active = true
  end)
end
function enterVersteck()
  if _iwScY == false then
    _NgZga.Active = false
    _Urwigo.Dialog(false, {
      {
        Text = _Eg9m("?vr\r)v2/)f|rv%U);\n2)\br\r2/r%Z0"),
        Media = _iA3V
      },
      {
        Text = _Eg9m("'r/w/)[r\r\023/$2)\024v%U)|\n[f2\n\024])\fP)U\n2/)`S);vr)gZ/r[);r[[)Jr/w/)\023r\r2/r%Z/\\"),
        Media = _mBlA
      },
      {
        Text = _Eg9m("jP%U)rv[r)-rZS[;r])2%U\nS)\024\n|)Ur\r0"),
        Media = _iA3V
      },
      {
        Text = _Eg9m("lP\\"),
        Media = _mBlA
      },
      {
        Text = _Eg9m("?vr\r)wS)\024v\r0"),
        Media = _iA3V
      },
      {
        Text = _Eg9m("\\\\\\"),
        Media = _mBlA
      },
      {
        Text = _Eg9m("#2/);\n2\026\026\026"),
        Media = _RHWz
      },
      {
        Text = _Eg9m("\026\026\026)rv[)\026\026\026"),
        Media = _PuQjx
      },
      {
        Text = _Eg9m("\026\026\026)\006|v/w;)\026\026\026)\029\029\029)>|\n2U)\029\029\029"),
        Media = _njO
      },
      {
        Text = _Eg9m("lP)pv[)v%U\\)l\n2)\024\n%Ur)v%U)Uvr\r\\"),
        Media = _mBlA
      },
      {
        Text = _Eg9m("?\n||P0)\006v2/)`S)\nS%U)\022\n%Ur\r\\)`S)2S%U2/)pr2/v\024\024/);\n2)>v[\n|)\023P\024)TZ1wS2r2)'\nf;)\nS\021)yT])P;r\r\\"),
        Media = _iA3V
      },
      {
        Text = _Eg9m("5\024\024\024U])J\n\\"),
        Media = _mBlA
      },
      {
        Text = _Eg9m("g[);r\r)m\021r\rpr\021r2/vfS[f);\n)\023P\r[r)\n[);r\r)|v[Zr[)-rv/r\026)s\rrv\021$)\024\n|);\nUv[/r\r0"),
        Media = _iA3V
      },
      {
        Text = _Eg9m("\t\rv\024\n]);\n[Zr0)\127l\n2)\f\n\r)[S\r)\024v/)\024v\r)|P2])v\rfr[;\fvr)\f\n\r)\024v\r)f\r\n;r)ZS\rw)2%U\fS\024\024r\rvf\026\026\026\028"),
        Media = _mBlA
      }
    }, function(action)
      _XKvkP.Description = _Eg9m("-S%Ur);r[)\022\n%Ur)S[;)/\r\nfr)`v%U)v[2)_PfpS%U)rv[\026)`vr)`P2r)|vrf/)\n[);r\r)m\021r\rpr\021r2/vfS[f)\023P\r[r)|v[Z2)\127;\nUv[/r\r)f\rrv\021r[\028\026")
      myAgentZ.Name = _Eg9m("srP%\n%Ur\r")
      myAgentZ.Description = _Eg9m("\030v[)srP%\n%Ur\r]);r\r)`v\r)v\rfr[;\fvr)prZ\n[[/)\023P\rZP\024\024/\026")
      myAgentZ:MoveTo(zone36)
      _iwScY = true
      PlaySound(beepCapture)
      _xjmb:Start()
    end)
  end
end
function captureDialog()
  _Urwigo.MessageBox({
    Text = _Eg9m("`\n2)-Kvr|)v2/)\nS2])`S)pv2/)fr\021\n[fr[0)\030\rfvp$)`v%U0)#%U)pv[)gfr[/)\002)S[;)U\npr);r[)gS\021/\r\nf])`v%U);v[f\021r2/)wS)\024\n%Ur[0"),
    Media = _mBlA,
    Callback = function(action)
      if action ~= nil then
        PlaySound(beepCapture)
        _Urwigo.Dialog(false, {
          {
            Text = _Eg9m("\br\r;\n\024\024/])r2)\f\n\r)\n||r2)2P)\r\n\021\021v[vr\r/)frK|\n[/0)?\npr[);vr)\024v\r);P%U)r\r[2/U\n\021/);vr2r[)srP%UvK)v\024K|\n[/vr\r/\026)"),
            Media = _iA3V
          },
          {
            Text = _Eg9m("`S)f|\nSp2/)f\n\r)[v%U/])\fvr);\n2)v2/])\fr[[)`S)\nS2)Urv/r\rr\024)?v\024\024r|)2/r%Ur[;r)-%U\024r\rwr[)prZP\024\0242/\026"),
            Media = _iA3V
          },
          {
            Text = _Eg9m("'\n\024\024r\r)[v%U/)\rS\024])2r|p2/)2%US|;0)#%U)p\rv[fr)`v%U)Jr/w/)v[2)j\026\030\026}\026`\0261?\nSK/CS\n\r/vr\r0"),
            Media = _mBlA
          },
          {
            Text = _Eg9m("#[2)?\nSK/CS\n\r/vr\r\\)`\n[[)|\n22)S[2)\023P\rUr\r);vr)gZ/r[)UP|r[])\023vr||rv%U/)|\n22r[)2vr)\024v%U);\n[[)\fr[vf2/r[2)|rpr[0"),
            Media = _iA3V
          },
          {
            Text = _Eg9m("j\n)fS/])\npr\r)Zrv[r)<\rv%Z20)lvr)ZP\024\024r[)\fv\r)wS);r[)gZ/r[\\"),
            Media = _mBlA
          },
          {
            Text = _Eg9m("`vr)2v[;)prv);r\r)-K\rrr2%U\n[wr]);\n2)v2/)%\n\026)\v\018\018)\024)\023P[);r\r)m1\006\nU[)-/\n/vP[)g|/2/\n;/)-K\n[;\nS)r[/\021r\r[/\026"),
            Media = _iA3V
          },
          {
            Text = _Eg9m("`P\r/)Uv[)Z\n[[)\024\n[)|\nS\021r[)P;r\r)\021\nU\rr[\026)#%U)2%U\rrvp$2)`v\r)\024\n|)\nS\021\026"),
            Media = _iA3V
          }
        }, function(action)
          _dObf:MoveTo(Player)
          afterCaptureChanges()
        end)
      end
    end
  })
end
function afterCaptureChanges()
  _Urwigo.MessageBox({
    Text = _Eg9m("\127sS/]);\n[[)p\r\nS%Ur)v%U);\n2)srP\021r[%r1yrSf)S[;);r[)-/\n;/K|\n[)\npr\r)[v%U/)\024rU\r)S[;)Z\n[[)r2)\frfK\n%Zr[\026\026\026\028"),
    Media = _mBlA,
    Callback = function(action)
      if action ~= nil then
        _XKvkP.Description = _Eg9m("_\n22)`v\r)\023P[)y);vr)gZ/r[)wrvfr[)S[;)p\rv[fr)vU[)\024v/);r[)gZ/r[)v[2)j\030}`)?e\026")
        gfTask.Active = false
        zTask.Active = false
        geofences:MoveTo(nil)
        locationer:MoveTo(nil)
        _3P5:MoveTo(nil)
        loctrainer:MoveTo(nil)
        stadtplan:MoveTo(nil)
        myAgentZ.Name = _Eg9m("gfr[/)y)\127fr\021\n[fr[\028")
        myAgentZ.Description = _Eg9m("`r\r)r[/\021|PUr[r)gfr[/]);r[)`S)fr\021\n[fr[)U\n2/0")
        myAgentZ:MoveTo(Player)
        _hYOy = true
        zone35.Active = true
      end
    end
  })
end
function _SukKK()
  _Urwigo.MessageBox({
    Text = _Eg9m("lv||2/)`S);vr)#[/\rP)\n[2rUr[\\)\127\030\024K\021PU|r[0\028"),
    Media = _bqSn,
    Buttons = {
      _Eg9m("'\n"),
      _Eg9m("jrv[")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          PlaySound(PinkPanther)
          _Urwigo.Dialog(false, {
            {
              Text = _Eg9m("?r\rw|v%U)\fv||ZP\024\024r[)v\024)?\nSK/CS\n\r/vr\r)\023P[)j\026\030\026}\026`\026])-vr)\fr\r;r[)f|rv%U)pr;vr[/0"),
              Media = _AEVX
            },
            {
              Text = _Eg9m("gU])\002])ZP[[/r[)-vr)2v%U);P%U)r[/2%U|vr22r[])S[2)wSfS[2/r[)#U\rr\r)s\t-1sr[\nSvfZrv/)r/\f\n2)wS)Ur|\021r[\\"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("lP)-vr)\024v%U);P%U)2P)[r//)S[;)S[\nS\021;\rv[f|v%U)Tpv//r[T\026\026\026)\0141\127"),
              Media = _mBlA
            },
            {
              Text = _Eg9m("\t\rv\024\n]);\n2)\021\rrS/)\024v%U0)?\npr[)-vr);r[)gS2;\rS%Z);r\r)g|/2/\n;/Z\n\r/r);\nprv\\"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("5\n%Ur[)-vr)lv/wr\\)?\npr[)-vr)Jr\024\n|2)rv[r[)2%U|r%U/)\023P\rpr\rrv/r/r[)srP%\n%Ur\r)fr2rUr[\\"),
              Media = _mBlA
            },
            {
              Text = _Eg9m("j\nJ\n\026\026\026)jrU\024r[)-vr);r[)_P%\n/vP[r\r)\024v/])S\024)ff\021\026)#U\rr)yP[r[)wS)ZP\r\rvfvr\rr[\026"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("lvr)pv//r\\"),
              Media = _mBlA
            },
            {
              Text = _Eg9m("-/\n[;)\n||r2)v\024)srP/\r\n%Zr\r15\n[S\n|]);\n2)U\npr[)-vr);P%U)fr|r2r[\\"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("g%U)J\n])Jr/w/0)m[;);\n2)v2/);\n[[)\fPU|);r\r)<\r\n[2\024v//r\r])\024v/);r\024)v%U)?v|\021r)prZP\024\024r[)Z\n[[])P;r\r\\"),
              Media = _mBlA
            },
            {
              Text = _Eg9m("}v%U/vf0)`\n[[)Z\n[[$2)Jr/w/)J\n)|P2)frUr[\026"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("-vr)2P||/r[)2v%U)\n||r\r;v[f2)wSr\r2/)[P%U)Spr\r|rfr[])Pp)-vr)\023P\rUr\r);vr)-v\024S|\n/vP[);S\r%U2Kvr|r[\026\026\026"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("\026\026\026)P;r\r)2v%U)f|rv%U)\n[);r[)_v\023r1\030v[2\n/w)\f\nfr[)\fP||r[\026"),
              Media = _r3p5
            },
            {
              Text = _Eg9m("\017t]);\n[[)\024\n|)|P20"),
              Media = _mBlA
            }
          }, function(action)
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_r_u)
            end)
          end)
        else
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_r_u)
          end)
        end
      end
    end
  })
end
function _PgV()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(setFreeGF)
  end)
end
function _8CX()
  setBlockedGFChoices()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(removeFreeGF)
  end)
end
function _r3sUG()
  _Urwigo.Dialog(false, {
    {
      Text = _Eg9m("\030v[)srP%\n%Ur)\023P[)"),
      Media = _bqSn
    },
    {
      Text = _Eg9m("Z1wS2r)1)#;rr])tP[wrK/vP[)S[;)\t\rPf\r\n\024\024vr\rS[f"),
      Media = _Aoj
    },
    {
      Text = _Eg9m("\030\n\r|u\v)1)g\r/\fP\rZ])\006r\r\n/S[f)S[;)\006r/\n/r2/2"),
      Media = _TeswR
    },
    {
      Text = _Eg9m("_S2/)\nS\021)\024rU\r\\\005\006}\025\t\rPpvr\r)\024\n|\026\026\026"),
      Media = _r3p5
    },
    {
      Text = _Eg9m("s\022G\022G\vg\005\006}\025`r\r)\023r\r|\n22r[r)>\rvr;UP\021)\005\006}\025`r\r)f\rS2r|vfr)j\0221lUr\rvfP1t\rv\024v"),
      Media = _ri0
    },
    {
      Text = _Eg9m("S[;)\023P\r)\n||r\024\014"),
      Media = _njO
    },
    {
      Text = _Eg9m("s\022G\b\vsu\005\006}\025jvfU<h\015G\015L<\r\nvj\005\006}\025_vr2)rv[\021\n%U);vr)_Pf20"),
      Media = _RCx
    }
  }, function(action)
    if _9bC == false then
      _9bC = true
      _Urwigo.MessageBox({
        Text = _Eg9m("`vr2r2)\017S/\rP)\024v/)\022\n%Ur/vKK2)pr\021v[;r/)2v%U)prv\024)\022P\024K|r/vP[)\022P;r)v[)`rv[r\024)#[\023r[/\n\r)S[;)Z\n[[)Jr;r\rwrv/)\fvr;r\rUP|/)\fr\r;r[0"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end)
end
_Urwigo.InlineRequire(0)
_Urwigo.InlineRequire(1)
return theCartridge
