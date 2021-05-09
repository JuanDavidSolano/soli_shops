local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
locations = {}

Citizen.CreateThread(function()
    TriggerEvent("soli_shops:setShopsCoords")

    while true do
        Citizen.Wait(0)
        
        for i = 1 ,#locations,1 do
            local x = json.decode(locations[i].coords).x
            local y = json.decode(locations[i].coords).y
            local z = json.decode(locations[i].coords).z
            DrawMarker(29,x,y,z - 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 180, 0, 200, false, true, 2, false, false, false, false)
            DrawMarker(23,x,y,z - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 180, 0, 200, false, true, 2, false, false, false, false)
        end

    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPos = GetEntityCoords(PlayerPedId())
        local nearShopInfo = playerNearShop()
        if nearShopInfo.near then
            ESX.ShowFloatingHelpNotification("Press  ~INPUT_PICKUP~to open the shop", vector3(playerPos.x,playerPos.y,playerPos.z))
            if IsControlJustPressed(0,38) then
                openShop(nearShopInfo.id)
            end
        end
    end
end)

RegisterNetEvent('soli_shops:createShop')
AddEventHandler('soli_shops:createShop', function()
    TriggerEvent('chat:addMessage', {
        args = { 'Opening the shop creator' }
    })
    openShopCreator()
end)

RegisterNetEvent('soli_shops:showItems')
AddEventHandler('soli_shops:showItems', function(data)
    SendNUIMessage({type='updateItemList', data=data})
end)

RegisterNetEvent('soli_shops:setShopsCoords')
AddEventHandler('soli_shops:setShopsCoords',function(data)
    ESX.TriggerServerCallback('soli_shops:getShopsLocations', function(result, count)
        locations = result
    end)
end)

function openShopCreator()
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'creator'})
end

function openShop(idshop)
    ESX.TriggerServerCallback('soli_shops:getShopInfo', function(result, count)
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'shop'})
        Citizen.Wait(0)
        SendNUIMessage({type='updateShopUiInfo', data=result})
    end, idshop)
end

function closeShopCreator()
    SetNuiFocus(false)
    SendNUIMessage({type='exit'})
end

RegisterNUICallback("exit", function()
    closeShopCreator()
end)

RegisterNUICallback("create", function(data)
    local pos = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("soli_shops:addShop", data.name, pos, data.items)
end)

function playerNearShop()
    local playerPos = GetEntityCoords(PlayerPedId())
    for _, search in pairs(locations) do
        local decoded = json.decode(search.coords)
        local dist = Vdist(decoded.x,decoded.y,decoded.z, playerPos.x,playerPos.y,playerPos.z)
        if dist <= 1.0 then
            local data = {}
            data["near"] = true
            data["id"] = search.id
            return data
        end
    end
    local data = {}
    data["near"] = false
    return data
end