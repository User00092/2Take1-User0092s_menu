-- Need help? Please see "%appdata%\PopstarDevs\2Take1Menu\scripts\User0092_menu\Help" for help
-- menu version 0.0.2

-- basic checks that need to be in main file 
local main = require("User0092_menu/Lib/main")
if not main then 
	menu.notify("Main dependency is missing\nCannot load","FATAL | Cancelled Initialization",5,0xff0000ff)
	return
end 

local continue = main.MenuInitialization(users_menu_version)
if not continue then 
	return
end
local functions, globals, cayo_heist,casino_heist,doomsday_heist,apartment_heist,players,valid = main.GetDependencies()
if not valid then 
	return
end
users_menu_version = "0.0.2"

-- Main menu 
local USER_MENU = menu.add_feature("User0092's menu","parent",0, function()
end)

--[[
	local Player 
]]
local PLAYER_OPTIONS = menu.add_feature("Local Player -- Yourself --","parent",USER_MENU.id)
-- badsport
local PLAYER_BADSPORT = menu.add_feature("Badsport","parent",PLAYER_OPTIONS.id)
menu.add_feature("Add Badsport","action",PLAYER_BADSPORT.id,function()
	functions.GiveSelfBadsport()
end)
menu.add_feature("Remove Badsport","action",PLAYER_BADSPORT.id,function()
	functions.RemoveSelfBadsport()
end)
-- Kill death ratio
local PLAYER_KILL_DEATH_RATIO = menu.add_feature("K/D","parent",PLAYER_OPTIONS.id)
local PLAYER_KILL_DEATH_RATIO_PRESETS = menu.add_feature("K/D Presets","parent",PLAYER_KILL_DEATH_RATIO.id)
menu.add_feature("6.69","action",PLAYER_KILL_DEATH_RATIO_PRESETS.id, function()
	functions.stat_set_int("MPPLY_KILLS_PLAYERS",false,281)
	functions.stat_set_int("MPPLY_DEATHS_PLAYER",false,42)
end)

local PLAYER_KILL_DEATH_RATIO_KILLS = menu.add_feature("Player Kills","action_value_i",PLAYER_KILL_DEATH_RATIO.id,function(V)
	functions.stat_set_int("MPPLY_KILLS_PLAYERS",false,V.value)
	local PLAYER_CURRENT_KD = functions.GetkdRatiowithKills(V.value)
	menu.notify("Set MPPLY_KILLS_PLAYERS to: "..V.value.."\nCurrent K/D: "..PLAYER_CURRENT_KD,"Successful",3,0x008000)
end)
PLAYER_KILL_DEATH_RATIO_KILLS.min = 0
PLAYER_KILL_DEATH_RATIO_KILLS.max = 1000000
PLAYER_KILL_DEATH_RATIO_KILLS.mod = 1

local PLAYER_KILL_DEATH_RATIO_DEATHS = menu.add_feature("Player Deaths","action_value_i",PLAYER_KILL_DEATH_RATIO.id,function(V)
	functions.stat_set_int("MPPLY_DEATHS_PLAYER",false,V.value)
	local PLAYER_CURRENT_KD = functions.GetkdRatiowithDeaths(V.value)
	menu.notify("Set MPPLY_DEATHS_PLAYER to: "..V.value.."\nCurrent K/D: "..PLAYER_CURRENT_KD,"Successful",3,0x008000)
end)
PLAYER_KILL_DEATH_RATIO_DEATHS.min = 0
PLAYER_KILL_DEATH_RATIO_DEATHS.max = 1000000
PLAYER_KILL_DEATH_RATIO_DEATHS.mod = 1

