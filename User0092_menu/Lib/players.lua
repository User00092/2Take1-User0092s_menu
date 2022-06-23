local requests = require("User0092_menu/Lib/requests")
local globals = require("User0092_menu/Lib/globals")



local collectableTypes = {
	{"action figures",2784215},
	{"playing cards",2784216},
	{"signal jammers",2784217}
}
function GiveSelfBadsport()
	stat_set_int("MPPLY_BADSPORT_MESSAGE", false,-1)
	stat_set_int("MPPLY_BECAME_BADSPORT_NUM", false, -1)
	stat_set_float("MPPLY_OVERALL_BADSPORT",false,60000)
	stat_set_bool("MPPLY_CHAR_IS_BADSPORT",false,true)
	menu.notify("Added Badsport to self","Successful Operation",3,0x008000)
end
function RemoveSelfBadsport()
	stat_set_int("MPPLY_BADSPORT_MESSAGE", false,0)
	stat_set_int("MPPLY_BECAME_BADSPORT_NUM", false, 0)
	stat_set_float("MPPLY_OVERALL_BADSPORT",false,0)
	stat_set_bool("MPPLY_CHAR_IS_BADSPORT",false,false)
	menu.notify("Removed Badsport from self","Successful Operation",3,0x008000)
end
function unlockCollectables(name,value,playerid,coords)
	for id, data in ipairs(collectableTypes) do 
		if name:match(data[1]) then 
			local collectable_completed = script.get_global_i(data[2])
			if collectable_completed >= value then 
				menu.notify("Already unlocked","Success",3,0x008000)
				return
			end 
			if collectable_completed < value then 
				script.set_global_i(data[2], value)
				globals.TeleportPlayer(playerid,coords)
				if name ~= "shipwrecks" then 
					menu.notify("Unlocked all "..name.."\nIf the final item isn't here, please look for it","Success",3,0x008000)
				else
					menu.notify("Unlocked all "..name.."\nSearch for the final item (rotates daily)","Success",3,0x008000)
				end 
			end 
		break end 
	end 
end

function GetkdRatiowithKills(value)
	local KD_RATIO_DEATHS_HASH= gameplay.get_hash_key("MPPLY_DEATHS_PLAYER")
	local KD_RATIO_DEATHS = stats.stat_get_int(KD_RATIO_DEATHS_HASH,-1)
	local KD_RATIO = tonumber(value) / tonumber(KD_RATIO_DEATHS)
	local KD_RATIO = string.format("%.2f", KD_RATIO)
	return KD_RATIO
end 
function GetkdRatiowithDeaths(value)
	local KD_RATIO_KILLS_HASH= gameplay.get_hash_key("MPPLY_KILLS_PLAYERS")
	local KD_RATIO_KILLS = stats.stat_get_int(KD_RATIO_KILLS_HASH,-1)
	local KD_RATIO = tonumber(KD_RATIO_KILLS) / tonumber(value)
	local KD_RATIO = string.format("%.2f", KD_RATIO)
	return KD_RATIO
end 
local KD_VALUES = {
	-- {value,name,kills,deaths}
	{0,"1.34",103,77},
	{1,"1.50",105,70},
	{2,"4.20",319,76},
	{3,"6.69",281,42},
	{4,"69.69",906,13}
}

function SetKDPreset(value)
	for id, name in ipairs(KD_VALUES) do 
		if name[1] == tonumber(value) then 
			globals.stat_set_int("MPPLY_KILLS_PLAYERS",false,name[3])
			globals.stat_set_int("MPPLY_DEATHS_PLAYER",false,name[4])
			menu.notify("Set K/D to "..name[2],"Successful Operation",3,0x008000)
		break end 
	end 
end 

function SetKDKills(value)
	globals.stat_set_int("MPPLY_KILLS_PLAYERS",false,value)
	local PLAYER_CURRENT_KD = GetkdRatiowithKills(tonumber(value))
	menu.notify("Set MPPLY_KILLS_PLAYERS to: "..value.."\nCurrent K/D: "..PLAYER_CURRENT_KD,"Successful",3,0x008000)
end 
function SetKDDeaths(value)
	stat_set_int("MPPLY_DEATHS_PLAYERS",false,tonumber(value))
	local PLAYER_CURRENT_KD = GetkdRatiowithDeaths(tonumber(value))
	menu.notify("Set MPPLY_KILLS_PLAYERS to: "..value.."\nCurrent K/D: "..PLAYER_CURRENT_KD,"Successful",3,0x008000)
end 

local collectableTypes = {
	{0,"Action figures",2784215,99,v3(2487.128,3759.327,43.307)},
	{1,"Playing cards",2784216,53,v3(1991.764,3045.699,47.215)},
	{2,"Signal jammers",2784217,49,v3(-982.655,-2637.234,89.522)}
}

function UnlockCollectable(value,playerid)
	for id, data in ipairs(collectableTypes) do 
		if data[1] == value then 
			local collectable_completed = script.get_global_i(data[3])
			if collectable_completed >= data[4] then 
				menu.notify("Already unlocked","Success",3,0x008000)
				return
			end 
			script.set_global_i(data[3], data[4])
			globals.TeleportPlayer(playerid,data[5])
			menu.notify("Unlocked all "..data[2].."\nIf the final item isn't here, please look for it","Success",3,0x008000)
		break end 
	end 
end 

function getPlayerList()
	local playersl = {}
	for i = 0,31 do 
		if player.is_player_valid(i) then 
			local pName = player.get_player_name(i)
			local pSCID = player.get_player_scid(i)
			local pIP = requests.formatIP(player.get_player_ip(i))
			table.insert(playersl,{pName,i,pSCID,pIP})
		end
	end 
	return playersl
end 
return {
	unlockCollectables = unlockCollectables,
	GiveSelfBadsport = GiveSelfBadsport,
	RemoveSelfBadsport = RemoveSelfBadsport,
	GetkdRatiowithKills = GetkdRatiowithKills,
	GetkdRatiowithDeaths = GetkdRatiowithDeaths,
	SetKDPreset = SetKDPreset,
	SetKDKills = SetKDKills,
	SetKDDeaths = SetKDDeaths,
	UnlockCollectable = UnlockCollectable,
	getPlayerList = getPlayerList
}