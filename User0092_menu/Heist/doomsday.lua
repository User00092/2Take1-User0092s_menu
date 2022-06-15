local functions = require("User0092_menu/Lib/functions")

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
	{"act one", set_act_one},
	{"act two", set_act_two},
	{"act three", set_act_three}
}
function SetDoomsdayAct(act)
	for id, name in ipairs(doomsday_acts) do
		if name[1]:match(act) then
			local act_preset = name[2]
			for id, data in ipairs(act_preset) do 
				functions.stat_set_int(data[1],true,data[2])
			end 
		break end 
	end
	menu.notify("Set act to "..act,"Success",3,0x008000)
end 


return {
	SetDoomsdayAct = SetDoomsdayAct
}