-- Collectables 
local PLAYER_COLLECTABLES = menu.add_feature("Collectables","parent",PLAYER_OPTIONS.id)
menu.add_feature("Collect all action figures","action",PLAYER_COLLECTABLES.id, function()
	players.unlockCollectables("action figures",99,player.player_id(),v3(2487.128,3759.327,43.307))
end)
menu.add_feature("Collect all playing cards","action",PLAYER_COLLECTABLES.id, function()
	players.unlockCollectables("playing cards",53,player.player_id(),v3(1991.764,3045.699,47.215))
end)
menu.add_feature("Destroy all signal jammers","action",PLAYER_COLLECTABLES.id,function()
	players.unlockCollectables("signal jammers",49,player.player_id(),v3(-982.655,-2637.234,89.522))
end)
menu.add_feature("Unlock all shipwrecks","action",PLAYER_COLLECTABLES.id, function()
	players.unlockCollectables("shipwrecks",29,player.player_id(),player.get_player_coords(player.player_id()))
end)
-- give all weapons 
local WEAPON_OPTIONS = menu.add_feature("Weapon","parent",PLAYER_OPTIONS.id)
menu.add_feature("Give all weapons","action",WEAPON_OPTIONS.id, function()
	functions.GiveAllWeapons(player.player_id())
	menu.notify("Gave all weapons","Successful",3,0x008000)
end)

--[[
	Lobby
]]
local LOBBY_OPTIONS = menu.add_feature("Lobby","parent",USER_MENU.id)
-- lobby kindess
local LOBBY_KINDNESS_OPTIONS = menu.add_feature("Kindness","parent",LOBBY_OPTIONS.id)
-- actions 

-- toggles


--[[ 
	Friends
]]
local FRIEND_OPTIONS = menu.add_feature("Friends","parent",USER_MENU.id)

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
		menu.notify("Make sure all players are in the same vehicle to make this faster.","Notice",8,0xffff00)
	else
		menu.notify("Swim out further until you get a black screen.","Notice",8,0xffff00)
		cayo_heist.teleportPlayer(player.player_id(),"escape island")
	end
end)
local CAYO_BAG_SIZE = menu.add_feature("Select bag size","action_value_i",CAYO_UTILS.id,function(V)
	cayo_heist.SetBagSize(V.value)
end)
CAYO_BAG_SIZE.min = 1000
CAYO_BAG_SIZE.max = 10000
CAYO_BAG_SIZE.mod = 1000
-- Cayo teleports
local CAYO_TELEPORT= menu.add_feature("Cayo Teleports","parent",CAYO_HEIST.id)
local CAYO_TELEPORT_INSIDE= menu.add_feature("Compound Teleports","parent",CAYO_TELEPORT.id)
-- inside compound loot rooms
local CAYO_TELEPORT_INSIDE_LOOT_ROOMS = menu.add_feature("Loot rooms","parent",CAYO_TELEPORT_INSIDE.id)
local CAYO_TELEPORT_INSIDE_TARGET = menu.add_feature("Primary Target","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"primary target")
end)

local CAYO_TELEPORT_INSIDE_MAIN = menu.add_feature("Main loot","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"main loot")
end)

local CAYO_TELEPORT_INSIDE_ROOM_ONE = menu.add_feature("Loot Room 1","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"loot room 1")
end)

local CAYO_TELEPORT_INSIDE_ROOM_TWO = menu.add_feature("Loot Room 2","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"loot room 2")
end)
local CAYO_TELEPORT_INSIDE_ROOM_THREE = menu.add_feature("Loot Room 3","action",CAYO_TELEPORT_INSIDE_LOOT_ROOMS.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"loot room 3")
end)
-- inside compound POI
local CAYO_TELEPORT_INSIDE_POI = menu.add_feature("Point of interest","parent",CAYO_TELEPORT_INSIDE.id)
local CAYO_TELEPORT_INSIDE_MAIN_GATE =  menu.add_feature("Main Gate","action",CAYO_TELEPORT_INSIDE_POI.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"main gate")
end)
local CAYO_TELEPORT_INSIDE_OFFICE = menu.add_feature("Office","action",CAYO_TELEPORT_INSIDE_POI.id, function()
	local local_ped = player.get_player_ped(player.player_id())
	cayo_heist.teleportPlayer(player.player_id(),"office")
end)

