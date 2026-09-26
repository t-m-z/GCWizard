require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
cartFischistgesund = Wherigo.ZCartridge()
cartFischistgesund.MsgBoxCBFuncs = {}
cartFischistgesund.Id = "7fe653d3-7d95-4663-a048-898bd41025ed"
cartFischistgesund.Name = "Fisch ist gesund"
cartFischistgesund.Description = [[
<BR>
Hier geht es rund um den Fisch]]
cartFischistgesund.Visible = true
cartFischistgesund.Activity = "TourGuide"
cartFischistgesund.StartingLocationDescription = "<BR>\nN 53\194\176 51.799 E 008\194\176 42.308"
cartFischistgesund.StartingLocation = ZonePoint(53.863317, 8.705133, 0)
cartFischistgesund.Version = "1"
cartFischistgesund.Company = ""
cartFischistgesund.Author = "WATTFCR"
cartFischistgesund.BuilderVersion = "2.0.5129.5086"
cartFischistgesund.CreateDate = "8/26/2019 5:55:14 PM"
cartFischistgesund.PublishDate = "1/1/0001 12:00:00 AM"
cartFischistgesund.UpdateDate = "8/26/2019 5:55:14 PM"
cartFischistgesund.LastPlayedDate = "1/1/0001 12:00:00 AM"
cartFischistgesund.TargetDevice = "PocketPC"
cartFischistgesund.TargetDeviceVersion = "0"
cartFischistgesund.StateId = "1"
cartFischistgesund.CountryId = "2"
cartFischistgesund.Complete = false
cartFischistgesund.UseLogging = true
zoneStart = Wherigo.Zone(cartFischistgesund)
zoneStart.Id = "34e27a65-3f47-4fd4-861b-ec4656af5672"
zoneStart.Name = "Start"
zoneStart.Description = "Start"
zoneStart.Visible = true
zoneStart.DistanceRange = Distance(-1, "meters")
zoneStart.ShowObjects = "OnEnter"
zoneStart.ProximityRange = Distance(8, "meters")
zoneStart.AllowSetPositionTo = false
zoneStart.Active = true
zoneStart.Points = {
  ZonePoint(53.8633516666667, 8.70516833333333, 0),
  ZonePoint(53.8633516666667, 8.70509833333333, 0),
  ZonePoint(53.8632816666667, 8.70509833333333, 0),
  ZonePoint(53.8632816666667, 8.70516833333333, 0)
}
zoneStart.OriginalPoint = ZonePoint(53.8633166666667, 8.70513333333333, 0)
zoneStart.DistanceRangeUOM = "Meters"
zoneStart.ProximityRangeUOM = "Meters"
zoneStart.OutOfRangeName = ""
zoneStart.InRangeName = ""
zoneWP1 = Wherigo.Zone(cartFischistgesund)
zoneWP1.Id = "fb0d94ad-0f9b-490e-9393-1fc212a04077"
zoneWP1.Name = "WP 1"
zoneWP1.Description = "WP1"
zoneWP1.Visible = true
zoneWP1.DistanceRange = Distance(-1, "meters")
zoneWP1.ShowObjects = "OnEnter"
zoneWP1.ProximityRange = Distance(8, "meters")
zoneWP1.AllowSetPositionTo = false
zoneWP1.Active = false
zoneWP1.Points = {
  ZonePoint(53.8639016666667, 8.70595166666667, 0),
  ZonePoint(53.8639016666667, 8.70588166666667, 0),
  ZonePoint(53.8638316666667, 8.70588166666667, 0),
  ZonePoint(53.8638316666667, 8.70595166666667, 0)
}
zoneWP1.OriginalPoint = ZonePoint(53.8638666666667, 8.70591666666667, 0)
zoneWP1.DistanceRangeUOM = "Meters"
zoneWP1.ProximityRangeUOM = "Meters"
zoneWP1.OutOfRangeName = ""
zoneWP1.InRangeName = ""
zoneWP2 = Wherigo.Zone(cartFischistgesund)
zoneWP2.Id = "65b5ff88-508e-4f24-a645-2b5eb75bfa17"
zoneWP2.Name = "WP 2"
zoneWP2.Description = "WP 2"
zoneWP2.Visible = true
zoneWP2.DistanceRange = Distance(-1, "meters")
zoneWP2.ShowObjects = "OnEnter"
zoneWP2.ProximityRange = Distance(8, "meters")
zoneWP2.AllowSetPositionTo = false
zoneWP2.Active = false
zoneWP2.Points = {
  ZonePoint(53.8657516666667, 8.70851833333333, 0),
  ZonePoint(53.8657516666667, 8.70844833333333, 0),
  ZonePoint(53.8656816666667, 8.70844833333333, 0),
  ZonePoint(53.8656816666667, 8.70851833333333, 0)
}
zoneWP2.OriginalPoint = ZonePoint(53.8657166666667, 8.70848333333333, 0)
zoneWP2.DistanceRangeUOM = "Meters"
zoneWP2.ProximityRangeUOM = "Meters"
zoneWP2.OutOfRangeName = ""
zoneWP2.InRangeName = ""
zoneWP3 = Wherigo.Zone(cartFischistgesund)
zoneWP3.Id = "a0775162-af24-4740-9347-c665cc8e4075"
zoneWP3.Name = "WP 3"
zoneWP3.Description = "WP 3"
zoneWP3.Visible = true
zoneWP3.DistanceRange = Distance(-1, "meters")
zoneWP3.ShowObjects = "OnEnter"
zoneWP3.ProximityRange = Distance(8, "meters")
zoneWP3.AllowSetPositionTo = false
zoneWP3.Active = false
zoneWP3.Points = {
  ZonePoint(53.862985, 8.707835, 0),
  ZonePoint(53.862985, 8.707765, 0),
  ZonePoint(53.862915, 8.707765, 0),
  ZonePoint(53.862915, 8.707835, 0)
}
zoneWP3.OriginalPoint = ZonePoint(53.86295, 8.7078, 0)
zoneWP3.DistanceRangeUOM = "Meters"
zoneWP3.ProximityRangeUOM = "Meters"
zoneWP3.OutOfRangeName = ""
zoneWP3.InRangeName = ""
zoneWP4 = Wherigo.Zone(cartFischistgesund)
zoneWP4.Id = "4447d07e-f59c-4e56-b121-df5469ee8c65"
zoneWP4.Name = "WP 4"
zoneWP4.Description = "WP 4"
zoneWP4.Visible = true
zoneWP4.DistanceRange = Distance(-1, "meters")
zoneWP4.ShowObjects = "OnEnter"
zoneWP4.ProximityRange = Distance(8, "meters")
zoneWP4.AllowSetPositionTo = false
zoneWP4.Active = false
zoneWP4.Points = {
  ZonePoint(53.858685, 8.71440166666667, 0),
  ZonePoint(53.858685, 8.71433166666667, 0),
  ZonePoint(53.858615, 8.71433166666667, 0),
  ZonePoint(53.858615, 8.71440166666667, 0)
}
zoneWP4.OriginalPoint = ZonePoint(53.85865, 8.71436666666667, 0)
zoneWP4.DistanceRangeUOM = "Meters"
zoneWP4.ProximityRangeUOM = "Meters"
zoneWP4.OutOfRangeName = ""
zoneWP4.InRangeName = ""
zoneWP5 = Wherigo.Zone(cartFischistgesund)
zoneWP5.Id = "83b25857-c747-4530-a955-cd1e84b950e9"
zoneWP5.Name = "WP 5"
zoneWP5.Description = ""
zoneWP5.Visible = true
zoneWP5.DistanceRange = Distance(-1, "meters")
zoneWP5.ShowObjects = "OnEnter"
zoneWP5.ProximityRange = Distance(8, "meters")
zoneWP5.AllowSetPositionTo = false
zoneWP5.Active = false
zoneWP5.Points = {
  ZonePoint(53.860285, 8.71171833333333, 0),
  ZonePoint(53.860285, 8.71164833333333, 0),
  ZonePoint(53.860215, 8.71164833333333, 0),
  ZonePoint(53.860215, 8.71171833333333, 0)
}
zoneWP5.OriginalPoint = ZonePoint(53.86025, 8.71168333333333, 0)
zoneWP5.DistanceRangeUOM = "Meters"
zoneWP5.ProximityRangeUOM = "Meters"
zoneWP5.OutOfRangeName = ""
zoneWP5.InRangeName = ""
zoneWP6 = Wherigo.Zone(cartFischistgesund)
zoneWP6.Id = "1df009db-75c6-4226-8704-f2d839830bd4"
zoneWP6.Name = "WP 6"
zoneWP6.Description = ""
zoneWP6.Visible = true
zoneWP6.DistanceRange = Distance(-1, "meters")
zoneWP6.ShowObjects = "OnEnter"
zoneWP6.ProximityRange = Distance(8, "meters")
zoneWP6.AllowSetPositionTo = false
zoneWP6.Active = false
zoneWP6.Points = {
  ZonePoint(53.8608016666667, 8.710735, 0),
  ZonePoint(53.8608016666667, 8.710665, 0),
  ZonePoint(53.8607316666667, 8.710665, 0),
  ZonePoint(53.8607316666667, 8.710735, 0)
}
zoneWP6.OriginalPoint = ZonePoint(53.8607666666667, 8.7107, 0)
zoneWP6.DistanceRangeUOM = "Meters"
zoneWP6.ProximityRangeUOM = "Meters"
zoneWP6.OutOfRangeName = ""
zoneWP6.InRangeName = ""
zoneWP7 = Wherigo.Zone(cartFischistgesund)
zoneWP7.Id = "e5d0ff85-68d8-4e5c-ad33-d60634bb2190"
zoneWP7.Name = "WP 7"
zoneWP7.Description = "WP 7"
zoneWP7.Visible = true
zoneWP7.DistanceRange = Distance(-1, "meters")
zoneWP7.ShowObjects = "OnEnter"
zoneWP7.ProximityRange = Distance(8, "meters")
zoneWP7.AllowSetPositionTo = false
zoneWP7.Active = false
zoneWP7.Points = {
  ZonePoint(53.8610683333333, 8.71005166666667, 0),
  ZonePoint(53.8610683333333, 8.70998166666667, 0),
  ZonePoint(53.8609983333333, 8.70998166666667, 0),
  ZonePoint(53.8609983333333, 8.71005166666667, 0)
}
zoneWP7.OriginalPoint = ZonePoint(53.8610333333333, 8.71001666666667, 0)
zoneWP7.DistanceRangeUOM = "Meters"
zoneWP7.ProximityRangeUOM = "Meters"
zoneWP7.OutOfRangeName = ""
zoneWP7.InRangeName = ""
zoneWP8 = Wherigo.Zone(cartFischistgesund)
zoneWP8.Id = "39728aff-77ef-4adb-8bd2-e4b3cf34479c"
zoneWP8.Name = "WP 8"
zoneWP8.Description = "WP 8"
zoneWP8.Visible = true
zoneWP8.DistanceRange = Distance(-1, "meters")
zoneWP8.ShowObjects = "OnEnter"
zoneWP8.ProximityRange = Distance(8, "meters")
zoneWP8.AllowSetPositionTo = false
zoneWP8.Active = false
zoneWP8.Points = {
  ZonePoint(53.861785, 8.70885166666667, 0),
  ZonePoint(53.861785, 8.70878166666667, 0),
  ZonePoint(53.861715, 8.70878166666667, 0),
  ZonePoint(53.861715, 8.70885166666667, 0)
}
zoneWP8.OriginalPoint = ZonePoint(53.86175, 8.70881666666667, 0)
zoneWP8.DistanceRangeUOM = "Meters"
zoneWP8.ProximityRangeUOM = "Meters"
zoneWP8.OutOfRangeName = ""
zoneWP8.InRangeName = ""
zoneFinale = Wherigo.Zone(cartFischistgesund)
zoneFinale.Id = "96b018e9-e6f0-45e7-880a-e1c7379b8128"
zoneFinale.Name = "Finale"
zoneFinale.Description = "Finale"
zoneFinale.Visible = true
zoneFinale.DistanceRange = Distance(-1, "meters")
zoneFinale.ShowObjects = "OnEnter"
zoneFinale.ProximityRange = Distance(8, "meters")
zoneFinale.AllowSetPositionTo = false
zoneFinale.Active = false
zoneFinale.Points = {
  ZonePoint(53.8634266666667, 8.70697666666667, 0),
  ZonePoint(53.8634266666667, 8.70695666666667, 0),
  ZonePoint(53.8634066666667, 8.70695666666667, 0),
  ZonePoint(53.8634066666667, 8.70697666666667, 0)
}
zoneFinale.OriginalPoint = ZonePoint(53.8634166666667, 8.70696666666667, 0)
zoneFinale.DistanceRangeUOM = "Meters"
zoneFinale.ProximityRangeUOM = "Meters"
zoneFinale.OutOfRangeName = ""
zoneFinale.InRangeName = ""
zitemUnlockCode = Wherigo.ZItem(cartFischistgesund)
zitemUnlockCode.Id = "4e1e96a3-c1af-479f-92b0-e80ad0a3300d"
zitemUnlockCode.Name = "Unlock Code"
zitemUnlockCode.Description = "Your completion code is: "
zitemUnlockCode.Visible = true
zitemUnlockCode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemUnlockCode.Locked = false
zitemUnlockCode.Opened = false
Answer = ""
cartFischistgesund.ZVariables = {Answer = ""}
buildervar = {}
buildervar.Answer = {}
buildervar.Answer.Id = "00000000-0000-0000-0000-000000000000"
buildervar.Answer.Name = "Answer"
buildervar.Answer.Type = "String"
buildervar.Answer.Data = ""
buildervar.Answer.Description = ""
buildervar.EnteredFinalZone = {}
buildervar.EnteredFinalZone.Id = "00000000-0000-0000-0000-000000000001"
buildervar.EnteredFinalZone.Name = "EnteredFinalZone"
buildervar.EnteredFinalZone.Type = "Flag"
buildervar.EnteredFinalZone.Data = "False"
buildervar.EnteredFinalZone.Description = "Has the player entered the final zone? &nbsp;Used so the final zone can stay active, but the events will not be triggered a second time."
zinputInput0 = Wherigo.ZInput(cartFischistgesund)
zinputInput0.Id = "bb28ff14-e2d0-4e1b-9804-32dc7c632d85"
zinputInput0.Name = "Input0"
zinputInput0.Description = ""
zinputInput0.Visible = true
zinputInput0.Choices = {
  "Dorsch",
  "Kabeljau",
  "Miesmuschel"
}
zinputInput0.InputType = "MultipleChoice"
zinputInput0.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput0.Text = "Welcher Fisch ist bei 55\194\176 zu sehen"
zinputInput1 = Wherigo.ZInput(cartFischistgesund)
zinputInput1.Id = "d1101ced-49ea-4815-9224-4abc490f3446"
zinputInput1.Name = "Input1"
zinputInput1.Description = ""
zinputInput1.Visible = true
zinputInput1.Choices = {
  "25",
  "35",
  "30"
}
zinputInput1.InputType = "MultipleChoice"
zinputInput1.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput1.Text = "Wieviele onnovative Betriebe sind ca in Cuxhaven mit Fsich t\195\164tig"
zinputInput2 = Wherigo.ZInput(cartFischistgesund)
zinputInput2.Id = "50db3b15-67a0-40f9-971b-96a1e26eb146"
zinputInput2.Name = "Input2"
zinputInput2.Description = ""
zinputInput2.Visible = true
zinputInput2.Choices = {
  "Grundsitzer",
  "Baumkurren",
  "Schleppnetz"
}
zinputInput2.InputType = "MultipleChoice"
zinputInput2.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput2.Text = "Wie heisst die vor allem in der Nordsee vebreitete Fangmethode"
zinputInput3 = Wherigo.ZInput(cartFischistgesund)
zinputInput3.Id = "2fc27a6d-22ba-4219-828d-3fdf0da08e2f"
zinputInput3.Name = "Input3"
zinputInput3.Description = ""
zinputInput3.Visible = true
zinputInput3.Choices = {
  "Rotbarsch",
  "Schillerlocke",
  "Dornhai"
}
zinputInput3.InputType = "MultipleChoice"
zinputInput3.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput3.Text = "Welcher Fisch ist bei 90\194\176 abgebildet"
zinputInput4 = Wherigo.ZInput(cartFischistgesund)
zinputInput4.Id = "5251c3da-f179-476c-954c-08ca586a07bb"
zinputInput4.Name = "Input4"
zinputInput4.Description = ""
zinputInput4.Visible = true
zinputInput4.Choices = {
  "7",
  "5",
  "9"
}
zinputInput4.InputType = "MultipleChoice"
zinputInput4.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput4.Text = "Wie oft kommt das Wort oder der Wortteil \"Fisch\" im Text vor"
zinputInput5 = Wherigo.ZInput(cartFischistgesund)
zinputInput5.Id = "1bf2cdef-698f-4698-b709-b54014608496"
zinputInput5.Name = "Input5"
zinputInput5.Description = ""
zinputInput5.Visible = true
zinputInput5.Choices = {
  "Hering",
  "Forelle",
  "Lachs"
}
zinputInput5.InputType = "MultipleChoice"
zinputInput5.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput5.Text = "Welcher Fisch ist bei 185 \194\176 abgebildet"
zinputInput6 = Wherigo.ZInput(cartFischistgesund)
zinputInput6.Id = "3ddd9691-57b5-41e7-beac-06b0ef6f5260"
zinputInput6.Name = "Input6"
zinputInput6.Description = ""
zinputInput6.Visible = true
zinputInput6.Choices = {
  "175",
  "150",
  "140"
}
zinputInput6.InputType = "MultipleChoice"
zinputInput6.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput6.Text = "Bei welcher Gradzahl ist der Kabeljau abgebildet ?"
zinputInput7 = Wherigo.ZInput(cartFischistgesund)
zinputInput7.Id = "d151e227-92c4-4f20-8aca-56931d41f3d2"
zinputInput7.Name = "Input7"
zinputInput7.Description = ""
zinputInput7.Visible = true
zinputInput7.Choices = {
  "Fischverarbeitung",
  "Frischfisch",
  "G\195\188tesiegel"
}
zinputInput7.InputType = "MultipleChoice"
zinputInput7.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput7.Text = "Welcher Begriff wird hier erkl\195\164rt"
zinputInput8 = Wherigo.ZInput(cartFischistgesund)
zinputInput8.Id = "39db2bff-fbb6-41a2-b35f-4a4e124e44dc"
zinputInput8.Name = "Input8"
zinputInput8.Description = ""
zinputInput8.Visible = true
zinputInput8.Choices = {
  "nach Eiern",
  "fischig",
  "nach altem \195\150l"
}
zinputInput8.InputType = "MultipleChoice"
zinputInput8.InputVariableId = "00000000-0000-0000-0000-000000000000"
zinputInput8.Text = "Wie sollte Fisch nie riechen"
function zoneStart:OnProximity()
  zoneStart.Active = false
  Wherigo.GetInput(zinputInput0)
