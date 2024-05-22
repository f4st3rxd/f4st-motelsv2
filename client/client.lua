local QBCore = exports['qb-core']:GetCoreObject()
local InRoom = false 
local InZone = false 

CreateThread(function()
    if FastMotels.Blips then 
        fastmotels = AddBlipForCoord(FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z)
        SetBlipSprite(fastmotels, FastMotels.BlipSprite)
        SetBlipDisplay(fastmotels, 4)
        SetBlipScale(fastmotels, FastMotels.BlipScale)
        SetBlipColour(fastmotels, FastMotels.BlipColour)
        SetBlipAsShortRange(fastmotels, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Motel")
        EndTextCommandSetBlipName(fastmotels)
    end
end)

CreateThread(function()
    while true do 
        local sleep = 2000
        local distance = #(FastMotels.MotelCoords - GetEntityCoords(PlayerPedId()))
        if distance <= 7 then 
            InZone = true 
            sleep = 1
            DrawMarker(2, FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.70, 0.70, 0.70, 255, 0, 0, 50, false, true, 2, nil, nil, false)
            if distance <= 2 then 
                QBCore.Functions.DrawText3D(FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z, "[E] - Motel Menüsü")
                if IsControlJustPressed(0, 38) then 
                    TriggerEvent("f4st-motels:openMotelMenu")
                end
            end
        end
        Wait(sleep)
    end
end)



RegisterNetEvent("f4st-motels:openMotelMenu")
AddEventHandler("f4st-motels:openMotelMenu", function()
    if InZone then 
        exports['qb-menu']:openMenu({
            {
                header = 'Motel Menüsü',
                icon = 'fas fa-hotel',
                isMenuHeader = true, 
            },
    
            {
                header = 'Odana Gir',
                txt = 'Sahip olduğunuz motel odasına girer',
                icon = 'fas fa-key',
                params = {
                    event = 'f4st-motels:enterRoom'
                }
            },
            {
                header = 'Motel Odası Satın Al',
                txt = 'Yeni motel odası satın almanızı sağlar',
                icon = 'fas fa-sack-dollar',
                params = {
                    event = 'f4st-motels:buyRoomMenu'
                }
            },
            {
                header = 'Menüyü Kapat',
                txt = 'Motel menüsünü kapatır',
                icon = 'fas fa-right-to-bracket',
                params = {
                    event = ''
                }
            },
            
        })
    end
end)

RegisterNetEvent("f4st-motels:buyRoomMenu")
AddEventHandler("f4st-motels:buyRoomMenu", function()
    if InZone then
    exports['qb-menu']:openMenu({
        {
            header = 'Oda Satın Alım Menüsü',
            icon = 'fas fa-hotel',
            isMenuHeader = true, 
        },
        {
            header = 'Basit Motel Odası',
            txt = 'Ücret: '.. tostring(FastMotels.BasicRoomPrice) .. " $",
            icon = 'fas fa-sack-dollar',
            params = {
                event = 'f4st-motels:buyBasicRoom'
            }
        },
        {
            header = 'Orta Motel Odası',
            txt = 'Ücret: '.. tostring(FastMotels.Room1Price) .. " $",
            icon = 'fas fa-sack-dollar',
            params = {
                event = 'f4st-motels:buyRoom1'
            }
        },
        {
            header = 'Büyük Motel Odası',
            txt = 'Ücret: '.. tostring(FastMotels.Room2Price) .. " $",
            icon = 'fas fa-sack-dollar',
            params = {
                event = 'f4st-motels:buyRoom2'
            }
        },
        {
            header = 'Geri dön',
            txt = 'Motel menüsüne geri döner',
            icon = 'fas fa-right-to-bracket',
            params = {
                event = "f4st-motels:openMotelMenu"
            }
        },
    })
    end
end)

RegisterNetEvent("f4st-motels:buyBasicRoom")
AddEventHandler("f4st-motels:buyBasicRoom", function()
    TriggerServerEvent("f4st-motels:buyRoom", "basic")
end)

RegisterNetEvent("f4st-motels:buyRoom1")
AddEventHandler("f4st-motels:buyRoom1", function()
    TriggerServerEvent("f4st-motels:buyRoom", "room1")
end)

RegisterNetEvent("f4st-motels:buyRoom2")
AddEventHandler("f4st-motels:buyRoom2", function()
    TriggerServerEvent("f4st-motels:buyRoom", "room2")
end)

function OpenMotelStash()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if FastMotels.Inventory == "qb" then 
        TriggerEvent("inventory:client:SetCurrentStash", "Motel_"..PlayerData.citizenid)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Motel_"..PlayerData.citizenid)
    elseif FastMotels.Inventory == "ox" then
        TriggerServerEvent("f4st-motels:registerstash", "Motel_"..PlayerData.citizenid) 
        exports.ox_inventory:openInventory('stash', {id = "Motel_"..PlayerData.citizenid, owner = PlayerData.citizenid})
    else 
        return 
    end 
end

function OpenOutfitMenu()
    TriggerEvent("qb-clothing:client:openOutfitMenu")
end

function ExitRoom()
    InRoom = false 
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z, false)
    SetEntityHeading(PlayerPedId(), 140.69)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
    TriggerServerEvent("f4st-motels:ExitRoom")