-- island teleports
local CAYO_TELEPORT_ISLAND = menu.add_feature("Island Teleports","parent",CAYO_TELEPORT.id)

local CAYO_TELEPORT_ISLAND_COM_TOWER = menu.add_feature("Communications Tower","action",CAYO_TELEPORT_ISLAND.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"communications tower")
end)
local CAYO_TELEPORT_ISLAND_DRAINAGE = menu.add_feature("Drainage tunnel","action",CAYO_TELEPORT_ISLAND.id, function()
	cayo_heist.teleportPlayer(player.player_id(),"drainage tunnel")
end)
local CAYO_TELEPORT_ISLAND_NOTE = menu.add_feature("--- More comming soon ---","action",CAYO_TELEPORT_ISLAND.id)


-- cayo Targets 
local CAYO_PRESETS_TARGET = menu.add_feature("Cayo targets","parent",CAYO_HEIST.id)

-- Primary target 

local CAYO_PRIM_TARGET_SELECT = menu.add_feature("Primary target","parent", CAYO_PRESETS_TARGET.id)
local CAYO_PRIM_TARGET_PANTHER = menu.add_feature("Panther Statue -- 1.9 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	cayo_heist.set_target("panther")
end)

local CAYO_PRIM_TARGET_DIAMOND = menu.add_feature("Pink Diamond -- 1.3 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	cayo_heist.set_target("diamond")
end)
local CAYO_PRIM_TARGET_MAD = menu.add_feature("Madrazo Files -- 1.1 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	cayo_heist.set_target("madrazo")
end)
local CAYO_PRIM_TARGET_BONDS= menu.add_feature("Bearer Bonds -- 1.1 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	cayo_heist.set_target("bonds")
end)
local CAYO_PRIM_TARGET_NECKLACE= menu.add_feature("Ruby Necklace -- 1 million --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	cayo_heist.set_target("ruby")
end)
local CAYO_PRIM_TARGET_TEQUILA= menu.add_feature("Sinsimito Tequila -- 900k --","action",CAYO_PRIM_TARGET_SELECT.id, function()
	cayo_heist.set_target("tequila")
end)
-- secondary target

local CAYO_SEC_TARGET_SELECT = menu.add_feature("Secondary target","parent", CAYO_PRESETS_TARGET.id)
local CAYO_SEC_TARGET_WEED = menu.add_feature("Weed","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	cayo_heist.set_secondary_target("weed")
end)
local CAYO_SEC_TARGET_COKE = menu.add_feature("Coke","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	cayo_heist.set_secondary_target("coke")
end)
local CAYO_SEC_TARGET_GOLD = menu.add_feature("Gold","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	cayo_heist.set_secondary_target("gold")
end)
local CAYO_SEC_TARGET_CASH = menu.add_feature("Cash","action" ,CAYO_SEC_TARGET_SELECT.id, function()
	cayo_heist.set_secondary_target("cash")
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
	functions.stat_set_int("H3OPT_TARGET",true,3)
	menu.notify("Set target to Diamond","Success",3,0x008000)
end)
menu.add_feature("Art","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	functions.stat_set_int("H3OPT_TARGET",true,2)
	menu.notify("Set target to Art","Success",3,0x008000)
end)
menu.add_feature("Gold","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	functions.stat_set_int("H3OPT_TARGET",true,1)
	menu.notify("Set target to Gold","Success",3,0x008000)
end)
menu.add_feature("Cash","action",CASINO_HEIST_PREP_SKIP_TARGET.id, function()
	functions.stat_set_int("H3OPT_TARGET",true,0)
	menu.notify("Set target to Cash","Success",3,0x008000)
end)