end
function zinputInput0:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "Kabeljau") then
    Wherigo.MessageBox({
      Text = "Super - der schmeckt uebrigens gekocht und gebraten",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB2
    })
  else
    Wherigo.MessageBox({
      Text = "Gleich am Anfang schlapp machen ?",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB1
    })
  end
end
function zoneWP1:OnProximity()
  zoneWP1.Active = false
  Wherigo.GetInput(zinputInput1)
end
function zinputInput1:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "30") then
    Wherigo.MessageBox({
      Text = "Wow, gut gelesen",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB4
    })
  else
    Wherigo.MessageBox({
      Text = "Dann lies nochmal in Ruhe",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB3
    })
  end
end
function zoneWP2:OnProximity()
  zoneWP2.Active = false
  Wherigo.GetInput(zinputInput2)
end
function zinputInput2:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "Baumkurren") then
    Wherigo.MessageBox({
      Text = "Glueckwunsch",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB6
    })
  else
    Wherigo.MessageBox({
      Text = "Du musst wohl nochmal ran",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB5
    })
  end
end
function zoneWP3:OnProximity()
  zoneWP3.Active = false
  Wherigo.GetInput(zinputInput3)
end
function zinputInput3:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "Rotbarsch") then
    Wherigo.MessageBox({
      Text = "Du hast scheinbar den Durchblick",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB9
    })
  else
    Wherigo.MessageBox({
      Text = "Du bist unterzuckert - mach nochmal",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB8
    })
  end
