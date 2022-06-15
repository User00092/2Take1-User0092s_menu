local functions = require("User0092_menu/Lib/functions")
local collectableTypes = {
	{"action figures",2784215},
	{"playing cards",2784216},
	{"signal jammers",2784217},
	{"shipwrecks",2784552}
}

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
				functions.TeleportPlayer(playerid,coords)
				if name ~= "shipwrecks" then 
					menu.notify("Unlocked all "..name.."\nIf the final item isn't here, please look for it","Success",3,0x008000)
				else
					menu.notify("Unlocked all "..name.."\nSearch for the final item (rotates daily)","Success",3,0x008000)
				end 
			end 
		break end 
	end 
end
return {
	unlockCollectables = unlockCollectables
}