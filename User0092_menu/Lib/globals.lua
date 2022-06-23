local requests = require("User0092_menu/Lib/requests")

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

function stat_get_bool(hash, prefix)
	local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
	local bool = stats.stat_get_bool(hash0, -1)
	if prefix then
        local bool = stats.stat_get_bool(hash1, -1)
    end
	return bool
end 

function stat_get_int(hash, prefix)
	local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
	local value = stats.stat_get_int(hash0, -1)
	if prefix then
        local value = stats.stat_get_int(hash1, -1)
    end
	return value
end 

function stat_get_float(hash, prefix)
	local hash0, hash1 = hash
    if prefix then
        hash0 = "MP0_" .. hash
        hash1 = "MP1_" .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
	local value = stats.stat_get_float(hash0, -1)
	if prefix then
        local value = stats.stat_get_float(hash1, -1)
    end
	return value
end

function GetPlayersList()
	local players = {}
	for i = 0,31 do 
		if player.is_player_valid(i) then 
			local playerName = player.get_player_name(i)
			local playerSCID = player.get_player_scid(i)
			local playerIP = requests.formatIP(player.get_player_ip(i))
			table.insert(players,{playerName,playerSCID,playerIP,i})
		end
	end 
	local playerName = player.get_player_name(player.player_id())
	local playerSCID = player.get_player_scid(player.player_id())
	local playerIP = requests.formatIP(player.get_player_ip(player.player_id()))
	table.insert(players,{playerName,playerSCID,playerIP,player.player_id()})
	return players
end
function GetPlayers()
	local players = 0
	for i = 0,31 do 
		if player.is_player_valid(i) then 
			players = players +1 
		end
	end 
	return players
end
function TeleportPlayer(playerid,coords)
	local ped = player.get_player_ped(playerid)
	entity.set_entity_coords_no_offset(ped,coords)
end
function GiveAllWeapons(ped)
	local targetName = player.get_player_name(ped)
	local weaponHash = weapon.get_all_weapon_hashes()
	local pedHash = player.get_player_ped(ped)
	for id, hash in ipairs(weaponHash) do 
		if not weapon.has_ped_got_weapon(pedHash, hash) then 
			weapon.give_delayed_weapon_to_ped(pedHash, hash, 0, false)
			local x, Mammo = weapon.get_max_ammo(pedHash, hash)
			weapon.set_ped_ammo(pedHash, hash, Mammo)
		end
	end 
	menu.notify("Gave all weapons to "..targetName,"Successful Operation",3,0x008000)
end
function RemoveAllWeapons(ped)
	local targetName = player.get_player_name(ped)
	local pedHash = player.get_player_ped(ped)
	weapon.remove_all_ped_weapons(pedHash)
	menu.notify("Removed all weapons from "..targetName,"Successful Operation",3,0x008000)
end 
function split(s, delimiter)
	local result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end

function placeCam(pid)
	local cam_ = native.call(0xB51194800B257161, "DEFAULT_SCRIPTED_CAMERA", 0, 0, 0, 0, 0, 0, 0, 1, 1):__tointeger()
	native.call(0x07E5B515DB0636FC, 1, 0, 0, 0, 0)
	native.call(0xFEDB7D269E8C60E3, cam_, player.get_player_ped(pid), 0, 0, 0, 0)
	return cam_
end 

function destroyCam(cam_)
	native.call(0x07E5B515DB0636FC, 0, 0, 0, 0, 0)
	native.call(0x865908C81A2C22E9, cam_, 0)
end 	

return {
	GetPlayersList = GetPlayersList,
	GetPlayers = GetPlayers,
	stat_set_bool = stat_set_bool, 
	stat_set_int = stat_set_int,
	stat_set_float = stat_set_float,
	stat_get_bool = stat_get_bool,
	stat_get_int = stat_get_int,
	stat_get_float = stat_get_float,
	GiveAllWeapons = GiveAllWeapons,
	TeleportPlayer = TeleportPlayer,
	RemoveAllWeapons = RemoveAllWeapons,
	split = split,
	placeCam = placeCam,
	destroyCam = destroyCam
}