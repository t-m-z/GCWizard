local Wherigo = require("Wherigo")
local Player = Wherigo.Player
local Env = Wherigo.Env
local wb_num = function(value)
  local n = tonumber(value)
  if n then
    return n
  end
  if type(value) ~= "string" then
    return 0
  end
  local s = string.gsub(value, "[,%s']", "")
  return tonumber(string.match(s, "%-?%d+%.?%d*")) or 0
end
local objCartridge = Wherigo.ZCartridge()
objCartridge.Name = "GSBR#08: Sonnberg WHERIGO"
objCartridge.Description = [[
Ein WHERIGO ist ein muss fuer eine Cacher- Gemeinde - hier ist [GCB3YW0] - der erste fuer Gaflenz. Plane 1.5 Stunden ein und achte auf die Begleit-Dosen und Multi- Fragen an der Strecke.
Was dich erwartet:
* Du besuchst 7 Zonen entlang der Sonnberg-Runde (1.5h)
* Du findest zumindes 4 Schaetze und uebernimmst sie in dein Inventar.
* Benutze die Landkarte - sie zeigt die jeweils naechsten Zonen.
* Das letzte item, der Einkaufskorb, hat einen BUTTON zur nochmaligen Final- Anzeige.
Viel Spasz!

Version 2026-09-02 03:00]]
objCartridge.Author = "FraBe14"
objCartridge.Company = "by FranzJosef"
objCartridge.Version = "1.3"
objCartridge.Activity = "Geocache"
objCartridge.TargetDevice = "PocketPC"
objCartridge.Visible = true
objCartridge.Complete = false
objCartridge.ZVariables = {}
objCartridge.BuilderVersion = "CacheSleuth Wherigo Builder"
objCartridge.UseLogging = false
objCartridge.Id = "88589d9a-4e16-4a88-aaf1-c4cea36305b6"
objCartridge.StartingLocation = Wherigo.ZonePoint(47.89406666666667, 14.72355, 500)
objCartridge.StartingLocationDescription = "Startpunkt: Feuerwehrhaus Gaflenz"
local media5 = Wherigo.ZMedia(objCartridge)
media5.Name = "aussicht_gugga"
media5.Description = ""
media5.AltText = "aussicht_gugga"
media5.Resources = {
  {
    Type = "jpg",
    Filename = "aussicht_gugga.jpg",
    Directives = {}
  }
}
local media6 = Wherigo.ZMedia(objCartridge)
media6.Name = "einkaufskorb"
media6.Description = ""
media6.AltText = "einkaufskorb"
media6.Resources = {
  {
    Type = "jpg",
    Filename = "einkaufskorb.jpg",
    Directives = {}
  }
}
local media8 = Wherigo.ZMedia(objCartridge)
media8.Name = "zaungatter"
media8.Description = ""
media8.AltText = "zaungatter"
media8.Resources = {
  {
    Type = "jpg",
    Filename = "zaungatter.jpg",
    Directives = {}
  }
}
local media9 = Wherigo.ZMedia(objCartridge)
media9.Name = "zwerg"
media9.Description = ""
media9.AltText = "zwerg"
media9.Resources = {
  {
    Type = "jpg",
    Filename = "zwerg.jpg",
    Directives = {}
  }
}
local media10 = Wherigo.ZMedia(objCartridge)
media10.Name = "feuerwehrhelm"
media10.Description = ""
media10.AltText = "feuerwehrhelm"
media10.Resources = {
  {
    Type = "jpg",
    Filename = "feuerwehrhelm.jpg",
    Directives = {}
  }
}
local media11 = Wherigo.ZMedia(objCartridge)
media11.Name = "wegweiser"
media11.Description = ""
media11.AltText = "wegweiser"
media11.Resources = {
  {
    Type = "jpg",
    Filename = "wegweiser.jpg",
    Directives = {}
  }
}
local media15 = Wherigo.ZMedia(objCartridge)
media15.Name = "feuerwehrhaus"
media15.Description = ""
media15.AltText = "feuerwehrhaus"
media15.Resources = {
  {
    Type = "jpg",
    Filename = "feuerwehrhaus.jpg",
    Directives = {}
  }
}
local media16 = Wherigo.ZMedia(objCartridge)
media16.Name = "zwergentor"
media16.Description = ""
media16.AltText = "zwergentor"
media16.Resources = {
  {
    Type = "jpg",
    Filename = "zwergentor.jpg",
    Directives = {}
  }
}
local media17 = Wherigo.ZMedia(objCartridge)
media17.Name = "talbodenblick"
media17.Description = ""
media17.AltText = "talbodenblick"
media17.Resources = {
  {
    Type = "jpg",
    Filename = "talbodenblick.jpg",
    Directives = {}
  }
}
local media1 = Wherigo.ZMedia(objCartridge)
media1.Name = "gaflenz_lenz"
media1.Description = ""
media1.AltText = "gaflenz_lenz"
media1.Resources = {
  {
    Type = "jpg",
    Filename = "gaflenz_lenz.jpg",
    Directives = {}
  }
}
local media2 = Wherigo.ZMedia(objCartridge)
media2.Name = "sieger_pokal"
media2.Description = ""
media2.AltText = "sieger_pokal"
media2.Resources = {
  {
    Type = "jpg",
    Filename = "sieger_pokal.jpg",
    Directives = {}
  }
}
local media3 = Wherigo.ZMedia(objCartridge)
media3.Name = "bewertung_falsch"
media3.Description = ""
media3.AltText = "bewertung_falsch"
media3.Resources = {
  {
    Type = "jpg",
    Filename = "bewertung_falsch.jpg",
    Directives = {}
  }
}
local media4 = Wherigo.ZMedia(objCartridge)
media4.Name = "bewertung_richtig"
media4.Description = ""
media4.AltText = "bewertung_richtig"
media4.Resources = {
  {
    Type = "jpg",
    Filename = "bewertung_richtig.jpg",
    Directives = {}
  }
}
local media12 = Wherigo.ZMedia(objCartridge)
media12.Name = "Gaflenz_Westansicht"
media12.Description = ""
media12.AltText = "Gaflenz_Westansicht"
media12.Resources = {
  {
    Type = "jpg",
    Filename = "gaflenz_westansicht.jpg",
    Directives = {}
  }
}
local media13 = Wherigo.ZMedia(objCartridge)
media13.Name = "question"
media13.Description = ""
media13.AltText = "question"
media13.Resources = {
  {
    Type = "png",
    Filename = "question.png",
    Directives = {}
  }
}
local media14 = Wherigo.ZMedia(objCartridge)
media14.Name = "gafenz_wappen"
media14.Description = ""
media14.AltText = "gafenz_wappen"
media14.Resources = {
  {
    Type = "png",
    Filename = "gafenz_wappen.png",
    Directives = {}
  }
}
local media18 = Wherigo.ZMedia(objCartridge)
media18.Name = "eintrittskarte"
media18.Description = ""
media18.AltText = "eintrittskarte"
media18.Resources = {
  {
    Type = "png",
    Filename = "eintrittskarte.png",
    Directives = {}
  }
}
local media19 = Wherigo.ZMedia(objCartridge)
media19.Name = "calculator"
media19.Description = "FraBe14"
media19.AltText = "calculator"
media19.Resources = {
  {
    Type = "jpg",
    Filename = "calculator.jpg",
    Directives = {}
  }
}
objCartridge.Icon = media14
local z01_Feuerwehr = Wherigo.Zone(objCartridge)
z01_Feuerwehr.Name = "01.Feuerwehr"
z01_Feuerwehr.Description = "Geh zum Vorplatz der Feuerwehr. Wenn du hier parken willst lass bitte die Einfahrten frei und nimm den Stellplatz gegenueber."
z01_Feuerwehr.Visible = true
z01_Feuerwehr.Active = true
z01_Feuerwehr.ShowObjects = "OnEnter"
z01_Feuerwehr.DistanceRange = Wherigo.Distance(700, "meters")
z01_Feuerwehr.ProximityRange = Wherigo.Distance(20, "meters")
z01_Feuerwehr.Points = {
  Wherigo.ZonePoint(47.892970815965334, 14.716221387156414, 0),
  Wherigo.ZonePoint(47.892837, 14.71596, 0),
  Wherigo.ZonePoint(47.892779, 14.716053, 0),
  Wherigo.ZonePoint(47.892911464011995, 14.716312578930747, 0)
}
z01_Feuerwehr.OriginalPoint = Wherigo.ZonePoint(47.892841281792855, 14.716089941420758, 0)
z01_Feuerwehr.Media = media15
local z02_Zwergentor = Wherigo.Zone(objCartridge)
z02_Zwergentor.Name = "02.Zwergentor"
z02_Zwergentor.Description = "Tritt ein in das Reich der Zwergen."
z02_Zwergentor.Visible = false
z02_Zwergentor.Active = false
z02_Zwergentor.ShowObjects = "OnEnter"
z02_Zwergentor.DistanceRange = Wherigo.Distance(500, "meters")
z02_Zwergentor.ProximityRange = Wherigo.Distance(100, "meters")
z02_Zwergentor.Points = {
  Wherigo.ZonePoint(47.895244037584, 14.713415794860767, 0),
  Wherigo.ZonePoint(47.89513975794693, 14.713383612517818, 0),
  Wherigo.ZonePoint(47.89511635423128, 14.713268285027581, 0),
  Wherigo.ZonePoint(47.895182926744, 14.713182453506052, 0),
  Wherigo.ZonePoint(47.89527641842489, 14.713246829021529, 0)
}
z02_Zwergentor.OriginalPoint = Wherigo.ZonePoint(47.895195483504395, 14.713313886746063, 0)
z02_Zwergentor.Media = media16
local z03_Zwergenwald = Wherigo.Zone(objCartridge)
z03_Zwergenwald.Name = "03.Zwergenwald"
z03_Zwergenwald.Description = "Finde den Zwerg im Wald!"
z03_Zwergenwald.Visible = false
z03_Zwergenwald.Active = false
z03_Zwergenwald.ShowObjects = "OnEnter"
z03_Zwergenwald.DistanceRange = Wherigo.Distance(300, "meters")
z03_Zwergenwald.ProximityRange = Wherigo.Distance(20, "meters")
z03_Zwergenwald.Points = {
  Wherigo.ZonePoint(47.8951810883737, 14.715642040786816, 0),
  Wherigo.ZonePoint(47.89518468654175, 14.715781509350874, 0),
  Wherigo.ZonePoint(47.895119944404705, 14.715851250463, 0),
  Wherigo.ZonePoint(47.89504260233432, 14.715784203643903, 0),
  Wherigo.ZonePoint(47.8948987304139, 14.71514316304486, 0),
  Wherigo.ZonePoint(47.894848400073734, 14.714545003114113, 0),
  Wherigo.ZonePoint(47.89501204620223, 14.714094440861166, 0),
  Wherigo.ZonePoint(47.89512006349696, 14.71419367156146, 0),
  Wherigo.ZonePoint(47.895044421502725, 14.714448449894293, 0),
  Wherigo.ZonePoint(47.895017444164246, 14.714687175953694, 0),
  Wherigo.ZonePoint(47.89503543228932, 14.71502242528551, 0),
  Wherigo.ZonePoint(47.89509118948269, 14.715293332073752, 0)
}
z03_Zwergenwald.OriginalPoint = Wherigo.ZonePoint(47.89492385540647, 14.714671210895537, 0)
z03_Zwergenwald.Media = media9
local z04_Weggabelung = Wherigo.Zone(objCartridge)
z04_Weggabelung.Name = "04.Weggabelung"
z04_Weggabelung.Description = "nimm den oberen Weg (Forstweg)"
z04_Weggabelung.Visible = false
z04_Weggabelung.Active = false
z04_Weggabelung.ShowObjects = "OnEnter"
z04_Weggabelung.DistanceRange = Wherigo.Distance(300, "meters")
z04_Weggabelung.ProximityRange = Wherigo.Distance(20, "meters")
z04_Weggabelung.Points = {
  Wherigo.ZonePoint(47.89820410487428, 14.71940518161089, 0),
  Wherigo.ZonePoint(47.898162740109534, 14.719617072445288, 0),
  Wherigo.ZonePoint(47.898078234345256, 14.719555378485587, 0),
  Wherigo.ZonePoint(47.89812677848846, 14.71932202472511, 0)
}
z04_Weggabelung.OriginalPoint = Wherigo.ZonePoint(47.89813938312918, 14.719456131498118, 0)
z04_Weggabelung.Media = media11
local z05_Aussicht = Wherigo.Zone(objCartridge)
z05_Aussicht.Name = "05.SchoeneAussicht"
z05_Aussicht.Description = "geniesze die Aussicht auf Gaflenz"
z05_Aussicht.Visible = false
z05_Aussicht.Active = false
z05_Aussicht.ShowObjects = "OnEnter"
z05_Aussicht.DistanceRange = Wherigo.Distance(300, "meters")
z05_Aussicht.ProximityRange = Wherigo.Distance(20, "meters")
z05_Aussicht.Points = {
  Wherigo.ZonePoint(47.89796070730613, 14.721997890814595, 0),
  Wherigo.ZonePoint(47.898023635747286, 14.722354647938838, 0),
  Wherigo.ZonePoint(47.897857307886426, 14.722447187898533, 0),
  Wherigo.ZonePoint(47.89774131539419, 14.722036806170573, 0),
  Wherigo.ZonePoint(47.89784919634345, 14.721858428441507, 0)
}
z05_Aussicht.OriginalPoint = Wherigo.ZonePoint(47.89785, 14.7222, 0)
z05_Aussicht.Media = media17
local z06_Viehgatter = Wherigo.Zone(objCartridge)
z06_Viehgatter.Name = "06.Viehgatter"
z06_Viehgatter.Description = "passiere das Tor zur Weide - mach es wieder zu!"
z06_Viehgatter.Visible = false
z06_Viehgatter.Active = false
z06_Viehgatter.ShowObjects = "OnEnter"
z06_Viehgatter.DistanceRange = Wherigo.Distance(300, "meters")
z06_Viehgatter.ProximityRange = Wherigo.Distance(20, "meters")
z06_Viehgatter.Points = {
  Wherigo.ZonePoint(47.89998437907526, 14.727564458243906, 0),
  Wherigo.ZonePoint(47.90009946533862, 14.727915813463103, 0),
  Wherigo.ZonePoint(47.90000594902749, 14.728178669946562, 0),
  Wherigo.ZonePoint(47.89984231412085, 14.728170637481268, 0),
  Wherigo.ZonePoint(47.89970922246616, 14.7277897554707, 0),
  Wherigo.ZonePoint(47.899788398419076, 14.72752153456921, 0)
}
z06_Viehgatter.OriginalPoint = Wherigo.ZonePoint(47.899883333333335, 14.727833333333333, 0)
z06_Viehgatter.Media = media8
local z07_Nahversorgung = Wherigo.Zone(objCartridge)
z07_Nahversorgung.Name = "07.Nahversorgung"
z07_Nahversorgung.Description = "erreiche die Nahversorger- Zone. Vielleicht haelt sie einen Cache bereit?"
z07_Nahversorgung.Visible = false
z07_Nahversorgung.Active = false
z07_Nahversorgung.ShowObjects = "OnEnter"
z07_Nahversorgung.DistanceRange = Wherigo.Distance(300, "meters")
z07_Nahversorgung.ProximityRange = Wherigo.Distance(20, "meters")
z07_Nahversorgung.Points = {
  Wherigo.ZonePoint(47.89658738839696, 14.728213492013234, 0),
  Wherigo.ZonePoint(47.89664682359689, 14.728594431503906, 0),
  Wherigo.ZonePoint(47.896484908979566, 14.728707067621617, 0),
  Wherigo.ZonePoint(47.89643096605242, 14.728436135354558, 0),
  Wherigo.ZonePoint(47.896360779217176, 14.72837715424668, 0),
  Wherigo.ZonePoint(47.896269114453716, 14.728403985500337, 0),
  Wherigo.ZonePoint(47.89623135275459, 14.728114331918059, 0),
  Wherigo.ZonePoint(47.89645792878078, 14.728036538693157, 0)
}
z07_Nahversorgung.OriginalPoint = Wherigo.ZonePoint(47.89641666666667, 14.728283333333334, 0)
z07_Nahversorgung.Media = media1
local itmFeuerwehrhelm = Wherigo.ZItem(objCartridge)
itmFeuerwehrhelm.Name = "Feuerwehrhelm"
itmFeuerwehrhelm.Description = "Ein Hut aus Metall der dich schuezt und bewahrt."
itmFeuerwehrhelm.Visible = false
itmFeuerwehrhelm.Locked = false
itmFeuerwehrhelm.Opened = false
itmFeuerwehrhelm.Media = media10
itmFeuerwehrhelm:MoveTo(z01_Feuerwehr)
local itmEintrittskarte = Wherigo.ZItem(objCartridge)
itmEintrittskarte.Name = "Eintrittskarte"
itmEintrittskarte.Description = "Die Karte berechtigt zum Eintritt ins Zwergenreich."
itmEintrittskarte.Visible = false
itmEintrittskarte.Locked = false
itmEintrittskarte.Opened = false
itmEintrittskarte.Media = media18
itmEintrittskarte:MoveTo(z02_Zwergentor)
local itmZwerg = Wherigo.ZItem(objCartridge)
itmZwerg.Name = "Zwerg"
itmZwerg.Description = "Geheimnisvoll und faszinierend: Der Zwerg im Wald."
itmZwerg.Visible = false
itmZwerg.Locked = false
itmZwerg.Opened = false
itmZwerg.Media = media9
itmZwerg:MoveTo(z03_Zwergenwald)
local itmWegweiser = Wherigo.ZItem(objCartridge)
itmWegweiser.Name = "Wegweiser"
itmWegweiser.Description = "Du musst den oberen Weg nehmen (Forststrasze)!"
itmWegweiser.Visible = false
itmWegweiser.Locked = false
itmWegweiser.Opened = false
itmWegweiser.Media = media11
itmWegweiser:MoveTo(z04_Weggabelung)
local itmGugga = Wherigo.ZItem(objCartridge)
itmGugga.Name = "Gugga"
itmGugga.Description = "Mit oder ohne Gugga - die Aussicht ist fantastisch."
itmGugga.Visible = false
itmGugga.Locked = false
itmGugga.Opened = false
itmGugga.Media = media5
itmGugga:MoveTo(z05_Aussicht)
local itmViehgatterPassierschein = Wherigo.ZItem(objCartridge)
itmViehgatterPassierschein.Name = "Viehgatter Passierschein"
itmViehgatterPassierschein.Description = "Passiere das Viehgatter - bitte wieder schlieszen!"
itmViehgatterPassierschein.Visible = false
itmViehgatterPassierschein.Locked = false
itmViehgatterPassierschein.Opened = false
itmViehgatterPassierschein.Media = media8
itmViehgatterPassierschein:MoveTo(z06_Viehgatter)
local itmEinkaufskorbUndRechnung = Wherigo.ZItem(objCartridge)
itmEinkaufskorbUndRechnung.Name = "Einkaufskorb &amp; Rechnung"
itmEinkaufskorbUndRechnung.Description = "Hoamatgfue' und LENZ bieten an vielen Wochenstunden Nahversorgung, teils mit Selbstbedienung."
itmEinkaufskorbUndRechnung.Visible = false
itmEinkaufskorbUndRechnung.Locked = false
itmEinkaufskorbUndRechnung.Opened = false
itmEinkaufskorbUndRechnung.Media = media6
itmEinkaufskorbUndRechnung:MoveTo(z07_Nahversorgung)
local tsk01_Feuerwehr_collect = Wherigo.ZTask(objCartridge)
tsk01_Feuerwehr_collect.Name = "a1-Feuerwehr-sammeln"
tsk01_Feuerwehr_collect.Description = "verarbeite Sammelgegenstand"
tsk01_Feuerwehr_collect.Visible = true
tsk01_Feuerwehr_collect.Active = false
tsk01_Feuerwehr_collect.Complete = false
tsk01_Feuerwehr_collect.CorrectState = "None"
local tsk02_ZwergenEintritt_collect = Wherigo.ZTask(objCartridge)
tsk02_ZwergenEintritt_collect.Name = "a2-ZwergenEintritt_sammeln"
tsk02_ZwergenEintritt_collect.Description = "verarbeite Sammelgegenstand"
tsk02_ZwergenEintritt_collect.Visible = false
tsk02_ZwergenEintritt_collect.Active = false
tsk02_ZwergenEintritt_collect.Complete = false
tsk02_ZwergenEintritt_collect.CorrectState = "None"
local tsk03_ZwergenFang_collect = Wherigo.ZTask(objCartridge)
tsk03_ZwergenFang_collect.Name = "a3-ZwergenFang_sammeln"
tsk03_ZwergenFang_collect.Description = "verarbeite Sammelgegenstand"
tsk03_ZwergenFang_collect.Visible = false
tsk03_ZwergenFang_collect.Active = false
tsk03_ZwergenFang_collect.Complete = false
tsk03_ZwergenFang_collect.CorrectState = "None"
local tsk04_WegEntscheidung_collect = Wherigo.ZTask(objCartridge)
tsk04_WegEntscheidung_collect.Name = "a4-WegEntscheidung-sammeln"
tsk04_WegEntscheidung_collect.Description = "verarbeite Sammelgegenstand"
tsk04_WegEntscheidung_collect.Visible = false
tsk04_WegEntscheidung_collect.Active = false
tsk04_WegEntscheidung_collect.Complete = false
tsk04_WegEntscheidung_collect.CorrectState = "None"
local tsk05_AussichtsGenuss = Wherigo.ZTask(objCartridge)
tsk05_AussichtsGenuss.Name = "a5-AussichtsGenuss-sammeln"
tsk05_AussichtsGenuss.Description = "verarbeite Sammelgegenstand"
tsk05_AussichtsGenuss.Visible = false
tsk05_AussichtsGenuss.Active = false
tsk05_AussichtsGenuss.Complete = false
tsk05_AussichtsGenuss.CorrectState = "None"
local tsk06_ViehgatterPassage_collect = Wherigo.ZTask(objCartridge)
tsk06_ViehgatterPassage_collect.Name = "a6-ViehgatterPassage-sammeln"
tsk06_ViehgatterPassage_collect.Description = "verarbeite Sammelgegenstand"
tsk06_ViehgatterPassage_collect.Visible = false
tsk06_ViehgatterPassage_collect.Active = false
tsk06_ViehgatterPassage_collect.Complete = false
tsk06_ViehgatterPassage_collect.CorrectState = "None"
local tsk07_Nahversorgung_collect = Wherigo.ZTask(objCartridge)
tsk07_Nahversorgung_collect.Name = "a7-Nahversorgung-sammeln"
tsk07_Nahversorgung_collect.Description = ""
tsk07_Nahversorgung_collect.Visible = false
tsk07_Nahversorgung_collect.Active = false
tsk07_Nahversorgung_collect.Complete = false
tsk07_Nahversorgung_collect.CorrectState = "None"
local tsk08_ZeigeBeleg = Wherigo.ZTask(objCartridge)
tsk08_ZeigeBeleg.Name = "a8-ZeigeBeleg"
tsk08_ZeigeBeleg.Description = "Bewerte die Fundstuecke und schau auf das Ergebnis."
tsk08_ZeigeBeleg.Visible = false
tsk08_ZeigeBeleg.Active = false
tsk08_ZeigeBeleg.Complete = false
tsk08_ZeigeBeleg.CorrectState = "None"
tsk08_ZeigeBeleg.Media = media13
local tsk21_Feuerwehr_EIN = Wherigo.ZTask(objCartridge)
tsk21_Feuerwehr_EIN.Name = "x1-FeuerwehrEIN"
tsk21_Feuerwehr_EIN.Description = "aktiviere Zone"
tsk21_Feuerwehr_EIN.Visible = false
tsk21_Feuerwehr_EIN.Active = false
tsk21_Feuerwehr_EIN.Complete = false
tsk21_Feuerwehr_EIN.CorrectState = "None"
local tsk22_Zwergentor_EIN = Wherigo.ZTask(objCartridge)
tsk22_Zwergentor_EIN.Name = "x2-ZwergentorEIN"
tsk22_Zwergentor_EIN.Description = "aktiviere Zone"
tsk22_Zwergentor_EIN.Visible = false
tsk22_Zwergentor_EIN.Active = false
tsk22_Zwergentor_EIN.Complete = false
tsk22_Zwergentor_EIN.CorrectState = "None"
local tsk23_Zwergenfang_EIN = Wherigo.ZTask(objCartridge)
tsk23_Zwergenfang_EIN.Name = "x3-ZwergenfangEIN"
tsk23_Zwergenfang_EIN.Description = "aktiviere Zone"
tsk23_Zwergenfang_EIN.Visible = false
tsk23_Zwergenfang_EIN.Active = false
tsk23_Zwergenfang_EIN.Complete = false
tsk23_Zwergenfang_EIN.CorrectState = "None"
local tsk04_Weggabel_EIN = Wherigo.ZTask(objCartridge)
tsk04_Weggabel_EIN.Name = "x4-WeggabelEIN"
tsk04_Weggabel_EIN.Description = "aktiviere Zone"
tsk04_Weggabel_EIN.Visible = false
tsk04_Weggabel_EIN.Active = false
tsk04_Weggabel_EIN.Complete = false
tsk04_Weggabel_EIN.CorrectState = "None"
local tsk05_Aussicht_EIN = Wherigo.ZTask(objCartridge)
tsk05_Aussicht_EIN.Name = "x5-AussichtEIN"
tsk05_Aussicht_EIN.Description = "aktiviere Zone"
tsk05_Aussicht_EIN.Visible = false
tsk05_Aussicht_EIN.Active = false
tsk05_Aussicht_EIN.Complete = false
tsk05_Aussicht_EIN.CorrectState = "None"
local tsk06_Viegatter_EIN = Wherigo.ZTask(objCartridge)
tsk06_Viegatter_EIN.Name = "x6-ViegatterEIN"
tsk06_Viegatter_EIN.Description = "aktiviere Zone"
tsk06_Viegatter_EIN.Visible = false
tsk06_Viegatter_EIN.Active = false
tsk06_Viegatter_EIN.Complete = false
tsk06_Viegatter_EIN.CorrectState = "None"
local tsk07_Nahversorger_EIN = Wherigo.ZTask(objCartridge)
tsk07_Nahversorger_EIN.Name = "x7-NahversorgerEIN"
tsk07_Nahversorger_EIN.Description = "aktiviere Zone"
tsk07_Nahversorger_EIN.Visible = false
tsk07_Nahversorger_EIN.Active = false
tsk07_Nahversorger_EIN.Complete = false
tsk07_Nahversorger_EIN.CorrectState = "None"
local tmr5Sekunden = Wherigo.ZTimer(objCartridge)
tmr5Sekunden.Name = "Timer 5s"
tmr5Sekunden.Visible = true
tmr5Sekunden.Type = "Countdown"
tmr5Sekunden.Duration = 5
itmFeuerwehrhelm.Commands.cmdHelmAufsetzen = Wherigo.ZCommand({
  Text = "Helm auf/absetzen?",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmEintrittskarte.Commands.cmdZwergenreichBetreten = Wherigo.ZCommand({
  Text = "Eintritt beanspruchen.",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmZwerg.Commands.cmdZwergFangen = Wherigo.ZCommand({
  Text = "Zwerg fangen/freilassen",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmWegweiser.Commands.cmdWegAuswaehlen = Wherigo.ZCommand({
  Text = "Weghinweis folgen/ignorieren",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmGugga.Commands.cmdGaflenzErblicken = Wherigo.ZCommand({
  Text = "Gaflenz erblicken/ignorieren",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmViehgatterPassierschein.Commands.cmdViegatterDurchschreiten = Wherigo.ZCommand({
  Text = "Viehgatter durchschreiten/uebersteigen",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmEinkaufskorbUndRechnung.Commands.cmdRegionalEinkaufen = Wherigo.ZCommand({
  Text = "regional/irgendwo Einkaufen",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
itmEinkaufskorbUndRechnung.Commands.cmdFinalBerechnenUndZeigen = Wherigo.ZCommand({
  Text = "Final berechnen &amp; zeigen",
  Enabled = true,
  CmdWith = false,
  WorksWithAll = false,
  EmptyTargetListText = ""
})
objCartridge.ZVariables.varCountItems = 0
objCartridge.ZVariables.varConst_TRUE = true
objCartridge.ZVariables.varConst_FALSE = false
objCartridge.ZVariables.varMinimumItems = 4
objCartridge.ZVariables.var1New1 = ""
local wb_cb_1, wb_cb_2, wb_cb_3, wb_cb_4, wb_cb_5, wb_cb_6, wb_cb_7, wb_cb_8, wb_cb_9, wb_cb_10, wb_cb_11, wb_cb_12, wb_cb_13, wb_cb_14, wb_cb_15, wb_cb_16, wb_cb_17, wb_cb_18
function wb_cb_1(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = "sammle und klicke auf 'NahversorgungFertig' um die Auswertung zu sehen."
    })
  elseif action == "Button2" then
    z01_Feuerwehr.Active = true
    tmr5Sekunden:Start()
    Wherigo.MessageBox({
      Text = "Besuche die Zonen der Reihe nach um noch fehlende tems zu sammeln."
    })
  end
end
function wb_cb_2(action)
  if action == "Button1" then
    tsk08_ZeigeBeleg.Active = true
  end
end
function wb_cb_3(action)
  if action == "Button1" then
    if itmFeuerwehrhelm.Container ~= Player then
      itmFeuerwehrhelm:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Der Helm gehoert schon dir.",
        Media = media3
      })
    end
  end
end
function wb_cb_4(action)
  if action == "Button1" then
    if itmEintrittskarte.Container ~= Player then
      itmEintrittskarte:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Die Eintrittskarte gehoert schon dir!",
        Media = media3
      })
    end
  end
end
function wb_cb_5(action)
  if action == "Button1" then
    if itmZwerg.Container ~= Player then
      itmZwerg:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Du bist bereits herr ueber den Zwerg!",
        Media = media3
      })
    end
  end
end
function wb_cb_6(action)
  if action == "Button1" then
    if itmWegweiser.Container ~= Player then
      itmWegweiser:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Du kennst bereits den Weg.",
        Media = media3
      })
    end
  end
end
function wb_cb_7(action)
  if action == "Button1" then
    if itmGugga.Container ~= Player then
      itmGugga:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Die Aussicht ist dir bereits sicher, fuer immer und ewig!",
        Media = media3
      })
    end
  end
end
function wb_cb_8(action)
  if action == "Button1" then
    if itmViehgatterPassierschein.Container ~= Player then
      itmViehgatterPassierschein:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Du hast den Tanzschein fuer die Wiese bereits in der Tasche!",
        Media = media3
      })
    end
  end
end
function wb_cb_9(action)
  if action == "Button1" then
    if itmEinkaufskorbUndRechnung.Container ~= Player then
      itmEinkaufskorbUndRechnung:MoveTo(Player)
    else
      Wherigo.MessageBox({
        Text = "Du kennst den Einkaufskorb bereits.",
        Media = media3
      })
    end
  end
end
function wb_cb_10(action)
  if action == "Button1" then
    tsk08_ZeigeBeleg.Active = false
    tmr5Sekunden:Start()
    tsk08_ZeigeBeleg.Active = true
  end
end
function wb_cb_11(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmFeuerwehrhelm.Visible = true
    itmFeuerwehrhelm.Commands.cmdHelmAufsetzen.Enabled = true
    tsk01_Feuerwehr_collect.Complete = true
  end
end
function wb_cb_12(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmEintrittskarte.Visible = true
    itmEintrittskarte.Commands.cmdZwergenreichBetreten.Enabled = true
    tsk02_ZwergenEintritt_collect.Complete = true
  end
end
function wb_cb_13(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmZwerg.Visible = true
    itmZwerg.Commands.cmdZwergFangen.Enabled = true
    tsk03_ZwergenFang_collect.Complete = true
  end
end
function wb_cb_14(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmWegweiser.Visible = true
    itmWegweiser.Commands.cmdWegAuswaehlen.Enabled = true
    tsk04_WegEntscheidung_collect.Complete = true
  end
end
function wb_cb_15(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmGugga.Visible = true
    itmGugga.Commands.cmdGaflenzErblicken.Enabled = true
    tsk05_AussichtsGenuss.Complete = true
  end
end
function wb_cb_16(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmViehgatterPassierschein.Visible = true
    itmViehgatterPassierschein.Commands.cmdViegatterDurchschreiten.Enabled = true
    tsk06_ViehgatterPassage_collect.Complete = true
  end
end
function wb_cb_17(action)
  if action == "Button1" then
    tmr5Sekunden:Start()
    itmEinkaufskorbUndRechnung.Visible = true
    itmEinkaufskorbUndRechnung.Commands.cmdRegionalEinkaufen.Enabled = true
    itmEinkaufskorbUndRechnung.Commands.cmdFinalBerechnenUndZeigen.Enabled = true
    tsk07_Nahversorgung_collect.Complete = true
  end
end
function wb_cb_18(action)
  if action == "Button1" then
    objCartridge.ZVariables.varCountItems = 0
    if itmFeuerwehrhelm.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if itmEintrittskarte.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if itmZwerg.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if itmWegweiser.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if itmGugga.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if itmViehgatterPassierschein.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if itmEinkaufskorbUndRechnung.Container == Player then
      objCartridge.ZVariables.varCountItems = wb_num(objCartridge.ZVariables.varCountItems) + 1
    end
    if wb_num(objCartridge.ZVariables.varCountItems) >= wb_num(objCartridge.ZVariables.varMinimumItems) then
      Wherigo.MessageBox({
        Text = [[
Gratuliere. Suche bei
N47 53.770 E014 43.673

Du findest diesen Eintrag auch unter "Aufgaben" - "zeige Beleg"]],
        Media = media2
      })
    else
      Wherigo.MessageBox({
        Text = "Sorry, dir fehlen noch ein paar items.",
        Media = media3
      })
    end
    tsk08_ZeigeBeleg.Complete = true
  end
end
function objCartridge:OnStart()
  Wherigo.MessageBox({
    Text = "Der Kreislauf ruft nach Bewegung. Auf zum Gaflenzer Wherigo!",
    Media = media12
  })
  tmr5Sekunden:Start()
  z01_Feuerwehr.Visible = true
  z01_Feuerwehr.Active = true
end
function objCartridge:OnRestore()
  Wherigo.MessageBox({
    Text = "Willkommen zurueck beim Gaflenzer WHERIGO.",
    Buttons = {
      "Ich habe bereits items gesammelt.",
      "ich besitze noch keine items."
    },
    Callback = wb_cb_1
  })
end
function z01_Feuerwehr:OnEnter()
  tsk01_Feuerwehr_collect.Visible = true
  tsk01_Feuerwehr_collect.Active = true
end
function z01_Feuerwehr:OnExit()
  if itmFeuerwehrhelm.Container ~= Player then
    itmFeuerwehrhelm:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk01_Feuerwehr_collect.Complete = true
    z01_Feuerwehr.Active = false
  end
  tsk01_Feuerwehr_collect.Complete = true
  z01_Feuerwehr.Active = false
end
function z01_Feuerwehr:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk21_Feuerwehr_EIN.Active = true
  tsk22_Zwergentor_EIN.Active = true
end
function z01_Feuerwehr:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z01_Feuerwehr:OnClick()
  if itmFeuerwehrhelm.Container == Player then
    Wherigo.MessageBox({
      Text = "Du bist bereits im Besitz des Feuerwehrhelms, es gibt hier sonst nichts zu tun.",
      Media = media10
    })
  elseif tsk01_Feuerwehr_collect.Active ~= true then
    tsk01_Feuerwehr_collect.Active = true
  end
end
function z02_Zwergentor:OnEnter()
  tsk02_ZwergenEintritt_collect.Visible = true
  tsk02_ZwergenEintritt_collect.Active = true
end
function z02_Zwergentor:OnExit()
  if itmEintrittskarte.Container ~= Player then
    itmEintrittskarte:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk02_ZwergenEintritt_collect.Complete = true
    z02_Zwergentor.Active = false
  end
end
function z02_Zwergentor:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk22_Zwergentor_EIN.Active = true
  tsk23_Zwergenfang_EIN.Active = true
end
function z02_Zwergentor:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z02_Zwergentor:OnClick()
  if itmEintrittskarte.Container == Player then
    Wherigo.MessageBox({
      Text = "Du bist bereits im Besitz der Eintrittskarte, es gibt hier sonst nichts zu tun.",
      Media = media18
    })
  end
end
function z03_Zwergenwald:OnEnter()
  tsk03_ZwergenFang_collect.Visible = true
  tsk03_ZwergenFang_collect.Active = true
end
function z03_Zwergenwald:OnExit()
  if itmZwerg.Container ~= Player then
    itmZwerg:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk03_ZwergenFang_collect.Complete = true
    z03_Zwergenwald.Active = false
  end
end
function z03_Zwergenwald:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk23_Zwergenfang_EIN.Active = true
  tsk04_Weggabel_EIN.Active = true
end
function z03_Zwergenwald:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z03_Zwergenwald:OnClick()
  if itmZwerg.Container == Player then
    Wherigo.MessageBox({
      Text = "Du bist bereits Meister \195\188ber den Zwerg, es gibt hier sonst nichts zu tun.",
      Media = media9
    })
  end
end
function z04_Weggabelung:OnEnter()
  tsk04_WegEntscheidung_collect.Visible = true
  tsk04_WegEntscheidung_collect.Active = true
end
function z04_Weggabelung:OnExit()
  if itmWegweiser.Container ~= Player then
    itmWegweiser:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk04_WegEntscheidung_collect.Complete = true
    z04_Weggabelung.Active = false
  end
end
function z04_Weggabelung:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk04_Weggabel_EIN.Active = true
  tsk05_Aussicht_EIN.Active = true
end
function z04_Weggabelung:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z04_Weggabelung:OnClick()
  if itmWegweiser.Container == Player then
    Wherigo.MessageBox({
      Text = "Du solltest bereits auf dem richtign Weg sein, es gibt hier sonst nichts zu tun.",
      Media = media11
    })
  end
end
function z05_Aussicht:OnEnter()
  tsk05_AussichtsGenuss.Visible = true
  tsk05_AussichtsGenuss.Active = true
end
function z05_Aussicht:OnExit()
  if itmGugga.Container ~= Player then
    itmGugga:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk05_AussichtsGenuss.Complete = true
    z05_Aussicht.Active = false
  end
end
function z05_Aussicht:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk05_Aussicht_EIN.Active = true
  tsk06_Viegatter_EIN.Active = true
end
function z05_Aussicht:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z05_Aussicht:OnClick()
  if itmGugga.Container == Player then
    Wherigo.MessageBox({
      Text = "Du warst bereits bei der Schoenen Aussicht und Herr ueber den Gugga, es gibt hier sonst nichts zu tun."
    })
  end
end
function z06_Viehgatter:OnEnter()
  tsk06_ViehgatterPassage_collect.Visible = true
  tsk06_ViehgatterPassage_collect.Active = true
end
function z06_Viehgatter:OnExit()
  if itmViehgatterPassierschein.Container ~= Player then
    itmViehgatterPassierschein:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk06_ViehgatterPassage_collect.Complete = true
    z06_Viehgatter.Active = false
  end
end
function z06_Viehgatter:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk06_Viegatter_EIN.Active = true
  tsk07_Nahversorger_EIN.Active = true
end
function z06_Viehgatter:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z06_Viehgatter:OnClick()
  if itmViehgatterPassierschein.Container == Player then
    Wherigo.MessageBox({
      Text = "Du bist bereits im Besitz der Viehgatter-Passierdokumente, es gibt hier sonst nichts zu tun."
    })
  end
end
function z07_Nahversorgung:OnEnter()
  tsk07_Nahversorgung_collect.Visible = true
  tsk07_Nahversorgung_collect.Active = true
end
function z07_Nahversorgung:OnExit()
  if itmEinkaufskorbUndRechnung.Container ~= Player then
    itmEinkaufskorbUndRechnung:MoveTo(Player)
    Wherigo.Command("Vibrate")
    tsk07_Nahversorgung_collect.Complete = true
    tsk08_ZeigeBeleg.Visible = true
    tsk08_ZeigeBeleg.Active = true
  end
end
function z07_Nahversorgung:OnProximity()
  Wherigo.ShowStatusText("du bist nah dran ~ heisz!")
  tsk07_Nahversorger_EIN.Active = true
end
function z07_Nahversorgung:OnDistant()
  Wherigo.ShowStatusText("komm naeher!")
end
function z07_Nahversorgung:OnClick()
  if itmEinkaufskorbUndRechnung.Container == Player then
    Wherigo.MessageBox({
      Text = "Du warst bereits regional Einkaufen. Willst du noch die Final- Pruefung anstoszen?",
      Media = media19,
      Buttons = {"ja", "nein"},
      Callback = wb_cb_2
    })
  end
end
function itmFeuerwehrhelm:OncmdHelmAufsetzen(target)
  Wherigo.MessageBox({
    Text = "Besitzverhaeltnisse aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_3
  })
end
function itmEintrittskarte:OncmdZwergenreichBetreten(target)
  Wherigo.MessageBox({
    Text = "Eintritt- Status aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_4
  })
end
function itmZwerg:OncmdZwergFangen(target)
  Wherigo.MessageBox({
    Text = "Zwerg- Gefangenschaft aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_5
  })
end
function itmWegweiser:OncmdWegAuswaehlen(target)
  Wherigo.MessageBox({
    Text = "Wegentscheidung aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_6
  })
end
function itmGugga:OncmdGaflenzErblicken(target)
  Wherigo.MessageBox({
    Text = "Aussichts- Bewertung aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_7
  })
end
function itmViehgatterPassierschein:OncmdViegatterDurchschreiten(target)
  Wherigo.MessageBox({
    Text = "Passierzustand aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_8
  })
end
function itmEinkaufskorbUndRechnung:OncmdRegionalEinkaufen(target)
  Wherigo.MessageBox({
    Text = "Einkaufsverhalten aendern?",
    Media = media13,
    Buttons = {"ja", "nein"},
    Callback = wb_cb_9
  })
end
function itmEinkaufskorbUndRechnung:OncmdFinalBerechnenUndZeigen(target)
  Wherigo.MessageBox({
    Text = "Neubewertung Fundstuecke",
    Buttons = {
      "ja, neu bewerten",
      "nein, nix tun"
    },
    Callback = wb_cb_10
  })
end
function tsk01_Feuerwehr_collect:OnSetActive()
  Wherigo.MessageBox({
    Text = "Zone FEUERWEHR erreicht.",
    Media = media15,
    Buttons = {
      "Nimm den Helm an dich."
    },
    Callback = wb_cb_11
  })
end
function tsk02_ZwergenEintritt_collect:OnSetActive()
  Wherigo.MessageBox({
    Text = "Zone ZWERGENTOR erreicht.",
    Media = media16,
    Buttons = {
      "Verwende die Eintrittskarte."
    },
    Callback = wb_cb_12
  })
end
function tsk03_ZwergenFang_collect:OnSetActive()
  Wherigo.MessageBox({
    Text = "Zone ZWERGENWALD erreicht.",
    Media = media9,
    Buttons = {
      "Fang den Zwerg!"
    },
    Callback = wb_cb_13
  })
end
function tsk04_WegEntscheidung_collect:OnSetActive()
  Wherigo.MessageBox({
    Text = "Zone WEGGABEL - nimm den oberen (Forst)Weg!",
    Media = media11,
    Buttons = {
      "nimm den oberen Weg!"
    },
    Callback = wb_cb_14
  })
end
function tsk05_AussichtsGenuss:OnSetActive()
  Wherigo.MessageBox({
    Text = "Geniesze die Aussicht!",
    Media = media17,
    Buttons = {
      "Geniesze die Aussicht!"
    },
    Callback = wb_cb_15
  })
end
function tsk06_ViehgatterPassage_collect:OnSetActive()
  Wherigo.MessageBox({
    Text = "Geh durchs Gatter und schliesze es!",
    Media = media8,
    Buttons = {"weiter"},
    Callback = wb_cb_16
  })
end
function tsk07_Nahversorgung_collect:OnSetActive()
  Wherigo.MessageBox({
    Text = "Ueberdenke dein Einkaufsverhalten und versuche ...",
    Media = media1,
    Buttons = {
      "regional einzukaufen"
    },
    Callback = wb_cb_17
  })
end
function tsk08_ZeigeBeleg:OnSetActive()
  Wherigo.MessageBox({
    Text = "Berechnung erreicht ...",
    Media = media13,
    Callback = wb_cb_18
  })
end
function tsk08_ZeigeBeleg:OnClick()
  Wherigo.MessageBox({
    Text = [[
Gratuliere. Suche bei
N47 53.770 E014 43.673]],
    Media = media2
  })
end
function tsk21_Feuerwehr_EIN:OnSetActive()
  if z01_Feuerwehr.Active ~= true and itmFeuerwehrhelm.Container ~= Player then
    z01_Feuerwehr.Visible = true
    itmFeuerwehrhelm.Visible = true
    z01_Feuerwehr.Active = true
    tsk01_Feuerwehr_collect.Visible = true
  end
  tsk21_Feuerwehr_EIN.Complete = true
end
function tsk22_Zwergentor_EIN:OnSetActive()
  if z02_Zwergentor.Active ~= true and itmEintrittskarte.Container ~= Player then
    z02_Zwergentor.Visible = true
    itmEintrittskarte.Visible = true
    z02_Zwergentor.Active = true
    tsk02_ZwergenEintritt_collect.Visible = true
  end
  tsk22_Zwergentor_EIN.Complete = true
end
function tsk23_Zwergenfang_EIN:OnSetActive()
  if z03_Zwergenwald.Active ~= true and itmZwerg.Container ~= Player then
    z03_Zwergenwald.Visible = true
    itmZwerg.Visible = true
    z03_Zwergenwald.Active = true
    tsk03_ZwergenFang_collect.Visible = true
  end
  tsk23_Zwergenfang_EIN.Complete = true
end
function tsk04_Weggabel_EIN:OnSetActive()
  if z04_Weggabelung.Active ~= true and itmWegweiser.Container ~= Player then
    z04_Weggabelung.Visible = true
    itmWegweiser.Visible = true
    z04_Weggabelung.Active = true
    tsk04_WegEntscheidung_collect.Visible = true
  end
  tsk04_Weggabel_EIN.Complete = true
end
function tsk05_Aussicht_EIN:OnSetActive()
  if z05_Aussicht.Active ~= true and itmGugga.Container ~= Player then
    z05_Aussicht.Visible = true
    itmGugga.Visible = true
    z05_Aussicht.Active = true
    tsk05_AussichtsGenuss.Visible = true
  end
  tsk05_Aussicht_EIN.Complete = true
end
function tsk06_Viegatter_EIN:OnSetActive()
  if z06_Viehgatter.Active ~= true and itmViehgatterPassierschein.Container ~= Player then
    z06_Viehgatter.Visible = true
    itmViehgatterPassierschein.Visible = true
    z06_Viehgatter.Active = true
    tsk06_ViehgatterPassage_collect.Visible = true
  end
  tsk06_Viegatter_EIN.Complete = true
end
function tsk07_Nahversorger_EIN:OnSetActive()
  if z07_Nahversorgung.Active ~= true and itmEinkaufskorbUndRechnung.Container ~= Player then
    z07_Nahversorgung.Visible = true
    itmEinkaufskorbUndRechnung.Visible = true
    z07_Nahversorgung.Active = true
    tsk07_Nahversorgung_collect.Visible = true
    tsk08_ZeigeBeleg.Visible = true
  end
  tsk07_Nahversorger_EIN.Complete = true
end
return objCartridge
