-- need help, please see "%appdata%\Roaming\PopstarDevs\2Take1Menu\scripts\User0092's menu\Help" for help
if users_menu_version then 
	menu.notify("User's menu is already loaded!", "Cancelled Initialization", 3, 0xff0000ff) 
	return
end
if not users_menu_version then 
	if menu.is_trusted_mode_enabled() then
		menu.notify("Successfully loaded", "Welcome to User0092's menu", 7, 0x008000)
			else
		if not menu.is_trusted_mode_enabled() then
		menu.notify("User0092's menu requires Trusted Mode to be activated", "Failed", 8, 0xff0000ff)
	end
		return end
end
users_menu_version = "0.0.1"
-- NOTE: This will be used later (hopefully)
-- local dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092's menu\\"
-- if not utils.dir_exists(dir) then 
	-- menu.notify("Directory not found.\nPlease go to the help folder", "Failed", 8, 0xff0000ff)
	-- return
-- end 

function GetkdRatiowithKills(value)
	local KD_RATIO_DEATHS_HASH= gameplay.get_hash_key("MPPLY_DEATHS_PLAYER")
	local KD_RATIO_DEATHS = stats.stat_get_int(KD_RATIO_DEATHS_HASH,-1)
	local KD_RATIO = tonumber(value) / tonumber(KD_RATIO_DEATHS)
	local KD_RATIO = string.format("%.2f", tostring(KD_RATIO))
	return KD_RATIO
end 
function GetkdRatiowithDeaths(value)
	local KD_RATIO_KILLS_HASH= gameplay.get_hash_key("MPPLY_KILLS_PLAYERS")
	local KD_RATIO_KILLS = stats.stat_get_int(KD_RATIO_KILLS_HASH,-1)
	local KD_RATIO = tonumber(KD_RATIO_KILLS) / tonumber(value)
	local KD_RATIO = string.format("%.2f", tostring(KD_RATIO))
	return KD_RATIO
end 

