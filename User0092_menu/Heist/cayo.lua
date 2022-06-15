local functions = require("User0092_menu/Lib/functions")
function SetBagSize(size)
	script.set_global_i(291540, size)
end 
local CAYO_PRESET_PANTHER = {
    {"PROSTITUTES_FREQUENTE", 100}, 
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5},
	{"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local CAYO_PRESET_DIAMOND = {
    {"PROSTITUTES_FREQUENTE", 100}, 
    {"H4CNF_BOLTCUT", 4424},
    {"H4CNF_UNIFORM", 5256},
    {"H4CNF_GRAPPEL", 5156},
    {"H4_MISSIONS", -1},
    {"H4CNF_WEAPONS", 4},
    {"H4CNF_TROJAN", 5},
	{"H4_PROGRESS", 126823},
    {"H4CNF_BS_GEN", 262143},
    {"H4CNF_BS_ENTR", 63},
    {"H4CNF_BS_ABIL", 63},
    {"H4CNF_WEP_DISRP", 3},
    {"H4CNF_ARM_DISRP", 3},
    {"H4CNF_HEL_DISRP", 3},
    {"H4CNF_APPROACH", -1}
}
local cayo_teleports = {
	{"escape island",v3(4107.352,-6012.722,-0.142)},
	{"primary target", v3(5007.247,-5755.247,15.484)},
	{"main loot", v3(5001.715,-5748.664,14.840)},
	{"loot room 1", v3(5027.525,-5734.574,17.866)},
	{"loot room 2",v3(5007.580,-5786.705,17.832)},
	{"loot room 3",v3(5079.875,-5756.972,15.830)},
	{"main gate",v3(4991.076,-5720.522,19.880)},
	{"office",v3(5009.136,-5752.514,28.845)},
	{"communications tower",v3(5268.138,-5427.602,65.597)},
	{"drainage tunnel",v3(5052.634,-5828.525,-9.245)}
}

function teleportPlayer(playerid,place)
	for id, name in ipairs(cayo_teleports) do 
		if name[1]:match(place) then 
			local ped = player.get_player_ped(playerid)
			coords = name[2]
			entity.set_entity_coords_no_offset(ped,coords)
		break end 
	end 
end 

local cayo_targets = {
	{"panther",5},
	{"diamond",3},
	{"madrazo",4},
	{"bonds",2},
	{"ruby",1},
	{"tequila",0}
}
function set_target(name)
	for id, target in ipairs(cayo_targets) do 
		if target[1]:match(name) then 
			local value = target[2]
			for i = 1, #CAYO_PRESET_PANTHER do
				functions.stat_set_int(CAYO_PRESET_PANTHER[i][1], true, CAYO_PRESET_PANTHER[i][2])
			end
			functions.stat_set_int("H4CNF_TARGET", true, value)
			menu.notify("Set primary target to "..target[1],"Successful",6,0x008000)
		break end 
	end 
end 

local CAYO_WEED_SECONDARY = {
    {"H4LOOT_WEED_I", 0},
	{"H4LOOT_WEED_I_SCOPED", 0},
	{"H4LOOT_WEED_C", 255},
	{"H4LOOT_WEED_C_SCOPED", 255},
    {"H4LOOT_WEED_V", 625908},
    {"H4LOOT_COKE_I", 0},
	{"H4LOOT_COKE_I_SCOPED", 0},
	{"H4LOOT_COKE_C", 0},
	{"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_CASH_I", 0},
	{"H4LOOT_CASH_I_SCOPED", 0},
	{"H4LOOT_CASH_C", 0},
	{"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_CASH_V", 0},
}
local CAYO_COKE_SECONDARY = {
    {"H4LOOT_COKE_I", 0},
	{"H4LOOT_COKE_I_SCOPED", 0},
	{"H4LOOT_COKE_C", 255},
	{"H4LOOT_COKE_C_SCOPED", 255},
    {"H4LOOT_COKE_V", 938863},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_CASH_V", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_WEED_I", 0},
	{"H4LOOT_WEED_I_SCOPED", 0},
	{"H4LOOT_WEED_C", 0},
	{"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_CASH_I", 0},
	{"H4LOOT_CASH_I_SCOPED", 0},
	{"H4LOOT_CASH_C", 0},
	{"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_CASH_V", 0}
}
local CAYO_GOLD_SECONDARY = {
    {"H4LOOT_GOLD_C", 255},
	{"H4LOOT_GOLD_C_SCOPED", 255},
	{"H4LOOT_GOLD_V", 1251817},
	{"H4LOOT_WEED_V", 0},
	{"H4LOOT_COKE_V", 0},
	{"H4LOOT_CASH_V", 0},
	{"H4LOOT_COKE_I", 0},
	{"H4LOOT_COKE_I_SCOPED", 0},
	{"H4LOOT_COKE_C", 0},
	{"H4LOOT_COKE_C_SCOPED", 0},
	{"H4LOOT_WEED_I", 0},
	{"H4LOOT_WEED_I_SCOPED", 0},
	{"H4LOOT_WEED_C", 0},
	{"H4LOOT_WEED_C_SCOPED", 0},
	{"H4LOOT_CASH_I", 0},
	{"H4LOOT_CASH_I_SCOPED", 0},
	{"H4LOOT_CASH_C", 0},
	{"H4LOOT_CASH_C_SCOPED", 0},
	{"H4LOOT_CASH_V", 0}
}
local CAYO_CASH_SECONDARY = {
    {"H4LOOT_CASH_I", 0},
	{"H4LOOT_CASH_I_SCOPED", 0},
	{"H4LOOT_CASH_C", 255},
	{"H4LOOT_CASH_C_SCOPED", 255},
    {"H4LOOT_CASH_V", 469431},
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_COKE_I", 0},
	{"H4LOOT_COKE_I_SCOPED", 0},
	{"H4LOOT_COKE_C", 0},
	{"H4LOOT_COKE_C_SCOPED", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_WEED_I", 0},
	{"H4LOOT_WEED_I_SCOPED", 0},
	{"H4LOOT_WEED_C", 0},
	{"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_V", 0},
    {"H4LOOT_GOLD_C", 0},
    {"H4LOOT_GOLD_C_SCOPED", 0},
    {"H4LOOT_GOLD_V", 0},
    {"H4LOOT_WEED_I", 0},
	{"H4LOOT_WEED_I_SCOPED", 0},
	{"H4LOOT_WEED_C", 0},
	{"H4LOOT_WEED_C_SCOPED", 0},
    {"H4LOOT_WEED_V", 0},
    {"H4LOOT_COKE_I", 0},
	{"H4LOOT_COKE_I_SCOPED", 0},
	{"H4LOOT_COKE_C", 0},
	{"H4LOOT_COKE_C_SCOPED", 0},
	{"H4LOOT_COKE_V", 0}
}
local secondary_targets = {
	{"gold",CAYO_GOLD_SECONDARY},
	{"weed",CAYO_WEED_SECONDARY},
	{"coke",CAYO_COKE_SECONDARY},
	{"cash",CAYO_CASH_SECONDARY}
}

function set_secondary_target(name)
	for id, target in ipairs(secondary_targets) do 
		if target[1]:match(name) then 
			local secondary_targets_preset = target[2]
			for id, data in ipairs(secondary_targets_preset) do 
				functions.stat_set_int(data[1],true,data[2])
			end 
			menu.notify("Set secondary target to "..name,"Success",4,0x008000)
		break end
	end 
end 
return {
	SetBagSize = SetBagSize,
	teleportPlayer = teleportPlayer,
	set_target = set_target,
	set_secondary_target = set_secondary_target
}