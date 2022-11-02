local table = lib.table
if cfg.esxLegacy == false then
    ESX = nil -- ESX 
    CreateThread(function()
	    while ESX == nil do
	    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		    Wait(0)
	    end
    end)
end

RegisterNetEvent('esx:playerLoaded') -- toto načte postavu prostě základ
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
	while true do
        Citizen.Wait(5000)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
            if blip == nil then
                blip = AddBlipForCoord(cfg.blip['blipjobcords'])
                AddTextEntry('blip', cfg.blip['blipjobname'])
                SetBlipSprite(blip, 473)
                SetBlipColour(blip, 37)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 1.0)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('blip')
                EndTextCommandSetBlipName(blip)
            end

        else
            if blip ~= nil then
                RemoveBlip(blip)
                blip = nil
            end

        end
    end
end)


local boxm = true
local ispakuojama = true
local pajimta = false

RegisterNetEvent('sell:plastic') 
AddEventHandler('sell:plastic', function()
    TriggerServerEvent('ig-recycle:sellpl')
end)

RegisterNetEvent('sell:copp') 
AddEventHandler('sell:copp', function()
    TriggerServerEvent('ig-recycle:sellpl')
end)

RegisterNetEvent('getbox') 
AddEventHandler('getbox', function(xPlayer)
    local playerPed = PlayerPedId()
    if pajimta == false then
    if boxm == true then
    pajimta = true
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 5000, true)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then end
    Citizen.Wait(500)
    ClearPedTasks(playerPed)
    Citizen.Wait(200)
    boxbum()
    boxm = false
    else 
        Notify(cfg.translation['darturideze'])
    end
    else
        Notify(cfg.translation['jobisnotdone'])
            end
    end)

RegisterNetEvent('ispakuoti') 
AddEventHandler('ispakuoti', function(xPlayer)
    local playerPed = PlayerPedId()
    if pajimta == true then
    if ispakuojama == true then
    ispakuojama = false
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 5000, true)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then end
    Citizen.Wait(200)
    ClearPedTasks(playerPed)
    DropPackage()
    boxonground()
    TriggerServerEvent('box:items')
    ispakuojama = true
    pajimta = false
    else
        Notify(cfg.translation['darvisispakuojama'])
    end
    else
            Notify(cfg.translation['neturidezes'])
    end
end)

exports.ox_target:addSphereZone({
    coords = vec3(-163.4762, 6169.7627, 31.2063),
    radius = 1,
    debug = drawZones,
    options = {
        {
            name = 'deze1',
            event = 'getbox',
            icon = 'fa-solid fa-box',
            label = 'Pajimti Deže',
            groups = cfg.job['job'],
	    distance = 2,
            canInteract = function(entity, distance, coords, name)
                return true
            end
        }
    }
})

exports.ox_target:addSphereZone({
    coords = vec3(-166.2100, 6166.6343, 31.2016),
    radius = 1,
    debug = drawZones,
    options = {
        {
            name = 'deze2',
            event = 'getbox',
            icon = 'fa-solid fa-box',
            label = 'Pajimti Deže',
            groups = cfg.job['job'],
	    distance = 2,
            canInteract = function(entity, distance, coords, name)
                return true
            end
        }
    }
})

exports.ox_target:addSphereZone({
    coords = vec3(-164.6830, 6165.0654, 31.2014),
    radius = 1,
    debug = drawZones,
    options = {
        {
            name = 'deze3',
            event = 'getbox',
            icon = 'fa-solid fa-box',
            label = 'Pajimti Deže',
            groups = cfg.job['job'],
	    distance = 2,
            canInteract = function(entity, distance, coords, name)
                return true
            end
        }
    }
})

exports.ox_target:addSphereZone({
    coords = vec3(-166.9157, 6175.5898, 31.1726),
    radius = 1,
    debug = drawZones,
    options = {
        {
            name = 'ispakuoti',
            event = 'ispakuoti',
            icon = 'fa-sharp fa-solid fa-box-open',
            label = 'Išpakuoti Deže',
            groups = cfg.job['job'],
	    distance = 2,
            canInteract = function(entity, distance, coords, name)
                return true
            end
        }
    }
})

function boxbum()
    local pos = GetEntityCoords(PlayerPedId(), true)
    RequestAnimDict('anim@heists@box_carry@')
    while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
      Wait(7)
    end
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
    RequestModel("prop_cs_cardbox_01")
    while not HasModelLoaded("prop_cs_cardbox_01") do
      Wait(0)
    end
    local object5 = CreateObject("prop_cs_cardbox_01", pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(object5, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
    carryPackage = object5
    

end

function boxonground()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)

    ESX.Game.SpawnLocalObject("prop_cs_cardbox_01", objectCoords, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        Wait(10000)
        DeleteObject(obj)
        DeleteEntity(obj)
    
    end)
end

function DropPackage()
    ClearPedTasks(PlayerPedId())
    DetachEntity(carryPackage, true, true)
    DeleteObject(carryPackage)
    carryPackage = nil
    boxm = true

end