end

function BasicRoom()
    InRoom = true 
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.BasicRoomCoords.x, FastMotels.BasicRoomCoords.y, FastMotels.BasicRoomCoords.z, false)
    SetEntityHeading(PlayerPedId(), 171.61)
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
end

function Room1()
    InRoom = true 
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.Room1Coords.x, FastMotels.Room1Coords.y, FastMotels.Room1Coords.z, false)
    SetEntityHeading(PlayerPedId(), 0.19)
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
end 

function Room2()
    InRoom = true 
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.Room2Coords.x, FastMotels.Room2Coords.y, FastMotels.Room2Coords.z, false)
    SetEntityHeading(PlayerPedId(), 353.9)
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
end 

RegisterNetEvent("f4st-motels:enterRoom")
AddEventHandler("f4st-motels:enterRoom", function()
    TriggerServerEvent("f4st-motels:datacheck")
end)

RegisterNetEvent("f4st-motels:teleportRoom")
AddEventHandler("f4st-motels:teleportRoom", function(motel_type_data)
    local motel_type = motel_type_data
    --print(motel_type)
    if motel_type == "basic" then 
        BasicRoom()
    elseif motel_type == "room1" then 
        Room1()
    elseif motel_type == "room2" then 
        Room2()
    else
        print("[DEBUG]: data bulunamadi")
        QBCore.Functions.Notify("Motel datanız bulunamadı sunucu sahibi ile iletisime gecin", "error", 5000)
    end 
end)

CreateThread(function()
    while true do 
        local sleep = 1000
        local distance = #(FastMotels.BasicRoomStash - GetEntityCoords(PlayerPedId()))
        if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.BasicRoomStash.x, FastMotels.BasicRoomStash.y, FastMotels.BasicRoomStash.z, "[E] - Depo")
                if IsControlJustPressed(0, 38) then 
                    OpenMotelStash()
                end
            end
        end
        Wait(sleep)
    end 
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.BasicRoomOutfit - GetEntityCoords(PlayerPedId()))
        if InRoom then 
            if distance <= 2 then 
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.BasicRoomOutfit.x, FastMotels.BasicRoomOutfit.y, FastMotels.BasicRoomOutfit.z, "[E] - Kıyafet Dolabı")
                if IsControlJustPressed(0, 38) then 
                    OpenOutfitMenu()
                end
            end
        end
        Wait(sleep)
    end 
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.BasicRoomDoor - GetEntityCoords(PlayerPedId()))
        if InRoom then 
            if distance <= 2 then 
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.BasicRoomDoor.x, FastMotels.BasicRoomDoor.y, FastMotels.BasicRoomDoor.z, "[E] - Odadan Çık")
                if IsControlJustPressed(0, 38) then 
                    ExitRoom()
                end
            end
        end
        Wait(sleep)
    end 
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.Room1DoorCoords - GetEntityCoords(PlayerPedId()))
        if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.Room1DoorCoords.x, FastMotels.Room1DoorCoords.y, FastMotels.Room1DoorCoords.z, "[E] - Odadan Çık")
                if IsControlJustPressed(0, 38) then 
                    ExitRoom()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.Room1Stash - GetEntityCoords(PlayerPedId()))

        if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.Room1Stash.x, FastMotels.Room1Stash.y, FastMotels.Room1Stash.z, "[E] - Depo")
                if IsControlJustPressed(0, 38) then 
                    OpenMotelStash()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.Room1Outfit - GetEntityCoords(PlayerPedId()))

        if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.Room1Outfit.x, FastMotels.Room1Outfit.y, FastMotels.Room1Outfit.z, "[E] - Kıyafet Dolabı")
                if IsControlJustPressed(0, 38) then 
                    OpenOutfitMenu()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.Room2DoorCoords - GetEntityCoords(PlayerPedId()))
        -- if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.Room2DoorCoords.x, FastMotels.Room2DoorCoords.y, FastMotels.Room2DoorCoords.z, "[E] - Odadan Çık")
                if IsControlJustPressed(0, 38) then 
                    ExitRoom()
                end
            end
        -- end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.Room2Stash - GetEntityCoords(PlayerPedId()))
        if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.Room2Stash.x, FastMotels.Room2Stash.y, FastMotels.Room2Stash.z, "[E] - Depo")
                if IsControlJustPressed(0, 38) then 
                    OpenMotelStash()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do 
        local sleep = 1000 
        local distance = #(FastMotels.Room2Outfit - GetEntityCoords(PlayerPedId()))

        if InRoom then 
            if distance <= 2 then 
                sleep = 1 
                QBCore.Functions.DrawText3D(FastMotels.Room2Outfit.x, FastMotels.Room2Outfit.y, FastMotels.Room2Outfit.z, "[E] - Kıyafet Dolabı")
                if IsControlJustPressed(0, 38) then 
                    OpenOutfitMenu()
                end
            end
        end
        Wait(sleep)
    end
end)
