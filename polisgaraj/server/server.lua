local QBCore = exports['qb-core']:GetCoreObject()

local InMenu = false

local function DiscordLog(message)
    local embed = {
        {
            ["color"] = 04255, 
            ["title"] = "CloudDevelopment Police Garage",
            ["description"] = message,
            ["url"] = "https://discord.gg/e4AYS3VE",
            ["footer"] = {
            ["text"] = "By CloudDevelopment",
            ["icon_url"] = Config.LogsImage
        },
            ["thumbnail"] = {
                ["url"] = Config.LogsImage,
            },
    }
}
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = '', embeds = embed, avatar_url = Config.LogsImage}), { ['Content-Type'] = 'application/json' })
end

QBCore.Functions.CreateCallback(':CheckIfActive', function(source, cb)
    local src = source

    if not InMenu then
        TriggerEvent(":server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Biri zaten menüde, lütfen bekleyin !", "error")
    end
end)

RegisterNetEvent(':server:SetActive', function(status)
    if status ~= nil then
        InMenu = status
        TriggerClientEvent(':client:SetActive', -1, InMenu)
    else
        TriggerClientEvent(':client:SetActive', -1, InMenu)
    end
end)

QBCore.Functions.CreateCallback('CL-emsGarage:CheckIfActive', function(source, cb)
    local src = source

    if not InMenu then
        TriggerEvent("CL-emsGarage:server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Biri zaten menüde, lütfen bekleyin !", "error")
    end
end)


QBCore.Functions.CreateCallback('CL-emsHeli:CheckIfActive', function(source, cb)
    local src = source

    if not InMenu then
        TriggerEvent("CL-emsHeli:server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Biri zaten menüde, lütfen bekleyin !", "error")
    end
end)


QBCore.Functions.CreateCallback('CL-pdHeli:CheckIfActive', function(source, cb)
    local src = source

    if not InMenu then
        TriggerEvent("CL-pdHeli:server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Biri zaten menüde, lütfen bekleyin !", "error")
    end
end)

RegisterNetEvent('CL-emsGarage:server:SetActive', function(status)
    if status ~= nil then
        InMenu = status
        TriggerClientEvent('CL-emsGarage:client:SetActive', -1, InMenu)
    else
        TriggerClientEvent('CL-emsGarage:client:SetActive', -1, InMenu)
    end
end)


RegisterNetEvent('CL-emsHeli:server:SetActive', function(status)
    if status ~= nil then
        InMenu = status
        TriggerClientEvent('CL-emsHeli:client:SetActive', -1, InMenu)
    else
        TriggerClientEvent('CL-emsHeli:client:SetActive', -1, InMenu)
    end
end)

RegisterNetEvent('CL-pdHeli:server:SetActive', function(status)
    if status ~= nil then
        InMenu = status
        TriggerClientEvent('CL-pdHeli:client:SetActive', -1, InMenu)
    else
        TriggerClientEvent('CL-pdHeli:client:SetActive', -1, InMenu)
    end
end)

RegisterServerEvent(":AddVehicleSQL", function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)

RegisterServerEvent("CL-emsGarage:AddVehicleSQL", function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)


RegisterServerEvent("CL-emsHeli:AddVehicleSQL", function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)

RegisterServerEvent("CL-pdHeli:AddVehicleSQL", function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)

RegisterServerEvent(':TakeMoney', function(paymenttype, price, vehiclename, vehicle)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local Steamname = GetPlayerName(src)
    if Player.Functions.GetMoney(paymenttype) >= price then
        TriggerClientEvent(":SpawnVehicle", src, vehicle)  
        Player.Functions.RemoveMoney(paymenttype, price)
        TriggerClientEvent('QBCore:Notify', src, 'Araç başarıyla satın alındı', "success")    
        DiscordLog('New Vehicle Bought By: **'..Steamname..'** ID: **' ..source.. '** Bought: **' ..vehiclename.. '** For: **' ..price.. '$**') 
    else
        TriggerClientEvent('QBCore:Notify', src, 'Yeterli miktarda paran yok !', "error")              
    end    
end)


RegisterServerEvent('CL-emsGarage:TakeMoney', function(paymenttype, price, vehiclename, vehicle)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local Steamname = GetPlayerName(src)
    if Player.Functions.GetMoney(paymenttype) >= price then
        TriggerClientEvent("CL-emsGarage:SpawnVehicle", src, vehicle)  
        Player.Functions.RemoveMoney(paymenttype, price)
        TriggerClientEvent('QBCore:Notify', src, 'Araç başarıyla satın alındı', "success")    
        DiscordLog('New Vehicle Bought By: **'..Steamname..'** ID: **' ..source.. '** Bought: **' ..vehiclename.. '** For: **' ..price.. '$**') 
    else
        TriggerClientEvent('QBCore:Notify', src, 'Yeterli miktarda paran yok !', "error")              
    end    
end)


RegisterServerEvent('CL-emsHeli:TakeMoney', function(paymenttype, price, vehiclename, vehicle)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local Steamname = GetPlayerName(src)
    if Player.Functions.GetMoney(paymenttype) >= price then
        TriggerClientEvent("CL-emsHeli:SpawnVehicle", src, vehicle)  
        Player.Functions.RemoveMoney(paymenttype, price)
        TriggerClientEvent('QBCore:Notify', src, 'Araç başarıyla satın alındı', "success")    
        DiscordLog('New Vehicle Bought By: **'..Steamname..'** ID: **' ..source.. '** Bought: **' ..vehiclename.. '** For: **' ..price.. '$**') 
    else
        TriggerClientEvent('QBCore:Notify', src, 'Yeterli miktarda paran yok !', "error")              
    end    
end)


RegisterServerEvent('CL-pdHeli:TakeMoney', function(paymenttype, price, vehiclename, vehicle)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local Steamname = GetPlayerName(src)
    if Player.Functions.GetMoney(paymenttype) >= price then
        TriggerClientEvent("CL-pdHeli:SpawnVehicle", src, vehicle)  
        Player.Functions.RemoveMoney(paymenttype, price)
        TriggerClientEvent('QBCore:Notify', src, 'Araç başarıyla satın alındı', "success")    
        DiscordLog('New Vehicle Bought By: **'..Steamname..'** ID: **' ..source.. '** Bought: **' ..vehiclename.. '** For: **' ..price.. '$**') 
    else
        TriggerClientEvent('QBCore:Notify', src, 'Yeterli miktarda paran yok !', "error")              
    end    
end)
-- QBCore.Commands.Add('prepair', 'Repair Your Police Vehicle (Can Be Used Only In The Police Station)', {}, false, function(source, args)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     if Player.PlayerData.job.name == 'police' then
--         TriggerClientEvent(":CheckZone", src)
--     else
--         TriggerClientEvent('QBCore:Notify', src, 'You are not a police officer.', "error")              
--     end
-- end)