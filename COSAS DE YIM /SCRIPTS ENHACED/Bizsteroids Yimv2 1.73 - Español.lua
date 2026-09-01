natives.load_natives()
local cls = "                                            \r"
local lual = "\r\27[9C]\27[94m[INFO/LuaScript]\27[m "
local lual_s = ": \27[92mInicializado correctamente\27[m                           "
local function IsOnline() return NETWORK.NETWORK_IS_SESSION_STARTED() and not NETWORK.NETWORK_IS_IN_TRANSITION() and not STREAMING.IS_PLAYER_SWITCH_IN_PROGRESS() and not NETWORK.NETWORK_IS_ACTIVITY_SESSION() end

local HGgoodtype = {
	{ 0, "Materiales Animales" },
	{ 1, "Arte y Antigüedades" },
	{ 2, "Químicos" },
	{ 3, "Mercancía Falsificada" },
	{ 4, "Joyas y Gemas" },
	{ 5, "Suministros Médicos" },
	{ 6, "Narcóticos" },
	{ 7, "Tabaco y Alcohol" }
}

local WHgoodtype = {
	{ 0,  "Suministros Médicos" },
	{ 1,  "Tabaco y Alcohol" },
	{ 2,  "Arte y Antigüedades" },
	{ 3,  "Productos Electrónicos" },
	{ 4,  "Armas y Munición" },
	{ 5,  "Narcóticos" },
	{ 6,  "Gemas" },
	{ 7,  "Materiales Animales" },
	{ 8,  "Mercancía Falsificada" },
	{ 9,  "Joyas" },
	{ 10, "Barras de Oro" }
}

local PropGlob = {
	whprop = 1845347 + 260 + 128,
	hangarprop = 1845347 + 260 + 304,
	bbizprop = 1845347 + 260 + 205,
	ncprop = 1845347 + 260 + 364,
	syprop = 1845347 + 260 + 504,
}

local function OpenMCT()
	if scripts.is_active("apparcadebusinesshub") then
		scripts.run_as_script("apparcadebusinesshub", function() SCRIPT.TERMINATE_THIS_THREAD() end)
	end
	if ScriptGlobal(1951071):get_int() ~= 0 then -- Credits to PazzoG
		ScriptGlobal(1951071):set_int(0)
	end
	SCRIPT.REQUEST_SCRIPT("apparcadebusinesshub")
	if SCRIPT.HAS_SCRIPT_LOADED("apparcadebusinesshub") then
		BUILTIN.START_NEW_SCRIPT("apparcadebusinesshub", 1424)
		SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED("apparcadebusinesshub")
	end
end

script.run_in_callback(function()
	while scripts.is_active("apparcadebusinesshub") do
		if ScriptGlobal(1971195):get_int() == -1 then
			ScriptGlobal(1971195):set_int(0)
		end
		script.yield(0)
	end
end)

local BizRe_running = false
local BizRe_cancel = true
local function BizRe_lotoggle()
	if BizRe_cancel then
		notify.warn("TinkerScript - Biz-Teroids", "Lógica cancelada.", 3000)
		BizRe_running = false
		STATS.STAT_SAVE(0, 0, 3, 0)
	end
	return BizRe_cancel
end

