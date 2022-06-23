local main = require("User0092_menu/Lib/main")
local globals = require("User0092_menu/Lib/globals")

local set_act_three = {
	{"GANGOPS_FLOW_MISSION_PROG",16368},
	{"GANGOPS_HEIST_STATUS",229380},
	{"GANGOPS_FLOW_NOTIFICATIONS",1557}
}
local set_act_two = {
	{"GANGOPS_FLOW_MISSION_PROG",240},
	{"GANGOPS_HEIST_STATUS",229378},
	{"GANGOPS_FLOW_NOTIFICATIONS",1557}
}
local set_act_one = {
	{"GANGOPS_FLOW_MISSION_PROG",503},
	{"GANGOPS_HEIST_STATUS",229383},
	{"GANGOPS_FLOW_NOTIFICATIONS",1557}
}
local doomsday_acts = {
	{0,"act 1", set_act_one},
	{1,"act 2", set_act_two},
	{2,"act 3", set_act_three}
}
function SetDoomsdayAct(act)
	for id, name in ipairs(doomsday_acts) do
		if name[1] == act then
			local act_preset = name[3]
			for id, data in ipairs(act_preset) do 
				globals.stat_set_int(data[1],true,data[2])
			end 
		break end 
	end
---@diagnostic disable-next-line: undefined-global
	main.NotifyUser("Set act to:\n"..name[2],3,"green")
end 
local player_cuts = {
	{"player 1",1963626},
	{"player 2",1963627},
	{"player 3",1963628},
	{"player 4",1963629}
}	

function SetPlayerCut(playernum,value)
	for id, num in ipairs(player_cuts) do
		if num[1] == playernum then 
			script.set_global_i(num[2],value)
			menu.notify("Set ".. num[1] .."'s cut to "..value,"Successful Operation",3,0x008000)
		break end 
	end 
end 

return {
	SetDoomsdayAct = SetDoomsdayAct,
	SetPlayerCut = SetPlayerCut
}