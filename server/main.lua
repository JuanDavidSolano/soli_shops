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

ESX.Commands.Add("removeshop", "Remove a shop",{}, false, function(source, args)
	local Player = ESX.GetPlayerFromId(source)
	local playerPos = Player.getCoords()
	MySQL.Async.fetchAll('SELECT coords, id from solishopslocations',{}, function(result) 
		nearShopInfo = json.encode(playerNearShop(playerPos, result))
		if json.decode(nearShopInfo).near then
			MySQL.Async.execute('DELETE FROM solishopsinfo WHERE idshop = @id', {['@id'] = json.decode(nearShopInfo).id}, function(affectedRows)
			end)
			MySQL.Async.execute('DELETE FROM solishopslocations WHERE id = @id', {['@id'] = json.decode(nearShopInfo).id}, function(affectedRows)
				TriggerClientEvent("soli_shops:setShopsCoords", -1)
			end)
		end
	end)
end, "admin")

RegisterServerEvent('soli_shops:addShop')
AddEventHandler('soli_shops:addShop', function(name, coords, items)
	MySQL.Async.insert('INSERT INTO solishopslocations (name, coords) VALUES (@name, @coords)',
	{['name']=name, ['coords']=json.encode(coords)}, function (insertId)
		for _, item in pairs(items) do
			local buy = tonumber(item.buy)
			local sell = tonumber(item.sell)
			local amount = tonumber(item.amount)
			local itemname = item.item
			MySQL.Async.insert('INSERT INTO solishopsinfo (idshop,iditem,buyprice,sellprice,sellamount) VALUES (@idshop,@iditem,@buyprice,@sellprice,@sellamount)',
			{['idshop']=insertId,['iditem']=itemname,['buyprice']=buy,['sellprice']=sell,['sellamount']=amount})
		end
	end)
	

	TriggerClientEvent("soli_shops:setShopsCoords", -1)
end)

ESX.RegisterServerCallback('soli_shops:getShopsLocations', function(source, cb)
	MySQL.Async.fetchAll('SELECT coords, id from solishopslocations', {}, function(result)
	cb(result)
	end)
end)

ESX.RegisterServerCallback('soli_shops:getShopInfo', function(source, cb, idshop)
	MySQL.Async.fetchAll('SELECT iditem, buyprice, sellprice, sellamount FROM solishopsinfo WHERE idshop=@id',{["id"]=idshop}, function(result)
	cb(result)
	end)
end)


function playerNearShop(playerPos, locations)
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

function Vdist(x1,y1,z1,x2,y2,z2)
	local x = x1 - x2
	local y = y1 - y2
	local z = z1 - z2
	local D2 = x + y + z
	return math.sqrt(math.ceil(D2))
end