local function GetBusinessSlot(businessName)
	local MCbizlocs = {
		[1] = "Paleto Bay", [6] = "El Burro Heights", [11] = "Gran Senora Desert", [16] = "Terminal",
		[2] = "Mount Chiliad", [7] = "Downtown Vinewood", [12] = "San Chianski Mountain Range", [17] = "Elysian Island",
		[3] = "Paleto Bay", [8] = "Morningwood", [13] = "Alamo Sea", [18] = "Elysian Island",
		[4] = "Paleto Bay", [9] = "Vespucci Canals", [14] = "Gran Senora Desert", [19] = "Cypress Flats",
		[5] = "Paleto Bay", [10] = "Textile City", [15] = "Grapeseed", [20] = "Elysian Island",
		[21] = "Grand Senora Oilfields", [22] = "Grand Senora Desert", [23] = "Route 68", [24] = "Farmhouse", [25] = "Smoke Tree Road", [26] = "Thomson Scrapyard", [27] = "Grapeseed", [28] = "Paleto Forest", [29] = "Raton Canyon", [30] = "Lago Zancudo", [31] = "Chumash"
	}
	local MCbiz = {
		{ MCBname = "Methamphetamine Lab", ID = { 1, 6, 11, 16 } },
		{ MCBname = "Weed Farm", ID = { 2, 7, 12, 17 } },
		{ MCBname = "Cocaine Lockup", ID = { 3, 8, 13, 18 } },
		{ MCBname = "Counterfeit Cash Factory", ID = { 4, 9, 14, 19 } },
		{ MCBname = "Document Forgery Office", ID = { 5, 10, 15, 20 } },
		{ MCBname = "Bunker", ID = { 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 } }
	}
	for _, business in ipairs(MCbiz) do -- Credit to Silenthy6 (SilentSalo) for this part https://www.unknowncheats.me/forum/4380348-post701.html (it was too much for my brain)
		if business.MCBname == businessName then
			for i = 0, 5 do
				local slot = ScriptGlobal(PropGlob.bbizprop):at(PLAYER.PLAYER_ID(), 884):at(i, 13):get_int()
				if slot > 0 then
					for _, id in ipairs(business.ID) do
						if slot == id then
							local mcbizloc = MCbizlocs[slot]
							log.info("\r\27[1;36mNegocio:\27[1;92m "..businessName.." \27[m| \27[1;36mUbicación:\27[m "..mcbizloc.." | \27[1;36mSlot:\27[m "..i.." | \27[1;36mID:\27[m "..slot.."            \r")
							return true, i
						end
					end
				end
			end
		end
	end
end

local function BizRe_Hangar()
	if ScriptGlobal(PropGlob.hangarprop):at(PLAYER.PLAYER_ID(), 884):get_int() >= 1 then
		if ScriptGlobal(PropGlob.hangarprop + 3):at(PLAYER.PLAYER_ID(), 884):get_int() <= 49 then
			if HGWHmaxgoods then
				if HGsetgood then
					ScriptGlobal(1882787 + 8):set_int(HGgoodtype)
				end
				ScriptGlobal(1882787 + 7):set_int(50)
				stats.set_packed_bool(36828, true)
				STATS.STAT_SAVE(0, 0, 3, 0)
				notify.success("¡Éxito!", "¡Mercancía del hangar reabastecida!", 3000)
			else
				notify.info("TinkerScript - Biz-Teroids", "Reabastecimiento instantáneo máximo deshabilitado. El hangar se reabastecerá con mercancía mixta.", 3000)
				for HGl = 0, 49 do if BizRe_running and BizRe_lotoggle() then return end
					stats.set_packed_bool(36828, true)
					script.yield(1500)
				end
			end
		else
			notify.warn("¡Ups!", "El hangar está al máximo de capacidad.", 3000)
		end
		BizRe_cancel = true
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees un Hangar.", 3000)
	end
end

local function BizRe_Warehouse()
	if ScriptGlobal(PropGlob.whprop):at(PLAYER.PLAYER_ID(), 884):at(0, 3):get_int() <= 0 then
		notify.error("TinkerScript - Biz-Teroids", "No posees un Almacén.", 3000)
	end
	if HGWHmaxgoods then
		for WHp, c in ipairs({32359, 32360, 32361, 32362, 32363}) do if BizRe_running and BizRe_lotoggle() then return end
			if ScriptGlobal(PropGlob.whprop):at(PLAYER.PLAYER_ID(), 884):at(WHp - 1, 3):get_int() >= 1 then
				if BizRe_running and BizRe_lotoggle() then return end
				if ScriptGlobal(PropGlob.whprop + 1):at(PLAYER.PLAYER_ID(), 884):at(WHp - 1, 3):get_int() <= 110 then
					for i = 1, 2 do if BizRe_running and BizRe_lotoggle() then return end
						if WHsetgood then ScriptGlobal(1882762 + 16):set_int(WHgoodtype) end
						ScriptGlobal(1882762 + 13):set_int(111)
						stats.set_packed_bool(c, true)
						script.yield(2000)
					end
					STATS.STAT_SAVE(0, 0, 3, 0)
					notify.success("¡Éxito!", string.format("¡Mercancía del Almacén(%d) reabastecida!", WHp))
				else
					notify.warn("¡Ups!", string.format("El Almacén(%d) está al máximo de capacidad.", WHp))
				end
			end
		end
		BizRe_cancel = true
	else
		notify.info("TinkerScript - Biz-Teroids", "Reabastecimiento instantáneo máximo deshabilitado. El Almacén se reabastecerá con mercancía mixta.", 3000) script.yield(3000)
		for WHl = 1, 111 do if BizRe_running and BizRe_lotoggle() then return end
			stats.set_packed_bool_range(32359, 32363, true)
			script.yield(100)
		end
		BizRe_cancel = true
	end