function stat_set_bool(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_bool(hash0, -1)
    if value0 ~= value then
        stats.stat_set_bool(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_bool(hash1, -1)
        if value1 ~= value then
            stats.stat_set_bool(hash1, value, save)
        end
    end
end
function stat_set_int(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_int(hash0, -1)
    if value0 ~= value then
        stats.stat_set_int(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_int(hash1, -1)
        if value1 ~= value then
            stats.stat_set_int(hash1, value, save)
        end
    end
end
function stat_set_float(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_float(hash0, -1)
    if value0 ~= value then
        stats.stat_set_float(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_int(hash1, -1)
        if value1 ~= value then
            stats.stat_set_float(hash1, value, save)
        end
    end
end

local USER_MENU = menu.add_feature("User0092's menu","parent",0, function()
end)


--[[
	Player 
]]
local PLAYER_OPTIONS = menu.add_feature("Local Player -- Yourself --","parent",USER_MENU.id)
-- badsport
local PLAYER_BADSPORT = menu.add_feature("Badsport","parent",PLAYER_OPTIONS.id)
local PLAYER_BADSPORT_ADD = menu.add_feature("Add Badsport","action",PLAYER_BADSPORT.id,function()
	stat_set_int("MPPLY_BADSPORT_MESSAGE", false,-1)
	stat_set_int("MPPLY_BECAME_BADSPORT_NUM", false, -1)
	stat_set_float("MPPLY_OVERALL_BADSPORT",false,60000)
	stat_set_bool("MPPLY_CHAR_IS_BADSPORT",false,true)
end)
local PLAYER_BADSPORT_REMOVE = menu.add_feature("Remove Badsport","action",PLAYER_BADSPORT.id,function()
	stat_set_int("MPPLY_BADSPORT_MESSAGE", false,0)
	stat_set_int("MPPLY_BECAME_BADSPORT_NUM", false, 0)
	stat_set_float("MPPLY_OVERALL_BADSPORT",false,0)
	stat_set_bool("MPPLY_CHAR_IS_BADSPORT",false,false)
end)
-- Kill death ratio
local PLAYER_KILL_DEATH_RATIO = menu.add_feature("K/D","parent",PLAYER_OPTIONS.id)
local PLAYER_KILL_DEATH_RATIO_PRESETS = menu.add_feature("K/D Presets","parent",PLAYER_KILL_DEATH_RATIO.id)
menu.add_feature("6.69","action",PLAYER_KILL_DEATH_RATIO_PRESETS.id, function()
	stat_set_int("MPPLY_KILLS_PLAYERS",false,281)
	stat_set_int("MPPLY_DEATHS_PLAYER",false,42)

end)

local PLAYER_KILL_DEATH_RATIO_KILLS = menu.add_feature("Player Kills","action_value_i",PLAYER_KILL_DEATH_RATIO.id,function(V)
	stat_set_int("MPPLY_KILLS_PLAYERS",false,V.value)
	local PLAYER_CURRENT_KD = GetkdRatiowithKills(V.value)
	menu.notify("Set MPPLY_KILLS_PLAYERS to: "..V.value.."\nCurrent K/D: "..PLAYER_CURRENT_KD,"Successful",3,0x008000)
end)
PLAYER_KILL_DEATH_RATIO_KILLS.min = 0
PLAYER_KILL_DEATH_RATIO_KILLS.max = 1000000
PLAYER_KILL_DEATH_RATIO_KILLS.mod = 1

local PLAYER_KILL_DEATH_RATIO_DEATHS = menu.add_feature("Player Deaths","action_value_i",PLAYER_KILL_DEATH_RATIO.id,function(V)
	stat_set_int("MPPLY_DEATHS_PLAYER",false,V.value)
	local PLAYER_CURRENT_KD = GetkdRatiowithDeaths(V.value)
	menu.notify("Set MPPLY_DEATHS_PLAYER to: "..V.value.."\nCurrent K/D: "..PLAYER_CURRENT_KD,"Successful",3,0x008000)
end)
PLAYER_KILL_DEATH_RATIO_DEATHS.min = 0
PLAYER_KILL_DEATH_RATIO_DEATHS.max = 1000000
PLAYER_KILL_DEATH_RATIO_DEATHS.mod = 1


-- give all weapons 

local WEAPON_OPTIONS = menu.add_feature("Weapon","parent",PLAYER_OPTIONS.id)
local WEAPON_OPTIONS_GIVE_WEAPONS = menu.add_feature("Give all weapons","action",WEAPON_OPTIONS.id, function()
	local weaponHash = weapon.get_all_weapon_hashes()
	local pedHash = player.get_player_ped(player.player_id())
	for id, hash in ipairs(weaponHash) do 
		weapon.give_delayed_weapon_to_ped(pedHash, hash, 0, false)
	end 
	menu.notify("Gave all weapons","Successful",3,0x008000)
end)

--[[
	Lobby
]]
local LOBBY_OPTIONS = menu.add_feature("Lobby","parent",USER_MENU.id)
-- lobby kindess
local LOBBY_KINDNESS_OPTIONS = menu.add_feature("Kindness","parent",LOBBY_OPTIONS.id)
-- actions 
-- give all weapons 
local LOBBY_KINDESS_WEAPON_GIVE_ALL = menu.add_feature("Give all weapons -- might crash game -- ","action",LOBBY_KINDNESS_OPTIONS.id, function()
	local weaponHash = weapon.get_all_weapon_hashes()
	local players = player.player_count() 
	for i = 0,players do 
		if player.is_player_valid(i) then 
			local pedHash = player.get_player_ped(i)
			for id, hash in ipairs(weaponHash) do 
				if not weapon.has_ped_got_weapon(pedHash,hash) then 
					weapon.give_delayed_weapon_to_ped(pedHash, hash, 12, true)
				end
			end 
		end 
	system.yeild(0)
	end 
end)
-- toggles


--[[ 
	Friends
]]

--[[
	Heist Controller
]]
local mission_control = menu.add_feature("Heist controller", "parent", USER_MENU.id)
--[[ 
	CAYO MAIN
]]

local CAYO_HEIST = menu.add_feature("Cayo Perico","parent",mission_control.id)

-- cayo utils
local CAYO_UTILS = menu.add_feature("Cayo Utils","parent",CAYO_HEIST.id)
local CAYO_SKIP_DRAIN = menu.add_feature("Delete Drainage Pipe Grate","action",CAYO_UTILS.id, function()
	menu.notify("Drainage pipe grate removed","Successful",6,0x008000)
	local drainage = 2997331308
	local objects = object.get_all_objects()
	for id, ent in ipairs(objects) do
		local model = entity.get_entity_model_hash(ent)
		
		if model == drainage then
			entity.set_entity_as_mission_entity(ent, true, true)
			entity.delete_entity(ent)
		end
	end
end)
local CAYO_TELEPORT_ISLAND_ESCAPE = menu.add_feature("Escape Island","action",CAYO_UTILS.id, function()
	local players = player.player_count()
	local available = true 
	for index = 0,players do 
		if player.is_player_valid(index) then 
			local inCar = player.is_player_in_any_vehicle(index)
			if not inCar then 
				available = false 
			end 
		end
	end
	if not available and players > 1 then 
		menu.notify("Make sure all players are in the same vehicle \nto make this faster.","Notice",8,0xffff00)
	else
		menu.notify("Swim out further until you get a black screen.","Notice",8,0xffff00)
		local local_ped = player.get_player_ped(player.player_id())
		entity.set_entity_coords_no_offset(local_ped,v3(4107.352,-6012.722,-0.142))
	end
end)

-- Cayo teleports
local CAYO_TELEPORT= menu.add_feature("Cayo Teleports","parent",CAYO_HEIST.id)
local CAYO_TELEPORT_INSIDE= menu.add_feature("Compound Teleports","parent",CAYO_TELEPORT.id)
-- inside compound loot rooms
local CAYO_TELEPORT_INSIDE_LOOT_ROOMS = menu.add_feature("Loot rooms","parent",CAYO_TELEPORT_INSIDE.id)
local CAYO_TELEPORT_INSIDE_TARGET = menu.add_feature("Primary Target","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5007.247,-5755.247,15.484))
end)

local CAYO_TELEPORT_INSIDE_MAIN = menu.add_feature("Main loot","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5001.715,-5748.664,14.840))
end)

local CAYO_TELEPORT_INSIDE_ROOM_ONE = menu.add_feature("Loot Room 1","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5027.525,-5734.574,17.866))
end)

local CAYO_TELEPORT_INSIDE_ROOM_TWO = menu.add_feature("Loot Room 2","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5007.580,-5786.705,17.832))
end)
local CAYO_TELEPORT_INSIDE_ROOM_THREE = menu.add_feature("Loot Room 3","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5079.875,-5756.972,15.830))
end)
-- inside compound POI
local CAYO_TELEPORT_INSIDE_POI = menu.add_feature("Point of interest","parent",CAYO_TELEPORT_INSIDE.id)
local CAYO_TELEPORT_INSIDE_MAIN_GATE =  menu.add_feature("Main Gate","action",CAYO_TELEPORT_INSIDE_POI.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(4991.076,-5720.522,19.880))
end)
local CAYO_TELEPORT_INSIDE_OFFICE = menu.add_feature("Office","action",CAYO_TELEPORT_INSIDE_POI.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5009.136,-5752.514,28.845))
end)

-- island teleports
local CAYO_TELEPORT_ISLAND = menu.add_feature("Island Teleports","parent",CAYO_TELEPORT.id)

local CAYO_TELEPORT_ISLAND_COM_TOWER = menu.add_feature("Communications Tower","action",CAYO_TELEPORT_ISLAND.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5268.138,-5427.602,65.597))
end)
local CAYO_TELEPORT_ISLAND_DRAINAGE = menu.add_feature("Drainage tunnel","action",CAYO_TELEPORT_ISLAND.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	entity.set_entity_coords_no_offset(local_ped,v3(5052.634,-5828.525,-9.245))
end)
local CAYO_TELEPORT_ISLAND_NOTE = menu.add_feature("--- More comming soon ---","action",CAYO_TELEPORT_ISLAND.id)


-- cayo Targets 
local CAYO_PRESETS_TARGET = menu.add_feature("Cayo targets","parent",CAYO_HEIST.id)

-- Primary target 
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
local CAYO_PRIM_TARGET_SELECT = menu.add_feature("Primary target","parent", CAYO_PRESETS_TARGET.id)
local CAYO_PRIM_TARGET_PANTHER = menu.add_feature("Panther Statue -- 1.9 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PRESET_PANTHER do
        stat_set_int(CAYO_PRESET_PANTHER[i][1], true, CAYO_PRESET_PANTHER[i][2])
    end
	stat_set_int("H4CNF_TARGET", true, 5)
	menu.notify("Set primary target to Panther Statue","Successful",6,0x008000)
end)

local CAYO_PRIM_TARGET_DIAMOND = menu.add_feature("Pink Diamond -- 1.3 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PRESET_DIAMOND do
        stat_set_int(CAYO_PRESET_DIAMOND[i][1], true, CAYO_PRESET_DIAMOND[i][2])
    end     
	stat_set_int("H4CNF_TARGET", true, 3)
	menu.notify("Set primary target to Pink Diamond","Successful",6,0x008000)
end)
local CAYO_PRIM_TARGET_MAD = menu.add_feature("Madrazo Files -- 1.1 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PRESET_DIAMOND do
        stat_set_int(CAYO_PRESET_DIAMOND[i][1], true, CAYO_PRESET_DIAMOND[i][2])
    end     
	stat_set_int("H4CNF_TARGET", true, 4)
	menu.notify("Set primary target to Madrazo Files","Successful",6,0x008000)
end)
local CAYO_PRIM_TARGET_BONDS= menu.add_feature("Bearer Bonds -- 1.1 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PRESET_DIAMOND do
        stat_set_int(CAYO_PRESET_DIAMOND[i][1], true, CAYO_PRESET_DIAMOND[i][2])
    end     
	stat_set_int("H4CNF_TARGET", true, 2)
	menu.notify("Set primary target to Bearer Bonds","Successful",6,0x008000)
end)
local CAYO_PRIM_TARGET_NECKLACE= menu.add_feature("Ruby Necklace -- 1 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PRESET_DIAMOND do
        stat_set_int(CAYO_PRESET_DIAMOND[i][1], true, CAYO_PRESET_DIAMOND[i][2])
    end     
	stat_set_int("H4CNF_TARGET", true, 1)
	menu.notify("Set primary target to Ruby Necklace","Successful",6,0x008000)
end)
local CAYO_PRIM_TARGET_TEQUILA= menu.add_feature("Sinsimito Tequila -- 900k --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PRESET_DIAMOND do
        stat_set_int(CAYO_PRESET_DIAMOND[i][1], true, CAYO_PRESET_DIAMOND[i][2])
    end     
	stat_set_int("H4CNF_TARGET", true, 0)
	menu.notify("Set primary target to Sinsimito Tequila","Successful",6,0x008000)
end)
-- secondary target
local CAYO_WEED_SECONDARY = {
    {"H4LOOT_WEED_I", 8128},
    {"H4LOOT_WEED_I_SCOPED", 8128},
    {"H4LOOT_WEED_C", 65},
    {"H4LOOT_WEED_C_SCOPED", 65},
    {"H4LOOT_WEED_V", 571818} 
}
local CAYO_COKE_SECONDARY = {
    {"H4LOOT_COKE_I", 16769024},
    {"H4LOOT_COKE_I_SCOPED", 16769024},
    {"H4LOOT_COKE_C", 22},
    {"H4LOOT_COKE_C_SCOPED", 22},
    {"H4LOOT_COKE_V", 714772}
}
local CAYO_GOLD_SECONDARY = {
    {"H4LOOT_GOLD_I", 0},
    {"H4LOOT_GOLD_I_SCOPED", 0},
    {"H4LOOT_GOLD_C", 168},
    {"H4LOOT_GOLD_C_SCOPED", 168},
    {"H4LOOT_GOLD_V", 953029}
}
local CAYO_CASH_SECONDARY = {
    {"H4LOOT_CASH_I", 63},
    {"H4LOOT_CASH_I_SCOPED", 63},
    {"H4LOOT_CASH_C", 0},
    {"H4LOOT_CASH_C_SCOPED", 0},
    {"H4LOOT_CASH_V", 357386}
}
local CAYO_PAINT_SECONDARY = {
    {"H4LOOT_PAINT", 127},
    {"H4LOOT_PAINT_SCOPED", 127},
    {"H4LOOT_PAINT_V", 714772}
}
local CAYO_SEC_TARGET_SELECT = menu.add_feature("Secondary target","parent", CAYO_PRESETS_TARGET.id)
local CAYO_SEC_TARGET_WEED = menu.add_feature("Weed","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	for i = 1, #CAYO_WEED_SECONDARY do
        stat_set_int(CAYO_WEED_SECONDARY[i][1], true, CAYO_WEED_SECONDARY[i][2])
    end
	menu.notify("Unlocked weed","Successful",6,0x008000)
end)
local CAYO_SEC_TARGET_COKE = menu.add_feature("Coke","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	for i = 1, #CAYO_COKE_SECONDARY do
        stat_set_int(CAYO_COKE_SECONDARY[i][1], true, CAYO_COKE_SECONDARY[i][2])
    end   
	menu.notify("Unlocked coke","Successful",6,0x008000)
end)
local CAYO_SEC_TARGET_GOLD = menu.add_feature("Gold","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	for i = 1, #CAYO_GOLD_SECONDARY do
        stat_set_int(CAYO_GOLD_SECONDARY[i][1], true, CAYO_GOLD_SECONDARY[i][2])
    end
	menu.notify("Unlocked gold","Successful",6,0x008000)
end)
local CAYO_SEC_TARGET_CASH = menu.add_feature("Cash","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	for i = 1, #CAYO_CASH_SECONDARY do
        stat_set_int(CAYO_CASH_SECONDARY[i][1], true, CAYO_CASH_SECONDARY[i][2])
    end
	menu.notify("Unlocked cash","Successful",6,0x008000)
end)
local CAYO_SEC_TARGET_PAINT= menu.add_feature("Paint","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	for i = 1, #CAYO_PAINT_SECONDARY do
        stat_set_int(CAYO_PAINT_SECONDARY[i][1], true, CAYO_PAINT_SECONDARY[i][2])
    end
	menu.notify("Unlocked Paintings","Successful",6,0x008000)
end)




--cayo bag size 
local PERICO_BAG_SIZE = menu.add_feature("Cayo Bag size","parent",CAYO_HEIST.id)

local current_bag_size = script.get_global_i(291540)
local CAYO_BAG_SIZE_CURRENT = menu.add_feature("Current bag size: "..current_bag_size,"action",PERICO_BAG_SIZE.id)
local CAYO_BAG_SIZE_SEPERATOR = menu.add_feature("----Select Size----","action",PERICO_BAG_SIZE.id)
local CAYO_BAG_SIZE_TEN_K = menu.add_feature("10K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 10000)
end)
local CAYO_BAG_SIZE_NINE_K = menu.add_feature("9K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 9000)
end)
local CAYO_BAG_SIZE_EIGHT_K = menu.add_feature("8K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 8000)
end)
local CAYO_BAG_SIZE_SEVEN_K = menu.add_feature("7K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 7000)
end)
local CAYO_BAG_SIZE_SIX_K = menu.add_feature("6K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 6000)
end)
local CAYO_BAG_SIZE_FIVE_K = menu.add_feature("5K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 5000)
end)
local CAYO_BAG_SIZE_FOUR_K = menu.add_feature("4K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 4000)
end)
local CAYO_BAG_SIZE_THREE_K = menu.add_feature("3K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 3000)
end)
local CAYO_BAG_SIZE_TWO_K = menu.add_feature("2K","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 2000)
end)
local CAYO_BAG_SIZE_DEFAULT = menu.add_feature("Default","action",PERICO_BAG_SIZE.id,function()
	script.set_global_i(291540, 1800)
end)

-- cayo cuts 
local PERICO_HEIST_CUTS = menu.add_feature("Cayo Cuts", "parent", CAYO_HEIST.id)

-- cayo cut presets 
local CAYO_MAX_PRESETS = menu.add_feature("Presets","parent",PERICO_HEIST_CUTS.id)
local CAYO_TWO = menu.add_feature("Two players","action",CAYO_MAX_PRESETS.id,function()
	menu.notify("Cut Editor successful 100%", "Cut Editor", 7, 0x50783CF0)
	script.set_global_i(1974405, 100)
	script.set_global_i(1974406, 100)
end)
local CAYO_THREE = menu.add_feature("Three players","action",CAYO_MAX_PRESETS.id,function()
	menu.notify("Cut Editor successful 100%", "Cut Editor", 7, 0x50783CF0)
	script.set_global_i(1974405, 100)
	script.set_global_i(1974406, 100)
	script.set_global_i(1974407, 100)
end)
local CAYO_FOUR = menu.add_feature("Four players","action",CAYO_MAX_PRESETS.id,function()
	menu.notify("Cut Editor successful 100%", "Cut Editor", 7, 0x50783CF0)
	script.set_global_i(1974405, 100)
	script.set_global_i(1974406, 100)
	script.set_global_i(1974407, 100)
	script.set_global_i(1974408, 100)
end)

-- cayo manual
-- cayo player 1
local CAYO_PLAYER_ONE = menu.add_feature("Player one cut","parent",PERICO_HEIST_CUTS.id)
local CAYO_PLAYER_ONE_CUT_CUSTOM = menu.add_feature("Custom -- up to 150% --","action_value_i",CAYO_PLAYER_ONE.id,function(V)
	script.set_global_i(1974405, tonumber(V.value))
end)
CAYO_PLAYER_ONE_CUT_CUSTOM.min = 0
CAYO_PLAYER_ONE_CUT_CUSTOM.max = 150 
CAYO_PLAYER_ONE_CUT_CUSTOM.mod = 10
local CAYO_PLAYER_ONE_CUT_MAX = menu.add_feature("100%","action",CAYO_PLAYER_ONE.id,function()
	script.set_global_i(1974405, 100)
end)
local CAYO_PLAYER_ONE_CUT_SEVEN = menu.add_feature("75%","action",CAYO_PLAYER_ONE.id,function()
	script.set_global_i(1974405, 75)
end)
local CAYO_PLAYER_ONE_CUT_Half = menu.add_feature("50%","action",CAYO_PLAYER_ONE.id,function()
	script.set_global_i(1974405, 50)
end)
local CAYO_PLAYER_ONE_CUT_TWENTY = menu.add_feature("25%","action",CAYO_PLAYER_ONE.id,function()
	script.set_global_i(1974405, 25)
end)

-- cayo player 2 
local CAYO_PLAYER_TWO = menu.add_feature("Player two cut","parent",PERICO_HEIST_CUTS.id)
local CAYO_PLAYER_TWO_CUT_CUSTOM = menu.add_feature("Custom -- up to 150% --","action_value_i",CAYO_PLAYER_TWO.id,function(V)
	script.set_global_i(1974406, tonumber(V.value))
end)
CAYO_PLAYER_TWO_CUT_CUSTOM.min = 0
CAYO_PLAYER_TWO_CUT_CUSTOM.max = 150 
CAYO_PLAYER_TWO_CUT_CUSTOM.mod = 10
local CAYO_PLAYER_TWO_CUT_MAX = menu.add_feature("100%","action",CAYO_PLAYER_TWO.id,function()
	script.set_global_i(1974406, 100)
end)
local CAYO_PLAYER_TWO_CUT_SEVEN = menu.add_feature("75%","action",CAYO_PLAYER_TWO.id,function()
	script.set_global_i(1974406, 75)
end)
local CAYO_PLAYER_TWO_CUT_Half = menu.add_feature("50%","action",CAYO_PLAYER_TWO.id,function()
	script.set_global_i(1974406, 50)
end)
local CAYO_PLAYER_TWO_CUT_TWENTY = menu.add_feature("25%","action",CAYO_PLAYER_TWO.id,function()
	script.set_global_i(1974406, 25)
end)

-- cayo player 3
local CAYO_PLAYER_THREE = menu.add_feature("Player three cut","parent",PERICO_HEIST_CUTS.id)
local CAYO_PLAYER_THREE_CUT_CUSTOM = menu.add_feature("Custom -- up to 150% --","action_value_i",CAYO_PLAYER_THREE.id,function(V)
	script.set_global_i(1974407, tonumber(V.value))
end)
CAYO_PLAYER_THREE_CUT_CUSTOM.min = 0
CAYO_PLAYER_THREE_CUT_CUSTOM.max = 150 
CAYO_PLAYER_THREE_CUT_CUSTOM.mod = 10
local CAYO_PLAYER_THREE_CUT_MAX = menu.add_feature("100%","action",CAYO_PLAYER_THREE.id,function()
	script.set_global_i(1974407, 100)
end)
local CAYO_PLAYER_THREE_CUT_SEVEN = menu.add_feature("75%","action",CAYO_PLAYER_THREE.id,function()
	script.set_global_i(1974407, 75)
end)
local CAYO_PLAYER_THREE_CUT_Half = menu.add_feature("50%","action",CAYO_PLAYER_THREE.id,function()
	script.set_global_i(1974407, 50)
end)
local CAYO_PLAYER_THREE_CUT_TWENTY = menu.add_feature("25%","action",CAYO_PLAYER_THREE.id,function()
	script.set_global_i(1974407, 25)
end)

-- cayo player 4
local CAYO_PLAYER_FOUR = menu.add_feature("Player four cut","parent",PERICO_HEIST_CUTS.id)
local CAYO_PLAYER_FOUR_CUT_CUSTOM = menu.add_feature("Custom -- up to 150% --","action_value_i",CAYO_PLAYER_FOUR.id,function(V)
	script.set_global_i(1974408, tonumber(V.value))
end)
CAYO_PLAYER_FOUR_CUT_CUSTOM.min = 0
CAYO_PLAYER_FOUR_CUT_CUSTOM.max = 150 
CAYO_PLAYER_FOUR_CUT_CUSTOM.mod = 10
local CAYO_PLAYER_FOUR_CUT_CUSTOM = menu.add_feature("100%","action",CAYO_PLAYER_FOUR.id,function()
	script.set_global_i(1974408, 100)
end)
local CAYO_PLAYER_FOUR_CUT_SEVEN = menu.add_feature("75%","action",CAYO_PLAYER_FOUR.id,function()
	script.set_global_i(1974408, 75)
end)
local CAYO_PLAYER_FOUR_CUT_Half = menu.add_feature("50%","action",CAYO_PLAYER_FOUR.id,function()
	script.set_global_i(1974408, 50)
end)
local CAYO_PLAYER_FOUR_CUT_TWENTY = menu.add_feature("25%","action",CAYO_PLAYER_FOUR.id,function()
	script.set_global_i(1974408, 25)
end)


--[[
	CASINO MAIN
]]
local CASINO_HEIST = menu.add_feature("Casino","parent", mission_control.id)
--casino prep skip
-- board one
-- target 
local CASINO_HEIST_PREP_SKIP = menu.add_feature("Skip prep","parent",CASINO_HEIST.id)
local CASINO_HEIST_PREP_SKIP_TARGET = menu.add_feature("Select Target","parent",CASINO_HEIST_PREP_SKIP.id)
menu.add_feature("Diamond","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	stat_set_int("H3OPT_TARGET",true,3)
end)
menu.add_feature("Art","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	stat_set_int("H3OPT_TARGET",true,2)
end)
menu.add_feature("Gold","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	stat_set_int("H3OPT_TARGET",true,1)
end)
menu.add_feature("Cash","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	stat_set_int("H3OPT_TARGET",true,0)
end)

-- approach
local CASINO_HEIST_PREP_SKIP_APPROACH = menu.add_feature("Select Approach","parent",CASINO_HEIST_PREP_SKIP.id)
-- easy approach
local CASINO_HEIST_PREP_SKIP_APPROACH_EASY = menu.add_feature("Easy Approach","parent",CASINO_HEIST_PREP_SKIP_APPROACH.id)
menu.add_feature("Aggressive","action",CASINO_HEIST_PREP_SKIP_APPROACH_EASY.id, function()
	stat_set_int("H3_LAST_APPROACH",true,1)
	stat_set_int("H3_HARD_APPROACH",true,2)
	stat_set_int("H3OPT_APPROACH",true,3)
end)
menu.add_feature("Big Con","action",CASINO_HEIST_PREP_SKIP_APPROACH_EASY.id, function()
	stat_set_int("H3_LAST_APPROACH",true,3)
	stat_set_int("H3_HARD_APPROACH",true,1)
	stat_set_int("H3OPT_APPROACH",true,2)
end)
menu.add_feature("Sneaky","action",CASINO_HEIST_PREP_SKIP_APPROACH_EASY.id, function()
	stat_set_int("H3_LAST_APPROACH",true,3)
	stat_set_int("H3_HARD_APPROACH",true,2)
	stat_set_int("H3OPT_APPROACH",true,1)
end)
-- hard approach
local CASINO_HEIST_PREP_SKIP_APPROACH_HARD = menu.add_feature("Hard Approach","parent",CASINO_HEIST_PREP_SKIP_APPROACH.id)
menu.add_feature("Aggressive","action",CASINO_HEIST_PREP_SKIP_APPROACH_HARD.id, function()
	stat_set_int("H3_LAST_APPROACH",true,1)
	stat_set_int("H3_HARD_APPROACH",true,3)
	stat_set_int("H3OPT_APPROACH",true,3)
end)
menu.add_feature("Big Con","action",CASINO_HEIST_PREP_SKIP_APPROACH_HARD.id, function()
	stat_set_int("H3_LAST_APPROACH",true,3)
	stat_set_int("H3_HARD_APPROACH",true,2)
	stat_set_int("H3OPT_APPROACH",true,2)
end)
menu.add_feature("Sneaky","action",CASINO_HEIST_PREP_SKIP_APPROACH_HARD.id, function()
	stat_set_int("H3_LAST_APPROACH",true,3)
	stat_set_int("H3_HARD_APPROACH",true,1)
	stat_set_int("H3OPT_APPROACH",true,1)
end)

-- complete board one 
menu.add_feature("Complete Board One","action",CASINO_HEIST_PREP_SKIP.id,function()
	stat_set_int("H3OPT_BITSET1",true,-1)
end)

-- board two 
-- hacker 
local CASINO_HEIST_PREP_SKIP_HACKER = menu.add_feature("Select hacker","parent",CASINO_HEIST_PREP_SKIP.id)
menu.add_feature("Avi Schwartzman -- 10% | Expert --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	stat_set_int("H3OPT_CREWHACKER",true,4)
end)
menu.add_feature("Page Harris -- 9% | Expert --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	stat_set_int("H3OPT_CREWHACKER",true,5)
end)
menu.add_feature("Christian Feltz -- 7% | Good --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	stat_set_int("H3OPT_CREWHACKER",true,2)
end)
menu.add_feature("Yohan Blair -- 5% | Good --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	stat_set_int("H3OPT_CREWHACKER",true,3)
end)
menu.add_feature("Rickie Lukens -- 3% | Poor --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	stat_set_int("H3OPT_CREWHACKER",true,1)
end)
-- complete board two 
local CASINO_BOARD_TWO_PRESETS = {
	{"H3OPT_DISRUPTSHIP", 3},
	{"H3OPT_KEYLEVELS", 2},
	{"H3OPT_CREWWEAP", 3},
	{"H3OPT_CREWDRIVER", 1},
	{"H3OPT_VEHS", 3},
	{"H3OPT_WEAPS", 0},
	{"H3OPT_BITSET0", -129},
	{"H3OPT_MASKS",4}
}
menu.add_feature("-- Complete Board two --","action",CASINO_HEIST_PREP_SKIP.id, function()
	for i = 1, #CASINO_BOARD_TWO_PRESETS do
		stat_set_int(CASINO_BOARD_TWO_PRESETS[i][1], true, CASINO_BOARD_TWO_PRESETS[i][2])
	end
end)
-- gun man 
-- local CASINO_HEIST_PREP_SKIP_GUNMAN = menu.add_feature("Select Gunman","parent",CASINO_HEIST_PREP_SKIP.id)
-- menu.add_feature("Chester McCoy -- 10% | Expert --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- stat_set_int("H3OPT_CREWWEAP",true,4)
-- end)
-- menu.add_feature("Gustavo Mota -- 9% | Expert --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id,function()
	-- stat_set_int("H3OPT_CREWWEAP",true,2)
-- end)
-- menu.add_feature("Patrick McReary -- 9% | Good --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- stat_set_int("H3OPT_CREWWEAP",true,5)
-- end)
-- menu.add_feature("Charlie Reed -- 7% | Good --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- stat_set_int("H3OPT_CREWWEAP",true,3)
-- end)
-- menu.add_feature("Karl Abolaji -- 5% | Poor --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- stat_set_int("H3OPT_CREWWEAP",true,1)
-- end)
-- casino cuts 
local CASINO_HEIST_CUTS = menu.add_feature("Casino Cuts","parent", CASINO_HEIST.id)

-- Casino cut Presets
local CASINO_PRESETS_CUT = menu.add_feature("Presets","parent",CASINO_HEIST_CUTS.id)
local CASINO_PRESET_TWO = menu.add_feature("Two players","action",CASINO_PRESETS_CUT.id,function()
	script.set_global_i(1969065, 100)
	script.set_global_i(1969066, 100)
end)
local CASINO_PRESET_THREE = menu.add_feature("Three players","action",CASINO_PRESETS_CUT.id,function()
	script.set_global_i(1969065, 100)
	script.set_global_i(1969066, 100)
	script.set_global_i(1969067, 100)
end)
local CASINO_PRESET_FOUR = menu.add_feature("Four players","action",CASINO_PRESETS_CUT.id,function()
	script.set_global_i(1969065, 100)
	script.set_global_i(1969066, 100)
	script.set_global_i(1969067, 100)
	script.set_global_i(1969068, 100)
end)



-- Casino cut manual 
-- player 1
local CASINO_PLAYER_ONE = menu.add_feature("Player one cut","parent",CASINO_HEIST_CUTS.id)
local CASINO_PLAYER_ONE_MAX = menu.add_feature("100%","action",CASINO_PLAYER_ONE.id,function()
	script.set_global_i(1969065, 100)
end)
local CASINO_PLAYER_ONE_SEVEN = menu.add_feature("75%","action",CASINO_PLAYER_ONE.id,function()
	script.set_global_i(1969065, 75)
end)
local CASINO_PLAYER_ONE_HALF = menu.add_feature("50%","action",CASINO_PLAYER_ONE.id,function()
	script.set_global_i(1969065, 50)
end)
local CASINO_PLAYER_ONE_TWENTY = menu.add_feature("25%","action",CASINO_PLAYER_ONE.id,function()
	script.set_global_i(1969065, 25)
end)

-- player 2 
local CASINO_PLAYER_TWO = menu.add_feature("Player two cut","parent",CASINO_HEIST_CUTS.id)
local CASINO_PLAYER_TWO_MAX = menu.add_feature("100%","action",CASINO_PLAYER_TWO.id,function()
	script.set_global_i(1969066, 100)
end)
local CASINO_PLAYER_TWO_SEVEN = menu.add_feature("75%","action",CASINO_PLAYER_TWO.id,function()
	script.set_global_i(1969066, 75)
end)
local CASINO_PLAYER_TWO_HALF = menu.add_feature("50%","action",CASINO_PLAYER_TWO.id,function()
	script.set_global_i(1969066, 50)
end)
local CASINO_PLAYER_TWO_TWENTY = menu.add_feature("25%","action",CASINO_PLAYER_TWO.id,function()
	script.set_global_i(1969066, 25)
end)

-- player 3
local CASINO_PLAYER_THREE = menu.add_feature("Player three cut","parent",CASINO_HEIST_CUTS.id)
local CASINO_PLAYER_THREE_MAX = menu.add_feature("100%","action",CASINO_PLAYER_THREE.id,function()
	script.set_global_i(1969067, 100)
end)
local CASINO_PLAYER_THREE_SEVEN = menu.add_feature("75%","action",CASINO_PLAYER_THREE.id,function()
	script.set_global_i(1969067, 75)
end)
local CASINO_PLAYER_THREE_HALF = menu.add_feature("50%","action",CASINO_PLAYER_THREE.id,function()
	script.set_global_i(1969067, 50)
end)
local CASINO_PLAYER_THREE_TWENTY = menu.add_feature("25%","action",CASINO_PLAYER_THREE.id,function()
	script.set_global_i(1969067, 25)
end)

-- player 4
local CASINO_PLAYER_FOUR = menu.add_feature("Player four cut","parent",CASINO_HEIST_CUTS.id)
local CASINO_PLAYER_FOUR_MAX = menu.add_feature("100%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969066, 100)
end)
local CASINO_PLAYER_FOUR_SEVEN = menu.add_feature("75%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969066, 75)
end)
local CASINO_PLAYER_FOUR_HALF = menu.add_feature("50%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969066, 50)
end)
local CASINO_PLAYER_FOUR_TWENTY = menu.add_feature("25%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969066, 25)
end)

--[[
	Doomsday main
]]
local DOOMSDAY_HEIST = menu.add_feature("Doomsday","parent",mission_control.id)

-- doomsday heist 
local DOOMSDAY_HEIST_SELECT = menu.add_feature("Select Act","parent",DOOMSDAY_HEIST.id)
menu.add_feature("Act 1","action",DOOMSDAY_HEIST_SELECT.id, function()
	stat_set_int("GANGOPS_FLOW_MISSION_PROG",true,503)
	stat_set_int("GANGOPS_HEIST_STATUS",true,229383)
	stat_set_int("GANGOPS_FLOW_NOTIFICATIONS",true,1557)
end)
menu.add_feature("Act 2","action",DOOMSDAY_HEIST_SELECT.id, function()
	stat_set_int("GANGOPS_FLOW_MISSION_PROG",true,240)
	stat_set_int("GANGOPS_HEIST_STATUS",true,229378)
	stat_set_int("GANGOPS_FLOW_NOTIFICATIONS",true,1557)
end)
menu.add_feature("Act 3","action",DOOMSDAY_HEIST_SELECT.id, function()
	stat_set_int("GANGOPS_FLOW_MISSION_PROG",true,16368)
	stat_set_int("GANGOPS_HEIST_STATUS",true,229380)
	stat_set_int("GANGOPS_FLOW_NOTIFICATIONS",true,1557)
end)

-- doomsday cuts
local DOOMSDAY_HEIST_CUTS = menu.add_feature("Doomsday Cuts", "parent", DOOMSDAY_HEIST.id)
-- cut presets
local DOOMSDAY_HEIST_CUTS_PRESET = menu.add_feature("Presets","parent",DOOMSDAY_HEIST_CUTS.id)
local DOOMSDAY_HEIST_CUTS_PRESET_TWO = menu.add_feature("Two players","action",DOOMSDAY_HEIST_CUTS_PRESET.id, function()
	script.set_global_i(1963626, 100)
	script.set_global_i(1963627, 100)
end)
local DOOMSDAY_HEIST_CUTS_PRESET_THREE = menu.add_feature("Three players","action",DOOMSDAY_HEIST_CUTS_PRESET.id, function()
	script.set_global_i(1963626, 100)
	script.set_global_i(1963627, 100)
	script.set_global_i(1963628, 100)
end)
local DOOMSDAY_HEIST_CUTS_PRESET_FOUR = menu.add_feature("Four players","action",DOOMSDAY_HEIST_CUTS_PRESET.id, function()
	script.set_global_i(1963626, 100)
	script.set_global_i(1963627, 100)
	script.set_global_i(1963628, 100)
	script.set_global_i(1963629, 100)
end)

-- Player 1 
local DOOMSDAY_HEIST_CUTS_ONE = menu.add_feature("Player one","parent",DOOMSDAY_HEIST_CUTS.id)
local DOOMSDAY_HEIST_CUTS_ONE_MAX = menu.add_feature("100%","action",DOOMSDAY_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1963626, 100)
end)
local DOOMSDAY_HEIST_CUTS_ONE_SEVEN = menu.add_feature("75%","action",DOOMSDAY_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1963626, 75)
end)
local DOOMSDAY_HEIST_CUTS_ONE_HALF = menu.add_feature("50%","action",DOOMSDAY_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1963626, 50)
end)
local DOOMSDAY_HEIST_CUTS_ONE_TWENTY = menu.add_feature("25%","action",DOOMSDAY_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1963626, 25)
end)
-- Player 2
local DOOMSDAY_HEIST_CUTS_TWO = menu.add_feature("Player two","parent",DOOMSDAY_HEIST_CUTS.id)
local DOOMSDAY_HEIST_CUTS_TWO_MAX = menu.add_feature("100%","action",DOOMSDAY_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1963627, 100)
end)
local DOOMSDAY_HEIST_CUTS_TWO_SEVEN = menu.add_feature("75%","action",DOOMSDAY_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1963627, 75)
end)
local DOOMSDAY_HEIST_CUTS_TWO_HALF = menu.add_feature("50%","action",DOOMSDAY_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1963627, 50)
end)
local DOOMSDAY_HEIST_CUTS_TWO_TWENTY = menu.add_feature("25%","action",DOOMSDAY_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1963627, 25)
end)
-- Player 3
local DOOMSDAY_HEIST_CUTS_THREE = menu.add_feature("Player three","parent",DOOMSDAY_HEIST_CUTS.id)
local DOOMSDAY_HEIST_CUTS_THREE_MAX = menu.add_feature("100%","action",DOOMSDAY_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1963628, 100)
end)
local DOOMSDAY_HEIST_CUTS_THREE_SEVEN = menu.add_feature("75%","action",DOOMSDAY_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1963628, 75)
end)
local DOOMSDAY_HEIST_CUTS_THREE_HALF = menu.add_feature("50%","action",DOOMSDAY_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1963628, 50)
end)
local DOOMSDAY_HEIST_CUTS_THREE_TWENTY = menu.add_feature("25%","action",DOOMSDAY_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1963628, 25)
end)
-- Player 4
local DOOMSDAY_HEIST_CUTS_FOUR = menu.add_feature("Player four","parent",DOOMSDAY_HEIST_CUTS.id)
local DOOMSDAY_HEIST_CUTS_FOUR_MAX = menu.add_feature("100%","action",DOOMSDAY_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1963629, 100)
end)
local DOOMSDAY_HEIST_CUTS_FOUR_SEVEN = menu.add_feature("75%","action",DOOMSDAY_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1963629, 75)
end)
local DOOMSDAY_HEIST_CUTS_FOUR_HALF = menu.add_feature("50%","action",DOOMSDAY_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1963629, 50)
end)
local DOOMSDAY_HEIST_CUTS_FOUR_TWENTY = menu.add_feature("25%","action",DOOMSDAY_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1963629, 25)
end)