end
function zoneWP4:OnProximity()
  zoneWP4.Active = false
  Wherigo.GetInput(zinputInput4)
end
function zinputInput4:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "7") then
    Wherigo.MessageBox({
      Text = "Mathe also auch gut .)",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB11
    })
  else
    Wherigo.MessageBox({
      Text = "Als Cacher solltest Du besser zaehlen koennen - versuche es nochmal",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB10
    })
  end
end
function zoneWP5:OnProximity()
  zoneWP5.Active = false
  Wherigo.GetInput(zinputInput5)
end
function zinputInput5:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "Lachs") then
    Wherigo.MessageBox({
      Text = "Auch da hast Du richtig geschaut - ich bin begeistert",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB13
    })
  else
    Wherigo.MessageBox({
      Text = "So schwer ist es doch nicht, oder doch ?",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB12
    })
  end
end
function zoneWP6:OnProximity()
  zoneWP6.Active = false
  Wherigo.GetInput(zinputInput6)
end
function zinputInput6:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "150") then
    Wherigo.MessageBox({
      Text = "Ich hatte nichts anderes erwartet",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB15
    })
  else
    Wherigo.MessageBox({
      Text = "Du solltest nochmal nachsehen",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB14
    })
  end
end
function zoneWP7:OnProximity()
  zoneWP7.Active = false
  Wherigo.GetInput(zinputInput7)
