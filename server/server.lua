local QBCore = exports['qb-core']:GetCoreObject()
local Rooms = {}

RegisterServerEvent("f4st-motels:datacheck")
AddEventHandler("f4st-motels:datacheck", function()
    local src = source 
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local PlayerCitizenID = xPlayer.PlayerData.citizenid 
    local motel_type_data = nil 

    
    MySQL.scalar('SELECT `motel_type` FROM `players` WHERE `citizenid` = ? LIMIT 1', {
        PlayerCitizenID
    }, function(motel_type)
        motel_type_data = motel_type 
        --print(motel_type_data)
        TriggerEvent("f4st-motels:server:teleportRoom", src, motel_type_data) 
    end)
end)

RegisterServerEvent("f4st-motels:buyRoom")
AddEventHandler("f4st-motels:buyRoom", function(motel_type)
    local src = source
    local motel_type_data = motel_type 
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local PlayerCash = xPlayer.Functions.GetMoney("cash")
    local PlayerBank = xPlayer.Functions.GetMoney("bank")

    if motel_type_data == "basic" then 
        if FastMotels.BasicRoomPrice <= PlayerCash then 
            xPlayer.Functions.RemoveMoney("cash", FastMotels.BasicRoomPrice, "Basit motel odası satın alındı")
            TriggerEvent("f4st-motels:addDatabase", src, "basic") 
            TriggerClientEvent("QBCore:Notify", src, "Başarıyla basit motel odası satın aldınız!", "success", 3000)
        elseif FastMotels.BasicRoomPrice <= PlayerBank then 
            xPlayer.Functions.RemoveMoney("bank", FastMotels.BasicRoomPrice, "Basit motel odası satın alındı")
            TriggerEvent("f4st-motels:addDatabase", src, "basic") 
            TriggerClientEvent("QBCore:Notify", src, "Başarıyla basit motel odası satın aldınız!", "success", 3000)
        else 
            TriggerClientEvent("QBCore:Notify", src, "Yeterli paranız bulunmamakta", "error", 3000)
        end
    elseif motel_type_data == "room1" then 
        if FastMotels.Room1Price <= PlayerCash then 
            xPlayer.Functions.RemoveMoney("cash", FastMotels.Room1Price, "Orta motel odası satın alındı")
            TriggerEvent("f4st-motels:addDatabase", src, "room1") 
            TriggerClientEvent("QBCore:Notify", src, "Başarıyla orta motel odası satın aldınız!", "success", 3000)
        elseif FastMotels.Room1Price <= PlayerBank then 
            xPlayer.Functions.RemoveMoney("bank", FastMotels.Room1Price, "Orta motel odası satın alındı")
            TriggerEvent("f4st-motels:addDatabase", src, "room1") 
            TriggerClientEvent("QBCore:Notify", src, "Başarıyla orta motel odası satın aldınız!", "success", 3000)
        else 
            TriggerClientEvent("QBCore:Notify", src, "Yeterli paranız bulunmamakta", "error", 3000)
        end
    elseif motel_type_data == "room2" then 
        if FastMotels.Room2Price <= PlayerCash then 
            xPlayer.Functions.RemoveMoney("cash", FastMotels.Room2Price, "Büyük motel odası satın alındı")
            TriggerEvent("f4st-motels:addDatabase", src, "room2") 
            TriggerClientEvent("QBCore:Notify", src, "Başarıyla büyük motel odası satın aldınız!", "success", 3000)
        elseif FastMotels.Room2Price <= PlayerBank then 
            xPlayer.Functions.RemoveMoney("bank", FastMotels.Room2Price, "Büyük motel odası satın alındı")
            TriggerClientEvent("QBCore:Notify", src, "Başarıyla büyük motel odası satın aldınız!", "success", 3000)
            TriggerEvent("f4st-motels:addDatabase", src, "room2") 
        else 
            TriggerClientEvent("QBCore:Notify", src, "Yeterli paranız bulunmamakta", "error", 3000)
        end
    end
end)

RegisterServerEvent("f4st-motels:addDatabase")
AddEventHandler("f4st-motels:addDatabase", function(source, motel_type)
    local src = source 
    local motel_type_data = motel_type
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local PlayerCitizenID = xPlayer.PlayerData.citizenid 
    
    local query = "UPDATE players SET motel_type = ? WHERE citizenid = ?"
    local values = {motel_type_data, PlayerCitizenID}
    MySQL.Async.execute(query, values, function(rowsChanged) end)
end)    

RegisterServerEvent("f4st-motels:server:teleportRoom")
AddEventHandler("f4st-motels:server:teleportRoom", function(source, motel_type)
    local src = source
    local motel_type_data = motel_type

    local bucket = getFirstBucket()
    if bucket < 64 then
        Rooms[src] = bucket
        SetPlayerRoutingBucket(src, Rooms[src])
        TriggerClientEvent("f4st-motels:teleportRoom", src, motel_type_data)
    else
        TriggerClientEvent("QBCore:Notify", source, "Şu anda müsait oda bulunmamakta!", "error")
    end
end)


function getFirstBucket()
    local i = 1
    repeat
        local founded = false
        for k, v in pairs(Rooms) do
            if Rooms[k] == i then
                founded = true
                i=i+1
                break
            end
        end
    until not founded
    return i
end

AddEventHandler('playerDropped', function(_)
    Rooms[source] = nil
end)

RegisterServerEvent('f4st-motels:ExitRoom')
AddEventHandler('f4st-hooker:ExitRoom', function(id)
    local src = source
    Rooms[src] = nil
    SetPlayerRoutingBucket(src, 0)
end)