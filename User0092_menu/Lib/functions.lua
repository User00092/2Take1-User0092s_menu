function GetkdRatiowithKills(value)
	local KD_RATIO_DEATHS_HASH= gameplay.get_hash_key("MPPLY_DEATHS_PLAYER")
	local KD_RATIO_DEATHS = stats.stat_get_int(KD_RATIO_DEATHS_HASH,-1)
	local KD_RATIO = tonumber(value) / tonumber(KD_RATIO_DEATHS)
	local KD_RATIO = string.format("%.2f", tostring(KD_RATIO))
	return KD_RATIO
end 
function GetkdRatiowithDeaths(value)
	local KD_RATIO_KILLS_HASH= gameplay.get_hash_key("MPPLY_KILLS_PLAYERS")
	local KD_RATIO_KILLS = stats.stat_get_int(KD_RATIO_KILLS_HASH,-1)
	local KD_RATIO = tonumber(KD_RATIO_KILLS) / tonumber(value)
	local KD_RATIO = string.format("%.2f", tostring(KD_RATIO))
	return KD_RATIO
end 
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
	local playernum = player.player_count() 
	local players = {}
	for i = 0,playernum do 
		if player.is_player_valid(i) then 
			local playerName = player.get_player_name(i)
			table.insert(players,playerName)
		end
	end 
	return players
end
function GetPlayers()
	local playernum = player.player_count() 
	local players = 0
	for i = 0,playernum do 
		if player.is_player_valid(i) then 
			players = players +1 
		end
	end 
	return players
end

function GiveSelfBadsport()
	stat_set_int("MPPLY_BADSPORT_MESSAGE", false,-1)
	stat_set_int("MPPLY_BECAME_BADSPORT_NUM", false, -1)
	stat_set_float("MPPLY_OVERALL_BADSPORT",false,60000)
	stat_set_bool("MPPLY_CHAR_IS_BADSPORT",false,true)
end
function RemoveSelfBadsport()
	stat_set_int("MPPLY_BADSPORT_MESSAGE", false,0)
	stat_set_int("MPPLY_BECAME_BADSPORT_NUM", false, 0)
	stat_set_float("MPPLY_OVERALL_BADSPORT",false,0)
	stat_set_bool("MPPLY_CHAR_IS_BADSPORT",false,false)
end

function GiveAllWeapons(ped)
	local weaponHash = weapon.get_all_weapon_hashes()
	local pedHash = player.get_player_ped(ped)
	weapon.remove_all_ped_weapons(pedHash)
	for id, hash in ipairs(weaponHash) do 
		weapon.give_delayed_weapon_to_ped(pedHash, hash, 0, false)
	end 
end

function TeleportPlayer(playerid,coords)
	local ped = player.get_player_ped(playerid)
	entity.set_entity_coords_no_offset(ped,coords)
end
return {
	GetkdRatiowithKills = GetkdRatiowithKills,
	GetkdRatiowithDeaths = GetkdRatiowithDeaths, 
	stat_set_bool = stat_set_bool, 
	stat_set_int = stat_set_int,
	stat_set_float = stat_set_float,
	stat_get_bool = stat_get_bool,
	stat_get_int = stat_get_int,
	stat_get_float = stat_get_float,
	GetPlayersList = GetPlayersList,
	GetPlayers = GetPlayers,
	GiveSelfBadsport = GiveSelfBadsport,
	RemoveSelfBadsport = RemoveSelfBadsport,
	GiveAllWeapons = GiveAllWeapons,
	TeleportPlayer = TeleportPlayer
}