end

local function BizRe_MCresup()
	tunables.set_int(1712674055, 1)
	for b = 0, 7 do
		if ScriptGlobal(PropGlob.bbizprop):at(PLAYER.PLAYER_ID(), 884):at(b, 13):get_int() >= 1 then
			for bsup = 1, 7 do
				ScriptGlobal(1673820 + bsup):set_int(1)
			end
		end
	end
	notify.success("¡Éxito!", "¡Se han reabastecido todos los suministros de los negocios!", 3000)
end

local function BizRe_MCrestock()

	local methmc, slot = GetBusinessSlot("Methamphetamine Lab")
	if methmc then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(slot, 13):get_int() <= 19 then
			for _, manuprod in ipairs({1370024930, 1944848251, 1577999189, 1678460062}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({-730135062, -660914094}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio de Metanfetamina reabastecido!\nPor favor reinicia tu negocio.", 3000)
		else
			notify.warn("¡Ups!", "¡El stock del negocio de Metanfetamina está al máximo!", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees un Laboratorio de Metanfetamina.", 3000)
	end

	if BizRe_running and BizRe_lotoggle() then return end
	local weedmc, slot = GetBusinessSlot("Weed Farm")
	if weedmc then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(slot, 13):get_int() <= 79 then
			for _, manuprod in ipairs({-635596193, -1694873660, 1575359233, 102029883}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({-373027461, 1195564032}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio de Marihuana reabastecido!\nPor favor reinicia tu negocio.", 3000)
		else
			notify.warn("¡Ups!", "¡El stock del negocio de Marihuana está al máximo!", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees una Plantación de Marihuana.", 3000)
	end

	if BizRe_running and BizRe_lotoggle() then return end
	local crackmc, slot = GetBusinessSlot("Cocaine Lockup")
	if crackmc then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(slot, 13):get_int() <= 9 then
			for _, manuprod in ipairs({702413484, 2070857577, -1539796661, 396217128}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({-161187879, 1500658261}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio de Cocaína reabastecido!\nPor favor reinicia tu negocio.", 3000)
		else
			notify.warn("¡Ups!", "¡El stock del negocio de Cocaína está al máximo!", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees un Negocio de Cocaína.", 3000)
	end

	if BizRe_running and BizRe_lotoggle() then return end
	local cashmc, slot = GetBusinessSlot("Counterfeit Cash Factory")
	if cashmc then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(slot, 13):get_int() <= 39 then
			for _, manuprod in ipairs({1310272402, 1690071006, -1454958662, -1913260493}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({631857857, -891680742}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio de Billetes Falsos reabastecido!\nPor favor reinicia tu negocio.", 3000)
		else
			notify.warn("¡Ups!", "¡El stock del negocio de Billetes Falsos está al máximo!", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees una Fábrica de Billetes Falsos.", 3000)
	end

	if BizRe_running and BizRe_lotoggle() then return end
	local fakeidmc, slot = GetBusinessSlot("Document Forgery Office")
	if fakeidmc then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(slot, 13):get_int() <= 59 then
			for _, manuprod in ipairs({-959721585, 1672482518, -518264160, 489023341}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({-1839004359, -192060672}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio de Documentos Falsos reabastecido!\nPor favor reinicia tu negocio.", 3000)
		else
			notify.warn("¡Ups!", "¡El stock del negocio de Documentos Falsos está al máximo!", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees una Oficina de Falsificación de Documentos.", 3000)
	end

	if BizRe_running and BizRe_lotoggle() then return end
	local bunkermc, slot = GetBusinessSlot("Bunker")
	if bunkermc then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(slot, 13):get_int() <= 99 then
			for _, manuprod in ipairs({215868155, 631477612, 818645907}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({-1652502760, 1647327744}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio del Búnker reabastecido!\nPor favor reinicia tu negocio.", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees un Búnker.", 3000)
	end

	if BizRe_running and BizRe_lotoggle() then return end
	if ScriptGlobal(PropGlob.bbizprop):at(PLAYER.PLAYER_ID(), 884):at(6, 13):get_int() >= 1 then
		if ScriptGlobal(PropGlob.bbizprop + 1):at(PLAYER.PLAYER_ID(), 884):at(6, 13):get_int() <= 159 then
			for _, manuprod in ipairs({-672998848, 494316332, -40235252}) do
				tunables.set_int(manuprod, 1)
			end
			for _, manucost in ipairs({-1506354854, -993236072}) do
				tunables.set_int(manucost, 1)
			end
			script.yield(2000)
			notify.success("¡Éxito!", "¡Negocio de Laboratorio de Ácido reabastecido!\nPor favor reinicia tu negocio.", 3000)
		end
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees un Laboratorio de Ácido.", 3000)
	end
end


local function BizRe_NCrestock()
	if ScriptGlobal(PropGlob.ncprop):at(PLAYER.PLAYER_ID(), 884):get_int() >= 1 then
		if ScriptGlobal(PropGlob.ncprop + 4):get_float() <= 99.0 then
			stats.set_int("MPX_CLUB_POPULARITY", 1000)
			notify.success("¡Éxito!", "¡La Popularidad de la Discoteca se ha maximizado!", 3000)
		end
		for _, manuprod in ipairs({-147565853, -1390027611, -1292210552, 1007184806, 18969287, -863328938, 1607981264}) do
			tunables.set_int(manuprod, 1)
		end
		notify.success("¡Éxito!", "¡Discoteca reabastecida!\nPor favor reasigna tus técnicos.", 3000)
		script.yield(2000)
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees una Discoteca.", 3000)
	end
end

local function BizRe_SalvPop()
	if ScriptGlobal(PropGlob.syprop):at(PLAYER.PLAYER_ID(), 884):get_int() >= 1 then
		stats.set_packed_int(51051, 100)
		notify.success("¡Éxito!", "¡La Reputación del Desguace se ha maximizado!", 3000)
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees un Desguace.", 3000)
	end
end

local function BizRe_MFheat()
	if stats.get_int("MPX_SB_CAR_WASH_OWNED") == 1 then
		for tycoonh = 24924, 24926 do
			stats.set_packed_int(tycoonh, 0)
		end
		notify.success("¡Éxito!", "¡Calor de Negocios Money Fronts eliminado!", 3000)
		script.yield(2000)
	else
		notify.error("TinkerScript - Biz-Teroids", "No posees el Lavado de Autos.", 3000)
	end
end

local BizRe_count = true
local function BusinessOnSteroids()

local function Countdown()
	local cd_cls = "\r                                                                                \r"
	log.info(cd_cls.."\27[1A\27[26C10\r") script.yield(999)
	for i = 10, 1, -1 do if BizRe_lotoggle() then return end
		notify.info("TinkerScript - Biz-Teroids by ImagineNothing", "La lógica principal comenzará en "..i..".", 999)
		log.info(cd_cls.."\27[1A\27[26C"..i.."  \r") script.yield(999)
	end
	log.info(cd_cls.."\27[1AIniciando...                           \r")
	log.info(cd_cls.."\27[1A\27[42;30m Iniciar \27[m                           \r\n")
end

	log.warn("\r                                                                                 \r"..[[
           __     Este script reabastecerá/rellenará:
  \ ______/ V`-,  ]].."\27[38;5;124mHangar y Almacenes\27[m\n"..[[
   }        /~~  ]].."\27[32mNegocios de MC\27[m\n"..[[
  /_)^ --,r'    ]].."\27[95mDiscoteca\27[m y \27[95mBarra de Popularidad\27[m"..[[
 |b      |b   ]].."\27[38;5;27mReputación del Desguace\27[m"..[[
 ]].."Eliminar niveles de calor: \27[38;5;208mNegocios Money Fronts\27[m"..[[
 ]].."\n\27[2;37;3mDEBES REINICIAR TUS NEGOCIOS DE MC Y REASIGNAR TÉCNICOS DE LA DISCOTECA DESPUÉS DE EJECUTAR EL SCRIPT SI *RESTOCK* ESTÁ HABILITADO.\27[m\n\nLa lógica principal comenzará en:")


	if BizRe_count then Countdown() end

	if BizRe_lotoggle() then return end

	if HGWHrestock then
		BizRe_Hangar()
		if BizRe_lotoggle() then return end
		BizRe_Warehouse()
	else
		notify.info("TinkerScript - Biz-Teroids", "Reabastecimiento de Hangar y Almacén deshabilitado. Omitiendo...")
	end

	if BizRe_lotoggle() then return end
	if MCresup then BizRe_MCresup() else notify.info("TinkerScript - Biz-Teroids", "Reabastecimiento de Negocios de MC deshabilitado. Omitiendo...") end

	script.yield(3000)

	if BizRe_lotoggle() then return end
	if MCrestock then
		notify.info("TinkerScript - Biz-Teroids", "Reabastecimiento de Negocios de MC habilitado.")
		BizRe_MCrestock()
	else
		notify.info("TinkerScript - Biz-Teroids", "Reabastecimiento de Negocios de MC deshabilitado. Omitiendo...")
	end

	script.yield(3000)

	if BizRe_lotoggle() then return end
	if NCgoods then BizRe_NCrestock() end

	BizRe_SalvPop()
	if BizRe_lotoggle() then return end
	BizRe_MFheat()

	STATS.STAT_SAVE(0, 0, 3, 0)
	BizRe_cancel = true
	BizRe_running = false

	log.info("\r                                                                                \r\n\r\27[1B\27[42;30m Fin \27[m\n")
	notify.success("TinkerScript - Biz-Teroids", "¡Completado!", 3000)

end

local TS_Bizteroids = menu.get_submenu("Biz-Teroids"):add_category("Principal")
local BizteroidsMenu = menu.create_group("Panel de Control", 20)

TS_Bizteroids:imgui(function()
	if IsOnline() then BizteroidsMenu:draw() else ImGui.TextDisabled("Por favor, únete a una sesión de modo libre.") return end
end)

BizteroidsMenu:add_checkbox("HGWH_restock", "Reabastecimiento Hangar/Almacén", "¿Debe el script reabastecer tu Hangar y Almacenes?", true)
BizteroidsMenu:add_checkbox("HGWH_maxgoods", "Mercancía Máxima Hangar/Almacén", "¿Debe el script maximizar instantáneamente el stock de tu Hangar y Almacenes?\nSi está deshabilitado, el reabastecimiento será un poco más lento, pero recibirás mercancía mixta", true)

BizteroidsMenu:add_checkbox("HG_setgood", "Establecer Mercancía del Hangar", "El tipo de mercancía para el Hangar será aleatorio si esto está deshabilitado", false)

commandmgr.add_list_command("HG_goodtype", "Tipo de Mercancía del Hangar", "", HGgoodtype, 0, function()
	HGgoodtype = commandmgr.get_command("HG_goodtype"):get_value()
end) HGgoodtype = 0

BizteroidsMenu:imgui(function()
    if commandmgr.get_command("HG_setgood"):get_value() == true then
        commandmgr.get_command("HG_goodtype"):draw()
		ImGui.Spacing()
    end
end)

BizteroidsMenu:add_checkbox("WH_setgood", "Establecer Mercancía del Almacén", "El tipo de mercancía para los Almacenes será aleatorio si esto está deshabilitado", false)

commandmgr.add_list_command("WH_goodtype", "Tipo de Mercancía del Almacén", "", WHgoodtype, 0, function()
	WHgoodtype = commandmgr.get_command("WH_goodtype"):get_value()
end) WHgoodtype = 0

BizteroidsMenu:imgui(function()
    if commandmgr.get_command("WH_setgood"):get_value() == true then
        commandmgr.get_command("WH_goodtype"):draw()
		ImGui.Spacing()
    end
end)

BizteroidsMenu:add_checkbox("MC_resup", "Reabastecimiento Negocios MC", "¿Debe el script reabastecer todos tus Negocios de MC?", true)
BizteroidsMenu:add_checkbox("MC_restock", "Restock Negocios MC", "¿Debe el script rellenar tus Negocios de MC?", true)
BizteroidsMenu:add_checkbox("NC_goods", "Reabastecimiento Discoteca", "¿Debe el script reabastecer tu Discoteca?", true)

BizteroidsMenu:imgui(function()

	HGWHrestock = commandmgr.get_command("HGWH_restock"):get_value()
	HGWHmaxgoods = commandmgr.get_command("HGWH_maxgoods"):get_value()
	HGsetgood = commandmgr.get_command("HG_setgood"):get_value()
	WHsetgood = commandmgr.get_command("WH_setgood"):get_value()
	MCresup = commandmgr.get_command("MC_resup"):get_value()
	MCrestock = commandmgr.get_command("MC_restock"):get_value()
	NCgoods = commandmgr.get_command("NC_goods"):get_value()

	ImGui.Spacing()ImGui.Spacing()ImGui.Spacing()
	if BizRe_cancel and ImGui.Button("¡Ejecutar!", 80, 40) then
		BizRe_running = true
		BizRe_cancel = false
		script.run_in_callback(function() BusinessOnSteroids() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Bendice a los negocios.") end

	if BizRe_cancel then
		ImGui.SameLine()
		ImGui.BeginGroup()
		ImGui.Spacing()ImGui.Spacing()
		BizRe_count = ImGui.Checkbox("Cuenta Regresiva", BizRe_count)
		ImGui.EndGroup()
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Te permite deshabilitar la cuenta regresiva de 10s al ejecutar Biz-Teroids") end

	if not BizRe_cancel and BizRe_running then
		if ImGui.Button("Cancelar", 80, 40) then
			BizRe_cancel = true
		end if ImGui.IsItemHovered() then ImGui.SetTooltip("Cancela la lógica de Biz-Teroids.") end
	end
    ImGui.Spacing()ImGui.Spacing()ImGui.Spacing()

	ImGui.Text("Funciones Individuales")ImGui.Separator()ImGui.Spacing()

	if ImGui.Button("Terminal de Control Maestro", 185) then
		script.run_in_callback(function() OpenMCT() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Gestiona tus negocios. (Doble Clic)") end ImGui.SameLine()

	if ImGui.Button("Negocios Poseídos", 185) then
		GetBusinessSlot("Methamphetamine Lab")
		GetBusinessSlot("Weed Farm")
		GetBusinessSlot("Cocaine Lockup")
		GetBusinessSlot("Counterfeit Cash Factory")
		GetBusinessSlot("Document Forgery Office")
		GetBusinessSlot("Bunker")
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Imprime tus negocios poseídos en consola.") end ImGui.NewLine()

	if ImGui.Button("Reabastecer Hangar", 185) then
		BizRe_running = true
		BizRe_cancel = false
		script.run_in_callback(function() BizRe_Hangar() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Reabastece tu Hangar.") end ImGui.SameLine()

	if ImGui.Button("Reabastecer Almacén", 185) then
		BizRe_running = true
		BizRe_cancel = false
		script.run_in_callback(function() BizRe_Warehouse() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Reabastece tu(s) Almacén(es).") end

	if ImGui.Button("Reabastecer Negocios MC", 185) then
		BizRe_running = true
		BizRe_cancel = false
		script.run_in_callback(function() BizRe_MCrestock() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Reabastece todos tus Negocios de Club de Motociclistas") end ImGui.SameLine()

	if ImGui.Button("Reabastecer Suministros MC", 185) then
		BizRe_MCresup()
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Reabastece los suministros de todos tus Negocios de Club de Motociclistas.") end

	if ImGui.Button("Reabastecer Discoteca", 185) then
		script.run_in_callback(function() BizRe_NCrestock() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Reabastece tu Discoteca.") end ImGui.SameLine()

	if ImGui.Button("Calor de Negocios", 185) then
		script.run_in_callback(function() BizRe_MFheat() end)
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Elimina el calor de Money Fronts.") end

	if ImGui.Button("Popularidad Discoteca", 185) then
		if ScriptGlobal(PropGlob.ncprop):at(PLAYER.PLAYER_ID(), 884):get_int() >= 1 then
			if stats.get_int("MPX_CLUB_POPULARITY") <= 999 then
				stats.set_int("MPX_CLUB_POPULARITY", 1000)
				notify.success("¡Éxito!", "¡La Popularidad de la Discoteca se ha maximizado!")
			end
		else
			notify.error("TinkerScript - Biz-Teroids", "No posees una Discoteca.")
		end
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Establece la popularidad de tu Discoteca al máximo.") end ImGui.SameLine()

	if ImGui.Button("Popularidad Desguace", 185) then
		BizRe_SalvPop()
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Establece la popularidad de tu Desguace al máximo.") end

	ImGui.SetWindowFontScale(0.6)
	ImGui.TextDisabled("\nDEBES REINICIAR TUS NEGOCIOS DE MC Y REASIGNAR TÉCNICOS DE LA DISCOTECA SI *RESTOCK* ESTÁ HABILITADO")
	ImGui.SetWindowFontScale(1.0)

	ImGui.Spacing()ImGui.Spacing()ImGui.Spacing()
	ImGui.Text("Venta Instantánea") ImGui.SameLine() ImGui.TextColored(0.2, 1, 1, 1, "°°°°")ImGui.Separator()ImGui.Spacing()

	if ImGui.Button("Carga Especial##sell", 185) then
		if scripts.is_active("gb_contraband_sell") then
			ScriptLocal("gb_contraband_sell", 576 + 1):set_int(67230)
		else
			notify.info("TinkerScript - Biz-Teroids", "¡Debes iniciar una Misión de Venta de Carga Especial primero!")
		end
	end

	ImGui.SameLine() if ImGui.Button("Carga Aérea (Aire)", 185) then
		if scripts.is_active("gb_smuggler") then
			ScriptLocal("gb_smuggler", 1998 + 1035):set_int(0)
			ScriptLocal("gb_smuggler", 1998 + 1078):set_int(1)
		else
			notify.info("TinkerScript - Biz-Teroids", "¡Debes iniciar una Misión de Venta de Carga Aérea primero!")
		end
	end

	if ImGui.Button("Armas", 185) then
		if scripts.is_active("gb_gunrunning") then
			ScriptLocal("gb_gunrunning", 1275 + 774):set_int(0)
		else
			notify.info("TinkerScript - Biz-Teroids", "¡Debes iniciar una Misión de Venta de Armas primero!")
		end
	end

	ImGui.SameLine() if ImGui.Button("Producto Negocios MC", 185) then
		if scripts.is_active("gb_biker_contraband_sell") then
			ScriptLocal("gb_biker_contraband_sell", 738 + 122):set_int(ScriptLocal("gb_biker_contraband_sell", 738 + 174):get_int())
		else
			notify.info("TinkerScript - Biz-Teroids", "¡Debes iniciar una Misión de Venta de Producto primero!")
		end
	end

	ImGui.SameLine() if CAMERA.IS_SCREEN_FADED_OUT() and scripts.is_active("gb_biker_contraband_sell") then
		if ImGui.Button("Aparecer") then
			CAMERA.DO_SCREEN_FADE_IN(500)
		end
	end if ImGui.IsItemHovered() then ImGui.SetTooltip("Usa esto si estás atrapado en pantalla negra.") end
end)
