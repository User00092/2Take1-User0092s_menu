local globals = require("User0092_menu/Lib/globals")

local casino_prim_targets = {
	{0,"H3OPT_TARGET",3,"Diamonds"},
	{1,"H3OPT_TARGET",2,"Artwork"},
	{2,"H3OPT_TARGET",1,"Gold"},
	{3,"H3OPT_TARGET",0,"Cash"}
}
function SetPrimTarget(value)
	for id, targets in ipairs(casino_prim_targets) do 
		if targets[1] == value then 
			globals.stat_set_int(targets[2],true,targets[3])
			menu.notify("Set target to "..targets[4],"Successful Operation",3,0x008000)
		break end 
	end 
end 

local easy_approach_sneaky = {
	{"H3_LAST_APPROACH",3},
	{"H3_HARD_APPROACH",2},
	{"H3OPT_APPROACH",1}
}
local easy_approach_bigcon = {
	{"H3_LAST_APPROACH",3},
	{"H3_HARD_APPROACH",1},
	{"H3OPT_APPROACH",2}
}
local easy_approach_agressive = {
	{"H3_LAST_APPROACH",1},
	{"H3_HARD_APPROACH",2},
	{"H3OPT_APPROACH",3}
}
local easy_approach = {
	{0,"Agressive",easy_approach_agressive},
	{1,"Big Con",easy_approach_bigcon},
	{2,"Sneaky",easy_approach_sneaky}
}

local hard_approach_sneaky = {
	{"H3_LAST_APPROACH",3},
	{"H3_HARD_APPROACH",1},
	{"H3OPT_APPROACH",1}
}
local hard_approach_bigcon = {
	{"H3_LAST_APPROACH",3},
	{"H3_HARD_APPROACH",2},
	{"H3OPT_APPROACH",2}
}
local hard_approach_agressive = {
	{"H3_LAST_APPROACH",1},
	{"H3_HARD_APPROACH",3},
	{"H3OPT_APPROACH",3}
}
local hard_approach = {
	{0,"Agressive",hard_approach_agressive},
	{1,"Big Con",hard_approach_bigcon},
	{2,"Sneaky",hard_approach_sneaky}
}
function SetApprachEasy(value)
	for id, name in ipairs(easy_approach) do
		if name[1] == value then 
			local approach_presets = name[3]
			for id, data in ipairs(approach_presets) do 
				globals.stat_set_int(data[1],true,data[2])
			end 
			menu.notify("Set approach to \nEasy: "..name[2],"Successful Operation",3,0x008000)
		break end 
	end 
end
function SetApprachHard(value)
	for id, name in ipairs(hard_approach) do
		if name[1] == value then 
			local approach_presets = name[3]
			for id, data in ipairs(approach_presets) do 
				globals.stat_set_int(data[1],true,data[2])
			end 
			menu.notify("Set approach to \nEasy: "..name[2],"Successful Operation",3,0x008000)
		break end 
	end 
end
local select_hacker = {
	{0,"Avi Schwartzman","H3OPT_CREWHACKER",4},
	{1,"Page Harris","H3OPT_CREWHACKER",5},
	{2,"Christian Feltz","H3OPT_CREWHACKER",2},
	{3,"Yohan Blair","H3OPT_CREWHACKER",3},
	{4,"Rickie Lukens","H3OPT_CREWHACKER",1}
}
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
local board_two_action_types = {
	{"hacker",select_hacker},
	
}
function BoardTwoAction(name,value)
	for id, action in ipairs(board_two_action_types) do 
		if action[1]:match(name) then 
			local select_preset = action[2]
			for id, data in ipairs(select_preset) do 
				if data[1] == value then
					globals.stat_set_int(data[3],true,data[4])
					menu.notify("Set "..action[1] .." to "..data[2],"Successful Operation",3,0x008000)
				break end
			end 
		break end 
	end 
end
function CompleteBoardTwo()
	for i = 1, #CASINO_BOARD_TWO_PRESETS do
		globals.stat_set_int(CASINO_BOARD_TWO_PRESETS[i][1], true, CASINO_BOARD_TWO_PRESETS[i][2])
	end
	menu.notify("Completed board two","Successful Operation",3,0x008000)
end
local players_num = {
	{"player 1",1969065},
	{"player 2",1969066},
	{"player 3",1969067},
	{"player 4",1969068}
}
function SetPlayerCut(playerNum,value)
	for id, players in ipairs(players_num) do 
		if players[1] == playerNum then 
			stats.stat_set_int(players[2],value)
			menu.notify("Set "..player[1].."'s cut to "..value.."%","Successful Operation",3,0x008000)
		break end 
	end 
end
return {
	SetPrimTarget = SetPrimTarget,
	SetApprachEasy = SetApprachEasy,
	SetApprachHard = SetApprachHard,
	BoardTwoAction = BoardTwoAction,
	CompleteBoardTwo = CompleteBoardTwo,
	SetPlayerCut = SetPlayerCut
}