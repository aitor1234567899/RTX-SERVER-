
natives.load_natives()
 
local function IsOnline() return NETWORK.NETWORK_IS_SESSION_STARTED() and not NETWORK.NETWORK_IS_IN_TRANSITION() and not STREAMING.IS_PLAYER_SWITCH_IN_PROGRESS() and not NETWORK.NETWORK_IS_ACTIVITY_SESSION() end
 
-- --- Primary Target ---
local KCHtargets = {
	{ 0,  "La Dernière Débauche"},
	{ 1,  "Hare Oneself Think"},
	{ 2,  "The Downfall of Rome"},
	{ 3,  "Brother Brother"},
	{ 4,  "A Cast of Characters"},
	{ 5,  "Gone To Seed"},
	{ 6,  "True Love"},
	{ 7,  "Breathless"},
	{ 8,  "Consumato"},
	{ 9,  "I Hear Voices"},
	{ 10, "Winter, Nowhere in Particular"},
	{ 11, "The Girl With the Pearl Necklace"},
	{ 12, "Chat on Fruit"},
	{ 13, "Pumpkin"},
	{ 14, "Twindifference"},
	{ 15, "Stacks Study V"},
	{ 16, "I, Fruit"},
	{ 17, "To Beat About the Bush"},
	{ 18, "In Excess of Success"},
	{ 19, "Juiced"},
	{ 20, "A Winding Road Home"},
	{ 21, "Teckels"},
	{ 22, "Trust"},
	{ 23, "Until Death"},
	{ 24, "What Are Melons?"},
	{ 25, "The Outcome of Endeavour"},
	{ 26, "Mi O Melee"}
}
 
local KCloadoutTypes = {
	{ 0, "None"},
	{ 1, "Street"},
	{ 2, "Security"},
	{ 3, "Military"}
}
 
local KCmanchezColors = {
	{ 0, "Red"},
	{ 1, "Blue"},
	{ 2, "Green"},
	{ 3, "Yellow"}
}
 
local band, bor, bnot, lshift = bit.band, bit.bor, bit.bnot, bit.lshift
 