-- approach
local CASINO_HEIST_PREP_SKIP_APPROACH = menu.add_feature("Select Approach","parent",CASINO_HEIST_PREP_SKIP.id)
-- easy approach
local CASINO_HEIST_PREP_SKIP_APPROACH_EASY = menu.add_feature("Easy Approach","parent",CASINO_HEIST_PREP_SKIP_APPROACH.id)
menu.add_feature("Aggressive","action",CASINO_HEIST_PREP_SKIP_APPROACH_EASY.id, function()
	functions.stat_set_int("H3_LAST_APPROACH",true,1)
	functions.stat_set_int("H3_HARD_APPROACH",true,2)
	functions.stat_set_int("H3OPT_APPROACH",true,3)
	menu.notify("Set approach to:\nAggressive | Easy","Success",3,0x008000)
end)
menu.add_feature("Big Con","action",CASINO_HEIST_PREP_SKIP_APPROACH_EASY.id, function()
	functions.stat_set_int("H3_LAST_APPROACH",true,3)
	functions.stat_set_int("H3_HARD_APPROACH",true,1)
	functions.stat_set_int("H3OPT_APPROACH",true,2)
	menu.notify("Set approach to:\nBig Con | Easy","Success",3,0x008000)
end)
menu.add_feature("Sneaky","action",CASINO_HEIST_PREP_SKIP_APPROACH_EASY.id, function()
	functions.stat_set_int("H3_LAST_APPROACH",true,3)
	functions.stat_set_int("H3_HARD_APPROACH",true,2)
	functions.stat_set_int("H3OPT_APPROACH",true,1)
	menu.notify("Set approach to:\nSneaky | Easy","Success",3,0x008000)
end)
-- hard approach
local CASINO_HEIST_PREP_SKIP_APPROACH_HARD = menu.add_feature("Hard Approach","parent",CASINO_HEIST_PREP_SKIP_APPROACH.id)
menu.add_feature("Aggressive","action",CASINO_HEIST_PREP_SKIP_APPROACH_HARD.id, function()
	functions.stat_set_int("H3_LAST_APPROACH",true,1)
	functions.stat_set_int("H3_HARD_APPROACH",true,3)
	functions.stat_set_int("H3OPT_APPROACH",true,3)
	menu.notify("Set approach to:\nAggressive | Hard","Success",3,0x008000)
end)
menu.add_feature("Big Con","action",CASINO_HEIST_PREP_SKIP_APPROACH_HARD.id, function()
	functions.stat_set_int("H3_LAST_APPROACH",true,3)
	functions.stat_set_int("H3_HARD_APPROACH",true,2)
	functions.stat_set_int("H3OPT_APPROACH",true,2)
	menu.notify("Set approach to:\nBig Con | Hard","Success",3,0x008000)
end)
menu.add_feature("Sneaky","action",CASINO_HEIST_PREP_SKIP_APPROACH_HARD.id, function()
	functions.stat_set_int("H3_LAST_APPROACH",true,3)
	functions.stat_set_int("H3_HARD_APPROACH",true,1)
	functions.stat_set_int("H3OPT_APPROACH",true,1)
	menu.notify("Set approach to:\nSneaky | Hard","Success",3,0x008000)
end)

-- complete board one 
menu.add_feature("-- Complete Board One --","action",CASINO_HEIST_PREP_SKIP.id,function()
	functions.stat_set_int("H3OPT_BITSET1",true,-1)
	menu.notify("Completed board one","Success",3,0x008000)
end)

