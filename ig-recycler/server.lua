RegisterNetEvent('box:items')
AddEventHandler('box:items', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.canCarryItem(RandomItem(), RandomNumber()) then
        xPlayer.addInventoryItem(RandomItem(), RandomNumber())   
        xPlayer.addInventoryItem(RandomItem(), RandomNumber())     
    end

end)

Items = {
    cfg.item["item0"],
    cfg.item["item1"],
    cfg.item["item2"],
    cfg.item["item3"],
    cfg.item["item4"],
}

function RandomItem()
    return Items[math.random(#Items)]
end

function RandomNumber()
    return math.random(1,2)
end

RegisterServerEvent('ig-recycler-sell')
AddEventHandler('ig-recycler-sell', function()
            for k, v in pairs(cfg.prices) do
                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer.getInventoryItem(k).count > 0 then
                    local rewardAmount = 0
                    for i = 1, xPlayer.getInventoryItem(k).count do
                        rewardAmount = rewardAmount + math.random(v[1], v[2])
                    end
                    xPlayer.addMoney(rewardAmount)
                    TriggerClientEvent('ig-recycler:notify', source, (cfg.translation['sold_for']):format(xPlayer.getInventoryItem(k).count, xPlayer.getInventoryItem(k).label, addCommas(rewardAmount)))
                    xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
                end
            end
end)

addCommas = function(n)
	return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
								  :gsub(",(%-?)$","%1"):reverse()
end
