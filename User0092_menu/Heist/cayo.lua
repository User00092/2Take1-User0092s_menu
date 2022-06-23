local globals = require("User0092_menu/Lib/globals")

local CAYO_PRESET_PRIMARY= {
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
	{0,"Weed",CAYO_WEED_SECONDARY},
	{1,"Coke",CAYO_COKE_SECONDARY},
	{3,"Gold",CAYO_GOLD_SECONDARY},
	{4,"Cash",CAYO_CASH_SECONDARY}
}
local primary_targets = {
	{0,"Panther Statue",5},
	{1,"Pink Diamond",3},
	{2,"Madrazo Files",4},
	{3,"Bearer Bonds",2},
	{4,"Ruby Necklace",1},
	{5,"Tequila",0}
}
function SetPrimaryTarget(value)
	for id, data in ipairs(primary_targets) do 
		if data[1] == value then 
			for i = 1, #CAYO_PRESET_PRIMARY do
				globals.stat_set_int(CAYO_PRESET_PRIMARY[i][1], true, CAYO_PRESET_PRIMARY[i][2])
			end
			globals.stat_set_int("H4CNF_TARGET", true, data[3])
			menu.notify("Set primary target to "..data[2],"Successful",6,0x008000)
		break end 
	end 
end 
function SetSecondaryTarget(value)
	for id, data in ipairs(secondary_targets) do 
		if data[1] == value then 
			local secondary_targets_preset = data[3]
			for id, name in ipairs(secondary_targets_preset) do 
				globals.stat_set_int(name[1],true,name[2])
			end 
			menu.notify("Set secondary target to "..data[2],"Successful Operation",3,0x008000)
		break end 
	end 
end
local playerCuts = {
	{"Player 1",1974405},
	{"player 2",1974406},
	{"player 3",1974407},
	{"player 4",1974408}
}
function SetPlayerCut(playerNum,value)
	for id, data in ipairs(playerCuts) do 
		if data[1] == playerNum then 
			script.set_global_i(data[2],value)
			menu.notify("Set "..data[1].."'s cut to "..value.."%","Successful Operation",3,0x008000)
		break end 
	end 
end
local cayo_teleports = {
	{"escape island",v3(4107.352,-6012.722,-0.142)},
	{"primary target", v3(5007.247,-5755.247,15.484)},
	{"main loot", v3(5001.715,-5748.664,14.840)},
	{"loot room 1", v3(5027.525,-5734.574,17.866)},
	{"loot room 2",v3(5007.580,-5786.705,17.832)},
	{"loot room 3",v3(5079.875,-5756.972,15.830)},
	{"inside main gate",v3(4991.076,-5720.522,19.880)},
	{"office",v3(5009.136,-5752.514,28.845)},
	{"communications tower",v3(5268.138,-5427.602,65.597)},
	{"drainage tunnel",v3(5052.634,-5828.525,-9.245)}
}
function teleportPlayer(playerid,place)
	for id, teleport in ipairs(cayo_teleports) do 
		if teleport[1] == place then 
			globals.TeleportPlayer(playerid,teleport[2])
		break end
	end 
end
function RemoveDrainagePipe()
	local drainage = 2997331308
	local objects = object.get_all_objects()
	for id, ent in ipairs(objects) do
		local model = entity.get_entity_model_hash(ent)
		
		if model == drainage then
			entity.set_entity_as_mission_entity(ent, true, true)
			entity.delete_entity(ent)
		end
	end
	menu.notify("Drainage pipe grate removed","Successful Operation",3,0x008000)
end 

function SetBagSize(size)
	script.set_global_i(291540, size)
	menu.notify("Set bag size to "..size,"Successful Operation",3,0x008000)
end 

return {
	SetPrimaryTarget = SetPrimaryTarget,
	SetSecondaryTarget = SetSecondaryTarget,
	SetPlayerCut = SetPlayerCut,
	teleportPlayer = teleportPlayer,
	RemoveDrainagePipe = RemoveDrainagePipe,
	SetBagSize = SetBagSize
}