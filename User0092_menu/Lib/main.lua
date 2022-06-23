local color_list = {
	--0xAABBGGRR
	{"green",0xff008000},
	{"red",0xff0000ff},
	{"yellow",0xff00ffff}
}

local LUA_TRUST_STATS = 1 << 0
local LUA_TRUST_SCRIPT_VARS = 1 << 1
local LUA_TRUST_NATIVES = 1 << 2
local LUA_TRUST_HTTP = 1 << 3

function NotifyUser(text,seconds,color)
	for id, name in ipairs(color_list) do
		if name[1] == color then
			menu.notify(tostring(text),"User0092's menu 0.0.3",tonumber(seconds),name[2])
		break end 
	end 
end 
function MenuInitialization(menuVersion)
	if menuVersion then 
		NotifyUser("You already loaded User0092's menu!",3, "yellow") 
		return false
	end 
	local takemenuv = menu.get_version()
	if takemenuv ~= "2.60.1" then 
		NotifyUser("The menu is not up-to-date!\nSome errors may occur",5, "yellow") 
	end 
	if not menu.is_trusted_mode_enabled(LUA_TRUST_STATS) then
		NotifyUser("Trustedmode(stats) is disabled!\nSome features are disabled",5, "yellow") 
	end 
	if not menu.is_trusted_mode_enabled(LUA_TRUST_SCRIPT_VARS) then
		NotifyUser("Trustedmode(stats vars) is disabled!\nSome features are disabled",5, "yellow") 
	end 
	if not menu.is_trusted_mode_enabled(LUA_TRUST_NATIVES) then
		NotifyUser("Trustedmode(natives) is disabled!\nSome features are disabled",5, "yellow") 
	end 
	if not menu.is_trusted_mode_enabled(LUA_TRUST_HTTP) then
		NotifyUser("Trustedmode(HTTP) is disabled!\nSome features are disabled",5, "yellow") 
	end 
	
	local dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\"
	if not utils.dir_exists(dir) then 
		NotifyUser("Directory not found.\nPlease go to the help folder", 8, "red")
		return false
	end 
	local lib_dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\Lib\\"
	if not utils.dir_exists(lib_dir) then 
		NotifyUser("Lib not found.\nPlease go to the help folder",8, "red")
		return false
	end
	local fs = require("User0092_menu/Lib/fs")

	local player_name = player.get_player_name(player.player_id())
	local admin_names = fs.lines_from(lib_dir.."Data\\admin.txt")
	for id, name in ipairs(admin_names) do 
		if name == player_name then
			menu.notify("Welcome back Master!","User0092's menu 0.0.3",7,0xff008000) -- I don't want to hear it. Keep it to yourself.
			return true
		end
	end 
	local beta_names = fs.lines_from(lib_dir.."Data\\beta.txt")
	for id, name in ipairs(beta_names) do 
		if name == player_name then 
			menu.notify("Welcome back "..name..", good to see you again.","User0092's menu 0.0.3",7,0xff008000)
			return true
		end 
	end 
	NotifyUser("Welcome "..player_name.. ", to User0092's menu",7, "green")
	NotifyUser("If there are errors or bugs, please contact User0092 on Discord\nFuckIfiKnow#6815",10,"green")
	return true
end 


function GetDependencies()
	local missing_dependencies = {}
	local lib_dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\Lib\\"
	local globals = require("User0092_menu/Lib/globals")
	if not globals then 
		table.insert(missing_dependencies,"globals.lua")
	end 
	local ipInfo = require("User0092_menu/Lib/infoIP")
	if not ipInfo then 
		table.insert(missing_dependencies,"infoIP.lua")
	end 

	local players = require("User0092_menu/Lib/players")
	if not players then 
		table.insert(missing_dependencies,"players.lua")
	end 
	
	local apartment = require("User0092_menu/Heist/apartment")
	if not apartment then 
		table.insert(missing_dependencies,"apartment.lua")
	end 
	
	local casino = require("User0092_menu/Heist/casino")
	if not casino then 
		table.insert(missing_dependencies,"casino.lua")
	end 
	
	local cayo = require("User0092_menu/Heist/cayo")
	if not cayo then 
		table.insert(missing_dependencies,"cayo.lua")
	end 
	
	local doomsday = require("User0092_menu/Heist/doomsday")
	if not doomsday then 
		table.insert(missing_dependencies,"doomsday.lua")
	end 
	
	local commands = require("User0092_menu/Lib/commands")
	if not commands then 
		table.insert(missing_dependencies,"commands.lua")
	end 
	
	local requests = require("User0092_menu/Lib/requests")
	if not requests then
		table.insert(missing_dependencies,"requests.lua")
	end 
	
	local fs = require("User0092_menu/Lib/fs")
	if not fs then 
		table.insert(missing_dependencies,"fs.lua")
	end 
	
	if not fs.file_exists(lib_dir.."Data\\admin.txt") then
		table.insert(missing_dependencies,"admin.txt")
	end 
	if not fs.file_exists(lib_dir.."Data\\beta.txt") then 
		table.insert(missing_dependencies,"beta.txt")
	end 
	if not fs.file_exists(lib_dir.."Data\\whitelist.txt") then 
		table.insert(missing_dependencies,"whitelist.txt")
	end 

	if #missing_dependencies > 0 then
		NotifyUser("You are missing ("..#missing_dependencies..") dependencies.",5,"red")
		for id, missing in ipairs(missing_dependencies) do 
			NotifyUser("Missing the dependency: "..missing,5,"red")
		end
		return false
	end

	return globals, players, apartment, casino, cayo, doomsday, commands, requests,fs,ipInfo,true
end

return {
	MenuInitialization = MenuInitialization,
	GetDependencies = GetDependencies,
	NotifyUser = NotifyUser
}