local function KortzCenterSetup()
 
	local generalBits = -1
	if not KCguardroutes then generalBits = band(generalBits, bnot(lshift(1, 5))) end -- Guard Routes Purchased
	if not KCglasscutter then generalBits = band(generalBits, bnot(lshift(1, 6))) end -- Glass Cutter Purchased
	if not KCpowerdrills then generalBits = band(generalBits, bnot(lshift(1, 7))) end -- Power Drills Purchased
	if not KCempcharges  then generalBits = band(generalBits, bnot(lshift(1, 8))) end -- EMP Charges Purchased
 
	if KCloadouttype ~= 1 then generalBits = band(generalBits, bnot(lshift(1, 9)))  end -- Street Loadout
	if KCloadouttype ~= 2 then generalBits = band(generalBits, bnot(lshift(1, 10))) end -- Security Loadout
	if KCloadouttype ~= 3 then generalBits = band(generalBits, bnot(lshift(1, 11))) end -- Military Loadout
 
	if not (KCmanchez and KCmanchezcolor == 0) then generalBits = band(generalBits, bnot(lshift(1, 17))) end -- Red Manchez
	if not (KCmanchez and KCmanchezcolor == 1) then generalBits = band(generalBits, bnot(lshift(1, 18))) end -- Blue Manchez
	if not (KCmanchez and KCmanchezcolor == 2) then generalBits = band(generalBits, bnot(lshift(1, 19))) end -- Green Manchez
	if not (KCmanchez and KCmanchezcolor == 3) then generalBits = band(generalBits, bnot(lshift(1, 20))) end -- Yellow Manchez
 
	if not KCmanholekey then generalBits = band(generalBits, bnot(lshift(1, 27))) end -- Manhole Key
	if not KChardmode   then generalBits = band(generalBits, bnot(lshift(1, 28))) end -- Hard Mode
	if not KCweakguards then generalBits = band(generalBits, bnot(lshift(1, 31))) end -- Weak Guards
 
	local robberyProg = -1
	if not KCscopeout        then robberyProg = band(robberyProg, bnot(lshift(1, 0)))  end
	if not KCalphamail       then robberyProg = band(robberyProg, bnot(lshift(1, 1)))  end
	if not KChazmat          then robberyProg = band(robberyProg, bnot(lshift(1, 2)))  end
	if not KCstaffkeycard    then robberyProg = band(robberyProg, bnot(lshift(1, 3)))  end
	if not KCtacticalequip   then robberyProg = band(robberyProg, bnot(lshift(1, 4)))  end
	if not KChackingdevice   then robberyProg = band(robberyProg, bnot(lshift(1, 5)))  end
	if not KCaccesscode      then robberyProg = band(robberyProg, bnot(lshift(1, 6)))  end
	if not KCunmarkedweapons then robberyProg = band(robberyProg, bnot(lshift(1, 7)))  end
	if not KCcaracara        then robberyProg = band(robberyProg, bnot(lshift(1, 8)))  end
	if not KCannihilator     then robberyProg = band(robberyProg, bnot(lshift(1, 9)))  end
	if not KCmanchez         then robberyProg = band(robberyProg, bnot(lshift(1, 10))) end
	if not KCprepemp         then robberyProg = band(robberyProg, bnot(lshift(1, 11))) end
	if not KCguardshipments  then robberyProg = band(robberyProg, bnot(lshift(1, 12))) end
	if not KCguardroutesprep then robberyProg = band(robberyProg, bnot(lshift(1, 13))) end
	if not KCglasscutterprep then robberyProg = band(robberyProg, bnot(lshift(1, 14))) end
	if not KCpowerdrillsprep then robberyProg = band(robberyProg, bnot(lshift(1, 15))) end
 
	local scopingBS = KCscopesecondary and -1 or 0
	local poiBS     = KCscopepoi and -1 or 0
 
	stats.set_int("MPX_K26_GENERAL_BS", generalBits)
	stats.set_int("MPX_K26_GENERAL_BS2", -1)
	stats.set_int("MPX_K26_ROBBERY_PROG", robberyProg)
	stats.set_int("MPX_K26_HEIST_TARGET", KCprimarytarget)
	stats.set_int("MPX_K26_SCOPING_BS", scopingBS)
	stats.set_int("MPX_K26_POI_BS", poiBS)
 
	notify.success("Success!", "Kortz Center Heist has been set up!")
end
 
local KortzCenter = menu.get_submenu("Kortz Center Heist"):add_category("Configuración")
local KCGroupGeneral  = menu.create_group("Configuración", 3)
local KCGPrepWork = menu.get_submenu("Kortz Center Heist"):add_category("Trabajo preparatorio")
local KCGroupPrepWork = menu.create_group("Required Trabajo preparatorio", 6)
local KCOptionalPrep = menu.get_submenu("Kortz Center Heist"):add_category("Preparación opcional")
local KCGroupOptionalPrep = menu.create_group("Trabajos preparatorios opcionales", 5)
 
 
KortzCenter:imgui(function()
	if IsOnline() then
		KCGroupGeneral:draw()
	else
		ImGui.TextDisabled("Please join a freemode session.")
		return
	end
end)
 
KCGPrepWork:imgui(function()
	if IsOnline() then
		KCGroupPrepWork:draw()
	else
		ImGui.TextDisabled("Please join a freemode session.")
		return
	end
end)
 
KCOptionalPrep:imgui(function()
	if IsOnline() then
		KCGroupOptionalPrep:draw()
	else
		ImGui.TextDisabled("Please join a freemode session.")
		return
	end
end)
 
-- =========================================================
-- Group 1: Setup
-- =========================================================
KCGroupGeneral:add_checkbox("KC_setprimarytarget", "Establecer objetivo principal", "=", false, function()
	notify.success("KortZ", "Set Primary Target enabled!", 3000)
end, function()
	notify.info("KortZ", "Set Primary Target disabled!", 3000)
end)
 
commandmgr.add_list_command("KC_primarytarget", "Primary Target", "", KCHtargets, 0, function()
	KCprimarytarget = commandmgr.get_command("KC_primarytarget"):get_value()
end) KCprimarytarget = 0
 
