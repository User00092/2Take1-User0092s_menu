-- Need help? Please see "%appdata%\PopstarDevs\2Take1Menu\scripts\User0092_menu\Help"
-- menu version 0.0.3

-- basic checks that need to be in main file 
local main = require("User0092_menu/Lib/main")
if not main then 
	menu.notify("Main dependency is missing\nCannot load","User0092's menu 0.0.3",5,0xff0000ff)
	return
end 
local dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\"
local globals, players, apartment_heist, casino_heist, cayo_heist, doomsday_heist, commands, requests,fs,ipInfo,valid = main.GetDependencies()
if not valid then 
	return
end 
local continue = main.MenuInitialization(users_menu_version)
if not continue then
	return
end

users_menu_version = "0.0.3"

local LUA_TRUST_STATS = 1 << 0
local LUA_TRUST_SCRIPT_VARS = 1 << 1
local LUA_TRUST_NATIVES = 1 << 2
local LUA_TRUST_HTTP = 1 << 3

local is_https_trusted = menu.is_trusted_mode_enabled(LUA_TRUST_HTTP)
-- Main menu 
local USER_MENU = menu.add_feature("User0092's menu","parent",0, function()
end)

--[[
	local Player 
]]
local PLAYER_OPTIONS = menu.add_feature("Local Player","parent",USER_MENU.id)

-- actions 
if menu.is_trusted_mode_enabled(LUA_TRUST_SCRIPT_VARS) and menu.is_trusted_mode_enabled(LUA_TRUST_STATS) then 
	local PLAYER_OPTIONS_COLLECTABLES = menu.add_feature("Collectables","action_value_str",PLAYER_OPTIONS.id, function(V)
		players.UnlockCollectable(V.value,player.player_id())
	end):set_str_data({
		"Action figures",
		"Playing cards",
		"Signal jammers"
	})

	menu.add_feature("Badsport","action_value_str",PLAYER_OPTIONS.id, function(V)
		if V.value == 0 then 
			players.GiveSelfBadsport()
		elseif V.value == 1 then 
			players.RemoveSelfBadsport()
		end 
		
	end):set_str_data({
		"Add",
		"Remove"
	})
end

menu.add_feature("Weapons","action_value_str",PLAYER_OPTIONS.id, function(V)
	if V.value == 0 then 
		globals.GiveAllWeapons(player.player_id())
	elseif V.value == 1 then 
		globals.RemoveAllWeapons(player.player_id())
	end 
	
end):set_str_data({
	"Give all",
	"Remove all"
})
-- parents 
if menu.is_trusted_mode_enabled(LUA_TRUST_STATS) then 
	local PLAYER_OPTIONS_STATS = menu.add_feature("Stats","parent",PLAYER_OPTIONS.id)
	local PLAYER_KILL_DEATH_RATIO = menu.add_feature("K/D","parent",PLAYER_OPTIONS_STATS.id)
	menu.add_feature("Presets","action_value_str",PLAYER_KILL_DEATH_RATIO.id, function(V)
		players.SetKDPreset(V.value)
	end):set_str_data({
		"1.34",
		"1.50",
		"4.20",
		"6.69",
		"69.69"
	})
	local PLAYER_KILL_DEATH_RATIO_SET_KILLS = menu.add_feature("Kills","action_value_i",PLAYER_KILL_DEATH_RATIO.id, function(V)
		players.SetKDKills(V.value)
	end)
	PLAYER_KILL_DEATH_RATIO_SET_KILLS.min = 0
	PLAYER_KILL_DEATH_RATIO_SET_KILLS.max = 1000000
	PLAYER_KILL_DEATH_RATIO_SET_KILLS.mod = 1
	local PLAYER_KILL_DEATH_RATIO_SET_DEATHS = menu.add_feature("Deaths","action_value_i",PLAYER_KILL_DEATH_RATIO.id, function(V)
		players.SetKDDeaths(V.value)
	end)
	PLAYER_KILL_DEATH_RATIO_SET_DEATHS.min = 0
	PLAYER_KILL_DEATH_RATIO_SET_DEATHS.max = 1000000
	PLAYER_KILL_DEATH_RATIO_SET_DEATHS.mod = 1
end

--[[
	Lobby
]]


--[[ 
	Friends
]]


