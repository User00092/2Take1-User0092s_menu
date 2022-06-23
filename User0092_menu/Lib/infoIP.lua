local main = require("User0092_menu/Lib/main")
local requests = require("User0092_menu/Lib/requests")
local globals = require("User0092_menu/Lib/globals")
local fs = require("User0092_menu/Lib/fs")
local LUA_TRUST_HTTP = 1 << 3
local dir = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\User0092_menu\\"
local is_https_trusted = menu.is_trusted_mode_enabled(LUA_TRUST_HTTP)
-- Put on hold

--[[
{"status":"success","continent":"Europe","continentCode":"EU","country":"Netherlands","countryCode":"NL","region":"UT","regionName":"Utrecht","city":"Utrecht","district":"","zip":"3512","lat":52.0907,"lon":5.12142,"timezone":"Europe/Amsterdam","offset":7200,"currency":"EUR","isp":"SURFnet bv","org":"SURFnet bv","as":"","asname":"","mobile":false,"proxy":false,"hosting":false,"query":"145.6.237.163"}
]]

function GetIPinfo(pid)
    if not is_https_trusted then 
        return false 
    end
    local city,region,country,org,postal,timezone,vpn,currency,long,lat= "Failed"
    local IP = requests.formatIP(player.get_player_ip(pid))
    local link = "http://demo.ip-api.com/json/"..tostring(IP).."?fields=66842623&lang=en"
    local x, raw = web.get(link)
    if raw ~= nil then 
        local response = globals.split(raw,",")
        for id, data in ipairs(response) do 
            local log = globals.split(data,":")
            if log[1]:match("city") then 
                city = tostring(log[2])
            elseif log[1]:match("region") then 
                region = tostring(log[2])
            elseif log[1]:match("country") then 
                country = tostring(log[2])
            elseif log[1]:match("isp") then 
                org = tostring(log[2])
            elseif log[1]:match("zip") then 
                postal = tostring(log[2])
            elseif log[1]:match("timezone") then 
                timezone = tostring(log[2])
            elseif log[1]:match("proxy") then 
                vpn = tostring(log[2])
            elseif log[1]:match("currency") then 
                currency = tostring(log[2])
            elseif log[1]:match("lat") then
                lat = tostring(log[2])
            elseif log[1]:match("lon") then 
                long = tostring(log[2])
            end  
        end 
    end 
    return city,region,country,org,postal,timezone,vpn,IP,currency,long,lat
end 

function isVpn(pid)
    if not is_https_trusted then 
        return false
    end 
    local proxy = "Nil"
    local IP = requests.formatIP(player.get_player_ip(pid))
    local link = "http://demo.ip-api.com/json/"..tostring(IP).."?fields=66842623&lang=en"
    local x, raw = web.get(link)
    if raw ~= nil then 
        local response = globals.split(raw,",")
        for id, data in ipairs(response) do 
            local log = globals.split(data,":")
            if log[1]:match("proxy") then 
                proxy = log[2]
                if proxy:match("true") then 
                    return true 
                else 
                    return false 
                end 
            end 
        end 
        
    else 
        menu.notify("nil response")
    end 
end 
return {
    GetIPinfo = GetIPinfo,
    isVpn = isVpn
}

--[[
function(f, pid)
    pIp = dec_to_ipv4(player.get_player_ip(pid))
    statusCode, response = web.get("https://proxycheck.io/v2/"..pIp)
    if response ~= nil then
        for k, v in pairs(json.decode(response)) do
            if v.proxy ~= nil then
                if v.proxy == "no" then
                    menu.notify"Player is not using VPN/Proxy"
                else
                    menu.notify"Player is using a VPN/Proxy"
                end
            end
        end
    end
end

]]