KCGroupGeneral:imgui(function()
    if commandmgr.get_command("KC_setprimarytarget"):get_value() == true then
        commandmgr.get_command("KC_primarytarget"):draw()
		ImGui.Spacing()
    end
end)
 
KCGroupGeneral:add_checkbox("KC_scopesecondary", "Objetivos secundarios", "Objetivos secundarios ", false, function() end)
KCGroupGeneral:add_checkbox("KC_scopeout",       "Observar",         "Echa un vistazo al Kortz Center.",  false, function() end)
KCGroupGeneral:add_checkbox("KC_hardmode",       "Modo difícil",         "Modo difícil activado",       false, function() end)
KCGroupGeneral:add_checkbox("KC_scopepoi",       "Puntos de interés","Puntos de interés del alcance",false, function() end)
 
-- =========================================================
-- Group 2: Required Prep Work
-- =========================================================
 
-- --- Infiltration Gear ---
KCGroupPrepWork:imgui(function()
	ImGui.Text("Equipo de infiltración")
	ImGui.Separator()
end)
KCGroupPrepWork:add_checkbox("KC_alphamail",      "Disfraz de correo Alpha", "Disfraz de correo Alpha",false, function() end)
KCGroupPrepWork:add_checkbox("KC_hazmat",         "Traje de protección contra materiales peligrosos", "Traje de protección contra materiales peligrosos",       false, function() end)
KCGroupPrepWork:add_checkbox("KC_staffkeycard",  "Tarjeta de acceso para el personal", "Tarjeta de acceso para el personal",      false, function() end)
KCGroupPrepWork:add_checkbox("KC_tacticalequip", "Equipo táctico", "Equipo táctico",   false, function() end)
 
KCGroupPrepWork:imgui(function()
	ImGui.Spacing()
end)
 
-- --- Getaway Vehicles ---
KCGroupPrepWork:imgui(function()
	ImGui.Text("Vehículos de escape")
end)
 
KCGroupPrepWork:add_checkbox("KC_caracara",       "Caracara acorazado", "Caracara acorazado",        false, function() end)
KCGroupPrepWork:add_checkbox("KC_annihilator",     "Sigilo del Aniquilador", "Sigilo del Aniquilador",   false, function() end)
KCGroupPrepWork:add_checkbox("KC_manchez",           "Mánchez", "Mánchez",              false, function() end)
 
commandmgr.add_list_command("KC_manchezcolor", "Manchez Color", "", KCmanchezColors, 0, function()
	KCmanchezcolor = commandmgr.get_command("KC_manchezcolor"):get_value()
end) KCmanchezcolor = 0
 
KCGroupPrepWork:imgui(function()
	if commandmgr.get_command("KC_manchez"):get_value() == true then
		commandmgr.get_command("KC_manchezcolor"):draw()
		ImGui.Spacing()
	end
end)
 
KCGroupPrepWork:imgui(function()
	ImGui.Spacing()
end)
 
 
-- --- Unmarked Weapons ---
KCGroupPrepWork:imgui(function()
	ImGui.Text("Armas sin marcar")
end)
 
KCGroupPrepWork:add_checkbox("KC_unmarkedweapons", "Armas sin marcar", "Armas sin marcar",        false, function() end)
 
commandmgr.add_list_command("KC_loadouttype", "Loadout Type", "", KCloadoutTypes, 0, function()
	KCloadouttype = commandmgr.get_command("KC_loadouttype"):get_value()
end) KCloadouttype = 0
 
KCGroupPrepWork:imgui(function()
	if commandmgr.get_command("KC_unmarkedweapons"):get_value() == true then
		commandmgr.get_command("KC_loadouttype"):draw()
		ImGui.Spacing()
	end
end)
 
-- --- Equipment ---
KCGroupPrepWork:imgui(function()
	ImGui.Text("Equipment")
	ImGui.Separator()
end)
 
KCGroupPrepWork:add_checkbox("KC_hackingdevice",    "Dispositivo de pirateo", "Dispositivo de pirateo",        false, function() end)
KCGroupPrepWork:add_checkbox("KC_accesscode",         "Código de acceso", "Código de acceso",        false, function() end)
 
 
 
 
 
-- =========================================================
-- Group 3: Optional Prep Work
-- =========================================================
 