--[[
	apartment main
]]
local APARTMENT_HEIST = menu.add_feature("Apartment","parent",mission_control.id)
-- go to current heist screen 
menu.add_feature("Go to Current Heist Finale","action",APARTMENT_HEIST.id,function()
	stat_set_int("HEIST_PLANNING_STAGE",true,-1)
	menu.notify("Please leave and re-enter your apaertment","Successful",4,0x008000)
end)
-- apartment cuts
local APARTMENT_HEIST_CUTS = menu.add_feature("Apartment Cuts", "parent", APARTMENT_HEIST.id)
-- max all 
APARTMENT_HEIST_CUTS_MAX_ALL = menu.add_feature("Max all", "action", APARTMENT_HEIST_CUTS.id,function()
	script.set_global_i(1937645, 100)
	script.set_global_i(1937646, 100)
	script.set_global_i(1937647, 100)
	script.set_global_i(1937648, 100)
	menu.notify("This is buggy, the user might not see 100%, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
-- player one
local APARTMENT_HEIST_CUTS_ONE = menu.add_feature("Player one", "parent", APARTMENT_HEIST_CUTS.id)
local APARTMENT_HEIST_CUTS_ONE_CUSTOM = menu.add_feature("Custom","action_value_i",APARTMENT_HEIST_CUTS_ONE.id, function(V)
	script.set_global_i(1937645, tonumber(V.value))
end)
APARTMENT_HEIST_CUTS_ONE_CUSTOM.min = 0 
APARTMENT_HEIST_CUTS_ONE_CUSTOM.max = 100
APARTMENT_HEIST_CUTS_ONE_CUSTOM.mod = 10
menu.add_feature("100%","action",APARTMENT_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1937645, 100)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("75%","action",APARTMENT_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1937645, 75)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("50%","action",APARTMENT_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1937645, 50)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("25%","action",APARTMENT_HEIST_CUTS_ONE.id, function()
	script.set_global_i(1937645, 25)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
-- player 2
local APARTMENT_HEIST_CUTS_TWO = menu.add_feature("Player two", "parent", APARTMENT_HEIST_CUTS.id)
local APARTMENT_HEIST_CUTS_TWO_CUSTOM = menu.add_feature("Custom","action_value_i",APARTMENT_HEIST_CUTS_TWO.id, function(V)
	script.set_global_i(1937646, tonumber(V.value))
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
APARTMENT_HEIST_CUTS_TWO_CUSTOM.min = 0 
APARTMENT_HEIST_CUTS_TWO_CUSTOM.max = 100
APARTMENT_HEIST_CUTS_TWO_CUSTOM.mod = 10
menu.add_feature("100%","action",APARTMENT_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1937646, 100)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("75%","action",APARTMENT_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1937646, 75)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("50%","action",APARTMENT_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1937646, 50)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("25%","action",APARTMENT_HEIST_CUTS_TWO.id, function()
	script.set_global_i(1937646, 25)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
-- player 3
local APARTMENT_HEIST_CUTS_THREE = menu.add_feature("Player three", "parent", APARTMENT_HEIST_CUTS.id)
local APARTMENT_HEIST_CUTS_THREE_CUSTOM = menu.add_feature("Custom","action_value_i",APARTMENT_HEIST_CUTS_THREE.id, function(V)
	script.set_global_i(1765610, tonumber(V.value))
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
APARTMENT_HEIST_CUTS_THREE_CUSTOM.min = 0 
APARTMENT_HEIST_CUTS_THREE_CUSTOM.max = 100
APARTMENT_HEIST_CUTS_THREE_CUSTOM.mod = 10
menu.add_feature("100%","action",APARTMENT_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1937647, 100)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("75%","action",APARTMENT_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1937647, 75)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("50%","action",APARTMENT_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1937647, 50)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("25%","action",APARTMENT_HEIST_CUTS_THREE.id, function()
	script.set_global_i(1937647, 25)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
-- player 4
local APARTMENT_HEIST_CUTS_FOUR = menu.add_feature("Player four", "parent", APARTMENT_HEIST_CUTS.id)
local APARTMENT_HEIST_CUTS_FOUR_CUSTOM = menu.add_feature("Custom","action_value_i",APARTMENT_HEIST_CUTS_FOUR.id, function(V)
	script.set_global_i(1937648, tonumber(V.value))
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
APARTMENT_HEIST_CUTS_FOUR_CUSTOM.min = 0 
APARTMENT_HEIST_CUTS_FOUR_CUSTOM.max = 100
APARTMENT_HEIST_CUTS_FOUR_CUSTOM.mod = 10
menu.add_feature("100%","action",APARTMENT_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1937648, 100)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("75%","action",APARTMENT_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1937648, 75)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("50%","action",APARTMENT_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1937648, 50)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
menu.add_feature("25%","action",APARTMENT_HEIST_CUTS_FOUR.id, function()
	script.set_global_i(1937648, 25)
	menu.notify("This is buggy, the user might not see the value, and the game may correct it.\nI'll try fixing it later","Notice",5,0xffff00)
end)
