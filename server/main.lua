ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj
end)

ESX.Commands.Add("createshop", "Create a shop",{}, false, function(source, args)
	local Player = ESX.GetPlayerFromId(source)
	TriggerClientEvent("soli_shops:createShop", source)
	MySQL.Async.fetchAll('SELECT name FROM items',{}, function(result) 
		TriggerClientEvent('soli_shops:showItems', source, result)
	end)
		
end, "admin")

RegisterServerEvent('soli_shops:addShop')
AddEventHandler('soli_shops:addShop', function(name, coords)
	MySQL.Async.execute('INSERT INTO solishopslocations (name, coords) VALUES (@name, @coords)',
	{['name']=name, ['coords']=json.encode(coords)})
	TriggerClientEvent("soli_shops:setShopsCoords", -1)
end)

ESX.RegisterServerCallback('soli_shops:getShopsLocations', function(source, cb)
	MySQL.Async.fetchAll('SELECT coords from solishopslocations', {}, function(result)
	cb(result)
	end)
end)


