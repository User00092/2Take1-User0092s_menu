local dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\"
local lib_dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\Lib\\"
local fs = require("User0092_menu/Lib/fs")
local globals = require("User0092_menu/Lib/globals")

 
function IPtoDec(IP)
    local fields = {}
    local pattern = string.format("([^%s]+)", ".")
    IP:gsub(pattern, function(c) fields[#fields+1] = c end)
    local ip_dec=0
    for i=1,4 do
        ip_dec=ip_dec+fields[i]* (256)^(3-i+1)
    end
    return ip_dec
end

function formatIP(ip)
  return string.format("%i.%i.%i.%i", (ip >> 24) & 0xff, ((ip >> 16) & 0xff), ((ip >> 8) & 0xff), ip & 0xff)
end

function GetPlayerInfo(pID)
	local name = player.get_player_name(pID)
	local SCID = player.get_player_scid(pID)
	local IP = formatIP(player.get_player_ip(pID))
	return name,SCID,IP
end

function CorrectPlayerName(pName)
	local name = pName:format("([^%s]+-)","")
	name = name:format(" ", "")
	return name
end 

function GetPlayerIDbyName(pName)
	local playerList = globals.GetPlayersList()
	for id, name in ipairs(playerList) do 
		if name[1] == pName then 
			return name[4]
		end 
	end 
	return false
end

function isWhitelisted(pid)
	local whitelist_list = fs.lines_from(lib_dir.."Data\\whitelist.txt")
	local pName,pSCID = player.get_player_name(pid),player.get_player_scid(pid)
	for id, name in ipairs(whitelist_list) do 
		name = name:gsub(" ", ""):sub(0, -2)
		local log = split(name, "|")
		if log[1] == pName
		or log[2] == pSCID then
			return true 
		end 
	end 
	return false
end 

function logPlayer(pid)
	if pid == player.player_id() then 
		return
	end 
	local pName,pSCID = player.get_player_name(pid),player.get_player_scid(pid)
	local formatedIP = formatIP(player.get_player_ip(pid))
	local append_text = pName .." | "..pSCID.." | " ..formatedIP.." | "..IPtoDec(formatedIP)
	fs.write_file(dir.."Logs\\playerLog.txt","append",append_text)
end 

function playerSeen(pid)
	local mType = ""
	local detections = {}
	local player_log = fs.lines_from(dir.."Logs\\playerLog.txt")
	local pName,pSCID = tostring(player.get_player_name(pid)),tostring(player.get_player_scid(pid))
	local formatedIP = formatIP(player.get_player_ip(pid))
	local DecIP = IPtoDec(formatedIP)
	for id, name in ipairs(player_log) do 
		name = name:gsub(" ", ""):sub(0, -2)
		local log = split(name, "|")
		if log[1] == tostring(pName)
		or log[2] == tostring(pSCID)
		or log[3] == tostring(formatedIP)
		or log[4] == tostring(DecIP) then 
			table.insert(detections,pName)
			if log[1] == pName then
				mType = "Name"
			elseif log[2] == pSCID then 
				mType = "SCID"
			elseif log[3] == formatedIP then 
				mType = "IP"
			elseif log[4] == DecIP then
				mType = "Decimal IP"
			else
				mType = "Invalid Type??"
			end 
		end 
	end 
	if #detections == 0 then
		return false
	end
	local logText = "\""..pName.."\" was in your game. I have seen them (".. #detections ..") times | "..mType
	fs.write_file(dir.."Logs\\historyLog.txt","append",logText)
	return pName, #detections, mType
end 
local modderflags= {
	{MDF_MANUAL = 1 << 0x00, "MDF_MANUAL"},
    {MDF_PLAYER_MODEL= 1 << 0x01,"MDF_PLAYER_MODEL"},
    {MDF_SCID_SPOOF = 1 << 0x02,"MDF_SCID_SPOOF"},
    {MDF_INVALID_OBJECT = 1 << 0x03,"MDF_INVALID_OBJECT"},
    {MDF_INVALID_PED_CRASH = 1 << 0x04,"MDF_INVALID_PED_CRASH"},
    {MDF_MODEL_CHANGE_CRASH=1 << 0x05,"MDF_MODEL_CHANGE_CRASH"},
    {MDF_PLAYER_MODEL_CHANGE = 1 << 0x06,"MDF_PLAYER_MODEL_CHANGE"},
    {MDF_RAC = 1 << 0x07,"MDF_RAC"},
    {MDF_MONEY_DROP = 1 << 0x08,"MDF_MONEY_DROP"},
    {MDF_SEP=1 << 0x09,"MDF_SEP"},
    {MDF_ATTACH_OBJECT=1 << 0x0A,"MDF_ATTACH_OBJECT"},
    {MDF_ATTACH_PED=1 << 0x0B,"MDF_ATTACH_PED"},
    {MDF_NET_ARRAY_CRASH=1 << 0x0C,"MDF_NET_ARRAY_CRASH"},
    {MDF_SYNC_CRASH=1 << 0x0D,"MDF_SYNC_CRASH"},
    {MDF_NET_EVENT_CRASH=1 << 0x0E,"MDF_NET_EVENT_CRASH"},
    {MDF_HOST_TOKEN=1 << 0x0F,"MDF_HOST_TOKEN"},
    {MDF_SE_SPAM=1 << 0x10,"MDF_SE_SPAM"},
    {MDF_INVALID_VEHICLE=1 << 0x11,"MDF_INVALID_VEHICLE"},
    {MDF_FRAME_FLAGS=1 << 0x12,"MDF_FRAME_FLAGS"},
    {MDF_IP_SPOOF=1 << 0x13,"MDF_IP_SPOOF"},
    {MDF_KAREN=1 << 0x14,"MDF_KAREN"},
    {MDF_SESSION_MISMATCH =1 << 0x15,"MDF_SESSION_MISMATCH"},
    {MDF_SOUND_SPAM =1 << 0x16,"MDF_SOUND_SPAM"},
    {MDF_SCID_NAME_MISMATCH=1 << 0x17,"MDF_SCID_NAME_MISMATCH"},
    {MDF_RAC2=1 << 0x18,"MDF_RAC2"},
    {MDF_SEP_INT=1 << 0x19,"MDF_SEP_INT"},
    {MDF_SUSPICIOUS_ACTIVITY= 1 << 0x1A,"MDF_SUSPICIOUS_ACTIVITY"},

    {MDF_ENDS = 1 << 0x1B,"MDF_ENDS"}
}


function checkmflag(mflag)
	for id, flag in ipairs(modderflags) do 
		if mflag == flag[1] then 
			return flag[2]
		end
	end 
	return "Invalid"
end 
return {
	GetPlayerInfo = GetPlayerInfo,
	GetPlayerIDbyName = GetPlayerIDbyName,
	isWhitelisted = isWhitelisted,
	formatIP = formatIP,
	IPtoDec = IPtoDec,
	logPlayer = logPlayer,
	playerSeen = playerSeen,
	CorrectPlayerName = CorrectPlayerName,
	checkmflag = checkmflag
}