--[[
	Chat commands 
]]
local chat_commands_active,requireFriends,allow_whitelist = false 
local allow_distance, allow_kick = false 
local CHAT_COMMANDS = menu.add_feature("Chat commands","parent",USER_MENU.id)
menu.add_feature("Active","toggle",CHAT_COMMANDS.id,function(V)
	if V.on then
		chat_commands_active = true 
		main.NotifyUser("Activated chat commands",3,"green")
		return chat_commands_active
	end 
	chat_commands_active = false
	main.NotifyUser("Deactivated chat commands",3,"green")	
end)
menu.add_feature("Friends only","toggle",CHAT_COMMANDS.id, function(V)
	if V.on then
		requireFriends = true 
		main.NotifyUser("Changed mode to friends only",3,"green")
		return 
	end 
	requireFriends = false
	main.NotifyUser("Changed mode to lobby",3,"green")
end)
menu.add_feature("Allow whitelist","toggle",CHAT_COMMANDS.id, function(V)
	if V.on then
		allow_whitelist = true 
		main.NotifyUser("Allowing whitelisted players",3,"green")
		return
	end 
	allow_whitelist = false
	main.NotifyUser("Not allowing whitelisted players",3,"green")
end)
menu.add_feature("----------------------------","action",CHAT_COMMANDS.id)

menu.add_feature("Distance <player>","toggle",CHAT_COMMANDS.id, function(V)
	if V.on then 
		allow_distance = true 
		main.NotifyUser("Distance command: ON",3,"green")
		return 
	end 
	allow_distance = false
	main.NotifyUser("Distance command: OFF",3,"green")
end) 
menu.add_feature("kick <player>","toggle",CHAT_COMMANDS.id,function(V)
	if V.on then
		allow_kick = true 
		main.NotifyUser("Kick command: ON",3,"green")
		return 
	end 
	allow_kick = false 
	main.NotifyUser("Kick command: OFF",3,"green")
end)

 
-- backend 
event.add_event_listener("chat", function(event)
	local chat_id = event.player
	local chat_text = event.body
	
	if chat_commands_active then
		if chat_id == player.player_id()
		and chat_text:match("^/whitelist") then
			commands.AddWhitelist(event.body)
			return
		end 
		if chat_text:match("^/") then 
			local continue = commands.ChatCommandMain(chat_id,chat_text,requireFriends,allow_whitelist)
			if not continue then 
				return 
			end 
			if chat_text:match("^/distance") then 
				if allow_distance then 
					commands.getDistance(chat_text,chat_id)
				end
				if not allow_distance then 
					player.send_player_sms(chat_id, "[Command services]\nCommand not active:\n\\Distance")
				end 
			end 
			if chat_text:match("^/kick") then 
				if allow_kick then 
					local success = commands.kickPlayer(chat_text,chat_id)
					if not success then 
						player.send_player_sms(chat_id, "Something went wrong!\nDid you type the name correctly?")
					end 
				end 
				if not allow_kick then 
					player.send_player_sms(chat_id, "[Command services]\nCommand not active:\n\\Kick")
				end 
			
			end 
		end 
	end
end)


