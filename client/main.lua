ESX = nil
locations = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

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
            ESX.ShowFloatingHelpNotification("Press  ~INPUT_PICKUP~to open the shop", vector3(x,y,z))
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

function closeShopCreator()
    SetNuiFocus(false)
    SendNUIMessage({type='exit'})
end

RegisterNUICallback("exit", function()
    closeShopCreator()
end)

RegisterNUICallback("create", function(data)
    local pos = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("soli_shops:addShop", data.name, pos)
end)

Citizen.CreateThread(function()
    print("asdasd")
    Citizen.Wait(0)
    while true do
        playerNearShop()
    end

end)

function playerNearShop()
    local playerPos = GetEntityCoords(PlayerPedId())
    print(json.encode(locations))
    for _, search in pairs(locations) do
        print(search.x)
        --[[ local dist = Vdist(search) ]]
    end

end