local main = require("User0092_menu/Lib/main")
local requests = require("User0092_menu/Lib/requests")
local fs = require("User0092_menu/Lib/fs")
local players = require("User0092_menu/Lib/players")
-- local math = require("User0092_menu/Lib/math")

function AddWhitelist(text)
	for i = 0,32 do 
		if player.is_player_valid(i) then
			local pName = player.get_player_name(i)
			if text:match(pName) then 
				local lib_dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\Lib\\"
				local formatedIP = requests.formatIP(player.get_player_ip(i))
				local append_text = pName .. " | " ..player.get_player_scid(i).." | " ..formatedIP .. " | "..requests.IPtoDec(formatedIP)
				fs.write_file(lib_dir.."Data\\whitelist.txt","append",append_text)
				main.NotifyUser("Whitelisted player:\n\""..pName.."\"",4,"green")
				return
			end 
		end
	end 
	main.NotifyUser("Name not found",4,"red")
end
local chat_commands = {
	"/distance",
	"/kick",
	"/crash"
}
local function isCommand(text)
	for id, command in ipairs(chat_commands) do 
		if text:match(command) then 
			return true
		end 
	end 
	return false
end 

local function IsAllowed(pid,requireFriends,whitelist)
	local allow = false 
	if requireFriends 
	and player.is_player_friend(pid) then
		allow = true 
		return allow
	end 
	if whitelist then
		local is_listed = requests.isWhitelisted(pid)
		if is_listed then
			allow = true
		end 
	end 
	if not requireFriends
	and not whitelist then 
		allow = true
	end 
	if pid == player.player_id() then
		allow = true
	end 
	return allow
end 

function ChatCommandMain(chat_id,chat_text,requireFriends,allow_whitelist)
	local is_command = isCommand(chat_text)
	if not is_command then
		return false
	end 
	local continue = IsAllowed(chat_id,requireFriends,allow_whitelist)
	if not continue then 
		return false 
	end 
	return true
end 


function getDistance(chat_text,chat_id)
	local playerList = players.getPlayerList()
	for id, name in ipairs(playerList) do 
		if chat_text:match(name[1]) then 
			local local_coords = player.get_player_coords(chat_id)
			local player_coords = player.get_player_coords(name[2])
			local x_diff = local_coords.x - player_coords.x
			local y_diff = local_coords.y - player_coords.y
			local x_diff,y_diff = string.format("%.0f", x_diff), string.format("%.0f", y_diff)
			local total = x_diff^2 + y_diff^2
			local total =string.format("%.0f", math.sqrt(total))

			player.send_player_sms(chat_id, "[Command services]\n\""..name[1].."\"\nDistance: "..total)
			
		break end 
	end 
end 

function kickPlayer(chat_text,chat_id)
	local playerList = players.getPlayerList()
	for id, name in ipairs(playerList) do 
		local sender = player.get_player_name(chat_id)
		local local_name = player.get_player_name(player.player_id())
		if chat_text:match(local_name) then 
			main.NotifyUser(sender.." tried kicking you!",6,"red")
			return
		end
		
		local isBlocked = players.isPlayerWhitelisted(name[2])
		if not isBlocked then 
			isBlocked = player.is_player_friend(name[2])
		end 
		
		if isBlocked then 
			main.NotifyUser(sender.." tried kicking a whitelisted player: "..name[1],6,"red")
		end 
		if chat_text:match(name[1]) 
		and not isBlocked then 
			player.send_player_sms(chat_id, "[Command services]\nKicking:\n"..name[1])
			network.network_session_kick_player(name[2])
			return true 
		end
	end 
	return false
end 
return {
	AddWhitelist = AddWhitelist,
	ChatCommandMain = ChatCommandMain,
	getDistance = getDistance,
	kickPlayer = kickPlayer
}