--[[
	Heist Controller
]]
if menu.is_trusted_mode_enabled(LUA_TRUST_SCRIPT_VARS) and menu.is_trusted_mode_enabled(LUA_TRUST_STATS) then 
	local HEIST_CONTROL = menu.add_feature("Heist controller", "parent", USER_MENU.id)


	local HEIST_CONTROL_CAYO = menu.add_feature("Cayo Perico", "parent", HEIST_CONTROL.id)


	local HEIST_CONTROL_CAYO_UTILS = menu.add_feature("Utilities","parent",HEIST_CONTROL_CAYO.id)
	menu.add_feature("Delete Drainage Pipe Grate","action",HEIST_CONTROL_CAYO_UTILS.id, function()
		cayo_heist.RemoveDrainagePipe()
	end)
	menu.add_feature("Escape Island","action",HEIST_CONTROL_CAYO_UTILS.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"escape island")
	end)
	local HEIST_CONTROL_CAYO_BAG = menu.add_feature("Set bag size","action_value_i",HEIST_CONTROL_CAYO_UTILS.id, function(V)
		cayo_heist.SetBagSize(V.value)
	end)
	HEIST_CONTROL_CAYO_BAG.min = 1000
	HEIST_CONTROL_CAYO_BAG.max = 10000
	HEIST_CONTROL_CAYO_BAG.mod = 1000

	local HEIST_CONTROL_CAYO_SKIP_PREP = menu.add_feature("Skip prep", "parent",HEIST_CONTROL_CAYO.id)

	menu.add_feature("Primary Target","action_value_str",HEIST_CONTROL_CAYO_SKIP_PREP.id, function(V)
		cayo_heist.SetPrimaryTarget(V.value)
	end):set_str_data({
		"Panther Statue (1.9 million)",
		"Pink Diamond   (1.3 million)",
		"Madrazo Files  (1.1 million)",
		"Bearer Bonds   (1.1 million)",
		"Ruby Necklace  (1.0 million)",
		"Tequila        (0.9 million)"
	})
	menu.add_feature("Secondary Target","action_value_str",HEIST_CONTROL_CAYO_SKIP_PREP.id, function(V)
		cayo_heist.SetSecondaryTarget(V.value)
	end):set_str_data({
		"Weed",
		"Coke",
		"Gold",
		"Cash"
	})


	local HEIST_CONTROL_CAYO_CUTS = menu.add_feature("Player Cuts","parent",HEIST_CONTROL_CAYO.id)
	local HEIST_CONTROL_CAYO_CUTS_ONE = menu.add_feature("Player 1","action_value_i",HEIST_CONTROL_CAYO_CUTS.id,function(V)
		cayo_heist.SetPlayerCut("player 1",V.value)
	end)
	HEIST_CONTROL_CAYO_CUTS_ONE.min = 0
	HEIST_CONTROL_CAYO_CUTS_ONE.max = 100
	HEIST_CONTROL_CAYO_CUTS_ONE.mod = 10

	local HEIST_CONTROL_CAYO_CUTS_TWO = menu.add_feature("Player 2","action_value_i",HEIST_CONTROL_CAYO_CUTS.id,function(V)
		cayo_heist.SetPlayerCut("player 2",V.value)
	end)
	HEIST_CONTROL_CAYO_CUTS_TWO.min = 0
	HEIST_CONTROL_CAYO_CUTS_TWO.max = 100
	HEIST_CONTROL_CAYO_CUTS_TWO.mod = 10

	local HEIST_CONTROL_CAYO_CUTS_THREE = menu.add_feature("Player 3","action_value_i",HEIST_CONTROL_CAYO_CUTS.id,function(V)
		cayo_heist.SetPlayerCut("player 3",V.value)
	end)
	HEIST_CONTROL_CAYO_CUTS_THREE.min = 0
	HEIST_CONTROL_CAYO_CUTS_THREE.max = 100
	HEIST_CONTROL_CAYO_CUTS_THREE.mod = 10

	local HEIST_CONTROL_CAYO_CUTS_FOUR = menu.add_feature("Player 4","action_value_i",HEIST_CONTROL_CAYO_CUTS.id,function(V)
		cayo_heist.SetPlayerCut("player 4",V.value)
	end)
	HEIST_CONTROL_CAYO_CUTS_FOUR.min = 0
	HEIST_CONTROL_CAYO_CUTS_FOUR.max = 100
	HEIST_CONTROL_CAYO_CUTS_FOUR.mod = 10


	local HEIST_CONTROL_CAYO_TELEPORT = menu.add_feature("Teleports","parent",HEIST_CONTROL_CAYO.id)


	local HEIST_CONTROL_CAYO_TELEPORT_COMPOUND = menu.add_feature("Compound Teleports","parent",HEIST_CONTROL_CAYO_TELEPORT.id)
	menu.add_feature("Inside Main Gate","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"inside main gate")
	end)
	menu.add_feature("Office","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"office")
	end)
	menu.add_feature("Vault","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"primary target")
	end)
	menu.add_feature("Vault loot","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"main loot")
	end)
	menu.add_feature("Loot room 1","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"loot room 1")
	end)
	menu.add_feature("Loot room 2","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"loot room 2")
	end)
	menu.add_feature("Loot room 3","action",HEIST_CONTROL_CAYO_TELEPORT_COMPOUND.id,function()
		cayo_heist.teleportPlayer(player.player_id(),"loot room 2")
	end)


	local HEIST_CONTROL_CAYO_TELEPORT_ISLAND = menu.add_feature("Island Teleports","parent",HEIST_CONTROL_CAYO_TELEPORT.id)
	menu.add_feature("Communications tower","action",HEIST_CONTROL_CAYO_TELEPORT_ISLAND.id, function()
		cayo_heist.teleportPlayer(player.player_id(),"communications tower")
	end)
	menu.add_feature("Drainage tunnel : Entrance","action",HEIST_CONTROL_CAYO_TELEPORT_ISLAND.id, function()
		cayo_heist.teleportPlayer(player.player_id(),"drainage tunnel")
	end)


	local HEIST_CONTROL_CASINO = menu.add_feature("Casino", "parent", HEIST_CONTROL.id)
	local HEIST_CONTROL_CASINO_SKIP_PREP = menu.add_feature("Skip Prep","parent",HEIST_CONTROL_CASINO.id)
	menu.add_feature("Target","action_value_str",HEIST_CONTROL_CASINO_SKIP_PREP.id,function(V)
		casino_heist.SetPrimTarget(V.value)
	end):set_str_data({
		"Diamond",
		"Artwork",
		"Gold",
		"Cash"
	})
	local HEIST_CONTROL_CASINO_SKIP_PREP_APPROACH = menu.add_feature("Select Approach","parent",HEIST_CONTROL_CASINO_SKIP_PREP.id)
	menu.add_feature("Easy Approach","action_value_str",HEIST_CONTROL_CASINO_SKIP_PREP_APPROACH.id,function(V)
		casino_heist.SetApprachEasy(V.value)
	end):set_str_data({
		"Aggressive",
		"Big Con",
		"Sneaky"
	})

	menu.add_feature("Hard Approach","action_value_str",HEIST_CONTROL_CASINO_SKIP_PREP_APPROACH.id,function(V)
		casino_heist.SetApprachHard(V.value)
	end):set_str_data({
		"Aggressive",
		"Big Con",
		"Sneaky"
	})
	menu.add_feature("--- Complete board one ---","action",HEIST_CONTROL_CASINO_SKIP_PREP.id,function()
		globals.stat_set_int("H3OPT_BITSET1",true,-1)
		main.NotifyUser("Completed board one",3,"green")
	end)

	menu.add_feature("Hacker: ","action_value_str",HEIST_CONTROL_CASINO_SKIP_PREP.id,function(V)
		casino_heist.BoardTwoAction("hacker",V.value)
	end):set_str_data({
		"Avi   (U)	10%",
		"Page  (U)	9%",
		"Christian  7%",
		"Yohan (U)	5%",
		"Rickie 	3%"
	})

	menu.add_feature("--- Complete board two ---","action",HEIST_CONTROL_CASINO_SKIP_PREP.id,function()
		casino_heist.CompleteBoardTwo()
	end)


	local HEIST_CONTROL_CASINO_CUTS =  menu.add_feature("Player Cuts","parent",HEIST_CONTROL_CASINO.id)

	local HEIST_CONTROL_CASINO_CUTS_ONE = menu.add_feature("Player 1","action_value_i",HEIST_CONTROL_CASINO_CUTS.id, function(V)
		casino_heist.SetPlayerCut("player 1",V.value)
	end)
	HEIST_CONTROL_CASINO_CUTS_ONE.min = 0 
	HEIST_CONTROL_CASINO_CUTS_ONE.max = 179
	HEIST_CONTROL_CASINO_CUTS_ONE.mod = 10

	local HEIST_CONTROL_CASINO_CUTS_TWO = menu.add_feature("Player 2","action_value_i",HEIST_CONTROL_CASINO_CUTS.id, function(V)
		casino_heist.SetPlayerCut("player 2",V.value)
	end)
	HEIST_CONTROL_CASINO_CUTS_TWO.min = 0 
	HEIST_CONTROL_CASINO_CUTS_TWO.max = 179
	HEIST_CONTROL_CASINO_CUTS_TWO.mod = 10

	local HEIST_CONTROL_CASINO_CUTS_THREE = menu.add_feature("Player 3","action_value_i",HEIST_CONTROL_CASINO_CUTS.id, function(V)
		casino_heist.SetPlayerCut("player 3",V.value)
	end)
	HEIST_CONTROL_CASINO_CUTS_THREE.min = 0 
	HEIST_CONTROL_CASINO_CUTS_THREE.max = 179
	HEIST_CONTROL_CASINO_CUTS_THREE.mod = 10

	local HEIST_CONTROL_CASINO_CUTS_FOUR = menu.add_feature("Player 4","action_value_i",HEIST_CONTROL_CASINO_CUTS.id, function(V)
		casino_heist.SetPlayerCut("player 4",V.value)
	end)
	HEIST_CONTROL_CASINO_CUTS_FOUR.min = 0 
	HEIST_CONTROL_CASINO_CUTS_FOUR.max = 179
	HEIST_CONTROL_CASINO_CUTS_FOUR.mod = 10


	local HEIST_CONTROL_DOOMSDAY = menu.add_feature("Doomsday","parent",HEIST_CONTROL.id)

	menu.add_feature("Set Act","action_value_str",HEIST_CONTROL_DOOMSDAY.id,function(V)
		doomsday_heist.SetDoomsdayAct(V.value)
	end):set_str_data({
		"Act 1",
		"Act 2",
		"Act 3"
	})

	local HEIST_CONTROL_DOOMSDAY_CUTS = menu.add_feature("Player Cuts","parent",HEIST_CONTROL_DOOMSDAY.id)
	local HEIST_CONTROL_DOOMSDAY_CUTS_ONE = menu.add_feature("Player 1","action_value_i",HEIST_CONTROL_DOOMSDAY_CUTS.id, function(V)
		SetPlayerCut("player 1",V.value)
	end)
	HEIST_CONTROL_DOOMSDAY_CUTS_ONE.min = 0
	HEIST_CONTROL_DOOMSDAY_CUTS_ONE.max = 150 
	HEIST_CONTROL_DOOMSDAY_CUTS_ONE.mod = 10


	local HEIST_CONTROL_DOOMSDAY_CUTS_TWO = menu.add_feature("Player 2","action_value_i",HEIST_CONTROL_DOOMSDAY_CUTS.id, function(V)
		SetPlayerCut("player 2",V.value)
	end)
	HEIST_CONTROL_DOOMSDAY_CUTS_TWO.min = 0
	HEIST_CONTROL_DOOMSDAY_CUTS_TWO.max = 150 
	HEIST_CONTROL_DOOMSDAY_CUTS_TWO.mod = 10

	local HEIST_CONTROL_DOOMSDAY_CUTS_THREE = menu.add_feature("Player 3","action_value_i",HEIST_CONTROL_DOOMSDAY_CUTS.id, function(V)
		SetPlayerCut("player 3",V.value)
	end)
	HEIST_CONTROL_DOOMSDAY_CUTS_THREE.min = 0
	HEIST_CONTROL_DOOMSDAY_CUTS_THREE.max = 150 
	HEIST_CONTROL_DOOMSDAY_CUTS_THREE.mod = 10

	local HEIST_CONTROL_DOOMSDAY_CUTS_FOUR = menu.add_feature("Player 4","action_value_i",HEIST_CONTROL_DOOMSDAY_CUTS.id, function(V)
		SetPlayerCut("player 4",V.value)
	end)
	HEIST_CONTROL_DOOMSDAY_CUTS_FOUR.min = 0
	HEIST_CONTROL_DOOMSDAY_CUTS_FOUR.max = 150 
	HEIST_CONTROL_DOOMSDAY_CUTS_FOUR.mod = 10
