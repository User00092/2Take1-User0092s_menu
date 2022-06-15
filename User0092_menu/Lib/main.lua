function MenuInitialization(menuVersion)
	local  twoTakeOne_version = menu.get_version()
	if twoTakeOne_version ~= "2.59.0" then 
		menu.notify("User's menu is not updated. Please wait", "Cancelled Initialization", 3, 0xff0000ff) 
		return false
	end 
	if menuVersion then 
		menu.notify("User's menu is already loaded!", "Cancelled Initialization", 3, 0xff0000ff) 
		return false
	end 
	if menu.is_trusted_mode_enabled() then
		menu.notify("Successfully loaded", "Welcome to User0092's menu", 7, 0x008000)
	else
		if not menu.is_trusted_mode_enabled() then
			menu.notify("User0092's menu requires Trusted Mode to be activated", "Failed", 8, 0xff0000ff)
			return false
		end
	end
	local dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\"
	if not utils.dir_exists(dir) then 
		menu.notify("Directory not found.\nPlease go to the help folder", "Failed", 8, 0xff0000ff)
		return false
	end 
	local lib_dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\Lib\\"
	if not utils.dir_exists(lib_dir) then 
		menu.notify("Lib not found.\nPlease go to the help folder", "Failed", 8, 0xff0000ff)
		return false
	end
	return true
end 


function GetDependencies()
	local missing_dependencies = {}
	local functions = require("User0092_menu/Lib/functions")
	if not functions then 
		table.insert(missing_dependencies,"functions.lua")
	end
	
	local globals = require("User0092_menu/Lib/globals")
	if not globals then 
		table.insert(missing_dependencies,"globals.lua")
	end
	
	local cayo_Heist = require("User0092_menu/Heist/cayo")
	if not cayo_Heist then 
		table.insert(missing_dependencies,"cayo.lua")
	end 
	
	local casino_heist = require("User0092_menu/Heist/casino")
	if not casino_heist then 
		table.insert(missing_dependencies,"casino.lua")
	end  
	
	local doomsday_heist = require("User0092_menu/Heist/doomsday")
	if not doomsday_heist then 
		table.insert(missing_dependencies,"doomsday.lua")
	end  
	
	local apartment_heist = require("User0092_menu/Heist/apartment")
	if not apartment_heist then 
		table.insert(missing_dependencies,"apartment.lua")
	end  
	
	local players = require("User0092_menu/Lib/players")
	if not players then 
		table.insert(missing_dependencies,"players.lua")
	end
	if #missing_dependencies > 0 then
		menu.notify("You are missing ("..#missing_dependencies..") dependencies.","FATAL | Cancelled Initialization",4,0xff0000ff)
		for id, missing in ipairs(missing_dependencies) do 
			menu.notify("Cannot find the dependency: ".. missing,"FATAL | Cancelled Initialization",4,0xff0000ff)
		end
		return false
	end
	-- functions, globals, cayo_Heist,casino_heist,doomsday_heist,apartment_heist
	return functions, globals, cayo_Heist,casino_heist,doomsday_heist,apartment_heist,players,true -- true must always be at the end
end

return {
	MenuInitialization = MenuInitialization,
	GetDependencies = GetDependencies
}