end
function zinputInput7:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "G\195\188tesiegel") then
    Wherigo.MessageBox({
      Text = "Super aufgepasst - Du hast es gleich geschafft",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB17
    })
  else
    Wherigo.MessageBox({
      Text = "Das ist jetzt aber schwach so kurz vor dem Ziel",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB16
    })
  end
end
function zoneWP8:OnProximity()
  zoneWP8.Active = false
  Wherigo.GetInput(zinputInput8)
end
function zinputInput8:OnGetInput(input)
  Answer = input
  if Wherigo.NoCaseEquals(Answer, "fischig") then
    Wherigo.MessageBox({
      Text = "Tataaaaa ! Jetzt geht es zum Final bei N 53\194\17651.805 E 008\194\176 42.418",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB19
    })
  else
    Wherigo.MessageBox({
      Text = "Fang am besten von vorne an",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB18
    })
  end
end
function zoneFinale:OnProximity()
  if EnteredFinalZone ~= true then
    EnteredFinalZone = true
    zoneFinale.Active = false
    Wherigo.MessageBox({
      Text = "Du hast es geschafft !<BR>\nGl\195\188ckwunsch und ich hoffe Du hast was gelernt dabei",
      Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB20
    })
    zoneFinale.Active = true
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB1(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput0)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB2(action)
  if action ~= nil then
    zoneWP1.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB3(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput1)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB4(action)
  if action ~= nil then
    zoneWP2.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB5(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput2)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB6(action)
  if action ~= nil then
    local did = gsub_wig(string.lower(Env.DeviceID))
    if did ~= "m2v52@xw" and did ~= "mo3w624-rq" and did ~= "nw5xn737" and did ~= "nw3o4w49nx" and did ~= "5om8vu3" and did ~= "k1z85s6" and did ~= "mo3w624" then
      zoneWP3.Active = true
      cartFischistgesund:RequestSync()
    else
      Wherigo.MessageBox({
        Text = "PECH",
        Callback = cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB7
      })
    end
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB7(action)
  if action ~= nil then
    Wherigo.Command("SaveClose")
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB8(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput3)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB9(action)
  if action ~= nil then
    zoneWP4.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB10(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput4)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB11(action)
  if action ~= nil then
    zoneWP5.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB12(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput5)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB13(action)
  if action ~= nil then
    zoneWP6.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB14(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput6)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB15(action)
  if action ~= nil then
    zoneWP7.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB16(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput7)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB17(action)
  if action ~= nil then
    zoneWP8.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB18(action)
  if action ~= nil then
    Wherigo.GetInput(zinputInput8)
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB19(action)
  if action ~= nil then
    zoneFinale.Active = true
    cartFischistgesund:RequestSync()
  end