end

--[[
	Extra
]]
local USER_MENU_EXTRA = menu.add_feature("Extra","parent",USER_MENU.id)

-- credits 
local MENU_CREDS = menu.add_feature("Credits","parent",USER_MENU_EXTRA.id)
menu.add_feature("You can thank Master for this menu!","action",MENU_CREDS.id,function()
end)
menu.add_feature("--------------------","action",MENU_CREDS.id,function()
end)
menu.add_feature("Thanks to Master's friend, Ngin, for giving Master some","action",MENU_CREDS.id,function()
end)
menu.add_feature("ideas!","action",MENU_CREDS.id,function()
end)

--[[
	player specific 
]]
local PS_OPTIONS = menu.add_player_feature("User0092's menu","parent",0)
menu.add_player_feature("VPN?","action",PS_OPTIONS.id,function(f,pid)
	if not is_https_trusted then 
		main.NotifyUser("HTTP trusted is required",5,"red")
		return
	end 
	local vpn= ipInfo.isVpn(pid)
	if vpn == nil then
		main.NotifyUser("Nil result",5,"red")
	elseif vpn == true then 
		main.NotifyUser("user has a vpn",5,"yellow")
	else 
		main.NotifyUser("user doesn't have a vpn",5,"green")
	end 
end)
--[[
	if is_https_trusted then
			local city,region,country,org,postal,timezone,vpn,IP,currency= ipInfo.GetIPinfo(chat_id)
			local pName = player.get_player_name(chat_id)
			local append_text = "{"..pName.."\n\t{\n\tCity: "..tostring(city).."\n\tRegion: "..tostring(region).."\n\tCountry: "..tostring(country).."\n\tISP: "..tostring(org).."\n\tPostal code (estimate): "..tostring(postal).."\n\tTimezone: "..tostring(timezone).."\n\tVPN: "..tostring(vpn).."\n\tCurrency: "..tostring(currency).."\n\tIP: "..tostring(IP).."\n\t}\n}"
			fs.write_file(dir.."Logs\\IPLog.txt","append",append_text)
		end 
]]
menu.add_player_feature("Log ip info","action",PS_OPTIONS.id,function(f,pid)
	if not is_https_trusted then 
		main.NotifyUser("HTTP trusted is required",5,"red")
		return
	end 
	if is_https_trusted then
		local city,region,country,org,postal,timezone,vpn,IP,currency,long,lat= ipInfo.GetIPinfo(pid)
		local pName = player.get_player_name(pid)
		local append_text = "{\""..pName.."\" = \n\t{\n\t\t{City: "..tostring(city).."}\n\t\t{Region: "..tostring(region).."}\n\t\t{Country: "..tostring(country).."}\n\t\t{ISP: "..tostring(org).."}\n\t\t{Postal code (estimate): "..tostring(postal).."}\n\t\t{Timezone: "..tostring(timezone).."}\n\t\t{VPN: "..tostring(vpn).."}\n\t\t{Currency: "..tostring(currency).."}\n\t\t{IP: "..tostring(IP).."}\n\t\t{Long: "..tostring(long).."}\n\t\t{Lat: "..tostring(lat).."}\n\t}\n}\n"
		fs.write_file(dir.."Logs\\IPLog.txt","append",append_text)
		main.NotifyUser("Logged "..pName.."'s info.",5,"green")
	end 
end )