-- board two 
-- hacker 
local CASINO_HEIST_PREP_SKIP_HACKER = menu.add_feature("Select hacker","parent",CASINO_HEIST_PREP_SKIP.id)
menu.add_feature("Avi Schwartzman -- 10% | Expert --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	functions.stat_set_int("H3OPT_CREWHACKER",true,4)
	menu.notify("Set hacker to Avi Schwartzman","Success",3,0x008000)
end)
menu.add_feature("Page Harris -- 9% | Expert --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	functions.stat_set_int("H3OPT_CREWHACKER",true,5)
	menu.notify("Set hacker to Page Harris","Success",3,0x008000)
end)
menu.add_feature("Christian Feltz -- 7% | Good --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	functions.stat_set_int("H3OPT_CREWHACKER",true,2)
	menu.notify("Set hacker to Christian Feltz","Success",3,0x008000)
end)
menu.add_feature("Yohan Blair -- 5% | Good --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	functions.stat_set_int("H3OPT_CREWHACKER",true,3)
	menu.notify("Set hacker to Yohan Blair","Success",3,0x008000)
end)
menu.add_feature("Rickie Lukens -- 3% | Poor --","action",CASINO_HEIST_PREP_SKIP_HACKER.id, function()
	functions.stat_set_int("H3OPT_CREWHACKER",true,1)
	menu.notify("Set hacker to Rickie Lukens","Success",3,0x008000)
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
		functions.stat_set_int(CASINO_BOARD_TWO_PRESETS[i][1], true, CASINO_BOARD_TWO_PRESETS[i][2])
	end
	menu.notify("Completed board two","Success",3,0x008000)
end)
-- gun man 
-- local CASINO_HEIST_PREP_SKIP_GUNMAN = menu.add_feature("Select Gunman","parent",CASINO_HEIST_PREP_SKIP.id)
-- menu.add_feature("Chester McCoy -- 10% | Expert --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- functions.stat_set_int("H3OPT_CREWWEAP",true,4)
-- end)
-- menu.add_feature("Gustavo Mota -- 9% | Expert --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id,function()
	-- functions.stat_set_int("H3OPT_CREWWEAP",true,2)
-- end)
-- menu.add_feature("Patrick McReary -- 9% | Good --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- functions.stat_set_int("H3OPT_CREWWEAP",true,5)
-- end)
-- menu.add_feature("Charlie Reed -- 7% | Good --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- functions.stat_set_int("H3OPT_CREWWEAP",true,3)
-- end)
-- menu.add_feature("Karl Abolaji -- 5% | Poor --","action",CASINO_HEIST_PREP_SKIP_GUNMAN.id, function()
	-- functions.stat_set_int("H3OPT_CREWWEAP",true,1)
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
local CASINO_PLAYER_ONE_CUSTOM = menu.add_feature("Custom","action_value_i",CASINO_PLAYER_ONE.id,function(V)
	script.set_global_i(1969065, V.value)
end)
CASINO_PLAYER_ONE_CUSTOM.min = 0
CASINO_PLAYER_ONE_CUSTOM.max = 179
CASINO_PLAYER_ONE_CUSTOM.mod = 10
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
local CASINO_PLAYER_TWO_CUSTOM = menu.add_feature("Custom","action_value_i",CASINO_PLAYER_TWO.id,function(V)
	script.set_global_i(1969066, V.value)
end)
CASINO_PLAYER_TWO_CUSTOM.min = 0
CASINO_PLAYER_TWO_CUSTOM.max = 179
CASINO_PLAYER_TWO_CUSTOM.mod = 10
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
local CASINO_PLAYER_THREE_CUSTOM = menu.add_feature("Custom","action_value_i",CASINO_PLAYER_THREE.id,function(V)
	script.set_global_i(1969067, V.value)
end)
CASINO_PLAYER_THREE_CUSTOM.min = 0
CASINO_PLAYER_THREE_CUSTOM.max = 179
CASINO_PLAYER_THREE_CUSTOM.mod = 10
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
local CASINO_PLAYER_FOUR_CUSTOM = menu.add_feature("Custom","action_value_i",CASINO_PLAYER_FOUR.id,function(V)
	script.set_global_i(1969068, V.value)
end)
CASINO_PLAYER_FOUR_CUSTOM.min = 0
CASINO_PLAYER_FOUR_CUSTOM.max = 179
CASINO_PLAYER_FOUR_CUSTOM.mod = 10
local CASINO_PLAYER_FOUR_MAX = menu.add_feature("100%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969068, 100)
end)
local CASINO_PLAYER_FOUR_SEVEN = menu.add_feature("75%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969068, 75)
end)
local CASINO_PLAYER_FOUR_HALF = menu.add_feature("50%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969068, 50)
end)
local CASINO_PLAYER_FOUR_TWENTY = menu.add_feature("25%","action",CASINO_PLAYER_FOUR.id,function()
	script.set_global_i(1969068, 25)
end)

--[[
	Doomsday main
]]
local DOOMSDAY_HEIST = menu.add_feature("Doomsday","parent",mission_control.id)

-- doomsday heist 
local DOOMSDAY_HEIST_SELECT = menu.add_feature("Select Act","parent",DOOMSDAY_HEIST.id)
menu.add_feature("Act 1","action",DOOMSDAY_HEIST_SELECT.id, function()
	doomsday_heist.SetDoomsdayAct("act one")
end)
menu.add_feature("Act 2","action",DOOMSDAY_HEIST_SELECT.id, function()
	doomsday_heist.SetDoomsdayAct("act two")
end)
menu.add_feature("Act 3","action",DOOMSDAY_HEIST_SELECT.id, function()
	doomsday_heist.SetDoomsdayAct("act three")
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
local DOOMSDAY_HEIST_CUTS_ONE_CUSTOM = menu.add_feature("Custom","action_value_i",DOOMSDAY_HEIST_CUTS_ONE.id, function(V)
	script.set_global_i(1963626, V.value)
end)
DOOMSDAY_HEIST_CUTS_ONE_CUSTOM.min = 0 
DOOMSDAY_HEIST_CUTS_ONE_CUSTOM.max = 150
DOOMSDAY_HEIST_CUTS_ONE_CUSTOM.mod = 10

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
local DOOMSDAY_HEIST_CUTS_TWO_CUSTOM = menu.add_feature("Custom","action_value_i",DOOMSDAY_HEIST_CUTS_TWO.id, function(V)
	script.set_global_i(1963627, V.value)
end)
DOOMSDAY_HEIST_CUTS_TWO_CUSTOM.min = 0 
DOOMSDAY_HEIST_CUTS_TWO_CUSTOM.max = 150
DOOMSDAY_HEIST_CUTS_TWO_CUSTOM.mod = 10
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
local DOOMSDAY_HEIST_CUTS_THREE_CUSTOM = menu.add_feature("Custom","action_value_i",DOOMSDAY_HEIST_CUTS_THREE.id, function(V)
	script.set_global_i(1963628, V.value)
end)
DOOMSDAY_HEIST_CUTS_THREE_CUSTOM.min = 0 
DOOMSDAY_HEIST_CUTS_THREE_CUSTOM.max = 150
DOOMSDAY_HEIST_CUTS_THREE_CUSTOM.mod = 10
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
local DOOMSDAY_HEIST_CUTS_FOUR_CUSTOM = menu.add_feature("Custom","action_value_i",DOOMSDAY_HEIST_CUTS_FOUR.id, function(V)
	script.set_global_i(1963629, V.value)
end)
DOOMSDAY_HEIST_CUTS_FOUR_CUSTOM.min = 0 
DOOMSDAY_HEIST_CUTS_FOUR_CUSTOM.max = 150
DOOMSDAY_HEIST_CUTS_FOUR_CUSTOM.mod = 10
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
	functions.stat_set_int("HEIST_PLANNING_STAGE",true,-1)
	menu.notify("Please leave and re-enter your apartment","Successful",4,0x008000)
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


--[[
	HIDDEN ITEMS
]]
local last_ply = 420 -- imposible player index
local last_msg = ""
local x = 0
function chat(ply,text)
	if ply == player.player_id()
	or player.is_player_friend(ply)then 
		return
	end
	if ply == last_ply 
	and last_msg == text then 
		x = x +1
	end 
	if x == 3 then 
		local sender = player.get_player_name(ply)
		menu.notify("Detected Chat flood from "..sender,"Anti-flood",4,0x008000)
		network.network_session_kick_player(ply)
		x = 0
	end 
	last_msg = text 
	last_ply = ply 
end