end
function cartFischistgesund.MsgBoxCBFuncs.MsgBoxCB20(action)
  if action ~= nil then
    Wherigo.MessageBox({
      Text = "The cartridge is complete. &nbsp;Your completion code is " .. string.sub(Player.CompletionCode, 1, 15) .. ". &nbsp;Make sure to write this down."
    })
    cartFischistgesund.Complete = true
    zitemUnlockCode.Description = zitemUnlockCode.Description .. string.sub(Player.CompletionCode, 1, 15)
    zitemUnlockCode:MoveTo(Player)
  end
end
function gsub_wig(str, obf)
  local result = ""
  if obf == nil then
    obf = true
  end
  local rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~"
  local plen = string.len(rot_palette)
  local magic = {
    ["\001"] = "B",
    ["\002"] = "R",
    ["\003"] = ""
  }
  str = string.gsub(str, "&nbsp;", " ")
  for i = 1, string.len(str) do
    local c = string.sub(str, i, i)
    local p = string.find(rot_palette, c, 1, true)
    if p then
      local jump = (i - 1) % 8 + 9
      if obf then
        p = p + jump
        if plen < p then
          p = p - plen
        end
      else
        p = p - jump
        if p < 1 then
          p = p + plen
        end
      end
      c = string.sub(rot_palette, p, p)
    else
      x = magic[c]
      if x then
      else
      end
    end
    if p then
    else
      p = "null"
    end
    result = result .. c
  end
  return result
end
ucoderes = ""
function ucode_wig(ucodenum)
  if pcall(toucode_wig, ucodenum) then
    return ucoderes
  else
    return "?"
  end
end
function toucode_wig(ucodenum)
  ucoderes = string.char(ucodenum)
end
return cartFischistgesund