--[[
	Hidden 
]]
-- player history 
event.add_event_listener("player_join", function(event)
	local pid = event.player
	local Pname,times,mType = requests.playerSeen(pid)
	if Pname then 
		main.NotifyUser("I have seen \""..Pname.."\" (" ..tonumber(times)..") times before\nDetection: "..mType,8,"yellow")
	end 
	requests.logPlayer(pid)
	if is_https_trusted 
	and pid ~= player.player_id() then
		local city,region,country,org,postal,timezone,vpn,IP,currency,long,lat= ipInfo.GetIPinfo(pid)
		local pName = player.get_player_name(pid)
		local append_text = "{\""..pName.."\" = \n\t{\n\t\t{City: "..tostring(city).."}\n\t\t{Region: "..tostring(region).."}\n\t\t{Country: "..tostring(country).."}\n\t\t{ISP: "..tostring(org).."}\n\t\t{Postal code (estimate): "..tostring(postal).."}\n\t\t{Timezone: "..tostring(timezone).."}\n\t\t{VPN: "..tostring(vpn).."}\n\t\t{Currency: "..tostring(currency).."}\n\t\t{IP: "..tostring(IP).."}\n\t\t{Long: "..tostring(long).."}\n\t\t{Lat: "..tostring(lat).."}\n\t}\n}\n"
		fs.write_file(dir.."Logs\\autoIPLog.txt","append",append_text)
	end 
end)

--Modder logs 
event.add_event_listener("modder", function(eventa)
	local pID = eventa.player
	local mFlag = requests.checkmflag(event.flag)
	local name,SCID,IP = requests.GetPlayerInfo(pID)
	local logText = "Modder: "..name.." | Flag: "..mFlag.." | SCID: "..SCID.." | IP: "..IP
	fs.write_file(dir.."Logs\\ModderLog.txt","append",logText)
end)




