RegisterNetEvent('box:items')
AddEventHandler('box:items', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.canCarryItem(RandomItem(), RandomNumber()) then
        xPlayer.addInventoryItem(RandomItem(), RandomNumber())   
        xPlayer.addInventoryItem(RandomItem(), RandomNumber())     
        xPlayer.addInventoryItem(LuckyItem(), LuckyRandomNumber())  
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