KCGroupOptionalPrep:add_checkbox("KC_guardshipments",  "Proteger los envíos", "Proteger los envíos",         false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_guardroutesprep",   "Rutas de vigilancia (Preparación)", "Preparación de rutas de vigilancia",     false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_glasscutterprep", "Cortador de vidrio (Preparación)", "Preparación del cortador de vidrio",       false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_powerdrillsprep", "Taladros eléctricos (Preparación)", "Preparación de taladros eléctricos",      false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_prepemp",          "Cargas EMP (Preparación)", "Preparación de cargas EMP",     false, function() end)
 
KCGroupOptionalPrep:add_checkbox("KC_manholekey",  "Llave de alcantarilla", "Requerida para la entrada de alcantarillado",  false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_weakguards",   "Guardias débiles", "Guardias débiles habilitados", false, function() end)
 
KCGroupOptionalPrep:add_checkbox("KC_guardroutes",   "Rutas de vigilancia (Comprar)", "Rutas de vigilancia compradas", false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_glasscutter",  "Cortador de vidrio (Comprar)", "Cortador de vidrio comprado",  false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_powerdrills",  "Taladros eléctricos (Comprar)", "Taladros eléctricos comprados",  false, function() end)
KCGroupOptionalPrep:add_checkbox("KC_empcharges",    "Cargas EMP (Comprar)", "Cargas EMP compradas",  false, function() end)
 
 
KCGroupOptionalPrep:imgui(function()
 
	KCguardroutes        = commandmgr.get_command("KC_guardroutes"):get_value()
	KCglasscutter        = commandmgr.get_command("KC_glasscutter"):get_value()
	KCpowerdrills        = commandmgr.get_command("KC_powerdrills"):get_value()
	KCempcharges         = commandmgr.get_command("KC_empcharges"):get_value()
	KCscopeout           = commandmgr.get_command("KC_scopeout"):get_value()
	KCalphamail          = commandmgr.get_command("KC_alphamail"):get_value()
	KChazmat             = commandmgr.get_command("KC_hazmat"):get_value()
	KCstaffkeycard       = commandmgr.get_command("KC_staffkeycard"):get_value()
	KCtacticalequip      = commandmgr.get_command("KC_tacticalequip"):get_value()
	KChackingdevice      = commandmgr.get_command("KC_hackingdevice"):get_value()
	KCaccesscode         = commandmgr.get_command("KC_accesscode"):get_value()
	KCunmarkedweapons    = commandmgr.get_command("KC_unmarkedweapons"):get_value()
	KCcaracara           = commandmgr.get_command("KC_caracara"):get_value()
	KCannihilator        = commandmgr.get_command("KC_annihilator"):get_value()
	KCmanchez            = commandmgr.get_command("KC_manchez"):get_value()
	KCprepemp            = commandmgr.get_command("KC_prepemp"):get_value()
	KCguardshipments     = commandmgr.get_command("KC_guardshipments"):get_value()
	KCguardroutesprep    = commandmgr.get_command("KC_guardroutesprep"):get_value()
	KCglasscutterprep    = commandmgr.get_command("KC_glasscutterprep"):get_value()
	KCpowerdrillsprep    = commandmgr.get_command("KC_powerdrillsprep"):get_value()
	KCscopesecondary     = commandmgr.get_command("KC_scopesecondary"):get_value()
	KCscopepoi           = commandmgr.get_command("KC_scopepoi"):get_value()
	KCloadouttype        = commandmgr.get_command("KC_loadouttype"):get_value()
	KCmanholekey         = commandmgr.get_command("KC_manholekey"):get_value()
	KChardmode           = commandmgr.get_command("KC_hardmode"):get_value()
	KCweakguards         = commandmgr.get_command("KC_weakguards"):get_value()
	KCmanchezcolor       = commandmgr.get_command("KC_manchezcolor"):get_value()
 
	ImGui.Spacing()ImGui.Spacing()ImGui.Spacing()
	ImGui.Separator()
	ImGui.Spacing()
 
	if ImGui.Button("¡Configuración!", 80, 40) then
		script.run_in_callback(function() KortzCenterSetup() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Configura el atraco al Centro Kortz con las opciones seleccionadas.") end
end)